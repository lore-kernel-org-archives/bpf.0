Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6FB3AFB19
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907136; cv=none; b=RY3IqTNK/d9KVoBEFIdiWH+rzibd9D1Mx9669ZhkPpap46SnbtLUu+vpdbu1DgdGwfPklubdM/vecJ1+c0xJoxZ2LyI0AHcIZbOEAupAvN1p/3z5HkGeHGffijYGDOWyvaZ9durMmCSCV/Nk8A+P83dsT8B8Y09p6dM3FqcTwfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907136; c=relaxed/simple;
	bh=7oLS+ugpj9oTP6GYZy0XKsha72aYJhd0KlkskREawwk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB5kriGIC6m8Z32g/LrI3gLyLuoBpzbmCDuqJ0/9cRdIKhUUa56pTpYZTmiBnP5NS0TSIUpXHWLQEayXG67asGSP4+bKkHS1Cmhd4FhvwrQDj+vhTINlSTNo+GYPyP657DwvOJzcrKjoQZZZ07lF/YBW6VchRypw+vT3p0TRFJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvgExA/M; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvgExA/M"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45fe59255beso1958322f8f.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780907132; x=1781511932; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wJt2vWmLqZGTigOQwINI4d7Y8R4NKAJn6ZhYtLnbzNQ=;
        b=jvgExA/Mtmv5w+NDjlY+dIGHZ5F4jovm/pobrY3/eH8iENRu66J6QlqbvHZibMhgt/
         yggskqeXbUxlvFuS7WzvcMVzp54dAq5yUBTKIXWkYX/GWeVpdmbP6KSDq/cUSb1+ZIRs
         svnFMzGO2EBVgksHDkG0t6q/wT+R9ADcscf0i4HMmv5GYNukRaZ4Chw0KaHRWkOrKSuf
         NHM1f/pcDGnWOr1+VlYwKSbZ1n/jqKmzZ72AzhroUMuxbtZVGiX3GdMTnmuzyBU8FSf1
         em6iAiMhVrdrsWO1VZCA/mtoNAwZSktR00qeo2XLKwwD4fbTZpXVdRW8KV5UWwbmfsBn
         c2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907132; x=1781511932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJt2vWmLqZGTigOQwINI4d7Y8R4NKAJn6ZhYtLnbzNQ=;
        b=BGOwEG0vZ6wEfWBxSNmpsx3vBx/TqdYiLDRH53zI/m/oAeUQTY3JM6qusykrqRBjng
         AISkPNaGHPEP3t1xQoBXBKjF2l3CIN5vRzvpdn7UhV90Y2qhM7tMdWv3FiMzulfUmA9s
         +kVEix/55Ef+96BS8O6zxS0qTuJWfdh5vySTWQqpR/J6xd70OfuJ9JUoGgYIuG7cVTlL
         D26J4fPJXlfq1ZkNPVPlmnEvEvIfJK5jczm9QEEVzm/ZcNqSsJriLy8AOhxUuSK9K6cQ
         OQjsY2up5/Lt/vJqhw9fVYDFwkaghHU0zi+E++hF63s/ceDlBj+dr++DQcg+jfFnwl+H
         owkg==
X-Forwarded-Encrypted: i=1; AFNElJ/NrK6Ga/2yuD6O6S0GXC3+sGzkjxaVEbcweLzW9aMxLNV6D+RpOs4ohE9DO63bQgpImvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEjslKwAPH0LgG8yPu9fFUuMRAkkSgm1x2KS/C8J70FnlrdP5I
	vXVMybO00qeiSi4Nc4Sv40Enjmdr0y51rHBcnfZSma4GZuRWWwweoBRj
X-Gm-Gg: Acq92OF0kbYXhMkVMf8LDe6+3oTBppZ7wQ0hBywle0pBLKyUG+eoNUEQqwbC0AZboa/
	0uF1MZDJWdaoASJrGhOxL1ODVs2/4NG5E5cebyf8qfkOHtRuwSDA5begpUzyMH+su4zanNOs/G2
	a6JAkSoLVXhyjeqMmOD0wljM8j+ab0gLQHa/GSSpyrvet5cgtN07Fgj374wRFSYfBQyMXSFeQ6X
	jWVoUyTTweWvT76NfhApUMWpcwm0OUaKCMTX55xvf+XxnOVrVpbn5xypOo0utErW08hZWLo0qVY
	zBYipHc3fp19H4ldTzdLh6HtiStIPqaxE+rg+GnOgKRsS49t3/sZ2uRkYiZntepJNSqEgeSNInI
	7m4/dm/su6gv2Klx66QqjrJAh56JWZ8WLTkHy+0LHjasb2+zxIoQyLvJNuMULIqgBXr2xBN3pAL
	xqcShtfUnA3mjCH7m2yP+ejA==
X-Received: by 2002:adf:ff89:0:b0:45e:ef2e:25a8 with SMTP id ffacd0b85a97d-46030623f7emr17766574f8f.32.1780907132343;
        Mon, 08 Jun 2026 01:25:32 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm49087250f8f.12.2026.06.08.01.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:25:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 8 Jun 2026 10:25:30 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv8 bpf-next 28/29] selftests/bpf: Add tracing multi attach
 benchmark test
Message-ID: <aiZ8euKIuw_9qaw6@krava>
References: <20260606123955.345967-1-jolsa@kernel.org>
 <20260606123955.345967-29-jolsa@kernel.org>
 <DJ30RPYRXESZ.2P3LP98X55VMG@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DJ30RPYRXESZ.2P3LP98X55VMG@gmail.com>

On Sun, Jun 07, 2026 at 11:13:32AM -0700, Alexei Starovoitov wrote:
> On Sat Jun 6, 2026 at 5:39 AM PDT, Jiri Olsa wrote:
> > Adding benchmark test that attaches to (almost) all allowed tracing
> > functions and display attach/detach times.
> >
> >   # ./test_progs -t tracing_multi_bench_attach -v
> >   bpf_testmod.ko is already unloaded.
> >   Loading bpf_testmod.ko...
> >   Successfully loaded bpf_testmod.ko.
> >   serial_test_tracing_multi_bench_attach:PASS:btf__load_vmlinux_btf 0 nsec
> >   serial_test_tracing_multi_bench_attach:PASS:tracing_multi_bench__open_and_load 0 nsec
> >   serial_test_tracing_multi_bench_attach:PASS:get_syms 0 nsec
> >   serial_test_tracing_multi_bench_attach:PASS:bpf_program__attach_tracing_multi 0 nsec
> >   serial_test_tracing_multi_bench_attach: found 51186 functions
> >   serial_test_tracing_multi_bench_attach: attached in   1.295s
> >   serial_test_tracing_multi_bench_attach: detached in   0.243s
> 
> ...
> 
> > +	if (!ASSERT_OK(bpf_get_ksyms(&ksyms, true), "get_syms"))
> > +		goto cleanup;
> > +
> > +	/* Get all ftrace 'safe' symbols.. */
> > +	for (i = 0; i < ksyms->filtered_cnt; i++) {
> > +		if (!tsearch(&ksyms->filtered_syms[i], &root, compare)) {
> > +			ASSERT_FAIL("tsearch failed");
> > +			goto cleanup;
> > +		}
> > +	}
> > +
> > +	/* ..and filter them through BTF and btf_type_is_traceable_func. */
> > +	nr = btf__type_cnt(btf);
> > +	for (type_id = 1; type_id < nr; type_id++) {
> > +		const struct btf_type *type;
> > +		const char *str;
> > +
> > +		type = btf__type_by_id(btf, type_id);
> > +		if (!type)
> > +			break;
> > +
> > +		if (BTF_INFO_KIND(type->info) != BTF_KIND_FUNC)
> > +			continue;
> > +
> > +		str = btf__name_by_offset(btf, type->name_off);
> > +		if (!str)
> > +			break;
> > +
> > +		if (!tfind(&str, &root, compare))
> > +			continue;
> > +
> > +		if (!btf_type_is_traceable_func(btf, type))
> > +			continue;
> > +
> > +		err = libbpf_ensure_mem((void **) &ids, &cap, sizeof(*ids), cnt + 1);
> > +		if (err)
> > +			goto cleanup;
> > +
> > +		ids[cnt++] = type_id;
> > +	}
> 
> This filtering wasn't enough.
> I've added removal of duplicates here while applying:
> 
> +       /*
> +        * Collect names that are not unique in kallsyms. The kernel resolves a
> +        * tracing-multi BTF id to an address with kallsyms_lookup_name(), which
> +        * returns the first symbol of that name. For a duplicate name that may
> +        * be a different (non-ftrace-able) instance than the ftrace-able one in
> +        * available_filter_functions, so attaching to it by BTF id fails with
> +        * -ENOENT (e.g. t_start/t_next/t_stop). ksyms->syms is sorted by name,
> +        * so equal names are adjacent.
> +        */
> +       for (i = 1; i < ksyms->sym_cnt; i++) {
> +               if (strcmp(ksyms->syms[i].name, ksyms->syms[i - 1].name))
> +                       continue;
> +               if (!tsearch(&ksyms->syms[i].name, &dups, compare)) {
> +                       ASSERT_FAIL("tsearch failed");
> +                       goto cleanup;
> +               }
> +       }
> 
> 
> +               /* Skip names that are not unique in kallsyms, see above. */
> +               if (tfind(&str, &dups, compare))
> +                       continue;
> 
> 
> As claude explains it:
> ----
> 1. The kernel attaches tracing_multi by BTF id. To get an address it resolves
> the BTF function name via kallsyms_lookup_name(tname) and requires
> ftrace_location(addr) — kernel/bpf/verifier.c:19380:
> addr = kallsyms_lookup_name(tname);
> ...
> if (!addr || !ftrace_location(addr))
>         return -ENOENT;
> 2. t_start/t_next/t_stop each have 5 instances in this kernel. Only one is
> ftrace-able — the copies in kernel/trace/* are built notrace (ftrace's Makefile
> strips -pg), so only the unrelated copy is in available_filter_functions:
> 3. kallsyms_lookup_name() returns the lowest-address instance among equal names
> (exact strcmp, lowest seq). That instance has no fentry → ftrace_location()
> returns 0 → -ENOENT, which aborts the whole all-or-nothing bench attach.
> 
> Why the bench includes them: it intersects BTF FUNC names with
> available_filter_functions names. Since some t_start is ftrace-able, the name
> passes the filter — but the kernel resolves the wrong (non-ftrace-able)
> t_start. The author's kernel apparently had the ftrace-able copy at the lowest
> address, so it passed there.
> 
> This is a pre-existing limitation, not multi-specific: single fentry attach by
> BTF id uses the same kallsyms_lookup_name(tname) path (verifier.c:19120) — you
> can't reliably fentry-attach to any duplicate-named function on this kernel
> either.
> ----

strange I never triggered that.. but makes sense

> 
> Maybe we should adjust bpf_get_ksyms() instead. Not sure.

the only other user is test_kprobe_multi_bench_attach which does
not care about this, so I think at this point keeping this in the
serial_test_tracing_multi_bench_attach is enough for now

thanks,
jirka
