Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773719;
	b=cVXhpGZ7kIFZ1XxNmUBOpdgeDxbBR/L8DEiLegrOirMb1zQ+4j7zVZBZLt9XBE5ldEub
	 A86yfbd4g5mSr6Wo9jbZiYSE8iWvpiZfrBBQNGJqKZQY+OVi5JuA4GMXL6VzsXfREuErB
	 ngZuxuBUOhFIm1PH5ZNjzwr9QSixbzlmSRoi/X3HCGYYs1I1KQDkYe448vqGu03VKrWOm
	 CEMeAhvlPcJjlOCoCGZt5yfkJW0lzpy0YCHKRr42Z0VutWPUEOw+Zid6ecHHlfQlAgBQb
	 WQ6MXveDva5ems6DddazY/RQFtA9ZqwNUibBpOnXvj1hdYg4dY3drMalLaqLt8Ktg1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773719;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=64KsjQaIAQCLkSy5XUakz5qRXTJ4vmB/sJbuNLP4YMQ=;
	b=c4TKwnQiur6ESjhR7hZcp+SQ4rFut2lpmhLIebUgK1UZSLdh2SFheastWEbGm4R7gziR
	 hnL1sttGDsSt+Sog7x8UJ+klR5zRzIzVMz5a5/zPsmykrLY0GmabUNXRISr3Y5+cCESfX
	 1r7IBQ8OdENScE0dJ8qBbwpNhZ3V/B/D/rxX5qnlZgSjXhQuz+Q0o73RJdMeiZTLgKygN
	 XhVpKGxd/yqhT7kDa75MZZJE94StSmtKLwpyjyeGMKMJD3BmyZBmjLls3SszC/rKkr5HZ
	 Fo66YJ4TyYW1UXKUh+W/n4UltpVWsCPnO0spwc/f0Zf85g0QwTThzW2zn833EXA4bcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=gJUNUJSc;
	arc=none smtp.remote-ip=217.74.67.49
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FC606A33D
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 803FC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=gJUNUJSc
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Fri, 27 Nov 2026 11:01:54 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Dudu Lu <phx0fer@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Octavian Purdila <tavip@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH net v9 5/6] selftests/bpf: add xdp_shrink_frags
Date: Fri, 27 Nov 2026 11:01:31 +0100
Message-ID: <20261127100132.1977890-6-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127100132.1977890-1-sst@poczta.fm>
References: <20261127100132.1977890-1-sst@poczta.fm>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795773716; bh=64KsjQaIAQCLkSy5XUakz5qRXTJ4vmB/sJbuNLP4YMQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gJUNUJScpMuzw19gqLN1wTu9WJ+DrkruK/47pRmoaw45ao8i04/QY4q2rj1IGsBp4
	 L3Utv0w3tDDdBeePl0cKJa9DzEohu8yVMhToeqLXprgCC1jlxRn5D0ytPFr0O1MHyl
	 dejtipBWi9trVQ8Nix+ua7p3jIZclo/cvi9HlfYs=

From: Jiayuan Chen <jiayuan.chen@linux.dev>

Add a test that attaches an xdp.frags program which shrinks a whole frag
away, so bpf_xdp_shrink_data() frees a page_pool frag.

test_tun triggers the page-type mismatch on the generic XDP path.
test_veth triggers the same mismatch on the veth path.
test_veth_tx bounces the cow'd buff with XDP_TX so the peer runs a frags
program on the resulting frame, covering the buff -> frame -> buff path.

A kernel without the fix will report "Bad page state ... page_pool leak".

The packet sizes only leave a frag after the cow on 4K pages, so the
subtests skip elsewhere.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
[sst: reworded two comments for the on-stack rxq info]
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 .../bpf/prog_tests/xdp_shrink_frags.c         | 288 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_shrink_frags.c    |  34 +++
 2 files changed, 322 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_shrink_frags.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
new file mode 100644
index 000000000000..789dfdd51b57
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <linux/if_tun.h>
+#include <linux/if_ether.h>
+#include <sys/uio.h>
+#include <net/if.h>
+#include <arpa/inet.h>
+#include "xdp_shrink_frags.skel.h"
+
+/*
+ * A generic-XDP program that shrinks into the frags frees a page_pool frag.
+ * skb-backed XDP first cow's the nonlinear skb into page_pool memory
+ * (skb_cow_data_for_xdp() for generic XDP, skb_pp_cow_data() for veth), but
+ * the shared rxq is registered as MEM_TYPE_PAGE_SHARED, so a buggy kernel
+ * frees the frag with page_frag_free() -> "Bad page state ... page_pool leak".
+ */
+
+#define TAP_NAME	"xdp_shrink0"
+#define TAP_NETNS	"xdp_shrink_tap"
+
+#define NS_NAME_MAX_LEN	32
+#define VETH_LOCAL	"xdp_shrinkA"
+#define VETH_PEER	"xdp_shrinkB"
+#define VETH_LOCAL_IP	"10.9.9.1"
+#define VETH_PEER_IP	"10.9.9.2"
+#define VETH_LOCAL_MAC	"02:00:00:00:00:01"
+
+/*
+ * skb_pp_cow_data() keeps up to one page in the linear part, so the packet
+ * sizes below only leave a frag (smaller than the 3000-byte shrink, so it is
+ * released as a whole) on 4K pages. Skip elsewhere rather than run a test
+ * that cannot tell a fixed kernel from a buggy one.
+ */
+#define PAGE_SIZE_4K	4096
+
+/*
+ * Generous, so a loaded CI does not fail the assert prematurely; normally
+ * the first check already succeeds.
+ */
+#define WAIT_ITERS	10000
+#define WAIT_US		1000
+
+static void wait_for_prog(struct xdp_shrink_frags *skel)
+{
+	int i;
+
+	for (i = 0; i < WAIT_ITERS && !skel->bss->shrink_ran; i++)
+		usleep(WAIT_US);
+}
+
+static int create_tap_napi_frags(const char *ifname)
+{
+	struct ifreq ifr = {
+		.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_NAPI | IFF_NAPI_FRAGS,
+	};
+	int fd, err;
+
+	strscpy(ifr.ifr_name, ifname);
+
+	fd = open("/dev/net/tun", O_RDWR);
+	if (fd < 0)
+		return -errno;
+
+	err = ioctl(fd, TUNSETIFF, &ifr);
+	if (err) {
+		err = -errno;
+		close(fd);
+		return err;
+	}
+
+	return fd;
+}
+
+/*
+ * Similar to flow_dissector.c: writev() an IFF_NAPI_FRAGS tap to build a
+ * nonlinear skb that tun runs through do_xdp_generic().
+ */
+static void test_tun(struct xdp_shrink_frags *skel)
+{
+	__u8 head[74], frag1[2048], frag2[2048];
+	struct ethhdr *eth = (void *)head;
+	int tap_fd = -1, ifindex, err;
+	struct netns_obj *ns = NULL;
+	struct iovec iov[3];
+	ssize_t n;
+
+	if (getpagesize() != PAGE_SIZE_4K) {
+		test__skip();
+		return;
+	}
+
+	ns = netns_new(TAP_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	tap_fd = create_tap_napi_frags(TAP_NAME);
+	if (!ASSERT_GE(tap_fd, 0, "create_tap"))
+		goto out;
+
+	SYS(out, "ip link set dev " TAP_NAME " up");
+
+	ifindex = if_nametoindex(TAP_NAME);
+	if (!ASSERT_GT(ifindex, 0, "if_nametoindex"))
+		goto out;
+
+	skel->bss->shrink_ran = 0;
+
+	err = bpf_xdp_attach(ifindex, bpf_program__fd(skel->progs.xdp_shrink),
+			     0, NULL);
+	if (!ASSERT_OK(err, "bpf_xdp_attach"))
+		goto out;
+
+	memset(head, 0, sizeof(head));
+	memset(frag1, 0x41, sizeof(frag1));
+	memset(frag2, 0x42, sizeof(frag2));
+	eth->h_proto = htons(ETH_P_IP);
+
+	iov[0].iov_base = head;  iov[0].iov_len = sizeof(head);
+	iov[1].iov_base = frag1; iov[1].iov_len = sizeof(frag1);
+	iov[2].iov_base = frag2; iov[2].iov_len = sizeof(frag2);
+
+	n = writev(tap_fd, iov, ARRAY_SIZE(iov));
+	ASSERT_EQ(n, sizeof(head) + sizeof(frag1) + sizeof(frag2), "writev");
+
+	wait_for_prog(skel);
+	/* a buggy kernel only splats "page_pool leak", it does not fail here */
+	ASSERT_GT(skel->bss->shrink_ran, 0, "xdp_prog_ran");
+
+	bpf_xdp_detach(ifindex, 0, NULL);
+out:
+	if (tap_fd >= 0)
+		close(tap_fd);
+	netns_free(ns);
+}
+
+/*
+ * Both veth ends live in their own namespace, so the traffic really crosses
+ * the pair and nothing is created in the caller's namespace.
+ */
+static int veth_setup(char *ns0, char *ns1)
+{
+	if (!ASSERT_OK(append_tid(ns0, NS_NAME_MAX_LEN), "append_tid ns0"))
+		return -1;
+	if (!ASSERT_OK(append_tid(ns1, NS_NAME_MAX_LEN), "append_tid ns1"))
+		return -1;
+
+	SYS(fail, "ip netns add %s", ns0);
+	SYS(fail_ns0, "ip netns add %s", ns1);
+	SYS(fail_ns1, "ip -n %s link add %s mtu 8000 type veth peer name %s mtu 8000",
+	    ns0, VETH_LOCAL, VETH_PEER);
+	SYS(fail_ns1, "ip -n %s link set %s netns %s", ns0, VETH_PEER, ns1);
+	SYS(fail_ns1, "ip -n %s link set %s address %s", ns0, VETH_LOCAL,
+	    VETH_LOCAL_MAC);
+	SYS(fail_ns1, "ip -n %s addr add %s/24 dev %s", ns0, VETH_LOCAL_IP,
+	    VETH_LOCAL);
+	SYS(fail_ns1, "ip -n %s link set %s up", ns0, VETH_LOCAL);
+	SYS(fail_ns1, "ip -n %s addr add %s/24 dev %s", ns1, VETH_PEER_IP,
+	    VETH_PEER);
+	SYS(fail_ns1, "ip -n %s link set %s up", ns1, VETH_PEER);
+
+	return 0;
+
+fail_ns1:
+	SYS_NOFAIL("ip netns del %s", ns1);
+fail_ns0:
+	SYS_NOFAIL("ip netns del %s", ns0);
+fail:
+	return -1;
+}
+
+static void veth_cleanup(const char *ns0, const char *ns1)
+{
+	/* Dropping the namespaces takes the veth pair and its XDP programs. */
+	SYS_NOFAIL("ip netns del %s", ns1);
+	SYS_NOFAIL("ip netns del %s", ns0);
+}
+
+static int veth_attach(const char *ns, const char *dev, int prog_fd)
+{
+	struct nstoken *nstoken;
+	int ifindex, err;
+
+	nstoken = open_netns(ns);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		return -1;
+
+	ifindex = if_nametoindex(dev);
+	if (!ASSERT_GT(ifindex, 0, "if_nametoindex")) {
+		close_netns(nstoken);
+		return -1;
+	}
+
+	err = bpf_xdp_attach(ifindex, prog_fd, 0, NULL);
+	close_netns(nstoken);
+
+	return ASSERT_OK(err, "bpf_xdp_attach") ? 0 : -1;
+}
+
+/* A large ping builds a nonlinear skb that veth cow's into its page_pool. */
+static void test_veth(struct xdp_shrink_frags *skel)
+{
+	char ns0[NS_NAME_MAX_LEN] = "xdp_shrink_ns0-";
+	char ns1[NS_NAME_MAX_LEN] = "xdp_shrink_ns1-";
+
+	if (getpagesize() != PAGE_SIZE_4K) {
+		test__skip();
+		return;
+	}
+
+	if (veth_setup(ns0, ns1))
+		return;
+
+	skel->bss->shrink_ran = 0;
+
+	if (veth_attach(ns0, VETH_LOCAL, bpf_program__fd(skel->progs.xdp_shrink)))
+		goto out;
+
+	SYS_NOFAIL("ip netns exec %s ping -q -s 5000 -c 3 -W 1 %s",
+		   ns1, VETH_LOCAL_IP);
+
+	wait_for_prog(skel);
+	/* a buggy kernel only splats "page_pool leak", it does not fail here */
+	ASSERT_GT(skel->bss->shrink_ran, 0, "xdp_prog_ran");
+out:
+	veth_cleanup(ns0, ns1);
+}
+
+/*
+ * LOCAL cow's the incoming skb and returns XDP_TX, so the buff is turned into
+ * an xdp_frame and bounced to PEER, which shrinks a frag. The page_pool mem
+ * type the buff ran with must not reach the frame, or PEER frees a plain
+ * page (whose pp was already cleared on the XDP_TX side) as page_pool memory.
+ */
+static void test_veth_tx(struct xdp_shrink_frags *skel)
+{
+	char ns0[NS_NAME_MAX_LEN] = "xdp_shrink_tx0-";
+	char ns1[NS_NAME_MAX_LEN] = "xdp_shrink_tx1-";
+
+	if (getpagesize() != PAGE_SIZE_4K) {
+		test__skip();
+		return;
+	}
+
+	if (veth_setup(ns0, ns1))
+		return;
+
+	/*
+	 * LOCAL bounces everything (incl. ARP) with XDP_TX, so pin a static
+	 * neighbour to let the ping's payload actually reach it.
+	 */
+	SYS(out, "ip -n %s neigh add %s lladdr %s dev %s nud permanent",
+	    ns1, VETH_LOCAL_IP, VETH_LOCAL_MAC, VETH_PEER);
+
+	skel->bss->shrink_ran = 0;
+
+	if (veth_attach(ns0, VETH_LOCAL, bpf_program__fd(skel->progs.xdp_tx)))
+		goto out;
+	if (veth_attach(ns1, VETH_PEER, bpf_program__fd(skel->progs.xdp_shrink)))
+		goto out;
+
+	SYS_NOFAIL("ip netns exec %s ping -q -s 5000 -c 3 -W 1 %s",
+		   ns1, VETH_LOCAL_IP);
+
+	wait_for_prog(skel);
+	/* a buggy kernel only splats "page_pool leak", it does not fail here */
+	ASSERT_GT(skel->bss->shrink_ran, 0, "xdp_prog_ran");
+out:
+	veth_cleanup(ns0, ns1);
+}
+
+void test_xdp_shrink_frags(void)
+{
+	struct xdp_shrink_frags *skel;
+
+	skel = xdp_shrink_frags__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
+		return;
+
+	if (test__start_subtest("tun"))
+		test_tun(skel);
+	if (test__start_subtest("veth"))
+		test_veth(skel);
+	if (test__start_subtest("veth_tx"))
+		test_veth_tx(skel);
+
+	xdp_shrink_frags__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c b/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c
new file mode 100644
index 000000000000..5d8e26f1b3a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+int shrink_ran;
+
+SEC("xdp.frags")
+int xdp_shrink(struct xdp_md *ctx)
+{
+	/*
+	 * Runs on both skb-backed XDP paths (generic XDP via tun, and veth):
+	 * the nonlinear skb is cow'd into page_pool memory before we run, so
+	 * shrinking the tail releases a whole frag that has to go back to that
+	 * pool. The counter only tells us the program ran and the helper
+	 * succeeded -- a linear buff returns 0 as well -- it does not prove a
+	 * frag was released.
+	 */
+	if (bpf_xdp_adjust_tail(ctx, -3000) == 0)
+		__sync_fetch_and_add(&shrink_ran, 1);
+	return XDP_PASS;
+}
+
+SEC("xdp.frags")
+int xdp_tx(struct xdp_md *ctx)
+{
+	/*
+	 * Bounce the frame back. On veth this turns the buff into an
+	 * xdp_frame, which must not take over the page_pool mem type the
+	 * buff ran with.
+	 */
+	return XDP_TX;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.56.0

