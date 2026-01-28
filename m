Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326A360746
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609430; cv=none; b=cdMqmqDIyeIn+Zw6plQZyuJ+dZMd8VJGTgQfZ8P0Pp0nHYUetR/VTbdBhRO+SSdGEN2NCr6FdHjp5ROSefOtFvxJKVGJ+Ysu7W4E7T9/Afb7nIqD9y1eNKzM9yNb3BFKTZkOMQ8qEcnUClrpOARzEhr9fYN5nfdCuo6SOtlP5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609430; c=relaxed/simple;
	bh=THyzkYNiA5RTUK9YKP7lt4PaxlMYqQzmPF+ejfi7aHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3WcIAobQ1LpFQARs3xXL+UC3kQ2Lni0cY5xdNJbb95LrnPUUtCpDVrou9gXHEVheP3scbhNTCrJzTlvd1dKi5vBghVJzsFBfy0y0A5kXchHPRAgl2PVC3UWHZG9E5XVLfGBVwnr6SV6hzPTCjFb6TrlhMBMP4hDYNAPRWXeSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koiK4S9f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koiK4S9f"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806bf03573so8546445e9.2
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 06:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769609427; x=1770214227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5N/dLnDP7ZNeMr/qwDSyiaL36LDhsQe2QSv+3xSbKhs=;
        b=koiK4S9f4t2sZ+hxMz7eG9lX7AIcTGVNhhXtayxl/PaKD/SqOSrA3bXWG+VE9bBgTd
         5FakKGnzOBxZZkBVShYaSQTAU7K75BeEzTD5x+Ym3sF9aWCUR8OdMTjEtcr+JebzWLQ+
         2TdRMPNAe5jPLZrfzjTHB8Iss9C4NPIzRF1XraQJm4JlGr6IQa6me+TcqlN2GF2WsMNk
         PkZpdCFbSujjd9jQw9XjJ4ZuRMNlJfRDDCBEG7ysbuiXcnBADnGBfociwqqpk9Mdmoyz
         +qKb/yShAdWSxPanf5DnRtG7Slo8FDjPie9PpLreMcnz3sviSgwtMCyR74YPQQzMUNB9
         Dt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769609427; x=1770214227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5N/dLnDP7ZNeMr/qwDSyiaL36LDhsQe2QSv+3xSbKhs=;
        b=gnogke1iNjzsN8KUoFT5DHjwGWKgZ1q56OWO/ePAT9OS27tiMOsVeYCDT+YjMtp3dN
         +EytrsxlHGPGTMntVDUatqW5wR7xSMu4WVBLBd2BwqGGv6y5RP74q25LQ2vUyZjiuPqh
         gdWqfFBUFykLAX+NoRXoL7pNE75op+kPb5b8XNs5rMezWsNr9+sGBsGKPZWthtOuhV7V
         /NYUD0sdxUL0mkwyfswnugmUsYnhj9bkwLujT/lwCzWqBQNvu8kMct8oQ6qyuR758xWw
         J9gdNH80WL4v8ejhMd5Dld6L9MmkA6G3EdlOLJ5VFYgEHrBUZMg5y9TKINB9ApH2nvQB
         90RQ==
X-Gm-Message-State: AOJu0Yx4YR29CyvuXYysWSvTbJbuk8O50FYzrb0XsJOiQhHWOchykobp
	fhTOtCBERAGizQ3EQSlM8pv0KhJiYpXxJfhOeSzyJhvDd/0aL6fYE3KN
X-Gm-Gg: AZuq6aI80d8qwmAciBtcydJDF8BAB1DIIB+39wRKRc4h974CnGfrf/2zkmmRtnaaEiL
	Y9/c29FbO6xXPHX1WYVsy7Zn/8RoRvgI46NpJT5t4Bz/4jUM65Db7eJc3WQq0wANnIomuqJ4DF7
	0gzujFk2LurQoXk8L9VF/O1Veu4cW1aSphoMVohr/SCwFCci+I+pU7CQT8PES2XNdfPHGxfKcAL
	DRyQRnTm+v8HpQBJ570C/NANNI+IQuoUUuRTANsT/hH7HZOtAD2W5OUTSrRqP33OpKeB161LFhj
	+nxynUNXtRbRtcIS4zRSKntY3CjKmX07G9y9vDbZrfkaeeMD5paM6RQNQGh9a+oqodgI9rLNtZi
	XUCK7mDFAKrHv/HCORYlDZhazmB6M77TSS1gjnXjyHRt0mQbS1EAUopB5XY2coC45OU1+wgPhAW
	6/CTmDqqHfzaHtUjgLueBBPKpyJ2SwslJwowiOsZrMUjpood4=
X-Received: by 2002:a05:600c:64ce:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-48069c92cacmr56536475e9.32.1769609426544;
        Wed, 28 Jan 2026 06:10:26 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:c307:95a:6dc8:83a5? ([2620:10d:c092:500::6:f1cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm141733965e9.4.2026.01.28.06.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 06:10:25 -0800 (PST)
Message-ID: <750db7bc-2cc5-4a53-8bb6-30e702fa0989@gmail.com>
Date: Wed, 28 Jan 2026 14:10:24 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Add the missing types in the logs
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260128085842.145057-1-yangfeng59949@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260128085842.145057-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/28/26 08:58, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
>
> Add the missing types to avoid such uninformative errors as shown below:
> R1 type=ptr_ expected=ptr_
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>   kernel/bpf/log.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index a0c3b35de2ce..6fee3d8b3703 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -473,14 +473,26 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
>   			strscpy(postfix, "_or_null");
>   	}
>   
> -	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
> +	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
>   		 type & MEM_RDONLY ? "rdonly_" : "",
>   		 type & MEM_RINGBUF ? "ringbuf_" : "",
>   		 type & MEM_USER ? "user_" : "",
>   		 type & MEM_PERCPU ? "percpu_" : "",
>   		 type & MEM_RCU ? "rcu_" : "",
>   		 type & PTR_UNTRUSTED ? "untrusted_" : "",
> -		 type & PTR_TRUSTED ? "trusted_" : ""
> +		 type & PTR_TRUSTED ? "trusted_" : "",
> +		 type & MEM_UNINIT ? "uninit_" : "",
> +		 type & DYNPTR_TYPE_LOCAL ? "dynptr_local_" : "",
> +		 type & DYNPTR_TYPE_RINGBUF ? "dynptr_ringbuf_" : "",
> +		 type & MEM_FIXED_SIZE ? "fixed_size_" : "",
> +		 type & MEM_ALLOC ? "alloc_" : "",
> +		 type & NON_OWN_REF ? "non_own_ref_" : "",
> +		 type & DYNPTR_TYPE_SKB ? "dynptr_skb_" : "",
> +		 type & DYNPTR_TYPE_XDP ? "dynptr_xdp_" : "",
> +		 type & MEM_ALIGNED ? "aligned_" : "",
> +		 type & MEM_WRITE ? "write_" : "",
> +		 type & DYNPTR_TYPE_SKB_META ? "dynptr_skb_meta_" : "",
> +		 type & DYNPTR_TYPE_FILE ? "dynptr_file_" : ""
>   	);
Maybe it'll be good to decrease the number of the %s
and also group up the strings, for example:
const char *dynptr_reg_type(...)
{
     if (type & DYNPTR_TYPE_SKB) return "dynptr_skb_"; if (type & 
DYNPTR_TYPE_XDP) return "dynptr_xdp_";} so later we can substitute 
multiple %s with just one, corresponding to the dynptr type, this also 
ensures dynptr type is always in the same place, relative to other 
things. This can also be applied to (MEM_RDONLY, MEM_WRITE), 
(PTR_TRUSTED, PTR_UNTRUSTED) and so on.
>   
>   	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",

