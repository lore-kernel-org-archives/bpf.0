Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316834;
	b=w+i19t9guDt9w2dEVvoCtlMy5/o/9lEtCVChiCbdKWae/49e+olHGYrkXjO+LhvBpRxb
	 Nt5RSDwpgU+x7au/0MP/Km90zEjC+8pjSt/U6t3T1gEjYrvN+n8Xcf1Ap4jKNq1voYh5z
	 XNiz5DF7kH5pBV8sZU4TvPNuo1oAtQeBEw9H3InBchDu6CgPBLuS2itLb8WwjHFZ2YKd9
	 7gJivTYAKfCSN59cMyGi2vLff19Xyzw4jvFB/rY/aLMN0t6+xGx3uOA3CAKdzSDTy45V6
	 /WfrGvFqHvoe3D0fkcI2pBbguZWz/m+pFWvr5zJCnJhk7NB0QfLSdcQMGd/UNwS5RQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316834;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jmGjkKcjSqmOdXkFwVhu/ZUdaZzfH+DaKIptD+Gmy0Y=;
	b=txlD6UnUCL5+ex5E10lBaRua9p/GEJ1XRQSDWxVQ4x4oHxvaRX4olMJKKi72S3N46D9U
	 kGlr0Llv5iOQN2BYshRs2r3K8+L0Tccihjo9wYS0fAEReJBdCd/jWFMNrbRFJIjAXq4xJ
	 yIKN+9NOWihUFNpEtDRsv3vt4MFLQMA4fBbdj6oUhY9Q06TYSHNRYstCSLv0G468ov4th
	 YU7SRGbrOq9Rcx4Mg7EUvhToBKIrI3WDyQR+j3V6+EYZR8dlYFaxBDMp11ps5uJmQT7Jh
	 ldiMv856Io1zPomDtgmmN9TAL1pkKOtbJR2nB+UckRQEPTkkC0pmg/qjITN6M9MwtnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bbhwH7gd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lYSrv6pH;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB00607683E
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACB00607683E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bbhwH7gd;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lYSrv6pH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmGjkKcjSqmOdXkFwVhu/ZUdaZzfH+DaKIptD+Gmy0Y=;
	b=bbhwH7gdKF50S4ykDldCd44NDCOIYdcE5BV3qh1UFP7gP29K8T13JGmEsXAO3pP1yjtsr1
	/6TNJbwE3AVjhbG9l0SGXHTh0Mghsp4XRwT+H+M2Kcc3pNrpl8stbMUUYhNUfSpAbKPS+j
	fCiOjYyoLX0AaMvfs0zyNDTZV9G1Wew=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-YyVXn1geO0KMurC_H0mI9A-1; Tue, 10 Nov 2026 08:20:30 -0500
X-MC-Unique: YyVXn1geO0KMurC_H0mI9A-1
X-Mimecast-MFC-AGG-ID: YyVXn1geO0KMurC_H0mI9A_1794316829
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c5051881421so54969466b.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316829; x=1794921629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jmGjkKcjSqmOdXkFwVhu/ZUdaZzfH+DaKIptD+Gmy0Y=;
        b=lYSrv6pHwB1qZHkVvDiuhxA+58vaRWORWjwefkcnxPYtBXttcqLae7ls2ilN18GtyK
         HMFry42KotdWge+rbCX5W3iLONdA7Yk+W81aQAH/rTyIbK2D9Xrp4pmUzSNZZLPdfS0w
         kgcdZ/1j9xKfJnlXTF4Iv/u8FX+PExzsl+u+wIcKxrOIUygUPCKFXt/koZOjii0GkVej
         F7MbyornURD+GgM/OMz8/nAYf4b6OYDNXe5FqJkywCgTjZDMiSdmFlgXhMQin8hrNMi5
         QvCMZ9Q48MZy+xNWBTjs7DqKd+3o5OHHbpUJkWXd1SqIsIcO7CJy0edg5tPjBMXe+/zx
         ko4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316829; x=1794921629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jmGjkKcjSqmOdXkFwVhu/ZUdaZzfH+DaKIptD+Gmy0Y=;
        b=DcytTKMMh/Hl1NkuVDzPRPBxSjIDDIei8kD2upi2xgDEwu7Bz1yFc0d4TH8yzmLiQh
         GMMkPK5bJii1LHdtfBjhcvrA6Hj+YHZpdOfrj39e9D1YcIEY+kXieB47jMX/XYPgOt0n
         VuaUcGM56fvAdSgs535fKifaeW6JduKUhecGnXIJTJYMcxcB1JvAJO5guJM7oDCH7JIg
         TwRmcJuQ/A0eiuUhEAl1yy2eZ1M/+5BOCKl/heMhSar38H5acDQXl6ySR97fMGTnnIoL
         XBvFj4kK1dmnZ2+R3Y4fWEiwmWR2K8HI80ZPwA4Q+akWX600JOCz3GLR7qtH2lxkkfDM
         ZJTw==
X-Forwarded-Encrypted: i=1; AL+hErGHD8DXrTpsUePnITJrnqTTlVYOz1M29KE/cz2vMrsrspmNHLTi+A5MRAU/0IrUcYK1DTE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9D+KDXfOlF/vYbJmu3ipD0JMVM+eIJkdQkRG8B6+vca9vqfs6Y
	u0sfUhXC32k3i59iKpOHuDHuM3omhm69eDaEwnP+ZpFMn7S1Kvc/e2ZR1ghPrAae8S3k3s5Gi97
	EbfbzBTYynaL8xvh/kseZa8H83YnvaFZdEAKDnmV36U188P9pnAemIw==
X-Gm-Gg: AYBFou1j1c7iMKoG0KcLC0hqCKmj1ErWBQP1V2WQakgxj7LFZ/x3swOyzJzHPgm14X9
	IxwpRRqW/EFEAPOutK9fos/JnL5hoJ1MHxb0OVuYnD1VWzrhAcWxj2liVAPYo8siv1c6rIOVcqR
	CndSlIwXnKvUIhHkxc0uu4gMUvWnkxMFBmlUWTAplZTYgbtR7F8ck2pbRFOuy9mLvi4Y9JwMpIz
	CMzf0xkTBLq1qiOI4JqHKcvOnVCpKOIwL6CsdDbgqivGjHfLSNE8P89sfBa1FkuowI0TnmpmBUZ
	H2xw1lxtKZRkr8dtXhYRPOCG/Mt1dhMvoSdqaVsuAVhsQrKAtJfhruXoZJYvU/DCug7pMee4U9T
	Ih8zUlMBz8NvcLrl5iu/4gGGhUWIQroOgiPY8oSn0aqWtbk6MeeUpxmOnHmPpjySC7xV9CUhIea
	oHPODI/LXXhj7qihUNUxH5+6M3wnRhPNf4T4jfkmVj3Uvh1lUBNpcRaNR00+LC+nCV2yH2422ji
	sod093YtHKlwA42+FUdka/WiOtr/nVRE7D2OC+3cN1nd/cUbk8h
X-Received: by 2002:a17:906:c150:b0:c2c:d06f:cf89 with SMTP id a640c23a62f3a-c50491bd3b6mr211044266b.2.1794316828727;
        Tue, 10 Nov 2026 05:20:28 -0800 (PST)
X-Received: by 2002:a17:906:c150:b0:c2c:d06f:cf89 with SMTP id a640c23a62f3a-c50491bd3b6mr211040266b.2.1794316828268;
        Tue, 10 Nov 2026 05:20:28 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:27 -0800 (PST)
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
Subject: [RFC PATCH net-next 12/12] io_uring/opaque: add basic KUnit tests
Date: Tue, 10 Nov 2026 13:20:06 +0000
Message-Id: <20261110132006.3280986-13-amarkuze@redhat.com>
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

Check receive-budget admission and watermark transitions, then build a
page-backed immutable version and check its vector, payload, held version
reference and final backing/reference release.

Use existing internal helpers without adding production test hooks. These
are basic helper checks; the matching liburing example exercises a real
ring and loopback TCP connection.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 io_uring/Kconfig       |  10 ++++
 io_uring/Makefile      |   1 +
 io_uring/opaque_test.c | 128 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 io_uring/opaque_test.c

diff --git a/io_uring/Kconfig b/io_uring/Kconfig
index 5b696cf266f6..db6e3c5a317d 100644
--- a/io_uring/Kconfig
+++ b/io_uring/Kconfig
@@ -30,3 +30,13 @@ config IO_URING_BPF_OPS
 	def_bool y
 	depends on IO_URING
 	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
+
+config IO_URING_OPAQUE_OBJ_KUNIT_TEST
+	bool "KUnit smoke tests for opaque objects" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && IO_URING_OPAQUE_OBJ
+	default KUNIT_ALL_TESTS
+	help
+	  Check receive-budget admission and watermark transitions, and the
+	  vector representation and reference lifetime of an immutable version.
+	  The tests call internal helpers without a userspace ring or TCP socket.
+	  They are a small smoke test, not a pressure or concurrency suite.
diff --git a/io_uring/Makefile b/io_uring/Makefile
index 912b1861c0a5..b7fcc2d3c714 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_IO_URING)		+= io_uring.o opdef.o kbuf.o rsrc.o notif.o \
 
 obj-$(CONFIG_IO_URING_ZCRX)	+= zcrx.o
 obj-$(CONFIG_IO_URING_OPAQUE_OBJ)	+= opaque.o opaque_register.o opaque_compact.o
+obj-$(CONFIG_IO_URING_OPAQUE_OBJ_KUNIT_TEST) += opaque_test.o
 obj-$(CONFIG_IO_WQ)		+= io-wq.o
 obj-$(CONFIG_FUTEX)		+= futex.o
 obj-$(CONFIG_EPOLL)		+= epoll.o
diff --git a/io_uring/opaque_test.c b/io_uring/opaque_test.c
new file mode 100644
index 000000000000..cba5829de05f
--- /dev/null
+++ b/io_uring/opaque_test.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <linux/highmem.h>
+
+#include "opaque_internal.h"
+
+struct opaque_basic {
+	struct io_opaque_store *store;
+	struct io_opaque_data *data;
+	struct page *page;
+};
+
+static void opaque_basic_release(void *arg)
+{
+	struct opaque_basic *c = arg;
+
+	if (!IS_ERR_OR_NULL(c->store)) {
+		io_opaque_data_put(c->store, c->data);
+		/* Also release a budget assertion's unfinished reservation. */
+		if (atomic64_read(&c->store->bytes) > 0)
+			io_opaque_uncharge(c->store, atomic64_read(&c->store->bytes));
+		io_opaque_free(c->store);
+	}
+	if (c->page)
+		put_page(c->page);
+}
+
+static struct opaque_basic *opaque_basic_new(struct kunit *test)
+{
+	struct io_uring_opaque_config config = {
+		.hard_limit = 8 * PAGE_SIZE,
+		.compact_headroom = 2 * PAGE_SIZE,
+		.reply_reserve = PAGE_SIZE,
+		.high_watermark = 4 * PAGE_SIZE,
+		.low_watermark = 2 * PAGE_SIZE,
+		.max_object_size = PAGE_SIZE,
+		.max_objects = 4,
+		.max_streams = 1,
+		.max_extents = 8,
+	};
+	struct opaque_basic *c = kunit_kzalloc(test, sizeof(*c), GFP_KERNEL);
+	struct io_ring_ctx *ctx;
+
+	KUNIT_ASSERT_NOT_NULL(test, c);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, opaque_basic_release, c), 0);
+	/* No user/mm accounting in this internal-helper fixture. */
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	c->store = io_opaque_alloc(ctx, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, c->store);
+	return c;
+}
+
+static void opaque_basic_budget(struct kunit *test)
+{
+	struct opaque_basic *c = opaque_basic_new(test);
+	struct io_opaque_store *store = c->store;
+
+	KUNIT_ASSERT_TRUE(test, io_opaque_charge(store, 3 * PAGE_SIZE, true));
+	KUNIT_EXPECT_EQ(test, io_opaque_memory_mode(store), IORING_OPAQUE_MEMORY_NORMAL);
+	KUNIT_ASSERT_TRUE(test, io_opaque_charge(store, PAGE_SIZE, true));
+	KUNIT_EXPECT_EQ(test, io_opaque_memory_mode(store), IORING_OPAQUE_MEMORY_LOWMEM);
+	KUNIT_EXPECT_FALSE(test, io_opaque_charge(store, 2 * PAGE_SIZE, true));
+	KUNIT_EXPECT_EQ(test, atomic64_read(&store->bytes), (s64)(4 * PAGE_SIZE));
+	io_opaque_uncharge(store, 2 * PAGE_SIZE);
+	KUNIT_EXPECT_EQ(test, io_opaque_memory_mode(store), IORING_OPAQUE_MEMORY_NORMAL);
+	io_opaque_uncharge(store, 2 * PAGE_SIZE);
+	KUNIT_EXPECT_EQ(test, atomic64_read(&store->bytes), 0LL);
+}
+
+static void opaque_basic_version(struct kunit *test)
+{
+	static const char payload[] = "opaque";
+	struct opaque_basic *c = opaque_basic_new(test);
+	struct io_opaque_extent *extent;
+	void *mapped;
+
+	c->data = io_opaque_data_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, c->data);
+	c->page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	KUNIT_ASSERT_NOT_NULL(test, c->page);
+	mapped = kmap_local_page(c->page);
+	memcpy(mapped + 17, payload, sizeof(payload));
+	kunmap_local(mapped);
+	get_page(c->page);
+	extent = io_opaque_extent_new(c->store, c->page, 17, sizeof(payload), 0, false);
+	if (IS_ERR(extent))
+		put_page(c->page);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, extent);
+	list_add_tail(&extent->list, &c->data->extents);
+	c->data->length = sizeof(payload);
+	KUNIT_ASSERT_EQ(test, io_opaque_vector(c->data), 0);
+	KUNIT_ASSERT_EQ(test, c->data->nr, 1U);
+	KUNIT_EXPECT_PTR_EQ(test, c->data->bvec[0].bv_page, c->page);
+	KUNIT_EXPECT_EQ(test, c->data->bvec[0].bv_offset, 17U);
+	KUNIT_EXPECT_EQ(test, c->data->bvec[0].bv_len, (unsigned int)sizeof(payload));
+	KUNIT_EXPECT_EQ(test, c->data->charge, (u64)PAGE_SIZE);
+	KUNIT_EXPECT_EQ(test, atomic64_read(&c->store->bytes), (s64)PAGE_SIZE);
+	KUNIT_EXPECT_EQ(test, atomic_read(&c->store->extents), 1);
+	refcount_inc(&c->data->refs);
+	io_opaque_data_put(c->store, c->data);
+	KUNIT_EXPECT_EQ(test, refcount_read(&c->data->refs), 1U);
+	KUNIT_EXPECT_EQ(test, page_ref_count(c->page), 2);
+	mapped = kmap_local_page(c->data->bvec[0].bv_page);
+	KUNIT_EXPECT_MEMEQ(test, mapped + c->data->bvec[0].bv_offset, payload, sizeof(payload));
+	kunmap_local(mapped);
+	io_opaque_data_put(c->store, c->data);
+	c->data = NULL;
+	KUNIT_EXPECT_EQ(test, page_ref_count(c->page), 1);
+	KUNIT_EXPECT_EQ(test, atomic64_read(&c->store->bytes), 0LL);
+	KUNIT_EXPECT_EQ(test, atomic_read(&c->store->extents), 0);
+}
+
+static struct kunit_case opaque_basic_cases[] = {
+	KUNIT_CASE(opaque_basic_budget),
+	KUNIT_CASE(opaque_basic_version),
+	{}
+};
+
+static struct kunit_suite opaque_basic_suite = {
+	.name = "io_opaque_basic",
+	.test_cases = opaque_basic_cases,
+};
+
+kunit_test_suite(opaque_basic_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1

