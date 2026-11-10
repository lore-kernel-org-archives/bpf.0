Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328172;
	b=DaC5w0iYnIbYvVH2JAHaPNGzAE9f66EYTz1DEtk1N4nNYBCzQ3spPTce9Y5t417UsmkB
	 QAsYy6KGE/k9OfOxXLl8nMvdQXfjKNKZp0erHI010BRWFJRqilD+BJ265qTDcjIKqgqZQ
	 ymxqynoUJjrIaN6g305adGL4ytOorpIgD/DmcyF+867w8onnK45kDoJcIJghwEHtW9B9K
	 Bz8EoiFIu4asfTCjO5+9jHNmWM5dqknYKThfsZLI9UDMS8It1fMnolSf2AihZ+rb2qb1u
	 FujsC6x4q5D+NjPd4ti+mmXqzda88W//TtGWPh52gEMEbvWMkWRTSSqGtCuFZdsm8vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HNNUOPHHRYuxX8ALTNMCrNB0wz+vFOtJtbEqpRjOoKE=;
	b=PM4+qBOzzdaYNFwVKktcGMm1HWmChUv0DKqQIYzveKLDXsDdZ6tvGV5UibQaSNB887MC
	 weHPGJGFH1ONyOVA5tla0yprZTAkat4jAvByad98X4CptAGbOqp7EDhJyV56jlGc+iKXA
	 KKD4FKVJC8QivQf24/2HkjAOg0nav4Q+PK99+jT/4Scuw7/g4IaM8lnGE9Bm5FRb34LWc
	 QWCz6cHllqw3Sph9mjxtcfJkrvzDlkfe+8YW/Bo4ND33nHch/kRVUjGaCmSeWE49HEwBi
	 ursweahlPkDSKVDpSE3U95LrnFF05vr0/Y/+S40SYFBg0fVlxkWPs3q5n+MTbAM07pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eW+LnvWI;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943660A262A
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E943660A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eW+LnvWI
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so16433115e9.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328170; x=1794932970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNNUOPHHRYuxX8ALTNMCrNB0wz+vFOtJtbEqpRjOoKE=;
        b=eW+LnvWIjEP9yoKQPu131LxcrGYM4M4y9GnyvgqUz1bIztoa9U9hDet9vSFth8BAfJ
         /LVs94UsCK0m+MBwhey+6QNvI/zeGWb9MOmoYZGL30zsW6a4RHibW/UPenNCi3rNu2pO
         oANQEUOy/3ZC0/QfXepV6EAg/iN+HQr+9hRgWOKZLve96kfPaC6jsQXMy7hEIgnu49ep
         5c4sC0UHA3ujYd8U4u2GPtr7j+Y7c2lXoKgiqd5JDAJ2YG5j/0LsZnz6pZm53kQ9r+fg
         MW7U0WZ0Z6Lypjn06JLtvO7f0g3IU7JtMDhtslehlBN1fiMI59sPpA1WyaSSY+4bCob4
         FL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328170; x=1794932970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HNNUOPHHRYuxX8ALTNMCrNB0wz+vFOtJtbEqpRjOoKE=;
        b=OYaISBaYwUliono3lts18NujvQA83o9cn2YaEnGwujKT7dB3SBnmon4hkaZlDX3zdB
         3smprs5AaBB9Dh2a0R8ieTCjoroj3qNI9LyO0ty95N9qatPt/JqnpF+gcDr9Qfxq4Thp
         bgqwQ0pTKiynne9sGXJhqmWsyWIxGtpDbfbo0qCaC7MiRbu2BW5aFBtGjXsnytFhJHYk
         wBbtT0Rqvs9IkpJmPdJZMfWwkKJgJ6+BET2f2iQFd25B3MlR79rmG/QssUJgbV9HJIL1
         9REf3evEZEB/skkBrToLSWXKlEFAhvD3INlZqM+vD0qOfcjyBrsnNDU/L2g3XdOrIFT9
         en/A==
X-Forwarded-Encrypted: i=1; AL+hErFN1DXFdZXupyQK04tGgQ50OYZvpznhuOyQt2wgPawG/xJIIqEHqaJQEAOmIavyUN1i68g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vmHsIWuSHwcwL7Tv2cD0//oUc+TOA+uWd035GUNY22n3Jf7B2
	Lu/PwjP5slXx46jg2F/ES74li+F77+yDqmHWl2ulu9ZlLRQclKprq3YS
X-Gm-Gg: AYBFou3n8eb1Q3tHTqmr/3ba6tNWb+CMW5x3gMXSJYSDBlQ5L09VxOA+CAJ1KP6+Yfm
	LtfoaOgdQVkR3PCl/EOt7WwN9MLz895K4v/7wjf4WwHKQe7Ym2PLctjMP9yaTuImgxqZx+6shGC
	z6A7m1lzIljks8kA2sT4AN/n9Z7sVWgSB+mb5Wehb6jIAEvv6qr68UBSrMrmt+0w2JCzNTXr9xz
	8/w8aQ5aMNIiMMX+8Txb8K4wljvpLWAIdDgZ2GWpc3uUa/mZQcRq1DoMu2rfs4+szK1kYD5jKXb
	PrMZOgZQPPVM2eEnbD10Iu7CPv932y/2xBfZcMCL+hY8+b+gvkJ4BKaAvcleChIxx/nC+mRKX51
	GKFrkv8wme4Es7abrfXH5z0+4Zae1KIxOc/CnRiZ2VYHd+ysV44lDkEJT5BukQ6MMGHPBX1zxgT
	sPUX8vcqvCagOEPVc5lSEhlT+NppbFhRXDekmKYkGMyvTPUIA1VZjLBZRZYug6MLq8Pw3yUnJ3K
	534+5OJ7iN3b9qf11VRt1AtQvFl8ilLbMERfWCOFgLj+1Gm1Sk6N0S+cdvR6FZ4I1GuhDjPs9X7
	t5Z0vGo6if98nQGIMI5KJaWV0sCwkHVYgZzN9irX7+FrlIU=
X-Received: by 2002:a05:600c:8b88:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4ba02356b59mr54334095e9.28.1794328170282;
        Tue, 10 Nov 2026 08:29:30 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea745sm71287485e9.10.2026.11.10.08.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:29:29 -0800 (PST)
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
Subject: [PATCH v3 bpf-next 06/18] selftests/bpf: Test fmod_ret BTF decl tags and attach permission
Date: Tue, 10 Nov 2026 16:40:26 +0000
Message-ID: <20261110164046.454431-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110164046.454431-1-a.s.protopopov@gmail.com>
References: <20261110164046.454431-1-a.s.protopopov@gmail.com>
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

Check that resolve_btfids tags the fmod_ret targets of vmlinux and of
bpf_testmod with "bpf_fmodret", that only bpf_fentry_test1 has the
"bpf_fmodret_sleepable" tag, and that a function which is not a target
has none.

Load minimal fmod_ret programs to check that the kernel builds its
target set from the tags: a target loads, a function which is not a
target does not, and sleepable programs load only for the sleepable
target.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/fmodret_tags.c   | 155 ++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fmodret_tags.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fmodret_tags.c b/tools/testing/selftests/bpf/prog_tests/fmodret_tags.c
new file mode 100644
index 000000000000..62efe11af826
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fmodret_tags.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <linux/filter.h>
+#include <bpf/btf.h>
+
+#define TAG_FMODRET		"bpf_fmodret"
+#define TAG_FMODRET_SLEEPABLE	"bpf_fmodret_sleepable"
+
+static bool func_has_tag(const struct btf *btf, const char *func, const char *tag)
+{
+	int func_id, id, nr_types;
+
+	func_id = btf__find_by_name_kind(btf, func, BTF_KIND_FUNC);
+	if (func_id < 0)
+		return false;
+
+	nr_types = btf__type_cnt(btf);
+	for (id = 1; id < nr_types; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+
+		if (!btf_is_decl_tag(t) || t->type != func_id ||
+		    btf_decl_tag(t)->component_idx != -1)
+			continue;
+		if (!strcmp(btf__name_by_offset(btf, t->name_off), tag))
+			return true;
+	}
+
+	return false;
+}
+
+static void test_vmlinux_tags(void)
+{
+	struct btf *btf;
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return;
+
+	ASSERT_TRUE(func_has_tag(btf, "bpf_modify_return_test", TAG_FMODRET), "modify_return_test");
+	ASSERT_TRUE(func_has_tag(btf, "bpf_modify_return_test2", TAG_FMODRET),
+		    "modify_return_test2");
+	ASSERT_TRUE(func_has_tag(btf, "bpf_modify_return_test_tp", TAG_FMODRET),
+		    "modify_return_test_tp");
+	ASSERT_TRUE(func_has_tag(btf, "bpf_fentry_test1", TAG_FMODRET), "fentry_test1");
+	ASSERT_TRUE(func_has_tag(btf, "update_socket_protocol", TAG_FMODRET),
+		    "update_socket_protocol");
+
+	/* Only bpf_fentry_test1 is a sleepable target */
+	ASSERT_TRUE(func_has_tag(btf, "bpf_fentry_test1", TAG_FMODRET_SLEEPABLE),
+		    "fentry_test1_sleepable");
+	ASSERT_FALSE(func_has_tag(btf, "bpf_modify_return_test", TAG_FMODRET_SLEEPABLE),
+		     "modify_return_test_sleepable");
+	ASSERT_FALSE(func_has_tag(btf, "bpf_modify_return_test2", TAG_FMODRET_SLEEPABLE),
+		     "modify_return_test2_sleepable");
+	ASSERT_FALSE(func_has_tag(btf, "bpf_modify_return_test_tp", TAG_FMODRET_SLEEPABLE),
+		     "modify_return_test_tp_sleepable");
+	ASSERT_FALSE(func_has_tag(btf, "update_socket_protocol", TAG_FMODRET_SLEEPABLE),
+		     "update_socket_protocol_sleepable");
+
+	/* A function which is not a target has no tag */
+	ASSERT_GT(btf__find_by_name_kind(btf, "bpf_fentry_test2", BTF_KIND_FUNC), 0,
+		  "fentry_test2_exists");
+	ASSERT_FALSE(func_has_tag(btf, "bpf_fentry_test2", TAG_FMODRET), "fentry_test2");
+	ASSERT_FALSE(func_has_tag(btf, "bpf_fentry_test2", TAG_FMODRET_SLEEPABLE),
+		     "fentry_test2_sleepable");
+
+	btf__free(btf);
+}
+
+static void test_module_tags(void)
+{
+	struct btf *vmlinux_btf, *module_btf;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "btf__load_vmlinux_btf"))
+		return;
+	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (!module_btf && errno == ENOENT) {
+		printf("%s:SKIP:bpf_testmod has no BTF\n", __func__);
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK_PTR(module_btf, "btf__load_module_btf"))
+		goto out;
+
+	ASSERT_TRUE(func_has_tag(module_btf, "bpf_testmod_trampoline_count_test", TAG_FMODRET),
+		    "trampoline_count_test");
+	ASSERT_FALSE(func_has_tag(module_btf, "bpf_testmod_trampoline_count_test",
+				  TAG_FMODRET_SLEEPABLE), "trampoline_count_test_sleepable");
+	ASSERT_FALSE(func_has_tag(module_btf, "bpf_testmod_fentry_test1", TAG_FMODRET),
+		     "testmod_fentry_test1");
+
+	btf__free(module_btf);
+out:
+	btf__free(vmlinux_btf);
+}
+
+/* Load a minimal fmod_ret program which attaches to function BTF_ID */
+static int load_fmod_ret(int btf_id, __u32 prog_flags)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.expected_attach_type = BPF_MODIFY_RETURN,
+		.prog_flags = prog_flags,
+		.attach_btf_id = btf_id,
+	);
+
+	return bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL", insns, ARRAY_SIZE(insns), &opts);
+}
+
+static void check_load(const char *func, __u32 prog_flags, bool allowed, const char *name)
+{
+	int btf_id, fd;
+
+	btf_id = libbpf_find_vmlinux_btf_id(func, BPF_MODIFY_RETURN);
+	if (!ASSERT_GT(btf_id, 0, func))
+		return;
+	fd = load_fmod_ret(btf_id, prog_flags);
+	if (allowed)
+		ASSERT_GE(fd, 0, name);
+	else
+		ASSERT_LT(fd, 0, name);
+	if (fd >= 0)
+		close(fd);
+}
+
+static void test_attach_permission(void)
+{
+	check_load("bpf_modify_return_test", 0, true, "target");
+	check_load("bpf_fentry_test1", 0, true, "sleepable_target");
+	check_load("bpf_fentry_test2", 0, false, "not_a_target");
+
+	check_load("bpf_fentry_test1", BPF_F_SLEEPABLE, true, "sleepable_prog_sleepable_target");
+	check_load("bpf_modify_return_test", BPF_F_SLEEPABLE, false,
+		   "sleepable_prog_nonsleepable_target");
+}
+
+void test_fmodret_tags(void)
+{
+	if (test__start_subtest("vmlinux"))
+		test_vmlinux_tags();
+	if (test__start_subtest("module"))
+		test_module_tags();
+	if (test__start_subtest("attach_permission"))
+		test_attach_permission();
+}
-- 
2.43.0

