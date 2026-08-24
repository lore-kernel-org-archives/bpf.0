Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D32264C7
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609733; cv=none; b=FiM2JZKa84SW+hfMKP1VL5/zu+gBjEYK5xn/8wjBJiPmzZ4rUdMZF5/j669ZDNsRYbErEy3jvbQsJKdg/OAuXhyWfcaUaNwP53jr93W+ok7rP2wWuEAmiaMeDwdf0IPkai0Ko4irmNtd8rwLSJfJg8piofYpL53MfaU+2U+KT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609733; c=relaxed/simple;
	bh=gnQzKmA6OB26ji3EHgJCq7ZNC2QGkfefmJ9egWp2efE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oo0Ha+oppXnGIZ1KfDIwKsWQS/3hEzjY7Jh+K2xJ7Ri3P3Ba+nwf9VYfLJ3rROoKJp3Vm1cjZslscMbuHEOaeaFhHC7F0zuqQtnuVdm9FVVS+czDqoGfOoR6UcX+7UUaNLa7yOgGc6uo8HpYb9e2htqiifhxFVHLvkYsBkWQEW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5/UkQrS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5/UkQrS"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e7109321dso2915543a91.3
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787609731; x=1788214531; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qCca0udm2f3qa1do9wIRs3l9naTyvstBQVl9fK5YRkE=;
        b=q5/UkQrSNmF8Sy3uSlzA15y4RrJ/B+fMa9chA/Sgg+Y3QuO1oGGjVdmxYcO3QQk/4E
         QDxvY2uT/kRRvpXrfn8GPg+aJ1xDz09VWGk1fnkwjU1eL/1wpERKGm1GQnftTVBjPlWU
         bAh/mAuWR748S6SSX7JHvYZa4kYOTZbMDNN4P3cnl8fa0wro5cYIJ/fZtcmGEhiSWPM3
         9fBIk06cA46Pb9v/76UqIOEwtcPewIZm2uScDFoJWTu/XxMvN7KrGocE9N6Ss3WW38hK
         MbimOrUxFdijEz/ZadtLsdQE4lmWLgJTZGP17OZlPtCTLBEwNm3SMUNJuixzQ0Ge/Oap
         TJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787609731; x=1788214531;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCca0udm2f3qa1do9wIRs3l9naTyvstBQVl9fK5YRkE=;
        b=Ct8EW1KebiXf+NC+23iOG0hSbihBmJUB96PJ0zpUfY68xENUJQGwWG9TPG3HvizdKC
         Dt3winKc0pg4MOFWUeUBzzcc09pzdx0Rf0IEbxp6N/sUxStdM48uIjN08EbwSzlUhYD3
         qQ2bLaoDORyJzH4jiZ2I/mPoOpe/nx1dTUHMIs0YbHwCCIlDy3O6Msq0SURWmtwFxjBU
         bNkHrc3EXgTDgKF91hEYrp2PXs5PAqXcJbJ7hpzMPAyMjm5pyDMu5gxB6Z+U6jD3tFVV
         Dvp1HVOYHLhJLI2gOAaBzhh+4QDHv94ag+VuWsdG9j14TGcL4YJSFHrU8/lx2AHzQzVQ
         TcSw==
X-Forwarded-Encrypted: i=1; AHgh+RqTJqZcjg72QEGDisiAr0vReBUF1+3UfAbuO0j9i248HcVThUaoT8GomGAC62PHUx0DfUc=@vger.kernel.org
X-Gm-Message-State: AFuF++nKRNFN+EkliXMZ46z7iBr/JQerTAz9baJd2hrz1bzKqH9csx1b
	MqdinR69hK+IJ5F26tSm5G4L20UasPnMkrWnUUQ/xr+aQntngLh8cpml
X-Gm-Gg: AR+sD136v64jCe+SEFc77jKHFt99M81VO1ppUKG3NJi63CPxSSHDP8ommHOVpEN7fab
	a7y6NZ9tlKnCYqwGw38Lh7qVHXN+nvZDNygDwepVIZBknQI5H4RImHi6Uf3ZWrE/Gv4S0gD2tHt
	ln+k58j6PD1/Dmxi3//AWiARUuczT2Rtc5+JVz36/wUXelbJ4jKXx7nq+otDVs17ONd3z0ayfdt
	byb2xz2isDO2XeEpKFQma5fKtLlEJhUAUnrr7OXastdfD+X2Kn1GFBH2CldtCva0VYpNUYw1DdD
	Bn4NL5kPVj+b/goBvEjO64dOmCskz8FHhDfhuZB8Q9dejU70ukUeX51Ps2042q51jYO1odg0mOk
	YTB5yTdogLc1VBPBJO2s2BkOzDM3LzxwaO9g4RyY/ykN4wOi146IAiN7BAwlUImralk519U/zkF
	6N/C7aKCYDkrIUnSk+InYXjewkbsTXDV/R0xXK9V1lgwn2h6C3JwqlJjgZISj6ywtAkaJuxLDHs
	3O0WviDg1of1l7fNKyTFa/qJ5yQrb403GidR/ac0tBaiX8MASpwsCpYHg==
X-Received: by 2002:a17:90b:2e4b:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-396464a18c5mr3950513a91.10.1787609731381;
        Mon, 24 Aug 2026 15:15:31 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860c6989sm27865792c88.2.2026.08.24.15.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:15:30 -0700 (PDT)
Message-ID: <3bb599fb6840c650c8408054bef8cfbcba0f8878.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 11/14] bpf: Replace arena kfunc argument
 flags with suffixes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Date: Mon, 24 Aug 2026 15:15:28 -0700
In-Reply-To: <20260821233516.3426127-12-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
	 <20260821233516.3426127-12-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-22 at 01:35 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..6c34a0d34b3f 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

...

> @@ -1082,14 +1092,20 @@ void *bpf_arena_alloc_pages_sleepable(void *p__ma=
p, void *addr__ign, u32 page_cn
>  	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node=
_id, true);
>  }
> =20
> -__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 =
page_cnt)
> +/*
> + * A valid arena address can have zero low 32 bits, so ptr must be rebas=
ed
> + * unconditionally instead of being treated as nullable.
> + */
> +__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__arena, u3=
2 page_cnt)
>  {
>  	struct bpf_map *map =3D p__map;
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> +	long ptr;
> =20
> -	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
> +	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || !page_cnt)
>  		return;                                      ^^^^^^^^^^^^

This is a behavioral change, as far as I understand.
Is it intended?

> -	arena_free_pages(arena, (long)ptr__ign, page_cnt, true);
> +	ptr =3D arena_kaddr_to_uaddr(arena, ptr__arena);
> +	arena_free_pages(arena, ptr, page_cnt, true);
>  }
> =20
>  void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u3=
2 page_cnt)

...

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
> index 815f342eb4b0..d76490e059f9 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -445,6 +445,8 @@ int iter_maps1(struct bpf_iter__bpf_map *ctx)
> =20
>  	if (!map)
>  		return 0;
> +	/* Associate an arena before testing the generic map-pointer path. */
> +	bpf_arena_reserve_pages(&arena, NULL, 0);

Is this behavioral change intended?

>  	bpf_arena_alloc_pages(map, NULL, map->max_entries, 0, 0);
>  	return 0;
>  }

...
