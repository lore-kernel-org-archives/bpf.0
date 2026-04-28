Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D5329E7E
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394780; cv=none; b=rqH2WOT4DIJZO12CBem64OggIvIeG6p+jhOxKtjjcqRfncamekmxfULv/dLdA/NXRZx4cqLpukrje7jnZTvz9vc7Pw9UUp+WeLMYGBMwbIc/VgufloQHqX8k1J3RR3un70fCKDP4aNkBXeDTrVBBDH9GYq2weuylvq3oENd5eZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394780; c=relaxed/simple;
	bh=/fNp2mFHrHzbvVCpc6jBdls5IoO2JoXdfxLFj9DPcrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RK2QdGtpf6zDcI/0MVmPe34k2v9NTQkG6XNMLrDCgane2A4SQnIPB8WTFKkz4+v5ZT5Pg+AUaexFHmNecOXJPByS/yXEaYPnqf8JoGDU07eg4zgrsyinL9qC2VER+xm6600++rRkNfjKLsJHM/3g9ZtSKGlXcyvmyQRKz9JUT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7uL+FOv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7uL+FOv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso59704745e9.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777394778; x=1777999578; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xX6ZobyCZ0aP+zrMg2Q9FAh4/2uG9AusWr19tGXBlXY=;
        b=K7uL+FOvmjDU7sdvWRowW7FXplbdotoG2L8t7qk8/6miL45C7jiIiuLamkow4fTXqy
         x/3JCxJTJC5uXKKcbr/WeW5KUQB18/bzgVnLvuxhyCKHHwEWocLPBLW+58RUq6UC9kMb
         AhMFXmZ1BSr8huESh3BaLd6nO+mh8+ANx+CgUx0a72d0HmiZKYHGoUrbKGfTqj0P1TTC
         0AKP9AT2EnXZVuLj4offkCXlsSHyYI9X5/+q8AqwdLflXUlxG42T6yMc3K2le4QWzrHZ
         SyifkwjCnK6IALvSKXgZiUP6SXbZ4cY9BMfOGY7TWhWuabLmyt7C7Io/JqTaNlQ6DgNj
         UmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777394778; x=1777999578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xX6ZobyCZ0aP+zrMg2Q9FAh4/2uG9AusWr19tGXBlXY=;
        b=OX9HdcmIPI1xxHcRuABtBynady72GQsnuMHcvJznWFCYVy+yAGl4K3Url22XoMQmm7
         TrhKHGGa3yQpT6b1i9lc116SWMVVXmf6IILoLafxRtKSMO7IlmagettsTLfN2Q8l7TVM
         7C6Mp0+wHbJ3Oyj+DbVuaNkzQpqV9T8crJZRdXia0x6y4lxYz1Zr13lfuV7Fitkp35/8
         8d2ouVWQEc4BoGjxg+rJVjGbEEDybRRbzxEDrzO/C6wWwbYbnuD7I35RdDPZGbHxaLOO
         XZ4OUX3IuNR2tTPf5XZFg9ISCQ9PjUaHacp0jTeOJX6hD8xqKt/xIy9SGHc8GVfCteUz
         16AQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UmFaTVCrnDv/AW/gKOgoFo1OnhTk4HOmD0bZ7zpsoAr+AMiyG9ygpxpJGpLcnZnKFLFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSR/PvreMRTwexVJznDT9uDUYicfUQGlc7E1573D2hEQ04TfJa
	Aie1GT0u6hcgpS1GhGPIQxwA0M3jnWZ4mQDCnWffaYSd8W8HQmaF+7s2
X-Gm-Gg: AeBDiev1NG29/6P2LhO0+d6yK+IiQNoPmaRyXJQ4sjzDryYxDztZcpDvPwZtdO54BcR
	Ntrgf6XZLzzk+x6fkSPdp3d9jgn7g+/ate5lC3s0BmKJSZXXN3lMnFk/13iRkI//TAlYCYNC7KX
	eZd4pSsUHvgbCAPHHnoOMT5/G+Vj8LWnWRMYkItwoZhjDHZF9rZckce/zg+Yv4jTY6JXWfODV6P
	lQVlqyh3+dLZyY6tRwE9KGdTS1wo1bXMMV1HG0vZClIjrWkVm9tWVdiotoGT5IXLNaa4/eviwJB
	OW6qjrfNqr6xwIEFXNOBSB2/nZ1FxCWUevLp/wBuV8GQzivvsUIUfjASdTtbDNCc1+UfTdYb+Fm
	LNtumtvsHupgtn/7Bh3+L3vty59mXsn7CKM1V5Ebl2VKV0FEscR8YgwSleF6jMDhVFjhnd/V+Hn
	PIBDw0212WijiaqIjyWxfPKhlOkPw2iNWzfHynWKSDJZnhuaZS1tJ1IEkYUKbiN4QfodI3Q0J2H
	v3D6OtvPlbpt9NWJ1w=
X-Received: by 2002:a05:600c:c118:b0:48a:65ad:1881 with SMTP id 5b1f17b1804b1-48a7b533de1mr4570715e9.13.1777394777419;
        Tue, 28 Apr 2026 09:46:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:1126:4:a18c:dabb:5dfa:d13d? ([2620:10d:c092:500::5:e452])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b569cb5sm5762265e9.2.2026.04.28.09.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:46:16 -0700 (PDT)
Message-ID: <d85346c710e62c1ccf1babe1c5e5ebce6c757fb6.camel@gmail.com>
Subject: Re: [PATCH bpf-next 02/18] bpf: Add precision marking and
 backtracking for stack argument slots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,  Martin KaFai Lau
 <martin.lau@kernel.org>
Date: Tue, 28 Apr 2026 09:46:14 -0700
In-Reply-To: <20260424171443.2034958-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
	 <20260424171443.2034958-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 10:14 -0700, Yonghong Song wrote:
> Extend the precision marking and backtracking infrastructure to
> support stack argument slots (r11-based accesses). Without this,
> precision demands for scalar values passed through stack arguments
> are silently dropped, which could allow the verifier to incorrectly
> prune states with different constant values in stack arg slots.
>=20
> INSN_F_STACK_ARG_ACCESS is encoded as INSN_F_STACK_ACCESS |
> INSN_F_DST_REG_STACK (BIT(9) | BIT(10)). This is safe because
> INSN_F_STACK_ACCESS is only used for ST/STX/LDX insns while
> INSN_F_DST_REG_STACK is only used for JMP insns =E2=80=94 they never appe=
ar
> on the same instruction. This keeps the total within the 12-bit
> jmp_history flags budget.
>=20
> Three components are added:
>=20
> 1. Jump history recording for stack arg accesses:
>    - check_stack_arg_write() records INSN_F_STACK_ARG_ACCESS for
>      outgoing stores.
>    - check_stack_arg_read() records INSN_F_STACK_ARG_ACCESS for
>      incoming loads.
>=20
> 2. backtrack_insn() handling:
>    - BPF_LDX: when backtracking through an incoming stack arg load,
>      transfer precision demand from the destination register to the
>      stack arg slot mask.
>    - BPF_STX/BPF_ST: when backtracking through an outgoing stack arg
>      store, transfer precision demand from the stack arg slot to the
>      source register.
>    - Call boundary: when exiting a callee back to the caller,
>      propagate the callee's incoming stack arg precision bits to the
>      caller's outgoing stack arg slots. The slot index maps directly
>      (slot i in callee corresponds to slot i in caller) since the
>      caller's stack_arg_regs only contains outgoing slots.
>=20
> 3. bpf_mark_chain_precision() state walking:
>    - When iterating parent states, mark stack_arg_regs[spi].precise
>      for slots that have pending precision demand.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  include/linux/bpf_verifier.h | 13 ++++++++
>  kernel/bpf/backtrack.c       | 61 ++++++++++++++++++++++++++++++++++--
>  kernel/bpf/verifier.c        | 30 +++++++++++++++---
>  3 files changed, 98 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2cc349d7fc17..735f33ad3db7 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -393,6 +393,13 @@ enum {
>  	INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
> =20
>  	INSN_F_STACK_ACCESS =3D BIT(9),
> +	/*
> +	 * INSN_F_STACK_ARG_ACCESS uses INSN_F_STACK_ACCESS | INSN_F_DST_REG_ST=
ACK.
> +	 * This is safe because INSN_F_DST_REG_STACK is only used for JMP insns
> +	 * while INSN_F_STACK_ACCESS is only used for ST/STX/LDX insns =E2=80=
=94 they
> +	 * never appear on the same instruction.
> +	 */
> +	INSN_F_STACK_ARG_ACCESS =3D BIT(9) | BIT(10),

Tbh, I'd split bpf_jmp_history_entry like this:

  struct bpf_jmp_history_entry {
         u32 idx:20;
	 u32 frame:3;
	 u32 spi:6;
         /* insn idx can't be bigger than 1 million */
         u32 prev_idx : 20;
         /* special INSN_F_xxx flags */
         u32 flags : 12;
         /* additional registers that need precision tracking when this
          * jump is backtracked, vector of six 10-bit records
          */
         u64 linked_regs;
  };

[...]

> @@ -453,9 +498,10 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
>  					     bt_stack_mask(bt));
>  				return -EFAULT;
>  			}
> -			/* clear r1-r5 in callback subprog's mask */
> +			/* clear r1-r5 and stack arg slots in callback subprog's mask */
>  			for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
>  				bt_clear_reg(bt, i);
> +			bt->stack_arg_masks[bt->frame] =3D 0;

Nit: I think having these set at this point is a bug condition.

>  			if (bt_subprog_exit(bt))
>  				return -EFAULT;
>  			return 0;

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c

[...]

>  static int check_outgoing_stack_args(struct bpf_verifier_env *env, struc=
t bpf_func_state *caller,
> @@ -7269,8 +7285,14 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
>  	}
>  	err =3D check_helper_mem_access(env, mem_reg, mem_argno, size_reg->umax=
_value,
>  				      access_type, zero_size_allowed, meta);
> -	if (!err)
> -		err =3D mark_chain_precision(env, reg_from_argno(size_argno));
> +	if (!err) {
> +		int regno =3D reg_from_argno(size_argno);
> +
> +		if (regno >=3D 0)
> +			err =3D mark_chain_precision(env, regno);
> +		else
> +			err =3D mark_stack_arg_precision(env, arg_from_argno(size_argno) - 1)=
;
> +	}

Nit: maybe make this a utility function, e.g. mark_arg_precision(env, argno=
) ?

>  	return err;
>  }
> =20
