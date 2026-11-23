Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470363;
	b=LRssvx97Jd77pb3Vmm8wAW1Ne2ZuPGFhyZCZQXmUfS2gN5CE4UwIl1o8K8rIYctR314A
	 g969cuoekElyllcuYVDo5Sf7beHK3whohcIWhQKFN0exyip0m5lPaxxsKc9/dpAOh9sbp
	 3K18McMzBypc2KXgWGRsfRwBjqowfgaCjyN6jdoM/gzrIMwdtzmcRBtTYgIb+Vn23pnmT
	 VXU6SmLUmL9u/xYnRGZoV4AYG1xkLj9r7sjAdZy0NDlRMK1KIEek8dhQVNSqa/bLy7OzT
	 panEzvPSaDd+cVV6gyUz9qmc6dfS5uNNCe375RuI0H5Crt6nw+e1QKLHwlcYu5zAN2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470363;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Shz0vFbMZApQHnxXjuMygFvUH5u2IdlpvjR1eoSsZKs=;
	b=UejTAxu0ozrtb3NcmB6JSjR7kTCJp0LwMwRRgZV0X3u+okXiqRJzIEGOrxLHwQ9yZLwV
	 UrWOAEwQ86t3Z+PBzQtWJq7hk6bzcY3sy9Ot/FJM+CacxwZCr6umGeuCCaQHup7gLShw9
	 M1X0Pa/dS3p0iL4oy0s+rrXgga2Xm2PqUupFoBhXMjUcN7idCX7Z+9HL+OLZTo/koC0ik
	 /e+bf6YorKKn0CTt2EB2u7GMLtipFE1ll3tiNFyU5//5grKExLlc2+9dagJAyWpUVpByc
	 rRqjyvgIohVidIqSp6t3UVeg7aSbHx686FH9S8d/VSleNcy/fLzq3HnZzpBgE+QcCxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cct16vwW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C4606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cct16vwW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99981F000CF;
	Mon, 23 Nov 2026 21:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795470362;
	bh=Shz0vFbMZApQHnxXjuMygFvUH5u2IdlpvjR1eoSsZKs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cct16vwWJKUs1vpiOrbk+vDNZPNIUmVCDRfScoNVcjBBJ4i9s/s9qgTHLV9u7A6AA
	 J6j7Huq6hCLx+CwLF2oQmKlYBwwfUSo2DvFmir9ZX5poaFKnC6cEmqFvAOQx92ZPFn
	 3jTLjJG7dJ9wlhPQtFNCKGkmyCgkj30KMjcEMIgXV8gHX6pEllspkJisJbcw1Yhu2F
	 UlOwM2Kc8CpsRmtfwnSefkk92MdskY7XFdIGo/l/CnI4vHdG66flIVpiZmxQHkbgyO
	 exSbdsq8zbvvoctMZw38Zvcdca0OmX7aRzHA7bzLGYdwBWJrOVDD/ib64v9vcJqeTT
	 tzevIq5c3t2WA==
Content-Type: multipart/mixed; boundary="===============7243962787031392501=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1cdc66100171336f5021638b5b309f3cd5e1852bed647573797a73a1f6ced776@mail.kernel.org>
In-Reply-To: <b9243eaf40e91eb71994fce04d45ca91f1740c86.1795467315.git.memxor@gmail.com>
References: <b9243eaf40e91eb71994fce04d45ca91f1740c86.1795467315.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf, docs: Document the overwrite mode of BPF ring buffer
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: xukuohai@huawei.com,tamird@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 23 Nov 2026 21:46:00 +0000 (UTC)

--===============7243962787031392501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, docs: Document the overwrite mode of BPF ring buffer

TL;DR:
- Docs claim overwrite-mode reservations never fail, but they may still fail
  when the oldest uncommitted record would be overwritten
- Consumer procedure may lack read ordering on weak CPUs and busy/discard bit
  handling

> diff --git a/Documentation/bpf/ringbuf.rst b/Documentation/bpf/ringbuf.rst
> --- a/Documentation/bpf/ringbuf.rst
> +++ b/Documentation/bpf/ringbuf.rst

[ ... ]

> +Overwrite mode
> +--------------
> +
> +In a ring buffer created with the ``BPF_F_RB_OVERWRITE`` map flag, reservations
> +don't fail when the ring buffer is full. The producer overwrites the oldest
> +records instead, so the ring buffer always holds the most recent data.

Is this strictly true?  In bpf_ringbuf_has_space() the check

    new_prod_pos - pend_pos > rb->mask

returns false before the overwrite_mode shortcut is reached, so a
reservation still fails (returns NULL) when the oldest not-yet-committed
record and the new record together span the whole ring.

Overwrite mode cannot overwrite a record that a producer is still working
on.

Could the text say that reservations don't fail merely because the consumer
is behind, but can still fail when the oldest uncommitted record would have
to be overwritten?

[ ... ]

> +1. Read the overwrite position and then the producer position. Start at the
> +   consumer position, or at the overwrite position if the producer position is
> +   a ring buffer size or more ahead of the consumer position. If the start is
> +   the producer position, there is nothing to read.
> +2. Read the record header and do the check in step 4. Use the length and flags
> +   of the header only if it passes.

Should step 1 say that these two loads must be ordered (acquire or a read
barrier)?  On weakly ordered CPUs such as arm64 the two loads can be
reordered, which breaks the ordering the kernel relies on; the kernel's own
ringbuf_avail_data_sz() uses smp_load_acquire() for both.  Only step 4
mentions a barrier.

Also, step 2 doesn't mention BPF_RINGBUF_BUSY_BIT or BPF_RINGBUF_DISCARD_BIT.
The record at the producer position is reserved but may still be busy, and
the length has to be masked before use, so a consumer following only this
section could treat a busy header as a valid length.

Finally, the batching paragraph needs the first record's length to find the
next record before the step 4 check has validated it.  Doesn't that conflict
with step 2's "Use the length and flags of the header only if it passes"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45270351590
--===============7243962787031392501==--
