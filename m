Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111939D6E7
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471030; cv=none; b=pvkpDzNv7E5+9Wwc7PzcOi9l2eQ5C6FLyODNvykg/cBZa0ZJBdQSQYfYNuTWsG0lOXi5RpMvI+6mIGWjCgRbOxUE9UR514ykHeSG0L0cE/DRE7ty3ILKnQFeiGDgrxuTpoWByDOVl/cqx3tGE1Ne5MEc4hI0cq20hlYXdzXKmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471030; c=relaxed/simple;
	bh=o4CM9jidaRxABIiphg7sxo3HEhfjJVDYZrP+FZfzMnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdDwhaRV+6UPl9XlOKIyxifFmEDx9mrw+SNN5rna7/6gEavsC0FImCJo1JUhgA9icUqpp6rJGQMiJpc6PUEDeZS/nN7Za9ulWUFOsqG9UzBGksPViTiDUAbf/S0DfxcKQqCAo+qBTPHvCvKLWseqD29EWnyTQlHNCJ/dOQvP+Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAYInVB4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAYInVB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026DA1F00898
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 07:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780471029;
	bh=B9gE9LR8WZKp5FJX5lQdc0Rrvfx5JZgnmoXVQiOoRCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PAYInVB46E2dDqjJ29B2BFLzz9Gn67N2C6rxnXCE4mCy5tzp43H/Subkl0sjKINMa
	 Z94fNReCDxYcbFCWvtkj/+jeMebrXXCBJya3kkPi16BQ9xIhCXYfPb8IuBG401Gcd+
	 RdkT4/Tbmh2/H+EhCzm1nM1HLi59Jk8zzgMdciWKfI777EfwMb8VKfus3qctWQvOlj
	 iIvHpLBpS6Y8VP9YXxCxVV4eH7YLtSjqOisRCdHdHPHe6ecKsC0itUSrT4XKqRG7vO
	 Xlv2QxD3TKfoqK3zVOSRa7RC7xqXoYR6noYXtaoPf48InL7n+GmDyChtYCR8hx51Xe
	 45d0bZammIeVQ==
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5176b9c476aso12425021cf.3
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 00:17:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YxJGmlcmAD96XiH33CG9UVpnM7LYVaBfM23ZATWEVz/4YnAcWDJ
	xSJZNbp1ysyWD8mrRTmTctvoU/gzGWCTsAFCEa4sLEZAVhtZg/5+mmh82Oq3LAGaS/CC/zVhPAT
	6wDMCf4qxcwRolCbaZc8wGVvX9QDGgFY=
X-Received: by 2002:a05:622a:5c14:b0:517:29b1:5433 with SMTP id
 d75a77b69052e-51778635927mr34758491cf.24.1780471028254; Wed, 03 Jun 2026
 00:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602205847.102825-1-varunrmallya@gmail.com> <20260602205847.102825-3-varunrmallya@gmail.com>
In-Reply-To: <20260602205847.102825-3-varunrmallya@gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Wed, 3 Jun 2026 09:16:56 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNgWvufshCz2CwTeJ=NyjGKVhCrkTLz_v0g+34K=5MEC1A@mail.gmail.com>
X-Gm-Features: AVHnY4JoiPpI56R-HIsCyr_W1-sI4CUWK3ue5cXpYoYT5evyAosvlghYOrHtCUw
Message-ID: <CAJ+HfNgWvufshCz2CwTeJ=NyjGKVhCrkTLz_v0g+34K=5MEC1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf, riscv: inline bpf_get_current_task()
 and bpf_get_current_task_btf()
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	puranjay@kernel.org, menglong8.dong@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	pulehui@huawei.com, alex@ghiti.fr, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jun 2026 at 22:59, Varun R Mallya <varunrmallya@gmail.com> wrote:
>
> On RISC-V, the current task pointer is stored in the thread pointer
> register (tp). Emit a single `mv a5, tp` instead of a full helper
> call for BPF_FUNC_get_current_task and BPF_FUNC_get_current_task_btf.
>
> Register bpf_jit_inlines_helper_call() entries for both helpers so the
> verifier treats them as inlined, and add the expected `mv a5, tp`
> annotation to the riscv64 selftests.
>
> The following show changes before and after this patch.
>
> Before patch:
>
>       auipc  t1,0x817a    # load upper PC-relative address
>       jalr   -2004(t1)    # call bpf_get_current_task helper
>       mv     a5,a0        # move return value to BPF_REG_0
>
> After patch:
>
>       mv     a5,tp        # directly: a5 =3D current (tp =3D thread point=
er)
>
> Benchmark (bpf_prog_test_run wrapping bpf_get_current_task in loop,
> batch=3D100, 10s, QEMU RISC-V):
>
>               | runs/sec  | helper-calls/sec | ns/call
>  -------------+-----------+------------------+---------
>  Before patch |   173,490 |       17,349,090 |      57
>  After patch  |   320,497 |       32,049,780 |      31
>  -------------+-----------+------------------+---------
>  Improvement  |   +84.7%  |          +84.7%  |  -45.6%
>
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
