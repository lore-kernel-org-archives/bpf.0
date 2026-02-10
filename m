Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C62EC0B4
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770737203; cv=none; b=ehw0VIaTiVdPyvyD1+l4D8WUq6dQx5tHhLycipL+6Bo/GlS5iNlU/qR5z/1vrACxOydfxvgAEILqTEGApVmjW/WAAb4DH/fAH3kjxY2RSGsiJL3DOju8iev5GIJIkJMi6g1/fGiZgaSa8RnSilkukAd38cPjgmoO04Gfv6utWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770737203; c=relaxed/simple;
	bh=x0spoTGQbotbIU8NDtg0SM4E8b0+uBFbTN5esIpLojM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy3YuViRyH3a1cqFG/+0tiCtg9/aoWSaZfvoFPR5py3VHfgYQyCMwdJV9tnGym2Dos1QzChg7Gff6GzB2+bR5AbyH05OQgkTczDpCpI/22FmHw6D0iYRlOa3eKJFQpV6IDspgujwOEhJAYrWz28xCMUs0EiohWfFlr6+CF4sFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h75KCqhm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h75KCqhm"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4376acce52eso658455f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 07:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770737200; x=1771342000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hEHTIohXIURSDF0f+f1UTjwj6j9j4gbdCoJ83XdZpg=;
        b=h75KCqhmEKJeh5QBoCufYcJ/J6IHsSJS46ZawDEgeDE0tO3sBN3JDIgy0fGxteMnOR
         VYFy9wlQWkebWpu8wNAWvD7SqTb63AQyvojwl22eqRKRTHpkCwvSzWX+WzeEns44ln0j
         bvIDzTR//DGTzaWrOr8bk5eBuiERDL0N22BHuMoVEVNjp7o4NRI7P5yUEKy2UmnkY4Ji
         bfqxKfLZUpidl76jHxSBhd7R4wYml1aW+nSw8d3dss7Mlf7peT0eshxMajzGFyLV0RiE
         5NmTfftDttQ7EI5mkUpPwZH6cByQvcXcEe6emFzsqU1jXNIRQN0x3kXYy9jdt4OdtJoe
         uwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770737200; x=1771342000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hEHTIohXIURSDF0f+f1UTjwj6j9j4gbdCoJ83XdZpg=;
        b=Z0PRcBCcZ5sGy1pHebGACdSxh3w+vwotFqsED4sgl1E5revGoH6F/usG6XfWZHVRyX
         PLAbGdcIww7+Q3nFo7r0dit51+cXfLGJhDiRM8oi/fngH6SKNyVUiNfB23p17sJt9mTW
         FAbDdHCEL5IAQCsVETQLHaVavw+FHuT2TEGEmaxT9Po0KPR44XRuJX3McsxBE4AW/LS5
         0zDPhMqVvEti8M9ivEzJ3ERvQpGHkcrMtbDsDupWCK1Sr/FlYgL73Vz7VjByrSpmUAUV
         SV3cy2+9L4pb9aSc6C+vTzK9odBeG1adMAVigHQztjR216BuBkYo2NkVupWV6mBtw35O
         AN+A==
X-Gm-Message-State: AOJu0Yw9KmljfNLVDaH2Wl20wXJS2kFZffEQJ7HZKaMbxR8ZdS1nKCTM
	9llPIvm3yyTUvVaqn11XZSM2FoHxTHs7ySjGwVqkbF4VTp4r825yfsRX
X-Gm-Gg: AZuq6aLodC7sGBRxTUPQRYL1A6zWSCbfy0CdVKmxYYvMWnH/IzuIWchh1I+z56BLmKc
	Pnb3pVLkTidJ5a3ezyiiy2Px9KeE0RTy5pBtuTATuHBX2FK+3ep8ok1y/M2E+ViAyS68oEFC79h
	PfL206LxMPfVMNw2DgtYN3b+qbJ1OxqeNDDfpGNdHpRFEn0S7oF0ilWSMJAidHa8ZiBtoBVqvJE
	23mw7TXyKnjpestv+SdgcxZmIhhBbWG+HhayDk/4+iU9WpSl1SxKKo4CHvQBunuiPoewtUWd0Iu
	GtjWf2t1v/5tVzcz2FS/msBdUJwWtm4ccQL2A5HHVPx9AHbBcJBt8GBCoRT7EV12ROPUZ7ZyhLb
	Rqfs8xQRB5mTMQaazxQcAcYJodx6onpVsYXrFakZfOsbPo6oX2W41RlRNExnQY0LGAntoWkwKVw
	lSMMv+zgS0BPrhXZgk
X-Received: by 2002:a05:6000:2482:b0:436:37e4:594f with SMTP id ffacd0b85a97d-43637e459fcmr17616704f8f.47.1770737200112;
        Tue, 10 Feb 2026 07:26:40 -0800 (PST)
Received: from krava ([2a00:102a:4031:6dfd:1b8f:d778:eeaa:181b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376806626fsm21884613f8f.37.2026.02.10.07.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 07:26:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Feb 2026 16:26:35 +0100
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	Jordan Rome <linux@jordanrome.com>,
	Qais Yousef <qyousef@layalina.io>, Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Split module_attach into
 subtests
Message-ID: <aYtOK8YerYM-801A@krava>
References: <cover.1770723724.git.vmalik@redhat.com>
 <699a95dfb6493cfd588524f388214db1250518f3.1770723724.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <699a95dfb6493cfd588524f388214db1250518f3.1770723724.git.vmalik@redhat.com>

On Tue, Feb 10, 2026 at 01:40:32PM +0100, Viktor Malik wrote:

SNIP

> -void test_module_attach(void)
> +static void test_module_attach_prog(const char *prog_name, int sz,
> +				    const char *attach_target, int ret)
>  {
> -	const int READ_SZ = 456;
> -	const int WRITE_SZ = 457;
> -	struct test_module_attach* skel;
> -	struct test_module_attach__bss *bss;
> -	struct bpf_link *link;
> +	struct test_module_attach *skel;
> +	struct bpf_program *prog;
>  	int err;
> -	int writable_val = 0;
>  
>  	skel = test_module_attach__open();
>  	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
>  		return;
>  
> -	err = bpf_program__set_attach_target(skel->progs.handle_fentry_manual,
> -					     0, "bpf_testmod_test_read");
> -	ASSERT_OK(err, "set_attach_target");
> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +	if (!ASSERT_OK_PTR(prog, "find program"))
> +		goto cleanup;
> +	bpf_program__set_autoload(prog, true);
>  
> -	err = bpf_program__set_attach_target(skel->progs.handle_fentry_explicit_manual,
> -					     0, "bpf_testmod:bpf_testmod_test_read");
> -	ASSERT_OK(err, "set_attach_target_explicit");
> +	if (attach_target) {
> +		err = bpf_program__set_attach_target(prog, 0, attach_target);
> +		ASSERT_OK(err, attach_target);
> +	}
> +
> +	err = test_module_attach__load(skel);
> +	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
> +		return;

goto cleanup?

> +
> +	err = test_module_attach__attach(skel);
> +	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))

should we use ASSERT in new code?

> +		goto cleanup;
> +
> +	if (sz) {
> +		/* trigger both read and write though each test uses only one */
> +		ASSERT_OK(trigger_module_test_read(sz), "trigger_read");
> +		ASSERT_OK(trigger_module_test_write(sz), "trigger_write");
> +
> +		ASSERT_EQ(skel->bss->sz, sz, prog_name);
> +	}
> +
> +	if (ret)
> +		ASSERT_EQ(skel->bss->retval, ret, "ret");
> +cleanup:
> +	test_module_attach__destroy(skel);
> +}
> +
> +static void test_module_attach_writable(void)
> +{
> +	struct test_module_attach__bss *bss;
> +	struct test_module_attach *skel;
> +	struct bpf_program *prog;
> +	int writable_val = 0;
> +	int err;
> +
> +	skel = test_module_attach__open();
> +	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
> +		return;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj,
> +						"handle_raw_tp_writable_bare");
> +	if (!ASSERT_OK_PTR(prog, "find program"))
> +		goto cleanup;
> +	bpf_program__set_autoload(prog, true);
>  
>  	err = test_module_attach__load(skel);
>  	if (CHECK(err, "skel_load", "failed to load skeleton\n"))

seems like there's missing goto cleanup in original code as well

> @@ -65,21 +121,6 @@ void test_module_attach(void)
>  	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
>  		goto cleanup;
>  
> -	/* trigger tracepoint */
> -	ASSERT_OK(trigger_module_test_read(READ_SZ), "trigger_read");
> -	ASSERT_OK(trigger_module_test_write(WRITE_SZ), "trigger_write");
> -
> -	ASSERT_EQ(bss->raw_tp_read_sz, READ_SZ, "raw_tp");
> -	ASSERT_EQ(bss->raw_tp_bare_write_sz, WRITE_SZ, "raw_tp_bare");
> -	ASSERT_EQ(bss->tp_btf_read_sz, READ_SZ, "tp_btf");
> -	ASSERT_EQ(bss->fentry_read_sz, READ_SZ, "fentry");
> -	ASSERT_EQ(bss->fentry_manual_read_sz, READ_SZ, "fentry_manual");
> -	ASSERT_EQ(bss->fentry_explicit_read_sz, READ_SZ, "fentry_explicit");
> -	ASSERT_EQ(bss->fentry_explicit_manual_read_sz, READ_SZ, "fentry_explicit_manual");
> -	ASSERT_EQ(bss->fexit_read_sz, READ_SZ, "fexit");
> -	ASSERT_EQ(bss->fexit_ret, -EIO, "fexit_tet");
> -	ASSERT_EQ(bss->fmod_ret_read_sz, READ_SZ, "fmod_ret");

SNIP

> +void test_module_attach(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(read_tests); i++) {
> +		if (!test__start_subtest(read_tests[i]))
> +			continue;
> +		test_module_attach_prog(read_tests[i], READ_SZ, NULL, 0);
> +	}
> +	if (test__start_subtest("handle_raw_tp_bare")) {
> +		test_module_attach_prog("handle_raw_tp_bare", WRITE_SZ, NULL,
> +					0);

nit, could be on the previous line?

jirka
