lint:
	-ruff check --fix

format:
	@usort format .
	@ruff format

test:
	@python3 -m unittest discover -s tests/ -p "*_test.py"
	@python3 -m unittest discover -s distributed_shampoo/tests/ -p "*_test.py"
	@python3 -m unittest discover -s distributed_shampoo/utils/tests/ -p "*_test.py"
	@python3 -m unittest discover -s distributed_shampoo/gpu_tests/ -p "*_test.py"
	@python3 -m unittest distributed_shampoo/utils/gpu_tests/shampoo_dist_utils_test.py
	@torchrun --standalone --nnodes=1 --nproc_per_node=2 -m unittest distributed_shampoo/utils/gpu_tests/shampoo_ddp_distributor_test.py

test-gpu:
	@torchrun --standalone --nnodes=1 --nproc_per_node=2 -m unittest discover -s distributed_shampoo/gpu_tests/ -p "*_test.py"
	@torchrun --standalone --nnodes=1 --nproc_per_node=2 -m unittest distributed_shampoo/utils/gpu_tests/shampoo_dist_utils_test.py
	@torchrun --standalone --nnodes=1 --nproc_per_node=2 -m unittest distributed_shampoo/utils/gpu_tests/shampoo_ddp_distributor_test.py
	@torchrun --standalone --nnodes=1 --nproc_per_node=2 -m unittest distributed_shampoo/utils/gpu_tests/shampoo_fsdp_distributor_test.py
	@torchrun --standalone --nnodes=1 --nproc_per_node=2 -m unittest distributed_shampoo/utils/gpu_tests/shampoo_fully_shard_distributor_test.py
	@torchrun --standalone --nnodes=1 --nproc_per_node=4 -m unittest distributed_shampoo/utils/gpu_tests/shampoo_hsdp_distributor_test.py
	@torchrun --standalone --nnodes=1 --nproc_per_node=4 -m unittest distributed_shampoo/utils/gpu_tests/shampoo_fsdp_utils_test.py