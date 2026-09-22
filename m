Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1A2F7EFC
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041233; cv=none; b=AAmQ97sArhF7fuk7TpWsd43UvN15zb2YWA6/+HO0X6Jl2inHsk28csgxh8CpWbYiqY+Ohxcas+PIUDOZWNFYVEy+gUlXTtSmdR4/eJDl8oRgt/MfVgymFuJMqV0AaoSI2J5P9vuizeDifNwroCckqBq0h5RU19KQGariJW+AE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041233; c=relaxed/simple;
	bh=+P63ffgjr3pdboURh9eeuRYyJNt86mz/vkXw2ggL6o0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=NZaTt0EY1pBrq/JnAMjExAzaBWF74noI8/Ddj02xVZqwgOFZ+XKmyxWpDEohysfL/2uPPVsJ9tc+4lL8PD0jtkP+sxnZnrtZeUMLWd53DzHVKaRy+Wbl5u+XuOHhMFCukv+tJ3rzXV0bWJUtQaNaflegSYCA8oxx/bVc1OdHOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+tsQLBG; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+tsQLBG"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db22383fe8so23392945ad.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790041232; x=1790646032; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uv9sBMtX3Z/AnKEaJOOadu3m/dKGHE50lWXdsUYLDwo=;
        b=D+tsQLBGSpZtjlROBa+g83n9rojZArC4hZlkEsYQlaQ2bBI0rrbjX0YqqE6xmBpo/q
         9z5Hvw4V+G/TvD+W19+atBHanHfT9+epQxYVEWTvCYxAyTw6fwVmualKiSeeX4TsHtK7
         n9SUSD4vrCBOqBg2uBoG7gnTiC0kFv+AgCAjrTvPu7yCuKmYQSI97YsLFWj/9EXDF4om
         0DflcFRYcYvxXp8cUuyzyCvmf7lDnPwwvnTLyf2yPjQnzH8rHZOe0KudwTjGkspBPR4L
         V2hJWGJHvQcQNQYl6k71rilWVeVGb41l3223TERNMzy5R1tSqnZD89HwwcFq82t0HpoP
         +jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790041232; x=1790646032;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uv9sBMtX3Z/AnKEaJOOadu3m/dKGHE50lWXdsUYLDwo=;
        b=ja0KksoNhxeYFPM5QX7MU5h9OMxPjjxeHS0nF6LOeDcC6kfPrLG9mdp3SXsaFiSJ/t
         c4GkT1s8ll9b+mK3g9TH33YpqNJXIKkE59eeJdlRsYhLkHLiLQAueMm3lhSRtWInWRJj
         B9JxFsCMkAD9v+qXTQX7Xz1MfXdu4KoQPvaGeYgR7a39wGspdpXSd2pfKeDaTgc+DdyX
         JLhYvz98IoaArCKCvNbOSDh3jSaEe43QzYblw9Q2SykAkzuCMyLeaVjqVLu7ZEVMhCBN
         XCCnNBaYKUbrlk3GVGDJ68pkq9c5H8WsUf20PHGZa2Cpxdnp6hEprY/lG05N1IBoPtrd
         pScQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWmGaeCDVvctK7UUYkUUkMcSNeguc/rGnB5tFhPqNem6aimLVEIYh9/iJyI0DH+HCUuhw=@vger.kernel.org
X-Gm-Message-State: AFuF++lUFTRZdb08BEGkZzEJ/68R+MiEOH6pwOctcAdTw8fUa1evJoHY
	xmPS43RVGm6Y//wrDkv+jgGxJ++abwZq8cEG3zkM/6KuuGcsD1BvS/Vp
X-Gm-Gg: AYBFou2gM1FbcdpqhihYMl78eZjiF7Uc9S1gyuSKVc/7h0SKTNTHn4plGEz5qafopbF
	3NrhF+JGbMU1PkjRElTOpA7pyQp4LLpq2MoDOYmlQoMR/MNF5n1hbnh8ty9sH7gAbf/kYsSOmh3
	0e7JZSTURm/yYqbz5TGhHXwZlS5X7n6DoGrRzGjwDUPXyyXkMXKnbaPx8PAp4YhVbem9HbY4DCg
	hwKflWCpRS1688VJyUn9+hO6FbqDdcHW1DXlpDvYt9WMP7op83KMgitVoTUdKkAhXuT/JeaIy8G
	m7dAJudGAbgos7gPFhVH3yODd0UDWWdXwNUDOkDd45q6TVn2r3QnE9NueRz5gtSJYaxmPKjQupg
	2Uh/WhrwpsgM7eVT3kFqZXbBKUY2qVLnLOtOuT3Nxeba9Riy3ycQpbXlVWvRi0MwO2mJjkaekUV
	xi6iTYtnBd9MWK7l7+5lC733I3nYiS6ud98SP7SEBxcIMFWKL4ANcblylcjOjnQ/DPXu5SiZn4m
	AYVn3gBi9gouiTJEh4I1jfLFBEvyzRCwET4KuJiwPuskV58YRYZPsfoiKXlC6dsJ7zHFUQodOvZ
	wfXsZjFxzKJ4Vw==
X-Received: by 2002:a17:903:26c8:b0:2dd:c0ff:e72e with SMTP id d9443c01a7336-2ddc0ffe9ffmr111566545ad.64.1790041231501;
        Mon, 21 Sep 2026 18:40:31 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d053e87sm1056265ad.63.2026.09.21.18.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 18:40:30 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 01:40:30 +0000
Message-Id: <DLLGNOQ59JIC.1O76G4NM0FXZ1@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>, "Anton Protopopov"
 <a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Speed up htab lookups for u32/u64 keys
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <kernel-team@meta.com>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
In-Reply-To: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
References: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 02:28 PM Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
> +	/*
> +	 * Fold the jhash constant and key length into hashrnd once for the
> +	 * fixed-size fast paths instead of doing it on every lookup.
> +	 */
> +	if (htab->map.key_size == sizeof(u32) ||
> +	    htab->map.key_size == sizeof(u64))
> +		htab->hashrnd += JHASH_INITVAL + htab->map.key_size;

This optimization is probably not needed anymore?

> -static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
> +static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 key_size)

__htab_lookup() is __always_inline, but htab_map_hash() and
lookup_nulls_elem_raw() that consume key_size are not.
Whether memcmp() becomes a single compare in _u32/_u64 variants
is up to the compiler. Make both __always_inline?

