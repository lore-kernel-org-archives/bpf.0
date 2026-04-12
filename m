Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39671A275
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959109; cv=none; b=YIdRJVax6AXVE/LBwlQ2966s7BbPYgyma3kU3HRsO2De7Vcybqxr2uUZrOH9bazUHDED4HqI7dE/kl4lo0AfSs07wBYR4xDtwTDjH16/oD1qzIAa0jWPZUpR6bB7/g+w8KEXjoc+nX5Rl/LgMtl4msgVB8A7QadAmjdfR+EkUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959109; c=relaxed/simple;
	bh=25NRYr5fNxJJTddXAhwEHgTMOBqK3cNg3ICTs8IzdsI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Mr64tjRm80ug9/OCR1bzUlsFEpfdqjX6GBPBtjoaojbjQzOGhlsnwDoXJFtjtseTdgyzx1/T/MjzuqjpiVs8ulc/sCDYYaztzCA//5Tssj6SZQ7pRzvlYTHqu5f38Pc+1X3TNCo5O40aUSKsWdFHlnSVPQtBCBVh6fFAYbgrcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N55n4b5j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N55n4b5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C304C116C6;
	Sun, 12 Apr 2026 01:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775959109;
	bh=25NRYr5fNxJJTddXAhwEHgTMOBqK3cNg3ICTs8IzdsI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=N55n4b5j8xHaUOXRNM3qno9FXmmoaXFWw+UowojZKdhBsgJc1iMkuqEzkfoOjz5P1
	 1XZs3ZZRBQC5l2HzqyiAhDrYftRT8kcKnI8Zz5w89WGH2Y/Fp404Ea11kRETnDxnK3
	 6PrOOQUMED4Jrf937bhKg1mvg4GZO8GSjDoRNFPv9oOlyaN5v+Z+ClsqUF7wxi0MgL
	 tUTTDqDGXxJYZomDmioh6vwCJ5ZVC65xvgxKck3fCl2KYYbDARzXQZWjDz1WGmpoul
	 TYFF21C6P5odHAuuHznpo6U/RCXLW5IHsfOD6rcal0kUzKwPlS5u9oz7DS977zR5H3
	 snGnO4FM+p9oQ==
Content-Type: multipart/mixed; boundary="===============2306263496579365498=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3fd6b830d907fc12e02981f784ca91e4bdd2e8311446f00308b7abb97a54af9c@mail.kernel.org>
In-Reply-To: <20260412011857.3387-2-emil@etsalapatis.com>
References: <20260412011857.3387-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on arena pointer addition
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 01:58:29 +0000 (UTC)

--===============2306263496579365498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 967e132f2662..45e219f9d206 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +error:
> +	verbose(env, "R%d %s R%d: Invalid operation between "
> +			"bpf_reg_state types %s and %s\n",
> +		insn->dst_reg,
> +		bpf_alu_string[opcode >> 4],
> +		insn->src_reg,
> +		reg_type_str(env, dst_reg->type),
> +		reg_type_str(env, src_reg->type));

reg_type_str() writes into the shared buffer env->tmp_str_buf and
returns a pointer to it. Its own comment in log.c says:

    Note that reg_type_str() can not appear more than once in a
    single verbose() statement.

Calling it twice here means both %s arguments resolve to the same
buffer, so the error message will show one type name twice instead
of showing both. Would splitting this into two verbose() calls work?

This was also flagged during review of the v5 series and acknowledged.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24295891016
--===============2306263496579365498==--
