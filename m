Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A473414DE3
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947904; cv=none; b=MhCs7UzSq7CFBBxn+Tzvjb9U8k1pym47FCY1jCq2/2V0ssj1HZc0TSRIvIaanugzI7KPoHLckBX1iBdCZ8WznmeL41xis0KtAPKi2dLE3zi9ccqGtlmt6yWAmLnLUoygFPfuEeSZahUavzdXJREf9lSi97NDVvlQfUhKoLNAydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947904; c=relaxed/simple;
	bh=u+ZBEElfAJ8Fq7BiwKa+i+7tojuy99yuqEYvtggGZY4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8Z59RiNXPUXIMb2/kjD8bU4yIdqF0OMgenURjAwnMo7Y60f8fTZspwQ0qrhPJ/Z9DrXDjRnMfRoZGFs0VOlQQ9jxUimfZ3RTUW0xoXdhQ8dCtnd2J0zxrombKQpayRRTdZomP/xDsCK/2F4EDI7C7xHaCwWupFLg2RArTDbuhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maKLI9Dq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maKLI9Dq"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so23686205e9.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783947901; x=1784552701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c6vHqEs/nvT9xdY9MIonzknsd0pq8kf18zBI3Kv7BPY=;
        b=maKLI9DqVNeSfn4asMB4gKNZJj9rHB6EUyyroJpUcljp0LBTsqqeh7vB7R9TTyYJPH
         /pGOlsrLHQolUDxyND13YRb8wciwlhuTZpCb8VU4tQssLi1yXdUCPEl3MekPS2rruugI
         qWg/6LDbZUEtFTXpG84zDgztX6K8Lcn7sBQMl/SJqC54N/IAQOzGE5xleRBq4Mq/YPaB
         BM6AbP6UFZWip7BjmQVEnEea/5u464z8wW8fpV4+z95HVU11FNAbLUilnp9b1UPyPgi5
         M3WDft9KunU5CS66/gvzpnzXLxKLT/UEIXdgW0oaNrRvzyXgdibOqwull71QWLYipo0+
         uYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947901; x=1784552701;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c6vHqEs/nvT9xdY9MIonzknsd0pq8kf18zBI3Kv7BPY=;
        b=W1FJNd+ho9h77KB5SnpXC+g4nUhj9MFCFYc4cZ2ttgapM+HSZq+HqMnojiXPy1Cvg7
         sIMC5W41NTEvaDEO+N5KqJ4HhV4ObxFsFH4Dqn+L7txoRyZuY0+TICMImVgf7wZfS3K5
         gh0jbY/u+nyrM81f3qNqn+NtrTt3Q5hnJChWrsl6u43dK9pbtf+V3zYee5xTNSZsORqG
         9n6sAlBxP4gpn/H3HcLt5yz4ROxjH+F1fPL0ld7xKn6QIcUSTwW1BAq3KwxvcfojZF14
         BFRk3UcikDZqyeqBGQ9Sw/Ny2ehF6NwN+O5bOsZcfJlJhN0xFRA4CAw8Kn93r0F6FJxF
         riyQ==
X-Gm-Message-State: AOJu0YybE/BcTCXiGbAkDShPNoRmMjpdl6pajxYOkzL+PshkCzpiG4pa
	Q82Wc0XoSo09P6eDwYKT2MwBtzu90YdmkX+dRbf0A7plOv8vDiz3OCj4
X-Gm-Gg: AfdE7cmkWrgljjrR7Bx5GR0w1MnrKwa5yWTyhHa8nYY/L1+aseXaIEE2E3eF4Dfnk5r
	IPgqEjVXCrq78GNoC34c5f/geybMmu0Hv7b47sNyQx7gvicBGtZt7YyaP6hF+CpO796ASdQwD42
	rRkuwCVu9Rm5QFSz5NP7RDF0K/RSF1iAf3ySZcMlgLNYqj1wlFYmrH9snuavajDT8Jx4P2vN4uG
	qDeWPNszr4b3UaWoSB6Iimns9Lr3zeoToe4TMaJxY43hlqurqFds+FLkdLY7mdaBRka5kvFuunr
	mcM9vXsP5T6M0AFt9ro+Vmrz47Drvie1RYgcyEQ3QiTZhYrwmuPXf9w1j3J1TlyOAC4Kfof44hc
	OGMoUS5S22pP346kKKsNOe0OiPBPao2VUM+OrZslJfrnHBbyunESq7Ey+L9n3Gw==
X-Received: by 2002:a05:600c:1c27:b0:492:3fb5:3a17 with SMTP id 5b1f17b1804b1-493f887ab70mr97426965e9.2.1783947901194;
        Mon, 13 Jul 2026 06:05:01 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::86b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3c42sm355887235e9.1.2026.07.13.06.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:05:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 13 Jul 2026 15:04:59 +0200
To: Naveed Khan <naveed@digiscrypt.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2] libbpf: initialize btf_ext out-parameter early in
 btf_parse_elf()
Message-ID: <alTie0_4pu-T5Bik@krava>
References: <CAEf4BzbBqysGiHFuEW0b+tg6uA-gv4s8gGCeF_QZ-L3nhDc8yA@mail.gmail.com>
 <178378853022.49961.12254894397759137901@digiscrypt.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178378853022.49961.12254894397759137901@digiscrypt.com>

On Sat, Jul 11, 2026 at 10:18:50PM +0530, Naveed Khan wrote:
> btf_parse_elf() only stores to *btf_ext once it reaches the .BTF.ext
> parsing step.  If the function fails before that point (open() aside,
> e.g. elf_begin() failure, missing .BTF section, or a malformed .BTF /
> .BTF.base section), the cleanup path still runs
> 
> 	if (btf_ext)
> 		btf_ext__free(*btf_ext);
> 
> and reads a value that was never written.  A caller that passes an
> uninitialized pointer, e.g.
> 
> 	struct btf_ext *ext;
> 	btf = btf__parse_elf(path, &ext);
> 
> ends up with btf_ext__free() operating on stack garbage, which can
> crash or corrupt the heap.  Current in-tree callers happen to
> NULL-initialize their pointer, but the API contract should not rely
> on that.
> 
> Initialize *btf_ext to NULL on entry so every exit path leaves the
> out-parameter in a defined state.
> 
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
> ---
> >From 4dc7d1c8a2a2ec4c00ec038a94a86e26ab6cf75a Mon Sep 17 00:00:00 2001
> From: Naveed Khan <naveed@digiscrypt.com>
> Date: Sat, 11 Jul 2026 16:19:36 +0530
> Subject: [PATCH] libbpf: initialize btf_ext out-parameter early in
>  btf_parse_elf()

hi,
looks like subject/changelog mishap ?

> 
> btf_parse_elf() only stores to *btf_ext once it reaches the .BTF.ext
> parsing step.  If the function fails before that point (open() aside,
> e.g. elf_begin() failure, missing .BTF section, or a malformed .BTF /
> .BTF.base section), the cleanup path still runs
> 
> 	if (btf_ext)
> 		btf_ext__free(*btf_ext);
> 
> and reads a value that was never written.  A caller that passes an
> uninitialized pointer, e.g.
> 
> 	struct btf_ext *ext;
> 	btf = btf__parse_elf(path, &ext);
> 
> ends up with btf_ext__free() operating on stack garbage, which can
> crash or corrupt the heap.  Current in-tree callers happen to
> NULL-initialize their pointer, but the API contract should not rely
> on that.
> 
> Initialize *btf_ext to NULL on entry so every exit path leaves the
> out-parameter in a defined state.
> 
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
> ---
>  tools/lib/bpf/btf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 823bce8951..cabe8286f0 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1453,6 +1453,9 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>  	int err = 0, fd = -1;
>  	Elf *elf = NULL;
>  
> +	if (btf_ext)
> +		*btf_ext = NULL;

there's already this setup in btf_parse and it can be removed now
when we do that in btf_parse_elf

jirka

> +
>  	if (elf_version(EV_CURRENT) == EV_NONE) {
>  		pr_warn("failed to init libelf for %s\n", path);
>  		return ERR_PTR(-LIBBPF_ERRNO__LIBELF);
> -- 
> 2.52.0
> 
