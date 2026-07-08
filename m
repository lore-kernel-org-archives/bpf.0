Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68A72F12A5
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498209; cv=none; b=tHUiqFIRL09n6ZYGnGp9XFwkwrQPV/Vj2cqUPPmiFYF487wmeV6b1k8HoM0AH/URjwdBFqyo04o4FBHNBhWXEacqUk12lM/vzfFtLVikDPzCmjWlwLjv4DOFqXqlXRahv8uC7homajmAvBG5Po364H4LfOAf0t5iHU44EhKq2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498209; c=relaxed/simple;
	bh=oGFLKsBnMzcej3uQvyEv+8cIrYohmvDx5EmQXQp1f+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qjptxK4thriZbQC4e7fLG1QDiwvfQptuHY6eWBQzqd2lLZzeedvGjbtnmn8VUk9ITc5U1HaR6/Y80ys+lYtJgMBO2PbaT65+OiAVNSS88SXlggmrP/fyz5PQ5T7DkwP0qrxNx34nl4e9GF9B1DfMptoLny5s7hUe5KtWtlFzmMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MugYH1kr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MugYH1kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402A51F000E9;
	Wed,  8 Jul 2026 08:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498208;
	bh=naFiFVDs2FFvIyFypLAefkuqplXFoABxSNZjWfDiu1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MugYH1krRnexFSItF/cBgotziCp0ubirsmKB2ZomnHJuozbUK43IxoybmQWRit903
	 hafwGkc3eiN0ci9NRjJDGqWQ+XU/oVhwsSeiUC+Yn/T+qUCsTf/woYCd9Ov2jE7AUj
	 acM/8C3JkQic2XohAotjMqmpEoDUzGfZ1EPiO2Aesd/nl1VlpzoYxkUti6aQFpQF/m
	 6YQeNZOZ+1KkQPjHPYfS+KJL1YqdCTpk9ReikQ5qZCIYOq+UHZrJjzooeSqQM9/E4U
	 oWzOTdbimmy/Ekf39FrqopSDBgqKKZDZdj54GXXXH7QG7H1JQ7sEBW5lkoq43l8s5E
	 2OllX2+wWTYpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 02/10] bpf: mark instructions accessing
 program stack
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708-kasan-v4-2-d5c177ab8227@bootlin.com>
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-2-d5c177ab8227@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:10:07 +0000
Message-Id: <20260708081008.402A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In `adjust_insn_aux_data()`, when replacing an instruction with a =
single new instruction (`cnt =3D=3D 1`), `data[off].non_stack_access` is in=
correctly set by evaluating `is_mem_insn(insn)` instead of `is_mem_insn(ins=
n + off)`.
--

--- Patch [2]: [PATCH bpf-next v4 02/10] bpf: mark instructions accessing p=
rogram stack ---
commit 764c11844e954d2fc0370d170803b0deb684733a
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf: mark instructions accessing program stack

This commit introduces tracking of instructions that access non-stack memory
to help JIT compilers emit KASAN checks. It adds logic to mark BPF
instructions as stack-only by default and overrides this if any state
indicates non-stack access, including adjustments during verifier patching.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index f515fc9669ce2..feee1f33de9d5 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -172,8 +184,14 @@ static void adjust_insn_aux_data(struct bpf_verifier=
_env *env,
>  	 */
>  	data[off].zext_dst =3D insn_has_def32(insn + off + cnt - 1);
> =20
> -	if (cnt =3D=3D 1)
> +	if (cnt =3D=3D 1) {
> +		/* A non-memory accessing insn could have been replaced by a
> +		 * memory accessing insn, systematically mark it for non-stack
> +		 * access
> +		 */
> +		data[off].non_stack_access =3D is_mem_insn(insn);

[Severity: High]
Should this check be using is_mem_insn(insn + off) instead of
is_mem_insn(insn)?

Since insn points to the start of the program (new_prog->insnsi), calling
is_mem_insn(insn) evaluates the very first instruction of the program rather
than the newly patched instruction at the targeted offset.

If the first instruction happens to not be a memory access, will this
incorrectly mark the patched instruction as not accessing non-stack memory
and cause us to miss KASAN instrumentation?

>  		return;
> +	}
>  	prog_len =3D new_prog->len;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-kasan-v4-0=
-d5c177ab8227@bootlin.com?part=3D2
