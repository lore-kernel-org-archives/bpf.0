Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3F3ACA46;
	Thu, 17 Sep 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632571; cv=none; b=JPWIuYyMAng0eNTekNf7/0uu8HnojWa420ENSP9VElH8nwBL4jw8rvHmkDLjeOacRFMRxWB4v4Bhc9wOU2mQQmZB2KTSf5nNtIx4VJh8cdFshdeWSWWFpA0+XLMPVCOF4ptTvynkVblGkpHHQRdjzvo+JTdy/zpGZ6rYJc2k4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632571; c=relaxed/simple;
	bh=kHPDGaZfE0k8a/kEG6WSf7kyDNNHo/Dz+aR6+2t4pjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQhdvn7VrU6kC0mRurqYtdfThr7AqX68dzIi2v5Sj5JV46AO9L20s90vMDZmZARcAcGZZOlUy3Dq+Pu3z6ASdIf2qhcC4tJPhN1Md2ucH1PVcdxEr2spFH+/ixj7uo3eZdjsIHknlKDkYaJzjhGnQup+TKFtTB0Bba9XH1zA0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jQrHyMZB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jQrHyMZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lk
	OiJM3PKJIofBytNg8vM4RdkLpX+PLbrteXezO+fWg=; b=jQrHyMZBMPk+PI55O4
	5aRf58OTbdAWqWf8TEG0yJnn6HMeTx7Pwbzw2E3AhH4I+WrjtDnzrIz1PnLFsuaG
	xDm4p/pLWjSI9XtEr+OLVAWm8ZGeS9WD+L8NiRkXnyu0qZff0xuvE898br22XOY2
	lpA9cUhoTCXEe/BpZbIbifMII=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3j70IoKtqR_EaSA--.61734S3;
	Thu, 17 Sep 2026 16:08:42 +0800 (CST)
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
Subject: [PATCH bpf 1/2] selftests/bpf: Fix timing-dependent assertions in task work stress test
Date: Thu, 17 Sep 2026 16:08:38 +0800
Message-ID: <20260917080839.462038-2-luyun_611@163.com>
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
X-CM-TRANSID:QCgvCgC3j70IoKtqR_EaSA--.61734S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxur1kXFy3JFy7trWkWF15Jwb_yoW5Jw48p3
	s3u3y7tr1UKa42yF129w48WFWrGrsYyFW5KryvgFy3ArnxuF97X3yxKF1jqFW7Zr9Yvwnx
	uw45Kws7CF4kWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5ucNUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AuvfmqroAtUuQAA3x

From: Yun Lu <luyun@kylinos.cn>

task_work_run() assumes every stress run observes both scheduler
contention and, when the delete thread is enabled, cancellation of at
least one pending callback.

Neither outcome is guaranteed. Contention is observed only when another
scheduler selects the same one of 128 map values while its task work is
outstanding. A valid run can therefore have no scheduling errors. This
was reproduced with a single scheduler: more than one million callbacks
were scheduled and completed while schedule_error remained zero.

Likewise, a successful map deletion may remove a value after its
callback has completed. delete_success can therefore be nonzero without
callback_success being smaller than callback_scheduled.

Drop the assertion that schedule_error is nonzero. Keep requiring exact
callback accounting when deletion is disabled. With deletion enabled,
allow equal counts but still reject callback_success greater than
callback_scheduled.

Fixes: c6ae18e0af5e ("selftests/bpf: add bpf task work stress tests")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/task_work_stress.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_work_stress.c b/tools/testing/selftests/bpf/prog_tests/task_work_stress.c
index 450d17d91a56..d61636ed5e3d 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_work_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_work_stress.c
@@ -105,13 +105,11 @@ static void task_work_run(bool enable_delete)
 		pthread_join(tid_del, NULL);
 
 	ASSERT_GT(skel->bss->callback_scheduled, 0, "work scheduled");
-	/* Some scheduling attempts should have failed due to contention */
-	ASSERT_GT(skel->bss->schedule_error, 0, "schedule error");
 
 	if (enable_delete) {
-		/* If delete thread is enabled, it has cancelled some callbacks */
 		ASSERT_GT(skel->bss->delete_success, 0, "delete success");
-		ASSERT_LT(skel->bss->callback_success, skel->bss->callback_scheduled, "callbacks");
+		/* Deletion may race after the task work has already run. */
+		ASSERT_LE(skel->bss->callback_success, skel->bss->callback_scheduled, "callbacks");
 	} else {
 		/* Without delete thread number of scheduled callbacks is the same as fired */
 		ASSERT_EQ(skel->bss->callback_success, skel->bss->callback_scheduled, "callbacks");
-- 
2.43.0

