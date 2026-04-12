Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF7981ACA
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775971917; cv=none; b=GPSW0Nh4mrTPkIxEj3TuzZbapmDOoNBsstm7aK9VKdsLPT6djOCz5n4I+cmUCwbIaamLWbgb3kkL0zbcde8Xm81KqJcFlYumev3RMIRuxZi/eV1fh9H6lVeA9yBtiKYPdbHVGnpIq4c2blGRjCGcD382USmV5rkgVzlVjmume6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775971917; c=relaxed/simple;
	bh=PnzGPHDIDfr9yss/M5Up/92baZtrTAbiIwG3J3uWzdw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QeyprikxQBLXLgKJIX5+YOa24FAIxHxRGJ74FfQJh8Ze2CVdBnMI3I/xbR3cb0k1sZ0r/Xf+Kw3OiKta9e7ijiu/WKBS7HlczsfSA3vNquE0nuc6R79URjEp75ybizF946fUqro0cAn0JMvQL7hSpKoGG2BRkUtYR4F0mD+HQTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s677OCDD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s677OCDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2A3C2BCAF;
	Sun, 12 Apr 2026 05:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775971916;
	bh=PnzGPHDIDfr9yss/M5Up/92baZtrTAbiIwG3J3uWzdw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=s677OCDDJ7Am7tmkqtodSsDNa29M+BC0FwAiEBdLKyaB8o1ZNjS+8iNsLRno8BsQ2
	 zwZH7jyV9qdE6UJNZeSQhmKbI+LFDaompQXjLoSDXRE8X8IfxknGf0TUsBOcsWcFKu
	 Gx5y4zgjmXncs1pUNhOnyReO7qeMVjjoah2hRt/vuGBWEEhMM/vjjC/JOQtqR83cM6
	 ta+wR31pKOSv8SpSPaV2sKKSuxstxnSWAj+vKXHHn3AHUq4km/9hs+Fu4vfpvqWHgO
	 4jH6CAXCAZHTUK/SEHl7l6gG1TQFbyk3ZcQgzgCguwwDLELUUGGE3O4PdeD9nzpWAC
	 s5p9n/gMqx6Qw==
Content-Type: multipart/mixed; boundary="===============4059431366149334660=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <834331bd3a4dd3bc2a3b365ae9dcf8031f22041d33623c1712432f5083f15c9a@mail.kernel.org>
In-Reply-To: <20260412045847.255351-1-yonghong.song@linux.dev>
References: <20260412045847.255351-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 04/18] bpf: Refactor to handle memory and size together
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 05:31:56 +0000 (UTC)

--===============4059431366149334660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4c67a15c73e1..cddd39ebb40b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8591,11 +8591,13 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>   * containing the pointer.
>   */
>  static int check_mem_size_reg(struct bpf_verifier_env *env,
> -			      struct bpf_reg_state *reg, u32 regno,
> +			      struct bpf_reg_state *mem_reg,
> +			      struct bpf_reg_state *size_reg, u32 mem_regno,

The function comment above still says "@regno is the register
containing the access size. regno-1 is the register containing
the pointer."

After this refactor there is no @regno parameter.  The parameter is
now mem_regno, which is the memory (pointer) register, not the size
register.  Should the comment be updated to match the new signature?
Something like "@mem_regno is the register containing the pointer,
size register is at mem_regno+1" would match the actual interface.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635
--===============4059431366149334660==--
