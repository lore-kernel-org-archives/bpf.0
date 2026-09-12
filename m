Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59630568E
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243849; cv=none; b=VN5pt9WMJkcZavmysuiTqQljsJF3jpZSUUE403g+AbOu3Ecgmhe9GbBke7tovJHoq2i5F6mDgiC8rHksDtGZebUlJd/sdkzzcNw599NZ6EFsL9KNk3IZYnmIa7PA768DeFaW8FP12G25wUUJEWPyzotD6vFgdTCqP2cVxZY+8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243849; c=relaxed/simple;
	bh=04+RUC3OXaqRcoITvjh3gDcTwHUuoI6LEkDasCu6f64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RVObRAV6owEa7sgcTVFepQz+CyhiV0ZZxlZBIEC/MIKHM3Pz3IWhbGetXCUDIwO42HLWRA4wqk1DFKnZR4WKPjk4p+3vAAX3OlgGZTFQmRlXNZv3KeRoAf6GxCPuUgCOYlocssyg+3/2blceONEgToufBsvILhsnW6wRXBg1mOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUk5LDzE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUk5LDzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C631F000FF;
	Sat, 12 Sep 2026 20:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243848;
	bh=f7q3Mq+5YS0zsiuzAbG7LLFTZEIuYrgAL1i+j6+x6Rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUk5LDzEhxYj4uz+SzKMXXrMr8W1ehhjhcfcwIpZjM6BOkYWgZAlwKoT5wFtqpv70
	 p8cHkGcMObUyD8H8jEzKkhKAOHyKqIqGYQeo7sQuRh6psG1XUXKb1Dr61CV5oKEJ3S
	 XRpZJz/9L9CIeCmDd7CFMq64daI1jJ9ZUZtQSfKy4azYpuPLxTKjtBTtZTzZmsh5UW
	 MRzkdCRj6dk+WDnCOW2VzHIEcINjGRv7y6z0iGVLkl7UgMueQIpN8eTvgmGRNQbyhe
	 gCbSvQCShHm+ArXCSusp25camPm4ycsDChWVmrS8Eh2mMxEqHoDTVp3HY42iyyPRPl
	 G2JHdcfnEj+EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 09/15] bpf: Prepare kfunc arguments for the
 JIT from an ABI description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260912195242.989416-1-yonghong.song@linux.dev>
References: <20260912195156.980886-1-yonghong.song@linux.dev>
 <20260912195242.989416-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:10:47 +0000
Message-Id: <20260912201048.30C631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the required BPF subsystem style.
--

commit 68032f34d921b02fbe1d286d103a8c0c09435a42
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Prepare kfunc arguments for the JIT from an ABI description

This commit introduces bpf_jit_arg_abi to describe BPF calling
conventions based on architecture-specific rules. It replaces open-coded
argument placement with a generalized approach used by bpf_jit_place_args()
and bpf_jit_plan_arg_moves().

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d0066d744ceb9..2a5fa346aadaa 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> @@ -993,6 +993,13 @@ static_assert(__BPF_RET_TYPE_MAX <=3D BPF_BASE_TYPE_=
LIMIT);
>   */
>  #define MAX_BPF_FUNC_REG_ARGS 5
> =20
> +/* A by-value argument takes two eightbytes at most, so the maximum numb=
er of
> + * argument slots of any function is 2 * MAX_BPF_FUNC_ARGS. A local arra=
y may
> + * need that size for processing, although eventually the maximum slots =
will
> + * be capped at MAX_BPF_FUNC_ARGS.
> + */
> +#define MAX_BPF_FUNC_ARG_SLOTS (2 * MAX_BPF_FUNC_ARGS)

[Severity: Low]
This isn't a bug, but does the multi-line comment block above
MAX_BPF_FUNC_ARG_SLOTS follow the required BPF subsystem style? The BPF
subsystem guidelines specify that multi-line comments must have the
opening /* on its own line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912195156.9808=
86-1-yonghong.song@linux.dev?part=3D9
