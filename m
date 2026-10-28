Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157816;
	b=LlmtH9Z3AbPDqZT0pbMrgto1SHQ5Td942j66kxDQPMm7jpQL6/Sf6EmGYaGvSv5LESlO
	 p1zuWM7+KcZcSX+63PEIKPfGFvDiQKjc0//Ha4LJm5P45AolRR5rDATnuKUmApmD2BtOe
	 xSKYzugPf8s3AdYPQFydl8LJilJJ7chgdco9aHeJwNj8PWBmJGhfsMF/t1hqvC6Q0qOrr
	 Ff0qHJTT0eqGB3ChQ9maGxeFXkz6wGvEOTnR5fihN9DHkk6Y6r7e0aaWnwMOZAPTew0WZ
	 VAnbQN441OE6KB3QS15kh623segZl5d1ezZEOYHS3gRLluMnOzc/1Upak9mJ+GWvsFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157816;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=m1t61hf9q7vY8/C6aBIQK+Efpvxuu3mYkJZ6PJCjqAE=;
	b=lbwgpGtpUuEdBJd7fH18VHSQehzsMUC0gwXAdLPmDpaHsRAPDjy0wHI6KC0GHW+3lqmC
	 qHAHF6kRREGOuAhlXFQoF+4AErCIGHkR9SqA1pqfGIdvGEQ9Hwraud2zp6t6ypX/i1xIs
	 +lbZfwGemZ6BpzJs9HtBzAkKUEofBuQ3RO1qzgz0ZsM/+ushVbbB6r6EA+re1up653vlY
	 DE+Pw5hBDSHh933HGaiiF3ljWH+Q0N5cjYtq9MzRpkQQe/ZESsGhhNRkv+IARt/Y2lGhQ
	 z+oKlcWC3lzHZ4tyecG9zCDM5RK33negkmT19BAqlztMSs+FYVkj21LCY+QrQf3srLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ECPM1W9u;
	arc=none smtp.remote-ip=95.215.58.57
Received: from mta1.migadu.com (out-57.mta1.migadu.com [95.215.58.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00499606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 03:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00499606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ECPM1W9u
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5ylalOZz6iO6eHpmtG0RvOJja8NfzJcT04XmFJRj9UU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793157812; v=1; x=1793762612;
 b=ECPM1W9ucewv8J70X2P4jTnCYlwJpH9ow3JUvg7wpIe6hcJj6jTliT4MLybtKO4336FKE5Sv
 2LnTzUHX1/GePeV2N3c/u0E6c2LyWkGNLE1Ds544gcqMrULreVAT6lw7Es9pemDsF0U+N1yWRz5
 UODFjkKrcUNSoN6ovVyuzcr0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3e19cbed590c118f;
	Wed, 28 Oct 2026 03:23:32 +0000
X-Mizu-Trace-ID: 3e19cbed590c118f
X-Migadu-Flow: FLOW_OUT
Message-ID: <0a29aa6a-702b-44c2-b70e-a8db5145e1d7@linux.dev>
Date: Tue, 27 Oct 2026 20:23:24 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3] bpf: Fix out-of-bounds btf->types write for split
 BTF
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261028031933.277550-1-yangfeng59949@163.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261028031933.277550-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/26 8:19 PM, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> btf_add_type() stores the types of a BTF in btf->types[], which can hold at
> most BTF_MAX_TYPE entries.  The types of a split BTF get IDs start_id ..
> start_id + nr_types - 1, so only BTF_MAX_TYPE - start_id of them fit, but
> neither the limit check nor the size used to grow the array accounts for
> start_id: the check is an equality test against BTF_MAX_TYPE
> ('start_id + btf->types_size == BTF_MAX_TYPE') and the new size is clamped
> to BTF_MAX_TYPE.
> 
> The check therefore only fires if the array happens to grow to exactly
> BTF_MAX_TYPE - start_id entries.  Otherwise, if the module has more than
> BTF_MAX_TYPE types, the array is filled up to BTF_MAX_TYPE entries.  The
> next type that needs to be added reallocates the array to the same size,
> after which btf->types_size no longer equals btf->nr_types and the growth
> path is not taken anymore, so every following type is written past the end
> of the array:
> 
>   BUG: unable to handle page fault for address: ffffc90006200000
>   RIP: 0010:btf_add_type+0x74/0x270
>   Call Trace:
>    btf_check_all_metas
>    btf_parse_module
> 
> Bound both the array size and the limit check by BTF_MAX_TYPE - start_id.
> Base BTF (start_id == 0) is unaffected.
> 
> Fixes: 951bb64621b8 ("bpf: Add in-kernel split BTF support")
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> Reviewed-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thank you!

> ---
> v3: Simplify the commit message. Thanks, Ihor Solodrai.
> Remove the redundant btf->start_id >= BTF_MAX_TYPE check introduced in v2.
> When entering this branch, types_size == nr_types >= 0, so the condition
> start_id >= BTF_MAX_TYPE is already covered by the second check.
> start_id comes from btf_nr_types (base_btf), and the base BTF is subject
> to the same bounds check, so start_id <= BTF_MAX_TYPE.
> Thus there is no u32 wrap-around for start_id + type_size,
> and max_size cannot underflow.
> 
> v2: https://lore.kernel.org/all/20261026073654.840705-1-yangfeng59949@163.com/
> ---
>  kernel/bpf/btf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7ed1ff71a089..1be30487a2fa 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1752,15 +1752,16 @@ static int btf_add_type(struct btf_verifier_env *env, struct btf_type *t)
>  		/* Expand 'types' array */
>  
>  		struct btf_type **new_types;
> -		u32 expand_by, new_size;
> +		u32 expand_by, new_size, max_size;
>  
> -		if (btf->start_id + btf->types_size == BTF_MAX_TYPE) {
> +		if (btf->start_id + btf->types_size >= BTF_MAX_TYPE) {
>  			btf_verifier_log(env, "Exceeded max num of types");
>  			return -E2BIG;
>  		}
>  
> +		max_size = BTF_MAX_TYPE - btf->start_id;
>  		expand_by = max_t(u32, btf->types_size >> 2, 16);
> -		new_size = min_t(u32, BTF_MAX_TYPE,
> +		new_size = min_t(u32, max_size,
>  				 btf->types_size + expand_by);
>  
>  		new_types = kvzalloc_objs(*new_types, new_size,

