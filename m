Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A793A2E25
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079184; cv=none; b=jMGEZpWJwBNJJznhBCLeBjgrUQ1qEwwkv7PA8b1Fuh2yG+SDyY/dR1vz32X9eipJOrdD+5vpTBFYxC9pdSqi+XcC0eXaOyBEh8MXqThEmgR5r8YOwN8Dk2p+L+m9JtfwdCuLUwtc/J7HwV18Xenf25OofbRdf1R/ALacMdh451E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079184; c=relaxed/simple;
	bh=1LwNYa0nsMkWi/VTO8ktSvbDoho+LWniLHNV/RoBPe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zt51tGI4H45sR/captep1/MNTu9ghb7UjsyHLl/YW7OoP+6eHam1PrSi/k0oLOVYHqS0G0E0b5FyBuyTDmWjZo1RkZKtic9o2WHCXM56X6SslEQueWvjf5d7lM72a4j7MSt8gO8Lt/JoSVrrq/XfiBtR1dHLqdvPT5mFsbUGkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhrL1R3h; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhrL1R3h"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so4641678a91.0
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 01:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079183; x=1781683983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3kEhRN8jP8NPUF2dXs8XkRxqkJ3rS6M1G7akkNNwjA=;
        b=EhrL1R3hdkqryyd3ucapXsWMPROpZzMH4iUhRLjXv8TgLGWeLR/WvY/GPTgo2xu4pW
         79nJRKn3ZOXY41JqoVRUriMH8ZGBP+JfN/HTgDisraMEHRb0XfJTrnn/pjSisn7c24te
         cxuDudj7V/iWuSzI3f9tpTncqFvGyz/PoduaSkBD9gVkAKIW/nHOenGNMRvjNe2dmtbj
         PJkdzQsXbpsECCqhrDlfXX5FvbkvROHNiqjF6whzD3EUYMBAEVcwKm4w16R9yuErdAgC
         TeoEs8jN9xBCxIrWIKObIm5J28ZcuyJKc/BzLyB4cYj4kMfIsHYKQGoiRYnGa+Z3/Im9
         ToVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079183; x=1781683983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v3kEhRN8jP8NPUF2dXs8XkRxqkJ3rS6M1G7akkNNwjA=;
        b=Ia/7Ey/TJoXTEvj7C8+BEhGIPD4Wzy/99leN2u+Ssgc7V2L6dnVRaoZNvAhtIVFjHl
         JS/xcQDYXQg+ZQ9qO2AssaE2GmTVxEaYEOC1MtVybJhEULxrQZP5aeHA24nmPZAfyaF1
         y6x0vLyTLbuohZr56GlXUGbrTZY+1xQx3+KsYfFNlwSA2Jt5JDDWCfRGixP+cONxSjjD
         u1Ai+mPDRbYOo9V3prgWL64HSxv3J39D+ESDM0a5XJzksd1039XuO6KprS1gfANVEUlg
         U17OEhNqwFsduX5SBcVq6wnLE4jXns3w+dF7cXL+Y8cJtiZU1rZ+kHhXaNUl7Ge3RcF1
         HpVg==
X-Forwarded-Encrypted: i=1; AFNElJ8tAzHt0S80vb09MFPC726lcZI1N0RzUHldwcD5Ap7LX3h/1Wlh5uhDQ7I2vMk6PCOE1Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaPjuSWN+t/b/CWVvLW4RdwXtLzK0sGwKqc7M/2cQ+l8knEAQ0
	kmq/cf2uBew+EF77WnJ84qQUA9y9DUs3qkVPEPHfScQ9lb0RjSgNU6uj
X-Gm-Gg: Acq92OEwLJmOrMs6yfGFvMyhqs4ZkFU5mNNBy5DsTxR/eDHQet+hniMT5GJ5F4G2C/K
	HPraQ3x9GGeMj2FVLdXaSrb7kdv+sIITB8aCBoEjxQg9n1HJKX2e5DG4x1o3h0RQpHfsK8iJ8WM
	k2EhqUKVW2iYrD2iGnnZhBH4A/t4qiDB4H3+/dMNMyaC7NZqhtmX/oU+Be+WAL3BEPD73SPzvxE
	HqoCFMMBuDuqM+a9gSCMcIP3SmHasF0UQi66nKUzfAHvrCn4AbjfFoel3sVJTlgVDk69dco67+N
	O0LCkqPlyh/XW48Sgkzye0hKiVIKtRDA5FxooHEaYsMlHm4mJ72UulqzFwR2ZlYn2yTPBrLwm2t
	B3x8ZbhpiHPYNc9y3Up7z6t5LZycmAWIIESoJs9EExq+uxdTkE/7hRxmdyEURHV0e63F22Sfjpz
	uFOrlJvCHSOFZ4mUAdnABheui0VDqVlUM8UVaah0J4m7pIl7Db9bOJUkSsypd4N0QDjiCSkQWn
X-Received: by 2002:a17:90b:2f0d:b0:368:3830:a8bd with SMTP id 98e67ed59e1d1-37131041514mr18542159a91.7.1781079182633;
        Wed, 10 Jun 2026 01:13:02 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37645c1aeb5sm1241003a91.2.2026.06.10.01.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:13:02 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: add test for bpf_msg_pop_data() overflow
Date: Wed, 10 Jun 2026 08:11:54 +0000
Message-ID: <20260610081218.506709-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
References: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test in sockmap_basic.c that calls bpf_msg_pop_data() with a length
close to U32_MAX, which overflows the start + len bounds check. The sk_msg
program records the return value over a sendmsg and the test checks that
the call is rejected with -EINVAL.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 48 +++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_pop_data.c     | 27 +++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index d2846579285f..cb3229711f93 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -14,6 +14,7 @@
 #include "test_sockmap_pass_prog.skel.h"
 #include "test_sockmap_drop_prog.skel.h"
 #include "test_sockmap_change_tail.skel.h"
+#include "test_sockmap_msg_pop_data.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
 #include "sockmap_helpers.h"
@@ -666,6 +667,51 @@ static void test_sockmap_skb_verdict_change_tail(void)
 	test_sockmap_change_tail__destroy(skel);
 }
 
+static void test_sockmap_msg_verdict_pop_data(void)
+{
+	struct test_sockmap_msg_pop_data *skel;
+	int err, map, verdict;
+	int c1 = -1, p1 = -1, sent;
+	int zero = 0;
+	char *buf;
+	const size_t len = 32 * 1024;
+
+	skel = test_sockmap_msg_pop_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	verdict = bpf_program__fd(skel->progs.prog_msg_pop_data);
+	map = bpf_map__fd(skel->maps.sock_map);
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out_close;
+
+	buf = calloc(len, 1);
+	if (!ASSERT_OK_PTR(buf, "calloc"))
+		goto out_close;
+
+	sent = xsend(c1, buf, len, 0);
+	ASSERT_EQ(sent, (ssize_t)len, "xsend");
+	ASSERT_EQ(skel->data->pop_data_ret, -EINVAL, "pop_data_rejects overflow");
+
+	free(buf);
+
+out_close:
+	close(c1);
+	close(p1);
+out:
+	test_sockmap_msg_pop_data__destroy(skel);
+}
+
 static void test_sockmap_skb_verdict_peek_helper(int map)
 {
 	int err, c1, p1, zero = 0, sent, recvd, avail;
@@ -1373,6 +1419,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap skb_verdict change tail"))
 		test_sockmap_skb_verdict_change_tail();
+	if (test__start_subtest("sockmap msg_verdict pop_data overflow"))
+		test_sockmap_msg_verdict_pop_data();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
 		test_sockmap_skb_verdict_peek();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek with link"))
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c b/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c
new file mode 100644
index 000000000000..301e65b95256
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sock_map SEC(".maps");
+
+#define POP_START 0x48a3
+#define POP_LEN   0xfffffffd
+
+long pop_data_ret = 1;
+
+SEC("sk_msg")
+int prog_msg_pop_data(struct sk_msg_md *msg)
+{
+	if (msg->size <= POP_START)
+		return SK_PASS;
+
+	pop_data_ret = bpf_msg_pop_data(msg, POP_START, POP_LEN, 0);
+	return SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

