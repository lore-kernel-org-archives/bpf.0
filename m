Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B1446067;
	Tue, 21 Jul 2026 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627086; cv=none; b=dRNOt12sVJYREVREOxuEXZj8DxRwZI/niIvhYNYTnpKM1bj5nMPEbobABp8zaZPhNG6GIjnN4urzeUgLRoJEyLlVtai/aJ9YCmwwnwbRWEe3GOayHdM0fVCda4iCbBfRfM8AIsEBnl4hTDeSFtbKHdTMlX3D7X+0TyQnSO/Xzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627086; c=relaxed/simple;
	bh=RUGtFjXd2Ngi4MJrG0xjR274j0Sw5gEzMC+Xl+YZCg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j0KwSn3qSxiIJGkC8+FaymM+EdlxQcmmWjcxyqsn+e5K8FhtKNu+nRna0GJ9JCXi844NPS+eQhpFq+QC/ZDnviM4WxzgaHechvusolt3sQ2Wo6LkOcY99RWPxetjFwtpI+cD+JVYkcDtSsWWkuxYcl9aUS+eraCUwncKIT8NCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MTo9mLDK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MTo9mLDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8b
	q/fEOH+8VrRAWchTR1BoPBLJwtsejTQGH1hKo+BCo=; b=MTo9mLDKdfvjk5BjXC
	G9Gv26cgZhb9HFASfVTxyKKN0ZQNA8jarVIpaH2bwjjwLgWW8SxHrzBCfGrgG7wl
	BuV5qOxkPQzVGt2yFe+3BDdfI5kvWHOqeeH3ycaYThUB+NFqQa65yBWL3xnOmcEu
	46+JemhaJZxgCh/KoYFkXXOTE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBHN3dlP19qc_KUKQ--.35387S2;
	Tue, 21 Jul 2026 17:44:06 +0800 (CST)
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
Subject: [PATCH bpf-next] selftests/bpf: Fix double free of name
Date: Tue, 21 Jul 2026 17:44:04 +0800
Message-Id: <20260721094404.593127-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHN3dlP19qc_KUKQ--.35387S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4ftryfXFyrCry8ZF43Wrg_yoW3tFc_uw
	4UXFs3GF10yay5A3WUGr1YkrWkZw4UZF4kXrnIqF13Jay5Xa1DXa1Dur1vyas8W39xJa9I
	van3Gr9xKr18CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8e6wtUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8gZb02pfP2YHBwAA3Q

From: Feng Yang <yangfeng@kylinos.cn>

The name has already been freed in the free_subtest_state function
and does not need to be freed again.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 7ba82974ee78..1d3caf996971 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1886,7 +1886,6 @@ static int worker_main_send_subtests(int sock, struct test_state *state)
 			worker_main_send_log(sock, subtest_state->log_buf, subtest_state->log_cnt);
 
 		free_subtest_state(subtest_state);
-		free(subtest_state->name);
 	}
 
 out:
-- 
2.43.0

