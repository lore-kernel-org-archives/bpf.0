Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495982F531B
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644243; cv=none; b=WEWcsBjTiEOAcdt4ywzKnhqndcaSyA+8+eoyQmJWVP24wnob/EjDrKwSsz9g8WP4+xe0aKVhIF7a3OXqLSZnN32DtpOCgpO3hiqjZeotRCmJLcWC1Y4JmexQPbcbK7mduwVSaLAxfwBUxMC4ZCmZbwZahz+HcrZHijnYxO7rwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644243; c=relaxed/simple;
	bh=NtvaBNSVoK7oKWXFv49lETLnLBGunHM+uU1K7pNhXYI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLEZXsHdhvRfvvwtyQeMqswqnICdE+dBNN0euyN6kS3zEVtZroxnPqqFberqeO/ENNPYuGFx5P+oZ5ZnrH1E4Azn2DrcVhNctZa1neLCWJkBY4OjNXjSaKfGqYAAMWgO1jaykQqODF7u4Crje3XsuQPmCnRDddaG1q29MAnMV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXyskpls; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXyskpls"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47de008b020so40607f8f.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786644240; x=1787249040; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zr5I5FYVqXv9F6tHOsf6hEzeaNxXhC/qXHtmdMQmKGg=;
        b=SXyskpls04g62dMGJtIB7/xhakVUQiN9nB9D7eqYhwWy4lFK/77gjw7B+vXL8poQVT
         EviYGYlOOhP2nB9KvC+kRDxVFhUnGf4dHqtLMKyELd9bWRuvgzQ67CGdpgb4iJHOM/Ln
         1yka1frWsL6JAbGdi9xSEcs8A1tHcO8c4jG40AhAtr8mEkn4VhO+Y0lEKo0C+AHBIRvU
         V7lAlRdZBJh2RdN8N8p0rhR6NiqKhUTh9vSiEBlI2E7vvmFSCe2yRS0j6BN6LnIiT3Ne
         twXCQS9mvJtTRNlvTpQrzr5n7k5yE1yun4JW88NAv8B97wvsi1szsOab0ZeUJC11KGZx
         hBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786644240; x=1787249040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zr5I5FYVqXv9F6tHOsf6hEzeaNxXhC/qXHtmdMQmKGg=;
        b=mjLP1dDgaefjssEnGm+do2T98J7ji7eRqT8PzlK3kQRVXu/FjSvpJ19nHmL9vlaaUr
         189MIQmqfuG636dfxN00HUqsGyRkFM09Yazz8LVAZrRTu20r6IXSZyWS08fX43/nxxMZ
         DoMcs8f0YqdJ1rb6whfeHkA3NzqWt/b9vSisRcF2OP842QZVeWVy7pYW++DXOD6AFfmS
         V/qk1b3KozhELsg6gSPKBEabk14ghGhsIf7xaNMK9sZpsZFWwtWaQlNzZZ3iVcweFoI+
         TII6nw2jsUMzQCP7BHScLNl3WeQcdbxQgd18Xk/a5ImcAXA6Evna6w1cyvhofX1aHK88
         miHw==
X-Forwarded-Encrypted: i=1; AHgh+RqDaAqYQZGSmR0rX+bnBxDLhYa5wqmMVY3HY5sZOlULiIo7ZZlTQY8RAMUkWkyn8cXQ0wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiiH2pXQ65OLqo+CIWtDw2UovST1anXfZzXi9EAad01ILLazsJ
	gZj1qC6ysCctayhyhTe9e+ZdcjFgBQsdDIgOXAO2IGTCAEPbLGIcr0i7
X-Gm-Gg: AR+sD12jG+ce1aZtTSpETnYhdpq3T83sw5cBjOQ3v3Q5QgGfj6LaPnE5KuRLCRsdLWE
	xFgjS0oGRqwl5cYlBf7Et7Oj5HcWw96rp9WHeBUa8lYgwVSukLICR61PmnE9z8q94kVWumF+4hS
	FasEZEnTiXrwk7A4Bvj7t0B88TOxWP/cL1SzkoFB0zSzzbDU3pgpg70gR4t+G7/z3XXbJK0KZ/Z
	Z3ox8u9DN3a9rGKJEBWFFjMO378P7lGIPra4hC0qgMX8LDJ9wzKAraEz87jQzB6JikfJhK5pTp6
	4XR8o0Xzj37nD/rxcYnM2m761VOOAMVqTVeEsAaYSeqNdstkcn+cdHWDbCgqyjwTgmXLumN8rJ7
	7D8zEkw0LNUKqdGeU0MdAmyM6b+fYj09L7w481d3Aa5b0dKz2qbkgWRfyk3YR18smQJqi/1R1hQ
	A8nULvrofFOepX0uwIYL2x96KIcdrJrVi4NegFywWDCsjrIrE=
X-Received: by 2002:a05:6000:61d:b0:481:5a46:dbef with SMTP id ffacd0b85a97d-4815a4e72admr11372177f8f.5.1786644240265;
        Thu, 13 Aug 2026 11:04:00 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cc811sm1004573f8f.33.2026.08.13.11.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:03:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 13 Aug 2026 20:03:57 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org,
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
Message-ID: <an4HDVUea-8zgdUM@krava>
References: <20260804154813.90795-1-leon.hwang@linux.dev>
 <CAEf4BzbJCB0KUZMkeRPfYSjMQ3Q3eoFKUZS3px1mBBhxtEqYdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbJCB0KUZMkeRPfYSjMQ3Q3eoFKUZS3px1mBBhxtEqYdQ@mail.gmail.com>

On Tue, Aug 04, 2026 at 03:40:30PM -0700, Andrii Nakryiko wrote:
> On Tue, Aug 4, 2026 at 8:48 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> >
> > In CI, the tracing_multi_bench_attach test could cost >10s, which should
> > be avoided in daily CI running.
> >
> >  ./test_progs -t tracing_multi_bench_attach -v
> >  WATCHDOG: test case tracing_multi_bench_attach executes for 10 seconds...
> >  serial_test_tracing_multi_bench_attach: found 40163 functions
> >  serial_test_tracing_multi_bench_attach: attached in   9.367s
> >  serial_test_tracing_multi_bench_attach: detached in   1.798s
> >  #546     tracing_multi_bench_attach:OK
> >
> > Since it is for benchmark attachment of tracing_multi link, move it to
> > the generic bench framework.
> >
> >  ./bench tracing-multi-attach
> >  Setting up benchmark 'tracing-multi-attach'...
> >  tracing-multi-attach: found 40166 functions
> >  tracing-multi-attach: attached in   9.278s
> >  tracing-multi-attach: detached in   1.836s
> >
> > Assisted-by: Codex:gpt-5.6-sol
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> >  tools/testing/selftests/bpf/Makefile          |   2 +
> >  tools/testing/selftests/bpf/bench.c           |   2 +
> >  .../bpf/benchs/bench_tracing_multi_attach.c   | 177 ++++++++++++++++++
> >  .../selftests/bpf/prog_tests/tracing_multi.c  | 125 -------------
> >  4 files changed, 181 insertions(+), 125 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach.c
> >
> 
> Jiri, are you ok with not exercising this logic regularly?
> 
> but also hm, is 10 seconds expected?

sorry for late reply, I overlooked this one

the 'commited result' is around 1.2s.. will check

      serial_test_tracing_multi_bench_attach: found 51186 functions
      serial_test_tracing_multi_bench_attach: attached in   1.295s
      serial_test_tracing_multi_bench_attach: detached in   0.243s

thanks,
jirka
