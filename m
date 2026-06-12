Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AD0305670
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299075; cv=none; b=jJCW/Rhsm9+ssc5YijxqJkg6m8KIvya7zURN+KPxNrXWtDMqMxO2Re7xPAdB0latY5uzYx2GnT/8LBsMsRMZuGKWKo69+Z4oRQZy8lexgCvSOfZqGHtjaD4eAbfa8DzRAMHY4lpaWxCQ+AHDMeUWrg5bpwGkAsy5m8b1m45ft/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299075; c=relaxed/simple;
	bh=oWftYDhMkl76y75pKPEawZd9CVnlgZ9ebsZaZ2xO6us=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aiV/BLAPL7cnLfUGnlrryyov1u8jSujinH/+pM4Dizz4BxRvLjFs9oXB8T7+vl2yn73At8aqmRe/hTxrHRxezOhkLL2o+ZJe5kyWnjsCTqxvtN++iuuBa7L8zd4i3F67hk+b04o/RsOVSefEtus/RxQ5kYV9eyO1Fga5XJ/gpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH4cwj+r; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH4cwj+r"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1363fe80fe8so2236284c88.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 14:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781299072; x=1781903872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BgCyfcEGyUE9hoE+x0544zdGFGWTbREYDHAscBm7+sA=;
        b=SH4cwj+ritIIFWFIrLVpUd+tutpJoqshU8Uenn7ZjoNjhE6w1loU0wfBWa3dgAwTDG
         Wqy2ur0s12k9xFltCLOK4PS9+ac8dsttRXFozDRouqD7kw33lq8ow607FEX2Mln9Ny4w
         seca2z8y8SH+/suJNMeHUsNviNGNS+ulldFzLYJnOsybh5rpEedBk0oCqLOEtntZ2SpK
         5pgGlzqB2koRmKeN1d9lhmj8/McGlICMvS4SOhEJdiSr9uPBL8A7+TjVhVelB1c9udRY
         HTWBKIzoEwJt7UadkPhzlavqc+2FHxFpnUD/QP4JyEfqPOqi87lhLzn5biaFhQ+lUwgI
         W7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781299072; x=1781903872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgCyfcEGyUE9hoE+x0544zdGFGWTbREYDHAscBm7+sA=;
        b=ABXHM3v2TfDV8FAX+hs33TXAynfY+Z2rCYKJ9Mm29t1vjW8JYZ+Smb5iDQvuBfsRjO
         glvas3oyQTXXMdiNZSsQ98nV0kpNmb6HGrp6wktcywU6tzp8Yz0H4qMWtJSRWUhTqddz
         nWGRH3lP1zpUDR1lcyn7e69cchIQjJIfAdqhyQb3HqXT1IyOBljtqDMMOJfmOyjWgQIy
         dWrRtcXGKdVxoXfM0mPsswzYuIy8j5wb3zsr0OqoS7h2qTqHHf4+W6LqBOYWIzKiL2Rk
         p5StSZdJWD87ys9TQEI83O7FoEM+ZyqFf7lvX3qVaZ1c5gCoqYqF54JmHKKbWWs8N07U
         6dbw==
X-Forwarded-Encrypted: i=1; AFNElJ+NiqvK45stw3eUOFeFcd2oc8h6OeNJ74W0bNbV4GroKIKW0Lf0HRn0ZWJoPfSD1m0HGyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTXsuc0Jjib2kHZQmAU2GkIGjxeadzTjN1qICfar0UBIn5JXR
	j3M0AF7kpqcBY0FZWaAhN3fXfBSNfM8EqS/2Elmd8jba5J6pRaI1+xi+
X-Gm-Gg: Acq92OFU2sluUPVfCaiZgACac8Qu7sj7S7bofGv113es4X27QczTivDrprs95I174m/
	X785qQ8vtatEMy/y0MgfUV/WITkF9sXei1qMBmrO4IecC/Hi08rTqcfwBqrC+803quAHnICxuBa
	w72Xc20d05MMmXVtVff0MhgUBN/sJyydqgOk1zgv2lhjvsg7MoZIF9lRSk64Fx6vy8VCIr2YGss
	wu8zp44SJSAcT6LNbLfPWsXzyeIubY3lUhlVmJdi035zVSfVJ1E8NOpdae6m62H6EB/uYV8sCua
	BoJlKwJdLaGvrFIEtIioGvxyV/ZuRbFPQcYxALtuMA/ltvelm//IzaAPZmDXTi6H6WHF1LApd3Q
	WKT0Od2C2+tUwrEkmeNbJGYRil61n7FnvGHLKr7E/u67aQW85l4ZAizH57GbWQhgQm7p9Vnj02k
	9wv/Fbt5vD5KEY3GBVhzc4lVxP+sEIj97H4hJPcGVFznT+drtc1v6SfP9sAckEKR+zEyvV+3vHv
	RzI1zk5
X-Received: by 2002:a05:7300:d4cc:b0:2e1:e3e6:2909 with SMTP id 5a478bee46e88-3081ff73b5fmr2630036eec.9.1781299071785;
        Fri, 12 Jun 2026 14:17:51 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9497:cf9d:9fc8:debe? ([2620:10d:c090:500::1:af9e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm5175286eec.3.2026.06.12.14.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 14:17:51 -0700 (PDT)
Message-ID: <b9b5ce121db4204090adb6fe9a803345735fbfb8.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: support shift operations with
 non-const src operand
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tianci Cao <ziye@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com
Date: Fri, 12 Jun 2026 14:17:49 -0700
In-Reply-To: <20260612093818.18609-2-ziye@zju.edu.cn>
References: <20260612093818.18609-1-ziye@zju.edu.cn>
	 <20260612093818.18609-2-ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-12 at 17:38 +0800, Tianci Cao wrote:
> Currently, the BPF verifier only allows shift operations when the shift
> amount is a known constant. This is overly restrictive for cases where
> the shift amount is bounded but not fully determined at verification time=
.
> For example, the following code is rejected by the verifier even though
> the shift amount is bounded to [1, 4]:
>=20
>     u32 shift =3D bpf_get_prandom_u32();
>     shift &=3D 3;    // shift is in range [0, 3]
>     shift +=3D 1;    // shift is in range [1, 4]
>     r1 <<=3D shift;  // non-const but bounded shift amount
>=20
> Modify the shift helper functions (scalar_min_max_lsh,
> scalar32_min_max_lsh, scalar_min_max_rsh, scalar32_min_max_rsh,
> scalar_min_max_arsh, scalar32_min_max_arsh) to handle non-const
> but bounded shift amounts.
>=20
> Update is_safe_to_compute_dst_reg_range() to remove the src_is_const
> check for shift operations. This approach ensures the verifier
> remains sound while allowing more programs to pass verification.
>=20
> Also modify the comment on is_safe_to_compute_dst_reg_range.
> Shifts by more than insn bitness are legal in the BPF ISA; they are
> currently implementation-defined behaviour of the underlying architecture=
,
> rather than UB, and have been made legal for performance reasons.
> See: https://lore.kernel.org/bpf/20210706112502.2064236-47-sashal@kernel.=
org
>=20
> Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -14320,14 +14350,36 @@ static void scalar_min_max_arsh(struct bpf_reg_=
state *dst_reg,
>  				struct bpf_reg_state *src_reg)
>  {
>  	u64 umin_val =3D reg_umin(src_reg);
> +	u64 umax_val =3D reg_umax(src_reg);
> +	s64 smin =3D reg_smin(dst_reg);
> +	s64 smax =3D reg_smax(dst_reg);

Nit: the naming becomes confusing when reading 'smin >> umax_val'.
     I'd use something like 'smin >> max_shift'.

> =20
> -	/* Upon reaching here, src_known is true and umax_val is equal
> -	 * to umin_val.
> +	/*
> +	 * BPF_ARSH (arithmetic right shift) on 64-bit register.
> +	 * Same three-branch logic as the 32-bit variant (scalar32_min_max_arsh=
):
> +	 *
> +	 *   smin >=3D 0: result in [smax >> umax_val, smin >> umin_val]
> +	 *              e.g. [4,8] >> [1,2] =E2=86=92 [1,4]

Nit: I'm not sure that repeating the code snippet in the comment is helpful=
, tbh.
     Maybe just have an example for each case and explain it in terms of di=
viding
     by smallest or biggest divisor.

> +	 *   smax <  0: result in [smin >> umin_val, smax >> umax_val]
> +	 *              e.g. [-8,-4] >> [1,2] =E2=86=92 [-4,-1]
> +	 *   mixed:     result in [smin >> umin_val, smax >> umin_val]
> +	 *              e.g. [-8,8] >> [1,2] =E2=86=92 [-4,4]
> +	 *
> +	 * var_off is set to tnum_unknown since a non-constant shift amount
> +	 * prevents precise bit tracking.
>  	 */
> -	reg_set_srange64(dst_reg, reg_smin(dst_reg) >> umin_val,
> -			 reg_smax(dst_reg) >> umin_val);
> -
> -	dst_reg->var_off =3D tnum_arshift(dst_reg->var_off, umin_val, 64);
> +	if (umin_val =3D=3D umax_val) {
> +		reg_set_srange64(dst_reg, smin >> umin_val, smax >> umin_val);
> +		dst_reg->var_off =3D tnum_arshift(dst_reg->var_off, umin_val, 64);
> +	} else {
> +		if (smin >=3D 0)
> +			reg_set_srange64(dst_reg, smin >> umax_val, smax >> umin_val);
> +		else if (smax < 0)
> +			reg_set_srange64(dst_reg, smin >> umin_val, smax >> umax_val);
> +		else
> +			reg_set_srange64(dst_reg, smin >> umin_val, smax >> umin_val);
> +		dst_reg->var_off =3D tnum_unknown;
> +	}
> =20
>  	/* Its not easy to operate on alu32 bounds here because it depends
>  	 * on bits being shifted in from upper 32-bits. Take easy way out

[...]
