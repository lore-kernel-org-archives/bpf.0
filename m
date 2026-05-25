Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C652AD2C;
	Mon, 25 May 2026 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751055; cv=none; b=HwelAKSyIfjIxomJrtBRgEY/pLTxAziOiv3xeccSGTspCKQTnhqUhag2SdpC7Qo2YwjLAM2tcGjjsZRkSFMFm1WVVKOFce/dHIEXNSYAFVxseBVaTczmf+zajh/5LLdInnjhsUjr1CqprUWGghiH0QHVpF+SKArkPThBUjYsWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751055; c=relaxed/simple;
	bh=+gZCWH6NmPkj93kThXkzkE8RXtU+epCU76X8ys27mVI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=INkPlC09d/d39NfmNFw4KTJMjMy5YPp3oOf5yDboHBt9jFvQNCQhxxMw8jPtxkqCv4ICO6NhZn/wAgcBmIVXaSnQFLUVJrBc0//TZmU4iPQBkRHhO3x39Mq92zQ4hsZYkxKOeaZ/eObFORHsUjs8jrVJXfKdPr6N8sVyhPrLkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W12NhCIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W12NhCIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC461F000E9;
	Mon, 25 May 2026 23:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779751054;
	bh=Dwl6ydZM/8zB2TIBPrd8gXE7DHTIdqyKikZ8RPJEhb8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=W12NhCIia7qpznW+As4LMNmwpyibjCxLdWCIJi8MjkJ7NGUIqLY5vBxkYfcmzoH7+
	 dtSZv1F0ejP558VPDR04kuK4vvn0CtEgIknYCp1yk0Ni/HM8LFkiXZ1z+9Y0gY400V
	 RjUVQDtOWUKj1bjBegoCH9uI4zSb352EUzETT7wbxP+wXv1jxOPWKIgugqf0dDXBDH
	 ctsqgRSSG3Zp8U33hiT//lA5jlI6knnes3Hf7iT0u4FzYzGLlRB7UrQZWXv0GAK7Ad
	 Ofw4qD0Gv8C0C4Jm8cIAM0GnIMkaakUvhvGWGUWwwPKR3xl7icYYAwt2ieqw98HCjA
	 33u/FmSG+R3Rw==
Content-Type: multipart/mixed; boundary="===============3593931110788409390=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d08bc35721d0745ccc6f281763df6bf8b638883399746f401594dff72eee805e@mail.kernel.org>
In-Reply-To: <20260525223948.1920986-2-ihor.solodrai@linux.dev>
References: <20260525223948.1920986-2-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Factor out stack_map build ID helpers
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: puranjay@kernel.org,shakeel.butt@linux.dev,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 25 May 2026 23:17:33 +0000 (UTC)

--===============3593931110788409390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..e23be7d44503 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -152,6 +152,28 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
>  			 : build_id_parse_nofault(vma, build_id, NULL);
>  }
>
> +static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
> +{
> +	id->status = BPF_STACK_BUILD_ID_IP;
> +	memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
> +}
> +
> +static inline u64 stack_map_build_id_offset(unsigned long vm_pgoff,
> +					    unsigned long vm_start, u64 ip)
> +{
> +	return (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
> +}
> +
> +static inline void stack_map_build_id_set_valid(struct bpf_stack_build_id *id,
> +						u64 offset,
> +						const unsigned char *build_id)
> +{
> +	id->status = BPF_STACK_BUILD_ID_VALID;
> +	id->offset = offset;
> +	if (id->build_id != build_id)
> +		memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
> +}

In bpf_get_stack(), the destination buffer can be a BPF map value that is
concurrently readable locklessly by user-space. Since the buffer initially
contains the raw instruction pointer (ip), does setting status to VALID
before writing the offset create a data race?

A concurrent lockless reader polling the status field might observe the
VALID status while the union still holds the raw ip instead of the correct
file offset, and before the build_id string is fully copied.

Prior to this patch, the offset was written before the status. Could this
reordering of assignments cause concurrent readers to observe stale data?

This was raised by sashiko-bot in v6 review and acknowledged by the author
as needing to be fixed in the next version, but was not addressed:

https://lore.kernel.org/bpf/20260521231600.E14FD1F000E9@smtp.kernel.org/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26422948694
--===============3593931110788409390==--
