Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998341;
	b=P7A5Pr7W/qjvnyMZpZ+PBnevANtmw5Fp5LJnw8EumHkhO2hyskMFJLYZlVg2BjuAEF/j
	 kKfDLfObPSuGo37K8QVU37tA3N7nIaJM8X5hPW+wNjGsv+rBo0U81Qz8OES50gcym2PlN
	 s+UT0WOQIpZrX7qY+zDaJXetMeKOiVjLMyt92pDzSNeK8EXggbjNmCWJ2lHIVXx/98DMd
	 yQFbj5OnI4Yq8WtNl1IJft7T+PeG+ybxNfYGTT4W2QhCp5fyzuP51eIC/WT9Z5KIEbjdP
	 e5AUnfFKsXVrkljp0+8ofgepvz42ica1LXM1XNj8gR43LJcB+x1lil+XVQ1c9fiXhNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4bigZdO+UqDhXlTtw91r7FpVnHPJ87WxQN+Gmu/rwZ4=;
	b=uNuV2kINHalyw4SJ/BXd4e2PPNgygQVfl59A1VYX0vnY/RMrQx2fo98luYgUBHgG+isb
	 cOUys3Qc7PTmwnw7qazOA4ealeBINRWtautUkoz2jWhaIT0CfpH9OJg6mwC9b3Scd+vlg
	 d2FfZ0yPQY658BRN35uNpU7slAgYO2SQgTP3ejIyNdyV1qppFfTzAuxdP+SLr+MuJG5G7
	 scmCBvW1RyOUAKaOWwiGmwhgw3VDExBeTVA7tGzackC6dax/pelPZSmhPoSWyC+zCXsJj
	 KUfS3fTFX3Nbsh+4t7wQf8i9+duc9kYQluu+5xxg82L86taPXWt09lpCTTB+1O4AZ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CeJjeMMT;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E894606D807
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E894606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CeJjeMMT
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so432315e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998339; x=1794603139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4bigZdO+UqDhXlTtw91r7FpVnHPJ87WxQN+Gmu/rwZ4=;
        b=CeJjeMMTC8+6/flFdHO4eobpA7+OmiOVodKY+k6542YPpVaFdtrjAgkVVkiEdmon62
         m+hsRwbnk54k2J1CQPRyA0xeITjzuA9tbdg4OqJcgezSdDw3u2rgHVVYcB6NCNEoXwXt
         /NpyK9+NrOPVw9ni1K95tQxyNz8ROd0CI9qRv4NY4BeA5i0DvqpLmRYiArJ8MuIMIh+W
         R9a4frmo1D75ZZnambTGZKKiIH2Zgp6sAH8nfaeBNXJNiagG8oc4P4kpXGSCKFey38/V
         zcWVkRzbYfRjLg8tmDWpE3OxGUvpdoEFGdggGd+B6bjB1hMKXnZJTvUreGoUGiZEEwSv
         DyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998339; x=1794603139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4bigZdO+UqDhXlTtw91r7FpVnHPJ87WxQN+Gmu/rwZ4=;
        b=WWj87F4UeFMty8qYZpS5TEK63OMVJpaBz0i6RhUH6XSSXYPAVWq/U9GQELFd3beBP2
         Pjj/jbYTLeNn3XIXfIfITiaZYrjUV/RunWpcSY88D4NNf6Ar6Z2nE+enHWBZqP01QCke
         Hh5gpumJPhV2+mOv3dZE+FpVgOuPLoWi5R8LiCqgrxTirFWkHtaHq/OlJwaXzhqm9duZ
         aY+S6AIy+8xNecBSTL8mRdZDsCYWj+Cf3g5Oy6JMXGIZvJt2xJIoDiVHeHVGVM3kY+JI
         sWNIujAJs6AidaKhZ1b9HioIZMNb+SbvYEMJwv9IUnvjWZtg8gbhB4Gxd8JVM6DWxPWj
         5BEQ==
X-Forwarded-Encrypted: i=1; AKwUvBznI3XXdQIUMbnl8ABWPIpwtOXPd9jYhO1XoSSgCBYOGRmTai7S0bh+L1De5mPH+xd/wmM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5XU4vPLyjZ+0Ewvz5EXut2Wx6LUjaQwRrR1Zy/w6hrdBU2O6p
	/xjQV9eMLG7EplxbjWxJx+bEgd5nyJHR1iAr+h5OgIuR9SSNVGtL9o7S
X-Gm-Gg: AYBFou3SWfW7MmfAsf9icCh4qmvqX8S3z4pPRlyf+vuFj25pc5i5JKwi1BlFUn3p5as
	iJXe6pgwppGqZ0cpic2rtk3GfbRMUtSGF8CMmlHB7NluBvVW1UTi+vrSoWdf3c1UBU7GHlzBovP
	e70HZo2Al5jiw8OEgMr2acYTlfP3yxuJfAqRpnaSNCp3jYvp6iKS35mrwilItc/jVbk/gorDYaL
	qBWmqQ3hsJbneG1yIHJUd/LOYlwsxKi6ZALDZPTPiRJpMbNSulJSQcla4/gf6qXonWkKlCgoA7a
	i35s7yK7ti7Ezy8DGqQJV7lB9/rLvwjj+QE6o0Y+BGeJay3cnNcXhfMdqBE4TYXRNs5z83w6Gjz
	mCacdAreidsTOQmkaKJvFL+HfZVMAMsQlMIRs6Za0Jl0ly8iCSrlOX0zKZ2lz50IAIfQc8mc5Ct
	lERa3WVsrkzxXOqUbtm7h+ewddPLIdgTvGdRUTJ9025VhDhFHhOi1hYvuslUwAScKc3bAnslADP
	8rsn6FwXkgxV/3GmRjnJIr3C1IS2gZsuRrc/xOsuzEwuwKfAlqULrpHdWdDSVs2WKpbAwuiMLIg
	oAyvWOcaCf2Dy80IC5XdK62IDufPbVxIqrpDS/s9F77bnC8=
X-Received: by 2002:a05:600c:4e0e:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4b810df8c0fmr2722005e9.0.1793998339470;
        Fri, 06 Nov 2026 12:52:19 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:19 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 16/18] selftests/bpf: Test fmod_ret candidates found by bpf_scan_ir
Date: Fri,  6 Nov 2026 21:03:05 +0000
Message-ID: <20261106210314.1767267-16-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20261106205523.1765622-1-a.s.protopopov@gmail.com
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
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

Add bpf_testmod_retval.c to bpf_testmod with functions for bpf_scan_ir.
The "test_retval:" decl tag of each lists the values which bpf_scan_ir
must find. An empty list means that the function must not become an
fmod_ret target. Cover constant errors of both return widths,
assumptions, private stack writes, PHIs, sign extensions, PTR_ERR() of
an ERR_PTR() from an inlined helper, which is not recognized yet, errors
which are not known exactly, observable effects, a notrace function, a
function on the error injection list, a declared target, a weak
definition with an error which a strong one without errors in
bpf_testmod_retval_strong.c replaces and two weak definitions, of which
the one with an error in bpf_testmod_retval_strong.c loses the link.

Rename bpf_testmod.c to bpf_testmod_main.c so the module can consist of
several objects.

Build both files only with the plugin: their functions mean nothing
without it and bpf_testmod_retval.c uses clang extensions such as
__builtin_assume().

Check that the tags in the module BTF match. Check that the verifier
lets fmod_ret programs return only 0 or the listed values on every path,
in the low 32 bits for an int function and in all 64 bits for an s64
one. Declared targets and the static rules stay unrestricted. Check that
an extension cannot replace a function of an fmod_ret program with
restricted return values, neither at load nor when it is attached later,
and that such a program cannot use tail calls.

Skip the test when bpf_testmod has no "test_retval:" tags, that is when
it is built without the plugin.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/fmodret_retval.c | 205 ++++++++++++
 .../selftests/bpf/progs/fmodret_retval.c      | 196 +++++++++++
 .../selftests/bpf/progs/fmodret_retval_ext.c  |  44 +++
 .../testing/selftests/bpf/test_kmods/Makefile |  11 +-
 .../{bpf_testmod.c => bpf_testmod_main.c}     |   0
 .../bpf/test_kmods/bpf_testmod_retval.c       | 314 ++++++++++++++++++
 .../test_kmods/bpf_testmod_retval_strong.c    |  28 ++
 7 files changed, 797 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
 create mode 100644 tools/testing/selftests/bpf/progs/fmodret_retval.c
 create mode 100644 tools/testing/selftests/bpf/progs/fmodret_retval_ext.c
 rename tools/testing/selftests/bpf/test_kmods/{bpf_testmod.c => bpf_testmod_main.c} (100%)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval_strong.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c b/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
new file mode 100644
index 000000000000..abb0a9e331b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "fmodret_retval.skel.h"
+#include "fmodret_retval_ext.skel.h"
+
+#define TAG_FMODRET		"bpf_fmodret"
+#define TAG_RETVAL		"bpf_fmodret_retval:"
+#define TAG_TEST_RETVAL		"test_retval:"
+
+/* The decl tags of a function */
+struct func_tags {
+	const char *test_retval;
+	const char *retval;
+	bool target;
+};
+
+static bool tag_value(const char *name, const char *key, const char **value)
+{
+	size_t len = strlen(key);
+
+	if (strncmp(name, key, len))
+		return false;
+	*value = name + len;
+	return true;
+}
+
+/*
+ * Return the decl tags of the functions of module BTF, indexed by BTF ID. Only
+ * the types of the module itself are read, not those of its vmlinux base.
+ */
+static struct func_tags *collect_tags(const struct btf *btf, int start_id)
+{
+	int id, nr_types = btf__type_cnt(btf);
+	struct func_tags *tags;
+
+	tags = calloc(nr_types, sizeof(*tags));
+	if (!tags)
+		return NULL;
+	for (id = start_id; id < nr_types; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		struct func_tags *f;
+		const char *name;
+
+		if (!btf_is_decl_tag(t) || btf_decl_tag(t)->component_idx != -1 ||
+		    t->type >= nr_types)
+			continue;
+		f = &tags[t->type];
+		name = btf__name_by_offset(btf, t->name_off);
+		if (!tag_value(name, TAG_TEST_RETVAL, &f->test_retval) &&
+		    !tag_value(name, TAG_RETVAL, &f->retval) && !strcmp(name, TAG_FMODRET))
+			f->target = true;
+	}
+
+	return tags;
+}
+
+/* Compare the tags of every fixture with the values it expects */
+static void test_tags(const struct btf *btf, const struct func_tags *tags, int start_id)
+{
+	int id, nr_types = btf__type_cnt(btf), nr_fixtures = 0;
+
+	for (id = start_id; id < nr_types; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		const char *name;
+
+		if (!btf_is_func(t) || !tags[id].test_retval)
+			continue;
+		name = btf__name_by_offset(btf, t->name_off);
+		ASSERT_STREQ(tags[id].retval ?: "", tags[id].test_retval, name);
+		if (*tags[id].test_retval)
+			ASSERT_TRUE(tags[id].target, name);
+		else if (strcmp(name, "bpf_testmod_retval_declared"))
+			ASSERT_FALSE(tags[id].target, name);
+		nr_fixtures++;
+	}
+	ASSERT_GT(nr_fixtures, 0, "fixtures");
+
+	id = btf__find_by_name_kind(btf, "bpf_testmod_retval_declared", BTF_KIND_FUNC);
+	if (ASSERT_GE(id, start_id, "declared"))
+		ASSERT_TRUE(tags[id].target, "declared_target");
+}
+
+/* Open the programs again with only the extension, to replace FUNC of TARGET */
+static struct fmodret_retval_ext *open_extension(struct bpf_program *target,
+						 const char *func, char *log, size_t log_size)
+{
+	struct fmodret_retval_ext *skel;
+
+	skel = fmodret_retval_ext__open();
+	if (!ASSERT_OK_PTR(skel, "fmodret_retval_ext__open"))
+		return NULL;
+	bpf_program__set_autoload(skel->progs.restricted, false);
+	bpf_program__set_autoload(skel->progs.unrestricted, false);
+	if (!ASSERT_OK(bpf_program__set_attach_target(skel->progs.extension,
+						      bpf_program__fd(target), func),
+		       "set_attach_target")) {
+		fmodret_retval_ext__destroy(skel);
+		return NULL;
+	}
+	bpf_program__set_log_buf(skel->progs.extension, log, log_size);
+	return skel;
+}
+
+/*
+ * An extension could return any value for an fmod_ret program, so it must not
+ * replace one whose return values are restricted, neither at load nor when it
+ * is attached later to another program.
+ */
+static void test_extension(void)
+{
+	struct fmodret_retval_ext *targets, *skel = NULL;
+	struct bpf_link *link;
+	char log[4096] = {};
+
+	if (!is_jit_enabled()) {
+		printf("%s:SKIP:extensions need the JIT\n", __func__);
+		test__skip();
+		return;
+	}
+
+	targets = fmodret_retval_ext__open();
+	if (!ASSERT_OK_PTR(targets, "fmodret_retval_ext__open"))
+		return;
+	bpf_program__set_autoload(targets->progs.extension, false);
+	if (!ASSERT_OK(fmodret_retval_ext__load(targets), "load_targets"))
+		goto out;
+
+	skel = open_extension(targets->progs.restricted, "restricted_value", log, sizeof(log));
+	if (!skel)
+		goto out;
+	ASSERT_ERR(fmodret_retval_ext__load(skel), "load_restricted");
+	ASSERT_HAS_SUBSTR(log, "Cannot extend an fmod_ret program with restricted return values",
+			  "log_restricted");
+	fmodret_retval_ext__destroy(skel);
+
+	skel = open_extension(targets->progs.unrestricted, "unrestricted_value", log, sizeof(log));
+	if (!skel)
+		goto out;
+	if (!ASSERT_OK(fmodret_retval_ext__load(skel), "load_unrestricted"))
+		goto out;
+	link = bpf_program__attach_freplace(skel->progs.extension,
+					    bpf_program__fd(targets->progs.restricted),
+					    "restricted_value");
+	if (!ASSERT_ERR_PTR(link, "attach_restricted"))
+		bpf_link__destroy(link);
+	link = bpf_program__attach_freplace(skel->progs.extension,
+					    bpf_program__fd(targets->progs.unrestricted),
+					    "unrestricted_value");
+	if (ASSERT_OK_PTR(link, "attach_unrestricted"))
+		bpf_link__destroy(link);
+out:
+	fmodret_retval_ext__destroy(skel);
+	fmodret_retval_ext__destroy(targets);
+}
+
+void test_fmodret_retval(void)
+{
+	struct btf *vmlinux_btf, *btf = NULL;
+	struct func_tags *tags = NULL;
+	int id, start_id, nr_types;
+	bool has_fixtures = false;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "btf__load_vmlinux_btf"))
+		return;
+	btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (!btf && errno == ENOENT) {
+		printf("%s:SKIP:bpf_testmod has no BTF\n", __func__);
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK_PTR(btf, "btf__load_module_btf"))
+		goto out;
+	start_id = btf__type_cnt(vmlinux_btf);
+	nr_types = btf__type_cnt(btf);
+	tags = collect_tags(btf, start_id);
+	if (!ASSERT_OK_PTR(tags, "collect_tags"))
+		goto out;
+
+	/* The fixtures are built only with the compiler plugin */
+	for (id = start_id; id < nr_types && !has_fixtures; id++)
+		has_fixtures = tags[id].test_retval;
+	if (!has_fixtures) {
+		printf("%s:SKIP:bpf_testmod has no %s tags\n", __func__, TAG_TEST_RETVAL);
+		test__skip();
+		goto out;
+	}
+
+	if (test__start_subtest("tags"))
+		test_tags(btf, tags, start_id);
+	if (test__start_subtest("extension"))
+		test_extension();
+	RUN_TESTS(fmodret_retval);
+out:
+	free(tags);
+	btf__free(btf);
+	btf__free(vmlinux_btf);
+}
diff --git a/tools/testing/selftests/bpf/progs/fmodret_retval.c b/tools/testing/selftests/bpf/progs/fmodret_retval.c
new file mode 100644
index 000000000000..30fe15b97484
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fmodret_retval.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fmod_ret programs on the targets which the LLVM IR scanner finds in
+ * bpf_testmod, see test_kmods/bpf_testmod_retval.c. They may return only 0 or
+ * the values of the "bpf_fmodret_retval:" tag of their target.
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* bpf_testmod_retval_constant() returns -EINVAL */
+SEC("fmod_ret/bpf_testmod_retval_constant")
+__success
+int BPF_PROG(constant_einval, int ret)
+{
+	return -22;
+}
+
+SEC("fmod_ret/bpf_testmod_retval_constant")
+__success
+int BPF_PROG(constant_zero, int ret)
+{
+	return 0;
+}
+
+SEC("fmod_ret/bpf_testmod_retval_constant")
+__failure __msg("it should be 0 or one of -22")
+int BPF_PROG(constant_other, int ret)
+{
+	return -1;
+}
+
+SEC("fmod_ret/bpf_testmod_retval_constant")
+__failure __msg("it should be 0 or one of -22")
+__naked void constant_unknown(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* The function returns int, so only the low 32 bits count */
+SEC("fmod_ret/bpf_testmod_retval_constant")
+__success
+__naked void constant_32bit(void)
+{
+	asm volatile (
+	"w0 = -22;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* Not 0, so the function is not called, but the caller would see 0 */
+SEC("fmod_ret/bpf_testmod_retval_constant")
+__failure __msg("it should be 0 or one of -22")
+__naked void constant_high_bits(void)
+{
+	asm volatile (
+	"r0 = 1;"
+	"r0 <<= 32;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* bpf_testmod_retval_join() returns -EINVAL or -ERANGE */
+SEC("fmod_ret/bpf_testmod_retval_join")
+__success
+int BPF_PROG(join_einval, int *result, int value, int ret)
+{
+	return -22;
+}
+
+SEC("fmod_ret/bpf_testmod_retval_join")
+__success
+int BPF_PROG(join_erange, int *result, int value, int ret)
+{
+	return -34;
+}
+
+SEC("fmod_ret/bpf_testmod_retval_join")
+__failure __msg("it should be 0 or one of -34,-22")
+int BPF_PROG(join_other, int *result, int value, int ret)
+{
+	return -1;
+}
+
+/* Each path returns an allowed value */
+SEC("fmod_ret/bpf_testmod_retval_join")
+__success
+__naked void join_both_paths(void)
+{
+	asm volatile (
+	"r2 = *(u64 *)(r1 + 8);"
+	"if r2 s< 0 goto 1f;"
+	"r0 = -34;"
+	"exit;"
+"1:"
+	"r0 = -22;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * One of two paths to the same exit returns a forbidden value. The verifier
+ * checks the allowed one first and must not prune the other.
+ */
+SEC("fmod_ret/bpf_testmod_retval_join")
+__failure __msg("it should be 0 or one of -34,-22")
+__naked void join_one_forbidden(void)
+{
+	asm volatile (
+	"r2 = *(u64 *)(r1 + 8);"
+	"if r2 s< 0 goto 1f;"
+	"r0 = -34;"
+	"goto 2f;"
+"1:"
+	"r0 = -1;"
+"2:"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* bpf_testmod_retval_wide() returns s64, so all 64 bits count */
+SEC("fmod_ret/bpf_testmod_retval_wide")
+__success
+__load_if_JITed()
+__naked void wide_64bit(void)
+{
+	asm volatile (
+	"r0 = -14;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("fmod_ret/bpf_testmod_retval_wide")
+__failure __msg("it should be 0 or one of -14")
+__naked void wide_32bit(void)
+{
+	asm volatile (
+	"w0 = -14;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* Declared targets and the static rules are not restricted */
+SEC("fmod_ret/bpf_testmod_retval_declared")
+__success
+int BPF_PROG(declared_any, int ret)
+{
+	return -1;
+}
+
+SEC("fmod_ret/bpf_modify_return_test")
+__success
+int BPF_PROG(static_rule_any, int a, int *b, int ret)
+{
+	return -1;
+}
+
+/* The error injection list allows any value although the target has a tag */
+SEC("fmod_ret/bpf_testmod_retval_injectable")
+__success
+int BPF_PROG(static_rule_tagged, int value, int ret)
+{
+	return -1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+/* A program in a program array may return any value */
+SEC("fmod_ret/bpf_testmod_retval_constant")
+__failure __msg("tail calls are not allowed in fmod_ret programs with restricted return values")
+int BPF_PROG(constant_tail_call, int ret)
+{
+	bpf_tail_call(ctx, &jmp_table, 0);
+	return 0;
+}
+
+SEC("fmod_ret/bpf_testmod_retval_declared")
+__success
+int BPF_PROG(declared_tail_call, int ret)
+{
+	bpf_tail_call(ctx, &jmp_table, 0);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fmodret_retval_ext.c b/tools/testing/selftests/bpf/progs/fmodret_retval_ext.c
new file mode 100644
index 000000000000..96cef5595842
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fmodret_retval_ext.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An extension of fmod_ret programs, see prog_tests/fmodret_retval.c. The
+ * return values of the program on bpf_testmod_retval_constant() are restricted
+ * by its "bpf_fmodret_retval:" tag, those of the program on the declared target
+ * are not. An extension cannot replace the main function of a tracing program,
+ * so each of them calls a global function which the extension replaces.
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* Keeps clang from folding the calls */
+int value_bias;
+
+__noinline int restricted_value(int value)
+{
+	return value + value_bias;
+}
+
+__noinline int unrestricted_value(int value)
+{
+	return value + value_bias;
+}
+
+SEC("fmod_ret/bpf_testmod_retval_constant")
+int BPF_PROG(restricted, int ret)
+{
+	return restricted_value(ret) ? -22 : 0;
+}
+
+SEC("fmod_ret/bpf_testmod_retval_declared")
+int BPF_PROG(unrestricted, int ret)
+{
+	return unrestricted_value(ret);
+}
+
+SEC("freplace")
+int extension(int value)
+{
+	return -1;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 031c7454ce65..475df9a7680e 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -23,7 +23,16 @@ MODULES = bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
 
 $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
-CFLAGS_bpf_testmod.o = -I$(src)
+bpf_testmod-y := bpf_testmod_main.o
+# The functions for bpf_scan_ir use clang extensions and need the plugin
+bpf_testmod-$(CONFIG_CLANG_PLUGIN_BPF_SCAN_IR) += bpf_testmod_retval.o \
+						  bpf_testmod_retval_strong.o
+# Coverage instrumentation makes every path of the fixtures dirty
+GCOV_PROFILE_bpf_testmod_retval.o := n
+KCOV_INSTRUMENT_bpf_testmod_retval.o := n
+KMSAN_SANITIZE_bpf_testmod_retval.o := n
+
+CFLAGS_bpf_testmod_main.o = -I$(src)
 
 # When BPF_STRICT_BUILD != 0, a missing KDIR is fatal (the default).
 # When permissive, skip silently.
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_main.c
similarity index 100%
rename from tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
rename to tools/testing/selftests/bpf/test_kmods/bpf_testmod_main.c
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
new file mode 100644
index 000000000000..926c4a667b78
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions for the fmod_ret targets which the LLVM IR scanner finds, see
+ * prog_tests/fmodret_retval.c. The "test_retval:" decl tag of each lists the
+ * values the scanner must find on paths without side effects. An empty list
+ * means that the function must not become such a target.
+ */
+#include <linux/atomic.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/error-injection.h>
+#include <linux/mutex.h>
+#include <linux/rcupdate.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define RETVAL(values)	__attribute__((btf_decl_tag("test_retval:" values)))
+
+static __used int bpf_testmod_retval_state;
+static __used int *bpf_testmod_retval_captured;
+
+static noinline void bpf_testmod_retval_effect(void)
+{
+	WRITE_ONCE(bpf_testmod_retval_state, 1);
+}
+
+static noinline void bpf_testmod_retval_capture(int *ptr)
+{
+	WRITE_ONCE(bpf_testmod_retval_captured, ptr);
+}
+
+static noinline int bpf_testmod_retval_store(int value)
+{
+	WRITE_ONCE(bpf_testmod_retval_state, value);
+	return value;
+}
+
+static noinline int bpf_testmod_retval_clear(int value)
+{
+	WRITE_ONCE(bpf_testmod_retval_state, 0);
+	return value - 1;
+}
+
+/* Constant errors and both return widths */
+static __used noinline RETVAL("-22") int bpf_testmod_retval_constant(void)
+{
+	return -EINVAL;
+}
+
+static __used noinline RETVAL("-14") s64 bpf_testmod_retval_wide(void)
+{
+	return -EFAULT;
+}
+
+static __used noinline RETVAL("-1") int bpf_testmod_retval_first_errno(void)
+{
+	return -1;
+}
+
+static __used noinline RETVAL("-4095") int bpf_testmod_retval_last_errno(void)
+{
+	return -MAX_ERRNO;
+}
+
+/*
+ * PTR_ERR() of the ERR_PTR() of an inlined helper. Not recognized yet: the
+ * error reaches the return through a PHI in an earlier block.
+ */
+static __always_inline int *bpf_testmod_retval_slot(int *buf, int idx)
+{
+	if (idx < 0)
+		return ERR_PTR(-EINVAL);
+	if (idx > 8)
+		return ERR_PTR(-EFAULT);
+	return &buf[idx];
+}
+
+static __used noinline RETVAL("") int bpf_testmod_retval_err_ptr(int *buf, int idx)
+{
+	int *slot = bpf_testmod_retval_slot(buf, idx);
+
+	if (IS_ERR(slot))
+		return PTR_ERR(slot);
+	*slot = 1;
+	return 0;
+}
+
+/* A clean error path may join a dirty success path */
+static __used noinline RETVAL("-22") int bpf_testmod_retval_before_store(int *result, int value)
+{
+	if (value < 0)
+		return -EINVAL;
+	*result = value;
+	return 0;
+}
+
+static __used noinline RETVAL("-34,-22") int bpf_testmod_retval_join(int *result, int value)
+{
+	int ret;
+
+	if (value < 0)
+		ret = -EINVAL;
+	else if (value > 32)
+		ret = -ERANGE;
+	else {
+		*result = value;
+		ret = 0;
+	}
+	return ret;
+}
+
+/*
+ * An int error which a long function returns: the PHI of the two calls keeps
+ * the sign extension in the block of the return
+ */
+static __used noinline RETVAL("-22") long bpf_testmod_retval_sign_extend(int value)
+{
+	int ret;
+
+	if (value < 0)
+		ret = -EINVAL;
+	else if (value > 32)
+		ret = bpf_testmod_retval_store(value);
+	else
+		ret = bpf_testmod_retval_clear(value);
+	return ret;
+}
+
+/* An assumption does not make a path dirty */
+static __used noinline RETVAL("-22") int bpf_testmod_retval_assume(int value)
+{
+	__builtin_assume(value > 0);
+	return -EINVAL;
+}
+
+/* Writes to private stack objects are clean, optnone keeps them in the IR */
+static __used noinline RETVAL("-22") __attribute__((optnone))
+int bpf_testmod_retval_private_store(int value)
+{
+	int scratch[2];
+
+	scratch[0] = value;
+	scratch[1] = 0;
+	return -EINVAL;
+}
+
+static __used noinline RETVAL("-22") __attribute__((optnone))
+int bpf_testmod_retval_private_memset(void)
+{
+	char scratch[32];
+
+	__builtin_memset(scratch, 0, sizeof(scratch));
+	return -EINVAL;
+}
+
+/* An error which is not known exactly is not recorded */
+static __used noinline RETVAL("") int bpf_testmod_retval_masked(unsigned int value)
+{
+	return -1 - (value & 31);
+}
+
+static __used noinline RETVAL("") long bpf_testmod_retval_ptr_err(void *ptr, int *state)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	*state = 1;
+	return 0;
+}
+
+/* Pointer functions are not targets yet */
+static __used noinline RETVAL("") void *bpf_testmod_retval_error_pointer(void)
+{
+	return ERR_PTR(-ENOMEM);
+}
+
+/* Every error path has an observable effect */
+static __used noinline RETVAL("") int bpf_testmod_retval_argument_store(int *state)
+{
+	*state = 1;
+	return -EINVAL;
+}
+
+static __used noinline RETVAL("") int bpf_testmod_retval_global_store(void)
+{
+	bpf_testmod_retval_state = 1;
+	return -EINVAL;
+}
+
+static __used noinline RETVAL("") int bpf_testmod_retval_volatile_read(int *state)
+{
+	return READ_ONCE(*state) ? -EINVAL : -ERANGE;
+}
+
+static __used noinline RETVAL("") int bpf_testmod_retval_atomic(atomic_t *state)
+{
+	atomic_inc(state);
+	return -EINVAL;
+}
+
+static __used noinline RETVAL("") int bpf_testmod_retval_call(void)
+{
+	bpf_testmod_retval_effect();
+	return -EINVAL;
+}
+
+static __used noinline RETVAL("") int bpf_testmod_retval_barrier(void)
+{
+	barrier();
+	return -EINVAL;
+}
+
+static __used noinline RETVAL("")
+int bpf_testmod_retval_only_error_is_dirty(int *state, bool reject)
+{
+	if (reject) {
+		*state = 1;
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static __used noinline RETVAL("")
+int bpf_testmod_retval_lock_held(spinlock_t *lock) __acquires(lock)
+{
+	spin_lock(lock);
+	return -EINVAL;
+}
+
+static __used noinline RETVAL("") int bpf_testmod_retval_stack_escape(void)
+{
+	int scratch;
+
+	bpf_testmod_retval_capture(&scratch);
+	scratch = 1;
+	return -EINVAL;
+}
+
+static __used noinline RETVAL("") int bpf_testmod_retval_external_memset(void *dest)
+{
+	__builtin_memset(dest, 0, 32);
+	return -EINVAL;
+}
+
+/* Not recognized yet, although they have no side effects */
+static __used noinline RETVAL("") int bpf_testmod_retval_balanced_spinlock(spinlock_t *lock)
+{
+	spin_lock(lock);
+	spin_unlock(lock);
+	return -EINVAL;
+}
+
+static __used noinline RETVAL("") int bpf_testmod_retval_input_errno(int error)
+{
+	if (error >= -MAX_ERRNO && error < 0)
+		return error;
+	return 0;
+}
+
+/* No ftrace call site, but call padding in __patchable_function_entries on x86 */
+static __used noinline RETVAL("") notrace int bpf_testmod_retval_notrace(void)
+{
+	return -EINVAL;
+}
+
+/*
+ * A weak definition with an error, replaced by a strong one without errors in
+ * bpf_testmod_retval_strong.c
+ */
+int bpf_testmod_retval_overridden(void);
+
+__weak noinline __attribute__((btf_decl_tag("test_retval:")))
+int bpf_testmod_retval_overridden(void)
+{
+	return -EINVAL;
+}
+
+/*
+ * Two weak definitions: this one with a side effect is linked first and wins
+ * over the one with an error in bpf_testmod_retval_strong.c
+ */
+int bpf_testmod_retval_two_weak(void);
+
+__weak noinline __attribute__((btf_decl_tag("test_retval:")))
+int bpf_testmod_retval_two_weak(void)
+{
+	bpf_testmod_retval_effect();
+	return 0;
+}
+
+/*
+ * A function on the error injection list gets its tag, but the static rules let
+ * programs return any value
+ */
+static __used noinline RETVAL("-22") int bpf_testmod_retval_injectable(int value)
+{
+	if (value < 0)
+		return -EINVAL;
+	bpf_testmod_retval_effect();
+	return 0;
+}
+ALLOW_ERROR_INJECTION(bpf_testmod_retval_injectable, ERRNO);
+
+/* A declared target keeps only its own tags */
+static __used noinline RETVAL("") int bpf_testmod_retval_declared(void)
+{
+	return -EINVAL;
+}
+
+BTF_FMODRET_START(bpf_testmod_retval_declared_ids)
+BTF_ID_FLAGS(func, bpf_testmod_retval_declared)
+BTF_FMODRET_END(bpf_testmod_retval_declared_ids)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval_strong.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval_strong.c
new file mode 100644
index 000000000000..a246d7f619bc
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval_strong.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Replaces the weak bpf_testmod_retval_overridden() of bpf_testmod_retval.c.
+ * This definition returns no errors, so the function must not become an
+ * fmod_ret target, see prog_tests/fmodret_retval.c.
+ *
+ * The weak bpf_testmod_retval_two_weak() here loses the link to the one of
+ * bpf_testmod_retval.c, so its error must not make the function a target
+ * either.
+ */
+#include <linux/compiler.h>
+#include <linux/errno.h>
+
+int bpf_testmod_retval_overridden(void);
+
+noinline __attribute__((btf_decl_tag("test_retval:")))
+int bpf_testmod_retval_overridden(void)
+{
+	return 0;
+}
+
+int bpf_testmod_retval_two_weak(void);
+
+__weak noinline __attribute__((btf_decl_tag("test_retval:")))
+int bpf_testmod_retval_two_weak(void)
+{
+	return -EINVAL;
+}
-- 
2.43.0

