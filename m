Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B0359A6D
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737330; cv=none; b=JOQ0rWr2ME7zwV32Ld2tN2TuuCvOCPYOYhleHj41aEkmvdQCITVJDXE1mf3n1y8DiXLZuRWIjlpfX1xCAbOyftBjEyeF3Pr0DcSdDUgDIRmaiTsqrEE2//3ngb5yXADluYQJhqE2bqwcazwmoLudLOA7HGFw9hZ50dStz+mXtrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737330; c=relaxed/simple;
	bh=+CBvNUiTSmOb8wgesxgUgTkMkniAVeogmRUswrXtXR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5A/MddJa52pfah1h40BhIrXcp1n5UCSkbm1rGXHkaq0RW2r/EQE9Dcud5PcXcIrDdN0FUexvHseY/kanC9fMAvBdzEcMRkpbmvgqNvKp3jp8MvOAOR/4JjESqKal0WPr631+hMSs61qOhU2tEL3uuIPl4esvwNG6cK+2zy9DlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgcdhO+R; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgcdhO+R"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ccce967aa8dso490440a12.1
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791737325; x=1792342125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bu1uFXy7MfZO5yHU2XvzJsdWGBGl7lshba6a4TyW1P0=;
        b=kgcdhO+R3sIYGjzHF2jD6bWWIToh5JG8Q2oKYXYcuhZy93HF1/63+vmpz8Sp1yoIfh
         YZM5PpagAPMB4ZAoea1j4lZEf5IVVqrAylh+9oh51YDrtvfbpgu9QvnM1YzRPaY1/UIv
         LemMwf+uUJsj442GNsZIAGznwMhsSaE340+4kSsdff7jToQ8FE5TeFkv03HX5fDraBSM
         NMTqrxhpwBdVm35xp6QXCJKq8vtXa9YbEJzYGQkwzpSbJaMu7pD6UCKWhq/OtdbK4NIv
         Rl0cRHk2DUy4zhY4UHNRGw0iPb2lmZz0D7xC+BC7S5PjilPrz/KuKoi5n6rlrtYwoFJV
         f+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791737325; x=1792342125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bu1uFXy7MfZO5yHU2XvzJsdWGBGl7lshba6a4TyW1P0=;
        b=pDdv3wSyAIdRsn72NHzl5Svu4b/ri2J97i8BQXb/wN1wLebTFaNo5m89Hz59XQdxwG
         Q+MSIepTz5DEd6yPtTylL62C5AGOQmXjmF654hbiJ7cMlyaTTAsGDUnjiNA+LNb8DDA+
         ux/MGRb7+leSjLg3NwtxeZ+woSdH8EUCSxHdXSuzYzfNb/xuugFR5CHLFyZC3+mkRb3x
         gpM5noTYjCm/4bTKjIrfdttHcA95otSA+RJ0P1sdt3UKfH6zjS5e6a3IRwtf5t8tK31u
         UnAdtxLsPfK/JwYiKjSVLcnCITUrGihqNrVd/DswAORXKMpLP4mKyDGoQldaVMZFfNf9
         /naA==
X-Gm-Message-State: AFq9FYKAdS9+GizYI08Q0EJODtAfFQra3Rda5DtbrocebKHlTTX8iZwO
	3m4ZZVtezuLhHg1wzg/YSe2nPSSj0fIwL4lHXhSg3OMgkdiBycwd8JG1p5hbjWnyXhY=
X-Gm-Gg: AYBFou1PHK5JyjlEifJKyeiJJS6BSGQol5uTcjxHe+pQL9Ei+JxPBsxM1Aar5SKhW40
	cLcVB+MpbMIQDMzi+rw3k3xX318+/bcnK38GZEnSN5Z1C6uLSgJ8Zl2FUCG8qCyC6Xao7Tg61Nj
	14vk2NQys+N2TOimu4V+a7B7+YyepO9CF86oIpTzqxi74mKyNFn97DW8dNCHyXJXcwjzn5A541x
	vP4CnuLqXmMa537JbN5eklMOddwXCK6FGYvu7rEs5WDi1Y6QQzR3P5ABV0FJV8WKkyciKrIzJlp
	6Xy1430JGZNIJumgtooE4n52PlrsJK4vL6NxCu+5DpSKQmN22Wjn/zrJEQOPqxLb98LdiHoaz7n
	lDRHATJe3qWia8GS9+BBshFpyLuFK5vdPzk8tJsDbddwMxshY+851exNrug9EAxSq6jmQoLr2S2
	FJ1OzV2gYsTGBlJoE8PxRiZXqulZVqn+Wacb3gUwIMrOQHBv8Qjcw3os1tPz7uFZud87pDwH+IF
	lGDAj4yLxF5TrecGfq7GMKEJjtZpOI2bsux+Fj5rFp1BuZk6Kw5GBoFmsS8GKaLwN6mdTJHdGnk
	Bmjpogcbr9qp0Rhz4aTF0sm7TuhcCVTyJha/WhnDYGo=
X-Received: by 2002:a17:90b:2ec3:b0:3ab:365f:ebe2 with SMTP id 98e67ed59e1d1-3ab3a9553c0mr6434709a91.32.1791737324680;
        Sun, 11 Oct 2026 09:48:44 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed040dsm15642642a91.6.2026.10.11.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 09:48:44 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test tracing_multi link with BTF ids of the same address
Date: Sun, 11 Oct 2026 16:48:36 +0000
Message-ID: <20261011164836.2233874-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
References: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The stub of a syscall without arguments is an alias of its __do_sys_
function. Find such pair where both have BTF ids. Which ones do depends
on the compiler, so don't hard code the names. Check that each id can be
attached and that the attach of both in one link fails with -EINVAL.

With CONFIG_DEBUG_INFO_BTF_INLINE vmlinux BTF has 26 names with more
than one BTF_KIND_FUNC:

  [117318] FUNC 'hash' type_id=76715 linkage=static
  [117319] FUNC 'hash' type_id=76722 linkage=static
  [117320] FUNC 'hash' type_id=76789 linkage=static

while there is one 'hash' in kallsyms. tracing_multi_bench_attach skips
the names that are not unique in kallsyms only and passes all three ids
to the kernel. Take the first id of the name.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 0aa9532a05cf..cc727011f3a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -662,6 +662,97 @@ static void test_attach_api_fails(void)
 	free(ids2);
 }
 
+/*
+ * Find two BTF ids that resolve to the same address. The stub of a syscall
+ * without arguments is an alias of its __do_sys_ function.
+ */
+static bool get_same_addr_ids(__u32 *ids)
+{
+	const char *prefix = "__x64_sys_";
+	__u32 nr, type_id;
+	bool found = false;
+	struct btf *btf;
+	char alias[128];
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return false;
+
+	nr = btf__type_cnt(btf);
+	for (type_id = 1; type_id < nr && !found; type_id++) {
+		const struct btf_type *type = btf__type_by_id(btf, type_id);
+		const char *str;
+		long addr;
+		__s32 id;
+
+		if (!btf_is_func(type))
+			continue;
+
+		str = btf__name_by_offset(btf, type->name_off);
+		if (!str || strncmp(str, prefix, strlen(prefix)))
+			continue;
+
+		snprintf(alias, sizeof(alias), "__do_sys_%s", str + strlen(prefix));
+		id = btf__find_by_name_kind(btf, alias, BTF_KIND_FUNC);
+		if (id <= 0)
+			continue;
+
+		addr = ksym_get_addr(str);
+		if (!addr || addr != ksym_get_addr(alias))
+			continue;
+
+		ids[0] = type_id;
+		ids[1] = id;
+		found = true;
+	}
+
+	btf__free(btf);
+	return found;
+}
+
+static void test_attach_same_addr(void)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tracing_multi_fail *skel;
+	struct bpf_link *link;
+	__u32 ids[2];
+	int i;
+
+	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
+		return;
+
+	if (!get_same_addr_ids(ids)) {
+		test__skip();
+		return;
+	}
+
+	skel = tracing_multi_fail__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_fail__open_and_load"))
+		return;
+
+	/* Each id attaches fine on its own.. */
+	for (i = 0; i < 2; i++) {
+		opts.ids = &ids[i];
+		opts.cnt = 1;
+
+		link = bpf_program__attach_tracing_multi(skel->progs.test_fentry, NULL, &opts);
+		if (!ASSERT_OK_PTR(link, "attach_single"))
+			goto cleanup;
+		bpf_link__destroy(link);
+	}
+
+	/* ..but there's only one call site, so not both of them. */
+	opts.ids = ids;
+	opts.cnt = 2;
+
+	link = bpf_program__attach_tracing_multi(skel->progs.test_fentry, NULL, &opts);
+	if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "attach_same_addr"))
+		bpf_link__destroy(link);
+
+cleanup:
+	tracing_multi_fail__destroy(skel);
+}
+
 void serial_test_tracing_multi_bench_attach(void)
 {
 	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
@@ -748,6 +839,12 @@ void serial_test_tracing_multi_bench_attach(void)
 		if (!btf_type_is_traceable_func(btf, type))
 			continue;
 
+		/*
+		 * BTF can have more functions of the same name and they all
+		 * resolve to the same address, take just the first one.
+		 */
+		tdelete(&str, &root, compare);
+
 		err = libbpf_ensure_mem((void **) &ids, &cap, sizeof(*ids), cnt + 1);
 		if (err)
 			goto cleanup;
@@ -1023,6 +1120,8 @@ void test_tracing_multi_test(void)
 		test_session();
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
+	if (test__start_subtest("attach_same_addr"))
+		test_attach_same_addr();
 	RUN_TESTS(tracing_multi_verifier);
 	if (test__start_subtest("fentry_after_multi"))
 		test_fentry_after_multi();
-- 
2.55.0

