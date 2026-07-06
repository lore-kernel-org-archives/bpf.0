Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D033AF64B;
	Mon,  6 Jul 2026 04:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783312201; cv=none; b=NKTVmcycdiTHbs+8F7KHCYk5eNwc9Yl6yEW2vLlYE1McsLVU+L9OYUcETIrHqROwuUYP+1s7QWJjF+lGTw6fEMFBad3zw+02m5+TnkdxY9nlOc2qmtXlgNH1s6ycsFabYw6EgLTGelCvZ6aX52r81q53L+jQXBoo5qzGM8RADD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783312201; c=relaxed/simple;
	bh=14xwxpHQ6FQZgu8Ro+DaM7PM/rNhKtJ0s3lSW9tvqt8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=h3Favo4L+1d4ymyfbBX1ByLFWOgyZfX2o60jIl6iBcNtDLMxeLYw9xuMgNEwVDfXuiTJhvARuSDODReio27dr3lHa9RwAl5iV+wcPd7mZSRZWds3vRCQbLrc0vV12OC/qbkr3/bPR8LzCag6KWB1KsxG/DzWNEnPNrEDqS/lgjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsIakXfI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsIakXfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6869C1F000E9;
	Mon,  6 Jul 2026 04:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783312199;
	bh=7nrZmdNVQZBLHesxScverq1xXuC0sK/kImN4oqVF4rE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XsIakXfIHhodIfDvR5j2xdwiYWXYCx2lHu+8yKm4xUhRwymTageNfv8EodKVsNQ/e
	 PjKL6VOJAmslv5CTZ5euJdumCaXKl/OkyuSJTgsWe7Omr4ZgSGM3R3DaXDYMoDXTAu
	 be1hSHWQAXht7JyOo77KIe2J+YMGSEdM0XeYj205wlRapqszBSJHx08M+JDzqdPXjq
	 0DNNoikr422sdMDacHWhLa0/NtdC4NjLKNg41HYq/GHDN3qBZQaTT7DlO7U1PAVx1J
	 4WIWGGs5GHA/UgSor1zFMtcrgBuy0XIjZM4iysSY/ld1iCjqL8Eq7cB7yleOTo3f8w
	 1uyD4Lfd9PMIw==
Content-Type: multipart/mixed; boundary="===============2104253922922447403=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20c6156293d46e6515a98030194624a58d25b9ca4771a7a48d99a466edd3b9de@mail.kernel.org>
In-Reply-To: <20260706033906.1988-3-yangtiezhu@loongson.cn>
References: <20260706033906.1988-3-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2 2/4] LoongArch: BPF: Move arena register slot below TCC context
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Jul 2026 04:29:59 +0000 (UTC)

--===============2104253922922447403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> LoongArch: BPF: Move arena register slot below TCC context
>
> Currently, the stack layout places the optional arena register slot above
> the tail call counter context. When arena_vm_start is dynamically enabled,
> it shifts the relative offset of the tcc_ptr slot within the stack frame,
> causing hardcoded tracking macros to mismatch and potentially leading to
> memory misalignment or corruption.
> To fix this, move the arena register save and restore sequences below the
> tail call counter context slots in both build_prologue() and epilogue. It
> needs to update __build_epilogue() to insert a proper offset decrement to
> safely skip the unneeded tcc_ptr reading block while accurately aligning
> with the relocated arena slot at the very bottom.
> With this patch, the tcc_ptr slot is always positioned at a fixed distance
> directly underneath the base callee-saved registers that is independent of
> whether the arena features are on.
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

This looks like a fix for a memory misalignment or corruption bug affecting
arena BPF programs.  Should it carry a Fixes: tag?

The buggy stack layout, where the arena register save/restore and the extra
stack reservation sit above the tail call counter context, appears to have
been introduced by:

  Fixes: ef54c517a937 ("LoongArch: BPF: Implement PROBE_MEM32 pseudo instructions")

An independent fix for the same root cause ("LoongArch: BPF: Fix tail call
count pointer offset for arena programs") carries this same Fixes tag along
with Cc: stable, so a stable backport may be warranted here as well.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28766636714
--===============2104253922922447403==--
