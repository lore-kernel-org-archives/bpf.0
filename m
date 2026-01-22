Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17F1F03D2
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040614; cv=pass; b=CWinBQlll6ZpLy+TvmgpioosGhSWj3BSiF2bW4tqKkYcO9bYyTTHXRx8YFEIc5cnJiMAhc1iqdPGzLBcduC81T4MZJ1ilVTpuUp/TTnV6BJZ4zyw6yBGEiiGkQo6ikrL3R5Z4i0vRYafBS4a3+FWh2kV+iEAuyvMApnfica7tLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040614; c=relaxed/simple;
	bh=E+w1se1yD98YbUFA0FefiqES/M2g51jDvmuw5rYoG0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUy3bjdy1pqR9YDdlIty9uCXoZgx4ilIxpuiawyAZL4UprcFDEpJR0ItVeqNKRCu0VDI77YidnWR58Frf8TZu+XOpWfIACdHoevJUDxoLA2Gqo/jEvzERpwvYcnXPo5UoUtXIjMZaiAEN9zgifVC9KXJYCUi3tW8PsG97w00otM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aE/PQNu4; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE/PQNu4"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c21417781so249497a91.3
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:10:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769040609; cv=none;
        d=google.com; s=arc-20240605;
        b=WM34QWyOTkFL1WliTTKrO61PZOOx4XAaSLCreKHI0Tf/J0kmNNDnJS911TaVCAlRGJ
         A6Ah+1hwavs8YxqwhT+3ynd1qrIbUGgwxo2imkvLoxBXqWuuXjoOJEU3jSPGQwFZMjFS
         8d5WumIbhlR+c8wuctqzlDUwhBCPBuDcO38X63aSxkfeH6+meVlO4Gs7bpO+vGAjQcs2
         YexFjA5k8L3JdmPce/rEcx9KjPM9DYrzQyyH8AEQfekoH03EgxVoI3Kbx2fQyMam+h4y
         Vxw7fnZmZHEV5EplFwmXomgxHLn0/33KDLH0D+AD7ub1dRdQeiH9Uq3dGNVDJNKg/nRA
         jQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5RdFdvYZ2+yT8ESpVs1g7QzLTQwBWAi4m9fXSa+H6iU=;
        fh=L09vzUziBxF0FRHbM8WnNG4DKlnPjJ+RWWEIlpGJBUo=;
        b=eVeE/oM8lE3vWOSCI6HyIKvAa/rg+owxv+Tw0l5OUxa886e5qT5M4X6wovnXm4qSeS
         2kBQxe5J0k1yscRIqzRmrHdqtbfbYL0iiuQ1laF57OGNIFcu0Nu9LxACzblwzxGEszNj
         9eGmpoliRqY5TI7mTZHlz8L/JaJVzvp5HzB7E9/cNQS+9FiGFZ60QpPfTaLbXUz2CogL
         ZNVQc/XEB6yW0hPdeerFTe7F0BF83j7VoyO27IDPPDtsTFo9i0b+UA53vMEUUZd72R5v
         brJnY45cN8kCT6g0A13cOB/3f5rZH9JjxoB9mp12+Avpr2bCfZdI6FaSVs+lQMjjKnDe
         i9tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040609; x=1769645409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RdFdvYZ2+yT8ESpVs1g7QzLTQwBWAi4m9fXSa+H6iU=;
        b=aE/PQNu4Szyxg6ar+5NYXSooXgj+xfmyWlbfu6Rc8v/eU8eSfwPk8dPH/fYb9D5Rwz
         +2DIenuTnkWS5mPp7AiVWfVkXRoQFTzXtbKsDURZGAf1s2CbIiZKPzLiK8FldV9ha44X
         1uNbtBJJaT22S9Giitok065IbQiSOurP8oahG/eFuEVU8BJq7DanhXUZ4yWv1sIdwdEH
         pC5SIn1uZqH67qRo42Hl0Bo4lW0SHEhYnt6BNvIGO2XAlQW8UPWKxtxRvWj2lah2RdDo
         2tok2qb1wnB3MqTRNVEDj4o+ndvW6tE8rQCwI8mkY6CO543k6xlTAEtMuIpDjzXryboM
         HGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040609; x=1769645409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RdFdvYZ2+yT8ESpVs1g7QzLTQwBWAi4m9fXSa+H6iU=;
        b=fLL811DZ4q/s44AlZmvYoPLy3FxhyYTMrQWNm3qNdhmNXRUenvR91aQk3kXiHri5Ux
         yohwLU/jv+hjpguMw6kxW0mvJlTEIbu04f4K96k6gq8IxJjFTx7wOX/mz+Hdcx5txFyq
         Z0vqxY2/+xLe8kL86gMzIK+fTZlgKa8SzsbrpBjtpZqvi4H/UL16uHvQP+OL1bM/U5Vk
         nCuJk3375j0FhDLtuIFFx1jouHtgnnrXmwGJbRgitHRN6KOa1/95d69ODH0KiX/FBQ3L
         ZX4kEye3Qlx3HyeDm+HdCCBA+g7KmRDYdQ9UFBwYTEfOdCscYWoEY8OAUg+sIyvsTHkr
         vNPA==
X-Forwarded-Encrypted: i=1; AJvYcCW2226FkIasdwkDOCh1AxP3HMd9D4ybLaikRhxI7xz2aaJF9YjI3a4YcuovhzfeQVIMKog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTi6XyIXG9Nwtug0juYWParGc8CM1poGvfZNb+L48j+frbc0B
	x65fq0Kfwq25f7trgI/CtHhUF6KZnYeMsnBGf3KdbZbLr+Jb/uwWCUvAYCwqkSzWlu/6kTXj9L2
	jNOzC4oh8zHoBLR2x9gCq7n1hhcHCpso=
X-Gm-Gg: AZuq6aJ4pWWuST1VIdf8S+GSq5rDsKLpM0oUWqoSNVT7/nV2aqVtQaDGbmPJXvP9GcF
	5KBxqySi5BunPNY1005XY+AXn0+vwGz5fOaqZsRMMNfdvz4LX27rL+FJl6s1znq4yKHYAGI+8Rj
	D2e6p/x96pVNbaMGuXs3XYGX9QNfbO/s9QOk5Bnx5oef4UNhyDam9vcw3x4mKvR+0InTrWIfMXO
	yRqXlEYa1iP2N+JKy9Mym47GeP9XXBh2lwEoYQkDi0SJm/Yk8x+8NTlyub9pi7gK4MG8zENGJWA
	pnVCCSrcIw8B2DI312c=
X-Received: by 2002:a17:90b:5603:b0:340:2a16:94be with SMTP id
 98e67ed59e1d1-35272ef6716mr14887681a91.4.1769040609143; Wed, 21 Jan 2026
 16:10:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Jan 2026 16:09:56 -0800
X-Gm-Features: AZwV_Qj9mePZlRoySqiHX-dtgkm6Br8m3zLXq-i1fsayrU3p7IsjbTJy6NgYzOI
Message-ID: <CAEf4BzZX+hDww=MvMrqx3h9uKdB+Sef8rVMxrvxcm+9jj7MUjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 00/12] bpf: fsession support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:23=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Hi, all.
>
> In this version, I followed Andrii's suggestions in v9, and did many
> adjustment.
>
> overall
> -------
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
>
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program.
>
> We allow the usage of bpf_get_func_ret() to get the return value in the
> fentry of the tracing session, as it will always get "0", which is safe
> enough and is OK.
>
> Session cookie is also supported with the kfunc bpf_session_cookie().
> In order to limit the stack usage, we limit the maximum number of cookies
> to 4.
>
> kfunc design
> ------------
> In order to keep consistency with existing kfunc, we don't introduce new
> kfunc for fsession. Instead, we reuse the existing kfunc
> bpf_session_cookie() and bpf_session_is_return().
>
> The prototype of bpf_session_cookie() and bpf_session_is_return() don't
> satisfy our needs, so we change their prototype by adding the argument
> "void *ctx" to them.
>
> We inline bpf_session_cookie() and bpf_session_is_return() for fsession
> in the verifier directly. Therefore, we don't need to introduce new
> functions for them.
>
> architecture
> ------------
> The fsession stuff is arch related, so the -EOPNOTSUPP will be returned i=
f
> it is not supported yet by the arch. In this series, we only support
> x86_64. And later, other arch will be implemented.
>
> Changes v9 -> v10:
> * 1st patch: some small adjustment, such as use switch in
>   bpf_prog_has_trampoline()
> * 2nd patch: some adjustment to the commit log and comment
> * 3rd patch:
>   - drop the declaration of bpf_session_is_return() and
>     bpf_session_cookie()
>   - use vmlinux.h instead of bpf_kfuncs.h in uprobe_multi_session.c,
>     kprobe_multi_session_cookie.c and uprobe_multi_session_cookie.c
> * 4th patch:
>   - some adjustment to the comment and commit log
>   - rename the prefix from BPF_TRAMP_M_ tp BPF_TRAMP_SHIFT_

This is minor nit, but I think BPF_TRAMP_IS_RETURN_SHIFT and
BPF_TRAMP_COOKIE_INDEX_SHIFT (note added INDEX, because that's what we
store, not the cookie itself) makes more sense naming-wise and is more
natural to read. Consider updating this.

>   - remove the definition of BPF_TRAMP_M_NR_ARGS
>   - check the program type in bpf_session_filter()
> * 5th patch: some adjustment to the commit log
> * 6th patch:
>   - add the "reg" to the function arguments of emit_store_stack_imm64()
>   - use the positive offset in emit_store_stack_imm64()
> * 7th patch:
>   - use "|" for func_meta instead of "+"
>   - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
>     computing it with "stack_size + 8"
>   - pass the "cookie_off" to invoke_bpf() instead of computing the curren=
t
>     cookie index with "func_meta"
> * 8th patch:
>   - split the modification to bpftool to a separate patch
> * v9: https://lore.kernel.org/bpf/20260110141115.537055-1-dongml2@chinate=
lecom.cn/
>

Overall this looks great, I was actually trying to apply and push it
despite those minor nits I left. But unfortunately there is some
conflict, so you'll have to rebase and resend. Hopefully just one last
time :)

> Changes v8 -> v9:
> * remove the definition of bpf_fsession_cookie and bpf_fsession_is_return
>   in the 4th and 5th patch
> * rename emit_st_r0_imm64() to emit_store_stack_imm64() in the 6th patch
> * v8: https://lore.kernel.org/bpf/20260108022450.88086-1-dongml2@chinatel=
ecom.cn/
>
> Changes v7 -> v8:
> * use the last byte of nr_args for bpf_get_func_arg_cnt() in the 2nd patc=
h
> * v7: https://lore.kernel.org/bpf/20260107064352.291069-1-dongml2@chinate=
lecom.cn/
>
> Changes v6 -> v7:
> * change the prototype of bpf_session_cookie() and bpf_session_is_return(=
),
>   and reuse them instead of introduce new kfunc for fsession.
> * v6: https://lore.kernel.org/bpf/20260104122814.183732-1-dongml2@chinate=
lecom.cn/
>
> Changes v5 -> v6:
> * No changes in this version, just a rebase to deal with conflicts.
> * v5: https://lore.kernel.org/bpf/20251224130735.201422-1-dongml2@chinate=
lecom.cn/
>
> Changes v4 -> v5:
> * use fsession terminology consistently in all patches
> * 1st patch:
>   - use more explicit way in __bpf_trampoline_link_prog()
> * 4th patch:
>   - remove "cookie_cnt" in struct bpf_trampoline
> * 6th patch:
>   - rename nr_regs to func_md
>   - define cookie_off in a new line
> * 7th patch:
>   - remove the handling of BPF_TRACE_SESSION in legacy fallback path for
>     BPF_RAW_TRACEPOINT_OPEN
> * v4: https://lore.kernel.org/bpf/20251217095445.218428-1-dongml2@chinate=
lecom.cn/
>
> Changes v3 -> v4:
> * instead of adding a new hlist to progs_hlist in trampoline, add the bpf
>   program to both the fentry hlist and the fexit hlist.
> * introduce the 2nd patch to reuse the nr_args field in the stack to
>   store all the information we need(except the session cookies).
> * limit the maximum number of cookies to 4.
> * remove the logic to skip fexit if the fentry return non-zero.
> * v3: https://lore.kernel.org/bpf/20251026030143.23807-1-dongml2@chinatel=
ecom.cn/
>
> Changes v2 -> v3:
> * squeeze some patches:
>   - the 2 patches for the kfunc bpf_tracing_is_exit() and
>     bpf_fsession_cookie() are merged into the second patch.
>   - the testcases for fsession are also squeezed.
> * fix the CI error by move the testcase for bpf_get_func_ip to
>   fsession_test.c
> * v2: https://lore.kernel.org/bpf/20251022080159.553805-1-dongml2@chinate=
lecom.cn/
>
> Changes v1 -> v2:
> * session cookie support.
>   In this version, session cookie is implemented, and the kfunc
>   bpf_fsession_cookie() is added.
> * restructure the layout of the stack.
>   In this version, the session stuff that stored in the stack is changed,
>   and we locate them after the return value to not break
>   bpf_get_func_ip().
> * testcase enhancement.
>   Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
>   the testcase for get_func_ip and session cookie is added too.
> * v1: https://lore.kernel.org/bpf/20251018142124.783206-1-dongml2@chinate=
lecom.cn/
>
> Menglong Dong (12):
>   bpf: add fsession support
>   bpf: use the least significant byte for the nr_args in trampoline
>   bpf: change prototype of bpf_session_{cookie,is_return}
>   bpf: support fsession for bpf_session_is_return
>   bpf: support fsession for bpf_session_cookie
>   bpf,x86: introduce emit_store_stack_imm64() for trampoline
>   bpf,x86: add fsession support for x86_64
>   libbpf: add fsession support
>   bpftool: add fsession support
>   selftests/bpf: add testcases for fsession
>   selftests/bpf: add testcases for fsession cookie
>   selftests/bpf: test fsession mixed with fentry and fexit
>
>  arch/x86/net/bpf_jit_comp.c                   |  71 +++++--
>  include/linux/bpf.h                           |  36 ++++
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/btf.c                              |   2 +
>  kernel/bpf/syscall.c                          |  18 +-
>  kernel/bpf/trampoline.c                       |  53 +++++-
>  kernel/bpf/verifier.c                         |  86 +++++++--
>  kernel/trace/bpf_trace.c                      |  49 +++--
>  net/bpf/test_run.c                            |   1 +
>  net/core/bpf_sk_storage.c                     |   1 +
>  tools/bpf/bpftool/common.c                    |   1 +
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/lib/bpf/bpf.c                           |   1 +
>  tools/lib/bpf/libbpf.c                        |   3 +
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |   3 -
>  .../selftests/bpf/prog_tests/fsession_test.c  |  90 +++++++++
>  .../bpf/prog_tests/tracing_failure.c          |   2 +-
>  .../selftests/bpf/progs/fsession_test.c       | 179 ++++++++++++++++++
>  .../bpf/progs/kprobe_multi_session_cookie.c   |  15 +-
>  .../bpf/progs/uprobe_multi_session.c          |   7 +-
>  .../bpf/progs/uprobe_multi_session_cookie.c   |  15 +-
>  .../progs/uprobe_multi_session_recursive.c    |  11 +-
>  22 files changed, 550 insertions(+), 96 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.=
c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
>
> --
> 2.52.0
>
