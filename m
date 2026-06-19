Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8361379980
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781903563; cv=none; b=mVvGsNLgZ0D/A4iyTayYYG2ViMvw1+CKdnq/nncuRrhYetMIFMFDSmZHTvArcpn0sEtHr3Hw3a3yv8mcC3ZkGv+jafTpKwRGhvbUNY9PMgbXULs/A9S8igW58CFpegOImI9KIRRexHdUSz7chrrutuZ3XlqjC7t3YsWob/eZRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781903563; c=relaxed/simple;
	bh=8SOZnFys1/vR6rcm7IWb0WeZM+4qGb3Ud8cxyDhqQtI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q6sD6JGp4ZJfpw5VmqKsLknzqNWCeHREyHCXITD051ygpbsKi6Fbpoq6BoZyRk7cIJfUm2M6FQOJCFszbFeIj6g+CUSxIkKUwC53g2dGtZKO0BIXoD0s9UDbAud24RJhqcpo5G/EWpwtHbIRMJaZLiJKfYmey5QrmUINAJQ6ehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqhlVKjR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqhlVKjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121D61F000E9;
	Fri, 19 Jun 2026 21:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781903562;
	bh=p+FDiBCgsXykrb+wHg8xhHY29v2JbfVuBl4LTS9qYhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CqhlVKjRmF6zW2uIOdAX1bNfj9wWWT3ADsCtPFX7r0bUgjwh981+ybcVEJ7UgYmIW
	 P4l63PWy2hdRP9CJobLrxqrzDsWD4j+60buRQRG+A0dCHWTYwlCp7AophbytZUnzym
	 qmxjKaP7jVuB1VE1nOoPbMnlpqDplNTf9cdSfKYUw1q8spzugn+ui28+TMjQDCox5C
	 8JliZySBV0qSX7C8Hu+e1ayR8AHeYZiGVsete08TCaNhM/riLOfWnFNp6Tssrpy1Oc
	 ggJPjPxDfgHzrElONWNGflft794uhG9rmu1xQ7LHDoHCfkTS7jGbX9AZNlIQ1hJIvL
	 BOhVNv4RkhjVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 10/17] bpf: Report Resource Lifetime
 reference leaks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619205934.1312876-11-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
 <20260619205934.1312876-11-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 21:12:41 +0000
Message-Id: <20260619211242.121D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Diagnostic history for nested IRQ-disabled regions prints the wr=
ong context.
--

commit 3353d537a1807034f6c2c245d23ed71ed9b90936
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: bpf: Report Resource Lifetime reference leaks

Augment selected Resource Lifetime Safety failures with structured diagnost=
ics
while preserving the existing verifier messages. Report unreleased referenc=
es
from check_reference_leak() using reference-scoped diagnostic history, and =
add
state reports for dynptr, iterator, lock, and IRQ-flag lifetime misuse.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 933540eb105bf..e9c58f84ec89e 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
[ ... ]
> @@ -1702,6 +1702,71 @@ void bpf_diag_report_mem_bounds(struct bpf_verifie=
r_env *env, u32 insn_idx,
[ ... ]
> +void bpf_diag_report_irq_resource_state(struct bpf_verifier_env *env,
> +					u32 insn_idx, const char *problem,
> +					const char *reason,
> +					const char *suggestion,
> +					u32 depth)
> +{
> +	struct bpf_diag_history_opts opts =3D {
> +		.scope =3D BPF_DIAG_HISTORY_SCOPE_CONTEXT,
> +		.ctx_kind =3D BPF_DIAG_CONTEXT_IRQ,
> +		.ctx_depth =3D depth,
> +	};
> +
> +	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_RESOURCE_LIFETIME_SAFETY,
> +			       problem);
> +	bpf_diag_report_reason(env, "%s", reason);
> +
> +	bpf_diag_report_section(env, "At");
> +	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
> +
> +	if (depth)
> +		bpf_diag_print_history(env, &opts);

[Severity: Medium]
Will this diagnostic history print the correct context for nested
IRQ-disabled regions?

In acquire_irq_state(), the depth parameter passed to bpf_diag_record_conte=
xt()
is hardcoded to 1 regardless of whether bpf_local_irq_save() calls are nest=
ed:

kernel/bpf/verifier.c:acquire_irq_state() {
	...
	state->active_irq_id =3D s->id;
	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_IRQ, true, 1);
	return s->id;
}

Because BPF allows nested IRQ-disabled regions, a sequence of nested saves
will all emit enter events with depth 1. When an inner region is properly
restored, its leave event is also recorded as depth 1.

If a diagnostic report is triggered later while still in the outer IRQ regi=
on,
bpf_diag_history_context_start_idx() searches backwards, skips the leave ev=
ent
(as it only stops on leave if depth is 0), and incorrectly matches the enter
event of the already closed inner region.

Does the verifier need to track the actual nesting level instead of hardcod=
ing 1
so that bpf_diag_history_context_start_idx() finds the currently active out=
er
region?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619205934.1312=
876-1-memxor@gmail.com?part=3D10
