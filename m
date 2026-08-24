Received: from mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC384370D7B
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 03:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787540878; cv=none; b=H5zW9IYaL87SKUlu9gpn8FwAZv47iRiJ8WbjsdZt/SwXTpRroDXSHzy61c2gNWFrAI/G4ZBQsRRMso4fWYJGYHMrUvbp+v3utn04WXK/Fi6IBFHdsvSVsUT8le+jl2J2SPfSVFtciAKmOTv0zh1uGx0RDIPedUzDVgb4dcpBlEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787540878; c=relaxed/simple;
	bh=l7q9NfVO33RZqDNAKsacw9ostqtqL107XpOn/D3Gino=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6Fdbs6ruNbNXQLtemay5jxhiVHjZTSAk7z+9yEvPqRfNpf7NrTNl8c98Q2Uk0oYJfxACpLdklP8NriVIgGvSHlGX90KuWUS5ZU7/5ACMvUCaCFbulu3mCiyWs6tlTQRRQeJAgsNZ3/zoRpcJnuOn8JNMCckEVS6QQ+76m2Ym3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sBC/p/Zm; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sBC/p/Zm"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=l7q9NfVO33RZqDNAKsacw9ostqtqL107XpOn/D3Gino=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787540874; v=1; x=1788145674;
 b=sBC/p/Zmy3X6F48m5J1DBLnzJ8cQirkwBiVcZJdAI2I0czt6PXjlQX6SGrscHVKEiFdaDPsk
 Ieh3VI/YselGoGMmoG1cuCsFADFiAYs5Vb67SvvmXr5uj8MNMF/cNL58ipvGNvgWaJlbjUl/CaC
 tIfWsWl0KcyaR+9IoEQzOLZM=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.0)
	by smtp.migadu.com with ESMTPS id ab67b601b70d2fa5;
	Mon, 24 Aug 2026 03:07:54 +0000
X-Mizu-Trace-ID: ab67b601b70d2fa5
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: add xdp_shrink_frags
Date: Mon, 24 Aug 2026 11:06:44 +0800
Message-ID: <20260824030705.266049-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824030705.266049-1-jiayuan.chen@linux.dev>
References: <20260824030257.263179-1-jiayuan.chen@linux.dev>
 <20260824030705.266049-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that attaches an xdp.frags program which shrinks a whole frag
away, so bpf_xdp_shrink_data() frees a page_pool frag.

test_tun triggers the page-type mismatch on the generic XDP path.
test_veth triggers the same mismatch on the veth path.

Both reproduce "Bad page state ... page_pool leak" on a buggy kernel.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../bpf/prog_tests/xdp_shrink_frags.c         | 163 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_shrink_frags.c    |  23 +++
 2 files changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_shrink_frags.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
new file mode 100644
index 000000000000..f3d8a84a6dc9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
@@ -0,0 +1,163 @@
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
+#define VETH_LOCAL	"xdp_shrinkA"
+#define VETH_PEER	"xdp_shrinkB"
+#define VETH_NETNS	"xdp_shrink_veth"
+#define VETH_LOCAL_IP	"10.9.9.1"
+#define VETH_PEER_IP	"10.9.9.2"
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
+		return -1;
+
+	err = ioctl(fd, TUNSETIFF, &ifr);
+	if (err) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+/*
+ * Similar to flow_dissector.c: writev() an IFF_NAPI_FRAGS tap to build a
+ * nonlinear skb (sized for 4K pages, like xdp_adjust_tail.c) that tun runs
+ * through do_xdp_generic().
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
+	usleep(100 * 1000);
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
+ * A large ping builds a nonlinear skb that veth cow's into its page_pool
+ * (sized for 4K pages, like xdp_adjust_tail.c) before running the program.
+ */
+static void test_veth(struct xdp_shrink_frags *skel)
+{
+	int ifindex, err;
+
+	SYS(out, "ip netns add " VETH_NETNS);
+	SYS(out_ns, "ip link add %s mtu 8000 type veth peer name %s mtu 8000",
+	    VETH_LOCAL, VETH_PEER);
+	SYS(out_link, "ip link set " VETH_PEER " netns " VETH_NETNS);
+	SYS(out_link, "ip addr add " VETH_LOCAL_IP "/24 dev " VETH_LOCAL);
+	SYS(out_link, "ip link set " VETH_LOCAL " up");
+	SYS(out_link, "ip -n " VETH_NETNS " addr add " VETH_PEER_IP "/24 dev " VETH_PEER);
+	SYS(out_link, "ip -n " VETH_NETNS " link set " VETH_PEER " up");
+
+	ifindex = if_nametoindex(VETH_LOCAL);
+	if (!ASSERT_GT(ifindex, 0, "if_nametoindex"))
+		goto out_link;
+
+	skel->bss->shrink_ran = 0;
+
+	err = bpf_xdp_attach(ifindex, bpf_program__fd(skel->progs.xdp_shrink),
+			     0, NULL);
+	if (!ASSERT_OK(err, "bpf_xdp_attach"))
+		goto out_link;
+
+	SYS_NOFAIL("ip netns exec " VETH_NETNS
+		   " ping -q -s 5000 -c 3 -W 1 " VETH_LOCAL_IP);
+
+	ASSERT_GT(skel->bss->shrink_ran, 0, "xdp_prog_ran");
+
+	bpf_xdp_detach(ifindex, 0, NULL);
+out_link:
+	SYS_NOFAIL("ip link del " VETH_LOCAL);
+out_ns:
+	SYS_NOFAIL("ip netns del " VETH_NETNS);
+out:
+	return;
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
+
+	xdp_shrink_frags__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c b/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c
new file mode 100644
index 000000000000..62e3791ac81d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c
@@ -0,0 +1,23 @@
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
+	 * The program is loaded with BPF_F_XDP_HAS_FRAGS (xdp.frags), so a
+	 * nonlinear skb entering generic XDP is cow'd into page_pool memory
+	 * before we run. Shrinking the tail far enough releases at least one
+	 * whole frag, which must be returned to its page_pool. Count only a
+	 * successful shrink so a too-small frame (e.g. ARP) does not satisfy
+	 * the test.
+	 */
+	if (bpf_xdp_adjust_tail(ctx, -3000) == 0)
+		__sync_fetch_and_add(&shrink_ran, 1);
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

