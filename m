Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059110;
	b=XqhxsThyUZ+ow23CRSGKilC0KqPzyjso6n98EJ5MSPJdlJf3OSq07N4+o7xJWOXDBsmk
	 4DJwP0icK+MAD6Cp4wvHJDXKlaUARK/01dVyCddHJ/GntKBMhZ98SP3oQWvVAkObZtYL+
	 939eYatNT1VjxrsZILgNxRIFGhigLsVWfy+UMTRCTrtlym4Ryg8vbsDGzzmsVAcWbwF/5
	 a5rDQVhTHazHIjGWl+9RUHLhtXRA498rDKjfsboLMOAxVeNAh5fZchexqDQQO5RWcG64/
	 7Hs80wMAzYCnj8XLoHInT91YKXR3ZbKCqSogtK/0+JbfuTkAyKyR22ZxBv5Kc+QFigw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059110;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=CH12WUOSlWI7U8kexgvviPOCsbzjXTqoLAHe4rjQpPk=;
	b=uLDQvvcqXml55aqaHjeTu2tajDkZjMQKnQe3FQZGgd8JjlFr/CGcA/kWUNHXrRq6jK4l
	 Tc/+dxNgwfQXaGDYwFvsyUMCYmbj8zBVKvY3pEs8D3wUWm/+0Ja9u0t3fhh0TWhJi2Mr7
	 4YVCYdrzJeAttIAoPj+JUuGfJBIn+PltmtaYcMK3b/1r9QXBsPbouGyP5asCFWc64N1rC
	 uAKfpANPXBwfx5v1+4m3eZaEnQFwVTV7CFpDIM22Pz+XBoTyfa3gEf5DjqOvZ7o26ZC2K
	 Kx0bjN3Gf3+mu/GLsmThQjal8qtYV3m7VAJXa1IUDQVqXSamqrVgRNm5ID96jnwqAmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aadssHm3;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB9606A32F
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88EB9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aadssHm3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=CH
	12WUOSlWI7U8kexgvviPOCsbzjXTqoLAHe4rjQpPk=; b=aadssHm3Kc7yDWx7IB
	ahcDRcQO4XpY5lY4ZYNDueb4Xc8ldN3/H2wYNL4BFqYLMfdg3XW50OTshh8FwTlH
	EcPsJWOyzMExodNtniy0P+W/FZhBL+Q1qA4V6vJN5hLZWlSmeT8E21ZdqmnAEho4
	V0sjNA6ZnSVTylZXUVCKbE1cg=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3Xzx1bf5qM8OwJA--.54798S5;
	Thu, 19 Nov 2026 11:31:06 +0800 (CST)
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
Subject: [PATCH bpf-next v4 3/6] selftests/bpf: Test task work scheduling on a deleted value
Date: Thu, 19 Nov 2026 11:30:48 +0800
Message-ID: <20261119033051.196177-4-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119033051.196177-1-luyun_611@163.com>
References: <20261119033051.196177-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wD3Xzx1bf5qM8OwJA--.54798S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw17JryUJw47XF1UCF4DJwb_yoW5XrWkpa
	s5A343tw4rt3Wxtr4fZws7Wr1rWw1ktw15Kr43tr17Ars5XFn7Xw1rKFyjqFs3CrZ5Zan3
	uw4Yg3yfCw48XrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jy9aPUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BrTomr+bXojgAAA3n

From: Yun Lu <luyun@kylinos.cn>

Add a deleted-value case to task_work_stress. A syscall program looks up
a HASH value, deletes it and schedules task work through the retained
pointer. Assert that scheduling returns -ENOENT; positive step codes
distinguish setup failures from the unfixed kernel's return value of 0.

Reuse process_work(), which only counts callbacks and does not dereference
the old key or value.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 .../bpf/prog_tests/task_work_stress.c          | 18 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_stress.c     | 17 +++++++++++++++++
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

