Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2198B35B64B
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639998; cv=none; b=QEiCfpUj/IFxME0yW99wKwrq0AGO0ejcNS1uMx2oU+mu07azqlE7Z94HkREQ/qeiIP6hJBnYIkyTXJwcb+xl1OCChVjcMscg2IYeuJi77sMWVgzCUA+u2QAcGTjybG6h0AzQJeksNa8iV6+TiQcitTbvUT2f3f4nNjfxuHvK1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639998; c=relaxed/simple;
	bh=DR72l5rfmF9woJgiiQ+SUs1tFCC5L4Em4zqGl0Tn244=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3mzCv/7Fe8D7olYt05CeNlJt6iaHj+90VcwIWM32kQBuyW3EnvKTPNa6vC9Zdf2V/Bm/Y37yI8cMlvHCjQvL7TqvRFtuo2XTOb1iPHhLgr9VIvtuBlLN8MIUX+bvYTvbbAl8Syx1AkVRdgFEVKndrF4QE7rhLqG+7WdG0wUTOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9JBwHVl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9JBwHVl"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829756f3ee9so621802b3a.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772639996; x=1773244796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkeTvPf0E8KU750qZQOM/g+J3nMAURhvhN+ETGDpHsM=;
        b=Y9JBwHVlonc4R/ur4Tv8GErnNM95ue3EbkXwkbjDEtRfO39TlGxRB7xeJMGoBjCYuK
         PsHqhht6FMzOEuxsY6ilPBCbWySDWQmhGcy8nloopD0r/50J74MaEYJkjFfcNBBELgK8
         216FYfUcAxM+Lg5SMSroArDf0+W1Qn84sZkkCYvGJu5z9/UO/bOL16/jYGWhKxdrGueP
         dYHthiJPgFuxr6xe7GZ28wo5bJVHvuIOS+n0ITPxlT2ePHIUx8qe1QSO7HCVzEYDnp+U
         i5h+5cMvn9XHPobayo9K32gny9m2YOX1jLbSGY0gOa6mrPzNl3c8J3Kz5qemvKVwLBn2
         492w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639996; x=1773244796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkeTvPf0E8KU750qZQOM/g+J3nMAURhvhN+ETGDpHsM=;
        b=nblqKoH0vYvyCF3JFVZJtIF/CZHb89bSpjfCeS3+9DETTMGbR6+7XR1B/brUAQLOSx
         dFDMArovJq+S36ScYWyI4kq+KUxwUeSTJQtUEWTFbETHozPhFviMasqoRhGxinxbz/ti
         X2RPmuFZWkEaknFM6K7UxjxhxQiTNrLETYwNtcRi6G6b9bvsqZ/EY0HUc2hLlbLGealm
         Sj28viphi9xTwR3IU51PJ4o2rXYpnIIJJSRDWs2oPQT5pa7VWqdHn/YJjkQi2a84iILF
         Tki3VhFpGlXvESLMaiDJj5omfFLIXDZ2wzdcE6LGWQLfNmObWVq/H42tqZzLUo+K+r31
         p7zw==
X-Gm-Message-State: AOJu0Yy9npBjgTeEgE07+rscmZWVXIfdBCAj3AL1RzsPtm/Xy8HLOHvU
	xmY+OdMrN0NrxABxHUO7F4Ns8HJ+EJjVdamDjYS32f8CRe8v1xnVR8b8
X-Gm-Gg: ATEYQzyB6PjIwlXYSXsrBqhg1il/W1D+u/1NMLVr/rdWeSvdLDea1x/afMX6ivDUvkT
	bCyQ6c15ZdVCBm2z83nraNBaYfeI1HvwVsb5N8HEp+QsFvWQisEVuEgevhcGX0Lx2+ueNUMclw1
	XVKIcSdLcFeImI6ck0RlaSisMgf4rmDVVoYiQQ/eum9nmdjTXyK6e/LrjDeRUByMtMDhRSvdhce
	ES7x19TAZTZoE4qS35WvXiKlYkfgZqXQ+dh61HEQSIlcFo38uOpsyVLKbStNM5jtvtjqOAvpYY1
	luVDSQuDnWFUmm5Fe/vgMI4x0XxRo9CYKOx6jl1ITDvkcx4GeQW+oGHWeQ+1CtMI9CP8MheSVjg
	5mXmjPMigncDQafbEGQnyU86e8TwLUV8WaCiDY6GwWMVVgpHi9JCy6G/oBW07cZ8K4AEE9ReWL7
	cX8m6Nkjtsjo2T/NEhk55RmyaY0O/ApyqaFdaZ
X-Received: by 2002:a05:6a21:7a96:b0:38b:e3c1:db44 with SMTP id adf61e73a8af0-3982e23b3e7mr2314723637.58.1772639996403;
        Wed, 04 Mar 2026 07:59:56 -0800 (PST)
Received: from [172.20.10.5] ([117.20.154.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73818d9502sm1352139a12.21.2026.03.04.07.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 07:59:55 -0800 (PST)
Message-ID: <927c59b1-acae-4013-b552-2d03cc77562b@gmail.com>
Date: Wed, 4 Mar 2026 23:59:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] bpf/verifier: refactor kfunc checks to
 table-driven approach
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304143459.78059-1-pilgrimtao@gmail.com>
 <20260304143459.78059-6-pilgrimtao@gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20260304143459.78059-6-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

NIT on the subject prefix: instead of bpf/verifier, it should be one of
bpf, libbpf, selftests/bpf, bpftool, and "bpf, x86/arm64".

So, the subject can be "bpf: refactor kfunc checks using table-driven
approach in verifier".

Thanks,
Leon

On 2026/3/4 22:34, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> Replace per-kfunc btf_id chains in list/rbtree/res_lock and graph node
> checks with btf_id_in_kfunc_table() and static kfunc tables for easier
> maintenance.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/verifier.c | 93 +++++++++++++++++++++++++++++--------------
>  1 file changed, 64 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d133d18aa0cc..25961cf83a67 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12600,6 +12600,60 @@ BTF_ID(func, bpf_session_is_return)
>  BTF_ID(func, bpf_stream_vprintk)
>  BTF_ID(func, bpf_stream_print_stack)
>  
> +static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
> +	KF_bpf_list_push_front_impl,
> +	KF_bpf_list_push_back_impl,
> +	KF_bpf_list_pop_front,
> +	KF_bpf_list_pop_back,
> +	KF_bpf_list_del,
> +	KF_bpf_list_front,
> +	KF_bpf_list_back,
> +	KF_bpf_list_add_impl,
> +	KF_bpf_list_node_is_edge,
> +	KF_bpf_list_empty,
> +};
> +
> +/* Kfuncs that take a list node argument (bpf_list_node *). */
> +static const enum special_kfunc_type bpf_list_node_api_kfuncs[] = {
> +	KF_bpf_list_push_front_impl,
> +	KF_bpf_list_push_back_impl,
> +	KF_bpf_list_del,
> +	KF_bpf_list_add_impl,
> +	KF_bpf_list_node_is_edge,
> +};
> +
> +/* Kfuncs that take an rbtree node argument (bpf_rb_node *). */
> +static const enum special_kfunc_type bpf_rbtree_node_api_kfuncs[] = {
> +	KF_bpf_rbtree_remove,
> +	KF_bpf_rbtree_add_impl,
> +	KF_bpf_rbtree_left,
> +	KF_bpf_rbtree_right,
> +};
> +
> +static const enum special_kfunc_type bpf_rbtree_api_kfuncs[] = {
> +	KF_bpf_rbtree_add_impl,
> +	KF_bpf_rbtree_remove,
> +	KF_bpf_rbtree_first,
> +	KF_bpf_rbtree_root,
> +	KF_bpf_rbtree_left,
> +	KF_bpf_rbtree_right,
> +};
> +
> +static const enum special_kfunc_type bpf_res_spin_lock_kfuncs[] = {
> +	KF_bpf_res_spin_lock,
> +	KF_bpf_res_spin_unlock,
> +	KF_bpf_res_spin_lock_irqsave,
> +	KF_bpf_res_spin_unlock_irqrestore,
> +};
> +
> +static bool btf_id_in_kfunc_table(u32 btf_id, const enum special_kfunc_type *kfuncs, int n)
> +{
> +	for (int i = 0; i < n; i++)
> +		if (btf_id == special_kfunc_list[kfuncs[i]])
> +			return true;
> +	return false;
> +}
> +
>  static bool is_task_work_add_kfunc(u32 func_id)
>  {
>  	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
> @@ -13000,26 +13054,14 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
>  
>  static bool is_bpf_list_api_kfunc(u32 btf_id)
>  {
> -	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_node_is_edge] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_empty];
> +	return btf_id_in_kfunc_table(btf_id, bpf_list_api_kfuncs,
> +				     ARRAY_SIZE(bpf_list_api_kfuncs));
>  }
>  
>  static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
>  {
> -	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
> -	       btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> -	       btf_id == special_kfunc_list[KF_bpf_rbtree_first] ||
> -	       btf_id == special_kfunc_list[KF_bpf_rbtree_root] ||
> -	       btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
> -	       btf_id == special_kfunc_list[KF_bpf_rbtree_right];
> +	return btf_id_in_kfunc_table(btf_id, bpf_rbtree_api_kfuncs,
> +				     ARRAY_SIZE(bpf_rbtree_api_kfuncs));
>  }
>  
>  static bool is_bpf_iter_num_api_kfunc(u32 btf_id)
> @@ -13037,10 +13079,8 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
>  
>  static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
>  {
> -	return btf_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
> -	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock] ||
> -	       btf_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
> -	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore];
> +	return btf_id_in_kfunc_table(btf_id, bpf_res_spin_lock_kfuncs,
> +				    ARRAY_SIZE(bpf_res_spin_lock_kfuncs));
>  }
>  
>  static bool is_bpf_arena_kfunc(u32 btf_id)
> @@ -13129,17 +13169,12 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>  
>  	switch (node_field_type) {
>  	case BPF_LIST_NODE:
> -		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_node_is_edge]);
> +		ret = btf_id_in_kfunc_table(kfunc_btf_id, bpf_list_node_api_kfuncs,
> +					    ARRAY_SIZE(bpf_list_node_api_kfuncs));
>  		break;
>  	case BPF_RB_NODE:
> -		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_right]);
> +		ret = btf_id_in_kfunc_table(kfunc_btf_id, bpf_rbtree_node_api_kfuncs,
> +					    ARRAY_SIZE(bpf_rbtree_node_api_kfuncs));
>  		break;
>  	default:
>  		verbose(env, "verifier internal error: unexpected graph node argument type %s\n",

