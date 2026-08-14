Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF197470119;
	Fri, 14 Aug 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714265; cv=none; b=AaIC6+z4If4V8C9RnxZ1JisNQ1rLHf7xmjvBrx4FdJBd+fxEK3WuYBhbzMN84QzOeIQ1+NjlT/bOwtVLdZbvbCsYZlDB5iTC5Dg+NqrsaoSiJ3YQ2oybMFAq3P1PjKsfqvXZrrL934ke1BwDcpRPXH8xEnRsBD/wTV90VJNfUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714265; c=relaxed/simple;
	bh=N8BZiKj8YC2bEasdYQ0rNI19BXgjH4N5gGeOoO+SFqI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Wnd2ns5poytPTmMdqK9eOHtbhMvdv6msAGJ0Wtk8tr6dvCvY1H13ka6kNbib0iCUIhsZeNXjnCvXckxtBPMk3WfLDdkhkYPRT8RM9kMIzA+uQLbQWe4Ps13sw+TP6jI99MaD0wVHHGJilKFbZHZRlRN8l+ZztDxlyIlt+psA0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9+wZcpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9+wZcpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900BC1F00A3D;
	Fri, 14 Aug 2026 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786714263;
	bh=P2QMn998TtMQVkPrstQgLMw6hVm5GWE79c99K1O6GoE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=R9+wZcpAZxHjet6FA5GGnfzBIYM+pgRIQfhv2Bt6dK2eZWhG5kv+gmEKNA4bskUri
	 YThoY6PW4epK1AjZBCGhz7EXvETGmBqQ7RDy9WYGp59fpK7Y5r6deNJ6Yfg7b3YX2l
	 r0PMLInkFU7/Z0KHbCxbjLRBnFF0CZmleSB9HkZOAr8kOzHD7kqmHGwBkOxeNsGo7K
	 0NdnLpFkF/sQ8sDUlSUJSpHDKAlvkCPE/d/A9+EXUpQIG8cDnfu9+IsXhPH39ETbgm
	 JLUbXskCBHsQHl6qXAtCfyY990Wk74ni7OT6BMDD3MYqCNVCZPD//uebM78WMabQPp
	 e2Tm3m95LonrQ==
Content-Type: multipart/mixed; boundary="===============1951540970482262893=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a5403c5ca8cf7d13c0f8afaf2399a398a3d7e954be3986e7d6ae0a8c192161de@mail.kernel.org>
In-Reply-To: <20260814124843.22041-2-i.tellez@btesa.com>
References: <20260814124843.22041-2-i.tellez@btesa.com>
Subject: Re: [PATCH v2 bpf 1/4] bpf: Fix pending_pos walk on 32-bit ring position wrap
From: bot+bpf-ci@kernel.org
To: i.tellez@btesa.com,andrii.nakryiko@gmail.com,ast@kernel.org,daniel@iogearbox.net
Cc: andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,billy@starlabs.sg,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,i.tellez@btesa.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 13:31:02 +0000 (UTC)

--===============1951540970482262893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 35ae64ade36b..06d3cc192601 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -482,7 +482,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
>  	prod_pos = rb->producer_pos;
>  	new_prod_pos = prod_pos + len;
>
> -	while (pend_pos < prod_pos) {
> +	while (prod_pos - pend_pos > 0) {
>  		hdr = (void *)rb->data + (pend_pos & rb->mask);
>  		hdr_len = READ_ONCE(hdr->len);
>  		if (hdr_len & BPF_RINGBUF_BUSY_BIT)

This isn't a bug, but since both operands are unsigned long,
`prod_pos - pend_pos > 0` is the same as `pend_pos != prod_pos`.

Would spelling it that way (or `(long)(prod_pos - pend_pos) > 0` if an
ordering test is meant) make the intent clearer next to the
`- ... > rb->mask` comparisons above?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31802836964
--===============1951540970482262893==--
