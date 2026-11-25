Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.217.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620228;
	b=ljEQKhdi14c/xsWSPoUZq43qiDZduTP7OPUig3YpgipUSJx6mTuZlsG64VHpl2K5Kka1
	 NmvagpiDNGoS+X58X/91XPfCRpxyvTuBrAhvng4hdxKQgVb5KyCvRiUVNIvtgxTLnm/Kr
	 g2xzbFSaSgiQhVicS6wXCKVor0hH6YVKEd/0Km3NI1gD/AjF1x1c+PqtOQXwAtrevP2YB
	 sNEauj6/k/ZGuy/DFmzVFI38LEcAyvxhlXVXlvZnrX5Th1tle4tCiw98EwT4frHph+qWK
	 aW/zEsrFfFK7yI5rFquBsFANopna4YxOXzGBXkc6VB+DjixhUmHAHjjf/8ZWKm1jTqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620228;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SC6SmwcOlRX4TMShN4/z5oFu7ovHE/zxGHPprunnak4=;
	b=b07eff3y7sgKZ1HeqhacBMzcPvIZV/ex6V5na9VcIFX06BoJyg3z0bDFqlyPF/FdwMjv
	 SOotbwBbhREzN2Lx/10CaguZ2DVe+tRlbD2bQ/TWsnK0/mqAOvG2JB0cTZi49H5jvh0hb
	 utAXqxfkCc03M2AQk7+30wmvEka50b4DojrmkPL0CVLsti/HoMxE1j6+wojqbi8PEJsLV
	 AdaAZ3uhRq+9XYr/s1USC4jasog0m+vBdWUQ0DVvd6ZVdp3m9gSC/hpw3SVjhlLFZu6EU
	 IrG1lsBvZSCbVLrlquZ/JYbfmB6F0cJk2fqwyBYUw5syMqWklFLqSr16kPlGufbhtuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-dortmund.de;
	spf=pass smtp.mailfrom=tu-dortmund.de;
	dkim=pass header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=V+LxSgX+;
	arc=none smtp.remote-ip=129.217.128.51
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA28606A323;
	Wed, 25 Nov 2026 15:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AA28606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=V+LxSgX+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1795620198;
	bh=SC6SmwcOlRX4TMShN4/z5oFu7ovHE/zxGHPprunnak4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V+LxSgX+xOIGZKNib5pjO6K9VDNuowVOl3A9tvaUAg8D4bIdEXr4w9BVkbNfpKzK+
	 e9D8yq/Sx9zz8wwRgyZtt8F8WJ+bT6MpXvptSn1HIYJCBMbp/koMDX2bg8NQaUaEHb
	 PQv1QiViB8LXTIvM0WkHfWq+4KVqoPUSFtG9aGbc=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.207])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6APFNERM004665
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:23:17 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        =?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH net-next 1/3] ptr_ring: add PTR_RING_BATCH
Date: Wed, 25 Nov 2026 16:23:09 +0100
Message-ID: <20261125152311.805325-2-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125152311.805325-1-simon.schippers@tu-dortmund.de>
References: <20261125152311.805325-1-simon.schippers@tu-dortmund.de>
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

Name the batch size in which the consumer frees entries, so that users
of a ring can size their own work to it. The next patch uses it in veth.

No functional change.

Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 include/linux/ptr_ring.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 631c43fde4407..b851a9c170bf6 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -27,6 +27,11 @@
 #include <asm/errno.h>
 #endif
 
+/* Consumed entries are freed in batches of this size, unless the ring is
+ * smaller than two batches
+ */
+#define PTR_RING_BATCH	(SMP_CACHE_BYTES * 2 / (int)sizeof(void *))
+
 struct ptr_ring {
 	int producer ____cacheline_aligned_in_smp;
 	spinlock_t producer_lock;
@@ -506,7 +511,7 @@ static inline void **__ptr_ring_init_queue_alloc_noprof(unsigned int size, gfp_t
 static inline void __ptr_ring_set_size(struct ptr_ring *r, int size)
 {
 	r->size = size;
-	r->batch = SMP_CACHE_BYTES * 2 / sizeof(*(r->queue));
+	r->batch = PTR_RING_BATCH;
 	/* We need to set batch at least to 1 to make logic
 	 * in __ptr_ring_discard_one work correctly.
 	 * Batching too much (because ring is small) would cause a lot of
-- 
2.43.0

