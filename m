Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436887;
	b=Od3aQiUJSpuQiT9XnMzBmSI9SIgmlCrYwjgOmmdu3hICA4zdGZfsgJK0bvGAt5LQO2cc
	 oFDkJCbEzLigZrairvsYrKVc73d5bAkUSjFtRGq3YfI7z/wKf/AKersH1bYCbbcQ3z/hR
	 vdVmM2sMoPV6JXojquA8no+rxdj0JYfn3fB374wmSTCKQZLjKR1foPm4/Fb96FfHY62E8
	 UyJIefR2WDa3YTppP7KEaDk/yrwicEklYwokXD1YZCDaK/aN0XSjHEhOTuX3Yn7/s8sHA
	 DKgmiz439KJ5Lo/rgmUjbCyEvywvEa3B524YgfoVk/c94Sn7+E2SZ7CvFVfXkoAQDXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436887;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=UY3RMS56DkTiyj0krxa5zBr/mBUw7hLobgrEZX1POGE=;
	b=zS1slmV6d/mJ2JCkiODo/qU6/nx4wV53Ej2KrhONwyk2zY5DEzrHER7L6ygxDoqO9iSa
	 O7e6R+cZqWW/6DOgX5l9+gCycxd05UPmtynzIdF/H463oiXNmBHSKrl/7DMW+3wmFkMQH
	 ZcJ945y3PYzwSe20UhDwNVHo+9wvngseT1NbFe/c8ak55JX13bfdx2MihPZgUuOLNc9im
	 +xRHKo29yPOQlDFdmsX6o4Ri72jNrS2ORjOwrA29BpgKN5mC66RtoS82C1aLtWZTQiNYR
	 016a6G2XiIW2KyGKC1rLNBS4caDZ4gm3TApNaBHJk9UqMy24OKduxN0r6S5BdvqBx0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHI+Wm8K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47E606A880;
	Wed, 11 Nov 2026 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHI+Wm8K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDF11F00A0A;
	Wed, 11 Nov 2026 22:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436887;
	bh=UY3RMS56DkTiyj0krxa5zBr/mBUw7hLobgrEZX1POGE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iHI+Wm8KcSPSvJBFNxNli54Zk3sK/ga3jxTAPM7hgTxGSFX5fqD1gnPhB6596uoN9
	 i+qy8oDyxvR5IJpgw9Z3Qaq5Q/ln0MSLSRSNsVvheo13lNFSce7r0NmSg0EWq8+Ghx
	 NFBBkR+X6sKRYrFfHKKnHofhDE53X943wccSU7Q2Ua+yMWcxi4BUSeaMo1mc7fwN3Q
	 u46+I8fyauv8wQ/lfsgCxqGiA6UWzcNfUuQSbtYVcSLOZ+xLPaHPFF1qYW3BqcPPNY
	 7MRAfYRR1sl8CW+LP3loUeT+nXi91y+GZPpxdvW/s2dfKOakLnRUbOyo6Ko9NmucZF
	 IEtCFltIV416g==
Subject:
 Re: [PATCH net-next v1 03/11] xdp: Copy buffers with restricted lifetime
From: netdev-bot+sashiko@kernel.org
To: bjorn@kernel.org
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, alexanderduyck@fb.com, kernel-team@meta.com,
 andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 asml.silence@gmail.com, axboe@kernel.dk, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org,
 io-uring@vger.kernel.org, almasrymina@google.com, mike.marciniszyn@gmail.com,
 bestswngs@gmail.com, razor@blackwall.org, dw@davidwei.uk,
 aleksander.lobakin@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stuclar@meta.com
Date: Wed, 11 Nov 2026 22:41:24 +0000
Message-ID: <179443688445.2199510.2127044982916637399@kernel.org>
In-Reply-To: <20261110102039.1002605-4-bjorn@kernel.org>
References: <20261110102039.1002605-4-bjorn@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] xdp: missing xdp_data_meta_unsupported() check in
  xdp_build_skb_from_zc()
- [High] xdp: skb_shared_info overwrite in xdp_build_skb_from_zc() via
  aligned memcpy

--

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -638,6 +689,9 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
>  	u32 nr_frags = 0;
>  	int metalen;
>  
> +	if (unlikely(xdp_buff_needs_copy(xdp)))
> +		return xdp_build_skb_from_zc(xdp);
> +
>  	if (unlikely(xdp_buff_has_frags(xdp))) {
>  		sinfo = xdp_get_shared_info_from_buff(xdp);
>  		nr_frags = sinfo->nr_frags;

[Severity: High]
This makes xdp_build_skb_from_zc() the XDP_PASS path for restricted
page pool buffers, and its copy can overrun the new head into the
skb_shared_info.

The function asks the system page pool for truesize = xdp->frame_sz.
When that comes back unchanged, napi_build_skb() places
skb_shared_info at the same offset that xdp_data_hard_end() has in the
source. The code then copies LARGEST_ALIGN(len) bytes starting at
offset xdp->data_meta - xdp->data_hard_start.

That offset is often not a multiple of 16, which is normal after
bpf_xdp_adjust_head() by an Ethernet or VLAN header. If data_end is
also close to xdp_data_hard_end(), the rounded-up memcpy writes into
the already initialised skb_shinfo() of the new skb: flags,
nr_frags, the gso fields and frag_list.

The bytes written come from past data_end in the head chunk, which
for UMEM is writable by userspace. Freeing or segmenting the skb
later then walks a bogus nr_frags or frag_list.

With XDP_FLAGS_EXT the head chunk no longer holds the shared info at
all. Does anything still keep data_end below xdp_data_hard_end() for
these buffers? If not, len alone can run past skb->end, since
__skb_put() does not check.

Should the destination size be derived from the copy instead of
xdp->frame_sz? For example: headroom + LARGEST_ALIGN(len) +
SKB_DATA_ALIGN(sizeof(struct skb_shared_info)). Or should this path
copy exactly len bytes?

[Severity: High]
Restricted buffers on XDP_PASS now go through xdp_build_skb_from_zc(),
but that function cannot cope with unsupported metadata. If the driver
called xdp_prepare_buff(..., false), or metadata is otherwise invalid,
xdp->data_meta is xdp->data + 1.

The non-copy path of xdp_build_skb_from_buff() handles this. It
reserves and puts from xdp->data and only sets metadata when
metalen > 0. xdp_copy_buff_to_frame() in this patch also checks
xdp_data_meta_unsupported().

xdp_build_skb_from_zc() does not. It:

- computes len as data_end - data_meta,
- reserves data_meta - data_hard_start,
- copies from data_meta,
- then sees metalen == -1 and skips the __skb_pull().

The resulting skb starts at the second byte of the Ethernet header and
is one byte short, so eth_type_trans() and everything above it parse
shifted data. If data_end == data, len also wraps as a u32.

The XSK callers did not hit this, because the pool sets
data_meta == data. Page pool drivers without metadata support pass
meta_valid == false routinely, though.

Could xdp_build_skb_from_zc() compute the metadata size the way
xdp_copy_buff_to_frame() does? That means treating unsupported
metadata as zero length and copying from xdp->data.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110102039.1002605-1-bjorn%40kernel.org
