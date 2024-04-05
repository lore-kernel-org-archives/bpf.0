Received: from smtp5.epfl.ch (smtp5.epfl.ch [128.178.224.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F1634
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712348792; cv=none; b=o1LZ1UgdUuAMVAhNrD1kM9rjW0E4yL8X+cJOjBBy6UZKlMydcVTlBil9qo7Y3+eqMLG315fDQf+5nil8yqjjOX8SLtNf8ZuIchs0Wox1/HIuOPphiZMA94FUNKpAATu14xrSYxX6tEQE4ZmzrIM7oQyR75y2gK7OWZeiZ8VY/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712348792; c=relaxed/simple;
	bh=p6kDP9z27M8cTDH10t100JMbK/BPhMTRTvtqIxwZxh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDvTKEBNnwDRBWvIRDGGjGF3wLJGgcyXSjfzPFD+YoaYwb/hdVVKFaDYOBlwklNty0osPYw+fDdxtH5D/hDXZJD03aCMIh95rf+UyEmd8/+QFJVwqqQWT18E+301YhVfnJPW5y7vVJ+zRUgORlAuQXvuW5IQr5pGk2Kbb6jSaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=7Hak5hiD; arc=none smtp.client-ip=128.178.224.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="7Hak5hiD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1712348779;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=p6kDP9z27M8cTDH10t100JMbK/BPhMTRTvtqIxwZxh8=;
      b=7Hak5hiDMqH60prHt65ANNPL4ZLEkUs3TQDnewAn5WdeQ38xbAvyv//JSWUJTSRWF
        NHwZvk6urbqkmen8XKKcmWHAZQarRsoRKnds5eUPefioQOSGiaGcaKCCuOyFDuEjC
        Mf4Usnw2qb4tReoW2PjC0f7Gkl2I760MzDqAtX8bA=
Received: (qmail 903 invoked by uid 107); 5 Apr 2024 20:26:19 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Fri, 05 Apr 2024 22:26:19 +0200
X-EPFL-Auth: Ybur4Gjapr/dblrKFNAYwEwtiRSA1boVlH0FDjy9exQAC13urAc=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 22:26:19 +0200
From: Tao Lyu <tao.lyu@epfl.ch>
To: <andrii.nakryiko@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<john.fastabend@gmail.com>, <mathias.payer@nebelwelt.net>,
	<meng.xu.cs@uwaterloo.ca>, <sanidhya.kashyap@epfl.ch>, <tao.lyu@epfl.ch>
Subject: [PATCH bpf-next] bpf: Fix verifier error due to narrower scalar spill onto 64-bit spilled scalar slots
Date: Fri, 5 Apr 2024 22:26:07 +0200
Message-ID: <20240405202607.4146642-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEf4BzZL6dCZx8Mve1RYXRJ1JeA6xqZeYN0V4Jfr9Xg04vAZrg@mail.gmail.com>
References: <CAEf4BzZL6dCZx8Mve1RYXRJ1JeA6xqZeYN0V4Jfr9Xg04vAZrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ewa12.intranet.epfl.ch (128.178.224.187) To
 ewa07.intranet.epfl.ch (128.178.224.178)

When CAP_PERFMON and CAP_SYS_ADMIN (allow_ptr_leaks) are disabled,
the verifier previously aimed to reject partial overwrite on an 8-byte stack slot
that contains a spilled pointer.

However, it rejects all partial stack overwrites
as long as the targeted stack slot is a spilled register in that cap setting,
because it does not check if the stack slot is a spilled pointer.

Finally, incomplete checks will result in the rejection of valid programs,
which spill narrower scalar values onto scalar slots, as shown below.

0: R1=ctx() R10=fp0
; asm volatile ( @ repro.bpf.c:679
0: (7a) *(u64 *)(r10 -8) = 1          ; R10=fp0 fp-8_w=1
1: (62) *(u32 *)(r10 -8) = 1
attempt to corrupt spilled pointer on stack
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0.

Note that only when CAP_BPF or CAP_SYS_ADMIN are enabled,
are 64-bit scalars stored onto stacks marked as spilled scalars.

Thus, to reproduce this issue,
we can only assign CAP_BPF capability to the test.

However, the existing bpf selftest doesn't support setting specific caps.

So, I modified the test_loader.c and some related header files to
enabled set specific capabilities on a test with the following attributes:

__msg_caps(msg)
__failure_caps(caps)
__success_caps(caps)
__retval_caps(val)

Here, caps can be any combination of capabilities, like "CAP_BPF | CAP_PERFMON".

Finally, the issue is fixed by checking the spilled register type of targeted slots.

Fixes: ab125ed3ec1c ("bpf: fix check for attempt to corrupt spilled pointer")
Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 kernel/bpf/verifier.c                         |   1 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  13 ++
 .../selftests/bpf/progs/verifier_spill_fill.c |  18 ++
 tools/testing/selftests/bpf/test_loader.c     | 154 ++++++++++++++++--
 4 files changed, 169 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63749ad5ac6b..da575e295d53 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4493,6 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	 */
 	if (!env->allow_ptr_leaks &&
 	    is_spilled_reg(&state->stack[spi]) &&
+	    !is_spilled_scalar_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
 		return -EACCES;
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index fb2f5513e29e..b8dc0d73932f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -2,6 +2,10 @@
 #ifndef __BPF_MISC_H__
 #define __BPF_MISC_H__
 
+/* Expand a macro and then stringize the expansion */
+#define QUOTE(str) #str
+#define EXPAND_QUOTE(str) QUOTE(str)
+
 /* This set of attributes controls behavior of the
  * test_loader.c:test_loader__run_subtests().
  *
@@ -24,11 +28,15 @@
  *                   Multiple __msg attributes could be specified.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
  *
+ * __msg_caps        Same as __msg but for specified capabilities.
+ *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
+ * __success_caps    Expect program load success in specified cap mode.
  *
  * __failure         Expect program load failure in privileged mode.
  * __failure_unpriv  Expect program load failure in unprivileged mode.
+ * __failure_caps    Expect program load failure in specified cap mode.
  *
  * __retval          Execute the program using BPF_PROG_TEST_RUN command,
  *                   expect return value to match passed parameter:
@@ -38,6 +46,7 @@
  *                   - literal POINTER_VALUE (see definition below)
  *                   - literal TEST_DATA_LEN (see definition below)
  * __retval_unpriv   Same, but load program in unprivileged mode.
+ * __retval_caps     Same, but load program in specified cap mode.
  *
  * __description     Text to be used instead of a program name for display
  *                   and filtering purposes.
@@ -63,12 +72,16 @@
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
+#define __msg_caps(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_caps=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
+#define __failure_caps(caps)	__attribute__((btf_decl_tag("comment:test_expect_failure_caps="EXPAND_QUOTE(caps))))
+#define __success_caps(caps)	__attribute__((btf_decl_tag("comment:test_expect_success_caps="EXPAND_QUOTE(caps))))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
 #define __flag(flag)		__attribute__((btf_decl_tag("comment:test_prog_flags="#flag)))
 #define __retval(val)		__attribute__((btf_decl_tag("comment:test_retval="#val)))
 #define __retval_unpriv(val)	__attribute__((btf_decl_tag("comment:test_retval_unpriv="#val)))
+#define __retval_caps(val)	__attribute__((btf_decl_tag("comment:test_retval_caps="#val)))
 #define __auxiliary		__attribute__((btf_decl_tag("comment:test_auxiliary")))
 #define __auxiliary_unpriv	__attribute__((btf_decl_tag("comment:test_auxiliary_unpriv")))
 #define __btf_path(path)	__attribute__((btf_decl_tag("comment:test_btf_path=" path)))
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 85e48069c9e6..c3eb6f7cf0c2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include <../../../tools/include/linux/filter.h>
+#include "../cap_helpers.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
@@ -1244,4 +1245,21 @@ __naked void old_stack_misc_vs_cur_ctx_ptr(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("32-bit scalars should be able to overwrite 64-bit scalar spilled slots")
+__log_level(2)
+__success __success_unpriv
+__success_caps(CAP_BPF) __retval_caps(0)
+__naked void spill_32bit_onto_64bit_slot(void)
+{
+	asm volatile("					\
+	*(u64*)(r10 - 8) = 1;				\
+	*(u32*)(r10 - 8) = 1;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 524c38e9cde4..42701ec0212f 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -20,11 +20,15 @@
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
+#define TEST_TAG_EXPECT_FAILURE_CAPS "comment:test_expect_failure_caps="
+#define TEST_TAG_EXPECT_SUCCESS_CAPS "comment:test_expect_success_caps="
+#define TEST_TAG_EXPECT_MSG_PFX_CAPS "comment:test_expect_msg_caps="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
 #define TEST_TAG_RETVAL_PFX "comment:test_retval="
 #define TEST_TAG_RETVAL_PFX_UNPRIV "comment:test_retval_unpriv="
+#define TEST_TAG_RETVAL_PFX_CAPS "comment:test_retval_caps="
 #define TEST_TAG_AUXILIARY "comment:test_auxiliary"
 #define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
 #define TEST_BTF_PATH "comment:test_btf_path="
@@ -43,7 +47,8 @@ static int sysctl_unpriv_disabled = -1;
 
 enum mode {
 	PRIV = 1,
-	UNPRIV = 2
+	UNPRIV = 2,
+	CUSTCAPS = 4
 };
 
 struct test_subspec {
@@ -59,6 +64,8 @@ struct test_spec {
 	const char *prog_name;
 	struct test_subspec priv;
 	struct test_subspec unpriv;
+	struct test_subspec custom_caps;
+	__u64 caps;
 	const char *btf_custom_path;
 	int log_level;
 	int prog_flags;
@@ -133,6 +140,33 @@ static int parse_int(const char *str, int *val, const char *name)
 	return 0;
 }
 
+static int parse_caps(const char *str, __u64 *val, const char *name)
+{
+	int cap_flag = 0;
+	char *token = NULL, *saveptr = NULL;
+
+	char *str_cpy = strdup(str);
+	if (str_cpy == NULL) {
+		PRINT_FAIL("Memory allocation failed\n");
+		return -EINVAL;
+	}
+
+	token = strtok_r(str_cpy, "|", &saveptr);
+	while (token != NULL) {
+		errno = 0;
+		cap_flag = strtol(token, NULL, 10);
+		if (errno) {
+			PRINT_FAIL("failed to parse caps %s\n", name);
+			return -EINVAL;
+		}
+		*val |= (1ULL << cap_flag);
+		token = strtok_r(NULL, "|", &saveptr);
+	}
+
+	free(str_cpy);
+	return 0;
+}
+
 static int parse_retval(const char *str, int *val, const char *name)
 {
 	struct {
@@ -163,6 +197,22 @@ static void update_flags(int *flags, int flag, bool clear)
 		*flags |= flag;
 }
 
+static char *create_desc(const char *description, const char *suffix)
+{
+	int descr_len = strlen(description);
+	char *name;
+
+	name = malloc(descr_len + strlen(suffix) + 1);
+	if (!name) {
+		PRINT_FAIL("failed to allocate memory for unpriv.name\n");
+		return NULL;
+	}
+
+	strcpy(name, description);
+	strcpy(&name[descr_len], suffix);
+	return name;
+}
+
 /* Uses btf_decl_tag attributes to describe the expected test
  * behavior, see bpf_misc.h for detailed description of each attribute
  * and attribute combinations.
@@ -225,6 +275,20 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->unpriv.expect_failure = false;
 			spec->mode_mask |= UNPRIV;
 			has_unpriv_result = true;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_FAILURE_CAPS)) {
+			val = s + sizeof(TEST_TAG_EXPECT_FAILURE_CAPS) - 1;
+			err = parse_caps(val, &spec->caps, "test caps");
+			if (err)
+				goto cleanup;
+			spec->custom_caps.expect_failure = true;
+			spec->mode_mask |= CUSTCAPS;
+                } else if (str_has_pfx(s, TEST_TAG_EXPECT_SUCCESS_CAPS)) {
+			val = s + sizeof(TEST_TAG_EXPECT_SUCCESS_CAPS) - 1;
+			err = parse_caps(val, &spec->caps, "test caps");
+			if (err)
+				goto cleanup;
+			spec->custom_caps.expect_failure = false;
+			spec->mode_mask |= CUSTCAPS;
 		} else if (strcmp(s, TEST_TAG_AUXILIARY) == 0) {
 			spec->auxiliary = true;
 			spec->mode_mask |= PRIV;
@@ -243,6 +307,12 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_CAPS)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_CAPS) - 1;
+			err = push_msg(msg, &spec->custom_caps);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= CUSTCAPS;
 		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX)) {
 			val = s + sizeof(TEST_TAG_RETVAL_PFX) - 1;
 			err = parse_retval(val, &spec->priv.retval, "__retval");
@@ -258,6 +328,13 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->mode_mask |= UNPRIV;
 			spec->unpriv.execute = true;
 			has_unpriv_retval = true;
+		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX_CAPS)) {
+			val = s + sizeof(TEST_TAG_RETVAL_PFX_CAPS) - 1;
+			err = parse_retval(val, &spec->custom_caps.retval, "__retval_caps");
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= CUSTCAPS;
+			spec->custom_caps.execute = true;
 		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
 			val = s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
 			err = parse_int(val, &spec->log_level, "test log level");
@@ -311,22 +388,23 @@ static int parse_test_spec(struct test_loader *tester,
 	}
 
 	if (spec->mode_mask & UNPRIV) {
-		int descr_len = strlen(description);
-		const char *suffix = " @unpriv";
-		char *name;
-
-		name = malloc(descr_len + strlen(suffix) + 1);
+		char *name = create_desc(description, " @unpriv");
 		if (!name) {
-			PRINT_FAIL("failed to allocate memory for unpriv.name\n");
 			err = -ENOMEM;
 			goto cleanup;
 		}
-
-		strcpy(name, description);
-		strcpy(&name[descr_len], suffix);
 		spec->unpriv.name = name;
 	}
 
+	if (spec->mode_mask & CUSTCAPS) {
+		char *name = create_desc(description, " @caps");
+		if (!name) {
+			err = -ENOMEM;
+			goto cleanup;
+		}
+		spec->custom_caps.name = name;
+	}
+
 	if (spec->mode_mask & (PRIV | UNPRIV)) {
 		if (!has_unpriv_result)
 			spec->unpriv.expect_failure = spec->priv.expect_failure;
@@ -461,6 +539,28 @@ static int restore_capabilities(struct cap_state *caps)
 	return err;
 }
 
+static int set_capabilities(__u64 new_caps, struct cap_state *save_caps) {
+
+	int err;
+
+	/* Drop all bpf related caps */
+	err = drop_capabilities(save_caps);
+	if (err) {
+		PRINT_FAIL("failed to drop capabilities: %i, %s\n", err, strerror(err));
+		return err;
+	}
+
+	/* Set the specified caps */
+	err = cap_enable_effective(new_caps, NULL);
+	if (err) {
+		PRINT_FAIL("failed to set capabilities: %i, %s\n", err, strerror(err));
+		return err;
+	}
+
+	save_caps->initialized = true;
+	return 0;
+}
+
 static bool can_execute_unpriv(struct test_loader *tester, struct test_spec *spec)
 {
 	if (sysctl_unpriv_disabled < 0)
@@ -560,21 +660,34 @@ void run_subtest(struct test_loader *tester,
 		 size_t obj_byte_cnt,
 		 struct test_spec *specs,
 		 struct test_spec *spec,
-		 bool unpriv)
+		 int priv_level)
 {
-	struct test_subspec *subspec = unpriv ? &spec->unpriv : &spec->priv;
+	struct test_subspec *subspec = NULL;
 	struct bpf_program *tprog = NULL, *tprog_iter;
 	struct test_spec *spec_iter;
 	struct cap_state caps = {};
 	struct bpf_object *tobj;
 	struct bpf_map *map;
 	int retval, err, i;
-	bool should_load;
+	bool should_load, unpriv = (priv_level != PRIV);
+
+	switch (priv_level) {
+		case PRIV:
+			subspec = &spec->priv;
+			break;
+		case UNPRIV:
+			subspec = &spec->unpriv;
+			break;
+		case CUSTCAPS:
+			subspec = &spec->custom_caps;
+			break;
+		default:
+	}
 
 	if (!test__start_subtest(subspec->name))
 		return;
 
-	if (unpriv) {
+	if (priv_level == UNPRIV) {
 		if (!can_execute_unpriv(tester, spec)) {
 			test__skip();
 			test__end_subtest();
@@ -584,6 +697,11 @@ void run_subtest(struct test_loader *tester,
 			test__end_subtest();
 			return;
 		}
+	} else if (priv_level == CUSTCAPS) {
+		if (set_capabilities(spec->caps, &caps)) {
+			test__end_subtest();
+			return;
+		}
 	}
 
 	/* Implicitly reset to NULL if next test case doesn't specify */
@@ -714,11 +832,13 @@ static void process_subtest(struct test_loader *tester,
 
 		if (spec->mode_mask & PRIV)
 			run_subtest(tester, &open_opts, obj_bytes, obj_byte_cnt,
-				    specs, spec, false);
+				    specs, spec, PRIV);
 		if (spec->mode_mask & UNPRIV)
 			run_subtest(tester, &open_opts, obj_bytes, obj_byte_cnt,
-				    specs, spec, true);
-
+				    specs, spec, UNPRIV);
+		if (spec->mode_mask & CUSTCAPS)
+			run_subtest(tester, &open_opts, obj_bytes, obj_byte_cnt,
+				    specs, spec, CUSTCAPS);
 	}
 
 	for (i = 0; i < nr_progs; ++i)
-- 
2.34.1

