Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA94348860
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377016; cv=none; b=t0tE1JzLK2AS63mneJnwN9dNsHrrLrljgLJfFFpzd31Rk1jVWv5+slxhwMsJkJ2jfagbbFjuaI/rAQ4MoHR/gVeUGpViwjEi9jt7+UI0hahwgeuaGzSKGhp7hgGZQpvLNCs6rSsjeGi0LrwtOUTlmQ60FVTl5E2dtkaFwGonWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377016; c=relaxed/simple;
	bh=OXTIb1/N5Bc5RUHCbP84pisCmO6LuOOayqAJscQyIPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fcx92eXFehFZFV3Q2J1d1n/1EJGUgWyt6/BSslHIuNJOF9DRhV2jrKKsiPOgeUcAFrs3iZ6zwHObjUGzMhC8tSceNA3lB0vK8eKL7O6bkI7CR/8ZxCNPPKZe43mF3sT9/Giw3JvLxiaEEg7hAE38VGNeetG3is/cnXJJI52vKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Akr04Vv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Akr04Vv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E80E1F000E9;
	Thu, 21 May 2026 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377015;
	bh=gevCHyv4QKmSZnCu0TcXDn4WsjEcfgwIF6WlGvR0ptM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Akr04Vv3/GnRX4nmuUptuWzi0ZC4/EK1jXRWHQc3Ee052oz4IhMCTJ4IPgQ2UieKI
	 EWwHB7bs8rdgYBooficV3FxWjKz+XRwsvNSuJrKl4y/KjzwDu5DrY7PdHwgSu/wGEL
	 gohodNBCaLIkZrhr2CqeshZX9b/E3S83QpksRZ6aJNfFNP6V/LO/juUqNoMKptQQ+F
	 X9vlNQ/vAILBblQe1Yhk+9GehcPorDkrqwfJ+NDq4IK7M3JMv6JNTOTuj0xo5QXJQh
	 jHLrkCTcaJ9ZUk6voUoklTvEugbj0OIMob4V3QCOn0GtN8U6VDIx5YP31pDbSD95mg
	 rtJIZ1baUruLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 20/20] unwind_user/sframe: Add prctl() interface for
 registering .sframe sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521142546.3908498-21-jremus@linux.ibm.com>
References: <20260521142546.3908498-21-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:23:35 +0000
Message-Id: <20260521152335.6E80E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The patch adds a test-only UAPI interface that is explicitly not i=
ntended for mainline inclusion, violating ABI stability rules.
- [High] Unbounded memory allocation in PR_ADD_SFRAME allows a local Denial=
 of Service (DoS) via memory exhaustion.
- [Low] When SFrame support is disabled, the prctl options incorrectly retu=
rn -ENOSYS instead of -EINVAL.

Pre-existing issues:
- [Critical] Improper handling of -EFAULT in sframe_find() leads to prematu=
re deletion of valid unwinding metadata and poses a severe NMI deadlock ris=
k.
- [High] A malicious user application can reliably trigger a WARN_ON_ONCE i=
n sframe_find() by causing concurrent removals of an .sframe section, poten=
tially panicking the system.
- [High] Unbounded iteration in sframe_validate_section() without yielding =
the CPU can cause softlockup DoS.
--

commit f2ba64c060979156a7ef9c545cd667594369670a
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Add prctl() interface for registering .sframe sections

The kernel doesn't have direct visibility to the ELF contents of shared
libraries. This commit adds prctl() interfaces to allow glibc to tell the
kernel where to find .sframe sections for unwinding.

> [
>   This adds an interface for prctl() for testing loading of sframes for
>   libraries. But this interface should really be a system call. This patch
>   is for testing purposes only and should not be applied to mainline.
> ]

[Severity: High]
Since this is explicitly marked as a temporary test patch, should it be
redesigned as a proper system call or removed before being merged?

Adding temporary or experimental prctl() interfaces exposes a temporary ABI=
 to
userspace which must be maintained indefinitely, polluting the UAPI.

> diff --git a/kernel/sys.c b/kernel/sys.c
> index 62e842055cc9c..b0a9b1e3ccd7c 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c

[ ... ]

> @@ -2907,6 +2908,14 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
>  		if (arg3 & PR_CFI_LOCK && !(arg3 & PR_CFI_DISABLE))
>  			error =3D arch_prctl_lock_branch_landing_pad_state(me);
>  		break;
> +	case PR_ADD_SFRAME:
> +		error =3D sframe_add_section(arg2, arg3, arg4, arg5);

[Severity: High]
Could this allow a local Denial of Service via memory exhaustion?

A user process can repeatedly call prctl(PR_ADD_SFRAME) with valid, small
ranges. If each call allocates a new struct sframe_section and inserts it
into the mm->sframe_mt maple tree using GFP_KERNEL_ACCOUNT, an unprivileged
user might exhaust kernel memory since there is no upper limit on the total
number of sections a process can register.

[Severity: Low]
Is it intentional that the fallback stub for sframe_add_section() returns
-ENOSYS when SFrame support is disabled?

include/linux/sframe.h:sframe_add_section() {
    ...
    return -ENOSYS;
}

Standard kernel conventions dictate that unsupported or disabled prctl opti=
ons
should return -EINVAL. Returning -ENOSYS incorrectly indicates to userspace
that the entire prctl syscall is unimplemented.

[Severity: High]
This is a pre-existing issue, but is there a risk of a softlockup Denial of
Service during section validation?

When registering a new .sframe section via PR_ADD_SFRAME, the kernel
synchronously validates all FDE and FRE entries in sframe_validate_section(=
).
Because the number of FDEs is read from user-space memory and can be extrem=
ely
large, an attacker could provide a massive amount of FDEs/FREs.

Since the validation loop does not contain cond_resched(), the kernel could
spin here for seconds without yielding, triggering the softlockup detector.

> +		break;
> +	case PR_REMOVE_SFRAME:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error =3D sframe_remove_section(arg2);

[Severity: Critical]
This is a pre-existing issue, but does handling -EFAULT in sframe_find() ri=
sk
a severe NMI deadlock and premature deletion of valid metadata?

If unsafe_get_user() cleanly faults because the memory is temporarily paged
out, it sets ret =3D -EFAULT. The cleanup block then calls
WARN_ON_ONCE(sframe_remove_section(sec->sframe_start)).

Because sframe_find() is used by stack unwinders (like perf) that execute
in NMI context, triggering sframe_remove_section() inside an NMI attempts
to acquire the maple tree's internal spinlock (mt_lock). If the NMI
interrupted a thread already holding mt_lock, this could result in a hard
deadlock. Furthermore, this permanently destroys perfectly valid unwinding
metadata simply because a page was not resident.

[Severity: High]
This is a pre-existing issue, but might a malicious application reliably
trigger the WARN_ON_ONCE in sframe_find(), potentially panicking the system?

If an .sframe section returns -EFAULT because it is paged out, the error
path calls WARN_ON_ONCE(sframe_remove_section(sec->sframe_start)).
If sframe_remove_section() fails to find the section, it returns -EINVAL,
causing the warning to fire.

This condition could be reliably triggered if multiple threads concurrently
unwind through the same paged-out section, or if one thread unwinds while
another explicitly removes the section using the newly added
prctl(PR_REMOVE_SFRAME). If panic_on_warn is enabled, this might allow
unprivileged users to reliably crash the system.

> +		break;
>  	default:
>  		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
>  		error =3D -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142546.3908=
498-1-jremus@linux.ibm.com?part=3D20
