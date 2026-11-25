Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579700;
	b=SyA3OczZuLQjI9+9zNK6+G/YJjyT/TW71aOCRWz2k7qfQ7AMWoEXqVjDwl1A2KGbkM6I
	 5OL96ARnb1tf5CKEur4x7hu4Kr2wC/z/t0Z6w10rc4oQbOaNacO907vpygTk3A3xMvhHR
	 8cHYI2hRgABxSb39B4TS+abjDcGs1jjCQ3r5srIpwPpswwaqcftZg/UteAtqYQBSyQt3I
	 IwORcgxSBtKBc/831GifnN3WcZwXYTRb92Tb53C1oNxDl+Aaw25O5kkdQ7+gv9EKuhUIw
	 YIrQHBP8uB7WdnKaIC6PfRFj9GJSmNw+UsUYHG+7Rn2V9RFT4tUdcU4XtBniuqrwwew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579700;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=hAz+pNtOgLBglRHgB4EybuS/9YaaObwGBodr5tygHXY=;
	b=OOQMMQZEdaHGauDP/QuVvQzEBrwxZYq9botgUwHfDGz15C5dRCRZ8L8kcM6//AyIpPzW
	 mmrTuN2PEQd22K4BBj0jVKJpNZeIkCVzIY99nLe9zhz/QmEuL9+VRVEXhdfPW/RZ132qs
	 NuB8cUSFq6bVL21KtJPxrsGHqzCNO+Ri6wbdB0qTFoK3x28GKdgNZIcbpkDomQqY2Ke8m
	 UnB3CAuI5chf9fZZ6pTaBCI3bVe5hFfRCI6P/nigknP3r6XLKkvtfoTnqbh4K2fBo6jEg
	 Rgd4Pgx4b5jBuR5V4Yi9Z97zOjyNkaGiepUaTo26PHms9BtEjpQfUwLmkwjirLHK3Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eftVM32I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EFE606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eftVM32I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22E51F000C0;
	Wed, 25 Nov 2026 04:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795579699;
	bh=hAz+pNtOgLBglRHgB4EybuS/9YaaObwGBodr5tygHXY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eftVM32IvJhJA+uTYuTBKzFz+OID9BaWe1G1ke7fMzhoKJm5RpRjlmnmdUDiYjCzH
	 Fy96MITqLK85BLctY0NC0O/tbljKLnR7cVeCPKSzms49EHOLeuwBwB7AFMOh4SWiMG
	 5Bj9GV8p9UH8UntggyKVisPTjXMPtofqVJQDoCt90mDJGWKTZUXpC163L1D4GY1E3p
	 kdVuPp9cOwX341408Vs0XQzwIxICsX5G+JwJWRrbWbF2FWG5nnPDQagCiRwUuqqRV1
	 e9GumsxuRzvNGGID+LnQ8AAplAdwGngCkYPkyN4J77T6LrjtXgauzlEcYqeSdurTNr
	 Eno9Cga/RTUhw==
Content-Type: multipart/mixed; boundary="===============4357921173702940775=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b366e22d7135557535ba15efd2e8166eafef33e4d97d14b9cd79845b66b38f2e@mail.kernel.org>
In-Reply-To: <20261125032938.670542-27-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-27-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 26/47] bpf: Require CAP_PERFMON for kfuncs that leak pointers or touch tasks
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 04:08:18 +0000 (UTC)

--===============4357921173702940775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Require CAP_PERFMON for kfuncs that leak pointers or touch tasks

TL;DR: Documentation nit: the KF_PERFMON section in kfuncs.rst doesn't cover
the task-acting kfuncs (bpf_send_signal_task, task work) that now get the
flag, so new such kfuncs may miss it.

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 901c37504217..31389dd5c9f6 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -537,7 +537,8 @@ addresses to the BPF program, for example by reading through a pointer that the
>  verifier does not check. Calling such a kfunc requires CAP_PERFMON, or
>  CAP_SYS_ADMIN, in the same way that the equivalent BPF helpers are gated in
>  bpf_base_func_proto(). A program loaded with CAP_BPF alone is rejected at load
> -time.
> +time. The flag is implied when the program gets a returned ``void *`` as a
> +number.

This isn't a bug, but the KF_PERFMON section still describes the flag as being
for kfuncs that "can expose kernel memory or kernel addresses".

The same patch adds KF_PERFMON to bpf_send_signal_task(),
bpf_task_work_schedule_signal() and bpf_task_work_schedule_resume(), which
return only 0 or -errno and expose neither.  The commit message gives a
different reason for those: they "act on any task".

Could the first sentence of the section be widened to cover kfuncs that act
on any task as well?  Otherwise a new kfunc that signals or schedules work on
an arbitrary task may not get KF_PERFMON, based on this reference.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45542192835
--===============4357921173702940775==--
