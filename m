Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B6246AF19
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934870; cv=none; b=E8a1AxL/kQU+NJ3xMiSeoN8DDbsJjQh7ZTdt3ipvdogdlXoS3Rr8om/CA90qtDH0Wk7u9MfNvXtv3u5VzzjErQS1Idi+vY/YZhkGZh8jsCqepbNCU8SpKr66GYVBBiYkGUm1NUX8a+EZG/Nd9YYmPsPBYUIroCV6B6L/mKSweew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934870; c=relaxed/simple;
	bh=CDhyY+lp92Rh286QAW/XP/ZhroygHch5zAJeleD2L8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEGURaj+3ogb1KGSWLksf1E7Nl/K1KC7n/SAW+LlanBMmni0pQVxSO8bWmPKpktDoITh6WmfUcdu72Do20apM0Yz9+ASjpTDzaWKDv3UHiJvFluK8TiGQVEsjHd/k+L1gaRyWfR4b/e+vevZ0ntCuLmaK+Ptjn9CxhzWEQ8k5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7cfd819ae5eso2907472a34.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768934868; x=1769539668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyvv5bVOKq5q2ikgZwkotwgP6l+kB/mtu+tHV4I/d8o=;
        b=lbvLCGgNhkUCwKT0FN36qtCK6f1vutTKoKf0+Lf/0XhYHDXpazfELQVBLURtb+QhJL
         +lmmWtPJ/UmYCo1MZIKjdvCvEsNZhQH8UWUORzWCfjF5SMWQeC071hLu1l2WUPXlczeU
         1UZgNSgURpVoQOCg87NkBYOQULnWrE3zjJCXWtGcS2s1z8D4BKSITcXaWOkBrEMpxtIW
         wawUDa8I9rTJ6OwSUjO4Hygqn98CIUKeHWOcTz94XxkFsW9s/q60DoW8ypgjzN8ls8/B
         8kt8CxpuzPpjZbF1Vq4/iViKwNdkFNwydqZ79P6NsKmQm8JHT2XNJ3li8C55Wp4cfRH0
         NO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0kzzEr1rMHHjqrhTgHixtN4awYhgqT/i2vWG2E6pNtLlPWEzg+aNh2qtrN7WoERbKAGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpBHgbyBkLYHPv5Am3Ulusn2n62h4VWKO2aF5TBhHPAj2r0gY
	OlfM7YFuely88G4qD/zER78yt+LYX2arg4v1TRqRSPnoKMHjKFOfptnD
X-Gm-Gg: AY/fxX6a6o5WCk9w6WB9HE6/QCtelvjB0Gzc7Nm8hZlFfHbXHUU0CrYEiQ8oVWFBGKn
	SDGzZv0tD6uzAoldUA47flEjpkdsvkstHv0uH99Fg/+O3oi4IGVtVNp1he+VNb8DJqYNBAGR7t/
	5I8PpkBPkzDuiZhxnCpOHvHjqaZjVWUqbIYchJ9+gowHoxLlW8pzRCJumKCK+BQaw9AYkRTNg1+
	TF3YVy8oJ98omQaf58zSJxt78rTLMk0GRQFephlx/VHuzqE8UdkXvVGhDsMo0yAE9KwFDDIj2RV
	M9yPQ1q9zTCXIIymd7IbO0oMQXYuho4zf5LAsNklwg1zYCbF3f1S1Cxc7AJ3ou5o4ZRznyCLZmi
	YtuFBWQfMCCEX8c74IqqEzEzsRkbMKMu4DM7R3e9QMCxt2hqbhJA/8WXchHvpUt4v5w59f/hjnC
	FQ+A==
X-Received: by 2002:a05:6830:3986:b0:7cf:da97:57d6 with SMTP id 46e09a7af769-7d140a3d3c9mr1655270a34.6.1768934867912;
        Tue, 20 Jan 2026 10:47:47 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0e956esm8985236a34.10.2026.01.20.10.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:47:47 -0800 (PST)
Date: Tue, 20 Jan 2026 10:47:45 -0800
From: Breno Leitao <leitao@debian.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 05/21] slab: add sheaves to most caches
Message-ID: <aW_NK2NXVgtuzCVH@gmail.com>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-5-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-5-5595cb000772@suse.cz>

Hello Vlastimil,

On Fri, Jan 16, 2026 at 03:40:25PM +0100, Vlastimil Babka wrote:
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7863,6 +7863,48 @@ static void set_cpu_partial(struct kmem_cache *s)
>  #endif
>  }
>  
> +static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
> +					     struct kmem_cache_args *args)
> +
> +{
> +	unsigned int capacity;
> +	size_t size;
> +
> +
> +	if (IS_ENABLED(CONFIG_SLUB_TINY) || s->flags & SLAB_DEBUG_FLAGS)
> +		return 0;
> +
> +	/* bootstrap caches can't have sheaves for now */
> +	if (s->flags & SLAB_NO_OBJ_EXT)
> +		return 0;

I've been testing this on my arm64 environment with some debug patches,
and the machine became unbootable.

I am wondering if you should avoid SLAB_NOLEAKTRACE as well. I got the
impression it is hitting this infinite loop:

        -> slab allocation
          -> kmemleak_alloc()
            -> kmem_cache_alloc(object_cache)
              -> alloc_from_pcs() / __pcs_replace_empty_main()
                -> alloc_full_sheaf() -> kzalloc()
                  -> kmemleak_alloc()
                    -> ... (infinite recursion)


What about something as:

diff --git a/mm/slub.c b/mm/slub.c
index 26804859821a..0a6481aaa744 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7445,8 +7445,13 @@ static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
        if (IS_ENABLED(CONFIG_SLUB_TINY) || s->flags & SLAB_DEBUG_FLAGS)
                return 0;

-       /* bootstrap caches can't have sheaves for now */
-       if (s->flags & SLAB_NO_OBJ_EXT)
+       /*
+        * bootstrap caches can't have sheaves for now (SLAB_NO_OBJ_EXT).
+        * SLAB_NOLEAKTRACE caches (e.g., kmemleak's object_cache) must not
+        * have sheaves to avoid recursion when sheaf allocation triggers
+        * kmemleak tracking.
+        */
+       if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
                return 0;

