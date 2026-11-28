Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834411;
	b=n3SnG8x3rdACXu49srnuKwHYdCbKLpECqrOnR2P5xkSjMnFvOlgOZllGFwQnNah+MCVR
	 ouFil9Cu4Vb+mN9bsUpa6m7eNdIEtpw6kNLNu2LHgG7lFghAxUlK/joI1LyM5jJII4ebp
	 MjzeECEE1w8im1h+FpJhSlKMa8voHN4z7zETfw5cK9j24WgG2PVwXI8S6Jx8OXPorChCq
	 5PRZ2RHFTIHDVuLKs6s/zAhT5EsPZ6jySlrrLB9vyw253NZy+d1vgESuAvFt6q+ccuaNa
	 36pIZLsq+JDeI9SSCGVInQuyxG/zeyPRmW0wHR7ZGwIH+RZjhWr/NgsYYHkdDzZ3EZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=JZX9V2DBuckEeWqKVOKjSHCXB8HA/fgCZF/cFxIZ/IM=;
	b=P0UiG+B9EavAciYvK+Gcdi7JFwV8fmnRlfgSO4zuZugaYtJuyEpw0XIN31t1LL/i2E+8
	 dStGmqRlrjoaNpuarHqOLUV1ngttC34Ee1vqeXG/HhbWbmcrvM4oiK1Q0K8Jx6bGaTZiw
	 7l+6jPvYH9DassQWsXlAwI0apx5mU/8nDgKl/dWS3tlQvgU9a5d4BhQOBqqHNFgzJ6tM+
	 2C6NmKSzNa3T3qMHcvT/pPHxsE0hBCRA+PiO3N9qcdIY/v/pbFnXzd4lL0nejWWc1ZbH3
	 u6y08pSBsOjAWka0RYuEP+1PlOkYhZJCa1aSTzhA0yRy/kcC3GDixjPiARCzAPUkw4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="O1w0h/Y/";
	arc=none smtp.remote-ip=74.125.231.135
Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858C606A32F
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 02:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3858C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1w0h/Y/
Received: by mail-oo2-f7.google.com with SMTP id 46e09a7af769-861b66a5ac3so1085423a34.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 18:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795834410; x=1796439210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JZX9V2DBuckEeWqKVOKjSHCXB8HA/fgCZF/cFxIZ/IM=;
        b=O1w0h/Y/L+IzVjdjud/JFDYJWL5jodZIcqPS5p6zK2a95QalTcraAncuE87kFthJCi
         WYMasf5aFS2RRBVK9ZvSB55nr7ou/1bNUpN/REOjykWmBt6XWdIfK+vFy7r1zwyuWMFz
         pIK4xok2Xyc0ec5cw78C9Aaq/ui1pPirSExjJ9zDF9f71Rh7okKZ7J1J6h3REwBE3PK4
         nuI8LqFORKUy94WnADUXREVgY//52kUNSxHVkBxPNKrR62P8b8F34rYE/03lQ5muoGW3
         yFJNKdYUzvWFYU2iBRexTRJ0+gu3PUNUpkVcn3w178xzMQi3VYXRYKjFr8ubgEYq+d0O
         EaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795834410; x=1796439210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JZX9V2DBuckEeWqKVOKjSHCXB8HA/fgCZF/cFxIZ/IM=;
        b=NC0jNcgMabjvUTMzvcxrygptzOEYrHIWH29OzeE/U6XN6aZ8Dx5M5SaaJqMFSEwPW4
         yS3CEikXXoN+mVBm6Gw3gH2KEGeadUBfdYiVnZChCIZwD610XvQgZaJB9lcoNyGKk9MD
         8/GUgtMW2iovtJauzCF0bOKZlaAv1+zDgxNYtGWOQgz5T8GRsJ1elBbHE91JXQX44Q31
         T1L0ONpCg750VDm+UbftiYyGZqf8ToZQ1nzLegkrW453bSwI2bPbGF1+ZlDfw3CGOTJ2
         DZ9wPvZrQBTT0fEc+aIeyiLucs6G31T9YcREDG/Nk0I/shHOyftuIvSgqKqJlcYwn0CA
         CNxQ==
X-Gm-Message-State: APuU4Z+7+bF6Y5NcEQVFYmkq9n4OEXdQkK2ZRzjtuSUTW5E5Oq6nObWJ
	470XErn3JAe0s+Tn/86oShBXtRahdgiHL3Bl5NwS53XqsHMCvTA7FtezthBGvy02v4g=
X-Gm-Gg: AZFdTZeSxDIkEomkQZ230fFtgDPQ5Qlp8pLhjWK0KkVW29yV0ISsMOnwj2dsF80IDq8
	vmCQLrq7JdQO6GeR+V31yMCviKB+VlbE0YSAznUIlFCdnZAmYv1IeYycDh5aAlwc30LLYkRAT3R
	8fu6vHaBt/0DxVEsXt1bkHZpCjlIhCV0w1/NctKh6ICBtTGzq95+oLDy6v7pc9yy+wBIslYzVpT
	+1y8X81+foe4h9BcXzSTC5+RaSkaw/ecIsAAqDP5P99U+N9nXKAlrOeb0zWsAzT0YDJWSowPDdN
	anfEr7OcM9EMD7vKgZPtIqxwKFgY2K8Gz5oH1EIzilP+DC25IaYYYW8fu0WZL1wL+pWJ1frW7sM
	0Cbu8F93pcK/J1W8NS3/ZziwRoAD08oib0EsPL/3ziVGZwZpmK4Xem6HyaZk6f1GqcLdTfGOCFJ
	fiJFmAyd1iYRMEQtg69EluBi/u2dZrBPtedEGO9Ix5OPEc2TYiJQALMAG0hOxfmnZCdJq90j3/n
	PlwtNLpGTx24tz2BxDJ7hpZSLQKgfBj3YNSOHnPBIt6/wtg5XHi9YzcXJTxOz/JrE0YjzW1p7x9
	QFQjZqHtDE0I1lNb4Q0vWKTu4mfOaOurrWeJLg2y1Fb2vvpuCMwop0H1i6LUNf01roCtQ4rMYaa
	N4bqCfFyVt2LdJdFKhBBfbmGFYM4+tnIWbT+G
X-Received: by 2002:a05:6830:2b2a:b0:829:9992:2106 with SMTP id 46e09a7af769-863157a6e90mr30189798a34.22.1795834410155;
        Fri, 27 Nov 2026 18:53:30 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm18007374a34.18.2026.11.27.18.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:53:28 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Puranjay Mohan <puranjay@kernel.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Test loads through __iomem pointers
Date: Sat, 28 Nov 2026 03:53:17 +0100
Message-ID: <be149a9ba5e6dae5cf5eb536199d1dbbcf629e69.1795834380.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <cover.1795834380.git.memxor@gmail.com>
References: <cover.1795834380.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6177; h=from:subject:message-id; bh=C0R7WhZ+PpFHuwydZp3YARDwtyWE+znhx6lbyvOydY0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZvLiYfHTk6iYFu1hkSWy5kp0UtnHchq3bz72tcn66Zvzpg0 MZiro5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPhOcDwT6mo73O0Y/im7vuJPQt2W1 qG5E64/svo9AZhoZrTnUz2gYwM8++9L0m9/ujHpaiKnrpJ+xjKr/G2HpMJeh1VrP1gRaIUFwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Give bpf_testmod a function with an __iomem struct pointer argument, and a
struct with two __iomem members, one pointing to a struct and one to an
int. Check that a program cannot load through any of the three, and that
it can still read the value of the pointers.

The subtests are skipped when the BTF of bpf_testmod has no "iomem" type
tag.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_tag.c        | 55 +++++++++++++++++++
 .../selftests/bpf/progs/btf_type_tag_iomem.c  | 49 +++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 15 +++++
 3 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_iomem.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_tag.c b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
index 071430cd54de..164359841381 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_tag.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
@@ -11,6 +11,7 @@ struct btf_type_tag_test {
 #include "btf_type_tag.skel.h"
 #include "btf_type_tag_user.skel.h"
 #include "btf_type_tag_percpu.skel.h"
+#include "btf_type_tag_iomem.skel.h"
 
 static void test_btf_decl_tag(void)
 {
@@ -224,6 +225,51 @@ static void test_btf_type_tag_vmlinux_percpu(bool load_test)
 	btf__free(vmlinux_btf);
 }
 
+/* Load only @name. A load through an __iomem pointer has to fail. */
+static void test_btf_type_tag_mod_iomem(const char *name, bool fails)
+{
+	struct btf *vmlinux_btf = NULL, *module_btf = NULL;
+	struct btf_type_tag_iomem *skel = NULL;
+	struct bpf_program *prog;
+	char log[4096] = {};
+	int err;
+
+	if (load_btfs(&vmlinux_btf, &module_btf, /*needs_vmlinux_tag=*/false))
+		return;
+
+	/* skip the test if the module does not have __iomem tags */
+	if (btf__find_by_name_kind(module_btf, "iomem", BTF_KIND_TYPE_TAG) <= 0) {
+		printf("%s:SKIP: no __iomem btf_type_tag in bpf_testmod", __func__);
+		test__skip();
+		goto cleanup;
+	}
+
+	skel = btf_type_tag_iomem__open();
+	if (!ASSERT_OK_PTR(skel, "btf_type_tag_iomem"))
+		goto cleanup;
+
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog, !strcmp(bpf_program__name(prog), name));
+
+	prog = bpf_object__find_program_by_name(skel->obj, name);
+	if (!ASSERT_OK_PTR(prog, "find_program"))
+		goto cleanup;
+	bpf_program__set_log_buf(prog, log, sizeof(log));
+
+	err = btf_type_tag_iomem__load(skel);
+	if (fails) {
+		ASSERT_ERR(err, name);
+		ASSERT_HAS_SUBSTR(log, "invalid mem access 'scalar'", "log");
+	} else {
+		ASSERT_OK(err, name);
+	}
+
+cleanup:
+	btf_type_tag_iomem__destroy(skel);
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
+}
+
 void test_btf_tag(void)
 {
 	if (test__start_subtest("btf_decl_tag"))
@@ -246,4 +292,13 @@ void test_btf_tag(void)
 		test_btf_type_tag_vmlinux_percpu(true);
 	if (test__start_subtest("btf_type_tag_percpu_vmlinux_helper"))
 		test_btf_type_tag_vmlinux_percpu(false);
+
+	if (test__start_subtest("btf_type_tag_iomem_arg"))
+		test_btf_type_tag_mod_iomem("test_iomem_arg", true);
+	if (test__start_subtest("btf_type_tag_iomem_struct"))
+		test_btf_type_tag_mod_iomem("test_iomem_struct", true);
+	if (test__start_subtest("btf_type_tag_iomem_int"))
+		test_btf_type_tag_mod_iomem("test_iomem_int", true);
+	if (test__start_subtest("btf_type_tag_iomem_value"))
+		test_btf_type_tag_mod_iomem("test_iomem_value", false);
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_iomem.c b/tools/testing/selftests/bpf/progs/btf_type_tag_iomem.c
new file mode 100644
index 000000000000..29f1faa318e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_iomem.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct bpf_testmod_btf_type_tag_1 {
+	int a;
+};
+
+struct bpf_testmod_btf_type_tag_4 {
+	struct bpf_testmod_btf_type_tag_1 *p;
+	int *q;
+};
+
+long g;
+
+/* The argument is an __iomem pointer to a struct. */
+SEC("fentry/bpf_testmod_test_btf_type_tag_iomem_1")
+int BPF_PROG(test_iomem_arg, struct bpf_testmod_btf_type_tag_1 *arg)
+{
+	g = arg->a;
+	return 0;
+}
+
+/* The member is an __iomem pointer to a struct. */
+SEC("fentry/bpf_testmod_test_btf_type_tag_iomem_2")
+int BPF_PROG(test_iomem_struct, struct bpf_testmod_btf_type_tag_4 *arg)
+{
+	g = arg->p->a;
+	return 0;
+}
+
+/* The member is an __iomem pointer to an int. */
+SEC("fentry/bpf_testmod_test_btf_type_tag_iomem_2")
+int BPF_PROG(test_iomem_int, struct bpf_testmod_btf_type_tag_4 *arg)
+{
+	g = *arg->q;
+	return 0;
+}
+
+/* The value of the pointers can still be read. */
+SEC("fentry/bpf_testmod_test_btf_type_tag_iomem_2")
+int BPF_PROG(test_iomem_value, struct bpf_testmod_btf_type_tag_4 *arg)
+{
+	g = (long)arg->p + (long)arg->q;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1fbc0061cc24..debcc58418e7 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -650,6 +650,11 @@ struct bpf_testmod_btf_type_tag_3 {
 	struct bpf_testmod_btf_type_tag_1 __percpu *p;
 };
 
+struct bpf_testmod_btf_type_tag_4 {
+	struct bpf_testmod_btf_type_tag_1 __iomem *p;
+	int __iomem *q;
+};
+
 noinline int
 bpf_testmod_test_btf_type_tag_user_1(struct bpf_testmod_btf_type_tag_1 __user *arg) {
 	BTF_TYPE_EMIT(func_proto_typedef);
@@ -673,6 +678,16 @@ bpf_testmod_test_btf_type_tag_percpu_2(struct bpf_testmod_btf_type_tag_3 *arg) {
 	return arg->p->a;
 }
 
+noinline int
+bpf_testmod_test_btf_type_tag_iomem_1(struct bpf_testmod_btf_type_tag_1 __iomem *arg) {
+	return !!arg;
+}
+
+noinline int
+bpf_testmod_test_btf_type_tag_iomem_2(struct bpf_testmod_btf_type_tag_4 *arg) {
+	return arg->p && arg->q;
+}
+
 noinline int bpf_testmod_loop_test(int n)
 {
 	/* Make sum volatile, so smart compilers, such as clang, will not
-- 
2.53.1-Meta

