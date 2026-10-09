Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4124F30CC
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791568105; cv=none; b=XG5cdVTrdHfL1wy8AD33sjPL60sFsdwLuFNfg9rTUOFw7xpyGZw6hNddV31XxQHqOXBxng7ZfmE3ALKhY8016HVLMMJG/X/rAZ9LaCR/Xj+1M1/eniGpRRdy8lsM1cMZ2YE9ZRR/8O0vTIljio2oyd8So6Lm5GmToSUVxDPHjy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791568105; c=relaxed/simple;
	bh=G06C5aUATOmcrADynMI536oFVbNg8OnKAEM+SR465rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSKo0aPfwWUoefjd2VsyiTLicypgwOCEPFJetv2e/jbdHDlGSzrGji8mD/c5QZw7AhwJ3Wvxe0uEMa7csUDHGxBctiBqetrca/wvJwOsNd+qAgknAfNQmfLVQY+vcPHGgCIJzMDHXeMms2lbQkUGC7NYkQLdmT6a8PZTNgSIzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GktQTKde; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GktQTKde"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5ba328513b9so4078084e87.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791568102; x=1792172902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K5vaYVFwLLngWpq3Z5O+W5okZzU1bzC9tm9Olt/FKzg=;
        b=GktQTKdeLUEIMlDoi/S6oB4dzsEE0nUmxbuI20ExqgHnw361RPo8P7Rvj/G8lu/+VJ
         1kw/OWHmwjecAaUuvol6ipfJRK+rOa9l43hTn0vt25JvU5cWsrWZu9/p3sNkL9XyBzRP
         /ZkwsfcFbbEJOm8QChUaz7rf8Gp3dbL8ewYPOSwJyNWz7XBg+BzwhHeZRuKc9p+M5azT
         ZyrD3EQaXXm7LHvWLBgFIzbGKt/pyiR8/7SEMuuFrXOXesgUJymm6L2DWFMLFOA+ATBm
         DOj/xd3grc5gw5QhsOUW1ELKbreC635RFeIrkONzhdl6LqCfvutPDf7qhQinfQBFTVj+
         HURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791568102; x=1792172902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K5vaYVFwLLngWpq3Z5O+W5okZzU1bzC9tm9Olt/FKzg=;
        b=BPbVj4ufL9bMTN8ROCpWUMxgJuXt/VjpRdkWdjamVckvrcAgjRdKTgiDsXLubKWpST
         A7+vtveF9m7lPfwMsxmyVo2XmtouTthxnJ1CoOwk2PzNuBrFWzGn+xPS5rbIqLy3eMmW
         +Y5vGsuX6PmF8Ma6bCq5ihbnL4vsvBlo6CSFtHpEQLZIN0I8yxvbdAz66xcPKguoJvde
         mK3t5l1uYpJ0ziZzsAVe41PsTenmWlgaREFuPWklwIUlcEX5IAA9t05kovQu8PDizCAb
         P6mlrBo33u+BS5VoUZ2h2+mB28A3Za/HParG2/0hHDkBoLf5Qde5Mhi7sTCEYqb3OUys
         ADhw==
X-Gm-Message-State: AFq9FYIykZBF5ReQbEwPt+ls7BQQvRMzLu0KuM/kPU8iNtAlNIrMxUgg
	MAOgIvEliQxtie7F2DZG/I6u84GPJtYOaImjaxwV5q+Uh2/yYBTwJpuxSOxMElIN/jk=
X-Gm-Gg: AYBFou3d8i7kFDuAdDspJvyxCFQJ3O5pcWYBWXTE1OJvtr0rW1XkrbmQHoX6QyO+bT6
	yT1Qlf1k0QA7FMxRknikjLD2xiAmbZO+eHxtzTBKayWiMBloMUdW69HTOndApR1TQVtVcZOAhEE
	VM5LsklSloLhNSfrysZRu0fQ0NuufP72d5nhbZ9t+12KwmXCiE5340HhMTdaekkyjOLPtFM7uV4
	6u/SZgR1LLjqpAwNLAFWjz1Zp6nIlm6nWmoxqnS8vHMtjt1Rm8b2MpEndv0P91zEWyJRGECKGNQ
	ppp02/Fs8DuFWjDYYXwQeBjcMG7DG051rJWUATAast5MQzbMNk1ra1u/GjVCJ3dz2Gwt8gXEMj3
	pxApwcBCJN7k9GABFF3VL+PlaayMyb/KLakW6SsBpfWR8nNwRgHdZ2PstqEFTTL2dVFEevJflXe
	8Sm6rJBaQPUBNEwQ8IEyhTJgDtSEwm+cm7nqIdZ5pK6XPAaSIOblMruAA70BG+FnweDfgcDwYSz
	4ZpIV5Qxt/LrR0GnZJppW5MLVpxO500AuOsoEDKhTfz5x4uSNyr
X-Received: by 2002:a05:6512:340e:b0:5b6:31c:bb0c with SMTP id 2adb3069b0e04-5bcde35222amr856659e87.9.1791568102256;
        Fri, 09 Oct 2026 10:48:22 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcddeb5604sm852635e87.63.2026.10.09.10.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:48:21 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover test_run csum validation after bpf_skb_change_tail()
Date: Fri,  9 Oct 2026 20:47:48 +0300
Message-ID: <20261009174755.22026-3-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009174755.22026-1-skokovmaksimevg@gmail.com>
References: <20261009174755.22026-1-skokovmaksimevg@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_F_TEST_SKB_CHECKSUM_COMPLETE tests for tc programs that move the
skb out of CHECKSUM_COMPLETE with bpf_skb_change_tail():

- change_tail_trim trims the last 4 bytes of pkt_v4. They hold the
  non-zero tcp.urg_ptr, so the stale skb->csum no longer matches the
  packet.
- change_tail_grow_write appends 4 zero bytes, which on their own do
  not change the sum, and then writes a byte with BPF_F_RECOMPUTE_CSUM.
  That write can no longer update skb->csum.

Both return -EBADMSG without the preceding test_run fix and pass with
it.

Also add store_no_recompute as a negative test. It writes a byte
without BPF_F_RECOMPUTE_CSUM, so the skb stays CHECKSUM_COMPLETE with a
stale skb->csum, and test_run must keep returning -EBADMSG. This checks
that the validation still runs for CHECKSUM_COMPLETE skbs. The passing
case, a CHECKSUM_COMPLETE skb whose checksum is updated correctly, is
already covered by test_skb_pkt_end.

Assisted-by: LLM
Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
---
 .../bpf/prog_tests/skb_csum_complete.c        | 39 ++++++++++++++++
 .../selftests/bpf/progs/skb_csum_complete.c   | 46 +++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skb_csum_complete.c
 create mode 100644 tools/testing/selftests/bpf/progs/skb_csum_complete.c

diff --git a/tools/testing/selftests/bpf/prog_tests/skb_csum_complete.c b/tools/testing/selftests/bpf/prog_tests/skb_csum_complete.c
new file mode 100644
index 0000000000000..919f24dbacd3d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/skb_csum_complete.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "skb_csum_complete.skel.h"
+
+static void run(struct bpf_program *prog, int expected_err)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+		.flags = BPF_F_TEST_SKB_CHECKSUM_COMPLETE,
+	);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
+	if (!ASSERT_EQ(err, expected_err, "test_run"))
+		return;
+	if (!expected_err)
+		ASSERT_EQ(topts.retval, 0, "retval");
+}
+
+void test_skb_csum_complete(void)
+{
+	struct skb_csum_complete *skel;
+
+	skel = skb_csum_complete__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	if (test__start_subtest("change_tail_trim"))
+		run(skel->progs.change_tail_trim, 0);
+	if (test__start_subtest("change_tail_grow_write"))
+		run(skel->progs.change_tail_grow_write, 0);
+	if (test__start_subtest("store_no_recompute"))
+		run(skel->progs.store_no_recompute, -EBADMSG);
+
+	skb_csum_complete__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/skb_csum_complete.c b/tools/testing/selftests/bpf/progs/skb_csum_complete.c
new file mode 100644
index 0000000000000..644731a12dc87
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/skb_csum_complete.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("tc")
+int change_tail_trim(struct __sk_buff *skb)
+{
+	/*
+	 * Drops CHECKSUM_COMPLETE. skb->csum still covers the trimmed bytes,
+	 * which hold the non-zero tcp.urg_ptr of pkt_v4, so it no longer
+	 * matches the packet.
+	 */
+	if (bpf_skb_change_tail(skb, skb->len - 4, 0))
+		return 1;
+	return 0;
+}
+
+SEC("tc")
+int change_tail_grow_write(struct __sk_buff *skb)
+{
+	__u8 val = 0xab;
+
+	/*
+	 * Drops CHECKSUM_COMPLETE. The new bytes are zero and do not change
+	 * the sum, but the write below can no longer update skb->csum.
+	 */
+	if (bpf_skb_change_tail(skb, skb->len + 4, 0))
+		return 1;
+	if (bpf_skb_store_bytes(skb, skb->len - 1, &val, sizeof(val),
+				BPF_F_RECOMPUTE_CSUM))
+		return 2;
+	return 0;
+}
+
+SEC("tc")
+int store_no_recompute(struct __sk_buff *skb)
+{
+	__u8 val = 0xab;
+
+	/* skb stays CHECKSUM_COMPLETE, but skb->csum is not updated. */
+	if (bpf_skb_store_bytes(skb, skb->len - 1, &val, sizeof(val), 0))
+		return 1;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3

