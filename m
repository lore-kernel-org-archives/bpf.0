Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9499139794B
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218782; cv=none; b=WhoTi08q1wOLzCduu0BocxMpD+gtZ9pdV4MXDtfMmYnmFjw5XN2h6vgw6F0feYbjBmeVpjKWZ9q0+KKZ+44XHtAf5tiKalwLahHwYLG8yTojHOYJVxTtCeFtuEA7R3RvovrEXMnR6gUWOds3rxpwq74FRMwfqxraDhy0kl7H5CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218782; c=relaxed/simple;
	bh=kj5v3dja33NhVhu0BfZ62HBqtjuJxIA+6drchRbO5d4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=B5Fuv2tUXdTEGOvscfcwjzw0I/CvLf+/RvZab2M+PErKW88i3BBKEf9yBDcnTmCToCXWIh5qx4WyKJ+MI7Osj4HWKa7J4GstzUn6osmotM2+r4jKtOMRmXrPBZey9e+Aj8dnqBRYIvV0nhThlQouHeR8aiIOm2hqrMHsfxXHczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRku09uf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRku09uf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299991F000E9;
	Mon, 31 Aug 2026 23:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788218781;
	bh=CkR08r07So36LQGJ60BWTMTOOigRu9Mwez3kt2VOpC0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HRku09ufPZCRdb9KmpfO3tt8+EjhixmyjfpzaprrDhewZT4ZoPdaQXI8fbX66ZLMI
	 Z0Fka4ndixXsAG1SBjP41W+ij8j0Jh9kfPzdVUHk2V00VYV4BkWL244w02I7xnbeqZ
	 lGygfP2PNkHHQgtDt66BXOUGcQ8myD8cq7nJvhcY7JDEg/XcbBDuHsmB5yh3RTXein
	 o5N/m3GOyHdadNvkuyPf0wXULDECWFxIQrzHJ7ZSre3WqUANz+ZGL2+qyFiSDPaYNW
	 sSl0lftA0En194A0DI0/c5wXq+hN7ympHNNk8bZY9Ykkv392jFX1eFDfq/NCu1Z0hZ
	 GUruEc65piVxg==
Content-Type: multipart/mixed; boundary="===============6750772419974576802=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <08bc375fdf3ed6ec599f4f9a8b220f46d8d485a2c8420531f081797b33cf1296@mail.kernel.org>
In-Reply-To: <20260831223314.89787-1-sidchintamaneni@gmail.com>
References: <20260831223314.89787-1-sidchintamaneni@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: allow terminal gotox instructions
From: bot+bpf-ci@kernel.org
To: sidchintamaneni@gmail.com,bpf@vger.kernel.org
Cc: sidchintamaneni@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,puranjay@kernel.org,rlmenge@gmail.com,hargar@microsoft.com,apais@microsoft.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 23:26:20 +0000 (UTC)

--===============6750772419974576802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: allow terminal gotox instructions

This isn't a bug, but Anton Protopopov requested capitalizing "allow" in
the commit title when he provided his Reviewed-by tag. Should this be
"bpf: Allow terminal gotox instructions"?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8f585ceb2cd51..483473df7746c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3107,7 +3109,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  		if (i == subprog_end - 1) {
>  			/* to avoid fall-through from one subprog into another
>  			 * the last insn of the subprog should be either exit
>  			 * or unconditional jump back or bpf_throw call
>  			 */
>  			if (code != (BPF_JMP | BPF_EXIT) &&
>  			    code != (BPF_JMP32 | BPF_JA) &&
> -			    code != (BPF_JMP | BPF_JA)) {
> +			    code != (BPF_JMP | BPF_JA) &&
> +			    !insn_is_gotox(&insn[i])) {

This isn't a bug, but would it be worth extending the comment above this
condition to mention gotox, since the accepted-terminator list right
below it now has a fourth entry?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33447655511
--===============6750772419974576802==--
