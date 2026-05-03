Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AF534C80D
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777814079; cv=none; b=cbSgMlatvfxFcUBPjVfKwz11ZPiOMYB4BdBOF6hAlM8KlTxaYuZkn6JYI2qkA1lXQBciNytqddRUlXJLh3f3D09L3wvm98pnbwchICq9ElC1iCBVT5v0vQKv6fSAgrVgVuaQK64AGYkQEsDtbFSCr8G1+q0MqWf3Mzi0NqdUSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777814079; c=relaxed/simple;
	bh=+3Sw65MH+mH8uvVkx6voWfoLejVJ67hl97HwhBk7N38=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmsIftA96+806LIs2jSz3xCOTadMzjIkCUcCV13voZQv+G8HDtSxw7jfvYHZP1GUwGzkxgJcT8/PSYaLi6gVQrD1rZHBr4fKhOaOv4O1R1C0UBuHf085WvnB8Q+tFm+yRpFkH9geOwuqU6g7as+oFZlaPDJgiqqtLAMlUp7xaSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gELKhWKS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gELKhWKS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so36071065e9.2
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 06:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777814076; x=1778418876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+t8aQ2D50+bAUmo6lhfUsih7msb5k9k8rxqeFudZz0=;
        b=gELKhWKSk5oavAWIUeKwKcVVRqrZJa7/yusszidHuHAJ39hKPGwqip4AJN5Glk8W0b
         mjp+XT888ILOrdmGrVIq1611zpMQPRng7xqkUjVMIxUwcD+zUlIdc34/Bb2ob0IUV0TZ
         zZB6hIX8TsEbFlXDYFVnhpbKWpcHVyOv6njHYZe6V5iEomi00LcFpV1+eM3nBu/9z1lg
         bsAC/Tdm5NhIHvyXKPoP9dIgZg3qgFo0+eipJqBtZjkiebHoDa53zC04D+fu4jdXiIWU
         Agfecedm9Ie69N5kU3OxlnLAkITZtvZ7QQL1FM+01/lE/RiduN4e6VSVY2wuuFiUPlbL
         bu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777814076; x=1778418876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+t8aQ2D50+bAUmo6lhfUsih7msb5k9k8rxqeFudZz0=;
        b=UNt07nEf0Ue9FA/YIB7oad6hteJd+iLUamQInVdsr+HPvL5bDyp6RHVR0+eb2mdiO7
         IVEcmG82nVwA2NYDEWA9w9Sdt47rR9AkjTEq0y8wMYxJa/VNhtGrAWiaQ+h1OIDnBuRU
         3AFMAQ4TQAz88rMerD16Tz0/yGCQoXywrujje8MbQsRNhTMtUj/6dr+716Qx/AZHcui0
         48Wtrdg0/0lUYlvGYXEzA2+vI0Q1n2F4ZXMotfmXvphDxHOQ4Oam8jXmFn9nbeYHSh8/
         rwkeFqvJdC4A9xi4sfdYtuCgeSYdDt8dZydAajyQ6wL8F6c5FZy+jWhKKNV8W0I+HWtA
         37IA==
X-Gm-Message-State: AOJu0YwKE3ZBOQ/gLbgyq22FjhdjRSoReic8SBVBMolNfGwvX/PwKj5e
	1TffBXlGsmxoGMVT3W2ad0lhjBA/h8VoIJV3jlYnpeoUuajPCglllRaE
X-Gm-Gg: AeBDieuvuezQezVkOn+s3yJZDabqlE4sRdG3l0QJxaLBiw//bJNMg2YPLC2+Gw0/mSD
	/PCvUiv/gvsIqDvfms3HAWlf+ZSNwhpFNse87aokbdwXU2pSjnbeLmEO2c+X++gU4nbAsdd4Jly
	GRgjY7MeA/HpotGvQEzSVENvIpNHfmQyDXjRkavfZRhKqXFrnYXworzyBBXOBq2SKkIeQi5AtXC
	ldREJHuvpXQy62O3XMoFmR/UYIEAfhDX+B7HsMe7YT9uzTq5ePcdQrJLUb1Glnm0a2AoSQiWOAn
	b5CghM/fQeLVwpNsIfME+drSw7Bpdp4gITEjc7jATUGMLCu3jsaCT/geVJ60CC0kPGg38p7o8tw
	VBHTRMEHTKX+MVxiUMOn+xp9hSezY+63/h2XqTIs4nKsnW2W81gl3KLO85AyGlOdblxv+4GHX9V
	gtk2WpsGSgUFH6HmTkpMSbcP5x
X-Received: by 2002:a05:600c:c119:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-48a9866cdd9mr76172175e9.22.1777814075721;
        Sun, 03 May 2026 06:14:35 -0700 (PDT)
Received: from krava ([2a00:102a:5035:d0c8:1b40:17fc:ed0:1fcd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba6f83sm186736065e9.9.2026.05.03.06.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 06:14:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 3 May 2026 15:14:32 +0200
To: Florian Lehner <dev@der-flo.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, shuah@kernel.org, davem@davemloft.net,
	kuba@kernel.org, hawk@kernel.org, sdf@fomichev.me,
	sun.jian.kdev@gmail.com
Subject: Re: [PATCH bpf-next 2/2 v3] selftests/bpf: Test LINK_DETACH for perf
 link
Message-ID: <afdKOE6HJVb09tiL@krava>
References: <20260501160901.224134-1-dev@der-flo.net>
 <20260501160901.224134-3-dev@der-flo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501160901.224134-3-dev@der-flo.net>

On Fri, May 01, 2026 at 06:09:01PM +0200, Florian Lehner wrote:
> Add test_perf_link_detach() to verify that the new LINK_DETACH support for
> BPF perf links works correctly. The test creates a link to a BPF program
> for a software perf event, confirms the program is executed, calls
> bpf_link_detach() to exercise the BPF_LINK_DETACH syscall path, and then
> verifies the program is no longer invoked after detach.
> 
> Signed-off-by: Florian Lehner <dev@der-flo.net>

hi,
you mentioned in here [1] the primary use case is to disable uprobes
temporarily.. I was expecting this as a selftest and curious to see
how that works.. could you add selftest for that?

thanks,
jirka


[1] https://lore.kernel.org/bpf/aJOhPoTLdYnZmHYA@der-flo.net/


> ---
>  .../selftests/bpf/prog_tests/perf_link.c      | 79 ++++++++++++++++---
>  1 file changed, 67 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
> index 9e3a0d217af8..b75112c1b67d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
> @@ -18,29 +18,84 @@ static void burn_cpu(void)
>  		barrier();
>  }
>  
> -void test_perf_link(void)
> +static int perf_link_setup(struct test_perf_link **skel, int *pfd)
>  {
> -	struct test_perf_link *skel = NULL;
>  	struct perf_event_attr attr;
> -	int pfd = -1, link_fd = -1, err;
> -	int run_cnt_before, run_cnt_after;
> -	struct bpf_link_info info;
> -	__u32 info_len = sizeof(info);
> -	__u64 timeout_time_ns;
>  
> -	/* create perf event */
>  	memset(&attr, 0, sizeof(attr));
>  	attr.size = sizeof(attr);
>  	attr.type = PERF_TYPE_SOFTWARE;
>  	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>  	attr.freq = 1;
>  	attr.sample_freq = 1000;
> -	pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
> -	if (!ASSERT_GE(pfd, 0, "perf_fd"))
> +	*pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
> +	if (!ASSERT_GE(*pfd, 0, "perf_fd"))
> +		return -1;
> +
> +	*skel = test_perf_link__open_and_load();
> +	if (!ASSERT_OK_PTR(*skel, "skel_load"))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +void test_perf_link_detach(void)
> +{
> +	struct test_perf_link *skel = NULL;
> +	int pfd = -1, link_fd = -1, err;
> +	int run_cnt_before, run_cnt_after;
> +	__u64 timeout_time_ns;
> +
> +	if (perf_link_setup(&skel, &pfd))
> +		goto cleanup;
> +
> +	link_fd = bpf_link_create(bpf_program__fd(skel->progs.handler), pfd,
> +				  BPF_PERF_EVENT, NULL);
> +	if (!ASSERT_GE(link_fd, 0, "link_fd"))
>  		goto cleanup;
>  
> -	skel = test_perf_link__open_and_load();
> -	if (!ASSERT_OK_PTR(skel, "skel_load"))
> +	/* ensure we get at least one perf_event prog execution */
> +	timeout_time_ns = get_time_ns() + BURN_TIMEOUT_NS;
> +	while (true) {
> +		burn_cpu();
> +		if (skel->bss->run_cnt > 0)
> +			break;
> +		if (!ASSERT_LT(get_time_ns(), timeout_time_ns, "run_cnt_timeout"))
> +			goto cleanup;
> +	}
> +
> +	/* detach via BPF_LINK_DETACH - BPF program should no longer be executed */
> +	err = bpf_link_detach(link_fd);
> +	if (!ASSERT_OK(err, "link_detach"))
> +		goto cleanup;
> +
> +	/* make sure there are no stragglers */
> +	kern_sync_rcu();
> +
> +	run_cnt_before = skel->bss->run_cnt;
> +	burn_cpu();
> +	run_cnt_after = skel->bss->run_cnt;
> +
> +	ASSERT_EQ(run_cnt_before, run_cnt_after, "run_cnt_detached");
> +
> +cleanup:
> +	if (link_fd >= 0)
> +		close(link_fd);
> +	if (pfd >= 0)
> +		close(pfd);
> +	test_perf_link__destroy(skel);
> +}
> +
> +void test_perf_link(void)
> +{
> +	struct test_perf_link *skel = NULL;
> +	int pfd = -1, link_fd = -1, err;
> +	int run_cnt_before, run_cnt_after;
> +	struct bpf_link_info info;
> +	__u32 info_len = sizeof(info);
> +	__u64 timeout_time_ns;
> +
> +	if (perf_link_setup(&skel, &pfd))
>  		goto cleanup;
>  
>  	link_fd = bpf_link_create(bpf_program__fd(skel->progs.handler), pfd,
> -- 
> 2.53.0
> 
