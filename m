Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4463F926F
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881585; cv=none; b=YS74vL2xnmh0z3WJLg3HCMa5kN+HC7jJx6zK8tOTfj3xFQZev3yDg5VipP0gryg0ENq55qY+2Oi027Qn5MHbQreIz9+3sv+WwSBMiHb/Rfs5oH5i6rK7yGrWDEDxIpJldprDg1rREsVbPLOOhlS5JJQSnxEkVZqjENZiLDMfPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881585; c=relaxed/simple;
	bh=zdDEQw3POEcBNK1m+nnHV4Ups4oqCj8UqbP2vlgbI9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTdY1zQPLFh+kfstgdtdGhftnJBYekiBD7osFV8zsLa9ddK/s9UlFC/nkKGkcSVBF4hs7Am/hg80hW3YARR/aY9f+ls7wlOWBX+Hh8wgBFOJNa8XjjYv8qp9T6kDdB9Tvc9UQ+kqS0n0e6EOQLMZK+kgI3LnSd4ZAFeC9+smFio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VPFWg5wI; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VPFWg5wI"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd8f9725b30so1296377666b.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779881570; x=1780486370; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7gvLdv/Bq5CbEznwFrU/dQuDdRJJpw/RX9SjzX/Pdc=;
        b=VPFWg5wIGvZcJ+2xiZR11Ydl0OCsjGE816K2a2VUtUbb+ilmLSKYKUTo6NkSJWHUJs
         U4mUG9b1NCbHM3LKXkN3C29GEgQthz7fYTCD6BYeuxQkiVkj8a9rXqg3wk4wNeqc2s3U
         3+1EF/iwhuxbqHW1dSabBM8hWsCiDcMoXBrLRHE6YDHmoVm7ycvDyYDS5lM6Pnpnk88V
         t2USY0RnzTCTDFME646HiL+qYcBJjNt5se+u85Mws3C5WyL+03fxiveBKmcMbomnG1cj
         AAhmvVxM5wnGf6zmfMKsbkmeDRUDkaDhfpBu3Iq6D2HSzZvqPRNge+0cWcGN5YA+ccIC
         0Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779881570; x=1780486370;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7gvLdv/Bq5CbEznwFrU/dQuDdRJJpw/RX9SjzX/Pdc=;
        b=M6Y4OTkelfM9bw5acZacXSYve2ptfpN9aZ0lmo4TYz/86XdChvLriBmylRyBEx5AyI
         y1hqk1OCmBAhKfpL0X4j/h0iR3CBlE3U8xi/fA6I5remD+Ryby4VMBI4PEeNeVb8eVPX
         +5yM9IfRyE4Mx01RrcGjwLouFQQwCOPvq1Y8SepzQS+yIBSisNL+3KpeLUCoUYd8cIm5
         a+0n/9IA51pFnC2A2+v56XjP3hobN3xoJ+yB0UFF/vF7S96RMxR1sXPpRULucn9i9P8A
         O+iAhIIV7gXUUTyOs6VswBlcmwvzH6V0iSJ/JDl/vYsjhKZNF4px9MOgWjqLXOZEJjaz
         s0ow==
X-Forwarded-Encrypted: i=1; AFNElJ+eUUNWRrGgQasd4rvbJV+hRGh/x+wFFYaW/j/QYHWK22DZm0WfTBi4qWHaTKRcQBhEszU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsD4o2Zije6MgL/cixCQS696Q2Uiue+NrbDyY3yDANHxDBcFwU
	gt0sKBfXwykMbQIlhmXGCZIesLchS4861OV7sOiAvYg4+/sutPKlQOSY/qICEjqTQvg=
X-Gm-Gg: Acq92OH0K8VwwDVKLifoe1KjRPv4rH2x1BKjDsYwWIE0q8Cs32LvgDcNz69C4T1LZrv
	drxXCxbXIiZRMfmVv5VdOHy1Xy0t5mamgQbZ2uOS9rdA4r+ic4PoS+hORtjxBX4BNZkj1adjbKV
	5UScnt/OKPPHIczHYQvhPnp3ob5ET2eUO3ZuDThYxIGGhNUBPaA4fqvk+B5vfdF/g3UsI8eZIAg
	WwonOjzfdQ1lrDBkrTn7Qq2ieKmrABWjzdfvBcaWjwhI/YHwMen9J5R6RBHxp6O67pFE4lkCIMw
	C98xcrrWk36+rd8JpIg5CEVdZ+xELZW11Q87q9ncLWFAvb+wC8zC0fBNLCN5Y2g2p59Q6+Dm0cl
	uVNbRBjhYJUDRti8mnUi/+b4p8+0SsXOxX9nO6fd5vsiCw2YU5wJc0Ky5h3p/pgLp1vZV4wKImA
	JYdIJcCVH+i3tDgasiq5FN/s7Fyg==
X-Received: by 2002:a17:907:d22:b0:bd5:7a3:a596 with SMTP id a640c23a62f3a-bdd2b2f40cbmr1286972666b.49.1779881569751;
        Wed, 27 May 2026 04:32:49 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc264e424sm599288466b.6.2026.05.27.04.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:32:49 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  bpf@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 11/13] selftests/bpf: Add reattach tests for uprobe
 syscall
In-Reply-To: <20260526205840.173790-12-jolsa@kernel.org> (Jiri Olsa's message
	of "Tue, 26 May 2026 22:58:38 +0200")
References: <20260526205840.173790-1-jolsa@kernel.org>
	<20260526205840.173790-12-jolsa@kernel.org>
Date: Wed, 27 May 2026 13:32:48 +0200
Message-ID: <87tsrt5bq7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 26, 2026 at 10:58 PM +02, Jiri Olsa wrote:
> Adding reattach tests for uprobe syscall tests to make sure
> we can re-attach and optimize same uprobe multiple times.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 114 ++++++++++++++++--
>  1 file changed, 104 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 0868fb9793e0..969f4deba9fd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -430,23 +430,28 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
>  	return tramp;
>  }
>  
> -static void check_detach(void *addr, void *tramp)
> +static bool check_detach(void *addr, void *tramp)
>  {
>  	static const char nop10_prefix[] = { 0x66, 0x2e, 0x0f, 0x1f, 0x84 };
> +	bool ok = true;
>  
>  	/* [uprobes_trampoline] stays after detach */
> -	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> -	ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix");
> +	if (!ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline"))
> +		ok = false;
> +	if (!ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix"))
> +		ok = false;
> +	return ok;
>  }

Nit: Maybe apply the same pattern you used in
progs/get_func_args_test.c?

ok &= ASSERT_OK(...)
ok &= ASSERT_OK(...)

>  
> -static void check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
> -		  trigger_t trigger, void *addr, int executed)
> +static void *check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
> +		   trigger_t trigger, void *addr, int executed)

Nit: Kinda wish that was called check_attach_detach().

>  {
>  	void *tramp;
>  
>  	tramp = check_attach(skel, trigger, addr, executed);
>  	bpf_link__destroy(link);
>  	check_detach(addr, tramp);
> +	return tramp;
>  }
>  
>  static void test_uprobe_legacy(void)
> @@ -457,6 +462,7 @@ static void test_uprobe_legacy(void)
>  	);
>  	struct bpf_link *link;
>  	unsigned long offset;
> +	void *tramp;
>  
>  	offset = get_uprobe_offset(&uprobe_test);
>  	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
> @@ -474,7 +480,28 @@ static void test_uprobe_legacy(void)
>  	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
>  		goto cleanup;
>  
> -	check(skel, link, uprobe_test, uprobe_test, 2);
> +	tramp = check(skel, link, uprobe_test, uprobe_test, 2);
> +
> +	/* reattach and detach without triggering optimization */
> +	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
> +					       0, "/proc/self/exe", offset, NULL);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
> +		goto cleanup;
> +

In theory we're missing a check here that an unoptimized uprobe was
installed. If nothing happened at all between the last check() and
check_destroy() below, the test would still pass.

Applies to the three similar changes after that one as well.

> +	bpf_link__destroy(link);
> +	if (!check_detach(uprobe_test, tramp))
> +		goto cleanup;
> +
> +	uprobe_test();
> +	ASSERT_EQ(skel->bss->executed, 2, "executed_no_probe");
> +
> +	/* reattach with triggering optimization */
> +	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
> +				0, "/proc/self/exe", offset, NULL);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
> +		goto cleanup;
> +
> +	check(skel, link, uprobe_test, uprobe_test, 4);
>  
>  	/* uretprobe */
>  	skel->bss->executed = 0;

[...]
