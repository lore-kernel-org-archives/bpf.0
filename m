Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4702D23B9
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295979; cv=none; b=TIxwCAlfLIdsgbeIgPuPVRUl/zi2sYMcq9hksV1aeGJQ2OasQs+1j7FERGQf9IaeObsd1kRAVcJrpclyDyLVK2oFKFXaQVExFmcoYjyDKapNsC3+u+zUnzQyi+9uVY0ucO9SaspfD3rfQRdHbVYIO1N41ZFKNk/L4fD08QT1Nc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295979; c=relaxed/simple;
	bh=GcpX8SBDAas6dXd5vLh/FFL7lg3YkUh1iD+cihU+b9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mVhp/m+Di1RKXfF/LC3u938A+J6eIDui/UvgohQWmRtlhQN1LYoCcPduj1Yt69bM1dHCQvH/Dt2LzsFw6EirX/zEX3i3RT0goE32aNYGaiBuQLhwahW+YiK/6Q0fZ5uPgshUfKOQiEog8Pbh4bBJZvUD9vTELED3TtRVR90eYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL7uR+0e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL7uR+0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69B71F00893;
	Wed, 20 May 2026 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779295975;
	bh=H56I4ZS2toCCYuMlnqnGz9pNcfd1uYfERSxsfh8IzzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aL7uR+0eA7/173upJMkdtkl/0JpkeYEABoMFX+aaBpEjeND2AV8UqvRYwX2im9b6c
	 SKkKrdd/ero/miUKDUjpawRnTMRbKpZ4lhAQBHyux+T4el7d4eSAvDtlRpIZvBBDDQ
	 /6M/fyrNPPcraoFF43reaPlV9QV6RWWdMMUNqCVwrco6D4pQdecGN8a0EPxWLsy1uP
	 MF3puwwNdPNX2VjRM04DcAbr0cq1a8xdBd+hu+f9Arp214wZeRP8VRwNRAEiSWvVqZ
	 FOb5SdjMOuZ83Ogxw97TjpLAlpCYA6SgAthyCk8sAbZeY1OzHInTTBF2ABD4tSKiyJ
	 HSHXtwxblT40Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 20/20] unwind_user/sframe: Add prctl() interface for
 registering .sframe sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-21-jremus@linux.ibm.com>
References: <20260520154004.3845823-21-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:52:55 +0000
Message-Id: <20260520165255.A69B71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The patch introduces a temporary testing UAPI into `prctl` which i=
s explicitly noted by the author as not intended for mainline.
- [High] Concurrent prctl(PR_ADD_SFRAME) and prctl(PR_REMOVE_SFRAME) calls =
lack synchronization, leading to use-after-free, double-free, and memory le=
aks.
- [Medium] Unsupported prctl options PR_ADD_SFRAME and PR_REMOVE_SFRAME inc=
orrectly return -ENOSYS instead of -EINVAL when the sframe feature is disab=
led.
--

commit a01f291288e4c84f6ad3bbf93c1ed0939390a9b8
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Add prctl() interface for registering .sframe sections

This commit adds new prctl interfaces to allow glibc to inform the kernel
where to find .sframe sections. This provides the kernel with visibility
into the ELF contents of shared libraries.

>     [
>       This adds an interface for prctl() for testing loading of sframes f=
or
>       libraries. But this interface should really be a system call. This =
patch
>       is for testing purposes only and should not be applied to mainline.
>     ]

[Severity: High]
Should this patch be merged if it creates a permanent UAPI via prctl for a
temporary testing feature?=20

The commit message explicitly notes it is for testing purposes only and
should not be applied to mainline. Committing to this interface could result
in userspace relying on a temporary test mechanism.

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
> +		break;
> +	case PR_REMOVE_SFRAME:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error =3D sframe_remove_section(arg2);
> +		break;

[Severity: High]
Are concurrent calls to PR_ADD_SFRAME and PR_REMOVE_SFRAME properly
synchronized to prevent double-free or memory leaks?

If sframe_remove_section() only holds an SRCU read lock and
sframe_add_section() only holds mmap_read_lock(), could Thread A and Thread
B concurrently executing PR_REMOVE_SFRAME both find the same section and
erase it?

If Thread A calls mtree_erase() and queues the section for freeing via
call_srcu(), and Thread C concurrently inserts a new section at the same
text_start via PR_ADD_SFRAME:

Thread B might then erase the new section but queue the old section's RCU
callback a second time. Could this sequence lead to a double-free of the
old section and a memory leak of the newly inserted section?

[Severity: Medium]
When the sframe feature is disabled in the kernel configuration, will these
calls return -ENOSYS instead of -EINVAL?

The dummy functions defined in include/linux/sframe.h return -ENOSYS:

static inline int sframe_add_section(unsigned long sframe_start,
                                     unsigned long sframe_end,
                                     unsigned long text_start,
                                     unsigned long text_end)
{
        return -ENOSYS;
}

According to the prctl ABI convention, unsupported options typically fall
through to the default case and return -EINVAL. Could returning -ENOSYS
cause unexpected errors for userspace applications probing for this feature=
's
availability?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D20
