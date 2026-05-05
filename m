Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376103C2768
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006757; cv=none; b=AxplKGecpVlb2oFNxX2frh28WMV4N8wa2I4ArfNlTMEBV9tzSg1R4E90qcZ2ALI7yPSrcPfXJCYXA1GVs7lc8UCGsduOfcnKU479HHI3IslyUmzuh5nzFytq/7VW74B33El2qXaHq9Y3rQ+QT/THFCNsxC2zr9sWcpiFmC04kL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006757; c=relaxed/simple;
	bh=GKWG+sLGWVUJD6MeBUhI1Cyp+JVTjuRGwwPHCYWQYZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GW1yN9U/2seRJEOu2owH97N4bCMm9NbdObm2BMDIh4H/yqJUz2jF9FUQaVbD7drhVjg4rUe0YU6cyRUMbUDT6R4U4GSUhVJUDg7Q2ZHyfmjtYgLkKFVYDs9h3vawc1VK+cZ4IVODgcMRMbVpaSUamscf7aI4uvD8n8Ws5/SaxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtB61BRq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtB61BRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94A0C2BCB4;
	Tue,  5 May 2026 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778006756;
	bh=GKWG+sLGWVUJD6MeBUhI1Cyp+JVTjuRGwwPHCYWQYZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RtB61BRqmKxMIIZi5iAB5gpN+uoL1ZzoHkoCMIoBlMyehAKjZ/9Ek0YxsbekDypju
	 myw30z29uS28PUXlgyN9miSwo3L4E9SLpJNWd+FDJQJa7crR/k5Lc9zGTRuIbMwhA/
	 jdZVJKGafl+DxKwYaP9e45aqP0I9n9iy8KvY0W2JO9LxmsAidDh40uiBgAKJwAUG+Y
	 MTiVt4t6c4ulRIPAo3BlHAsu18kBDDX1mst2lZFpn/ow7qKlbZ7Yk9uz3hzOin13WC
	 s4B0mCBKu0VDvpTWHumx67mq9PsNgJ16e3ieJ1rN9KtnaHGJBTsCFWWBWfok6RHoCI
	 XjtMml1OJt5zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 19/19] unwind_user/sframe: Add prctl() interface for
 registering .sframe sections
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-20-jremus@linux.ibm.com>
References: <20260505121718.3572346-20-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:45:56 +0000
Message-Id: <20260505184556.B94A0C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `break;` statement causes `PR_SET_CFI` to fall through to =
`PR_ADD_SFRAME`.
- [Medium] Patch introduces a test-only interface into the permanent UAPI.
--

commit 9171aa16917963dd1070d9ca3467d9086cd66393
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Add prctl() interface for registering .sframe sections

The commit adds prctl() interfaces which allow glibc to tell the kernel
where to find .sframe sections. It mentions that the patch is for testing
purposes only.

>     [
>       This adds an interface for prctl() for testing loading of sframes f=
or
>       libraries. But this interface should really be a system call. This =
patch
>       is for testing purposes only and should not be applied to mainline.
>     ]

Is it intended to include this in a mainline patch series? Adding temporary
or test-only interfaces into the UAPI represents a permanent ABI commitment
once released.

> diff --git a/kernel/sys.c b/kernel/sys.c
> index 62e842055cc9c..6e81e82bc9911 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
[ ... ]
> @@ -2906,6 +2907,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
>  			break;
>  		if (arg3 & PR_CFI_LOCK && !(arg3 & PR_CFI_DISABLE))
>  			error =3D arch_prctl_lock_branch_landing_pad_state(me);
> +	case PR_ADD_SFRAME:
> +		error =3D sframe_add_section(arg2, arg3, arg4, arg5);
> +		break;

Does this cause the previous case to fall through into PR_ADD_SFRAME?

It appears the new case was inserted before the break statement of the
previous case. This would cause execution to unintentionally continue into
sframe_add_section and overwrite the original error status.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D19
