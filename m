Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097135F179
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352331; cv=none; b=J3VNSRk54CznIUp755kZ7hbx2i0JVt4qKxNNhI6szcyZV5TBCFzi3BuIaywdHfGNwTiLQAYJt/H1nIjtnRw9mVHw/fJRdpz1ECNE0foVlfrSqflqDYLo09yAyxRvZrErmvmUKzAya6OYYjoSHV1fq0pQi57j4Mlv/qJdw0geNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352331; c=relaxed/simple;
	bh=9kkXs74naFLkR7tsQ97HfR/dSsWcR0xtD7xs9YcLoNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfTm9Dy7R55L9zihFFa3/UHuPghmRE6qhl9L4EHQjEE3LD5XsAssQKLQHSNkE2ACj4lUerMsbvHNhcxrLxGEu4W7NBoj0u4YmvuomQFu/lOoGRK7dFw8QBdhRSJyEwWGS7vKFwylAc+RiDt2tATdSeFw1N+ZNHLxi5scLZ4FcNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Up5FO+UB; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Up5FO+UB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780352327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2JCsshQIRcXFwnXyputxFVFmahr9SGDljCocSGVm/Y=;
	b=Up5FO+UB5h6tx5ksrDhelY6HFkzLeCig85pG/Sny9EUbbWmnUdqI5M3pSVaEWNPRyZ1KyD
	vWEsGY4WyBhsiHKEZcIfda4uwuA8btqMU7igwJPRX5xfzgKNYWks4a76ihdcTp3+eHh2xF
	S/guf9j9AZIj0ukFGUsSLORahh3AhTw=
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
Subject: [PATCH bpf-next v1 01/14] tools/bpf: Sync btf_ids.h to tools
Date: Mon,  1 Jun 2026 15:17:52 -0700
Message-ID: <20260601221805.821394-2-ihor.solodrai@linux.dev>
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

Sync tools/include/linux/btf_ids.h with include/linux/btf_ids.h so
tools-side code can use BTF_ID_FLAGS(), BTF_SET8_START(), and
BTF_KFUNCS_START().

Keep the tools copy's existing compiler header dependency:
tools/include/linux/compiler.h already provides __maybe_unused and
tools/include/linux/compiler_attributes.h does not exist.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/include/linux/btf_ids.h | 78 ++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 72ea363d434d..4fe5c5f1558c 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -10,6 +10,9 @@ struct btf_id_set {
 	u32 ids[];
 };
 
+/* This flag implies BTF_SET8 holds kfunc(s) */
+#define BTF_SET8_KFUNCS		(1 << 0)
+
 struct btf_id_set8 {
 	u32 cnt;
 	u32 flags;
@@ -22,6 +25,7 @@ struct btf_id_set8 {
 #ifdef CONFIG_DEBUG_INFO_BTF
 
 #include <linux/compiler.h> /* for __PASTE */
+#include <linux/stringify.h>
 
 /*
  * Following macros help to define lists of BTF IDs placed
@@ -35,7 +39,7 @@ struct btf_id_set8 {
 
 #define BTF_IDS_SECTION ".BTF_ids"
 
-#define ____BTF_ID(symbol)				\
+#define ____BTF_ID(symbol, word)			\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
 ".local " #symbol " ;                          \n"	\
@@ -43,10 +47,11 @@ asm(							\
 ".size  " #symbol ", 4;                        \n"	\
 #symbol ":                                     \n"	\
 ".zero 4                                       \n"	\
+word							\
 ".popsection;                                  \n");
 
-#define __BTF_ID(symbol) \
-	____BTF_ID(symbol)
+#define __BTF_ID(symbol, word) \
+	____BTF_ID(symbol, word)
 
 #define __ID(prefix) \
 	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
@@ -56,7 +61,14 @@ asm(							\
  * to 4 zero bytes.
  */
 #define BTF_ID(prefix, name) \
-	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))
+	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__), "")
+
+#define ____BTF_ID_FLAGS(prefix, name, flags) \
+	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__), ".long " #flags "\n")
+#define __BTF_ID_FLAGS(prefix, name, flags, ...) \
+	____BTF_ID_FLAGS(prefix, name, flags)
+#define BTF_ID_FLAGS(prefix, name, ...) \
+	__BTF_ID_FLAGS(prefix, name, ##__VA_ARGS__, 0)
 
 /*
  * The BTF_ID_LIST macro defines pure (unsorted) list
@@ -155,10 +167,58 @@ asm(							\
 ".popsection;                                 \n");	\
 extern struct btf_id_set name;
 
+/*
+ * The BTF_SET8_START/END macros pair defines sorted list of
+ * BTF IDs and their flags plus its members count, with the
+ * following layout:
+ *
+ * BTF_SET8_START(list)
+ * BTF_ID_FLAGS(type1, name1, flags)
+ * BTF_ID_FLAGS(type2, name2, flags)
+ * BTF_SET8_END(list)
+ *
+ * __BTF_ID__set8__list:
+ * .zero 8
+ * list:
+ * __BTF_ID__type1__name1__3:
+ * .zero 4
+ * .word (1 << 0) | (1 << 2)
+ * __BTF_ID__type2__name2__5:
+ * .zero 4
+ * .word (1 << 3) | (1 << 1) | (1 << 2)
+ *
+ */
+#define __BTF_SET8_START(name, scope, flags)		\
+__BTF_ID_LIST(name, local)				\
+asm(							\
+".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+"." #scope " __BTF_ID__set8__" #name ";        \n"	\
+"__BTF_ID__set8__" #name ":;                   \n"	\
+".zero 4                                       \n"	\
+".long " __stringify(flags)                   "\n"	\
+".popsection;                                  \n");
+
+#define BTF_SET8_START(name)				\
+__BTF_SET8_START(name, local, 0)
+
+#define BTF_SET8_END(name)				\
+asm(							\
+".pushsection " BTF_IDS_SECTION ",\"a\";      \n"	\
+".size __BTF_ID__set8__" #name ", .-" #name "  \n"	\
+".popsection;                                 \n");	\
+extern struct btf_id_set8 name;
+
+#define BTF_KFUNCS_START(name)				\
+__BTF_SET8_START(name, local, BTF_SET8_KFUNCS)
+
+#define BTF_KFUNCS_END(name)				\
+BTF_SET8_END(name)
+
 #else
 
-#define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
+#define BTF_ID_LIST(name) static u32 __maybe_unused name[128];
 #define BTF_ID(prefix, name)
+#define BTF_ID_FLAGS(prefix, name, ...)
 #define BTF_ID_UNUSED
 #define BTF_ID_LIST_GLOBAL(name, n) u32 __maybe_unused name[n];
 #define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 __maybe_unused name[1];
@@ -166,6 +226,10 @@ extern struct btf_id_set name;
 #define BTF_SET_START(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_START_GLOBAL(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_END(name)
+#define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
+#define BTF_SET8_END(name)
+#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
+#define BTF_KFUNCS_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
 
@@ -215,5 +279,9 @@ MAX_BTF_TRACING_TYPE,
 };
 
 extern u32 btf_tracing_ids[];
+extern u32 bpf_cgroup_btf_id[];
+extern u32 bpf_local_storage_map_btf_id[];
+extern u32 btf_bpf_map_id[];
+extern u32 bpf_kmem_cache_btf_id[];
 
 #endif
-- 
2.54.0

