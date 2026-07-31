Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD59264A97
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465952; cv=none; b=fKcVi9/z9cfW6A6iQiChJy5iVsEVXhVtbiRP1mAdEXc6VkFxWO76qw5e+h5nnSaNzID9d//gUbQ5iUO4kX4MK0hh1kytFa7ojaB8Avo7tFU3yYCTJ622gDJPxCQtl7ivJDvC4uNT9NUJS06P0YxAVpvX9M4WvzsTUCraDTSyNkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465952; c=relaxed/simple;
	bh=YLftH4yBvz+HzmYEgrkVLkrtkTvpILcxB9aShK/1++I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BKRLCnoaQ6kbUuYXH+ALTttWEdmg4BWdWXjLUdcIgRek/NK+nv8tt4Rl/9FTd7E7ny4q5EBjHbwbUn9nCmlrvAyH/BTyoadE0Cir8HMZVLqBsTh0xJGlNVgzZxoPR1bNZgZLJFoNe4nwo9LrirRfFmxI5P3PNbT0xumNwZY1ctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chiD3yWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chiD3yWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A713C1F000E9;
	Fri, 31 Jul 2026 02:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465950;
	bh=cZDbcvs82362mVWYrcyjOM9lnNQBlcxppZ+0wYkHkTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=chiD3yWHstIcn7QMY8XzFKspmw/mFZ7hxGmo1PQ6hWdMcnRsNu1O4bJrIAdUtuYhE
	 kBjD+hCddDqgfvcopeZJ3bw0sb3wxbfMXBeup0aSwYTnpJWmiFbpuBmImCsnnYQjsC
	 xw7bVrKJe2KyuQ7JzvzYrhO3w80X5pyAN/5OyNk0kWQoG3SCr77cwKytxSAMXB6hwh
	 15YEYdkt8uluQ1kf0FJ1hL+N+/698N2PfOgN94zKiznFKFCT5uRPMEqqXcZvHPGnkb
	 Q1koyLqZSwkbnfAKWYq1vQ2HMVLIchEC7KS5/FEQjo10ZcuVCejbsqwSgLKvi4E7fo
	 IFegpBvAOTiHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 12/13] landlock: Document the BPF kfunc
 interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731022047.189137-13-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <20260731022047.189137-13-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 02:45:50 +0000
Message-Id: <20260731024550.A713C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The kfunc filter excessively restricts `bpf_landlock_put_ruleset=
`, contradicting the documented intent and severely limiting ruleset lifecy=
cle management.
--

--- Patch [12]: [PATCH bpf-next 12/13] landlock: Document the BPF kfunc int=
erface ---
commit f2d332c72e5178d7fb211de4b8685c5f171ac8da
Author: Justin Suess <utilityemal77@gmail.com>

landlock: Document the BPF kfunc interface

This commit adds documentation for the new Landlock BPF kfuncs. It describes
how a syscall program can acquire a ruleset from a file descriptor and pass=
 it
via a map to a sleepable LSM BPF program for enforcement on an execution.

> diff --git a/Documentation/security/landlock.rst b/Documentation/security=
/landlock.rst
> index c5186526e76f6..01197c7580ec0 100644
> --- a/Documentation/security/landlock.rst
> +++ b/Documentation/security/landlock.rst
> @@ -129,6 +129,31 @@ The reasoning is:
>    restrictions, because access within the same scope is already
>    allowed based on ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``.
> =20
> +BPF kfuncs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +BPF programs can apply a userspace-created Landlock ruleset to an
> +execution.  A syscall program (``BPF_PROG_TYPE_SYSCALL``), running in
> +the context of the process that set the ruleset up, acquires the
> +ruleset from its file descriptor and typically hands it over through
> +a map kptr field; a sleepable LSM BPF program attached to the
> +``bprm_creds_for_exec`` or ``bprm_creds_from_file`` hooks then
> +enforces it on an execution.
> +
> +This can be used to inspect the runtime context of a pending execution,
> +and enforce a Landlock policy through BPF.
> +
> +The restriction is staged in the Landlock blob of the
> +credentials prepared for the execution and committed past the exec
> +point of no return, so a failed execution leaves the calling task
> +untouched.  The ``landlock_restrict_self(2)`` flags apply, with the
> +exception of ``LANDLOCK_RESTRICT_SELF_TSYNC``.
> +
> +.. kernel-doc:: kernel/bpf/bpf_lsm.c
> +    :identifiers: bpf_landlock_get_ruleset_from_fd
> +                  bpf_landlock_put_ruleset
> +                  bpf_landlock_restrict_binprm

[Severity: Medium]
Does the kfunc filter excessively restrict bpf_landlock_put_ruleset,
contradicting the documented intent?

Looking at bpf_landlock_kfunc_filter() in kernel/bpf/bpf_lsm.c, it appears
to apply -EACCES to bpf_landlock_put_ruleset for most program types and hoo=
ks:

kernel/bpf/bpf_lsm.c:bpf_landlock_kfunc_filter() {
	if (!btf_id_set8_contains(&bpf_landlock_kfunc_ids, kfunc_id))
		return 0;

	switch (prog->type) {
// ...
	case BPF_PROG_TYPE_LSM:
// ...
		if (!btf_id_set_contains(&bpf_landlock_kfunc_hooks,
					 prog->aux->attach_btf_id))
			return -EACCES;

		return 0;
	default:
		return -EACCES;
	}
}

This prevents BPF programs of types other than SYSCALL or two specific
sleepable LSM hooks from legitimately dropping a reference to a
bpf_landlock_ruleset they acquire from a map via bpf_kptr_xchg().

The verifier forces the program to drop the acquired reference, but rejects
the call to bpf_landlock_put_ruleset().

Additionally, looking at bpf_landlock_kfunc_ids:

kernel/bpf/bpf_lsm.c:
BTF_ID_FLAGS(func, bpf_landlock_put_ruleset, KF_RELEASE | KF_SLEEPABLE)

The KF_SLEEPABLE flag seems to prevent calling the release kfunc from
non-sleepable programs, even though the underlying release mechanism
(security_policy_kptr_put) is designed to support non-sleepable contexts.

Could this severely limit ruleset lifecycle management by making the kptr
functionally unusable across most BPF program types?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731022047.1891=
37-1-utilityemal77@gmail.com?part=3D12
