Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DE2F8E96
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819326; cv=none; b=LclKY7hA00PyziGMyKuNRfTkNLvE5Xrb/HL1X6N3TaHSLjEFNrBIRcKibPfvKwvZy04DI+MNzWdwZgFQ7d5rOl3zgYfph12yMMnKny+NkVlpsMOM96TpztScAnmgdRYTdMLOJD7lSFDOxO8kd6wBmbl1RoX6JUs4DX2ERV8vwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819326; c=relaxed/simple;
	bh=I2nDMKXcmn5tr7HU2Tz6mrXMHAZqeMTAbSnlOLIuk5g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b121KFs8iJZlecRDog/wVOA5HlEPwqwxpRI52WG76gELUMvMHhLUGbr3LtG8XFHlJ5bjxgNZe37wBQk8alWx0l4Fg3DvzvGMtIdMSZRXXu0+vdCEBwEtgQqqLGGz8LHM/FsLxbhLydio81kLEtkC1RPd2+I4kFKwAVvw5MQxS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJuiOuCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJuiOuCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C98F1F000E9;
	Thu, 23 Jul 2026 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784819324;
	bh=qTfhrBmf8gPkWstMXf8IwPC9MnzZB2oancSKRiFcNtc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VJuiOuCM0ehH31ECTkVauEi+p1Fd0J6OYS6gpMhbPpUGD17rsX2LxFaC2HYGDx/+d
	 hOFBAamWTbivSQghRQfkfrwxl+meiT7he4dQ7RAL9qUOFYoW+1x7vsaAhLBubg6f2e
	 zKYkNt3JASggBKlLfEVQ3mfVM2SmT7tP2q0p5xzXxRLmmgW6CX2V/Vy8/Pdog9LvMo
	 pZVO7PGZ6+ujx1xn1Iz1MpGl8DjfocBIzlY8eS+s1RllDDc6R/N8c66R9Cd+m/GaFf
	 KZPDGvNYStzsKLXRqXBCi15PZkrBogLo9mHsFNhXGDtPBloht2ZBsUni4HncJH0Y8k
	 ojOCs6lRbUK/Q==
Content-Type: multipart/mixed; boundary="===============0920127468740527574=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de7e741b41933e64129a1be2f51c3a2c5ec0edc526702474a8816ed411433c4c@mail.kernel.org>
In-Reply-To: <20260723140648.583055-6-max@linux.ibm.com>
References: <20260723140648.583055-6-max@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/3] s390/bpf: Add emit_ldx and emit_stx functions
From: bot+bpf-ci@kernel.org
To: max@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,agordeev@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 23 Jul 2026 15:08:43 +0000 (UTC)

--===============0920127468740527574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> s390/bpf: Add emit_ldx and emit_stx functions
>
> Add new functions for load and store to reuse
> them in the load-acquire and store-release logic.
>
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>

This isn't a bug, but the changelog describes the commit only as adding the
emit_ldx()/emit_stx() helpers for reuse, while the diff also makes a couple
of functional changes that aren't mentioned.

It drops the arena atomic load/store rejection from bpf_jit_supports_insn():

	switch (insn->code) {
	case BPF_STX | BPF_ATOMIC | BPF_B:
	case BPF_STX | BPF_ATOMIC | BPF_H:
	case BPF_STX | BPF_ATOMIC | BPF_W:
	case BPF_STX | BPF_ATOMIC | BPF_DW:
		if (bpf_atomic_is_load_store(insn))
			return false;
		break;

and it adds new case labels to the BPF_ATOMIC switch in bpf_jit_insn():

	case BPF_STX | BPF_ATOMIC | BPF_B:
	case BPF_STX | BPF_ATOMIC | BPF_H:
	...
	case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
	case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:

Would it read more clearly to mention these gating changes in the changelog,
or to fold them into the commit that adds the load-acquire/store-release
handlers?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30016652277
--===============0920127468740527574==--
