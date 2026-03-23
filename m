Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717D235C01
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277945; cv=none; b=Pe9yUo+B83fA0L9XIZF30zuZ0hhrzV6YbxdlpYFWhYX9T3g+3Hd7zG/YSQ3JsOQSd3GZDpm8b50VXPaITDbnJFgStRs1XRCkHkuDtPThL61ag1lOwjgFv8hcjc4y7HBY2wZgwOoVe2qPTWQK2N9YEzXTepYERRs629X9GPeWq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277945; c=relaxed/simple;
	bh=hZMa9/rXp/MLbEXo8hvit7Hb+0FLFCNzpG3ElI9yPZw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=IjTG2fNKFHMeNxD0r9SpUexbsGkU8oRMwZO71ORAVtDBUdbaeuH+9KMl6JgzBkhgN3F6iIHhXT/Zv71Kxy43kLUVU2iDVDvzTPBhSVn8LhJDjv/IABx+dguTxkPbfqpNg2gyNSPtCxzmOYiA1qjCRoYdrKSTE4OHfI89HIKrEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=nYfowV2w; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="nYfowV2w"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cfbbdbaf3cso415996685a.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1774277942; x=1774882742; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3EqbF6NlwfEFVyEMMoJ9bGfig815fUbu/Fe0QXPdxA=;
        b=nYfowV2wM3W8ufUg65rhTmeEEpQnBIcDlRIKzYLS3wKZsJFV+yG6Chbo8T+HFuSDub
         lypcq7xGl4ftXqPozQmqWTz0lokwtN0H34mBx+I5AFC1uLB9VGxdAnWEQdoDRj95P/46
         pEays4TWmmWucYzpV04W8jgVWca8/L1new6FpeGyxXqPNZqTpG7M54pTE34YhXpa9XJJ
         iltew8n1qdVSgxcZhdxm7Joks48a7ZpWMF7y1chBFS9q/0ASqlZ6sFfZrE/mhy8fUzRV
         kZQMRTXUGNXufvlgCVsdjLxLpI82QLjTt/B3UT9rxiO1Y1WKwbAoKiQXIMydOkgdcbhS
         KxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774277942; x=1774882742;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3EqbF6NlwfEFVyEMMoJ9bGfig815fUbu/Fe0QXPdxA=;
        b=PtFBLuAUl4Xw1pefPKiFDErb5YGwPWez3gaB23BFZUmJh1GmFVPKS1X3zYURwOp9ew
         MUfaI2Z5RxtQTUjiPIkmqmdgbnBp6EkmRzGv3QIkFJYp4dxYtiuYLebUzfdm0E0rJ6jp
         yXHyGmMG5b8SYETZP2ebqL0G7gCk+h1cWnY+wkaiUhkn1UXrtbBfISl7BrG2I3udvbDt
         /VxoyVxjEd2NZFMfJO2LQ/BUC2F8yd0fVt0+P35d2e1h95KuKskboMGx23ID/MMeGzml
         xcs1KDsAU56PKhtXZ27sq3BgXDHhvCw7f+QEAYb+6HmrJ/atsODXNUepFvp6SGwbrbe2
         zxHw==
X-Forwarded-Encrypted: i=1; AJvYcCUClC9EsjAE3R0l/PvsakNFL5Oo1u6hRr36l7UoH5MdFs0yKdj+B3rDDWns1J+GpvSDWzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvv3rmNqhpzNbP/9NFqnGem+RTFivwEkU7R4XhBlz5E25JkzO
	xYI65XtoC/wWFW253Qoq8VFq4RkQH16ohJYuRmhVETYLp0nncUmHZoqvU3zVKbc5vG4=
X-Gm-Gg: ATEYQzwMQyiuVD6l3ap1PMb2WfMnNzMfT0EObZJhI/sCc9S3G9Zs20A0rnwXVb7bmMi
	J110xIy7uNKRPT4sRK0cjxCBHQoApvhQvA6+LnudEH9aiSpAL07MTSvLGXL3vHgh+FkbWIGe/j/
	tzrLa0/S7GPMQwYCpJ7C/WDv6DmelSirCF0rjkq6DeG/aWKvB7qc0hOiY9hR0Kzop2LAFsKtusy
	4TNO3bA1dGuLnjDs2EIYGiyvtzw+7YnSt+I4tBRLK/SiHrbxlutnIs7U6mTPeFUTPaGJsXcqApO
	oG48E9DzrxO9yyU6RKI+TGkOlaOOj2SB88ZOUcllaDVaVVrpDQszJeFs692O7mTDc6UIFM4oSth
	05B5eGmPhVi1IfTgY7FdqhhH3hpa4cw8uLSW8g4/GevcCObZa4/FBxazVzKEZZ7/5TcGOzFLMjp
	we0OKAwlD2NMn2VJqkhehRhbw=
X-Received: by 2002:a05:620a:198b:b0:8cf:cfbd:d1d5 with SMTP id af79cd13be357-8cfcfbdd9efmr1485631685a.23.1774277941785;
        Mon, 23 Mar 2026 07:59:01 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm829411485a.25.2026.03.23.07.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 10:59:00 -0400
Message-Id: <DHA91D8WS7HK.2N4F9P08CTI55@etsalapatis.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
 <sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
 <tangyazhou518@outlook.com>, <shenghaoyuan0928@163.com>, <ziye@zju.edu.cn>
Subject: Re: [PATCH bpf v3 2/3] selftests/bpf: Add test for large offset
 bpf-to-bpf call
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260323122254.98540-1-tangyazhou@zju.edu.cn>
 <20260323122254.98540-3-tangyazhou@zju.edu.cn>
In-Reply-To: <20260323122254.98540-3-tangyazhou@zju.edu.cn>

On Mon Mar 23, 2026 at 8:22 AM EDT, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Add a selftest to verify the verifier and JIT behavior when handling
> bpf-to-bpf calls with relative jump offsets exceeding the s16 boundary.
>
> The test utilizes an inline assembly block with ".rept 200000" to generat=
e
> a massive dummy subprogram. By placing this padding between the main prog=
ram
> and the target subprogram, it forces the verifier to process a bpf-to-bpf=
 call
> with the imm field exceeding the s16 range.
>
> The user-space test driver dynamically adapts to the host's configuration=
:
> - When JIT is enabled, it asserts that the program is successfully loaded=
,
>   JIT-compiled, and executes correctly to return the expected value.
> - When JIT is disabled, it asserts that the verifier cleanly rejects the
>   program with -EINVAL (or -ENOSPC if the log buffer is truncated), match=
ing
>   the expected "offset out of range" error log.
>
> Note: To ensure the test is both effective at load time and efficient at
> runtime, two specific tricks are employed:
> 1. Prevent Compiler Optimization: A volatile variable (magic_ret) is used
>    inside target_subprog(). This prevents the compiler from optimizing
>    the function away or aggressively inlining it, ensuring the subprogram
>    and the call instruction are strictly retained in the final BPF byteco=
de.
> 2. Prevent Execution Degradation: The massive padding subprogram is
>    conditionally called using a global volatile variable ("int zero", who=
se
>    value is actually 0). This forces the verifier to statically analyze t=
he
>    branch and calculate the giant jump offset, but allows the runtime to
>    completely bypass the 200,000 dummy instructions, preventing performan=
ce
>    degradation during test execution.

Nit: You can remove these notes imo, they are way too specific for the
commit description and are relatively frequently used programming idioms
for BPF.

Another nit below.

> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---
>  .../selftests/bpf/prog_tests/call_large_imm.c | 54 +++++++++++++++++++
>  .../selftests/bpf/progs/call_large_imm.c      | 37 +++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/call_large_imm.c b/to=
ols/testing/selftests/bpf/prog_tests/call_large_imm.c
> new file mode 100644
> index 000000000000..8968b3c3263f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "call_large_imm.skel.h"
> +
> +/*
> + * This test dynamically adapts to the current environment, and will suc=
ceed
> + * whether JIT is enabled or not.
> + * 1. If JIT is enabled: The test case will successfully load and return
> + *    the expected value.
> + * 2. If JIT is disabled: It asserts that the verifier cleanly rejects t=
he
> + *    program with -EINVAL (or -ENOSPC) and outputs the expected error l=
og.
> + */
> +
> +void test_call_large_imm(void)
> +{
> +	struct call_large_imm *skel;
> +	int err, prog_fd;
> +	char log_buf[4096];
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +
> +	skel =3D call_large_imm__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	if (!env.jit_enabled)
> +		bpf_program__set_log_buf(skel->progs.call_large_imm_test,
> +					 log_buf, sizeof(log_buf));
> +
> +	err =3D call_large_imm__load(skel);
> +
> +	if (env.jit_enabled) {
> +		if (!ASSERT_OK(err, "load_should_succeed_with_jit"))
> +			goto cleanup;
> +
> +		prog_fd =3D bpf_program__fd(skel->progs.call_large_imm_test);
> +		err =3D bpf_prog_test_run_opts(prog_fd, &opts);
> +
> +		if (ASSERT_OK(err, "prog_run_success"))
> +			ASSERT_EQ(opts.retval, 3, "prog_retval");
> +
> +	} else {
> +		ASSERT_ERR(err, "load_should_fail_in_interpreter");
> +		ASSERT_TRUE(err =3D=3D -EINVAL || err =3D=3D -ENOSPC, "err_should_be_e=
inval_or_enospc");
> +
> +		if (!ASSERT_OK_PTR(strstr(log_buf, "bpf-to-bpf call offset out of rang=
e for interpreter"),
> +				   "check_verifier_log_msg")) {
> +			printf("Actual verifier log:\n%s\n", log_buf);
> +		}
> +	}
> +
> +cleanup:
> +	call_large_imm__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/call_large_imm.c b/tools/t=
esting/selftests/bpf/progs/call_large_imm.c
> new file mode 100644
> index 000000000000..5c59141cb474
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/call_large_imm.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +/*
> + * A volatile global variable is used here, so that padding_subprog()
> + * will not be optimized, and it will not be really executed even if
> + * it is successfully loaded (when JIT is enabled).
> + */
> +volatile int zero =3D 0;
> +
> +static __attribute__((noinline)) void padding_subprog(void)
> +{
> +	asm volatile ("					\
> +		r0 =3D 0;					\

Nit: Is it possible to make this value exactly as large as it needs to
be to trigger the verifier failure? Along with an explanation as to why
it is that exact size that triggers it.

> +		.rept 200000;				\
> +		r0 +=3D 0;				\
> +		.endr;					\
> +	" ::: "r0");
> +}
> +
> +static __attribute__((noinline)) int target_subprog(void)
> +{
> +	/* A volatile variable is used here to prevent optimization. */
> +	volatile int magic_ret =3D 3;
> +	return magic_ret;
> +}
> +
> +SEC("syscall")
> +int call_large_imm_test(void *ctx)
> +{
> +	if (zero)
> +		padding_subprog();
> +	return target_subprog();
> +}
> +
> +char LICENSE[] SEC("license") =3D "GPL";

