Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601810;
	b=uEbloUO8qkY0y3WAFp5cFH2s5ownPYcL6ozsRbrA2TqD53r/gKudpYgHmHb73l6e3Nvs
	 KTboDwCPOwaqrwrSzBcy0vPMfdzpWBWSQqpS4g4HKphd0tZv0SsYfHHAUOnDKeD8C5yrj
	 XyYMOdyJxpNz/eT2S/1apwp2OSs7aecmwob7ud2Q7Zmw+/z4VhajXz7NLzbLFZF4/gYxz
	 W/HHK0mrsHPC3fsqehh8n1sT2/m7n21biIzfYhE0ovOnOvuTJIgHNJg4YoeSt8AHq4JZj
	 oH+hfZ48cX1PqE5+NO9DGR5putaMOVxzHlKIZzzqaQ6PPcKG3cZAaji1nCnafndQmJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jLY1JvmnLhPCmMypd+jecwVeUpvAGEHEBr/LLKHd0fU=;
	b=CEIRN3me5ynk3EG0iCS1iAtVGJrkk98P/uHdRySWWnt0eBxLhM1gBOhQO8L5cadZ6PUl
	 2XhgyN7uDKqOwvYmKn/RKZiyWE7EgcRntlpAMc5yNUMGKEugJJiX74ilMvyrGmDgfpEib
	 qHlP4e7fY+ge2B/9nWB5KFUT9UDbqeXMGOgBdqCtSnCHXs2NCRwKNEP1R5ns937hZ15vQ
	 UyW9pvCLFZ/9LvejNOF4FtExLoxGJGN7ApRZMlU+qhRdVTgCJwK+OE23lCJpkhFg/UDOJ
	 ZCD9Fyi4WdX09QvN9nKKWyaK7gXkw18P4CG1xA+79pXD9F6VxlSqyPr8QMc3hOk76zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NySj10uw;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF29606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FF29606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NySj10uw
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so8623668a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 02:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795601808; x=1796206608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jLY1JvmnLhPCmMypd+jecwVeUpvAGEHEBr/LLKHd0fU=;
        b=NySj10uw1lrtCA18i09pa6NiTBQms2hOwIHXqULOt9dEf+x7SAv30b+iVT0USy99Ji
         q/cy+fj/fJX2QVZA7vz/8i23V6tHCAUxE0FdjNY6CS4SRgjEPbzHIJx1DEVqJkec/c3z
         EA07m+V/RuGPU5gSLriwDL2q1k8amDLNUVu/P+V1oRNk4Fy0N4RsToGfBv5ThU3TpGM2
         HhKY/cDVQ7ZJLTnleYeeJYytKphgV1eF0aBUkAPu6wHVCUezEa5GRZLQkmkq6325SoW5
         9tIUZ2l/hWD9zfsuW0/HPJhYrU201Zc1qT/5/HVP4zaaQjj080M0m7L0z7jQgusnDmku
         TiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601808; x=1796206608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jLY1JvmnLhPCmMypd+jecwVeUpvAGEHEBr/LLKHd0fU=;
        b=CCA6ADGN8MPI066izVLqNiD8nfW0uLFPa9+LtnH7Y1Aswwaxda+e/JTXG1lSUuLpDN
         6MDy6Fe8BnZbPbVpLcIifGHFAx7U8RlEql15Xz30EYQSXDljJRGA73+YS0w3f7zb+QTs
         9WAah4ZmtCLytcLvHJzW1BR9Yr4UPCAfn8olfn8k40il97hS44t27JZGYJwu8q1X18+X
         8ItDpyxoxYSb7TWbD4KDQwNyTrFBYVLaE2GN0K2RYI9cuMw6xexWOHoV0QrO4aONWhJ6
         7m+ca5QeNlg+sGduM8PEEJgbiUkAKbTmE+tb2vFlcWybsm2nqgeS6hViD4SiT2wS5bt2
         7Tfw==
X-Forwarded-Encrypted: i=1; AL+hErEY0jd7hgxW2slQVfpNjO8YN3MXjRiHn6tqbFbr9POF0ew8dBEZCiFuE+oTFZ4p43mxZHA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yxND13rTxme/g8ccg2zweR6/kcKxUB+S5I5e1J3Nl7Xj2VyWg
	ORlEJQob+suMAeUZf4Foc18sZlNty8dyxHjlxMMPgInRCq7Bggl78wkrt7JPKg==
X-Gm-Gg: AZFdTZctzFYCI7vRWC3k5wDdP5E8DJ4eGh4AfMsys7IBRk4tCfSKfpXfQ+R6V9sAXWP
	Kn/RCFZjtKzcsp3xZXAnnc8xT+9dGNmHwrAR7U4FGVnQs7KKsUYhn1+2Rt8VIxFA9t/VRs4H6Ju
	4W5NfpXcIlHPlwX8jTWUUuK8C1thUPbUOPR+0kfjscmm0xkFoFUUv0ym9fpfQYfVY9MgaH4OCkb
	UOtP5HgcHPHTV1+AmkpkcMBr2BrjQy/BGdU9JeUcDTkpdqMmATtY3l30Cg7T5+0w531XIh1ZdAv
	Hhd/uDhe8h4w7FABSgNO3gWOpbzW0eZvpnC8x6bMia9V9dXtnAwkKmbRPI19g2eYoj2y7zv0Ucz
	EL2o0QdblIuU5tYhj+C5b9Mm+F19JEry37NQc22SEAPorrosXGaJ3BnfyGefXGAW/LbPDNTHMvb
	zLI38OYAm4NCoK3dDLATKxPVGI25cy1Cjnb9rldt/pbaSQIU0Ps7kaa3MG1spswkeHSrMkxHUGW
	wJJmayJ9hTY+dcGXJ210nEP1SPE7Q+kvCPa2qVIA4OGxNOjdyI5CXh4/kqHydppND6ezPFTY9P+
	UfQ1MHLFdWEoGdSlPxdQiqIOCHyPzcf6SKH8E+JnFQerUoqL
X-Received: by 2002:a17:906:1955:b0:c40:4848:f7fa with SMTP id a640c23a62f3a-c513ab1dc62mr1093692366b.44.1795601808385;
        Wed, 25 Nov 2026 02:16:48 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm34765938f8f.29.2026.11.25.02.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:16:48 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 4/7] selftests/bpf: Test fmod_ret on a declared function that returns a pointer
Date: Wed, 25 Nov 2026 10:28:01 +0000
Message-ID: <20261125102810.699464-5-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125102810.699464-1-a.s.protopopov@gmail.com>
References: <20261125102810.699464-1-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_testmod_modify_return_ptr() to the error injection list.
Check that a program on it may return an error pointer but not
another value, and that an extension of a global function of such a
program loads.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/modify_return.c  | 44 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/err.h       |  5 +++
 .../selftests/bpf/progs/modify_return_ext.c   | 12 +++++
 .../selftests/bpf/progs/modify_return_ptr.c   | 43 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  7 +++
 5 files changed, 111 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/modify_return_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/modify_return_ptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
index 2417030f104a..2308609de69c 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -8,6 +8,8 @@
 #include <unistd.h>
 #include "modify_return.skel.h"
 #include "modify_return_width.skel.h"
+#include "modify_return_ptr.skel.h"
+#include "modify_return_ext.skel.h"
 
 #define LOWER(x) ((x) & 0xffff)
 #define UPPER(x) ((x) >> 16)
@@ -144,3 +146,45 @@ void test_modify_return_graph(void)
 out:
 	ASSERT_OK(rmdir(instance), "rmdir");
 }
+
+/* An extension of a global function of such a program */
+static void test_extension(void)
+{
+	struct modify_return_ptr *skel;
+	struct modify_return_ext *ext;
+	struct bpf_program *prog;
+
+	/* The function returns 64 bits */
+	if (!is_jit_enabled()) {
+		printf("%s:SKIP:JIT is disabled\n", __func__);
+		test__skip();
+		return;
+	}
+
+	skel = modify_return_ptr__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog, prog == skel->progs.calls_global);
+	if (!ASSERT_OK(modify_return_ptr__load(skel), "load"))
+		goto out;
+	ext = modify_return_ext__open();
+	if (!ASSERT_OK_PTR(ext, "open extension"))
+		goto out;
+	ASSERT_OK(bpf_program__set_attach_target(ext->progs.replace_global,
+						 bpf_program__fd(skel->progs.calls_global),
+						 "global_func"), "set_attach_target");
+	ASSERT_OK(modify_return_ext__load(ext), "load extension");
+	modify_return_ext__destroy(ext);
+out:
+	modify_return_ptr__destroy(skel);
+}
+
+/* NULL or an error from a declared function that returns a pointer */
+void test_modify_return_ptr(void)
+{
+	if (test__start_subtest("extension"))
+		test_extension();
+
+	RUN_TESTS(modify_return_ptr);
+}
diff --git a/tools/testing/selftests/bpf/progs/err.h b/tools/testing/selftests/bpf/progs/err.h
index 38529779a236..be3100752d35 100644
--- a/tools/testing/selftests/bpf/progs/err.h
+++ b/tools/testing/selftests/bpf/progs/err.h
@@ -25,4 +25,9 @@ static inline long PTR_ERR(const void *ptr)
 	return (long) ptr;
 }
 
+static inline void *ERR_PTR(long error)
+{
+	return (void *) error;
+}
+
 #endif /* __ERR_H__ */
diff --git a/tools/testing/selftests/bpf/progs/modify_return_ext.c b/tools/testing/selftests/bpf/progs/modify_return_ext.c
new file mode 100644
index 000000000000..80f70a1f452e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/modify_return_ext.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* An extension of a global function of an fmod_ret program, see prog_tests/modify_return.c */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("freplace")
+int replace_global(int x)
+{
+	return 7;
+}
diff --git a/tools/testing/selftests/bpf/progs/modify_return_ptr.c b/tools/testing/selftests/bpf/progs/modify_return_ptr.c
new file mode 100644
index 000000000000..9c9d5cf543f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/modify_return_ptr.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "err.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fmod_ret/bpf_testmod_modify_return_ptr")
+__load_if_JITed()
+__success
+void *BPF_PROG(error)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+/* For the extension of prog_tests/modify_return.c */
+__noinline int global_func(int x)
+{
+	/*
+	 * The barrier here is needed because otherwise clang can drop
+	 * the call, and there is nothing to replace
+	 */
+	barrier_var(x);
+	return x;
+}
+
+SEC("fmod_ret/bpf_testmod_modify_return_ptr")
+__load_if_JITed()
+__success
+void *BPF_PROG(calls_global)
+{
+	return global_func(0) ? ERR_PTR(-EINVAL) : NULL;
+}
+
+SEC("fmod_ret/bpf_testmod_modify_return_ptr")
+__failure __msg("should have been in [-4095, 0]")
+void *BPF_PROG(not_an_error)
+{
+	return (void *)1;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1fbc0061cc24..73d5992cc17a 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -774,6 +774,13 @@ noinline bool bpf_testmod_modify_return_bool(void)
 }
 ALLOW_ERROR_INJECTION(bpf_testmod_modify_return_bool, TRUE);
 
+noinline void *bpf_testmod_modify_return_ptr(void)
+{
+	asm volatile ("");
+	return NULL;
+}
+ALLOW_ERROR_INJECTION(bpf_testmod_modify_return_ptr, ERRNO);
+
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 		      const struct bin_attribute *bin_attr,
-- 
2.43.0

