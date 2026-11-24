Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543140;
	b=U/QerbCRNj+oFiuOFy90vBCyk0Mfxgfnd7ciw8AaNxF28XeBiyzcdiGh9LdwRDnloYga
	 2Pb8ZmOYNW3+nukpE0+usElnK7h8yq6xiY4sFe2ho3xSjZW3kcjocfQHVc66NlLhLdxu3
	 ngJRdPptyJ5Ya2/mgWqb+5JUMPgBpnOQRRMUa8RmqXaDrg/GhJwZay1aBVs8zdQW3fMkZ
	 D3yPoA6p03+kRXfQUTAJtRe2aGCJjOOl9kN7kXoT9qwm2ONWHc7CZpNqIMtGPRVJASwVs
	 4rQxHZQHXI/e+gfevKQTqiRXkkGaWPNNUOWaTs5xjdIonM9rI6NoDFl6tcAMMjCbIbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bohhXAU7tFCgOgXzIKgR9vv6uOs8poL4HtEoBRHXmXw=;
	b=VBi0AF5KZerCWe/XucBqGwyux76SYxcgN5j6MrFVd2COyLa38ANa9QP+ejiQqVWitOEX
	 UHrDV9K96/lDmtFU0zd7wh2iScW65ASzISkR60MayJoL2ALy4NORuNJaNDzBTM4bE7sK3
	 j4RUoOXut3EojpriinGjg5sV/UmY6ez8pL/EHkqZTqYIILpXWobjjI+jEfBAyYCHto7m0
	 J2Cr5zME0cOsnfVxsIiBIFPMNfd5iU7ZKOZDgk2BwSwW9HfQm1LgrI3IeIV7Dh1WSlxvZ
	 W+9R4i7XIXy+/jkYGp4LFqCwZFIb4wUQZBwDzyRE5dPjGZbWFjuU8Izoo213V2/F4Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=FNCLkt0+;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41D606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB41D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=FNCLkt0+
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6baa6f27904so3620196a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795543138; x=1796147938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bohhXAU7tFCgOgXzIKgR9vv6uOs8poL4HtEoBRHXmXw=;
        b=FNCLkt0+X74F8TZpGwPJ9My784ujCrxM6ZfPnrYHMenzKjY8dmDndskgj849rlsJi1
         LYWBxXpF98Oj9PVPZmkemu0wbHqFguw1N+7GJae/hdyzuykfYYBMUIPDatFBxTzN90Zm
         kroq07brpFUwpVripCnyotNy3p4BcxO4TPwy7b+lwa7LwvB+krZC5HVulnzTZTVcUcdZ
         7dggCwe+5nYhDs3AWVeTTaX574POT0GKb7RCj5gh8k/jem6IYzVia3rVfzPSlc1Xyo9p
         F7W+EXEdY76NzGcCyEe38J55jF9TroasSlvMSB+M6RsisPWiGh6C13Hgs9iFSW8Xq4qJ
         gkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543138; x=1796147938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bohhXAU7tFCgOgXzIKgR9vv6uOs8poL4HtEoBRHXmXw=;
        b=R+IVXEE29FRwl2VowmmvONqpz+xStsNVpIyOBU6H8n8MkK1hNBKL6zRCfkr1ZTg/Bm
         BzDNXo6Hgp+C8eBTtxutlq2aSrSRhjoIJ+F4CRPDsBv1DO0G42NOkXwQOs9wB+tSaPen
         OVKi0eB55t4Ddk043tNJC9lJ3PkMFiVn2Bdxx3urNXATmC68g0IFkvQviLIEfXPtvOw9
         T063fK0iCSEBCb/GM/mj7bxyTySLUQ1pa7e0VimkpnrmVtjOTVMRu75mFkrPfwLHnuDJ
         EX+NBBztkj2IHvmq/9iTHgoIdR4AVYEh/JeTYwecYe/BDX6INU9g+zMuRTufLGF6KUhu
         ELUQ==
X-Forwarded-Encrypted: i=1; AL+hErFOdv7Spq0oEpr95Vgk2QVO1xI2ATZsBZBRl9I2u7PFGJgxK5HggRwAcbmZamkMr3XysqY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ceNGst6miqyL/P/sAiojGcML3WvD33LhMqOGOYzlbYtpxbXaU
	crH3ILLNN9B8YfX93UGfZFf4uLIRcixf7UdQGyuD3/xf3nC507Obfl2ECBRTO9+1pV4=
X-Gm-Gg: AZFdTZdDs2SpGIP2+AKj61VE1GKDfNyXPXhjPXEF+WgnSERYaUSyPiDDsnc2/iTmGbb
	H5rEurJ83asyigUiRPjeSFFl1LuNOVvgI3WjRLdd3TwaNl+mHyuwdbEDOmbYOeCfsKf6fktPVmx
	cnSS7EGCWfFzaaRfmwEGnOWG/81qHlAHKmVSz2/11mNAocT8gdoRFiLuUhYjy66WLvcD6zsW5i6
	k9tOcT+yomDZPxmmwxL5ZMHBLmlS0N0ALYzNHzm05qqslzrHFf5kpxHsQ/43uwsP7G36wfAh0yO
	nZmMuVIO1EL1BdyG7KdkUcjr/8q/2rSGYNIUPLPSnEf6jpfo8WvVJI4k5jwFU9q7QvEupFvdPAh
	u2uJG3RJVrj8bDL5A2bcDlUqbfsH1h5jJeWjhIopLV3xgE7zH6TLqGaLgkUMyDXtlP6+BUl6yFK
	N1bqgSASc0ge2DkDtNAL+/1iWUp8hpPAnPFDKTF3nkfp+KxBQx47dt9J1NcAYfWXxVJQkUiVG8/
	D5WRcX+zUA9SFas13JXd4lVzbb8EULnPXwOvVc931xzZhLvHBIqYrbQQuzzvhKLSZ0tKBX3i7QY
	LasRaoWrCd2FA2btpIwcQq0Y3Ar4OUXbrjqSZFMBySHEF0E=
X-Received: by 2002:a05:6402:2714:b0:6ba:45a3:c7de with SMTP id 4fb4d7f45d1cf-6ba45a3ca22mr10545737a12.9.1795543138120;
        Tue, 24 Nov 2026 09:58:58 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba3711ad52sm7205762a12.35.2026.11.24.09.58.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:58:57 -0800 (PST)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	Tianyi Gao <tianyi.gao@linux.dev>,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v3 04/11] selftests: net: add flag to send a frame in xdp_helper
Date: Tue, 24 Nov 2026 17:58:17 +0000
Message-ID: <20261124175824.60470-5-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124175824.60470-1-tianyi@cloudflare.com>
References: <20261124175824.60470-1-tianyi@cloudflare.com>
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
know about IP or UDP.

-t binds the socket in copy mode. Copy mode sends the frame within
sendto(), so the helper can exit right after it. In zerocopy mode,
sendto() only wakes up the driver, which may send the frame after the
helper has exited and closed the socket. Also, the extra headroom is
added when copy mode allocates an skb for the frame in xsk_build_skb().

send_frame() follows tools/testing/selftests/net/lib/xsk/xsk.c and
tools/testing/selftests/bpf/prog_tests/xdp_metadata.c. XDP_PGOFF_TX_RING
(0x80000000) does not fit in a 32-bit off_t. xsk.c also passes it to
mmap() without _FILE_OFFSET_BITS, so xdp_helper does not define it
either.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
v3:
- Bind in copy mode with -t (Sashiko).

v2:
- Exit after sendto() and do not wait for the TX completion, as
  xdp_metadata.c does.
- Drop the _FILE_OFFSET_BITS define, as xsk.c does.
---
 tools/testing/selftests/net/lib/xdp_helper.c | 83 ++++++++++++++++++--
 1 file changed, 75 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
index eb025a9f35b1..e17768816032 100644
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
@@ -94,9 +146,21 @@ int main(int argc, char **argv)
 	sxdp.sxdp_queue_id = queue;
 	sxdp.sxdp_flags = 0;
 
-	if (argc > 3) {
-		if (!strcmp(argv[3], "-z")) {
-			sxdp.sxdp_flags = XDP_ZEROCOPY;
+	for (i = 3; i < argc; i++) {
+		if (!strcmp(argv[i], "-z")) {
+			sxdp.sxdp_flags |= XDP_ZEROCOPY;
+		} else if (!strcmp(argv[i], "-t") && i + 1 < argc) {
+			sxdp.sxdp_flags |= XDP_COPY;
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
@@ -119,6 +183,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (frame_len)
+		return send_frame(sock_fd, frame_len);
+
 	ksft_ready();
 	ksft_wait();
 
-- 
2.56.0

