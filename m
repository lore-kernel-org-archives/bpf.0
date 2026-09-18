Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A137C0E6;
	Fri, 18 Sep 2026 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699453; cv=none; b=cFC4nsuKVy085NPlBuQTCBc2unwSZau5qi8/l3KNCBAUPd0o7NBGcAzC3YvPdrMqnPjredwwXHdaRMBtGiDwIStijtfofwXEBRE5imTwjgsh/GzF2vzkPU1G622qYm41GvtnxtlmqmOf0NjciJoGDYpOC7zDhnDnAA2kTUyRJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699453; c=relaxed/simple;
	bh=VjqJXu2vAe/ZPEwDVtYCkvWQ2r4QR2EZSyg8NybNLOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdKpUIkZIUysu90tG9HmzVJ5Il8OUJjBYoBVvQJpUM8soFYWCNOzzDO0HZixoYGoCMxi1nRoJCX0vvOK2FyUU+Ug8GqdBqK71tjdurxzVz60HO2t4F1paGz4MrKt4kxBrE7hZ+rIwkN3R1eo7J8ZoD5id9Sgq8qtu2DeUENbyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=elzRu7+p; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="elzRu7+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Mw
	xeu4gYjbYiIAf6fIw/7HM23U+Ce2Pt8V9BwNNcht4=; b=elzRu7+pOBrDzDXOty
	AMKNXIKjPeSITBwt73CUMczjHn+wuJT+pIO4Fn3HrzxKlk4wOf/1OO3yu33mLAlN
	9i7s9NTPuYm3SJdzqY57KS6h9tEy+deWB/0lPnCC7KLSYq0smr8LIZAxLyjznBJE
	rk8PP4fa/TO197XH8xGHTqrAo=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCH7+U1paxqIh9RBQ--.22264S2;
	Fri, 18 Sep 2026 10:43:02 +0800 (CST)
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
	emil@etsalapatis.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Clean up child when task_work__open() fails
Date: Fri, 18 Sep 2026 10:43:00 +0800
Message-ID: <20260918024300.18321-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH7+U1paxqIh9RBQ--.22264S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry8tr15tFW7Xr4UJr45GFg_yoW8Aw48pa
	yrJr1jkr4fG3W7ta18CrsrWFyrC3WkAay5KF15KrnrZr9xXryxXF4fKFWjqwn5CrWSvF1F
	vw4xK393Gr48XFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjCJQUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCxBY8C2qspTbICQAA3x

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
Resent as a standalone patch against bpf-next as requested during
review; the content is unchanged from patch 2/2 of the previous
series.

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

