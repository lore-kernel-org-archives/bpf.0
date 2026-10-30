Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350072;
	b=PYkFmNNO9n4tb9UiXLPaXwsqa4uyuyBauVZchwFDJWDKJA9AcrkMzpQZxTrcOvjc+gdR
	 SIojEN4UJas2RlvHcGZP6bcBHkQNdnajzWai9FLXkAw1IWlci70QzWiITco+2ytlrLgK8
	 PtCtpjnjezaxc5ITRrnRg8Rn52Pww/+nHXpn2+xRpqvoOA+1qvyWeTybYjunz0ghFjYww
	 iaIQFlzxZnfFjmU2VFgfapQAxrBp+4jPAPw8sF1ltaxGbsmk0mpKgqltwZKMWhv06DiNn
	 lB7sZjHcukpuyGzPm87tY7lyaSW21nRL35q8esCHg1/5W057cBSBhrI72WTL57mcbxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350072;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=KrD/LT25yUr4hzgtq3ozTYQoswHyYhMKqnTj9MrA7yQ=;
	b=vJ6YZ8Zvy8b1RMdWaKBPNHyWXfvy5VFwKves5bdQtjTb4q8xZIJL6YCDFa3vkJo8rFQ4
	 YjgoF/44qF0L9ikDelnW0x25vOD8Z0mSWc0eeVpdNxU2C4XTu+ogSp0rHSXX+p62PPYH/
	 ovjyf2n8/ytT/Q+B/3OP/44ZQn7giMSCFiQKXMUOAHW4HtTcx34RzfnEY28aUQc4pWila
	 pZfpV3evkZVkXQKyUiJ0A6ajjgEkYUTluQH00QdiNT1Cg2BW+tJvnjpA8fD7NrH5dFB+A
	 HpN5jQm8NPPyuNkGOnjVU2zDfde95ckM9Kr+5BoOx9YX8N/tCggimT39ImRrdhz/i6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QjMA/2B8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1AE606A31C;
	Fri, 30 Oct 2026 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjMA/2B8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8B01F000C1;
	Fri, 30 Oct 2026 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793350072;
	bh=KrD/LT25yUr4hzgtq3ozTYQoswHyYhMKqnTj9MrA7yQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QjMA/2B8CZscQfaFu/WT/U6Y2M4NWtO4+THO4uTPFwCSiZ1smfQcK0uUxM4zrg9Vb
	 LqswBte6CIMZ2ITHE67rlkTTB33tqXHR1JIa9KsVGLgxQd5EFYsQMyX+iFqGQLT/qe
	 /giQal94WXwHFMPz28VqsVj/Bu1RG8X0FwmqEsYZe1h5Cb93gu9P5KmZ5B79A4FimV
	 24IF9UBSwNFykEF1OSWahsjUocfMdi/tzsrj8DxUgIkVritNttSW5oBlqb5X7q5UK2
	 doJVCkexnpQ/EQ4EJKCTaBSj/5CVv6fbThRkmpbjyUrY7X85S/84vYPTxrOtk4Y1F5
	 9L1CdTdw7Oh6g==
Content-Type: multipart/mixed; boundary="===============2292663351581088568=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <36d13f061c48206a13e7a38cb846f4c71e0a15fcf0459ab56a2b01f67a57172e@mail.kernel.org>
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
Subject: Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring is full
From: bot+bpf-ci@kernel.org
To: marcin.knap@vecima.com,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,sdf@fomichev.me,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,jtollet@cisco.com
Cc: intel-wired-lan@lists.osuosl.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,marcin.knap@vecima.com,joshwash@google.com,hramamurthy@google.com,sgoutham@marvell.com,gakula@marvell.com,rkannoth@marvell.com,sbhatta@marvell.com,bbhushan2@marvell.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 30 Oct 2026 08:47:51 +0000 (UTC)

--===============2292663351581088568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> xsk: Do not free ZC Rx buffer when the Rx ring is full

TL;DR: Commit message only: the code change looks correct, but the "freed
twice" claim seems inaccurate for drivers that free immediately (i40e, ice,
etc.); only deferred-release drivers like mlx5e are affected.

>     xsk: Do not free ZC Rx buffer when the Rx ring is full
>
>     When an XDP program redirects a zero-copy buffer to an XSK and the
>     socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
>     -ENOBUFS to xdp_do_redirect().
>
>     A failed xdp_do_redirect() leaves the buffer owned by the caller, and
>     most drivers rely on that: mlx5e treats the failure as XDP_DROP and
>     releases the buffer when the Rx WQE is refilled, while i40e, ice,
>     ixgbe, igb, igc, stmmac, idpf and others free it themselves. The
>     buffer is therefore freed twice. It gets reused for another Rx
>     descriptor, the second free puts an in-use buffer back on the pool
>     free list, and the same UMEM frame is later handed to user space
>     twice. ixgbe and igb keep the buffer in the ring on their need_wakeup
>     -ENOBUFS (XDP_EXIT) path and run it through XDP again on the next poll,
>     after the core has freed it.
>
>     Leave the buffer with the caller on both the single-buffer and the
>     multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
>     do. A few drivers relied on the core freeing the buffer, so make them
>     free it:
>
>     - i40e and ice consume the descriptor on XDP_EXIT without freeing it.
>     - gve DQO counts the redirect error without freeing the buffer.
>     - octeontx2 returns false on a failed redirect, so the caller goes on
>       to build an skb from the already freed buffer. Free the buffer and
>       report it as consumed instead.
>
>     Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
>     zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
>     with the Rx ring. With this change no duplicate frames were seen with
>     striding RQ on or off.
>
>     Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
>     Signed-off-by: Marcin Knap <marcin.knap@vecima.com>

The changelog says that for i40e, ice, ixgbe, igb, igc, stmmac, idpf and the
others the buffer is "freed twice" and that "the second free puts an in-use
buffer back on the pool free list".  Is this accurate for those drivers?

All of them call xsk_buff_free() on the redirect failure path straight after
xdp_do_redirect() returns, before any xp_alloc() can run.  xp_free() starts
with:

    void xp_free(struct xdp_buff_xsk *xskb)
    {
        if (!list_empty(&xskb->list_node))
            return;
        ...

and the xsk_buff_free() from the old xsk_rcv_zc() err label has already put
list_node on pool->free_list.  So wouldn't the second free simply return
early here?

For a multi-buffer frame, xskb_list is already emptied by then, and the head
hits the same early return.

The corruption described seems to happen only where the second release comes
later, after the buffer may have been reallocated:

- mlx5e releases the buffer on WQE refill.
- ixgbe and igb keep the buffer in the ring on XDP_EXIT and run XDP on it
  again.
- dpaa2 calls dpaa2_eth_recycle_buf(), which hands the address back to the
  hardware pool while the buffer is also on free_list.
- octeontx2 builds an skb from the freed buffer.

The code change itself looks correct.  Could the changelog be reworded to
name the drivers with a deferred second release, or the reuse after free, as
the ones affected, instead of the drivers that free the buffer immediately?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41025962641
--===============2292663351581088568==--
