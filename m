Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5392B2D7
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640162; cv=none; b=C7E5DuRr5UHWc7UM+l09uGOYt01D47Sf8SzCfoHnZxSRna0e+03frA3MGM790X7LhkKm33UV1IPQXspzDvOy+0OKHIIqahxzd3cA/0yHEZWunOErJ0MiTZ3Dc/w+erIydQgWpAKmQ3Qnv9PW1wORCIzGwZB2Xm0qU07KO6yin9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640162; c=relaxed/simple;
	bh=cJabYJVNfZ0ZS0Oi2Rhop0Hd0NPFgjYmOf2XHZfZGMc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BVN2OL7bpxT8S1cL8yVDjUhsdFPDJsjKYTo5fPAGyMl0RQjXOJpscqb1eu4kiuG1YCGMR8CXBKc/USn2wBaDFMyNSeyjfNiZwRhUNCBcd9qV/h3t/MA/ZzD9jqM5AuuR93//NUvI0An4vUK8jkWpVFUSyDAvY0uonWIA6v8DAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYYsZ7TF; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYYsZ7TF"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4a483a552efso998382b6e.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788640160; x=1789244960; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mJUmB88Htkd+dJYEbOc4LBcl8doiRK+vFL3oOlV3WTY=;
        b=VYYsZ7TFTRF2mMuA+I8uYSk96LIeoqKR1FNSM8BHPzRacn5QdvPsgwif1X1haQPajO
         +6SDfqZdDmWtUHckeS3/Rrss9Hd46opBmMv2y0fABmhEkqR3qyPyLzOYcJZXr9qNDmGJ
         wZZQmWXQXtNFe3+3gd8weIub/5gNTPgmT72W7yxjArPSzViMsJabbMzaiUEVhFWuTcE3
         IgFGZre5CEu8D5sMxFIpAjulCLLu1Ra8rr3PIuiPVma/MOfBoIndqrxVAa0MXR8zNLRE
         heTO6Ze61FdbIE44hA9TW8I8Uyxz73P3VzziyElwBI5DHBzehkpJyUKO3d3BwH7Gh2QF
         4kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788640160; x=1789244960;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mJUmB88Htkd+dJYEbOc4LBcl8doiRK+vFL3oOlV3WTY=;
        b=BqE23hBeppXdxr8qic85ryrK6nRtGEBJr/G21KSYa4XJXuTYUpozScNNxkSrRXq/DW
         CBkYEYvMnFfJTW0NOs49Li5YhmLYasdSHQSJAZMwWpXA87+2GyG3EzNrh/Sd8JX/6PZH
         UWUTh1QPetwnXK68oKJVEA4H2SlrPdFfdIhIt6uT+B0663nrE4oVLVkGIEg7SvcJaQ+J
         v9vvDlagSUNztmlg5vl0E3MeFq29mqzXgwbDr5vyry+FYq19bAVfJUMGktEQK1ymajoQ
         AT24c0A0isA+wXH87bP6uVr2qiUv+QxEuH370/B6s9YLgg0Uw1PnAz1tpuWLaPmSS6X2
         z+pA==
X-Forwarded-Encrypted: i=1; AKwUvBx8DR7IaYF1r8NVOqQPmK2zggGYk0py12+gCzUW2Wh2BAxFYLziviiR7MjxFS+4PV5WNRk=@vger.kernel.org
X-Gm-Message-State: AFuF++nIAgEyuZRzZry+IxEO2IL44/ouxu4Amv31k0pOqDv6vcbi7jT+
	0gvwVawjRQ2VxIWBplZH+UmvQXM9/lmA9YnnDDdPmoMtpnvWpqW5wiua
X-Gm-Gg: AYBFou2eotz9l22TvN77unpiBVUOmDshLkaRKOTq7AJdfKbQ63bErjJUbLtkG3nK68t
	HtRSCVquZppGMdltjvk7/uuVsAkqBbUhx4kS6Ugm43JOt5GQkvuUw2ta8HFq9Zvsw3x9flbudVq
	UkOCDML85Aj0vql+p/+5ezvch+9ziEm5/OP7fPO2ObaHUx4OQ4FzuUrikDtLM7gcjveIwxlwS6H
	l4Zk7ym5HARKJ8COFmnBwhU9IEG6ck8JqOF6oo75UlszBBbb/lhVMx06fQya57yhLeJdSbParrn
	Jfl88RN/oE7Q2YtG7cczqIu4Wg9muOQhx5Fe05QEXXtvgOH1US+KBZWV7jcqes6Z/DXvskHcqLM
	8FU/dj+G3ZROMM3e4c7RfBgVkRkOwpigOAo8K4ZnHnnE0qYPTA4Dz6oENcgWCxEkxLHajdsUjP4
	1n+fUoUOa/11iGkOnysoPTQ9LlTYzCK/fc2ZVrGabYkDHri4C5tsQm40pGTEq44wQlEb/d+V6bM
	psOcyY4JnAJ0mjtKM5IAmiz6B4jI5NcWF6H+7HTV/ENnI7xKdM20ok=
X-Received: by 2002:a05:6808:2223:b0:4bb:8403:64c0 with SMTP id 5614622812f47-4bb84038ce4mr2317991b6e.3.1788640160222;
        Sat, 05 Sep 2026 13:29:20 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b97124b081sm6492375b6e.9.2026.09.05.13.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 13:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 13:29:18 -0700
Message-Id: <DL7O0P1GKQUN.TNI3R5B2ZGBI@gmail.com>
Cc: "Nicholas Carlini" <npc@anthropic.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf v2 4/7] bpf: Reject fall-through across subprogram
 boundaries
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260905083418.3723623-1-memxor@gmail.com>
 <20260905083418.3723623-5-memxor@gmail.com>
In-Reply-To: <20260905083418.3723623-5-memxor@gmail.com>

On Sat Sep 5, 2026 at 1:34 AM PDT, Kumar Kartikeya Dwivedi wrote:
> check_subprogs() verifies that each subprogram ends in an exit or an
> unconditional jump, preventing control flow from falling through into
> the next subprogram. However, this check runs before CO-RE relocations
> are applied.
>
> When a relocation cannot be resolved, bpf_core_patch_insn() poisons its
> target by replacing it with an invalid BPF_CALL. A relocation targeting
> the terminal instruction of a non-final subprogram can therefore create
> a fall-through edge into the next subprogram after the invariant was
> checked.
>
> The per-subprogram DFS in bpf_compute_postorder() then visits the next
> subprogram twice and writes past its prog->len-sized postorder array.
> Stack liveness analysis relies on the same containment and can access its
> per-subprogram arrays out of bounds as well.
>
> Reject fall-through edges whose endpoints belong to different
> subprograms in push_insn(). This reestablishes the invariant on the final
> instruction stream at the common CFG edge insertion point. Cross-subprog
> pseudo-call edges remain valid because they are represented as branch
> edges.
>
> Fixes: efcda22aa541 ("bpf: compute instructions postorder per subprogram"=
)
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/cfg.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 842c7d1eabcc..e3c904328ede 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -102,6 +102,7 @@ enum {
>   */
>  static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
>  {
> +	struct bpf_subprog_info *subprog;
>  	int *insn_stack =3D env->cfg.insn_stack;
>  	int *insn_state =3D env->cfg.insn_state;
> =20
> @@ -121,6 +122,26 @@ static int push_insn(int t, int w, int e, struct bpf=
_verifier_env *env)
>  		return -EINVAL;
>  	}
> =20
> +	/*
> +	 * check_subprogs() prevents control flow from falling through a
> +	 * subprogram boundary, but runs before CO-RE relocations can rewrite a=
n
> +	 * instruction. Reestablish the invariant on the final instruction stre=
am
> +	 * before constructing the CFG used by later per-subprogram passes.
> +	 */
> +	if (e =3D=3D FALLTHROUGH) {
> +		subprog =3D bpf_find_containing_subprog(env, t);
> +		if (w < subprog->start || w >=3D (subprog + 1)->start) {
> +			verbose_linfo(env, t, "%d: ", t);
> +			verbose(env, "fall-through out of subprog from insn %d to %d\n", t, w=
);
> +			bpf_diag_program_structure(
> +				env, t, "fall-through leaves subprogram",
> +				"Keep fall-through control flow inside the current subprogram.",
> +				"Instruction %d falls through to instruction %d outside its subprogr=
am.",
> +				t, w);
> +			return -EINVAL;
> +		}
> +	}

I don't think it's the right fix.
Instead we should teach bpf_core_poison_insn() to poison only relocatable i=
nsns.
Those in bpf_core_patch_insn()'s switch() statement.

Otherwise we will have all sort of other issues with random insns being
converted into call insns by in-kernel CORE.

pw-bot: cr
