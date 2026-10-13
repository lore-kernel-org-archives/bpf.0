Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184528D831;
	Tue, 13 Oct 2026 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860531; cv=none; b=Tc7CG0kIP4FWIuUYilABE/z2Quphqu5Nypj5zYL5z3L1xfTfnyZbquPliSCT81NqnRGoxUXKdHvXJN1zXHI/NmdyxkLQD5porQbOXBOB3TculjgjhOOgYdjymTpmMCaaHqOOgTofuaMc3N8RCGcdxac/0seFynxc8i2eXKMCVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860531; c=relaxed/simple;
	bh=2QyfqQcZbn7YmQP8Wh3VjbqXonCtaQaumx758KUVgsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cN5yZOLvTqQm8p0LQINXbXjbbZAjxnoV4u+cPtqQvFI+aBQHQyd5T8AMUtbAbg5NREY70XWFz5Kd/CgvIBCvOAk5T7152W1Xd0EJ8OAPKCVhauhcqnJ76gioSBTqR6bhkTeDiQJuHW5/6fdmySPZ3VP+HGfrFet7LPbVS6U8u/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g0ZWGlfV; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g0ZWGlfV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZN
	TpWmVxNLgmH1u6gSZXhqDxxSQQ0xYZG1cc95j+xjM=; b=g0ZWGlfVdI1NIr25v6
	lxsy/HzD3QsE9KCqNl8Wqgdr6JwSIGtGFJa311v7WDkkKzI4j2ef2Kq+sJ7pNyRu
	CqGEQ3eVbdwloYjx2jUL2uY9IX6LJxTezG8c5WAoVpRix3+iE6t94CLmnjuG/znY
	OIvLDdNSJKFOWN/HlSCNiI930=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBXDbwDn81q1bDPEA--.2729S2;
	Tue, 13 Oct 2026 11:01:25 +0800 (CST)
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
	ihor.solodrai@linux.dev,
	shuah@kernel.org
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Fix map fd leak in no-BTF wq test
Date: Tue, 13 Oct 2026 11:01:14 +0800
Message-ID: <20261013030114.292157-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXDbwDn81q1bDPEA--.2729S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWDKw1UAw45Kr1xZFW7XFb_yoW8WF13pa
	yFk3yjkF95uF1Ut3WfK3y7WrWFka1kXrWayF4Ygr17urn8Jr97tw4fKa13Jas3ZrZ5Zr4Y
	vw4xt39YvayUZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbzV8UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wX2xWrNnwXSgAAA3y

From: Yun Lu <luyun@kylinos.cn>

bpf_map__reuse_fd() duplicates the supplied file descriptor instead of
taking ownership of it. test_failure_map_no_btf() closes the original
map_fd only when reuse fails, leaking it when reuse succeeds, including
when the test passes. Destroying the skeleton closes its own descriptor
but leaves the original descriptor and its map reference alive.

Close map_fd immediately after bpf_map__reuse_fd(), before checking its
return value, to release the original descriptor on both success and
failure. The skeleton retains its own descriptor for the subsequent
program load.

Fixes: bca2b74ea9a8 ("selftests/bpf: Add more bpf_wq tests")
Reported-by: Jackie Liu <liuyun01@kylinos.cn>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 84831eecc935..97926e35aaf2 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -64,10 +64,9 @@ static void test_failure_map_no_btf(void)
 		goto out;
 
 	err = bpf_map__reuse_fd(skel->maps.array, map_fd);
-	if (!ASSERT_OK(err, "map reuse fd")) {
-		close(map_fd);
+	close(map_fd);
+	if (!ASSERT_OK(err, "map reuse fd"))
 		goto out;
-	}
 
 	insns = bpf_program__insns(skel->progs.test_map_no_btf);
 	if (!ASSERT_OK_PTR(insns, "insns ptr"))

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0

