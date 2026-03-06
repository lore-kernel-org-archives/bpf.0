Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D174528726D
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786070; cv=none; b=aUBdRmLI5SIRfQd7A3NCVOvvS+t79OFQcKpj2fHXf2QdkR/ZdHcAYTe2kU8b5xQotnkb6c72cQ0uoJ6BF9htCOQ+OF1nKcOYWJqo3W/7f9/lLwBwUd3bEvGPS/eB/rLr9Djs+Q9/7qk/snNSk4FDD8A/cvtNknSW9pcB8UenC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786070; c=relaxed/simple;
	bh=FSnCQteshzTgEgQDW6fDbzB6myPWp+OkWX0DrDYnzaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mrjs1kiEP/UnpEYeO2qP6plhmE8e81WeUN0s0VT4p3B5tb+KLWlFhQuLNbWz2vMU77/qf/keoKdpM5MINnwnDSqu7gv/PcOJEvCjKOqT0rLOFLBMi64Oko9Cm9cbRKVCy0IoUk5+Yz8Nky954eAYbjoEp8V277HOx3k/XQFsRgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1sf3a+t; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1sf3a+t"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2be19f05d7dso2680477eec.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 00:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772786068; x=1773390868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTYaTMIfl3qpAKJQP5PrqqDEAZm6BYMm6jHkGQYMhoY=;
        b=D1sf3a+tijpotJsmUide+g7T6CZUR6tgVkVjOwhdn/9yuumuHrGoo9JJ5Vdy5+YWkq
         byaCfk4zAnxgnSUYjCIfOM7FyQ2PVhwQNr1L2mWG5jGE9H61V6Tp3y2lEiLxpLr2rRdW
         vlQiJfsjouU//IWEVHuI0aTzyCPVriAJvG4O3tl9TAKX1fMaNhul98KQXuiH6vkfSSA/
         0IB/CYEEQIcXYJFhThSuNpWct8AfffcbbYuSBzAFb5ipIY+ND7n2O/b7qO/dLelnPfxx
         TBaIXvJLn2GSgGBdrql66CCkOEy1PDlogMVuEZoRQjok2PaTDItgR93sEpb8ePPnxvKb
         ZzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772786068; x=1773390868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTYaTMIfl3qpAKJQP5PrqqDEAZm6BYMm6jHkGQYMhoY=;
        b=cRVo4C29GnLdfxkubxTYDy4N795uJP2tn7Z1bIeMCipPeo7f/Doj2QyTjdu0ML9T6o
         P4W5e8WZj3ZlWzxwoH+Y0BNNZfa98hi4ZyN4V94cnqyKUulOlpFrObRubCaa5LM3Fhwr
         lhyesBNK8uzAznP/W0VvtOwwJpsv7VawT/APt9DGbuAIdaRe1nTLvUfJx115y79i/AcI
         9WUeSsBWxmMu6AEXVIiAM91lp5/JAZSIGwLSGRHGfODS2inFIGtf3bn1ZfnjhbckGHD7
         0OmqVV+PrEQk4m76EmBR5FOloxRvzWyEMh/kq2+1OZQN0FLvt7aF5Qo8guP7Sw1P4qbk
         OXoA==
X-Gm-Message-State: AOJu0Yy6DRSIC1H2gFt1CCM+6CrEnbMoTpSrFdddDyJUnJPBh8c8DMXj
	zU2R2CoXfZO1mkIp99movNT9eGhe+94w7hffiEYDsaE9vL7bstFsz1Zp
X-Gm-Gg: ATEYQzzvPJEOKsabfj84ujss5MIxwvzf1k6OYt3VDj7TXBXqK8xCzY4WprbDeccDYmM
	Nxb6+odprZ9ZRD6HH3RgiVE7dp76v05Hscn/DN8xCjw7Y/s+p6PPits81aDRXLYUAtr38BsE9cY
	e18Dig/3KGItj9ZQueAw7wVLzfn1pTcV6mrYE3ZX+Zzl3b3uOOTGoVP+kcaX5BoaIMDYE/AKcT4
	CaVMqs9GSAZbEWXRVDO95+T4IWB6enxBEvcLfz3dtljzpGyJHccIuOsXywS5WDXPdS8uajh2UPJ
	W6nfabAo8685dCQtVEoBseK/beN/LM9ADrM6hzKqHfCeBLv3a8c1CzJdPBO9X9RFtlN3ypeJg8L
	juA4iHZkfW4gdTeHhHJ2LvNKyf5IzOIujSa3n5zNDQKF7pGaBHkfJ1sw3mYD+exyAVs7mBd+27c
	cdG+Omy7XzC2YD4ZWZIMQzrdvAWCzuFX4yPF1iiM8WbmeifPz2ksEbkueiXFQBmXfbjo09hS61c
	se8rrrwBooBc8iNZhgBGMY=
X-Received: by 2002:a05:7300:fd0e:b0:2b7:f145:a94 with SMTP id 5a478bee46e88-2be4e04c366mr580288eec.30.1772786067653;
        Fri, 06 Mar 2026 00:34:27 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f807a30sm680324eec.6.2026.03.06.00.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 00:34:27 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v3 1/2] selftests/bpf: filter by pid to avoid cross-test interference
Date: Fri,  6 Mar 2026 16:33:29 +0800
Message-ID: <20260306083330.518627-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
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

v3:
- use ASSERT_*() instead of CHECK() for the new checks
- simplify patch subject as suggested by Andrii

 .../selftests/bpf/prog_tests/probe_user.c     | 26 ++++++++++++++++++-
 .../selftests/bpf/progs/test_probe_user.c     | 13 ++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
index 8721671321de..b3e17a329cb4 100644
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
@@ -34,6 +39,23 @@ void serial_test_probe_user(void)
 			goto cleanup;
 	}
 
+	{
+		struct bpf_map *bss_map;
+		struct test_pro_bss bss_init = {};
+
+		bss_init.test_pid = getpid();
+		bss_map = bpf_object__find_map_by_name(obj, "test_pro.bss");
+		if (!ASSERT_OK_PTR(bss_map, "find_bss_map"))
+			goto cleanup;
+		if (!ASSERT_EQ(bpf_map__value_size(bss_map), sizeof(bss_init),
+			       "bss_size"))
+			goto cleanup;
+		err = bpf_map__set_initial_value(bss_map, &bss_init,
+						 sizeof(bss_init));
+		if (!ASSERT_OK(err, "set_bss_init"))
+			goto cleanup;
+	}
+
 	err = bpf_object__load(obj);
 	if (CHECK(err, "obj_load", "err %d\n", err))
 		goto cleanup;
@@ -62,11 +84,13 @@ void serial_test_probe_user(void)
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
 

base-commit: 7dff99b354601dd01829e1511711846e04340a69
-- 
2.43.0

