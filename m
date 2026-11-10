Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=81.19.149.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339191;
	b=3MDRvvWodgfhuuBZgcRhx1lHOMsTSToaHkOkxMbsLMPODbuZMwmmZMnnm1K5x6OxAbzd
	 kOkB6q+FnGZiX4imFWWLwj0SC2L1NWdz+R2vw8gMZ8Zcxt2UQer4gbhq9CspQ6vq5grtd
	 6ctYl0Wf0xdjhF9aHvkmGOrvHyOJK8ukB0miyANII0a5IkUsvezki00gMYJInfaEgbBqV
	 lzEI2ZfSwGkmcBhcFO2ULWHYm4Lx+uXT4b1ltfwgWcEI7cJZz8pDcK4uQj9QBvMNLFOi1
	 5Fnh+3Gp/HQLc0suCuWpWadpwGFXG6rv+nbKPprAEpBZTXkQsfxh/W30GjNstRwoVsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339191;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-AV-Do-Run;
	bh=Kb6tsHIuCpbK8Ynd/HxIwOkPQSLfGDHhz1xSOv1kM98=;
	b=z85ScK4HhuU7Ld6XbqE1pOMcadJDWmpz9RmfemokuiqO9aSe/BW1mLkrlZ6Wof0WZLs7
	 8Q/b+J6xThmjz8InWm34XMaRscFuF+doihkOHw0HzJDWQT5/0++LJG6hv42EWNvJ2PbeU
	 rivRakWy0Ha+WeM4qyxS3yQeVLu9Aqp3hpTV8Xmu2zSb3tOpQQa4yWoyhsHxlDqkwN6UN
	 kLo80l7EaUiU8kMt20D1Pjx13X7OD8lEQqPXK1Ee+qdHdt2KvNmYlSDN/Wtp8X700ogbc
	 rk04bZVW6nDAA+D83xCDw65FMnBsqMVwjwwFNyo3Bme9+pTQbHko4Z6b8kVQRA5oZFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=engleder-embedded.com;
	spf=pass smtp.mailfrom=engleder-embedded.com;
	dkim=pass header.d=engleder-embedded.com header.i=@engleder-embedded.com header.a=rsa-sha256 header.s=dkim11 header.b=d1g97xJ3;
	arc=none smtp.remote-ip=81.19.149.116
Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB3606A321;
	Tue, 10 Nov 2026 19:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BFB3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.a=rsa-sha256 header.s=dkim11 header.b=d1g97xJ3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kb6tsHIuCpbK8Ynd/HxIwOkPQSLfGDHhz1xSOv1kM98=; b=d1g97xJ3xONMX6Y0uhEkV2nclq
	p94D0CK0/HqOVSFQN/q93V4n+JQcgogScPzbbhsf2EK7esCKzDxZEgkMgUB6sIh+omV2rTIjst7Z0
	1AaIrfpKHAAZNHW79ihGxgwuRF6OiZ6PY4zaH6ySBztj3AOjznbKEkNkN3gkr2+8BAaE=;
Received: from [80.121.72.134] (helo=[10.0.0.160])
	by mx06lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1xQraO-000000000Ux-3taX;
	Tue, 10 Nov 2026 20:32:53 +0100
Message-ID: <cb785718-02cd-442b-a236-c1bce6971d60@engleder-embedded.com>
Date: Tue, 10 Nov 2026 20:32:50 +0100
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
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
To: Ding Meng <meng.ding@siemens.com>, netdev@vger.kernel.org
Cc: florian.bezdeka@siemens.com, jan.kiszka@siemens.com, wq.wang@siemens.com,
 p@1g4.org, Jason Xing <kerneljasonxing@gmail.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>
References: <20261105071706.7043-1-meng.ding@siemens.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20261105071706.7043-1-meng.ding@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 05.11.26 08:16, Ding Meng wrote:
> Commit 97dc7cd92ac6 ("ptp: Support late timestamp determination")
> added support for deferring RX timestamp conversion to
> ndo_get_tstamp(). When the timestamp is consumed, get_timestamp()
> uses the skb's NAPI ID to find the device that owns the timestamp
> cookie and invoke its callback.
> 
> Commit e68b6e50fa35 ("udp: enable busy polling for all sockets")
> gated NAPI ID bookkeeping with CONFIG_NET_RX_BUSY_POLL. As a result,
> when busy polling is disabled, the skb may not carry a usable NAPI ID.
> The device lookup then fails, so the driver callback is not invoked.
> get_timestamp() falls back to hwtstamp, which does not contain the
> converted timestamp, resulting in an incorrect RX hardware timestamp.
> 
> Record skb NAPI IDs independently of busy-poll support to support
> drivers that use deferred timestamp conversion and future driver
> features that need to look up a device by its NAPI ID.
> 
> Signed-off-by: Ding Meng <meng.ding@siemens.com>
> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> In the discussion of the issue reported at
> https://lore.kernel.org/netdev/20260630112056.885071-1-meng.ding@siemens.com/
> this previous patch added an igc-specific fallback for configurations
> with CONFIG_NET_RX_BUSY_POLL disabled. It populated skb's hwtstamp
> field with a timestamp converted using the default hardware timer,
> allowing get_timestamp() to return it without invoking ndo_get_tstamp().
> But Jakub Kicinski noted that the proposed fix appeared to be a
> driver-specific workaround for a generic problem. The engleder driver
> would also be affected by the same issue.
> 
> This patch introduces a new configuration option to enable NAPI ID
> bookkeeping independently of busy polling. The option is enabled
> whenever busy polling is enabled, preserving the existing behavior.
> It is also selected by the igc and engleder drivers, ensuring that
> skbs carry a NAPI ID even when busy polling is disabled.
> 
> Another approach considered was to require drivers using deferred
> timestamp conversion, such as igc and engleder, to enable busy polling.
> However, this would introduce an unnecessary dependency between two
> independent features: hardware timestamp reporting should not require
> busy polling to be enabled.
> 
> Timestamping has been tested only with igc; it has not been tested
> with engleder.
> 
>   Documentation/networking/timestamping.rst | 11 ++++++++---
>   drivers/net/ethernet/engleder/Kconfig     |  1 +
>   drivers/net/ethernet/intel/Kconfig        |  1 +
>   include/linux/skbuff.h                    |  4 ++--
>   include/net/busy_poll.h                   |  2 +-
>   include/trace/events/net.h                |  2 +-
>   net/Kconfig                               |  4 ++++
>   net/core/filter.c                         |  2 +-
>   net/core/skbuff.c                         |  2 +-
>   9 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index 2162c4f2b28a6..dbe40a1972639 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -278,9 +278,14 @@ SOF_TIMESTAMPING_OPT_PKTINFO:
>     packets with hardware timestamps. The message contains struct
>     scm_ts_pktinfo, which supplies the index of the real interface which
>     received the packet and its length at layer 2. A valid (non-zero)
> -  interface index will be returned only if CONFIG_NET_RX_BUSY_POLL is
> -  enabled and the driver is using NAPI. The struct contains also two
> -  other fields, but they are reserved and undefined.
> +  interface index will be returned only if CONFIG_SKB_MARK_NAPI_ID is
> +  enabled and the driver is using NAPI. This hidden configuration is
> +  selected automatically by busy-poll support and by drivers that need
> +  skb NAPI IDs to resolve deferred hardware timestamps. Drivers that
> +  use deferred timestamp conversion must select it so the networking
> +  stack can find the device and call its timestamp callback even when
> +  busy polling is disabled. The struct contains also two other fields,
> +  but they are reserved and undefined.
>   
>   SOF_TIMESTAMPING_OPT_TX_SWHW:
>     Request both hardware and software timestamps for outgoing packets
> diff --git a/drivers/net/ethernet/engleder/Kconfig b/drivers/net/ethernet/engleder/Kconfig
> index 3df6bf476ae7e..9700a243bea11 100644
> --- a/drivers/net/ethernet/engleder/Kconfig
> +++ b/drivers/net/ethernet/engleder/Kconfig
> @@ -22,6 +22,7 @@ config TSNEP
>   	depends on PTP_1588_CLOCK_OPTIONAL
>   	select PHYLIB
>   	select PAGE_POOL
> +	select SKB_MARK_NAPI_ID
>   	help
>   	  Support for the Engleder TSN endpoint Ethernet MAC IP Core.
>   
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index 780f113986ea8..7fb63f351fc20 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -376,6 +376,7 @@ config IGC
>   	depends on PCI
>   	depends on PTP_1588_CLOCK_OPTIONAL
>   	depends on ETHTOOL_NETLINK
> +	select SKB_MARK_NAPI_ID
>   	help
>   	  This driver supports Intel(R) Ethernet Controller I225-LM/I225-V
>   	  family of adapters.
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6787fcf6ac3e4..164c862f7a403 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1059,7 +1059,7 @@ struct sk_buff {
>   			__u16	vlan_tci;
>   		};
>   	};
> -#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
> +#if defined(CONFIG_SKB_MARK_NAPI_ID) || defined(CONFIG_XPS)
>   	union {
>   		unsigned int	napi_id;
>   		unsigned int	sender_cpu;
> @@ -1267,7 +1267,7 @@ static inline bool skb_pkt_type_ok(u32 ptype)
>    */
>   static inline unsigned int skb_napi_id(const struct sk_buff *skb)
>   {
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>   	return skb->napi_id;
>   #else
>   	return 0;
> diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> index 6e172d0f6ef5f..f7c0e62c6a7d7 100644
> --- a/include/net/busy_poll.h
> +++ b/include/net/busy_poll.h
> @@ -130,7 +130,7 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
>   static inline void __skb_mark_napi_id(struct sk_buff *skb,
>   				      const struct gro_node *gro)
>   {
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>   	/* If the skb was already marked with a valid NAPI ID, avoid overwriting
>   	 * it.
>   	 */
> diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> index dbc2c5598e35a..99ed7645242eb 100644
> --- a/include/trace/events/net.h
> +++ b/include/trace/events/net.h
> @@ -208,7 +208,7 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
>   
>   	TP_fast_assign(
>   		__assign_str(name);
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>   		__entry->napi_id = napi_id_valid(skb->napi_id) ?
>   				   skb->napi_id : 0;
>   #else
> diff --git a/net/Kconfig b/net/Kconfig
> index 76ab44aa439a6..8fa7586dc08ca 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -346,9 +346,13 @@ config CGROUP_NET_CLASSID
>   	  Cgroup subsystem for use as general purpose socket classid marker that is
>   	  being used in cls_cgroup and for netfilter matching.
>   
> +config SKB_MARK_NAPI_ID
> +	bool
> +
>   config NET_RX_BUSY_POLL
>   	bool
>   	default y if !PREEMPT_RT || (PREEMPT_RT && !NETCONSOLE)
> +	select SKB_MARK_NAPI_ID
>   
>   config BQL
>   	bool
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b7ac145b68b1f..e2218c18622b8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10274,7 +10274,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>   		break;
>   
>   	case offsetof(struct __sk_buff, napi_id):
> -#if defined(CONFIG_NET_RX_BUSY_POLL)
> +#if defined(CONFIG_SKB_MARK_NAPI_ID)
>   		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
>   				      bpf_target_off(struct sk_buff, napi_id, 4,
>   						     target_size));
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index eb9fcc4b1fd1a..386a32cdc0cc8 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1581,7 +1581,7 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>   #ifdef CONFIG_NETWORK_SECMARK
>   	CHECK_SKB_FIELD(secmark);
>   #endif
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>   	CHECK_SKB_FIELD(napi_id);
>   #endif
>   #ifdef CONFIG_XPS
> 
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
