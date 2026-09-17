Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA663C4B79;
	Thu, 17 Sep 2026 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632566; cv=none; b=kXLIGx5jQ7Q1ITxdqMiKBL8LY3WZn7Myzr2dTIzo+VHa2W90VzI9mmCsvutLZqSlp9FtJbIVT1yOHstrD29kMQaZTJWdxse8j8jBCsvxLKUefKMhzXRXIja++cJIeGiOZy17KDUtgLsgNT84dOJrmY6AJfH3cxi4hRGnkHsOg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632566; c=relaxed/simple;
	bh=CHIyeBaGccn5Hn4AcfnudET/+5QN0hXB5sA0AuigAQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkhDMhz7wGjpCwlwPoVLJA0fltKA5piHEHGr0i0SOdShLEzAmFT0uGcQ5dsvE1sx0jCrnL60+UgeCBhar69s4tyw3L0cDpyzsYJqmZbn6cXpJoj3Zdnr3PUpZ8ujnbzRi25g3ZFER7PvAkFmVIoEac9HnLU05YbLQgPJbNPnd3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WsYO5A3B; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WsYO5A3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=HE
	4vhRmMF3tWJa+4osgXklw7t+f+OaSxjORNGdynazU=; b=WsYO5A3Bg18IvWlwVa
	U8L8FTAEERmi064+Zp2prVmldKaeE2p/6DYoBPtH5mDm4UtLZ3UNhltLe0J6Z1pd
	QZiGG5zaK9nOXPhG/WdmMW5McZkmGEYexO9M1Rz0KQDK0fa4A6nkTS6Gtwg52ngJ
	CgHF5/b/sRiZ1PszJ6G35mZyc=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3j70IoKtqR_EaSA--.61734S4;
	Thu, 17 Sep 2026 16:08:44 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Clean up child when task_work__open() fails
Date: Thu, 17 Sep 2026 16:08:39 +0800
Message-ID: <20260917080839.462038-3-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917080839.462038-1-luyun_611@163.com>
References: <20260917080839.462038-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3j70IoKtqR_EaSA--.61734S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry8tr15tFW7Xr4UJr45GFg_yoW8WFWxpa
	yrJryjkr4fG3W7tw48CrsrWFyrC3WkAay5KF1rKrnrAr98XryxXF4fKFWjqwn5CrWSvF1r
	Z3yxK393Gr48ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7eOLUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7Aywf2qroAxU5QAA3z

From: Yun Lu <luyun@kylinos.cn>

task_work_run() forks a child that blocks reading a pipe until the
parent wakes it. If task_work__open() fails afterwards, the parent
returns without closing either pipe fd or waiting for the child.
Because the parent retains the write end, the child remains blocked in
read() until test_progs exits.

Route this failure through the common cleanup path. At this point
cleanup is safe: pe_fd is -1, link is NULL, task_work__destroy() accepts
NULL, and the pid > 0 branch closes the read end, wakes the child,
closes the write end and waits for it.

This is the last early return after a successful fork. The fork failure
path already closes both pipe fds after commit 5730dacb3f17
("selftests/bpf: Task_work selftest cleanup fixes").

Fixes: 39fd74dfd5d2 ("selftests/bpf: BPF task work scheduling tests")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/test_task_work.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
index 774b31a5f6ca..fe0cb1702eaa 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
@@ -85,7 +85,7 @@ static void task_work_run(const char *prog_name, const char *map_name)
 
 	skel = task_work__open();
 	if (!ASSERT_OK_PTR(skel, "task_work__open"))
-		return;
+		goto cleanup;
 
 	bpf_object__for_each_program(prog, skel->obj) {
 		bpf_program__set_autoload(prog, false);
-- 
2.43.0

