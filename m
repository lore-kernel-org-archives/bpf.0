Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599894;
	b=qI3SDLXa0dALgg+RWC7dfaI3gmh8DIpzl+ATxyGQznNcFnXMuXzz6qDoDOTL6/BT2cAy
	 4NirXYgq3exmTuUHvgTiF7tbmZr7KES/ijlbeDhOVdhIi51GNt82/JGPJYCR9GUam+1U+
	 jV12+tkwUoGYgX9jsTd07PuChR4SJK4/Ce907MEOW9UEay6M7jQrLm/nPsz8+/CmXW+nV
	 68tipYaWuFJNO0pPSbrJRLTU1VHaFcdbp8nC/bUQGYvAvlnFrJre3SZJBJ593dwwGsIho
	 UBV0aAWxo4bBfuPJxf05Y3O4vCXIdwu6LmOO31yMrYU01PtMn4/nXRG8Zz2Ut2GvIEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=mK+snQ9Frl5VxzHZ6tx3RVh1smAcvo0rFgfFkfaD5gg=;
	b=SjTzgB7+Zu/ulkIE6dYiOfeI0UU1I2/KUsryJLnqIQ3pOtvobqdbHNulrcHzQInehSLr
	 P7gGO2Eun4W6s+YXODVdkvZopnEod/Od4A6lB+rjnP3dqOKWbrEtdMJ56jhrVeRCgu4gG
	 hVRXRkjoSA1Be03OIjAVxl/KpB2lp5mlenN9/gRGnlce9rptXSe/Hah0bwz3VWVAvaEZb
	 ubHd3RYrKNQK6JA/cYGPMNOmn9CLe+mA67P3aN7L3RYiPZUC7/zsscIlqG4cMyLNJbhUI
	 DaxFys9QaGSfsLUO2LQQ64oc+odTnahpTOWaltM45AqiFvbSiVO6YpzlUoDQgCZrQ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=l9B4VepN;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F113606AEB6
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 19:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F113606AEB6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=l9B4VepN
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso751648a91.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 11:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794599892; x=1795204692; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mK+snQ9Frl5VxzHZ6tx3RVh1smAcvo0rFgfFkfaD5gg=;
        b=l9B4VepNHDDm6p7etG6W2OI9MX7MHs0BT9Dcv7hbvUD7tcAi2HbicK6dgwH04x86LU
         mB074A2ftJreMTxnPiam/gA5VJS0HXmF3HXW8v9BYgVQIzHFoNoKLK0UxhkQ/Xl7qsvp
         paffvFH+tI/4E7XQmnlSg3kVXDrWI2OtKE+Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599892; x=1795204692;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mK+snQ9Frl5VxzHZ6tx3RVh1smAcvo0rFgfFkfaD5gg=;
        b=WsE7Kx6hX0ol98V4tp9V4Yu3yqSokIMEv0pz2XQg5GBOfYnjjUDGCC/NiXfLeZWupL
         ML1mU2yG1BEXpMKdk0dDKcGZ+V7sQtKN6iHTQMIeTyP9rdZokRz5YV8hTNOh6KD4+vnX
         foTVGzpIUmAV58lvYYvRb6y4x5GZVQVsOwtbdbDJnEfJ4DiC683kQbrdxh/6l2NR8jJx
         o95V4YBtmHTDHGYUUa0oZdoFiKdIWkrArHsNuSl+t0D99LEJa6XEa8oKA8AsM2RWRPvT
         w7rVqbB9WXb3yP7Z8Wx4jNLNYt+GcOvohdtRQDyVA8SWB0ny9ivvKx90pNYz4ng9ID/a
         TDiQ==
X-Forwarded-Encrypted: i=1; AL+hErFN/AJyuX7Iqb5KocsgjQAIS/imzyHgTve6TxQ1mLlSiDlxs1HTsSEjZew4xziLutF6vW4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/g6ewiTkNy5uiBZ4IVLFWYMd/oPY5rg9pcrjG81zBExYK0MxSz
	hIdmqD4NjB/qHyY3Jn3FYVSX6vvj2/HTSZM67iEUFJ4MgVWZZwVLclJWi1OzW4f7A78=
X-Gm-Gg: AYBFou0M0X+ueV8BIpsqpkYIxNwhNrqjz1OlN4YR0+6RToipONf74xKJXGs3D7j+hsg
	+9MPVPz6LfkfzCtSua5WiHAi1Zl5dFVnPbAr+ripfvsmtCZImiT9SnFno7ePE3TvgBl50yJI7s2
	oIoS8PjIVukPcToOxdy5/jeJiDghU24eLEy6udIctnjOW9bf584d9AIs2oEipsJ1DhiGHzYRZG+
	hhOhf2heHofMFCI3wlOy9Uz5bioHG+/lX0CurZUAl4jH5DflBygP8iXwBOgPFPkF9zhX0+43icd
	W+xnJeL6Pq6/YhEw5U6ax7rWUU4Dt2OzpoQ+wolaB/Oq89NVLj99xM5PB00bil0BhFLACqKytHe
	eV2A0Ztv3V+UJzqo3xjxHoEy7bNZ7Tpa8oZSgL0st7uRK9hQ4gLU+qEGwmxAXWxiu6cLXhzNB3w
	QkZN629jOk6SKeQiLBPg7xIuaJ/lFedNX3F6CtPQDrsOlkWn59B4UmEoAQLlcSYLAXw2OcdN3D7
	5qeo86qnkXwyCnt/5IbUY9LMJUy39UF8WrBg1qew38jQqSFpzfouR4X9c/gZVzxJps4+PkK34UT
	HqMkUOAe/bt9/1pHYJAmJbRsVOlA0FKMNPePZO5FJwGaVw3oT+VHanhfE3+NwDm08fLcLhZ1gPA
	ECidI8OSw+iNXZmBrQCRfp8mIPThaxAIdFfXsGlBJf/4ozCBXGjWMsi7AWSB3z8WUVF2FXDX9+p
	TXypxXMG98wMInAOtRYnhGfV6XnyDvlbl2MfElfC6Tyum5JpsU8regGrzNT3o=
X-Received: by 2002:a17:90b:17c7:b0:3ab:884b:65ab with SMTP id 98e67ed59e1d1-3b1b0ba4fd8mr3495026a91.55.1794599891728;
        Fri, 13 Nov 2026 11:58:11 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7e5055sm14868305ad.39.2026.11.13.11.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:58:11 -0800 (PST)
Date: Fri, 13 Nov 2026 11:58:08 -0800
From: Chris Down <chris@chrisdown.name>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: dennis@kernel.org, tj@kernel.org, cl@gentwo.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, acme@kernel.org, yonghong.song@linux.dev, eddyz87@gmail.com, martin.lau@linux.dev, nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 1/2] percpu: do not put btf_type_tag on per-cpu variable declarations
In-Reply-To: <20261110012235.1024461-2-vineet.gupta@linux.dev>
References: <20261110012235.1024461-1-vineet.gupta@linux.dev> <20261110012235.1024461-2-vineet.gupta@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261113115808.87a52a7c74e293ce@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Vineet,

Vineet Gupta <vineet.gupta@linux.dev> writes:
>The message is confusing: this is a declaration, not a definition. But
>the compiler is right to object to a type tag on the aggregate, and the
>issue is fundamental: every variant of an aggregate shares one DIE, so
>there is nowhere to put it. clang drops it silently and GCC warns.

Not a big deal, but the definition in GCC's message is the definition of
struct cpuinfo_x86, not of cpu_info. It's saying the attribute is being
applied to the struct type after the struct was already defined, which is
accurate. So maybe just drop that first sentence?

I've tested this with clang 23 and GCC 16. With clang, the same 280 types
and 3360 bytes of BTF go away. Likewise, with GCC, the per-cpu
declarations no longer warn, and the non-enclosed address space errors
are gone.

Once the commit message nits are fixed, please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Thanks!

Chris
