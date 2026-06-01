Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227E3403E8
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352352; cv=none; b=NeMmEBrvnX5DbrTBkgCmKD3sSffN+vqqIfjY+6XR+N7RPRZE2w9/4qnHKSlIFKN7WjxHchEZbLjLfvWgeb8AOVBtMK/86Wq4BNipxAoRNj+AaXEU13qxOysG9fsHXQEJu4eltKpUJUumqhEC0B9ZHt6fAgQQQhNfbgp2Yzu5dg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352352; c=relaxed/simple;
	bh=lJvF7cPh+f40LkOCThtTR2kE3A6LY70aJBx/npVkElI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEh1UAJzT6imm7WeF19uvsi4X5bR4y9HyCjWBoBSBjXFwnhmqzmvmjDRiyC430fKiwh025DJa47vOHYDcqS6eNLORe9e2sFYpdYjMQkRjpvF90uGwfsD55LXjlJExBpyCm30ZHTNwMgdVY3bDRdp/Sy4nURSC+wAeIN6wo7BBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kLxhrf+v; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kLxhrf+v"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780352349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9YrFVFGwoBrUMybWOvgZK+iDBwJWMRXZDjSUTLK8WE=;
	b=kLxhrf+v6Mju4X3v3lfEi9fVgNlcjiG0SaEXyYZ/w1jEy6uMdTfesTxKzMEMzFDidbC2KR
	dYVYG4nz/4bcotJrNm03xJXUcBspaQUkKaGTFlFrqreataYw5A8B6Ujxm3zQTecJq6BJgp
	OT1/nFQ3wLW6yhs2Lbwk/DtVLjH7Kqs=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v1 08/14] selftests/bpf: Verify bpf_kfunc decl tag emission in resolve_btfids
Date: Mon,  1 Jun 2026 15:17:59 -0700
Message-ID: <20260601221805.821394-9-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-1-ihor.solodrai@linux.dev>
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extend prog_tests/resolve_btfids.c to assert that resolve_btfids emits a
BTF_KIND_DECL_TAG of name "bpf_kfunc" for each kfunc declared in the
test BTF ID set. Add a small btf_has_decl_tag() helper that walks the
output BTF looking for a matching decl tag (name + target FUNC +
component_idx == -1).

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index f6fd79b9dd23..7d9c3460cbed 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -156,6 +156,28 @@ static int resolve_symbols(struct btf *btf)
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
+		if (name && strcmp(name, tag_name) == 0)
+			return true;
+	}
+	return false;
+}
+
 void test_resolve_btfids(void)
 {
 	__u32 *test_list, *test_lists[] = { test_list_local, test_list_global };
@@ -218,6 +240,12 @@ void test_resolve_btfids(void)
 				  test_kfunc_set.pairs[i].id, "kfunc_sort_check");
 	}
 
+	/* Check resolve_btfids emitted bpf_kfunc decl_tag for each kfunc */
+	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++)
+		ASSERT_TRUE(btf_has_decl_tag(btf, "bpf_kfunc",
+					     kfunc_symbols[i].id),
+			    kfunc_symbols[i].name);
+
 out:
 	btf__free(btf);
 }
-- 
2.54.0

