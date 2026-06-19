Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601CA360EE9
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781905619; cv=none; b=KAi0zLz9ZeYPE1K62EVXgvTQ8GAco5oKYCpZffVAHtz8qJxVx5UWj5c8Axmsx86zOJAnhLUJN+TdacOFtapBKi2PZ2CP0mZrvhVvKbArQd5PW9IPRiDmYn1OBE50tCw27ZLDGO4PF7qf+u6xOEexK5/MN6m4VmQeYVw7I4R/ODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781905619; c=relaxed/simple;
	bh=YrdjFucZBGbXWj9dzUF89fN7u9RQjR2VCyx6v6E8bDw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HWrP5opeEVICfjuXIO1ojxJkFA3NT34bnLqUMh2WDPYzyUDcz4+kMRTdFEPTlES3qebEwo1wdgpeyZwNBNck+Cg1wFX3n+J1bWYS0fkBYMmQg4+WepZD2jdk2yf9tKbOljkcV5iqoWz/zy0iIcydUQkCumTlp/7MVV/HQmx1LXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZbHyTQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZbHyTQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76791F000E9;
	Fri, 19 Jun 2026 21:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781905618;
	bh=fMb0qXqryYEjrVfyTLQ9NzQr11EkHVYl0h8U2xLv0aU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bZbHyTQ3jA0mHtRbtiP2nxIQXPUBSw3W/G+LDKiyl6/Yl5CqwqdKW5Lzq2hsmCsUM
	 T9vcuneVUZdtk09POFDQTT+JkBh9pEXL3UOOWTk5DvdsILBATMenxXSiNRmoxZR61y
	 tZlQEVa4u/N+qb/nmGCQCJul4/uL0F91SmaboYHq2U27PuxjtSdu3N7vYISsmgPree
	 rpQtvVoq7U92KNPLqmU2amaVvKQn75ZmeAjUtII5KbLeWi7sCWCpU1O+ll4sDQWEZu
	 u8utBGGNc9T4r2ygJrddtfSdU/fxbTGWfbdDVBWTstLVsseP/YN+bUqWM0xssH6CLn
	 NtBvHm54Dp/Gw==
Content-Type: multipart/mixed; boundary="===============2382129627332519134=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9eea3ba5dc3c6aeec14d5098ae920bb858a94ae6e0a0a0c2356373397d1781f7@mail.kernel.org>
In-Reply-To: <20260619205934.1312876-8-memxor@gmail.com>
References: <20260619205934.1312876-8-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 07/17] bpf: Track verifier context diagnostic events
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 21:46:57 +0000 (UTC)

--===============2382129627332519134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 58cc7c18cf98..d6a9a2315f54 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -1041,6 +1041,53 @@ void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx,
> +void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
> +			     enum bpf_diag_context_kind ctx_kind, bool enter,
> +			     u32 depth)
> +{
> +	/* Keep leave events so context rendering can stop at a depth-zero exit
> +	 * and show nested-region depth accurately for the active path.
> +	 */

This isn't a bug, but would it be worth moving the comment text onto the
line after /* to match the multi-line comment style used elsewhere in the
BPF tree?  The rest of diagnostics.c keeps its multi-line comments with the
opening /* on its own line.

> +	struct bpf_diag_history_event event = {
> +		.insn_idx = insn_idx,
> +		.kind = BPF_DIAG_HISTORY_CONTEXT,
> +		.ctx.kind = ctx_kind,
> +		.ctx.enter = enter,
> +		.ctx.depth = depth,
> +	};
> +
> +	if (ctx_kind == BPF_DIAG_CONTEXT_NONE)
> +		return;
> +
> +	bpf_diag_append_history(env, &event);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27848712882
--===============2382129627332519134==--
