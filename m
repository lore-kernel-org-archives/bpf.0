Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C7132A3FF
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770755887; cv=none; b=Z63dSkkiuefwo15uGeLBLwNTGkLILXFfwcKMHREfGhAYrZFINCuWNWxyr27aLV6k7P0WtCm1r65PfVBLnQw27nZlsyOrhTK6GpIVml7augu9jmXprR22iFqN4Dsk0fheeAH5t79lg887rWb5Q8VwYWXoVrVkBTcfGkH+Mf2czAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770755887; c=relaxed/simple;
	bh=DIsVUx+SC6iVtPqkoAJgYoHs3D9Drtphf+MSTLL8fg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+SZwPzu4+NMd8LsYPeyxTjsx9cTsiaW9+4UsigMJR4QfWVKYv9MSp0o57tZkIkgxW0EzuLUy1HQrXnWKDEfPSP7OYWUdJNLjV9iNshlOQmc8WBt5ZbNx/WyEApZckvXec+hDfapWm+yJvhojy0ri13a7nT0SaHndhR1efWoGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5Y9uCGL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=py4Ukknw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5Y9uCGL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="py4Ukknw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770755884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFpPo8xb4wUDthQMPv+iopkycKrdBqVBHuyMOSHMtas=;
	b=G5Y9uCGL22zSBJODcv0d23i6apLCmvNKK3gPqBbvErCsj8sxgODCQq+ThCvkBKjzMw7JE3
	XynKTGdH4FCwrhbBIWpQkBe63g1RSgY/N0LHRG862S2gkXCoLvQtMrqZoGGPqRDgHh5YH/
	Jptp8q/MmeQKJX8z6M4gMF4sSxJiRWs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-TPYIlHeKOPiPmg3EiXDnPQ-1; Tue, 10 Feb 2026 15:38:03 -0500
X-MC-Unique: TPYIlHeKOPiPmg3EiXDnPQ-1
X-Mimecast-MFC-AGG-ID: TPYIlHeKOPiPmg3EiXDnPQ_1770755882
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4830e7c6131so39702705e9.2
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 12:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770755882; x=1771360682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFpPo8xb4wUDthQMPv+iopkycKrdBqVBHuyMOSHMtas=;
        b=py4Ukknw1hG6C28sj0UV9rv4ScgKpc/MNyvkgt3N5laA8pMUlnDlk5YrZCND26T2yd
         ljLgTuIT/o4H6AzQdhLQyzFbPVO9QnjRsCmJ7gDKrTEFD4xuXOdZjBbj/YV0t1bAeRuQ
         clWHhtpsKxTzlLoCmNb6quAarEdCJ9ockuEBWqyoDbPaUrZgq9wdU8nvAjUR0S6QTfi8
         qjQQpfb5ock9Zts3qdeS9zPZAWhrlzl2C3hDaePSx7t/NYJP0BXQXPkVkvVAH2JaEN6H
         B5XpWmgCEs2KEwi/Yb7tMvYuSssL2ettD8CXf8x5ZQCqmGFEAQ7hih5gVRZ1+KtBeW3D
         L2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770755882; x=1771360682;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFpPo8xb4wUDthQMPv+iopkycKrdBqVBHuyMOSHMtas=;
        b=LCsamQtFAV4RtyK8ZHjHL9/2cJgpd41U8LX9cbJbyM+mEyyrvf4rXYm1PFRpyXBYUR
         MEDhLF85VEzk2FXxZv8ZoxLm1SLR51S97d2BOlo0lDbo1Bjpii4v04VgWNtgVMcQgE4f
         hmJnlsFO0n2C7MTtiKFa9vBqpaj67s50vqOs96oStXlhYegpML2cik5BIKyXSQlcA9v0
         k9uHgrQTDyMGSYP2Bc1+T3sxwuq8VGXS8tIV8MBz5VM1OsxsfxoKirarxgna4Tx3Y9Mu
         0vCRNF9WtFHvfqsmyIC1PYpawAuVGwqEVqKCC8IlcZg+0HCQlQNCXaHZwFGnID3EJIUi
         AfZw==
X-Gm-Message-State: AOJu0YzS4geDklxtpRBqhrZN4q39h0npfuPfzN6oNMYaqVw6ma/F+8cG
	GVEeY44dBBolWZNyqMG5qlmUsPunP6apaJxV+jv8n8ZfSDc59q+4uv7PVg+YNwaBH6nsrVc1nyS
	cdDvoaHJtyc1TeI0S7+LItU2ITT4NRlohgpKZePQAJJdPIzHhcqDW
X-Gm-Gg: AZuq6aKKPVYrfcCqpO8LHEqURRWckJXpMRwHHzBQ2/DR9U3DrGieEc4IjkW+Wp6Vfn2
	tOYrajFLSSrpGrYwt25ofKqQs7qJNd4BirZm3XRrIsPmkctmEhBApDb43feDDvJpr7NLNPToj45
	cLS14m/NWhk56w/eL9b41DZWDkqmAZpCPoIz48Y0nGIlY6Jx1xLNGqJ840X24/kX+ehEQvqxspK
	9cVrQhCWvqoInoXZML4gtBG8cmJeTevAXBd4aE0MTcpXBi1xuouKL9PhTa5Bg3x8AN/6o06ObWz
	h0kxAeFe5vCq31urH8i3DXSBy1zIF+LiTg1AdRCUbiauZea9GpurRqatOiR4FIjVYBXf9Bpy262
	IYx8uxVWoXWUX2LM6XXUmUKCN6zYpWoeYYKPwNd742mvop55Qfwi3YxIq
X-Received: by 2002:a05:600c:8b31:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-4835b9523dfmr3870215e9.17.1770755882359;
        Tue, 10 Feb 2026 12:38:02 -0800 (PST)
X-Received: by 2002:a05:600c:8b31:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-4835b9523dfmr3869855e9.17.1770755881906;
        Tue, 10 Feb 2026 12:38:01 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e1a8esm75180825e9.5.2026.02.10.12.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 12:38:01 -0800 (PST)
Message-ID: <487b0d57-bb41-4f6e-9f53-e253f161ac9e@redhat.com>
Date: Tue, 10 Feb 2026 21:37:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Split module_attach into
 subtests
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Shuah Khan <shuah@kernel.org>, Jordan Rome <linux@jordanrome.com>,
 Qais Yousef <qyousef@layalina.io>, Hou Tao <houtao1@huawei.com>
References: <cover.1770723724.git.vmalik@redhat.com>
 <699a95dfb6493cfd588524f388214db1250518f3.1770723724.git.vmalik@redhat.com>
 <aYtOK8YerYM-801A@krava>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <aYtOK8YerYM-801A@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/26 16:26, Jiri Olsa wrote:
> On Tue, Feb 10, 2026 at 01:40:32PM +0100, Viktor Malik wrote:
> 
> SNIP
> 
>> -void test_module_attach(void)
>> +static void test_module_attach_prog(const char *prog_name, int sz,
>> +				    const char *attach_target, int ret)
>>  {
>> -	const int READ_SZ = 456;
>> -	const int WRITE_SZ = 457;
>> -	struct test_module_attach* skel;
>> -	struct test_module_attach__bss *bss;
>> -	struct bpf_link *link;
>> +	struct test_module_attach *skel;
>> +	struct bpf_program *prog;
>>  	int err;
>> -	int writable_val = 0;
>>  
>>  	skel = test_module_attach__open();
>>  	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
>>  		return;
>>  
>> -	err = bpf_program__set_attach_target(skel->progs.handle_fentry_manual,
>> -					     0, "bpf_testmod_test_read");
>> -	ASSERT_OK(err, "set_attach_target");
>> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
>> +	if (!ASSERT_OK_PTR(prog, "find program"))
>> +		goto cleanup;
>> +	bpf_program__set_autoload(prog, true);
>>  
>> -	err = bpf_program__set_attach_target(skel->progs.handle_fentry_explicit_manual,
>> -					     0, "bpf_testmod:bpf_testmod_test_read");
>> -	ASSERT_OK(err, "set_attach_target_explicit");
>> +	if (attach_target) {
>> +		err = bpf_program__set_attach_target(prog, 0, attach_target);
>> +		ASSERT_OK(err, attach_target);
>> +	}
>> +
>> +	err = test_module_attach__load(skel);
>> +	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
>> +		return;
> 
> goto cleanup?

Yup, also found by the AI bot.

> 
>> +
>> +	err = test_module_attach__attach(skel);
>> +	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
> 
> should we use ASSERT in new code?

Will do.

> 
>> +		goto cleanup;
>> +
>> +	if (sz) {
>> +		/* trigger both read and write though each test uses only one */
>> +		ASSERT_OK(trigger_module_test_read(sz), "trigger_read");
>> +		ASSERT_OK(trigger_module_test_write(sz), "trigger_write");
>> +
>> +		ASSERT_EQ(skel->bss->sz, sz, prog_name);
>> +	}
>> +
>> +	if (ret)
>> +		ASSERT_EQ(skel->bss->retval, ret, "ret");
>> +cleanup:
>> +	test_module_attach__destroy(skel);
>> +}
>> +
>> +static void test_module_attach_writable(void)
>> +{
>> +	struct test_module_attach__bss *bss;
>> +	struct test_module_attach *skel;
>> +	struct bpf_program *prog;
>> +	int writable_val = 0;
>> +	int err;
>> +
>> +	skel = test_module_attach__open();
>> +	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
>> +		return;
>> +
>> +	prog = bpf_object__find_program_by_name(skel->obj,
>> +						"handle_raw_tp_writable_bare");
>> +	if (!ASSERT_OK_PTR(prog, "find program"))
>> +		goto cleanup;
>> +	bpf_program__set_autoload(prog, true);
>>  
>>  	err = test_module_attach__load(skel);
>>  	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
> 
> seems like there's missing goto cleanup in original code as well

Yes, I've already changed that in one of the later versions.

> 
>> @@ -65,21 +121,6 @@ void test_module_attach(void)
>>  	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
>>  		goto cleanup;
>>  
>> -	/* trigger tracepoint */
>> -	ASSERT_OK(trigger_module_test_read(READ_SZ), "trigger_read");
>> -	ASSERT_OK(trigger_module_test_write(WRITE_SZ), "trigger_write");
>> -
>> -	ASSERT_EQ(bss->raw_tp_read_sz, READ_SZ, "raw_tp");
>> -	ASSERT_EQ(bss->raw_tp_bare_write_sz, WRITE_SZ, "raw_tp_bare");
>> -	ASSERT_EQ(bss->tp_btf_read_sz, READ_SZ, "tp_btf");
>> -	ASSERT_EQ(bss->fentry_read_sz, READ_SZ, "fentry");
>> -	ASSERT_EQ(bss->fentry_manual_read_sz, READ_SZ, "fentry_manual");
>> -	ASSERT_EQ(bss->fentry_explicit_read_sz, READ_SZ, "fentry_explicit");
>> -	ASSERT_EQ(bss->fentry_explicit_manual_read_sz, READ_SZ, "fentry_explicit_manual");
>> -	ASSERT_EQ(bss->fexit_read_sz, READ_SZ, "fexit");
>> -	ASSERT_EQ(bss->fexit_ret, -EIO, "fexit_tet");
>> -	ASSERT_EQ(bss->fmod_ret_read_sz, READ_SZ, "fmod_ret");
> 
> SNIP
> 
>> +void test_module_attach(void)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(read_tests); i++) {
>> +		if (!test__start_subtest(read_tests[i]))
>> +			continue;
>> +		test_module_attach_prog(read_tests[i], READ_SZ, NULL, 0);
>> +	}
>> +	if (test__start_subtest("handle_raw_tp_bare")) {
>> +		test_module_attach_prog("handle_raw_tp_bare", WRITE_SZ, NULL,
>> +					0);
> 
> nit, could be on the previous line?

Yeah, looks much nicer, will change.

> 
> jirka
> 

Thanks.
Viktor

