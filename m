Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35B423147
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644177; cv=none; b=W6iDxO3kpO4ad15sT+5CZlU4xfir8c3GisoyAMlxfnHfMxHUCZUXWsW5yXb2HwCIXvrL3Xd6moQPsQH36ZRonQYd097msxNNnsZHxGMS118ZoQ9MbAoTc5glKM79rzt4oti1G4K6JIE7gU0/RMT8oGbe+lXyqnUeKJElgDOm7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644177; c=relaxed/simple;
	bh=B7QOcotNzB9z4ivT7LgSzQYaupEi8vJq3S5WGP0/2QM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GFAnGk8tL2TN1cNQTezzObcgXqV4Jby2Plqfr8LJtqQVY3EDPf0MFe+E6zpYphu5PAGWPqwFaOPtVhOWItWakW6wiwFw2/7C6+VP5txQYcgfieKL1JfhhpI73MTeJxqihayNo7UfdHgGBooXV2EyYuKHJKiptj4ES6rknj038w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8MMZATR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8MMZATR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035CA1F00893;
	Fri,  5 Jun 2026 07:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780644176;
	bh=Y8pAMHz4XB151z8VZQdh7otoNYNMmSs0CK905/fZ154=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=l8MMZATRqqi9d5D3ObqQVySwFw9cRCF83TAI7ilIAEWIBTXKgz3+LUmB09PAJgCXm
	 5IrhKglj0m/eyZf7LOcNE24OY0fP8CfLU/81sUJsd35kbkBMqO9EvEzqwNy3CwszGv
	 ZARwf33g+HITz5aH92UfZwZgQx4gnDCUsb0NYLrCCnGhBo6135QCmpkV8zeDVwcTiF
	 cLO1cmsxyoR2qAKp8RJuHr1J5yhImD81N4hF0YSutQxEmB8A/2GtDKsi23U8EfqrwQ
	 Dxh+6fbJAoV24Ye5+N6S6CvOoHCvoO49RgDCTspbnRy0obUpH+eF47SS99PL8V+l63
	 zJUc98r9v9pJw==
Content-Type: multipart/mixed; boundary="===============8112647437143842960=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <effe59abaf21bb114e5e0604a35051147f33a01370f88e280e53997bd9f7c525@mail.kernel.org>
In-Reply-To: <20260605063412.974640-11-memxor@gmail.com>
References: <20260605063412.974640-11-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 10/17] bpf: Report Resource Lifetime reference leaks
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 07:22:56 +0000 (UTC)

--===============8112647437143842960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c

[ ... ]

> @@ -11576,6 +11665,11 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
>  		if (!is_irq_flag_reg_valid_uninit(env, reg)) {
>  			verbose(env, "expected uninitialized irq flag as %s\n",
>  				reg_arg_name(env, argno));
> +				bpf_diag_report_resource_state(env, env->insn_idx,

This isn't a bug, but the indentation looks off here. The
bpf_diag_report_resource_state() call has an extra level of indentation
that doesn't match the verbose() call above it. This same issue appears
in both places where bpf_diag_report_resource_state() is added to this
function (at the save validation and restore validation).

Should these be adjusted to align with the verbose() calls?

Reference: https://lore.kernel.org/bpf/20260605064536.DE3F51F00893@smtp.kernel.org

> +							       "IRQ flag is already initialized",

[ ... ]

> @@ -11592,6 +11686,10 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
>  		if (err) {
>  			verbose(env, "expected an initialized irq flag as %s\n",
>  				reg_arg_name(env, argno));
> +				bpf_diag_report_resource_state(env, env->insn_idx,
> +							       "uninitialized IRQ flag restore",

Same indentation issue here.

> +							       "Restoring IRQ state requires a stack slot that was initialized by a matching IRQ save operation on this path.",
> +							       "Pass the same stack slot that was previously initialized by the matching IRQ save kfunc.");

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27000182395
--===============8112647437143842960==--
