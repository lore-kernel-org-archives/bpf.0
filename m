Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601946;
	b=lhqIBoyBSaqnph0K8Yzy80OTb4rNpoWyd1eippDXVOArD+fpUBAfE40LIdq+Do+Bqtj5
	 b3T2DacXzuZhP0x1WzS/LAF97QqmRNRaEsS6niIvSCFSeIh3vas6+DLKBI6oGy/xbmLtC
	 mvXyQcNKuFhEXnEir+C4tAkjUguvgHRIIjmV4copUpHZ91yRjoRAR+XFUUGEq5/gjaYqL
	 hRiH2QyfCS/GCWvOCXjTN8ylRf8QiyGEnVvaU4ZD5mkvHfiMNAtoC1P9bIFQND62+nC9L
	 kTEaL44JFA1UJCw1sYK7nYwQ+0v0DAy64G+R7Wj47DDTwVBf4fgDLp7/z7YNQdAHZcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601946;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Ch+cdHNWdqSBOJQDfma07OavdtmO6Fn0ukfkIr5qp2w=;
	b=kNYXF53fWvlVkJ0v1sF/ouM/PmgAB8rRaTyjs2dNeKpy5PRX+WKX29OkPt9nsFz3T9+b
	 KS6WgJS07av2yZcuCHYn5eTeumA0lWNtMqMkxldTHHke9Sxg5mOyJU//QF6MSLOyxr7Gl
	 di3mIVAi2J6KfD9b72B5WmLprtb8ZTejo+7Y4M7ZLML9nPb+0K3QyyHAJ7SCgGrZGYrEd
	 4i3kvd83Ie+ISqBs67biq4b05CNfrJQeqQWOaxTEd1zwfPeaDkPtt4V8mjHb0RMLxix0o
	 D2QDhAO3D4dA+g9LxiTTvnABedA6z0mnP4o/npbh/JNdIq38nezhhMbwBJyRd6UBKPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WH2fDS9g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50C606A31A;
	Wed, 21 Oct 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WH2fDS9g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461031F000C1;
	Wed, 21 Oct 2026 16:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792601945;
	bh=Ch+cdHNWdqSBOJQDfma07OavdtmO6Fn0ukfkIr5qp2w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WH2fDS9gwnSKO9+SNh64/8vxkuZPlqNeTvhYIDVDQbTaQw1MnLgFwNHa4KyIm15df
	 Ijz6eb54a414X7cW290tmBmzuRfQq4VBQ9vGFMWqiX23gGg+9MAk9XX7rlNGE86XLg
	 aFwvwOvSkQoyMl3bCN0EAHIh4a1bDoy4zJRpGQj0r7YNocKCdLE0GMuJNMJ7LxDQz5
	 5YYjk05bIzD0Oc+KDQUKWMOUzNPthtEfMAC2Q2/HjTolM4UqlE7jp/+u5Kzt2QqJtr
	 xJ3DV19yVZ2ugkUwF1vcbEjeqN20p8O3KM9HDon+Q78fpDHUlS4GSSEoqw9LScObZk
	 lZe7kQJ7uzRSQ==
Content-Type: multipart/mixed; boundary="===============4988805122012070755=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <584b50e286edb7bf068660ad5221f7181c60a28871c5ed50b1d8cf00ba17a8ec@mail.kernel.org>
In-Reply-To: <20261021155645.69120-1-phx0fer@gmail.com>
References: <20261021155645.69120-1-phx0fer@gmail.com>
Subject: Re: [PATCH bpf] net: return page_pool frags to the pool in bpf_xdp_shrink_data()
From: bot+bpf-ci@kernel.org
To: phx0fer@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: netdev@vger.kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 16:59:05 +0000 (UTC)

--===============4988805122012070755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> net: return page_pool frags to the pool in bpf_xdp_shrink_data()

TL;DR: Commit message only: the Fixes tag (4dce1a0d7cf3) may be wrong;
e6d5dbdd20aa (v6.9, generic XDP multi-buff) seems the real origin, so stable
backport scope is understated.

>     net: return page_pool frags to the pool in bpf_xdp_shrink_data()
>
>     bpf_xdp_shrink_data() releases a fully-shrunk frag through
>     __xdp_return(netmem, mem_type, false, zc_frag), selecting the freer from
>     the rxq's mem type.  Under generic XDP the rxq's xdp_rxq_info often has no
>     mem model registered (e.g. loopback), so mem_type stays
>     MEM_TYPE_PAGE_SHARED == 0 even though the frag was allocated from a page
>     pool by skb_pp_cow_data().  __xdp_return() then frees the page through
>     page_frag_free() instead of page_pool_put_full_netmem(), so the page is
>     returned to the buddy allocator while its page_pool accounting is still
>     live:
>
>       BUG: Bad page state in process A-146-S3_S1  pfn:4694b
>       page dumped because: page_pool leak
>        page_frag_free+0xf0/0x11c
>        __xdp_return+0x160/0x640
>        bpf_xdp_adjust_tail+0x5a4/0xbac
>        bpf_prog_run_generic_xdp+0x4a8/0x1204
>
>     Before falling back to __xdp_return(), try the page_pool path: if the
>     frag really is a page_pool page, napi_pp_put_page() recycles it through
>     the pool and we are done.
>
>     Fixes: 4dce1a0d7cf3 ("bpf: Support pulling non-linear xdp data")
>     Assisted-by: LLM
>     Signed-off-by: Dudu Lu <phx0fer@gmail.com>

Is the Fixes: tag pointing at the right commit?

4dce1a0d7cf3 only added bpf_xdp_pull_data() as a new caller of
bpf_xdp_shrink_data().  The splat in the commit message goes through
bpf_xdp_adjust_tail() -> bpf_xdp_frags_shrink_tail() -> __xdp_return(),
which already freed released frags based on xdp->rxq->mem.type
(MEM_TYPE_PAGE_SHARED when no mem model is registered, as in generic XDP)
since c5114710c8ce ("xsk: fix usage of multi-buffer BPF helpers for ZC XDP")
and bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tail() API").

The mismatch only became possible when e6d5dbdd20aa made
netif_receive_generic_xdp() build non-linear xdp_buffs from page_pool backed
frags via skb_pp_cow_data(), while the generic XDP rxq has no registered mem
model.  From then on the adjust_tail shrink path freed page_pool pages with
page_frag_free(), and the "page_pool leak" check already existed via
dba1b8a7ab68 ("mm/page_pool: catch page_pool memory leaks").

e6d5dbdd20aa landed in v6.9 while 4dce1a0d7cf3 landed in v6.18, so the
current tag understates the stable backport scope.  Should this instead
include:

  Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39631548606
--===============4988805122012070755==--
