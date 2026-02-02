Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF32DB783
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062605; cv=none; b=Uno8bv2hsFVYj4osXgVPr0XpUSifSRGCtyR7LZ++gplOxxHrnM94GeuMRx3pWLYt8H4UApcwHpac05aBtpU/Dx0wKK1M93Q2SPc7VlmYczdI9dClPWbovqlz6aXy5GZXSBOgzqvrU+MiEUlTCkQL8fuQPGH3049oCkoIt35v1/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062605; c=relaxed/simple;
	bh=F49N2nqnSHSs4st9byLss7RjbHj9sFNORHnwxDp5Lio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j4co1LFXcuFZBIAEW2Kb+ZcvkVcWI+8bMcQnPoR9NdjsVudxykbCekfbkqOHbVELUG1Pu6VJN+J2nLWenRYi+AIhkPjDkWgadWPmeta/UQE3rRrGiyi1tg+6UyFf34m9M8zjR8uJMo1hr/L1z+zUiZFKfoyruaUxsffizxJ/SfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S21Ou1QQ; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S21Ou1QQ"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b720bb90d0so4747604eec.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 12:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770062603; x=1770667403; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mclfyc94LDSdMgXzfhKezNdsSg5ki1SU0HxwzWIZCUk=;
        b=S21Ou1QQ9YpfLkl/ZhZzj+C0ceUtZJYxcPTAfV+7EBIwrG0aFOY9sZ/XkXglMxUIJ7
         +zgDRsDzjpZdEcpnt/CUf+exswlAxruIRQxDJU4eX5JcWp2ZESW+xr6Z0TuSSO0TSlyc
         iaqAgMfByluRjbVh4TNfNbUyYlrYQZpl7T1Cedxfv1SwPNRfZE2Hszb361Q9hvnq7Csm
         /RytUPhAknV6U/7c5QyYwWaFV7wevF1AF9M7fb+6GQVEO3gtxu/6KeJ4w7iu8W+DWLOT
         /QDsUkQpn9va1SDrhAyhqlaW+osVXNf1EV3aMkYyymJnOox/td4kTKP6lOge7ZBrOllS
         YAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770062603; x=1770667403;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mclfyc94LDSdMgXzfhKezNdsSg5ki1SU0HxwzWIZCUk=;
        b=Us4VglGYbHTJ1WAGHzoxg8GRc8r43Tdeu32VfMuq81DOD0PZLTqAkNNnurnw45hEtE
         TpGrDbfXp+ewmkQIxqUvtIaU2ZwxfxMX7ci+mm86oaML+xWxArbb8yO4mZOJD11tJFzf
         ldnkQGZ0/y5cBmby8dIosSxOStjI69SLDKTBHoCqH+WvEbIm95eCEvtxciX9Q78SoQdK
         UHrxdGrD4LBvGHjKMczbhts7PpVjX1cPKun/fFHyGAj84k0zearTfNhDMajh716ANAkh
         H8p7EHHfoLPUz3gOsuQJod/XfU3Apdv5tTdQ/FUbbtZ4pqEbH93ES4WWDk0HaJ6Dd1Ln
         lsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW957/oMfr+neSAbf4hGWhBcHlO4GPHABVfB1ExG5pl+irjCnTUi/PQ8NjYCC7STkIo04w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7aVs+7aHIU8U3tK4tKYP/kU8J1PnW7XdsNd7UYM6rtKaLR40E
	TPo+3jQoSyUMmXgTzyGhwnXOc962yP7nwNgVraq/LzN6ZsqeLmT3jXrc
X-Gm-Gg: AZuq6aIoqiX2rLu9T7dAFxryB6G/KLw1d0yyCJaK3gsJoudgJ2mGJtcwH84z+/DS9+g
	Grfxp7EdgagzwXbzNWOT7K3cMQ77vw3Qw4Wy56aUt6neIxL1akIMds6DfN3VRA1bYoLE43gt3on
	+zy5BM9hWAlVuyBIL3PcuCFWqq5O6fzfAIIT5sg2C3E6NjFQbkT+B6Fdvm7o+BLXYBDc+9CzOHl
	AAo4XCW/A90CcyYzuoD0AR4Uo25z4sivdS7I+RSG5I1zoUWg1wGgtL3Sog2Couf5zm/faUhABYO
	zU/JetAIVc84NZ9CkR/bgNpqBslbn7eJqACAWWcpKxO6cVIeVfa82C6SBun5mkQ84hwnspeMFgx
	dau03YsJbCrKWcrvITvKUhCo5llzBIVfYHLmScaHgGneODMPlPUKn1LcozUAhMqinl3mIZsuBpL
	Y/jYOjIqqzOpgcNepb4oCYZ7qSkPqZUw7NCE5RRC6lu0UzIqpkH2pE0WN3FUoiJVO4Ag==
X-Received: by 2002:a05:7300:bc05:b0:2ae:4f61:892e with SMTP id 5a478bee46e88-2b7c8903199mr5902220eec.36.1770062602659;
        Mon, 02 Feb 2026 12:03:22 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:eca2:6a75:cc8b:c3? ([2620:10d:c090:500::3:5713])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1add664sm20880137eec.26.2026.02.02.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:03:22 -0800 (PST)
Message-ID: <e62c874af12c74ec4442df6e098c6d5000f9540e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bitwise tracking for BPF_END
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tianci Cao <ziye@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com
Date: Mon, 02 Feb 2026 12:03:20 -0800
In-Reply-To: <20260202133536.66207-2-ziye@zju.edu.cn>
References: <20260202133536.66207-1-ziye@zju.edu.cn>
	 <20260202133536.66207-2-ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-02 at 21:35 +0800, Tianci Cao wrote:
> This patch implements bitwise tracking (tnum analysis) for BPF_END
> (byte swap) operation.
>=20
> Currently, the BPF verifier does not track value for BPF_END operation,
> treating the result as completely unknown. This limits the verifier's
> ability to prove safety of programs that perform endianness conversions,
> which are common in networking code.
>=20
> For example, the following code pattern for port number validation:
>=20
> int test(struct pt_regs *ctx) {
>     __u64 x =3D bpf_get_prandom_u32();
>     x &=3D 0x3f00;           // Range: [0, 0x3f00], var_off: (0x0; 0x3f00=
)
>     x =3D bswap16(x);        // Should swap to range [0, 0x3f], var_off: =
(0x0; 0x3f)
>     if (x > 0x3f) goto trap;
>     return 0;
> trap:
>     return *(u64 *)NULL;   // Should be unreachable
> }
>=20
> Currently generates verifier output:
>=20
> 1: (54) w0 &=3D 16128                   ; R0=3Dscalar(smin=3Dsmin32=3D0,s=
max=3Dumax=3Dsmax32=3Dumax32=3D16128,var_off=3D(0x0; 0x3f00))
> 2: (d7) r0 =3D bswap16 r0               ; R0=3Dscalar()
> 3: (25) if r0 > 0x3f goto pc+2        ; R0=3Dscalar(smin=3Dsmin32=3D0,sma=
x=3Dumax=3Dsmax32=3Dumax32=3D63,var_off=3D(0x0; 0x3f))
>=20
> Without this patch, even though the verifier knows `x` has certain bits
> set, after bswap16, it loses all tracking information and treats port
> as having a completely unknown value [0, 65535].
>=20
> According to the BPF instruction set[1], there are 3 kinds of BPF_END:
>=20
> 1. `bswap(16|32|64)`: opcode=3D0xd7 (BPF_END | BPF_ALU64 | BPF_TO_LE)
>    - do unconditional swap
> 2. `le(16|32|64)`: opcode=3D0xd4 (BPF_END | BPF_ALU | BPF_TO_LE)
>    - on big-endian: do swap
>    - on little-endian: truncation (16/32-bit) or no-op (64-bit)
> 3. `be(16|32|64)`: opcode=3D0xdc (BPF_END | BPF_ALU | BPF_TO_BE)
>    - on little-endian: do swap
>    - on big-endian: truncation (16/32-bit) or no-op (64-bit)
>=20
> Since BPF_END operations are inherently bit-wise permutations, tnum
> (bitwise tracking) offers the most efficient and precise mechanism
> for value analysis. By implementing `tnum_bswap16`, `tnum_bswap32`,
> and `tnum_bswap64`, we can derive exact `var_off` values concisely,
> directly reflecting the bit-level changes.
>=20
> Here is the overview of changes:
>=20
> 1. In `tnum_bswap(16|32|64)` (kernel/bpf/tnum.c):
>=20
> Call `swab(16|32|64)` function on the value and mask of `var_off`, and
> do truncation for 16/32-bit cases.
>=20
> 2. In `adjust_scalar_min_max_vals` (kernel/bpf/verifier.c):
>=20
> Call helper function `scalar_byte_swap`.
> - Only do byte swap when
>   * alu64 (unconditional swap) OR
>   * switching between big-endian and little-endian machines.
> - If need do byte swap:
>   * Firstly call `tnum_bswap(16|32|64)` to update `var_off`.
>   * Then reset the bound since byte swap scrambles the range.
> - For 16/32-bit cases, truncate dst register to match the swapped size.
>=20
> This enables better verification of networking code that frequently uses
> byte swaps for protocol processing, reducing false positive rejections.
>=20
> [1] https://www.kernel.org/doc/Documentation/bpf/standardization/instruct=
ion-set.rst
>=20
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> ---

Hi Tianci, the code looks correct, a single nit below.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -15986,12 +16029,19 @@ static int adjust_scalar_min_max_vals(struct bp=
f_verifier_env *env,
>  		else
>  			scalar_min_max_arsh(dst_reg, &src_reg);
>  		break;
> +	case BPF_END:
> +		scalar_byte_swap(dst_reg, insn);
> +		break;
>  	default:
>  		break;
>  	}
> =20
> -	/* ALU32 ops are zero extended into 64bit register */
> -	if (alu32)
> +	/*
> +	 * ALU32 ops are zero extended into 64bit register.
> +	 * BPF_END is already handled inside the helper (truncation),
> +	 * so skip zext here.
> +	 */
> +	if (alu32 && opcode !=3D BPF_END)

Nit: zext after scalar_byte_swap() won't change anything, right?
     If so, I'd just avoid the special case and skip 'opcode !=3D BPF_END'.

>  		zext_32_to_64(dst_reg);
>  	reg_bounds_sync(dst_reg);
>  	return 0;

[...]
