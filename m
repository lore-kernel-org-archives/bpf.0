Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB76346AF1;
	Tue, 22 Sep 2026 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042152; cv=none; b=p2A4ezGPkIcmwh/LtyAft/E6eYCwdM2XtkVsallGWxDQXv+E01o86bLki0vjyubI5qbUAyhhCOdWAlvyQMnH4BZG8xDQ7Eabd4kflRfaiGxvYMTEitI6DsrwhdC3I//rcDs4naZhtIj6ywFewuBNJpqVczkIG1IV9awabPDHSZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042152; c=relaxed/simple;
	bh=KjrrirkHh7s6Th3uYt6RMQMAte7+5cGYK9DDiw9vzHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hs/Ervuaesg+arFJc7EyElKFjCblnE1YHCHBT3JvIpJedwxSWz0Fe9VYlbroTNBGm1xDmNxOyGQAX8KdApElHL8u24YV/rUhgaMekJ2+2Tt7ie1X5HUYFjZVaAj2upafqrwr1pYDGXppurrwW5wJ5+rqonnehNT6GU6DOTROFsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VQnIwWLt; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VQnIwWLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=e/
	VNVp+m9ZzMo9CqtPYa18G/dTpf3BBtlGLFT6fk6/I=; b=VQnIwWLt6cNFAC6zF5
	73s8czRzD7SQVisZq3Q6V9ZaGBBYQcJIGeJQQ+h8nbPCNY4XNEgEPDeSUzcXmjd/
	3VG3bvy8a6eiB39ct1NINgEw5NDfKc7iFtKPWdZ88qoV1ylLk4cHUHvbQwz5canb
	XxEyfztjqpe/KvGEEzzO7cy9M=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3_5fJ37FqaxQMAA--.8898S3;
	Tue, 22 Sep 2026 09:54:22 +0800 (CST)
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
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Check bpf_skb_output() tracing restrictions
Date: Tue, 22 Sep 2026 09:54:17 +0800
Message-Id: <20260922015417.130869-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260922015417.130869-1-yangfeng59949@163.com>
References: <20260922015417.130869-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_5fJ37FqaxQMAA--.8898S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy5JrW5ArW8Cw47Xr48tFb_yoW8uw1xp3
	Wvy39Ikr97XF42gw4fAa18ZwnIqw4kZrW5Zr4Sqw1ayr43Xrs2qF1xCF45Ww1fZr4UuryF
	vrW2gFWUAw4kAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j12NtUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8Q4yqmqx386HjQAA3n

From: Feng Yang <yangfeng@kylinos.cn>

Add verifier coverage for the bpf_skb_output() tracing policy. Verify
that an fentry program can still use the helper, while the equivalent
fexit program is rejected at load time.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
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
2.27.0

