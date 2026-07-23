Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE703E8326
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792653; cv=none; b=EArZ6JVLFMCZvPz7mhg94QLW7so8dDhBfcbnf7yxa4G2/jdWAGocQWDxh3WSpv9sdvl8qQCiAu+M0A9jS3CaifP3ncMJcpO3KnrkEVjg30ugCTrsB0ZzcQA9IxslChpDLo033kuAC6vIoMhjxl8+M+53bnKC7WIHEy9hTB8C+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792653; c=relaxed/simple;
	bh=AUQShpvVYkVdfDylf0eCezCjD+VTNo2HJw+12MEdcOA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=exZjzAvFJkAFLZj8KvpgF7prJBcyCk5psPolY/cKfD1HfoKf8wkT4K896SZ5R8r/Kj4op5dZqs6AMumIZCR1s1NnTEWIOzBSmx87ALp/zofx3RqJVDKN14J2WNEazvMBRXZl+4NI+SC1Pk+KZAxqNcBdWirxwVodoF49pspoV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMIWjObF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMIWjObF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2594D1F000E9;
	Thu, 23 Jul 2026 07:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784792651;
	bh=iP7e3XskoOpRE8wTlj2RK99yn8vhCFpAHO0XTp/Y69c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MMIWjObFb7i+SdX+pNs0Nxj0BDpJsKg1maJCwkZIOzp0t57jv/cFqHqRaoeGcxB3S
	 W9S0WrQH3WLIRtB7lg97IZ5uAE6+HN2gdZ7q3lNWF0xsIjvVmLTkzZ3Zds1eNiD8uC
	 Tw6xknVn8NdNvYdZkJhI4PxVioP7qro6MHAijMbNkKBU221omdg83FthOJ6vPBWJ23
	 LxJm+y/kHzRLBPk5RW0hcVk1hIMgM8FTttsRMtKYY8GIp2QNi54uxmz3RDOTNlrBxb
	 5nKvnDzVfPU/eRXumJGytD5rIk7TtyG50XtWfNlO52EdBObJ7zJnhuNLqH6tTAH8r7
	 thF0tV9xmNmBQ==
Content-Type: multipart/mixed; boundary="===============8538583925526871699=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9914054c2fd15d10d4782c57e3f37f7f5625973597b3a43977545f7b2402ff9e@mail.kernel.org>
In-Reply-To: <178478913040.2.14225985431891987705@digiscrypt.com>
References: <178478913040.2.14225985431891987705@digiscrypt.com>
Subject: Re: [PATCH] libbpf: bounds-check struct_ops member offset before writing shadow pointer
From: bot+bpf-ci@kernel.org
To: naveed@digiscrypt.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 23 Jul 2026 07:44:11 +0000 (UTC)

--===============8538583925526871699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf_object__collect_st_ops_relos() replaces each function pointer in a
> struct_ops value with a pointer to the corresponding struct bpf_program
> in the map's shadow data:
>
> 	*((struct bpf_program **)(st_ops->data + moff)) = prog;
>
> st_ops->data is allocated with malloc(type->size), so it is exactly
> map->def.value_size bytes long, and moff is the byte offset of the
> member being relocated. The only bound placed on moff comes from
> find_struct_ops_map_by_offset():
>
> 	offset - map->sec_offset < map->def.value_size
>
> so moff can be as large as value_size - 1. The store above is
> sizeof(struct bpf_program *) bytes wide, and nothing checks that
> moff + sizeof(struct bpf_program *) stays within value_size.
>
> libbpf's BTF sanity check does not validate that a struct member's
> offset plus its size fits within the struct's declared size (see
> btf_validate_type()), and this relocation runs at bpf_object__open()
> time, before the kernel validates the struct_ops type. A crafted object
> with a struct_ops struct whose declared size is small (e.g. 1) but which
> contains a function-pointer member near the end of (or beyond) that size
> therefore makes libbpf write up to sizeof(void *) - 1 bytes past the heap
> allocation - a controlled heap out-of-bounds write reachable purely from
> opening an untrusted object file.
>
> Reject such relocations by requiring the whole pointer store to fit
> within the map value.
>
> Signed-off-by: Naveed Khan <naveed@digiscrypt.com>

This fixes a heap out-of-bounds write, but there is no Fixes: tag.

The out-of-bounds store here:

	*((struct bpf_program **)(st_ops->data + moff)) = prog;

looks like it was introduced when this function started writing into the
shadow data.  Before that, the relocation only wrote to
st_ops->progs[member_idx], so the heap write past value_size did not
exist.

Should this carry:

  Fixes: 69e4a9d2b3f5 ("libbpf: Convert st_ops->data to shadow type.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29987958246
--===============8538583925526871699==--
