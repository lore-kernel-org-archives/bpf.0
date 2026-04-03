Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79972836A0
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225822; cv=none; b=J+19rzTgSzcibSb7JljnmKC8PaigEmALc/i6idDCKAAeo4jPwk0tcU9he4IdjgPk2LZJ7O1+5XINLic01LM/b70Q0hO+luRxAfpfXslnMH75YiECGls46/Q/0xijVF6njt/rMYM907P9KDiz1/JCgWSZDjN82iIk417i4dzSZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225822; c=relaxed/simple;
	bh=VUyMZznUW3osZvT3S1X9ebd+t+BQ6HfI1wDna3lMNNU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwzobyV8mbKu3uIHYcMfc6lJAIq0GnO4aBsB+T6l+XtmQ+VBexmCWk9FmUNIvb79+mwhbzXAm5hPk8tlR+nc0B7rObYyv1B37mp4ACBIdaPfc1nGCPY7Gt914qD2zDkmO8KVqzEhS661w9gZMppwn+01L2B7CTaT5N+BsYW8xLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQfZxc5J; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQfZxc5J"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4888375f735so16708825e9.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775225819; x=1775830619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=On2y2qp0yr/ak1wlJ66/XwrdqcyULXzG3n8Kx7OUYco=;
        b=YQfZxc5JhB+vUwZsCV9SaRoPPZVF1TcAy/d6DrrThHxZbglsaCzDbsxPdWAvzjTG6z
         cmtIESCfGHFZADveyp+uA8gBKhC/POSC+fTUeZ2zNUN4ccMhC2HJCY4xiYixAkFuDLpf
         Axss6WZIbpruV9qOmp75yrjNGuUFv8Vf591g/lPrHnhPMLmiNhO6wQJy0owvp1RqdRxR
         Rbn+QGX2x466F3wM3wOBOcd/IWJ4BLNiQMDw1Smv3HXp+dQZh5HBUDtzi37tkeO2IkDv
         Xfp61WXWqLSHa2KEWK9U4tJolCoSlQuuFGbSzUykbNIF4di7X6ROwtWOI6PCFluMrnwq
         DurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225819; x=1775830619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On2y2qp0yr/ak1wlJ66/XwrdqcyULXzG3n8Kx7OUYco=;
        b=PKOjPNr4sQIgajSh6ZifN4j4TsnxH3h6JdUWTXhUZVphelniDYHqhyO8ZQ6I5s1ZrE
         Fhl9HzK25Hw85ijaYYIxLgHPqos1XzgBWdjxfsXH9UewlAnNoMCFmJm3PFlOw8M38VXR
         M6OoMHq/A14kGYVTr5AAl67chBAMT+lsaLwd6ALUVlFiQB9PBeodeEvqYob8JZc504yU
         uJQlTntqbZ5Ek9KvzmVomlV04kTwfF09wkTJTOkrHY0WZxDzC65+ufcOeyZ0S3Txulg/
         WziN6IxWUEb2EqcG+dXohH2Wo7JzufMn0NJEonmOcJiWrhbtwua0UIOkh15awBc3X4It
         hwaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCTeCp+7nF4ttnEno0IW5D+OFP4iH6NAeze1v1QyZ7WUQIocHNhW3CVvvDk5RRLFuBBHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ZVBEJKsiAQC8CMGQbyFBh9BjEvW87xMSh5xiXvEM10BNn30M
	XFLkshoUCYmC3S+pHIzF2+Nv0ibYWGB0JG8S5cvKrVJ2IhVCoC0Rr5sM
X-Gm-Gg: ATEYQzzQ+RBvqtvKXzu2/1d8d1VRtXw8AfAArs0YHQVU/7Br9EA2EmR2B2hlhCPAsBS
	ZdnKb4GuTi5EpHw8IcYsCEJYH+iXars8WEleoEc6dLI5ykFWuTkjd5DD7Q8zeG84Yv1oyzqjfNZ
	dkrqmtLsn7xk1qrUPw5R0yVaER9xlqSi9rPOdNEmg2AetaoZ01O9TlJ4xJo5E+2bpRWl6hWZM+h
	A0M3wVnjeKUZmUF9PN1zkdybPbtC4gnHegrI2pHUY9UOv2v6pJK6NJW1mkF0iv523CUxVUxN4UQ
	XBWRtMf2cDvxsECD6Yf0iSWBlnakA7otzq/b5Y9rWW175RYaSXDaP3gx0ilSDlOZM/aR9Gfkdiy
	Z/bEkLDKfd2vejvKjvtSjSCuLcR76wpfKpD7CULaRYM+BMNkF/WqeNGHcLGahGUwHP2YvnAI8Eu
	gmqnZ5YL/w5a53k1OvgHLrNnvDSlcc07sG7CtHPftRSX2q0i7OiGNvwMEt1E5dRS309wdAcWOvk
	6QedJD1nBjdlJ/ysmCszUXjErn+Tt1CTM+HnyoN5KVnHdMMiNMbGQQkLSZhEJce3z41hZEobtgQ
	zLd5VFVpUt74BtUu6SS5LUKyKuJpWIHqV6Tj
X-Received: by 2002:a05:600c:4593:b0:488:7a24:9ddf with SMTP id 5b1f17b1804b1-488997dfafbmr50529535e9.28.1775225819014;
        Fri, 03 Apr 2026 07:16:59 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00e1e89335f46e29e8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:e1e8:9335:f46e:29e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e967badsm357414695e9.14.2026.04.03.07.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:16:58 -0700 (PDT)
From: Paul Chaignon <paul.chaignon@gmail.com>
X-Google-Original-From: Paul Chaignon <paul.chaignon@.com>
Date: Fri, 3 Apr 2026 16:16:56 +0200
To: Weiming Shi <bestswngs@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>, bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: add get_next_key boundary test
 for cgroup_storage
Message-ID: <ac_L2C42x33hyJFX@mail.gmail.com>
References: <20260403132951.43533-1-bestswngs@gmail.com>
 <20260403132951.43533-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403132951.43533-3-bestswngs@gmail.com>

On Fri, Apr 03, 2026 at 09:29:51PM +0800, Weiming Shi wrote:
> Verify that bpf_map__get_next_key() correctly returns -ENOENT when
> called on the last (and only) key in a cgroup_storage map. Before the
> fix in the previous patch, this would succeed with bogus key data
> instead of failing.
> 
> Suggested-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/cgroup_storage.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
> index cf395715ced47..5451a43b3563e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
> @@ -86,6 +86,11 @@ void test_cgroup_storage(void)
>  	err = SYS_NOFAIL(PING_CMD);
>  	ASSERT_OK(err, "sixth ping");
>  
> +	err = bpf_map__get_next_key(skel->maps.cgroup_storage, &key, &key,
> +				    sizeof(key));
> +	ASSERT_ERR(err, "bpf_map__get_next_key should fail");
> +	ASSERT_EQ(errno, ENOENT, "no second key");
> +
>  cleanup_progs:
>  	cgroup_storage__destroy(skel);
>  cleanup_network:
> -- 
> 2.43.0
> 
