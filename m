Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243292;
	b=gBAtRsimsoLltdc44NkaTRHaYd46XpIxLal1Q1cjmOryU6IX7GVX2VAZI+7MAKXZCkVW
	 lYuzm8+j0Pf6aSjMS0jHTZvoyf0JifTGxuPmR8rHSflOM40VvQGJSaQLFbf+B8MLnWGeR
	 6dMsfSOq6bBMcts6p0u6Xd/lUAgatf6k8GQGS0UJa09Hy1OyZSrzV5Jd0SdF6Z8sdE5Tv
	 fGwrGJSUoRdLq7dyJuNblgX9DWjEdeuQUmSZFjLMbcFNx89AegFxQ5HAJNf5lWtJ5qWSw
	 GRwpTwZCZ1cztZ6q5vZM3/j/OIsvSM6+HwBxmmH9rAHt/523vmdG0W6T9mxQZeUWHfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HNNUOPHHRYuxX8ALTNMCrNB0wz+vFOtJtbEqpRjOoKE=;
	b=j4nkVBtINjytWkip+kmMgl1053wA/NUdM903ZmQyGb0rlS+69/MElcAu/bcRdHXUJ2Q0
	 1ldjDhPV7LYxRgEAA3c0bUVTo+tpK7eqrQILl3yBDd8Sm6uu6RJFfEPv/khgmEhZEVz1M
	 BhhmQHlDsQ8ciQcmJtb6xT4iutwZet+e2Z5djEFxvb6z9hE4+l2QpO/6VIWEHIqzuGHws
	 aPCc+GQHBRS9UOaRlCemvt5o7fe5KSWCEVxpergW2MFLhTO6M1OS68ODoSJrkBt15h7uE
	 SKNtTRZratCeExUppLvT1SRbeVE1zLAzk+T2wzAWTAhE/j9zMG0Rr5ZJw05WHoya5/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TpMZYCA0;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24D60A5BD7
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A24D60A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TpMZYCA0
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4922523d1afso627298f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243290; x=1794848090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNNUOPHHRYuxX8ALTNMCrNB0wz+vFOtJtbEqpRjOoKE=;
        b=TpMZYCA0jRX7+3Kjt/x+6ZV2t/J4meTi20r/VR1EOrXmezI+HHwT6PdELR0uwB8Dmt
         TW/aBGCpdgFF/CSbW9UzqazYGWnJ6B5lNtWgw6vhLXQj9W9y7s7hgr4TlaZNW9a7Q9Re
         30uIwwZpV2SRc2wQTHzHezE9i2JdDTSmN96mgPekth3DIRI0MSJmyO3HMou9gVDvQ+03
         qzV1IjSiFz7qURXH9q1t3KHU5IhVg0safEsWILKap+y6PnzQFkzNSs46uKpcg9jpmnSZ
         0z9HTHgt6Wy0RWm/N7PlCX4906hoMkuFJnY2LHn14vm9EjYzUDewtLeSk/2vz1l6yabD
         coSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243290; x=1794848090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HNNUOPHHRYuxX8ALTNMCrNB0wz+vFOtJtbEqpRjOoKE=;
        b=YvWxyfrNLiJvJbCslW9ltc0LRrFcAR3aHkbMHuAlrLP2RrUYSwxjoynEBTOw22vSGh
         5VHqNolNIowdv/TtUNUJDInx2YUjKMAlgm4olK98xJefgPjBhffLjVH8/djfohRpRT2U
         vsJ8ElHSIQ4BjuIQ8Sv6l3iBeJnLHfxoSegP6v10S21OlecRCHYrbpnFsVOQnCwhQy/g
         77HF07TJoau/jHom44sqzVT2oEK3k1CuGpqVSPxXzY8J2fviAY32t2wHgmWLVNF8e6Yb
         khxPqOv9wXei5kOLX1uHrQJkhQ9XcMxSscPdLxTyzvjyr2JC52EPOoCRxe/ctmfwt2tv
         KmMQ==
X-Forwarded-Encrypted: i=1; AL+hErGb1gB99Vz2cnhjfAtnQuKTT6YZM7gqi4vOO0gg236+vBsHo2OccrFJSzIERDfsaJepq7g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/03/HehN55XA5oEgSiBGGFhTPDVbos5F2Ls6fnka/1+SjVwnTi
	W8jIyZlZVMe1EWfYGv4q7WfAr7SHtRBP0Td/G2Aq08WlBbFO8o/uD5eF
X-Gm-Gg: AYBFou01by11i5JxLe6F5rJFibgo423Ut5e4SNtfxUwmyFQNZ8Hyo4MimiENF8IFgZr
	AfHRfgdQViNJiGki7OEgz/hYWmzkwPKYRPNp05aY1ZMh4cwV3at5ZPMVzGoOnZBwUNJ8Qwt0+y7
	g2Iu5dk+NGhp2jo1iqGUfK6AbY4um+1t8n98pCPZEYlDZG6QT3c7pxyjTx1hUKu5nbXTi3k8r6Y
	qAG+GD5YmF4jMvm6DJQK4UY1Ouds3ICNuQa/JAcLWBg/GC0lddP5KbOL84FqfZp9TOakbSx2HAX
	otgsyHbmRwMCxMfOCnxkvOH9vVp5+3Clo92kex8n5m3B3Uw7N42e1BGAMAOVM6V/7ZxHO9v2EYg
	Qwm+UGwCHPLZkH6iodY45B2Z2GxzcgAbqlKuF9QfTXz+PoiWndkQSS8VRFpz6/lNM+NUVEJN2wX
	q6PxLKkFVQt/A2nHC9T1dFj4TSNkWczCggGzEg5iL64Jmcc9FSh2hFFeJflQk7yWgC2O2JhKgeM
	b/oMarJJWHtiNmRX5XdIWG0x38Z2Fwa0hzTUE8PTlPrE7TmL4mvSZZXp/rDPTHdf8gD6MzvFDv/
	TR/c6lODBBDFdfmsA+v7r/alDWov3MF8qzLxBN7Bu1yP0so=
X-Received: by 2002:a5d:5d0e:0:b0:492:905a:8b22 with SMTP id ffacd0b85a97d-4982c799164mr104721f8f.2.1794243289514;
        Mon, 09 Nov 2026 08:54:49 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:54:48 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 06/18] selftests/bpf: Test fmod_ret BTF decl tags and attach permission
Date: Mon,  9 Nov 2026 17:05:26 +0000
Message-ID: <20261109170550.141443-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109170550.141443-1-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
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

