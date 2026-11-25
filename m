Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584773;
	b=lvJk9IPq8Hsl7q/9n+HI9qlsbythZVw9eMRt9yfxPiE4+EaB1IHtKny5tE4XpYlkSWo+
	 P6HixnV/UpWMiyUQTM93I/QfdOYUCuhT/Qn/ZwzEigbHGRc/PFUnaf14uPvpyfpe15zTt
	 naP3PmjL0PLi8Jdep22HuuqnQXp0Ygs7/5j4ZWv9becBpNrKUeD0oAinOtyt8dlPfXpAS
	 viiYgLa4jlVBrKrGMcdy3UjQaOENhwrRQ054UAs4jRPIKR8RhBLVuPI5LW6kWdfxEVv4m
	 mWtCBZrhlKvzNXcvavHQs2XPyWLkA3BD+VpgKnkUks1KatQ/KkSXgGUC+/CRmFSsI8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584773;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=soxq+5MXIST1SgaMLSBl1OUg/dP9HEWCgOkYllx5Baw=;
	b=yA4kahq5PIc3J1dcxc6bxidI8klmedozBNvPuBKfvrLGOZow9Ou9l7K6rPvLpjpuboKc
	 oDMGMhd7Rn+AfIhOPSIgWnWhT7DgBsCpEZI78R6lfJgVBOCB/+VWTor1z+w+R18g5497/
	 8G1nWfQWgx7Okh7OWgZPfc6Ha12Rm1Hja6GEWjLM2KwF6BsRHz8nrxOAdcb/QGQLrFB+R
	 5LQKRMUwVRSu4ypP/3fxhu5yBtTj/uOa9OSrEpEDmQLOwN3hPfhC7hJvccUL5qx10xugD
	 lWdynrYZXX+HT8yrbfDlGgu9CU7wu+7EtEvXH5wY57L+gWHapKSyimQY2C9B8pJD5FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=G6kit3pl;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9F3606A329
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D9F3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=G6kit3pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=so
	xq+5MXIST1SgaMLSBl1OUg/dP9HEWCgOkYllx5Baw=; b=G6kit3plWndRFitdoM
	eLiLnae9mgok4+1QnYHV0jCmnu0xsscgDvTJTVxPcUXLfGdz5xSQdjaikqwszVRp
	bqZoNzggZIpenhCjva6fA88M8E6PA8RW4q1HXRXOoO5amBC9T/6IVD4YcGpomxTH
	DClPh72SguifflzOkn+eNNqUk=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnL6jCcgZrriN8JQ--.11907S5;
	Wed, 25 Nov 2026 13:31:52 +0800 (CST)
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
Subject: [PATCH bpf-next v5 3/6] selftests/bpf: Test task work scheduling on a deleted value
Date: Wed, 25 Nov 2026 13:31:29 +0800
Message-ID: <20261125053132.444234-4-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125053132.444234-1-luyun_611@163.com>
References: <20261125053132.444234-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wDnL6jCcgZrriN8JQ--.11907S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWkKw13AFW3Zr4fuF1Utrb_yoW8AF48pa
	yrArW2kw4Sgw17tr4fAws3KryrWw4ktw4rGrZxK34Yyr9xXrn7Xr4IkF12qFsxCrZYgr43
	Zw42q3yxuF4UWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDSdgUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wgr+WsGcsiUKgAA3Y

From: Yun Lu <luyun@kylinos.cn>

Add a return-value regression to the task_work_fail object, which
test_task_work already runs through RUN_TESTS(). Assert -ENOENT when
scheduling task work through a deleted map value. Positive step codes
distinguish fixture failures and the callback does not access the
map element.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 .../selftests/bpf/progs/task_work_fail.c      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/task_work_fail.c b/tools/testing/selftests/bpf/progs/task_work_fail.c
index bc56bda..7c118c4 100644
--- a/tools/testing/selftests/bpf/progs/task_work_fail.c
+++ b/tools/testing/selftests/bpf/progs/task_work_fail.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <vmlinux.h>
+#include <errno.h>
 #include <string.h>
 #include <stdbool.h>
 #include <bpf/bpf_helpers.h>
@@ -94,3 +95,28 @@ int map_null(struct pt_regs *args)
 	bpf_task_work_schedule_resume(task, &work->tw, NULL, process_work);
 	return 0;
 }
+
+static int deleted_task_work_cb(struct bpf_map *map, void *key, void *value)
+{
+	return 0;
+}
+
+SEC("syscall")
+__retval(-ENOENT)
+int schedule_deleted_task_work(void *ctx)
+{
+	struct elem empty = {}, *value;
+	int key = 0;
+
+	if (bpf_map_update_elem(&hmap, &key, &empty, BPF_NOEXIST))
+		return 1;
+	value = bpf_map_lookup_elem(&hmap, &key);
+	if (!value) {
+		bpf_map_delete_elem(&hmap, &key);
+		return 2;
+	}
+	if (bpf_map_delete_elem(&hmap, &key))
+		return 3;
+	return bpf_task_work_schedule_signal(bpf_get_current_task_btf(),
+					     &value->tw, &hmap, deleted_task_work_cb);
+}
-- 
2.43.0

