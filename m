Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC23515D1
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796723; cv=none; b=t/BSsvBqS0OQOhh4EVYFPCWUXRlXBZ/O3eBIsnzwXUtWwgY+01lssaiBGhCMhrtyMa63AE0OGQWQt7n7YidUipy0g0fS0kqGHVpkU6wIoUJUwYh/aXuCTQ56Na+g5XRlCLHkroGoy0OLLzFK5eqXnivvNt3nZkXUpWNETecu9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796723; c=relaxed/simple;
	bh=Svu6RnhGT9ZaCeLWHnUB6lDy88M5KDFUcgws65Kp+Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FW4KwYiOFZ3S3KNO8JEYL05QLEBY4fbu0RPQjq9V42HrtSdHG6y14i6eskzqFnOZdNpkARmL5jzrQi1zEXh4+Bc02ikQtmvhghSStddRrrMIpsv+4+0w9u1xZKu6pq6EILra/VLE42sPMqrRlLmqxiRQFXpzW6q5WafQeTIheY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jieKoxDv; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jieKoxDv"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398beb616f5so2685577a91.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796721; x=1791401521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pdh4TJMe4IwWqWncc/VpIzLiHgpOZB9O/Ewm26UKyuo=;
        b=jieKoxDvCdk1GKQMomlCzZhsTspp5Zs7d0r2knL6pu1+YVwvvIl8CW1U+fgnkgMIMt
         FwKrLAb38xGhKshfNnmYg8eZP0ahraybYUyrBmcSXlzV02X3k1xZJn3FOYccL7V9DTiA
         uxcXOs6usIbGttbQYQAGjxM/MugLIfVZ0DdusKKmaXFoqD+ltsz76W7ARjNxZKVIUujs
         1POaZk2DHUugPZz6Ev4zaeajIuhum0Z4tvwww/8MTHr9Ck/gCDgIGOYvVe40xUv7beZ1
         OqloWGCHFDWWD6FIX9OomU/3+uXBTfiG+ijAp4m7iCsi7VMy39P4kv42yl0yo33ddstd
         VbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796721; x=1791401521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pdh4TJMe4IwWqWncc/VpIzLiHgpOZB9O/Ewm26UKyuo=;
        b=Tt07rbIxp8kBSqx9+W9J8ZTwloOfS7PPeZUSsgx3ykkazqbMw/qtoOah/IAGQH9qov
         obJKIY+JodDrKGTXzQC784q5DpFVCEY+0jpkRqOD9tgchkh049dutPTtziZ/fpKH1xZO
         tseBwTuWvSvDBI/BWu9XNVZXoyM1CHFtnezObKpdqrxFXtUc1qgnFIu0uFvB2e9How9t
         htKTnrZxIvBWRs1jrk/nWMtHHkRFV2RoUBsWFOPMCcnNaRiUP7gaDuToLS0D1dhKpffK
         VweUYwcJhMFMC9OVMO57fLzilrpPttFAjlBChgJeIoE9d0EIoFK3bLZsl3FdLWqdJq5+
         Sg8w==
X-Gm-Message-State: AFq9FYJkdOo4Cod5m20AmMrgD4nGAHN/zf1MxZKEGG2m2bSXFmkyB0oj
	HGxX7CpgPeXmoSEoO0DWLvWxZ47pFb/2ss3QE78GMQpJ31F6FG+FsHaT2MhQLTii
X-Gm-Gg: AYBFou29gH4rjnikfqrtlFlXtzyKS9IxjN8gCSecMeT+0/glibkqlEiAlcVLYU9ccKK
	PTQi+8nYuuXIIj9VB8+Y3ITYxVPSlZMisZM3rzV9AAUWrRsS83Yen4xCaKgq31MpDLsYPRMYy17
	ZymxMQzqpDSsopsStPrVucASEAdWPIE1y/I/cbTAMGShfvYXVcuGm29Lu7yktO9Xr0ouGHMjmVF
	DUXuQc1wldtC7/CrRPK7SUvItgYW77TcUL3wy+yuZzjIJLV+JIfRIbygIvcN7L/MlvfYJ/KBr7q
	yC1oIYIwkvgcL0ZK5DbiYxWy7QApEK5fbiMIXBDghDajEsLU0ty7tGfW0irO6mC907nYmTqK+lM
	2pf9+zTu/J1b0kF9Do+HKFtor5dbKM75VzaaWTrylKJGzElHu5sPJRSDFGltpcyTDV15o+GVLON
	m6xt7O7WKkbEU1H8yHaUcG/GREG7DXWYXqkbonF+QENIMv/ItHlEAjGR/vAbpS5lXjsYOqoMF8m
	qnEYk7Dwai0CYMdi1l4GcROHOtQlXopAi3ayWKxGee/q6yEyOyXte/Kzz0rdkKCG6/E3LBZVqmj
	htIF63jv2ElEuO2Q2PQNLkurc2SVxtyifYDSZ+kAbLWiM3OE7EzqIw==
X-Received: by 2002:a17:90a:fc50:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3a4f32b4c7bmr314121a91.38.1790796721163;
        Wed, 30 Sep 2026 12:32:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f479dc9fsm658077a91.15.2026.09.30.12.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:32:00 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 10/14] selftests/bpf: Add tests for a variable that is smaller than its type
Date: Wed, 30 Sep 2026 19:31:23 +0000
Message-ID: <20260930193127.2181684-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Check that a variable in DATASEC that is smaller than its type is not
printed when the map is read from bpffs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/btf_rust.c       | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_rust.c b/tools/testing/selftests/bpf/prog_tests/btf_rust.c
index b0128daceaa1..9eed78d98265 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_rust.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_rust.c
@@ -75,8 +75,73 @@ static void test_func_name(void)
 	btf__free(btf);
 }
 
+#define PIN_PATH "/sys/fs/bpf/btf_rust_piece"
+
+/*
+ * A piece of a static that LLVM split has the type of the whole static.
+ * It's the last variable in the section, so its type ends past the map value.
+ */
+static void test_piece(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	int int_id, struct_id, var_id, piece_id, sec_id, map_fd = -1, key = 0;
+	__u32 value[2] = { 0x11111111, 0x22222222 };
+	char line[256] = {};
+	struct btf *btf;
+	FILE *f = NULL;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf"))
+		return;
+	int_id = btf__add_int(btf, "u32", 4, 0);
+	ASSERT_GT(int_id, 0, "int");
+	struct_id = btf__add_struct(btf, "Whole", 8);
+	ASSERT_GT(struct_id, 0, "struct");
+	ASSERT_OK(btf__add_field(btf, "a", int_id, 0, 0), "field");
+	ASSERT_OK(btf__add_field(btf, "b", int_id, 32, 0), "field");
+	var_id = btf__add_var(btf, "CNT", BTF_VAR_STATIC, int_id);
+	ASSERT_GT(var_id, 0, "var");
+	piece_id = btf__add_var(btf, "WHOLE.1", BTF_VAR_STATIC, struct_id);
+	ASSERT_GT(piece_id, 0, "piece");
+	sec_id = btf__add_datasec(btf, ".bss", sizeof(value));
+	ASSERT_GT(sec_id, 0, "datasec");
+	ASSERT_OK(btf__add_datasec_var_info(btf, var_id, 0, 4), "var info");
+	ASSERT_OK(btf__add_datasec_var_info(btf, piece_id, 4, 4), "piece info");
+	if (!ASSERT_OK(btf__load_into_kernel(btf), "btf load"))
+		goto out;
+
+	opts.btf_fd = btf__fd(btf);
+	opts.btf_value_type_id = sec_id;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, ".bss", sizeof(key), sizeof(value), 1, &opts);
+	if (!ASSERT_GE(map_fd, 0, "map create"))
+		goto out;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, value, 0), "map update"))
+		goto out;
+
+	/* the variable is printed, the piece is not */
+	unlink(PIN_PATH);
+	if (!ASSERT_OK(bpf_obj_pin(map_fd, PIN_PATH), "pin"))
+		goto out;
+	f = fopen(PIN_PATH, "r");
+	if (!ASSERT_OK_PTR(f, "open"))
+		goto out;
+	while (fgets(line, sizeof(line), f) && line[0] == '#')
+		;
+	ASSERT_HAS_SUBSTR(line, "286331153", "var");
+	ASSERT_NULL(strstr(line, "572662306"), "piece");
+out:
+	if (f)
+		fclose(f);
+	unlink(PIN_PATH);
+	if (map_fd >= 0)
+		close(map_fd);
+	btf__free(btf);
+}
+
 void test_btf_rust(void)
 {
 	if (test__start_subtest("func_name"))
 		test_func_name();
+	if (test__start_subtest("piece"))
+		test_piece();
 }
-- 
2.55.0

