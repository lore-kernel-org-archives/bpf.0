Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179143101DE
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771420476; cv=none; b=E0p2YOOj92Oos0/O5w8Hu5hmN9BRPl9sHwFw8JzCjRjL+nhDGERKFiY5AjCQvLGLu05Atepdp0N9Ko171whSuh4ANrMJmtGG/X+rn5ij6KleWHyLQWkI0POTfGJswySJDwDa2Ez3WnkdN4lzdAtyQdOXUQQeedbnDenF3RtQrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771420476; c=relaxed/simple;
	bh=cUCWJg3oykH0IgOagYCb7qN5Cy4R5qwjW3affrm7oFQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4vAUF4+qeU2lqo0z/f/rBE+DRkFWbSfVsCuTA7YYaYL3FGpg8ETN6uY38ffj1ROpimPzc9rAHb4j25JYgjCzV7ve0zTxCMEPguEvnxDbAeJoJvbTu66IGTinSIz6lROg2jVaBsF7F2dRSVP3J6RH8VCmZF4xIyQJ1e6JjIdbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALh01c0W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALh01c0W"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4807068eacbso41227985e9.2
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 05:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771420473; x=1772025273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8OAEu0jT/Dn3oD6qSOpVowFI0zjcW8+c4DLwjI1qRE=;
        b=ALh01c0WIBMNCUoWXFUwueivL8fNlKWglnJFFxV5hAQXjiKvpJ+Mz0sdru5EJW/REY
         IJSvwLXzGqWk4cWUVFvR3po27bipxyG7Z+8BoMTFJ86ncIy/Q3ngvF10Elf+tDE7jkjA
         j3xh8OEPdgvexjyiSygPzBq3iBF9Y6uctiXF9EYIj6hThIbzKfu754/UBqbhEwOsz1DA
         8DTbOhIsDT36QYjlqQbGXu4WnJIqLBGHfAyZg7Nsoy7IEJgGPJIiniF+jhhmU+DTMuiF
         mgS6kNjAwjL/DBtAqg2xM/aQ0Hy+UMTHZ3qV7ZBesji7CTPK0wuzJLnhuhFZzUNUjQNF
         jgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771420473; x=1772025273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8OAEu0jT/Dn3oD6qSOpVowFI0zjcW8+c4DLwjI1qRE=;
        b=Jb/vnAMurR1sxqTz4UjyobVQbTP3b35a7uhCqzpFbBdQVTmahPucSj9sBSrRgT5gS4
         qnMXrMuQv2dfDI5r52hBPd6veCafmGI3dCAlp1jYoK2dzTzCjGz9QFq776sQbZyD12og
         0YLmvOurTDnZ75y0Ts9IQmabOHGQoaREs4qpRpPESSzJn65hTrVwKlGqI7iMSofkvVle
         v1Dw2dt33gN3n9eDRatQyaWT8C0l6gOWYnEdtw7vxa+wbFyD3WFVBuvDSsrdtWKjv/U0
         UaRu8pzvUqvBfcd5+0hqchzTn9+SvUBtgu+yvMN+KUKWZixafqJJp/+LoDwOO1RscDBp
         nu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCViSHEHdn2wiunn20VpT/PyCQOB84/gXqjXuuf5XY96z9axwJ/4+A1BRgcJgUWFwjIcYfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBWfsb4ky51sgIV8Du4iwWX1hEKIOM8VEA1C143HFGmgOsQET
	6znCCi/NmAgq/C6aKuJ/kDqjXB+ICIteSuRJ5P3BGZA1f7f8uEmvqaR2
X-Gm-Gg: AZuq6aJUf0Gos4ttsyyeSEVsvJHaQIgWqOAz0jiOblIsqclfuzR5AG7yH8JyoQiSoeh
	usSDXBvgtHdoZ4uvs/QQpPfWaupqjhW/2thyIopJR4ZHaKWc5MDkzQ9pomXO/jMSWsK4uecS1y3
	NSx7McUdhZnySJGal59SXlDfxaDoPKUPIUIyajyb2a2626sFqhaJM2MrXE+L3+CeFOykmgmOKr1
	BuKeSwJyCgz4bWfaKuf7ebKkYe8+vv8orEm/+nQy2d3eM1kP9gKyWBm280zHyAPpxpb07UxWUzP
	UkSTS/qGiuW7i5WXSXVR+3zQFHZ/NAfE1i1ExGsigDY1BImYviqwA1qf4b26Ui8AIpnpmyjTsQy
	pPIPn2l41QcppoH5K5rZNn0I9Yw/wLJdxUA/d7neUG2u+hfMqwpCglqA4OgxIWEETm9nTbrj/lL
	YWeQCNO1uokIsp0fgSHB06qrtiv50WJXaKf3xQsiyftkI=
X-Received: by 2002:a05:600c:5296:b0:477:abea:9028 with SMTP id 5b1f17b1804b1-48398a42672mr32401165e9.6.1771420473115;
        Wed, 18 Feb 2026 05:14:33 -0800 (PST)
Received: from krava (37-188-249-12.red.o2.cz. [37.188.249.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48398244e83sm37572025e9.2.2026.02.18.05.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 05:14:32 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 18 Feb 2026 14:14:26 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 04/14] selftests/bpf: Refactor
 bpf_get_ksyms() trace helper
Message-ID: <aZW7Mp6DnOBfeQq0@krava>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-5-ihor.solodrai@linux.dev>
 <aY25gB6NDmlPJPUB@krava>
 <8c1527fd-7c57-488a-b4a6-3b763f3b5746@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1527fd-7c57-488a-b4a6-3b763f3b5746@linux.dev>

On Tue, Feb 17, 2026 at 12:42:08PM -0800, Ihor Solodrai wrote:
> On 2/12/26 3:29 AM, Jiri Olsa wrote:
> > On Wed, Feb 11, 2026 at 05:13:46PM -0800, Ihor Solodrai wrote:
> >> ASAN reported a memory leak in bpf_get_ksyms(): it allocates a struct
> >> ksyms internally and never frees it.
> >>
> >> Moe struct ksyms to trace_helpers.h and return it from the
> >> bpf_get_ksyms(), giving ownership to the caller. Add filtered_syms and
> >> filtered_cnt fields to the ksyms to hold the filtered array of
> >> symbols, previously returned by bpf_get_ksyms().
> >>
> >> Fixup the call sites: kprobe_multi_test and bench_trigger.
> >>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  .../selftests/bpf/benchs/bench_trigger.c      |  9 ++++----
> >>  .../bpf/prog_tests/kprobe_multi_test.c        | 12 ++++------
> >>  tools/testing/selftests/bpf/trace_helpers.c   | 23 ++++++++++---------
> >>  tools/testing/selftests/bpf/trace_helpers.h   | 11 +++++++--
> >>  4 files changed, 30 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> >> index aeec9edd3851..7231b88cf21a 100644
> >> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> >> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> >> @@ -230,8 +230,7 @@ static void trigger_fentry_setup(void)
> >>  static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
> >>  {
> >>  	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> >> -	char **syms = NULL;
> >> -	size_t cnt = 0;
> >> +	struct ksyms *ksyms = NULL;
> >>  
> >>  	/* Some recursive functions will be skipped in
> >>  	 * bpf_get_ksyms -> skip_entry, as they can introduce sufficient
> >> @@ -241,13 +240,13 @@ static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
> >>  	 * So, don't run the kprobe-multi-all and kretprobe-multi-all on
> >>  	 * a debug kernel.
> >>  	 */
> >> -	if (bpf_get_ksyms(&syms, &cnt, true)) {
> >> +	if (bpf_get_ksyms(&ksyms, true)) {
> >>  		fprintf(stderr, "failed to get ksyms\n");
> >>  		exit(1);
> >>  	}
> >>  
> >> -	opts.syms = (const char **) syms;
> >> -	opts.cnt = cnt;
> >> +	opts.syms = (const char **)ksyms->filtered_syms;
> >> +	opts.cnt = ksyms->filtered_cnt;
> >>  	opts.retprobe = kretprobe;
> >>  	/* attach empty to all the kernel functions except bpf_get_numa_node_id. */
> >>  	if (!bpf_program__attach_kprobe_multi_opts(empty, NULL, &opts)) {
> > 
> > hi,
> > 
> > missing free_kallsyms_local call in here ?
> 
> Yeap, thanks.
> 
> > 
> > 
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> >> index 9caef222e528..f81dcd609ee9 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> >> @@ -456,25 +456,23 @@ static void test_kprobe_multi_bench_attach(bool kernel)
> >>  {
> >>  	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> >>  	struct kprobe_multi_empty *skel = NULL;
> >> -	char **syms = NULL;
> >> -	size_t cnt = 0;
> >> +	struct ksyms *ksyms = NULL;
> >>  
> >> -	if (!ASSERT_OK(bpf_get_ksyms(&syms, &cnt, kernel), "bpf_get_ksyms"))
> >> +	if (!ASSERT_OK(bpf_get_ksyms(&ksyms, kernel), "bpf_get_ksyms"))
> >>  		return;
> >>  
> >>  	skel = kprobe_multi_empty__open_and_load();
> >>  	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
> >>  		goto cleanup;
> >>  
> >> -	opts.syms = (const char **) syms;
> >> -	opts.cnt = cnt;
> >> +	opts.syms = (const char **)ksyms->filtered_syms;
> >> +	opts.cnt = ksyms->filtered_cnt;
> >>  
> >>  	do_bench_test(skel, &opts);
> >>  
> >>  cleanup:
> >>  	kprobe_multi_empty__destroy(skel);
> >> -	if (syms)
> >> -		free(syms);
> >> +	free_kallsyms_local(ksyms);
> >>  }
> >>  
> >>  static void test_kprobe_multi_bench_attach_addr(bool kernel)
> >> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> >> index eeaab7013ca2..0e63daf83ed5 100644
> >> --- a/tools/testing/selftests/bpf/trace_helpers.c
> >> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> >> @@ -24,12 +24,6 @@
> >>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
> >>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
> >>  
> >> -struct ksyms {
> >> -	struct ksym *syms;
> >> -	size_t sym_cap;
> >> -	size_t sym_cnt;
> >> -};
> >> -
> >>  static struct ksyms *ksyms;
> >>  static pthread_mutex_t ksyms_mutex = PTHREAD_MUTEX_INITIALIZER;
> >>  
> >> @@ -54,6 +48,8 @@ void free_kallsyms_local(struct ksyms *ksyms)
> >>  	if (!ksyms)
> >>  		return;
> >>  
> >> +	free(ksyms->filtered_syms);
> >> +
> >>  	if (!ksyms->syms) {
> >>  		free(ksyms);
> >>  		return;
> >> @@ -610,7 +606,7 @@ static int search_kallsyms_compare(const void *p1, const struct ksym *p2)
> >>  	return compare_name(p1, p2->name);
> >>  }
> >>  
> >> -int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
> >> +int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel)
> >>  {
> >>  	size_t cap = 0, cnt = 0;
> >>  	char *name = NULL, *ksym_name, **syms = NULL;
> >> @@ -637,8 +633,10 @@ int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
> >>  	else
> >>  		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
> >>  
> >> -	if (!f)
> >> +	if (!f) {
> >> +		free_kallsyms_local(ksyms);
> >>  		return -EINVAL;
> >> +	}
> >>  
> >>  	map = hashmap__new(symbol_hash, symbol_equal, NULL);
> >>  	if (IS_ERR(map)) {
> >> @@ -679,15 +677,18 @@ int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
> >>  		syms[cnt++] = ksym_name;
> >>  	}
> >>  
> >> -	*symsp = syms;
> >> -	*cntp = cnt;
> >> +	ksyms->filtered_syms = syms;
> >> +	ksyms->filtered_cnt = cnt;
> >> +	*ksymsp = ksyms;
> >>  
> >>  error:
> >>  	free(name);
> >>  	fclose(f);
> >>  	hashmap__free(map);
> >> -	if (err)
> >> +	if (err) {
> >>  		free(syms);
> >> +		free_kallsyms_local(ksyms);
> >> +	}
> > 
> > I think we could just call free_kallsyms_local unconditionally in here
> > and fix callers to free syms pointer? seems easier than adding filtered*
> > fields to ksyms
> 
> The strings in filtered_syms are ksyms->syms[i].name pointers (not
> copied). I didn't want to do another strdup, and I also didn't like
> passing three out parameters to bpf_get_ksyms().
> 
> So I decided to consolidate the data gathered by bpf_get_ksyms() in
> struct ksyms. ksyms->filtered_syms essentially is a view into the
> ksyms->syms, and it can be unused too.
> 
> Does this make sense?

yep, sounds good

thanks,
jirka
