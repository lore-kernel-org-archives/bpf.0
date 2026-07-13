Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378634CFC6
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783977752; cv=none; b=a1SzGsKsG0HF9KTBqYQscokqxR0tXfLlarIx+8FfsGOzbd5ZKaFAf4ui/7QB3vU7ryrU9uiesLw6uZcx4Nam6MOt5edE2GtaONGA+1elRIlgG/R9Q8qziVY+nGRL889UGTrj+rz6wr0aSWpZelMSIHLBj1mKV0JYdP6YvH4THbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783977752; c=relaxed/simple;
	bh=0911x5z746DSBGrJQdRd7PT2mgv7GWq115asLXG13ZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VIX7B6PLemk2o/CQAFQ6UR3yVjATd93wE3yA8JiKT14WaXVWePIrDPFXHnerXE5ftPKWlkaNDqnImFO+m1b74LLRnhSDf6k5NT6DsgawZlXraHFfvaz+iLROelKQ+ovtnsW/L4e1C+eezoGZi23Kg90l7UcxCATE2BcyT1F0nag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rI53V3nQ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI53V3nQ"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso2020595a12.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783977750; x=1784582550; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=012KWSmGKH9yQYdoYG3G0PrW1DobnL7zQ0ZLH/2ph6s=;
        b=rI53V3nQ2ig2TZ8WN48uvIgiYPv7S5jGO939hN+TXwG1MLYZ31CunGTLy6btueEakt
         GA4uPHOy3s3G/50KVDoXwXWvpMh2f64VRP+JKY6BXhmx6FGie8ltEddOUoZGBXwdQ9s1
         nVsqkYBjUIfRIS9TLFz30pBsWvaXzkWGFQv1Bvy05o/hlb5ESnchyvHNuuUgiyQf5juB
         vJlWfr1aqDep5VlM7WQ8gWqM5r6a4ysdIf4iiqJLIvfVNbFCgNi3n2XKxB1AoQRX7HXV
         j/naa0Qj8rljz6EtIJxfwLplMa7OGcHXCiBIz7MN4LwS8aVK5hI7on8hYu4+87HeVghH
         Dp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783977750; x=1784582550;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=012KWSmGKH9yQYdoYG3G0PrW1DobnL7zQ0ZLH/2ph6s=;
        b=N06Z5IVrM5r3vg2V/ggTWTIqPOPse45RHyrgjabuZEUDnVVPn2zc9TME7P2MM8Iwpy
         ekqKpHQ6LtyaDCe64JWdhxexm97Rgd6oVfVRcp2B5NXrpnmgKDPQ/KQdiSJVRhq2go5S
         55EL1m/qiYH3jSKVexl5I12eeXiYePqrxnpia0EkthLp4IXYkGOZt66Z2AAlPMPyIMtb
         7KoLlmD3tu8g+a3CDr+3VgsBexDQ4cdVw1u3sw+/ifJiQGNMj08FD26VfamQibnT78tY
         rMLHl4WWSFjg96APl9K871NeqbmLEBN4jfAYjIw01uG3qZWyw+bQ6cmizOiD9gQo/DLr
         k3/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rov83MbSZYO4+pFHntZ/hFGhns8oNdFWN+NNPhkVGeQvKBZ0mbY2BiecMFnQsxx2bcWvr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjLHrpavjcmBmCggZRWVw/LzYpe5dltQGSNDNaZ1ykHufFw84
	eXAMX6Qh/fL0SY3srHq7k7Pc9B2PRvej+aBft3n3GnscpUxdmvdRgiYn
X-Gm-Gg: AfdE7cmfUo1mBleoW3Ebbgm/IJovcxCii8EDThQxulPTYb4eQQBJbyU12r9J3WLQNZT
	rX/4llwAKOTqcprxdZAKcYcXyU+ylWu2/SP/I/zTqsiKqEh9zkc724puc0Z/izcBraKolHR5qle
	KTK4kv0rUA20TuJNQ9qOUkCuIc4QQL0VLF/mm/J0PZd7g9p9BCEV0zjuRhWD8tM9UybduvepG2h
	L7sSHxtzSG2GlLH3OGTtv4ga+wb3J5wZ0MsP+68Ac5d4GicGt63N6yncai5O9Uwy/IEih9qJ+XX
	56McvCoAxu+NQxmzFQU6pEoszBi0EfaORoJsGrxsuprHKrDUo5aRUORxASneAXmtbgVdX1Na8Em
	z/qITQwpaPZd/ZErROzo49sMW8IAnG2UNyZtJYWR9HpFARX1rodNY5xp+ULqxlIZUiAhgoF9Ctr
	8y05oJ4A2nSlHDA0M2kqbzXyNU6QFPG6t32tsS+TnM
X-Received: by 2002:a05:6a00:1954:b0:845:c373:6525 with SMTP id d2e1a72fcca58-8488975a5b1mr9606193b3a.41.1783977750383;
        Mon, 13 Jul 2026 14:22:30 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf016sm359029b3a.28.2026.07.13.14.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:22:30 -0700 (PDT)
Message-ID: <77e5d785ca08a5fa57c661d9494f4551d0b55425.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Check byte type when validating
 helper stack reads
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 13 Jul 2026 14:22:27 -0700
In-Reply-To: <855140e07cebafa6770d577ed107b2541b92f95e.1783920884.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1783920884.git.chenyy23@mails.tsinghua.edu.cn>
	 <855140e07cebafa6770d577ed107b2541b92f95e.1783920884.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-13 at 06:16 +0000, Yiyang Chen wrote:
> check_stack_range_initialized() validates helper ranges byte by byte, but
> bpf_is_spilled_reg() only checks the slot-wide spill marker. For a CAP_BP=
F
> load, a narrow scalar spill marks only the covered bytes as STACK_SPILL. =
An
> untouched sibling remains STACK_INVALID, but the helper still accepts the
> read when the slot contains a spilled scalar.
>=20
> Require the byte being checked to be STACK_SPILL before accepting the
> slot-wide scalar spill state.
>=20
> Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
> =C2=A0kernel/bpf/verifier.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 03e2202cca13d..c971cf34c760b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6785,7 +6785,8 @@ static int check_stack_range_initialized(
> =C2=A0			goto mark;
> =C2=A0		}
> =C2=A0
> -		if (bpf_is_spilled_reg(&state->stack[spi]) &&
> +		if (*stype =3D=3D STACK_SPILL &&
> +		=C2=A0=C2=A0=C2=A0 bpf_is_spilled_reg(&state->stack[spi]) &&

Sorry, could you please explain again what's wrong with the original check?
Here it is:

                if (bpf_is_spilled_reg(&state->stack[spi]) &&
                    (state->stack[spi].spilled_ptr.type =3D=3D SCALAR_VALUE=
 || env->allow_ptr_leaks)) {
                        ... accepted ...
                }

And it says: if there is a register spill at 'spi':
- always allow access if the spilled register is scalar
- when allow_ptr_leaks is true, allow access when spilled
  register is either scalar or pointer.

The goal here is to avoid leaking pointers, and pointers are always 8-bytes=
.

> =C2=A0		=C2=A0=C2=A0=C2=A0 (state->stack[spi].spilled_ptr.type =3D=3D SCA=
LAR_VALUE ||
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 env->allow_ptr_leaks)) {
> =C2=A0			if (clobber) {

pw-bot: cr.
