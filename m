Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EEC30B508
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352334; cv=none; b=jUK8kiK6tcEPX4QbC059gk5fymP/Zghlj57rfd7jTjqg2w0rMX2luC38bQHYtiSyGdTQUlvmaS0XLSg4RmbX8fXZg9XCBETV4SJyM3s431o56DfD4Q+HdeGdw+Lf1guU0i0Vdqu+vDX3nleU0KW6MFGtlPvJCDclVxEy9pnCeoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352334; c=relaxed/simple;
	bh=cKyC29Mpejq/o3/GFTTaQXfwKGlw9qvTm6uLHth5pzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pn1xsBkSaueAHiqvBzlb68gmGNqO8eVCSzkwJVpycK/a0mmzpB6D0cN4JfLpYGZ2hSuAsY7ooUqG5GOmexMSQXgLwE39wrARh+osXnr1uub76bUP8gq//qB5WG6iMXUJ+1yJzBPnbjObLW01Ng0lmshxGErOSIc3REmLY2KqImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qmbImLXg; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qmbImLXg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780352330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KuxV3llsZQEZKsr/Dw96hOLpfxljH7pbk11d032UK1c=;
	b=qmbImLXgTMpLC9OnuNwgbCaJsjHmb716IkR5lPE5PCFIbiw3TYgsnjz6/tWMWP0I87MN4j
	GH8AUBoASDZZRmITW30C7j78zFkjepxok1KBVp0s1ApiLyCF2SlumF85shdVvyhxw9mV/t
	7DbzdrUBeZRqrgONEtwKIKZoYBZzn5k=
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
Subject: [PATCH bpf-next v1 02/14] selftests/bpf: Modernize resolve_btfids test scaffolding
Date: Mon,  1 Jun 2026 15:17:53 -0700
Message-ID: <20260601221805.821394-3-ihor.solodrai@linux.dev>
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

Refactor resolve_btfids test in order to:
  * use newer ASSERT_* macros instead of CHECK
  * extend the lifetime of loaded BTF to enable additional checks
  * cleanup unused/unnecessary code

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 54 +++++++------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 41dfaaabb73f..d742ecb2ca8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -10,8 +10,6 @@
 #include <linux/btf_ids.h>
 #include "test_progs.h"
 
-static int duration;
-
 struct symbol {
 	const char	*name;
 	int		 type;
@@ -95,25 +93,15 @@ __resolve_symbol(struct btf *btf, int type_id)
 	return 0;
 }
 
-static int resolve_symbols(void)
+static int resolve_symbols(struct btf *btf)
 {
-	struct btf *btf;
+	__u32 nr = btf__type_cnt(btf);
 	int type_id;
-	__u32 nr;
-
-	btf = btf__parse_raw("resolve_btfids.test.o.BTF");
-	if (CHECK(libbpf_get_error(btf), "resolve",
-		  "Failed to load BTF from resolve_btfids.test.o.BTF\n"))
-		return -1;
-
-	nr = btf__type_cnt(btf);
 
 	for (type_id = 1; type_id < nr; type_id++) {
 		if (__resolve_symbol(btf, type_id))
-			break;
+			return -1;
 	}
-
-	btf__free(btf);
 	return 0;
 }
 
@@ -121,25 +109,22 @@ void test_resolve_btfids(void)
 {
 	__u32 *test_list, *test_lists[] = { test_list_local, test_list_global };
 	unsigned int i, j;
-	int ret = 0;
+	struct btf *btf;
 
-	if (resolve_symbols())
-		return;
+	btf = btf__parse_raw("resolve_btfids.test.o.BTF");
+	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+		goto out;
+
+	if (resolve_symbols(btf))
+		goto out;
 
 	/* Check BTF_ID_LIST(test_list_local) and
 	 * BTF_ID_LIST_GLOBAL(test_list_global) IDs
 	 */
 	for (j = 0; j < ARRAY_SIZE(test_lists); j++) {
 		test_list = test_lists[j];
-		for (i = 0; i < ARRAY_SIZE(test_symbols); i++) {
-			ret = CHECK(test_list[i] != test_symbols[i].id,
-				    "id_check",
-				    "wrong ID for %s (%d != %d)\n",
-				    test_symbols[i].name,
-				    test_list[i], test_symbols[i].id);
-			if (ret)
-				return;
-		}
+		for (i = 0; i < ARRAY_SIZE(test_symbols); i++)
+			ASSERT_EQ(test_list[i], test_symbols[i].id, test_symbols[i].name);
 	}
 
 	/* Check BTF_SET_START(test_set) IDs */
@@ -153,15 +138,12 @@ void test_resolve_btfids(void)
 			break;
 		}
 
-		ret = CHECK(!found, "id_check",
-			    "ID %d not found in test_symbols\n",
-			    test_set.ids[i]);
-		if (ret)
-			break;
+		ASSERT_TRUE(found, "id_in_test_symbols");
 
-		if (i > 0) {
-			if (!ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check"))
-				return;
-		}
+		if (i > 0)
+			ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check");
 	}
+
+out:
+	btf__free(btf);
 }
-- 
2.54.0

