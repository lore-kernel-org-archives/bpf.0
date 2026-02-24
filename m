Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45ED54758
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956598; cv=pass; b=VNMX3zeelVc5zAT3CSUTD2dUwVrBWySCGrzzkNo3VIfVQg+NMH9+ppJPHQKOGRLoXcwr2fHrmpq2O0vxXiSks811Zrw26NBhJI3N9dT3avdpk5/duOrWenSc4IeHACHGOqa9yM+aEQM5Hyk5kDNECY1dB8SNbpaGZG9b5im8zIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956598; c=relaxed/simple;
	bh=yOUAlQdecOXwqwuQLKYarY4cF8GxvyJ5zAvCeXDrct4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUAPNvRh6RUrnwNK07wis4AFYXWj+sJtR6WoJD8+PQ/ND2q6hKHX1WXKWWyaoFrsBuNlx5smt2JMwBv4BccICHtaX/6ZZRiIoFQMA+ChsrVdIEOhzzocCvNnZL+jwBL/q3ZSTniPUsp8lVM+f3f5h+C4wnmmS+qyeN+nrBBSjDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isnQPH8Y; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isnQPH8Y"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64c31ca77b4so5265748d50.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 10:09:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771956596; cv=none;
        d=google.com; s=arc-20240605;
        b=FmTgWAegKlalMa3U3fHi0UMfiftuYKBDdpHNO5KtCK5Pumj3pqPYaYto9qJmulvwSh
         ALlqXUXTuu5Etz/Fwg0/4qbVuKNX54+Jypqhz2nwYdX8/0WRmKDVL91ykWRDIZmCGO37
         8grO84oi8l6MgrBZN4NhO2x/OOu/LkSnvQ8XOiH3z0upLHTpdH6L8EVRJqpTYLtYsp88
         RkkawLQS1k4YAQ2UGPilq99AC9/NkQntxd6v29nBtL8a3WOahBdeHx+OgaBtv5rLyFms
         OxpMwPhcO9a5ipvXYrZBg+KdgWO/eeexFYMZsDoz8u84MxsQ0Qz7kAPWp8ND6NAUaFW0
         HiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UlE7fs0GltsN511MjiIWQOzjiD2GXI1YY/nWZb9NCu0=;
        fh=SX+B7nJgDQkNE7HRslrjgofYVgsAGRVl4p1vRCTRjjg=;
        b=Jgme53GjlClD9XMIjmakQ+lJB8FpzJCAcbQqdeupuAOhHPKiw6hLKOO7O6eZtlo7Gf
         VVd3xjwT3Dw/hHmj0zgNL3K9IJRKtdrvfLRyrbSBqCFEfPPMwmXiOQp2Mk+IBwm+og7w
         V8gv2fB+VneTmb61cQITD9rgC3w69OyCnxlmfpigeAJPY8fqPTIbuVf/JEjkDTzFrcSU
         W59q2BAUqQSZ7TKSl7gk86sG6jDy0qO8seg2MFNjyYQUzv0vPbWYdIRnFtyIZL1FOHOh
         mHMIzLBIFqAxvQNas/zHEdJ6mWceGnhOvfdIXtX0252FYc0jsq0089mvfS7ZoxEztl/r
         RBBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771956596; x=1772561396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlE7fs0GltsN511MjiIWQOzjiD2GXI1YY/nWZb9NCu0=;
        b=isnQPH8YIpNYR5tCqGIsKqKSAqwZIRL6UpVDGXy/zKVvKhv6Jubi+Ym5nLIe1Uetdv
         vJStCxKpieDEKbDv4QuWHNh81T5eraqU3a+bjDBzi+YsR+pC9j5Zxv/0SDk8fqNJtS9G
         V0YdfzV8eOlwk9OGlHhnvjP1tktnOtmF2ELXOPcDtV3bv0Mi0FpJDNmGhphKr+b1Bdkp
         tQAbpxLJQBb7GLhse4k/doca2LXoUo4RzjQxJj1iLB9atleu+VZJs/ugC4un3iqJ+NxC
         53/z3FVlOvlR34E56uw2WmlsbWwsQXsJzLHuurrOh6qWTRsMEUXjDMZ1aRSmlg9pB6Hm
         3l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771956596; x=1772561396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UlE7fs0GltsN511MjiIWQOzjiD2GXI1YY/nWZb9NCu0=;
        b=nMbr/ry04B5j3f65kLWa/eaNmLY3ePUa0E3J/K/J6sI3TLd+QNUndwzcwAGV85Y81/
         pnRa/H6cy1lScMPVJhoWsfaixsJu43NCl7eIg3QhIMF7O8gCxQOHPtGYXkMdt7nVqDzk
         vOe0cJtQgR9Wzi93qizvz+Ey4FyWcnInTPSs8grRB0fuTjMA3QSm92/qayCFb+PKWEBt
         HcIqCZ9xVtorYm0UW6b49p6MJyyIzu7b+vtwIdYb74UcLdfPY1j+oDaZErVK0PcW9qYs
         5/Hd+imePUnCWi4R32J+UWUEm8mceRKBAQd9d5rEF25TyWpTq+TRumv+g3EFC/zfCqmI
         klZA==
X-Forwarded-Encrypted: i=1; AJvYcCWg2bW8I55+3wsKV4x4jdKs7vZXlUn7rduUQOvZRV9yzw0bb2wgpDzDuvZfLHMnD6sgesc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2soaeDNBEupK5/NYAnXXR52Pm6wLRxQeUJ8sYyZjWbKFdU/6
	0cUPiDPQc9+dN+WozOH1fuLf4qOfmeyWnNS5GmFrpTsHlKefAhjs0t0MZ2DJnIEIGGwgl8gqvzw
	dxC8iN4IxwINoesamaT+W+bNE/ElyJCo=
X-Gm-Gg: ATEYQzwqd+TJ4YD8A2o93l8YuJnaT73Mub4CfxNSm86Arv7lMs5Ly5dZZCWcawykWph
	E9B2FblwMx1HQAE6w2o4975aBDVUKHxRokuyaLfjez6podg48YDmCYoAb89zJg03Zpo5i+D/4Aq
	J5Z8jg7fT9/G3YXcEcJaKfHalZ8S0jNhejb5g1nLZo+gkwC1XTF5KQepDgzJYpQ8JPv7xxh848v
	O70Dvm+sCW8VApsrfqKQgqmIavDDop0OQvFnxQECx1x1Wj3X+oiBA9xVwec+Tb1j+93T3aA8/nA
	YtnvKMw=
X-Received: by 2002:a53:ac8a:0:b0:64c:99d7:8d1e with SMTP id
 956f58d0204a3-64c99d7b4c2mr3800678d50.3.1771956595826; Tue, 24 Feb 2026
 10:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224015855.1481707-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260224015855.1481707-1-ihor.solodrai@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 24 Feb 2026 10:09:43 -0800
X-Gm-Features: AaiRm50LRoerYwjYiCL0nDNYwJlYMVx42WomfHN20FpttQ1PoqZleEWazCaW7-U
Message-ID: <CAMB2axP9pZMtUcQH_bV9HWE145BseUpk9K5VfYhjYRa9gkTwsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix flakiness of task_local_storage/sys_enter_exit
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 5:59=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> The test_sys_enter_exit test was setting target_pid before attaching
> the BPF programs, which causes syscalls made during the attach phase
> to be counted. This is flaky because, apparently, there is no
> guarantee that both on_enter and on_exit will trigger during the
> attachment.
>
> Move the target_pid assignment to after task_local_storage__attach()
> so that only explicit sys_gettid() calls are counted.
>
> Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
> Closes: https://github.com/kernel-patches/vmtest/issues/448
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> ---
>
> I've been experimenting with running AI on BPF CI to investigate test
> failures. This is an example of a thing it may come up with.
>
> I don't want to spam the list with these, so for starters I'll be
> relaying only patches that I evaluated and/or tested.
>
> The AI generated reports will be posted with "[bpf-ci-bot]" prefix
> here: https://github.com/kernel-patches/vmtest/issues
>
> The goal of this particular application of AI is to make BPF CI more
> stable, less noisy/flaky, and potentially find and fix more kernel
> bugs. We'll see how it goes.
>
> ---
>  .../selftests/bpf/prog_tests/task_local_storage.c  | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c =
b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> index 7bee33797c71..2820a604aaa6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> @@ -25,24 +25,28 @@
>  static void test_sys_enter_exit(void)
>  {
>         struct task_local_storage *skel;
> +       pid_t pid =3D sys_gettid();
>         int err;
>
>         skel =3D task_local_storage__open_and_load();
>         if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>                 return;
>
> -       skel->bss->target_pid =3D sys_gettid();
> -
>         err =3D task_local_storage__attach(skel);
>         if (!ASSERT_OK(err, "skel_attach"))
>                 goto out;
>
> +       /* Set target_pid after attach so that syscalls made during
> +        * attach are not counted.
> +        */
> +       skel->bss->target_pid =3D pid;
> +
>         sys_gettid();
>         sys_gettid();
>

The test is done at this point and perhaps we should also add
skel->bss->target_pid =3D 0 to avoid some global variables from being
changed by bpf programs again. This is already done in
prog_tests/cgrp_local_storage.c. Not solving interference from
parallel subtests, but at least it will be easier to reason about the
test result.

> -       /* 3x syscalls: 1x attach and 2x gettid */
> -       ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
> -       ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
> +       /* 2x gettid syscalls */
> +       ASSERT_EQ(skel->bss->enter_cnt, 2, "enter_cnt");
> +       ASSERT_EQ(skel->bss->exit_cnt, 2, "exit_cnt");
>         ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
>  out:
>         task_local_storage__destroy(skel);
> --
> 2.53.0
>
