Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCFE2857EE;
	Fri,  8 May 2026 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267309; cv=none; b=T4k1RtiyiSRo+9nNqYU4IQp0zqjgWR8qEieI3eaq2B/8cZvuWKgiQ0biPoaU/xiyzKB+EfYNXLiCwLZ4lvb6sCMhvZwllso/TpSP+4gVitqCYk52lFlQ6ka9t+zNWw/Fm1cQPO5kPoXSpK2gzt+sxqNxQX6CLrdabSrPJmza90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267309; c=relaxed/simple;
	bh=lzLVGB0mcn0nS2U9oCM5vmPBKKOzJLY4dhbjmse1ptk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tmDt+I2yQgoGQTY8OtF+1gdrh1EVSvhjWelcslcCAa9VgHh4P8zuH/hkVd4tZ32FQo2000Qww3ogzOsRYr6xIWLTowvEuCHwxLs3nuZbp1aOT4q+IMKseDgRFQc85bezyAg+23fnM5xc5up8RbNWWt+YUAHy7zRg/THMsEeV7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoyiiZE7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoyiiZE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6B2C2BCB0;
	Fri,  8 May 2026 19:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778267308;
	bh=lzLVGB0mcn0nS2U9oCM5vmPBKKOzJLY4dhbjmse1ptk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eoyiiZE7/81nCVWdi8+v7/FsFn9vw5OU0vuhcOLpV+0GYhoQIG6tRqj+cDh5FdEtp
	 MeUDzmlrV8U0KKdbL4v+7WrlOQIV17dkal5Y7q852HzGMNf3/QKC01i/8OzpjfCr2Q
	 ogIhp1UJ7OHMZk0YxLsfkORudDPFJYFw9n9i/oTK0tki4yUko5oxKc32uMEzAZllO2
	 3low2i7inBp/FV6Rveuain6kx4FFeeErwdAGqO8n0hksMAQdKs++U0aV6cC7tVSpkY
	 UntDrZO3OAeCVcI+176TL7tsPk0Zhc1dITuWSdqoNDzhyvnjhyGg7b2mRQvISXFYl4
	 ip26n5bA/piWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Add scx_ai_numa scheduler example for AI
 workloads
Reply-To: sashiko@lists.linux.dev
To: "Qiliang Yuan" <realwujing@gmail.com>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260508-feat-scx_ai_example-v1-1-2b498af3514d@gmail.com>
References: <20260508-feat-scx_ai_example-v1-1-2b498af3514d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 19:08:27 +0000
Message-Id: <20260508190828.8A6B2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Missing bounds check on `my_node` in `ai_numa_dispatch` triggers `=
scx_error()` and scheduler abort on sparse or large NUMA topologies.
- [High] Tasks pinned to a single CPU bypass `select_cpu` and are improperl=
y routed to `NUMA_DSQ(0)`, causing CPU cycle waste and breaking NUMA isolat=
ion.
- [High] Userspace NUMA node detection logic fails on sparse topologies, de=
grading the scheduler and triggering a kernel abort.
- [Medium] Missing error check on `libbpf_num_possible_cpus()` leads to pot=
ential negative Variable Length Array (VLA) size and userspace crash.
--

commit 5065582a0672767bbb7d29e1575961ffc48ac6d0
Author: Qiliang Yuan <realwujing@gmail.com>

sched_ext: Add scx_ai_numa scheduler example for AI workloads

This commit introduces a NUMA-aware BPF scheduler tailored for AI workloads=
 to
preserve L3 cache warmth. The scheduler implements per-NUMA-node dispatch
queues, an idle fast path, task NUMA affinity tracking, and work stealing. A
userspace loader configures the scheduler and reports dispatch statistics.

> diff --git a/tools/sched_ext/scx_ai_numa.bpf.c b/tools/sched_ext/scx_ai_n=
uma.bpf.c
> new file mode 100644
> index 0000000000000..89d3b7dd3d474
> --- /dev/null
> +++ b/tools/sched_ext/scx_ai_numa.bpf.c

[ ... ]

> +void BPF_STRUCT_OPS(ai_numa_enqueue, struct task_struct *p, u64 enq_flag=
s)
> +{
> +	struct task_ctx *tctx;
> +	u32 node =3D 0;
> +
> +	/*
> +	 * Route to the task's preferred NUMA node DSQ.
> +	 * Keeping AI tasks on the same NUMA node as their GPU's host memory
> +	 * reduces cross-node DRAM traffic and PCIe DMA stalls.
> +	 */
> +	tctx =3D bpf_task_storage_get(&task_ctx_stor, p, 0, 0);

If a task is pinned to a single CPU, the sched_ext core intentionally skips
ops.select_cpu() and the task's NUMA affinity (tctx) is never initialized.
Will this cause the task to always default to NUMA_DSQ(0)?=20

If so, CPUs on node 0 might constantly iterate over these tasks but fail to
dispatch them because task_can_run_on_remote_rq() returns false, potentially
breaking NUMA isolation until the pinned CPU work-steals from NUMA_DSQ(0).

[ ... ]

> +void BPF_STRUCT_OPS(ai_numa_dispatch, s32 cpu, struct task_struct *prev)
> +{
> +	u32 my_node =3D cpu_to_node(cpu);
> +	u32 i;
> +
> +	/* First: consume from our own NUMA node =E2=80=94 zero cross-node traf=
fic */
> +	if (scx_bpf_dsq_move_to_local(NUMA_DSQ(my_node), 0))

Can cpu_to_node() return a node ID greater than or equal to nr_nodes (e.g. =
on
systems with sparse NUMA topologies or more than 16 nodes)?

If my_node is >=3D nr_nodes, the DSQ would not have been created by
ai_numa_init(). Could this cause the core scheduler to fail in find_user_ds=
q()
and trigger an scx_error() that aborts the BPF scheduler?

[ ... ]

> diff --git a/tools/sched_ext/scx_ai_numa.c b/tools/sched_ext/scx_ai_numa.c
> new file mode 100644
> index 0000000000000..58c7bb1bd6bb6
> --- /dev/null
> +++ b/tools/sched_ext/scx_ai_numa.c

[ ... ]

> +/* Detect NUMA node count by scanning sysfs */
> +static __u32 detect_nr_nodes(void)
> +{
> +	struct stat st;
> +	char path[64];
> +	__u32 i, count =3D 0;
> +
> +	for (i =3D 0; i < MAX_NUMA_NODES; i++) {
> +		snprintf(path, sizeof(path),
> +			 "/sys/devices/system/node/node%u", i);
> +		if (stat(path, &st) =3D=3D 0 && S_ISDIR(st.st_mode))
> +			count =3D i + 1;
> +		else
> +			break;

If the system has sparse NUMA nodes (for example, only node 0 and node 2 are
present), will this loop prematurely break at i =3D 1?

This would set nr_nodes to 1, causing the initialization to only create
NUMA_DSQ(0). When tasks run on node 2, they might attempt to enqueue or
dispatch from a non-existent NUMA_DSQ(2), which could trigger a kernel abor=
t.

[ ... ]

> +static void print_stats(struct scx_ai_numa *skel, __u32 nr_nodes)
> +{
> +	int nr_cpus =3D libbpf_num_possible_cpus();
> +	int map_fd  =3D bpf_map__fd(skel->maps.node_stats);
> +
> +	printf("\n%-6s %14s %14s %14s\n",
> +	       "Node", "Local-DSQ", "NUMA-DSQ", "Steals");
> +	printf("------+--------------+--------------+--------------\n");
> +
> +	for (__u32 node =3D 0; node < nr_nodes; node++) {
> +		struct node_stat per_cpu[nr_cpus];

Does libbpf_num_possible_cpus() need an error check here?

If it fails and returns a negative error code, passing a negative size to t=
he
variable-length array per_cpu could cause undefined behavior and crash the
userspace loader.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-feat-scx_a=
i_example-v1-1-2b498af3514d@gmail.com?part=3D1
