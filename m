Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8F92D97BA
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774061109; cv=none; b=ivRbmbY4C5lMVfAloNIgCWYMetYcohwBe5cL814De1AcpLooF1Vj1oXpr1XnSL5MqmFihLuWK5m+tQ+y+V2Y7Y2ERAbsHPnK8V3PWsUQwFA1aVTxFU2vcaBermOfSnn7ne5RSPYLvTnbPkCfkqmahRwSb3b9YNG5GAxUSPJS5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774061109; c=relaxed/simple;
	bh=Q6p/PKASAUnOEbKLfuwx+b19UcjF5du/pBhWbx4ayKA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=CrCI4fZnN+CynUPQsUbuU5n3VoObrLorcWb5OhuSF1uEDRfk+TSv2ZWI+2IefpdAP0Dqi2RfzNfoYd24/aXFuoIfG00wlNrn+3LxMsml/DFTOr36XdBVpjNOvovUGuAlG2ETAa+LdRvlybVpbJ85FEYPWksiNVOyK+XChJzkv50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aG1bR20n; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aG1bR20n"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c105e5ac70so1224714eec.0
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 19:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774061107; x=1774665907; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+THnNIhXb4I1Hax0SNl1UEHbEI4ZOIHd6uYzFFXr4o=;
        b=aG1bR20nCZIRehSZhaVDcIJqVN36sfGAM5yO0vLJcQghaohoeDAhFndRenY5Aj/THC
         TcvTzo1irXYYT8kQYrSQHgmu+UGPviPca8HR7cj4eV4ik+tbxc3EnY0W8FKmpoPlqXSb
         wo/pw6n1oBIAhxsRJRzMZ3HDiG+d6OK1dlkIHmzTwyUpYpdOq0L/n3+DcIFZUo3ExDgo
         M6b9l7TKeoSKazPImU5MAluOFl6HqATQjBWZMv2YLyJ0b6MrGiK862f3sNtxOYcrCOf5
         oFyIFwSUsKhfRvR2WWEDm6TZ8Pclm0LCDDLyktWKiO++c/MGZ8AYBYuRLjlXy2qZJF8/
         Nr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774061107; x=1774665907;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+THnNIhXb4I1Hax0SNl1UEHbEI4ZOIHd6uYzFFXr4o=;
        b=EcI3JIvnvstP/891zzYWwnhaEAqRD5NZYCgAIHxeBScrjhQef32TmSNfX2mODr3vHZ
         GcBCu2P+OzU96PFUAC5RbHvvQlB6hRXdQ4Di0+lItnkEh+wsiTYlhvfjQw4DMp/M2ohK
         R+Ubn4oJjwHm7TO3Ag8GT1jLh8lKn8n7k/BXxpfuA7pBFlpmMpFc9oowRRq0Lrh6Olq8
         ei2rGKWtKyDsfXN+sQO2CDQIWZJ8uhgly32Ub5myko+Y20Tb4BSdvyyaq9nCFGfErgms
         2lryhJ2/k5q+moj+tc1oPPTmijhENI7gqCaXnYp7+ANlHlbKbsxV07UnXjVzRwlG4R42
         S1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCV7q/RNEYI+fMBLpKsaMOrQO/eU3eHShPGMEGAbIuGv0MwD9d5ra9TFHOqM7kqcg+aXCW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztzBXB32jfuYOfyljznJfheR9oGPzZA6o2jStUki9/uSY9TS0T
	5QWPJ966ZFahIc163plKvrCehY5Tpq4pYG3JLawUxjJsYRDIn+4DTUQHOe2NRsd37MQrCraHyxc
	fGl6Ym7JefQ==
X-Received: from dlbvs12.prod.google.com ([2002:a05:7022:3f0c:b0:12a:6d14:dfd9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4582:b0:12a:6c84:6039
 with SMTP id a92af1059eb24-12a726dd70amr2048952c88.41.1774061107157; Fri, 20
 Mar 2026 19:45:07 -0700 (PDT)
Date: Fri, 20 Mar 2026 19:44:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260321024446.692008-1-irogers@google.com>
Subject: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
From: Ian Rogers <irogers@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hashmap implementation contained strict aliasing violations.
Specifically, the hashmap_cast_ptr(p) macro was casting pointers (such
as void **) to long *, and these were subsequently dereferenced in
functions like hashmap_insert(), hashmap_find(), and hashmap_delete().

C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
through an lvalue of an incompatible type. Dereferencing a long * to
write to a void * object is a violation, even if they share the same
size, as they are not compatible types. This can lead to undefined
behavior, especially with aggressive compiler optimizations.

Fix this by:
1. Updating hashmap_insert(), hashmap_find(), and hashmap_delete() to
   take void * for their output parameters (old_key, old_value, and
   value).
2. Modifying the implementation to use memcpy() and memset() for
   accessing these output parameters. Accessing an object as an array of
   characters (as done by memcpy) is a permitted exception to the
   strict aliasing rules.
3. Updating the hashmap_cast_ptr(p) macro to return void *, ensuring
   compatibility with the new function signatures while preserving the
   static assertion that ensures the pointed-to type matches the size of
   a long.

Input parameters (key and value) remain as long, as they involve value
conversion rather than incompatible pointer dereferencing, which is safe
under strict aliasing rules.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.c | 21 +++++++++++----------
 tools/lib/bpf/hashmap.h |  8 ++++----
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index 140ee4055676..ef50d262a126 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -8,6 +8,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
 #include <errno.h>
 #include <linux/err.h>
 #include "hashmap.h"
@@ -153,24 +154,24 @@ static bool hashmap_find_entry(const struct hashmap *map,
 
 int hashmap_insert(struct hashmap *map, long key, long value,
 		   enum hashmap_insert_strategy strategy,
-		   long *old_key, long *old_value)
+		   void *old_key, void *old_value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
 	int err;
 
 	if (old_key)
-		*old_key = 0;
+		memset(old_key, 0, sizeof(long));
 	if (old_value)
-		*old_value = 0;
+		memset(old_value, 0, sizeof(long));
 
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
 	if (strategy != HASHMAP_APPEND &&
 	    hashmap_find_entry(map, key, h, NULL, &entry)) {
 		if (old_key)
-			*old_key = entry->key;
+			memcpy(old_key, &entry->key, sizeof(long));
 		if (old_value)
-			*old_value = entry->value;
+			memcpy(old_value, &entry->value, sizeof(long));
 
 		if (strategy == HASHMAP_SET || strategy == HASHMAP_UPDATE) {
 			entry->key = key;
@@ -203,7 +204,7 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 	return 0;
 }
 
-bool hashmap_find(const struct hashmap *map, long key, long *value)
+bool hashmap_find(const struct hashmap *map, long key, void *value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
@@ -213,12 +214,12 @@ bool hashmap_find(const struct hashmap *map, long key, long *value)
 		return false;
 
 	if (value)
-		*value = entry->value;
+		memcpy(value, &entry->value, sizeof(long));
 	return true;
 }
 
 bool hashmap_delete(struct hashmap *map, long key,
-		    long *old_key, long *old_value)
+		    void *old_key, void *old_value)
 {
 	struct hashmap_entry **pprev, *entry;
 	size_t h;
@@ -228,9 +229,9 @@ bool hashmap_delete(struct hashmap *map, long key,
 		return false;
 
 	if (old_key)
-		*old_key = entry->key;
+		memcpy(old_key, &entry->key, sizeof(long));
 	if (old_value)
-		*old_value = entry->value;
+		memcpy(old_value, &entry->value, sizeof(long));
 
 	hashmap_del_entry(pprev, entry);
 	free(entry);
diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index 0c4f155e8eb7..a888bf8c05de 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -116,7 +116,7 @@ enum hashmap_insert_strategy {
 	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
 				sizeof(*(p)) == sizeof(long),				\
 		       #p " pointee should be a long-sized integer or a pointer");	\
-	(long *)(p);									\
+	(void *)(p);									\
 })
 
 /*
@@ -128,7 +128,7 @@ enum hashmap_insert_strategy {
  */
 int hashmap_insert(struct hashmap *map, long key, long value,
 		   enum hashmap_insert_strategy strategy,
-		   long *old_key, long *old_value);
+		   void *old_key, void *old_value);
 
 #define hashmap__insert(map, key, value, strategy, old_key, old_value) \
 	hashmap_insert((map), (long)(key), (long)(value), (strategy),  \
@@ -147,14 +147,14 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 #define hashmap__append(map, key, value) \
 	hashmap__insert((map), (key), (value), HASHMAP_APPEND, NULL, NULL)
 
-bool hashmap_delete(struct hashmap *map, long key, long *old_key, long *old_value);
+bool hashmap_delete(struct hashmap *map, long key, void *old_key, void *old_value);
 
 #define hashmap__delete(map, key, old_key, old_value)		       \
 	hashmap_delete((map), (long)(key),			       \
 		       hashmap_cast_ptr(old_key),		       \
 		       hashmap_cast_ptr(old_value))
 
-bool hashmap_find(const struct hashmap *map, long key, long *value);
+bool hashmap_find(const struct hashmap *map, long key, void *value);
 
 #define hashmap__find(map, key, value) \
 	hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
-- 
2.53.0.959.g497ff81fa9-goog

