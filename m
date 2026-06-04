Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD137F8D5
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560053; cv=none; b=nUTnGSPZ71c6AR+qrvvzZyBAnght+Jpe3nkTatSHRhasMo8RCsEr69e8vdqRP2YAYxQq2CnXTZsm0j/8qaIvYOVj0scdpJgouVrF1AHiECAkfXvsg/fDJjY7E9H1Zs3mFKhjtVEUsteUS0H8D0JJ8pLfDWBcrAgQFdcHpwvlgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560053; c=relaxed/simple;
	bh=euaKvkz0bmQioDFYhOdMwAp8A8tyElTXhl7rJTkQKPw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVtIDfZLNwnJVNv3R20uC3kRsMn1evMc1WHVkdQb4HQ9clL7geZt72k5BqCvXoJ+sGBtVyifCFxYiwgCu/Lf88JwrePGFh0U8gqJNB9/nKUJICnPtqynVEj0wGiqiYVSZrs0w3ju/0s1SZy9R0jD+opkBFY2lfRkv2+Z1anYKPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=le39up2L; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le39up2L"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45fd45e596cso174023f8f.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560050; x=1781164850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RL7FImbpIn+VjTJfYXkZ93eX1v/NTo7ok1lWqFVH6L8=;
        b=le39up2LKAESFRf/cT/8FS5xBZ4pOVt6c7f84ME4OrcBZc/7sAu+YT/chcFE6/UZpe
         YqOpOHgv7oQqy31n2AIeWduhPEUblYlHPqTWiz21BbDEli+EzrnB906jsEjaUKr4ql6n
         HY88Kl0WO6UIGdq34tKDGtFCtkWf1kxkwuj0gnV+8atP0Zuknb/VKCZuoz0edrG1sk/U
         fvsUpvKLWpOog1UwY9WQe9Ch01ccu92nZSiimLdH9qQh+/04WeE7n166TAsivYXsOX+J
         rHaIcjA9wxflgT32ucgzpTu+vKuha6mxxs2bVbMIWNAavj5n08CmTPVe4a8b9z6PNOdy
         vVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560050; x=1781164850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RL7FImbpIn+VjTJfYXkZ93eX1v/NTo7ok1lWqFVH6L8=;
        b=NE7lQfGKDsPv8FxtidEAkNCNswtPkjGKFMbZ3MH5/Lqt8t6A5ZyPnoWnxRsgbp1wUm
         r1cha1R6FatafYTAuUhvdgkzbD6c7vKN69UyhFvd0fJay7GU1Ad3OIy4/pdltg87FGbt
         686lzaDCwKUETFJM8+i4a1JsFi8RUS4/6VPBI0hMTkpPf8oqQuhOECQZIIQTi1ya5jp1
         /FiAHG70wlZ4rfUQdkTb33h6XhSHro/qKDZzhPgIB54OvWXT3S0xXCyXHmrFFmxczKKN
         jPTemNbKLCiMJ2obtonWcTTjZBYwVc7q7A/2ZVyxLMLmmB5GzTaYc2pwRZtNE0MchJ+V
         Vdew==
X-Gm-Message-State: AOJu0YywjLyDojIeQUFdM+yVGygjFBfIqzgX5966HNLQgMk4Y8H2plFk
	ImtAEwLgLPHfgRAnoPrXHeIBMMoMddioDMJQ7njyGKCZb+9W5+C1EgbO
X-Gm-Gg: Acq92OElBbjFzsLNS7e+Keqtw5iZlMKbxZofznb6hlneKkgm981bPtfKK6S+V+4EWvi
	KaP9JZqLA3qEBKIi4Sij20v1pZw3mF9KQ3s1yb8yoWN19ge5csUzQIthZS51A18hK3s5gy81iRm
	7+qPabgZkQDESH9DndEVGA8zEGrM61GQRspNoZUckWVX1+/ARrYUBTTt9ohTjw13INB0/GYVelv
	LNjW8BUvh84E+hFJkDu7CxLThsWVe/WuV5wM2UfkhALOumvcTUqyFF1LOlgz5foF6zTGeOdwazq
	RsZy62/nzFOd5HUohiTIHhY7wPSWn7TvNEtsKQcbNGv8K2llW3+RkvB3d6U3/nLNoKsGidujxIi
	rm6+Dq1rAVqNvxynjoqVooWu/W9iHag1JcRU7BcWDh60v90ayPd/wprGr6WjmHcofgqJUPdtCCg
	hBuOH5kFzJU9hxe6NO60pOQEH/zg==
X-Received: by 2002:a5d:424b:0:b0:45e:ee50:d066 with SMTP id ffacd0b85a97d-4602178307fmr7803012f8f.6.1780560046008;
        Thu, 04 Jun 2026 01:00:46 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm14077545f8f.17.2026.06.04.01.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:00:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jun 2026 10:00:43 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv7 bpf-next 21/29] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Message-ID: <aiEwq_Oo7vKbxZAB@krava>
References: <20260603110554.29590-22-jolsa@kernel.org>
 <20260603134059.D02E71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603134059.D02E71F00893@smtp.kernel.org>

On Wed, Jun 03, 2026 at 01:40:59PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch introduces tests using new libbpf APIs and section definitions (`bpf_program__attach_tracing_multi`, `struct bpf_tracing_multi_opts`, `fentry.multi`) that are not present in the tree.
> --
> 
> commit 51532d297dcd0ba4ad28dece86396b88a934e780
> Author: Jiri Olsa <jolsa@kernel.org>
> Subject: selftests/bpf: Add tracing multi skel/pattern/ids attach tests
> 
> Adding tests for tracing_multi link attachment via all possible libbpf
> apis - skeleton, function pattern and btf ids.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > new file mode 100644
> > index 0000000000000..f333b2514b345
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> 
> [ ... ]
> 
> > +static void test_link_api_pattern(void)
> > +{
> > +	struct tracing_multi *skel;
> > +
> > +	skel = tracing_multi__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "tracing_multi__open_and_load"))
> > +		return;
> > +
> > +	skel->bss->pid = getpid();
> > +
> > +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> > +					"bpf_fentry_test*", NULL);
> 
> [Severity: Low]
> Is the bpf_program__attach_tracing_multi() function implemented in the tree?
> I couldn't find its definition in the libbpf headers, which might cause a
> build failure when compiling the selftests.

yes, added in: libbpf: Add support to create tracing multi link

> 
> [ ... ]
> 
> > +static void test_link_api_ids(void)
> > +{
> > +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> 
> [Severity: Low]
> Does struct bpf_tracing_multi_opts exist in the current libbpf headers?
> This instantiation seems to rely on a structure that is missing from the tree.

yes, in: libbpf: Add support to create tracing multi link

> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_attach.c
> > new file mode 100644
> > index 0000000000000..332d0a423a430
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/tracing_multi_attach.c
> 
> [ ... ]
> 
> > +__u64 test_result_fentry = 0;
> > +__u64 test_result_fexit = 0;
> > +
> > +SEC("fentry.multi/bpf_fentry_test*")
> > +int BPF_PROG(test_fentry)
> 
> [Severity: Low]
> Is the fentry.multi section prefix supported by the current version of
> libbpf? Using an unrecognized section might cause libbpf to fail when loading
> the object.

yes, in: libbpf: Add support to create tracing multi link

jirka
