Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253774;
	b=EGsK6CQk1ga4UlvkRMgcj+2zKd6XFIZ2N9vbgzVGpskT3+f/uRSEQWMYBfbD4XXgKJWJ
	 vJ8CtJkRPr5bvq6wX4KgCvKPJHVJDE8y3gw5dcAygTtlUpk9xfYOo0PkMZDqMbAEGu8EV
	 tfxTwcFvCMynZP+fjqbnAMRW3LssXV6pWgi4bUzfXqMdv0Qrnb+cdVKhuoOS3RCiqiMOQ
	 RCI4BagR9pm26xlKaDhsvFp6b02h+dcxyURO9GqEbXJhe5pTuuIgVudUw7sslnkZqLLjY
	 Bo7mngSD2Q0K+FAYyXZdDXaCWzEImEva/UrP7p+prpgu+pQGneTJOodZTiH7QSdZxGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253774;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UatCj+DwgBywpSp3E9BN8ilewOuAQkyoMBcI+t7HhdU=;
	b=aNtYwmoagKRPepUnjFBIIFIL/0y4bbgaknEMdYnap4eZnqoK4QVIJE4Tt/BwlKHF5MCd
	 gpt6r93D8MvQx5eSvzgCIUcsTEkrOGLOWZJ19LHpaftMkiLF28KhlIUkJfu5ShgIqJahc
	 sYKpRBV0h32RZW8d2a/lXAmL9G4ESnGidpHgONXyhYePIUOhwqtI3MTFVIPrq3wyDPu8u
	 V31ihs6cFtebOb1RC7uuO/svqaO7CSIJmbxlcodP5rcNeNW7CHdV/BGWbPQlm2i7F/grt
	 56a9d0LpuTnIO485R3ffZ9x840R1pZjfKIg+LFritbfGwiBmTdy8cePqw+UiblrzPfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0VyzQd6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5E60A262E;
	Mon,  9 Nov 2026 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0VyzQd6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12EC1F008BD;
	Mon,  9 Nov 2026 19:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253773;
	bh=UatCj+DwgBywpSp3E9BN8ilewOuAQkyoMBcI+t7HhdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S0VyzQd64co/Lt4/zPfz7Do1LAaZ7QmjMHFzRtexQwmFX9cSzqzaWjrLypR0MU3kz
	 aCpBz6+8YGAneKmDIPloRpbMj6DEQEHCneEHdXVW3/AO9Fg3my66dbrVvALszTsK/R
	 shPDPYsbocfI1/Tk04sYY5ZlX6rhhZdFcGTaABZvY+JnyUgT1XYif64I2xjmn4fl3v
	 CSs92GeF3aZrwLj8U2Yc00xhH9B7fzG4jBBhhieKOdZ7hiy7tY40ShM9OaP1mOJKTx
	 Us9KddQUIXMEAH9CZAqRMaAlfQ95wScnH7h5JyOluHs08VG3EwwFjQChFRKIM9AQCO
	 TLZjoZZpt1xLw==
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
Subject: [PATCH 01/13] static_call: Index code text reservation lookups
Date: Mon,  9 Nov 2026 20:49:04 +0100
Message-ID: <20261109194916.1089703-2-jolsa@kernel.org>
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

Text reservation checks scan every static call site. Build an address-sorted
index for core text sites and use binary search to find the starting point
near the requested range.

Module indexing is intentionally unsupported. Module reservation checks
continue to use a linear scan, avoiding per-module index allocation and
teardown complexity.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/static_call_inline.c | 114 +++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 2 deletions(-)

diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 2b6a0d99cdbe..884dfc897a1f 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -15,6 +15,18 @@ extern struct static_call_site __start_static_call_sites[],
 extern struct static_call_tramp_key __start_static_call_tramp_key[],
 				    __stop_static_call_tramp_key[];
 
+struct static_call_site_index {
+	struct static_call_site *base;
+	unsigned int nr;
+	u32 entries[];
+};
+
+/*
+ * Index static call sites by code address for text reservation lookups.
+ * The site table itself is sorted by static-call-key address.
+ */
+static struct static_call_site_index *static_call_site_index;
+
 int static_call_initialized;
 
 /*
@@ -41,7 +53,7 @@ static void static_call_unlock(void)
 	mutex_unlock(&static_call_mutex);
 }
 
-static inline void *static_call_addr(struct static_call_site *site)
+static inline void *static_call_addr(const struct static_call_site *site)
 {
 	return (void *)((long)site->addr + (long)&site->addr);
 }
@@ -301,6 +313,79 @@ static int addr_conflict(struct static_call_site *site, void *start, void *end)
 	return 0;
 }
 
+static int static_call_site_index_cmp(const void *a, const void *b, const void *priv)
+{
+	const struct static_call_site *base = priv;
+	unsigned int ia = *(u32 *)a;
+	unsigned int ib = *(u32 *)b;
+	unsigned long ca = (unsigned long)static_call_addr(base + ia);
+	unsigned long cb = (unsigned long)static_call_addr(base + ib);
+
+	return cmp_int(ca, cb);
+}
+
+static struct static_call_site_index *
+static_call_site_index_alloc(struct static_call_site *start,
+			     struct static_call_site *stop)
+{
+	struct static_call_site_index *index;
+	unsigned int nr = stop - start;
+	unsigned int i;
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
+	       static_call_site_index_cmp, NULL, start);
+
+	return index;
+}
+
+static int
+static_call_site_index_text_reserved(struct static_call_site_index *index,
+				     void *start, void *end, bool init)
+{
+	unsigned int low = 0, high = index->nr, i;
+
+	/* Find the first site after @start. */
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+		void *addr = static_call_addr(index->base + index->entries[mid]);
+
+		if (addr <= start)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+
+	/* The preceding site may overlap @start. */
+	if (low)
+		low--;
+
+	for (i = low; i < index->nr; i++) {
+		struct static_call_site *site = index->base + index->entries[i];
+		void *addr = static_call_addr(site);
+
+		/* Later sites cannot overlap once this address is past @end. */
+		if (addr > end)
+			break;
+		if ((init || !static_call_is_init(site)) &&
+		    addr_conflict(site, start, end))
+			return 1;
+	}
+
+	return 0;
+}
+
 static int __static_call_text_reserved(struct static_call_site *iter_start,
 				       struct static_call_site *iter_stop,
 				       void *start, void *end, bool init)
@@ -483,7 +568,15 @@ static inline int __static_call_mod_text_reserved(void *start, void *end)
 int static_call_text_reserved(void *start, void *end)
 {
 	bool init = system_state < SYSTEM_RUNNING;
-	int ret = __static_call_text_reserved(__start_static_call_sites,
+	struct static_call_site_index *index;
+	int ret;
+
+	/* Pairs with the release in static_call_site_index_build(). */
+	index = smp_load_acquire(&static_call_site_index);
+	if (index)
+		ret = static_call_site_index_text_reserved(index, start, end, init);
+	else
+		ret = __static_call_text_reserved(__start_static_call_sites,
 			__stop_static_call_sites, start, end, init);
 
 	if (ret)
@@ -522,6 +615,23 @@ int __init static_call_init(void)
 }
 early_initcall(static_call_init);
 
+static int __init static_call_site_index_build(void)
+{
+	struct static_call_site_index *index;
+
+	/*
+	 * Build the index in an initcall so normal memory allocation is
+	 * available, static_call_init() can run before that.
+	 */
+	index = static_call_site_index_alloc(__start_static_call_sites,
+					     __stop_static_call_sites);
+
+	/* Publish the initialized index to static_call_text_reserved(). */
+	smp_store_release(&static_call_site_index, index);
+	return 0;
+}
+late_initcall(static_call_site_index_build);
+
 #ifdef CONFIG_STATIC_CALL_SELFTEST
 
 static int func_a(int x)
-- 
2.43.0

