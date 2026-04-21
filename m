Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8193D76
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729789; cv=none; b=XRC4Yanb9Sovwy6Zrux2JFN98gnDXJ4C5rsT2oaEHJU37A1d+OoU0R1xmJ9GKLbLrwZ8/AhaaGtdvmZ/PxAPGiaV9n97HMv5Mm3Aaynz8qnpeP7GHVk3nW4E/Ik5edy/J5INdzHZ/DRRgVq6vBw5q9+6Fixu868VN7j0vozXsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729789; c=relaxed/simple;
	bh=OyVP1THzYWFVo5IeeG6pJe4rpxexdGxGY2H/eJc5FpA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gylJ8JZwaokoiHiIcFdoBbTYae1kriwWCXy8GeAaMOY9eZXrGNj0517uTMXTjFWJBU8QqoMBIqQ/v6sLViHo1q6Yd+aFl+hV7jRuh7Y3gviYF91iqiKy94I45bKMVbwe8kmJ9jdb4irIbj/wyZ0olhQ/+EfTrpngnHwQpKyqUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ1lirtx; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ1lirtx"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479d68a9063so444271b6e.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 17:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776729787; x=1777334587; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pckPPRgAY5cEqKLEKV0z4TQjGbG5LsWCCCPdEUEtetc=;
        b=fZ1lirtx6DcgJcCTjVr6D67nIfq/SjC9oHf4w6/FMtxiDTD55Usx95Tq8bFY8mFLaZ
         km1ufzQBm/4eA1x4Z6+MGbddh1dKt+lZXRBTG4creLDLXnGG4dOiL/FCd002ABWgcipz
         uM048xq9aKsXBe5NoN0QM+0yza2lTSf7/rKvdL1W2MyOFGh0K4W7koNxwTcli0LDCD9q
         H1WOhe0t4Fuc1surHuJVWxt9Zbr68AEHUGbvF5Gvr+ID6ztOqhQ0E23nVPNzZXu7xqfH
         SREK398uPswVLlkv4fhXfbjik2dtZHNO9B+8YLYPdk8B9Sm8MuWlbpnHXJ1YOYh4FgaZ
         NvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776729787; x=1777334587;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pckPPRgAY5cEqKLEKV0z4TQjGbG5LsWCCCPdEUEtetc=;
        b=XL4j/Kv9qVX9kp3dmbLvMzpQKOMK3+NQPZ1bqMf3aQzc5OULPZmCyKDd+qYDU7lO8L
         eNUbjjsAlt0n8ZOp3Avy4WGwLEz7S+etG8S7aKVifIEkMldhOAJSJtt+41vJj6SAU0J1
         tK0kqZg5EBoB3a3TnCpM5VhYOybkqRn4ueSrdmfFDcgmfg4ZXeSYyWHbxHb10oVGaGP3
         PIpvtmavPmHtc48zu3HxOyaJa7L/iviMWuIzeI62GHMubeWgtXrLrFE8HxSItXfXvDIH
         JEizANZ0lerbwsnTHzOeNv5z89IDJgipRyJ9iUoe3Q8omNrea61Mowp2Fnrucu9+W01T
         ALhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DgxivAcYmSCeyPNeDFHxnwfOr+Bd2zO9ZcUJhNh2zKYjLjz8Tf7A2Pn8WTTWuy/Yp6to=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqYY8YB+jAWpc1Ydtw5Hlz0z7oxeKpHpx354E4gSEgPHStD7q+
	3mLNC/gqEiXr68+LNJS1b9oHXQ5HUQ5w1C1zv3ldWcY7nsny0TqAi2iW
X-Gm-Gg: AeBDievtRQlT5vvwqkVwmHa3vzW2JQtss9p3lS6zgWu/THUNP/WneL7clMLQnENWxKZ
	BTIcE9ZlgVGgIqNnI8lQucl9QFSTnau+x1zmSVngB4JpPdZ+PQjNPBNMrYWg86AcdcNrrPopM1m
	omFaY917/6zPiNfVZbcpvkH6speNW4QBAQGkH2VgA/7FGAZcWsxxrx4NmqUwuEytRZn39GtNL1J
	Cdi11pkMcx+UZS3OjeeRouYlESnS7H5nNvQ8yEupgEEoOu2UyIDWGmBJ06vaWU1/A2sa7Y1YH0L
	s5IQ63ONvQyHuDnIjyEreO95wkdOx1tKcWh5u+Fdy+RcGuIb9W4Cc5cTi3DMiOePVDR+YBLXbpO
	1eeP1qEDAdGvsw+usWNgTpnZ1QBbS+Rmzub1NMjZO1jrO+ufhg7pulKB1/AiIirXbZMt6gTA5KH
	vYPD6MgDAnHjMeCPQBFLwNxGObDRbQ/XM3B40gDD+Oyrjw7buwua3eArkps+V0X5k8PJWGj9P7Q
	OETnuO31DZUBv5oVQkp909csA7y
X-Received: by 2002:a05:6808:6f8f:b0:44d:bcb0:1409 with SMTP id 5614622812f47-4799ca08539mr7694904b6e.22.1776729786687;
        Mon, 20 Apr 2026 17:03:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799feaa131sm7818107b6e.3.2026.04.20.17.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 17:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 17:03:04 -0700
Message-Id: <DHYE574ZW4D7.2RNZPHN9QHT8@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v6 04/17] bpf: Prepare verifier logs for
 upcoming kfunc stack arguments
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <20260419163336.733654-1-yonghong.song@linux.dev>
In-Reply-To: <20260419163336.733654-1-yonghong.song@linux.dev>

On Sun Apr 19, 2026 at 9:33 AM PDT, Yonghong Song wrote:
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
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf_verifier.h                  |   1 +
>  kernel/bpf/verifier.c                         | 649 ++++++++++--------
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
>  30 files changed, 474 insertions(+), 374 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b148f816f25b..9fbbddc40d21 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -913,6 +913,7 @@ struct bpf_verifier_env {
>  	 * e.g., in reg_type_str() to generate reg_type string
>  	 */
>  	char tmp_str_buf[TMP_STR_BUF_LEN];
> +	char tmp_reg_arg_name_buf[32];

the name is too long.
Just tmp_arg_name ?

>  	struct bpf_insn insn_buf[INSN_BUF_SIZE];
>  	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>  	struct bpf_scc_callchain callchain_buf;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3716d9688d00..6aa4dc161a56 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1751,6 +1751,55 @@ static struct bpf_verifier_state *push_stack(struc=
t bpf_verifier_env *env,
>  	return &elem->st;
>  }
> =20
> +/*
> + * Unified argument number encoding for verifier log messages.
> + * Register args (arg_idx 0-4) use their register number (R1-R5).
> + * Stack args (arg_idx 5+) are encoded as STACK_ARGNO_BASE + arg_idx
> + * to avoid collision with register numbers. reg_arg_name() decodes
> + * this back to a human-readable string like "*(R11-8)" for logs.
> + */
> +#define STACK_ARGNO_BASE 100
> +
> +static bool is_stack_argno(int argno)
> +{
> +	return argno >=3D STACK_ARGNO_BASE;
> +}
> +
> +static u32 make_argno(u32 arg_idx)
> +{
> +	if (arg_idx < MAX_BPF_FUNC_REG_ARGS)
> +		return BPF_REG_1 + arg_idx;
> +	return STACK_ARGNO_BASE + arg_idx;
> +}
> +
> +static u32 arg_idx_from_argno(int argno)
> +{
> +	if (is_stack_argno(argno))
> +		return argno - STACK_ARGNO_BASE;
> +	return argno - BPF_REG_1;
> +}
> +
> +static int next_argno(int argno)
> +{
> +	return make_argno(arg_idx_from_argno(argno) + 1);
> +}

I don't like this +1, -1 dance all around. Makes the whole thing
hard to follow.
Keep argno starting at 1. So old regno =3D=3D argno.

>  		/* Check if local kptr in src arg matches kptr in dst arg */
> -		if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && regno =3D=3D BPF_REG_2)=
 {
> -			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
> +		if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg &&
> +		    !is_stack_argno(argno) && argno =3D=3D BPF_REG_2) {
> +			if (map_kptr_match_type(env, meta->kptr_field, reg, argno))

And then this argno =3D=3D BPF_REG_2 will look fine.
With argno base 0 the above looks broken.
Also is_stack_argno() looks like defensive programming. remove it.

