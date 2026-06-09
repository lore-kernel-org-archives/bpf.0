Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57FC4ADD97
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041337; cv=none; b=kg2hxIoajTgk9z82O8WpvWKKSd9973usMCD+2SS6AKVKML+Xwr2MJPG5PJgc69Y8b15OdKJyo/OTcqxuQ0YeXAkEw/lHgoqYxPXfTMQ5/HuvacIXZDgIJocLleZJb6kZ8pXMtOe0D15yAm0LYU8yCJY6enehT/T7IppVt6TFF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041337; c=relaxed/simple;
	bh=1SJs+iXm69SIEJj9m43EfR+G/js5pI7b1TsOG2jusl8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ViZ4BP9tA3sThjCopnj3y+y5bvMp8fzI2Yl/vb6qrSQVziXJl1CbJAaA/EdP33x40B7sif6biGtbeTO4Mz+UBZ1m21OGxrKgKezaRHHRGV4UFyg2uHZT0+S2IecS/CC2GAV1pYdbRmZ1ux0iae4vvWPYPcW5hJHA5cFutTq5LRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXXWB1al; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXXWB1al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD5C1F00893;
	Tue,  9 Jun 2026 21:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781041334;
	bh=+fGecr6NxJ3jrezj+Upvz8j57HcK9lYPChFlt1KRYQ4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZXXWB1alraJXIB/0XG5mX5dT3/rTQbwEYRT/AyOFDfZsIKiy/ywVaDIrGB01d+MhO
	 k/8rzZINqwH/VyxcQ8E183bTarrgDODsnvHBgYra1ppZiYbcHR8KgV/t6aDbFQvKgp
	 3Zr/bQ7RIVSxOk/BZ9C6VMSvnoogDQG7k2PRKMrNVeqOLOGLVRp9EK6kbzSaY/cnAZ
	 TihWUIDCI3N4HpyEeC/WquFO6EOiKOvPM0PVYCymcfJrP+/kITHfJqnFEm8jfqrNGz
	 eom/Px0UD4rP+5vX0emb6+0rZ8ZMfgkah9/zd2f4L327T42kSBYV5muBjPjSHK1yBk
	 QnQeZm9MuEXKg==
Content-Type: multipart/mixed; boundary="===============7754677882750053490=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de6319304ab0d8e36a91ac7605f0d0c1ad0d95f2646a8c6b5dadefe0ded009fd@mail.kernel.org>
In-Reply-To: <20260609210749.3448062-1-ihor.solodrai@linux.dev>
References: <20260609210749.3448062-1-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1] bpf: Better build_id caching in stack_map_get_build_id_offset()
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org
Cc: bpf@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 21:42:13 +0000 (UTC)

--===============7754677882750053490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Better build_id caching in stack_map_get_build_id_offset()
>
> This patch is a follow up to recent implementation of
> stack_map_get_build_id_offset_sleepable() [1].
> stack_map_get_build_id_offset() and its sleepable variant each cached
> only the last successfully resolved VMA, with separate bookkeeping in
> each function. A run of IPs in a VMA with no usable build ID will
> repeat the lookup for every frame: find_vma() in the non-sleepable
> path, a VMA lock and a blocking build_id_parse_file() in the sleepable.
> Factor the per-call cache into a shared struct stack_map_build_id_cache
> with two independent slots [2][3], used by both functions:
>   * resolved   - last VMA that produced a build ID (file, build_id and
>                  range), reused to skip the lookup and the parse;
>   * unresolved - last VMA with no usable build ID (range only), reused to
>                  emit a raw IP without another lookup or parse.
> Keeping the slots independent means a build-ID-less VMA no longer evicts
> the last resolved build ID, so a trace alternating between a binary and a
> region without one stops re-resolving the binary on every return.
> The shared lookup tests [vm_start, vm_end), matching the sleepable path;
> the non-sleepable path previously reused a build ID for ip == vm_end
> (range_in_vma() is inclusive) and now re-resolves it correctly.
> [1] https://lore.kernel.org/bpf/20260525223948.1920986-1-ihor.solodrai@linux.dev/
> [2] https://lore.kernel.org/bpf/CAEf4Bza2fRDGhLQoPE-EzM7F34xaEJfi5Exmxb-iWVUN3F06=g@mail.gmail.com/
> [3] https://lore.kernel.org/bpf/CAEf4BzZXJFr=1iiVx937ht=4PYQkQHg=eFk810zhMDzXQG3ihw@mail.gmail.com/
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

This commit fixes a user-visible correctness bug in
stack_map_get_build_id_offset() but does not carry a Fixes: tag.  The
commit message notes:

> the non-sleepable path previously reused a build ID for ip == vm_end
> (range_in_vma() is inclusive) and now re-resolves it correctly.

The buggy code is the range cache check:

  if (prev_build_id && range_in_vma(prev_vma, ip, ip))

range_in_vma() is inclusive of vm_end, so an IP equal to
prev_vma->vm_end (which belongs to the next VMA, since ranges are
[vm_start, vm_end)) reuses the previous VMA's build_id and computes a
wrong offset.  The change replaces this with an explicit half-open check
(ip >= vm_start && ip < vm_end).

Should this carry a Fixes: tag?  The most recent commit in the available
history to establish this prev_vma/prev_build_id range cache (and which
contains the exact range_in_vma(prev_vma, ip, ip) line being replaced)
appears to be:

  Fixes: fc99547a8bda ("bpf: Factor out stack_map build ID helpers")

The inclusive range_in_vma() behavior likely predates fc99547a8bda,
which refactored the cache and added the prev_build_id guard but
inherited the inclusive check, so the true origin of the off-by-one may
be older than this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27236707090
--===============7754677882750053490==--
