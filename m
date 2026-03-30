Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A43B8D59
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865306; cv=none; b=UmxLQRXxZ5xXev325hu+vC/Jix15LdI9U7peUEbVQPUQGTg8UnVyXVc+pLcztNMzY0esmA1J3Z4agaCZrCO19ziFHTWlZzTFffFVQPwfRCYwclovQSD03DLhjAv5AvntQJyc3KIFlGmmZyejjd8IzxPwATDU56xQcJOOwTCwZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865306; c=relaxed/simple;
	bh=8wyx6aOB9/rpSUdWACqkfgV0FBEbAQZSWzjWclq3iEo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8nfsHEg1sZikWmUa2fsyy/lqRdhnNnBggArma+b+4+tAs4sOC9X9cjcvyhIrQ5dkPJOBvNUazlwe7ZtWo6FzmgofDeSKWZf9N1ODaYjroxNHVdKIfiSvehHx9CdCQYgDqivfMgduGFYLzKXu+9ACITTBIrs3UUcHYfcdUb0V2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okjGd268; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okjGd268"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso42254455e9.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774865303; x=1775470103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stE/M7chhz4+zdgyifRHBNEwU7WLtwKy5+xfo7bOcXE=;
        b=okjGd268/xpK3Vlrh/fAIaTaCc4v6f14Q3aA30zNZf1o+bjN1x5jI4Q7TG5lI+m/yt
         O7sNVW1vGlIbfKtYg4Eer1xTkMac11FzeXu7zqhwuTeCoS6A8coVhc2vduyrqVkmaL+Y
         UFk0uhqle+Moireiek+9J7Cs6qecnXTyRCaFiLkcg0UZgb36A+E2uGuxmQvAA3/evqN/
         zIdHpTWHxqMkVzeybfQGU0rfLmuijh34lVY6IpZDHsiWqrmFkDJ/xmy/nYb9S1Jr2BDw
         HhP2bQDRdVnTtRSzmr0ddUvlQloIHnZx+vd4Ses+hZRCESUhZmlK/QzJ1/pDSZVRd81a
         OoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774865303; x=1775470103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stE/M7chhz4+zdgyifRHBNEwU7WLtwKy5+xfo7bOcXE=;
        b=MSjvbdYPRxRo/bBaxbXbInaQdZ8hZtD7AknqKq6qJiJXc1sDtqX1hoK83Zjl8uAL8q
         0fTk5vmCxc/8mQON6GbVcjJmEtlNteAPoxXb2bCqkpcZCVioDaCuIhn0r3wOAH5JG7Iz
         Q1XU16Thn/tj14J7XajXbDZ00D4YTgArUQuBQOs5rBmOwJSXQ73zvjlkV3BpRMW7vjLQ
         3l3eianreZCBkpZIqbETyGGOckXsSy6f8SyXt7AYWxDm8Ks5c45EVR2FGJexS8qpmlyh
         rhw512B38+aHp2j92KdtDopwDglGfHo9rSCjbg21t53eOwk0ln+RKLU+VYvV11CtuRu5
         Pjsw==
X-Gm-Message-State: AOJu0YxiN9/VbmlTRwHmRKDfI4HKCJ5Zy4Q6ub+Fi4Ko6u9NohTMbU0k
	LihETOXdFbn/eSYSnwLbszqHNVxjKiJg/37wdBAAJPdSjno9Bd3Xghj0
X-Gm-Gg: ATEYQzw2vVoBSDslbywZL6HfJ0gE4idOi64nd7jstc/+14HxzoafwKVk5OZ/C4qBlaf
	T4OUoWsGJnVgsbxTXRvPYC2Og9tRuxDJI87YYhc79SYqxMRo8mTnghsVKnxk7mU2mq2gDxWtUKI
	20mEsJfAdkWxM8PCP37Zn9me55xbc6bl80z0S4O0kS7X624x8/EWxRExqZeE6yoNwJkMb5Gc8ve
	+fYBtY8683yZVwe7Pl5gJcwxQcTpXaRccwhbAhI4DuIxPOCf9cbNPm6mIlZXPzr/JmFZ4TOVgGn
	y0QePEnICVbxzowQTRV4XJs1MVNNeVWmiXx5UF/4ocBAFWBmOf2XvT4QqbRSukvO1D1aPof1vSE
	Y9nGxOcbPaw9aHsIFBAEALYBbAugaAO4pg3Ttag00MoYS3+kKijMVMxJ/kag8BB7N9CRhtw/vqP
	FKdJKQF3bbV8L6F7m5dFb1lBh/inrVgdPuqq8=
X-Received: by 2002:a05:600c:a016:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48727ef153cmr186484445e9.26.1774865302883;
        Mon, 30 Mar 2026 03:08:22 -0700 (PDT)
Received: from krava (37-188-160-213.red.o2.cz. [37.188.160.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270ea4bdsm132473095e9.6.2026.03.30.03.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:08:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Mar 2026 12:08:20 +0200
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add test for
 address-based single kprobe attach
Message-ID: <acpLlFg_UUmzp80f@krava>
References: <20260329124429.689912-1-hoyeon.lee@suse.com>
 <20260329124429.689912-3-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329124429.689912-3-hoyeon.lee@suse.com>

On Sun, Mar 29, 2026 at 09:43:39PM +0900, Hoyeon Lee wrote:
> Currently, attach_probe covers manual single-kprobe attaches by
> func_name, but not by raw address. This commit adds address-based
> single-kprobe attach subtests for the two underlying attach paths,
> legacy tracefs/debugfs and PMU-based non-legacy. The new subtests
> resolve SYS_NANOSLEEP_KPROBE_NAME through kallsyms, pass the result
> through bpf_kprobe_opts.addr, and verify that kprobe and kretprobe are
> still triggered.
> 
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index 9e77e5da7097..64f2ed75779d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -123,6 +123,51 @@ static void test_attach_probe_manual(enum probe_attach_mode attach_mode)
>  	test_attach_probe_manual__destroy(skel);
>  }
>  
> +/* manual attach address-based kprobe/kretprobe testings */
> +static void test_attach_kprobe_by_addr(enum probe_attach_mode attach_mode)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> +	struct bpf_link *kprobe_link, *kretprobe_link;
> +	struct test_attach_probe_manual *skel;
> +	unsigned long func_addr;
> +
> +	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> +		return;
> +
> +	func_addr = ksym_get_addr(SYS_NANOSLEEP_KPROBE_NAME);
> +	if (!ASSERT_NEQ(func_addr, 0UL, "func_addr"))
> +		return;
> +
> +	skel = test_attach_probe_manual__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
> +		return;
> +
> +	kprobe_opts.attach_mode = attach_mode;
> +	kprobe_opts.retprobe = false;
> +	kprobe_opts.addr = func_addr;
> +	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
> +						      NULL, &kprobe_opts);
> +	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_by_addr"))
> +		goto cleanup;
> +	skel->links.handle_kprobe = kprobe_link;

we usually use skel->links.handle_kprobe directly, no need to use
kprobe_link or kretprobe_link

> +
> +	kprobe_opts.retprobe = true;
> +	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
> +							 NULL, &kprobe_opts);
> +	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_by_addr"))
> +		goto cleanup;
> +	skel->links.handle_kretprobe = kretprobe_link;
> +
> +	/* trigger & validate kprobe && kretprobe */
> +	usleep(1);
> +
> +	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
> +	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
> +
> +cleanup:
> +	test_attach_probe_manual__destroy(skel);
> +}
> +
>  /* attach uprobe/uretprobe long event name testings */
>  static void test_attach_uprobe_long_event_name(void)
>  {
> @@ -416,6 +461,10 @@ void test_attach_probe(void)
>  		test_attach_probe_manual(PROBE_ATTACH_MODE_PERF);
>  	if (test__start_subtest("manual-link"))
>  		test_attach_probe_manual(PROBE_ATTACH_MODE_LINK);
> +	if (test__start_subtest("kprobe-legacy-by-addr"))
> +		test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_LEGACY);
> +	if (test__start_subtest("kprobe-perf-by-addr"))
> +		test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_PERF);

should we test PROBE_ATTACH_MODE_LINK mode as well?

jirka

>  
>  	if (test__start_subtest("auto"))
>  		test_attach_probe_auto(skel);
> -- 
> 2.52.0
> 
