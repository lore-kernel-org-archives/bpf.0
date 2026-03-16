Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C632B989
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646464; cv=none; b=jDxORE86dtlVc9Iq+/AXjGq4aY4drI2imN/GAJ+Kpgaw9/FwSq2jCLdx6JIXHHAQVOLaXI0KYXv6Q1M7CU7obdQXcTgu8MUT4GqHDbPh7eb18JdRgrmxu8zahYN5bpSJTg+JUTNdRANzYhavehuD8/jeTcIKwdo+H3XY9WsZWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646464; c=relaxed/simple;
	bh=IqUaZKF+nwTuN1re1AFZQs0CX1BJ7DOi3AgNK8zWc1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smPQTUGteTG0O6unytYHBMG7Pug/qBXzGhU7/RTX9btaqNB2++wptZfqkvBrmtgri/mr4NmZrL/pZ6hwenJeRjQ6JvGTa/tgLs1Q1Ee6FLBLmRZPEenSJzreWAWZ5rLuLiu4lr4Oc0uKaqOdNeJdK7IjGNMvpgNI/xNo2enmvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM7hmDTk; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM7hmDTk"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79881805788so42489287b3.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773646461; x=1774251261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYofxbTxVeUb8gRUtgDsMF1YdvMI5jrpYMWP5TzQcpU=;
        b=SM7hmDTkx0DormTDHnC6ff6vhhLnift14Y7cpQ9C4xIVBTbjBniqAK3ZYFmYGK7YR8
         VoiBdN3ejONTZ/XWtcITaa2S/dp82UA1WL6CIh6cXXGW7hOP/IdA9Xc+Awoj5EOgyQTA
         +lGqgpY93gXykfoSMZFnz11wQ3Ha7KCdpLpc9+PQtnPQrvHtp3qkm7j3SQjSAuIlOrUc
         yD61tqj8Rim7j5X2vEPEa81Z9gw00yPFGQyDS+eQZryT3Dvv01ArfMxjATJWDWqlUVW2
         KQP9FxNEP7wT23x6hGdcAWo3bX7r8XwpUzDuvJDNbaeLYi2HVK30m4gAWSFcaoFJuPHc
         HmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773646461; x=1774251261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYofxbTxVeUb8gRUtgDsMF1YdvMI5jrpYMWP5TzQcpU=;
        b=T/Rqrbk1FlDV5BTkSBcsJbKHc40fb98voyrc7YTzRmBNjVrt7o9XqFc75KjXeYchi/
         rYsENRNMPClHcKE7/ImpLsdO8GSIZZtjxCpQ7mYYyrCmYVjOdKRssvWRqNtM1pfkbDP5
         xGD7qw53etbeGhC8hMbYhA2+OTSgeTtI79+GDmR5N2+KXtdGJKRSHcJfYDKDZPUO2QMb
         z8yol3YTV0NOHrODNNqDNU65EduCvIMNU0WdL9TlJKZ5UzIYenKBpJ3pCmgXgb7T3lJb
         36D9Akqp/B0uW1yhUlO2PmYdVWyT4982PnZ5GdvMujSO1pDDYST+vIuZudyHJGA+N6Xg
         5jTQ==
X-Gm-Message-State: AOJu0YwUa4kma7tPOzVcwbw8Lav4Wbtv4Aa0lS0OwCYnJ/DfWdX8J6WY
	P+2PJ5rIHHERvnsUadXBdyKJftVxsfygb1ZL9BRJqjUagTjeatjViHymPUetak7IVXpEMQ==
X-Gm-Gg: ATEYQzwyDbK0XtwC9TbpVR+loapjA7JGEsKV9XgbXRDYai5G0TKdzCCzQ8dXM3wh87a
	sA6i9igW0Z7l9faSMnjZeTtYGA5qs1FljiU/6kzg+q41SByuCZB6vwtIQnxAIoj1vYS0xu+7BF8
	DJ7mA6OkoZz9yE8HQv8/2qI6BHGq0bFO/PfotS+AjKoSf14GSN24+Qn98LsCjrcUNXHxfABw9YE
	4kESX4YtjzmPjn++3I/DAHPto425RXmgikR+qs5sAgcQKMK6NwF69wElkngB4n+MtjG6Lv8Fc1X
	HbOkSvC5q64gbOltiRSgjVf9q6mXgQbIMPP5bqZO4/z+55Cugh4ludfTw/zFU9eMkvmyXMVWbMI
	V6gZcC1up4dzMg5B+DJJK6zHRsrQfjfbXcPhtUuuNAdUYXW2/HiCB/wuZQvzKCTsmalT/UqXYMs
	vOKLHxQ4p/vv6V9YmmeEmNlVpa/rJZbppwPmMqGXpClp4jmGzTGRB/BoBs8WnMHbCNvODhjWeFM
	qN9UWm826yVPiRf8IcLIKYRSPLEHs4mpc7org==
X-Received: by 2002:a05:690c:4484:b0:796:2fde:5dbe with SMTP id 00721157ae682-79a1c1c0293mr112773817b3.44.1773646461577;
        Mon, 16 Mar 2026 00:34:21 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65a3bedcsm5250551d50.1.2026.03.16.00.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 00:34:21 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] selftests/bpf: restrict ns_current_pid_tgid updates to target task
Date: Mon, 16 Mar 2026 15:34:09 +0800
Message-ID: <20260316073409.4040-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ns_current_pid_tgid uses a shared syscall tracepoint for
current_pid_tgid tracepoint subtests. When selftests run in parallel,
unrelated tasks can trigger the same hook and overwrite BSS results,
causing false failures.

Store the expected pid/tgid in BSS and update user_pid/user_tgid only
when bpf_get_ns_current_pid_tgid() returns values matching the target
task.

This prevents unrelated tasks from interfering with the test, allows
dropping the serial-only restriction, and removes the obsolete TODO
comment.

Tested:
  ./test_progs -t current_pid_tgid
  ./test_progs -j$(nproc) -t current_pid_tgid

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c | 5 +++--
 .../testing/selftests/bpf/progs/test_ns_current_pid_tgid.c | 7 +++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 99c953f2be21..e3938bb48151 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -34,6 +34,8 @@ static int get_pid_tgid(pid_t *pid, pid_t *tgid,
 	bss->ino = st.st_ino;
 	bss->user_pid = 0;
 	bss->user_tgid = 0;
+	bss->expected_pid = *pid;
+	bss->expected_tgid = *tgid;
 	return 0;
 }
 
@@ -200,8 +202,7 @@ static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg)
 		return;
 }
 
-/* TODO: use a different tracepoint */
-void serial_test_current_pid_tgid(void)
+void test_current_pid_tgid(void)
 {
 	if (test__start_subtest("root_ns_tp"))
 		test_current_pid_tgid_tp(NULL);
diff --git a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
index 386315afad65..d02c182a7100 100644
--- a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
@@ -14,6 +14,8 @@ struct {
 
 __u64 user_pid = 0;
 __u64 user_tgid = 0;
+__u64 expected_pid = 0;
+__u64 expected_tgid = 0;
 __u64 dev = 0;
 __u64 ino = 0;
 
@@ -24,6 +26,11 @@ static void get_pid_tgid(void)
 	if (bpf_get_ns_current_pid_tgid(dev, ino, &nsdata, sizeof(struct bpf_pidns_info)))
 		return;
 
+	if (expected_pid && nsdata.pid != expected_pid)
+		return;
+	if (expected_tgid && nsdata.tgid != expected_tgid)
+		return;
+
 	user_pid = nsdata.pid;
 	user_tgid = nsdata.tgid;
 }

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.43.0

