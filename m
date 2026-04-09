Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2E363C4E
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743284; cv=none; b=rSUX1W0QeHTcqURH9hd9tzCS0qr9K2kTXgXlU9UYZieTO647mJcdtE0HieiRsq+Hs0746oVhaGb28i+3j/QlLetukbVwMfediOLU7mi4BmcawgYpRlba+CyxuSCA6mq47DMK1vqlhOnA9+CedOo8jDQ/mn9Cl3TN1yXjGymDeKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743284; c=relaxed/simple;
	bh=Rkw1Ysxec0IR3+Zc8bMDz4J3G2dSh6FOnBK2CbbO13g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMsEzeubmf2Ba3gSk8yYQApGaRJ+P2tf6cWQDXWewzRdWuooyyLeueu/d3nTv2NybT35Z+hZTa2Bk3pA6CoBHj5RGGjZgni9wz6Nqe78GYB8RfBeXsY+aqxCazvofbdLdb3Jl8i0bAcrt7hZPaaL1EcSUw4SAEldHrwx67cpcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LieyiAsL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LieyiAsL"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b983bb07eso574729f8f.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775743269; x=1776348069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohIZ93yOp8/92W90PMyxfve36tc22fjDET33D09RBUM=;
        b=LieyiAsLmby8syaBRE4E6t44bMEWJzahktXIHsz1IM9R6zvMo4/LattCyTkYs3P/S9
         m4mKIxPBhvgbwlu7WwInAPAR3x9hisuBIrjC3BO/aa81Gl7dnPNOQ3FCnFV/BitHl3bG
         jNXS9XK/QIf/IhZa3bC9Wce2ItyriPp6DK+loGfVYMONcwnEHTaI4KlsYinjx0awxDS/
         6mRMHe6ileXIm22NeKupHA0oi1JiR43sxIIAVgRyJOdJnrhsO62yUiW288h4c52hPMLY
         aGNjSZbJBffDBviR/7ZlMeBe8FsDSr+BK6gAP+MtQojbGD7cTLjKdLBIG+UIZwUC3jjV
         8rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775743269; x=1776348069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohIZ93yOp8/92W90PMyxfve36tc22fjDET33D09RBUM=;
        b=bkZPzOcp7m5Kp4OtSP7PBNE9SMRkwKswDwDN8jmH/mU4iQtjEISo6qgdzLiqRWySKl
         kVHCtoFisG3m6RRFS7JkNMNmpc9PSv49ogVIwVO8LqJGe/RrVtr20I+MUzGs2UYK5dU8
         qgqrYzjzseRD5jxgRXDVYdbKqtAuYrge9JvU9hxHMmnZNfKkBMrPRZ0Bbi0RUjZrwzAI
         /caX/rzUjJOm7b6RuOYtY+uKFsEQSR6J5ye+PXWrw8kl/jeV0sd7g3V210qijKENvG8Z
         xus8ybYlS1sMEgYN7pAJ7uzJIIWHZMSHTPxzZxaCznX67Q6tzhKprDWCsAKZknIv9fV/
         Ca3g==
X-Forwarded-Encrypted: i=1; AJvYcCUOWUwh4ATmwNf3kF1QvhjokgkJyImwl7O7jd6GTACNGAuQKSctN9VtLIkMrOz2EWPKwaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KoWIOrB/R8DWRvRrN+qmyXpFnRmSSDqLzb0bgbwlGGRUe6ed
	+yXxvLuX6B9R6XKLBMM9LMuqqbK1xkr1WWYHzbmeXMRtJVdlKr9a2HFD
X-Gm-Gg: AeBDiev9o6XkN9LnJ0DvXbgDuZ4j2dODY9zl4SFqw9UN4M9GqwK2GeaJ412qMBQlp0o
	KtgkhVqB8Igwj6Aos5U6iRq1r1ZpbMs4ROsKCUDdZJbFqRjWVX1Rh881hwEsdZCGB/5vi6r5Qbl
	9QQX+EXKotASfpAN/yn7BtN9dl33WAx16GYbPELfYmOidElMoasVEAJHFei+PsIS9K3jW1lHOy9
	D7rMt+A24VOYiyQ/Nk/NF3aFtnNkppyH2Lcdv+CHsT8Kh70zOX/CKiCdMwYyfGZmTEXmjBvkaeu
	pOsJDZIBQmeMX7/hOfy2nEj6WvOk3nkxOv0pY5y2/YG95TB9lO6B0CKFp9hFqDxZDhgLfImZElK
	ux4NADjIDSI+sGdbKZWXUn1IbCAjYjjFmWjEDDKujxy8xbh+l8rWPk0Obk3sR0ykP9gBz/f58+L
	J6tBUtsVm70bWs6Rl0fkG5HT2oVMXiPZAJPeFVoLQJApc0pBAyPTzPhcEGaP43gOwE8Tk9AgQCw
	UjrDkzvRTA=
X-Received: by 2002:a5d:5f92:0:b0:43d:184:8aa2 with SMTP id ffacd0b85a97d-43d2928f9a2mr36664959f8f.16.1775743265211;
        Thu, 09 Apr 2026 07:01:05 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:a778:a387:b2af:188b? ([2a02:8109:a307:d900:a778:a387:b2af:188b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm68509311f8f.4.2026.04.09.07.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 07:01:04 -0700 (PDT)
Message-ID: <139753e9-99ab-4b54-a527-71dc034f1ac9@gmail.com>
Date: Thu, 9 Apr 2026 15:01:03 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf: Factor out stack_map_build_id_set_ip() in
 stackmap.c
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260409010604.1439087-1-ihor.solodrai@linux.dev>
 <20260409010604.1439087-2-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260409010604.1439087-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/9/26 2:06 AM, Ihor Solodrai wrote:
> Factor out a small helper from stack_map_get_build_id_offset() in
> preparation for adding a sleepable build ID resolution path.
> 
> No functional changes.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
The refactoring looks correct.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>   kernel/bpf/stackmap.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..4ef0fd06cea5 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -152,6 +152,12 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
>   			 : build_id_parse_nofault(vma, build_id, NULL);
>   }
>   
> +static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
> +{
> +	id->status = BPF_STACK_BUILD_ID_IP;
> +	memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
> +}
> +
>   /*
>    * Expects all id_offs[i].ip values to be set to correct initial IPs.
>    * They will be subsequently:
> @@ -165,23 +171,21 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
>   static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>   					  u32 trace_nr, bool user, bool may_fault)
>   {
> -	int i;
>   	struct mmap_unlock_irq_work *work = NULL;
>   	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
> +	bool has_user_ctx = user && current && current->mm;
>   	struct vm_area_struct *vma, *prev_vma = NULL;
>   	const char *prev_build_id;
> +	int i;
>   
>   	/* If the irq_work is in use, fall back to report ips. Same
>   	 * fallback is used for kernel stack (!user) on a stackmap with
>   	 * build_id.
>   	 */
> -	if (!user || !current || !current->mm || irq_work_busy ||
> -	    !mmap_read_trylock(current->mm)) {
> +	if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(current->mm)) {
>   		/* cannot access current->mm, fall back to ips */
> -		for (i = 0; i < trace_nr; i++) {
> -			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
> -			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
> -		}
> +		for (i = 0; i < trace_nr; i++)
> +			stack_map_build_id_set_ip(&id_offs[i]);
>   		return;
>   	}
>   
> @@ -196,8 +200,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>   		vma = find_vma(current->mm, ip);
>   		if (!vma || fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
>   			/* per entry fall back to ips */
> -			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
> -			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
> +			stack_map_build_id_set_ip(&id_offs[i]);
>   			continue;
>   		}
>   build_id_valid:

