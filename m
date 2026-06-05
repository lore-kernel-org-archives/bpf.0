Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E300F409603;
	Fri,  5 Jun 2026 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686536; cv=none; b=eOxLwNSU1jGjhTSF/NmDEtwX8cw4U1SoeLJN+sCIUlFHzOvPh5E98jOejtYl4+YWWO09dYBQf9aOfaMIJsbGLznSCXd/ZGnOE073iQsuATap2Ux0Q842a9gOL7b40BqmcM3pqBRRIBjyVqfCBufHE1oo8reDMVRoCeL0pBo4EBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686536; c=relaxed/simple;
	bh=KR5xveAOSH4lE4C7FApc/5PGwobBZ2hRVpf8cnvjB8Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lR2icXJewlgwBxEfpHP80vZMhDVdYEuRKWulLvb0dqlYxn/qvOLZfCMnnk76vugPHDFIMjaQuZ1if9ynlus3YIpItBfywKJMBYtDm72f7EnysoAU6/zBCfbBw1xf/xRtH/nFlcbwRxcnz097GoWBEYhkloa9S52SkWhkJvz47Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvJjF9SQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvJjF9SQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CAC1F00893;
	Fri,  5 Jun 2026 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780686535;
	bh=qo2m33NQeRmaDvm/ox0qcA8IfPMMLz/eL4e61lU1CKU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mvJjF9SQ29lyrlk3oI7xS4lcRrisWR2R4LFM/xP3jWHn5WQgh4nGN2EUvMViJR1TS
	 TbHqyO4herEAb38mppJT+0DfJ/rDBJPw275LIkdnYaAXlreDoxcMqJutSNCYoOIRPT
	 jbIIJ4ISFuyFv0BwzkNU1G0OuXYPR/buVz6pY1EsWKy/pRLOaqKlTEG1SXMT6noznM
	 QeSmJjApEDWjvabAyS/wCRQrP+9UyB6cCCx7NG8w2fQTZnWR6mxZZ+49V/EOYoe/Od
	 uQtmDEcPvRVzzOxpsFYDZqXUWaFgx9+E3Mm10ai+h+A8Lx1WWQ7vBbv16jUZhD9bLx
	 CaoOCgbApPc6w==
Content-Type: multipart/mixed; boundary="===============8919606443623192315=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3a3a97529e6a13b4220026c0d97d3c2341a503e3f815e0c67f1cc6a8ba13cab7@mail.kernel.org>
In-Reply-To: <20260605183551.969144-5-ameryhung@gmail.com>
References: <20260605183551.969144-5-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpf: Remove WARN_ON_ONCE in check_ids()
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 19:08:55 +0000 (UTC)

--===============8919606443623192315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Remove WARN_ON_ONCE in check_ids()
>
> check_ids() warned when it ran out of idmap slots, assuming this was
> impossible because the slots are bounded by the number of registers and
> stack slots. That assumption no longer holds: referenced dynptrs acquire
> an intermediate reference that lives in refs[] but is not backed by any
> register or stack slot [0], so a program can accumulate more reference
> ids than the idmap can hold and exhaust it.
>
> Exhaustion is fine for verification correctness. check_ids() already
> returns false, which makes the states compare as not equivalent and
> prevents unsound pruning. The only effect of the WARN_ON_ONCE() is log
> noise, or a panic under panic_on_warn. Drop the warning and keep
> returning false.
>
> [0] 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

This removes a WARN_ON_ONCE() that can panic under panic_on_warn, and
the commit body explains the idmap exhaustion only became reachable once
referenced dynptrs began acquiring an intermediate reference in refs[]
that is not backed by a register or stack slot.

Should this carry a Fixes: tag pointing at the commit that introduced
that behavior, which the body already cites as [0]?

  Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27034008594
--===============8919606443623192315==--
