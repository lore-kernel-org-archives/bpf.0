Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0740A921
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786778455; cv=none; b=dIOZLbCoINbYmpdeEFY9jpIHhIyfJ1inU7hxeKMXbamQZPk8u5j/YcEwrqAzaiTCwpDxQNXYi1BNwbqH3m0XgzeKeiyZ90tEdvqSoLuACOmMgZAQeo/6Y4GNzAEm0czL2kinzEHP+DKya1S0MgxJhdk9bWNBVVZU9qx/ZEdb4ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786778455; c=relaxed/simple;
	bh=l9qWm+kxYqtOfQk6SGtIgnkmxK7vPLh+Zk8I+g9GTzI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=M1wEG9pd0q2p4zHOxl6Y65AQLco3OcAHeM2ibiupC/kXOgva53BTS2y7lHyGRetOCNMyQz+JZOHG3QgskKGXUlHoMVbp8eduUxX1tVDKAdNqmfVmjINqRF3L5IfJ5eIRi/WB8zrSzEq1/0ROCZ4Bm83NiQ+pE1gEC+FwSHGe70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+U5wNup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+U5wNup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083781F00A3A;
	Sat, 15 Aug 2026 07:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786778454;
	bh=p64SWVC2uPxW+KZf48cwPN827mD6b67GSU6/YPDCRe8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=I+U5wNupnP+3pSk7lR15D/+7uy3sJruZYFAnPKyuCQghV3JMVuf4oWVWa9w/0LcjK
	 I1Oep7jIqIioS+LV0EtOLgIsLbGfCKwMxwItUf6Fjm9u872I5ONQvcSiTb+0Yh1Csy
	 tajH2YwsYSMTqwjuSQjaPPD5wB3IwnqpWmmcbHIVi5RnsXjCGr+YxuG/R8YWTLk5q3
	 SJiQmfN063zskpe5IRDOIVnXmjQ65cXSMOlBDdius0yDDK4qGwGnRS1gYr5B/ak9MB
	 4CAub1AI3ke1mnt+SbwzrZ+TPH4hQR1ajNWFIiNR08n0Dj+KH1dBKhRwLHCgRDq3FT
	 qnUyW4h0pGUBg==
Content-Type: multipart/mixed; boundary="===============3578984002509481183=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d02e6a6d3b2dc43a207b8ba836ce62497b250dede9252e7409c5212201c794b7@mail.kernel.org>
In-Reply-To: <20260815064612.378577-15-memxor@gmail.com>
References: <20260815064612.378577-15-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 14/14] bpf: Report Policy helper and kfunc errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 07:20:53 +0000 (UTC)

--===============3578984002509481183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 64c5c31ed230..ff028a8c1cca 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2924,6 +2924,10 @@ static int add_subprogs(struct bpf_verifier_env *env)
>
>  		if (!env->bpf_capable) {
>  			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
> +			bpf_diag_policy(
> +				env, i, "BPF-to-BPF function call",
> +				"loading or calling other BPF functions requires CAP_BPF or CAP_SYS_ADMIN",
> +				"Load this program with the required capability, or avoid BPF-to-BPF function calls in unprivileged programs.");
>  			return -EPERM;
>  		}

Does the operation string here accurately describe both cases? This
branch can fire for two types of instructions. The loop filter above
checks:

    if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
            continue;

So it matches both actual BPF-to-BPF calls (bpf_pseudo_call) and
ld_imm64 instructions that load a subprogram address for later use as
a callback argument (bpf_pseudo_func).

The pre-existing verbose() message handles this correctly: "loading/
calling other bpf or kernel functions". The new policy report's reason
string also handles it: "loading or calling other BPF functions
requires...". But the operation string hardcodes "BPF-to-BPF function
call", which is only accurate for one of the two cases.

An unprivileged program containing a bpf_loop() callback but no actual
bpf2bpf calls would get a report whose source annotation points at an
`rX = <subprog>` ld_imm64 (which print_bpf_insn() renders as an
assignment) while stating "policy check failed for BPF-to-BPF function
call" and suggesting the user "avoid BPF-to-BPF function calls" that
don't exist in the program.

Would a conditional string based on bpf_pseudo_func(insn) vs
bpf_pseudo_call(insn) be more accurate here, or perhaps wording that
covers both cases like the verbose() message does?

The add_kfuncs() change at 2980 doesn't have this issue since its loop
filter checks only bpf_pseudo_kfunc_call(), so "kernel function call"
is always accurate there.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31870608176
--===============3578984002509481183==--
