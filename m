Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0822E0B5C
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683879; cv=none; b=eml2HD7EUnHgDv3usQMSEuu68aQt4aCYpx2wbtH3pUDml0ZzlU83zYr6yPOW+vFX4vaLev8/GhPSFtZbaWLhosouZHrF122dsENt4Ux3NhFUwhcvHRJPExmRMhU8z/hI15MSk92EHq7F4UH5UsUpJRWP+5jSy77F3LmKa4qpsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683879; c=relaxed/simple;
	bh=h8T+fIQB2+jtiqEk8xNdHzgq7bHjfVRc1h+JcNvygew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUv3liWUhWNbsu4r6IelgGPP+wTbepn4VMVa4Cqpja4bO4E6RRO4tEYXfx9WSarWbKQH386RNcKsqSeCz3hhj0fWS1q9V9gbbsUzyxdD5FrpU6SjvYryf68/U7GU79fG5adCStYbbSnWAdxMGPfXustifbKDpZFRMiPVmiUaGes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZlmeGOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZlmeGOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EAAC19425;
	Mon, 20 Apr 2026 11:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776683879;
	bh=h8T+fIQB2+jtiqEk8xNdHzgq7bHjfVRc1h+JcNvygew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZlmeGOag4FogvA32Zt+0s83JeXZsPe/Duop87suBz176JMpRz1yDNiPBS1qgAHqu
	 e9ekB+EJrK4qzlVyYAwe+yT2/RhsQUIwUSK3g/xQ3eJbp7BdPI4KYzUWwMFuSia9um
	 4D2kJ6OF54kJ548wOBRExBlgtZ+tWRNbS0l6+k+uCox2mgDZQZmGb3Bj5kUY7E/DHf
	 zNBS3hm/A9SmdqeKWaELACByLBBrQFFY44ha6cDRpxSQH1xLj4QZ0wjRVTkA6VPtpt
	 21AO4zVQxClYoSPgjZ/olgCu60R7C3g3YLuOEo2JPLQvviwm1qzWY1/Gsuj+mOkutt
	 z5g2pnW5vcv6A==
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
Subject: [RFC PATCH bpf-next 1/6] selftests/bpf: Add bench_force_done() for early benchmark completion
Date: Mon, 20 Apr 2026 04:17:01 -0700
Message-ID: <20260420111726.2118636-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420111726.2118636-1-puranjay@kernel.org>
References: <20260420111726.2118636-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bench framework waits for duration_sec to elapse before collecting
results.  Benchmarks that know exactly how many samples they need can
call bench_force_done() to signal completion early, avoiding wasted
wall-clock time.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/bench.c | 7 +++++++
 tools/testing/selftests/bpf/bench.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 029b3e21f438..aa146f6f873b 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -741,6 +741,13 @@ static void setup_benchmark(void)
 static pthread_mutex_t bench_done_mtx = PTHREAD_MUTEX_INITIALIZER;
 static pthread_cond_t bench_done = PTHREAD_COND_INITIALIZER;
 
+void bench_force_done(void)
+{
+	pthread_mutex_lock(&bench_done_mtx);
+	pthread_cond_signal(&bench_done);
+	pthread_mutex_unlock(&bench_done_mtx);
+}
+
 static void collect_measurements(long delta_ns) {
 	int iter = state.res_cnt++;
 	struct bench_res *res = &state.results[iter];
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 7cf21936e7ed..89a3fc72f70e 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -70,6 +70,7 @@ extern struct env env;
 extern const struct bench *bench;
 
 void setup_libbpf(void);
+void bench_force_done(void);
 void hits_drops_report_progress(int iter, struct bench_res *res, long delta_ns);
 void hits_drops_report_final(struct bench_res res[], int res_cnt);
 void false_hits_report_progress(int iter, struct bench_res *res, long delta_ns);
-- 
2.52.0

