Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA930DEA6
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958348; cv=none; b=rgMTyR1/B7L6a1A4fFUHU3Kex/FwnQX6fov1nnnNhpAvRQ5bEtNXkmXQNiILXVgveCNmiBPLRE4l5PWvkxWmHWsREpzmAQz/sQthGzCtJHmwoMvpNSi5rBxFsb+EuxLtEJ4ZuBf01wqaUYBkEa9SoqkQ9nw+sJtrG3DjxPJilWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958348; c=relaxed/simple;
	bh=2xcM/u11/+3hlsjCj0ZCrAxJekBWshjkXHt4sgiAYjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUVyKqMBd5291Jr7C9y497KLJN+j9iv2Gt4OD1YVbLlJrKebJUnXRFFq4qu24g9qWarB8LkmCDhI+9gXb+CC8SesiN+k6ihTzqm3GRdMLUSezugf4Xoq90DXEJwdgQnTc8SGm3Bx+QtfJzF+AENUnvoGgSdrJRNqlNUNb+y2Mg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGRqZyDL; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGRqZyDL"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so11866405e9.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958345; x=1790563145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GheL8KnxtDsSPGMp066FRUcTBOxP2w+0qq1ZoKjpCkQ=;
        b=kGRqZyDLZ1neXehUolCINDlT1HLiqCisUgSF40WaIkjTPuuNWVYTnttYd+vIVRF02X
         B4MarJ+53OBSo4/WqylDHHCKPB1kKD1vmTtI56fs55pqm7HzkyVpIVu4FWeAbVtWZhdk
         zYS4wMx7R7H073gfesvSB5/FU2hLHwoupmDqTHkgsK0Wr6YQEInBiju74ehUsYosdxWm
         6dTEYUy/s8rc7uo+hfz4P6rIDY0e75/qQ6XY9YQwOOqYXh8EHMxmgfFj/hoqvNdKSIkI
         bR0OkavPtyRACfQgGHyIGkhxzHTkTSjDPpZWI4cabcoT0IZqkvYF7kSYGfkgI7hvpWOo
         ID9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958345; x=1790563145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GheL8KnxtDsSPGMp066FRUcTBOxP2w+0qq1ZoKjpCkQ=;
        b=gCMXhaEIsfOQh+kqAeLD2oRYYm7xRG8t/G6Uvq+JTyRqOvQKVOZBv9SKnoZ1gugufN
         IPSrTYOsMoCC1wsc/lQAIqCXLnl6Xm9rPXAadfai72BvNgmmlTFYeIjLTJbw8KRc50EC
         kwFCJalkNsSX/Ekj0+0ZEN+uDkRbFNIVVCP+NgddZDZK5tO3YXP1mj/l5viv2BW8O81P
         yuU0LhLTZRGCBkFHMI1Y7BILR3Km0vJJlKbsemYBaDDo2F+1h1qaOhyx80B1dQN6Sxbt
         DVQzUNL+tAC/MXl1jdVP0SNEYvFJ53xV+crT9Pix0NgB+wFRLxnOoGOTd0jQ5kGb55wM
         PzcQ==
X-Gm-Message-State: AFuF++kuhMz0q30Cc6kt2l8css9KamdMGhmTGF2dWXv9UP7wjsMkZLJl
	vQEHXmEXUMNAMHhW1+vuxX2v5CCze6oEaEmtwB67C6Cv4Ma81AlXLbQHhG8eJC08
X-Gm-Gg: AYBFou1YoC7hVzDfMA7+/yjFTuScxuetQdKCHZDHHoZc4xPaooVTz7WUZ9zopJZSpUJ
	5AOlxeOmNlfRkBRa8AVsO+LVx1u14rjCg84VG/Li3/FbseBTp+H/ode0RjExjlvfiwl1xxFCdei
	RDwch5+coNa4/BfhM4ifLvQ+UYzYFsSoi2vw6PvN61Nw9SxXUAESqyzXv/r0YI7cEbPu5BK++JJ
	6JidEqvZ9Dq2EO0pBRiwGmQ7J2s1gfzor/XbNKnsHQVJDXPd8r5/EzIFWYGRwjMd7R1sAKvgVAm
	tyfMwBG6F14BDJWHuLn88tjFg/jTKoY6eKeymmbnZ/VbfJYan+QTT000y3O7+qKL5iZ8XAB9fdz
	nUkOh45ZaAuicR46WNkCcS3GdhzrV8kO9V2SuWQIXVEMFtd/9sXFeBVPvCTk2PNrLmku8/IxfcF
	zTWHO2eArwdrbzFKJMepsPQWGfO+XwcAnSeubEvzfLrlqKK946wZV5lfTpXJFXp2M5Oq5XO81sH
	GlKUIn20bkuBLOItplNbJEbFXR8bUmowfx9JkUB/j6aQgthE5r12wxBEFc5zt/u7Uq+PDNntGRk
	Y2k6so2zE+eVNMvnGo0ea/sbX2wHb5QvwFWNZw==
X-Received: by 2002:a05:600c:3556:b0:49d:797:83bf with SMTP id 5b1f17b1804b1-49fc57360damr137567805e9.21.1789958344812;
        Sun, 20 Sep 2026 19:39:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm198588205e9.3.2026.09.20.19.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:39:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 11/11] selftests/bpf: Cover helper memory access permissions
Date: Mon, 21 Sep 2026 04:38:35 +0200
Message-ID: <20260921023843.411943-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921023843.411943-1-memxor@gmail.com>
References: <20260921023843.411943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7133; i=memxor@gmail.com; h=from:subject; bh=9heOkHTVi9oxB1PQ+JnJWinSgKLeYZ69QyvjFNUPLf8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvD9K1FLCWLbwRPt6qd9Nj8+vlGqbV//f7c/FKWctH72 5blMRwvO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRyw0Mf/h+KqyMWBr4Xqev 9JFJath5t+WLFmrkl/d/eXhsceeFnTcYGXZP2GRf3v0i6ZGXaL4u39aUnPkWJ6Z83LmzzODFeac jxxgB
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

Check that fixed-size and sized helper input/output buffers require both
read and write permission. Cover the MTU and FIB helpers, including read-only
and write-only rejection and read/write positive controls. Exercise the XDP
prototypes and the sock_ops header-option input/output argument as well.

Keep write-only maps usable as destinations for partial-output helpers
bpf_snprintf() and bpf_sysctl_get_name(), while rejecting a read-only
snprintf destination. Also retain a write-only-map destination for
bpf_get_current_comm(), whose output is annotated MEM_UNINIT and fully
initialized by the helper.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../progs/verifier_helper_access_var_len.c    | 143 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_mtu.c        |  88 +++++++++++
 2 files changed, 231 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
index e87eb6f221e4..2782faf0a528 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 /* Converted from tools/testing/selftests/bpf/verifier/helper_access_var_len.c */
 
 #include <linux/bpf.h>
@@ -822,6 +823,148 @@ __naked void bytes_no_leak_init_memory(void)
 	: __clobber_all);
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_WRONLY_PROG);
+	__type(key, __u32);
+	__type(value, struct bpf_fib_lookup);
+} map_fib_wo SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct bpf_fib_lookup);
+} map_fib_rw SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_RDONLY_PROG);
+	__type(key, __u32);
+	__type(value, struct bpf_fib_lookup);
+} map_fib_ro SEC(".maps");
+
+SEC("tc")
+__failure __msg("read from map forbidden")
+int writeonly_sized_input(struct __sk_buff *ctx)
+{
+	struct bpf_fib_lookup *params;
+	__u32 key = 0;
+
+	params = bpf_map_lookup_elem(&map_fib_wo, &key);
+	if (params)
+		bpf_fib_lookup(ctx, params, sizeof(*params), 0);
+	return 0;
+}
+
+SEC("tc")
+__success
+int readwrite_sized_input(struct __sk_buff *ctx)
+{
+	struct bpf_fib_lookup *params;
+	__u32 key = 0;
+
+	params = bpf_map_lookup_elem(&map_fib_rw, &key);
+	if (params)
+		bpf_fib_lookup(ctx, params, sizeof(*params), 0);
+	return 0;
+}
+
+SEC("tc")
+__failure __msg("write into map forbidden")
+int readonly_sized_output(struct __sk_buff *ctx)
+{
+	struct bpf_fib_lookup *params;
+	__u32 key = 0;
+
+	params = bpf_map_lookup_elem(&map_fib_ro, &key);
+	if (params)
+		bpf_fib_lookup(ctx, params, sizeof(*params), 0);
+	return 0;
+}
+
+SEC("xdp")
+__failure __msg("read from map forbidden")
+int xdp_writeonly_sized_input(struct xdp_md *ctx)
+{
+	struct bpf_fib_lookup *params;
+	__u32 key = 0;
+
+	params = bpf_map_lookup_elem(&map_fib_wo, &key);
+	if (params)
+		bpf_fib_lookup(ctx, params, sizeof(*params), 0);
+	return XDP_PASS;
+}
+
+SEC("sockops")
+__failure __msg("read from map forbidden")
+int writeonly_header_option(struct bpf_sock_ops *ctx)
+{
+	struct bpf_fib_lookup *buf;
+	__u32 key = 0;
+
+	buf = bpf_map_lookup_elem(&map_fib_wo, &key);
+	if (buf)
+		bpf_load_hdr_opt(ctx, buf, sizeof(*buf), 0);
+	return 0;
+}
+
+SEC("sockops")
+__success
+int readwrite_header_option(struct bpf_sock_ops *ctx)
+{
+	struct bpf_fib_lookup *buf;
+	__u32 key = 0;
+
+	buf = bpf_map_lookup_elem(&map_fib_rw, &key);
+	if (buf)
+		bpf_load_hdr_opt(ctx, buf, sizeof(*buf), 0);
+	return 0;
+}
+
+SEC("tc")
+__success
+int snprintf_writeonly_output(struct __sk_buff *ctx)
+{
+	void *buf;
+	__u32 key = 0;
+
+	buf = bpf_map_lookup_elem(&map_fib_wo, &key);
+	if (buf)
+		bpf_snprintf(buf, 16, "ok", NULL, 0);
+	return 0;
+}
+
+SEC("tc")
+__failure __msg("write into map forbidden")
+int snprintf_readonly_output(struct __sk_buff *ctx)
+{
+	void *buf;
+	__u32 key = 0;
+
+	buf = bpf_map_lookup_elem(&map_fib_ro, &key);
+	if (buf)
+		bpf_snprintf(buf, 16, "ok", NULL, 0);
+	return 0;
+}
+
+SEC("cgroup/sysctl")
+__success
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__success_unpriv
+int sysctl_writeonly_output(struct bpf_sysctl *ctx)
+{
+	void *buf;
+	__u32 key = 0;
+
+	buf = bpf_map_lookup_elem(&map_fib_wo, &key);
+	if (buf)
+		bpf_sysctl_get_name(ctx, buf, 16, 0);
+	return 0;
+}
+
 SEC("cgroup/sysctl")
 __success
 __caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
diff --git a/tools/testing/selftests/bpf/progs/verifier_mtu.c b/tools/testing/selftests/bpf/progs/verifier_mtu.c
index 256956ea1ac5..2f71f70302e4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_mtu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_mtu.c
@@ -17,4 +17,92 @@ int tc_uninit_mtu(struct __sk_buff *ctx)
 	return TCX_PASS;
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_WRONLY_PROG);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_mtu_wo SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_mtu_rw SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_RDONLY_PROG);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_mtu_ro SEC(".maps");
+
+SEC("tc/ingress")
+__failure __msg("read from map forbidden")
+int tc_writeonly_mtu(struct __sk_buff *ctx)
+{
+	__u32 key = 0;
+	__u32 *mtu;
+
+	mtu = bpf_map_lookup_elem(&map_mtu_wo, &key);
+	if (mtu)
+		bpf_check_mtu(ctx, 0, mtu, 0, 0);
+	return TCX_PASS;
+}
+
+SEC("tc/ingress")
+__success
+int tc_readwrite_mtu(struct __sk_buff *ctx)
+{
+	__u32 key = 0;
+	__u32 *mtu;
+
+	mtu = bpf_map_lookup_elem(&map_mtu_rw, &key);
+	if (mtu)
+		bpf_check_mtu(ctx, 0, mtu, 0, 0);
+	return TCX_PASS;
+}
+
+SEC("xdp")
+__failure __msg("read from map forbidden")
+int xdp_writeonly_mtu(struct xdp_md *ctx)
+{
+	__u32 key = 0;
+	__u32 *mtu;
+
+	mtu = bpf_map_lookup_elem(&map_mtu_wo, &key);
+	if (mtu)
+		bpf_check_mtu(ctx, 0, mtu, 0, 0);
+	return XDP_PASS;
+}
+
+SEC("tc/ingress")
+__failure __msg("write into map forbidden")
+int tc_readonly_mtu(struct __sk_buff *ctx)
+{
+	__u32 key = 0;
+	__u32 *mtu;
+
+	mtu = bpf_map_lookup_elem(&map_mtu_ro, &key);
+	if (mtu)
+		bpf_check_mtu(ctx, 0, mtu, 0, 0);
+	return TCX_PASS;
+}
+
+SEC("tc/ingress")
+__success
+int tc_writeonly_output(struct __sk_buff *ctx)
+{
+	__u32 key = 0;
+	__u32 *out;
+
+	out = bpf_map_lookup_elem(&map_mtu_wo, &key);
+	if (out)
+		bpf_get_current_comm(out, sizeof(*out));
+	return TCX_PASS;
+}
+
 char LICENSE[] SEC("license") = "GPL";
-- 
2.53.0

