Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE16372ECF
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284056; cv=none; b=SLXnwoGBfd0F3R6IjZnLHhSthjbs0XGnYxw5+48TXFaPwnfs7xsENTnNz5errf9dw+2r/KPM+fFC6dgkH39fQJy0ogluHIOgxgeXhfsb6VYOgSE7WWbsemo4mQAEppQWsMaDHYfSqT6meQ6cHklRMmEg2q7OEGqQWFIh1HhG/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284056; c=relaxed/simple;
	bh=hgRceoc8RziBHjbqU9BKeDZKjif6VQEiuRJ7pito8dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6g1XSsSlQCAYMrUQQfbJjhvOUolIwVjvfQiYYu6P+Pmjpj+ZT/IIqixQ816NOOj3ZFXIEesFFoLfKY0haTw/NFfyyeyLLpCoLVhbmryKGEK28XFijiqeM14wUmaZuQ9/A2AsaX9TdQGmvNbZNFJ3Ylln8uzWMltUMNEaFWurL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgMQZXkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgMQZXkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C891F000E9;
	Wed, 20 May 2026 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779284055;
	bh=MKWi8fkjd7A2mKQDKrrsUNf9h1FJhzb9N9FoCa/Tixw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EgMQZXkLAu/SJG72ezH4cqX/1+jHz4/eUK4QWd2ojdUNYM6EvU3+vBfhlQRDYl+WG
	 oNtdAdxMDKNMIIbegghVBQ2QtI9NUuthklaaq727ACJ1cFV9SJl59fV2Uycl7xzydn
	 clMrxsWD2po/Y39os3HUujuDkr6r6bvbOygTYp5dz2bL0KZ0pgImeX3mZHMysH40ed
	 pzmYIBwEd4NzaP+iLFuP08lBQ+YoDrKFcU/Qhmzub6LnT5xsDdp6guOKLbKkk+z8ZB
	 a+r7P/Ovzy7j4ivuunbFYN4IIhItS+quZxrdyYGy0wWyuWnSSPhNs8w94GFX/NpAWf
	 4WI8My05Q6Vqw==
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Filter timing outliers with IQR in batch-timing library
Date: Wed, 20 May 2026 06:33:32 -0700
Message-ID: <20260520133338.3392667-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133338.3392667-1-puranjay@kernel.org>
References: <20260520133338.3392667-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

System noise (timer interrupts, scheduling) can inflate the reported
stddev.  tcp-v4-syn showed stddev 37.86 ns without filtering vs
0.16 ns with filtering on the same run data.

Filter samples outside [Q1 - 1.5*IQR, Q3 + 1.5*IQR] before computing
statistics.  Scenarios with genuinely wide distributions have large IQR
so the fences stay wide and the filter has minimal effect.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/benchs/bench_bpf_timing.c   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
index 75a39da69655..e02ad324f7bc 100644
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

