Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41D3191BA;
	Wed, 17 Jun 2026 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682490; cv=none; b=TGBZrBzu+FoLS32nwOm0sY8IVK2nmD2hWxg5s/zfnKOCp76vJVQBUGKwaRboTir3Zr3HFJ1CoS7GaIM+Eg3Zl0+jrclCV981ZCBZFyZMQTRplv7sESd9YXgE1MnJ0pI+Kye6rl5QubFEm3TaGS5jPZWOyoHn7xqQIC3munyo82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682490; c=relaxed/simple;
	bh=nRfuCt93gFk3vbumuajPbWPzVHh37GYRRbFniBp4is0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oVCqDDI8rEhZjfADd65DJO6W2XyA8WzMzhFxh1kbolLg8AhDUg5JYKHOxP0N4H+rkJjoKSUbvj/uATAJvcMch7/52DX4K+6mc8Rfhf8ZAmi5Fdtav17sRJkatTl3GrPkNJ45/wGy85iAxt6mMdFzwYAk855GieeIcKyqGi5O+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=uo4+lRgY; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="uo4+lRgY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1781682079; bh=RKVWZMqrUacOZc0Vngz6mdjmDS6/q5LpvjOTD5B8Iio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=uo4+lRgYO1+Ccbpc4+baQwba6mx6OeYNUK5/EXttxkL+WD4Ju8An+JK7mjZl3/ipO
	 adKdn7DvZZpZ1piZHuNe7p5HVv0X/6GErwYGfqePzfN4o3FOFTeD16efpc8fis8HsY
	 XacH1meV+FjrqrdOJ8VbhzyCGQlojcjRHOlxWukCBSUCKTjpZS9124zh4FAKO0Fot/
	 lpLor9Zm/neSSzIWUOveHy/WhMSHRtHSHBcyzl0IA3ZOGFZ5ihivqsJvMDMsMIlwes
	 eU/yEDNWeBBtkS7S3fAwiAQAHOXPPSo18nMG/4lTrS72yviQ1n/CPNkMBcGo5SDkn9
	 MdiYGW7AFjZ1g==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ggG4v0NdPz1xpg;
	Wed, 17 Jun 2026 09:41:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:620:618:5b8:2:80b3:0:d9e
Received: from localhost (unknown [IPv6:2001:620:618:5b8:2:80b3:0:d9e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/aeCQqU27acxigRb0HWE/fB1Z4zAFgx3o=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ggG4r1cF7z1xrr;
	Wed, 17 Jun 2026 09:41:16 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  John Fastabend <john.fastabend@gmail.com>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Shuah Khan <shuah@kernel.org>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Fix stack slot index in nospec checks
In-Reply-To: <20260617-f01-11-stack-nospec-slot-index-v1-1-e3a080b0cd7e@mails.tsinghua.edu.cn>
	(Nuoqi Gui's message of "Wed, 17 Jun 2026 00:57:55 +0800")
References: <20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn>
	<20260617-f01-11-stack-nospec-slot-index-v1-1-e3a080b0cd7e@mails.tsinghua.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 17 Jun 2026 09:41:13 +0200
Message-ID: <871pe5y5pi.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nuoqi Gui <gnq25@mails.tsinghua.edu.cn> writes:

> check_stack_write_fixed_off() computes the byte slot for a fixed-offset
> stack write as -off - 1, and records each written byte in slot_type[] with
> (slot - i) % BPF_REG_SIZE.
>
> The Spectre v4 sanitization pre-check uses slot_type[i] instead. For a
> 4-byte write at fp-8 after the lower half of fp-8 has been zeroed, the
> pre-check scans bytes 0..3 and sees STACK_ZERO while the actual write updates
> bytes 7..4. That can leave the second half-slot write without nospec_result
> even though the bytes being overwritten still require sanitization.
>
> Use the same slot index in the sanitization pre-check that the write path uses
> when updating slot_type[].
>
> Fixes: e4f4db47794c ("bpf: Fix pointer-leak due to insufficient speculative store bypass mitigation")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281c..50e80dbbc1784 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3479,7 +3479,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>  		bool sanitize = reg && is_spillable_regtype(reg->type);
>  
>  		for (i = 0; i < size; i++) {
> -			u8 type = state->stack[spi].slot_type[i];
> +			u8 type = state->stack[spi].slot_type[(slot - i) %
> +							      BPF_REG_SIZE];
>  
>  			if (type != STACK_MISC && type != STACK_ZERO) {
>  				sanitize = true;

Acked-by: Luis Gerhorst <luis.gerhorst@fau.de>

I have briefly checked the other uses of slot_type[i] and they look
fine.
