Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8C366046
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333443; cv=none; b=D9jbgAfu42ZUasf9sscaGsVc5zDqCvBbwvGkW8I6vCYXDowAwj7h2bLE+cgW1ndOEqMGtn8q2Ee2WEATBPEYzDIgse/L9mAD639odkU24wXuzTqs3QuGp5YUOgWr9X3/eSPEB9eINgYknzyC6ezlsxNEQPRpfWnt2pBiqYGZ4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333443; c=relaxed/simple;
	bh=ny4F686XU3gQ2H+vMFM/I+B0c5kC47mbwkkPWhSTfgM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=M+gkut6g4+dR7wt4FrLfivO2j0tRL+jww8YqHtFSvm1We4ReoptghE4ivBn/tb5ryK25Bz/X3WKbnXN/PbO0zE/077luVOArKuej7DuaTnea71MX5Er6eiBMAL+gkEe6/CP9xfKiqotNH6RHYpumprXD2kYxSohv2fJ6roPv7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=HyjJOANS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="HyjJOANS"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so2915641a91.2
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 20:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779333441; x=1779938241; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnZgEvyl5JzulXJ71OevVX7wYBcNSF1YrTlDeDtAzPQ=;
        b=HyjJOANSHazSF5fYdYNLrCE0j1QaNyfGRvfSkrDRAUnYBFJzw4LCK4GhGXvf87cvOV
         ht92y4CWSpmnNHZJHzDXsNl763tchywm2A9VNfrdSwhI5UdSDButr7NDKvZ1rInfa159
         FK06o8YZTy8wxEOQXwJPWAEc2jwkrafgA/AHz+kfLNiQIJBKdrxqorEk0o/h6j64uo/1
         GE4M9XljDc3zermBNjvV14gTLHBMhQwsCcYlqzSNNi7SLOmtYOoIvgrj+SuQRvKFmyoW
         vHAzD2xslpD8SKGpeJ6tbUcu4bHUeWanC2UTAlmjU0um/Swh6KD6E9kEVIT/fV8xPMPN
         x8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779333441; x=1779938241;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnZgEvyl5JzulXJ71OevVX7wYBcNSF1YrTlDeDtAzPQ=;
        b=gLsCJEUFYIZVF6nDnRnc2Vq1FdBegVmXVuhXs5L3PBprMVXQx6F8jDHG9Vgxuv0tMH
         2C4Q8v8EqwI3K2HXSkQTIUx0H87WqPYk6ibs0HfxC6obNNpG0KfA+DlzVxYvuWYHtojk
         laVtkh+gnm/75SagYu95xmWhJdxI7KI4IeN8JWedrvv3LBTlODSNmws96d7QsUMV7dOf
         Mw2jmsuVDYIgLt1ty0vPdRq7Heb80IVYMiKMrIy8xv37MDq8U2YmtmEtfKcF3puJSK/Y
         sRqNe1E+rMqXFsXM5c+fojUVgnb8JX3I4QKwmjtYT1xbarszvSuv9anq143g5AFxf0F2
         p0sg==
X-Forwarded-Encrypted: i=1; AFNElJ/cK+fVxVdGUrTvIxre8ZWgQdwIKPR7ehV6J1pHiL/+XPAQrQRbYJ7b6rYl+TCK54vKi6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwATCHd+PvvCCv2jsdupPmzNwiUNsNXzrJhFijYCZU6/YxJoUGo
	u5D0p++lKBJLpG0bF4PUt4xCM4bdJ37O4mAW9PtifXsL0C8vCu8hULY49+DRpsizzhs=
X-Gm-Gg: Acq92OFCwYMh5zq8GnJEJ+UWt1g0GQrq0YBY/swFAla7ax4eSTmYkFePVfCibrLOSqq
	Uu3ywIEx+L684nS7yJDzfzWwiwc+BU6sAwypkXxFyejfTfyg5b83IOnSbx0YULDd3A0NTfiS22C
	lEp/boDm3c6ErH4BuMxMFFXQvm6eUhdrKt6o83jF1O20pKiLZxrQzMzUYsfxpTXDIfeYIEqdOVR
	rjGteUFfEa6gQKRv1d3LIJMmF9CJ4NTK47FtACzC62BXZMLC3FpgbaLzMwncAFUJaPDcq26TvBU
	JiFnqaAdYUxTYHJbaa42SrvxjmueDB4fkxAYrs0A2kcNR6JxgrxPLlwo8UHUZmTLNIT8CUycOoM
	gqpqe3HxucEEX0Ptz32UOKAikkx8dcrp0fTBSUm3Y74cm8tOFKTlLEaKxNIdfCbX24ji5lipGeo
	0HtmtS6PhYJ0UMt8w4OITk0VbE
X-Received: by 2002:a17:90b:1fc3:b0:366:16d1:6a26 with SMTP id 98e67ed59e1d1-36a45139004mr1096386a91.5.1779333441193;
        Wed, 20 May 2026 20:17:21 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a4560779csm222458a91.1.2026.05.20.20.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 20:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 23:17:20 -0400
Message-Id: <DIO129TJQ1F9.20NON5EPGLHRO@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] bpf: Add sleepable variant of bpf_arena_alloc_pages
 for kernel callers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-4-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-4-tj@kernel.org>

On Wed May 20, 2026 at 7:50 PM EDT, Tejun Heo wrote:
> The existing kernel-side export of bpf_arena_alloc_pages is _non_sleepabl=
e
> only - it's used by the verifier to inline the kfunc when the call site i=
s
> non-sleepable. There is no sleepable equivalent for kernel callers; the
> kfunc bpf_arena_alloc_pages itself is BPF-only.
>
> sched_ext needs sleepable kernel-side allocs for its arena pool init/grow
> paths. Add bpf_arena_alloc_pages_sleepable() mirroring the _non_sleepable
> wrapper but passing sleepable=3Dtrue to arena_alloc_pages().
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf.h |  8 ++++++++
>  kernel/bpf/arena.c  | 13 +++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 831996c411cf..64968ca6db51 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -679,6 +679,8 @@ int bpf_dynptr_from_file_sleepable(struct file *file,=
 u32 flags,
>  void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign,=
 u32 page_cnt, int node_id,
>  					  u64 flags);
>  void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u3=
2 page_cnt);
> +void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ign, u32=
 page_cnt, int node_id,
> +				      u64 flags);
>  #else
>  static inline void *bpf_arena_alloc_pages_non_sleepable(void *p__map, vo=
id *addr__ign, u32 page_cnt,
>  							int node_id, u64 flags)
> @@ -689,6 +691,12 @@ static inline void *bpf_arena_alloc_pages_non_sleepa=
ble(void *p__map, void *addr
>  static inline void bpf_arena_free_pages_non_sleepable(void *p__map, void=
 *ptr__ign, u32 page_cnt)
>  {
>  }
> +
> +static inline void *bpf_arena_alloc_pages_sleepable(void *p__map, void *=
addr__ign, u32 page_cnt,
> +						    int node_id, u64 flags)
> +{
> +	return NULL;
> +}
>  #endif
> =20
>  extern const struct bpf_map_ops bpf_map_offload_ops;
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 1c0b87ecc817..a811cf6170fa 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -934,6 +934,19 @@ void *bpf_arena_alloc_pages_non_sleepable(void *p__m=
ap, void *addr__ign, u32 pag
> =20
>  	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node=
_id, false);
>  }
> +
> +void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ign, u32=
 page_cnt,
> +				      int node_id, u64 flags)
> +{
> +	struct bpf_map *map =3D p__map;
> +	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> +
> +	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || flags || !page_cnt)
> +		return NULL;
> +
> +	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node=
_id, true);
> +}
> +
>  __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 =
page_cnt)
>  {
>  	struct bpf_map *map =3D p__map;

