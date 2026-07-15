Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36C73D6475;
	Wed, 15 Jul 2026 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151678; cv=none; b=tOL7fLxOih1Eo/0xA4Crc25aaq/S0ONgjl7lykbMSXgo+hyOJ1rp27KqTMncN6RilDKi5wQI9XtjKndM0B9OwD+ajWdnQSS3GSkfK6sPx9GvjmGgvlsH9G4sLNJcQTpGHHwxRoijhKo6mrpphJonQlt3d79axvoazfjB3z1AdbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151678; c=relaxed/simple;
	bh=gHc9UsUwUPBw5xhLhDweYHveTm4IM/ZXyQ3l0XZyXGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTG6N39t4p4OJeWQpCLZNCBiUWMBC31o1iXfSvsc/qlDT3KZBJdkZHRelCQfmEaK6YNFyLB0Hwd5On9Or/HGdOHe3iKrn9Q3Vqf9WJFw+9IdmKiD6d0DhmFbfiLPvh+3S5ukifMuS3DNe2fXB9JDSfsltdAa+2DqarWBbhLLsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od3r5g3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od3r5g3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35F01F00A3A;
	Wed, 15 Jul 2026 21:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151676;
	bh=3UpMsD8XOoD4Z4HhPClQN9erIi/Ae2Mgk4+JNrwqu08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Od3r5g3IbTurvkBpiqHU4K2v8l2oIX7E5cbBpnZyri1tZWoi0asmo5JojXttAD4MM
	 eGK0QFcQ4/O1LhSzgZuaeQGUSdMTHB24lJQwumXb6nauPnv/5DkZ+1OX01tfTSpOZ2
	 J1JQ0ngHZ4fOKiQikmg88cis23t3LJXtoX5TTcj5Y3WPdeTknMgUt3aCpQtGTcCV6I
	 Yte/tvdmU856wRwF0dbeBIHVVcwVc9k/9/LWrek3rqi5VX6F+lRa4DVeRub7AGXaeH
	 Mkeb9kWkEqVqkOh9OPXy54t3rVB+sFchiktrEwvH7a00I0YQubJqo/JMOe5But3yiH
	 l4jf6MvKTTpzg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jul 2026 23:39:47 +0200
Subject: [PATCH bpf-next v5 7/8] selftests/bpf: Add test for
 bpf_skb_rx_checksum kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-bpf-xdp-meta-rxcksum-v5-7-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Vladimir Vdovin <deliran@verdict.gg>, 
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

Add a selftest for the newly added bpf_skb_rx_checksum() kfunc.
The test consists of a TC BPF program that calls the kfunc and
records which checksum type each packet has in a per-type counter
map, and a userspace test runner that exercises two scenarios:

- csum_none: runs with bpf_prog_test_run_opts (no special flags),
  verifies all packets are reported as CHECKSUM_NONE.
- csum_complete: runs with BPF_F_TEST_SKB_CHECKSUM_COMPLETE flag,
  verifies all packets are reported as CHECKSUM_COMPLETE.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h           |  8 ++++
 .../selftests/bpf/prog_tests/skb_rx_checksum.c     | 50 ++++++++++++++++++++++
 .../testing/selftests/bpf/progs/skb_rx_checksum.c  | 33 ++++++++++++++
 tools/testing/selftests/bpf/skb_rx_checksum.h      |  8 ++++
 4 files changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index ae71e9b69051..d03572e26df2 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -64,6 +64,14 @@ struct bpf_tcp_req_attrs;
 extern int bpf_sk_assign_tcp_reqsk(struct __sk_buff *skb, struct sock *sk,
 				   struct bpf_tcp_req_attrs *attrs, int attrs__sz) __ksym;
 
+/* Description
+ *  Read skb RX checksum info (ip_summed and csum_meta).
+ * Returns
+ *  0 on success
+ */
+extern int bpf_skb_rx_checksum(struct __sk_buff *skb, __u32 *ip_summed,
+			       __u32 *csum_meta) __ksym;
+
 void *bpf_cast_to_kern_ctx(void *) __ksym;
 
 extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
diff --git a/tools/testing/selftests/bpf/prog_tests/skb_rx_checksum.c b/tools/testing/selftests/bpf/prog_tests/skb_rx_checksum.c
new file mode 100644
index 000000000000..d71ab7c70b68
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/skb_rx_checksum.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "skb_rx_checksum.skel.h"
+#include "skb_rx_checksum.h"
+
+#define TX_PACKETS 3
+
+static int run_test(__u32 flags, enum skb_csum expected_csum)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = TX_PACKETS,
+		.flags = flags,
+	);
+	int prog_fd, err, key = expected_csum;
+	struct skb_rx_checksum *skel;
+	__u64 cnt;
+
+	skel = skb_rx_checksum__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return -1;
+
+	prog_fd = bpf_program__fd(skel->progs.tc_rx_csum);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(topts.retval, 0, "retval"))
+		goto cleanup;
+
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.csum_cnt), &key, &cnt);
+	if (!ASSERT_OK(err, "map_lookup"))
+		goto cleanup;
+
+	ASSERT_EQ(cnt, TX_PACKETS, "csum_cnt");
+cleanup:
+	skb_rx_checksum__destroy(skel);
+	return 0;
+}
+
+void test_skb_rx_checksum(void)
+{
+	if (test__start_subtest("csum_none"))
+		run_test(0, SKB_CSUM_NONE);
+
+	if (test__start_subtest("csum_complete"))
+		run_test(BPF_F_TEST_SKB_CHECKSUM_COMPLETE, SKB_CSUM_COMPLETE);
+}
diff --git a/tools/testing/selftests/bpf/progs/skb_rx_checksum.c b/tools/testing/selftests/bpf/progs/skb_rx_checksum.c
new file mode 100644
index 000000000000..dc4e192905d5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/skb_rx_checksum.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+#include "skb_rx_checksum.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, SKB_CSUM_PARTIAL);
+	__type(key, __u32);
+	__type(value, __u64);
+} csum_cnt SEC(".maps");
+
+SEC("tc")
+int tc_rx_csum(struct __sk_buff *skb)
+{
+	enum skb_csum ip_summed;
+	__u32 csum_meta;
+	__u64 *cnt;
+
+	bpf_skb_rx_checksum(skb, &ip_summed, &csum_meta);
+	if (ip_summed < SKB_CSUM_PARTIAL) {
+		cnt = bpf_map_lookup_elem(&csum_cnt, &ip_summed);
+		if (cnt)
+			__sync_fetch_and_add(cnt, 1);
+	}
+
+	return TC_ACT_OK;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/skb_rx_checksum.h b/tools/testing/selftests/bpf/skb_rx_checksum.h
new file mode 100644
index 000000000000..60aad3561843
--- /dev/null
+++ b/tools/testing/selftests/bpf/skb_rx_checksum.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+enum skb_csum {
+	SKB_CSUM_NONE		= 0,
+	SKB_CSUM_UNNECESSARY	= 1,
+	SKB_CSUM_COMPLETE	= 2,
+	SKB_CSUM_PARTIAL	= 3,
+};

-- 
2.55.0

