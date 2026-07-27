Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA303FD96B
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157560; cv=none; b=KJaowXbE8WICOLKHzaplrvCcMFMLVamhPNDY7HXx/fM0fWCURUY5ZYPkumjKFUEj6r97RwWq6m0Scxh0vMx6BLqs4dRTBN95vItSizhihGQn0IO742w65Vsqby/bpDgLmf2AFyiNrwPVBMkwnf72aPnZDHhUxa3SOZwDIbOn+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157560; c=relaxed/simple;
	bh=TnufA92Fej2Tt+A3Wq3pD4ndUp8TapRbyDldjrSwBUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRe1HgLZXpzt2ArNLB5P3JeNPGaE7411XvgedvXNDbmeO/WwiBt0MXeHDugs0lWtfxOCmrlLwmRSnamUvImZ0JxvaoYkS+mmO68cebiHNtGe5Z6ZSfIZy9TF7cDq+jEfcCoXf2VNU5D7O6n/mALdeEzkzmho8kK7Q0RfRhOqOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzLZyKI9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzLZyKI9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954aff6088so22752665e9.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785157557; x=1785762357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1B87TL/aZ8C8Z4evKf7/RY5o6bazqFyD/JIjo1HbK8=;
        b=MzLZyKI9aOBRYfYU7V5sCkWT86JubeLbTbzVEPO1bk1pZb/nmKmLcuql71b3RyScfq
         vn6wrhyOzVyzxgpB/LBXLURrgRi9cyijSUYln9lGExmLp/gNCGIltRljFUd/SmxnCztM
         dASY+7/7u5xPnEmHlJU7eCHZo51fI9ONYJDfT4eMoo00TiLD4GCuQAUrBllBZv6vXC9M
         sO4bqcter/TEQ9idroSMQflY0w6d0t4enhjRo2wfKkAvRiA0d6hZMiVDeF7Vd1WpLsLZ
         sFBwMugXdNAhdt42LMADtKijwFuljbPoZezp4ZZENPIrvhIi995kd5UCFlDNV6t19VR7
         8wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157557; x=1785762357;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B1B87TL/aZ8C8Z4evKf7/RY5o6bazqFyD/JIjo1HbK8=;
        b=M0fdXH50A67Inf48AeehabD6DHGZs1xIS+QhjBQtMjZR7Y/ftm78lzA2I/XmI7J3Wm
         3ZKSTW1iOTcf822+dBoT/qNHyWwWBPwLchjy23HbEpWshnmRiaZEdsOXm9RbLByzvY0J
         bwTLhG/l4GXwpfOxfLQdk8//etdoCEo00KxXTu0m9cMzDAOw1rOHYLLirlqpnOOMiXEC
         NsIgcYbjrJUG1ZezLE6z006Ck6V0JJBimNk/cwOBzGNIFwmb4L6vv2jf7LVVhG1mNVNP
         M1n2aJpv5D5lcvK6p8WgyrKKSimVO6RA8BSvprkTutg1h8+WPXVkJVt7j/vI3Qe9Kg8i
         X+GA==
X-Forwarded-Encrypted: i=1; AHgh+RpuVxxSOnKHrF33NI1UZpErsjClV/AyLJo5D8lK9TKD01RAeWRROn9MROMXC3xKhh2tmSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6TYtD7fN3WWglQaWn0b8BYpLmynvVLad0Hd1B2aq2sosawHm
	NGBmkDeQk2Gm5mJCG6GroNMq22k4mIY1cRyoyXtqR171UEAqTGDu+fcl
X-Gm-Gg: AR+sD13RRLx5wxQoMaq2y2yvj0vS3Ya9c0YKq+skVzfDX6pEyZikhSgjJFTHz77AMdP
	DqChOXBev7/rgZQQgm9a3f8JasttEQt35vWoTEXTWckGTYayynj/PoutbxaJlJItMDmSz/Gu2nl
	v2uI9G6A4jiFBKsLkDei98Gv0t3+b7OBjn7ixG4lNfDSkybDGfaoJ3uiv2lDx2RCKKxrKu8KjGT
	YFNYTFBbvG+xCDWwZRg/ZuNAGhm4dtsYfze+kqMhVX8SzAC+Ut7ZTH02eBJ4YH2ZDLDI3DVMm4R
	FCEHvJdTtAdj3Nr5v99bjWuqA6g8yRCXcbTvvQlocXgQj4FIIN4f89j6P4LeK/HVJNzoJfJJtS7
	mIIxpcsbaQdMtAp6ucP6W3Bpa34VfwjUnnQkIojgmqZcfRUr5QzJcF4dALuC9T+ySQjBiRqGaK2
	ShIxtYygCvz7uw+HVEI/uHhxpRbRKLSa+UJl3uf2r47ysnhqwi
X-Received: by 2002:a05:600c:1d18:b0:493:c634:952 with SMTP id 5b1f17b1804b1-496b56da571mr111910445e9.7.1785157556412;
        Mon, 27 Jul 2026 06:05:56 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:c208:9e32:8612:3f5f? ([2620:10d:c092:500::4:a69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfe07e1sm233523525e9.3.2026.07.27.06.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 06:05:55 -0700 (PDT)
Message-ID: <f1cf47c3-38be-40ff-aab7-c9a8ed852dcb@gmail.com>
Date: Mon, 27 Jul 2026 14:05:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Cancel RHash special fields on value
 recycle
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko
 <yatsenko@meta.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260726-f01-23-rhash-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn>
 <20260726-f01-23-rhash-cancel-bpf-next-v1-1-6e5e1131d885@mails.tsinghua.edu.cn>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260726-f01-23-rhash-cancel-bpf-next-v1-1-6e5e1131d885@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/26 4:51 PM, Nuoqi Gui wrote:
> Commit 6905f8601298 ("bpf: Allow special fields in resizable hashtab") says
> that "kptr semantics under in-place updates are identical to array map."
> However, after copy_map_value() preserves special fields,
> rhtab_map_update_existing() calls bpf_obj_free_fields() and drops retained
> kptrs. BPF_EXIST can therefore unexpectedly clear a kptr.
> 
> Use bpf_obj_cancel_fields() in the update and deferred deletion paths, as
> hash and array maps do. It cancels timer, workqueue, and task-work state
> while the allocator destructor releases kptrs at final reclamation.
> 
> Fixes: 6905f8601298 ("bpf: Allow special fields in resizable hashtab")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

The change looks correct, corresponding htab fix was landed around
the same time as rhtab, so it was missed, and not replicated.

This patch correctly updates update/deletion callsites, which guarantees
that potentially NMI-unsafe kptr destructor is not called from NMI.
Final destructor rhtab_mem_dtor() left unchanged.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>  kernel/bpf/hashtab.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9f394e1aa2e8..54ea111daa8b 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2865,14 +2865,14 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
>  	return htab_map_alloc_check(attr);
>  }
>  
> -static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
> -					struct rhtab_elem *elem)
> +static void rhtab_check_and_cancel_fields(struct bpf_rhtab *rhtab,
> +					  struct rhtab_elem *elem)
>  {
>  	if (IS_ERR_OR_NULL(rhtab->map.record))
>  		return;
>  
> -	bpf_obj_free_fields(rhtab->map.record,
> -			    rhtab_elem_value(elem, rhtab->map.key_size));
> +	bpf_obj_cancel_fields(&rhtab->map,
> +			      rhtab_elem_value(elem, rhtab->map.key_size));
>  }
>  
>  static void rhtab_mem_dtor(void *obj, void *ctx)
> @@ -2964,8 +2964,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
>  		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>  		check_and_init_map_value(&rhtab->map, copy);
>  	}
> -	/* Release internal structs: kptr, bpf_timer, task_work, wq */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	/* Cancel reusable internal structs: bpf_timer, task_work, wq */
> +	rhtab_check_and_cancel_fields(rhtab, elem);
>  	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>  	return 0;
>  }
> @@ -3027,7 +3027,7 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
>  	 * kptrs/etc. still sit in the slot. Cancel them after the copy
>  	 * to match arraymap's update semantics.
>  	 */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	rhtab_check_and_cancel_fields(rhtab, elem);
>  	return 0;
>  }
>  
> 

