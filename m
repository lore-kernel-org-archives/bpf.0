Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522447604E;
	Wed, 22 Jul 2026 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706528; cv=none; b=NUSa8Cb1Kx7Chq62jzgCMAgskHIvhzPXtGs6MUJ2dC+eie4gZfh08i7Hv1d4F5t9l36BMZzUKNstabjyJdIuz9AnAl7AGs75p1RPkvghPnqny9T//HdFptRB9JezzOy9YXvmlgEorw0hFpl1TDhT0amA0pIery+bOGqf6wADTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706528; c=relaxed/simple;
	bh=FNi/w8QUVzqiKMiKlF225WNheWrCsvZLomDXdy+bxb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RmpSWWzO5Ko3O7kAU1oOB26dgAuGr+ilsuA7orL+CIvRCLLUbotpaU8dYtZOjMoCF/T4qNUUO9bcSPmLWzzw4byX9tXXePHtGtaREuJ7BYRZgtJ49J9QFmTrE9t2vh6OBAwExNfmuPpi2RqcmcTTELE0fPtfZ7KXerDZwFozUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OTKLeElO; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OTKLeElO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pR
	tt+gWQWOELN6BDEnQJjjf8T2CiaZ37KNZud1J4Acs=; b=OTKLeElOvALEI5PHSH
	TTdT7vXGJ5X3aMeIOK71jPZgEyTShenSCBDZBuDidEv2Q9yPnFGAxedJDv+9xEPf
	yi7o/5q7nMOAe+j8aFnABtvVmy6T3gENndLIaSMpAuF+w6SACb9xOLiXOs0h6WPP
	VTlmEvUuIeJPxzVP4a6WJqD70=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnrw+kdWBq8DkpJA--.55057S4;
	Wed, 22 Jul 2026 15:47:51 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 2/5] selftests/bpf: Fix missing allocation null checks in test_progs.c
Date: Wed, 22 Jul 2026 15:47:45 +0800
Message-Id: <20260722074748.674080-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260722074748.674080-1-yangfeng59949@163.com>
References: <20260722074748.674080-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnrw+kdWBq8DkpJA--.55057S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWfuw4fKry3Cr47Ar47Jwb_yoW5WrykpF
	48GFn8KF4fZFnFv3W3C3yUWry5KwsYqayDKa4xAw17Ar47JryfK34ktFyIqFnrGr45uFW3
	Z3Z09F1IgrsrJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7R6rUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzwc5sWpgdadMXwAA3L

From: Feng Yang <yangfeng@kylinos.cn>

Add null checks after memory allocations to prevent potential segmentation faults.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 33 ++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 1d3caf996971..88c65ce5b018 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -730,11 +730,14 @@ int compare_map_keys(int map1_fd, int map2_fd)
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
 {
 	__u32 key, next_key, *cur_key_p, *next_key_p;
-	char *val_buf1, *val_buf2;
-	int i, err = 0;
+	char *val_buf1 = NULL, *val_buf2 = NULL;
+	int i, err = -ENOMEM;
 
 	val_buf1 = malloc(stack_trace_len);
 	val_buf2 = malloc(stack_trace_len);
+	if (!val_buf1 || !val_buf2)
+		goto out;
+	err = 0;
 	cur_key_p = NULL;
 	next_key_p = &key;
 	while (bpf_map_get_next_key(smap_fd, cur_key_p, next_key_p) == 0) {
@@ -1514,6 +1517,8 @@ static int dispatch_thread_send_subtests(int sock_fd, struct test_state *state)
 	int subtest_num = state->subtest_num;
 
 	state->subtest_states = malloc(subtest_num * sizeof(*subtest_state));
+	if (!state->subtest_states)
+		return -ENOMEM;
 
 	for (int i = 0; i < subtest_num; i++) {
 		subtest_state = &state->subtest_states[i];
@@ -1732,9 +1737,24 @@ static void server_main(void)
 	sigaction(SIGINT, &sigact_int, NULL);
 
 	dispatcher_threads = calloc(sizeof(pthread_t), env.workers);
+	if (!dispatcher_threads) {
+		perror("Failed to calloc dispatcher_threads");
+		exit(EXIT_ERR_SETUP_INFRA);
+	}
 	data = calloc(sizeof(struct dispatch_data), env.workers);
+	if (!data) {
+		perror("Failed to calloc data");
+		free(dispatcher_threads);
+		exit(EXIT_ERR_SETUP_INFRA);
+	}
 
 	env.worker_current_test = calloc(sizeof(int), env.workers);
+	if (!env.worker_current_test) {
+		perror("Failed to calloc env.worker_current_test");
+		free(data);
+		free(dispatcher_threads);
+		exit(EXIT_ERR_SETUP_INFRA);
+	}
 	for (i = 0; i < env.workers; i++) {
 		int rc;
 
@@ -2094,7 +2114,16 @@ int main(int argc, char **argv)
 	env.worker_id = -1; /* main process */
 	if (env.workers) {
 		env.worker_pids = calloc(sizeof(pid_t), env.workers);
+		if (!env.worker_pids) {
+			perror("Failed to calloc worker_pids");
+			return -ENOMEM;
+		}
 		env.worker_socks = calloc(sizeof(int), env.workers);
+		if (!env.worker_socks) {
+			perror("Failed to calloc worker_socks");
+			free(env.worker_pids);
+			return -ENOMEM;
+		}
 		if (env.debug)
 			fprintf(stdout, "Launching %d workers.\n", env.workers);
 		for (i = 0; i < env.workers; i++) {
-- 
2.43.0

