Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917809;
	b=4KMyObpKXIqdfoo3gA/oJPwUcW9TUT8PfrdoMMUptcHpRaHyAyI8T7TpQI6OtZbbQiMx
	 iEjwg2FZZazxukpMifu0ZKh4L9WNbJ89g1JboxkdxwtaPk1IEgLoQ090w1PorWVVE1nRV
	 eQotrwD2UdiYjXf31Ltv9NNnitb3CqRjOG1P3PPB+JeQ+Zcclhx1JKtOmXBHsVjr5b9PF
	 MuV0R4P3tHILrtE2WhxU+EJwxXn56+frm3S3RJiAjcrQ/tex36kNIKRjdGQNtTAGwUQHJ
	 Fe6xsf7jkhkphxavefx1k1Tyzem0VaZp8gVgoLNXnEtS4DOGVQs9bEncWxAU/P0NGJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917809;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=viuLjYesmtJpA1sjvM4v1Scr8RvgUg7KgCw53WlMpzY=;
	b=CNhhsZ/lx0ELRt7S1Ow7IY2IVFQbx2ASZajAFFR2/vnazG0rxtIfb5UhfOcFtKwa9Ne9
	 /PuSI2xZYk+mIeXZ628CDJu5DqLTv3Pbt5ctUYtOEOHQAKVliCArxOkUe7RCfJig8RRlT
	 pEjP3NJr2vITWrsvRY/LJvre8vZVexbu+YgJJLEPgtsLH2vL9JFD67+etqOQc7wwCnSOe
	 V9yOG3XrMuXgYFk1laax6NlS8xver3KPT9pl8Zq+PbCD/h7A1Gwf1ccC1Z/sXI/mssfaI
	 eTr4E38a8utuBu2T0hoL9Hugt3hTtubaQ+sVNXV1M6WE+XS/Z0WMrtxop4UO9y/nJgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=mMSmuuwV;
	arc=none smtp.remote-ip=185.70.43.96
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C777606A331;
	Thu,  5 Nov 2026 22:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C777606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=mMSmuuwV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793917804; x=1794177004;
	bh=viuLjYesmtJpA1sjvM4v1Scr8RvgUg7KgCw53WlMpzY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mMSmuuwVIEGud4Y5aCYE/GSpTIRBaEj5qlZ61a615iQU2rVQrPljNtKoY6dsUMqFy
	 Ue8+V6w38IEwHIPojjfg6Eqfa0bL88v7g8V9mmXFsOLNDHXGg2A5sBoOBFuPLpEWDA
	 2klPrbRG+FVVDX2pWfgbJXH5LGwYWBu0MOKobG1RjXxBEcUjLADuWs/qAYY3aIckhK
	 qrTq9dxw/AIPbB3Od1V72sUtcoUwRVyrJF8Bzh+EAdLj3CN8QfOsk3uU55LOFBPipJ
	 hm0jVmvXG5YL5WqPR8OUOy/7cmq8wq2teyhRh6JO0DKGhPTpXtTSJW2B9P175aqNoO
	 vmn3WSItZlIxA==
Date: Thu, 05 Nov 2026 22:29:51 +0000
To: Ding Meng <meng.ding@siemens.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Richard Cochran <richardcochran@gmail.com>, florian.bezdeka@siemens.com, jan.kiszka@siemens.com, wq.wang@siemens.com, gerhard@engleder-embedded.com, Jason Xing <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <Tif4BSB0H3l8O1bLzRnhCE9hUYhsz6G3MIhQAgYZImUx1_8YwnCyzy89IV6OSTsXdHDT6fFf7rEL1qfRFJC9OPDHRlhl3cgNJyyE_mVlHWM=@1g4.org>
In-Reply-To: <20261105071706.7043-1-meng.ding@siemens.com>
References: <20261105071706.7043-1-meng.ding@siemens.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 262a97350b81bd39ace0cec8114d774b513fee40
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Thursday, November 5th, 2026 at 1:19 AM, Ding Meng <meng.ding@siemens.co=
m> wrote:

> Commit 97dc7cd92ac6 ("ptp: Support late timestamp determination")
> added support for deferring RX timestamp conversion to
> ndo_get_tstamp(). When the timestamp is consumed, get_timestamp()
> uses the skb's NAPI ID to find the device that owns the timestamp
> cookie and invoke its callback.
>=20
> Commit e68b6e50fa35 ("udp: enable busy polling for all sockets")
> gated NAPI ID bookkeeping with CONFIG_NET_RX_BUSY_POLL. As a result,
> when busy polling is disabled, the skb may not carry a usable NAPI ID.
> The device lookup then fails, so the driver callback is not invoked.
> get_timestamp() falls back to hwtstamp, which does not contain the
> converted timestamp, resulting in an incorrect RX hardware timestamp.
>=20
> Record skb NAPI IDs independently of busy-poll support to support
> drivers that use deferred timestamp conversion and future driver
> features that need to look up a device by its NAPI ID.
>=20
> Signed-off-by: Ding Meng <meng.ding@siemens.com>
> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> In the discussion of the issue reported at
> https://lore.kernel.org/netdev/20260630112056.885071-1-meng.ding@siemens.=
com/
> this previous patch added an igc-specific fallback for configurations
> with CONFIG_NET_RX_BUSY_POLL disabled. It populated skb's hwtstamp
> field with a timestamp converted using the default hardware timer,
> allowing get_timestamp() to return it without invoking ndo_get_tstamp().
> But Jakub Kicinski noted that the proposed fix appeared to be a
> driver-specific workaround for a generic problem. The engleder driver
> would also be affected by the same issue.
>=20
> This patch introduces a new configuration option to enable NAPI ID
> bookkeeping independently of busy polling. The option is enabled
> whenever busy polling is enabled, preserving the existing behavior.
> It is also selected by the igc and engleder drivers, ensuring that
> skbs carry a NAPI ID even when busy polling is disabled.
>=20
> Another approach considered was to require drivers using deferred
> timestamp conversion, such as igc and engleder, to enable busy polling.
> However, this would introduce an unnecessary dependency between two
> independent features: hardware timestamp reporting should not require
> busy polling to be enabled.
>=20
> Timestamping has been tested only with igc; it has not been tested
> with engleder.
>=20
>  Documentation/networking/timestamping.rst | 11 ++++++++---
>  drivers/net/ethernet/engleder/Kconfig     |  1 +
>  drivers/net/ethernet/intel/Kconfig        |  1 +
>  include/linux/skbuff.h                    |  4 ++--
>  include/net/busy_poll.h                   |  2 +-
>  include/trace/events/net.h                |  2 +-
>  net/Kconfig                               |  4 ++++
>  net/core/filter.c                         |  2 +-
>  net/core/skbuff.c                         |  2 +-
>  9 files changed, 20 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/ne=
tworking/timestamping.rst
> index 2162c4f2b28a6..dbe40a1972639 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -278,9 +278,14 @@ SOF_TIMESTAMPING_OPT_PKTINFO:
>    packets with hardware timestamps. The message contains struct
>    scm_ts_pktinfo, which supplies the index of the real interface which
>    received the packet and its length at layer 2. A valid (non-zero)
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
>=20
>  SOF_TIMESTAMPING_OPT_TX_SWHW:
>    Request both hardware and software timestamps for outgoing packets
> diff --git a/drivers/net/ethernet/engleder/Kconfig b/drivers/net/ethernet=
/engleder/Kconfig
> index 3df6bf476ae7e..9700a243bea11 100644
> --- a/drivers/net/ethernet/engleder/Kconfig
> +++ b/drivers/net/ethernet/engleder/Kconfig
> @@ -22,6 +22,7 @@ config TSNEP
>  =09depends on PTP_1588_CLOCK_OPTIONAL
>  =09select PHYLIB
>  =09select PAGE_POOL
> +=09select SKB_MARK_NAPI_ID
>  =09help
>  =09  Support for the Engleder TSN endpoint Ethernet MAC IP Core.
>=20
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/in=
tel/Kconfig
> index 780f113986ea8..7fb63f351fc20 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -376,6 +376,7 @@ config IGC
>  =09depends on PCI
>  =09depends on PTP_1588_CLOCK_OPTIONAL
>  =09depends on ETHTOOL_NETLINK
> +=09select SKB_MARK_NAPI_ID
>  =09help
>  =09  This driver supports Intel(R) Ethernet Controller I225-LM/I225-V
>  =09  family of adapters.
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6787fcf6ac3e4..164c862f7a403 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1059,7 +1059,7 @@ struct sk_buff {
>  =09=09=09__u16=09vlan_tci;
>  =09=09};
>  =09};
> -#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
> +#if defined(CONFIG_SKB_MARK_NAPI_ID) || defined(CONFIG_XPS)
>  =09union {
>  =09=09unsigned int=09napi_id;
>  =09=09unsigned int=09sender_cpu;
> @@ -1267,7 +1267,7 @@ static inline bool skb_pkt_type_ok(u32 ptype)
>   */
>  static inline unsigned int skb_napi_id(const struct sk_buff *skb)
>  {
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>  =09return skb->napi_id;
>  #else
>  =09return 0;
> diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> index 6e172d0f6ef5f..f7c0e62c6a7d7 100644
> --- a/include/net/busy_poll.h
> +++ b/include/net/busy_poll.h
> @@ -130,7 +130,7 @@ static inline void sk_busy_loop(struct sock *sk, int =
nonblock)
>  static inline void __skb_mark_napi_id(struct sk_buff *skb,
>  =09=09=09=09      const struct gro_node *gro)
>  {
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>  =09/* If the skb was already marked with a valid NAPI ID, avoid overwrit=
ing
>  =09 * it.
>  =09 */
> diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> index dbc2c5598e35a..99ed7645242eb 100644
> --- a/include/trace/events/net.h
> +++ b/include/trace/events/net.h
> @@ -208,7 +208,7 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
>=20
>  =09TP_fast_assign(
>  =09=09__assign_str(name);
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>  =09=09__entry->napi_id =3D napi_id_valid(skb->napi_id) ?
>  =09=09=09=09   skb->napi_id : 0;
>  #else
> diff --git a/net/Kconfig b/net/Kconfig
> index 76ab44aa439a6..8fa7586dc08ca 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -346,9 +346,13 @@ config CGROUP_NET_CLASSID
>  =09  Cgroup subsystem for use as general purpose socket classid marker t=
hat is
>  =09  being used in cls_cgroup and for netfilter matching.
>=20
> +config SKB_MARK_NAPI_ID
> +=09bool
> +
>  config NET_RX_BUSY_POLL
>  =09bool
>  =09default y if !PREEMPT_RT || (PREEMPT_RT && !NETCONSOLE)
> +=09select SKB_MARK_NAPI_ID
>=20
>  config BQL
>  =09bool
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b7ac145b68b1f..e2218c18622b8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10274,7 +10274,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access=
_type type,
>  =09=09break;
>=20
>  =09case offsetof(struct __sk_buff, napi_id):
> -#if defined(CONFIG_NET_RX_BUSY_POLL)
> +#if defined(CONFIG_SKB_MARK_NAPI_ID)
>  =09=09*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
>  =09=09=09=09      bpf_target_off(struct sk_buff, napi_id, 4,
>  =09=09=09=09=09=09     target_size));
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index eb9fcc4b1fd1a..386a32cdc0cc8 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1581,7 +1581,7 @@ static void __copy_skb_header(struct sk_buff *new, =
const struct sk_buff *old)
>  #ifdef CONFIG_NETWORK_SECMARK
>  =09CHECK_SKB_FIELD(secmark);
>  #endif
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>  =09CHECK_SKB_FIELD(napi_id);
>  #endif
>  #ifdef CONFIG_XPS
>=20
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> --
> 2.47.3
>=20
>=20

Are you sure this does not make the preexisting timestamp lifetime
issue more pathological? I think it needs to be fixed now as well.
It was the last item mentioned by Sashiko in your review if I=20
remember correctly.

Paul
