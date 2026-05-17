Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF88194AE6
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778983785; cv=pass; b=mTIaD4Yy0qLyfB/nfloEtU60DxYVldNMZsFJvoJE2imKKFlfMYw0IeOIQwCwndOhJP78LOjdlIJx1Z7Ng6tdwwgyp4FU02CMXgsGF59kXx/17koST+x3NUlZC6VmHaLqBl4IXEqppWzyGJS8hejwfx9yz782hoaVv+djkJiDmz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778983785; c=relaxed/simple;
	bh=wCr4N8mYfYoIPWB9C8PT2ELm8Fckx0JWQsBfxrIsZoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNKy2S6hp1SWYNi8QCzBH4oT9T5vtgIVbUuBGPctevNr5ZEBM9FsZECX6NdOoPGxstgzM0/f7NypNT8XPwMu7TXzAmXRpBBp0OVQV+VrV6jzR1VFswpX4mH6fgQ5ASJemcmErW8dSeJqW8t2JlIpiYZ5zbP8KU9MIV9f52FFslg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8vKpF3q; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8vKpF3q"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a877510541so1394023e87.2
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 19:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778983782; cv=none;
        d=google.com; s=arc-20240605;
        b=UMCNFbUuKISqnGmMrHttfo/TMNR87UCM49Ybepsp0ihj7R5VyTYx1H+VidPiPlFb4v
         GnWW6TOn0RuNZuZr5wVUm2g6XB8r4yfNF+wKYqT/y/HyFWU7MmcSLdCHPWO3c61psBGD
         lo0wDHleUH/9E/xVJorc+opPDEpMUWKuRnsxCdO3Qp0qXENUaLGdQH9xgIxArm33amF1
         nfwRW4qcaxLgjxGNkpzJcNjPCZuYzREeba53BchktiAljX6JtnlOjDpr0B9P5JiS04pn
         JrV92vKraW5HVFJuuI2rUeIKy9oV3tCHun7ySkn1mbz9CfAJ9+VavKm+7xPXEV+SAh0p
         L1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nO3j0t9MiAa/cJqnzOkw+Q9w6M93B+L1CjXXR/zt8LU=;
        fh=hYDCbxPfZzYDlBqmCIstOwyv8lsex/q7q0O8eq0Wj5k=;
        b=MhWW/xhnDqHaVj5h3vXsdErj/QQ2zscjwofxBfSmKEwgkcfyJNn89wJHjYj/aGYyAT
         SRfT20VYOIKyDwOPc7NuR2ylBEDqG/fGMTXRNQHzg148KGjzG/F95HASzn00ECVr849g
         hUbJXgulZm+rNtLrmQxI4gTcZWP/zI/HpBxLSqpSQVg5vbDzfBqDlCpPMIN2zoPOVW2o
         rjf85hOEqI9Q23EkvdIoWj5jkQrNzfNOy7Bn6L66Xqzn7UVUee9LF9xEg4eWvAMmelAT
         6YPdHaZ4UAZy4+GCe6oI/WAhwND/q9dI8UWexb5WkWFhnI1faZorGMuzTTIPADAtw/TJ
         yEog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778983782; x=1779588582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO3j0t9MiAa/cJqnzOkw+Q9w6M93B+L1CjXXR/zt8LU=;
        b=P8vKpF3qvGMznU1qwNMFV/H6wcMlIyX9Fito7HiMvppEbz9rekeFtBLdoGIUQER8IM
         J9v0/LcpK8SFCtoFgE4wVZj7+w6z2ibEePI3Ihz72hmBUTFeVfTp9AgOdXRm3jZ5xJxA
         Kb9mc/4tkrH4CeUvy0tFU4K7E2ZpGYzHyOxCnPUtD8NM1z23CmxE91E1d2tNtIrqI59H
         Kp4YAkT/9UNBcjuEeyJE2cue6rRF+UjVKRrVropuaPHlm8l4qlyIM4p5nlxOEAQ/FWi/
         X/Si4hBtZn8sV1dGkaIg/G+aItKTV8Rbbtgw/MI6S67aPp8B3vHvtlPfwxhAKUz7VPxe
         A8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778983782; x=1779588582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nO3j0t9MiAa/cJqnzOkw+Q9w6M93B+L1CjXXR/zt8LU=;
        b=R0SIeCVgmahglnp4Q8Q3zErwzheycn0EAGZVWMes/3pCw/7znnSb+0A1ZQFBXL9Co+
         hOnzN8vSaij6YrTA5uC03dcGRT8NGrfH34Yja+rbuaRfxyHgqelntxc4on8Gstcw6hHm
         GFIDodhAhuAdnQqFMPLEYOE2mFZL9KR46V+iBK2/1HY51EDmRsJDJ+yioBemawb/4PjI
         muCey1KqZV27wYrAjMdDTVcr7cHxJXJ2CM1WjPLRsrHVqlikCImZuAvOY/yVjg0VSe9H
         INuoD2P6UUUJeNi3KVIXDWko74xqJjCNbG0og0Ac78EqsXX5AtAyM53LIVeIhcdbvE+K
         hprw==
X-Forwarded-Encrypted: i=1; AFNElJ8U/LMMsHy5VpZ7EYRD9crIqsLraWQPovo/FnzX3R2eVny+YvDss1+emVo9Q2n0u+1BacU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1qPBChBVJK60r4HMkkf+seqCQaJMHyKy/uu/P85QgVzEB74T5
	pvHMC8T9sANxDkSpRkTO4s7abb+MmndG07l3mt17iXiFdrUedcBrk/wNtA4GP/vgNkjV+zRxCQT
	Nq+LikoOqVGVxk11oiPA6oP9I+anO89A=
X-Gm-Gg: Acq92OGp19qyhMwPvqDSLAg1sYfhN3T5fETbMIc7DuVn2KKjUv4HAxaSRunnVJ+yGYL
	GIwTy2U5Z2YEEVFb5N7RP29IIHWimUwpl9ojMgWL1vz8eNqYuCvqfjHz4xvPZhW+eMWNFx2+b1l
	93bcR+xVjAOe9KKGqHiQdQeYHWrDeHX+6lZF9muWEbJhL3rhBj8uSEiiU+4rn59RKwRTF2V1MjC
	adtteCxuFhBgcTfuDV7gNb6cPnepg1AmWlMwts4LIl9YuKXuRUC3HWSLmfGgXIOS3P8TNEQk8AH
	uuysUGAVpkBqs6dZNITt+qBW1Sh7yru+MLstQlYLxFZLNyO6nw==
X-Received: by 2002:a05:6512:128a:b0:5a8:6c7b:f9d7 with SMTP id
 2adb3069b0e04-5aa0e769eecmr2807294e87.41.1778983781501; Sat, 16 May 2026
 19:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515123018.80147-1-kerneljasonxing@gmail.com> <agdRCYgpmVKkrQFB@boxer>
In-Reply-To: <agdRCYgpmVKkrQFB@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 17 May 2026 10:09:04 +0800
X-Gm-Features: AVHnY4L8iEfTvBrUVUtHlcv0-8kRC6326SHOWRCABLdtZk3dSp_FwiYWdc9NopI
Message-ID: <CAL+tcoBqr2Hb_Lkprp5brxLeVnr0fQDY=sUKEVdD-CcowZ7BRQ@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] xsk: fix meta and publish of cq issues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 1:00=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, May 15, 2026 at 08:30:13PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The series is the product of previous review from sashiko[1].
> >
> > 1) META
> > patch 1: address TOCTOU around metadata.
> >
> > 2) PUBLISH of CQ
> > patch 2: make sure xsk_addr->addrs[] can be published to cq when
> >          overflow occurs.
> > patch 3: keep cleaning up the continuation descs (more than 17) and
> >          publish its address when overflow occurs.
> > patch 4: like patch 3, but only handles the invalid descs cases.
> >
> > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing=
@gmail.com/
> >
> > ---
> > V2
> > Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxin=
g@gmail.com/
> > 1. adjust selftests (Jakub)
> > 2. add READ_ONCE in patch 1 (Stan)
> >
> >
> > Jason Xing (5):
> >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
> >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
> >   xsk: drain continuation descs after overflow in xsk_build_skb()
> >   xsk: drain continuation descs on invalid descriptor in
> >     __xsk_generic_xmit()
> >   selftests/xsk: fix multi-buffer invalid desc tests for drain_cont
> >
> >  include/net/xdp_sock.h                        |  1 +
> >  net/xdp/xsk.c                                 | 48 +++++++++++++++----
> >  .../selftests/bpf/prog_tests/test_xsk.c       | 45 +++++++++--------
> >  3 files changed, 64 insertions(+), 30 deletions(-)
>
> this adds regression to xskxceiver runs on real hw (ice on my side):
>
> PREREQUISITES: [ PASS ]
> 1..108
> ok 1 PASS: SKB SEND_RECEIVE
> ok 2 PASS: SKB SEND_RECEIVE_2K_FRAME
> ok 3 PASS: SKB SEND_RECEIVE_SINGLE_PKT
> ok 4 PASS: SKB POLL_RX
> ok 5 PASS: SKB POLL_TX
> ok 6 PASS: SKB POLL_RXQ_FULL
> ok 7 PASS: SKB POLL_TXQ_FULL
> ok 8 PASS: SKB ALIGNED_INV_DESC
> ok 9 PASS: SKB ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 10 PASS: SKB UMEM_HEADROOM
> ok 11 PASS: SKB BIDIRECTIONAL
> ok 12 PASS: SKB STAT_RX_DROPPED
> ok 13 PASS: SKB STAT_TX_INVALID
> ok 14 PASS: SKB STAT_RX_FULL
> ok 15 PASS: SKB STAT_FILL_EMPTY
> ok 16 PASS: SKB XDP_PROG_CLEANUP
> ok 17 PASS: SKB XDP_DROP_HALF
> ok 18 PASS: SKB XDP_SHARED_UMEM
> ok 19 PASS: SKB XDP_METADATA_COPY
> ok 20 PASS: SKB XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 21 FAIL: SKB ALIGNED_INV_DESC_MULTI_BUFF
> ok 22 PASS: SKB TOO_MANY_FRAGS
> ok 23 PASS: SKB XDP_ADJUST_TAIL_SHRINK
> ok 24 PASS: SKB TX_QUEUE_CONSUMER
> ok 25 PASS: SKB XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 26 # SKIP SKIP: SKB XDP_ADJUST_TAIL_GROW
> ok 27 # SKIP SKIP: SKB XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 28 PASS: SKB SEND_RECEIVE_9K_PACKETS
> ok 29 PASS: SKB SEND_RECEIVE_UNALIGNED
> ok 30 PASS: SKB UNALIGNED_INV_DESC
> ok 31 PASS: SKB UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 32 PASS: SKB SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 33 FAIL: SKB UNALIGNED_INV_DESC_MULTI_BUFF
> ok 34 PASS: SKB HW_SW_MIN_RING_SIZE
> ok 35 PASS: SKB HW_SW_MAX_RING_SIZE
> ok 36 PASS: SKB TEARDOWN
> ok 37 PASS: DRV SEND_RECEIVE
> ok 38 PASS: DRV SEND_RECEIVE_2K_FRAME
> ok 39 PASS: DRV SEND_RECEIVE_SINGLE_PKT
> ok 40 PASS: DRV POLL_RX
> ok 41 PASS: DRV POLL_TX
> ok 42 PASS: DRV POLL_RXQ_FULL
> ok 43 PASS: DRV POLL_TXQ_FULL
> ok 44 PASS: DRV ALIGNED_INV_DESC
> ok 45 PASS: DRV ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 46 PASS: DRV UMEM_HEADROOM
> ok 47 PASS: DRV BIDIRECTIONAL
> ok 48 PASS: DRV STAT_RX_DROPPED
> ok 49 PASS: DRV STAT_TX_INVALID
> ok 50 PASS: DRV STAT_RX_FULL
> ok 51 PASS: DRV STAT_FILL_EMPTY
> ok 52 PASS: DRV XDP_PROG_CLEANUP
> ok 53 PASS: DRV XDP_DROP_HALF
> ok 54 PASS: DRV XDP_SHARED_UMEM
> ok 55 PASS: DRV XDP_METADATA_COPY
> ok 56 PASS: DRV XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 57 FAIL: DRV ALIGNED_INV_DESC_MULTI_BUFF
> ok 58 PASS: DRV TOO_MANY_FRAGS
> ok 59 PASS: DRV XDP_ADJUST_TAIL_SHRINK
> ok 60 PASS: DRV TX_QUEUE_CONSUMER
> ok 61 PASS: DRV XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 62 PASS: DRV XDP_ADJUST_TAIL_GROW
> ok 63 PASS: DRV XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 64 PASS: DRV SEND_RECEIVE_9K_PACKETS
> ok 65 PASS: DRV SEND_RECEIVE_UNALIGNED
> ok 66 PASS: DRV UNALIGNED_INV_DESC
> ok 67 PASS: DRV UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 68 PASS: DRV SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 69 FAIL: DRV UNALIGNED_INV_DESC_MULTI_BUFF
> ok 70 PASS: DRV HW_SW_MIN_RING_SIZE
> ok 71 PASS: DRV HW_SW_MAX_RING_SIZE
> ok 72 PASS: DRV TEARDOWN
> ok 73 PASS: ZC SEND_RECEIVE
> ok 74 PASS: ZC SEND_RECEIVE_2K_FRAME
> ok 75 PASS: ZC SEND_RECEIVE_SINGLE_PKT
> ok 76 PASS: ZC POLL_RX
> ok 77 PASS: ZC POLL_TX
> ok 78 PASS: ZC POLL_RXQ_FULL
> ok 79 PASS: ZC POLL_TXQ_FULL
> ok 80 PASS: ZC ALIGNED_INV_DESC
> ok 81 PASS: ZC ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 82 PASS: ZC UMEM_HEADROOM
> ok 83 PASS: ZC BIDIRECTIONAL
> # Can not run RX_DROPPED test for ZC mode
> ok 84 # SKIP SKIP: ZC STAT_RX_DROPPED
> ok 85 PASS: ZC STAT_TX_INVALID
> ok 86 PASS: ZC STAT_RX_FULL
> ok 87 PASS: ZC STAT_FILL_EMPTY
> ok 88 PASS: ZC XDP_PROG_CLEANUP
> ok 89 PASS: ZC XDP_DROP_HALF
> ok 90 PASS: ZC XDP_SHARED_UMEM
> ok 91 PASS: ZC XDP_METADATA_COPY
> ok 92 PASS: ZC XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 93 FAIL: ZC ALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> ---------------------------------------
> not ok 94 FAIL: ZC TOO_MANY_FRAGS
> ok 95 PASS: ZC XDP_ADJUST_TAIL_SHRINK
> # Can not run TX_QUEUE_CONSUMER test for ZC mode
> ok 96 # SKIP SKIP: ZC TX_QUEUE_CONSUMER
> ok 97 PASS: ZC XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 98 PASS: ZC XDP_ADJUST_TAIL_GROW
> ok 99 PASS: ZC XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 100 PASS: ZC SEND_RECEIVE_9K_PACKETS
> ok 101 PASS: ZC SEND_RECEIVE_UNALIGNED
> ok 102 PASS: ZC UNALIGNED_INV_DESC
> ok 103 PASS: ZC UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 104 PASS: ZC SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 105 FAIL: ZC UNALIGNED_INV_DESC_MULTI_BUFF
> ok 106 PASS: ZC HW_SW_MIN_RING_SIZE
> ok 107 PASS: ZC HW_SW_MAX_RING_SIZE
> ok 108 PASS: ZC TEARDOWN
> # 4 skipped test(s) detected. Consider enabling relevant config options t=
o improve coverage.
> # Totals: pass:97 fail:7 xfail:0 xpass:0 skip:4 error:0
> XSK_SELFTESTS_ens785f0np0_SOFTIRQ: [ FAIL ]
> 1..108
> ok 1 PASS: SKB BUSY-POLL SEND_RECEIVE
> ok 2 PASS: SKB BUSY-POLL SEND_RECEIVE_2K_FRAME
> ok 3 PASS: SKB BUSY-POLL SEND_RECEIVE_SINGLE_PKT
> ok 4 PASS: SKB BUSY-POLL POLL_RX
> ok 5 PASS: SKB BUSY-POLL POLL_TX
> ok 6 PASS: SKB BUSY-POLL POLL_RXQ_FULL
> ok 7 PASS: SKB BUSY-POLL POLL_TXQ_FULL
> ok 8 PASS: SKB BUSY-POLL ALIGNED_INV_DESC
> ok 9 PASS: SKB BUSY-POLL ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 10 PASS: SKB BUSY-POLL UMEM_HEADROOM
> ok 11 PASS: SKB BUSY-POLL BIDIRECTIONAL
> ok 12 PASS: SKB BUSY-POLL STAT_RX_DROPPED
> ok 13 PASS: SKB BUSY-POLL STAT_TX_INVALID
> ok 14 PASS: SKB BUSY-POLL STAT_RX_FULL
> ok 15 PASS: SKB BUSY-POLL STAT_FILL_EMPTY
> ok 16 PASS: SKB BUSY-POLL XDP_PROG_CLEANUP
> ok 17 PASS: SKB BUSY-POLL XDP_DROP_HALF
> ok 18 PASS: SKB BUSY-POLL XDP_SHARED_UMEM
> ok 19 PASS: SKB BUSY-POLL XDP_METADATA_COPY
> ok 20 PASS: SKB BUSY-POLL XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 21 FAIL: SKB BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> ok 22 PASS: SKB BUSY-POLL TOO_MANY_FRAGS
> ok 23 PASS: SKB BUSY-POLL XDP_ADJUST_TAIL_SHRINK
> ok 24 PASS: SKB BUSY-POLL TX_QUEUE_CONSUMER
> ok 25 PASS: SKB BUSY-POLL XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 26 # SKIP SKIP: SKB BUSY-POLL XDP_ADJUST_TAIL_GROW
> ok 27 # SKIP SKIP: SKB BUSY-POLL XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 28 PASS: SKB BUSY-POLL SEND_RECEIVE_9K_PACKETS
> ok 29 PASS: SKB BUSY-POLL SEND_RECEIVE_UNALIGNED
> ok 30 PASS: SKB BUSY-POLL UNALIGNED_INV_DESC
> ok 31 PASS: SKB BUSY-POLL UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 32 PASS: SKB BUSY-POLL SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 33 FAIL: SKB BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> ok 34 PASS: SKB BUSY-POLL HW_SW_MIN_RING_SIZE
> ok 35 PASS: SKB BUSY-POLL HW_SW_MAX_RING_SIZE
> ok 36 PASS: SKB BUSY-POLL TEARDOWN
> ok 37 PASS: DRV BUSY-POLL SEND_RECEIVE
> ok 38 PASS: DRV BUSY-POLL SEND_RECEIVE_2K_FRAME
> ok 39 PASS: DRV BUSY-POLL SEND_RECEIVE_SINGLE_PKT
> ok 40 PASS: DRV BUSY-POLL POLL_RX
> ok 41 PASS: DRV BUSY-POLL POLL_TX
> ok 42 PASS: DRV BUSY-POLL POLL_RXQ_FULL
> ok 43 PASS: DRV BUSY-POLL POLL_TXQ_FULL
> ok 44 PASS: DRV BUSY-POLL ALIGNED_INV_DESC
> ok 45 PASS: DRV BUSY-POLL ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 46 PASS: DRV BUSY-POLL UMEM_HEADROOM
> ok 47 PASS: DRV BUSY-POLL BIDIRECTIONAL
> ok 48 PASS: DRV BUSY-POLL STAT_RX_DROPPED
> ok 49 PASS: DRV BUSY-POLL STAT_TX_INVALID
> ok 50 PASS: DRV BUSY-POLL STAT_RX_FULL
> ok 51 PASS: DRV BUSY-POLL STAT_FILL_EMPTY
> ok 52 PASS: DRV BUSY-POLL XDP_PROG_CLEANUP
> ok 53 PASS: DRV BUSY-POLL XDP_DROP_HALF
> ok 54 PASS: DRV BUSY-POLL XDP_SHARED_UMEM
> ok 55 PASS: DRV BUSY-POLL XDP_METADATA_COPY
> ok 56 PASS: DRV BUSY-POLL XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 57 FAIL: DRV BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> ok 58 PASS: DRV BUSY-POLL TOO_MANY_FRAGS
> ok 59 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_SHRINK
> ok 60 PASS: DRV BUSY-POLL TX_QUEUE_CONSUMER
> ok 61 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 62 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_GROW
> ok 63 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 64 PASS: DRV BUSY-POLL SEND_RECEIVE_9K_PACKETS
> ok 65 PASS: DRV BUSY-POLL SEND_RECEIVE_UNALIGNED
> ok 66 PASS: DRV BUSY-POLL UNALIGNED_INV_DESC
> ok 67 PASS: DRV BUSY-POLL UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 68 PASS: DRV BUSY-POLL SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 69 FAIL: DRV BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> ok 70 PASS: DRV BUSY-POLL HW_SW_MIN_RING_SIZE
> ok 71 PASS: DRV BUSY-POLL HW_SW_MAX_RING_SIZE
> ok 72 PASS: DRV BUSY-POLL TEARDOWN
> ok 73 PASS: ZC BUSY-POLL SEND_RECEIVE
> ok 74 PASS: ZC BUSY-POLL SEND_RECEIVE_2K_FRAME
> ok 75 PASS: ZC BUSY-POLL SEND_RECEIVE_SINGLE_PKT
> ok 76 PASS: ZC BUSY-POLL POLL_RX
> ok 77 PASS: ZC BUSY-POLL POLL_TX
> ok 78 PASS: ZC BUSY-POLL POLL_RXQ_FULL
> ok 79 PASS: ZC BUSY-POLL POLL_TXQ_FULL
> ok 80 PASS: ZC BUSY-POLL ALIGNED_INV_DESC
> ok 81 PASS: ZC BUSY-POLL ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 82 PASS: ZC BUSY-POLL UMEM_HEADROOM
> ok 83 PASS: ZC BUSY-POLL BIDIRECTIONAL
> # Can not run RX_DROPPED test for ZC mode
> ok 84 # SKIP SKIP: ZC BUSY-POLL STAT_RX_DROPPED
> ok 85 PASS: ZC BUSY-POLL STAT_TX_INVALID
> ok 86 PASS: ZC BUSY-POLL STAT_RX_FULL
> ok 87 PASS: ZC BUSY-POLL STAT_FILL_EMPTY
> ok 88 PASS: ZC BUSY-POLL XDP_PROG_CLEANUP
> ok 89 PASS: ZC BUSY-POLL XDP_DROP_HALF
> ok 90 PASS: ZC BUSY-POLL XDP_SHARED_UMEM
> ok 91 PASS: ZC BUSY-POLL XDP_METADATA_COPY
> ok 92 PASS: ZC BUSY-POLL XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 93 FAIL: ZC BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> ---------------------------------------
> not ok 94 FAIL: ZC BUSY-POLL TOO_MANY_FRAGS
> ok 95 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_SHRINK
> # Can not run TX_QUEUE_CONSUMER test for ZC mode
> ok 96 # SKIP SKIP: ZC BUSY-POLL TX_QUEUE_CONSUMER
> ok 97 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 98 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_GROW
> ok 99 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 100 PASS: ZC BUSY-POLL SEND_RECEIVE_9K_PACKETS
> ok 101 PASS: ZC BUSY-POLL SEND_RECEIVE_UNALIGNED
> ok 102 PASS: ZC BUSY-POLL UNALIGNED_INV_DESC
> ok 103 PASS: ZC BUSY-POLL UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 104 PASS: ZC BUSY-POLL SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 105 FAIL: ZC BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> ok 106 PASS: ZC BUSY-POLL HW_SW_MIN_RING_SIZE
> ok 107 PASS: ZC BUSY-POLL HW_SW_MAX_RING_SIZE
> ok 108 PASS: ZC BUSY-POLL TEARDOWN
> # 4 skipped test(s) detected. Consider enabling relevant config options t=
o improve coverage.
> # Totals: pass:97 fail:7 xfail:0 xpass:0 skip:4 error:0
> XSK_SELFTESTS_ens785f0np0_BUSY_POLL: [ FAIL ]
>
> Summary:
> XSK_SELFTESTS_ens785f0np0_SOFTIRQ: [ FAIL ]
> XSK_SELFTESTS_ens785f0np0_BUSY_POLL: [ FAIL ]

Thanks for the test. I spent some time finally configuring the env in
my machine with ixgbe driver.

Some of the failures are probably caused because of lack of patch 5 in
your setup? The rest is caused/breaked by patch 3 which was stated by
Stan. I fixed that in the next version.

Thanks,
Jason
