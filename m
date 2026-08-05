Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E640B0E7
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785971249; cv=none; b=YpaajUyxDmZLjgIZx0NRlXVgR1Vp+Vo7bPdbYxcTqH3nVP6/ENmRmRvpO+wgHdx09YoxXEy23BhKMBtEmZhb1eRz65GibfwFAfo/K8PeS1rB/WQZy184ymKXAR/EYc107bCD4GX3N+viXv0sdna8b+XgTl2WkwJD35tZouFJh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785971249; c=relaxed/simple;
	bh=ufoZwSh628rJe4VxSzIVZqFvxjp9Zh9LHUcQ7/LuPqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFodHI4Fvi/gJLii527oG6UFbwf2F6Hq1veNez2cJXfaNL4LOwpUgUGtB0kkusy/SxBzAfu9cqVXJbXuJehJYLl7JYWQ0bAwMDgy8TJ4E/t5LNA8Cr7aDyCn0zIfjyUXsVJDqyVy9K7gDjSxEiVm8v0vQV25msfrH5uOeeUfMs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k/D6H8Q9; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k/D6H8Q9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785971246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiDPlC57u1vF60KHgmrKI3a7/nPG06gh2r7Mg4Fh3dk=;
	b=k/D6H8Q95aquj8L+XQu79qo2VwYs/edmQZXl4SxV+DEZ7pycBEirvWJhU3/T7XzSaW2lh4
	GxLSoN5r+hFuMwMr4WSB8UZ7MmWjKEOmuZ5dICsiIsvbJIl+bzE2KChGnh2vPZhc8bApld
	ZOUT1rpsWu2OrEqkVSuCtL6YFmPSnac=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 5/6] selftests/bpf: Verify decl tags emission in resolve_btfids test
Date: Wed,  5 Aug 2026 16:06:47 -0700
Message-ID: <20260805230648.2354989-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extend test_resolve_btfids() to assert that resolve_btfids emits a
BTF_KIND_DECL_TAG named "bpf_kfunc" for every kfunc, and
"bpf_fastcall" for kfuncs marked KF_FASTCALL.

Add a btf_has_decl_tag() helper that scans the output BTF for a decl
tag matching name and target.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 8482f00046d4..732cfed35e1c 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -12,6 +12,8 @@
 
 #define BTF_DATA_FILE "resolve_btfids.test.o.BTF"
 
+#define DECL_TAG_FASTCALL "bpf_fastcall"
+#define DECL_TAG_KFUNC "bpf_kfunc"
 #define TYPE_ATTR_ARENA "address_space(1)"
 
 #ifndef KF_FASTCALL
@@ -176,6 +178,28 @@ static int resolve_symbols(struct btf *btf)
 	return 0;
 }
 
+static bool btf_has_decl_tag(struct btf *btf, const char *tag_name, s32 target_id)
+{
+	const struct btf_type *t;
+	const char *name;
+	int nr, id;
+
+	nr = btf__type_cnt(btf);
+	for (id = 1; id < nr; id++) {
+		t = btf__type_by_id(btf, id);
+		if (!btf_is_decl_tag(t))
+			continue;
+		if (t->type != (__u32)target_id)
+			continue;
+		if (btf_decl_tag(t)->component_idx != -1)
+			continue;
+		name = btf__name_by_offset(btf, t->name_off);
+		if (strcmp(name, tag_name) == 0)
+			return true;
+	}
+	return false;
+}
+
 static void check_kfunc_set(struct btf_id_set8 *set)
 {
 	unsigned int i, j;
@@ -260,6 +284,22 @@ void test_resolve_btfids(void)
 	check_kfunc_set(&test_kfunc_set);
 	check_kfunc_set(&test_kfunc_set_rev);
 
+	/* Check resolve_btfids emitted a bpf_kfunc decl_tag for each kfunc */
+	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
+		ASSERT_TRUE(btf_has_decl_tag(btf, DECL_TAG_KFUNC,
+					     kfunc_symbols[i].id),
+			    kfunc_symbols[i].name);
+	}
+
+	/* Check resolve_btfids emitted bpf_fastcall for KF_FASTCALL kfuncs */
+	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
+		if (kfunc_symbols[i].flags & KF_FASTCALL) {
+			ASSERT_TRUE(btf_has_decl_tag(btf, DECL_TAG_FASTCALL,
+						     kfunc_symbols[i].id),
+				    kfunc_symbols[i].name);
+		}
+	}
+
 	/*
 	 * Check resolve_btfids wrapped exactly the arena-flagged return/args
 	 * with the address_space(1) type attribute, and left other
-- 
2.55.0

