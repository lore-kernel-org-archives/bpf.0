Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052332;
	b=aumxkKnISwVR7gTl2Z4W5BL73ospd4wEZyd/E2oEVJ8VOEOSqxxiTxOC/XUcdikqTSVL
	 ZgA8qNcdGKDCwkBH5IgViihqkFc9B6zcfamcJsxc0XsHZ8nIqz5VrY/4buMWrokihjTh6
	 o8nT33ffUHl4YNyyeONiq/MX2SLB0tjTPM6roXH8aO2Baibx0CuWOYFC5iWCNxYp3c9N7
	 AayDPbtAqHKYDORexjJ7/VZ+Uvn0LT3PAY80BpgLTyHMRpqC97qoyojlX+HDM/Uisk2st
	 TDrLC3JRxhjUhPI/A6BlFbSwXKbT0JxafhAub8MpH+jd4J2PLfvUDO5IT0wck5Dtw0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yVcHqzXkcmRmeetpAor6laiPG64o4Do4e1KDubpvDQA=;
	b=IX50d1iCWkNtZkY2zXGLidMLuklNShpU08bxEbWRj5+iT5iGjioXumUdvNwJEpM/D3Du
	 7/ubAEW7WErIjvRfxTyoc1fqWUIW3xIPx8jge45k9dF0saSEdv5gO1Qzc3Z+MV4qrWdnI
	 AxwSRtjNuEkYe8cxZGsQEXnFb3cJtRKyvALvFZeTp2e0R8oTTpCWr3Ip9SKjT2XQPWvGA
	 FYwUYGVV63DKRwAFmXMF2nkfsPlVuvvokaidV38WbkPLrFygi/1CYRMMdkEp3M6DEA5Ua
	 FYLArWI6IZUS0dWO5KStny6A055FxXwXvnQijfQVeT4NnULHaVDYWRNisbs3uxHGOXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="Eh7C/lX8";
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669B60A262D
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6669B60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Eh7C/lX8
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4d21051042so280736166b.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795052330; x=1795657130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVcHqzXkcmRmeetpAor6laiPG64o4Do4e1KDubpvDQA=;
        b=Eh7C/lX85Oa77jtB8/DFYZO+O9JzEG3DMq5syaMAz6SYmftKF83P6kGE2jMl3ya1ho
         dcDrWR0Yjk571vjfMXLmb1qYoyp6zVnHBIJyjiAwmoaBlYEVOlje4cMf96MC7SujRAyK
         CSJlfAg8RbfEIpBnKIbF9YUAaFdpd5eJbQCfxwFUgS90pld+VB9oqcZwRGA68tjglwkH
         DGSOQKbLQKUB+ZxilP1l0UZRPQqWLP+udcn2MvhffPDURz8xz1SujAOV6xIYRvvD8ji2
         pyc3/EX2bV8GqF4v/uGZE+Z17G+PNd+0NP19RB87s3AEKOhKUrYjCG+OhSzA3sKVvJFQ
         Cr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795052330; x=1795657130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yVcHqzXkcmRmeetpAor6laiPG64o4Do4e1KDubpvDQA=;
        b=wjfEJeDTA5jJOKlSuLEotQNJy+stRYyuaCUtG+deGKdv5DvkKmJys/NAZbZax7qZbQ
         VU5CH1COWobVjPGycppS0BBecYc5JudE6XUWd6cnMwmHWCP9IMWcMMHI6e7FOd2a07s6
         E4ISCJX6J+FqYqo1XZ/2kVsHinf1hP+W6rHkOu+WheC9SmTQkX9I6OKjLUX0/fHdzSch
         EKO/Yt9Szdzt1wSBWfRIIrFCihuq/bQAbz7W83Z/GNGbCVx/00SGpa7h87fXurMxJtPz
         YoSXwepZwBI1z4qtj8hQjgoqho4Pd24NzObZkbQxc5EQOehiiupQJlTaYugRnI6Qlyxw
         7Qfg==
X-Forwarded-Encrypted: i=1; AL+hErEow0VlXzm63lF/D9Rpf1FIe2Vb5FJj16cpaE5qKEm5gvo9V02EI0e66dImsO41JnZNMP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CUU7s+1E9Fazxf5if+8EoJ2c8TKB6ApMO39C31NTn4PYMlxeb
	7jdNzby3hXi9toHdmZM25HD8pX+YH2eL770ln0sTX7Epllfe63KW83+4+rdLHLiJQtw=
X-Gm-Gg: AYBFou1BPeCrCvYnanFV1XhkSTWov+POb2nojRvBdUnmxav8jRnLIOO6WbB4gaoAPEv
	KAml3MexQ5FzRrB5+nuE42GDZ7aEG3Af4MBxnSoUou0+TBe0YyoNAesjIlK54N2l9PgIhmxKOrb
	2yCm9V3YIjpmEj6opafgcmzKgS3jGr6duC5Qp+sDkpBFhKB/YFc4uqv05dsdtdWgQWHDKBtezcU
	4TdojisNshAETwmeaLgG66GBZtgK0uUgh+KFZaGS9rnihAmf8qzrjGQh+01+0RsdtYG2vY7hSJI
	WploKJzflOAOx3j77MHhJugC3KZ1l9ewBklOur/q1Ww6PFWQCN/XU75kJbQYhhGS+VJrb0WMKQn
	pEdpdSRQ7SVxgM+5F4WukrrQyTxqdSHjf/9h0nHbCj59xAHQKc6mvs9t2kOPul+sL0vf1tl1Cvb
	ojIaIzIlvID0DxaCH9iMhqTXqmtqvRPbo1bka24RF8x+WPojhsmNYSb9ZY3H8T4EtJrYdNLc4yG
	RgK3TlBa87gm52bmpLPW89CarN0nG3BzBC8Pis8r7e2IjZwDXKegT3xTzQ79EyjA/TMpVtOnbWk
	hjELG6cqSNHN+N1Ef3NibGMCpdXNH2cQquAdQDvWydLNqH1/P2DBLENlHg==
X-Received: by 2002:a17:907:9613:b0:c40:9b75:84af with SMTP id a640c23a62f3a-c510e15bbd9mr437677766b.8.1795052329834;
        Wed, 18 Nov 2026 17:38:49 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4080sm59785966b.16.2026.11.18.17.38.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 17:38:48 -0800 (PST)
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
	Stephen Hemminger <stephen@networkplumber.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Anil Kaushik <anilkaushikwireless@gmail.com>,
	Demos Ra <demosthenes.ra@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Joe Damato <joe@dama.to>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Li RongQing <lirongqing@baidu.com>,
	Louis Scalbert <louis.scalbert@6wind.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Song Liu <song@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Wang Zhan <wang.zhan@smartx.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Zhou Qiuyue <n0ps1edzz@gmail.com>,
	Tianyi Gao <tianyi.gao@linux.dev>,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 04/11] selftests: net: add flag to send a frame in xdp_helper
Date: Thu, 19 Nov 2026 01:38:23 +0000
Message-ID: <20261119013830.36935-5-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119013830.36935-1-tianyi@cloudflare.com>
References: <20261119013830.36935-1-tianyi@cloudflare.com>
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
helper also creates a TX ring, sends the frame and exits. It returns 1
if sendto() fails. Without -t, nothing changes.

The test passes the whole frame in hex, so xdp_helper does not need to
know about IP or UDP. veth has no AF_XDP zerocopy support, so the
socket runs in copy mode. In copy mode the kernel allocates an skb for
the frame in xsk_build_skb(), which uses the extra headroom. As a test
helper, -t takes one well-formed frame and does not wait for TX
completion, because copy mode sends the frame within sendto(). A
driver with zerocopy support may send it later, so -t is meant for copy
mode.

send_frame() follows tools/testing/selftests/net/lib/xsk/xsk.c and
tools/testing/selftests/bpf/prog_tests/xdp_metadata.c. XDP_PGOFF_TX_RING
(0x80000000) does not fit in a 32-bit off_t. xsk.c also passes it to
mmap() without _FILE_OFFSET_BITS, so xdp_helper does not define it
either.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
v2:
- Exit after sendto() and do not wait for the TX completion, as
  xdp_metadata.c does.
- Drop the _FILE_OFFSET_BITS define, as xsk.c does.
---
 tools/testing/selftests/net/lib/xdp_helper.c | 80 ++++++++++++++++++--
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
index eb025a9f35b1..1111631efd73 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -19,15 +19,65 @@
 
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
+	if (!len || len > 2048 || strlen(hex) % 2)
+		return -1;
+	for (i = 0; i < len; i++)
+		if (sscanf(hex + 2 * i, "%2hhx", &buf[i]) != 1)
+			return -1;
+	return len;
+}
+
+static int send_frame(int sock_fd, __u32 len)
+{
+	struct xdp_mmap_offsets off;
+	socklen_t optlen = sizeof(off);
+	struct xdp_desc *desc;
+	size_t tx_sz;
+	int ret = 0;
+	char *tx;
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
+	desc = (struct xdp_desc *)(tx + off.tx.desc);
+	desc->addr = 0;
+	desc->len = len;
+	__atomic_store_n((__u32 *)(tx + off.tx.producer), 1, __ATOMIC_RELEASE);
+
+	if (sendto(sock_fd, NULL, 0, MSG_DONTWAIT, NULL, 0) < 0) {
+		perror("sendto failed");
+		ret = 1;
+	}
+
+	munmap(tx, tx_sz);
+	return ret;
 }
 
 /* this is a simple helper program that creates an XDP socket and does the
  * minimum necessary to get bind() to succeed.
  *
- * this test program is not intended to actually process packets, but could be
- * extended in the future if that is actually needed.
+ * without -t it does not process packets. with -t it sends one frame
+ * through the TX ring and exits.
  *
  * it is used by queues.py to ensure the xsk netlinux attribute is set
  * correctly.
@@ -37,13 +87,15 @@ int main(int argc, char **argv)
 	struct xdp_umem_reg umem_reg = { 0 };
 	struct sockaddr_xdp sxdp = { 0 };
 	int num_desc = NUM_DESC;
+	int frame_len = 0;
 	void *umem_area;
 	int retry = 0;
 	int ifindex;
 	int sock_fd;
 	int queue;
+	int i;
 
-	if (argc != 3 && argc != 4) {
+	if (argc < 3) {
 		print_usage(argv[0]);
 		return 1;
 	}
@@ -94,9 +146,20 @@ int main(int argc, char **argv)
 	sxdp.sxdp_queue_id = queue;
 	sxdp.sxdp_flags = 0;
 
-	if (argc > 3) {
-		if (!strcmp(argv[3], "-z")) {
+	for (i = 3; i < argc; i++) {
+		if (!strcmp(argv[i], "-z")) {
 			sxdp.sxdp_flags = XDP_ZEROCOPY;
+		} else if (!strcmp(argv[i], "-t") && i + 1 < argc) {
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
@@ -119,6 +182,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (frame_len)
+		return send_frame(sock_fd, frame_len);
+
 	ksft_ready();
 	ksft_wait();
 
-- 
2.56.0

