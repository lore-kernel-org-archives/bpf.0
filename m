Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA623EA94
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 02:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143907; cv=none; b=tpn5TGPMY7G0AD9exRz1yelAS+rzjJKF9Q1Lry6KBeE43ARUhPcl7a8JWQ5altLT3hielPqWz+9i4+4Awqo5yQZb1KK10OtjEZaO2gctmi8tsY3GEKSHIw0MNV+5y9HCGMOGG2HW/EvE1xcCTU7HTbzMGGr6HPbJIBvQQJAjyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143907; c=relaxed/simple;
	bh=/quYFsIq0m6wCBNtCKmgkuTK7IhTw7O7JhpLhB2NAFc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EOVwrfgkIMyIOwD1p7iqHVnnOwQ7s+L/f6j6e/xnem+Y5BiGrNB220z9TkD6tzacDXIcQ9tY1mmfXjeLztEt4TZZdq9j6aEmMYPuw/aZJFyGF7XfO6rFqN5ahTa48ih83RDppYrvnEHmaaeSH8nulwgGzzkjs5urj4p4Pmm5Qm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz38gRX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz38gRX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8091F00893;
	Thu, 11 Jun 2026 02:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781143906;
	bh=a0XlCZ5yt9jhWPOQ9qOOXN6pDRlRnxKeudObnVULq9U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oz38gRX6o56OeyM2DvbboeIUb/WuK85AJRIJ5C5np1z4x3ulennJGWQDg5BIiLOvL
	 +3AUnnkHDC1BYUnfXEp24pZMVSgRXsu0nEgCiB3pOC0sh4y/xIreHCv2KBgXFdCZlH
	 mJTv/UUOkGl0ba46YfHpjulC0jJMsw8S7QEFdV2KWUPZWxaqZp883TyVr31dqI0agE
	 kfmKeJxmH95fjLyvR83uSosRNuMwAIxI91eSoTuP14jBkPyvbuuae0fG/ixft1tHkN
	 mKqcK3NjqBtQ5au0dZYIpx09bN4Xp5icQqEFuzbF8SUsTlVlCf0dYwubsnLWZQqCyl
	 L0QAbBbTrjKmw==
Content-Type: multipart/mixed; boundary="===============8726414749980304070=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <79026d1065dc6eb587ffe49d609721da2b81acc9b006a3bc5ee11423754108ab@mail.kernel.org>
In-Reply-To: <20260611013547.247039-4-jiayuan.chen@linux.dev>
References: <20260611013547.247039-4-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf 3/4] bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 11 Jun 2026 02:11:45 +0000 (UTC)

--===============8726414749980304070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3e555f276ba8..982d59cf659f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2716,7 +2716,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
>  	if (unlikely(bytes_sg_total > copy))
>  		return -EINVAL;
>
> -	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
> +	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZERO,
>  			   get_order(copy));
>  	if (unlikely(!page))
>  		return -ENOMEM;

The hunk header shows this change is inside bpf_msg_pull_data
(BPF_CALL_4 at line 2716). However, the commit subject, body, and Fixes:
tag all reference bpf_msg_push_data, not bpf_msg_pull_data. Does this patch
modify the wrong function?

The commit message describes the heap info leak in bpf_msg_push_data: in
the copy path "a gap of len bytes between the front and back memcpy regions
is left uninitialized", and in the non-copy path "the entire page of
uninitialized heap content is added directly to the sk_msg scatterlist".

Looking at bpf_msg_push_data in net/core/filter.c, its alloc_pages() call
at line 2835 is still:

    page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
                       get_order(copy + len));

without __GFP_ZERO. The copy path (lines 2840-2865) writes raw[0..front)
and raw[front+len .. front+len+back) via two memcpy calls, leaving
raw[front .. front+len) uninitialized. This page is then placed into the
scatterlist via sg_set_page at line 2922 and transmitted. This is the leak
described in the commit message.

The function actually modified, bpf_msg_pull_data, does not have this
issue. Its memcpy loop (lines 2726-2738) fully overwrites all 'copy' bytes
before they are placed via sg_set_page at line 2740. Adding __GFP_ZERO
there does not fix the documented security concern.

Should the __GFP_ZERO also be added to bpf_msg_push_data's alloc_pages at
line 2835?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27318345998
--===============8726414749980304070==--
