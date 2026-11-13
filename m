Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608048;
	b=u0xnXjPr2KPce3mO7/9W4XYjoeLVVBn1CFvBn4vxHXO8KVIPpvMqg/Vowb2nhmo/4yYV
	 fKbvz+8eoWDFcp3puMKOoRfwkJD8iWuWx2Bauq7a5iiUilGUmIDmTNvdaQXp0cOO7m6Gj
	 u+rsEc96E3/B3cIko/YNgXHWncQpJFTJnnhCfWyQs8wPV1/R2t8yDsyOb7ZcUsJqFu1/S
	 f4PbaEtuSVj6AXw7f6CU9M7zlIOWCSLND99fnjo20g35dKRYD+ge40DHJbNtMFpNxwSdK
	 LgTSNF04F/1y52sFLWODB2KDJSdvUgxqcQZkGW4dEwCMNNMT/5q/Rt/AAK5Ktb8OiZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=xRGclsVYgihn8KXrg7MdwsYc+zBVAwEON65aAassTFM=;
	b=BAwgHPMKqpQ3WFCAlzEfXIsBGV2tkiFnqAMhlqceQwUfFnR5i5loLkfcGSPGd5N6o1zF
	 XBCBlU5Y7A6Z6QG4hERktduA61BvtsqvIs6AzjkvRfG8mbF++lVY5lRjRjTVwvtb/Pj9h
	 DO7WHWbLiL/tzULhlg2BtZHoCLdcn19VrcQ3wBFqNKsuPtEBiGukRCT3sm2SPypAXbdor
	 ONliowvz2bxMklyaFhPhy9+Cc2Wolmu3PMrHEd8F7GaI2bkx8gtGEhg+a0NtQ595RRZcp
	 A3NYcIQPpi/nzlbCV6IWcNFF+6LCPPIhAmrWFc33ZWFj9oad3XocazDWR02dw+MbE5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gp5vQMux;
	arc=none smtp.remote-ip=209.85.160.71
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757E606A330
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6757E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gp5vQMux
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-469debb526fso1510213fac.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 14:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608046; x=1795212846; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xRGclsVYgihn8KXrg7MdwsYc+zBVAwEON65aAassTFM=;
        b=gp5vQMux2ymaiEi6tOh1fDOWEJUHLLWas0pVdwpyWkI3ugCjixVnBW7K3Dj5N2smUk
         GHjoawG0WKaKqO4sSfsvHKCal3PN/B53sn2McNHh89YQOIo9c7/9TKX+u7RdsA+0qkig
         DOpj35xWtFQnN7xCdUqmaSTYJx8wUdBisznQodXYjxsDEB4U6JEfSgt7yBlrJeuRRFW6
         1oE8NzfGd7gGS9D7WLOr3kkjtM1xe1ARmQUrdMT0K4365LghPSC0X1hONAj0qXZjwcqy
         gj8Pk6KqazJAyUztxqEGZiUHtYNFFsR8GKcgf9ebC8SHoGuEcL63JfOyjx2v0uBVN64w
         CETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608046; x=1795212846;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xRGclsVYgihn8KXrg7MdwsYc+zBVAwEON65aAassTFM=;
        b=HYG1kiYmV/XzQcg3+GPs48w+4/0w0lG+D5flLpY8eDVvkB8zvI4nee0tn/HMjIL6fn
         dhvFE7m7PHwaDSdwsrOQPYPHnTzYRFRnjHnuCY7Qc7p8JBH6/0UINMCjk59S3FfEASxy
         Svxg6hJhboxhuGY286jOp+UOo/WUB137offeU4XWh/5w29dEZPDZdgiNkS8yvgNNEyJJ
         OHLJT07RzQxJ3wVTJ4k1ADPTkGkzVPK2TMeTmmnD3r3+TqgBQvSnner1alNwMA/4jqlk
         z1AKrtfcXzCGfqBe3slQsOwilK1ARmE8h81dMCMzsnZQkNjRhtbn3Apii2SgbHX3XDOZ
         5eSA==
X-Forwarded-Encrypted: i=1; AL+hErHYTssDyTXTk1a/835FuDymjFRcpDkpuo9DfGycrtqrX53OOr9bR0ZwCrUg49QvlLouodU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FD5R5+kAbjjeEiPDLYX5sFkx0kHx+zoUD/px2G8GXHuwGeZjZ
	jT2Kh5pceXGx53xRGqCb8sBElovch9j5wxUKqe1cH+R7WoYNosa5rUDTuqilP8RI0a+NS4yb2Pt
	9oDRx2yybSZNihw==
X-Received: from oaoo3-n2.prod.google.com ([2002:a05:6870:c443:20b0:4ae:45bb:afee])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:c0a:b0:494:7af4:954a with SMTP id 586e51a60fabf-4afdf1706bdmr3442581fac.8.1794608045968;
 Fri, 13 Nov 2026 14:14:05 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:47 -0800
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261113221248.3535369-13-wusamuel@google.com>
Subject: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

KALLSYMS_QUERY_BY_NAME, added later in this series, needs to find a
symbol name or prefix across module symbols in one pass.
module_get_kallsym() walks the module list from the head and runs an
export bsearch() for every symbol index.

Add module_kallsyms_find_name(), and put the shared query struct in
linux/kallsyms.h, so we have a more efficient linear walk.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 include/linux/kallsyms.h |  7 +++++
 include/linux/module.h   | 13 +++++++++
 kernel/module/kallsyms.c | 57 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index d5dd54c53ace..d31f2f436159 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -24,6 +24,13 @@
 struct cred;
 struct module;
 
+/* Exact or prefix name query, optionally in one module. */
+struct kallsyms_name_query {
+	const char *name;
+	size_t cmp_len;		/* bytes to compare; includes NUL if exact */
+	const char *modname;	/* NULL matches any module */
+};
+
 static inline int is_kernel_text(unsigned long addr)
 {
 	if (__is_kernel_text(addr))
diff --git a/include/linux/module.h b/include/linux/module.h
index 76f4f3596477..07d5a74ecfcc 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -42,6 +42,7 @@ struct modversion_info {
 
 struct module;
 struct exception_table_entry;
+struct kallsyms_name_query;
 
 struct module_kobject {
 	struct kobject kobj;
@@ -978,6 +979,10 @@ int lookup_module_symbol_attrs(unsigned long addr,
  */
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		       char *name, char *module_name, int *exported);
+int module_kallsyms_find_name(unsigned int *symnum,
+			      const struct kallsyms_name_query *q,
+			      unsigned long *value, char *name,
+			      char *module_name);
 
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
@@ -1016,6 +1021,14 @@ static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
 	return -ERANGE;
 }
 
+static inline int module_kallsyms_find_name(unsigned int *symnum,
+					    const struct kallsyms_name_query *q,
+					    unsigned long *value, char *name,
+					    char *module_name)
+{
+	return -ENOENT;
+}
+
 static inline unsigned long module_kallsyms_lookup_name(const char *name)
 {
 	return 0;
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 1ff8ce857d92..72006c9bad42 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -406,6 +406,63 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 	return -ERANGE;
 }
 
+/**
+ * module_kallsyms_find_name - Find a module symbol by name or prefix
+ * @symnum: in: index to start at; out: index of the match. The index
+ *          counts the symbols of the searched modules in list order.
+ * @q: name query; if @q->modname is set, only that module is searched
+ * @value: set to the symbol address
+ * @name: set to the symbol name (KSYM_NAME_LEN bytes)
+ * @module_name: set to the module name (MODULE_NAME_LEN bytes)
+ *
+ * Undefined (SHN_UNDEF) symbols are skipped.
+ *
+ * Return: 0 on a match, or -ENOENT.
+ */
+int module_kallsyms_find_name(unsigned int *symnum,
+			      const struct kallsyms_name_query *q,
+			      unsigned long *value, char *name,
+			      char *module_name)
+{
+	unsigned int start = *symnum;
+	unsigned int sym_base = 0;
+	struct module *mod;
+
+	guard(rcu)();
+	list_for_each_entry_rcu(mod, &modules, list) {
+		struct mod_kallsyms *kallsyms;
+		unsigned int i = 0;
+
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		if (q->modname && strcmp(q->modname, mod->name))
+			continue;
+
+		kallsyms = rcu_dereference(mod->kallsyms);
+		if (start > sym_base)
+			i = start - sym_base;
+		for (; i < kallsyms->num_symtab; i++) {
+			const Elf_Sym *sym = &kallsyms->symtab[i];
+			const char *symname = kallsyms_symbol_name(kallsyms, i);
+
+			if (sym->st_shndx == SHN_UNDEF)
+				continue;
+			if (strncmp(symname, q->name, q->cmp_len))
+				continue;
+
+			*value = kallsyms_symbol_value(sym);
+			strscpy(name, symname, KSYM_NAME_LEN);
+			strscpy(module_name, mod->name, MODULE_NAME_LEN);
+			*symnum = sym_base + i;
+			return 0;
+		}
+		if (q->modname)
+			break;
+		sym_base += kallsyms->num_symtab;
+	}
+	return -ENOENT;
+}
+
 /* Given a module and name of symbol, find and return the symbol's value */
 static unsigned long __find_kallsyms_symbol_value(struct module *mod, const char *name)
 {
-- 
2.56.0.679.gc527c65306-goog

