Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B226356749
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953964; cv=none; b=lf/DZItdYsUathn0Qji+i2LBV3artFfEOc/T+GIstt59a5PK8gtyiDM0IeW2FKviImGcMFc62eBX/I+N4rlP7mSXpkoA/FhPR7MgJPbOu/9k4YFXczwsWv9b8Tokhw3soyqq+940L4NYzlzdOs/HHw5MScAtJFeKRJv+ywtJvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953964; c=relaxed/simple;
	bh=MSpDN8pe4okCg2foTKhI5xVkwd0rojRu2kUZTYgPnts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neOmqB+CCwQp3n5UwuzGhAJR71bb0vkMUwnXZpZWTd6bXRQ7Dp4MTkrNDGBhluXRwRdL1/t3eHY8WnMloyYQ4uyg2BKzHo43wspst2iVte2zlDDylqxHUMf6tPbBnFkWcXQZq2tJtdiCXMD1FhCOtIB0uAQVdr9KIggCWEKrWOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rHteMdge; arc=none smtp.client-ip=95.215.58.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rHteMdge"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MSpDN8pe4okCg2foTKhI5xVkwd0rojRu2kUZTYgPnts=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787953960; v=1; x=1788558760;
 b=rHteMdge1tYHhhSvJ1jqtF39GWAFFrdAHLDZATcwIXP7vLgD7hhUhp7yHrWVABnIxKr8k7g4
 oRyAcLFExhYL/jIHUI1xQiGrsTB8Fw7I+vi10N2qxGzttnwfSCkBiASsp8TUI/qlAbdIn/gPgpR
 is/wb/RyV/d5xFARbuS7g8EE=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id e2c8c195ece31b63;
	Fri, 28 Aug 2026 21:52:40 +0000
X-Mizu-Trace-ID: e2c8c195ece31b63
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 6/6] bpftool: Don't drop a type in the sorted C dump
Date: Fri, 28 Aug 2026 14:52:07 -0700
Message-ID: <20260828215207.3105313-7-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828215207.3105313-1-ihor.solodrai@linux.dev>
References: <20260828215207.3105313-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C dump sorts types by default, so that generated headers are
diffable. The sorted dump emits one type fewer than the unsorted dump
of the same BTF.

dump_btf_c() starts its loop at index 1 to skip the void type at BTF
type ID 0. That holds for the unsorted dump, where the array index is
the type ID, but not after qsort(): position 0 is then the lowest
ranked type, and btf_type_rank() ranks an anonymous enum 0 while void
takes the default rank of 10. So the enum is skipped, and void is
emitted instead as a no-op.

Fixes: 94133cf24bb3 ("bpftool: Introduce btf c dump sorting")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c                                     | 6 +++++-
 .../testing/selftests/bpf/bpftool_btf_dump_sorted.expected  | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index c9589026da8d..bca0a3982f09 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -805,9 +805,13 @@ static int dump_btf_c(const struct btf *btf,
 
 		if (sort_dump)
 			datums = sort_btf_c(btf);
-		for (i = 1; i < cnt; i++) {
+		for (i = 0; i < cnt; i++) {
 			int idx = datums ? datums[i].index : i;
 
+			/* type ID 0 is void, skip it */
+			if (idx == 0)
+				continue;
+
 			err = btf_dump__dump_type(d, idx);
 			if (err)
 				goto done;
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
index a9c6b688ffd7..5470b2b43229 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
@@ -21,6 +21,10 @@
 #endif
 #endif
 
+enum {
+	E0 = 1,
+};
+
 struct holey {
 	int c;
 	long: 32;
-- 
2.55.0

