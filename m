Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86ED377AB2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276624; cv=none; b=ORI6QfPgn4i2Oy77upZKWWQ1W7IxMHQr5WGE0o0nkN+zxSFX+6mXUyGDNiDslErw7frNotbkJF9BImq1+I4PPwQ2hnOnPWySPwXnbWz1p12Hd1ISVEVrZCxlYQK8w2/QknsmvgKUYZrsyEfM++AGbKZEBCdXrenhoSdJ1lF1D4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276624; c=relaxed/simple;
	bh=cLKpcaozP8ED7WOXgQ84JqwhHCHMXjmeFjXntDO9zuo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s5KKrFquJq6NucmgvQWeQPoWdGjAU+/u6KkPIBHg2vEu00NrMvKX7D06F1GmvI78UOf9qVoTDSxWCG7F4hvLPRVt0qCL9myXFEq/e/mxtaynvTdgCesXsCpXcUvFkEstXaUnZvZcs9bLwQ+HsoGH+Mog0ZsGKIlcQlY+B995hds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwzBxoCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwzBxoCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214C61F000FF;
	Thu, 24 Sep 2026 19:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790276622;
	bh=y6i0LLsAN6+JEKO9FdYfh3LHbFoGS6umGR1gNY+2910=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WwzBxoCObtitSi8DVmIH1BCyLV/h2nowapxss5BtjyyFEtuOn56IiIPR4/YXNoRfC
	 JKB8xeOhr7kLKLFYejKU8SP+lBdDZ7pD/2scXuweeJgOIPtmMf0IchfWkTmPNRB48v
	 FmPQqexRJWPIzL/GAJDS2QSJcOj9081RkolsCn+O7X95ZhhCnhzk842sl1/4fjq59T
	 BuWj1Q/0IqgUNG8I9VmlMzS+1K8D1sYhiwvinno3vcQvsFQuNXOuUXZd0PzB1j/k1j
	 YDa8EFl1B5nlvi7Rt6WS50Ij2BzD4lNyHHDXZicbUuSphhd0eFL7QO0Vtof3HwfWtr
	 pNwF/mzAiNa6g==
Content-Type: multipart/mixed; boundary="===============0379661633849005578=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6a8963156df5c25c00ed488854d4a106b408751f90896fd0304b8eab6a729609@mail.kernel.org>
In-Reply-To: <20260924182353.277516-1-alexei.starovoitov@gmail.com>
References: <20260924182353.277516-1-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix overflow of jump offset in constant blinding
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 19:03:41 +0000 (UTC)

--===============0379661633849005578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix overflow of jump offset in constant blinding
>
> bpf_jit_blind_insn() rewrites 'if rX op imm goto off' into:
>
>   AX = imm ^ rnd
>   AX ^= rnd
>   if rX op AX goto off
>
> and subtracts 2 from off when the jump is backward. off is s16, so
> -32767 and -32768 wrap and the jump goes 32767 insns forward, past the
> end of the prog. The jump is inside the patch, hence bpf_adj_branches()
> doesn't check it. The kernel crashes when such prog runs with
> bpf_jit_harden=2.
>
> Return -ERANGE in such case. bpf_jit_blind_constants() fails the same
> way when blinding of other insns moves a jump out of range.
>
> Fixes: 4f3446bb809f ("bpf: add generic constant blinding for use in jits")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Does the commit message fully capture the security impact of this bug?

The message states that -32767 and -32768 both wrap to 32767 and go past
the end of the program. However, with the old s16 off, from->off = -32767
becomes (s16)-32769 = +32767, but from->off = -32768 becomes
(s16)-32770 = +32766, so these two values don't both give 32767.

More significantly, the wrapped target doesn't always go past the end of
the program. The rewritten jump sits at pos+2, so its target is
pos+2+1+32767 = pos+32770. To hit this case requires pos >= 32766, which
means a bpf_capable program with more than 4096 insns. The limit for such
programs is BPF_COMPLEXITY_LIMIT_INSNS (1M), so a program with more than
pos+32770 insns is straightforward to construct.

When the wrapped jump lands on a valid instruction in the middle of the
program, this creates a control-flow edge that the verifier never checked.
Wouldn't this be a verifier bypass that could lead to out-of-range memory
access, rather than only a crash?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36042749135
--===============0379661633849005578==--
