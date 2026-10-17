Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1F356A12;
	Sat, 17 Oct 2026 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257416; cv=none; b=dBuHRE/YovV5ok89ybrmt2utMHAgDqcU4bVZ+CZoSVjsZTSmWuJOOFzdDmrh8BXnTOOBbz/d7BaiKRlF+muRXBvLcoWAt41bLLeZbjHIs+3jPtRg03x5oPtiXQf0G/IBL4K7NkqD+bpPo2EmIvjI6WrxxXdFDt9JDUknXVRHRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257416; c=relaxed/simple;
	bh=TaaEVMzevsZhEmqw8t1aGOBiLT/97tPSNPNQnTvr4A8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E0hOYVP7S6Tk3k/Tm2o8hZxl7H5rFMNZCI8l/pVA56UkhdMdwREWhG+u2Y3AZz5epTD+TlSsCjNwEUfo7DQddSgUaS2YQ+3qKWJ9lKfwkeo4u+U5jwIHHZwftmLvUUQC/21Mu9CrIrZme4S/p9l8jeNBpUn/J7w/zTbzDU0wMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aluooGTF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aluooGTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DDD1F000C4;
	Sat, 17 Oct 2026 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257415;
	bh=/Awz1trca6AJ0hj9ylQGqWXY+N/A29yJ1M6KPr9eeDc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aluooGTFLpOcORZMBMurQUWqVaJgBzFL1T+GBQ1VZjIoGM43DK/lshrqlnt8M9qEQ
	 VmqMKPmiGGLUOFZmq+Hy944Q+G0qFrIdjPQtSBcxfS4V8LgSGPbStRWMTrdx+szz8v
	 OAGXuDLf+e6ye+QOx7IF3IOJV9b+8VubTp0eGpmi6MJOrw3SJRve5cfcQed82Oj+hr
	 6WNPUTPWXfNy5ltChdWE6WrdVIsbgU32Zgrt+FhTR+0b1yvDoziPjJx9/bRiXivoy4
	 qmiSHCfg3cjadVGLqhLK1TWKKKUNcBbykomNRIHkkAOxVXhsFsDavpsknc8/IGLNrg
	 3j7w+1cTX2Mkw==
Content-Type: multipart/mixed; boundary="===============4803198174632980664=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <41340e606021ab347abfe39f2d2ea81204880f85f7d1f6e8997445e0976c16ec@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-43-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-43-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 42/43] bpf: Use memmove() to store bytes in an skb
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:16:54 +0000 (UTC)

--===============4803198174632980664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Use memmove() to store bytes in an skb

TL;DR: The commit message claims all other dynptr kinds already use memmove(),
but XDP dynptr writes still use memcpy(), so overlapping slices may be
corrupted the same way; should the XDP store path change too?

>     bpf: Use memmove() to store bytes in an skb
>
>     Through bpf_dynptr_write() and bpf_dynptr_copy() the source of
>     bpf_skb_store_bytes() can be a slice of the same skb which overlaps the
>     destination. memcpy() then reads bytes which it has overwritten already. On
>     x86 with FSRM it repeats the first bytes of the source instead of copying
>     it. The other kinds of dynptr are written with memmove() for that reason.
>
>     Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
>     Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The sentence "The other kinds of dynptr are written with memmove() for that
reason." doesn't look accurate for XDP dynptrs.  Is that statement correct?

__bpf_dynptr_write() handles the cases like this:

  - LOCAL and RINGBUF use memmove()
  - SKB_META goes through __bpf_skb_meta_store_bytes(), which uses memmove()
  - SKB is fixed by this patch
  - XDP goes through __bpf_xdp_store_bytes() -> ____bpf_xdp_store_bytes():

	ptr = bpf_xdp_pointer(xdp, offset, len);
	...
	if (!ptr)
		bpf_xdp_copy_buf(xdp, offset, buf, len, true);
	else
		memcpy(ptr, buf, len);

and bpf_xdp_copy_buf() also uses memcpy() for each chunk it writes.

bpf_dynptr_slice_rdwr() on an XDP dynptr returns a direct pointer into the
xdp_buff via bpf_xdp_pointer() whenever the range lies within a single
buffer, and that slice is accepted as the ARG_PTR_TO_MEM source of
bpf_dynptr_write().  Can a program then do this:

	p = bpf_dynptr_slice_rdwr(&xdp_dptr, 0, NULL, 64);
	bpf_dynptr_write(&xdp_dptr, 8, p, 64, 0);

and reach memcpy(ptr + 8, ptr, 64) with overlapping ranges, which is the same
failure the commit message describes for skb (the first bytes get replicated
on x86 with FSRM)?

bpf_dynptr_copy() looks like it can reach the same thing when the source
slice is direct and the destination range spans the linear area and a frag.
In that case dst_slice is NULL, so __bpf_dynptr_write() runs with src_slice
as the source and bpf_xdp_copy_buf() memcpy()s the first chunk over the
overlapping linear area.

I didn't find a later commit in this series that changes the XDP store path.
Should bpf_xdp_store_bytes() use memmove() for the direct case, and
bpf_xdp_copy_buf() use memmove() for the flush case, or should the commit
message stop claiming that all other dynptr kinds are already written with
memmove()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============4803198174632980664==--
