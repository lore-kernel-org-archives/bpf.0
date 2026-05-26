Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFC3B5F66
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812596; cv=none; b=go9Xx1j50aBC9a1/BgS3H6E5rp4cY6VQv1AslOnfFbyAS9jIkoGnxG1cBF8M1v4FR3tRNZMBQLak5sLCntuCRc8qTCzDXEVCB80Gl8cYOluX26S7iLQWptyoXmZsoXL0HtDNi4b1YBw/O9XkWsVzTBw88IDZKMgdUe/c56aSo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812596; c=relaxed/simple;
	bh=dAvQA/uEoxcnQpjzJdRy6iTKQgkIrmDkJiuukk1go7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fOk+J30cGoMLOALjiBe5BbCQxPY7GFv8PDnlJ7ejAtuxH3KCRG6w/87g9nyE0rv3+HW+gryq9PiuzXk6Lju1JRMbi9ZkBs5ecNkNYV1xpMNNUHZqiPU6k7+4SKwHg7pc10BEqgQHbYAw754WMFKBoLU1RmREm6Ls9trNzlx/2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8hhzAbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8hhzAbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C1F1F000E9;
	Tue, 26 May 2026 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779812592;
	bh=Hsemjfxo8eTkBELzULjxgNKpufvoTAjjExUTN25aTfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j8hhzAbGVPTiDrbDy151rzjwmnoYXSCLb/a4aSZrAlUwdLtl2ZCOMszF/uP+oHbPA
	 7vwejFnQbrBHYrpK0AMEST5gB3lspPKL7+nzNyy0vIti0SLv5dKQw6wBfKFj+SiaNR
	 XY8Tr8mcYUcX9chfXTmCjRBC6kbvPE9QJA2Gc+WJ/KKvFM2xvgGEPqZ7mJAarEyZdd
	 CVx0ZV5ZvzMhWVaAUhomt9zefWRZo7RWq4wm/7bbmG3tR9gWXXUw0KtJ5+1fDH2VTM
	 0bNMTy2T2CUv2oAXS8+Fi8s7hwzJSHWX8kAq3+H6lvQgWK81wGxNMLQhao/UWAN3CH
	 0VtkmFXHfEE8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 1/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamie Hill-Daniel" <clubby789@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-seccomp-combined-v1-1-304b1cc3ad24@hill-daniel.co.uk>
References: <20260526-seccomp-combined-v1-1-304b1cc3ad24@hill-daniel.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 16:23:11 +0000
Message-Id: <20260526162312.44C1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] SECCOMP_MODE_COMBINED allows a ptracer to completely bypass strict=
 mode restrictions via system call manipulation.
- [High] The internal SECCOMP_MODE_COMBINED constant is leaked to userspace=
, violating ABI stability.
- [High] Checkpoint/Restore (CRIU) and Ptrace filter dumping are broken for=
 processes in COMBINED mode.
- [High] Thread synchronization (TSYNC) is broken and causes state inconsis=
tencies for processes in COMBINED mode.
- [Medium] The transition from SECCOMP_MODE_STRICT to SECCOMP_MODE_COMBINED=
 is structurally unreachable.
--

commit c1df2665317e85f0cd779f5b52a0ed4763185a42
Author: Jamie Hill-Daniel <clubby789@gmail.com>

seccomp: Allow using SECCOMP_MODE_STRICT with SECCOMP_MODE_FILTER

It is currently impossible to enable SECCOMP_MODE_STRICT if
SECCOMP_MODE_FILTER is enabled, and vice-versa. This makes using
seccomp difficult in environments such as Docker, which installs a
seccomp filter by default.

Introduce a new internal SECCOMP_MODE_COMBINED
that runs strict checks, followed by any installed filters.

Link: https://github.com/moby/moby/issues/42082

> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 25f62867a16d9..8201a050d358f 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -33,6 +33,8 @@
> =20
>  /* Not exposed in headers: strictly internal use only. */
>  #define SECCOMP_MODE_DEAD	(SECCOMP_MODE_FILTER + 1)
> +/* Run SECCOMP_MODE_STRICT checks, followed by SECCOMP_MODE_FILTER  */
> +#define SECCOMP_MODE_COMBINED (SECCOMP_MODE_DEAD + 1)

[Severity: High]
Does this new internal mode leak to userspace and break ABI expectations?

Looking at prctl_get_seccomp(), it returns current->seccomp.mode directly.
This will now return 4 to userspace for tasks in combined mode, but userspa=
ce
utilities like systemd and container runtimes strictly expect the mode to be
0 (DISABLED), 1 (STRICT), or 2 (FILTER).

[Severity: High]
Will setting current->seccomp.mode to SECCOMP_MODE_COMBINED break thread
synchronization (TSYNC)?

seccomp_can_sync_threads() validates sibling threads and only allows
synchronization if they are in SECCOMP_MODE_DISABLED or
SECCOMP_MODE_FILTER. If any thread is in SECCOMP_MODE_COMBINED, this
validation unconditionally fails and SECCOMP_FILTER_FLAG_TSYNC operations
abort with -ESRCH.

[Severity: High]
Can this new mode prevent checkpoint/restore (CRIU) and ptrace filter
dumping?

get_nth_filter(), which is the backend for PTRACE_SECCOMP_GET_FILTER and
seccomp metadata inspection, explicitly enforces the condition:

    if (task->seccomp.mode !=3D SECCOMP_MODE_FILTER)
        return ERR_PTR(-EINVAL);

When a process runs in SECCOMP_MODE_COMBINED, this validation will fail,
making it impossible to inspect, dump, or checkpoint the attached seccomp
BPF filters.

[ ... ]

> @@ -432,14 +434,21 @@ static u32 seccomp_run_filters(const struct seccomp=
_data *sd,
>  }
>  #endif /* CONFIG_SECCOMP_FILTER */
> =20
> -static inline bool seccomp_may_assign_mode(unsigned long seccomp_mode)
> +/**
> + * seccomp_needs_combined: internal function for checking if requested m=
ode
> + * needs to be upgraded to SECCOMP_MODE_COMBINED.
> + *
> + */
> +static inline bool seccomp_needs_combined(unsigned long seccomp_mode)
>  {
>  	assert_spin_locked(&current->sighand->siglock);
> =20
> -	if (current->seccomp.mode && current->seccomp.mode !=3D seccomp_mode)
> -		return false;
> +	if ((current->seccomp.mode =3D=3D SECCOMP_MODE_STRICT ||
> +	     current->seccomp.mode =3D=3D SECCOMP_MODE_FILTER) &&
> +	    current->seccomp.mode !=3D seccomp_mode)
> +		return true;

[Severity: Medium]
Is the transition from SECCOMP_MODE_STRICT to SECCOMP_MODE_COMBINED
structurally unreachable?

In strict mode, the __secure_computing_strict() hook runs during syscall
entry and unconditionally kills the process via SIGKILL if it attempts to
execute any syscall other than read, write, _exit, or sigreturn.

Any attempt to invoke prctl or seccomp to install a filter while in
strict mode will result in immediate termination, preventing the upgrade.

> -	return true;
> +	return false;
>  }

[ ... ]

> @@ -1407,6 +1416,9 @@ int __secure_computing(void)
>  		WARN_ON_ONCE(1);
>  		do_exit(SIGKILL);
>  		return -1;
> +	case SECCOMP_MODE_COMBINED:
> +		__secure_computing_strict(this_syscall);
> +		return __seccomp_filter(this_syscall, false);

[Severity: High]
Could this sequence allow a ptracer to completely bypass strict mode
restrictions via system call manipulation?

If the original system call is permitted by the strict check (for example,
read), __secure_computing_strict() passes and __seccomp_filter()
evaluates the BPF filter.

If the filter returns SECCOMP_RET_TRACE, a ptracer is notified and can use
PTRACE_SETREGS to modify the system call number (for example, changing it
to execve).

While __seccomp_filter() correctly re-evaluates the newly injected syscall
against the BPF filter, __secure_computing_strict() is never re-run. If
the filter permits the new syscall, it will execute, allowing the ptracer to
completely bypass the strict mode sandbox.

>  	default:
>  		BUG();
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-seccomp-co=
mbined-v1-0-304b1cc3ad24@hill-daniel.co.uk?part=3D1
