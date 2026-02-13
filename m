Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829F22ACEB
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001324; cv=none; b=a1RbskB/h7FOpeDpS7vLwaTNglRZ9fmfR1I1EWZXqIqEqZKdJpzLawkvW5f51DvvXc9SkeP5phKxNDiBbVkL0GhxvWq8TMyGVXNa08N4WQL1L2unHT6zufpYsBlJZKXPY1wxPxndX6s0A+uPtNU3SnywWIszcKpxvUZ+T48mK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001324; c=relaxed/simple;
	bh=VqkMT+8fM812y9UPjSz+55ow5pFiS3AhD+KW7aaxE2w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq2yAMuFHzUX9a2POWN4igzjY70zu5zcxMN+q6n8MIVR0XLkXJtT0ZSIfWKdnP70nHJwNLcboXgdtScKbaJUQJRozLwAh3fCjW5Z46/YVaX35qIT0E5qcTo9mYmyuGYo8KO5uzUVdNvrKosT2OUJocPfyWd8v2xiU0diF0PRiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjucjs6G; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjucjs6G"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso9660705e9.3
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 08:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771001321; x=1771606121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CvmEWuyZCrem0YY4YLx4j6EDY4JGfS/eFVbWJ68FPAM=;
        b=gjucjs6Gaz+sjVB5nUl8bDqeW02YbyfQifePOW7gUdUbLKcCzONvW2w2uggsEztpLT
         ZGPob8jQo08J9+AHiE2OZU2Uws6DLuNE6duojuuRgbI5twYl6muwvY0+3oRINsxkOBa3
         ZlyVwuQNKAGwWqPoqWvXy2McSyq+cUFWnmskQJhrVf5PrDhrgz5bpsa+J51kP50lxSAW
         H4g09jTpHnZ1wN6LB/mVgWT9gU12kpUz6szUJdr+x+KwucbKLBYDtGqfI4USsuCj1ins
         EU495XI+zg0VMnM+d8fHKJTivnJSfEQQXJyuIG9tfuYQVotJVbfubwQCVONYk731iHf9
         WRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771001321; x=1771606121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvmEWuyZCrem0YY4YLx4j6EDY4JGfS/eFVbWJ68FPAM=;
        b=tqmhTQYEl8GD0xEsEUGssERbsNzfQAvpJhxUYVGqd5aY4CXCP3WAozRM7cP+JH2+/B
         SH7oNf5nD2vt9oBrvsNKs0RDACHwERstKjIczKl8zzYhs2eQ3iylbn/FLVSjYRcprrJE
         /NygiLNbGoKvkXtDMzeJtwLWN3wMEHNEJJnOfB9yJHmOn5IhCyeiYstJC6xBCVT31y03
         gesMTkRiQynG7Xsqrerfb0oFDychK+WIjG8pnxzzTSrJko2jDaMBcsa2y0o49LCCt3IW
         HCtWcBe0KOf4yfHsXVdLNQXvCqbU1gKfy2zIsPmhjiITrwmvKL58byZTABuzM6Y4f+7p
         HNvw==
X-Forwarded-Encrypted: i=1; AJvYcCXj/7BOkMnnaAtkUBz0QIg30GJf5JP/XyHSo1qP0/WMeA96iUvkEq2ImhuoCXObigAhdC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//2Ur5dyjZKAOd2da7jzFmthwKQZ4OcYTuiPgYnEbGQv5AUqA
	NA58LwnbrBoaqaygnDy5h2ZO+AMbUiGdLGmwVGQ99dIy1gYV8ESYwvpl
X-Gm-Gg: AZuq6aLsHi3kPtcTolPZox5bL/5XUbs4nSn5RfbEI+RxKakfGM0ejyQf0Zb75oC2oGN
	zGEJpHZ7Myh+RS3qRpjUAzRn97d7yCPXxUQdiF17Lj4bdl4lukzuSZkjT7xWsEwpxfUw6bwvTxz
	WYTNrq+Bj2n5auIRe2UVxncfpD7uyD+8RreCW8KThTOue+1ylN7098/7z46QYBlTq/HwZlAOBbe
	itWJJ9MopAvo90NZ2b0vLWhcw7AVD6D23vggQkIASKjTwHgThDiq1UqRR3P0tVze2B1bpLcvf5s
	jyFkRE85nATRDFZOItXAYyzLSJ20XRnlNOpIuW5RVwxnMoMh6bIw1c+EfylvwqYXtKY5LOp5unx
	wwsH+FEMgGtATvrpVGDTLgwqEY7QsXCWjehRNAnUWKk2HzNg6zB3v2/eClaz9nW6tQESe9HZHKP
	ll3icGFBO3GKwjlmV1vD0HWhNDC0Q=
X-Received: by 2002:a05:600c:1e1d:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-48373a15f1bmr40067995e9.1.1771001320336;
        Fri, 13 Feb 2026 08:48:40 -0800 (PST)
Received: from krava ([2a00:102a:403e:bc0a:6cae:b7c0:c276:c265])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm291847895e9.7.2026.02.13.08.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:48:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Feb 2026 17:48:36 +0100
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 09/14] selftests/bpf: Fix double thread join
 in uprobe_multi_test
Message-ID: <aY9V5FOElHHmBvbZ@krava>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-10-ihor.solodrai@linux.dev>
 <5de2e9e7-2898-49a8-ba1a-253dceddeedd@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5de2e9e7-2898-49a8-ba1a-253dceddeedd@gmail.com>

On Thu, Feb 12, 2026 at 02:49:09PM +0000, Mykyta Yatsenko wrote:
> On 2/12/26 01:13, Ihor Solodrai wrote:
> > ASAN reported a "joining already joined thread" error. The
> > release_child() may be called multiple times for the same struct
> > child.
> > 
> > Fix by setting child->thread to 0 after pthread_join.
> > 
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > ---
> >   tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index 2ee17ef1dae2..17881e009eee 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -62,8 +62,10 @@ static void release_child(struct child *child)
> >   		return;
> >   	close(child->go[1]);
> >   	close(child->go[0]);
> > -	if (child->thread)
> > +	if (child->thread) {
> >   		pthread_join(child->thread, NULL);
> > +		child->thread = 0;
> > +	}
> >   	close(child->c2p[0]);
> >   	close(child->c2p[1]);
> >   	if (child->pid > 0)
> As far as I understand the problem is due to `static struct child child` in
> the test_attach_api(), once we initialize thread field of the child
> it's not reset before the next test run.
> Maybe we should also add memset(&child, 0, sizeof(child));
> in test_attach_api() before each test to make sure all fields are reset.

right, perhaps we could do memset right away in release_child,

jirka

> 
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
