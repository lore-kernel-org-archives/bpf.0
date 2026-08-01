Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE7350285
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570409; cv=none; b=HxnDKG5XnZkYkEoFKKeg41LiHhucaXZuUaTw1OjHh/SdeRc50WP+R13D1EImgdRk1OfQBjVIaZcYcXzlvHSH9qPdJTHuZsxwS0THxDK//MuiuosxyZvTro+YBw+OJ4G7nu9AkByshWXFSPgFSYdD7xvNh4tW8Hj4SOZsQ/uAZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570409; c=relaxed/simple;
	bh=ALaemY/eXxfnRyItTlKyt20t5FCFf2oUoNhTrYMPUFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNapUypN5ABTgLFP1Ga5dyAcJzHoHnArpo8M58SCT40b0zjdWRcrBrarfFbbML8+/Ewk8UxGGlzvUFABYSQqK2N2IvZW+/x0WZ4Xdew+xdtnu/AVMO+pLb7orotxxNl4q0NDobQuy0W5Pmve+vvwC892SklxmD/ffHx5CtbpoMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGmMD9JR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGmMD9JR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cedda2ce6fso14621765ad.1
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570407; x=1786175207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rjhTHf2XLXNXzE77GZdDfci/SD/X5/txEVNM9cMJMUY=;
        b=CGmMD9JRsqxA2W5rKJPb/D6qTt5R3nceDDZR1l1dlLDLSd8ZqqQ49a5XnJqs1In+Ke
         i6tQlFStnumH4tusBFxq4NjQ7o5dpWDJrsCBpcu/1ShViIPpys9RxOqFxSV3wMX44aT+
         yLWEEi9nM80HG43KiAvTYWhksn63tbBrgu4o4mzP/LS3NiJoZvTjYYvXOBeW//9PBx9q
         2hDkO4H8D+Qg6hnRzjuhdyUnPu3zLe371fzlzh17PgUwGGtpnk7bcQnD+8LMHfIpLmgh
         iorVNRsQ/QJIuVSSYD7NKHW4MjGJA9/D2FG80bTRubtLZX8/ZjxrSRE7bPdyXulyHHez
         6hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570407; x=1786175207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rjhTHf2XLXNXzE77GZdDfci/SD/X5/txEVNM9cMJMUY=;
        b=nKUNIs2xPNd4dgeLieQQ+jrxfnI1qT6Jd8jZg7stjosWet1sf3ZjVBx5jUWNZt1lSP
         btEOw/y8XfBwQ/syTJgfLy/QfeBYUmD10GOxJS25ALXZa/iwyu2R2hlI0kWO2vgM0aCE
         vqlTDI6T7Aaz8Y9qD+1jJIMdGJcNIsnoN+ztbw08j4reHnQfmJFuhW1CsPJRsHtr/RaL
         sJ0ZmTToGnhO0YB+5wC0u7Tvd6lC7cVv+aQLBA9NJ4H4A87jMYnQONko86WPUWmoRzLi
         u+RTeJUmn6A+b/lhgCUTg5T32MWx9ZJB54MBnQ3x4cKVEd/yhRfyQyK5gqGDyM8ZMo+Y
         Bw5Q==
X-Gm-Message-State: AOJu0YxX2Yt8Fype7TuTh9oWNRTi8zDvjCRcv3myjie8wKALPThNv3O8
	9UbIZjwIwbKNqX1syudejb+V5knT7mPsMEYXXAuqL0fUa7sP3SGzaScQYrCioQ==
X-Gm-Gg: AR+sD13+ULw2VcwO8UFix6tg8b6vFK4ZPo5sZiih3mhOvikcBfiU6zsrjQuSa7D4334
	8HsoVUoB4vLrbgnWk07D5Ax9KuMZY7Ifg2U3dq3Eh6OcGNldk4ttsVd9EpDnYTZkID1vLV0ZrFL
	9JjRf2opWKSNMQUM1Cinp7psCDXyo5HOtTW4850rdUzTh8x/nt888P41Zremny4KMzKTp11Pals
	MJy+4l7EV50R+yvca82JmO6OQaRbmO8Xav7LuKeUGWwC+fdRG1c4+rJ/uv8QCTxX009pMjogJ2u
	yr5A7RFRWRzbQLP936CBFY58S7aNyetMOdb+uzBOlM58pikJJTWMAdx/vIEfTVbjv1r1HU5WRDI
	2OQZtae/STaH2AzhD89Ijmi+FmmGGukhVJPzmGs/f+Jai8FyM5rBW3p5DEqiBWQvm3r34BrRpDu
	iN4su7UxvRSwhFE9iQEh4auRBm4iyQz7UPQWtuNPBi4jCPBGn0wg==
X-Received: by 2002:a17:903:1b6c:b0:2c9:97a7:71af with SMTP id d9443c01a7336-2d05249c287mr25730165ad.42.1785570407534;
        Sat, 01 Aug 2026 00:46:47 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19fb5sm15066505ad.9.2026.08.01.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:47 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 07/18] selftests/bpf: Test map lookup result refinement
Date: Sat,  1 Aug 2026 00:46:22 -0700
Message-ID: <20260801074633.1595644-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A map-of-maps lookup value is refined to a map pointer (map_ptr_or_null)
at lookup time by refine_map_lookup_value(). Test that it is rejected
wherever a raw map value would be read as bytes, so the inner map
descriptor cannot leak.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_map_lookup_refine.c    | 73 +++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_map_lookup_refine.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index be97f6887f0e..41cd071d016a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -61,6 +61,7 @@
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
 #include "verifier_map_in_map.skel.h"
+#include "verifier_map_lookup_refine.skel.h"
 #include "verifier_map_ptr.skel.h"
 #include "verifier_map_ptr_mixing.skel.h"
 #include "verifier_map_ret_val.skel.h"
@@ -215,6 +216,7 @@ void test_verifier_liveness_exp(void)         { RUN(verifier_liveness_exp); }
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
 void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }
+void test_verifier_map_lookup_refine(void)    { RUN(verifier_map_lookup_refine); }
 void test_verifier_map_ptr(void)              { RUN(verifier_map_ptr); }
 void test_verifier_map_ptr_mixing(void)       { RUN(verifier_map_ptr_mixing); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_lookup_refine.c b/tools/testing/selftests/bpf/progs/verifier_map_lookup_refine.c
new file mode 100644
index 000000000000..c01abf54923d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_map_lookup_refine.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct inner_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} inner_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__array(values, struct inner_map);
+} outer_map SEC(".maps") = {
+	.values = { [0] = &inner_map },
+};
+
+SEC("?tc")
+__failure __msg("type=map_ptr_or_null expected=fp")
+int mapofmaps_value_as_kfunc_mem_buf(struct __sk_buff *skb)
+{
+	struct bpf_dynptr dptr;
+	__u32 key = 0;
+	void *inner;
+	char *p;
+
+	inner = bpf_map_lookup_elem(&outer_map, &key);
+	/* intentionally NOT NULL-checked: type is map_ptr_or_null */
+
+	bpf_dynptr_from_skb(skb, 0, &dptr);
+	/* arg3 is mem+size */
+	p = bpf_dynptr_slice(&dptr, 0, inner, 4);
+	if (p)
+		return p[0];
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("type=map_ptr_or_null expected=fp")
+int mapofmaps_value_as_helper_mem_buf(struct __sk_buff *skb)
+{
+	__u32 key = 0;
+	void *inner;
+
+	inner = bpf_map_lookup_elem(&outer_map, &key);
+	/* intentionally NOT NULL-checked: type is map_ptr_or_null */
+
+	/* arg1 is mem+size */
+	return bpf_csum_diff(inner, 4, NULL, 0, 0) + skb->len;
+}
+
+SEC("?tc")
+__failure __msg("type=map_ptr_or_null expected=fp")
+int mapofmaps_value_as_helper_fixed_mem(struct __sk_buff *skb)
+{
+	char th[sizeof(struct tcphdr)] = {};
+	__u32 key = 0;
+	void *inner;
+
+	inner = bpf_map_lookup_elem(&outer_map, &key);
+	/* intentionally NOT NULL-checked: type is map_ptr_or_null */
+
+	/* arg1 is fixed-sized mem */
+	return bpf_tcp_raw_check_syncookie_ipv4(inner, (void *)th);
+}
-- 
2.52.0

