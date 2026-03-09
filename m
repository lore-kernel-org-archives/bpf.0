Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7E3A9DA9
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073297; cv=none; b=U2Dt+aLfFXahDIRDBH7khxgQ0u+rfbWPbGX3ImaJ9um6wgbedAE+fNqxtp+Lq68N5vrgkMsGPeAxJfPTTQpc7NcJj9++c7oyTpamIXc/RWUBov80zRbfSdj2ja36MwC6W3aGUbhk4icZ26g1QYrYn7kpjHR7rXvO7zRZ6McupZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073297; c=relaxed/simple;
	bh=td74bMx8ZXiHQfNV+QzmTZxdoVL+td/b5gqEqpcrNW8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WFdBSu9itpqSlawLuRuSkPOXb8uu67pSu47ktIyQVcWjLzjrfN8UTptuzTg3Ex9Khjt7t/MAZeKa4Q9a7rtW8H3Aq2UBQpUz67DfoX7hRUTPd60rbeCwShGPBqILcIEvWCJHViPBnfx8SBQ2pcRLxqp0sqIzQZfdGRaMd4hyDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=0W3ncEka; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="0W3ncEka"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899fa9610bbso131846916d6.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773073295; x=1773678095; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k907me6g0lW0BSeww/pGmw3mgtqq3eewfWPpggfLHN8=;
        b=0W3ncEkak6FmKdEAn7axM9i9i9wM5esprQoKh2aufozwfj0y74EEcJcTJ214MYhQwq
         CEzSD4TVDx5sc/bPeyA5h4mc2Ac+e/F1zTsU4TUizNErQqKh83Uuo7ghiSXTIUrR/Gaw
         j84Q93kWQyx7iDLtuKl5gpYdhwPKVONGZaz+f7NJ0c6H/wm/ZEbPsKp4sdsKhhauAfiM
         KFSfR4UxUi7VDLVEslX6NJ01a9qtoclhy0KFnhR5y+Y7VMIL3RqXS0nyoL+f5da+nvhD
         7TjCdKqP8ZUr6ZKuVcknIH09oP379ZBdhMNI2qHoDv97wRqrwiIjJPdDoCqsLhCI1MIV
         Fv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073295; x=1773678095;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k907me6g0lW0BSeww/pGmw3mgtqq3eewfWPpggfLHN8=;
        b=rOWg0vM4jIIWPqwl1SMERqs2u//Zo0LnqbKvx2mqqK9JF1u6szxMEB4/u8a/09IBeO
         Poz/avJpa25pd369iXRcaxSZbKKVRY5bWk9/f39B6Md1nlQ3XJB0q9TT6u8EmSYKFYZG
         F/UUNzjWcibE7FbajzkitlKsLcu6XI/GOURZTWUKip2Vqz6y42OD8QoFEZnaVSphFNTu
         9WkVE9U/dB/FXkZTXg/4Q/OllV7V22koaM8xwELm2JUvNxrFB20hwsNfaLrDwPvi02V8
         9t5i2rGKCQ599yxUUBnxYpX0aRShZo6L6h0JwvO/Y52GvdyeS5Ag0CFTe97ZG2UZ7Cck
         qjXA==
X-Forwarded-Encrypted: i=1; AJvYcCXaQchfHdhQli5Ss0f2DOdjzMqVp/9QlcObrzKieSJyRU2Twe5iphusHBeNzOKHZfKROT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/JASdl1LGe4PUT01EOd5/GOxijcMke7+QcEg4ePIbAKrZX4IF
	cwJ0HFoFm7JK+epuY6LW2M+3Gv0y0IHxC/q+zraLbjTSbq/5ScJnY4SIxfgPeRU1q+o=
X-Gm-Gg: ATEYQzz8y5NNoXkjvRpA5XVxjIn5WjK8epg0nXyU5Opl07uD5MF0sYcSUVF7/eGWrEd
	D2oystZJ4+8izqFF5CbqwpdML+LYhqHO5tepwy6QIfzGXHjRixyUora3ZYnWS27Rl/+sJm+NBEX
	7E05/xmOBXX7lOarryowiwluvRBkYfVASuFDgUQ95gNGaZWVUkEqM/BIbIwnPYSstn58Zm733Ob
	2s7gYjiOk0Muypy/gmF8NOEwIDw4kFwYdhmWWylDN+0JI1xcw79vRdmiFTONOPuGM5HBzDCZ3Qh
	/t3NvI1oITIpI7eONpPA8aa2hVofAOrI5NHa1u0QVftqrQCWtHYN5O16Wp3vK0KAam4rem6y6o7
	wn/7Z544bMByPvfLRtdWPKFprxP4brkKStj1+KYEjx+SXUPLJp4W9OkUBUwQltC3rTtuw53A7kp
	x65kACFZ9VquhMW17498XgbrQdyxxekliuYA==
X-Received: by 2002:a05:6214:262d:b0:899:f601:788b with SMTP id 6a1803df08f44-89a30a1799bmr185913076d6.3.1773073294650;
        Mon, 09 Mar 2026 09:21:34 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57bf772csm988956d6.24.2026.03.09.09.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 09:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 12:21:32 -0400
Message-Id: <DGYE0XY2UKQV.2COXLK9T9HG9S@etsalapatis.com>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "ast@kernel.org"
 <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf: fix constant blinding bypass for
 PROBE_MEM32 stores
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "CyFun" <xcyfun@protonmail.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <ymj6l4pBrhKjzHeR2XYjQcvWswW_741UgkR05M3iYsrzxzhD-3AfAZ1rNJ5k1b6ex0tosQAorJP38DfNDkyqbhkY-DD6RW_qTfuJ0z86psE=@protonmail.com>
In-Reply-To: <ymj6l4pBrhKjzHeR2XYjQcvWswW_741UgkR05M3iYsrzxzhD-3AfAZ1rNJ5k1b6ex0tosQAorJP38DfNDkyqbhkY-DD6RW_qTfuJ0z86psE=@protonmail.com>

On Fri Mar 6, 2026 at 4:03 AM EST, CyFun wrote:
> To: bpf@vger.kernel.org
> Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org, netdev@vger.=
kernel.org
> Subject: [PATCH bpf v2] bpf: fix constant blinding bypass for PROBE_MEM32=
 stores
>
> BPF_ST | BPF_PROBE_MEM32 immediate stores are not handled by
> bpf_jit_blind_insn(), allowing user-controlled 32-bit immediates to
> survive unblinded into JIT-compiled native code when bpf_jit_harden >=3D =
1.
>
> The root cause is that convert_ctx_accesses() rewrites BPF_ST|BPF_MEM
> to BPF_ST|BPF_PROBE_MEM32 for arena pointer stores during verification,
> before bpf_jit_blind_constants() runs during JIT compilation. The
> blinding switch only matches BPF_ST|BPF_MEM (mode 0x60), not
> BPF_ST|BPF_PROBE_MEM32 (mode 0xa0). The instruction falls through
> unblinded.
>
> Add BPF_ST|BPF_PROBE_MEM32 cases to bpf_jit_blind_insn() alongside the
> existing BPF_ST|BPF_MEM cases. The blinding transformation is identical:
> load the blinded immediate into BPF_REG_AX via mov+xor, then convert
> the immediate store to a register store (BPF_STX).
>
> The rewritten STX instruction must preserve the BPF_PROBE_MEM32 mode so
> the architecture JIT emits the correct arena addressing (R12-based on
> x86-64). Cannot use the BPF_STX_MEM() macro here because it hardcodes
> BPF_MEM mode; construct the instruction directly instead.
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Though:

> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the v=
erifier.")
> Signed-off-by: s4ch <xcyfun@protonmail.com>

IIRC pseudonyms are not allowed on the SOB line so you will probably have t=
o update it.

> ---
> v2: Rebased onto current bpf tree (commit 56145d237385).
>     v1 had a malformed diff header that caused CI to reject it.
> ---
>  kernel/bpf/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3ece2da55..bb2fa75de 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1422,6 +1422,24 @@ static int bpf_jit_blind_insn(const struct bpf_ins=
n *from,
>  		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
>  		*to++ =3D BPF_STX_MEM(from->code, from->dst_reg, BPF_REG_AX, from->off=
);
>  		break;
> +
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
> +		*to++ =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^
> +				      from->imm);
> +		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
> +		/* Cannot use BPF_STX_MEM() here: it hardcodes BPF_MEM
> +		 * mode which would lose BPF_PROBE_MEM32 and break the
> +		 * arena addressing in the architecture JIT. */
> +		*to++ =3D (struct bpf_insn) {
> +			.code  =3D BPF_STX | BPF_PROBE_MEM32 | BPF_SIZE(from->code),
> +			.dst_reg =3D from->dst_reg,
> +			.src_reg =3D BPF_REG_AX,
> +			.off   =3D from->off,
> +		};
> +		break;
>  	}
>  out:
>  	return to - to_buff;
> --
> 2.53.0

