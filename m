Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209463A783B
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988572; cv=none; b=MkLuw5WeU+o5BNHm75hFYbywFn8HAxl9WJEsjwanPdoqd9x2WM7FI0Zo8QYaKpoN+vpSCgCtDzO2taIcLO/W2tqV4EwTQ3nOyIFpuQ6ibhNIZKtWzeMvnd5lydLb6BKQ1Zf2lvJIMGDVTia5IlOreCwCTsxE9RHnI2HefnQakg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988572; c=relaxed/simple;
	bh=u7um/yROV0Uoc6Lyio+e+E+tFGmnAo1AVUvWvMlK77s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inKt+UvWfdri3m8h0L3Q1nmv/JUahaUvjTTquF29k71N+d8I/XnGjf+YOhGoGF/fW4xI6doV38LONgttOZ8WBKKvAUAq4Jv0ZBwjJnv4mmTkw6Id4BpnG1YvQkIXXw9E7wLklOkZK3IxCAdz7s1Dp1pmAZoyp0E/ayXkkaJk/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6GkV8cu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6GkV8cu"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0c09bb78cso5270205ad.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768988570; x=1769593370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6crH5fiQLouF15MwsFqqEri1pA43lFVDbD7kBDfCmV4=;
        b=L6GkV8cuMRL1Z+LTFZjcZ2ISHcEZUIQ0vgCJ0FdVPSYFsn6wvv+kr68r1zkuAyHAMM
         JSaDhiHJdHSiGhE2RnAkfw0vYRAI+PylmmYzrPJx7p2RePu/AFyc1KdS+qcpnmfCWoeY
         9nGzgn6HJIuhifXbeElI7gMwySWBHzRgGUUMpuyh1KsHJfnuc3Wv7Lt2VoAzfjiKOlzz
         6XqWc6KyTO2moFbYR87JIHy+nxJcb8ukrdmeYAfNIYDyNN5ki2ktFTQdV433u/WG1qvd
         DUyfqqsaSNBXMhiC9QCtj50OjszazAwbou1Xl9JK68o131FtlX6BvCC67nkmS/wB+e6H
         eGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988570; x=1769593370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6crH5fiQLouF15MwsFqqEri1pA43lFVDbD7kBDfCmV4=;
        b=AmXT4BCuyIrSbG7bTt8E8CZHVc9ceLBPsbO3/bGK3A60vlrpBCJde4aQ9ZbUaplK2p
         0ylN1CiHxH1JlBKOP87DTgD/P4z4jGMIcWM941YHwIJ46GpgJIsGl2WvtP26mr4HSrSl
         6385YRz4dphV3AwUg0iYMezlt95KFjOObEVB/R1N1R+QD+2UkqWd62IecZnQruj5GNlm
         Fy9Ko35pZJomrxDm5UUeJqasYahcg6ScaUkArPSrVzSJsPgnZZEvChLiCnpsUu/woys3
         wZzVLCmc6Nlpj9r0PbGlI90YQ9MHSPM2JajVczJVJkQXzsptq61fF30Qq+RGINdWIz8P
         YTUA==
X-Forwarded-Encrypted: i=1; AJvYcCUPjm2N4YlveZOocASOaKaLnr3O0foutNxJRbCkAy2o/0WeO/QtPn7w3jHAJ3XiKbq6HKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiP55ufeHzNYxXYq0ENGugj4HQCIqXQEQZwCbtJJRghhHS+tSb
	Bmab1QfAMrBWmOcsdFj9AeS5qJwD48NDy5HMygtZyJAgDgUbK8P5D9I=
X-Gm-Gg: AZuq6aLm2d6WOt37Y0JCXhAgEKkezbQtPj7/Goa4Pe11JL4m8UaEQWcd8xehPvRl5VO
	W1fwZTD4cjx1InwYyE5atC9rBhnuglSesGCC9f2C2Nac2ZHdFrRcQ0/K/m90u3bqQqMFyWwWPrF
	JY7N727x3W/4Nj5LtEx7WVidYLBFnOYYMQU3yjSvpxYGme0IODeA6JSpfAJBq+gyhhkv8bKtKio
	QxMiQwXEp5BPHnS73aU1OHDQzaVydewpZCdO7czyvHsdDZmrFLb3GHgbVr47eFA+QJEdz5uYTIo
	MaSTwuSNoiHeHAUWRspohnzML7V8Ak+dEYu5GYfsmJ9bXkY7sjzGXKgAub7ahObZ386j2ReelP8
	MCgPZzuZY6Xsf+Sp9Z4yE4y95pJEiodA+jYLeRUePHrdZ8ximwhlnJjubtm01FDU1FMFxbyHIRg
	zNXlQbL4z1hcZ+3tdmph7eBIJhJQ==
X-Received: by 2002:a17:902:f745:b0:2a7:9163:8e60 with SMTP id d9443c01a7336-2a7916393a6mr21147595ad.23.1768988570185;
        Wed, 21 Jan 2026 01:42:50 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([38.76.140.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a770945806sm40536875ad.70.2026.01.21.01.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:42:49 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	yatsenko@meta.com,
	bentiss@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH bpf] selftests/bpf: Fix resource leak in serial_test_wq on attach failure
Date: Wed, 21 Jan 2026 17:41:16 +0800
Message-ID: <20260121094114.1801-3-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When wq__attach() fails, serial_test_wq() returns early without calling
wq__destroy(), leaking the skeleton resources allocated by
wq__open_and_load(). This causes ASAN leak reports in selftests runs.

Fix this by jumping to a common clean_up label that calls wq__destroy()
on all exit paths after successful open_and_load.

Note that the early return after wq__open_and_load() failure is correct
and doesn't need fixing, since that function returns NULL on failure
(after internally cleaning up any partial allocations).

Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 15c67d23128b..84831eecc935 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -16,12 +16,12 @@ void serial_test_wq(void)
 	/* re-run the success test to check if the timer was actually executed */
 
 	wq_skel = wq__open_and_load();
-	if (!ASSERT_OK_PTR(wq_skel, "wq_skel_load"))
+	if (!ASSERT_OK_PTR(wq_skel, "wq__open_and_load"))
 		return;
 
 	err = wq__attach(wq_skel);
 	if (!ASSERT_OK(err, "wq_attach"))
-		return;
+		goto clean_up;
 
 	prog_fd = bpf_program__fd(wq_skel->progs.test_syscall_array_sleepable);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
@@ -31,6 +31,7 @@ void serial_test_wq(void)
 	usleep(50); /* 10 usecs should be enough, but give it extra */
 
 	ASSERT_EQ(wq_skel->bss->ok_sleepable, (1 << 1), "ok_sleepable");
+clean_up:
 	wq__destroy(wq_skel);
 }
 
-- 
2.34.1

