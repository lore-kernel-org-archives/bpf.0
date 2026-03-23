Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C12377000
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263580; cv=none; b=Yp8Er9zdD1jAabiA//PK6WjtmvK3a9HqbuEhjCckZ7rjYs5nuiPS4ED2X9X87iPz3Q5ZbSwIE+/VhbRmzuwHVMl/vs6MzigPh3VrDrtuA+vZbr4VoYgUoRvRXi/F1vRKkvU6rP633gu9wD+m2xpK4y7WIW8btfLVJGKqmXPfbYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263580; c=relaxed/simple;
	bh=V3qIVBeIYZc6o6LUFDbfme/F0QW48dL8M3JlrifxMCo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssqQEyiJ62Oga7qPrQD0SqrfzF672AputQwEWHZNSU3H8RJzE1MLEfHYXS/c3JqhdqCp9vIg+4e8wPl7vi70bcToxAK3lbTgflOimLsW1wDJAi/pwaC3bEzRXN5+ZcPaGSssEGQGgIkBLIN8oFdZZTI4MiIoGXXimK3QdBVhGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWseFFTw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWseFFTw"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so3742727f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 03:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774263577; x=1774868377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PdHGJawNgmz3Mnxlo8DQZ2ezVhQNMuS/IKfPtN1AcXY=;
        b=LWseFFTwOjloZ2wNHPfiGJwDkZNrtVdTGAqR9geD3yoY6TrT/zQMTS03ZAqLle6Jvy
         w5vwEwYIsfXWlPqDk9B56vTZJBhvGnd7baMAICJ+zY7R1rWBBz44AZ/crpRkaVyA0zZY
         UE8Lp4LuH5X0QRKPxkfRBrg/2dnK9pvd96T6ICX2P3aNQehcOI29ElPVhpPYPHAwlXFy
         Klv9wRuCR64bS52jwkhT8hH3SA5SBIoZdVDAlt945MHloUYyQ1A3qu2vzHpLs7XrcWBs
         mq0Kqlzy7tXgR8gk9s62mZ6Qc0ZyFufoffOvF2u868pNmh9Sj548IM6Rhw7/4pNjPP4h
         yygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774263577; x=1774868377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdHGJawNgmz3Mnxlo8DQZ2ezVhQNMuS/IKfPtN1AcXY=;
        b=g61Je6U70g5me0ECcqnhHKbNuZ2UDUEdr55u68B3VaGX/17Nc2JBrVaURgf+leXdAw
         JWWQi8xLOtuHHhSF0+CoG2rPbIic0Bavwa/ElXMQ7Dit54U3crAOORQJZzMNS12EN8XE
         KU7j7z9ajylX3cT+Unk03JzDaLla29LOcmyqXCg1J90OA+Yw4UAnkYbm1f7abg6y5EyC
         LwhDJI9BXpufRlSc6IM9YRsz21BQGaXkDE59LIVzByrDaXsAbOXSd7qncpKZ5ahVYFKF
         JznL6s3JI6grIIXKb2VWn2HUKFvS/zWm3WxMc3NVBUOG6X3Z0fsGKx9c3P3yCskamKdI
         +lbA==
X-Forwarded-Encrypted: i=1; AJvYcCXQTnjy3OjrjIiGnHHmIFZROLlptUXzBkkB3IVECBIwv5JtsxOIl0FgClhgNqvrRn5Udf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU0rMz6wFjkATlr5XWUTON5nWn0p0nQJ43XL49UScUX0X1n+hH
	02fcsmh6gc85fKaF4UqA+aNHcF24bdX7h+9M9VrZyhhFJOYGOBB46MqV
X-Gm-Gg: ATEYQzw49b4zla+QH0Yv7y1SgXgOY+oq2i7/nl6cbN0v7T0g9WwTdGj+q0pelRU/eQx
	shKuDyXqaPpclAYi+50qepcwgBmoC2hsP7cy6EWFnlYrqjHx/Vxbf7H6nB1xHCPgw3M5EaCiLcM
	DCshqmht9XFs/Mo416AGQtNRDRfDyG04856lonpcszpw1qBoaig+qitTx27JQ/7zKLGC486kgB4
	fFX7+0SOz9NX46JBHpY3MAL2HjH6EmbPGWkcLdYaVZfD0BCEyzzT8ra3ecOp6pzY0uzhsUnr5Aw
	CJDxvTxg+hyCA0OCwuXPJT5eFKMuvgKAiVTW0yoaKoNZJqxTBaUV+HN+VxrrNrRQmGIHY3VxiBW
	EWBWIWI4XZt+HSCpkd3Lup0hLTwwEzR/NF99B05dAjofjeR+1QWBN/JCqmLKwQwtY6RE/1riXe6
	PyNwTOkRf5IqNu4dx71MbWoRGT8Vo=
X-Received: by 2002:a05:6000:220f:b0:43b:7481:f899 with SMTP id ffacd0b85a97d-43b7481fabfmr6744251f8f.7.1774263577027;
        Mon, 23 Mar 2026 03:59:37 -0700 (PDT)
Received: from krava ([2a00:102a:502b:faa8:f878:ffa9:3b65:76be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0b0csm27307584f8f.15.2026.03.23.03.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:59:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Mar 2026 11:59:34 +0100
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, olsajiri@gmail.com, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	shuah@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: test access to ringbuf
 position with map pointer
Message-ID: <acEdFlYd4UHmknEU@krava>
References: <20260323021839.101316-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323021839.101316-1-dongml2@chinatelecom.cn>

On Mon, Mar 23, 2026 at 10:18:39AM +0800, Menglong Dong wrote:
> Add the testing to access the bpf_ringbuf with the map pointer.
> "consumer_pos" and "producer_pos" is accessed in this testing. We reserve
> 128 bytes in the ringbuf to test the producer_pos, which should be
> "128 + 8", and the "8" is BPF_RINGBUF_HDR_SZ.
> 
> It will be helpful if we want to evaluate the usage of the ringbuf in bpf
> prog with the consumer and producer position.

lgtm, question though.. is this related to some kernel change or
some ongoing work? looks like basic operation that's already
tested indirectly by existing tests

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
> v2:
> - don't set the max_entries for the ringbuf map
> - add comment for the producer_pos
> ---
>  .../testing/selftests/bpf/progs/map_ptr_kern.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> index efaf622c28dd..d7611e7018ca 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -647,8 +647,14 @@ static inline int check_devmap_hash(void)
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
> @@ -659,9 +665,21 @@ static inline int check_ringbuf(void)
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
> +	/* The "8" here is BPF_RINGBUF_HDR_SZ */
> +	VERIFY(rb->producer_pos == 128 + 8);
> +
>  	return 1;
>  }
>  
> -- 
> 2.53.0
> 
