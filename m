Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB46377AA0
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054932; cv=none; b=bUCKj+oK8E3esgyW0CET3OX27K83VsU6cspFZjfcq+42xSCkW7Oqkdr7Y3gEnooT+JN8pImcFAiVVweVy0Lt2qTwiPCoRFNo41RLSO8UbE+wiwL0AGcm33zeLFpZBjG9KGfawlXaj6RTkYt4ov+jD4a8rLvMNd3isDW0WVxwxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054932; c=relaxed/simple;
	bh=aphYMmiYNr1JeIPA8T50mwkLquMt+pfKAidWzhIQaWc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cck9F8bne1ot0yJyG59A3Vmcx1REn0qCV5gVNcAbHIIgjmnqUrv9Ko1A96Rb7CijExt9noWa/frtaTeuaTpOqv6Vdv4s3ZVuJxBTkY6kRGjOIxm+ttktdvgznxWIQ8WukTBvLFmDT5hf68daptZnl48SrEKWsXw6OTwTG37bZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOS9UqGW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOS9UqGW"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c95d0a54ea5so3359796a12.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784054927; x=1784659727; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DmCrz+++FMRpOB+di1aYQDQQrE92WmtTbq/JiOrgj7c=;
        b=SOS9UqGWAD6hYraVY7yLlXHCKBt+xZY9QHa64+9QeEjKJISWbr9SH7dO5aOftpeld0
         zBM7stdIWaD5XbGbf252JcvlCH9gI7EXfqXTHYmZ3TNgBTKdQSoCBa9gvzSgeRzFLWTl
         +zft1a2qq+AqwpTRXYokzRBdneJ+KYyAOdiGpNBnVs0m4ISX9j3TYLL5+tmKeCj18vSg
         MQ6VlUGaghhOcS/odOKrKZB4js9sDi5PjI41I1FluwM8LIypmCJLiTDhCU5khoTPtv2h
         suDt04Kc54yQgFhVLvL78tOrYegQfOxcHLLN4htowh4a+3vn6Z6gwRBSW4q2aKDatbpM
         NTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054927; x=1784659727;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DmCrz+++FMRpOB+di1aYQDQQrE92WmtTbq/JiOrgj7c=;
        b=S1LwqJ6iQqqcka05/lznalGXzW5VFJXuVoN3gGbwSnwK7KhUJED58vmD2Chdo4AF2Y
         /ZTdRewqv3bHMYBTYsISjycXWP5wA6Qf87QgegrrcdQo5isba9aRhHL9D8ck3EAQgh7f
         1+CT/iUb6yjBYKWLTNUFBIayzvjxoUWfeSWY+Al7+53b8yqxrfepTUW1bgwDfBlAuSr8
         P+GIce5yBlwi83lLmZIZNVvdbGXOiqxU6qucQGI2IWubq3sP134roPukba8mu33/7+U8
         CtCpzh2KgMmTSNk/i03yipGQStIjU6Jx3GtdzdVl1i3azBWgcx2P4BerFoKMgHEVziUL
         4Wkg==
X-Forwarded-Encrypted: i=1; AHgh+RqabLReU/Ssd5pqWzsdY2V9ZF11B4d01SmpcplAoJofEb+LZVxDpcvmJhVH/iFEaYTR+dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRCZAa0CjzmOmdhO1N4uj37z2gzwscX2/ese8J5ejnbTbwFSt
	b6RjkFGp/JjXXhGWQyHLDWXRN/kQSmy5YH9gSQydsLX3xTaRL8e+GA6wXdpw6W5n
X-Gm-Gg: AfdE7clyH6AzCKLNOPajkVU1TspXtu25dkZlFvMDoloZoeOd+yxZReLz43HWzNIrPtb
	cvzs1lwPbF1eF2aSUn7bntJIZnKPLgPJmzmeTRvQb/LHd5tows1OHhQxsuwu/uOkzSoNo4TlNqD
	Ux3EmC1iv+U0s7Z73pMWW8ruS3i2PHuWZAdEcRbSXdG6B2HIjOOpsjaORlHz39hD0s/eC5lyWzA
	QYr55MOx0wSSPLDkz1nO4zA5l5QqwC525o1wGDAZ0BLa5QgF09exHlU5/FlgCBem32MN9onwExp
	i9twvB6yha4eaXP/vgiSL8UXqwOvNCsGrXUWXVDU0/F2x4Wpt1fuHE4UEwKyLzxGRlnEtcdW+NU
	d83MIXe6Do7P5A1vxFh4HIt0ZUn6xdz8su9RHrDLkHdVkEXOuo0g7A8V8DNO90tGK2IvhzY/UJ3
	nR9h3tgkfZd3RNWbcz9CKWm4tpFo1FXbNbEFAW+PJHET/KMWkBJcmFicywoUdTzFN0n7I=
X-Received: by 2002:a05:6a21:8884:b0:3c3:68a5:50b3 with SMTP id adf61e73a8af0-3c368a55207mr467413637.57.1784054927410;
        Tue, 14 Jul 2026 11:48:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:11d2:f935:a412:8fad? ([2620:10d:c090:500::972d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm56512564eec.25.2026.07.14.11.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:48:47 -0700 (PDT)
Message-ID: <08cc4cf4992b72088e59cd9aafe2bfa78d87f738.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/4] bpf: Unify helper and kfunc call
 argument meta
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Tue, 14 Jul 2026 11:48:45 -0700
In-Reply-To: <20260709230242.2003459-5-ameryhung@gmail.com>
References: <20260709230242.2003459-1-ameryhung@gmail.com>
	 <20260709230242.2003459-5-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-09 at 16:02 -0700, Amery Hung wrote:
> Helper and kfunc argument checking carried two separate meta structs: the
> verifier-local struct bpf_call_arg_meta and bpf_kfunc_call_arg_meta.
> Merge them into a single struct bpf_call_arg_meta. This is groundwork for
> sharing argument checking between helpers and kfuncs.
>=20
> While merging, drop the btf_id field from the helper meta since it is
> never used.
>=20
> No functional change.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  include/linux/bpf_verifier.h | 40 +++++++++------
>  kernel/bpf/cfg.c             |  2 +-
>  kernel/bpf/verifier.c        | 95 +++++++++++++++---------------------
>  3 files changed, 63 insertions(+), 74 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 3ed788ec6afc..5fbc3dfe5b19 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1479,18 +1479,24 @@ struct arg_alloc_mem_desc {
>  	bool found;
>  };
> =20
> -struct bpf_kfunc_call_arg_meta {
> -	/* In parameters */
> +struct bpf_call_arg_meta {
> +	/* Common */
>  	struct btf *btf;
>  	u32 func_id;
> -	u32 kfunc_flags;
> -	const struct btf_type *func_proto;
> -	const char *func_name;
> -	/* Out parameters */
>  	u8 release_regno;
> -	bool r0_rdonly;
>  	u32 ret_btf_id;
>  	u32 subprogno;
> +	struct bpf_map_desc map;
> +	struct bpf_dynptr_desc dynptr;
> +	struct ref_obj_desc ref_obj;
> +	struct arg_raw_mem_desc arg_raw_mem;
> +	struct arg_alloc_mem_desc arg_alloc_mem;
> +
> +	/* Only set by kfunc */
> +	bool r0_rdonly;
> +	u32 kfunc_flags;
> +	const struct btf_type *func_proto;
> +	const char *func_name;
>  	struct {
>  		u64 value;
>  		bool found;
> @@ -1521,29 +1527,31 @@ struct bpf_kfunc_call_arg_meta {
>  		u8 spi;
>  		u8 frameno;
>  	} iter;
> -	struct bpf_map_desc map;
> -	struct bpf_dynptr_desc dynptr;
> -	struct ref_obj_desc ref_obj;
> -	struct arg_raw_mem_desc arg_raw_mem;
> -	struct arg_alloc_mem_desc arg_alloc_mem;
> +
> +	/* Only set by helper */
> +	bool pkt_access;

It appears this one can be dropped altogether:

    diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
    index 5ccb00a8c84c..b1d5a359c78b 100644
    --- a/kernel/bpf/verifier.c
    +++ b/kernel/bpf/verifier.c
    @@ -4654,7 +4654,7 @@ static int check_map_access(struct bpf_verifier_e=
nv *env, struct bpf_reg_state *
     }

     static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
    -                              const struct bpf_call_arg_meta *meta,
    +                              const struct bpf_func_proto *fn,
                                   enum bpf_access_type t)
     {
            enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
    @@ -4678,8 +4678,8 @@ static bool may_access_direct_pkt_data(struct bpf=
_verifier_env *env,
            case BPF_PROG_TYPE_LWT_XMIT:
            case BPF_PROG_TYPE_SK_SKB:
            case BPF_PROG_TYPE_SK_MSG:
    -               if (meta)
    -                       return meta->pkt_access;
    +               if (fn)
    +                       return fn->pkt_access;

                    env->seen_direct_write =3D true;
                    return true;
    @@ -8307,7 +8307,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
            }

            if (type_is_pkt_pointer(type) &&
    -           !may_access_direct_pkt_data(env, meta, BPF_READ)) {
    +           !may_access_direct_pkt_data(env, fn, BPF_READ)) {
                    verbose(env, "helper access to the packet is not allowe=
d\n");
                    return -EACCES;
            }

> +	u64 msize_max_value;
> +	s64 const_map_key;
> +	struct btf *ret_btf;
> +	struct btf_field *kptr_field;
>  };

[...]
