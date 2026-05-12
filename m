Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41E25228C
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552922; cv=none; b=UcBTbP9ZRq2up9QhJ006vJJz/wc+6loofR4JuVDZk3e/d2JNitplYreMQYbwBwmLQ5qwdrFLpO1e+Bx4KdZoP6UgkkclWoEiTO1LOC8nb/aVgdzqflhSbP3goOkl3hyRUBU2jCVusXKgXLgK1Um9aL7s5mnQHJ6QLieNW1wM25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552922; c=relaxed/simple;
	bh=yvgC1FnjjoMtlutF/hjAmwuqu5sE1LUXUBLSbX5eXkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHThICQQTwfwgSUEOJkyh2m8/AIh3xG6mL9l2flW/29OrAb9To5I/Bp89W7sswlUhexJA2MaLgaD1s/VpvWtG3klEwundLHch4Hpz1py3kYqmgF8olcjefZmv4n6OJD50MI95bZL+kqIEYqkZ/wns2VBP8zqiuhPh00U+0kuQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7qb5utl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7qb5utl"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so2197742a91.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 19:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778552920; x=1779157720; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ayM4rO9yjDKyVwkABXp8ERuvhdOetbMp4rrjg9pQj5Q=;
        b=H7qb5utlWifk5YEe2BGAFpDccoG0/tibAgSeQ+46KkY7IZdmUIOUOKnbKrHxiJi+FE
         75up96vnsVsC7rU52/xfNRnreJLftdLIeNRZVftNVgOvKiTaQltPUfrherSpie7LcENZ
         MvLI8V+zv8kaRTVBA15SHctwNptNJQx7IIHxIFPaTn3KlJL1prpT5nO4NmAYsA1+JdYY
         5o0z/kRKcznOXWYXbBLxw7yB0RBPOy8rHYo1rI2CSeNWkb7BMs0LVR1g0XHUIu1QLrNC
         UeQ03S/7TdxfeMnfY0zPXnbA98MrYDw8LcwgD9Mw1+ltOe/hb+kn7lEekS9s+rTtaHnZ
         JcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778552920; x=1779157720;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ayM4rO9yjDKyVwkABXp8ERuvhdOetbMp4rrjg9pQj5Q=;
        b=k+uFGRw6k27NOxMnPge0AJBWglTnfZm9K/rJuFDL480nV259tFSGKovQVoQL/5RzTN
         rLj8XXqUZGZhtefIqPZEvgfZal0kJ4YSUC5p7VdaJg+B/20phBgJ5W4YSCAi3wWCRwI8
         YYfbeFfYT9r8XXRWMP9kpAC1atFHu2ejFtNwFvO9FjaBCazv1WVuz61JBVCAJJ9hI4oH
         1SFJC8dEsK57JPzYEKBqC0s1SRBiQp+bWRFxHDHDS0gZsT9EUjLAWIfheNLK8p/SBfhp
         2KsbrLNqs1U4BoQ+PBsJ4aK2fQfObn5R0/n1OlvdugjpbD691Hpxy9ctpaLhL41udS28
         WHtA==
X-Forwarded-Encrypted: i=1; AFNElJ/kJPJnPYB8QMx8eug/6Bw+Te5wjWjA/lIXe1jwNTv8V9l5pZRW3DJk0e22d41Mh0rWF3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHfRdZ+SPgKjhb1nGDkBw6Ilg3LEQFWPd1HRmZ/WwV3iRyihe
	0ZmGBwFq1eVvyo6AUYhZLrT5J58w6QmPvpRuGqHVpzpWfRqJvHIaeLK6
X-Gm-Gg: Acq92OGOGSY3uHhTz99BdZCU4MDC7f2OabOnV2wAVcGpuoqEbQwwWoR4mSShToQcJdr
	fe7oAqoWqaOvb8i9t9pJ0S91Sl8xfLxo7vquXxMkAthRGEcQzV7WVUtk27bGjVDTjwMypC3aWnv
	TBMcLtZ6ctIYoJqgwc4EwCOCUiMb4HAvVQX5Hh/DwnknxXn31T7UO3rlJY1BRrsknfoJg3JWqB/
	Hqd9ZK/YDz+dsvuYA6/uImhwPJfrwQTw2U5eua+awxRltAmgZs7Dgfdt0kRUquAnawhWj4YAZl8
	XZtrS/hlMHxAv3UlrKHtqH3p8CcsXXDVXvOfnOgG10KfhL8gQRfWCFqFnPDNS8z1376x13hA3aR
	GqoLomoITNXtKvZ1YvDMrnlVX1qL7FiTaDOQg/+qQWuMNhIegoFH+YH2GDycmrtcA3+M1uXRv+L
	RggfZBtSNHEJHwDQSwOdnlhR37zz+0CNYxAOmT9V6usu5xVfmSdXVm
X-Received: by 2002:a17:903:196d:b0:2b9:ecb4:a3dd with SMTP id d9443c01a7336-2bc7ac55031mr122095205ad.34.1778552919943;
        Mon, 11 May 2026 19:28:39 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e8df57sm120681275ad.64.2026.05.11.19.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:28:39 -0700 (PDT)
Message-ID: <ae5f8053bfc94fb02abdf78d5a452a7baae5c35e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 05/12] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Mon, 11 May 2026 19:28:06 -0700
In-Reply-To: <20260506142709.2298255-6-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-6-ameryhung@gmail.com>
Content-Type: multipart/mixed; boundary="=-Pv11CFF05eTOwbwEw9lY"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-Pv11CFF05eTOwbwEw9lY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:

[...]

> +/* Release id and objects referencing the id iteratively in a DFS manner=
 */
> +static int release_reference(struct bpf_verifier_env *env, int id)
> +{
> +	u32 mask =3D (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
>  	struct bpf_verifier_state *vstate =3D env->cur_state;
> +	struct bpf_idmap *idstack =3D &env->idmap_scratch;
> +	struct bpf_stack_state *stack;
>  	struct bpf_func_state *state;
>  	struct bpf_reg_state *reg;
> -	int err;
> +	int root_id =3D id, err;
> =20
> -	err =3D release_reference_nomark(vstate, ref_obj_id);
> -	if (err)
> -		return err;
> +	idstack->cnt =3D 0;
> +	idstack_push(idstack, id);
> =20
> -	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -		if (reg->ref_obj_id =3D=3D ref_obj_id)
> -			mark_reg_invalid(env, reg);
> -	}));
> +	if (find_reference_state(vstate, id))
> +		WARN_ON_ONCE(release_reference_nomark(vstate, id));
> +
> +	while ((id =3D idstack_pop(idstack))) {
> +		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
> +			int ref_obj_cnt =3D 1;
> +
> +			if (reg->id !=3D id && reg->parent_id !=3D id && reg->ref_obj_id !=3D=
 id)
> +				continue;
> +
> +			/*
> +			 * A referenced dynptr can be overwritten only if there is at
> +			 * least one other dynptr sharing the same ref_obj_id,
> +			 * ensuring the reference can still be properly released.
> +			 */
> +			if (stack && stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_DYNPTR &=
&
> +			    dynptr_type_referenced(reg->dynptr.type))
> +				ref_obj_cnt =3D dynptr_get_refcnt(state, reg->ref_obj_id);

Note that dynptr_get_refcnt() only looks for objects in the state's frame,
dynptrs in other frames are ignored. This can lead to false rejections,
as in the attached test cases, which verifier refuses to load with the
following error message:

; *(volatile __u8 *)&clone =3D 0; @ dynptr_fail.c:2160
19: (73) *(u8 *)(r10 -16) =3D r1
Leaking reference id=3D2 alloc_insn=3D7. Release it first.
processed 14 insns (limit 1000000) max_states_per_insn 1 total_states 1 pea=
k_states 1 mark_read 0

> +
> +			if (reg->ref_obj_id && reg->ref_obj_id !=3D root_id && ref_obj_cnt <=
=3D 1) {
> +				struct bpf_reference_state *ref_state;
> +
> +				ref_state =3D find_reference_state(env->cur_state, reg->ref_obj_id);
> +				verbose(env, "Leaking reference id=3D%d alloc_insn=3D%d. Release it =
first.\n",
> +					ref_state->id, ref_state->insn_idx);
> +				return -EINVAL;
> +			}
> +
> +			/* Free objects derived from the current object */
> +			if (reg->id !=3D id) {
> +				err =3D idstack_push(idstack, reg->id);
> +				if (err)
> +					return err;
> +			}
> +
> +			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL)
> +				mark_reg_invalid(env, reg);
> +			else if (stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_DYNPTR)
> +				invalidate_dynptr(env, stack);
> +		}));
> +	}
> =20
>  	return 0;
>  }

[...]

--=-Pv11CFF05eTOwbwEw9lY
Content-Disposition: attachment; filename="false-positivie-test.patch"
Content-Type: text/x-patch; name="false-positivie-test.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy9keW5wdHJfZmFp
bC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL2R5bnB0cl9mYWlsLmMKaW5k
ZXggMzE5NjIyMzNiZWExLi5lMzA4YjA0MDk1MzAgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9ncy9keW5wdHJfZmFpbC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9wcm9ncy9keW5wdHJfZmFpbC5jCkBAIC0yMTUwLDMgKzIxNTAsMzMgQEAgaW50
IGR5bnB0cl9vdmVyd3JpdGVfcmVmX2Nsb25lX3NsaWNlX3ZhbGlkKHZvaWQgKmN0eCkKIAogCXJl
dHVybiAwOwogfQorCitzdGF0aWMgX19ub2lubGluZSB2b2lkIG92ZXJ3cml0ZV9jbG9uZV9pbl9j
YWxsZWUoc3RydWN0IGJwZl9keW5wdHIgKnBhcmVudCkKK3sKKwlzdHJ1Y3QgYnBmX2R5bnB0ciBj
bG9uZTsKKworCWJwZl9keW5wdHJfY2xvbmUocGFyZW50LCAmY2xvbmUpOworCS8qIE92ZXJ3cml0
ZSB0aGUgY2xvbmUgLSBwYXJlbnQgaW4gY2FsbGVyIGZyYW1lIHN0aWxsIGhvbGRzIHRoZSByZWYg
Ki8KKwkqKHZvbGF0aWxlIF9fdTggKikmY2xvbmUgPSAwOworfQorCisvKgorICogT3ZlcndyaXRp
bmcgYSBjbG9uZSBpbiBhIGNhbGxlZSBmcmFtZSBzaG91bGQgYmUgYWxsb3dlZCB3aGVuIHRoZSBw
YXJlbnQKKyAqIGluIHRoZSBjYWxsZXIgZnJhbWUgc3RpbGwgaG9sZHMgdGhlIHJlZi4gZHlucHRy
X2dldF9yZWZjbnQoKSBjdXJyZW50bHkKKyAqIG9ubHkgY291bnRzIGR5bnB0cnMgaW4gdGhlIGN1
cnJlbnQgZnJhbWUsIG1pc3NpbmcgdGhlIHBhcmVudCBpbiB0aGUKKyAqIGNhbGxlciBmcmFtZS4K
KyAqLworU0VDKCI/cmF3X3RwIikKK19fc3VjY2VzcworaW50IGR5bnB0cl9vdmVyd3JpdGVfY2xv
bmVfY3Jvc3NfZnJhbWUodm9pZCAqY3R4KQoreworCXN0cnVjdCBicGZfZHlucHRyIHB0cjsKKwor
CWJwZl9yaW5nYnVmX3Jlc2VydmVfZHlucHRyKCZyaW5nYnVmLCA2NCwgMCwgJnB0cik7CisKKwlv
dmVyd3JpdGVfY2xvbmVfaW5fY2FsbGVlKCZwdHIpOworCisJYnBmX3JpbmdidWZfZGlzY2FyZF9k
eW5wdHIoJnB0ciwgMCk7CisKKwlyZXR1cm4gMDsKK30K


--=-Pv11CFF05eTOwbwEw9lY--
