Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9D25B0BE
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779826667; cv=none; b=QocGxT5okbh+rl72uQM3EhGbVuFnp+Hbz5gyw/AQohfQkUb4QTpHjoKFhrLxNaaTP8hu8hCCjcpmCeUUF1045LFfoqJC8OI86yXyRIYQhQHvZ9htokl+9GY5p1JkctK1TL+PYVm1bUAvG+9N6nUtCcsLX3mULzgJVqiIj3nXN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779826667; c=relaxed/simple;
	bh=DGsdWwpgLr8ZHtiSFZ4l0Djg1Nd8uEJI1nPD8hkRunE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OpJrTkOPhY6sHHbfMzbCjjrQ5WGRos/E1ezB7m7qKJ2G3RX1xQg3R4B8OZRyX8gUoYCJVttkaKL9Ggpf2KbgFMx5w2qpGGxGOZkmZgQ6mOjtmSfAVq5KTKa3B5f7ivA6B6puoZmT8HSYX8BbhbUErLFGeR9WnGMFoz+vVbh1224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqDSW6BQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqDSW6BQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D190D1F000E9;
	Tue, 26 May 2026 20:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779826666;
	bh=+JfWsD9G9izWAuLbKWLwH3arUXiiSqOeAp2KVI46ppg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lqDSW6BQAVojIM271SqkbWrTOAYPQHP75sOwetsXDuiEg6af7u40nS7X9Z+dZWLj/
	 il/RSGDoeabKtOMLlyfkFcT7JCSaBZsEtlEecrRovyP5Wf5mJtTeakWcGyF+f3G2Uh
	 fLCyO+K9ktqhMYE44lJpmpGWXgSM4k/9nYITR93uKWlWPYiHKmH5PeyyloMNrkWIWs
	 C13Xl80xPQXjHP7kitckxWlZX0tfzRsbU/Hv8TVlSCSNbJpAk0tEo3bcsnIHq7F2Hu
	 ilIZGtkt4VB33SrGA5IuzS1XNv2S4ormGB3+KF+C6d6j6aj8qtGltqckb9xJnnpmWM
	 cvaC6Wo0PWIIA==
Content-Type: multipart/mixed; boundary="===============7570166684319625877=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <61ddcbe99f39faa28a822a24e5e400f9e5825fb37305a5832d58bd48e1faea9f@mail.kernel.org>
In-Reply-To: <20260526-better-1m-reporting-v2-5-e7ec61c45d41@gmail.com>
References: <20260526-better-1m-reporting-v2-5-e7ec61c45d41@gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 5/6] bpf: report register diff summary for hot callchains
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 20:17:45 +0000 (UTC)

--===============7570166684319625877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 54b7ad65b7fc..d09c014462f1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17527,7 +17564,9 @@ static int do_check(struct bpf_verifier_env *env)
>  		insn_aux = &env->insn_aux_data[env->insn_idx];
>
>  		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
> -			print_hotspots(env);
> +			err = print_hotspots(env);
> +			if (err)
> +				return err;
>  			verbose(env,
>  				"BPF program is too large. Processed %d insn\n",
>  				env->insn_processed);

Should diagnostic allocation failures mask the complexity limit verdict?

When the verifier hits BPF_COMPLEXITY_LIMIT_INSNS, do_check() now calls
print_hotspots() and returns its error before emitting the standard "BPF
program is too large" message.

If bpf_sample_state_diffs() returns -ENOMEM from kvrealloc() during
diagnostic printing, do_check() propagates that error to userspace instead
of the expected -E2BIG. The program is correctly rejected, but the
user-visible error shifts from "program too large" to "out of memory"
purely because diagnostic output failed to allocate.

Would it be better to ignore or log-and-discard errors from print_hotspots()
so that -E2BIG and the "too large" message are always produced when the
complexity limit is reached?

This concern was raised in v1 by bot+bpf-ci@kernel.org:
https://lore.kernel.org/bpf/e98190c9cf56e356e517d69e5409b8fa34ee99342287c612418fbfe57319e1c4@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26471389564
--===============7570166684319625877==--
