Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253D481643;
	Fri,  4 Sep 2026 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524981; cv=none; b=LBLuqMM/oU0I8B5N/SOz9nIVxkC1VYpYk6AxAJX3ux5BQKIsACUff0bcUC7/BqkL/OhpwSrxs8YmGjsUTaOhxfmNC2lSJ9Uxy53Qi6Res7FeUiw2K3FFab8UXDT02tMPR+NJKSUvM2r6oBQwheVnGgM/e2xGTWx6Bho4pZ/vusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524981; c=relaxed/simple;
	bh=PiE6KAbCrx0HruWK15RJpph5P3xZDaq+6706Z76R9b8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qiLlGjK7Mr9+xsXBLz84CXEap7vpHPLi7G/bCb/wa8hiG2YdKCzUbiRZxt0hAi207WTqsUMIl7t67EPFHR4UKcCwWtQZTxwcfiCIUgeyMeXkkUl5lFm5lI9UrzNOP5LSpq9rdG9l6bdyLnPjBkHnljvT+BrT07EMKf/9jbqsoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP0sS3jm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP0sS3jm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8481F00A3D;
	Fri,  4 Sep 2026 12:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788524979;
	bh=PiE6KAbCrx0HruWK15RJpph5P3xZDaq+6706Z76R9b8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NP0sS3jmFM244rY3zX1Z4j7KzVxIstVaLQ9vZrMMOOWkjANvba0+fXtked7EzzdpY
	 yvgjGxHYn+V7/W1eNVM/QrxniQSExPrgdiVYELX6YMqjkQ1SKgtsn3E7Y0gw9+hVwD
	 iGDl/J5VJmuzE6apFDsnFGGSt0PybupWLDgLcza1nliPvOMtMCJLgVzfXSx7wqOvDu
	 NlQbZrPQWBrKRBt+F7JQugjTBPSrMW8jk6yLMc/tnQ+4DI5uM6+ae55EDvx+46dKvH
	 Fb3QOmD+20RgloJKRnq9xJiPXdwhD+eqPC4N2VSCdNVN+dfhHjhpva2tsLYsKhZmmz
	 /YcxslP/7UTvA==
Content-Type: multipart/mixed; boundary="===============2140836779584207408=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e473cea93e948db9c27dc4ae0e993eb3e09011e7cbe8c8e4b305c3b12d866502@mail.kernel.org>
In-Reply-To: <20260904111731.673341-2-main.kalliope@gmail.com>
References: <20260904111731.673341-2-main.kalliope@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, mips: Factor register moves into helpers
From: bot+bpf-ci@kernel.org
To: main.kalliope@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,tsbogend@alpha.franken.de
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-mips@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 12:29:38 +0000 (UTC)

--===============2140836779584207408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> BPF_MOVSX carries its source width in insn->off. Both MIPS JITs
> currently lower register MOV instructions directly in build_insn().
> Keeping the forthcoming MOVSX width switch there would split the move
> operation between dispatcher cases and backend emitters.
>
> Factor ALU32 and ALU64 register moves into helpers for each backend and
> route the existing MOV paths through them. The helpers own the complete
> move operation, including MIPS32 register-pair handling and the ALU32
> upper-half state. This keeps the following MOVSX width decoding inside
> one per-backend, per-width-class move emitter rather than in dispatcher
> case arms or generic primitives.

This isn't a bug, but the second paragraph seems to repeat the rationale
already given in the first. The first paragraph explains that keeping the
MOVSX width switch in build_insn() would split the move operation between
dispatcher cases and backend emitters. The second paragraph restates this
as keeping MOVSX width decoding inside one per-backend, per-width-class
move emitter rather than in dispatcher case arms or generic primitives.

Could the two be collapsed into a single sentence about why the move
lowering needs to live in one emitter?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33869345053
--===============2140836779584207408==--
