Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE03DB633
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692338; cv=none; b=E8ebu7LPMQA8j7BR6fWNyRwQlASX9GvL4d0HhUDb6Nyhr0sT4M9I4YkZH9VBhKgyTKEkH+E31YvBkL74X+ahnKWPIFEg0Il6LguSgqTOwEGyIzA7JiUUbdqnRA8h6NY5NQxBPxSYND70VbMVzRCVzUeemd5yLMzzMiDrgMxbrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692338; c=relaxed/simple;
	bh=NBiMnrImnHItmf4STDeqjB8MTSVn+E/Hd512IYeKlho=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VoNXjyK8vINgZc3zQpXNpiHfWVYCCxl5osh6i03257+zZ6TOXoYrd2CfpQv6EANyyKeW5Pn+Gaz6uJ/3BxyalnERdoA6BqLsxtcnqS7kYdaWWMhK+ZcMYhJG00sI7yaeiWu99RMPYNl+BsgrY+4o5Az0qUXWK82TcRzY79I+UiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=i4Pt0nIU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="i4Pt0nIU"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb4136d865so670176485a.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 13:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773692336; x=1774297136; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJjKpy2NSz8yXDUCSA4nsuucIHU5voD46HWaF5DCjJo=;
        b=i4Pt0nIUBSLywZkliw5YsWXRkZxgDZRYCTofnmyHs8r9+ew/B07ZnoNl72+fo5I0zN
         qnVoFJKkK44RmaMYlpA5bTDtxCxnN/aZhUBP9h9JE4PmhzIJB5QgLNECWl/nUZFUkfmQ
         FeJ97LqAHh71NRWwA0PiZBZ1jrViUd+5LqSB5v2YnuhPZSVYIzWbi7w/2FEwK8qMUFd9
         sQjNfZ7F0rD0HJU8rPj/xcdf8LadCWoXp/M6u0u5b1yBB3jY1GHEEZsZG0q3B7N+C6j6
         XHssZwZjNwX7mz6XF2rsoHMD9UifhADCUPboSnk9VWDp91L9VmP4nanNmbkHfTwuYZq/
         q+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773692336; x=1774297136;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJjKpy2NSz8yXDUCSA4nsuucIHU5voD46HWaF5DCjJo=;
        b=tC1VIL2xiP/H85btyXJBxENee+u38mcvNnVRYKYsqwzAqPUScFLgallGV5DsExdASw
         ZmXd716YENmz9Pr/yDdOTw2jM+x4DHPAXfbl8tf1ttdC2t/crUce/I7pu9ct180b8flT
         cKvd9QEe3KRQKET4GO37kmFMyfwxA58ZxHsXXA0dL/b7GZ1CYhEA/fG65juMWVYm+fKk
         5OS9ZY6hRmrmt+cK2gmVMwPPtzjJcMYN8a7u4b+Pj2Bbd68Qr+TNlzISW580pk0c/T70
         FdN6JflpxbPS20pV0A+ii8S6P9ZLV54/xY88VSYkG5lOOKE1SiMaUV5OY1pZU6ndel1H
         xg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL+T7dBI5XRVTehLgUs21EzpMIb8RpYRy16/zUQekn4FSMmRpuUT7f2UCHbU4R51oakyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIa8tuRaJhpxFUDLTgkG1WH92zTvZjEVCTzrTdaZ/tiklh0vq
	ydUNbqi371MTDpqxMtsFrcfDt86tsS7XBmE0X3HKYHNsK1WLf5vZDfUCqh67f3KLqf8=
X-Gm-Gg: ATEYQzxMe6ko9ZXmCMZ8IA+15l5mphxEePbpBi9XCFQWIRtW2Fl5ZGStHWindNebniQ
	P2MENPh1fK8OV4EYCl7wKlziXWPuIWCckiGkLvfLk6zdJH0wH/mgXiG14d9znsVoQb2mYi9w9sh
	GcrcyQxoQ1BpAzTv8lZIOgk8FtU8LMrgbqKwpDr6qadG7RrmGrE6SZu29hHl8F+Lc7WzxF6Cr5Q
	xrf8ZbjAJ+7AuBgMcia0Nwu54ybrED2iT++/nkKIEfU+nC4tQfEZYl+d9mKJjneBC+YjZRArfy5
	RXL9n1GLrMPR83K1LgJ04MoVA31ihJZ/IORfw0A0H7glP05uW2ak1cNCQUgJWBfsFtPlOI/Yi+y
	W48Nq7fvd564yKZMf9KhY3Wa6R/5LoUB21/GzWZ4EH+U81e7e/GUbOS36xTrGKqZIiVjeJTy7+U
	t/pHKTldM4R+xemARgIYB+Y+s=
X-Received: by 2002:a05:620a:450d:b0:8c6:a5bc:8a90 with SMTP id af79cd13be357-8cdb5a4b9e8mr2017394285a.14.1773692335627;
        Mon, 16 Mar 2026 13:18:55 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cdd8028300sm245195685a.46.2026.03.16.13.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 13:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 16:18:52 -0400
Message-Id: <DH4HGGKLQ2EG.33P3WH3OF05RX@etsalapatis.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
 <sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
 <tangyazhou518@outlook.com>, <shenghaoyuan0928@163.com>, <ziye@zju.edu.cn>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for large offset
 bpf-to-bpf call
From: <emil@etsalapatis.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260316190220.113417-1-tangyazhou@zju.edu.cn>
 <20260316190220.113417-3-tangyazhou@zju.edu.cn>
In-Reply-To: <20260316190220.113417-3-tangyazhou@zju.edu.cn>

On Mon Mar 16, 2026 at 3:02 PM EDT, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> The test utilizes an inline assembly block with `.rept 200000` to generat=
e
> a massive dummy subprogram. By placing this padding between the main prog=
ram
> and the target subprogram, it forces the verifier to process a bpf-to-bpf=
 call
> with the `imm` field exceeding the s16 range.
>
> The user-space test driver dynamically adapts to the host's JIT configura=
tion:
> - When JIT is enabled, it asserts that the program is successfully loaded=
,
>   JIT-compiled, and executes correctly (returning the expected value).
> - When JIT is disabled, it asserts that the program is cleanly rejected b=
y
>   the verifier with -EINVAL (or -ENOSPC if the verifier log buffer is tru=
ncated),
>   and strictly matches the expected error log.
>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---
>  .../selftests/bpf/prog_tests/call_large_imm.c | 49 +++++++++++++++++++
>  .../selftests/bpf/progs/call_large_imm.c      | 38 ++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/call_large_imm.c b/to=
ols/testing/selftests/bpf/prog_tests/call_large_imm.c
> new file mode 100644
> index 000000000000..ba4a2e27fa5d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "call_large_imm.skel.h"
> +
> +void test_call_large_imm(void)
> +{
> +	struct call_large_imm *skel;
> +	int err, prog_fd;
> +	char log_buf[4096] =3D {};

No need to init the log_buf, it will be NUL-terminated if load runs.

> +	char dummy_data[64] =3D {};

Nit: Why define dummy_data? You can make the function you're calling an
int (void) syscall to avoid this.

> +
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		.data_in =3D dummy_data,
> +		.data_size_in =3D sizeof(dummy_data),
> +	);
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

So we only test one path at a time, correct? I understand there's no
good way to turn JIT compilation on and off, but as it stands

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
> index 000000000000..d0057f88b48b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/call_large_imm.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct __sk_buff;

Can be removed if you use a syscall prog instead of a socket.

> +
> +static __attribute__((noinline)) void padding_subprog(void)
> +{
> +	asm volatile ("					\
> +		r0 =3D 0;					\
> +		.rept 200000;				\
> +		r0 +=3D 0;				\
> +		.endr;					\
> +	" ::: "r0");
> +}
> +
> +static __attribute__((noinline)) int target_subprog(struct __sk_buff *ct=
x)
> +{
> +	volatile int magic_ret =3D 3;
> +	return magic_ret;


If we remove the printk below, we can just leave this empty or have it
return 3 directly. Is there a reason to define the constant we're
returning indirectly? If there is there should be a comment about it
because right now it's not readily apparent.

> +}
> +
> +SEC("socket")
> +int call_large_imm_test(struct __sk_buff *ctx)
> +{
> +	int ret =3D 0;
> +
> +	if (ctx =3D=3D (void *)0)

Nit: Would if (!ctx) work? What is this condition's purpose in the first
place? If it's deliberate, again can we add a comment?

> +		padding_subprog();
> +
> +	et =3D target_subprog(ctx);
> +
> +	bpf_printk("Target subprog returned: %d\n", ret);

Let's remove this, there's no reason to emit to the trace pipe even on
success.

> +
> +	return ret;
> +}
> +
> +char LICENSE[] SEC("license") =3D "GPL";

