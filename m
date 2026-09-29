Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61593DB964;
	Tue, 29 Sep 2026 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705251; cv=none; b=QLgQsyldn5QjAsr8fjPSH72LDkmVnZqxzRBNSUf6GmEN60pNYpUTNBr+MIYItIj7onqf2jCK/aAgKxdSKa6gHhS8ryYFURQAYmh5BetBQFx6MRHAZk/8DRMsnW4TH24x2eVKOYnxWrBhCAM3MCwkPkoqfdXIqToz41n3kgqY86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705251; c=relaxed/simple;
	bh=XYOaZbRokxjR3B6SH6nyhW9zCU/VeMMpUYKXX/U8GK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/5EByaY6KWrBFHi/rtEh/0w5VIvGZSKANHcsWdOKyF+69ulCrJqy9GvY+9K/qUMR+rvhCgbKC27XxyrX6Gt8EltJcr+/a9M2reQTFEYPUFghtUJoWeENCYV0n7uzYyHaH07iUhVksove5HKuq0jHEI6ftoKR7WWQkWcsG8aetw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab5J9ee1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab5J9ee1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80B6DC4AF15;
	Tue, 29 Sep 2026 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790705251;
	bh=XYOaZbRokxjR3B6SH6nyhW9zCU/VeMMpUYKXX/U8GK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ab5J9ee1qIrhljNTtq9opmY26T7gMK3m9qN6sF/DFO/1NWdPxO15wkMhnh8CP1mk4
	 8JjW1seOHEaNbrx/viGXmhcRokVJtWdcYhU5XmPIQMOsDkZQUPvW9hmHuh9AWq81sM
	 URRkdeZZIuouLSMLQf3IU4ZIzv2dvSKsZXUVg2rayihLKbMfMG8NUnfGYFlWbC75nA
	 NlKKmX5mmhtgO1BilEDbnwdhRt0gZt6Btob8L2ydP057vWehKbQtb6sDNqDHyBKHCw
	 isf5+j1P+JucSurgGjWZc9Di333QTkZuYbWe8ucgz9+AH5vJCK08kBGbzeHijjGFbb
	 X5vB5BtkgQ9qA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB36CA5FAD;
	Tue, 29 Sep 2026 18:07:31 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 29 Sep 2026 12:07:31 -0600
Subject: [PATCH v7 2/3] kallsyms: Increase marker density to 16:1 to
 accelerate lookups
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-ksyms-tune-v7-2-be568ceef41e@gmail.com>
References: <20260929-ksyms-tune-v7-0-be568ceef41e@gmail.com>
In-Reply-To: <20260929-ksyms-tune-v7-0-be568ceef41e@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, 
 Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Kees Cook <kees@kernel.org>, David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 bpf@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790705250; l=5688;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=L4+N7wtX63R4ON7KHqWeibK8O6baOU4ILoweuWjUQVg=;
 b=EPNmLWaNlLyoHmqK9vY/cNLtX7TGIah4Z3Q4bWcH58kHqkaEoZdiG5xfjKmJupB9xxhYLvOi7
 AkgVipaT7gXBOxBgX94kYQQHDTvHPC0hmd68rCUcEg4OFhGmBQeYHFW
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

kallsyms stores symbols with remarkably efficient packing, and simple
streaming unpacking, laid out sequentially in address order.  That said,
variable-length records make arbitrary access inherently linear.
kallsyms_markers[] addressed this by marking stream offsets every 256
symbols, reducing the scan distance by 256x down to an average of
127.5 sequential steps.

While 127.5 hops was negligible for rare, single-shot oops backtraces,
both table size (~184k symbols) and lookup traffic have expanded
substantially.  In alphabetical binary search (kallsyms_lookup_names),
each of the ~17 comparison probes must locate candidate symbols via
get_symbol_offset(), compounding into ~2,170 sequential symbol hops
per lookup.  In bulk tracing workloads (such as BPF multi-kprobe
attach), this penalty compounds into multi-second latency.

Without altering the underlying storage layout, we can retune this
trade-off directly by increasing marker density from 256:1 down to
16:1 (KALLSYMS_MARKER_SHIFT 4) in kernel/kallsyms_internal.h, shared
between scripts/kallsyms.c and kernel/kallsyms.c.

This caps the remainder scan at 15 symbols and cuts average scan distance
from 127.5 down to 7.5 hops (a 17x reduction).  Across a 17-step binary
search, total hops collapse from ~2,170 down to ~127.  For a kernel with
~184,000 symbols, this adds ~10,800 u32 marker entries (+42 KiB) to
write-protected .rodata.

In-tree CONFIG_KALLSYMS_SELFTEST measurements across all ~184k symbols
show average lookup latency dropping from 6,102 ns down to 866 ns (a
7.0x speedup).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v6:
- Recast intro around the kallsyms storage/marker trade-off (efficient
  address packing vs linear search hops).
- Drop hunk-by-hunk numbered list from commit body (addresses BPF CI
  review).
- Drop 0.002% percentage claim and state absolute .rodata cost (+42 KiB
  for ~184k symbols).
- Drop ephemeral benchmark comment from kernel/kallsyms_internal.h.
  replace with scripts/kallsyms.c include ref and __KERNEL__ wrap

Changes in v5:
- Replace dynamic 1:1 batch lookup index (kvmalloc, mutexes, RCU) with
  static 16:1 marker density (KALLSYMS_MARKER_SHIFT 4) in .rodata
  (addresses Kees Cook review).
- Eliminate all dynamic RAM allocations, setup/teardown costs, and
  external batch APIs.

fx2
---
 kernel/kallsyms.c          |  8 ++++----
 kernel/kallsyms_internal.h | 11 +++++++++++
 scripts/kallsyms.c         | 14 +++++++++-----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index d18d78e626db..91ced7aa797e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -150,10 +150,10 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	int i, len;
 
 	/*
-	 * Use the closest marker we have. We have markers every 256 positions,
-	 * so that should be close enough.
+	 * Use the closest marker we have. We have markers every
+	 * (1 << KALLSYMS_MARKER_SHIFT) positions, so that should be close enough.
 	 */
-	name = &kallsyms_names[kallsyms_markers[pos >> 8]];
+	name = &kallsyms_names[kallsyms_markers[pos >> KALLSYMS_MARKER_SHIFT]];
 
 	/*
 	 * Sequentially scan all the symbols up to the point we're searching
@@ -161,7 +161,7 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	 * so we just need to add the len to the current pointer for every
 	 * symbol we wish to skip.
 	 */
-	for (i = 0; i < (pos & 0xFF); i++) {
+	for (i = 0; i < (pos & KALLSYMS_MARKER_MASK); i++) {
 		len = *name;
 
 		/*
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 81a867dbe57d..6a781e4cc77f 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -2,6 +2,16 @@
 #ifndef LINUX_KALLSYMS_INTERNAL_H_
 #define LINUX_KALLSYMS_INTERNAL_H_
 
+/*
+ * Provide compile-constants for scripts/kallsyms.c
+ * so it can build the corresponding kallsyms_marker[] table.
+ * and wrap the rest in __KERNEL__
+ */
+#define KALLSYMS_MARKER_SHIFT 4
+#define KALLSYMS_MARKER_SIZE  (1U << KALLSYMS_MARKER_SHIFT)
+#define KALLSYMS_MARKER_MASK  (KALLSYMS_MARKER_SIZE - 1U)
+
+#ifdef __KERNEL__
 #include <linux/types.h>
 
 extern const int kallsyms_offsets[];
@@ -14,5 +24,6 @@ extern const u16 kallsyms_token_index[];
 
 extern const unsigned int kallsyms_markers[];
 extern const u8 kallsyms_seqs_of_names[];
+#endif /* __KERNEL__ */
 
 #endif // LINUX_KALLSYMS_INTERNAL_H_
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 494852ade6d8..be42a9111350 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -29,6 +29,8 @@
 
 #include <xalloc.h>
 
+#include "../kernel/kallsyms_internal.h"
+
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
 #define KSYM_NAME_LEN		512
@@ -349,16 +351,18 @@ static void write_src(void)
 	printf("\t.long\t%u\n", table_cnt);
 	printf("\n");
 
-	/* table of offset markers, that give the offset in the compressed stream
-	 * every 256 symbols */
-	markers_cnt = (table_cnt + 255) / 256;
+	/*
+	 * Table of offset markers, giving the offset in the compressed stream
+	 * every (1 << KALLSYMS_MARKER_SHIFT) symbols.
+	 */
+	markers_cnt = (table_cnt + KALLSYMS_MARKER_MASK) >> KALLSYMS_MARKER_SHIFT;
 	markers = xmalloc(sizeof(*markers) * markers_cnt);
 
 	output_label("kallsyms_names");
 	off = 0;
 	for (i = 0; i < table_cnt; i++) {
-		if ((i & 0xFF) == 0)
-			markers[i >> 8] = off;
+		if ((i & KALLSYMS_MARKER_MASK) == 0)
+			markers[i >> KALLSYMS_MARKER_SHIFT] = off;
 		table[i]->seq = i;
 
 		/* There cannot be any symbol of length zero. */

-- 
2.55.0


