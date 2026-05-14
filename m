Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700B3A542A
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755636; cv=none; b=vAWiGfO67ZNgkcqJ94WlN37fc/P7v3F2pNHbqLHL9npjIBztx5gZvsgkX4Ru8fUPa1FMdCdAa4sSvOhzJky2ry+H9uRYHMv2JOK503K9ZJwHBaw3h+FmnHEgbTKj54XPAiIV986ncYqpDaKBJI1GYv3uIE3POGVy0frklBF1l6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755636; c=relaxed/simple;
	bh=+CrmjDGr2JNHGvY/tkxLtymQWoIJOtkgZfzqjdARtNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X0yGjIrW433/4Sci+ZDGO4btiDQCQQbN53fZxP3zg38msAXuiNX2DNnupATYjT02UHp7SrTTS/tZPsgvz3fBc4qL0fFf7rwKFFsD2GPQf1eAGpep9JvZm+8crxeem6VY9RqSb3IA3I48s6zqqP0eHI5zo4sQQo80Qtz8am0xh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Sh1rVCtM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Sh1rVCtM"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso95116566b.1
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 03:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778755633; x=1779360433; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4uxss1CtZcDp0zNhfAFf+hQx8oKtm2lVjhVo3APIjM=;
        b=Sh1rVCtM7DUXoe1+qA0CuDQC8kGrQiIUMS3uKythfnVjpH7Gz64cBNjQyvnfyPUEL7
         ugkA5QM1nWZh1Qf4djLFa3cxY/PRuVWwBOPM/uONTEBSe+aGDCKktwpHccBEkaT2sB66
         j2BLtLI1ADxoUGNWitbU7LDuMYy5rWI6ev4LKkOuk8lN37U/oy8FHi5nQ9V5zUOuOetM
         vpFs4xJz/D2IfNUFVI5WHmKpBZtGlodXRtW0u8w24TPt3Eu/wzwWYWmTAgXuNwG7RrRt
         +LuZh0jFvAkLKDz4w2d19AexrAh9w6VRxna0zuDcqJyI0Rv/lUI9B8I4TANudacLtc8P
         ybZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778755633; x=1779360433;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4uxss1CtZcDp0zNhfAFf+hQx8oKtm2lVjhVo3APIjM=;
        b=kCgFRhVkRQ3hvAQL+QdQdH/bN+R6y+8DVzFLP1dUCxh1MzaNz/Ed9p4APmbzx8ucEN
         4/22d0IkpZvw/D2C7oyv7sfYb6FOSeSTLJoo+YqAFSYTATWZdrQNZTa8NEe27xNV0dLN
         ul5GATIJBgaA8v1u0ejV4HdmoTcd9ch6gpfrL28ovdxUBHvxClX/qjOSSexWvNsQ8rST
         X85EGqSqLzbIyHNWn+KmR0fXRkThfDVPkxSlD0H1EbCpaK0EVnTCH6dseaUHxFQAv60w
         ghgYCdZOg7VaMmhff4idqJs3yReYkU974E0jMyU5ZD1BXd2zELN8hJjm0hJT5SvZpHR7
         z3Fg==
X-Forwarded-Encrypted: i=1; AFNElJ+hNDTuKkxmtzTZC1cyzjHLvp/PFjugZnCGXAGTtTw02ljSvGtoXfIhOG3XQplKVgaT2Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFxiAdgNEMmTY+Rz928B12geTPspW/zEV3rWFk6/i4q8Al2M5d
	B/M+3RwxUVwqGsZMSi38/eqIBuOwsmOwyG1LFyeQHXYLScP4fkgLtK0szJnA8ip0GlI=
X-Gm-Gg: Acq92OHOEKyv3yqUOOhpn/hjTqIcxvo5BzsP/SIwmhiCMRRCBe5Fzi5aXHeBThG7oo4
	YP/NvVfIFlWAnd1Pa3mgJXz6XM0wjdyMsj2HJ+X6q9+wYiIJwBRKZueQRGNoTiFVUGBW+N1pARz
	v94FIz2VbzPGnzBjEjUTdeC58IClD3VpQ30hrNywd/hhrhAq9GlDy0tqKzPXKDgxg0eerUVPeA8
	jVZW6FjM9SELTMUv77p5NtE/WhIaf/JLsALm/HFIs/oHBneVsW5dh0Ug5Tx5KpFLMQev1UzOl2B
	tYShL4LEsLhkUuMj31RW0Sa4PfZ1L6BUqSzIvpYf0be8eLthY7VhXYZThd9nqAK6jC3gvkXl7Qm
	r67w+1HWcE1Pe6kc/rEx0HAYjpf53W3CgQq5IT5ZWRA2Rke04je3TtFNGiLpX0oyPsw2x81wnui
	LOnd6Aor8rfy0hkbbK/Hp/CBU9cSibBs0dfX0wFUirvDOaT8jRNLGQvBmEDY9w71X5JN8KFBGts
	wVtcX2Q
X-Received: by 2002:a17:906:7945:b0:ba6:8f34:b419 with SMTP id a640c23a62f3a-bd3dfc6cea8mr443057266b.13.1778755633367;
        Thu, 14 May 2026 03:47:13 -0700 (PDT)
Received: from cloudflare.com (79.184.84.124.ipv4.supernova.orange.pl. [79.184.84.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c3150dsm75244066b.24.2026.05.14.03.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 03:47:13 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 14 May 2026 12:47:09 +0200
Subject: [PATCH net v2] net: Clear skb metadata in LWT BPF xmit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIACyoBWoC/z2Nyw6CMBBFf8XM2jGAD9CV/2FYDNOpNBZK2goaw
 r9bMXF5X+fOEMQbCXDZzOBlNMG4PoliuwFuqb8LGpU0FFlxyg5Fhc2g0U4RlXcDhkeDnURSFAn
 PlDeKpcyOJJD2gxdtXiv7Br1EqJPZmhCdf69/Y75Gf/RkfkTrmCx+e5T+tXcdBvYUucUxxxwrX
 TKdm31ZsVzZuqfSlrzs2HVQL8vyAbhq4IDVAAAA
X-Change-ID: 20260428-bpf-lwt-drop-skb-metadata-9a1bdce705ae
To: Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.14.3

skb metadata is meant for passing information between XDP and TC.
LWT programs cannot access the __sk_buff->data_meta pseudo-pointer.

However, LWT_XMIT programs can call helpers that move packet data.
One such helper is bpf_skb_change_head(), which uses skb_data_move() to
move both packet data and metadata after skb_push(). skb_data_move()
expects metadata to sit immediately before skb->data. This is the layout
that commit 8989d328dfe7 ("net: Helper to move packet data and metadata
after skb_push/pull") preserves for TC(X) programs when skb_push() or
skb_pull() moves packet data.

The IP output path can run LWT xmit before neighbour output has built the
outgoing L2 header. For forwarded, or otherwise RX-originated, packets
skb->data points at the network header while skb_mac_header() can still
point at the old L2 header. If such an skb still carries XDP metadata,
skb_data_move() sees metadata ending at skb_mac_header(), not immediately
before skb->data, and warns:

  WARNING: CPU: 21 PID: 454557 at include/linux/skbuff.h:4609 skb_data_move+0x47/0x90
  CPU: 21 UID: 0 PID: 454557 Comm: napi/iconduit-g Tainted: G           O        6.18.21 #1
  RIP: 0010:skb_data_move+0x47/0x90
  Call Trace:
   <IRQ>
   bpf_skb_change_head+0xe6/0x1a0
   bpf_prog_...+0x213/0x2e3
   run_lwt_bpf.isra.0+0x1d3/0x360
   bpf_xmit+0x46/0xe0
   lwtunnel_xmit+0xa1/0xf0
   ip_finish_output2+0x1e7/0x5e0
   ip_output+0x63/0x100
   __netif_receive_skb_one_core+0x85/0xa0
   process_backlog+0x9c/0x150
   __napi_poll+0x2b/0x190
   net_rx_action+0x40b/0x7f0
   handle_softirqs+0xd2/0x270
   do_softirq+0x3f/0x60
   </IRQ>

Drop skb metadata in the LWT BPF xmit path, just before invoking the
program. Doing it late, rather than in ip[6]_finish_output2(), preserves
metadata for tc egress on the outgoing device when no LWT BPF program is
attached - the only scenario where carrying tc-layer metadata through the
IP output path could be meaningful. Non-BPF LWT encap types do not run
helpers that touch metadata, so the BPF xmit op is the only site that needs
the clear.

Fixes: 8989d328dfe7 ("net: Helper to move packet data and metadata after skb_push/pull")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Clear metadata in bpf_xmit to allow access from tc(x) egress (Daniel)
- Add WARNING snippet to the description
- Link to v1: https://lore.kernel.org/r/20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com
---
 net/core/lwt_bpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index f71ef82a5f3d..d26cb9bb8189 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -284,6 +284,11 @@ static int bpf_xmit(struct sk_buff *skb)
 		__be16 proto = skb->protocol;
 		int ret;
 
+		/* LWT BPF programs cannot access skb metadata but can corrupt
+		 * it with helpers that operate on skb headroom. Drop it.
+		 */
+		skb_metadata_clear(skb);
+
 		ret = run_lwt_bpf(skb, &bpf->xmit, dst, CAN_REDIRECT);
 		switch (ret) {
 		case BPF_OK:



