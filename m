Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF63C76A1
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405340; cv=none; b=AE65ghHmfVSTX99N9I3nkLOOpPJbnV1w0FC2u6llgvmdfCGGDOZizaL9jVMGvTHHNatPHbdTKEiwY8f0b4PXXmPVvVcnwQWWdOJLUE+L6i6tgGf6DRUtipC+OTvCUY5ODXB7mW7Qi8o5pL4CUDr8GtjrsvvPCfSmQoA2TdQ22C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405340; c=relaxed/simple;
	bh=13Tv+Z1spZT5uGkt505TWNW+HVbJyhrxpNqZ4YKbgcs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbEe2uPU4/O/SbnsBO8ZsOIxO+Q8vxwyPYgSaZOZAE4uWK+Rb4OZnDvOUUMpEL08+hyouQ50LCZS8bbuKmJ14R5mXwFRDIe+8yBRuplg50Xw4L3sVfJWn0pB6GjRKBknh2nKIuh4XK1gmOyCg4eKTgKGwtxof6FJzLxX/w7hyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5hfIChx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5hfIChx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b3e03939so3363625e9.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405337; x=1781010137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItCSA6VbxzXe3LEvyJ0NVDfAgln05Oan0qOsUww/kBc=;
        b=U5hfIChxgQ8Kkn9yMnXn/WZruExm6faRpO5v4kGWi6I53cS/6epzrelY3AVXqK5Vzs
         BxlLXrHVQ8XPSzI7l3DSA9KU9dcPrcHvZ4QMP8one4fsUnAx/SgQsouGdxJ9RipVstRi
         oV4pIXQIcVK/bb0YjIZUQBIKSXjkaGCTXu1aqH1nneVXKTQMVLluzOYTQicCL5Djwi7C
         kQJT5e0kRNefZTuKUa1wpFb+Dk1bAMxjHNso2AaJDlJoe1MHuQspdmtc6ibkSi+f2AEv
         6ns/vTv/20QZZLlsjelSWPUzKn6JESQN8lTHUY2et2sC3shz6D8xNICSGHGKGQNqHHIt
         B2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405337; x=1781010137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItCSA6VbxzXe3LEvyJ0NVDfAgln05Oan0qOsUww/kBc=;
        b=FNkVXNwzJ3KCmouVRr6LYkFKAhFupPUFmb6amEXnLESAXfgZ9hJuDsEAat31+N/Lv+
         WgwKpp34+cXQmhgk8dNQ1OWAmW/oZK0X2yMic0nGp5pA39VKgcpsU0LWy7uzXcaxN8ax
         xSBEpKVZq7V2mru8hhK/MuTTPyQOkbvBeN33GqB4zZH0nQgme6nLyTWHmoZQbSbg+EbT
         FWljKST4r8yZv/3LibVtlqOEs/vcxXEp/mIYrUceycq3n6VSB8pxmGHGMeZciPDTU89B
         HU4fIKMvxWao6BGleDeg0K7XzekvJJsT/6i8pItGOUx4mDCaCYSbiFV3J26d/mt/JRVa
         PKAw==
X-Forwarded-Encrypted: i=1; AFNElJ/EsWRk5I62MEJWNUUbq7HBN8u+0WeNPhUWUtC27GSOZYb5+quN/kYpVQ2AUr1MGJO+mt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaIqZYU8T87L+Xibe5QzG2zjHQXPw2UvkaMcM1gfqT+F3qbWjI
	4V6dRh3Bfno05QYBZKzKSKIHHKdeisybGIjO5ZIF34Jf/30cGkLL7XM4
X-Gm-Gg: Acq92OHPTlPafgQDHah9fC2gplrmcaml7kF9lAknldcZgm93SSmu2+1l56s3Po84Hvv
	UgD2RiMsPGqO8tpQWTk5yL/kCqyP8LpchI6WGwJ/AGyS8s58SjH3B2GZWx8peeqxu0TZl1hp6Fn
	FQ0TFpzFHGxSmH3I8w53b0401wGidnXgoxRLCN9PJPQq/teHN4ZVgyym8dvG+Et5OxfBqiWL1YP
	Is6vcpRwIpw1VRrJRO7grUQEHjCnmhYd/kz9xDPkv60PIMaHxtHDZLz9kiFoQak6wHosC7ETvUN
	CaiWSM/IccbxJtMS0PQoKHRz23Lmqes9sPcOtnVQhqpMbk67XS3jEY4h2OAtyJhPCpISGybScpP
	SFuXls+GnhnvKOC1AWD9E6TCaCVSOxFvitEhGGHOyuEvSRSoDZQILjsAoNdff3PJBK8xU5x8FPY
	GUq0WJ+w4NYrKRMBRzyDo0NA8Up6M=
X-Received: by 2002:a05:600c:c3cf:20b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490b0e6014bmr44665745e9.6.1780405336989;
        Tue, 02 Jun 2026 06:02:16 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490af5f99dbsm26881425e9.9.2026.06.02.06.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:02:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 2 Jun 2026 15:02:13 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 02/14] selftests/bpf: Modernize
 resolve_btfids test scaffolding
Message-ID: <ah7UVZLgsBcLDnkJ@krava>
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-3-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601221805.821394-3-ihor.solodrai@linux.dev>

On Mon, Jun 01, 2026 at 03:17:53PM -0700, Ihor Solodrai wrote:

SNIP

> -static int resolve_symbols(void)
> +static int resolve_symbols(struct btf *btf)
>  {
> -	struct btf *btf;
> +	__u32 nr = btf__type_cnt(btf);
>  	int type_id;
> -	__u32 nr;
> -
> -	btf = btf__parse_raw("resolve_btfids.test.o.BTF");
> -	if (CHECK(libbpf_get_error(btf), "resolve",
> -		  "Failed to load BTF from resolve_btfids.test.o.BTF\n"))
> -		return -1;
> -
> -	nr = btf__type_cnt(btf);
>  
>  	for (type_id = 1; type_id < nr; type_id++) {
>  		if (__resolve_symbol(btf, type_id))

I think __resolve_symbol uses PRINT_FAIL instead of ASSERT

> -			break;
> +			return -1;
>  	}
> -
> -	btf__free(btf);
>  	return 0;
>  }
>  
> @@ -121,25 +109,22 @@ void test_resolve_btfids(void)
>  {
>  	__u32 *test_list, *test_lists[] = { test_list_local, test_list_global };
>  	unsigned int i, j;
> -	int ret = 0;
> +	struct btf *btf;
>  
> -	if (resolve_symbols())
> -		return;
> +	btf = btf__parse_raw("resolve_btfids.test.o.BTF");
> +	if (!ASSERT_OK_PTR(btf, "btf_parse"))
> +		goto out;

nit, just return?

jirka

> +
> +	if (resolve_symbols(btf))
> +		goto out;
>  

SNIP
