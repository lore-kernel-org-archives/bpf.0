Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF252C11CB;
	Thu, 18 Jun 2026 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781756382; cv=none; b=IDMKMpJMRqYfHaaAtuU78YHyqHtO2x5GWWmtyG+MjvArkvp0ZafWYWRyfYrPFyuU+aI6XJeTXwEGvljlWoyK7nyh2SWhUV+KWTu36mVQ9h+52d8IHcHcMesvJYrLXmMKgaDbTt/BcElTATuZRXL3/guzIRLhV+Po6HUXcbbA5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781756382; c=relaxed/simple;
	bh=1MW4VNkbZyVG64tjfqXLS8sUktdXvdrJeVTDqNjx+ms=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dtguD+husvpAz4PIrNwQ/eTSLkPnPCfeeVQppCgknqpfS+nooCyLIt3Z8feo9iPRCr9ud5OOTrouWHpJXNg2AyYEFkFChrtY8N6QNedTwiwQC9L1tpTUbmKNiMYsi0qoxQiF2IZB17cvS+oq6iUlylUNbffgLo0mZQpmDLOhUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1sLS9hX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1sLS9hX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4951F000E9;
	Thu, 18 Jun 2026 04:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781756380;
	bh=ROVddDfOyk8zu86ME/wG6+AbO6JfOCq+Z2d8XvM+8G0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H1sLS9hXMgSJ35QGbWdZFXbC2Wb91YkGd+c2CuTjTaPissvSOu7A1brYYYDav2CwF
	 CcWeUf99ka4Zl1VAMjc1n/jAIJQVNoRpICyyXCPvmvCLBQnKcPk/4y4xLzimVgdQBb
	 ebb4iMTSdlaZxGnN+yuiSbKpLtrIxAUKX9ZwdpHTFq3Mxg0wuomrS+XBco8/oaH3iv
	 BvnRptt2zx8cyecCITzzSE6oxRq5+OvfZWAvMYdaL6jZv57kBCVqi6Rwb3Eh3puGOe
	 OllBBT2i8xRP7842uAynv0JUiNotuy0DuLQgmIhHhfF+N+ChocaG89icNXwM9Wk/89
	 Q8j7jsAUQRkWw==
Content-Type: multipart/mixed; boundary="===============3276329233012674368=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7e996535cf04f95d2c4e54b1173f4e2d0a96102c737fe030decc432164df97a6@mail.kernel.org>
In-Reply-To: <20260618033809.98253-2-dongtai.guo@linux.dev>
References: <20260618033809.98253-2-dongtai.guo@linux.dev>
Subject: Re: [PATCH 1/5] LoongArch: BPF: Gate unsupported arena instructions via bpf_jit_supports_insn()
From: bot+bpf-ci@kernel.org
To: dongtai.guo@linux.dev,chenhuacai@kernel.org,yangtiezhu@loongson.cn,hengqi.chen@gmail.com
Cc: kernel@xen0n.name,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,loongarch@lists.linux.dev,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,guodongtai@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 18 Jun 2026 04:19:40 +0000 (UTC)

--===============3276329233012674368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     The JIT does not implement atomics on arena pointers (BPF_PROBE_ATOMIC)
>     nor sign-extending loads from the arena (BPF_PROBE_MEM32SX). Without a
>     bpf_jit_supports_insn() callback the verifier assumes both are available,
>     so such programs are accepted only to fail later in the JIT with a
>     confusing -EINVAL 'unknown opcode'.
>     Implement bpf_jit_supports_insn() to reject these instructions in the
>     arena case. The verifier then rejects the program early with a clear
>     message ('BPF_ATOMIC stores into R<n> ... is not allowed' / 'sign
>     extending loads from arena are not supported yet'). Regular arena
>     accesses (BPF_PROBE_MEM32 loads/stores of all sizes) remain supported.
>     Signed-off-by: George Guo <guodongtai@kylinos.cn>

This looks like it fixes a gap that was introduced when arena support
was first advertised via bpf_jit_supports_arena() returning true.
Should this carry a Fixes: tag?

  Fixes: 4fdb5dd8aeba ("LoongArch: BPF: Implement bpf_addr_space_cast instruction")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27735575341
--===============3276329233012674368==--
