Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597534D398;
	Thu, 23 Jul 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796713; cv=none; b=oSBoDZlgxMeSBBO7jzO8QM/T+A6VtEeOslsGxe9pk3hhlClbbMIZ2aep/XyRrOsayOk8GWKBMRZgCuVmqV8MfQxwjg0FNDXS5jbmZkJ46n/ZlF6n2tBOr56CfNZWQCHwiMZc2giS9NL7MeNrrL0tYr4Ca6GfN8VHgMu+dUvscCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796713; c=relaxed/simple;
	bh=tgM9o/DpEvL50YP7AXAiYHsExbCXemZgNAnHESGJKTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESEbtJN86UBayKzfxO+NDDZwyFmgaJr2o2Bo1xkbIgDhfUe7bMRtBkq51OOElYj1w3sD7f0YDJwNDxIOD06L30mA9DMivC8ikSC3OqYxo5hTTMhPgoxbQU2LqESUvtrEUGO5SzgAcs+vfsCWIEPVa5ARfBepW52N7sX0nqL1IMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NLwZPRms; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NLwZPRms"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aj
	4zqliLEwXTaW1eZQaP/YZLdrTirAHsc39CRSxXaEM=; b=NLwZPRms10tjGHngim
	s0O13zS8opeqhhYlJkQ0QXf4AlhqwnqP4ionJeKiTKc+bvqGS4JD+Z8wqIs9haap
	Jx44HkdGq/nAVhfghb+WFwqHF8YNFbIqpAGXbFG4cEqyFC0S/CgSvWrAnFWOSCk0
	IyojapPpKvwB5KGjeNOFWPSxs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXxSj01WFqpPy0Ig--.27305S3;
	Thu, 23 Jul 2026 16:51:02 +0800 (CST)
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
Subject: [PATCH v3 bpf-next 1/5] selftests/bpf: Fix double free of subtest_state->name
Date: Thu, 23 Jul 2026 16:50:56 +0800
Message-Id: <20260723085100.482147-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260723085100.482147-1-yangfeng59949@163.com>
References: <20260723085100.482147-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXxSj01WFqpPy0Ig--.27305S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4ftryfXFyrCr17Zr43KFg_yoWfCFXE9w
	4UXrs7GF10yay5A3WUGr1FkrWkZw4Uur4kXrnIqF13Jay5Xa1DXF4kur1qyas8W39xJa9I
	van3G3s3Kr1rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8S1v7UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzxalHmph1famvgAA3S

From: Feng Yang <yangfeng@kylinos.cn>

The name has already been freed in the free_subtest_state function
and does not need to be freed again.

Fixes: 0925225956bb ("bpf/selftests: Add granular subtest output for prog_test")
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

