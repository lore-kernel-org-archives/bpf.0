Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C430CDBB
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098313; cv=none; b=f83/SwFR3/SFwxdmH8t50g2eN0KQ5wJfrKyx+S/ZZ8x89MdvErOWRKrGaKMiUWskmcMA10OZY2RkS6HBcpF0u+6J2K8iLSkijDrMjViSmZjHqsClTU7LLvSnhUhdtlrimnqAkX0rFRCMLKuC3Ebx8drUm1hAfMPsXxmPWnrOgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098313; c=relaxed/simple;
	bh=XMrM4+Hj3SghIxgdaOrFD80PkaSmAH1qWcfG8RAykiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYcDene5VJRaediKws1GkfBEmUWiqCpo7EuFFr59MVaav4NCSzrSOZL1iC8fDyngNS6hZI2TprX54fQ+RrQxMvQXz6opdNZ62cAhSU2BMKgO8IxFlb75/mjSJYMZSp+QmooE4rCVeh1gbigMCeKiDvZn12qhGSfR2NgOsp07Zjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCjcbDBh; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCjcbDBh"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732e6a123so165013c88.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772098311; x=1772703111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tec9IvX19mzXZCyeb8uc2mz6TaJdE7CZsee6blSRk3g=;
        b=GCjcbDBhkNYLlpLHsBCqhIl7sZfJ8iuflzVpx+VT5yx3N0OJL6u7uipNviFbKjAruS
         5tcmeAqVkyBWbeaEbnTRDQmkL3VwDWYdsnLi/O7484GMEvOnI9qracTspZIkjT6BOyDR
         yIs4fdBtSqi+2Dn1AaxPGO0aOGe3dDtR/jX7zExIB1jalXmzxbBxSyUp7adZuYe6PK4k
         zYYapSw65E/Z/5k3gS9vp9BJ8bD4eCzMNR4u1YpZoufmnsRHrVeJfhooqHDwLwqDkvb5
         A9Gz1029sXvaUDQogW2xFlKT0WWfjCBkxgu2mD2ZNYJyXwv2WUPCOrmEAiTGjln4EsIw
         9h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098311; x=1772703111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tec9IvX19mzXZCyeb8uc2mz6TaJdE7CZsee6blSRk3g=;
        b=UucU6re8OeaU0bL6XGtSqWPuAVo9Gah3ZKJzQTWPYtKAeUo97HUQLCRS95q5L9m0Y8
         s4UQUXCJaZSIARUAO42iRntIYe+W9g0kZNe9Zwo1QFjHRwyhckAh48B0GEFn+IP96Zd6
         fwACJURC36r9HNjVs66iSYsH61OU5mEiDd69fhfBEoQBdSFVoVLB6MEb8W12h+R2Kg8q
         fm5ES/8k5QLyTiA/AvUBqvTtbnQ7mAGdO4UKyNpVefJfxQxygmTACZjfZVZQ0W+/iwzb
         1s0RKkoYcuWBimkMQq+/LguZfoIHgvFoKyjYGeSUqzELc7ss36zxIPPazfpxPFv48h2R
         Xn2A==
X-Forwarded-Encrypted: i=1; AJvYcCUkg2dA1Ag4Sn8cXH02eTCdaZtJbcO3BGCcc4rKT3Q7IhZIirlXJnGpc4wuOyGkJ5sKd/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMj0kIRcJbHg3upLP+8IzrGOwNFiNMCzLYF3aWlvMLmSL4ieuO
	xAMGb699EpCfY6WOPVThi4JqYJ0wB8suTl6omAMjOcy/+TcIdNB4lR7D
X-Gm-Gg: ATEYQzzcx9tn/ZkPQAJGCT2veTtbygKgGoJsk66roTa2j7+EVSo6Z7xEZfHEY/o2iaR
	rs/TX4RYfqrRbZte8G00SEvGjIFYab+HfMh40FmKW8ur9SS1aT1xhBrqy+7LwafJUO2PtUDjRbZ
	eDG4VU0f7uFcFLHaV/n/vC2lud88hsVBaHx9zon/uHBZed7s15lOPhhPFueYCZALzAFSFlhqZ4T
	r50EJfC7GxlzFfH5MfwzDuH7OJetGVR+ybPVfFwVK4LkaEKu4Xtu0pUyJG8F/U5EySQsJm53+lN
	3E+qhGorxffU7h6RrwJHkwj2RnPMcRv4aq+UX8W9IzFKb3UlYj3qoW27tAOG6mDxFB6ikd6N9Sg
	eK89sHsl/9LVNDRehmMiLzon01Sjg5Tvi6jpCW9SX61woXDdXjKJS3Ltv5dy3videfG8BJJ58dR
	A6TfcYU6enDD+cH/iakM1A1qt6NE/dS+lvYvwzx8spNSqiKsE7nsaVMJuylV0FZktDTCFCuMG12
	LCB5y8zgMFs3MYYsEtfW5E=
X-Received: by 2002:a05:7022:608e:b0:119:e569:fb96 with SMTP id a92af1059eb24-1276acda68bmr9380442c88.5.1772098311330;
        Thu, 26 Feb 2026 01:31:51 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43c12sm1771904c88.14.2026.02.26.01.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:31:50 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2 1/2] selftests/bpf: probe_user: filter by pid to avoid cross-test interference
Date: Thu, 26 Feb 2026 17:31:31 +0800
Message-ID: <20260226093132.437206-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226093132.437206-1-sun.jian.kdev@gmail.com>
References: <20260226093132.437206-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test installs a kprobe on __sys_connect and checks that
bpf_probe_write_user() can modify the syscall argument. However, any
concurrent thread in any other test that calls connect() will also
trigger the kprobe and have its sockaddr silently overwritten, causing
flaky failures in unrelated tests.

Constrain the hook to the current test process by filtering on a PID
stored as a global variable in .bss. Initialize the .bss value from
user space before bpf_object__load() using bpf_map__set_initial_value(),
and validate the bss map value size to catch layout mismatches.

No new map is introduced and the test keeps the existing non-skeleton
flow.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/probe_user.c     | 27 ++++++++++++++++++-
 .../selftests/bpf/progs/test_probe_user.c     | 13 +++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
index 8721671321de..280dcdb5ddef 100644
--- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
@@ -20,6 +20,11 @@ void serial_test_probe_user(void)
 	struct bpf_program *kprobe_progs[prog_count];
 	struct bpf_object *obj;
 	static const int zero = 0;
+	struct test_pro_bss {
+		struct sockaddr_in old;
+		__u32 test_pid;
+	};
+	struct test_pro_bss results = {};
 	size_t i;
 
 	obj = bpf_object__open_file(obj_file, &opts);
@@ -34,6 +39,24 @@ void serial_test_probe_user(void)
 			goto cleanup;
 	}
 
+	{
+		struct bpf_map *bss_map;
+		struct test_pro_bss bss_init = {};
+
+		bss_init.test_pid = getpid();
+		bss_map = bpf_object__find_map_by_name(obj, "test_pro.bss");
+		if (CHECK(!bss_map, "find_bss_map", "no bss map\n"))
+			goto cleanup;
+		if (CHECK(bpf_map__value_size(bss_map) != sizeof(bss_init),
+			  "bss_size", "bss value_size %u != %zu\n",
+			  bpf_map__value_size(bss_map), sizeof(bss_init)))
+			goto cleanup;
+		err = bpf_map__set_initial_value(bss_map, &bss_init,
+						 sizeof(bss_init));
+		if (CHECK(err, "set_bss_init", "err %d\n", err))
+			goto cleanup;
+	}
+
 	err = bpf_object__load(obj);
 	if (CHECK(err, "obj_load", "err %d\n", err))
 		goto cleanup;
@@ -62,11 +85,13 @@ void serial_test_probe_user(void)
 	connect(sock_fd, &curr, sizeof(curr));
 	close(sock_fd);
 
-	err = bpf_map_lookup_elem(results_map_fd, &zero, &tmp);
+	err = bpf_map_lookup_elem(results_map_fd, &zero, &results);
 	if (CHECK(err, "get_kprobe_res",
 		  "failed to get kprobe res: %d\n", err))
 		goto cleanup;
 
+	memcpy(&tmp, &results.old, sizeof(tmp));
+
 	in = (struct sockaddr_in *)&tmp;
 	if (CHECK(memcmp(&tmp, &orig, sizeof(orig)), "check_kprobe_res",
 		  "wrong kprobe res from probe read: %s:%u\n",
diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
index a8e501af9604..4bc86c7654b1 100644
--- a/tools/testing/selftests/bpf/progs/test_probe_user.c
+++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
@@ -5,13 +5,22 @@
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
 
-static struct sockaddr_in old;
+struct test_pro_bss {
+	struct sockaddr_in old;
+	__u32 test_pid;
+};
+
+struct test_pro_bss bss;
 
 static int handle_sys_connect_common(struct sockaddr_in *uservaddr)
 {
 	struct sockaddr_in new;
+	__u32 cur = bpf_get_current_pid_tgid() >> 32;
+
+	if (bss.test_pid && cur != bss.test_pid)
+		return 0;
 
-	bpf_probe_read_user(&old, sizeof(old), uservaddr);
+	bpf_probe_read_user(&bss.old, sizeof(bss.old), uservaddr);
 	__builtin_memset(&new, 0xab, sizeof(new));
 	bpf_probe_write_user(uservaddr, &new, sizeof(new));
 
-- 
2.43.0

