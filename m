Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F311482E8
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777433982; cv=none; b=bA2UIrlAUBY+qwzWfbMsvQxMF/CT7ufriKDO1EpMdORN/MlvX8pzjCQE4vMewqwHQPrIMo+7Z16CvWROwN/71GXwbq5a65A55hpr2vmU8V0LLM3qZBwqgqKv6r4yNuAr1dnpXReAnH63j9MdJel/UQ8V+FNdUmFMdgyHDxFgeyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777433982; c=relaxed/simple;
	bh=j9yGC/cPqbovN/V61k7Jm7HtApN03Bpv46VdAn62Log=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qzdbVFUYpfGcmnMr34b8yNu1kjo6lDklBZ1OJdVeYUHANKPIXqRIQ7Ek7MOCk0kRhUGKHCLYuDJJEFy5MyOXyeyTtvsOJ7lQBZSiAuG10x/5aK/FMjkSkjxknnTmyxBqjO2PNKr5cdSnYCzqJZ0MwoGCUV9QZmX+CNPmq/kYVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIgM7hen; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIgM7hen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4A4C19425;
	Wed, 29 Apr 2026 03:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777433982;
	bh=j9yGC/cPqbovN/V61k7Jm7HtApN03Bpv46VdAn62Log=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lIgM7henhhwHy6cC2ea+H+GPZ8gbOMAtXMZqZ5hIJkyDofow+vXVcc95yA7wAyt4u
	 W2rdBKLiZrfzcoIPd3+ULDm65VsCTU9qESUvT31iloEKjVfrStV0wT9tGFmDoHT0QM
	 jRaQy5X9cmLgMkDRfmt6YokHK5kJBQ+s6U2t0XPtBZfEanYoe0k8qd7aDVhJGXqECy
	 VkP245AegJZx98uEsHZAZDg4W7cbcgchvU8kHCOoW99rRv3JAKS2hpfU/e7UQjPjpO
	 uOXZSFisZDef8N+6W/I+eElj6nykm6xwhcSzIIwl1PMMWNP9Z52ODK0acRMl3Kao2s
	 sRigFTp5Z+DVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add kptr nmi deadlock
 reproducer
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428201422.1518903-5-utilityemal77@gmail.com>
References: <20260428201422.1518903-5-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 03:39:41 +0000
Message-Id: <20260429033942.0F4A4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] has_nmi_handler_btf() checks for the wrong BTF kind and name, caus=
ing the test to unconditionally skip.
- [High] BPF_PROG signature mismatch for the tracepoint causes verifier rej=
ection.
- [High] Race condition drops the kptr before the task is reaped, bypassing=
 the deadlock reproducer.
- [High] Race window in Hash map test leaks task_struct and causes a test t=
imeout.
- [High] Expected hash map deadlock avoidance aborts incorrectly fail the t=
est.
- [Medium] find_test_cpu incorrectly fails the test on single-core systems.
- [Low] Unnecessary manual validation of skeleton file descriptors.
--

commit 5f0b05bfc83b9c9298c4508b14319e9427f9679a
Author: Justin Suess <utilityemal77@gmail.com>
selftests/bpf: Add kptr nmi deadlock reproducer

This commit adds a deadlock reproducer for task struct kptrs, using an NMI
PMU event to trigger deletions while freeing the last task reference. It
includes test cases for array and hash map types.

> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kptr_nmi_deadloc=
k_repro.c b/tools/testing/selftests/bpf/prog_tests/task_kptr_nmi_deadlock_r=
epro.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/task_kptr_nmi_deadlock_repro=
.c
[ ... ]
> +static int find_test_cpu(void)
> +{
> +	cpu_set_t cpuset;
> +	int cpu, err;
> +
> +	err =3D sched_getaffinity(0, sizeof(cpuset), &cpuset);
> +	if (!ASSERT_OK(err, "sched_getaffinity"))
> +		return -1;
> +
> +	for (cpu =3D 1; cpu < CPU_SETSIZE; cpu++) {

Is it intentional to start iterating at cpu 1 here? On single-core systems =
or
environments affined only to CPU 0, this will exit without a match and trig=
ger
the ASSERT_TRUE failure below.

> +		if (CPU_ISSET(cpu, &cpuset))
> +			return cpu;
> +	}
> +
> +	ASSERT_TRUE(false, "cpu_available");
> +	return -1;
> +}
[ ... ]
> +static bool has_nmi_handler_btf(void)
> +{
> +	struct btf *btf;
> +	int id;
> +
> +	btf =3D btf__load_vmlinux_btf();
> +	if (libbpf_get_error(btf)) {
> +		printf("SKIP:no vmlinux BTF\n");
> +		test__skip();
> +		return false;
> +	}
> +
> +	id =3D btf__find_by_name_kind(btf, "nmi_handler", BTF_KIND_FUNC);

Will this lookup always fail and cause the test to unconditionally skip? Ke=
rnel
tracepoints generate a BTF_KIND_TYPEDEF named btf_trace_nmi_handler rather
than a BTF_KIND_FUNC named after the tracepoint.

> +	btf__free(btf);
> +	if (id <=3D 0) {
> +		printf("SKIP:no BTF FUNC nmi_handler\n");
> +		test__skip();
> +		return false;
> +	}
> +
> +	return true;
> +}
[ ... ]
> +static bool stash_exited_tasks(struct task_kptr_nmi_deadlock_repro *skel)
> +{
> +	int i, status;
> +
> +	for (i =3D 0; i < STASHED_TASKS; i++) {
> +		int pipefd[2];
> +		char sync;
> +		pid_t child_pid;

Can the race condition here cause the reproducer to bypass the deadlock
entirely?

Since NMIs are firing continuously via the PMU while the child processes are
forked, running, and waited on, the NMI handler could frequently delete the
map element and release the kptr while the kernel still holds its own
reference to the active or zombie task.

If the NMI drops a non-final reference, __put_task_struct won't be invoked
from the NMI context, missing the intended deadlock scenario.

> +
> +		if (!ASSERT_OK(pipe2(pipefd, O_CLOEXEC), "pipe2"))
> +			return false;
[ ... ]
> +	err =3D task_kptr_nmi_deadlock_repro__load(skel);
> +	if (!ASSERT_OK(err, "task_kptr_nmi_deadlock_repro__load"))
> +		goto cleanup;
> +
> +	if (bpf_program__fd(skel->progs.clear_task_kptrs_from_nmi) < 0) {

This isn't a bug, but is it necessary to check the file descriptor here? The
BPF skeleton guarantees that all programs and maps have valid file descript=
ors
after a successful load.

> +		test__skip();
> +		goto cleanup;
> +	}
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/task_kptr_nmi_deadlock_rep=
ro.c b/tools/testing/selftests/bpf/progs/task_kptr_nmi_deadlock_repro.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_kptr_nmi_deadlock_repro.c
[ ... ]
> +SEC("lsm.s/file_open")
> +int insert_task_kptr_from_lsm(struct file *ctx_file)
> +{
> +	struct task_map_value init =3D {};
> +	struct task_map_value *slot;
> +	struct task_struct *task, *acquired;
> +	__u32 pid;
> +	int i, ret;
> +
> +	(void)ctx_file;
> +
> +	pid =3D bpf_get_current_pid_tgid() >> 32;
> +	i =3D find_target_slot(pid);
> +	if (i < 0)
> +		return 0;
> +
> +	task =3D bpf_get_current_task_btf();
> +	acquired =3D bpf_task_acquire(task);
> +	if (!acquired) {
> +		task_kptr_nmi_err =3D TASK_KPTR_NMI_ACQUIRE_ERR;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Race is OK for these specific map types. Userspace may
> +	 * have modified the array, causing inconsistency. This
> +	 * error TASK_KPTR_NMI_CREATE_ERR is non-fatal for test
> +	 * purposes. But may be important if this test is
> +	 * extended for other map types.
> +	 */
> +	switch (task_kptr_nmi_map_type) {
> +	case TASK_KPTR_NMI_MAP_HASH:
> +		pid =3D i;
> +		ret =3D bpf_map_update_elem(&stashed_tasks_hash, &pid, &init,
> +					  BPF_NOEXIST);
> +		if (ret && ret !=3D -EEXIST) {
> +			task_kptr_nmi_err =3D TASK_KPTR_NMI_CREATE_ERR;
> +			goto release_task;
> +		}
> +		slot =3D bpf_map_lookup_elem(&stashed_tasks_hash, &pid);

Could this leak the task struct and cause a test timeout?

If an NMI fires immediately after the lookup but before bpf_kptr_xchg() is
called in stash_task(), clear_hash_tasks() will successfully delete the
empty element. The LSM hook would then resume and write the acquired task
struct into the deleted element's memory.

Since it is no longer in the map, subsequent NMIs cannot find it, causing a
timeout while waiting for task_kptr_nmi_deleted to increment.

> +		if (!slot) {
> +			task_kptr_nmi_err =3D TASK_KPTR_NMI_LOOKUP_ERR;
> +			goto release_task;
> +		}
> +		break;
[ ... ]
> +static __always_inline void clear_hash_tasks(void)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < MAX_TARGET_PIDS; i++) {
> +		__u32 slot =3D i;
> +
> +		if (!task_kptr_nmi_pids[i])
> +			continue;
> +		if (!bpf_map_delete_elem(&stashed_tasks_hash, &slot)) {
> +			task_kptr_nmi_live[i] =3D 0;
> +			task_kptr_nmi_deleted++;
> +		} else if (bpf_map_lookup_elem(&stashed_tasks_hash, &slot)) {
> +			set_delete_err(-EIO);

Does this incorrectly fail the test during an expected hash map deadlock
avoidance abort?

BPF hash maps use a bucket lock for concurrent updates and deletions. If the
NMI interrupts the LSM hook while it holds the bucket lock,
bpf_map_delete_elem() aborts to avoid deadlocking and returns -EBUSY.

Treating this resilient spinlock abort as a fatal -EIO error makes the test
inherently flaky.

> +		}
> +	}
> +}
[ ... ]
> +SEC("?tp_btf/nmi_handler")
> +int BPF_PROG(clear_task_kptrs_from_nmi, void *handler, void *regs, s64 d=
elta_ns,
> +	     int handled)

Does this program signature match the tracepoint?

The actual nmi_handler tracepoint provides only 3 arguments, but the BPF_PR=
OG
macro is used here with 4 arguments. The macro automatically expands to read
ctx[3], which the verifier will reject as an out-of-bounds context access
(offset >=3D 24), causing the program to fail to load unconditionally.

> +{
> +	(void)handler;
> +	(void)regs;
> +	(void)delta_ns;
> +	(void)handled;
> +
> +	if (task_kptr_nmi_deleted >=3D task_kptr_nmi_inserted)
> +		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428201422.1518=
903-1-utilityemal77@gmail.com?part=3D4
