Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BF3DA7C8;
	Sun, 20 Sep 2026 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789886156; cv=none; b=knVn+iov5egBfaa9NEzWlPECtUmDW5FEgcGCmjk2Cr6HXYvq7/hYRSQzesYNo82cUZVMKw4PxA2IU9w8eKqe7KQNBsAHW2bTAXf5voMZiyg+xgDX33bpxhVCWhkfIVgctPLJf2nXGULq54+nR+WRGUMoIBs6d/i/fUalvvmoE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789886156; c=relaxed/simple;
	bh=f3kEV6qCWROIy4is1IzV6l2A5scYFq8hQZHNNsWqp/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBwStihdFAApyW7poW1UXnKVM4MYrEH/LGIrgFJNGJ99aOBwbOuHVS0StPRIE9yQns+9iGCZPYO/qJ2PmGsDZrRb8dz4k/XLAY+9KWq8wwfQnX0JMsZDOXwDKNqjZYaJw5emUJo1BsjNOeTCpRllXxH8SDv8PywyOQy9SbUEUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LbO4g6Mp; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LbO4g6Mp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=h+
	Xk56gXA8V+uCWJm4Hp2x1B0l2K4jdoVWRG3XTXLjw=; b=LbO4g6MpuPBhySYxtq
	KYjGy6U1rl3Rlm8BJ06V/jgw6oWEe09AcqwYO6Yq3R4pyW2ILslcOUQNs4dsNKJi
	ATIgk8x3oPQXzHYBumlgFvI82M+caoiId7gR1c3r6ZI3wRmQV7DMSn9qP6CTVk1V
	0O1jksZrIjiMIjgylAH/nE5xI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3F8OCfq9qG42sBw--.49698S3;
	Sun, 20 Sep 2026 14:34:44 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	jolsa@kernel.org,
	ihor.solodrai@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Check bpf_skb_output() tracing restrictions
Date: Sun, 20 Sep 2026 14:34:42 +0800
Message-Id: <20260920063442.499577-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260920063442.499577-1-yangfeng59949@163.com>
References: <20260920063442.499577-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F8OCfq9qG42sBw--.49698S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy5JrW5AF48KF4rur45ZFb_yoW8uw13p3
	Wkt39xKrykXF42gw4fAa1xZwnIqa1kZrWYvr4Sqw1ayr43Xrs7XF1IkF4Ygw1fZr4UuryF
	vrW2gFW7Aw4kAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j12NtUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8gVHv2qvfoWOSgAA31

From: Feng Yang <yangfeng@kylinos.cn>

Add verifier coverage for the bpf_skb_output() tracing policy. Verify
that an fentry program can still use the helper, while the equivalent
fexit program is rejected at load time.

Signed-off-by: Yun Lu <luyun_611@163.com>
Signed-off-by: Feng Yang<yangfeng@kylinos.cn>
---
 .../bpf/progs/verifier_helper_restricted.c    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
index 889c9b78b912..058e71927cd5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 
 struct val {
@@ -17,6 +18,13 @@ struct {
 	__type(value, struct val);
 } map_spin_lock SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} perf_event_map SEC(".maps");
+
 SEC("kprobe")
 __description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_KPROBE")
 __failure __msg("program of this type cannot use helper bpf_ktime_get_coarse_ns")
@@ -165,4 +173,28 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("fentry/skb_tx_error")
+__description("bpf_skb_output is allowed in BPF_TRACE_FENTRY")
+__success
+int BPF_PROG(skb_output_fentry, void *skb)
+{
+	__u64 meta = 0;
+
+	bpf_skb_output(skb, &perf_event_map, BPF_F_CURRENT_CPU,
+		       &meta, sizeof(meta));
+	return 0;
+}
+
+SEC("fexit/skb_tx_error")
+__description("bpf_skb_output is forbidden in BPF_TRACE_FEXIT")
+__failure __msg("program of this type cannot use helper bpf_skb_output")
+int BPF_PROG(skb_output_fexit, void *skb)
+{
+	__u64 meta = 0;
+
+	bpf_skb_output(skb, &perf_event_map, BPF_F_CURRENT_CPU,
+		       &meta, sizeof(meta));
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

