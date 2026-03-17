Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A02EF67A
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767928; cv=none; b=EnPfrQ1zjh+8uGRC63j8/S24wCT8eKQxtbqYVQT7t1DQIvpcsepKPvrxwkY3QaGgflR5FDxrykhdUTY/yg15fpz6DisZddjP/QlrVQCrxYdqLx/Vw6gxlX0yeAuaoTX4r6Hp/LshPrPM6iXuVQ+bVvEDnmhERh+tgApPzxooiEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767928; c=relaxed/simple;
	bh=jSTOBk0QchOGhgQ9fPNgvyzaWz53LGuahLTQNnHNAiw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au0sUiDuEJtCuhWnR15+thUEVk8sNGZZ3IvSCHLHqq0MRYN3ZHyGf2WFCdQ0374LmcQuVKe+fbqeU187lvptyUNLrO4pp5VK5gb+kAvBHBmzjCtogtFX9bho7XrB7fTU+e5kQaLMXATBnTSZYRRQEOf7Bvy/bvCioaDtsLXgJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1mnl9Rt; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1mnl9Rt"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89c4bc36053so16606586d6.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767927; x=1774372727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FaaFcjOrcgiRK0kqbKsrAvjcKayVzBLU1SPmKnUc9iU=;
        b=Y1mnl9Rt86jddtZQKqyhespKO6Jbqe2GxUNUs57jaW7fBxuvLsq2Ps5WdUT6qHJ1hP
         lnI77KCwW9hZ3Bj1zTI3Kz/6vBlHWGX37Ol90aGRHFX4qtHGeTtzvhYaSDbe/8M5sQ7o
         hbmgMjSZg0d3VibGx6YvKAgK7kDszXUwpyxGZtbfgRan8a876tKPQBx4yVMzWwzGunT/
         kwOuTsAJ/3ZroD0I/250IQYBoHS33h8MvqVavmXjqxwuQSEwbU87sQfBYMM+wuzTPuAz
         9LaB+2t2qmULE5fVQtkg7THsbLkSXZf5QcgV12JAHi2Eukw/q1p1VAi+7dbs2T82lg6D
         g+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767927; x=1774372727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaaFcjOrcgiRK0kqbKsrAvjcKayVzBLU1SPmKnUc9iU=;
        b=JAi9IRMmF6lHiy/EeMdU/XCRA2hCEnwgUc5XbyeyJUGG7nLKTic5QvBT2zvtuUIY7y
         YPwzOI7DsCPfBmuLW2Z6xIkTsiQuSIHIfEdlFK+bWKeUflOA9GRN1BoMVjcUdaYedE8/
         3dW60Y+TPNDby6Jrekg11hQR/Rmsl6T92W1jZ7s2bp9Noh3czmnzk7fOOwtBeHq/RHhK
         HdApJBVg7stgxxrojCKnpCHsKiLxjeq5oFJYmjFnwAN9BocitZ1cdhTHFScS3I1sLEaZ
         Zuilca1Mdv8OhUxLnVlLmg85tn9r9I82byfuHHYRzDj73SeYcx0poCPgctqpxOrM9N6O
         dHUg==
X-Forwarded-Encrypted: i=1; AJvYcCU524wzja9fXZm1l9U46L4QgJ2rcKF6XjPe4Li6ykVCxig1kPxXUs0Z8U7HfMXMwLjn++g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9A12jHo3AH/Ga4x7QCcbD6woOcfx+3nGU/4JcEFv4PS6kqqfc
	HXqG6TWRyj+UqZLfZUGJESEHVx5YDKu9gyT4r/+DPRSdx2m3H4JzQeGg
X-Gm-Gg: ATEYQzwH4I+ygaGPhvE6Gx1OzXrYZrAF4ZZe9xszi+o/qb4mLgc9bMrUp8G4ZSimS4Z
	GvX6gcNBBY7HRcOIz2j9qLsFjMougXVy+PfftJr1GZPIihEcSxbJrzbtTqYkEQGVQV1u3U07lmz
	T/RY/w7zTyInq6X5eXiX+wuzI4nfgU3Ye8bE0NWbL83oAajtnfwFk8YS1y9mVaIop1AgOMLEBg8
	Z+SG62ML0b4Kcjiz7e44dcx/lgIh/3R4Z/h2wYHAVf/3q6m9On3rV73Szp1243nk1uzgGz9QlSI
	FcQ6ftWbf1lUPwsPDH4ML6tDoeJrJ4hYcjOklvb/tKvM5dSppOPai5LI2nUZKW9pkLVUoCdMxhc
	g/Oybv7L1s9Jj71ZLVr2Pq5j5BQApTRbSRyfuzfAfIMb8rVDB4C4eV3/QYAI+5ftGR7ULajhDza
	DZJ6fMqBVXoUc=
X-Received: by 2002:a05:6214:6003:b0:89c:5385:3476 with SMTP id 6a1803df08f44-89c6b56f9e2mr4975846d6.39.1773767926377;
        Tue, 17 Mar 2026 10:18:46 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b8e0275sm1329206d6.7.2026.03.17.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:18:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Mar 2026 18:18:41 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv3 bpf-next 19/24] selftests/bpf: Add tracing multi
 intersect tests
Message-ID: <abmM8XHYfhd9qiAz@krava>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-20-jolsa@kernel.org>
 <63fa6255-8682-495d-abe1-d30d72a7ece9@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63fa6255-8682-495d-abe1-d30d72a7ece9@linux.dev>

On Tue, Mar 17, 2026 at 11:05:29AM +0800, Leon Hwang wrote:

SNIP

> > diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > index e9042d8d4760..b7818f438d6e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > @@ -6,6 +6,7 @@
> >  #include "bpf/libbpf_internal.h"
> >  #include "tracing_multi.skel.h"
> >  #include "tracing_multi_module.skel.h"
> > +#include "tracing_multi_intersect.skel.h"
> >  #include "trace_helpers.h"
> >  
> >  static const char * const bpf_fentry_test[] = {
> > @@ -31,6 +32,20 @@ static const char * const bpf_testmod_fentry_test[] = {
> >  
> >  #define FUNCS_CNT (ARRAY_SIZE(bpf_fentry_test))
> >  
> > +static int get_random_funcs(const char **funcs)
> > +{
> > +	int i, cnt = 0;
> > +
> > +	for (i = 0; i < FUNCS_CNT; i++) {
> > +		if (rand() % 2)
>                     ^ srand() is missing for rand() ?

it's in test_progs main

> > +static void test_intersect(void)
> > +{
> > +	struct tracing_multi_intersect *skel;
> > +	const struct bpf_program *progs[4];
> > +	__u64 *test_results[4];
> > +	__u32 i;
> > +
> > +	skel = tracing_multi_intersect__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "tracing_multi_intersect__open_and_load"))
> > +		return;
> > +
> > +	skel->bss->pid = getpid();
> > +
> > +	progs[0] = skel->progs.fentry_1;
> > +	progs[1] = skel->progs.fexit_1;
> > +	progs[2] = skel->progs.fentry_2;
> > +	progs[3] = skel->progs.fexit_2;
> > +
> > +	test_results[0] = &skel->bss->test_result_fentry_1;
> > +	test_results[1] = &skel->bss->test_result_fexit_1;
> > +	test_results[2] = &skel->bss->test_result_fentry_2;
> > +	test_results[3] = &skel->bss->test_result_fexit_2;
> > +
> > +	for (i = 1; i < 16; i++)
> > +		__test_intersect(i, progs, test_results);
> > +
> > +	tracing_multi_intersect__destroy(skel);
> > +}
> > +
> >  void test_tracing_multi_test(void)
> >  {
> >  #ifndef __x86_64__
> > @@ -347,4 +444,6 @@ void test_tracing_multi_test(void)
> >  		test_module_link_api_pattern();
> >  	if (test__start_subtest("module_link_api_ids"))
> >  		test_module_link_api_ids();
> > +	if (test__start_subtest("intersect"))
> > +		test_intersect();
> >  }
> > diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> > new file mode 100644
> > index 000000000000..b8aecbf44093
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> > @@ -0,0 +1,42 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <stdbool.h>
> > +#include <linux/bpf.h>
> NIT:         ^ vmlinux.h is better than stdbool.h + bpf.h.

ok, thanks

jirka
