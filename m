Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898293;
	b=nuBlUyqbvYrTEbnJvbpVYblnxcznYpJV2XQjQ790r1k/Bnxrl6ToGuTAuRqzZ1DGtfoz
	 fI8pOgOQFMXuAt3PDmEAvIG1zoGk3Kkju3VRukj5tGEdI998M5phK5DGI6F3qfmOtm1cw
	 OUCD8vktzldlWQVBHTcnuh3fstbHdQs8P6uoCcdmzwvr9PJg7EIht/P4LI0nvpbBOOq8H
	 2CbC7D6mBDliM9KX/skv8QuztQxggus7kX0UODpN+GN9cHOHvYR0CE2vim/n0PgCnTlZJ
	 KnCrq5DbA5QXkGWJ9uJoAPbiwcbImBVBkmsFJkaVdSWmRjH/DIspvH3PRqh9WNh/Avw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898293;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:
	 From:To:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=tFELIg/XWdUdJ9mvJY05GWcNZWFrkuxK3FAD1A4Q1WY=;
	b=RKofGezmfscq+fOMYgsft7li5Y4dy3TkJJYuVwNP2L4PKONo+QwFsKLv0yw+6hu03a2m
	 mkkkuMWiARjQ6lRkqC3mn/7CI+ZnH5yueiSSwjP+UgJliHWcz4axCbu8sOYM1GzKe38Ci
	 S0jCfXLAwc7e1M5fBxbH4ym461dz691+ZJK8D0dmHfCCN9knv6XRG0+HBORu/wyC2GIxm
	 8dOTwxIU03wq5tpHmitno3FyNwH97tk5RjwYlChibTSEdJq2Y6ssvXGIPL5m7wyg/EU2Y
	 DHMcTxr6DwJ6OUmV5MWcSUx3qLnQHf/zFS5eK7HL2p6QZFLNGUKexhS5hbcAY0qqF0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="NqFyd/e5";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B5606A31B;
	Thu,  5 Nov 2026 17:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F7B5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NqFyd/e5
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A7BA51A0A53;
	Thu,  5 Nov 2026 17:04:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 71B8E5FF43;
	Thu,  5 Nov 2026 17:04:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9527E10329289;
	Thu,  5 Nov 2026 18:04:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793898286; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tFELIg/XWdUdJ9mvJY05GWcNZWFrkuxK3FAD1A4Q1WY=;
	b=NqFyd/e5nL3p61EwsmZzQ7nHcCLXYexuBb8Hu5cSpMnIl55xb3eTuBYd1R+yPix5Z0VQDt
	zziOUgEv+u911Z+wMpMidInZbWEi1tEOq7UxZMUvryOHys++veSE3Yvutxr2J1b03K5mgh
	/ayBX9WTnaXsNAkq/iXcQcRpyUsAitmUzd0SIUx4DRdHpwRw31ZaHldiSPoayRy6FMqQS6
	B+U1UlP+JUNn4Ob2sgYuV+pG7U+ffRCg5TvwoB4G97UTseguSloWVKX/nLXUzG6AAtEY1/
	mg9MMPv7RYMFwyQu+7QK3VZrR7lGhiJ5x9Q+eUGbEOLQrxaMYyLSsSXtxWd68A==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 18:04:41 +0100
Message-Id: <DMNFV9TGBTT7.2APJ533JDZBFN@bootlin.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: port test_ftrace.sh to
 test_progs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Jiri Olsa" <olsajiri@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261104-ftrace_in_test_progs-v2-1-45363230d228@bootlin.com>
 <ausZvdHfmevg3mMZ@krava>
In-Reply-To: <ausZvdHfmevg3mMZ@krava>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jiri,

On Wed Nov 4, 2026 at 12:40 PM CET, Jiri Olsa wrote:
> On Wed, Nov 04, 2026 at 10:59:33AM +0100, Alexis Lothor=C3=A9 (eBPF Found=
ation) wrote:
>> Commit ff205766dbbe ("ftrace: Fix function_graph tracer interaction with
>> BPF trampoline") made sure that trampolines generated for tracing
>> programs did not collide with the function graph when we are returning
>> from the hooked function. The series bringing this commit also came with
>> a new test ensuring that the kernel does not crash when executing BPF
>> programs handled by trampolines while the function graph trace is
>> enabled, but this test is a standalone shell script, hence not executed
>> in CI.

[...]

> lgtm, it might be worth to add something like this also for
> tracing-multi (maybe also kprobe-multi) and run some tests
> with function or function_graph enabled

Sure, I can take a look and follow-up with this. I guess it can be a
separate series, unless I'm told that it should be added in a v3.

Alexis

> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
>
> jirka
>
> SNIP
>
>> +void test_modify_return_graph(void)
>> +{
>> +	char instance[MAX_INSTANCE_PATH_LEN];
>> +	char *ftrace_dir;
>> +	int ret;
>> +
>> +	ftrace_dir =3D access(TRACE_FTRACE_DEFAULT, F_OK) ? TRACEFS_IN_DEBUGFS=
 :
>> +							  TRACEFS_DEFAULT;
>> +
>> +	ret =3D snprintf(instance, MAX_INSTANCE_PATH_LEN,
>> +		       "%s/instances/bpf-XXXXXX", ftrace_dir);
>> +	if (ret < 0)
>> +		return;
>> +
>> +	if (!ASSERT_OK_PTR(mkdtemp(instance), "mkdtemp"))
>> +		return;
>> +
>> +	SYS(out, "echo 'bpf_modify_return_test*' > %s/set_ftrace_filter",
>> +	    instance);
>
> nit, no need for new line
>
>> +	SYS(out, "echo function_graph > %s/current_tracer", instance);
>> +
>> +	test_modify_return();
>> +
>> +	SYS(out, "grep -q bpf_modify_return_test2 %s/trace", instance);
>> +out:
>> +	ASSERT_OK(rmdir(instance), "rmdir");
>> +}
>> diff --git a/tools/testing/selftests/bpf/test_ftrace.sh b/tools/testing/=
selftests/bpf/test_ftrace.sh
>> deleted file mode 100755
>> index f5109eb0e951..000000000000
>> --- a/tools/testing/selftests/bpf/test_ftrace.sh
>> +++ /dev/null
>> @@ -1,44 +0,0 @@
>> -#!/bin/bash
>> -
>> -if [[ -e /sys/kernel/tracing/trace ]]; then
>> -    TR=3D/sys/kernel/tracing/
>> -else
>> -    TR=3D/sys/kernel/debug/tracing/
>> -fi
>> -
>> -clear_trace() { # reset trace output
>> -    echo > $TR/trace
>> -}
>> -
>> -disable_tracing() { # stop trace recording
>> -    echo 0 > $TR/tracing_on
>> -}
>> -
>> -enable_tracing() { # start trace recording
>> -    echo 1 > $TR/tracing_on
>> -}
>> -
>> -reset_tracer() { # reset the current tracer
>> -    echo nop > $TR/current_tracer
>> -}
>> -
>> -disable_tracing
>> -clear_trace
>> -
>> -echo "" > $TR/set_ftrace_filter
>> -echo '*printk* *console* *wake* *serial* *lock*' > $TR/set_ftrace_notra=
ce
>> -
>> -echo "bpf_prog_test*" > $TR/set_graph_function
>> -echo "" > $TR/set_graph_notrace
>> -
>> -echo function_graph > $TR/current_tracer
>> -
>> -enable_tracing
>> -./test_progs -t fentry
>> -./test_progs -t fexit
>> -disable_tracing
>> -clear_trace
>> -
>> -reset_tracer
>> -
>> -exit 0
>>=20
>> ---
>> base-commit: b0e67f50519538b1b4c6364edc7811f482703f75
>> change-id: 20261027-ftrace_in_test_progs-d5f70a2330ac
>>=20
>> Best regards,
>> -- =20
>> Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>
>>=20





--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

