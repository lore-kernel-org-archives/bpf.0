Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504400;
	b=3iqjhVShsK/49+tKIW+vIrGndrEuIPCp/UqdbWB8sat0jxTf4Uz1+LBU+O9cGZIaonmK
	 EAaLVEJWwNecTeRG6iQrsl6Px6Xflxe7JbYTitZca2SjPPe2OZ1UDacct6Ry5ARBpaOsa
	 0HzYv1a1NhZi951Edztty4nxvhuDKG5TlIO8f29h7d5Y9KTJDNaSz6IPTX+euEq/7zEbp
	 WzTuZdU/2AtPcH8lZQdVrcus0pTcKb+y5+tlfZv/KW1a5ygL2ocusmQkoDrqvvZL5cxpQ
	 F8Hf4YbLhjrqfQjNV8gUFC797+VfWgFYif5rEC6S8NQOKpVVpd5HkdvBTnkLvN/ITPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ni1kpsCUmSMmOSQ2x9W2DKoNyy5/Ld98Sj47TVlfU0o=;
	b=hSZXoki/1itEqtNpsCx8ufk5YQAjFN+fJWC9zkAAxwnMyK0ygoilN79rz40FGvYesPNP
	 mMYgUFuHs7Hdlx7C1JR6BUZygQxkJv/yOJ4ouWBBgh1J4RnuInR8nLmXDeK7LYPNyvVN0
	 RihQ7NIs32KJEV58qRtf402O70UvwIDD4ZM618O3bGiCAapFyOE1TX43r9QDovyCDL6Ji
	 AqZyJB45u9CA/7FlKke/f1No/j5xvnWZkC3jtpGC3ujYKhBw9azu7j5sYuFrloXHgPiWJ
	 wz89t2A7uxYR6G4AtYPSL59v6IEWdagUvKDCBO1jZ87TUP5lnE+nSdCDRT2C5sauXRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ljsDYJfw;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E41606A333
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76E41606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ljsDYJfw
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2344224f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504399; x=1793109199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ni1kpsCUmSMmOSQ2x9W2DKoNyy5/Ld98Sj47TVlfU0o=;
        b=ljsDYJfwu3AtAc1Dcz+igJrM9WNFOYQpGUbqbkSQuEupQYCZ0faqyzR+qErYRSPaKH
         /+m//F1bNEEU6yF7zF7qVCK3036lYOFgLfpU6mXTtaR964AZOkFQ69LXhUimRKxcUM/a
         qsfL9Fh/qQQC9l9sgI/LF1Zu7S5rpeLmDI9AjMpX+e/F68JO0/hZyOPHulWMPYMNhDaH
         5pSDmJIY1TnOYiC1NkUEQWROOo8Vb7nUzukOml6qpADg+d1t4kQuxVTrXeL1WL1juOh7
         OgFksx/IOyYj23a5NOVOKDbslBrF3AQHq8vZezTijClS1AjgnbkS3de4zQEVHVq8BaJp
         rcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504399; x=1793109199;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ni1kpsCUmSMmOSQ2x9W2DKoNyy5/Ld98Sj47TVlfU0o=;
        b=TD+UMegD2fsDDiVOVN4HAGtsB9oktd7+TatP0NgOj6o45wbu5Tx4geENHZ0bokXVSE
         TxmAg++HuwQufxhRRZF33k6hLNoHf3XAgkoko+/y9pP7OplGLzNt+mdZd1PcVjA+rZ8X
         3xKVMK6axh6wWX8/SPn42E9QhPnBhHebaQDLBlNC4d0abP3Upf2MSisX4YyyfvtV9zWc
         QFdp3N8k28wnud8gNFnOgjugBbgsLtEDBcrE2vZOZvr3QsJAZv9PpzHTaK3vQXiS2yjj
         3BIvQUuyiir+ESQMkAXQaVSiXjkqjY1LiwsaEiNzrd4YGp6Qva3V8k0rF7V6ulWMS1w3
         9Luw==
X-Forwarded-Encrypted: i=1; AKwUvBwo4nDEbWAKCiud7NXjRAx4wNhZNS97tO7FVPUEL6HP3EI6wdWuXXrlQoo7eVjrcEa5dIc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCeyNKf+YFFjnkjtlJd9JG5N6TLdYyOXaA7E2GbDEHmky2zPuq
	n8vInGfPJ00CYRVaxb37WKBQGtsssCVrI0w8rXp1eP/sW6REYzmZutcY
X-Gm-Gg: AYBFou1H+wxxtZAJjVhh04q0SKz9WWhvGWbWK4qdRf570Ko5YpsHujXmqiFTcCzlbcM
	D7vlv5igBVBTT+eSKoTwpN3978vMBRgWPb4mdH8g9YkdzgxlzUwfkLDhC9QHrEt5ua/aT93Z91w
	RkNLRUPUMkWN63TJqbC21f0M7LkiNwMcLHm9S+FGIze/O6MM2RlCm+mbAv/SNcBsNjys6rXaET4
	W9en7fw4N5hFUlFR//Zpmq8UddNJ9CfNH1thHqcQwvYk6czUmt6bDU3ls969btlQHw0pR3Mtsmk
	vaTOI5kySo7i+qnX1ufUGv6gYgCaG+YeCt+FG5ABEapvKwShAK2on0s1KAazhoRWcsfM8H4B6nD
	hSPupZ+O6mw/1XTY9ZiNeoggVrCD69n2dfW1y9mcNiE4NQVwzHxI77P9JTIlcrFoRuJltUPhiQl
	xLp4hkTQQlI7Cwe8I3Vz+pZJwZ03oztTT212oqe94Jjz0sIbtCdUBRtXhocoelc9mNkD/0uUXF0
	nn6mTAXWLlCni6olZj4usH9xiEiwPEBia1lNWdTSUPGXIa9kVs4LibClLc2vEnZTarO
X-Received: by 2002:a05:600c:3e05:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a1d763625emr226211395e9.29.1792504398481;
        Tue, 20 Oct 2026 06:53:18 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:37c9:85ba:855b:cf83? ([2a02:8109:a307:d900:37c9:85ba:855b:cf83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8178dbsm6643439f8f.21.2026.10.20.06.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 06:53:17 -0700 (PDT)
Message-ID: <912a0f0d-3d95-4303-a7d4-6c6650d16752@gmail.com>
Date: Tue, 20 Oct 2026 14:53:14 +0100
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
Subject: Re: [PATCH bpf-next] bpf: Don't use percpu_counter for the htab
 element count in NMI
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
References: <20261020131524.207415-1-puranjay@kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20261020131524.207415-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/20/26 2:15 PM, Puranjay Mohan wrote:
> BPF programs attached to perf events run in NMI and can update a
> non-preallocated hash map. For large maps the element count is a
> percpu_counter, whose slow path takes fbc->lock with
> raw_spin_lock_irqsave(). That does not exclude NMIs, so an NMI that
> interrupts a holder of the lock and then updates the same map spins on it
> forever:
> 
>   WARNING: inconsistent lock state
>   inconsistent {INITIAL USE} -> {IN-NMI} usage.
>   kstress/261 [HC2[2]:SC0[0]:HE0:SE1] takes:
>   (key#5){....}-{2:2}, at: _raw_spin_lock_irqsave+0x18/0x30
>   {INITIAL USE} state was registered at:
>     percpu_counter_add_batch+0xd8/0x160
>     alloc_htab_elem+0x408/0x480
>     htab_map_update_elem+0x1e8/0x6a0
> 
> is_map_full() is affected too, as __percpu_counter_compare() falls back
> to percpu_counter_sum(), which takes the same lock.
> 
> Count the elements added or removed in NMI in htab->count, which is
> otherwise unused for such maps, and add it to the percpu_counter where
> that is read. In NMI is_map_full() only reads the percpu_counter, so the
> limit is approximate by up to PERCPU_COUNTER_BATCH * num_online_cpus()
> there.
> 
> Fixes: 86fe28f7692d ("bpf: Optimize element count in non-preallocated hash map.")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/hashtab.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index bf78e09f4d518..7a27479c46dc5 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -95,7 +95,8 @@ struct bpf_htab {
>  	};
>  	struct htab_elem *__percpu *extra_elems;
>  	/* number of elements in non-preallocated hashtable are kept
> -	 * in either pcount or count
> +	 * in either pcount or count; with pcount, those added or removed
> +	 * in NMI are in count, see is_map_full()
>  	 */
>  	struct percpu_counter pcount;
>  	atomic_t count;
> @@ -1160,11 +1161,23 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
>  	}
>  }
>  
> +/*
> + * With use_percpu_counter the elements added or removed in NMI are counted in
> + * @count, as percpu_counter takes a spinlock that the NMI could have
> + * interrupted the holder of.
> + */
>  static bool is_map_full(struct bpf_htab *htab)
>  {
> -	if (htab->use_percpu_counter)
> -		return __percpu_counter_compare(&htab->pcount, htab->map.max_entries,

To protect bucket locks in rhashtable from re-entrance from NMI we use 
bpf_disable_instrumentation()/bpf_enable_instrumentation(), will it work here?
It looks like a more common solution for hashtab.
> +	if (htab->use_percpu_counter) {
> +		/* percpu_counter_sum() takes that lock, so only read it in NMI */
> +		if (in_nmi())
> +			return percpu_counter_read(&htab->pcount) +
> +			       atomic_read(&htab->count) >= htab->map.max_entries;
> +		return __percpu_counter_compare(&htab->pcount,
> +						(s64)htab->map.max_entries -
> +						atomic_read(&htab->count),
>  						PERCPU_COUNTER_BATCH) >= 0;
> +	}
>  	return atomic_read(&htab->count) >= htab->map.max_entries;
>  }
>  
> @@ -1172,7 +1185,7 @@ static void inc_elem_count(struct bpf_htab *htab)
>  {
>  	bpf_map_inc_elem_count(&htab->map);
>  
> -	if (htab->use_percpu_counter)
> +	if (htab->use_percpu_counter && !in_nmi())
>  		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
>  	else
>  		atomic_inc(&htab->count);
> @@ -1182,7 +1195,7 @@ static void dec_elem_count(struct bpf_htab *htab)
>  {
>  	bpf_map_dec_elem_count(&htab->map);
>  
> -	if (htab->use_percpu_counter)
> +	if (htab->use_percpu_counter && !in_nmi())
>  		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
>  	else
>  		atomic_dec(&htab->count);
> @@ -2578,7 +2591,8 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
>  #define LLIST_NODE_SZ sizeof(struct llist_node)
>  
>  		num_entries = htab->use_percpu_counter ?
> -					  percpu_counter_sum(&htab->pcount) :
> +					  percpu_counter_sum(&htab->pcount) +
> +					  atomic_read(&htab->count) :
>  					  atomic_read(&htab->count);
>  		usage += (htab->elem_size + LLIST_NODE_SZ) * num_entries;
>  		if (percpu) {
> 
> base-commit: b71326388a8a24674846c1d8d3b6dd831d9843a9

