Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D027B3A7F7E
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208620; cv=none; b=DDMBriJNa5fn/rAUIREZoEsBxN8UOQfS9GRK28EyBXRiiKKVcYadEwNAWonnxv9UN9z+VSmgH0BwGQsVvUpG4QVZSL+sTEzm1QrrhCaWcfelAfwh4MXQB6rTrvskLfB+I3IIv+tNaas+VeE6uiOxrKUvqUQxKjl6b1NX5MG4SDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208620; c=relaxed/simple;
	bh=+QkSivBhMDsmeTUlK0DamH9a7EJ3DdrUHCPR9Cfgr2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApeW8jlEbV1WpJEWI+7NKsauW9QVRNwtIi49K2w0cOD+z2CWD1cAovSbwSrHcmfI0KE9F6L8FtMlSWPwuZTyb8yHJskUxZx5TNsXzoG27qvI663pKn9A95YWxEQ1kfmagtIKgG7J8ax1FpjJLYRVN+Urqdij5KmaKc2qPx5rbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGxLYjlo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGxLYjlo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1630C2BCB3;
	Tue, 19 May 2026 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779208620;
	bh=+QkSivBhMDsmeTUlK0DamH9a7EJ3DdrUHCPR9Cfgr2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGxLYjloaalc6+IfMzFk1OhXrDme3ouqVyyDWkygnA567Lq+VmzvbD2Lsd4Hv1s8b
	 PQadKPwCMjjDN44MeZnnjeE17X5NG5npUy3HT1urNIkrIQRmxbqerEHh9jBp3VspOq
	 9AuwX+LLPgVP6IbG8mmpNkLNVqhla4QwU2WIrJOYup14+3IPgFuiTodjNTkWn5A4w3
	 EThkymPv0INYKSQEyK8ght2hyxpRnqu6afE5ha3Nu7C+jAdLVfL4UBSYt3J8F9HsFO
	 LNsvU0Me34roNE76fAkNpwW/I43ovhULUixAE5CFognOSgHnuQLe1dITKdyJfxhpmW
	 LPpEprD+Tp/vw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Fei Chen <feichen@meta.com>,
	Taruna Agrawal <taragrawal@meta.com>,
	Nikhil Dixit Limaye <ndixit@meta.com>,
	"Nikita V. Shirokov" <tehnerd@tehnerd.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 4/4] selftests/bpf: Filter timing outliers with IQR in batch-timing library
Date: Tue, 19 May 2026 09:36:32 -0700
Message-ID: <20260519163632.2220753-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519163632.2220753-1-puranjay@kernel.org>
References: <20260519163632.2220753-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

System noise (timer interrupts, scheduling) can produce outlier batch
samples that inflate the reported stddev.  For example, tcp-v4-syn
showed stddev 37.86 ns without filtering vs 0.16 ns with filtering on
the same run, because a handful of interrupt-hit batches dominated the
variance.

Apply IQR-based outlier filtering (1.5 * IQR fences) before computing
statistics.  Samples outside [Q1 - 1.5*IQR, Q3 + 1.5*IQR] are
discarded.  This removes system noise while preserving genuine
operational variance: scenarios with inherently wide distributions
(e.g., LRU-miss with eviction pressure) have large IQR, so their
fences are wide and the filter has minimal effect.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/benchs/bench_bpf_timing.c   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
index 081e2e860cb4..1c3a74807c1c 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
@@ -65,6 +65,31 @@ static int collect_samples(struct bpf_bench_timing *t,
 	return total;
 }
 
+static int filter_outliers_iqr(double *sorted, int n)
+{
+	double q1, q3, iqr, lo, hi;
+	int start = 0, end = n;
+
+	if (n < 8)
+		return n;
+
+	q1 = sorted[n / 4];
+	q3 = sorted[3 * n / 4];
+	iqr = q3 - q1;
+	lo = q1 - 1.5 * iqr;
+	hi = q3 + 1.5 * iqr;
+
+	while (start < end && sorted[start] < lo)
+		start++;
+	while (end > start && sorted[end - 1] > hi)
+		end--;
+
+	if (start > 0)
+		memmove(sorted, sorted + start, (end - start) * sizeof(double));
+
+	return end - start;
+}
+
 static void compute_stats(const double *sorted, int n,
 			  struct timing_stats *s)
 {
@@ -150,6 +175,7 @@ void bpf_bench_timing_report(struct bpf_bench_timing *t, const char *name, const
 		return;
 	}
 
+	total = filter_outliers_iqr(all, total);
 	compute_stats(all, total, &s);
 
 	if (t->machine_readable) {
-- 
2.53.0-Meta

