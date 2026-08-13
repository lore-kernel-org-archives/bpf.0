Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C73EBF3B
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786650248; cv=none; b=fdSgkwTX0jIaHksGe8m6BMsfdSV3ETc1/9f209COfkrruNp1QNjHGgWEqIX2+e+A8CZoL/9ODPY8DVWuCatS36hmNDZcoluHFriS+aevjKiP+ot5qCkt/jRHziGKaOHknS6NYV6eKvsmVycSQwF/NtpZlerot1Jz9XniZVh9Oz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786650248; c=relaxed/simple;
	bh=u8wuJxT2Em7xjPpCtJAd3pmrPzPH3Y4EmnfYRE023FI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NcxOBpRNg3CzkZhWBmFrAn9bF6tjdHGumHPC+BdUQQfPob4sLXphI9Cy5dJhfff98YAHCKhvRIiYNc8wgwukZqOXUAZF+nqhLb41Gsdexw2cMAHePj3VF+LbKvOG3hw5emmSCueTYpt5OIwRHCptEA1kmZbL6Bk+rR9d/kX81m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oUZvQ/H4; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUZvQ/H4"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca12086c06eso177551a12.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786650246; x=1787255046; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fLNP5a1c2ClTV8DOXcZsLyeb1Z6bMnzz+TbBaAtJgfs=;
        b=oUZvQ/H4/pDWycscuqUKM3f5wlOMkqRUfhfCLgCyoMibxNqreSAODPjK7462MsKafS
         J7qFI6M38r2En5tXcBnodARISNS4UVScZylFH6I7ANmnru9KpPa9kBxy0sDv0E+cejJU
         gdYaLwdIaka2mKl5t24BsdQWSffyXSKmaemu+da20ZatGUjmxirTtGBof2DtZfQSRqWm
         slxMPQRUBynUnz/kOXQKE04Vf4IZ1L/h4AWcQ6yGmQoZOaaIuoBtV4en2AcOScW04gxV
         t5TSLXnHoBDSUbs8HJATYESoaQUol/FjoHdEPKA27qCc0NpubLpKHU+DPDALSQIzHKF6
         mBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786650246; x=1787255046;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLNP5a1c2ClTV8DOXcZsLyeb1Z6bMnzz+TbBaAtJgfs=;
        b=I1fQw/Hfoa4gvz4hya28UdO2gbTWszfh02MsznHY93AHnzGvE9a8R6f7S6QBkaPvVM
         AiRX7mH89QqP8msUk3VJ63ErHcWPxvHh/itI1GoY5FBBs82/M1AUB82O0Mg4PTDz4Ddt
         RSvrVddojiU/YJknVa+4WfaEAcgZ66eLkKoVKZHVWLoUFTnNFE+3OO+5XPGFusFKLKAP
         NTOsuARzBciPXwvX9tzCmYv7rMkmxWbzSbdkAsX6VcksDgl0qKI29klsGkLNdR8X3Rxb
         hXMWPsYykpQ7mH4e55cEybMq9Xxs5LUJww3QcTlM7JtzZHd2H2usbKbeSidisZ+RBfZH
         R4fQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMrBLCbOhsDDLa/2m7L07YaqH7XWHIOGjihgzD9J7ZuSWtHbvYN4yvnB25KyKUwksn5CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgRa3/mpkTlGMGpT6drAyntWbT4eRNAIihGw91oV9v6O0NuIR
	jU4ciag6O5R9x19XmJTtJgP9hPgHpIVmmH7w+aVQmcGMWD+4ipcOyAHN
X-Gm-Gg: AR+sD11n2Z4JcKc/FzVNMt3X4yPVCyDpz1UKK2bkRvtpn9veFSC2GTIfd3Md+mKL1cw
	TvoULuXKIQPPOOqGCPtK1rgrg2DC7JgnwQR93Y3PV18Kg1vg2UzdeqvbLZGTOoLCcKMfT5bVt+M
	B/kEdyiErElfnljgHie3g301jU7a9S4m8fcyzoTD5EiFM/kPEHOlm7mhaNanC/L2qO8VNdbvpcf
	0y1pAiF5FH4ONE3PbmNNQEmujsbqAjCT+SkNhBiffOVHKyXz+NcV0Kn3D6tgMmdH6Tu+IMUNjVr
	SaQgwRp0a2O0lT3cLlX+UeXZX16oTwi7LNvZILgncc0At7POBwwkGVrt02JFI//m23kcSExLckJ
	C5nbrBpn7FClfeX7Y39S8CAPwuAZLK3fWe//B6xeu0aWiDX65O71cyCYDw5j2QeNvbSjNRamAM7
	oeep55hz7ACPyt3KzKEu7xU6+L3HEmD7GCH/BQ2GFiKPUpCwpbSQghU3p1s4KvOK3BOeM22NMMM
	AX3XRxA30xXZmVGqq9umi7ZlbckzVCEg3zN/2268mKa+w==
X-Received: by 2002:a05:6a20:4321:b0:3c3:875d:c546 with SMTP id adf61e73a8af0-3cc71af3552mr157697637.7.1786650246007;
        Thu, 13 Aug 2026 12:44:06 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c5747sm1098097c88.5.2026.08.13.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:44:03 -0700 (PDT)
Message-ID: <c0a8a71dab13be1009080b4133069c7f55323af1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 05/16] bpf: Track verifier register
 diagnostic events
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 13 Aug 2026 12:44:01 -0700
In-Reply-To: <20260812233326.3575958-6-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
	 <20260812233326.3575958-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:

Claude ensures me that BPF_ATOMIC | BPF_FETCH lacks the mod_end() call
for when the stack memory is modified. Seem to be true.

...

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c

...

> @@ -30,15 +30,23 @@
>  #define BPF_DIAG_CONTEXT_CNT (1 + BPF_DIAG_CONTEXT * 2)
>  #define BPF_DIAG_SOURCE_LANE_WIDTH 88
>  #define BPF_DIAG_TAB_WIDTH 8
> -#define BPF_DIAG_REG_DESC_LEN 512
> -#define BPF_DIAG_REG_TMP_LEN 192

Churn

...

> @@ -49,6 +57,13 @@ struct bpf_diag_history_event {
>  		struct {
>  			bool cond_true;
>  		} branch;
> +		struct {
> +			struct bpf_diag_mod_target target;
> +			struct bpf_diag_mod_target origin;

Silly question, should we keep the 'src'/'dst' terminology here?
In order to be in line with instruction set.

> +			struct bpf_diag_reg_snapshot old, new;
> +			u8 reason;
> +			bool origin_valid;
> +		} mod;
>  	};
>  };

...

> @@ -375,6 +401,34 @@ static void diag_print_wrapped_prefixed(struct bpf_v=
erifier_env *env, const char
>  	}
>  }
> =20
> +static void bpf_diag_format_btf_type(char *buf, size_t size, const struc=
t btf *btf, u32 type_id)
> +{

Nit: single caller, might as well inline.

> +	size_t len;
> +	int ret;
> +
> +	buf[0] =3D '\0';
> +	ret =3D btf_type_snprintf_show_name(btf, type_id, buf, size);
> +	if (ret < 0 || !buf[0]) {
> +		scnprintf(buf, size, "BTF type ID %u", type_id);
> +		return;
> +	}
> +
> +	len =3D strlen(buf);
> +	if (len && buf[len - 1] =3D=3D '{')
> +		buf[len - 1] =3D '\0';
> +}
> +
> +const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const st=
ruct btf *btf, u32 type_id)
> +{
> +	char *buf =3D bpf_diag_fmt_buf(env, BPF_DIAG_FMT_BUF_SIZE);
> +
> +	if (!buf)
> +		return "";
> +
> +	bpf_diag_format_btf_type(buf, BPF_DIAG_FMT_BUF_SIZE, btf, type_id);
> +	return buf;
> +}

...

> +static bool diag_snapshot_eq(const struct bpf_diag_reg_snapshot *old,
> +			     const struct bpf_diag_reg_snapshot *new)
> +{

Nit: memcmp?

> +	return old->type =3D=3D new->type && old->map_ptr =3D=3D new->map_ptr &=
& old->btf =3D=3D new->btf &&
> +	       old->btf_id =3D=3D new->btf_id && old->var_off.value =3D=3D new-=
>var_off.value &&
> +	       old->var_off.mask =3D=3D new->var_off.mask && old->r64.base =3D=
=3D new->r64.base &&
> +	       old->r64.size =3D=3D new->r64.size;
> +}

...

> +static struct bpf_func_state *diag_func_state(struct bpf_verifier_env *e=
nv, u32 frameno)
> +{
> +	struct bpf_verifier_state *vstate =3D env->cur_state;
> +	int frame;
> +
> +	for (frame =3D 0; frame <=3D vstate->curframe; frame++) {
> +		if (vstate->frame[frame]->frameno =3D=3D frameno)
> +			return vstate->frame[frame];
> +	}

Isn't this just `return frameno <=3D vstate->curframe ? vstate->frame[frame=
no] : NULL`?

> +	return NULL;
> +}
> +

...

> diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h

...

--- 8< --------------------------------------

> +enum bpf_diag_mod_target_kind { ...
> +struct bpf_diag_mod_target { ...
> +static inline struct bpf_diag_mod_target bpf_diag_reg_target(u32 frameno=
, u8 regno) ...
> +static inline struct bpf_diag_mod_target bpf_diag_stack_arg_target(u32 f=
rameno, u8 slot) ...
> +static inline struct bpf_diag_mod_target bpf_diag_stack_slot_target(u32 =
frameno, u16 spi) ...
> +static inline struct bpf_diag_mod_target bpf_diag_stack_range_target(u32=
 frameno, s16 min_off, ...

-------------------------------------- >8 ---

Move this to diagnostics.c? (and drop prefixes).

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c

...

> @@ -8902,13 +8936,18 @@ static int check_func_proto(const struct bpf_func=
_proto *fn, struct bpf_call_arg
>   */
>  static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
>  {
> +	struct bpf_stack_state *stack;
>  	struct bpf_func_state *state;
>  	struct bpf_reg_state *reg;
> =20
> -	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
> -		if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))
> -			mark_reg_invalid(env, reg);
> -	}));
> +	bpf_for_each_reg_in_vstate_mask(
> +		env->cur_state, state, reg, stack, 1 << STACK_SPILL, ({
> +			if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) {
> +				bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_PKT_DATA_CHANGE);
> +				mark_reg_invalid(env, reg);
> +			}
> +		}))
> +		;
>  }

Nit: bpf_for_each_reg_in_vstate_mask conversion is not necessary.
