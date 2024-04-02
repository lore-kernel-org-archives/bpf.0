Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860F17756
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 05:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034287; cv=none; b=lfhGGlsg/jf30t/PqzNN8d7dx3Id6w2EPgiT37SJy/aBJc0en55d3wm4Z6R+njceSOO2Lu3pusk2Z/enTWvv9tZ1TjqtST8gMss0LuyxDy6JrdgVgYQDN2J3LRhhVjntbg2L+/X9gQq5JTiy1NwOQcDV2K8QXYyVuhq5QkEHe9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034287; c=relaxed/simple;
	bh=ATLaMEiRbO1gpmx8HNfohYikMQ+WpQKdyMpQHCCmgDc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S5R+H0wBw8VfqUtdDdx8ywX1tV1J9bYqLpMWAd+eX9Li0w7cbJKj7L+9Z5W8cCDxjZFAQjSzz+Gv/rxZLfKq0XtU9jcWAQMZCPU87tFTD6gOWH98F/pUkQgkptewU0datS8Rhy23C2y7ejKKgP/1EDsiksZZMoe5rb3ASXSdXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgXRgABF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgXRgABF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dee27acf7aso33432295ad.2
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 22:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712034285; x=1712639085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGYc4Db5jmOtNhipRofZSwWhF5ZTPrFyBf9rPN8/spw=;
        b=IgXRgABFwd5ezRQFv8pBLp0tRYqrm63Dds5oiEn/lyZZeHxrVTuDW1CoZcAddmBYoB
         QbbddY18M2COrOUx2YwzV7/1Q4v0s+Y5cyKjlVv0j8s+I28oKnHo3BG6km2YC7vvecyK
         RpWJjIGeO11+V3Po9McC4oUv9X/Efg7Xuba8IpOpcJ8x5HmUi9Rr1rRP2B88IQcMmkQH
         esHxVkDTeW3xCQj5KLUv25CN2ZqDiQ/IL2PRr/OqDhfU7E4ZtVYN80434ZLebXGWlrdd
         Ui5I/RKJakVp7yUf8V9iuEgINnX/UnO0dajFKXPRkmP7qhWFLBTGSRAgM7clYjTrei8l
         Siyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712034285; x=1712639085;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DGYc4Db5jmOtNhipRofZSwWhF5ZTPrFyBf9rPN8/spw=;
        b=hNvpOC2dB9WrUJHQUW0Y9vk7RoduddJIP0b9IDUXs3Ghi/JuarC04R+dWSModla9vy
         QuiCituFEnJYZ3a0+kZ9oa/L5glNlmFjjBvhTqEaVrdMrn+mIZGh8Knroqvk9BaJEkco
         tcdrHJmBJqWxAoAE1C8x01twsvJ5Y5+69PgakqTT9SLkVnX24hXKiR2WBjiYq8Pp3oPD
         m9EqVG7WBwnwdFdE963PoKBGyfk+4GjSCzQnuRtggE+wPnEHW6NPnCXmV34MuNqFnbzR
         rh5gCXD2rFLB8zS8gb5y4x4cibNC8rvIjyyolQ0PKjN/2xlkFioQnbuPh7Pk5wNwi3mg
         L+ew==
X-Forwarded-Encrypted: i=1; AJvYcCXc5TNbkSBVjWYnDXdqRBD5N1q4W+7UZ9lLaw7SHy/tkA+IlBnxisyr/1yLiPV5ynC0HHhTLhgB8475SV4c3v/gW36N
X-Gm-Message-State: AOJu0YwSuhOsO/0YYiPV6JZi+JVJN7AgIfCSVy4s9fp/dsqTmJ3fSndJ
	AXV7NmRnJfna57dJ53OmNnq2dDf1/oYtIpzaFoGXN46ZbLZeKM88og/Hfy+E
X-Google-Smtp-Source: AGHT+IEGMheQ6GIkHBtWsalqO6M7yAHgy2xxPTqYHv1fuX+Tuuv5ynGqwzRHIpjGdk326j9avXy6Fw==
X-Received: by 2002:a17:902:bc86:b0:1e0:9a4a:72b5 with SMTP id bb6-20020a170902bc8600b001e09a4a72b5mr10622651plb.26.1712034285151;
        Mon, 01 Apr 2024 22:04:45 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001e0bcccc800sm9918356pli.35.2024.04.01.22.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 22:04:44 -0700 (PDT)
Date: Mon, 01 Apr 2024 22:04:43 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <660b91ebeba17_1af772088f@john.notmuch>
In-Reply-To: <20240402021307.1012571-5-andrii@kernel.org>
References: <20240402021307.1012571-1-andrii@kernel.org>
 <20240402021307.1012571-5-andrii@kernel.org>
Subject: RE: [PATCH v2 bpf-next 4/4] bpf: inline bpf_map_lookup_elem() helper
 for PERCPU_HASH map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> Using new per-CPU BPF instruction, partially inline
> bpf_map_lookup_elem() helper for per-CPU hashmap BPF map. Just like for
> normal HASH map, we still generate a call into __htab_map_lookup_elem(),
> but after that we resolve per-CPU element address using a new
> instruction, saving on extra functions calls.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/hashtab.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index e81059faae63..83a9a74260e9 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2308,6 +2308,26 @@ static void *htab_percpu_map_lookup_elem(struct bpf_map *map, void *key)
>  		return NULL;
>  }
>  
> +/* inline bpf_map_lookup_elem() call for per-CPU hashmap */
> +static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
> +{
> +	struct bpf_insn *insn = insn_buf;
> +
> +	if (!bpf_jit_supports_percpu_insn())
> +		return -EOPNOTSUPP;
> +
> +	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
> +		     (void *(*)(struct bpf_map *map, void *key))NULL));
> +	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
> +	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
> +	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
> +				offsetof(struct htab_elem, key) + map->key_size);
> +	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
> +	*insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
> +
> +	return insn - insn_buf;
> +}
> +
>  static void *htab_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key, u32 cpu)
>  {
>  	struct htab_elem *l;
> @@ -2436,6 +2456,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
>  	.map_free = htab_map_free,
>  	.map_get_next_key = htab_map_get_next_key,
>  	.map_lookup_elem = htab_percpu_map_lookup_elem,
> +	.map_gen_lookup = htab_percpu_map_gen_lookup,
>  	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
>  	.map_update_elem = htab_percpu_map_update_elem,
>  	.map_delete_elem = htab_map_delete_elem,


Thanks I'll test on Tetragon as well to see if we can see some perf improvement we have
a few per cpu maps int here as well.

Acked-by: John Fastabend <john.fastabend@gmail.com>
