Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253785;
	b=tCjmAxk2N+XFjXgX1H2/Jel9uHF6tOLxp9hTLs0jtkMmWJsCZxVwrRsEduoU5ui+iGUh
	 Yu2QXbNLIBDVT30HLjVWspGFbELRZKdWishv0n6HTCpjeVX7OSV8iEPqRb++bNRgMvbGb
	 P5qohoLqcBS0BpkUD31TEKSWg+T1T29ooIZZEgES2hg3F6t5PiI30aIRZtx6JF6ikUBBC
	 AZg7gAPCNjdO6zpOKBFRwyDyR3P8itDl63i0qUzMlPzr6JvHFX5suCEnqVY2CA/jRP+U0
	 FVt0cFk1ZXtTlswaUv/sr+8va1EVrZZ9GV4/a8ojsxt7KHhNmEBb5RlBzOy+eKfPM7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253785;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M8CHeRKzRhc8Z/RcnT9AUUayDTie+d/p213vXc4rCPs=;
	b=5tjoQkbDpwTCV+uMu8Mgookr3g0+kb9jvgmAhdPBwdwXerjJazez6FNY/zmFIrDJvb/f
	 l8ELoM3VIo43KNXLm3pTwyPMgnkM50IORDkMSZK5eIR0h2OtMfaCSUNGs1C3GfUkXG1S5
	 9wFMCKcslgBNxgkHmNQpz6pseJTUslSUE+r8mysoVIOR81su+AR/jGQ2KZBAsfyJN1T9p
	 l4a0Rdbr0ZduZW2yJJBs13hmHU/DLPyVzRUuO675a3VN4OgRwAyKWNQl8usVpfkdKVU7O
	 DkYB8thpioPd1pEO680G0Z6VFMF69bBTV8li/iLu5W4y5DSkaNp6uqH+tXd7Qeny3yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iusaTTqz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45584606A33E;
	Mon,  9 Nov 2026 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iusaTTqz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E525D1F008BC;
	Mon,  9 Nov 2026 19:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253784;
	bh=M8CHeRKzRhc8Z/RcnT9AUUayDTie+d/p213vXc4rCPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iusaTTqz1Na7CJKZFJquB0SwxpTtCdzBF9H99sfdDdiFhc0OZtg0g8BhetnSGwlex
	 6blLbl9sREAQmjav8D/D+ARm9OckdY3U+8r2XvmzUVpzVXqs2s9gsJdBHCeFQ4bjyA
	 EwDx3+TbjN9aeXd7LXLuMJvVZNjO851NRt+mGDjfASLU/1yqAQA8CDEAPbocxprMTN
	 AUB6ASJ8R175Wy7OCXduDxcAsDcBm9Mv395Mw0lVIEWl+R9er6FFzescE+EoPyCbvs
	 D1nqcVVdMcbMVuN2+ivOZQsmK5A2Gq2ERJl9OyUDeaX0SxjOte5XThlpmVayK9KNgy
	 vXL+aYY98vHBA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alan Maguire <almagui@kernel.org>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 02/13] jump_label: Index text reservation lookups
Date: Mon,  9 Nov 2026 20:49:05 +0100
Message-ID: <20261109194916.1089703-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194916.1089703-1-jolsa@kernel.org>
References: <20261109194916.1089703-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Text reservation checks scan every jump entry. Build an index sorted by
code address for core entries and use binary search to find the starting
point near the requested range. Keep the original table sorted by
static-key address for updates.

Module reservation checks continue to use a linear scan, avoiding
per-module index allocation and teardown complexity.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/jump_label.c | 115 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index ab6b774bcfd7..64467b971efe 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -8,6 +8,7 @@
  */
 #include <linux/memory.h>
 #include <linux/uaccess.h>
+#include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/slab.h>
@@ -22,6 +23,18 @@
 /* mutex to protect coming/going of the jump_label table */
 static DEFINE_MUTEX(jump_label_mutex);
 
+struct jump_entry_index {
+	struct jump_entry *base;
+	unsigned int nr;
+	u32 entries[];
+};
+
+/*
+ * Index jump entries by code address for text reservation lookups. The jump
+ * table itself is sorted by static-key address, then by code address per key.
+ */
+static struct jump_entry_index *jump_entry_index;
+
 void jump_label_lock(void)
 {
 	mutex_lock(&jump_label_mutex);
@@ -381,6 +394,81 @@ static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 	return 0;
 }
 
+static int jump_entry_index_cmp(const void *a, const void *b, const void *priv)
+{
+	const struct jump_entry *base = priv;
+	unsigned int ia = *(u32 *)a;
+	unsigned int ib = *(u32 *)b;
+	unsigned long ca = jump_entry_code(base + ia);
+	unsigned long cb = jump_entry_code(base + ib);
+
+	if (ca < cb)
+		return -1;
+	if (ca > cb)
+		return 1;
+	return 0;
+}
+
+static struct jump_entry_index *
+jump_entry_index_alloc(struct jump_entry *start, struct jump_entry *stop)
+{
+	unsigned int i, nr = stop - start;
+	struct jump_entry_index *index;
+
+	if (!nr)
+		return NULL;
+
+	index = kvmalloc_flex(*index, entries, nr, GFP_KERNEL);
+	if (!index)
+		return NULL;
+
+	index->nr = nr;
+	index->base = start;
+	for (i = 0; i < nr; i++)
+		index->entries[i] = i;
+
+	sort_r(index->entries, nr, sizeof(index->entries[0]),
+	       jump_entry_index_cmp, NULL, start);
+	return index;
+}
+
+static int jump_entry_index_text_reserved(struct jump_entry_index *index,
+					  void *start, void *end, bool init)
+{
+	unsigned long start_addr = (unsigned long)start;
+	unsigned long end_addr = (unsigned long)end;
+	unsigned int low = 0, high = index->nr, i;
+
+	/* Find the first entry after @start. */
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+		unsigned long addr = jump_entry_code(index->base + index->entries[mid]);
+
+		if (addr <= start_addr)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+
+	/* The preceding entry may start before @start and overlap it. */
+	if (low)
+		low--;
+
+	for (i = low; i < index->nr; i++) {
+		struct jump_entry *entry = index->base + index->entries[i];
+		unsigned long addr = jump_entry_code(entry);
+
+		/* Later entries cannot overlap once this address is past @end. */
+		if (addr > end_addr)
+			break;
+		if ((init || !jump_entry_is_init(entry)) &&
+		    addr_conflict(entry, start, end))
+			return 1;
+	}
+
+	return 0;
+}
+
 static int __jump_label_text_reserved(struct jump_entry *iter_start,
 		struct jump_entry *iter_stop, void *start, void *end, bool init)
 {
@@ -869,8 +957,16 @@ early_initcall(jump_label_init_module);
  */
 int jump_label_text_reserved(void *start, void *end)
 {
+	struct jump_entry_index *index;
 	bool init = system_state < SYSTEM_RUNNING;
-	int ret = __jump_label_text_reserved(__start___jump_table,
+	int ret;
+
+	/* Pairs with the release in jump_entry_index_build(). */
+	index = smp_load_acquire(&jump_entry_index);
+	if (index)
+		ret = jump_entry_index_text_reserved(index, start, end, init);
+	else
+		ret = __jump_label_text_reserved(__start___jump_table,
 			__stop___jump_table, start, end, init);
 
 	if (ret)
@@ -909,6 +1005,23 @@ static void jump_label_update(struct static_key *key)
 		__jump_label_update(key, entry, stop, init);
 }
 
+static int __init jump_entry_index_build(void)
+{
+	struct jump_entry_index *index;
+
+	/*
+	 * Build the index in an initcall so normal memory allocation is
+	 * available; jump_label_init() runs before that.
+	 */
+	index = jump_entry_index_alloc(__start___jump_table, __stop___jump_table);
+
+	/* Publish the initialized index to jump_label_text_reserved(). */
+	smp_store_release(&jump_entry_index, index);
+
+	return 0;
+}
+late_initcall(jump_entry_index_build);
+
 #ifdef CONFIG_STATIC_KEYS_SELFTEST
 static DEFINE_STATIC_KEY_TRUE(sk_true);
 static DEFINE_STATIC_KEY_FALSE(sk_false);
-- 
2.43.0

