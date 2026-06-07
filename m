Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4232A23395E
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780856016; cv=none; b=ltpsDRe5OBuQz0+Jt6Fi62t47S8xGbVSf+zfNKjTBUJV1GKTTjbhP5t8+Ua+sBf5NPQ8TRyEMuSCQiciW0+FkuW9dkOR6BDpy6FREu6x5cjn+TaUxz2cuhnky+tDcLkwjVP7flNe/UCCZYXK+D4ZtIGijsAmDp93/OJY6erlhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780856016; c=relaxed/simple;
	bh=BP5TyjY1pCtGKAT//P7a7GvSHOPY7JKM31CFHBGd4Qs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=fKHTEKQasb/QYrxJ/+4DHpR9CXGQEIW8Xjtaq4DEALbn5/h/AOwarl4Q05L2wyJwsdMsOdgH3MB6VpdJYEOZ8Me4//2VX/NXMwxbai58YnqeLh5kDgcRVr531CGtD0gfwFdBo4QbSeVcjtmJfX3pAMmLFRbtjI7SFKRuQ1F3pGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rE1QYYK0; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rE1QYYK0"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48611addcfbso1387911b6e.1
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780856014; x=1781460814; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3HXEYBCN+P/6hSxIy3mpYQoUowU8aTo9ESTr8/tzPI=;
        b=rE1QYYK0dVxik6mH8AsS/SFr8PiHyanCL93p7jT/6osWXHnTypGUVS3LqOklwLiyle
         0mquJaZ6EAe9QMD9e08alKt85ELwTIb31vDgFQS6puIzyFVxCd3nIBu4Kxyt9Vqq/Oa6
         WV3FKYDmcY9YsSJ0ZJCUy+cNHNuIBCMMMvNN7zUczkUIttU/6K8oyGeTkmzNcu/Ju8pe
         gWq+f/X/aQDqzvdwBmM3xNUtQxRRK/sYk70vCLG8gAcn1ESv/h1qDH1eauAbofGnOwDe
         v6Nzn3nywlK6HNY0tTHCM3B8C3qGkP6fyytmzKfaxEEGfzRVmBV1YG5g1Ok0PgSdSK+Y
         Mamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780856014; x=1781460814;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3HXEYBCN+P/6hSxIy3mpYQoUowU8aTo9ESTr8/tzPI=;
        b=kHDQXcT8E9xLebmtLSqyBEMujnOzcERmAlnjRtVvBibfDDMPYeTPhiFEhI7643u0vt
         eA0I22B969qYdc++GCbMjBTI9bMC6RCiWjb51Yf9fExpM8FFx5l+pDtYmEL/sDY/7QuH
         dtuA06T9G33SRFsZZ3lJnD0HvF+JoMZmm2hP0OhrfH614mQ7BSTo4OcaOCbW2lSW43vy
         Eu9O3fuiLrljpWGgdsDTh3g+qgQBaSSuj9jTUw6P9laYW31krVayAxtyqbQXOlPg8QgE
         EYedV+eQuN8Uuh6H32ymhuc/sV5S3kcH/gFc1caSxRIyLbbcSSM+FkrPNV1yWPVORTEF
         6ALQ==
X-Gm-Message-State: AOJu0YwzhAEVTXX/X5FnVFm+O8iUpWmxHr2bODjIr0qaP/2VTM51QSCU
	uFXZkj4R47Mh4uN8aVt04wcjO3+Q7wnL9iHI7+bURGz6xOpr7OagDteu
X-Gm-Gg: Acq92OEhkJtqCwnrxh/KFXInZfBzGE3n8+QiBmUVsoy0PIj9gMtI505RE130I6Y1I/e
	VYH+skVDPj3yzThCd7KSNaHkyU0JdwH9jloN9jMrWnRRL8GVu8+ii1/7Lg2lUVdq/0kQgRsiPO9
	fAi0EM9qaqZbkXWG82McccbDlMd0b5uKjW3UtN79ry5tO7d1IKgjuO+0+M4zcOrKsh2OyMdNLcl
	QhW66gMQeCvXHlzTWLYre3qiL2PYdrlNp/XqX1N2wVD+Is5KiucHJXs3SkcDE5VUoHFYZbh+Q7h
	pL1PmPlddJqJr6u3ZOpc+kYA1OE6Vgql2g/93WnGUfFX1pRLe3rSiQqybk4Ox8cHA9aQafw+Oq8
	2ej/b8BCcoCJykLObjjJBiVSoxOZZb8k1ST+O5Wx9DY+VZ+4bykKeTPl4CLEyGmluaqErrljMK/
	2KQhRW8xb0HG6zmrF5A3rL/aOl7nWEBot6xqww15hl/niqa8Q3imK70dBL3jawkOveVzfju6Z/7
	NSRQ9uGNVyiI4b5cXybjcOSnto=
X-Received: by 2002:a05:6808:1a19:b0:486:52c6:36d8 with SMTP id 5614622812f47-4868db2dc14mr6846567b6e.5.1780856014039;
        Sun, 07 Jun 2026 11:13:34 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e7965006sm10804134a34.23.2026.06.07.11.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 11:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 11:13:32 -0700
Message-Id: <DJ30RPYRXESZ.2P3LP98X55VMG@gmail.com>
Subject: Re: [PATCHv8 bpf-next 28/29] selftests/bpf: Add tracing multi
 attach benchmark test
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>, "Menglong
 Dong" <menglong8.dong@gmail.com>, "Steven Rostedt" <rostedt@kernel.org>
X-Mailer: aerc
References: <20260606123955.345967-1-jolsa@kernel.org>
 <20260606123955.345967-29-jolsa@kernel.org>
In-Reply-To: <20260606123955.345967-29-jolsa@kernel.org>

On Sat Jun 6, 2026 at 5:39 AM PDT, Jiri Olsa wrote:
> Adding benchmark test that attaches to (almost) all allowed tracing
> functions and display attach/detach times.
>
>   # ./test_progs -t tracing_multi_bench_attach -v
>   bpf_testmod.ko is already unloaded.
>   Loading bpf_testmod.ko...
>   Successfully loaded bpf_testmod.ko.
>   serial_test_tracing_multi_bench_attach:PASS:btf__load_vmlinux_btf 0 nse=
c
>   serial_test_tracing_multi_bench_attach:PASS:tracing_multi_bench__open_a=
nd_load 0 nsec
>   serial_test_tracing_multi_bench_attach:PASS:get_syms 0 nsec
>   serial_test_tracing_multi_bench_attach:PASS:bpf_program__attach_tracing=
_multi 0 nsec
>   serial_test_tracing_multi_bench_attach: found 51186 functions
>   serial_test_tracing_multi_bench_attach: attached in   1.295s
>   serial_test_tracing_multi_bench_attach: detached in   0.243s

...

> +	if (!ASSERT_OK(bpf_get_ksyms(&ksyms, true), "get_syms"))
> +		goto cleanup;
> +
> +	/* Get all ftrace 'safe' symbols.. */
> +	for (i =3D 0; i < ksyms->filtered_cnt; i++) {
> +		if (!tsearch(&ksyms->filtered_syms[i], &root, compare)) {
> +			ASSERT_FAIL("tsearch failed");
> +			goto cleanup;
> +		}
> +	}
> +
> +	/* ..and filter them through BTF and btf_type_is_traceable_func. */
> +	nr =3D btf__type_cnt(btf);
> +	for (type_id =3D 1; type_id < nr; type_id++) {
> +		const struct btf_type *type;
> +		const char *str;
> +
> +		type =3D btf__type_by_id(btf, type_id);
> +		if (!type)
> +			break;
> +
> +		if (BTF_INFO_KIND(type->info) !=3D BTF_KIND_FUNC)
> +			continue;
> +
> +		str =3D btf__name_by_offset(btf, type->name_off);
> +		if (!str)
> +			break;
> +
> +		if (!tfind(&str, &root, compare))
> +			continue;
> +
> +		if (!btf_type_is_traceable_func(btf, type))
> +			continue;
> +
> +		err =3D libbpf_ensure_mem((void **) &ids, &cap, sizeof(*ids), cnt + 1)=
;
> +		if (err)
> +			goto cleanup;
> +
> +		ids[cnt++] =3D type_id;
> +	}

This filtering wasn't enough.
I've added removal of duplicates here while applying:

+       /*
+        * Collect names that are not unique in kallsyms. The kernel resolv=
es a
+        * tracing-multi BTF id to an address with kallsyms_lookup_name(), =
which
+        * returns the first symbol of that name. For a duplicate name that=
 may
+        * be a different (non-ftrace-able) instance than the ftrace-able o=
ne in
+        * available_filter_functions, so attaching to it by BTF id fails w=
ith
+        * -ENOENT (e.g. t_start/t_next/t_stop). ksyms->syms is sorted by n=
ame,
+        * so equal names are adjacent.
+        */
+       for (i =3D 1; i < ksyms->sym_cnt; i++) {
+               if (strcmp(ksyms->syms[i].name, ksyms->syms[i - 1].name))
+                       continue;
+               if (!tsearch(&ksyms->syms[i].name, &dups, compare)) {
+                       ASSERT_FAIL("tsearch failed");
+                       goto cleanup;
+               }
+       }


+               /* Skip names that are not unique in kallsyms, see above. *=
/
+               if (tfind(&str, &dups, compare))
+                       continue;


As claude explains it:
----
1. The kernel attaches tracing_multi by BTF id. To get an address it resolv=
es
the BTF function name via kallsyms_lookup_name(tname) and requires
ftrace_location(addr) =E2=80=94 kernel/bpf/verifier.c:19380:
addr =3D kallsyms_lookup_name(tname);
...
if (!addr || !ftrace_location(addr))
        return -ENOENT;
2. t_start/t_next/t_stop each have 5 instances in this kernel. Only one is
ftrace-able =E2=80=94 the copies in kernel/trace/* are built notrace (ftrac=
e's Makefile
strips -pg), so only the unrelated copy is in available_filter_functions:
3. kallsyms_lookup_name() returns the lowest-address instance among equal n=
ames
(exact strcmp, lowest seq). That instance has no fentry =E2=86=92 ftrace_lo=
cation()
returns 0 =E2=86=92 -ENOENT, which aborts the whole all-or-nothing bench at=
tach.

Why the bench includes them: it intersects BTF FUNC names with
available_filter_functions names. Since some t_start is ftrace-able, the na=
me
passes the filter =E2=80=94 but the kernel resolves the wrong (non-ftrace-a=
ble)
t_start. The author's kernel apparently had the ftrace-able copy at the low=
est
address, so it passed there.

This is a pre-existing limitation, not multi-specific: single fentry attach=
 by
BTF id uses the same kallsyms_lookup_name(tname) path (verifier.c:19120) =
=E2=80=94 you
can't reliably fentry-attach to any duplicate-named function on this kernel
either.
----

Maybe we should adjust bpf_get_ksyms() instead. Not sure.

After the fix in my gcc 15 kernel with KASAN:
serial_test_tracing_multi_bench_attach: found 49045 functions
serial_test_tracing_multi_bench_attach: attached in   4.115s
serial_test_tracing_multi_bench_attach: detached in   2.313s

