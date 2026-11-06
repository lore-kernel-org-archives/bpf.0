Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793946982;
	b=jsfvuz6ZweJCtF/qwCZU67kHlWnyq7jQmGQoByKiq165aJ010SEAdmVsmOQjSqAMsrey
	 kq5dl5PAgx6n388ORaggzdmgE717Hj4SMWQiQbH6SqrYjKXA4XeSGatWLy11QhQi3DZdY
	 IYJccU6BX1s/7qF+SlXMYtUr2DMf8cY4TTJTzro3OuZmKt95ok1l0N6EqRBiXRfTe3zez
	 jQR9YTqkRP5vpb4ISI2xSEcfPcz83oAFteR4TkmUNaOTKEZFBcEdCL7d91KDScRo7sETl
	 g+RzB1MxlxrD37Fz5WrhZ2WjRgfjfYBxiVMUS32ym3CvBjyNtS6mYCyFrzEQ6s08CvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793946982;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=HSkq7GM/C7a8WzdehCU5wxcvtBC9C9CoJO/ODOkIDzs=;
	b=PfBmVOkD+V9Yp92CA38tI22uK03MIYvQh6/awo9c89JjWFRKAvig5G5r2o//ri4jnldj
	 OeE8fJY4YSBKsiXwDEt6tIMjEnyFXunEkeoAmhcFDjAYEzis+EUoxWy4l2OurQcf2tJVB
	 oLXZSgrVIuZLJJ4d05EJNQ1iqjzT6VbtlA0xhjr+Y28eEGDYm0ubXjSUjNPle9f4dkp1D
	 cTjJ3kH9MsXy8CdbOgM0mhgiZtG+ezWYMJ4liU4YRvsQbL4zpO33EEOn2c9bDEb7MQ0Hd
	 TuLO1H0zFOfNouS/V8Fkx73Wi7u2UZ7/RVdABChBfZ3Th1COUhCre4+QxgDVi2yEAPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=KtTxaRmA;
	arc=none smtp.remote-ip=185.70.43.96
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68096606A328;
	Fri,  6 Nov 2026 06:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68096606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=KtTxaRmA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793946975; x=1794206175;
	bh=HSkq7GM/C7a8WzdehCU5wxcvtBC9C9CoJO/ODOkIDzs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KtTxaRmAXOyIoVXeeIsPjLsZ7swy2hG7y7mFLGdW3kC4jInBu2uCOIGKiCL2j2cLg
	 WF4DuioBfuVqDw4aN6snsDEyTm1tiayWlpR3kozsr1eh+3y3PyOiSwx3XY/1AOpQs7
	 NQO+RsY1frOV3eciiO/9siXk7BO3quAkrOTuo+iNCOUdCV8QN0fjfkDTcZoTjrys9Y
	 gTnqH/oHMr1IahYsENwILs7hdmkLe+LJpxX2XTMiMnzWFcQ6W5UpbIKnw3o6vTKhEl
	 E8+o2QgowLpMlPvRQofkryAAiVRybcZtBx1gXEmvDedoFQERxAAUZNpeRq64FdQr/0
	 HqDTdU2+cqr6A==
Date: Fri, 06 Nov 2026 06:36:05 +0000
To: Ding Meng <meng.ding@siemens.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Richard Cochran <richardcochran@gmail.com>, florian.bezdeka@siemens.com, jan.kiszka@siemens.com, wq.wang@siemens.com, gerhard@engleder-embedded.com, Jason Xing <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <KPhGx8a4LdMBr3rj5NRNGc_DxDUpjoDXn1RDkAisaWwvTg_MoClMGQ0iCyrMM6Ev21UbYwHrlCBPZ-xJUx0NbOMhSY1o8MlozwhRUSs15SQ=@1g4.org>
In-Reply-To: <eqrkw7wsawjtbvjkndmpik7jryb2sau6fdsu4njw6twn2lcfp3@k67o5wav5f5m>
References: <20261105071706.7043-1-meng.ding@siemens.com> <Tif4BSB0H3l8O1bLzRnhCE9hUYhsz6G3MIhQAgYZImUx1_8YwnCyzy89IV6OSTsXdHDT6fFf7rEL1qfRFJC9OPDHRlhl3cgNJyyE_mVlHWM=@1g4.org> <eqrkw7wsawjtbvjkndmpik7jryb2sau6fdsu4njw6twn2lcfp3@k67o5wav5f5m>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 98fcd52a7ec1792cf8bb61aff9005d55238b06cf
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





On Thursday, November 5th, 2026 at 11:50 PM, Ding Meng <meng.ding@siemens.c=
om> wrote:

> On Thu, Nov 05, 2026 at 10:29:51PM +0000, Paul Moses wrote:
> >
> >
> >
> >
> > On Thursday, November 5th, 2026 at 1:19 AM, Ding Meng <meng.ding@siemen=
s.com> wrote:
> >
> > > Commit 97dc7cd92ac6 ("ptp: Support late timestamp determination")
> > > added support for deferring RX timestamp conversion to
> > > ndo_get_tstamp(). When the timestamp is consumed, get_timestamp()
> > > uses the skb's NAPI ID to find the device that owns the timestamp
> > > cookie and invoke its callback.
> > >
> > > Commit e68b6e50fa35 ("udp: enable busy polling for all sockets")
> > > gated NAPI ID bookkeeping with CONFIG_NET_RX_BUSY_POLL. As a result,
> > > when busy polling is disabled, the skb may not carry a usable NAPI ID=
.
> > > The device lookup then fails, so the driver callback is not invoked.
> > > get_timestamp() falls back to hwtstamp, which does not contain the
> > > converted timestamp, resulting in an incorrect RX hardware timestamp.
> > >
> > > Record skb NAPI IDs independently of busy-poll support to support
> > > drivers that use deferred timestamp conversion and future driver
> > > features that need to look up a device by its NAPI ID.
> > >
> > > Signed-off-by: Ding Meng <meng.ding@siemens.com>
> > > Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > ---
> > > In the discussion of the issue reported at
> > > https://lore.kernel.org/netdev/20260630112056.885071-1-meng.ding@siem=
ens.com/
> > > this previous patch added an igc-specific fallback for configurations
> > > with CONFIG_NET_RX_BUSY_POLL disabled. It populated skb's hwtstamp
> > > field with a timestamp converted using the default hardware timer,
> > > allowing get_timestamp() to return it without invoking ndo_get_tstamp=
().
> > > But Jakub Kicinski noted that the proposed fix appeared to be a
> > > driver-specific workaround for a generic problem. The engleder driver
> > > would also be affected by the same issue.
> > >
> > > This patch introduces a new configuration option to enable NAPI ID
> > > bookkeeping independently of busy polling. The option is enabled
> > > whenever busy polling is enabled, preserving the existing behavior.
> > > It is also selected by the igc and engleder drivers, ensuring that
> > > skbs carry a NAPI ID even when busy polling is disabled.
> > >
> > > Another approach considered was to require drivers using deferred
> > > timestamp conversion, such as igc and engleder, to enable busy pollin=
g.
> > > However, this would introduce an unnecessary dependency between two
> > > independent features: hardware timestamp reporting should not require
> > > busy polling to be enabled.
> > >
> > > Timestamping has been tested only with igc; it has not been tested
> > > with engleder.
> > >
> > >  Documentation/networking/timestamping.rst | 11 ++++++++---
> > >  drivers/net/ethernet/engleder/Kconfig     |  1 +
> > >  drivers/net/ethernet/intel/Kconfig        |  1 +
> > >  include/linux/skbuff.h                    |  4 ++--
> > >  include/net/busy_poll.h                   |  2 +-
> > >  include/trace/events/net.h                |  2 +-
> > >  net/Kconfig                               |  4 ++++
> > >  net/core/filter.c                         |  2 +-
> > >  net/core/skbuff.c                         |  2 +-
> > >  9 files changed, 20 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/Documentation/networking/timestamping.rst b/Documentatio=
n/networking/timestamping.rst
> > > index 2162c4f2b28a6..dbe40a1972639 100644
> > > --- a/Documentation/networking/timestamping.rst
> > > +++ b/Documentation/networking/timestamping.rst
> > > @@ -278,9 +278,14 @@ SOF_TIMESTAMPING_OPT_PKTINFO:
> > >    packets with hardware timestamps. The message contains struct
> > >    scm_ts_pktinfo, which supplies the index of the real interface whi=
ch
> > >    received the packet and its length at layer 2. A valid (non-zero)
> > > -  interface index will be returned only if CONFIG_NET_RX_BUSY_POLL i=
s
> > > -  enabled and the driver is using NAPI. The struct contains also two
> > > -  other fields, but they are reserved and undefined.
> > > +  interface index will be returned only if CONFIG_SKB_MARK_NAPI_ID i=
s
> > > +  enabled and the driver is using NAPI. This hidden configuration is
> > > +  selected automatically by busy-poll support and by drivers that ne=
ed
> > > +  skb NAPI IDs to resolve deferred hardware timestamps. Drivers that
> > > +  use deferred timestamp conversion must select it so the networking
> > > +  stack can find the device and call its timestamp callback even whe=
n
> > > +  busy polling is disabled. The struct contains also two other field=
s,
> > > +  but they are reserved and undefined.
> > >
> > >  SOF_TIMESTAMPING_OPT_TX_SWHW:
> > >    Request both hardware and software timestamps for outgoing packets
> > > diff --git a/drivers/net/ethernet/engleder/Kconfig b/drivers/net/ethe=
rnet/engleder/Kconfig
> > > index 3df6bf476ae7e..9700a243bea11 100644
> > > --- a/drivers/net/ethernet/engleder/Kconfig
> > > +++ b/drivers/net/ethernet/engleder/Kconfig
> > > @@ -22,6 +22,7 @@ config TSNEP
> > >  =09depends on PTP_1588_CLOCK_OPTIONAL
> > >  =09select PHYLIB
> > >  =09select PAGE_POOL
> > > +=09select SKB_MARK_NAPI_ID
> > >  =09help
> > >  =09  Support for the Engleder TSN endpoint Ethernet MAC IP Core.
> > >
> > > diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/etherne=
t/intel/Kconfig
> > > index 780f113986ea8..7fb63f351fc20 100644
> > > --- a/drivers/net/ethernet/intel/Kconfig
> > > +++ b/drivers/net/ethernet/intel/Kconfig
> > > @@ -376,6 +376,7 @@ config IGC
> > >  =09depends on PCI
> > >  =09depends on PTP_1588_CLOCK_OPTIONAL
> > >  =09depends on ETHTOOL_NETLINK
> > > +=09select SKB_MARK_NAPI_ID
> > >  =09help
> > >  =09  This driver supports Intel(R) Ethernet Controller I225-LM/I225-=
V
> > >  =09  family of adapters.
> > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > index 6787fcf6ac3e4..164c862f7a403 100644
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -1059,7 +1059,7 @@ struct sk_buff {
> > >  =09=09=09__u16=09vlan_tci;
> > >  =09=09};
> > >  =09};
> > > -#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
> > > +#if defined(CONFIG_SKB_MARK_NAPI_ID) || defined(CONFIG_XPS)
> > >  =09union {
> > >  =09=09unsigned int=09napi_id;
> > >  =09=09unsigned int=09sender_cpu;
> > > @@ -1267,7 +1267,7 @@ static inline bool skb_pkt_type_ok(u32 ptype)
> > >   */
> > >  static inline unsigned int skb_napi_id(const struct sk_buff *skb)
> > >  {
> > > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> > >  =09return skb->napi_id;
> > >  #else
> > >  =09return 0;
> > > diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> > > index 6e172d0f6ef5f..f7c0e62c6a7d7 100644
> > > --- a/include/net/busy_poll.h
> > > +++ b/include/net/busy_poll.h
> > > @@ -130,7 +130,7 @@ static inline void sk_busy_loop(struct sock *sk, =
int nonblock)
> > >  static inline void __skb_mark_napi_id(struct sk_buff *skb,
> > >  =09=09=09=09      const struct gro_node *gro)
> > >  {
> > > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> > >  =09/* If the skb was already marked with a valid NAPI ID, avoid over=
writing
> > >  =09 * it.
> > >  =09 */
> > > diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> > > index dbc2c5598e35a..99ed7645242eb 100644
> > > --- a/include/trace/events/net.h
> > > +++ b/include/trace/events/net.h
> > > @@ -208,7 +208,7 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
> > >
> > >  =09TP_fast_assign(
> > >  =09=09__assign_str(name);
> > > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> > >  =09=09__entry->napi_id =3D napi_id_valid(skb->napi_id) ?
> > >  =09=09=09=09   skb->napi_id : 0;
> > >  #else
> > > diff --git a/net/Kconfig b/net/Kconfig
> > > index 76ab44aa439a6..8fa7586dc08ca 100644
> > > --- a/net/Kconfig
> > > +++ b/net/Kconfig
> > > @@ -346,9 +346,13 @@ config CGROUP_NET_CLASSID
> > >  =09  Cgroup subsystem for use as general purpose socket classid mark=
er that is
> > >  =09  being used in cls_cgroup and for netfilter matching.
> > >
> > > +config SKB_MARK_NAPI_ID
> > > +=09bool
> > > +
> > >  config NET_RX_BUSY_POLL
> > >  =09bool
> > >  =09default y if !PREEMPT_RT || (PREEMPT_RT && !NETCONSOLE)
> > > +=09select SKB_MARK_NAPI_ID
> > >
> > >  config BQL
> > >  =09bool
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index b7ac145b68b1f..e2218c18622b8 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -10274,7 +10274,7 @@ static u32 bpf_convert_ctx_access(enum bpf_ac=
cess_type type,
> > >  =09=09break;
> > >
> > >  =09case offsetof(struct __sk_buff, napi_id):
> > > -#if defined(CONFIG_NET_RX_BUSY_POLL)
> > > +#if defined(CONFIG_SKB_MARK_NAPI_ID)
> > >  =09=09*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
> > >  =09=09=09=09      bpf_target_off(struct sk_buff, napi_id, 4,
> > >  =09=09=09=09=09=09     target_size));
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index eb9fcc4b1fd1a..386a32cdc0cc8 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -1581,7 +1581,7 @@ static void __copy_skb_header(struct sk_buff *n=
ew, const struct sk_buff *old)
> > >  #ifdef CONFIG_NETWORK_SECMARK
> > >  =09CHECK_SKB_FIELD(secmark);
> > >  #endif
> > > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> > >  =09CHECK_SKB_FIELD(napi_id);
> > >  #endif
> > >  #ifdef CONFIG_XPS
> > >
> > > base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> > > --
> > > 2.47.3
> > >
> > >
> >
> > Are you sure this does not make the preexisting timestamp lifetime
> > issue more pathological? I think it needs to be fixed now as well.
> > It was the last item mentioned by Sashiko in your review if I
> > remember correctly.
> >
> > Paul
>=20
> The hardware timestamp lifetime issue may indeed exist,
> but it is independent of this patch. Even if that issus is fixed,
> we still need to obtain the netdevice from the skb, so the decoupling
> configuration introduced by this patch is still necessary.
>=20
> Ding Meng
>=20

Your patch changes non busy poll kernels from returning the raw cookie=20
pointer to dereferencing that cookie just like busy poll already did.

So I guess that's an improvement? My apathy has reached a threshold
where that sounds good to me.

The big question is why does igc alone need core modification to properly=
=20
store Timer 1. Seemed like an intel question so I digress.

Good luck and have fun


[    7.971832] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    7.971852] BUG: KASAN: use-after-free in igc_ptp_rx_pktstamp+0x12c/0x19=
0
[    7.972002] Read of size 4 at addr ffff88800549c008 by task test/197
[    7.972013]=20
[    7.972041] CPU: 0 UID: 65534 PID: 197 Comm: test Not tainted 7.3.0-nobu=
sy-patched-20261105+ #1 PREEMPT_RT=20
[    7.972064] Call Trace:
[    7.972103]  <TASK>
[    7.972122]  dump_stack_lvl+0x43/0x60
[    7.972215]  print_address_description+0x55/0x1d0
[    7.972265]  ? igc_ptp_rx_pktstamp+0x12c/0x190
[    7.972285]  print_report+0x58/0x70
[    7.972295]  kasan_report+0x130/0x170
[    7.972356]  ? igc_ptp_rx_pktstamp+0x12c/0x190
[    7.972366]  igc_ptp_rx_pktstamp+0x12c/0x190
[    7.972375]  __sock_recv_timestamp+0x72b/0xe10
[    7.972451]  __sock_recv_cmsgs+0x168/0x3c0
[    7.972461]  udp_recvmsg+0x4c9/0xb40
[    7.972525]  ? __pfx_inet_recvmsg+0x10/0x10
[    7.972546]  sock_recvmsg+0x125/0x170
[    7.972556]  ____sys_recvmsg+0x167/0x3b0
[    7.972567]  __sys_recvmsg+0x14c/0x1b0
[    7.972578]  ? do_syscall_64+0x115/0x310
[    7.972660]  do_syscall_64+0xdb/0x310
[    7.972671]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    7.972697] RIP: 0033:0x20af4c
[    7.972726] Code: be 01 00 00 00 0f 05 c3 cc cc cc cc cc cc 4d 89 cb 48 =
89 f8 4c 8b 4c 24 08 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 d8 0f 05 <c3=
> cc cc cc e9 db ff ff ff cc cc cc c3 cc cc cc cc cc cc cc 55 41
[    7.972744] RSP: 002b:00007ffd6dcb7308 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002f
[    7.972775] RAX: ffffffffffffffda RBX: 00007ffd6dcb73a0 RCX: 00000000002=
0af4c
[    7.972783] RDX: 0000000000000000 RSI: 00007ffd6dcb7320 RDI: 00000000000=
00003
[    7.972790] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000000=
00000
[    7.972796] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00230
[    7.972802] R13: 00007ffd6dcb73e0 R14: 0000000000000000 R15: 00007ffd6dc=
b75e0
[    7.972812]  </TASK>



