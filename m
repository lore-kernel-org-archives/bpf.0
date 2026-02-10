Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A862F9D98
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770756355; cv=none; b=StlJbfYH9798Zy9uzPkqDoxWHNKLA1NjvOBiJNFuFdGj9xKiotkfOo1ptSPF5N2rr/1EiySmaiOmJjiSJuJxoF7FCcTq8LWiBcLkHwwPcSk4HPP5wLDDfhKxn3hchS8dMNlJvPNG36cnO9dP9Q/OI1kf2tn+t+fmNBgviKYQIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770756355; c=relaxed/simple;
	bh=kq7T34EES0SMtw+RTUEP3rEIOMrnEeBJqIvD76fSZ8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv7C8epTFvT5Vmn7QJF3bpPRtLQrACzDoZQ1CzFmEoKu6OWgvUiHiJrI4av04ryR7VtQEGI0dCpqRKZzQHMvfMGzeIX3/p98pFQzcIx5on4QGZwmub8+ORPEEI3oH8Bu99TLchJNep5ruVGqZLMLWkRRrRx8ogu4ccrwSCZiZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoXd/H2P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNiUqPS6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoXd/H2P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNiUqPS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770756353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDQ8CmzSLx11N97f684NkIB404I2CWVwziInX9PSdFU=;
	b=XoXd/H2Pg/sIAYhhLQq1m/0BL31YqYy2C/DC6rzGNOLueF+53+BfNCvqwBKel47FPpBA19
	JLcfH6JMq3NOT6WShX0YS4PnEVo13/9yrv0j+lDij9cq4NeFqOrzJq2YyHSlGzh0WjMCzh
	Kq1styZ5RuYAElszMAY9Rc7AqSKb+K0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-rojApyFINa-2rDiBBf0gFQ-1; Tue, 10 Feb 2026 15:45:49 -0500
X-MC-Unique: rojApyFINa-2rDiBBf0gFQ-1
X-Mimecast-MFC-AGG-ID: rojApyFINa-2rDiBBf0gFQ_1770756348
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-437700715ddso1811181f8f.2
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 12:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770756348; x=1771361148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDQ8CmzSLx11N97f684NkIB404I2CWVwziInX9PSdFU=;
        b=CNiUqPS6I7nlV+D/CRw60i4GvBKQstHJ7D24t1ym6jDLT30SqWezZ1riyIOlHpy9bg
         hV8SXdp6MEa/3sVlyU8Fxm+qOPO8HiG9EgTKLvJzSjncWllgiBaFLe8jYsMHX3y/udWF
         X/EPKnf5SgxsBFOZwyR+GhCEeCUFWexe+BaTttHZrmuIgTpTmU7Q2nq0LEASKc7Wos11
         tZXViyN+0HXZLrnp47hxWje5YFa83rIzAj1NKvGBz0TpG10QlcE+na9PvJMx3FbAnCQC
         5r4HvC78QB+AHGihXe6pvpwwhOGCKNWEA7O8JD54EssD/SidRnQbmdtJX2O7rlGsn9yC
         kPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770756348; x=1771361148;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDQ8CmzSLx11N97f684NkIB404I2CWVwziInX9PSdFU=;
        b=GWlIjz0XkLspW4pjErJEShV9KIyIlC+u+OIh7AJD2ZAeGIqc7oM/cSESVIWzkwZMjV
         G2LF3sz51sEvcMudAa8gKZ4a5TRr3OgH9usX3lG0ih+Y38J7ELORPq81aB83xcmBBchP
         3V5wLl2iGERO2JTRso2rsGRrFd6A/YdL5KacWOIDwcNxsQ5DrC1ewD1XEaV+gB8FoBOk
         NNraWgdjWwFIzMsqVEWfPGvq14zgvwLmp6kSvfCjEnK9JvMy9rYjcRidwzd5yfkcojz/
         +bNEMEfGBaJ9ZKV+Bzghuv352T6x9DuJ9ZVfdF31Eek2QV6gVIku8aZdUrAb0oBOmXYj
         f2gg==
X-Forwarded-Encrypted: i=1; AJvYcCWFIV8yv8nlpZB5QWhIUp6waeMOoOe9qBjNZABmdq5Tx8wzdTje0vnTxhlhll2Z8cO4F6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoqB1ar9PiDhLm28+KpRbwwr1dVBt4LIp0VC6OLGcUC+LtQTOg
	/ODast7DTcbu+b0BHaCREFPj4bHzE0tvgyPv5awnljYfCs6jY58Kyp94fBcsltGmA1rjhwGnUmm
	szxEZZ4BguQaRS1BX4Vn3ODmegurEIdbTfGU/VCR/VrMFx8xj6tDf
X-Gm-Gg: AZuq6aLYNUVv5xyDbJ3Q6thpniTzmpd2VCTlON6rKIgyRKNOBgGkfVjELYdQ0CTcEbq
	9ANgY6uUSWG5hIXEctT0sLvjSXa5HXofPUmiDBppQDFcflUf3Sa+n4cejs7L6D0WirRfO1Pihxh
	iEKs11SCgaTJMUyejdTzYy9Gee72/KdQt1egohFydm1e+GFnsrggnopm9XfQS8i6GkWoZWL0COT
	UyKQ1z3NiKTiDDITd6El24D1kKBlDvVLSXe3VXioeDfQ2ZJvsP79mZquS/OTLspMySuSt43kh3W
	GboQSuNg4VA0ijMLcyddncAOJeGvkIhRig4uX7jbrnY3DsSfhs/ZSAjW/X1SKBQ3LlgnhAfrpxg
	TknApzvLetamGR3Jp1z5Y87YSAytszrEO9nLBsCLTGZoOQy628JpRXX8H
X-Received: by 2002:a05:6000:2406:b0:435:693e:c03e with SMTP id ffacd0b85a97d-4377a521087mr5911785f8f.19.1770756348299;
        Tue, 10 Feb 2026 12:45:48 -0800 (PST)
X-Received: by 2002:a05:6000:2406:b0:435:693e:c03e with SMTP id ffacd0b85a97d-4377a521087mr5911750f8f.19.1770756347756;
        Tue, 10 Feb 2026 12:45:47 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2d43sm35717466f8f.8.2026.02.10.12.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 12:45:47 -0800 (PST)
Message-ID: <e7f2bfde-1ad3-4956-a102-f0bb488780e2@redhat.com>
Date: Tue, 10 Feb 2026 21:45:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Split module_attach into
 subtests
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jordan Rome <linux@jordanrome.com>, Qais Yousef <qyousef@layalina.io>,
 Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org
References: <cover.1770732776.git.vmalik@redhat.com>
 <699a95dfb6493cfd588524f388214db1250518f3.1770732776.git.vmalik@redhat.com>
 <917d381a-c600-42ad-9f75-f5e49456f5f3@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <917d381a-c600-42ad-9f75-f5e49456f5f3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/26 17:01, Mykyta Yatsenko wrote:
> On 2/10/26 14:14, Viktor Malik wrote:
>> The test verifies attachment to various hooks in a kernel module,
>> however, everything is flattened into a single test. When running the
>> test on a kernel which doesn't support some of the hooks, it is
>> impossible to skip them selectively.
>>
>> Isolate each BPF program into a separate subtest. This is done by
>> disabling auto-loading of programs and loading and testing each program
>> separately.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>   .../selftests/bpf/prog_tests/module_attach.c  | 168 +++++++++++++-----
>>   .../selftests/bpf/progs/test_module_attach.c  |  63 +++----
>>   2 files changed, 149 insertions(+), 82 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
>> index 70fa7ae93173..8668c26c202f 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
>> @@ -6,6 +6,23 @@
>>   #include "test_module_attach.skel.h"
>>   #include "testing_helpers.h"
>>   
>> +static const char * const read_tests[] = {
>> +	"handle_raw_tp",
>> +	"handle_tp_btf",
>> +	"handle_fentry",
>> +	"handle_fentry_explicit",
>> +	"handle_fmod_ret",
>> +};
>> +
>> +static const char * const detach_tests[] = {
>> +	"handle_fentry",
>> +	"handle_fexit",
>> +	"kprobe_multi",
>> +};
>> +
>> +static const int READ_SZ = 456;
>> +static const int WRITE_SZ = 457;
>> +
>>   static int duration;
>>   
>>   static int trigger_module_test_writable(int *val)
>> @@ -33,27 +50,66 @@ static int trigger_module_test_writable(int *val)
>>   	return 0;
>>   }
>>   
>> -void test_module_attach(void)
>> +static void test_module_attach_prog(const char *prog_name, int sz,
>> +				    const char *attach_target, int ret)
>>   {
>> -	const int READ_SZ = 456;
>> -	const int WRITE_SZ = 457;
>> -	struct test_module_attach* skel;
>> -	struct test_module_attach__bss *bss;
>> -	struct bpf_link *link;
>> +	struct test_module_attach *skel;
>> +	struct bpf_program *prog;
>>   	int err;
>> -	int writable_val = 0;
>>   
>>   	skel = test_module_attach__open();
>>   	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
>>   		return;
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
> Does it makes sense to goto cleanup if err here?

Yeah, good catch, it doesn't make sense to continue with loading.

>> +	}
>> +
>> +	err = test_module_attach__load(skel);
>> +	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
> Is there any reason to use CHECK instead of ASSERT_OK(more common)?

No, I just used what was in the old code and didn't realize that CHECK
is now legacy. I'll replace it by ASSERT everywhere.

>> +		return;
>> +
>> +	err = test_module_attach__attach(skel);
>> +	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
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
> can we use skel->progs.handle_raw_tp_writable_bare instead of 
> find_program_by_name?

Of course we can, good catch!

Thanks!
Viktor

>> +	if (!ASSERT_OK_PTR(prog, "find program"))
>> +		goto cleanup;
>> +	bpf_program__set_autoload(prog, true);
>>   
>>   	err = test_module_attach__load(skel);
>>   	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
>> @@ -65,21 +121,6 @@ void test_module_attach(void)
>>   	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
>>   		goto cleanup;
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
>> -
>>   	bss->raw_tp_writable_bare_early_ret = true;
>>   	bss->raw_tp_writable_bare_out_val = 0xf1f2f3f4;
>>   	ASSERT_OK(trigger_module_test_writable(&writable_val),
>> @@ -87,31 +128,72 @@ void test_module_attach(void)
>>   	ASSERT_EQ(bss->raw_tp_writable_bare_in_val, 1024, "writable_test_in");
>>   	ASSERT_EQ(bss->raw_tp_writable_bare_out_val, writable_val,
>>   		  "writable_test_out");
>> +cleanup:
>> +	test_module_attach__destroy(skel);
>> +}
>>   
>> -	test_module_attach__detach(skel);
>> -
>> -	/* attach fentry/fexit and make sure it gets module reference */
>> -	link = bpf_program__attach(skel->progs.handle_fentry);
>> -	if (!ASSERT_OK_PTR(link, "attach_fentry"))
>> -		goto cleanup;
>> +static void test_module_attach_detach(const char *prog_name)
>> +{
>> +	struct test_module_attach *skel;
>> +	struct bpf_program *prog;
>> +	struct bpf_link *link;
>> +	int err;
>>   
>> -	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
>> -	bpf_link__destroy(link);
>> +	skel = test_module_attach__open();
>> +	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
>> +		return;
>>   
>> -	link = bpf_program__attach(skel->progs.handle_fexit);
>> -	if (!ASSERT_OK_PTR(link, "attach_fexit"))
>> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
>> +	if (!ASSERT_OK_PTR(prog, "find program"))
>>   		goto cleanup;
>> +	bpf_program__set_autoload(prog, true);
>>   
>> -	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
>> -	bpf_link__destroy(link);
>> +	err = test_module_attach__load(skel);
>> +	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
>> +		goto cleanup;
>>   
>> -	link = bpf_program__attach(skel->progs.kprobe_multi);
>> -	if (!ASSERT_OK_PTR(link, "attach_kprobe_multi"))
>> +	/* attach and make sure it gets module reference */
>> +	link = bpf_program__attach(prog);
>> +	if (!ASSERT_OK_PTR(link, "attach"))
>>   		goto cleanup;
>>   
>>   	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
>>   	bpf_link__destroy(link);
>> -
>>   cleanup:
>>   	test_module_attach__destroy(skel);
>>   }
>> +
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
>> +	}
>> +	if (test__start_subtest("handle_raw_tp_writable_bare"))
>> +		test_module_attach_writable();
>> +	if (test__start_subtest("handle_fentry_manual")) {
>> +		test_module_attach_prog("handle_fentry_manual", READ_SZ,
>> +					"bpf_testmod_test_read", 0);
>> +	}
>> +	if (test__start_subtest("handle_fentry_explicit_manual")) {
>> +		test_module_attach_prog("handle_fentry_explicit_manual",
>> +					READ_SZ,
>> +					"bpf_testmod:bpf_testmod_test_read", 0);
>> +	}
>> +	if (test__start_subtest("handle_fexit"))
>> +		test_module_attach_prog("handle_fexit", READ_SZ, NULL, -EIO);
>> +	if (test__start_subtest("handle_fexit_ret"))
>> +		test_module_attach_prog("handle_fexit_ret", 0, NULL, 0);
>> +	for (i = 0; i < ARRAY_SIZE(detach_tests); i++) {
>> +		if (!test__start_subtest(detach_tests[i]))
>> +			continue;
>> +		test_module_attach_detach(detach_tests[i]);
>> +	}
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
>> index 03d7f89787a1..5609e388fb58 100644
>> --- a/tools/testing/selftests/bpf/progs/test_module_attach.c
>> +++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
>> @@ -7,23 +7,21 @@
>>   #include <bpf/bpf_core_read.h>
>>   #include "../test_kmods/bpf_testmod.h"
>>   
>> -__u32 raw_tp_read_sz = 0;
>> +__u32 sz = 0;
>>   
>> -SEC("raw_tp/bpf_testmod_test_read")
>> +SEC("?raw_tp/bpf_testmod_test_read")
>>   int BPF_PROG(handle_raw_tp,
>>   	     struct task_struct *task, struct bpf_testmod_test_read_ctx *read_ctx)
>>   {
>> -	raw_tp_read_sz = BPF_CORE_READ(read_ctx, len);
>> +	sz = BPF_CORE_READ(read_ctx, len);
>>   	return 0;
>>   }
>>   
>> -__u32 raw_tp_bare_write_sz = 0;
>> -
>> -SEC("raw_tp/bpf_testmod_test_write_bare_tp")
>> +SEC("?raw_tp/bpf_testmod_test_write_bare_tp")
>>   int BPF_PROG(handle_raw_tp_bare,
>>   	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
>>   {
>> -	raw_tp_bare_write_sz = BPF_CORE_READ(write_ctx, len);
>> +	sz = BPF_CORE_READ(write_ctx, len);
>>   	return 0;
>>   }
>>   
>> @@ -31,7 +29,7 @@ int raw_tp_writable_bare_in_val = 0;
>>   int raw_tp_writable_bare_early_ret = 0;
>>   int raw_tp_writable_bare_out_val = 0;
>>   
>> -SEC("raw_tp.w/bpf_testmod_test_writable_bare_tp")
>> +SEC("?raw_tp.w/bpf_testmod_test_writable_bare_tp")
>>   int BPF_PROG(handle_raw_tp_writable_bare,
>>   	     struct bpf_testmod_test_writable_ctx *writable)
>>   {
>> @@ -41,76 +39,65 @@ int BPF_PROG(handle_raw_tp_writable_bare,
>>   	return 0;
>>   }
>>   
>> -__u32 tp_btf_read_sz = 0;
>> -
>> -SEC("tp_btf/bpf_testmod_test_read")
>> +SEC("?tp_btf/bpf_testmod_test_read")
>>   int BPF_PROG(handle_tp_btf,
>>   	     struct task_struct *task, struct bpf_testmod_test_read_ctx *read_ctx)
>>   {
>> -	tp_btf_read_sz = read_ctx->len;
>> +	sz = read_ctx->len;
>>   	return 0;
>>   }
>>   
>> -__u32 fentry_read_sz = 0;
>> -
>> -SEC("fentry/bpf_testmod_test_read")
>> +SEC("?fentry/bpf_testmod_test_read")
>>   int BPF_PROG(handle_fentry,
>>   	     struct file *file, struct kobject *kobj,
>>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
>>   {
>> -	fentry_read_sz = len;
>> +	sz = len;
>>   	return 0;
>>   }
>>   
>> -__u32 fentry_manual_read_sz = 0;
>> -
>> -SEC("fentry")
>> +SEC("?fentry")
>>   int BPF_PROG(handle_fentry_manual,
>>   	     struct file *file, struct kobject *kobj,
>>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
>>   {
>> -	fentry_manual_read_sz = len;
>> +	sz = len;
>>   	return 0;
>>   }
>>   
>> -__u32 fentry_explicit_read_sz = 0;
>> -
>> -SEC("fentry/bpf_testmod:bpf_testmod_test_read")
>> +SEC("?fentry/bpf_testmod:bpf_testmod_test_read")
>>   int BPF_PROG(handle_fentry_explicit,
>>   	     struct file *file, struct kobject *kobj,
>>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
>>   {
>> -	fentry_explicit_read_sz = len;
>> +	sz = len;
>>   	return 0;
>>   }
>>   
>>   
>> -__u32 fentry_explicit_manual_read_sz = 0;
>> -
>> -SEC("fentry")
>> +SEC("?fentry")
>>   int BPF_PROG(handle_fentry_explicit_manual,
>>   	     struct file *file, struct kobject *kobj,
>>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
>>   {
>> -	fentry_explicit_manual_read_sz = len;
>> +	sz = len;
>>   	return 0;
>>   }
>>   
>> -__u32 fexit_read_sz = 0;
>> -int fexit_ret = 0;
>> +int retval = 0;
>>   
>> -SEC("fexit/bpf_testmod_test_read")
>> +SEC("?fexit/bpf_testmod_test_read")
>>   int BPF_PROG(handle_fexit,
>>   	     struct file *file, struct kobject *kobj,
>>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len,
>>   	     int ret)
>>   {
>> -	fexit_read_sz = len;
>> -	fexit_ret = ret;
>> +	sz = len;
>> +	retval = ret;
>>   	return 0;
>>   }
>>   
>> -SEC("fexit/bpf_testmod_return_ptr")
>> +SEC("?fexit/bpf_testmod_return_ptr")
>>   int BPF_PROG(handle_fexit_ret, int arg, struct file *ret)
>>   {
>>   	long buf = 0;
>> @@ -122,18 +109,16 @@ int BPF_PROG(handle_fexit_ret, int arg, struct file *ret)
>>   	return 0;
>>   }
>>   
>> -__u32 fmod_ret_read_sz = 0;
>> -
>> -SEC("fmod_ret/bpf_testmod_test_read")
>> +SEC("?fmod_ret/bpf_testmod_test_read")
>>   int BPF_PROG(handle_fmod_ret,
>>   	     struct file *file, struct kobject *kobj,
>>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
>>   {
>> -	fmod_ret_read_sz = len;
>> +	sz = len;
>>   	return 0; /* don't override the exit code */
>>   }
>>   
>> -SEC("kprobe.multi/bpf_testmod_test_read")
>> +SEC("?kprobe.multi/bpf_testmod_test_read")
>>   int BPF_PROG(kprobe_multi)
>>   {
>>   	return 0;
> 

