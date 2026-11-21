Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795277039;
	b=ZMOa4ZDJuhTYaCr+NeqTrWWeKTPCXkEkyRP/RIaYDxZkEufcVbPOoJETSk/BjwRn4F3t
	 i50Mjt4JgDDIPPJL/ofL0+R1Z/yS9L7Sio3MkNM4HBR3ZGsCnddreufcPDI7By3fi4+B1
	 Gryy/0yvzRa8pBjntT/Ri0rIiOkDYu3KhTvkSilkSdDnhan9M1weyMaHw0ibhS8mN1zpC
	 Qg8yZ8Znz8TMP1tDEUOiMZfKLpvuFCJ6Bp2WmUnJZuCvN3Vafbgz/jXcjsUaVkNJ16IRW
	 VGC3KnO/zWbJXBH9gB/E/loATKs9HGiEmGAKaON6fhNGFSswT/1JZHyBjQAuEw8znZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795277039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5QdzEuTi+4UKBT+/YqvcdZRVWj9ymg25bD/LvLIywzA=;
	b=SyOxq1LV/wv/6uxv/s2haa6TP1mea8b0nC6utLKcKdkgCyVvYLrszHzsSkE4y2D7iyLB
	 EWDw43eZLzF1hSl8OT2FuzzNdW7sm+AWp3Pa2XNUyJbs9HfvltWPC14iN7kwVLRL6LgD1
	 ixOiQa0xAf5LAju/X1ufSx+mXHY/SgQ6nM2WFkKG0KjAv7etl44QvO4YItZd9JDGZDpoJ
	 uY9jAw6pZghUpdANaYwdxbkojUvTqRUdGnt58BOzt81vGgV1AMLDGVFGCUDXikkrvbQCT
	 BcemhGewpasjVoDlhpucjV0pjXwyVoF/Qrf6IfNsHZKMjfs3hUdTOShUGfHW8PA2PQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=XHI+1v5D;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82BB606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 16:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B82BB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=XHI+1v5D
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso18184645e9.3
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 08:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795277037; x=1795881837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5QdzEuTi+4UKBT+/YqvcdZRVWj9ymg25bD/LvLIywzA=;
        b=XHI+1v5DKeTpstUjmWCsHSaEer0ErGEJyETi/mrY46CAkAADAMuR+SGE6uWGmDkITc
         FxpSdBp0rXjLWdtjcij6EJdpK5JeHq9YE05RGHmgvtBtjPYQmwmvxCXfHDXgKjnMjEY3
         1WfrIZZyJGCQEEY46fy3wLFbLVOnumVmVWJ22r4o5M0pGygk96DYA2IP4nV+BbM1kRhN
         FzmMPzgHnbpHTCOqhf/ak8csoRZ7nq40JzV+n1yw7sm+I/p+VMoW0JfGOytKta8Zs5b3
         hwHGrWAIQCCZoDMBvWQ672fYw7mwGRQ9ACzNnXZjUWp/YynQZHOAgcgUfziijsFQA8tz
         YMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795277037; x=1795881837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5QdzEuTi+4UKBT+/YqvcdZRVWj9ymg25bD/LvLIywzA=;
        b=qAN5TBtjX1OGRws2Nt++irfedTdRZR8YmQ4NAMax0sg7FbbaF/AIpASHRRlimSnbm2
         0x6fINUREGa8UBgcwAxxk6dl6a+utZH+BU9x19zQZ/1u5uCuMD/qzkltvedV/L02ZwXF
         B5/GRpxODiRYMph4M1WmQyve0SgqD4+/ctYL0K2KWWS1zf8n9dQ6JHWzPiQj4/Kg053W
         qfSs8WVWNWVJUl5cVq8mnNj5b7qA0ShZYgnREBxjo0OcP9iNZMg+Kuh+SK+XiyXtc7fd
         ufmjRQE1dPq2QXOjGeS6Zx5Cy/fDIrKNWnlYHwPKdMEg5gmplP91J4onKXqPw0ScUHdu
         9aRQ==
X-Forwarded-Encrypted: i=1; AL+hErHZfBte2uYGH3jV3/p4l70dNPy2j47xON+PPr/1oJDlKPUA2MAagyo1nmg72jHWvV09aok=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AKw7gbrDhkbrTlKfImP4Zcou7WMZMI423GZ6QpG2IPmcH7jOh
	I5stuxQkupW9egDpp/odmY65GV2am+29ha/1YJW7NMTBbzFwHyotGxpL+O63z81pZJ4=
X-Gm-Gg: AZFdTZdNVcGeUfJ9PAHR6V3WGomqS56AJ6BTrLZ44NMFtHNgQuHPXbQeAYuCvhMggKd
	PvTfgX6I2dh4+udxnqf0Amj8wN1zrgHQ3cFZGQIKikvnZB4VkHPNTgDo/6J8gFjep4qF/dwN/ww
	Lh29bPwh8ch8FsVBQm1NSuEOGaHa/lLXbycLO37u9nMpPgm8Op+2kXcc85Yu70S5NXxPmO9KwRo
	zOamkpd0bE5uHdLd8iQIJ6Iruh8zLf+FD7KiildKlV2b6wFkYS7EHVNbV/R0t7lonCD/NvqMRR/
	a6o56F7KHcs86PRjIdk7M8a2eTRnEyhVG7raCAu0H/rBhzYNKCOcs8m4BVzo6a1KL8cV9b1ajj7
	MP2ePBx7Y01ZelWvhBOUXhABiH/zbkLUcTG5TLikNzrFp2TVs5wiqcGO1XIeZg/zlqN6koH2JvQ
	7h9HIq13ZdlXwJj3tR02DUqp/HqmSX6VWZF4JPVUfHX2GAVENgJQ0Uagq+QJ0TKA6kmNOyUXf1V
	lvoTnHIz5JgFfTwo3R5muKkZr9owUDoXdqEYg56pd7SWHC7JODV5Wlf0tO2KSjBy0VIKcnyLsOJ
	IcUiKMlycLEjuh9vzj8rJ2/j1iBwBz94bZcnetcl+Qc5cj42x/Q=
X-Received: by 2002:a05:600c:4584:b0:4bb:5de1:e90f with SMTP id 5b1f17b1804b1-4bb88819bcdmr141164155e9.31.1795277036426;
        Sat, 21 Nov 2026 08:03:56 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb853b216esm227175685e9.12.2026.11.21.08.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 08:03:55 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Joe Stringer <joe@wand.net.nz>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org
Subject: [PATCH net] net: keep skbs with a prefetched socket out of gro_cells gro
Date: Sat, 21 Nov 2026 18:02:04 +0200
Message-ID: <20261121160204.4024204-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_sk_assign at tc ingress holds a reference on a socket that is not
rcu freed, such as an established tcp socket, until the receive path
steals it. ip_rcv_core keeps a prefetched socket so when the assigned
packet is an ipip, gre or esp packet the socket stays attached after
decap and their rx paths pass the skb to gro_cells_receive. GRO merges
skbs with the same skb->sk into one flow and clears skb->sk and
skb->destructor of each merged skb without calling the destructor so
every merged skb leaks a socket ref.

Send skbs with a prefetched socket to netif_rx instead as
gro_cells_receive already does for cloned skbs, where each skb is
consumed on its own and no reference is lost.

skb_sk_is_prefetched tests skb->destructor which shares a cache line
with skb->cloned that is read just before so the common case adds a single
cheap test.

Reproduced with a tcx ingress program on a veth in a receiver netns with
an ipip tunnel which assigns an established tcp socket to ipip packets.
The sender sends 32 tcp segments of one flow inside ipip through a netem
slot qdisc so they are decapsulated in one batch and merged by gro.
Then the socket is closed and the receiver netns is deleted. The leaked
socket holds a ref on the netns so it is never torn down and its devices
are never unregistered:

Before:
  bpf_sk_assign() calls 32, sk_refcnt 32 after the burst
  receiver netns deleted, 30s later its veth peer still exists

After:
  bpf_sk_assign() calls 32, sk_refcnt 1 after the burst
  receiver netns deleted, its veth peer is gone

The problem was found during reviews of patches that add bpf_sk_assign
egress support.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>
CC: Martin KaFai Lau <kafai@fb.com>
CC: Joe Stringer <joe@wand.net.nz>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: bpf@vger.kernel.org

 net/core/gro_cells.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index 31352cac355c..8c74b2a1227b 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <net/gro_cells.h>
 #include <net/hotdata.h>
+#include <net/sock.h>
 
 struct gro_cell {
 	struct sk_buff_head	napi_skbs;
@@ -26,7 +27,8 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 
 	skb_unset_transport_header(skb);
 
-	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
+	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev) ||
+	    unlikely(skb_sk_is_prefetched(skb))) {
 		res = netif_rx(skb);
 		goto unlock;
 	}
-- 
2.47.3

