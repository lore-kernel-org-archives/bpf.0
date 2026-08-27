Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985FC447814
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844593; cv=none; b=t8bcx6vvb6leaEYVnMY7IuVjsERYhKR0JMUjG/+NUvRPJJmUzAnchI3pX7Yi5J9MIzwy7dwYcVrCBuX4OvyOn3KwsOmPZXVOWyZPrqp+tC0Nhu3CY0JO6OyFJvJhftpTkmoS8imPpM8RW3BczTLR204eFWNseIS60LlGx199hI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844593; c=relaxed/simple;
	bh=R/Ui01qgIRjN7bDjKXgC7dfbkCtMdnPJD5VkqvscjH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oawzLRLn8ohFGBqYNd9/upPwrhf8vH0vkPjUyKi1Twu1ur6iB8yecOjZYYHJxM+aazBpchIPTnwyVimeKAnIOK2sCRuNidBlpXCEB0iM3yJqz2AQskTLUGOnWBJKeaWUgRfx1OCOp5TnK1DWfceL+GzwBr0+E55N1N5gCtnvqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfruOJQa; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfruOJQa"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb6573bd52so960639a34.3
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787844590; x=1788449390; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gbyhTAsM0ylOswgJ8ydy4xAK0p3Y0RBuTrl0mjOMCNE=;
        b=PfruOJQaA9bbJoZG/N+ybhjPINgIoAu1xT6ANA/bdXccyR07HNAhoxBP1NlB2+yL39
         YOT789Cr1GLtye+RO25qDqJt0xNzswJqnJAdXCW5HR+6MdFI9kEf0k4nYGP2/L2K0Ve3
         prDg7sD05QtdXRJnyWzN2WJJRw1jRe/n17oXblJ0g1Qxaw8uBxlsUjM1cLUU4lV9mqWp
         6BbqgCs/34EACOocFL7eElDoNakUlbzmLeYkg0U0p6LkiAa6fi2REJehFmjTTqVRiSjB
         lITRw2WrJI6HTstKSJVGIcZAg8lTDram+i+3ZW8HoPveMULQshbHBKA5d7oyYKGlVDRq
         vdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787844590; x=1788449390;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gbyhTAsM0ylOswgJ8ydy4xAK0p3Y0RBuTrl0mjOMCNE=;
        b=MlSRTNTbCnEfigvPK1C4yR8hUi2OnsHdtKHrl3Sv773Q4eWLaaEeGlxz6ipYt7hGf1
         TDF1RkqULvNd/EC+ke+hofO+DlT33dhI7AN2WPIt7aNEAWwblg8Oj42ayTnR+aJgBpCO
         nr5pRx75/3YLpiG86DIjM/s/HBnnfNLdPgzX2P6GAY6PNW5ihcdGfM7iaRkOno10MVkj
         H69R02tLq6FZoZcsSV3nVcWHqO+vDn1mC3IHFRVN6ZDCD+jo9yEsY379BpMiUpWge80v
         zEh89Aw7B7tJfwqC8lvg16b3r/Lp3JDMNQJKiFykhcg6aRsus9ahjxEy7qYRonJw5b/z
         fgNA==
X-Gm-Message-State: AFuF++kR232hXZI44IcQf9WxYAYv964o7LUZ6FnmQZ1yezMJlfEmKTtm
	b+AH0vCyp32DVmx3sK9FpnIIhmF0gj4DAkZ2uksKIJ6XfA0UB2qliSh/V6EqgFRr
X-Gm-Gg: AR+sD12keWwD/jYAsv9T8xIa9L4dAY+LOd8AUSSL1CXaod1rK1AUfOTs2DqFp+rmvDc
	cpvZI9/WmUjqG3vqH1p99s5AEHHKu/8W1ySLVaza5Yoj02mOUc3p71y+dsAyGjtF34xAsf+N+ai
	Aql02Xq6Antfd8YmGXagh80dya2z+OtDmuwysebkzm6F53MKtIGDhNTd/B4nOdVznf+7xPbVjrA
	OGM/Dv+MRSSndbYHx7CGyJY3oYbK6dFAA3QPjwDuV7FqAVod1lTLGhJI+nJcHV+L4qa5sVLH9H6
	7FN51kCyGrjNIldCZ0FuTkSzaqiOSGjRydtVPFGtqV6uJAiqGLJgqk7/zhy786VfH5j28B8lFtL
	QeRL914TznnlfGCPHihwV/gwbX1qhnRlQ5EN2OlZvEsR+8N+vIVDZejrFb28Cskq9Z6dcjTAt6K
	u0E+EbLvI8JfUWD7ug9BbsCuRLZYghgKYGrxc1Y6zfxT2WNqeTJTRmsVC/VY47
X-Received: by 2002:a05:6830:7007:b0:7f4:daae:401d with SMTP id 46e09a7af769-7f4f2314c08mr47106a34.8.1787844590176;
        Thu, 27 Aug 2026 08:29:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4f11f8c34sm172141a34.8.2026.08.27.08.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:29:49 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 27 Aug 2026 08:29:44 -0700
Subject: [PATCH bpf-next] bpftool: Print average cycles per program run in
 profiler
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
X-B4-Tracking: v=1; b=H4sIAOdXkGoC/x3M4QqDIBQG0Fe5fL8TzKCWrzKGpLtuQqhc2yiid
 x/sPMA50VgSN1g6IfxNLZUMS31HCO8lv1ilJyzBaDPqm5mUr3ErZXXhWLm5yuLkk9U89OMcgx+
 0n9ARqnBM+/+9w9eoMu8bHtf1A8DAHu9xAAAA
X-Change-ID: 20260827-bpftool_cyles_per_run-93169fcb30b7
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com, qmo@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787844587; l=3756;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=koiJp5sJ/hAp3PZH2YgCwq2buD/QWSdRQQwh7KcHtZY=;
 b=TDjZYguD+tSqSxp9uSDgA90cEjDAeLplPN+I6dcCCcpYgWVxN9ZjDxBgO1RC2WWVSzGa8aJSk
 GlnoBz8jxCICjBu7vt2H4laNw5GVpeOrAhqzHhxZalxkfZLBESuRU+p
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Total cycle counts are difficult to compare across workloads with
different run counts. Report cycles per run to expose the per-invocation
cost directly.

Example:
sudo ./bpftool prog profile name mprog duration 15 cycles instructions

            423256 run_cnt
         947413975 cycles              #  2238.39 cycles per run
         333965846 instructions        #     0.35 insns per cycle

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  6 ++++--
 tools/bpf/bpftool/prog.c                         | 18 +++++++++++-------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 90fa2a48cc26..2280dc4492c0 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
 bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
     Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
     user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
-    the profiling will run up to **UINT_MAX** seconds.
+    the profiling will run up to **UINT_MAX** seconds. When **cycles** is
+    selected, plain output also reports the average number of cycles per
+    program run.
 
 bpftool prog help
     Print short help message.
@@ -360,7 +362,7 @@ EXAMPLES
 ::
 
          51397 run_cnt
-      40176203 cycles                                                 (83.05%)
+      40176203 cycles          # 781.68 cycles per run                (83.05%)
       42518139 instructions    #   1.06 insns per cycle               (83.39%)
            123 llc_misses      #   2.89 LLC misses per million insns  (83.15%)
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a9f730d407a9..8935508f955b 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2069,9 +2069,9 @@ struct profile_metric {
 	bool selected;
 
 	/* calculate ratios like instructions per cycle */
-	const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
+	const int ratio_metric; /* 0 for run_cnt, 1 for index 0 (cycles) */
 	const char *ratio_desc;
-	const float ratio_mul;
+	const double ratio_mul;
 } metrics[] = {
 	{
 		.name = "cycles",
@@ -2080,6 +2080,9 @@ struct profile_metric {
 			.config = PERF_COUNT_HW_CPU_CYCLES,
 			.exclude_user = 1,
 		},
+		.ratio_metric = 0,
+		.ratio_desc = "cycles per run",
+		.ratio_mul = 1.0,
 	},
 	{
 		.name = "instructions",
@@ -2256,17 +2259,18 @@ static void profile_print_readings_plain(void)
 	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
 		struct bpf_perf_event_value *val = &metrics[m].val;
 		int r;
+		__u64 ratio;
 
 		if (!metrics[m].selected)
 			continue;
 		printf("%18llu %-20s", val->counter, metrics[m].name);
 
-		r = metrics[m].ratio_metric - 1;
-		if (r >= 0 && metrics[r].selected &&
-		    metrics[r].val.counter > 0) {
+		r = metrics[m].ratio_metric;
+		/* r == 0 is a special case for run_cnt */
+		ratio = r ? metrics[r - 1].val.counter : profile_total_count;
+		if (metrics[m].ratio_desc && ratio) {
 			printf("# %8.2f %-30s",
-			       val->counter * metrics[m].ratio_mul /
-			       metrics[r].val.counter,
+			       val->counter * metrics[m].ratio_mul / ratio,
 			       metrics[m].ratio_desc);
 		} else {
 			printf("%-41s", "");

---
base-commit: 23ff631b3b8b1452dfe933ee21f96321a9c5e209
change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

