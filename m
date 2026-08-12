Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6A3FF1B4
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569671; cv=none; b=Na7o/WZJOtmY8JD+MInJqyWW0Cf5X+9sLKHnmHQ/t9OdGRPrMii/zV8vn2TvniNBqIR+SZtihf7ONqk7cB/NAOP3x2IBYwN4jMjI9pDyin4Qubm+mjvflq27CgGYtGVS9Lez8ul4hX4SXgFjtIh0nwcvrNQlSQ3wWXG7NoVYTRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569671; c=relaxed/simple;
	bh=Ko3e4fbCJMaQNJ8ibHn7NvV02W3ad28tB2YRq45uyrI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KdGgv/c6cQX9CwadFWzOeu8eyMKxDImkDIVJkbQcECuYDcZdvLL/p4tZyH9/HZmBsgy0dMkHKP95QNRpXoSi71a++BCgn0pXfnM0/eAuGe+6l5CiDw1Wr0TPBe8CjgwW2YI56RBbyas2+zCvKBqqeYK9EUUkEnB/fOu/gHnKNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6M8TQn2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6M8TQn2"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso2438711a91.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786569669; x=1787174469; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7jblAko4TIElX4GrxgpB7RG/riVFgh6VtIwHLxYN80M=;
        b=j6M8TQn2W1lKy3guuasPhgUlzBB2sqnh45MrZ4EwTE7xOxn0YpSiHixToOg1/dP1Hs
         LLiOqquBMcYDZF1yCe4iy5v1jngmQLPPloH7fzefmk+z7cjNDQdqebUmOaBVLRHPiMIe
         VGkd/MoE+ByNTBcJLS2MXza19yO7nRMITGVqakC1U9ZBUVzKkJMAn9cZRWUx8g/rVcix
         lnuIi9hrc6IWlLM60gEgLChw5PiT8C0Cl0Q+o3WaqnAtW6TXaOGD43Qm/yjORiQr+zWY
         xNH/jjc5H1TPNX02H5jAq+xZjdfwhtzwH3KJgD10SWzwjyESaJw27sih4H0/Xn7kRpoW
         S/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786569669; x=1787174469;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jblAko4TIElX4GrxgpB7RG/riVFgh6VtIwHLxYN80M=;
        b=szaBJlqfkrglkePl5FWqg4X8/g38tuL+72d4uA1LKw0WyCRQ1KyqfygAI+TQXIrrCG
         /CLJJBRSrIh3zLWG0TikfQ/fuVoeoVjHEumYofLBJ+4ryOyOCFZrZtRi9fCRaB6Znvm7
         kI17FOj2DBxePBqiDzleIqHMLowKNQI6dpm8bspNBccHAAs/UFEuU1954CIU0afgVDGn
         PoMI+Mq5KbCTAL+zE3tdiTVrDD95DiB9ShUJitsGBVEY3vRqepdxAD2Zsm3+cKXfk7st
         qLubEV1lk8hwzSh9eyRXjL0CYUnigo2bX+DGtgmP/2Uo9ySI5Y5NtPJqYOzCoNodePx8
         i2TA==
X-Forwarded-Encrypted: i=1; AHgh+RrNMz8FtEvWzh20ZnrvBeySyzh/TqYO68T5nS7ZyXAAz0nA6JcfxBT+b8LKUI4cXzulX0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+8d6CPmxUfvnKfCzBbsKXTbfOdDE7Mt0M3ohfJaIsmZdwMm1
	3Y+bj0sKMeS+/vqjJbf208bRQ17Wi7ODKZ0kto33zyyI9D1crLiG3jqZ
X-Gm-Gg: AR+sD13QmGoZhPubi3C7UZRPqbcBggPP3lbdthALRz2HviGaYGgiRLfMbt8z/037FIm
	T538ROBOBSp5lgnzpWHbuAndzLSmigLV0ZIwYKxAg7vFuFPiHKZLwlBzkiZ3R04d70w9wQva/dK
	WbaHaqy5y0p/qTk9r8mZV89o5cYkXUfkq6zdTD1JrHhAPKIIGPvtKIA5yhpL0ZH05MgA5IVA0Yu
	Prp5JO2r60PfRVvd0teuFDL6ehzw/ySlO0y1ZOx+rtFFm0iADZBPhFAiY6q9R6LnxG3Wyib1u1y
	4k1Z9B/3E1DBYAkcBp55Kb/SoW9wOmxghKc3s7r34OAKYWVAgswChAr9CtisAbM/t4MCI7afV4E
	lni5J5ycIDMk3cWmBuRYhnQH9QBx4cb0Xv2djt6oftaf1WGo+kZmuFn6Cqt1mqU8J/lCKmOP6SG
	q8mEmZ2eZhEUO4c5hJz283CbBaLlGxGq3CpnfOs1x8LKlEZPV2EGvZjm8TxM075sZgoUtqgz8VP
	hNTu+IrjH+51bPH
X-Received: by 2002:a17:90a:ec8e:b0:380:fead:448d with SMTP id 98e67ed59e1d1-3931e26f714mr1407372a91.13.1786569669157;
        Wed, 12 Aug 2026 14:21:09 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cd46314sm864632a91.6.2026.08.12.14.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:21:08 -0700 (PDT)
Message-ID: <f98b37e8dfd115063150a7f3caea873451295771.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 05/13] bpf: Account R2 of register-pair
 returns in live register analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 12 Aug 2026 14:21:05 -0700
In-Reply-To: <20260811000937.2381528-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811000937.2381528-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
> A BPF_EXIT of a subprogram returning a value larger than 8 bytes (a
> struct/union or an __int128) reads R2 as well as R0, since the second hal=
f
> of the return value is passed back in R2. compute_insn_live_regs() only
> marked R0 used at exit, so a callee's R2 could be considered dead and
> cleaned from checkpointed states, which would allow unsound state pruning=
.
>=20
> Mark R2 as read at the BPF_EXIT of a subprogram that does return a regist=
er
> pair. bpf_compute_live_registers() walks the instructions in order and
> env->subprog_info[] is sorted by subprogram start, so the containing
> subprogram is tracked with a running index and its return convention is
> queried once per subprogram through bpf_ret_reg_pair().
>=20
> Marking R2 at every exit instead would be simpler, but R2 would then stay
> live backwards across any call that is not followed by a write to R2, whi=
ch
> is nearly every program, and would needlessly hurt state pruning.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> =C2=A0kernel/bpf/liveness.c | 25 ++++++++++++++++++-------
> =C2=A01 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index ef9a5a922887..451edd74fa6f 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -2062,10 +2062,15 @@ static inline u32 mask_widen(u32 m) { return m | =
(m << 16); }
> =C2=A0static inline u16 mask_lo(u32 m) { return (u16)m; }
> =C2=A0static inline u16 mask_hi(u32 m) { return (u16)(m >> 16); }
> =C2=A0
> -/* Compute info->{use,def} fields for the instruction */
> +/*
> + * Compute info->{use,def} fields for the instruction. @ret_reg_pair tel=
ls
> + * whether the subprogram containing @insn returns its value in the R0:R=
2
> + * register pair, which matters for BPF_EXIT.
> + */

Nit: this comment change is unnecessary.

> =C2=A0static void compute_insn_live_regs(struct bpf_verifier_env *env,
> =C2=A0				=C2=A0=C2=A0 struct bpf_insn *insn,
> -				=C2=A0=C2=A0 struct insn_live_regs *info)
> +				=C2=A0=C2=A0 struct insn_live_regs *info,
> +				=C2=A0=C2=A0 bool ret_reg_pair)
> =C2=A0{
> =C2=A0	struct bpf_call_summary cs;
> =C2=A0	const u8 class =3D BPF_CLASS(insn->code);
> @@ -2196,7 +2201,7 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
> =C2=A0			break;
> =C2=A0		case BPF_EXIT:
> =C2=A0			def =3D 0;
> -			use =3D r0;
> +			use =3D ret_reg_pair ? (r0 | reg64_mask(BPF_REG_2)) : r0;

Nit: let's add an r2 variable.

> =C2=A0			break;
> =C2=A0		case BPF_CALL:
> =C2=A0			def =3D ALL_CALLER_SAVED_REGS;

...
