Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC236176ADE
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 04:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772080273; cv=none; b=orM5g/CrR09vsXE66iBZJhVNyIhME7tzvyqER/46L1kOY5KFQ+ufUSfy8cMI8Ej/MojrMd4JKyT7Q0X7B70OS77QgRHN8ZAhlxy51UOj4fWcdpaGAFwwJzYj8jjMGMP3XgN3qam0O3pZLbFTJcDcttOTfvpeWR+I1aeIUTzqbbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772080273; c=relaxed/simple;
	bh=5jraBeYmgG8252FmRBrzJf92BKTiIEG6/8lfskM9Mxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLmaRdQQdTqDpz+lgiVIj6LmuNAAHDC/x5HQGtQss5kRqy58jqmtAJfHz5zal9PFayXkfwvJdX+1zLpBvisP7s0ADW9jFPcg/QCRqiW1RB6vaPMcCqr7biT9sn2BGPaOIUbGMCCZ0UtOQZHc5x7HsvrOToXE2G224Cu1N1Vrn4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9x/dkbO; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9x/dkbO"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d1872504cbso352363a34.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 20:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772080271; x=1772685071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oamm599iv63qWnUlEmQOb5Nx3oFT3efmJHEDOkbhJg=;
        b=h9x/dkbOrd9Fk1rjzuhtLcsvh9wPzcN0+W7CIYIVYS3D2I1jkgI4kW2wo36Y0elUMB
         PWEUNFzX3yHzKGG7ET7aKTesprrrXrqbZXjH4liMBkKeeki7ISiBX8Ohrt7PkdiRb3ML
         SeymeEl6BfpVhs98zxcuMQqJqgxOufv7kdhmvyEMdTUevtJ2asUfyTf3xy3hbaz7DOnw
         hup1uKFEzOY+gAsnQjP1KNuZ0EgixGM9yFYzC0HImpzmAbjsj4pZnuwl6R+FYsrAkJx6
         xn1Cw2n5S7VxpKw3W737X79/2/2D2HNNFVCncOnpIwVS2Pj0Iaxlg8ogjkqYx31uc7dd
         Bxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772080271; x=1772685071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8oamm599iv63qWnUlEmQOb5Nx3oFT3efmJHEDOkbhJg=;
        b=GK1fNV/2ab/hVNk6/SU7XjVCALvZIxY+bP9JSS6JBctCQtPOQ2zrY/cZbwQtyOjkUt
         3zwn+8G+To2ZpDtc7/36BONFzlo9AvvsjvUhWNCAHbFsLqRWUds5t7dkRvrT1PQKRJL+
         DYKs4IXwxTgIvE/5dkd+jWg8Ms7lkpYrP7ga5HSsvOCJdpLhf+rHwdHTTcpc26kw/dIl
         AjoB1a+5PVwLqpHssubKi1ETGnuWF6X6tt6R7LF2oe5lBGMC6dYvD95Y94clgN04aNW1
         KvUd4ypyg+ptjDOAs6kNeyixtpA66MNgaaT7lc1LEbSoI+FwwXQ3vPfMruNilVoB+kOE
         +6jQ==
X-Gm-Message-State: AOJu0YyouHtXor3tKnpHu+F6rP/CRCeXjb5XmxcYCe91+nVqLJHReTQd
	t3NLWPZUZ4PMc2FajqvzeS4HanbPA1Ab+oHDw2w7pihK3qb6/pMKlp4Nbb2enWuWMGPg3g==
X-Gm-Gg: ATEYQzzR4vX7th6r3jQQlQL1ogJSOUJduyXoxV6iDpwbmzao+M1TqLxxDXCnNDqTb5b
	BkQL+yQV1HECNTCCi4Lc/2upL0h4POaNLspBOWkuhDFXZn2O66Cvmv3g2VoCpjDAH9NrJjnS4jM
	TvgKawPVl1gEP2Ko+PTuZVRD4EmoFk/97rfL3T1PTj7lcSbrz58YsKCiDCLBAApyTfxFJUfydSt
	jeqbUL5iuo1O/haYsxbyJhNsP/XbT1mkDPcIbMJFDbuZEaBgfSfwS8v+qaGeEvGd+KG1beNS2CO
	BRjiIPoEa7+Bvp30cZEU1SUeC4HfSat15SGLgiJdmMJJFQbHGsEON18+qRbNZJb9lhVI7g11xpe
	+SAaKsMQEM+wb8eDn0X/A6FgYLc4At3M66/HSmGxT30oCVnBrMi5CIUI6XkDQTAu/87ZLuhw+kx
	TusL/4y1CfnzBRwoW1CeF6UcQO8GZHzczUFRfQlyKce8mdzZRq0XSJ1m7NCNbOsLJhOlBFQu/Uz
	24VCAdOvxP9uFW2W1H7uI0Nrt0Al2RQ2w==
X-Received: by 2002:a05:6830:6f86:b0:7cf:c665:8884 with SMTP id 46e09a7af769-7d585789ae6mr929067a34.17.1772080270989;
        Wed, 25 Feb 2026 20:31:10 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586653f81sm806659a34.23.2026.02.25.20.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:31:10 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH 1/2] selftests/bpf: probe_user: filter by pid to avoid cross-test interference
Date: Thu, 26 Feb 2026 12:29:48 +0800
Message-ID: <2697993e938a2f87084cfe92a4117525d700ac9b.1772079741.git.sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772079741.git.sun.jian.kdev@gmail.com>
References: <cover.1772079741.git.sun.jian.kdev@gmail.com>
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

Fix this by introducing a pid_map (BPF_MAP_TYPE_ARRAY) that stores the
test process's PID. The kprobe handler returns early if the current PID
does not match, confining the hook to the test process only.

Also remove the TODO comment that tracked this issue.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/probe_user.c     | 13 ++++++++++-
 .../selftests/bpf/progs/test_probe_user.c     | 22 +++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
index 8721671321de..f50ee4066759 100644
--- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
@@ -13,13 +13,15 @@ void serial_test_probe_user(void)
 	enum { prog_count = ARRAY_SIZE(prog_names) };
 	const char *obj_file = "./test_probe_user.bpf.o";
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts, );
-	int err, results_map_fd, sock_fd, duration = 0;
+	int err, results_map_fd, pid_map_fd, sock_fd, duration = 0;
 	struct sockaddr curr, orig, tmp;
 	struct sockaddr_in *in = (struct sockaddr_in *)&curr;
 	struct bpf_link *kprobe_links[prog_count] = {};
 	struct bpf_program *kprobe_progs[prog_count];
 	struct bpf_object *obj;
 	static const int zero = 0;
+	__u32 key = 0;
+	__u32 pid;
 	size_t i;
 
 	obj = bpf_object__open_file(obj_file, &opts);
@@ -38,6 +40,15 @@ void serial_test_probe_user(void)
 	if (CHECK(err, "obj_load", "err %d\n", err))
 		goto cleanup;
 
+	pid_map_fd = bpf_find_map(__func__, obj, "pid_map");
+	if (CHECK(pid_map_fd < 0, "find_pid_map", "err %d\n", pid_map_fd))
+		goto cleanup;
+
+	pid = getpid();
+	err = bpf_map_update_elem(pid_map_fd, &key, &pid, BPF_ANY);
+	if (CHECK(err, "update_pid_map", "err %d\n", err))
+		goto cleanup;
+
 	results_map_fd = bpf_find_map(__func__, obj, "test_pro.bss");
 	if (CHECK(results_map_fd < 0, "find_bss_map",
 		  "err %d\n", results_map_fd))
diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
index a8e501af9604..20a13b984fb0 100644
--- a/tools/testing/selftests/bpf/progs/test_probe_user.c
+++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
@@ -5,6 +5,24 @@
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} pid_map SEC(".maps");
+
+static __always_inline int pid_ok(void)
+{
+	__u32 key = 0, *expected_pid;
+
+	expected_pid =  bpf_map_lookup_elem(&pid_map, &key);
+	if (!expected_pid ||
+	    *expected_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+	return 1;
+}
+
 static struct sockaddr_in old;
 
 static int handle_sys_connect_common(struct sockaddr_in *uservaddr)
@@ -22,6 +40,8 @@ SEC("ksyscall/connect")
 int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in *uservaddr,
 		 int addrlen)
 {
+	if (!pid_ok())
+		return 0;
 	return handle_sys_connect_common(uservaddr);
 }
 
@@ -36,6 +56,8 @@ int BPF_KSYSCALL(handle_sys_socketcall, int call, unsigned long *args)
 	if (call == SYS_CONNECT) {
 		struct sockaddr_in *uservaddr;
 
+		if (!pid_ok())
+			return 0;
 		bpf_probe_read_user(&uservaddr, sizeof(uservaddr), &args[1]);
 		return handle_sys_connect_common(uservaddr);
 	}
-- 
2.43.0

