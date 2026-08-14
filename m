Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F1429CD9
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719296; cv=none; b=p+qcKF92NFFniBMizhSMWZrqsh0UZANBUlGwbFWBpMQ+ZvCdUvTOwzJZ3gZ6YkrtDrAIXYcGpVKydoIRy4Cb1xR2m6ht4V5Iao9DEWVo0LgVNKm1UXjwSiFR32PrGCEF1Eloy6pjZran4466IJcA0ZGa1gA/DQIJd2VVw+L4GEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719296; c=relaxed/simple;
	bh=+tf7FEUY4JsLUkMWKMe2YfCCEKEGJh8DsBvHcZCylTo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3bih3SE2DmjVbOXnsjUtwCl8YvrIp0h6YovJfk8IZa2e3bSBwz5f/f1C4CCSpBzCDc24ytaiKXxiHFuxuHbyWo4Xmv+CrlZd/unAtU9vN1OriQz/NhuZXYq38vkXpg1bD+ki+lsX0m70R8W8cpnmvIllMNnuxBvpwQ0h68RisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjeMZcex; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjeMZcex"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so10219035e9.2
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786719292; x=1787324092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DyrxI2cYH7SSc56kmNn9Wc5tUe+KXdPMo3ly6gJPo2M=;
        b=fjeMZcexIrT0BVFRMLv97ZsfJuCWmq7Xm6cgRAca+OdFVW7xoMlTdZCtbkLzIkPbtt
         JO2CvDV51haPNdUAb87mhlV4O4hn+ZGZH3hImgMmb8i8OfZTr5vESpLlUon3hpbLzxKW
         lOxnrCLGMlUOYk5BLoS+OjDtozlp3QqpYW1h9n1WdZPMjo1hhIgcEEiZesVVa0TcdSsn
         k6FGazCgxTL6KB8s0eW28CIY8aTQSChV9M6oEpn40MAK/rbMPmJKI/37FaxaM1ynN0ML
         8xatsX0Q26Gc+qxwS03FoXsQ5Dd/uhj2CWAS+l1kccf8XZpMeu42KEOOR7gAi9aK7Y5b
         dkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786719292; x=1787324092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DyrxI2cYH7SSc56kmNn9Wc5tUe+KXdPMo3ly6gJPo2M=;
        b=ZBPxY4a1Ok9hGpP2X9Xq3vsC3JQPPw4/EHa/uSyfNnDztCObGoVwHL86dd+pysFsUk
         tuwPcCsFOyNWxt7nL2S9bps3p+siqm255S6xICovV7fM+TfNNN6DlZKTboWxJCaNSXoh
         NQjv7b4aR0AbGz1KHEysaAyYxzbuHdfo8fUYVpazK0nOkXbCkgTJX2I21z6d5/xA+4g/
         UeK2/F6HWWPDzzyTOX4vu1Vx9ShZVUT0YcS4Rws8DwSoyowGA/6tuaZ4UZDrVWAUP2r2
         OBQkQWCZjKbceB/9FRo/YxNA2DnuB6cct1T6ZxlFpHLdtVynPP/a+z1x4NF2kMXjRCnh
         aPAQ==
X-Forwarded-Encrypted: i=1; AHgh+RraGJp2otA9AdiaujvCJzn0jTlaEQS9tEgkQdTHnjolXsSlFj5pltnCzCq8ZY1KaLTeMPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFsPwyWd2V4gveRSenR3HGQ2sHqr4A8W8Eyfg34/AZcDtdvdO
	2sCfozh1hh6GHWfUa9XHZiBeTXYalJZgtW3nEbDmftvGM+XiFVLkViZW
X-Gm-Gg: AR+sD136gqtlzZ3dDnEE/Xn5ePN/iO0O6wJQWwLdYiU5IEyHfVCRhhHB8CZgcWucoCd
	qf7MQVLrltDBm9xbMo7jQEsPwkRH4byasSAA8+HfaUV3ZMdcBLuSGy2KrPyN/62Lw5j5hSzgm4K
	zfqXwSLPg0pQAmuDSg20YoZ3eYnB4xFqGO1rSjmYjLDUMMHsrYt9G+968Kevq/U2pjcTAZ4Hvzq
	p1UB18z8WF5q2R0YlR2mNaDYO+mlgfwcXkFJ9TBuUFgfSxknImkOnRoVvlY+j98aAlCXuq6wcup
	LVQtEtuAgb/cg8YAjk/PBIV7dCHr0F1HIYWiMqtezAQzv5xXezerVG4I+vknHZwUOZaVR5GQPET
	77sbqGczqRtfWDXYDEf6xqhQTlXofofFGnzGnE/c3rEiFfiW6gdz2oQxqFZpxxv6rub9fKXq0bc
	1XBk+nWQppsaRRFbO+ow2mSS3sVL9xQIs39Ni6s4wYgNbXNgM=
X-Received: by 2002:a05:600c:1546:b0:499:484a:98e7 with SMTP id 5b1f17b1804b1-49987974700mr80960195e9.14.1786719291723;
        Fri, 14 Aug 2026 07:54:51 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cd7ecsm8874800f8f.36.2026.08.14.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:54:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 14 Aug 2026 16:54:50 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Move tracing_multi_bench_attach
 to bench
Message-ID: <an8sOsKmqUexcYKv@krava>
References: <20260804154813.90795-1-leon.hwang@linux.dev>
 <CAEf4BzbJCB0KUZMkeRPfYSjMQ3Q3eoFKUZS3px1mBBhxtEqYdQ@mail.gmail.com>
 <an4HDVUea-8zgdUM@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an4HDVUea-8zgdUM@krava>

On Thu, Aug 13, 2026 at 08:03:57PM +0200, Jiri Olsa wrote:
> On Tue, Aug 04, 2026 at 03:40:30PM -0700, Andrii Nakryiko wrote:
> > On Tue, Aug 4, 2026 at 8:48 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> > >
> > > In CI, the tracing_multi_bench_attach test could cost >10s, which should
> > > be avoided in daily CI running.
> > >
> > >  ./test_progs -t tracing_multi_bench_attach -v
> > >  WATCHDOG: test case tracing_multi_bench_attach executes for 10 seconds...
> > >  serial_test_tracing_multi_bench_attach: found 40163 functions
> > >  serial_test_tracing_multi_bench_attach: attached in   9.367s
> > >  serial_test_tracing_multi_bench_attach: detached in   1.798s
> > >  #546     tracing_multi_bench_attach:OK
> > >
> > > Since it is for benchmark attachment of tracing_multi link, move it to
> > > the generic bench framework.
> > >
> > >  ./bench tracing-multi-attach
> > >  Setting up benchmark 'tracing-multi-attach'...
> > >  tracing-multi-attach: found 40166 functions
> > >  tracing-multi-attach: attached in   9.278s
> > >  tracing-multi-attach: detached in   1.836s
> > >
> > > Assisted-by: Codex:gpt-5.6-sol
> > > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > > ---
> > >  tools/testing/selftests/bpf/Makefile          |   2 +
> > >  tools/testing/selftests/bpf/bench.c           |   2 +
> > >  .../bpf/benchs/bench_tracing_multi_attach.c   | 177 ++++++++++++++++++
> > >  .../selftests/bpf/prog_tests/tracing_multi.c  | 125 -------------
> > >  4 files changed, 181 insertions(+), 125 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach.c
> > >
> > 
> > Jiri, are you ok with not exercising this logic regularly?
> > 
> > but also hm, is 10 seconds expected?
> 
> sorry for late reply, I overlooked this one
> 
> the 'commited result' is around 1.2s.. will check
> 
>       serial_test_tracing_multi_bench_attach: found 51186 functions
>       serial_test_tracing_multi_bench_attach: attached in   1.295s
>       serial_test_tracing_multi_bench_attach: detached in   0.243s
> 
> thanks,
> jirka

fyi found the possible culprint:
  https://lore.kernel.org/bpf/20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org/T/#m8184343c667a96efae72ae55f7a8679d51f6eaf6

jirka
