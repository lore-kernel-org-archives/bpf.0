Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320034;
	b=HODBLeZpvqUnuHKcpoN49fgBFoF+sf2pnRIdfuqx2FcYXTChYOCh5R4Q+cxuo4jJ7sHk
	 DV2Tfx2HnAJoUq9aEJ5z5s6lil8DURRMw6yrZURhhhq8O1mArAtYYkDQ8gvxrbm+LYb/c
	 UXpaScYypNdiYyynQo2yilFPUIpThdAu0idvidpGeqTfw8wWejYTxpDyKKHdFcZ+I1GGK
	 W0m+NLj6l/Nj/5sX68CtjIEsaoW3hNgoXUt05bR1ncHsreDilBDm2JxssLwlhAJDTbYOI
	 Uz/A70dnUrbq9b+/FxglcyNeVwph0Q00Norcjfh/6qhZ90XHqbKWKZzj4MboICLClXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320034;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Xd4nTp86cW9MidEl4iHRTLTDM3LxuvmF0DAhfS6CjOQ=;
	b=dPypWLYKZ6OFvNZKinW0ZjuTxlcMOjd8MYl9TtUaAe2c7ew7YlMi4dzqgkY3SQo9kbOT
	 6EVPNILznwAqZGpI2DsPgSW4qjCm1fQWk1iDiOkcfcNnHovmcRHaT/E7wpU3V0FXGuqfG
	 SQAsFZG3KP6JzORy0MdYPcWO3OKX9kRE3GhtSyfFPyiiRCktuAIgONICAIi2atmKhWQLO
	 QrY6c1nYMwSAkoRPmr7Lt0jVQn6AhNdQUltNOHQXUMuZXEDTnq3ywB117AT5pJ9FMLYpI
	 oSit1LUfr7it5Hl0NKeaU8sn0sXtJ8tttEjJCXuzRUgNzeCxgLPd7xZetQFdDRHKcaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f8Mt1/7r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD959606A32E;
	Tue, 10 Nov 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8Mt1/7r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850981F0089F;
	Tue, 10 Nov 2026 14:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320033;
	bh=Xd4nTp86cW9MidEl4iHRTLTDM3LxuvmF0DAhfS6CjOQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f8Mt1/7rCa1pZCIKwEJ+QowRw7WQd2Mil3HemNjtaswi4u+d03aYrTi40TLXxnCKw
	 pauvn8khQlPZ8R0mn/xay1EkuRTlVn70VcrXZAEZWngUsD6lexjShgO4SZjUnAw+Y7
	 IkXLs633FXY+yrUe4/bR9QruYsg3I9GAvk92vUcOMAd/goWCPfS5TkZXmAZlDQU2Xl
	 CDTMbuumkOVilTAQVmB07pRXPfjrja83JxOczK9RnNr+hOr3Y+05WFCevz3qvEFves
	 +l5bSjPbG1HZLdG4bfwyu9UpYy3uV/pWeW9XheFevIn2LpwSkiOXknAXotskv9WmEt
	 hGecO3L5DbctA==
Message-ID: <2f0e411d-d29a-487a-b7d3-2cd7dd92e456@kernel.org>
Date: Tue, 10 Nov 2026 15:13:41 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 03/15] xdp: add kfuncs to store RX hash and VLAN
 tag
To: Tianyi Gao <tianyi@cloudflare.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vladimir Vdovin <deliran@verdict.gg>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Chris J Arges <carges@cloudflare.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 llvm@lists.linux.dev, kernel-team@cloudflare.com
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <f865ab08e7e0343bcd6eb380f7003ddd32d177e2.1794281983.git.tianyi@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <f865ab08e7e0343bcd6eb380f7003ddd32d177e2.1794281983.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/26 04:57, Tianyi Gao wrote:
> Add bpf_xdp_skb_ext_store_rx_hash() and bpf_xdp_skb_ext_store_rx_vlan().
> They store the RX hash and the VLAN tag in the skb core extension area.
> A later patch sets the stored values on the skb built from the
> xdp_frame.
> 
> Both kfuncs call xdp_skb_ext_add(), which reserves the entry for an id.
> On the first store for a packet, it clears the header and sets
> XDP_FLAGS_HAS_SKB_EXT, so stale headroom is never read as a header. A
> second store of the same id, also after a delete, reuses its offset.
> 
> xdp_skb_ext_add() returns -EOPNOTSUPP for AF_XDP zero-copy buffers. User
> space can write their headroom while the program runs, and could change
> the header between two stores.
> 
> The store kfuncs are in their own kfunc set. They do not need a
> device-bound program, so programs on cpumap and veth can call them.
> 
> bpf_xdp_skb_ext_store_rx_vlan() accepts only ETH_P_8021Q and
> ETH_P_8021AD, because vlan_proto_idx() warns on any other TPID.
> 
> A BUILD_BUG_ON() in xdp_skb_ext_struct_check() limits the area to 64
> bytes. As in skb_extensions_init(), the function is noinline
> __no_profile so that it builds with CONFIG_GCOV_PROFILE_ALL.
> 
> The two kfuncs are based on bpf_xdp_store_rx_hash() and
> bpf_xdp_store_rx_vlan() by Lorenzo Bianconi in Jesper's XDP_REDIRECT RX
> hints series V2 [1].
> 
> Link: https://lore.kernel.org/all/175146831297.1421237.17665319427079757435.stgit@firesoul/ [1]
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
>   net/core/xdp.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 151 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 1d679e8fd649..97dc0e403a78 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -990,11 +990,159 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id)
>   	return btf_id_set8_contains(&xdp_metadata_kfunc_ids, btf_id);
>   }
>   
> -static int __init xdp_metadata_init(void)
> +#define XDP_SKB_EXT_CHUNKSIZEOF(x) DIV_ROUND_UP(sizeof(x), XDP_SKB_EXT_ALIGN)
> +#define XDP_SKB_EXT_ENTRY_ACTIVE BIT(7)
> +
> +struct xdp_skb_ext_hash {
> +	u32 val;
> +	u32 type; /* enum xdp_rss_hash_type */
> +};
> +
> +struct xdp_skb_ext_vlan {
> +	__be16 proto;
> +	u16 tci;
> +};
> +
> +static const u8 xdp_skb_ext_type_len[] = {
> +	[XDP_SKB_EXT_HASH] = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext_hash),
> +	[XDP_SKB_EXT_VLAN] = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext_vlan),
> +};
> +
> +/* Limit the header and all entries to 64 bytes, so that a new entry
> + * cannot grow the area without notice.
> + */
> +static noinline void __init __no_profile xdp_skb_ext_struct_check(void)
> +{
> +	unsigned int chunks = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(xdp_skb_ext_type_len); i++)
> +		chunks += xdp_skb_ext_type_len[i];
> +
> +	BUILD_BUG_ON(chunks * XDP_SKB_EXT_ALIGN > 64);
> +}
> +
> +static void *xdp_skb_ext_add(struct xdp_buff *xdp, enum xdp_skb_ext_id id)
> +{
> +	struct xdp_skb_ext *ext = xdp_skb_ext(xdp->data_hard_start);
> +	bool valid = xdp_buff_has_skb_ext(xdp);
> +	unsigned int newlen, newoff;
> +	void *start;
> +
> +	/* User space can write the headroom of AF_XDP zero-copy buffers */
> +	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	if (!valid) {
> +		newoff = XDP_SKB_EXT_CHUNKSIZEOF(*ext);
> +		newlen = newoff + xdp_skb_ext_type_len[id];
> +	} else if (ext->offset[id]) {
> +		newoff = ext->offset[id] & ~XDP_SKB_EXT_ENTRY_ACTIVE;


Given the recent run of security bugs caused by manipulated offsets, I
would like to limit how far a bad offset can reach here. The offset is
read back from the packet headroom and is trusted only because
XDP_FLAGS_HAS_SKB_EXT is set; nothing checks it against ext->chunks or
the buffer. With the 7-bit mask it can point up to 508 bytes past the
ext header, beyond the default headroom and into packet data, and in
this branch the caller then writes the entry (up to 8 bytes) there. I
have not found a way to get a bad header with this series, but the
invariant depends on every driver leaving this area alone while the
flag is set.

The BUILD_BUG_ON() in xdp_skb_ext_struct_check() limits the header plus
all entries to 64 bytes, which is 16 chunks, so a 4-bit mask covers
every valid offset. A bad offset then starts at most 60 bytes after the
ext header. It is the same AND with another constant, so it costs
nothing in the fast path. The same mask should be used in
xdp_skb_ext_get() in patch 7.

--Jesper

> +		newlen = ext->chunks;
> +	} else {
> +		newoff = ext->chunks;
> +		newlen = newoff + xdp_skb_ext_type_len[id];
> +	}
> +
> +	start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;
> +	if ((void *)ext + newlen * XDP_SKB_EXT_ALIGN > start)
> +		return ERR_PTR(-ENOSPC);
> +
> +	if (!valid) {
> +		memset(ext->offset, 0, sizeof(ext->offset));
> +		xdp->flags |= XDP_FLAGS_HAS_SKB_EXT;
> +	}
> +	ext->offset[id] = newoff | XDP_SKB_EXT_ENTRY_ACTIVE;
> +	ext->chunks = newlen;
> +
> +	return (void *)ext + newoff * XDP_SKB_EXT_ALIGN;
> +}
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_xdp_skb_ext_store_rx_hash - Store the RX hash of this packet.
> + * @ctx: XDP context pointer.
> + * @hash: RX hash value.
> + * @rss_type: RSS hash type, see &enum xdp_rss_hash_type.
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-ENOSPC`` : not enough headroom for the entry
> + * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
> + */
> +__bpf_kfunc int bpf_xdp_skb_ext_store_rx_hash(struct xdp_md *ctx, u32 hash,
> +					      enum xdp_rss_hash_type rss_type)
>   {
> -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
> +	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
> +	struct xdp_skb_ext_hash *entry;
> +
> +	entry = xdp_skb_ext_add(xdp, XDP_SKB_EXT_HASH);
> +	if (IS_ERR(entry))
> +		return PTR_ERR(entry);
> +
> +	entry->val = hash;
> +	entry->type = rss_type;
> +
> +	return 0;
> +}
> +
> +/**
> + * bpf_xdp_skb_ext_store_rx_vlan - Store the VLAN tag of this packet.
> + * @ctx: XDP context pointer.
> + * @vlan_proto: VLAN tag protocol identifier (TPID), in network byte order.
> + * @vlan_tci: VLAN TCI, in host byte order.
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EINVAL`` : @vlan_proto is not 802.1Q or 802.1AD
> + * * ``-ENOSPC`` : not enough headroom for the entry
> + * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
> + */
> +__bpf_kfunc int bpf_xdp_skb_ext_store_rx_vlan(struct xdp_md *ctx,
> +					      __be16 vlan_proto, u16 vlan_tci)
> +{
> +	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
> +	struct xdp_skb_ext_vlan *entry;
> +
> +	if (vlan_proto != htons(ETH_P_8021Q) &&
> +	    vlan_proto != htons(ETH_P_8021AD))
> +		return -EINVAL;
> +
> +	entry = xdp_skb_ext_add(xdp, XDP_SKB_EXT_VLAN);
> +	if (IS_ERR(entry))
> +		return PTR_ERR(entry);
> +
> +	entry->proto = vlan_proto;
> +	entry->tci = vlan_tci;
> +
> +	return 0;
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(xdp_skb_ext_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_hash)
> +BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_vlan)
> +BTF_KFUNCS_END(xdp_skb_ext_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set xdp_skb_ext_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &xdp_skb_ext_kfunc_ids,
> +};
> +
> +static int __init xdp_kfunc_init(void)
> +{
> +	int ret;
> +
> +	xdp_skb_ext_struct_check();
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> +					&xdp_skb_ext_kfunc_set);
> +	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> +						&xdp_metadata_kfunc_set);
>   }
> -late_initcall(xdp_metadata_init);
> +late_initcall(xdp_kfunc_init);
>   
>   void xdp_set_features_flag_locked(struct net_device *dev, xdp_features_t val)
>   {

