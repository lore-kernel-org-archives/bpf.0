Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727E15624B
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739322; cv=none; b=pAWOobJUmbexv+EpZuX89O0eQtHY6K5PdR+SEL+OGkk5gPNgS0L7yn1c6Jqm9Fa2ERSPK/oRs4vI0cRMnALrBZArvebfBbufa+Yp0STsLIwPD5qQp4d/7QoBieYBQPBFBzAx8MtKCokDJdmdDqrT/Akj3UdrXk1m8yoEzEeoiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739322; c=relaxed/simple;
	bh=TVgnxz8126eosY7mmIwUWjVdHGM0HeiWQZhn1eylK4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZY0golpemENHUH/u9jiXmVhg8iUjHaRgbi7sWrEMCvMnrTgbzE6eDGQkWBxDunr0/eGnrfwkbQQoGbFxp33CaTjJt23mgvZQmI+23Vq1Q23V8ErQPENr+whWwM4cvn0fbqsd6V005sMoGeBzm3GuezOXpStiywmFK5eGaYcdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzLkUN91; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzLkUN91"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4359a302794so2801502f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770739319; x=1771344119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpbXz0/o4Bps928R583Ni1hYIcFM4sc32oi4ssDkBJY=;
        b=bzLkUN91MhsMqx2E0sXLpTnOIHskMey1GSdqdz5q5ZKhtwjpnItstbul1Hbaekv/eD
         dQcq36bfbApd6VvmSs6eGOuN2nlEoEXFvCVzGFuUcH2hclE8b7BWZtOWC2ACgq7tfe0i
         nptUNa3NCRc0/ig/8Axys5yizHOVcw+syeembwW4UdEzZzsY5o83Jh+Za4LJ7n2jn+o9
         xabzZUIUd+zTvlKI0qs9Nwg6GkFscG0BgtUATteSNWws07CSDM11taVtCO20/STzLzbS
         6NmvfD3YEaQ5dIIdQaAbm5Nwkb3wBEkHoI5LDlLnKUHX1+FSO46M+Hu7fAwP44iZKKVX
         DXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770739319; x=1771344119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpbXz0/o4Bps928R583Ni1hYIcFM4sc32oi4ssDkBJY=;
        b=mo5kzOT4ijWKgyAVmEwDYCaJDe4Inis6vLzqVBBRWsmxOMPGNtaPsChPpLQ/SF0YCp
         HBFw/vXCtZx2MQ+9cEJIAutCRuuhuTdMLWwxsOwqq/cbhWESmua3zHLB8O/cZra9mj6Z
         ajNrS/4+zuZTMJVRpQd0nc47p+laL0kAltB+Mh9bGmfIqnZjlPq8o+2WUakHJxUBGu15
         DQSAhFO98a/Wu4ihSPxymtTJzq0/dLCmgXUSsKZnUB366FHK/JqT+cAyggQIh/13lWtN
         l04OVXY446EotRsyV4JTpRCjjVPMupDh21slzDqaXLw/2oVa0XNahGMr6+1L+F6qhmjK
         PrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvWXIvSD2wY1DCsVXu/Pdx3U5GbzSn6TuCRTn22b+I4dPDttMOR9w9ib3HXv5j3Xn5FIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32SaooAAqdUMNHtOdkIVgrRiEpZSF6Dm6fMjIdpdUx+tMZpck
	fOf9xGMP0egrz13z0PS1yLlp97NiWOEkwO4C8rAUit4Aq819EmDmD3qB
X-Gm-Gg: AZuq6aJUoLby3diy6g/F4YcGk0UgBw7ndiuPejVRLoq3Bnip6Pozld3rJnl2JTvxcUL
	9rTicuoY/KVvf4/fY+EzA6fZ1JWfnABqM2exO5Zavh62dDRikP4q5eMW3aNBcRkzsfrXf8Aaw4u
	V+4LOfoJoDYSLrBeCwa9ZGIqVZnejKY62uaVI7+oUt44bzN3QSuzCRBf/ZGKpOEDvW82wsOBV1i
	0ZxKV4pEQdL7+aBch/najaO5TSzeOj1KFfae1MXA310x/87pNcG16/tVQPXF6tfvm/lKt6GgbDa
	fTfCudNcgLSO9KNoJg65w9RCuG+rIZ3m2EzOQg6FbHDq8ai95ER6wfG3IfuNAaX2y33alHucxl8
	yEw+HGyFlOEQOpvrpNPVw03gwu3iZqpb+8H+AmmRcD+oBMQSanOjzeU01KXY72HnMUR+Rdjn/lT
	orR75EOaC7dqvAtiYzVvWdKJWSS0WuWLlyVfxx6+XWfATii6OcB9hoKGpRZnD77vAId5m6FIS4K
	4O9kwOhNU5gS89NSPTR3GM8Ig==
X-Received: by 2002:a05:6000:2301:b0:437:8111:e2d0 with SMTP id ffacd0b85a97d-4378111e486mr782957f8f.8.1770739318895;
        Tue, 10 Feb 2026 08:01:58 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436309ed238sm34109091f8f.19.2026.02.10.08.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 08:01:57 -0800 (PST)
Message-ID: <917d381a-c600-42ad-9f75-f5e49456f5f3@gmail.com>
Date: Tue, 10 Feb 2026 16:01:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Split module_attach into
 subtests
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jordan Rome <linux@jordanrome.com>, Qais Yousef <qyousef@layalina.io>,
 Hou Tao <houtao1@huawei.com>
References: <cover.1770732776.git.vmalik@redhat.com>
 <699a95dfb6493cfd588524f388214db1250518f3.1770732776.git.vmalik@redhat.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <699a95dfb6493cfd588524f388214db1250518f3.1770732776.git.vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/10/26 14:14, Viktor Malik wrote:
> The test verifies attachment to various hooks in a kernel module,
> however, everything is flattened into a single test. When running the
> test on a kernel which doesn't support some of the hooks, it is
> impossible to skip them selectively.
>
> Isolate each BPF program into a separate subtest. This is done by
> disabling auto-loading of programs and loading and testing each program
> separately.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>   .../selftests/bpf/prog_tests/module_attach.c  | 168 +++++++++++++-----
>   .../selftests/bpf/progs/test_module_attach.c  |  63 +++----
>   2 files changed, 149 insertions(+), 82 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
> index 70fa7ae93173..8668c26c202f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
> @@ -6,6 +6,23 @@
>   #include "test_module_attach.skel.h"
>   #include "testing_helpers.h"
>   
> +static const char * const read_tests[] = {
> +	"handle_raw_tp",
> +	"handle_tp_btf",
> +	"handle_fentry",
> +	"handle_fentry_explicit",
> +	"handle_fmod_ret",
> +};
> +
> +static const char * const detach_tests[] = {
> +	"handle_fentry",
> +	"handle_fexit",
> +	"kprobe_multi",
> +};
> +
> +static const int READ_SZ = 456;
> +static const int WRITE_SZ = 457;
> +
>   static int duration;
>   
>   static int trigger_module_test_writable(int *val)
> @@ -33,27 +50,66 @@ static int trigger_module_test_writable(int *val)
>   	return 0;
>   }
>   
> -void test_module_attach(void)
> +static void test_module_attach_prog(const char *prog_name, int sz,
> +				    const char *attach_target, int ret)
>   {
> -	const int READ_SZ = 456;
> -	const int WRITE_SZ = 457;
> -	struct test_module_attach* skel;
> -	struct test_module_attach__bss *bss;
> -	struct bpf_link *link;
> +	struct test_module_attach *skel;
> +	struct bpf_program *prog;
>   	int err;
> -	int writable_val = 0;
>   
>   	skel = test_module_attach__open();
>   	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
>   		return;
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
Does it makes sense to goto cleanup if err here?
> +	}
> +
> +	err = test_module_attach__load(skel);
> +	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
Is there any reason to use CHECK instead of ASSERT_OK(more common)?
> +		return;
> +
> +	err = test_module_attach__attach(skel);
> +	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
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
can we use skel->progs.handle_raw_tp_writable_bare instead of 
find_program_by_name?
> +	if (!ASSERT_OK_PTR(prog, "find program"))
> +		goto cleanup;
> +	bpf_program__set_autoload(prog, true);
>   
>   	err = test_module_attach__load(skel);
>   	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
> @@ -65,21 +121,6 @@ void test_module_attach(void)
>   	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
>   		goto cleanup;
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
> -
>   	bss->raw_tp_writable_bare_early_ret = true;
>   	bss->raw_tp_writable_bare_out_val = 0xf1f2f3f4;
>   	ASSERT_OK(trigger_module_test_writable(&writable_val),
> @@ -87,31 +128,72 @@ void test_module_attach(void)
>   	ASSERT_EQ(bss->raw_tp_writable_bare_in_val, 1024, "writable_test_in");
>   	ASSERT_EQ(bss->raw_tp_writable_bare_out_val, writable_val,
>   		  "writable_test_out");
> +cleanup:
> +	test_module_attach__destroy(skel);
> +}
>   
> -	test_module_attach__detach(skel);
> -
> -	/* attach fentry/fexit and make sure it gets module reference */
> -	link = bpf_program__attach(skel->progs.handle_fentry);
> -	if (!ASSERT_OK_PTR(link, "attach_fentry"))
> -		goto cleanup;
> +static void test_module_attach_detach(const char *prog_name)
> +{
> +	struct test_module_attach *skel;
> +	struct bpf_program *prog;
> +	struct bpf_link *link;
> +	int err;
>   
> -	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
> -	bpf_link__destroy(link);
> +	skel = test_module_attach__open();
> +	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
> +		return;
>   
> -	link = bpf_program__attach(skel->progs.handle_fexit);
> -	if (!ASSERT_OK_PTR(link, "attach_fexit"))
> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +	if (!ASSERT_OK_PTR(prog, "find program"))
>   		goto cleanup;
> +	bpf_program__set_autoload(prog, true);
>   
> -	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
> -	bpf_link__destroy(link);
> +	err = test_module_attach__load(skel);
> +	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
> +		goto cleanup;
>   
> -	link = bpf_program__attach(skel->progs.kprobe_multi);
> -	if (!ASSERT_OK_PTR(link, "attach_kprobe_multi"))
> +	/* attach and make sure it gets module reference */
> +	link = bpf_program__attach(prog);
> +	if (!ASSERT_OK_PTR(link, "attach"))
>   		goto cleanup;
>   
>   	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
>   	bpf_link__destroy(link);
> -
>   cleanup:
>   	test_module_attach__destroy(skel);
>   }
> +
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
> +	}
> +	if (test__start_subtest("handle_raw_tp_writable_bare"))
> +		test_module_attach_writable();
> +	if (test__start_subtest("handle_fentry_manual")) {
> +		test_module_attach_prog("handle_fentry_manual", READ_SZ,
> +					"bpf_testmod_test_read", 0);
> +	}
> +	if (test__start_subtest("handle_fentry_explicit_manual")) {
> +		test_module_attach_prog("handle_fentry_explicit_manual",
> +					READ_SZ,
> +					"bpf_testmod:bpf_testmod_test_read", 0);
> +	}
> +	if (test__start_subtest("handle_fexit"))
> +		test_module_attach_prog("handle_fexit", READ_SZ, NULL, -EIO);
> +	if (test__start_subtest("handle_fexit_ret"))
> +		test_module_attach_prog("handle_fexit_ret", 0, NULL, 0);
> +	for (i = 0; i < ARRAY_SIZE(detach_tests); i++) {
> +		if (!test__start_subtest(detach_tests[i]))
> +			continue;
> +		test_module_attach_detach(detach_tests[i]);
> +	}
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
> index 03d7f89787a1..5609e388fb58 100644
> --- a/tools/testing/selftests/bpf/progs/test_module_attach.c
> +++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
> @@ -7,23 +7,21 @@
>   #include <bpf/bpf_core_read.h>
>   #include "../test_kmods/bpf_testmod.h"
>   
> -__u32 raw_tp_read_sz = 0;
> +__u32 sz = 0;
>   
> -SEC("raw_tp/bpf_testmod_test_read")
> +SEC("?raw_tp/bpf_testmod_test_read")
>   int BPF_PROG(handle_raw_tp,
>   	     struct task_struct *task, struct bpf_testmod_test_read_ctx *read_ctx)
>   {
> -	raw_tp_read_sz = BPF_CORE_READ(read_ctx, len);
> +	sz = BPF_CORE_READ(read_ctx, len);
>   	return 0;
>   }
>   
> -__u32 raw_tp_bare_write_sz = 0;
> -
> -SEC("raw_tp/bpf_testmod_test_write_bare_tp")
> +SEC("?raw_tp/bpf_testmod_test_write_bare_tp")
>   int BPF_PROG(handle_raw_tp_bare,
>   	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
>   {
> -	raw_tp_bare_write_sz = BPF_CORE_READ(write_ctx, len);
> +	sz = BPF_CORE_READ(write_ctx, len);
>   	return 0;
>   }
>   
> @@ -31,7 +29,7 @@ int raw_tp_writable_bare_in_val = 0;
>   int raw_tp_writable_bare_early_ret = 0;
>   int raw_tp_writable_bare_out_val = 0;
>   
> -SEC("raw_tp.w/bpf_testmod_test_writable_bare_tp")
> +SEC("?raw_tp.w/bpf_testmod_test_writable_bare_tp")
>   int BPF_PROG(handle_raw_tp_writable_bare,
>   	     struct bpf_testmod_test_writable_ctx *writable)
>   {
> @@ -41,76 +39,65 @@ int BPF_PROG(handle_raw_tp_writable_bare,
>   	return 0;
>   }
>   
> -__u32 tp_btf_read_sz = 0;
> -
> -SEC("tp_btf/bpf_testmod_test_read")
> +SEC("?tp_btf/bpf_testmod_test_read")
>   int BPF_PROG(handle_tp_btf,
>   	     struct task_struct *task, struct bpf_testmod_test_read_ctx *read_ctx)
>   {
> -	tp_btf_read_sz = read_ctx->len;
> +	sz = read_ctx->len;
>   	return 0;
>   }
>   
> -__u32 fentry_read_sz = 0;
> -
> -SEC("fentry/bpf_testmod_test_read")
> +SEC("?fentry/bpf_testmod_test_read")
>   int BPF_PROG(handle_fentry,
>   	     struct file *file, struct kobject *kobj,
>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
>   {
> -	fentry_read_sz = len;
> +	sz = len;
>   	return 0;
>   }
>   
> -__u32 fentry_manual_read_sz = 0;
> -
> -SEC("fentry")
> +SEC("?fentry")
>   int BPF_PROG(handle_fentry_manual,
>   	     struct file *file, struct kobject *kobj,
>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
>   {
> -	fentry_manual_read_sz = len;
> +	sz = len;
>   	return 0;
>   }
>   
> -__u32 fentry_explicit_read_sz = 0;
> -
> -SEC("fentry/bpf_testmod:bpf_testmod_test_read")
> +SEC("?fentry/bpf_testmod:bpf_testmod_test_read")
>   int BPF_PROG(handle_fentry_explicit,
>   	     struct file *file, struct kobject *kobj,
>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
>   {
> -	fentry_explicit_read_sz = len;
> +	sz = len;
>   	return 0;
>   }
>   
>   
> -__u32 fentry_explicit_manual_read_sz = 0;
> -
> -SEC("fentry")
> +SEC("?fentry")
>   int BPF_PROG(handle_fentry_explicit_manual,
>   	     struct file *file, struct kobject *kobj,
>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
>   {
> -	fentry_explicit_manual_read_sz = len;
> +	sz = len;
>   	return 0;
>   }
>   
> -__u32 fexit_read_sz = 0;
> -int fexit_ret = 0;
> +int retval = 0;
>   
> -SEC("fexit/bpf_testmod_test_read")
> +SEC("?fexit/bpf_testmod_test_read")
>   int BPF_PROG(handle_fexit,
>   	     struct file *file, struct kobject *kobj,
>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len,
>   	     int ret)
>   {
> -	fexit_read_sz = len;
> -	fexit_ret = ret;
> +	sz = len;
> +	retval = ret;
>   	return 0;
>   }
>   
> -SEC("fexit/bpf_testmod_return_ptr")
> +SEC("?fexit/bpf_testmod_return_ptr")
>   int BPF_PROG(handle_fexit_ret, int arg, struct file *ret)
>   {
>   	long buf = 0;
> @@ -122,18 +109,16 @@ int BPF_PROG(handle_fexit_ret, int arg, struct file *ret)
>   	return 0;
>   }
>   
> -__u32 fmod_ret_read_sz = 0;
> -
> -SEC("fmod_ret/bpf_testmod_test_read")
> +SEC("?fmod_ret/bpf_testmod_test_read")
>   int BPF_PROG(handle_fmod_ret,
>   	     struct file *file, struct kobject *kobj,
>   	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
>   {
> -	fmod_ret_read_sz = len;
> +	sz = len;
>   	return 0; /* don't override the exit code */
>   }
>   
> -SEC("kprobe.multi/bpf_testmod_test_read")
> +SEC("?kprobe.multi/bpf_testmod_test_read")
>   int BPF_PROG(kprobe_multi)
>   {
>   	return 0;

