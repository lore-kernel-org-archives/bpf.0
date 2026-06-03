Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C2326D4A
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780520193; cv=none; b=AWk374bcNzbFhesPvxucpV+i7PLe9F7BlrcCe2fn2rXR0EUNLbaVtEq/kLv4phMVb5ugIg+Hipq5aYQ/c6duU+WcXD8VmINlbR/nKI0lhCqs+s6CLuGOtC8FpNbqJ4bV4DxdDuHE0YWb8qt0qF6ySgpX5/3FgKZhAeTDLU1COmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780520193; c=relaxed/simple;
	bh=5jZ6Z5eteEKdbmgo6OFpvw7GKCEUQ1BgKRxLDkn03Xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uX1NoYnP5ViizDpEeli3usLijGERzpAsGG0Sde4/tIr8QMuXNQfDCUhrKAPaazB8oXN57dF5EM7fQPamjKSk9wtmgBWAltJAzRmR36TGQ8YQGC159TNwwqXTjlnsHFqwFUoh4fxa5Ht0SzNQ9t6R+LBuPpTq1IpNK//Wfl0MAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Huj95fDp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Huj95fDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951A81F00893;
	Wed,  3 Jun 2026 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780520191;
	bh=CxBdqWEcHRYGLFdoC0xchG06OnDUvpyPqncwsZye7L4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Huj95fDpkMixDdwvYD2cyw/TPcRaTdOJab+eB0tBqfsQsiUEZdFqPfeR1MkFstYBa
	 nr/Q6Skh0Rjnv/8DJ+mqIpTAUnnQM8EVaw08mHLKzN+GcaSFWuZwmUDTMluKRULDJ6
	 YMkGy1DOXixAifuot8XaS4mXciljPxhyymxCiD89cJ0P4SuzUAaDLnuzQD6xOo2KN0
	 hQ2P4yEfvzbpCYj0N7dHmMeNuqwx0uhlE8OfKZ15QzDAh6BlIM0OsIZP5/9H1QT7EK
	 WIPUmIruId/nlMsJ2TGV5GzpFUFv2d6pVGoXpS8xqM0tcEdQYydhdeRVxRHQe+5t4C
	 X/8LjQWPpVhkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603204206.773482-1-rhkrqnwk98@gmail.com>
References: <20260603204206.773482-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 20:56:31 +0000
Message-Id: <20260603205631.951A81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch prevents a NULL pointer dereference in `bpf_task_from_vp=
id()`, but leaves the root vulnerability unpatched in `find_pid_ns()` and `=
find_task_by_vpid()`, exposing other callers like `trace_user_stack_print()=
` to the exact same crash.
- [High] `bpf_task_from_vpid()` uses `current` to determine the target PID =
namespace, which produces arbitrary, non-deterministic results when called =
from interrupt/network BPF programs.
--

commit 061d0db0a968fb39f30d4aaead03a668556d0e21
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf: fix NULL pointer dereference in bpf_task_from_vpid()
   =20
bpf_task_from_vpid() looks up a task in the pid namespace of the current
task. This patch adds a check to bail out when current has no pid namespace
to avoid a NULL pointer dereference in find_pid_ns().

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5314c9fed3cf..4646a915bf98c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2913,6 +2913,10 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid=
(s32 vpid)
>  	struct task_struct *p;
> =20
>  	rcu_read_lock();
> +	if (!task_active_pid_ns(current)) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}

[Severity: High]
This is a pre-existing issue, but while this patch prevents the crash in
bpf_task_from_vpid(), does it leave other callers of find_task_by_vpid()
vulnerable to the exact same NULL pointer dereference?

find_task_by_vpid() evaluates task_active_pid_ns(current) and passes the
result directly to find_pid_ns():

kernel/pid.c:find_pid_ns() {
        return idr_find(&ns->idr, nr);
}

If current has cleared its thread_pid during do_exit(), the namespace
pointer is NULL, and find_pid_ns() unconditionally dereferences it.

Other callers like trace_user_stack_print() in kernel/trace/trace_output.c
can still trigger this crash. For example, if the kernel oopses inside
do_exit() after detach_pid(), ftrace_dump_on_oops() can be invoked in a
panic context. If the trace buffer contains a user stack entry,
trace_user_stack_print() calls find_task_by_vpid(), potentially triggering
a recursive double-fault that prevents the panic log from flushing.

Would it be safer to add the NULL check directly inside find_pid_ns()
or find_task_by_vpid() instead?

[Severity: High]
This isn't a bug introduced by this patch, but does the use of current here
lead to arbitrary results for BPF programs running in interrupt context?

This kfunc is available for program types like cgroup_skb and xdp, which
can run in softirq or hardware interrupt context. In these contexts, current
points to whatever random task happened to be interrupted by the packet.

Since bpf_task_from_vpid() looks up the virtual PID relative to
task_active_pid_ns(current), won't passing the same vpid for the same
packet look up the PID in a completely random container or root namespace?

>  	p =3D find_task_by_vpid(vpid);
>  	if (p)
>  		p =3D bpf_task_acquire(p);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603204206.7734=
82-1-rhkrqnwk98@gmail.com?part=3D1
