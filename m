Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316818;
	b=5MKI8TP6ceRpSrBPDiDJO5PSMg8++akQYsuVF1Om4pa1ULRwsPtoZbKVubbHefgg+bxE
	 l48Q7pQsLBhxZY2r+g++CZWgqQHwM2NdBIzelyu6RriQv2PrvfPC5rB4LBVzAJiKlw694
	 N+MkYq3o2+Vc8u7NVIKmeWh7cpuyNHpn0SGmLavTCIlTICQLZO7aYjoyXnSBWP8HoUw9C
	 G2ztfUFTQ787JI3xQANzCWHFUIPWgcFz17CXUnKakm38g9ig5gRZ0V2BZjvRbN/K3Ot7B
	 UAoggyCTnJq0DwnvLOeC8COKnBLshNfebcHMgq91s1Xtfe3FlxZCd9piOJ1z4nfXNLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316818;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o3j8ZSLUlMW9spzjCj6Lf6ZyTqWduSvktrPcGEoHNnM=;
	b=qbEP1FdNjUMvRYbwjIwatGByOo+NPI+aUvKwRUTaJ9R4Y8d+FQsNEYjHFo3gsztBtKEm
	 LIrfM7MGFvydwMEYINyybIFUKujzTkcBjXuNczne6GNQ6GDNJ1Zomvux40hMvfLfWDJA2
	 ZQFE96iuD/3KTghauWNYp2SRNrrO8R3bzi9FSFAH1elijVjziDUyvgyzaESm2R0lQZh6O
	 0ZKOxns73Ypq8aFzEL3C3MXmCXi+7YC5wGsHw2Ezplqbz6ZwJvoUzxAOlk0FDKoz7ffVD
	 cGjcP2waoXrIsovvqQ5Ai8fi4QcI+DzY5eTBS/JDPyzJdrZYrY509ku4aGeuB5sJclQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bolY8nWU;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=i+5XCEtm;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56E60A260A
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD56E60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bolY8nWU;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=i+5XCEtm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3j8ZSLUlMW9spzjCj6Lf6ZyTqWduSvktrPcGEoHNnM=;
	b=bolY8nWUSU3xix/y00mMJGQIeehEiXvMWCOMiF+3QHdCT6yTgJL6w1WYMvWeBNoPRjxbBZ
	PsnXEtRfm/2CQYokiRvWZhH6S6/5Wt7mu3keoORqdm7WY2ohMLTzFrmmQAqh37EO/4gktt
	Gh1j4yMkvaZ27WHF/51o57HBLs8GoIo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-L2iHlQdQMf6XoHBqxiaoAg-1; Tue, 10 Nov 2026 08:20:15 -0500
X-MC-Unique: L2iHlQdQMf6XoHBqxiaoAg-1
X-Mimecast-MFC-AGG-ID: L2iHlQdQMf6XoHBqxiaoAg_1794316814
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c25edb54d22so259265866b.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316814; x=1794921614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o3j8ZSLUlMW9spzjCj6Lf6ZyTqWduSvktrPcGEoHNnM=;
        b=i+5XCEtmpFWipFgZNLE/fMc723DK5Ny/xxXGHMwawP8OlJErf09CL2Kd6S1HWtelVY
         0zuny+/muaJNJ88KY68zQHVVG9rHZ+MM5Ol1hIrYV3EbejqvN/SlDmdkKKCkM5sGJZbw
         3Pt4Jh+b8OXbZ6IEOtO62/Q9QIGkkxlrHZEBib1vjauncP8CRsER39qLbpU+PIN27fuH
         cbTyBBpeEz+/4O4bSV3vEmKdMKM4qQNCqAQWTfJFpl1xJUc40dWzRhueU/nCSn4DA/u6
         hju+8l8mYQJsSUTfCExcYwzApOkH09e06ykd90tqOEJ5B3cCyFzjuXIgreztbKVEIIt7
         WZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316814; x=1794921614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o3j8ZSLUlMW9spzjCj6Lf6ZyTqWduSvktrPcGEoHNnM=;
        b=XOD7+FhVMHmah2jUuBQFaoqZzUdOTN8BdhHXzOJLqVLl1jR/IVN1a8bOGkB1bI2dnR
         n74M6MELDVleFUfGjwak4hGpddW0WGJhN8CLz6q5jvCcCECjDuEV8pfZHKz20IZxcvDD
         bzHd/ZUlFJ7NiSnOEnIsRoTBCVSKgt2rl9EyDsVga+daSZRy4KIOWCd1h+MJtX3a3ztj
         N6/hbRsNGSi6XYWJ42JlCsHw+wjtRZad0mdx9uN1QFdwrhOzQGM8404lfYkW1WHb4QDU
         a3fnmqZXK9Vth5lxPQIpvU1h3Mk8GRx+WLVrlu1nNodX9icp9m58790lVvXKfSXAYVaH
         AfPQ==
X-Forwarded-Encrypted: i=1; AL+hErEShZO1vqrERkIa7H0kX+6BFCsBtPHYjl8IqMdnl36TLSHKaLdr8RwPCe175xsCg6/0/Yg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oTZqNDNA81h8LRmHy6LU39wZEt/YR6o2v2N3HOctvViGh/AQf
	c49dA9JlJsY2UtQyGZPD+O3C0lKbixnKKS0rpJb9NiyltYC9J921yh4FxPa2y805v3f1X4mLJlD
	dT3/sRA5hRRJd3zmiDvrU9feStl1z2vM1g5sJoy3Xo1CtPkThAj3UWQ==
X-Gm-Gg: AYBFou2rq6VaXSbErLK9rTvjN1ev98ebDxe6iIeyCzEHce8pV4s9dgoxCH4Fpv+zueb
	rK/QLEDMTsTkbIJYKkDnQeLJ3UuLr5y2uGT70UVjdKtrHzXF0zfazfyuu5L8TaswwS2p+umPmTs
	63N8LwVN9d1dJJCJHXXE5uBXbwbwCEDvMsv8HihaAu1FN4/Ekjpbx8xLxGqJTsIUywLVVln65i2
	4VsIk7Fl2RzULJbkFV8d2ESRIGK6kihc/7RR3U/c3yKVbso5p6wOsYU4fqZaCRD4FIviCT2bY7B
	fUU1GtrjplPZ5Pc28jHss2pPBqMNmzJ31avOFmRmeNkdR7HnKViRk/pjz28J/1qvro/L1/pbdk/
	gSvIKRGtU1fferrSYauS25jHi8TSmqoxFHtIalYwCAuEWMxa2T+3+m8IdAP05LNEkVeFAHVpYfS
	1yChxvGQs7FxBZ6/0Adxl+7wiJvRK+LaQIAnzVNS1YrDZdQl55yNwup50Hdr1QdNaIr6bDy12Gn
	V3DCNhbuz7y2tBYHxttvqG+HQwtLrIp9tPYWBQmRycXT+cgd01t
X-Received: by 2002:a17:907:d7c9:b0:c2e:2252:6ddb with SMTP id a640c23a62f3a-c50495dfb72mr227136966b.10.1794316814426;
        Tue, 10 Nov 2026 05:20:14 -0800 (PST)
X-Received: by 2002:a17:907:d7c9:b0:c2e:2252:6ddb with SMTP id a640c23a62f3a-c50495dfb72mr227134966b.10.1794316813994;
        Tue, 10 Nov 2026 05:20:13 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:13 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 04/12] io_uring/opaque: add owned-page helpers for dense copies
Date: Tue, 10 Nov 2026 13:19:58 +0000
Message-Id: <20261110132006.3280986-5-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110132006.3280986-1-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
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

Add the accounted destination-page allocator used by CREATE and compaction.
Prefer compound allocations up to 64 KiB, or one base page when larger,
and fall back to smaller orders.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 io_uring/Makefile         |  2 +-
 io_uring/opaque_compact.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 io_uring/opaque_compact.c

diff --git a/io_uring/Makefile b/io_uring/Makefile
index 81710127046c..191316972e04 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_IO_URING)		+= io_uring.o opdef.o kbuf.o rsrc.o notif.o \
 					query.o loop.o
 
 obj-$(CONFIG_IO_URING_ZCRX)	+= zcrx.o
-obj-$(CONFIG_IO_URING_OPAQUE_OBJ)	+= opaque.o
+obj-$(CONFIG_IO_URING_OPAQUE_OBJ)	+= opaque.o opaque_compact.o
 obj-$(CONFIG_IO_WQ)		+= io-wq.o
 obj-$(CONFIG_FUTEX)		+= futex.o
 obj-$(CONFIG_EPOLL)		+= epoll.o
diff --git a/io_uring/opaque_compact.c b/io_uring/opaque_compact.c
new file mode 100644
index 000000000000..b59c7cb95d42
--- /dev/null
+++ b/io_uring/opaque_compact.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Workers copy immutable backing without holding object table locks. */
+#include <linux/highmem.h>
+#include <linux/memcontrol.h>
+#include <linux/mm.h>
+#include <linux/overflow.h>
+#include <linux/sched.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+
+#include "io_uring.h"
+#include "opaque_internal.h"
+
+struct page *io_opaque_owned_page(unsigned int *order)
+{
+	struct page *page;
+
+	for (;;) {
+		page = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_COMP | __GFP_NORETRY |
+				   __GFP_NOWARN, *order);
+		if (page || !*order)
+			return page;
+		(*order)--;
+	}
+}
+
+/* Destination allocation for dense copies and CREATE. */
+struct page *io_opaque_dest_page(struct io_opaque_store *store, u64 pages_left,
+				 unsigned int *order)
+{
+	*order = min_t(unsigned int, IO_OPAQUE_MAX_ORDER, ilog2(pages_left));
+	return io_opaque_owned_page(order);
+}
-- 
2.34.1

