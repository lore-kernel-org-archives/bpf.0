Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821733260D
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892846; cv=none; b=uFtl7TZe0fh9e63mdrQSuiXBfZuvhtm1w2O2txzk6ukdy8FAtgbs9EsMBefKXiiW7gCVK/+nniS++ogkNw+z4jNTlGTg8jiwarM08mJZq4QRH/UMybj0lB3zu8oKuJQHakTnigicn2cJPNQdNbdoNs9t441mu8jahVtnr5ifpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892846; c=relaxed/simple;
	bh=AAPHlAQrFQR1xvfgM4iKvyqATfE+MKxM7mO+Dzlvmj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtHAUnuefbAEe2WzIhxk4AgKyh52v80aK814686qZ/PUIX+cSW1E8OTci16eVMdI/50zlHcBOymiGlpmU2jtIm64ma3J8xyejwESkSMtIpFMMiSsbQIJV9xQIV+t+74PF8v/F8YFc4dIrfT94DpdHhWWxfoJKhCRUp1b2NtjU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjEaC+Ml; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjEaC+Ml"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f1dcd5886so358249b3a.2
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 00:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775892844; x=1776497644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLfeDWNoCeDVDZa7GvuHeIvUR898p9yzBhe/kIboWmU=;
        b=KjEaC+MluXwXvJwJehfzes2tlLHkOJuu8KIM/xGdX+YKQrnpBUmXYv31Oh1VPb14m1
         9dqYseyafPqPJ8fmtZ01gb3e5xM6qBOiml4hwPo4SNX5LiUP/joKgiYV2XKVKapnleUl
         4/3+9SqbTH3ChqvYcgEgZQ/ws9MJurWP576Oyb0BHXdMPjgOrPS/zlgCUiVRAlxhSysW
         oYZJwsBYEQu2Mh8LyeUHYl7tN4XXsaaMWBqXp2eEYJyAF0wKvcB8POi9ZBAImpS0LB6t
         FNgfeBvi5y9ujwbfSiRu5fgqmBgDofwnv9kJWJ0diUXxg4fAY9Ujhsv0nWj8VL29uxuQ
         ixng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775892844; x=1776497644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nLfeDWNoCeDVDZa7GvuHeIvUR898p9yzBhe/kIboWmU=;
        b=bFsI9WW04QCvm0Rm5n9iTMgpMRFVa3YeEbmOUqAl8QVlEY3L8Teql023/xIFEE4Ouk
         SK9HQ9x96XscmpL5ZWFry+eL5EW1SYi6VFuFRXS1SMJXug6DT+tRgNxp9BRQpp1fOAAw
         BtyIBcrb/GIiTphiTtRIZMGFO/YpB1sJcMyS6LbLQUia8KsR7kvAXXxcEOk8y0MPazDW
         jvRWudFvlnDwZDvna67uq8ZQSXoXowH1fvCSWd1KpjSMOqLrKayeynzA4+ddHB/zm3Dz
         6hi0TW1EeB4Uun/YT/QH5U+NgliIWCd16tKTFHp+n5fXXTVpfqJBf1Vr/s/AqhdWYlti
         8YYQ==
X-Gm-Message-State: AOJu0Yxq5qfQKswEkrKfTbCH5TTY2eOD2byfVsFJedgMf5Yp9eBypMKX
	pnwSAdelldhl6WsfHQBRfMjBX2jI+4UJ3+/KobJ9OLFDKZB8Wj8HrlBJ7zf3zQ==
X-Gm-Gg: AeBDiev3Jfi9NN3ZpsOUHZp0GOda1cwD4+nWCgen+v2J9jefa4ic9efTfwFqO/SvDF7
	0zXT1tnX81Dr47jc4Ghvx8V8sMKC9ds1pUU9BpvZMBc2aq5KeT1K4hEauKWAzmfPbdYgXNjz7Em
	p3k7lCzP4f8g+8b4WgGX30b79ublP444MjNXARc+gKtfNWMZO3x0XblzKnAWxMOzumRgxNEyG92
	+T8qY2DbnyzcpiL6zHB13JbS/NkTsulafF44WNm+zSxCdXqi+OVg3YtDH4kRZaPUV645q1IwN6H
	a3shTTSYGN7ay1SJMy3AyillgBUPzOhn/iUQmGF6urPJEE2w6sDp3DAHRjc6lpk2sGMdMSTwHIS
	/X6Ak/8XJCJ36EkxVhRqEw0XwhwpOdLPsgEU/gILOF2B0kM9Poq+fpsGGmRdxsiNUNzsVTLEf9C
	PP/oElkTHZb1u7VkxAlgaLLkLJmB17m/sZ8jS2HGcI9VJzWLwUmG+3nrcyK6Mf3//LB+54o4ZEh
	exXjg==
X-Received: by 2002:a05:6a00:f99:b0:823:9c6:1985 with SMTP id d2e1a72fcca58-82f0c288c79mr6657011b3a.16.1775892843908;
        Sat, 11 Apr 2026 00:34:03 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30f5c3sm4965388b3a.3.2026.04.11.00.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 00:34:03 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	cupertino.miranda@oracle.com,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: impose global ordering for test decl_tags
Date: Sat, 11 Apr 2026 00:33:46 -0700
Message-ID: <20260410-selftests-global-tags-ordering-v2-3-c566ec9781bf@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-selftests-global-tags-ordering-v2-0-c566ec9781bf@gmail.com>
References: <20260410-selftests-global-tags-ordering-v2-0-c566ec9781bf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Impose global ordering for all decl tags used by test_loader.c based
tests (__success, __failure, __msg, etc):
- change every tag to expand as
  __attribute__((btf_decl_tag("comment:" XSTR(__COUNTER__) ...)))
- change parse_test_spec() to collect all decl tags before
  processing and sort them using strverscmp().

The ordering is necessary for gcc-bpf.
Neither GCC nor the C standard defines the order in which function
attributes are consumed. While Clang tends to preserve definition order,
GCC may process them out of sequence. This inconsistency causes BPF
tests with multiple __msg entries to fail when compiled with GCC.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  60 +++++-----
 tools/testing/selftests/bpf/test_loader.c    | 167 +++++++++++++++------------
 2 files changed, 124 insertions(+), 103 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 7e99fe8555e0..dcd78a3a9052 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -130,39 +130,41 @@
  * __linear_size     Specify the size of the linear area of non-linear skbs, or
  *                   0 for linear skbs.
  */
-#define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
-#define __not_msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_not_msg=" XSTR(__COUNTER__) "=" msg)))
-#define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" XSTR(__COUNTER__) "=" msg)))
-#define __jited(msg)		__attribute__((btf_decl_tag("comment:test_jited=" XSTR(__COUNTER__) "=" msg)))
-#define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
-#define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
-#define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
-#define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
-#define __not_msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_not_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
-#define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" XSTR(__COUNTER__) "=" msg)))
-#define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited_unpriv=" XSTR(__COUNTER__) "=" msg)))
-#define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
-#define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
-#define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
-#define __flag(flag)		__attribute__((btf_decl_tag("comment:test_prog_flags="#flag)))
-#define __retval(val)		__attribute__((btf_decl_tag("comment:test_retval="XSTR(val))))
-#define __retval_unpriv(val)	__attribute__((btf_decl_tag("comment:test_retval_unpriv="XSTR(val))))
-#define __auxiliary		__attribute__((btf_decl_tag("comment:test_auxiliary")))
-#define __auxiliary_unpriv	__attribute__((btf_decl_tag("comment:test_auxiliary_unpriv")))
-#define __btf_path(path)	__attribute__((btf_decl_tag("comment:test_btf_path=" path)))
-#define __arch(arch)		__attribute__((btf_decl_tag("comment:test_arch=" arch)))
+#define __test_tag(tag)		__attribute__((btf_decl_tag("comment:" XSTR(__COUNTER__) ":" tag)))
+
+#define __msg(msg)		__test_tag("test_expect_msg=" msg)
+#define __not_msg(msg)		__test_tag("test_expect_not_msg=" msg)
+#define __xlated(msg)		__test_tag("test_expect_xlated=" msg)
+#define __jited(msg)		__test_tag("test_jited=" msg)
+#define __failure		__test_tag("test_expect_failure")
+#define __success		__test_tag("test_expect_success")
+#define __description(desc)	__test_tag("test_description=" desc)
+#define __msg_unpriv(msg)	__test_tag("test_expect_msg_unpriv=" msg)
+#define __not_msg_unpriv(msg)	__test_tag("test_expect_not_msg_unpriv=" msg)
+#define __xlated_unpriv(msg)	__test_tag("test_expect_xlated_unpriv=" msg)
+#define __jited_unpriv(msg)	__test_tag("test_jited_unpriv=" msg)
+#define __failure_unpriv	__test_tag("test_expect_failure_unpriv")
+#define __success_unpriv	__test_tag("test_expect_success_unpriv")
+#define __log_level(lvl)	__test_tag("test_log_level=" #lvl)
+#define __flag(flag)		__test_tag("test_prog_flags=" #flag)
+#define __retval(val)		__test_tag("test_retval=" XSTR(val))
+#define __retval_unpriv(val)	__test_tag("test_retval_unpriv=" XSTR(val))
+#define __auxiliary		__test_tag("test_auxiliary")
+#define __auxiliary_unpriv	__test_tag("test_auxiliary_unpriv")
+#define __btf_path(path)	__test_tag("test_btf_path=" path)
+#define __arch(arch)		__test_tag("test_arch=" arch)
 #define __arch_x86_64		__arch("X86_64")
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
-#define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" EXPAND_QUOTE(caps))))
-#define __load_if_JITed()	__attribute__((btf_decl_tag("comment:load_mode=jited")))
-#define __load_if_no_JITed()	__attribute__((btf_decl_tag("comment:load_mode=no_jited")))
-#define __stderr(msg)		__attribute__((btf_decl_tag("comment:test_expect_stderr=" XSTR(__COUNTER__) "=" msg)))
-#define __stderr_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_stderr_unpriv=" XSTR(__COUNTER__) "=" msg)))
-#define __stdout(msg)		__attribute__((btf_decl_tag("comment:test_expect_stdout=" XSTR(__COUNTER__) "=" msg)))
-#define __stdout_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_stdout_unpriv=" XSTR(__COUNTER__) "=" msg)))
-#define __linear_size(sz)	__attribute__((btf_decl_tag("comment:test_linear_size=" XSTR(sz))))
+#define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
+#define __load_if_JITed()	__test_tag("load_mode=jited")
+#define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
+#define __stderr(msg)		__test_tag("test_expect_stderr=" msg)
+#define __stderr_unpriv(msg)	__test_tag("test_expect_stderr_unpriv=" msg)
+#define __stdout(msg)		__test_tag("test_expect_stdout=" msg)
+#define __stdout_unpriv(msg)	__test_tag("test_expect_stdout_unpriv=" msg)
+#define __linear_size(sz)	__test_tag("test_linear_size=" XSTR(sz))
 
 /* Define common capabilities tested using __caps_unpriv */
 #define CAP_NET_ADMIN		12
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index fa6147607c4d..066898d0c123 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 #include <linux/capability.h>
+#include <linux/err.h>
 #include <stdlib.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
@@ -20,34 +21,34 @@ static inline const char *str_has_pfx(const char *str, const char *pfx)
 
 #define TEST_LOADER_LOG_BUF_SZ 2097152
 
-#define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
-#define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
-#define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
-#define TEST_TAG_EXPECT_NOT_MSG_PFX "comment:test_expect_not_msg="
-#define TEST_TAG_EXPECT_XLATED_PFX "comment:test_expect_xlated="
-#define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
-#define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
-#define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
-#define TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV "comment:test_expect_not_msg_unpriv="
-#define TEST_TAG_EXPECT_XLATED_PFX_UNPRIV "comment:test_expect_xlated_unpriv="
-#define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
-#define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
-#define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
-#define TEST_TAG_RETVAL_PFX "comment:test_retval="
-#define TEST_TAG_RETVAL_PFX_UNPRIV "comment:test_retval_unpriv="
-#define TEST_TAG_AUXILIARY "comment:test_auxiliary"
-#define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
-#define TEST_BTF_PATH "comment:test_btf_path="
-#define TEST_TAG_ARCH "comment:test_arch="
-#define TEST_TAG_JITED_PFX "comment:test_jited="
-#define TEST_TAG_JITED_PFX_UNPRIV "comment:test_jited_unpriv="
-#define TEST_TAG_CAPS_UNPRIV "comment:test_caps_unpriv="
-#define TEST_TAG_LOAD_MODE_PFX "comment:load_mode="
-#define TEST_TAG_EXPECT_STDERR_PFX "comment:test_expect_stderr="
-#define TEST_TAG_EXPECT_STDERR_PFX_UNPRIV "comment:test_expect_stderr_unpriv="
-#define TEST_TAG_EXPECT_STDOUT_PFX "comment:test_expect_stdout="
-#define TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV "comment:test_expect_stdout_unpriv="
-#define TEST_TAG_LINEAR_SIZE "comment:test_linear_size="
+#define TEST_TAG_EXPECT_FAILURE "test_expect_failure"
+#define TEST_TAG_EXPECT_SUCCESS "test_expect_success"
+#define TEST_TAG_EXPECT_MSG_PFX "test_expect_msg="
+#define TEST_TAG_EXPECT_NOT_MSG_PFX "test_expect_not_msg="
+#define TEST_TAG_EXPECT_XLATED_PFX "test_expect_xlated="
+#define TEST_TAG_EXPECT_FAILURE_UNPRIV "test_expect_failure_unpriv"
+#define TEST_TAG_EXPECT_SUCCESS_UNPRIV "test_expect_success_unpriv"
+#define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "test_expect_msg_unpriv="
+#define TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV "test_expect_not_msg_unpriv="
+#define TEST_TAG_EXPECT_XLATED_PFX_UNPRIV "test_expect_xlated_unpriv="
+#define TEST_TAG_LOG_LEVEL_PFX "test_log_level="
+#define TEST_TAG_PROG_FLAGS_PFX "test_prog_flags="
+#define TEST_TAG_DESCRIPTION_PFX "test_description="
+#define TEST_TAG_RETVAL_PFX "test_retval="
+#define TEST_TAG_RETVAL_PFX_UNPRIV "test_retval_unpriv="
+#define TEST_TAG_AUXILIARY "test_auxiliary"
+#define TEST_TAG_AUXILIARY_UNPRIV "test_auxiliary_unpriv"
+#define TEST_BTF_PATH "test_btf_path="
+#define TEST_TAG_ARCH "test_arch="
+#define TEST_TAG_JITED_PFX "test_jited="
+#define TEST_TAG_JITED_PFX_UNPRIV "test_jited_unpriv="
+#define TEST_TAG_CAPS_UNPRIV "test_caps_unpriv="
+#define TEST_TAG_LOAD_MODE_PFX "load_mode="
+#define TEST_TAG_EXPECT_STDERR_PFX "test_expect_stderr="
+#define TEST_TAG_EXPECT_STDERR_PFX_UNPRIV "test_expect_stderr_unpriv="
+#define TEST_TAG_EXPECT_STDOUT_PFX "test_expect_stdout="
+#define TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV "test_expect_stdout_unpriv="
+#define TEST_TAG_LINEAR_SIZE "test_linear_size="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xbadcafe
@@ -352,33 +353,49 @@ static void update_flags(int *flags, int flag, bool clear)
 		*flags |= flag;
 }
 
-/* Matches a string of form '<pfx>[^=]=.*' and returns it's suffix.
- * Used to parse btf_decl_tag values.
- * Such values require unique prefix because compiler does not add
- * same __attribute__((btf_decl_tag(...))) twice.
- * Test suite uses two-component tags for such cases:
- *
- *   <pfx> __COUNTER__ '='
- *
- * For example, two consecutive __msg tags '__msg("foo") __msg("foo")'
- * would be encoded as:
- *
- *   [18] DECL_TAG 'comment:test_expect_msg=0=foo' type_id=15 component_idx=-1
- *   [19] DECL_TAG 'comment:test_expect_msg=1=foo' type_id=15 component_idx=-1
- *
- * And the purpose of this function is to extract 'foo' from the above.
- */
-static const char *skip_dynamic_pfx(const char *s, const char *pfx)
+static const char *skip_decl_tag_pfx(const char *s)
 {
-	const char *msg;
+	int n = 0;
 
-	if (strncmp(s, pfx, strlen(pfx)) != 0)
+	if (sscanf(s, "comment:%*d:%n", &n) < 0 || !n)
 		return NULL;
-	msg = s + strlen(pfx);
-	msg = strchr(msg, '=');
-	if (!msg)
-		return NULL;
-	return msg + 1;
+	return s + n;
+}
+
+static int compare_decl_tags(const void *a, const void *b)
+{
+	return strverscmp(*(const char **)a, *(const char **)b);
+}
+
+/*
+ * Compilers don't guarantee order in which BTF attributes would be generated,
+ * while order is important for test tags like __msg.
+ * Each test tag has the following prefix: "comment:" __COUNTER__,
+ * when sorted using strverscmp this gives same order as in the original C code.
+ */
+static const char **collect_decl_tags(struct btf *btf, int id, int *cnt)
+{
+	const char **tmp, **tags = NULL;
+	const struct btf_type *t;
+	int i;
+
+	*cnt = 0;
+	for (i = 1; i < btf__type_cnt(btf); i++) {
+		t = btf__type_by_id(btf, i);
+		if (!btf_is_decl_tag(t) || t->type != id || btf_decl_tag(t)->component_idx != -1)
+			continue;
+		tmp = realloc(tags, (*cnt + 1) * sizeof(*tags));
+		if (!tmp) {
+			free(tags);
+			return ERR_PTR(-ENOMEM);
+		}
+		tags = tmp;
+		tags[(*cnt)++] = btf__str_by_offset(btf, t->name_off);
+	}
+
+	if (*cnt)
+		qsort(tags, *cnt, sizeof(*tags), compare_decl_tags);
+	return tags;
 }
 
 enum arch {
@@ -424,7 +441,9 @@ static int parse_test_spec(struct test_loader *tester,
 	bool stdout_on_next_line = true;
 	bool unpriv_stdout_on_next_line = true;
 	bool collect_jit = false;
-	int func_id, i, err = 0;
+	const char **tags = NULL;
+	int func_id, i, nr_tags;
+	int err = 0;
 	u32 arch_mask = 0;
 	u32 load_mask = 0;
 	struct btf *btf;
@@ -447,20 +466,18 @@ static int parse_test_spec(struct test_loader *tester,
 		return -EINVAL;
 	}
 
-	for (i = 1; i < btf__type_cnt(btf); i++) {
+	tags = collect_decl_tags(btf, func_id, &nr_tags);
+	if (IS_ERR(tags))
+		return PTR_ERR(tags);
+
+	for (i = 0; i < nr_tags; i++) {
 		const char *s, *val, *msg;
-		const struct btf_type *t;
 		bool clear;
 		int flags;
 
-		t = btf__type_by_id(btf, i);
-		if (!btf_is_decl_tag(t))
+		s = skip_decl_tag_pfx(tags[i]);
+		if (!s)
 			continue;
-
-		if (t->type != func_id || btf_decl_tag(t)->component_idx != -1)
-			continue;
-
-		s = btf__str_by_offset(btf, t->name_off);
 		if ((val = str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX))) {
 			description = val;
 		} else if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
@@ -483,27 +500,27 @@ static int parse_test_spec(struct test_loader *tester,
 		} else if (strcmp(s, TEST_TAG_AUXILIARY_UNPRIV) == 0) {
 			spec->auxiliary = true;
 			spec->mode_mask |= UNPRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX))) {
 			err = push_msg(msg, false, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX))) {
 			err = push_msg(msg, true, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV))) {
 			err = push_msg(msg, false, &spec->unpriv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV))) {
 			err = push_msg(msg, true, &spec->unpriv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_JITED_PFX))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_JITED_PFX))) {
 			if (arch_mask == 0) {
 				PRINT_FAIL("__jited used before __arch_*");
 				goto cleanup;
@@ -515,7 +532,7 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				spec->mode_mask |= PRIV;
 			}
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_JITED_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_JITED_PFX_UNPRIV))) {
 			if (arch_mask == 0) {
 				PRINT_FAIL("__unpriv_jited used before __arch_*");
 				goto cleanup;
@@ -527,13 +544,13 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				spec->mode_mask |= UNPRIV;
 			}
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX))) {
 			err = push_disasm_msg(msg, &xlated_on_next_line,
 					      &spec->priv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV))) {
 			err = push_disasm_msg(msg, &unpriv_xlated_on_next_line,
 					      &spec->unpriv.expect_xlated);
 			if (err)
@@ -616,22 +633,22 @@ static int parse_test_spec(struct test_loader *tester,
 				err = -EINVAL;
 				goto cleanup;
 			}
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDERR_PFX))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDERR_PFX))) {
 			err = push_disasm_msg(msg, &stderr_on_next_line,
 					      &spec->priv.stderr);
 			if (err)
 				goto cleanup;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDERR_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDERR_PFX_UNPRIV))) {
 			err = push_disasm_msg(msg, &unpriv_stderr_on_next_line,
 					      &spec->unpriv.stderr);
 			if (err)
 				goto cleanup;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX))) {
 			err = push_disasm_msg(msg, &stdout_on_next_line,
 					      &spec->priv.stdout);
 			if (err)
 				goto cleanup;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV))) {
 			err = push_disasm_msg(msg, &unpriv_stdout_on_next_line,
 					      &spec->unpriv.stdout);
 			if (err)
@@ -734,9 +751,11 @@ static int parse_test_spec(struct test_loader *tester,
 
 	spec->valid = true;
 
+	free(tags);
 	return 0;
 
 cleanup:
+	free(tags);
 	free_test_spec(spec);
 	return err;
 }

-- 
2.53.0
