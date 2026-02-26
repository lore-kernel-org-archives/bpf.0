Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B442B726
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131800; cv=none; b=FXzMl0xCiX7cyI8fJWhTNJZuap0bGSqyaAfrxivp8AzyTQ6rfM7hIVYLC5IvM/WLaNEQ9bYaUYxf1Bgxz6UXy7P3DPP9DO9ogE/8tpy4DWHTlZ5h5TTcgZ8F/6fmmh28Hl0CVqpyQrabpS1/Efv0TZtL1o9uQeDkN+HDWN9nP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131800; c=relaxed/simple;
	bh=FpN9EERTp2cRgxv8FwIJtAYQnraM8IhyGexQqnlZvxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SorTz0D33ug4XrU05P8wtwGDGAXYEIEgwAwhHP8Q8kdRmrPmb4CVCrjSawA0iR1DN784epn3zXELWuyb0xPncq0r5+wxJbHDYO1C/LEybveBHV2IsorMdleFEHp+0tDg7hqmVWmKpuCLugl+57nFPHkt2h4prbStDZISm5a4Zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=A0N1iQsY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="A0N1iQsY"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb3bae8d3eso103770685a.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772131794; x=1772736594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNGl2PacRgY/7eEMD7XjUPhLqO/KH21uY3Hc8HdE6Yw=;
        b=A0N1iQsY42dgtKBz2p8VTyl2CrF7Df6aRgM0yWMmfR8QZ/cbjlWqs1zMIvlCxTxtdc
         zdOCyBcuNhGKejE9Il9ZQoJJg58l1s4H5ZKndsWQ3lujGuQPYRDc/VrpJRCQXPArhD9C
         iWrdZup1SmlKVbb/MfTh6wtcWWRIRGD8NVKKByA2ToyCRZAQIDGAnJaTAWyIl2vmbztU
         UMvnSh/Jr+jrIn3sBSlI4owdLBaikWOOSK5offDWHq2Lreb98SP9nL4itZseaOFSshx1
         8FToskLhvz8ccT0K6xx7HDxOX+gUzxP70T006dckRk0KxnisNTDhDc4mcusGcwXjqZ2a
         oojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772131794; x=1772736594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNGl2PacRgY/7eEMD7XjUPhLqO/KH21uY3Hc8HdE6Yw=;
        b=tSclg6skPnp2lpvOX8jsOygGhr3aUS0kgidVNnl7cheLRHZoZPILf2TAph910ZGX1S
         rNWYF1ybyAQY2tn3yQ0Pwf6mPhjBlBPnMI4UBvDdwGEnYVdVhCp3qpa0bdrmk8mzC7D/
         5soTNudedRhgk8JdHf4fOSM6S2o3R5m4ncx2YnxwxwI1nYOs/x5D9L/2oIpFAFlXWuuK
         6viWD1JzrvDvJ7B0eOQjeGHF+uPmOypgrRK5W2CciVKAOAkPejxePwtQaQqzm0x9C3Dl
         W8TKK+kOmLNp1GZDOuH17cKPCvr/HWXkyssR/QUnkKwn2QwYOrzWPTU7Uh0IYqxI9+Dg
         jG4A==
X-Forwarded-Encrypted: i=1; AJvYcCUBh2NHpibWZb+VooEk2Mu5tYu8kp9FR52IWf1OHMCC9qJ9d0D5RgksYlGUsWGcdzuymXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBNxGv32tfsE8o8PKLHSzRDUkCKl4jAAziDAp8e1D1voUZJ3o6
	uFUziQ8GJgmuUPfMQlQOvFOjzrYcdqGCCwv+wjMj9YOkXk4s+6/KPQCzOI/Ut8aAyRM=
X-Gm-Gg: ATEYQzz5ewXFq0uTcm9S3nI1O2SeogMdQKhQ2Gt0fZc3U2FGwBKeRlhWi4gOQRjmxu9
	5UqrlWMOjrapHSE8wyO8u381oNQWRgNV8FCSSg7s81Bk0dyAO/+2dOE9Gsp/k/hVmY55wYMJoyb
	miMHqq+qdKd+1PWlmT1Ip6Af7OwJaNh3s7UVVPz67P6UHZrSuZWXLeCfMOwSy+xzWNSnra2xEFl
	kCtzm3I3ucaIfYgdIVujZFQuRCTYTMpbNybdgDXUhar5mhQjVJ0/ndTlDr5B4uHdBaj85tFZDAZ
	dodVHyCxuYBvsiPZcUlRS8xyxB7GyASiZeHFV2BE3gURi4A47J/l90gSoX620ppZu/EmQhfzAI8
	9YmdD+IZ3f8Y4P/v54kunQXKQlI0BFC5tkR7YJ+/BIQ9wlw/4n64T5Gb2UknJv6m8gRqXgSUv6n
	M++OkIXdmsVYOZmTqFaEieI3E7MuMExsh8
X-Received: by 2002:a05:620a:25cb:b0:8cb:4f63:dac9 with SMTP id af79cd13be357-8cbc8d70e6dmr1400785a.17.1772131793718;
        Thu, 26 Feb 2026 10:49:53 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf746fc5sm268217885a.51.2026.02.26.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:49:53 -0800 (PST)
Date: Thu, 26 Feb 2026 13:49:49 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, ziy@nvidia.com, ilias.apalodimas@linaro.org,
	willy@infradead.org, brauner@kernel.org, kas@kernel.org,
	yuzhao@google.com, usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com, almasrymina@google.com,
	toke@redhat.com, asml.silence@gmail.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
	ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
Message-ID: <aaCVzc2lexW0TiPf@cmpxchg.org>
References: <20260224051347.19621-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224051347.19621-1-byungchul@sk.com>

On Tue, Feb 24, 2026 at 02:13:47PM +0900, Byungchul Park wrote:
> @@ -1416,9 +1413,15 @@ __always_inline bool __free_pages_prepare(struct page *page,
>  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>  		folio->mapping = NULL;
>  	}
> -	if (unlikely(page_has_type(page)))
> +	if (unlikely(page_has_type(page))) {
> +		/* networking expects to clear its page type before releasing */
> +		if (unlikely(PageNetpp(page))) {

You can gate that on is_check_pages_enabled(), to avoid a new branch
in the !debug case.

Otherwise, the MM bits look good to me!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
