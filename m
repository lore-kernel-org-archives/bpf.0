Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3BC36655D
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041256; cv=none; b=WWU2FsWcaV0bc1fwczUlky6IeU7CkHl4vyFguQ4UhJd9V/jVbkQLK4/X+LjC8P/ux1RxxgxOtlEACsfgTq0nXpGmnXItfp4bJNaQcf93tLCU92QeiA5QBwHrN6qq2nO2xQub9msCwct2WePjvg7o6kgpqQWFzIc1LCdnCGrzHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041256; c=relaxed/simple;
	bh=JXcJhABIEjH+lmBqHEkBKtdK9Ur4sjiH0izWhp1DPos=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OhdUJbwLOWFxqM1otXe7VPdiUko5AbvbuRaFen4LjfYFUUCMvJiG/K8qzKmjNmmfhfxCRNMM/ccdY9YGhoAkS1ZEh0Dbu/97JQb7+hDXAJvGXUF6VqszkQWKtsaM5nyb1B2wuPCmpFcr/r3BaFMzAZLMvKG49G5v32I6gRyWDoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjBW3vf5; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjBW3vf5"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69de9bc590aso4424166eaf.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781041249; x=1781646049; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lk0DNlEdT7SDazOz1r+23axga6IAJK2oAmGhdBK/VmQ=;
        b=fjBW3vf5QECJAX3QSFquS2FuhvINtaeNn7Bzzxt89ZwLyZr6aQtJfUhywphll0IFx0
         b83qtlDYlS9YSaahfuGizUr2cat/PNF/QuphkgINxf3XBXgiuxXM/NqHccyrGTQ978Ki
         o9W5fFZl1iU6PQgQlaZRgnxxRqZio+YjAnkPBTOyob+H/q9E2q+MbbyV4kLenwgvLwqj
         xSj2qwyR4w3NymA2olA4XPmvyPATb1lnRyZNWNIWGA5CH08U4b0WHCmBW1iExv+bH1oQ
         Gh3qaMFR7B46FL4HBHysXfNs/V/nNa0gaVtmjSMwNSWlwHX6OqOM1tzIpAAMTnMtTme2
         nVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041249; x=1781646049;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lk0DNlEdT7SDazOz1r+23axga6IAJK2oAmGhdBK/VmQ=;
        b=n5M10DsLQiFDXzg1ECjgzEdWpk8urpz+5hvXIncbXJNPgvQzLoFCGtgZsSbAkPeeF7
         S9kUO+JV0yAHuFgkuOXQKYHCESGlsFHvaS1eji6Z6/Blb1Fk9aSaM4PyaxV8d3Mrkk9t
         m5jCfyHMnGwZMCvqAQaZRZuyQ3JXX5jwvTyiRm9dpsCYsmYnXCQP+XIFW/x49Anr03qo
         cxzbq9lQGCLkeULjdrSB2YH3ZPPVlquyzwASUspQBQX335KD2Y0AzjwIWx1XkYnFF/aN
         ARbIZryyrfL1A97pEP67ditGwm5UHAblG9qLZZ4ejAOAkhuS9uJ6ZaC8BkLh51+G8fVD
         WbmA==
X-Gm-Message-State: AOJu0YylB6qHdWBpHTYnUS5NaudcKNnjszDBZuhzCi/fZ7drfoJxtOlj
	xXccmgm3mbCFk9DgA3ELo7K3P1tS6wWrBQ/0BLUZB6RAO0Hpa40TRic9O+oZYg==
X-Gm-Gg: Acq92OG0FqxehjZlu5r4hXmpG42OZhgVH/+bq8sp0OX8/3d0nqT6YHznDOLxwcrHHNL
	lK49WCE+VTgmdyGdMuwcME6xVfEQvH85fS4fupQD/nMaIzNRaopMEcXx97lHlnki5YQo4p531ko
	hoPNLueooHYcLuyJICyDr2NXE5+BQtWp+emP0MZYQ/qH81+fuNBfQhbLM3neOsz7eE7lpdzLtgj
	RKH3eHAekrLCyDMIMaBlpUYPPkHOUVxu/E9uKujsBnN/bc2wVwSkRfuH8YrkQ46ok9FqmeVGr9l
	5+uR8ZhG5dGCO2hkslDw2OIlx1p9LXMbxbn1NyLvvRUARuJBO1kQBZS1TlfMAB8uY4wapiCF9SY
	Wv/yGEJfJFcAf17DP4VXc9gKKNFuO0V/g87U+JmBg0JMb+Y6Qk4kK7FDCas/08t7eEeg6oAY5bc
	qFQdHO5oo82yFP5f6+gDh1rH4FWXNxuKgGvdfNllwb2sZCWqH+ohLvxlKBFU5XFHJDfmind6uou
	U7mdO7LfHDDGX6NIEdAsePcgVQ=
X-Received: by 2002:a05:6820:4687:b0:696:1e45:9011 with SMTP id 006d021491bc7-69e68c1cdc9mr9562815eaf.28.1781041249369;
        Tue, 09 Jun 2026 14:40:49 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8465e00sm16809428fac.15.2026.06.09.14.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 14:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 14:40:47 -0700
Message-Id: <DJ4UFHVC47AJ.3J6SQJ07X0ZTO@gmail.com>
Cc: <bpf@vger.kernel.org>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1] bpf: Better build_id caching in
 stack_map_get_build_id_offset()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>
X-Mailer: aerc
References: <20260609210749.3448062-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260609210749.3448062-1-ihor.solodrai@linux.dev>

On Tue Jun 9, 2026 at 2:07 PM PDT, Ihor Solodrai wrote:
> This patch is a follow up to recent implementation of
> stack_map_get_build_id_offset_sleepable() [1].
>
> stack_map_get_build_id_offset() and its sleepable variant each cached
> only the last successfully resolved VMA, with separate bookkeeping in
> each function. A run of IPs in a VMA with no usable build ID will
> repeat the lookup for every frame: find_vma() in the non-sleepable
> path, a VMA lock and a blocking build_id_parse_file() in the sleepable.
>
> Factor the per-call cache into a shared struct stack_map_build_id_cache
> with two independent slots [2][3], used by both functions:
>
>   * resolved   - last VMA that produced a build ID (file, build_id and
>                  range), reused to skip the lookup and the parse;
>   * unresolved - last VMA with no usable build ID (range only), reused to
>                  emit a raw IP without another lookup or parse.
>
> Keeping the slots independent means a build-ID-less VMA no longer evicts
> the last resolved build ID, so a trace alternating between a binary and a
> region without one stops re-resolving the binary on every return.
>
> The shared lookup tests [vm_start, vm_end), matching the sleepable path;
> the non-sleepable path previously reused a build ID for ip =3D=3D vm_end
> (range_in_vma() is inclusive) and now re-resolves it correctly.
>
> [1] https://lore.kernel.org/bpf/20260525223948.1920986-1-ihor.solodrai@li=
nux.dev/
> [2] https://lore.kernel.org/bpf/CAEf4Bza2fRDGhLQoPE-EzM7F34xaEJfi5Exmxb-i=
WVUN3F06=3Dg@mail.gmail.com/
> [3] https://lore.kernel.org/bpf/CAEf4BzZXJFr=3D1iiVx937ht=3D4PYQkQHg=3DeF=
k810zhMDzXQG3ihw@mail.gmail.com/
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 169 +++++++++++++++++++++++++++++-------------
>  1 file changed, 118 insertions(+), 51 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 77ba03216c09..6a642d6526c0 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -175,6 +175,82 @@ static inline void stack_map_build_id_set_valid(stru=
ct bpf_stack_build_id *id,
>  		memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
>  }
> =20
> +/*
> + * Per stack_map_get_build_id_offset() call cache of the last VMA with a=
 build ID
> + * resolved and the last VMA with no usable build ID.
> + * Adjacent stack frames tend to land in the same VMA (deep recursion) o=
r the same
> + * backing file (the main executable and a few shared libraries), so cac=
hing the
> + * last result of each kind lets us skip the VMA lookup and, for the res=
olved slot,
> + * the build ID parse. Tracking the two separately means a build-ID-less=
 VMA doesn't
> + * evict the last resolved build ID. A zero vm_end marks a slot as empty=
.
> + * resolved.build_id aliases the id_offs[] entry.
> + */
> +struct stack_map_build_id_cache {
> +	struct {
> +		struct file *file;	/* pinned in the sleepable path; NULL otherwise */
> +		const unsigned char *build_id;
> +		unsigned long vm_start;
> +		unsigned long vm_end;
> +		unsigned long vm_pgoff;
> +	} resolved;
> +	struct {
> +		unsigned long vm_start;
> +		unsigned long vm_end;
> +	} unresolved;
> +};
> +
> +/*
> + * Fill @id from a cached range covering @ip. On a hit this writes @id (=
resolved
> + * range -> build ID + offset, unresolved range -> raw ip) and returns 0=
; on a
> + * miss it leaves @id untouched and returns -ENOENT.
> + */
> +static int stack_map_build_id_set_from_cache(struct stack_map_build_id_c=
ache *cache,
> +					     struct bpf_stack_build_id *id, u64 ip)
> +{
> +	if (cache->resolved.vm_end && ip >=3D cache->resolved.vm_start &&
> +	    ip < cache->resolved.vm_end) {
> +		u64 offset =3D stack_map_build_id_offset(cache->resolved.vm_pgoff,
> +						       cache->resolved.vm_start, ip);

empty line is needed or move 'u64 offset' out.

> +		stack_map_build_id_set_valid(id, offset, cache->resolved.build_id);
> +		return 0;
> +	}
> +	if (cache->unresolved.vm_end && ip >=3D cache->unresolved.vm_start &&
> +	    ip < cache->unresolved.vm_end) {
> +		stack_map_build_id_set_ip(id);
> +		return 0;
> +	}

Please declaude it.
All the derefs can be shortened and more human readable.
For example: give struct a name:
struct resolved_vma *res =3D &cache->resolved;
struct unresolved_vma *unres =3D &cache->unresolved;
if (rev->vm_end && ip >=3D res->vm_start
if (unres->vm_end && ...)

or any other option. Just so that code doesn't scream "claude's slop".

pw-bot: cr
