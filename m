Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDCF2874FB
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236162; cv=none; b=mkVwA0BnQzdmphInplWIQRH/8Du9ocQ6tdNKXvsttq/Oqe4iCdA4dglKyJRTgL3aT6kLvdIb4ELQdm7gRHQzJTAhuNu76+l/j0Z6uYnqTi5dVBHKqWwcjgwOJP2OAE9VQZo2HBSVdYlAoKVpshqNw7W+GElCsbuMv8hrkHVfqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236162; c=relaxed/simple;
	bh=a36q37vdK1RYvyuKUB9JRESaQp7NDts4N1oTpnAO5+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlWAN6Tbgt3huEP+q6qXtIod0RYG53oj7zsqFd4pkySX0KgzgFKHs2g3TxZeKCHTeQ2Q1zM2G+WuFG2CshJZFNdMXCNQ0xiMK+65qZBT3EpckCUqYPqnXmY6Mm1CfIy0CyU2nJFmKZNniVNXTgyrlLXKMMwzV/TQcRcjnKBFAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4rZ1z74; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4rZ1z74"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso857500a12.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775236160; x=1775840960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO9v98h3OR7cJNFg9205sUd3VSqDXawcgVWe0IPI1MI=;
        b=s4rZ1z74T68hf2o6X7CNXNNRm9qScq1jKY0Ra6Gmra9f0Z2mVYZd+CT8gvxRw6E7ap
         h35PdJ0+mnwT1SVbhFa2yr0XcNPfFtQxxzSJ47Yh7dUhv81eHHRkiZEQdS8WDk0+lxvz
         7syNFasYTmsgUKvzhewoiksixoU27SuRm9bO4xS2KuWL7Ry3frjbtxX/X2q7TSUZIX3R
         4dcw5GUOZhLksaTJTOG/U7h5d8GYhlSM4Fa41mmjvcE/ekHy9JYZyhCNX/yUYMpx1Qgu
         982VOmZxz1fX4imW5isOd5tAll46AM0ZB1NNDvuVQIjoqRhjINa0/SPL6zTJTbNxlF/l
         h0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775236160; x=1775840960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cO9v98h3OR7cJNFg9205sUd3VSqDXawcgVWe0IPI1MI=;
        b=MT8T6Seurd6XSHTElvftutoSz4tHoxQSbRVrVzv6Ovbv6VTW8SRlISlukZR1xTZ6XW
         f/FSORG2eO05tHpvBR5dbWtCXZe5/A46D5b+CAhN6VA/5wfUJ2Fe6mSn6M7wkieyIlx5
         gcyCc6rwXKSAXvQwz3F4fzuAOFR2tiQSTGx2I/GWdqgZDV5YEok9OyXF1E18AusCmPcf
         d12gHL13Y3+LwhVf6zn7gTGEkVcUzlZkzF0OcEIVwwahadnxnUmodfx5pFPjw72DHolC
         hwjO+qmBEQCaTyP3JKlrIbd0dXr+5f2+9RIZwJDNVVmX68qlA86ArE9OM0ktcEoqXayU
         bU6w==
X-Forwarded-Encrypted: i=1; AJvYcCUKT7H3sHEc1jIT4BWa9hHQmM3KA5yJ+bMl76yjRX/Q74ZkVOXLRCl0w0qI/z2MqwJXmro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zEC2CLWWSNf7EBHyW6yXs7WoOKc6KHTBZkGTrNjmK8OPN1Nd
	6/hM6SArFbgTZkYGi+GD5WZxq2FgCq6/TIKMrpt57eDLcWMKbVlQpogY
X-Gm-Gg: ATEYQzz0kUgB3hVLd+WI9s71J2PhMsELres46k0W+iBHCD9BzCCM3aD2Q/EeUL7/Sj8
	Yc+m4PC+cMoCeDLqzHd90psrdwTSja2ZUSq+j9ZfzRRmF1YhC2M25UFNBolHh/r6qzplqprVXw9
	IjL8lePzRt0ZgCJpzMTWbgkWC1FjCCSSk7GfyddVYK/WZT+U0MIjPQt9FhoeY5fFjb8iblN77Wh
	jv63yr/e5CCDlnJVuxmrm8pW2Kvjo5WTkuiQh3Z2lSGpEZY6GUoqZg3KILpQdu2tvgv66ACmsAO
	70Ub9UrYgRKtSzvyE8TpGmkqB5u5vfuyYWk5gcUEqlhB0N8NuPauclNsSEmxdsdKW2LfPHKbl5m
	WFl5gOUCEZsI9zGRaXKyqKdJJUPCj3DsdGH/PIGFq1bQ2apifsN2c2PJblP4G65ffqoFD1o+/Cb
	8UtSF8KX4RRg8xxq2n60Mmo5vyEpn1SYDUJjnhFiiohtRya4yzHQ9qFA==
X-Received: by 2002:a05:6a20:9389:b0:398:9574:a1d7 with SMTP id adf61e73a8af0-39f2eda9efamr3712834637.11.1775236159709;
        Fri, 03 Apr 2026 10:09:19 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3c930sm6588725b3a.17.2026.04.03.10.09.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Apr 2026 10:09:18 -0700 (PDT)
From: Chengkaitao <pilgrimtao@gmail.com>
To: arnd@arndb.de,
	ast@kernel.org,
	ihor.solodrai@linux.dev,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	pengdonglin@xiaomi.com
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH bpf-next 1/3] bpf: Teach resolve_btfids about the setsc type
Date: Sat,  4 Apr 2026 01:08:55 +0800
Message-ID: <20260403170900.58659-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403170900.58659-1-pilgrimtao@gmail.com>
References: <20260403170900.58659-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Add .BTF_ids.##sfx subsections under the .BTF_ids output section. The
number of entries in each .BTF_ids.##sfx subsection is derived from
(__BTF_ids_seg_end_##sfx - sym.st_value). With this, resolve_btfids
no longer relies on BTF_SET_END(). That allows kernel code to avoid
forcing symbols with similar properties to sit strictly between
BTF_SET_START and BTF_SET_END, and it sets the stage for refactoring
the BTF_SET* and BTF_ID* macros later.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 include/asm-generic/btf_ids.lds.h | 23 ++++++++
 include/asm-generic/vmlinux.lds.h |  2 +
 tools/bpf/resolve_btfids/main.c   | 89 +++++++++++++++++++++++++++++--
 3 files changed, 111 insertions(+), 3 deletions(-)
 create mode 100644 include/asm-generic/btf_ids.lds.h

diff --git a/include/asm-generic/btf_ids.lds.h b/include/asm-generic/btf_ids.lds.h
new file mode 100644
index 000000000000..7579ba58f5ff
--- /dev/null
+++ b/include/asm-generic/btf_ids.lds.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 KylinSoft Corporation.
+ * Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+ */
+#ifndef __ASM_GENERIC_BTF_IDS_LDS_H
+#define __ASM_GENERIC_BTF_IDS_LDS_H
+
+/*
+ * Linker script helpers for CONFIG_DEBUG_INFO_BTF .BTF_ids subsections.
+ * Input section .BTF_ids.##sfx must match __BTF_IDS_SUBSEC(sfx) in btf_ids.h.
+ */
+#ifdef CONFIG_DEBUG_INFO_BTF
+
+#define BTF_IDS_SUBSEG(sfx)							\
+		KEEP(*(.BTF_ids.##sfx))						\
+		__BTF_ids_seg_end_##sfx = .;
+
+#define BTF_IDS_VERIFIER_SUBSEGS
+
+#endif /* CONFIG_DEBUG_INFO_BTF */
+
+#endif /* __ASM_GENERIC_BTF_IDS_LDS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1e1580febe4b..96407498629e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -51,6 +51,7 @@
  */
 
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/btf_ids.lds.h>
 
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
@@ -691,6 +692,7 @@
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
 		*(.BTF_ids)						\
+		BTF_IDS_VERIFIER_SUBSEGS				\
 	}
 #else
 #define BTF
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index f8a91fa7584f..d9b0c9c25eda 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -89,6 +89,7 @@
 #define BTF_FUNC	"func"
 #define BTF_SET		"set"
 #define BTF_SET8	"set8"
+#define BTF_SETSC	"setsc"
 
 #define ADDR_CNT	100
 
@@ -104,7 +105,8 @@ enum btf_id_kind {
 	BTF_ID_KIND_NONE,
 	BTF_ID_KIND_SYM,
 	BTF_ID_KIND_SET,
-	BTF_ID_KIND_SET8
+	BTF_ID_KIND_SET8,
+	BTF_ID_KIND_SETSC,
 };
 
 struct btf_id {
@@ -309,6 +311,77 @@ static int get_id(const char *prefix_end, char *buf, size_t buf_sz)
 	return 0;
 }
 
+static int elf_sym_value_by_name(struct object *obj, const char *sym_name,
+				 GElf_Addr *val)
+{
+	Elf_Scn *scn = NULL;
+	GElf_Shdr sh;
+	int n, i;
+
+	scn = elf_getscn(obj->efile.elf, obj->efile.symbols_shndx);
+	if (!scn || gelf_getshdr(scn, &sh) != &sh)
+		return -1;
+
+	n = sh.sh_size / sh.sh_entsize;
+	for (i = 0; i < n; i++) {
+		GElf_Sym sym;
+		char *name;
+
+		if (!gelf_getsym(obj->efile.symbols, i, &sym))
+			return -1;
+		if (sym.st_shndx == SHN_UNDEF)
+			continue;
+		name = elf_strptr(obj->efile.elf, obj->efile.strtabidx,
+				  sym.st_name);
+		if (name && !strcmp(name, sym_name)) {
+			*val = sym.st_value;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+/*
+ * BTF_ID_KIND_SETSC: begin is __BTF_ID__setsc__<name> (sym.st_value); end is
+ * __BTF_ids_seg_end_<name> from the linker script (btf_ids.lds.h).
+ */
+static int scatter_set_cnt_from_seg(struct object *obj, struct btf_id *id,
+				    GElf_Addr begin)
+{
+	GElf_Addr end;
+	char sym_end[KSYM_NAME_LEN];
+	int cnt;
+
+	if (snprintf(sym_end, sizeof(sym_end), "__BTF_ids_seg_end_%s",
+		     id->name) >= (int)sizeof(sym_end)) {
+		pr_err("FAILED scatter set symbol name overflow: %s\n", id->name);
+		return -1;
+	}
+
+	if (elf_sym_value_by_name(obj, sym_end, &end)) {
+		pr_err("FAILED scatter set %s: missing %s in %s\n",
+		       id->name, sym_end, obj->path);
+		return -1;
+	}
+
+	if (end <= begin || (end - begin) % sizeof(int)) {
+		pr_err("FAILED scatter set %s: bad span (begin %#lx .. end %s %#lx)\n",
+		       id->name, (unsigned long)begin, sym_end, (unsigned long)end);
+		return -1;
+	}
+
+	cnt = (int)((unsigned long)(end - begin) / sizeof(int) - 1);
+	if (cnt < 0) {
+		pr_err("FAILED scatter set %s: negative cnt\n", id->name);
+		return -1;
+	}
+	id->cnt = cnt;
+	pr_debug("scatter set %s cnt %d span %lu\n", id->name, cnt,
+		 (unsigned long)(end - begin));
+
+	return 0;
+}
+
 static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind kind)
 {
 	int len = strlen(name);
@@ -327,6 +400,9 @@ static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind k
 	case BTF_ID_KIND_SET8:
 		prefixlen = sizeof(BTF_SET8 "__") - 1;
 		break;
+	case BTF_ID_KIND_SETSC:
+		prefixlen = sizeof(BTF_SETSC "__") - 1;
+		break;
 	default:
 		pr_err("Unexpected kind %d passed to %s() for symbol %s\n", kind, __func__, name);
 		return NULL;
@@ -549,6 +625,11 @@ static int symbols_collect(struct object *obj)
 			 */
 			if (id)
 				id->cnt = sym.st_size / sizeof(uint64_t) - 1;
+		/* setsc */
+		} else if (!strncmp(prefix, BTF_SETSC, sizeof(BTF_SETSC) - 1)) {
+			id = add_set(obj, prefix, BTF_ID_KIND_SETSC);
+			if (id && scatter_set_cnt_from_seg(obj, id, sym.st_value))
+				return -1;
 		/* set */
 		} else if (!strncmp(prefix, BTF_SET, sizeof(BTF_SET) - 1)) {
 			id = add_set(obj, prefix, BTF_ID_KIND_SET);
@@ -690,8 +771,9 @@ static int id_patch(struct object *obj, struct btf_id *id)
 	int *ptr = data->d_buf;
 	int i;
 
-	/* For set, set8, id->id may be 0 */
-	if (!id->id && id->kind != BTF_ID_KIND_SET && id->kind != BTF_ID_KIND_SET8) {
+	/* For set, set8, setsc, id->id may be 0 */
+	if (!id->id && id->kind != BTF_ID_KIND_SET &&
+	    id->kind != BTF_ID_KIND_SET8 && id->kind != BTF_ID_KIND_SETSC) {
 		pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
 		warnings++;
 	}
@@ -766,6 +848,7 @@ static int sets_patch(struct object *obj)
 
 		switch (id->kind) {
 		case BTF_ID_KIND_SET:
+		case BTF_ID_KIND_SETSC:
 			set = data->d_buf + off;
 			cnt = set->cnt;
 			qsort(set->ids, set->cnt, sizeof(set->ids[0]), cmp_id);
-- 
2.43.0

