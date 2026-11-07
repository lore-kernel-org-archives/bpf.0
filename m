Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022497;
	b=Yaqu/CIgdd2CHxRVbgxCDhdljdhpS5W/LvB+RigA07/q9Kt5YFjVHmbhjrXGfqXnewi/
	 PcR7dfz2/2dSOZ/R3rl+Fl2BodQSo3HN31OWdHN1B40S/LEySQ0hLM2kxKQlC90fOvY4l
	 Ez38PiQ3XLD96+mC0GNwWlLzYMpUjnODKQ0ytaMMi1GIh4RsyqlVIZJiq0flJ2V/fXTZl
	 A0aCeWyQx2/dPf8uepHFOnzUv8vvGlGq4XdqfSMSaAeZgjYc0ZHy/GTeRIsBQ1HvXVIu4
	 Vx3+Og/4kwATxSuaJ1jIo/4Evpk2mVCyqk9XjCaTWkC9CWXnUMclePWnrM9Sy/Oybhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oFRJqIHH4Uu0/GgveZRmx8TIDB+Hixs9HbJY1cYzKxM=;
	b=ekJc2bnGjXzScKtPR/35AZWOxEti1hHMU5IasPn0fKBd0PiLYiovuuHDsxhFuuCtDFnq
	 SskPqKpn1YqlNADDd/Zfky+058k0bypsvRNIB/CyVeEZ2hShb/b9Motc82CWg6UYidLFe
	 Sv28c/3/PifZ5V9RrHrE0C5tUFlsi45fgs5GLfynmyNhL5TvbmM1U+Uuz/+cMiU9t3mno
	 SJp2SByYkDQZ4xkTfRsQzBCKu+PCwGr1V4XQCCgiyVg5q1/JD7mp5trLkRXNigA4JiOck
	 9nUAKD6wE8DWgQKVtT0I3LLYXp8sUVN2aOT10PATWO22ZBkIUz98Uy7M8dfzD3fZU9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=CuGsq7jQ;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADEC606A332
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ADEC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=CuGsq7jQ
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c49b431f022so185592766b.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794022496; x=1794627296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oFRJqIHH4Uu0/GgveZRmx8TIDB+Hixs9HbJY1cYzKxM=;
        b=CuGsq7jQiUwc8uwFzNw/ENZ6f2KjpuUGfKt+Ii/xdmbNtAYmRgsjFbRInOfPysbQUS
         yANdYNbxm3MDT0b8iGW7xxCOA1Kqu8ga8LgD0ARmCfHh33r5FVAaN6MOirGkBsBXpSOV
         mm+ZX2N24PTap4EXGvt97sQdlx+0kKtpBNVx5DBhVkK6KGxHKToFhOSUXTnxX3JwjblU
         eyDPWSCzZIgPdQ84KJWhWZxCOiUtZJ52kPwEQ1ti4gx9DC83S8phs+apvii2AtJkvazi
         vJsoS7aG9IQMc27oyvQX3/kf1KBEGX7428fQczrws3mrU0pqRcWpa3E6O2ty4rHoBCZK
         JpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022496; x=1794627296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oFRJqIHH4Uu0/GgveZRmx8TIDB+Hixs9HbJY1cYzKxM=;
        b=fQFts/FtKeyCyZvLkScpqmlS9o8jOBnIRY8NQqvXgQV0qfOb5P0qHhOtEkceQTNnxy
         +Mft9BQGo1X8DzsTrTnJ8e+esM4its8VUyLqPJ5FNskTEflKySyiG85XmuxCC8nWtkF4
         RJSZ8VYWzv2CB6ru9Q54O06P5NF+386gCWU37b1XWPMSYAN0B9H6XjBSN2GchLFgXPGP
         ABvgCx3Outd8cP7rjlziRwj5I2WzmS0b+YggCZrMvYSttiGr2SPNyUFgnahRBVmTeOff
         TKoonLn38M9psocZyLQho5KgXaPC8eWFd6jVm9drxtquIOyHOParF5l4PprECdslfwWo
         R/Pg==
X-Forwarded-Encrypted: i=1; AKwUvByP55kS6hN1hn5rszgj9SNRDa36enK+S/KtzTDdN5OSRyAHiDmeboOQ3IToW9Nd9fzx0bQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z91IBx/z/b3Ydxuyog4UhBBH2okDTBjHeHt2djO7Xho2RCDZVCH
	tvNbWC7cU+MlYoA8XLC4CVbFj1WFsGNAtC27HrZ5DF8m150JMxyi7pPJJJw/xWmzNOY=
X-Gm-Gg: AYBFou3Y9lGzCc2dG7VH5XBUoyjf2IRVQWl/fqp+dQ7a/HR7/A0OnljrKnODLYHMczb
	KJ/oPoTlZ9AdXeo/Wr9xAmDmXU4cuo51xyVPOfhyFMMJZPxII0Istckepi7je8v5XfSm3QgS8UM
	zQ/AKGhf2JUR23dKpCB3hY3GrdCdKY0MZzFLSxD2ArRDqwDw10qKh1mWryop91h6Uis0NeaDidv
	IrrTx5b18rfUaFmbAdleAUqwsgg7r/GWsqmU48hmbJVqGkHoMMS+M/wPemhg3qodbBW4r7GmiUX
	ooLfUONwrXIuE39GwpX/SP7cyZHlmMzpY1UduZ9jp5ohoIh+f4SMAkIqWAx3gOAFJYYNmnGGN6m
	zaxgFeEXxZsF5gml8VE8uzn6LNhEh+NzWrJCAfMXIw23Z6ogD/0lwWAf0vGhSGjY3a7k4EifuPn
	vwSrK3hJonTpQQGdKsFFXbaJ/wMSyYjbwjKoiHyNstrzi4b0PVMTfp4e9mDllfwXvd/JER92vAp
	W+2LnAHuX8bmLkQkEBwK0pgPHXzubIXNvZVGwM20/96A3IppjIg9MR13Iw1lVWTaG4o0TCeLVB0
	FYl1lqyGssZVya8LIerTnqyfxfzYa8s63lqU9SjsQ7Xj7ymmyjTDexDoWifg+rk=
X-Received: by 2002:a17:906:f58c:b0:c48:1977:e1bf with SMTP id a640c23a62f3a-c4d34cc020dmr370526966b.24.1794022495830;
        Fri, 06 Nov 2026 19:34:55 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3562e00dsm121104166b.21.2026.11.06.19.34.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:34:54 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Danielle Ratson <danieller@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 6/8] selftests: net: add flag to send a frame in xdp_helper
Date: Sat,  7 Nov 2026 03:34:25 +0000
Message-ID: <feab5dcef8743856ff1681f9a6ba62137d845c43.1794020868.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794020868.git.tianyi@cloudflare.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
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

xdp_helper only binds an XDP socket and waits. Tests in selftests/net
have no way to send a frame through the AF_XDP TX path.

Add a -t option that takes one Ethernet frame in hex. With -t, the
helper also creates a TX ring and sends the frame. It then waits for
the frame on the completion ring and exits. It returns 1 if sendto()
fails or no completion arrives within one second. Without -t, nothing
changes.

The test passes the whole frame in hex, so xdp_helper does not need to
know about IP or UDP. veth has no AF_XDP zerocopy support, so the
socket runs in copy mode. In copy mode the kernel allocates an skb for
the frame in xsk_build_skb(), which uses the extra headroom.

xdp_helper now maps the completion ring at
XDP_UMEM_PGOFF_COMPLETION_RING (0x180000000). This offset does not fit
in a 32-bit off_t, so define _FILE_OFFSET_BITS to 64.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 tools/testing/selftests/net/lib/xdp_helper.c | 113 +++++++++++++++++--
 1 file changed, 106 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
index eb025a9f35b1..5f4dec4408d9 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _FILE_OFFSET_BITS 64
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -19,15 +20,91 @@
 
 static void print_usage(const char *bin)
 {
-	fprintf(stderr, "Usage: %s ifindex queue_id [-z]\n\n"
-		"where:\n\t-z: force zerocopy mode", bin);
+	fprintf(stderr, "Usage: %s ifindex queue_id [-z] [-t frame_hex]\n\n"
+		"where:\n\t-z: force zerocopy mode\n"
+		"\t-t: send one frame, given in hex, and exit\n", bin);
+}
+
+static int parse_frame(unsigned char *buf, const char *hex)
+{
+	size_t len = strlen(hex) / 2;
+	size_t i;
+
+	if (!len || len > 2048 || strlen(hex) % 2 ||
+	    strspn(hex, "0123456789abcdefABCDEF") != strlen(hex))
+		return -1;
+	for (i = 0; i < len; i++)
+		if (sscanf(hex + 2 * i, "%2hhx", &buf[i]) != 1)
+			return -1;
+	return len;
+}
+
+/* Send the frame at UMEM address 0 and wait until its descriptor shows up
+ * on the completion ring. In copy mode this happens when the skb is freed.
+ */
+static int send_frame(int sock_fd, __u32 len)
+{
+	struct xdp_mmap_offsets off;
+	socklen_t optlen = sizeof(off);
+	struct xdp_desc *desc;
+	size_t tx_sz, cq_sz;
+	char *tx, *cq;
+	int ret = 1;
+	int i;
+
+	if (getsockopt(sock_fd, SOL_XDP, XDP_MMAP_OFFSETS, &off, &optlen)) {
+		perror("getsockopt failed");
+		return 1;
+	}
+
+	tx_sz = off.tx.desc + NUM_DESC * sizeof(*desc);
+	tx = mmap(NULL, tx_sz, PROT_READ | PROT_WRITE, MAP_SHARED, sock_fd,
+		  XDP_PGOFF_TX_RING);
+	if (tx == MAP_FAILED) {
+		perror("TX ring mmap failed");
+		return 1;
+	}
+
+	cq_sz = off.cr.desc + NUM_DESC * sizeof(__u64);
+	cq = mmap(NULL, cq_sz, PROT_READ | PROT_WRITE, MAP_SHARED, sock_fd,
+		  XDP_UMEM_PGOFF_COMPLETION_RING);
+	if (cq == MAP_FAILED) {
+		perror("completion ring mmap failed");
+		goto out_tx;
+	}
+
+	desc = (struct xdp_desc *)(tx + off.tx.desc);
+	desc->addr = 0;
+	desc->len = len;
+	__atomic_store_n((__u32 *)(tx + off.tx.producer), 1, __ATOMIC_RELEASE);
+
+	if (sendto(sock_fd, NULL, 0, MSG_DONTWAIT, NULL, 0) < 0) {
+		perror("sendto failed");
+		goto out;
+	}
+
+	for (i = 0; i < 100; i++) {
+		usleep(10000);
+		if (__atomic_load_n((__u32 *)(cq + off.cr.producer),
+				    __ATOMIC_ACQUIRE)) {
+			ret = 0;
+			goto out;
+		}
+	}
+
+	fprintf(stderr, "no TX completion\n");
+out:
+	munmap(cq, cq_sz);
+out_tx:
+	munmap(tx, tx_sz);
+	return ret;
 }
 
 /* this is a simple helper program that creates an XDP socket and does the
  * minimum necessary to get bind() to succeed.
  *
- * this test program is not intended to actually process packets, but could be
- * extended in the future if that is actually needed.
+ * without -t it does not process packets. with -t it sends one frame
+ * through the TX ring and exits once the frame completes.
  *
  * it is used by queues.py to ensure the xsk netlinux attribute is set
  * correctly.
@@ -37,13 +114,16 @@ int main(int argc, char **argv)
 	struct xdp_umem_reg umem_reg = { 0 };
 	struct sockaddr_xdp sxdp = { 0 };
 	int num_desc = NUM_DESC;
+	int frame_len = 0;
 	void *umem_area;
 	int retry = 0;
 	int ifindex;
 	int sock_fd;
 	int queue;
+	int ret;
+	int i;
 
-	if (argc != 3 && argc != 4) {
+	if (argc < 3) {
 		print_usage(argv[0]);
 		return 1;
 	}
@@ -94,9 +174,21 @@ int main(int argc, char **argv)
 	sxdp.sxdp_queue_id = queue;
 	sxdp.sxdp_flags = 0;
 
-	if (argc > 3) {
-		if (!strcmp(argv[3], "-z")) {
+	for (i = 3; i < argc; i++) {
+		if (!strcmp(argv[i], "-z")) {
 			sxdp.sxdp_flags = XDP_ZEROCOPY;
+		} else if (!strcmp(argv[i], "-t") && i + 1 < argc &&
+			   !frame_len) {
+			frame_len = parse_frame(umem_area, argv[++i]);
+			if (frame_len < 0) {
+				print_usage(argv[0]);
+				return 1;
+			}
+			if (setsockopt(sock_fd, SOL_XDP, XDP_TX_RING, &num_desc,
+				       sizeof(num_desc))) {
+				perror("setsockopt XDP_TX_RING failed");
+				return 1;
+			}
 		} else {
 			print_usage(argv[0]);
 			return 1;
@@ -119,6 +211,13 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (frame_len) {
+		ret = send_frame(sock_fd, frame_len);
+		munmap(umem_area, UMEM_SZ);
+		close(sock_fd);
+		return ret;
+	}
+
 	ksft_ready();
 	ksft_wait();
 
-- 
2.56.0

