Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34702BEFFE
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197521; cv=none; b=bLmKlIGt75Wo4g6CkUajzjC0yd5kYOywNFZGTrIcxP62hnOaokyU/wdy2YKNCK5VHbhliWf/t4CHbLgkCaO3cesH5620siK92fxrrYDZx3sP7s2kTW+q8LlDpMyaC0oiuwQ3jGUeS+M/GZQ+qWUaGahnEH4WEepBLEZ617CRj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197521; c=relaxed/simple;
	bh=ITfnZEQ3W/u3WhVx6Z0IDGccAinySSNqC/xhrPKjFOo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c+D0IXAY18DC31+F8m22dzDtkYyYOzF8sGXAfFeoAuvB6BHkPynWv+LDjBF4Eng3RkNezNtmyNyNisKYJNAhEeRLLMUhRQGEd/2VgGGLAkHsJDmbfTip/gFTZSDhllNSvgTZJ17pa/bcdfEk1RJ95HdOfaQNUoedn1C65aN+vp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHSaatQA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHSaatQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646C4C2BCB2;
	Thu,  7 May 2026 23:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778197520;
	bh=ITfnZEQ3W/u3WhVx6Z0IDGccAinySSNqC/xhrPKjFOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WHSaatQAyZt2QAyjpbUnT34LE7S/8C92s23jfoXHjGs4Som0hsbg8PFBXr2xTAZE+
	 6hMDEq/EzhCzmewGAIlr1nnu9esWWWpV0dIRWA9DbK0SV3k+lCYRo7xwvQGJj1BLb9
	 kN27hpVVZXuAU6sSWu+L3G53vBap9rAc7unXopgU+t7OxOOCJ69GehXWxM0C6F9FVT
	 Bgo3HukpVlVRQa3kp//uPnh5SgwaBV0xK4bZ8nUacOjMorRPjm4wixJJ32ud2ZdqvA
	 miOueZzivSZd80yJ3RiBjywV4Gfua6NdrlE1vuIZtNrcNaB/pnY3kpfWn1pxFkz8nz
	 KGUAf1Tu6h0Pw==
From: sashiko-bot@kernel.org
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from
 NMI
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507175453.1140400-2-utilityemal77@gmail.com>
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 23:45:19 +0000
Message-Id: <20260507234520.646C4C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] TOCTOU race in `bpf_dtor_kptr_release_one()` can lead to NMI deadl=
ocks.
- [Low] Memory leak on initialization failure in `bpf_dtor_kptr_init()`.
--

commit 488cdc390b90427a591d47211600c09addc95fcd
Author: Justin Suess <utilityemal77@gmail.com>
Date:   Thu May 7 17:54:52 2026 +0000

    bpf: Offload kptr destructors that run from NMI

This commit queues destructor-backed kptr teardowns to irq_work when
running from NMI context. It maintains an idle-slot surplus counter to
ensure offload slots are preallocated to prevent deadlocks.

Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@=
gmail.com/

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3b1f0ba02f613..d34fdb99eb8a9 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
[ ... ]
> @@ -65,6 +69,111 @@ static DEFINE_SPINLOCK(map_idr_lock);
> +static void bpf_dtor_kptr_release_one(void)
> +{
> +	struct bpf_dtor_kptr_work *job;
> +	long surplus;
> +
> +	for (;;) {
> +		surplus =3D atomic_long_read(&bpf_dtor_kptr_surplus);
> +		if (surplus <=3D 0)
> +			return;
> +
> +		job =3D bpf_dtor_kptr_pop_idle();

Could this sequence lead to a race condition that drains the idle pool
too early?

If multiple threads read a positive surplus value here, they might all call
bpf_dtor_kptr_pop_idle() before the cmpxchg executes. This could temporarily
drain the idle pool below the required number of reserved slots.

If an NMI fires during this window and attempts to tear down a kptr, would
bpf_dtor_kptr_offload() find the idle pool empty? If so, it looks like it
would trigger the fallback warning and run the destructor inline from the
NMI context, which might reintroduce the deadlocks this patch aims to
prevent.

> +		if (!job)
> +			return;
> +
> +		if (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_surplus, &surplus,
> +						     surplus - 1)) {
> +			pcpu_freelist_push(&bpf_dtor_kptr_idle, &job->fnode);
> +			continue;
> +		}
> +
> +		bpf_mem_free(&bpf_global_ma, job);
> +		return;
> +	}
> +}
[ ... ]
> +static int __init bpf_dtor_kptr_init(void)
> +{
> +	int err;
> +
> +	err =3D pcpu_freelist_init(&bpf_dtor_kptr_idle);
> +	if (err)
> +		return err;
> +
> +	err =3D pcpu_freelist_init(&bpf_dtor_kptr_jobs);
> +	if (err)
> +		return err;

Does this error path leak the per-cpu memory allocated for the idle list?

If the second pcpu_freelist_init() fails, the function returns immediately.
Should there be a cleanup path here to free the already initialized
bpf_dtor_kptr_idle list?

> +
> +	return 0;
> +}
> +late_initcall(bpf_dtor_kptr_init);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507175453.1140=
400-1-utilityemal77@gmail.com?part=3D1
