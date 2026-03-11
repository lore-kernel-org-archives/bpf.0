Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09982331A5B
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259055; cv=pass; b=mpoPXo5sVFYQZPOktKyed6eMgVvAgZ5cqe53WLkBxOM3aODagULdnsRZYPlkUcHxengFwDQGsYZ8giFtufMZLwhjoLfVd2nUbryP3SleXUyVI5XnkN0YVlSRV8pD+9S59WVXRk4v0VQqWawRaJoNdPuiY6gVQpul56BfNBNdoGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259055; c=relaxed/simple;
	bh=VxAHg9nrQcdrhsCmwfwi8cNr43nanoGoDRe2zhAByuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXOetjvVBO6qwfsZMsM58FHqQzMKumQkZ3tRkE7DzIZA8rc7yd2PCYU8PpVREcfzj07t97zaQ+9ohLWN19RefEBNRPmEf/ItmdxoTi8aEQpZXL+LJQRT4RnrJuHzQ2GeZxtU2HJfyMPF0V76x131SA2YaMlFLfSp81VeMWkfXGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSpqNGqY; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSpqNGqY"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35990245493so123380a91.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773259053; cv=none;
        d=google.com; s=arc-20240605;
        b=EpdJOOTFJRD6zP9325J1wYfOEg4qEpOmusAs7bF8IaXvTD92nSCVqSJtJ05mAjLJcH
         GmZcjv0FaoDMcRVYJ8WCaf9/1ArO6ML9oDoz1YfRCFYadR9BzSdUXtI0UKH7Lz2PjUCR
         x33vxt5QPH4AgGXA1LVJWDGsSeugbdUVuIVIeHe4rEJs+ZQAdrxdftFx0hnNWG58df9L
         mJ1AzS/99Jx49Ubnff71GW2rWReTB2+yFis7Ati62Jt7/AkpsqPPGjl0J+p+HMM02skh
         BjUCL1kd3BGUK2ATXhmnxUiyrKXoIRkI/EHOS77IyRh9OTzyfgl5HelK7BLE/U8GZut+
         KW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRgmDejJFWe/QqryxfaYjr8wy+YiV6XFgquy3LZyckg=;
        fh=HFezYODqB0dHS8ZckTal1iiWnuisbLhk4gui7Bi0T/g=;
        b=W1Lynqgqjbk8vV7zERSk3it9XPkohE+7C1p5vQaCBLXUW19vMT6iRd3OD0Ov/TVapX
         o0Ojf7Sw/oYBsVal7aHiqp+Vgw4HdEpSb0Du7vAGaIuNHRpQeBAAxhVoMCz2AjyMDmbl
         jnKiyzHceUlP3OHfH5DfwhPYKQXt48pdBAHDkzIzKeMMZZwu9/mmp2YDgr33DW5esRC9
         pr8bc/xEhyu5ASyzN/gBpvKp/5eEsUUJCs6mj2INi0SSLRbDQtw9ivXTJEKxgkCeyLSJ
         FjnnHiH2qnRcuXUhrwpSYZJ25DD6oT2wvz4Z2IkoZJ9P4LuCOXnh5abmYXhgv/nwP//G
         3zZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773259053; x=1773863853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRgmDejJFWe/QqryxfaYjr8wy+YiV6XFgquy3LZyckg=;
        b=FSpqNGqYpZqoNQm1VgY+xFcS25k7FBfcFOFYB4TU1zuZ3pe7a/ln/eqmSGAgTHAE+L
         BPm4kBmqGcHiPLI8UubX7sWeJjLKL9Z3RrGOrCOU5TKJD0nusybE/84s8dfOI8Sc50BK
         gITTPf2BneCfBA2+wYGgWPp6H8Udl33hPOTg9WdnaB96L5zFXwTfkpcMq3UK8kB00TrO
         s/SW5rsTYFzNuyK9kj0UyqUzAcnXGqvIIRXLIBS1X/f5QnLKH02Ne1ejtJ/2iElMjQn6
         TN73kUEhbqgBo0Qa+6trYkZXvdxt7uSc6HcJQrzkERECzCm7nsx837bnK2A0ShZPrU9n
         wZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773259053; x=1773863853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oRgmDejJFWe/QqryxfaYjr8wy+YiV6XFgquy3LZyckg=;
        b=R/ENNxkETmcaR4+qHofb4knC/rrTawCD02+8KceLAtl1BCgE+Nf1zueROMKLuVYhWU
         56aySwBe2RL+VDQeHHTX/RN5yY0luWY2wKWn5UpqqB2JOdEF8EqWRvz78Gd/6Kqd4lZR
         qbKzQYKp/2zgR+mGDHK+b1VJQPxsEwmHfvhbxuzx5e+r6YxejUCuS6qmK78nCzzfWHLe
         mff4eYwQI7nwEa2L2sqBMkzMoL5fcQpWmizwz98XX/2LUuS81WUprvm9JTJLB1ZmSNYP
         8Fvb74R78mhOF8Kee1YuUNq0SObIzZeOeLHyh3UGEtW8OyN8mvfVTncQ0MaYz7gATNAC
         f7DA==
X-Gm-Message-State: AOJu0Yx/nmVoljUqvWj9cw28pJUPIRM9ZDsgrIh3aUx/QjCBPL6vhmcx
	nvIFVd5zqxMIlnVQZ+npzh6RcQGCZeYVhGn0s03Pgpq5u2Y4K+1igA4TL9HyyQJit/hPhFHRziG
	IBlTqhItMl6RGwQIBqXIWg56ZKOvO+g8=
X-Gm-Gg: ATEYQzxrRMBtZGgt/wYhIvoxdSKRX1K6w8m6xCryX2TFOVCORjP21D/h8Whd9zAJzW1
	8hNr/94BVZng6msKSFjo+rrjyUTM5rAEEZ0H/a20ONe0YdiwtCsJuuvPCokZR0fipG3Yy3LwjHz
	ityoa6nBSwQrgO8ehfkWEGCvC80iX1OO7P6++d3e/PgkbDdDLS/3lfsXEbSd1DP758MvRLkIUtW
	0qlxP7IK3WwXQ+6jdY+ckYNhF9Y7LUJZ0vBXlvItN3eAAEfl4FUFtD3zos/NAkbMm6wK+66a3Y3
	bhERR+U=
X-Received: by 2002:a17:90b:28c4:b0:359:88c5:3add with SMTP id
 98e67ed59e1d1-35a012d38d7mr3576801a91.19.1773259053399; Wed, 11 Mar 2026
 12:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-4-ameryhung@gmail.com>
In-Reply-To: <20260307064439.3247440-4-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 12:57:20 -0700
X-Gm-Features: AaiRm52sIzb6_KbNecTpcE1qg84yxz2Vs0xSrZqMGjFP97M4P8XSEmbhRfLl42I
Message-ID: <CAEf4BzaRJ4hgMZY04=B0nnAE=MjyD4FN2L867vGCbornshOXDw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the verifier
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Simplify dynptr checking for helper and kfunc by unifying it. Remember
> initialized dynptr in process_dynptr_func() so that we can easily
> retrieve the information for verification later.

it would help to call out why all those checks you are removing are
not needed anymore

>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 179 +++++++++---------------------------------
>  1 file changed, 36 insertions(+), 143 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0f77c4c5b510..d52780962adb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -277,8 +277,15 @@ struct bpf_map_desc {
>         int uid;
>  };
>
> +struct bpf_dynptr_desc {
> +       enum bpf_dynptr_type type;
> +       u32 id;
> +       u32 ref_obj_id;
> +};
> +
>  struct bpf_call_arg_meta {
>         struct bpf_map_desc map;
> +       struct bpf_dynptr_desc initialized_dynptr;

nit: let's drop "initialized_" prefix? so verbose

[...]

> @@ -511,11 +513,6 @@ static bool is_ptr_cast_function(enum bpf_func_id fu=
nc_id)
>                 func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
>  }
>
> -static bool is_dynptr_ref_function(enum bpf_func_id func_id)
> -{
> -       return func_id =3D=3D BPF_FUNC_dynptr_data;
> -}
> -
>  static bool is_sync_callback_calling_kfunc(u32 btf_id);
>  static bool is_async_callback_calling_kfunc(u32 btf_id);
>  static bool is_callback_calling_kfunc(u32 btf_id);
> @@ -597,8 +594,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_func=
_id func_id,
>                 ref_obj_uses++;
>         if (is_acquire_function(func_id, map))
>                 ref_obj_uses++;
> -       if (is_dynptr_ref_function(func_id))
> -               ref_obj_uses++;

e.g., why this is fine? (because we don't use ref_obj_id for tracking
dynptrs anymore, right? would be good to call this out in the commit
message)

>
>         return ref_obj_uses > 1;
>  }

[...]

> @@ -13559,22 +13464,10 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>                                 }
>                         }
>
> -                       ret =3D process_dynptr_func(env, regno, insn_idx,=
 dynptr_arg_type, clone_ref_obj_id);
> +                       ret =3D process_dynptr_func(env, regno, insn_idx,=
 dynptr_arg_type, clone_ref_obj_id,
> +                                                 &meta->initialized_dynp=
tr);
>                         if (ret < 0)
>                                 return ret;
> -
> -                       if (!(dynptr_arg_type & MEM_UNINIT)) {

I can't fully connect MEM_UNINIT and CONST_PTR_TO_DYNPTR, this is
something that should be called out in commit message, IMO

> -                               int id =3D dynptr_id(env, reg);
> -
> -                               if (id < 0) {
> -                                       verifier_bug(env, "failed to obta=
in dynptr id");
> -                                       return id;
> -                               }
> -                               meta->initialized_dynptr.id =3D id;
> -                               meta->initialized_dynptr.type =3D dynptr_=
get_type(env, reg);
> -                               meta->initialized_dynptr.ref_obj_id =3D d=
ynptr_ref_obj_id(env, reg);
> -                       }
> -
>                         break;
>                 }
>                 case KF_ARG_PTR_TO_ITER:
> --
> 2.47.3
>
