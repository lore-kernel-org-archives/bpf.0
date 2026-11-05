Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881842;
	b=YWCeN8TPzXmDvlS1rTtup0r4nX87yL6267r9KL8AISZ5eUJatGEz5e5KfBYbmrLCDm3r
	 1tnFW8B1klLIVpjz5D2DJjzyLD7TXPx7Zd0aC7GbFWbTeWDrephzyDOnm3NbbnkDr6Qxd
	 iI6qi+iSmC94Q8u5CGbe9UDKltvEkvO5bzFjYXcNt8ErpqYmSyeVKCiOINXX9OvGWf9LX
	 mrC2nEDMKO/0seayXJcr8bXPiHsyeIkioeXqBb6cQtj8IsY1qHuDU8i27kGTT6qNlzjYC
	 X/efDa3Pj8GCsP6adIzVdzKWr+BWbq1U0NvhI6OZXN3zCq3ZoK1sMlLxmRNVprDZB7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DHGsTHubc4aMMBvmjHu/ylYilusYO6zlJFm21HDhy9s=;
	b=D3isvPS27vd9EKfFiFgP6F7+6sSranYW0dLta6qMBkwnOyTb0ip60olCme9J90iVZZjx
	 7susO1GcGbUm4lHx7OnLgQjZ4uuoM58eUN0d8HbUDSaGLy7CD89llxLjWgojdBzVVm3Sh
	 c5z3nQ3Tk3IWjpA3gAO8p556DunkdlCiSfBddCJyAsND+RV9oZj4eL3ye1f9Jlryvwe6C
	 8Rv6Th0SYb5/lP30+PWQDkHloXMd3E0dbvC0AboqAhY+nREGE8XaSyb5JrElEpm/XecX5
	 No7vc5rYen2YQRNiZnlJVJibstBmwG82fKmdv5gRdCAn2UQgZdfCH6Mm/5wtG/FES2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2ixqdkF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC502606A332
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2ixqdkF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC071F00A15;
	Thu,  5 Nov 2026 12:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881841;
	bh=DHGsTHubc4aMMBvmjHu/ylYilusYO6zlJFm21HDhy9s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=h2ixqdkFeFqpLPEzgj5s3zrhlE4WGGbkA8CuNtFFn5mlYLJN7s+MxKsp6NScwIF7j
	 Fz2Uxd0ossQAJMKaibq5Xu35bpruNEhTo6vvJ96PNyugOx459bwjPVAhznI8SDMdta
	 JsH7huo177vTAdCb5fIF0E6HtST5o7xq8lJ+lZza7QIkRNTyqSWn5EBoyfdR7YaIDk
	 KhpPL4ibFIAmW1kcoipGE1aQzkcL0SAFI1Fek/IfI+nrOEKILSH9PEKBFb+ygsdiLT
	 pWOKBYX7JHqBi9FIApQ+S0pbpigK6wTztaSV0P7fb3SduETJ5W+Qv5m+/SQB+JSkWe
	 upI12zr44NMFA==
Message-ID: <sashiko-outbox-199035@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: Add network namespace boundary inspection kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhishek Khade" <abhishekkhade69@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261105121642.38019-1-abhishekkhade69@gmail.com>
References: <20261105121642.38019-1-abhishekkhade69@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:30:40 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] bpf: use-after-free of task->nsproxy in netns task kfuncs
- [Medium] bpf: missing __nullable suffix on netns kfunc pointer parameters
- [Medium] selftests/bpf: incomplete coverage and error checks in test_netn=
s_kfunc()
--

commit becb6e580b969813c102c712d541272b54c4d34c
Author: Abhishek Khade <abhishekkhade69@gmail.com>

bpf: Add network namespace boundary inspection kfuncs

This commit adds three BPF kfuncs (bpf_task_is_init_net,
bpf_task_get_netns_inum, and bpf_sock_is_init_net) to inspect whether a
task or socket belongs to init_net and retrieve a task's network namespace
inode number, along with a BPF selftest.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6788489a2608b..3584703d139f1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2991,6 +2994,77 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task=
_struct *task,
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_NET
> +/**
> + * bpf_task_is_init_net - check whether task belongs to initial network =
namespace
> + * @task: the task to be tested
> + *
> + * Returns true if @task belongs to the initial network namespace (init_=
net),
> + * or false otherwise (or if @task or its nsproxy is NULL).
> + */
> +__bpf_kfunc bool bpf_task_is_init_net(const struct task_struct *task)
> +{
> +	struct nsproxy *nsproxy;
> +	struct net *net;
> +	bool ret =3D false;
> +
> +	if (!task)
> +		return false;
> +
> +	rcu_read_lock();
> +	nsproxy =3D rcu_dereference(task->nsproxy);
> +	if (nsproxy) {
> +		net =3D READ_ONCE(nsproxy->net_ns);
> +		ret =3D (net =3D=3D &init_net);
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +/**
> + * bpf_task_get_netns_inum - get inode number of task's network namespace
> + * @task: the task to inspect
> + *
> + * Returns the inode number (inum) of @task's network namespace, or 0 if
> + * @task, its nsproxy, or net_ns is NULL.
> + */
> +__bpf_kfunc u32 bpf_task_get_netns_inum(const struct task_struct *task)
> +{
> +	struct nsproxy *nsproxy;
> +	struct net *net;
> +	u32 inum =3D 0;
> +
> +	if (!task)
> +		return 0;
> +
> +	rcu_read_lock();
> +	nsproxy =3D rcu_dereference(task->nsproxy);
> +	if (nsproxy) {
> +		net =3D READ_ONCE(nsproxy->net_ns);
> +		if (net)
> +			inum =3D net->ns.inum;
> +	}
> +	rcu_read_unlock();
> +
> +	return inum;
> +}

[Severity: Critical]
Can bpf_task_is_init_net() and bpf_task_get_netns_inum() trigger a
use-after-free of task->nsproxy (and task->nsproxy->net_ns) when called on
a task other than current?

Both kfuncs are registered with KF_RCU and accept an arbitrary
struct task_struct pointer (for example from bpf_task_from_pid(), a task
iterator, task->real_parent, or a tracing/LSM hook), then read
task->nsproxy under rcu_read_lock() without holding task_lock(task).

However, task_struct::nsproxy is not an __rcu pointer (which also causes
rcu_dereference(task->nsproxy) to emit a Sparse address-space mismatch
warning when building with C=3D1 and CONFIG_SPARSE_RCU_POINTER), and
include/linux/nsproxy.h notes that accessing task->nsproxy on a
non-current task requires task_lock(task).

When the target task concurrently runs unshare(), setns(),
exec_task_namespaces(), or exits via do_exit() ->
exit_nsproxy_namespaces(), switch_task_namespaces() updates p->nsproxy
under task_lock(p) and immediately drops the old reference without waiting
for an RCU grace period:

kernel/nsproxy.c:switch_task_namespaces() {
	task_lock(p);
	ns =3D p->nsproxy;
	p->nsproxy =3D new;
	task_unlock(p);

	if (ns)
		put_nsproxy(ns);
}

put_nsproxy() -> nsproxy_free() then drops ns->net_ns and frees the
nsproxy slab object synchronously:

kernel/nsproxy.c:nsproxy_free() {
	...
	put_net(ns->net_ns);
	kmem_cache_free(nsproxy_cachep, ns);
}

Because nsproxy_cachep is not SLAB_TYPESAFE_BY_RCU and nsproxy_free() does
not use call_rcu(), rcu_read_lock() does not keep nsproxy alive after
loading task->nsproxy. Couldn't nsproxy be freed and poisoned or reused
before READ_ONCE(nsproxy->net_ns) and net->ns.inum are read?

> +
> +/**
> + * bpf_sock_is_init_net - check whether socket belongs to initial networ=
k namespace
> + * @sk: the socket to be tested
> + *
> + * Returns true if @sk belongs to init_net, or false otherwise (or if @s=
k is NULL).
> + */
> +__bpf_kfunc bool bpf_sock_is_init_net(const struct sock *sk)
> +{
> +	if (!sk)
> +		return false;
> +
> +	return net_eq(sock_net(sk), &init_net);
> +}

[Severity: Medium]
Should the pointer arguments of bpf_task_is_init_net(),
bpf_task_get_netns_inum(), and bpf_sock_is_init_net() use the __nullable
suffix (task__nullable and sk__nullable)?

The kernel-doc comments and implementations of all three kfuncs explicitly
handle NULL pointers by checking if (!task) or if (!sk) and returning
false or 0.

However, in kernel/bpf/verifier.c, is_kfunc_arg_nullable() and
get_kfunc_arg_type() only mark a kfunc pointer parameter as PTR_MAYBE_NULL
when the parameter name ends with __nullable. Without that suffix, won't
the verifier reject BPF programs that pass a nullable pointer (such as an
unchecked skb->sk or a PTR_MAYBE_NULL task pointer) to these kfuncs?

> diff --git a/tools/testing/selftests/bpf/prog_tests/netns_kfunc.c b/tools=
/testing/selftests/bpf/prog_tests/netns_kfunc.c
> new file mode 100644
> index 0000000000000..3072f7ede8124
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/netns_kfunc.c

[ ... ]

> @@ -0,0 +1,104 @@
> +	skel->bss->target_pid =3D pid;
> +	close(pipefd[0]);
> +	if (write(pipefd[1], &status, sizeof(status)) < 0) {
> +		close(pipefd[1]);
> +		waitpid(pid, NULL, 0);
> +		goto cleanup;
> +	}
> +	close(pipefd[1]);
> +	waitpid(pid, &status, 0);
> +
> +	ASSERT_EQ(skel->bss->inv_is_init_net, 1, "host_task_is_init_net");
> +	ASSERT_GT(skel->bss->inv_netns_inum, 0, "host_netns_inum_valid");
> +	host_inum =3D skel->bss->inv_netns_inum;

[ ... ]

> +	skel->bss->target_pid =3D pid;
> +	close(pipefd[0]);
> +	if (write(pipefd[1], &status, sizeof(status)) < 0) {
> +		close(pipefd[1]);
> +		waitpid(pid, NULL, 0);
> +		goto cleanup;
> +	}
> +	close(pipefd[1]);
> +	waitpid(pid, &status, 0);
> +
> +	ASSERT_EQ(skel->bss->inv_is_init_net, 0, "netns_task_not_init_net");
> +	ASSERT_GT(skel->bss->inv_netns_inum, 0, "child_netns_inum_valid");
> +	ASSERT_NEQ(skel->bss->inv_netns_inum, host_inum, "netns_inum_different"=
);
> +
> +cleanup:
> +	test_netns_kfunc__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_netns_kfunc.c b/tools=
/testing/selftests/bpf/progs/test_netns_kfunc.c
> new file mode 100644
> index 0000000000000..3ad49f8ba39a3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_netns_kfunc.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Abhishek Khade */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#include "bpf_misc.h"
> +
> +bool bpf_task_is_init_net(const struct task_struct *task) __ksym;
> +u32 bpf_task_get_netns_inum(const struct task_struct *task) __ksym;
> +
> +pid_t target_pid;
> +int inv_is_init_net =3D -1;
> +u32 inv_netns_inum;
> +
> +SEC("tp_btf/sched_process_exec")
> +int BPF_PROG(on_exec, struct task_struct *task, u64 old_pid,
> +	     struct linux_binprm *bprm)
> +{
> +	pid_t pid =3D task->tgid;
> +
> +	if (pid !=3D target_pid)
> +		return 0;
> +
> +	inv_is_init_net =3D bpf_task_is_init_net(task) ? 1 : 0;
> +	inv_netns_inum =3D bpf_task_get_netns_inum(task);
> +
> +	return 0;
> +}

[Severity: Medium]
There are a few issues in test_netns_kfunc() and on_exec():

1. The patch adds bpf_sock_is_init_net(), but neither test_netns_kfunc.c
nor netns_kfunc.c declares or exercises it. Could the selftest also cover
bpf_sock_is_init_net() in both init_net and the unshared network
namespace?

2. In test_netns_kfunc(), both write(pipefd[1], &status, sizeof(status))
error paths jump straight to cleanup without an ASSERT_*() failure, which
would allow the test to pass silently if write() fails, and waitpid(pid,
&status, 0) does not assert that the child exited cleanly via WIFEXITED()
and WEXITSTATUS(). Should those paths use ASSERT_EQ() so child failures in
unshare(CLONE_NEWNET) or execlp() are reported explicitly?

3. In on_exec(), task->tgid (the global PID in init_pid_ns) is compared
against target_pid (the userspace fork() return value in the caller's PID
namespace), and the first subtest assumes the test runner itself starts in
init_net. Would this cause false failures when running test_progs inside a
container or non-initial PID/network namespace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105121642.3801=
9-1-abhishekkhade69@gmail.com?part=3D1
