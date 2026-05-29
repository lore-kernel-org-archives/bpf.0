Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0B1BD9D0
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050006; cv=none; b=udPBxtGW33v8ZyqUIdj4Q57vseIKTGuNIChTMKOF/RtcRQ8LQjdcAflbjJXYU2uVWVuC7A+vmXBnHG77IPofqoZTvJCz/o+ptgGlFXkt/9v6C/DEKIp2DXSbj+LC3o5sI+oOp9h0IviM5qn7UVtF638wvAthlnVryFBT9MB6MH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050006; c=relaxed/simple;
	bh=T16OEqhUQcbXNgiccH8Z3tE4Yz9Sgeozl7tYVw51dxQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WdlT51DV66E8kidOvu+m/21NKywlw4mC69vW7w6p9yaYUEowb3qO+rqbGl3ad/VLVvl4sfRuQ7uiiAndwn3AxPzKC+nvzaG/iS6ahLg5e75VLiQgM/dKNvfHnuoWg3RdH5FclVKA7q0iIQPn30ZepahKwzbJ+5dYfN+BoDv1EQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYhPyiId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYhPyiId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE3E1F00893;
	Fri, 29 May 2026 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780050005;
	bh=vNWQfIT4VlJz6Li4T9/W4/ZFZLNPEHU6h5AajwH/PLQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EYhPyiIdK9wp0GlBGNC9jhGTQWKzNTreOYhc1dSAdub0c1XV2GvfWHtk3X2mvIOE4
	 GU7D5Ja6DfMbwbSzBFJ8A8Hs6FgED0YQhdjv1qgLhzdtwKqPVZ785sW0N1wrJaepoM
	 I7QFliolnpBHNYvmIY8CG8ExZ2kIIb45+SMNHY5edkxQNRiF3ecUIB/JfsWYLSBqgE
	 C0/ynZ2EPnJBjsSCVic5QVIlCxLYIRHUuOOrnR0oUMmY/lQ/BDEVi3lNVXVBw7+LJM
	 yNj2c3ANlYQdstrn/7mrOvoDnTD9HUJW8OW47SjYW5Bd0PeNk90rXe7xPsiHw24FKR
	 joLD+z672hNxw==
Content-Type: multipart/mixed; boundary="===============8873764150233708925=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8c91178b95448fccb992b1430bf09c7852a06dd28dbeb322cc69a7a1d8868c93@mail.kernel.org>
In-Reply-To: <20260529094119.307264-3-daniel@iogearbox.net>
References: <20260529094119.307264-3-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Also reset {insn,data}_cur on realloc failure
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,kpsingh@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 29 May 2026 10:20:05 +0000 (UTC)

--===============8873764150233708925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     libbpf: Also reset {insn,data}_cur on realloc failure
>
>     realloc_insn_buf() as well as realloc_data_buf() free and NULL
>     gen->insn_start / gen->data_start on -ENOMEM but leave gen->insn_cur /
>     gen->data_cur pointing into the old, freed buffer. Just reset the
>     cursors to NULL alongside the base pointers so the freed state is
>     coherent.
>
>     Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

This looks like a fix for a real bug where gen->insn_cur and
gen->data_cur are left pointing into a freed buffer on -ENOMEM.  Should
it carry a Fixes: tag pointing at the commit that introduced the
free()+NULL handling in realloc_insn_buf() and realloc_data_buf()?

The exact SHA could not be determined here, so it would need to be
looked up from a full bpf-next/torvalds tree.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26630703706
--===============8873764150233708925==--
