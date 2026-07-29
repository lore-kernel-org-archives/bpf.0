Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C71D2853F3
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306002; cv=none; b=QjNYG6hOOuXM9xjKZCZADfXIfpTTDRZ12opLEfFx1S5vO3prMtjhfqLI97CF5MheAQC9n092fIb3bIcz0nlhdlEZ7c4H1MZWT+XqqKcdr5OEHR+hTN7gtc830i80vuOM40a2WNphkAQ7JiOz1J+NdDb64qCDoKv+ygB+Oqs8/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306002; c=relaxed/simple;
	bh=O1mg0t6iuVQ3IJBCvlQsTmp7eEu7IdBq3d4IQADayf8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mCYWutvP1QowXUtJtidWnA3uPIrrV3cTRlaMXuayD+cil47l0tJgayL2lppksZXvJuUXnbC0KvQLEWuJh09tnSKnKElU7nEv4zXNI9WbEBByJYA0z1KedfaD5yeqeaniDf8hViifVNwOY1CRyRHUSSsHS5OtNX8tEA275l6ChUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4jkTHJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4jkTHJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3EC1F000E9;
	Wed, 29 Jul 2026 06:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785306001;
	bh=9U1shppFMUQsgbE/c5tFeUZ5Rqr9UBepihgfXV84mho=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K4jkTHJtp07k1cYkX9Tu/Z/umowR4AUXAo8PIvQYLQkduOdbsE5EZQNZViENeQukl
	 qt1gOiamYjVpNfETbjkpgkikXe/uiFMOFDtd/cICa5f+qIzNxSyJPrFDfrMaFC+S1+
	 lMxNFlh3Kv5KoeKB0/Vn1QQFACShUykzhC2V2OBzb24kiHEHnRRNimUawrr7Uiw6pO
	 Pz8PKRaQw3Pi03CzO6JOzwYLlhaorv5k725v2if1BpdPTXc72PeDPvlEJ36lp/+uwN
	 P2CpQwahy4ankXUwrzoTcIb/p8BuaICwW0/tLfaD9Zkxu0+WYXVtxw5ndoluxlqUlK
	 jVQi+wBswR7Xw==
Content-Type: multipart/mixed; boundary="===============6937139973021121379=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a3aa43df79440fa636555ad987478e6b8409e38fbed641c6557b11e2ba8636d9@mail.kernel.org>
In-Reply-To: <20260729050204.2586457-1-yonghong.song@linux.dev>
References: <20260729050204.2586457-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 2/3] bpf, x86: Fix trampoline stack size for 128-bit arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Jul 2026 06:20:00 +0000 (UTC)

--===============6937139973021121379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b2feec81e231..01e7ce569c1e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3369,11 +3369,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
>  		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
>
> -	/* extra registers for struct arguments */
> -	for (i = 0; i < m->nr_args; i++) {
> -		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> -			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
> -	}
> +	for (i = 0; i < m->nr_args; i++)
> +		nr_regs += (m->arg_size[i] + 7) / 8 - 1;
>
>  	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
>  	 * are passed through regs, the remains are through stack.

Does the Fixes: tag target the commit that introduced the bug described in
the commit message?

The changelog says save_args() overwrites adjacent stack slots because the
register save area is under-allocated. That mismatch requires the writer of
the save area to count 2 slots for a 16-byte argument while the accounting
loop counts 1.

In commit a9c5ad31fbdc (v6.1-era), both sides were symmetric and save_args()
did not exist yet. The save_regs() function in a9c5ad31fbdc used:

arch/x86/net/bpf_jit_comp.c, save_regs():
  if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
          nr_regs = (m->arg_size[i] + 7) / 8;
          arg_size = 8;
  } else {
          nr_regs = 1;
          arg_size = m->arg_size[i];
  }

arch_prepare_bpf_trampoline():
  if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
          extra_nregs += (m->arg_size[i] + 7) / 8 - 1;

Both used the same BTF_FMODEL_STRUCT_ARG condition, so a non-struct 16-byte
__int128 was accounted for 1 slot and written to 1 slot. No adjacent slot
was overwritten.

The asymmetry the changelog describes was introduced later, when save_regs()
was replaced by save_args()/restore_regs() that compute the slot count
unconditionally:

arch/x86/net/bpf_jit_comp.c (current):
  save_args():
      arg_regs = (m->arg_size[i] + 7) / 8;
  restore_regs():
      arg_regs = (m->arg_size[i] + 7) / 8;
  get_nr_used_regs():
      arg_regs = (m->arg_size[i] + 7) / 8;

versus the STRUCT_ARG-conditional accounting loop this patch deletes. The
commit that made save_args() unconditional is the one that created the
mismatch ('bpf, x86: allow function arguments up to 12 for TRACING', Menglong
Dong, v6.6-era).

The Fixes: tag points at a v6.1-era commit while the real culprit is
v6.6-era. On a v6.1-v6.5 tree this patch changes nr_regs for an __int128
from 1 to 2 while save_regs() still writes only 1 slot, which over-allocates
the save area rather than fixing anything.

---

Kumar Kartikeya Dwivedi raised a concern in v3 about a pahole BTF encoding
issue with the function bpf_testmod_test_int128_arg(__int128 a, int b, long c)
in tools/testing/selftests/bpf/test_kmods/bpf_testmod.c.

On x86-64, parameter 'a' consumes rdi:rsi, and 'b' ends up in rdx (not the
positionally-expected rsi). pahole maps the second parameter positionally to
rsi, sees 'b' in rdx, and skips BTF encoding for the function.

The comment in the code claiming that putting __int128 first prevents the
pahole issue is incorrect. Kumar suggested using bpf_testmod_test_int128_arg
(int b, long c, __int128 a) instead.

Is the pahole patch set 'Encode true signatures in kernel BTF' that you
mentioned in your response now merged? Without it, will this test fail in CI?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30424886481
--===============6937139973021121379==--
