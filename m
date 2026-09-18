Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6F35E1AA
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710266; cv=none; b=Q/+2WBnXVDkCkkzvvKorKq+mwI59Dzfr+zoE/qhk5PS2q4NGT0HNlk7FVWANLX9+wzjZYobyhBCtLplHSuDfd+gBfdeu2IgbRAGQGOpDm3N9s/IqWn5m6O6xgYO6P46v8mJzqVCCiPiJwSXywGFV3GFdErbXoggDCA24QeGpbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710266; c=relaxed/simple;
	bh=Ym1Ke40+CqchxgZizU+H1YWqAxH85v8kaoi99ZDnJzk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QTybFpwhIuTSRagOQjpa9HgspyrzM6amRrClS1jmDOf6AK6g/L4X/1RSmCxZExXf+YxfCMYipUN9mFiYc3fXI1ZfBy3/Wgy+dgoi9/Y8DWoFyZY7Cz0LcLnjw7sRAw0PeupyXlE0Axg0DmmoYeNA84m+Lrz+8WsJb7Hb/8XOqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P51R6HcP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P51R6HcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C491F000FF;
	Fri, 18 Sep 2026 05:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789710265;
	bh=+RQqZHMWYfmCXuU+f7wudR7bhNQx/GQLZpqYw5v025s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P51R6HcPWX9Rcva2qvWB1/t3CkNZ6ZzRPhnstST31CbrS5GJqTkwcKyMeDg8RHb2p
	 ZpiZ0UICep40l9oUlZ6Y4HqENMliLOYKgMg0fN+CfpfeAo+l/MLqtVJndxjVGq+6gA
	 DAQcVEMnO8ROghXmLCxA1n5bNpFUrUP8CJYslwbUfqKxJ6CoBIhH4Ft7jQctC7RMIK
	 fc6Ij6ti23oaTrNfLcSnfv45DPWvMdPfeV6HWFehJv4gq8N++poloPk9vCx2DRd5OV
	 NKdQZx00n2LEEqTdIUrBC2dTyLKMcynxCCbsK6fOoAhQpY4kRRkGUXLpKRa4fBbqXp
	 lUOzYNcGc0juw==
Content-Type: multipart/mixed; boundary="===============7043387562189552099=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cf4e0c0bad4199fe7d97ba1fad39634daa6852dbda2f5292912e5d880523f963@mail.kernel.org>
In-Reply-To: <20260918044327.3292986-1-yonghong.song@linux.dev>
References: <20260918044327.3292986-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 17/20] libbpf: Let the static linker carry .bpf_cleanup relocations
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 05:44:24 +0000 (UTC)

--===============7043387562189552099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> An object that carries a compiler-emitted exception cleanup table cannot be
> linked today. The table's fields are byte offsets into a code section,
> materialised by a 32-bit relocation against that section's symbol with the
> offset itself as the implicit addend, and the linker rejects both halves of
> that: the relocation type is not in the list it accepts, and a relocation
> against an STT_SECTION symbol from a non-executable section is an outright
> error.
>
> Both spellings of that relocation have to be taken. LLVM emits
> R_BPF_64_NODYLD32 for a .long against a section symbol; GNU as emits
> R_BPF_64_ABS32, which is what bpf_reloc_type_lookup() maps BFD_RELOC_32 to.
> They describe the same value, and the selftests are built with both
> compilers.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for objects that carry compiler-emitted exception
cleanup tables. Should this include:

  Fixes: 9f0c317f6aa1 ("libbpf: Add support for new llvm bpf relocations")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711
--===============7043387562189552099==--
