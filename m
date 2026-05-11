Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9F2BDC0F
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483056; cv=none; b=dRMCc4aS1tk5XcjgChxpY7dX5z5nzUlerb99W+/XiB+6i4MyH5St5S67c00n/i2bZsAzJ0LfB1ZyEIhh2n8taznuC7TMFvtNkZZ3Ipx/4dLA5GCyS8S3HevSfZt6WdrGvjwpkrMY1Psj3Npy2JzpLlyCcI7VSsQ1KmrO4MkdNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483056; c=relaxed/simple;
	bh=xWXiEIkRID2HbOHZkGXMbOWh5qMJRfdnhDqvpS6AOgU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klF35JWuoPfOvDG1e7obazK1fxujFZ2PL01W+9MvPKONQ2sLuheGhUJ76JKSzvYLLHhOzwB2b0WKoiKLAqfiVVX9h+W62eidME91+Uc8rw4pj9nCPrZoD6ParM+GpO08NoFz5KkKF9dksTcNREspOjGh71zLXiFQNEkgokPU5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvIUU7ia; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvIUU7ia"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so25495615e9.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 00:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778483054; x=1779087854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZUvW9Ft73vwFxh83AsJtEdmaDcsb/p6dg/OLv6u71Q=;
        b=GvIUU7iahFjKWDdQydz3CONlAGzEVcts7OjOBZwoZisfwUwvLvMU4Xysi1+hYnLN3t
         xDdhH+yluaHvDijJ1ug59yss5AGRXfDcvUm9bLpVK90uDIT5Daaan39h/Zdrv421m34s
         NT07Yjn26WQoDCsajZsY9FjVYhKxCjgJ+AkPqtewH9AR5XQ6s6CBrvOuz/qAKl4DAgYa
         w1X+1oqKCJXdIsJUjVxM0e3WaExesKznWxSz8ILm1T8dUZfxy26Kb0Ma22spT9627mcB
         V9a3wqHSf3zzFt9fN0zj6y/ZtMIphVj88k7dUbY1vpnGbAs14pHs147w1QxOTGIOHBap
         o/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778483054; x=1779087854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZUvW9Ft73vwFxh83AsJtEdmaDcsb/p6dg/OLv6u71Q=;
        b=qW5xVz5c0saa+ikx6wQHcEgs32fs0yzgjFMqAbbep8w+lv8k8ez3CDUhvk7SFx+18j
         QNsF05ZG07GM9EGOFSKeS1DX9W3mWpPIYJiVMCZ0BJ7WXhUzLgqQZ1ziKwCa0LHy7PRv
         Ytxa5/igpQYcvWhRtTgTPlavwWnAC019wY1j5S44D9WaQW5L35Zqw5FhWeVNlXbyB+tw
         OrvsuMZ0qPUhJAnfkUBDqzRY2VUb94KcWFgTg+2xJvUUj49+c4pMq9XWbYjfO+IO6MWF
         Ev+UcSAA61CzpG6g1RAjlpoDPrXqr2O4a8nD24waCm2P13uNb0qGEvtjBPbR9dILxphL
         WXKg==
X-Forwarded-Encrypted: i=1; AFNElJ8cUQb8FdFHtTfz8XkvqROeaHcmMdmVgy4vUHKIf3WH1XQ1vx9u17BnzhjcRzvzOF8ju4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWmg5eKfzEgGvDWhIyELiAYptQLNAwt/nAFZWOwqno/Nffks9
	eyoQIwbF9D6TYQvqe3M6/2Rn9s/MeaeM0YM7+18lWy0/MMsQV4MMfUZe
X-Gm-Gg: Acq92OEbZQs1qsKaR57DA1yFj2F3OhGzzsstTMoVJSrP8es/oSLd89QMCGGdbemzWZt
	Sx1iJrZe0nMFzpZ5pNeXKXYU2/F50BeQjVLlRLnXeP1R0lKxV/lxMx0S1o345M8l3U2oE3D6o9R
	lUJh8JBglRyrKB9w499IZvpNWx1zrCDUaUKBvO2/4TPg69x2wJapMhBbBxnGMKs/5l4Erno6yju
	FKiUuVbIyCUUoFsPhBHPBBvi6afZyfe1Pmji6L8xP9HnEzyI36CCXuivkCd+OelyNIqSu18DLlc
	jObE88MKTSAc4xaKawszCluZgD2aLOlcFm1oAmrBuzkSYPUf+FRx0oCLY+6TNIwbPMtwAiLrMG7
	TcdXLKUK9zLJxiB4QuMe4OGSIPaoUiZUmruNXjCk7eKx+tOZsSp8sXdamPmUhc534RT+Drl4PlZ
	/ysCYhDsY=
X-Received: by 2002:a05:600c:c4a5:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-48e6cbd6c10mr184580015e9.5.1778483053646;
        Mon, 11 May 2026 00:04:13 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::e257])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fffb9bdsm152864335e9.1.2026.05.11.00.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:04:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 May 2026 09:04:11 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2] selftests/bpf: Use both hrtimer enqueue helpers
 in vmlinux test
Message-ID: <agF_a9RYywaT2c7f@krava>
References: <20260509005730.250956-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509005730.250956-1-ihor.solodrai@linux.dev>

On Fri, May 08, 2026 at 05:57:30PM -0700, Ihor Solodrai wrote:
> The vmlinux selftest triggers nanosleep and checks that both kprobe
> and fentry programs observe the hrtimer enqueue path.
> 
> After the hrtimer_start_expires_user() conversion [1], nanosleep
> reaches hrtimer_start_range_ns_user() instead of
> hrtimer_start_range_ns(). Hard-coding either symbol makes the test
> fail either on bpf tree or on linux-next [2].
> 
> Update the test to resolve the target symbol at runtime via
> libbpf_find_vmlinux_btf_id(). This is a nice example of how to modify
> a BPF program to work on both older and newer kernel revision.

iiuc this will help before the [1] fully propagates everywhere,
also good as an example

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> [1] https://lore.kernel.org/all/20260408114952.062400833@kernel.org/
> [2] https://github.com/kernel-patches/bpf/actions/runs/25485909958/job/74782902203
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> ---
> 
> v1->v2:
>   * Use bpf_program__set_attach_target() and bpf_program__attach_kprobe()
>     to avoid duplicating BPF programs (Amery)
> v1: https://lore.kernel.org/all/20260507113915.24988-1-ihor.solodrai@linux.dev/
> 
> ---
>  .../selftests/bpf/prog_tests/vmlinux.c        | 45 ++++++++++++++++++-
>  .../selftests/bpf/progs/test_vmlinux.c        |  4 +-
>  2 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/vmlinux.c b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
> index 6fb2217d940b..b5fdd593910d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/vmlinux.c
> +++ b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
> @@ -14,21 +14,61 @@ static void nsleep()
>  	(void)syscall(__NR_nanosleep, &ts, NULL);
>  }
>  
> +static const char *hrtimer_func = "hrtimer_start_range_ns";
> +
> +static int setup_hrtimer_progs(struct test_vmlinux *skel)
> +{
> +	int err;
> +
> +	if (libbpf_find_vmlinux_btf_id("hrtimer_start_range_ns_user", BPF_TRACE_FENTRY) > 0)
> +		hrtimer_func = "hrtimer_start_range_ns_user";
> +
> +	err = bpf_program__set_attach_target(skel->progs.handle__fentry, 0, hrtimer_func);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Bare SEC("kprobe") has no target function, so attach it manually
> +	 * later after selecting the hrtimer function to probe.
> +	 */
> +	bpf_program__set_autoattach(skel->progs.handle__kprobe, false);
> +
> +	return 0;
> +}
> +
>  void test_vmlinux(void)
>  {
>  	int err;
>  	struct test_vmlinux* skel;
>  	struct test_vmlinux__bss *bss;
> +	struct bpf_link *kprobe_link = NULL;
>  
> -	skel = test_vmlinux__open_and_load();
> -	if (!ASSERT_OK_PTR(skel, "test_vmlinux__open_and_load"))
> +	skel = test_vmlinux__open();
> +	if (!ASSERT_OK_PTR(skel, "test_vmlinux__open"))
>  		return;
> +
> +	err = setup_hrtimer_progs(skel);
> +	if (!ASSERT_OK(err, "setup_hrtimer_progs"))
> +		goto cleanup;
> +
> +	err = test_vmlinux__load(skel);
> +	if (!ASSERT_OK(err, "test_vmlinux__load"))
> +		goto cleanup;
> +
>  	bss = skel->bss;
>  
>  	err = test_vmlinux__attach(skel);
>  	if (!ASSERT_OK(err, "test_vmlinux__attach"))
>  		goto cleanup;
>  
> +	/* manually attach kprobe with the selected function */
> +	if (hrtimer_func) {
> +		kprobe_link = bpf_program__attach_kprobe(skel->progs.handle__kprobe,
> +							 false /* retprobe */, hrtimer_func);
> +		if (!ASSERT_OK_PTR(kprobe_link, "bpf_program__attach_kprobe"))
> +			goto cleanup;
> +	}
> +
>  	/* trigger everything */
>  	nsleep();
>  
> @@ -39,5 +79,6 @@ void test_vmlinux(void)
>  	ASSERT_TRUE(bss->fentry_called, "fentry");
>  
>  cleanup:
> +	bpf_link__destroy(kprobe_link);
>  	test_vmlinux__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c b/tools/testing/selftests/bpf/progs/test_vmlinux.c
> index 78b23934d9f8..eea556940df6 100644
> --- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
> +++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
> @@ -69,7 +69,7 @@ int BPF_PROG(handle__tp_btf, struct pt_regs *regs, long id)
>  	return 0;
>  }
>  
> -SEC("kprobe/hrtimer_start_range_ns")
> +SEC("kprobe")
>  int BPF_KPROBE(handle__kprobe, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
>  	       const enum hrtimer_mode mode)
>  {
> @@ -78,7 +78,7 @@ int BPF_KPROBE(handle__kprobe, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
>  	return 0;
>  }
>  
> -SEC("fentry/hrtimer_start_range_ns")
> +SEC("fentry")
>  int BPF_PROG(handle__fentry, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
>  	     const enum hrtimer_mode mode)
>  {
> -- 
> 2.54.0
> 
> 
