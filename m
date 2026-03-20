Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E503B2FD9
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010460; cv=none; b=c3suWbYebpeqcqLyBy6Udh51E7J9QtALfgvEeDAlyC0BFOvHs0llUT44f3XWFbjsOWdz8+S0oyt1ONg/w4Ilg/ZfwSLZwzOsrPVuoRsS+sEZfPZKX9jRz4mde9T9zanNgSfg4AyRcRkRU6//J0H2XFYXAgYmNgkIdj1K9GZfXus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010460; c=relaxed/simple;
	bh=nlSLXtGJiwX9ZtMmKOu07rZzm0ootMaXdI2dBRIMygc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJC2H/L75mONlgAkt4K150HgeCqKhfnkBGafzjHO1vXXBoFZ3Aci1dafzvBO647NI7Hdz3m+G0mhfbNSxdo6qMAvs4f35oq5g4WYtZ1EYGy4IPOBAxrYAzl7Ob6tij0R3DECAi2gQovsRvYNzORV/DkyP+gW1im1Cpk9CQxTIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFRNvwg3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFRNvwg3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso17534185e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774010453; x=1774615253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KKuF987lzPL37cu98t8t+5v0Gzw20cN38RF+tKv41j0=;
        b=CFRNvwg3LLe/nUyRzS5q+HRWcw0XLKLSI5ApbS7H7igYRGZZrz/HL4BDkJw+5Gu6sh
         BFDwwaRQejNyHG+ZV6n5lTTVJoDEaWQ3udFrpSAuq6HTI3svn0BCCHD61qaAjzWjjLRX
         hDlnUhfqnYLe091BXU+4zdVhGz+irylvUIG8UUE7I+tWwTiSQ7RhFue3i12fdSy6e734
         xtABMxXLNC431xxzaE1VEckPTILAc4y3VQ/PL9FSt/OUDNq9KQzWob8zGjE9jEeHIZeK
         GlxHlcJr4uqDS3buC+nzxUvzNNXcAiCqFCYQcVpOkzBkqOT9B7mNUIbnqHS9cO4QYYXC
         /Sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774010453; x=1774615253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKuF987lzPL37cu98t8t+5v0Gzw20cN38RF+tKv41j0=;
        b=F+DmdckkwzJFoJBh24LBhRVK/OZf1jK4gItnNVHc7L7Kmhr/ltDHtWaLRoT8dlw149
         93Z39PhYFeydTF3gI8c1XiMwLugzPMKJT9kGjcv1Nv0feyM1teLQK2mEK8/1Ju6KhASV
         b6c8NsmHqABaBYAk48GJBytorb2QjNM/2ra1E7WSC8LEdsamjRlXyrSDQtXdHvt06xgk
         lUhMfULLU6vggfKFhPnhB9ZyWbK4CPHWSZuilmKxwcWpfZZZcVwP6KvJ7YS7eEemJKUl
         X8hK/PkqWQ/SbGJhZxBe7rTUG4Jcm7jI4W/Ov3wbWo7t+r/BKr9wNkl8hB5i68rAG3ZJ
         jbTw==
X-Forwarded-Encrypted: i=1; AJvYcCVwXAEBhWmKBd6dtAt+0CsPVxu1732H1PKhoGKVrf6oOciBQFNBPdanQpFQYHd8kdwGX3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YymBmjYScysmiPoTzSuoVsVHxC8QN0MlduzastbOiqq50FJod2a
	+WhdY7LykZweGvOXCCn0dvPfmOW0LsR/660Uotg4rF69fy4OZvt+l3rJ
X-Gm-Gg: ATEYQzz2PP188NhtFkK7oxgJskpRDfcOXMz9OcQgAh9/u/eKTBXXhHjroaulg0RLcAO
	VPPmMZXpIZKenf2eTIHxp7kPYEyCESsF0QyW0N00pygu0jvSaFOaUxH3Hfhw4ePq7UOLPMgxJMj
	UmKbP5kec4ztlf912YSULfGOrcYXN/1EUg3tvGDIRJvmvNopEhCEWafjVn5vW4hpONtEQMn5aJ7
	aoUcqefr/eKB3fAdH5BTadosyR2VqhCBBPOZ9476DIPzcvuPGD6Lw6mGN+BEKeM9AQlTf0F8zeW
	kEYwfXWPAdiJlEf5Lu94llTGpmM6MN2Aai/KMAqrHna86SJtlKb3uqTuuAhGwvGKud233R7DYFU
	Ai2/49ji/TIgetTSP+G21y/HDgs5YSDJOBoHpeZuizbDGNXoseeHDeI4XD3IhtuMjgeGTpkmo
X-Received: by 2002:a05:600c:c111:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-486ff024da8mr29812595e9.20.1774010452991;
        Fri, 20 Mar 2026 05:40:52 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7d6c54sm146845355e9.4.2026.03.20.05.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:40:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 20 Mar 2026 13:40:51 +0100
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	shuah@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: test access to ringbuf position
 with map pointer
Message-ID: <ab1AUyefoWABRs0T@krava>
References: <20260320084155.288417-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320084155.288417-1-dongml2@chinatelecom.cn>

On Fri, Mar 20, 2026 at 04:41:55PM +0800, Menglong Dong wrote:
> Add the testing to access the bpf_ringbuf with the map pointer.
> "consumer_pos" and "producer_pos" is accessed in this testing. We reserve
> 128 bytes in the ringbuf to test the producer_pos, which should be
> "128 + 8", and the "8" is BPF_RINGBUF_HDR_SZ.
> 
> It will be helpful if we want to evaluate the usage of the ringbuf in bpf
> prog with the consumer and producer position.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  .../testing/selftests/bpf/progs/map_ptr_kern.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> index efaf622c28dd..c3fa57ec430b 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -647,21 +647,39 @@ static inline int check_devmap_hash(void)
>  	return 1;
>  }
>  
> +struct bpf_ringbuf {
> +	unsigned long consumer_pos;
> +	unsigned long producer_pos;
> +} __attribute__((preserve_access_index));
> +
>  struct bpf_ringbuf_map {
>  	struct bpf_map map;
> +	struct bpf_ringbuf *rb;
>  } __attribute__((preserve_access_index));
>  
>  struct {
>  	__uint(type, BPF_MAP_TYPE_RINGBUF);
> +	__uint(max_entries, 1 << 10);

do you need to set max_entries? there's already check below
making sure it's 4096

jirka


>  } m_ringbuf SEC(".maps");
>  
>  static inline int check_ringbuf(void)
>  {
>  	struct bpf_ringbuf_map *ringbuf = (struct bpf_ringbuf_map *)&m_ringbuf;
>  	struct bpf_map *map = (struct bpf_map *)&m_ringbuf;
> +	struct bpf_ringbuf *rb;
> +	void *ptr;
>  
>  	VERIFY(check(&ringbuf->map, map, 0, 0, page_size));
>  
> +	ptr = bpf_ringbuf_reserve(&m_ringbuf, 128, 0);
> +	VERIFY(ptr);
> +
> +	bpf_ringbuf_discard(ptr, 0);
> +	rb = ringbuf->rb;
> +	VERIFY(rb);
> +	VERIFY(rb->consumer_pos == 0);
> +	VERIFY(rb->producer_pos == 128 + 8);
> +
>  	return 1;
>  }
>  
> -- 
> 2.53.0
> 
