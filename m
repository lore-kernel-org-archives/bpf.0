Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365087;
	b=0kzfIpNoOSHqM4WKRm8r7oNnwagalYdPKMYOaxszFrTc0OTnLIYIspopo81cZEKrvr+Z
	 P1kYZRhimHP7hwo2wGVKNx1vnOz+Y0WH6+PYgvcIvw76FdLCtULhzvyuM2DiI5vd0DD3q
	 lQd0W40zq/RlgNMJnlZ757Ucji2aB6e2cnm3etk4Sp+pqt8Xoj3eVk/zkqrmTL2HdlOZb
	 YOBRqO94ZN8io3UnntaWx2CwH8fx56kEMoY+A9cwGHP3s0XbYy0G1nZYf21H4uUJM3xUa
	 4leXoaLAAPpk2uXXbrMdC8bcVuajiTvxXeH9AWQpK7U3+U6/6HpMhdKgLMI1tycnx3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365087;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=bzovhjwKDO786MAsSCLztFgppolbFsVQKd25FXdvJ5U=;
	b=NTZPSHeipHAUkTWy+3ZLwjaPQljwiVu4JXWMNQkmd43F0Pqlo7JPPNP+as6ecnMgYLJQ
	 lR6ufBK6NzlyQj6genWLH9F/U7KwcnGLsTqy/DA05bSM2A7fD1NY+pgzG846srqIhfFt5
	 Z0U8g4u3s4L9KNsMGOisnfUPBDH6t61EayJgSaMtTHV91k9nH5lnKaBbWQkl1vH8dn+5v
	 POtoQzIwm3psHTnk0KEYeKQrX9i80iHFgRMNkKGihA0EpJM9IsnG2t4kpVX99Tj2yaefY
	 gDasdnWASRzFfSgRjKcRWBXa+8k1rA1SkcxuVklSPNI3FKEEHCPchWIa2ZVU8R9qqlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bQa2Z8ab;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE834606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 02:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE834606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bQa2Z8ab
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bz
	ovhjwKDO786MAsSCLztFgppolbFsVQKd25FXdvJ5U=; b=bQa2Z8abAI93WHljsn
	NTAz+kfIvifLv2HW8vaElhBi4L7OFwIAO0ILsZV/zS4D2Zp14wp3sir/xxqlZ0Rn
	yti82cKkCbB5aiJwpiWkUvYgI/89h+wky2CEPxbOeS8MohyLc/sgkNNAiG/jUmGn
	PJsy+hnkoYWOdyHq1ue0l3ilU=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBXCgpq1vNqdIGjEw--.26036S5;
	Wed, 11 Nov 2026 10:43:57 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 3/6] selftests/bpf: Test task work scheduling on a deleted value
Date: Wed, 11 Nov 2026 10:43:30 +0800
Message-ID: <20261111024333.228633-4-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111024333.228633-1-luyun_611@163.com>
References: <20261111024333.228633-1-luyun_611@163.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBXCgpq1vNqdIGjEw--.26036S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw17JryUJFW3ZF4kur4fGrg_yoW5XF4Upa
	s5A343tr4rt3Wxtr43Aws7Wr1rWw1ktw15Kr43tr17Ars5XFn7Xw1rKFyjqFs3CrZ5Xan3
	uw4Yq3yfCw48XrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jgR6wUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7A1oN2rz1m1jdQAA3K

From: Yun Lu <luyun@kylinos.cn>

Add a deleted-value case to task_work_stress. A syscall program looks up
a HASH value, deletes it and schedules task work through the retained
pointer. Assert that scheduling returns -ENOENT; positive step codes
distinguish setup failures from the unfixed kernel's return value of 0.

Reuse process_work(), which only counts callbacks and does not dereference
the old key or value.

Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
 ...elftests/bpf/prog_tests/task_work_stress.c |  18 ++++++++++++++++++
 ...ing/selftests/bpf/progs/task_work_stress.c |  17 +++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_work_stress.c b/tools/testing/selftests/bpf/prog_tests/task_work_stress.c
index 450d17d91a56..90d6d696537d 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_work_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_work_stress.c
@@ -121,8 +121,26 @@ cleanup:
 	task_work_stress__destroy(skel);
 }
 
+static void task_work_deleted(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct task_work_stress *skel;
+	int err;
+
+	skel = task_work_stress__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.schedule_deleted_task_work),
+				     &opts);
+	if (ASSERT_OK(err, "schedule_deleted_task_work"))
+		ASSERT_EQ((int)opts.retval, -ENOENT, "deleted schedule rejected");
+	task_work_stress__destroy(skel);
+}
+
 void test_task_work_stress(void)
 {
+	if (test__start_subtest("deleted"))
+		task_work_deleted();
 	if (test__start_subtest("no_delete"))
 		task_work_run(false);
 	if (test__start_subtest("with_delete"))
diff --git a/tools/testing/selftests/bpf/progs/task_work_stress.c b/tools/testing/selftests/bpf/progs/task_work_stress.c
index 1d4378f351ef..5f47133ad308 100644
--- a/tools/testing/selftests/bpf/progs/task_work_stress.c
+++ b/tools/testing/selftests/bpf/progs/task_work_stress.c
@@ -71,3 +71,20 @@ int delete_task_work(void *ctx)
 		__sync_fetch_and_add(&delete_success, 1);
 	return 0;
 }
+
+SEC("syscall")
+int schedule_deleted_task_work(void *ctx)
+{
+	struct elem empty = {}, *value;
+	int key = 0;
+
+	if (bpf_map_update_elem(&hmap, &key, &empty, BPF_NOEXIST))
+		return 1;
+	value = bpf_map_lookup_elem(&hmap, &key);
+	if (!value)
+		return 2;
+	if (bpf_map_delete_elem(&hmap, &key))
+		return 3;
+	return bpf_task_work_schedule_signal(bpf_get_current_task_btf(),
+					     &value->tw, &hmap, process_work);
+}
-- 
2.43.0

