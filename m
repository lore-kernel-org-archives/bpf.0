Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30E370D5C
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332216; cv=none; b=rYEikuBAnbEYCAAgNwitxBw7h6+rz4kqNPAIHQgn91TqquYzQjq1VyrupyDgpavnMQcCh7SI1VQ6pXQz5pJQChpLaBxp0IVAEwKqb0rSmJqj6P9r9XkMua5DAsbQ+ZDhLW73FpkVjC8MciOVfoTI/4yKwcyL3bAs9DoOWPBBqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332216; c=relaxed/simple;
	bh=4/nUy5Tdd7+qF4rmXJ5lHMs2M1ZjHEuqkrERXUTiUFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6DANkA1aX6BKuHL44r9aQX3pDPM4apR/GRJ7sWmFQO4IjMhge3XnmlnkfrjzJIHKFASeaLC3XyqUcKn7lBV39Lox0JIHqPSHCuyYxXPThJcOTVU5G48gNqlrzaco2cVXcsZrm9s+wCMc6lsfBZ4vpYjmTIMe2zHLMThFtHaNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rckYoQl4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rckYoQl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70214C19425;
	Mon, 27 Apr 2026 23:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332216;
	bh=4/nUy5Tdd7+qF4rmXJ5lHMs2M1ZjHEuqkrERXUTiUFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rckYoQl4adBfwOXNWxir9/zVHd69qemChsc4WnOIKHYLaA6o3afMsmx8E3o3ILOo3
	 a7bY8UlclmeubhJw8/ksn0FKaMaMJ8PEW53yyvtSeZtJUESf5RCEZ47FBFfUUv+thy
	 ZHxmsbVpgRW3SM4Vn5krt9aID6zZQubYrRRMGlHP8kLkr+qUaIEQBoX7D7z4Zl3BHQ
	 KCkL+RrxPVoqKATloZdN+2fmLqov7UmmHgfzNzsj2/79lJKxtgv7cjdf/Z1UBT7/eb
	 QmN7cnffspOpl+5pz/yqtWYWoGklnG6usfnYoImIjsgbaVcH2PLI9azPqbUF3EfPdP
	 qD9aT3FIS+vcQ==
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
Subject: [PATCH bpf-next 1/7] selftests/bpf: Add bench_force_done() for early benchmark completion
Date: Mon, 27 Apr 2026 16:22:58 -0700
Message-ID: <20260427232313.1582588-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427232313.1582588-1-puranjay@kernel.org>
References: <20260427232313.1582588-1-puranjay@kernel.org>
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

Also refactor collect_measurements() to reuse bench_force_done()
instead of open-coding the same mutex/cond_signal sequence.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/bench.c | 14 +++++++++-----
 tools/testing/selftests/bpf/bench.h |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 029b3e21f438..47a4e72208d6 100644
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
@@ -750,11 +757,8 @@ static void collect_measurements(long delta_ns) {
 	if (bench->report_progress)
 		bench->report_progress(iter, res, delta_ns);
 
-	if (iter == env.duration_sec + env.warmup_sec) {
-		pthread_mutex_lock(&bench_done_mtx);
-		pthread_cond_signal(&bench_done);
-		pthread_mutex_unlock(&bench_done_mtx);
-	}
+	if (iter == env.duration_sec + env.warmup_sec)
+		bench_force_done();
 }
 
 int main(int argc, char **argv)
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

