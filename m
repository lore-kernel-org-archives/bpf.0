Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792844761;
	b=Khwcibu0ryJRWJme2X0S6DBCu3ks+bfld6HpCUp+n3Vs4yM1tGHWY/hkuGYVuRv1uK1q
	 FUruAGEtcCas5wwzh31kaDzfvs66Fkn822uVilp4oAuta2STfDZ3QXrKs/4iLDgK6O2jd
	 iGvTNDBbWo8SYVDjsAyrmSDaduvfqLiiP3skR7QZeAy7uD32/GyehJRHNCguc4e2KlkJc
	 V9xJobSrEOnPigcbPrWASp9oCvO+F9AtaNOaOOZM49vo2+JsCL7BDl5TaxgYI9MO01O35
	 g8BoDUQe5b1sFTGBgtGoiCpc+OU2d45mdJyr8a+5c9sG0O52QA9M14lwiZTLB3iQtHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xF3nK2266GrESEfhk2mCS++Di1L2yhOWpJ1GfRqj+4M=;
	b=u4CyjWs5kjsdzDtJmzPotC0cYWogJlzboonUdGd2O8vYt947xFEERq2rTZmUPbpbNTDK
	 p2mWA2pL3WR048FLTu6wm1n4cvZoNwOkewE0azp05+fzb2XqsL2o6Mw4IXYiRaf36sYSn
	 h8HIbgbJJ80CpsvIuDkOeLuiqXqaNRxJ5UjGfksifmuXAjLfOehUebjjdUqbyNdiFfM1c
	 S2c7SGjwsYToVHs6CSqoQjZM4RQ4fy0eLs2c3IiBKH347ZDc3qOoy8vgXxUJoLA1zo132
	 lz3k/i/H4Fisf3FRdCQjqIS9NfKgi82tYXv2V4xsuK9YcmuzT1stpE70vFot0hz1M2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZaVWNVws;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3F60A2621
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 12:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3A3F60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZaVWNVws
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso1567548e87.0
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 05:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792844759; cv=none;
        d=google.com; s=arc-20260327;
        b=mFog5Dl41DiG648yGI7n3RxRaXCZ3YvzgIQCLZ672M7gjWNU6UL0wQuEeHT8Y+d1Ni
         lw1Ah+DYWLuMJv6SEvN9xttGXX43JMaXVYxYeb6cEJsyzj2n03Z5sVkKoTUfq3Q8rgWe
         ogybBVAxZajsIvmQwsaYoBt/7qKV59fqSScBNgozabFBsyAJkciNnqEM2dV9VxWnU4Uw
         esQKc6b5mWzKCG9fVzrNXyeFu94HFiTb1cJTA0VSLFWHbckBXG3BAMzeBVuKh8oFviNu
         pjHuwvLYYwjUJHJ8IwRTPIyVZQys8IhFQ1mjsneii5Uvq0/UntDt6p9okEB7w54po39P
         mcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xF3nK2266GrESEfhk2mCS++Di1L2yhOWpJ1GfRqj+4M=;
        fh=sJhWo2cY4FzRpkWmg5ez8XcQ2N/jZu0ODPAq6KvQh6Y=;
        b=paRdbNtxQR8ywWXoMBrrdHSc/R61nQfBPdgApBX9moZMuAwvqpwskILIRtMiGGoAzE
         KpeoaK0SzuuHPc6Tn2d+CQQCLLR/2YE+6Xy9CpxkcmGeAnS/4jVqezg9yD6Hw3h2/Q3s
         +7nvPvlEDhk9DHOrvRBQTWXDCa/C12UOhdVcrl3xrwArYRKw1mADl+7GwxbidzFk9MUh
         QEGEYPBkfqXg1GrZ7B0MGbzdOPG3WOBWFP9eaimdfQ3DscK1lasdsg+JPuzs4uXEKGTX
         fv36eFO3+Ra8RoZ4QHemXb3eNKmKC5Tg/o3KBtykgkAUO+qRtTWLSmiQZZd56mGegQph
         6G8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792844759; x=1793449559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xF3nK2266GrESEfhk2mCS++Di1L2yhOWpJ1GfRqj+4M=;
        b=ZaVWNVwsn2jDCv1fiE1xt7rHVMSix2n8thz/LMie/1AcLvHWr5+WSPjU9dCAaAe3uY
         ad2zcTLw/zkZSRJve02ZvWYLmSK2UD8rCjhM5opKeeJV/+yHJk6pBGYpJx5KK2MNqaFW
         wnkUfxgb1Uj6ipV/5hnUaCArU0WKGbLsPVil+l7qv8zOkDLFZCJq4ZbXgFdR4jysjMp9
         exzqPZ5P7Ej2tk5Pr/bxPEQ3p1S2gPOaJYRnblu3OYj9Ofx9uK9585nJ173Sn1d9FNzO
         9d6dVnEyNMH+uBFctqkaWPROpM2Vs45PJoOmvy01Vn/tTkt3rLcGxJXJCDsXlo6XFo4M
         uiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844759; x=1793449559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xF3nK2266GrESEfhk2mCS++Di1L2yhOWpJ1GfRqj+4M=;
        b=sJgS3YduDDqdBdPsKurPp9ATxUQpzJ5KKweKwW3RtF2meGq0HLhIOMwVWwt3YEsGHb
         WtC8JqsIQgnPwZAmxQG0EiZsUSw0v76SCYkpGoBRYNaeEWr0KFPtGlqkvmwECdK3GBpO
         S2Xu31zckfpvU4AsZxXUxIjW2XT7iFW3zw6CmbdDCYfxYPMCJfxMjkSKBLw/eEmIDfiA
         UGZRq1/K/vauxYqztR9tMVwomsZkxoL5wnLCig5bg4dz0EQPUW+cmqsDdxXu1F4TAGjh
         9tPbSQmGW1nBgmyCu7c1SHfVwef1cMyJC8Yimd8g8+Br2NqcM6rwOj2GXXrqt5Z1tv/r
         le3w==
X-Forwarded-Encrypted: i=1; AKwUvBzMelL+fX8wRqutDDrXjlNQz9fXSrlcl86mCQVbPzdlTACeAB//a+YLPWCxSKT/eMnouAU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPj/ButN0DyYYA6Pp2Jqo2jfX+ix4o23J31NUPuStypi5Gg7ky
	e/2RiXi+jKXYbDgRrBYnow1oo373Hp8crsrNhtU3EU9njBxSqReczBqOGc71/rYqlbohLmB4gMh
	ezaBdO/WYMiPq6kqk4u5pfNBooEwHDPI=
X-Gm-Gg: AYBFou3fRwIEaZ38TlzWnt1n5HiUbi0NV18CSdNpfzv0geed2TvewM15tqgmnhe15Xk
	jYJC3MB02kZBEgjSvF9YexlkzkKV4ga42crIWrk68H5oGJAdjG/j5JLoNj58G5jL4hRiMViKsPb
	JLjRHb8b4bEhaiUIdlfugJl984YXMv3q90ZindRqo1paiUCEC8tOuqZolr90USaHcB3L7+GRyz6
	wLQIVFC0+Q6udtmEE8S1hmVWs8gpEDNv25eXLVO5DPvQm9PM/Gzi1kUcA382VLvFiYCTnCVHKeI
	I1odgDynIHmikcaN8BCS4txhMktjc+gG9QfSPtIOixH4sTKHKx8Kiw+lS6fTOFDNzz5+PPYOR5t
	WNqp5v8+A5I4WHRMWAELBjS4z9KPhuIjaFlAv9rSnGVuK9vOYOu1B1M37Pc2NSDGBrSOcpwJqg0
	KVHwFd86TtSIivpvzARmjznLPjngPyJQRyAMQmADkzEzoNjSj8N9o=
X-Received: by 2002:a05:6512:3091:b0:5b8:f0d9:98cd with SMTP id
 2adb3069b0e04-5bfb71ea41cmr688298e87.58.1792844758718; Sat, 24 Oct 2026
 05:25:58 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com>
In-Reply-To: <20261024091256.17918-1-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 24 Oct 2026 20:25:20 +0800
X-Gm-Features: AclHuK99q20jG-ayaS9KssZ6Z-Od3CB6VIOCQBzGSydJ8acKu28CCk7z-t7ILtM
Message-ID: <CAL+tcoDkDV+2RFUadAvSxqxGpiBEd8TN9wJzrKVYySachGXjnQ@mail.gmail.com>
Subject: Re: [PATCH net] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 5:13=E2=80=AFPM Rongzheng Wang <testwrzwrz@gmail.co=
m> wrote:
>
> When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> calls skb_checksum_help() while only the first descriptor has been added =
to
> the skb. The checksum therefore covers just the first fragment, and
> skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> fragments are never included in the checksum.
>
> Move the software checksum calculation to the point where the last
> descriptor has been added to the skb.
>
> On a checksum failure the packet is now dropped instead of being returned
> to the application for a retry. This path is not reachable with the
> existing metadata validation, but the behavior change is intentional.
>
> Add a selftest that sends the same packet as a single descriptor and as t=
wo
> descriptors, verifies the expected UDP checksum, and compares the frames
> captured on the peer.
>
> Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
> ---
>  net/xdp/xsk.c                                 |  25 +-
>  .../selftests/bpf/prog_tests/xdp_metadata.c   | 299 ++++++++++++++++++
>  2 files changed, 316 insertions(+), 8 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..845ae6bde987 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>                 skb->csum_start =3D hr + csum_start;
>                 skb->csum_offset =3D csum_offset;
>                 skb->ip_summed =3D CHECKSUM_PARTIAL;
> -
> -               if (unlikely(pool->tx_sw_csum)) {
> -                       int err;
> -
> -                       err =3D skb_checksum_help(skb);
> -                       if (err)
> -                               return err;
> -               }
>         }
>
>         if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> @@ -1030,6 +1022,14 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>         return 0;
>  }
>
> +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *po=
ol)
> +{
> +       if (!pool->tx_sw_csum || skb->ip_summed !=3D CHECKSUM_PARTIAL)
> +               return 0;
> +
> +       return skb_checksum_help(skb);
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>                                               struct xdp_desc *desc)
>  {
> @@ -1270,6 +1270,15 @@ static int __xsk_generic_xmit(struct sock *sk)
>                         continue;
>                 }
>
> +               if (!xp_mb_desc(&desc)) {
> +                       err =3D xsk_skb_sw_csum(skb, xs->pool);
> +                       if (unlikely(err)) {
> +                               xskq_cons_release(xs->tx);
> +                               xsk_drop_skb(skb);
> +                               goto out;
> +                       }
> +               }
> +
>                 xskq_cons_release(xs->tx);
>
>                 if (xp_mb_desc(&desc)) {

How about adjusting the _position_ like this:
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..f7ee72b4681b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1275,6 +1275,12 @@ static int __xsk_generic_xmit(struct sock *sk)
                if (xp_mb_desc(&desc)) {
                        xs->skb =3D skb;
                        continue;
+               } else {
+                       err =3D xsk_skb_sw_csum(skb, xs->pool);
+                       if (unlikely(err)) {
+                               xsk_drop_skb(skb);
+                               goto out;
+                       }
                }

                err =3D __dev_direct_xmit(skb, xs->queue_id);
?

In terms of the error handling, is it correct to drop this skb? And
reading through the error cases in skb_checksum_help(), we never have
the chance to hit any of them at this point? Please double check that.

Another thing is you're adding this to the hot path. I would add
unlikely or something similar to remove the impact on generic xmit.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tool=
s/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 5c31054ad4a4..21a11300076a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c

Please separate this test from the patch as a 2/2 patch then.

Try to reuse the interfaces that we have and integrate it into the
existing selftests instead of reinventing the wheel from scratch.

Thanks,
Jason

> @@ -6,9 +6,12 @@
>  #include "xdp_metadata.h"
>  #include "xsk.h"
>
> +#include <arpa/inet.h>
>  #include <bpf/btf.h>
>  #include <linux/errqueue.h>
> +#include <linux/if_ether.h>
>  #include <linux/if_link.h>
> +#include <linux/if_packet.h>
>  #include <linux/net_tstamp.h>
>  #include <netinet/udp.h>
>  #include <sys/mman.h>
> @@ -38,6 +41,22 @@
>  #define TX_MAC "00:00:00:00:00:01"
>  #define RX_MAC "00:00:00:00:00:02"
>
> +#define MB_TX_NAME "mb_tx0"
> +#define MB_RX_NAME "mb_rx0"
> +#define MB_NETNS_NAME "xdp_mb_csum"
> +#define MB_UMEM_NUM 4
> +#define MB_UMEM_FRAME_SIZE XSK_UMEM__DEFAULT_FRAME_SIZE
> +#define MB_UMEM_SIZE (MB_UMEM_FRAME_SIZE * MB_UMEM_NUM)
> +#define MB_METADATA_LEN sizeof(struct xsk_tx_metadata)
> +#define MB_PAYLOAD_LEN 128
> +#define MB_SPLIT_LEN 64
> +#define MB_PKT_LEN (sizeof(struct ethhdr) + sizeof(struct iphdr) + \
> +                   sizeof(struct udphdr) + MB_PAYLOAD_LEN)
> +#define MB_TX_ADDR "10.1.0.1"
> +#define MB_RX_ADDR "10.1.0.2"
> +#define MB_SOURCE_PORT 1234
> +#define MB_DEST_PORT 8080
> +
>  #define VLAN_ID 59
>  #define VLAN_PROTO "802.1Q"
>  #define VLAN_PID htons(ETH_P_8021Q)
> @@ -543,3 +562,283 @@ void test_xdp_metadata(void)
>         SYS_NOFAIL("ip netns del " RX_NETNS_NAME);
>         SYS_NOFAIL("ip netns del " TX_NETNS_NAME);
>  }
> +
> +static int open_xsk_mb(int ifindex, struct xsk *xsk)
> +{
> +       const struct xsk_socket_config socket_config =3D {
> +               .rx_size =3D XSK_RING_PROD__DEFAULT_NUM_DESCS,
> +               .tx_size =3D XSK_RING_PROD__DEFAULT_NUM_DESCS,
> +               .bind_flags =3D XDP_COPY | XDP_USE_SG,
> +       };
> +       const struct xsk_umem_config umem_config =3D {
> +               .fill_size =3D XSK_RING_PROD__DEFAULT_NUM_DESCS,
> +               .comp_size =3D XSK_RING_CONS__DEFAULT_NUM_DESCS,
> +               .frame_size =3D MB_UMEM_FRAME_SIZE,
> +               .flags =3D XDP_UMEM_UNALIGNED_CHUNK_FLAG | XDP_UMEM_TX_SW=
_CSUM |
> +                        XDP_UMEM_TX_METADATA_LEN,
> +               .tx_metadata_len =3D sizeof(struct xsk_tx_metadata),
> +       };
> +       int ret;
> +
> +       xsk->umem_area =3D mmap(NULL, MB_UMEM_SIZE, PROT_READ | PROT_WRIT=
E,
> +                             MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE=
, -1, 0);
> +       if (!ASSERT_NEQ(xsk->umem_area, MAP_FAILED, "mmap"))
> +               return -1;
> +
> +       ret =3D xsk_umem__create(&xsk->umem, xsk->umem_area, MB_UMEM_SIZE=
,
> +                              &xsk->fill, &xsk->comp, &umem_config);
> +       if (!ASSERT_OK(ret, "xsk_umem__create"))
> +               return ret;
> +
> +       ret =3D xsk_socket__create(&xsk->socket, ifindex, QUEUE_ID, xsk->=
umem,
> +                                &xsk->rx, &xsk->tx, &socket_config);
> +       if (!ASSERT_OK(ret, "xsk_socket__create"))
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static void close_xsk_mb(struct xsk *xsk)
> +{
> +       if (xsk->socket)
> +               xsk_socket__delete(xsk->socket);
> +       if (xsk->umem)
> +               xsk_umem__delete(xsk->umem);
> +       if (xsk->umem_area && xsk->umem_area !=3D MAP_FAILED)
> +               munmap(xsk->umem_area, MB_UMEM_SIZE);
> +}
> +
> +static __sum16 mb_build_packet(u8 *pkt)
> +{
> +       struct ethhdr *eth =3D (void *)pkt;
> +       struct iphdr *iph =3D (void *)(eth + 1);
> +       struct udphdr *udph =3D (void *)(iph + 1);
> +       __sum16 expected;
> +
> +       memset(pkt, 0, MB_PKT_LEN);
> +       memcpy(eth->h_dest, RX_MAC, ETH_ALEN);
> +       memcpy(eth->h_source, TX_MAC, ETH_ALEN);
> +       eth->h_proto =3D htons(ETH_P_IP);
> +
> +       iph->version =3D 4;
> +       iph->ihl =3D 5;
> +       iph->tot_len =3D htons((u16)(MB_PKT_LEN - sizeof(*eth)));
> +       iph->id =3D htons(1);
> +       iph->ttl =3D 64;
> +       iph->protocol =3D IPPROTO_UDP;
> +       iph->saddr =3D inet_addr(MB_TX_ADDR);
> +       iph->daddr =3D inet_addr(MB_RX_ADDR);
> +       iph->check =3D build_ip_csum(iph);
> +
> +       udph->source =3D htons(MB_SOURCE_PORT);
> +       udph->dest =3D htons(MB_DEST_PORT);
> +       udph->len =3D htons((u16)(sizeof(*udph) + MB_PAYLOAD_LEN));
> +       memset(udph + 1, 0xaa, MB_PAYLOAD_LEN);
> +
> +       expected =3D build_udp_v4_csum(iph, udph);
> +       udph->check =3D ~csum_tcpudp_magic(iph->saddr, iph->daddr,
> +                                        ntohs(udph->len), IPPROTO_UDP, 0=
);
> +       return expected;
> +}
> +
> +static int mb_send_packet(struct xsk *xsk, const u8 *pkt, bool split)
> +{
> +       struct xsk_tx_metadata *meta;
> +       struct xdp_desc *tx_desc;
> +       u32 idx, num =3D split ? 2 : 1;
> +       u8 *frame;
> +       int ret;
> +
> +       ret =3D xsk_ring_prod__reserve(&xsk->tx, num, &idx);
> +       if (!ASSERT_EQ(ret, num, "xsk_ring_prod__reserve"))
> +               return -1;
> +
> +       if (split) {
> +               frame =3D xsk_umem__get_data(xsk->umem_area, MB_UMEM_FRAM=
E_SIZE);
> +               meta =3D (struct xsk_tx_metadata *)frame;
> +               memcpy(frame + MB_METADATA_LEN, pkt, MB_SPLIT_LEN);
> +
> +               tx_desc =3D xsk_ring_prod__tx_desc(&xsk->tx, idx);
> +               tx_desc->addr =3D MB_UMEM_FRAME_SIZE + MB_METADATA_LEN;
> +               tx_desc->len =3D MB_SPLIT_LEN;
> +               tx_desc->options =3D XDP_TX_METADATA | XDP_PKT_CONTD;
> +
> +               frame =3D xsk_umem__get_data(xsk->umem_area,
> +                                          2 * MB_UMEM_FRAME_SIZE);
> +               memcpy(frame + MB_METADATA_LEN, pkt + MB_SPLIT_LEN,
> +                      MB_PKT_LEN - MB_SPLIT_LEN);
> +
> +               tx_desc =3D xsk_ring_prod__tx_desc(&xsk->tx, idx + 1);
> +               tx_desc->addr =3D 2 * MB_UMEM_FRAME_SIZE + MB_METADATA_LE=
N;
> +               tx_desc->len =3D (u32)(MB_PKT_LEN - MB_SPLIT_LEN);
> +               tx_desc->options =3D 0;
> +       } else {
> +               frame =3D xsk_umem__get_data(xsk->umem_area, 0);
> +               meta =3D (struct xsk_tx_metadata *)frame;
> +               memcpy(frame + MB_METADATA_LEN, pkt, MB_PKT_LEN);
> +
> +               tx_desc =3D xsk_ring_prod__tx_desc(&xsk->tx, idx);
> +               tx_desc->addr =3D MB_METADATA_LEN;
> +               tx_desc->len =3D (u32)MB_PKT_LEN;
> +               tx_desc->options =3D XDP_TX_METADATA;
> +       }
> +
> +       memset(meta, 0, sizeof(*meta));
> +       meta->flags =3D XDP_TXMD_FLAGS_CHECKSUM;
> +       meta->request.csum_start =3D (u16)(sizeof(struct ethhdr) + sizeof=
(struct iphdr));
> +       meta->request.csum_offset =3D (u16)offsetof(struct udphdr, check)=
;
> +
> +       xsk_ring_prod__submit(&xsk->tx, num);
> +
> +       ret =3D sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT=
,
> +                    NULL, 0);
> +       if (!ASSERT_GE(ret, 0, "sendto"))
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static int mb_wait_completion(struct xsk *xsk, u32 num)
> +{
> +       struct pollfd pfd =3D {
> +               .fd =3D xsk_socket__fd(xsk->socket),
> +               .events =3D POLLOUT,
> +       };
> +       u32 idx;
> +       int ret, i;
> +
> +       for (i =3D 0; i < 100; i++) {
> +               ret =3D xsk_ring_cons__peek(&xsk->comp, num, &idx);
> +               if (ret =3D=3D num) {
> +                       xsk_ring_cons__release(&xsk->comp, num);
> +                       return 0;
> +               }
> +               poll(&pfd, 1, 1);
> +       }
> +
> +       return -1;
> +}
> +
> +static int mb_recv_packet(int fd, u8 *buf, size_t len)
> +{
> +       struct sockaddr_ll sll;
> +       socklen_t sll_len;
> +       struct pollfd pfd =3D {
> +               .fd =3D fd,
> +               .events =3D POLLIN,
> +       };
> +       struct ethhdr *eth;
> +       struct iphdr *iph;
> +       struct udphdr *udph;
> +       int ret;
> +
> +       for (;;) {
> +               ret =3D poll(&pfd, 1, 1000);
> +               if (ret <=3D 0)
> +                       return -1;
> +
> +               sll_len =3D sizeof(sll);
> +               ret =3D recvfrom(fd, buf, len, 0, (struct sockaddr *)&sll=
,
> +                              &sll_len);
> +               if (ret < 0)
> +                       return -1;
> +               if (ret < (int)(sizeof(*eth) + sizeof(*iph) + sizeof(*udp=
h)))
> +                       continue;
> +
> +               eth =3D (void *)buf;
> +               if (eth->h_proto !=3D htons(ETH_P_IP))
> +                       continue;
> +               iph =3D (void *)(eth + 1);
> +               if (iph->protocol !=3D IPPROTO_UDP)
> +                       continue;
> +               udph =3D (void *)(iph + 1);
> +               if (udph->dest !=3D htons(MB_DEST_PORT))
> +                       continue;
> +
> +               return ret;
> +       }
> +}
> +
> +void test_xdp_metadata_mb_csum(void)
> +{
> +       struct nstoken *tok =3D NULL;
> +       struct sockaddr_ll sll =3D {};
> +       struct udphdr *single_udp;
> +       struct udphdr *multi_udp;
> +       __sum16 expected_csum;
> +       u8 pkt[MB_PKT_LEN];
> +       u8 single[MB_PKT_LEN];
> +       u8 multi[MB_PKT_LEN];
> +       struct xsk xsk =3D {};
> +       int tx_ifindex, rx_ifindex;
> +       int pkt_fd =3D -1;
> +       int single_len;
> +       int multi_len;
> +       int ret;
> +
> +       SYS_NOFAIL("ip netns del " MB_NETNS_NAME);
> +       SYS(out, "ip netns add " MB_NETNS_NAME);
> +       tok =3D open_netns(MB_NETNS_NAME);
> +       if (!ASSERT_OK_PTR(tok, "setns"))
> +               goto out;
> +
> +       SYS(out, "ip link add " MB_TX_NAME " type veth peer name " MB_RX_=
NAME);
> +       SYS(out, "ip link set dev " MB_TX_NAME " up");
> +       SYS(out, "ip link set dev " MB_RX_NAME " up");
> +
> +       tx_ifindex =3D if_nametoindex(MB_TX_NAME);
> +       rx_ifindex =3D if_nametoindex(MB_RX_NAME);
> +       if (!ASSERT_NEQ(tx_ifindex, 0, "if_nametoindex(tx)") ||
> +           !ASSERT_NEQ(rx_ifindex, 0, "if_nametoindex(rx)"))
> +               goto out;
> +
> +       ret =3D open_xsk_mb(tx_ifindex, &xsk);
> +       if (!ASSERT_OK(ret, "open_xsk_mb"))
> +               goto out;
> +
> +       pkt_fd =3D socket(AF_PACKET, SOCK_RAW | SOCK_CLOEXEC, htons(ETH_P=
_ALL));
> +       if (!ASSERT_GE(pkt_fd, 0, "socket(AF_PACKET)"))
> +               goto out;
> +
> +       sll.sll_family =3D AF_PACKET;
> +       sll.sll_protocol =3D htons(ETH_P_ALL);
> +       sll.sll_ifindex =3D rx_ifindex;
> +       if (!ASSERT_OK(bind(pkt_fd, (struct sockaddr *)&sll, sizeof(sll))=
,
> +                      "bind(AF_PACKET)"))
> +               goto out;
> +
> +       expected_csum =3D mb_build_packet(pkt);
> +
> +       if (!ASSERT_OK(mb_send_packet(&xsk, pkt, false), "send single"))
> +               goto out;
> +       single_len =3D mb_recv_packet(pkt_fd, single, sizeof(single));
> +       if (!ASSERT_EQ(single_len, (int)MB_PKT_LEN, "recv single"))
> +               goto out;
> +       single_udp =3D (void *)(single + sizeof(struct ethhdr) + sizeof(s=
truct iphdr));
> +       if (!ASSERT_EQ(single_udp->check, expected_csum, "single checksum=
"))
> +               goto out;
> +       if (!ASSERT_OK(mb_wait_completion(&xsk, 1), "complete single"))
> +               goto out;
> +
> +       if (!ASSERT_OK(mb_send_packet(&xsk, pkt, true), "send multi"))
> +               goto out;
> +       multi_len =3D mb_recv_packet(pkt_fd, multi, sizeof(multi));
> +       if (!ASSERT_EQ(multi_len, (int)MB_PKT_LEN, "recv multi"))
> +               goto out;
> +       multi_udp =3D (void *)(multi + sizeof(struct ethhdr) + sizeof(str=
uct iphdr));
> +       if (!ASSERT_EQ(multi_udp->check, expected_csum, "multi checksum")=
)
> +               goto out;
> +       if (!ASSERT_OK(mb_wait_completion(&xsk, 2), "complete multi"))
> +               goto out;
> +
> +       ASSERT_EQ(memcmp(single, multi, MB_PKT_LEN), 0,
> +                 "single and multi-buffer packets differ");
> +
> +out:
> +       if (pkt_fd >=3D 0)
> +               close(pkt_fd);
> +       close_xsk_mb(&xsk);
> +       if (tok)
> +               close_netns(tok);
> +       SYS_NOFAIL("ip netns del " MB_NETNS_NAME);
> +}
> --
> 2.39.5 (Apple Git-154)
>
>
