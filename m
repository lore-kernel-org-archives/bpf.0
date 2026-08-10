Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4B388862
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 05:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338479; cv=none; b=mSnHPGUjMSmRU6s9URudec6z/8CNmIgOUiaIXaDkOQsdXv7Ke9xencpTBazD1GZrrjzSzpvAHASwFpN1+2oCDx2FNsnYP4GmceyItByhKaQOR/oJgOKILPnmD3OaW2++IKigW54S1mW4WYVIZV5nBJuwrwPmzUCYS/6rzQApOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338479; c=relaxed/simple;
	bh=+YSbpdbT+Zge2HjdLE2Zq2WHeNNB187uBYIbE44yNzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkWh+bwdrzy66Ju2ZJZPh7VYQbNm5pfSj4AehzTblAGoTI/Plr6T5/fvndENBHvVLKmdpPfDmD7IdvB/jALoSo78MLQD4SIaIywEA9Sk32WSnAorb8B9Tl1pENJPZ5WAUsTba8xxeKpGzOX6JMVGrpfOfjs9VQYZr93LrRrdVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sSxaY8kt; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sSxaY8kt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786338474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rcfqxJg8M6JJRKe48ru/DMT5hmYQqatFee02hdYv+k=;
	b=sSxaY8ktCP9jwlWUWN8nFQNsmzJ2zXFXK6h+PkAiUNdkuM90PXG/gEgI6EN0Kb2qZIiBfc
	vURmzeraQ+fsynY+iWbkvR3u/TfhQart++AKz5JQBSqEeeBc0Jo9vxvHrPA2iIAd6xU3xQ
	tnIY6Du2MhloWtEU/711axZA0D7J7K8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: xdp: test dev_xdp_install() rejects device-bound program
Date: Mon, 10 Aug 2026 13:06:01 +0800
Message-ID: <20260810050621.82035-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260810050621.82035-1-jiayuan.chen@linux.dev>
References: <20260810050621.82035-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bpf_xdp_link_update() used to skip the checks in dev_xdp_attach(). Add a
test that makes a generic XDP link with a normal program and then tries
to swap in a device-bound program, which must fail.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../bpf/prog_tests/xdp_dev_bound_only.c       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
index 7dd18c6d06c6..4a13f8ec4300 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <net/if.h>
+#include <linux/if_link.h>
 #include <test_progs.h>
 #include <network_helpers.h>
 
 #define LOCAL_NETNS "xdp_dev_bound_only_netns"
+#define LINK_UPDATE_NETNS "xdp_dev_bound_only_lu_netns"
 
 static int load_dummy_prog(char *name, __u32 ifindex, __u32 flags)
 {
@@ -59,3 +61,50 @@ void test_xdp_dev_bound_only_offdev(void)
 	 */
 	SYS_NOFAIL("ip netns del " LOCAL_NETNS);
 }
+
+/* A device-bound program must not run on the XDP software path.
+ * dev_xdp_attach() rejected such programs, but bpf_xdp_link_update() reaches
+ * dev_xdp_install() directly and bypasses it, so the check has to live in
+ * dev_xdp_install(). Create a generic (SKB) XDP link with a normal program,
+ * then try to swap in a device-bound program via BPF_LINK_UPDATE.
+ */
+void test_xdp_dev_bound_only_link_update(void)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, lopts, .flags = XDP_FLAGS_SKB_MODE);
+	int base_fd = -1, devbound_fd = -1, link_fd = -1;
+	struct nstoken *tok = NULL;
+	__u32 ifindex;
+	int err;
+
+	SYS(out, "ip netns add " LINK_UPDATE_NETNS);
+	tok = open_netns(LINK_UPDATE_NETNS);
+	if (!ASSERT_OK_PTR(tok, "open_netns"))
+		goto out;
+
+	SYS(out, "ip link add eth42 type veth");
+	ifindex = if_nametoindex("eth42");
+	if (!ASSERT_NEQ(ifindex, 0, "if_nametoindex"))
+		goto out;
+
+	devbound_fd = load_dummy_prog("devbound", ifindex, BPF_F_XDP_DEV_BOUND_ONLY);
+	if (!ASSERT_GE(devbound_fd, 0, "load_dummy_prog devbound"))
+		goto out;
+
+	base_fd = load_dummy_prog("base", 0, 0);
+	if (!ASSERT_GE(base_fd, 0, "load_dummy_prog base"))
+		goto out;
+
+	link_fd = bpf_link_create(base_fd, ifindex, BPF_XDP, &lopts);
+	if (!ASSERT_GE(link_fd, 0, "bpf_link_create"))
+		goto out;
+
+	err = bpf_link_update(link_fd, devbound_fd, NULL);
+	ASSERT_EQ(err, -EINVAL, "link_update device-bound rejected");
+
+out:
+	close(link_fd);
+	close(base_fd);
+	close(devbound_fd);
+	close_netns(tok);
+	SYS_NOFAIL("ip netns del " LINK_UPDATE_NETNS);
+}
-- 
2.43.0

