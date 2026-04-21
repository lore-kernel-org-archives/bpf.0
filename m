Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4D2BE621
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809274; cv=none; b=KZv1uHLhOZOAbvhIGxGCzA/ow10taWjbpgKiUIjWHcWZkNzVixzCnMrOUutj2vhwOEFjTu+6epZszAfQBwR0wNwYgaE00sk1PiFC4WI1Ker7ELLBPcRiwGJpR+e+0ShFwtnRfBD9xeFNRoAPPCjn1YVXY0dvKLgfNH1hK+NjLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809274; c=relaxed/simple;
	bh=FYawrbvv4ttUX4fza/GLSDvzmH0x6UjpDWn3B1smFB0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=J8zzIJGmBoRDe2+WHdrI4oARKqPxrNk+3Zv/NOh+AQ13muruQr9DcWnwyQH/U1QoCY5xdba2oEOHBCnfdzkO8vVSRRcwDXsfro+gm4Rreo44+NYAdUoZ8zKACtbj+ml+81YyAG+Jnitxl1dGu4WDIARtkO/3jZWuRXF4dWw/JS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qyyJNHq+; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyyJNHq+"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dbb6c072f1so4022250a34.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809272; x=1777414072; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oz6srP16uADBYAvRZr2xjOhHhYbUHg4cvwC3Umpktb4=;
        b=qyyJNHq+UsQm+8tTCeXkL8z1QWDxhphhlHbwdIfQ6OnrcBwrT/mNoVWwwCGzRGcN0h
         t0Y2XS+FXVA28EMiZHUJ5sI6y4zZME4F7hFNFYH3i7ryCF0TvzfyJIbnx6uNlbeMxWB3
         W2fwKFbOOFbcOYG8xA8zVQ67/OP4/IRtR3MGSs8AkITCqUsPgSzsRlYsgy40dT0sqYvC
         hDuU/vUuaWNzn5wbD94P6WILPAM41FQtXVhoRJe8H7/R9ON6c5fPcfuzxhiAsC9hflbI
         PoOs4Oqxwdw9t+j6K1XqazekD8DwFYPR8P2BYbn1OUdm0fN2ArF9kkNhCoqtmQaHE17U
         PyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809272; x=1777414072;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oz6srP16uADBYAvRZr2xjOhHhYbUHg4cvwC3Umpktb4=;
        b=ltAm0y5b/ALr+XBvfZSC/R8kYwB0gVoQz5IaUS7XfKyPGFMRxUagJFM876cBPgHfKM
         6O1srdS3QjJ58F+bjynbNGT0JteGRUCOE69BC0OdhGk9NzFoBE8u61afKI1t25Y48V7p
         gBlhYdNujaWT9oTQsFeFtC2BCArZRrSxVdR5ieXTTCzebgUF355DsxgVccFUV/7fsaFk
         cXkzFEuuhx5K8lgci2QaV4ffeMLtrH8HyIigqrcSk/H2nrhJx6tuIQp8NQRLKAAATQ73
         fqcJvj0RLJM3Rni+0ZrHKrnIeEG5AeIXyQFYXIHiFUHofMtBnubAR3MvlFXEYdSoRcWs
         NjUw==
X-Forwarded-Encrypted: i=1; AFNElJ9G8xQH9AGmO1bSMtVwh0bU2Evim50XTaFmSE36Q9GB58KhM6gjO2SM7p9/pXSZe3YYqv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcTAZq/UZEI9PYwKVceM1qT1Qw+fTvoj3poczCMm/7AiweJzcU
	ydS2mnqU6qYnP9qjkeohh9YtR2ATItjeSdZQR2r30eWCJxZIKgMwnQrS
X-Gm-Gg: AeBDietI3ha9WPCL3R6bu4HtXDL2xeP+X6Gy1n6rzi4xeLXCcGe2ElW5mmaswcsIYrp
	EvWhYxQm1f5acwR3V3lTSE4w++OgFhwbvCtDGF159MmclDhT2py/rTyWVRIa2Nes0iKVhSubE0B
	z/0pfd6/cJkr43vC3QMrkQ4PIKp4oNYmVH3F2cNB0/ApP9RiEoritEhI6PNtmaCjVHp1qlTyLW4
	sGrEP4EA87SeKjUnX2kC3G0w1nEm7UYqqvueLgu6RYeH1MVkjEsGTtNSni/ccLcC0mtBqUcM1vD
	DCiZaFeclobbrGdUPiLhHPpxBSMd3YYWA7cgnb7MNaGidLDwY0psu9/2uijuEJWf4RFm/DPLioH
	WWt77oQC2aqPgxHucwIt52XTzIVUV8/d2UTktwBh9iRf7IVz1HrJ/f9CxA8zs/nkGQv4LdfqO6v
	Z9sf4t3N+JbiWf/43L+4S9aep8oIJWxuFpLlvO3vpsH0wd4ZMOxrLQA81mnyrvL/HJ2zXGBEifC
	hVUjchUpc6/8MU188VG7dfJ/v1j
X-Received: by 2002:a05:6830:6a8c:b0:7d7:e59c:80e6 with SMTP id 46e09a7af769-7dc9513c4ccmr12918152a34.12.1776809271713;
        Tue, 21 Apr 2026 15:07:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9751a2f9sm12143977a34.12.2026.04.21.15.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 15:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 15:07:49 -0700
Message-Id: <DHZ6BHVW9CVO.1MNKDGSAXI76Z@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 7/9] bpf: Prepare verifier logs for upcoming
 kfunc stack arguments
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
 <20260421172002.3510514-1-yonghong.song@linux.dev>
In-Reply-To: <20260421172002.3510514-1-yonghong.song@linux.dev>

On Tue Apr 21, 2026 at 10:20 AM PDT, Yonghong Song wrote:
> This change prepares verifier log reporting for upcoming kfunc stack
> argument support.
>
> Today verifier log code mostly assumes that an argument can be described
> directly by a register number. That works for arguments passed in `R1`
> to `R5`, but it does not work once kfunc arguments can also be
> passed on the stack.
>
> Introduce an internal `argno` representation such that register-passed
> arguments keep using their real register numbers, while stack-passed
> arguments use an encoded value above a dedicated base.
> `reg_arg_name()` converts this representation into either `R%d` or
> `*(R11-off)` when emitting verifier logs. If a particular `argno`
> is corresponding to a stack argument, print `*(R11-off)`. Otherwise,
> print `R%d`. Here R11 presents the base of stack arguments.
>
> This keeps existing logs readable for register arguments and allows the
> same log sites to handle future stack arguments without open-coding
> special cases.
>
> Update selftests accordingly.
>
> Acked-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf_verifier.h                  |   1 +
>  kernel/bpf/verifier.c                         | 640 ++++++++++--------
>  .../testing/selftests/bpf/prog_tests/bpf_nf.c |  22 +-
>  .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
>  .../selftests/bpf/prog_tests/kfunc_call.c     |   2 +-
>  .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
>  .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  14 +-
>  .../selftests/bpf/progs/cpumask_failure.c     |  10 +-
>  .../testing/selftests/bpf/progs/dynptr_fail.c |  22 +-
>  .../selftests/bpf/progs/file_reader_fail.c    |   4 +-
>  tools/testing/selftests/bpf/progs/irq.c       |   4 +-
>  tools/testing/selftests/bpf/progs/iters.c     |   6 +-
>  .../selftests/bpf/progs/iters_state_safety.c  |  14 +-
>  .../selftests/bpf/progs/iters_testmod.c       |   4 +-
>  .../selftests/bpf/progs/iters_testmod_seq.c   |   4 +-
>  .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
>  .../selftests/bpf/progs/percpu_alloc_fail.c   |   4 +-
>  .../testing/selftests/bpf/progs/rbtree_fail.c |   6 +-
>  .../bpf/progs/refcounted_kptr_fail.c          |   2 +-
>  .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
>  .../selftests/bpf/progs/task_kfunc_failure.c  |  18 +-
>  .../selftests/bpf/progs/task_work_fail.c      |   6 +-
>  .../selftests/bpf/progs/test_bpf_nf_fail.c    |   8 +-
>  .../bpf/progs/test_kfunc_dynptr_param.c       |   2 +-
>  .../bpf/progs/test_kfunc_param_nullable.c     |   2 +-
>  .../selftests/bpf/progs/verifier_bits_iter.c  |   4 +-
>  .../bpf/progs/verifier_ref_tracking.c         |   6 +-
>  .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
>  .../testing/selftests/bpf/progs/wq_failures.c |   2 +-
>  tools/testing/selftests/bpf/verifier/calls.c  |  14 +-
>  30 files changed, 464 insertions(+), 375 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b148f816f25b..d5b4303315dd 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -913,6 +913,7 @@ struct bpf_verifier_env {
>  	 * e.g., in reg_type_str() to generate reg_type string
>  	 */
>  	char tmp_str_buf[TMP_STR_BUF_LEN];
> +	char tmp_arg_name[32];
>  	struct bpf_insn insn_buf[INSN_BUF_SIZE];
>  	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>  	struct bpf_scc_callchain callchain_buf;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 18ab92581452..82568a427211 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1742,6 +1742,44 @@ static struct bpf_verifier_state *push_stack(struc=
t bpf_verifier_env *env,
>  	return &elem->st;
>  }
> =20
> +#define STACK_ARGNO_BASE 100
> +
> +static bool is_stack_argno(int argno)
> +{
> +	return argno > STACK_ARGNO_BASE;
> +}
> +
> +/* arg starts at 1 */
> +static u32 make_argno(u32 arg)
> +{
> +	if (arg <=3D MAX_BPF_FUNC_REG_ARGS)
> +		return arg;
> +	return STACK_ARGNO_BASE + arg;
> +}

You can remove this and simplify everything further by

static bool is_stack_argno(int argno)
{
	return argno > MAX_BPF_FUNC_REG_ARGS;
}

> +
> +static u32 arg_from_argno(int argno)
> +{
> +	if (is_stack_argno(argno))
> +		return argno - STACK_ARGNO_BASE;
> +	return argno;
> +}

remove as well.

and a comment like:

/*
 * switch (argno) {
 * case 1: R1
 * case 5: R5
 * case 6: *(u64 *)(R11 +- 8)
 * case 7: *(u64 *)(R11 +- 16)
 */

> +static const char *reg_arg_name(struct bpf_verifier_env *env, int argno)
> +{
> +	char *buf =3D env->tmp_arg_name;
> +	int len =3D sizeof(env->tmp_arg_name);
> +	u32 arg;
> +
> +	if (!is_stack_argno(argno)) {
> +		snprintf(buf, len, "R%d", argno);
> +		return buf;
> +	}
> +
> +	arg =3D arg_from_argno(argno);

gone

> +	snprintf(buf, len, "*(R11-%u)", (arg - MAX_BPF_FUNC_REG_ARGS) * BPF_REG=
_SIZE);
> +	return buf;
> +}
