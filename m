Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38935C1BA
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562349; cv=none; b=qN0mD/WtC2ZE0tRaojvS0UvqLMHxzZveBQrHuTY43e6L3zvBcIDZmM5TS9tdFMSoGw4ASHhfkur4tKD/t6wRwN4DKQtxN8yXW/35pVFqgYNjbk1NkWkn9TBfbnYhi2GfIccOafR+S/8rOY2OOOXDDBYcKfM/9PSAG5DWrQ7ljwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562349; c=relaxed/simple;
	bh=dOc5YJITlJFlz/6tCg3nfla+26KcmDAdbl28Faet7tg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WlNhFbKpCt5ZjgM8/n5T92D4eN4mnAzTUgu2LyyW7FoZBG7BpeRKApG0LDISXsBj8deVOsbV+a3Gnx6CS7rsnrXwUqcLqtwgXcr7b4sTgVFVOJd8LrA74OqFIPJgiRhCDGNN0iTYXmcGu/5KDzz9uhXTI9xI0M4ltaXyC4m+z0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5r8wHKQ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5r8wHKQ"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2be26d11b95so1290046eec.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 10:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772562346; x=1773167146; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=haFM47pOXRxhxxDGpSKrpLIto0vYxJ8T2Pc4k9tuAYc=;
        b=m5r8wHKQezayjfDjBicnYZ4siRgvB4ss+TFhDu/e1+e4GPmkfBttal+t1KiZ5Z9Br2
         rQd1I20yYK+zIQYHRgRQ50hUzlmsgER97iPPxqaKOYw6nYm/dVgmC78lipzSzJsszM3d
         TW48ndSTQZlXtcMX7hDrpc3wYRSNDJNVo5G4xQDTULwpCpPnwsNsdZpZKtTe7oS0VvZk
         V6PW0XRB2Y0T7qVYC+YwRY6kQsZCu5jKEcQMGdE1azfWrnBJw8q6B+uh4nqlqwGwzJRq
         mlohAiG6zbhKZVC08gFu4pkOsacZVqqnpMsDQSom8j9DdMZ7QYz04pXrUUXICNscGCRo
         QdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562346; x=1773167146;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=haFM47pOXRxhxxDGpSKrpLIto0vYxJ8T2Pc4k9tuAYc=;
        b=ZTmscN79ohjGZflbWwSk8IJzQX0bYkT/+5zmUpq7+VA2IzU42IHg8SjFfpmitx1clm
         3voiTQECxEaxYnn3KAGde8FG1bXuqpvA6ETDe6Hru4qMC7bR97hBvjOZYcm0QQxEelia
         utfODE0wRcbmhBlvq9kKiZ0Q6XE5erpV8GDyJOc9p/GLXfNU6YDtG/XTs6kNDdkXR7Gg
         TdB2F3QvbrwMa7pmk8Xnnfj4FTUkiwnEiLrH3QtN7L+itNH5DF9SvUovw3zXK1NIJC3h
         mR/8GfsFLsZHiGbv/pExERADV1RSF/HspusH3AvdSju2MAdFTt3kAYshl4BJ1gSAz7UT
         8vzA==
X-Forwarded-Encrypted: i=1; AJvYcCUl7vtiUQCzzTz02M4C/TrT549WtkG9LgFD2NHxCHFmt6HE9U6RCaBlxAXro0Vs3cCIVXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlSviOzmiJUN+XVihEh34MoIkPEN8w//9mV8hnfJROilzC7Jf
	y9kRraFAlUHkoQPn1dxjWxmsL6OLD68LpYmcclzYZoZKaqG2pwSL3plRPytFfPre
X-Gm-Gg: ATEYQzxFe/8+yTZd8mqUif5eRn8EGIYQCM7//JxpHDtQzywpy7t0EFnogi8Dlb9LSVo
	LIEOaflt+TyuUKMABJdLWxONKHqHKZDPSZv777/ga/Xk+rcYoTxFlRSgzEO1BstmjYWMnjkwwvR
	AIky+0t7SQM+kP5VpjdKHJ+kFOed8WLfhLeW0etQdl6ewZCZWdtVVq45KQYyxlRWr3ON1qk9IoL
	bjQKxdv3hioJL9tUoHhq8aeGYytIvupYP0d0sVRcW6gks5VN01EL7REyj4gcVEFy0rpGEH6BDbx
	nMjXyqeW2bPxc8lVu8zdXUtS4ju+qeInzAzyIUtFsqEpDRGGPuPTMvQfqOmsLIF4xUbfcg/+MUH
	JejoN6bIJ48hrkiAfCo8/rHXKLvhE7zbi1giQU/WoGDodB4r3+PqY+kkTAyLMZroU5lvCgszRjM
	iwnbCSrZYE4xpMg4/D/hMXFAiN1hY1Aw2RfW4afDDFgAShJ8Ml+ZEQ7u5+gMYKyz1VejRAKT3mq
	yRY0NYD
X-Received: by 2002:a05:7300:148e:b0:2bd:c8d3:a084 with SMTP id 5a478bee46e88-2bde1bf9af8mr6999815eec.12.1772562346516;
        Tue, 03 Mar 2026 10:25:46 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c01sm13605794eec.16.2026.03.03.10.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:25:46 -0800 (PST)
Message-ID: <a4c1da47af29c3930a025217f25d169da48ed2a1.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Reset register ID for BPF_END value
 tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn, 	glapt.pro@outlook.com
Date: Tue, 03 Mar 2026 10:25:44 -0800
In-Reply-To: <20260303093956.395076-2-tangyazhou@zju.edu.cn>
References: <20260303093956.395076-1-tangyazhou@zju.edu.cn>
	 <20260303093956.395076-2-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-03 at 17:39 +0800, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
>=20
> When a register undergoes a BPF_END (byte swap) operation, its scalar
> value is mutated in-place. If this register previously shared a scalar ID
> with another register (e.g., after an `r1 =3D r0` assignment), this tie m=
ust
> be broken.
>=20
> Currently, the verifier misses resetting `dst_reg->id` to 0 for BPF_END.
> Consequently, if a conditional jump checks the swapped register, the
> verifier incorrectly propagates the learned bounds to the linked register=
,
> leading to false confidence in the linked register's value and potentiall=
y
> allowing out-of-bounds memory accesses.
>=20
> Fix this by explicitly resetting `dst_reg->id` to 0 in the BPF_END case
> to break the scalar tie, similar to how BPF_NEG handles it via
> `__mark_reg_known`.
>=20
> Fixes: 9d2119984224 ("bpf: Add bitwise tracking for BPF_END")
> Closes: https://lore.kernel.org/bpf/AMBPR06MB108683CFEB1CB8D9E02FC95ECF17=
EA@AMBPR06MB10868.eurprd06.prod.outlook.com/
> Link: https://lore.kernel.org/bpf/4be25f7442a52244d0dd1abb47bc6750e57984c=
9.camel@gmail.com/
> Reported-by: Guillaume Laporte <glapt.pro@outlook.com>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---

Hi Yazhou, thank you for spotting the bug!

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 401d6c4960ec..366ba4757135 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16121,6 +16121,8 @@ static int adjust_scalar_min_max_vals(struct bpf_=
verifier_env *env,
>  			scalar_min_max_arsh(dst_reg, &src_reg);
>  		break;
>  	case BPF_END:
> +		/* manually reset register's id here to avoid mistaken register links =
*/
> +		dst_reg->id =3D 0;
>  		scalar_byte_swap(dst_reg, insn);

Nit: I'd push this inside scalar_byte_swap() and maybe do it conditionally.

>  		break;
>  	default:
