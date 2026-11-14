Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633502;
	b=eC04HENudAaIDihBv6/iP6Z6xBnLunjWx70iRbEjylgcw2Rk5G8P/1l3aqhGot40MVTt
	 J6f4hKff/iGht7bCImb6/jHvJBjBfIaR+zIkVuEHnt8nA7tuFr3wYbzC0ILu6KDdUwb3T
	 cmnaUVy1XA7oKHfrV4gS3TvCmi3uTffUc91C0MCum9z0xKR73QtqJMHuYUILSTm27VMPj
	 CzyzXpv8BlMp8F0tjdTqobjvJBnLO8A0O6uKXC5RTyLTQnDje0k+S3j3uEewLXIHZ/vDu
	 hwSziHkLGNMBJQu58q5ehWbpND9ut4KxKHxQs/tkvCS5WB0eqeDdJXYf/igi05cvkzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WT08lLpfSwIiUMUiHrHlswMwKAuWnR9hn1AMGTiNoMY=;
	b=FbeqrKCSJIt+F7DGfntVkXAdQSk4tGmHK5OeLKASxYO9Xq1RODio3iTovV/inQ6taBd1
	 wcQ6qIUA9TutvH50A+gVVAld78Ly8kftj08ifv5VYyA4i+3C8aF7/dOzkT9KtPwp3vOQH
	 uZASmdv3m7EHrl/LzArQbUH3H79Q5eb20fR0tm9wEPo6oGCtL1N8wgqLK7JQLLjT/6PWY
	 hvVfdo8Cf4K6f02ARl/RyQZybhL6IwgS4u0jBEpMoS6BA8WmO/Tc6XquZqV1nRYShtUOe
	 lPTJhvZqOqkqWufz3kE+vC2PmTsCDGpC3VpDWRyYkpjYcvREQtFFa+2gAu9ARYaydew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=satZnDwM;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F518606A327
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F518606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=satZnDwM
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso1475566a12.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633502; x=1795238302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WT08lLpfSwIiUMUiHrHlswMwKAuWnR9hn1AMGTiNoMY=;
        b=satZnDwMpQ3cpw/UahahJCdpCotHZv4pxysq0c/5Fpc3rX9hvvdLQeq4dt9ekqabmV
         /RHsbJrGQZzUzEhKs8vyPWAt8ZITblCFcG79/uIwU8aqsYgEdti+2bA/feyHTG0czDDy
         xUpg+b8NQIlgdoMCX1ub8lbTLmXb7A7IS50LixveVpJ5Dp3689lEH7cGcSyExB1Bk5Pb
         tvqE85GRrWMOkEooDhjJg0O04e0TRYr0s/uTlYi9f+nBtRtEoZpoxLjFq7cihnOegGb0
         RdoXXq6zzQ53QpzfHR7HH+4Z8E/ggjC8ypW+AfCY47kdQ2qsXvnDnys/9FSs15sZGwjD
         vboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633502; x=1795238302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WT08lLpfSwIiUMUiHrHlswMwKAuWnR9hn1AMGTiNoMY=;
        b=z4E59v8wBkhqk3uWRrI32VQed9MklfL2aCV+Nrr2+xMUYyiX2lQXls6B4Q1b4kltuZ
         uiSxLlvy9oBsM/oImYjbGhDssWBLx7iNvs0YkLa/XCKlrgavFlKRhi+oxtDMAcp/gOn7
         2Usj8nxCDnDA+G/cjUYUJnjHis7esmJbW2MjQql+2KqJObmDMOyJQr2bPzb2YctT/ULO
         3HhzMJU55ZVRihRh54Yhzc+6cIfqWO6BCEUq57WYj9PdpfvFmysROgLyyvxeaVbBcM4q
         J6bdzYFPm7BMcGgAAsY+IwUF9DdvtMdMXvwFLbCieoygl48k4BuaiLf5fR12NPbvffkn
         /CDw==
X-Gm-Message-State: APuU4Z+pBVbpUyCo2qp6elKXEvq2e3T7oE9gFbp1bvyDk3BJ6nREULQG
	zJjAxTzZaPaQ2t7g0/9oIwn5FaEvsp1fHH22PjcCbXyQV6UBF2/2xeOyov3wkg==
X-Gm-Gg: AYBFou2DkjRv3eSitvukgQqETBO90igarNSNHGLcBo+TNFrj16Ju1xMbVz+L5PoBk0k
	Hm0Aqd5AS0i9C4C9b4j6fMl+Q8CDqHyvfVzjYOr6VHVWAw2iwRyEhxQRDoxwjcQ7+P5KlIOGr6D
	Kl1XwJ4RQSlmpdbsQWTfghWwoDU1+0fgL6plKvK1LGT6sWQoRshxIAobTGpoPJU4Dx/aRMZ2icY
	QtBBN2VQBxDZotZpWa1dka1tCfeUTf2ZsAd18Jk8CtH/uWu6JeZ0urfAT6VZb88CSiA1WyIrfcO
	+N7hbW8q/CZhgoiPwGsykpCXoHTPr7cZBVfC+cpCiqWbS+Xlkn0FpXpz0wetxWpLEQOrg741eKm
	Cia7RrmJRy/NmXGm9FwSn6wpzjg4vNqeHskxMMnkU5rtyG9VONe2qTlDwHD5WDCN38aKtL/Pl4O
	TxTc+g4URb/BB4F5KZ4VYH/NqX56AVulQnw+Ws3OyLb+N5P/4nXh6QFzBJDVxiKmlo2QgOIoSIS
	MRueMZ2PkglwNgF7zdQrGMqDIzntfiV1Jv3uGMoG6fXWVhX4M3BFRAdhTyE+bA4bZTiVWVbo2Za
	xUE3t+iOuJTHG0ChQ7LYleLRz1ou8VKl0Q50jFwAM1RvfWuqypXnUXxitsVMctL10bsWoz+8WKI
	5EayRCThmp878qmAjeCmC7OAWSk6JIQMWEWIYo9lh+r2+mxck/ZJawonWKThMbnnlmkdVhGItnQ
	==
X-Received: by 2002:a05:6a20:d48e:b0:3d3:aec2:4dcd with SMTP id adf61e73a8af0-3f7a68a5208mr4462397637.25.1794633501498;
        Fri, 13 Nov 2026 21:18:21 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc186fc72sm2196154a12.5.2026.11.13.21.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:18:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v3 bpf-next 02/11] resolve_btfids: Read the code of an ELF file by address
Date: Sat, 14 Nov 2026 05:17:56 +0000
Message-ID: <20261114051805.683966-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
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

From: Anton Protopopov <a.s.protopopov@gmail.com>

resolve_btfids is the tool that sees vmlinux and each module after the
link, with BTF at hand. A later patch lets it read the machine code of the
functions, to find the errors that they return. The two kinds of files
differ:

	                  vmlinux            module
	ELF file          linked image       relocatable (ET_REL)
	address           virtual address    each section starts at 0
	field of a jump   final value        0, a relocation has the target

A field is the bytes of an instruction that hold the target. In a module
these are fields with a relocation:
 - the jump to __x86_return_thunk, which is the return of the function
 - the jump to the cold subfunction

Add struct image. It gives both kinds of files one address space:

	vmlinux           addr = virtual address
	module            addr = section index << 32 | offset
	undefined symbol  addr = 16 * symbol index (section 0)

	image_bytes(addr)       the bytes at addr, and how many follow
	image_reloc(addr, len)  the target of a field in the len bytes
	image_symbol(name)      the address of a symbol
	image_func(name)        name, section, address and size

The user of struct image works in three steps:

	decode the instruction at addr    -> len
	image_reloc(addr, len)            -> the address of the target
	compare it with image_symbol("__x86_return_thunk")

BTF knows a function only by its name. image_func() returns NULL if two
functions have the name: nobody can tell which of them the FUNC is.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Co-developed-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/resolve_btfids/Build   |   1 +
 tools/bpf/resolve_btfids/image.c | 222 +++++++++++++++++++++++++++++++
 tools/bpf/resolve_btfids/image.h |  62 +++++++++
 3 files changed, 285 insertions(+)
 create mode 100644 tools/bpf/resolve_btfids/image.c
 create mode 100644 tools/bpf/resolve_btfids/image.h

diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
index 602e1508bf09..65af9dee7659 100644
--- a/tools/bpf/resolve_btfids/Build
+++ b/tools/bpf/resolve_btfids/Build
@@ -2,6 +2,7 @@ hostprogs := resolve_btfids
 
 resolve_btfids-y += main.o
 resolve_btfids-y += btf_colors.o
+resolve_btfids-y += image.o
 resolve_btfids-y += rbtree.o
 resolve_btfids-y += zalloc.o
 resolve_btfids-y += string.o
diff --git a/tools/bpf/resolve_btfids/image.c b/tools/bpf/resolve_btfids/image.c
new file mode 100644
index 000000000000..7a97a49e5364
--- /dev/null
+++ b/tools/bpf/resolve_btfids/image.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* The code of an ELF file, by address. See image.h */
+
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "image.h"
+
+static uint64_t image_address(const struct image *img, size_t shndx, uint64_t value)
+{
+	return img->relocatable ? (uint64_t)shndx << 32 | value : value;
+}
+
+static uint64_t symbol_address(const struct image *img, size_t idx, const GElf_Sym *sym)
+{
+	if (sym->st_shndx == SHN_UNDEF)
+		return img->relocatable ? idx << 4 : 0;
+	if (sym->st_shndx >= SHN_LORESERVE)
+		return 0;
+	return image_address(img, sym->st_shndx, sym->st_value);
+}
+
+uint64_t image_symbol(const struct image *img, const char *name)
+{
+	size_t i;
+
+	for (i = 1; i < img->nr_symbols; i++) {
+		const char *s;
+		GElf_Sym sym;
+
+		if (!gelf_getsym(img->symbols, i, &sym) || !sym.st_name)
+			continue;
+		s = elf_strptr(img->elf, img->strndx, sym.st_name);
+		if (s && !strcmp(s, name))
+			return symbol_address(img, i, &sym);
+	}
+	return 0;
+}
+
+static int cmp_func(const void *va, const void *vb)
+{
+	const struct image_func *a = va, *b = vb;
+
+	return strcmp(a->name, b->name);
+}
+
+const struct image_func *image_func(const struct image *img, const char *name)
+{
+	const struct image_func key = { .name = name }, *end = img->funcs + img->nr_funcs, *f;
+
+	f = bsearch(&key, img->funcs, img->nr_funcs, sizeof(*f), cmp_func);
+	if (!f || (f > img->funcs && !strcmp(f[-1].name, name)) ||
+	    (f + 1 < end && !strcmp(f[1].name, name)))
+		return NULL;
+	return f;
+}
+
+const unsigned char *image_bytes(const struct image *img, uint64_t addr, size_t *avail)
+{
+	const struct image_section *s;
+	size_t i;
+
+	for (i = img->relocatable ? addr >> 32 : 1; i < img->nr_sections; i++) {
+		s = &img->sections[i];
+		if (addr - s->addr < s->size) {
+			*avail = s->size - (addr - s->addr);
+			return s->data + (addr - s->addr);
+		}
+	}
+	return NULL;
+}
+
+const struct image_reloc *image_reloc(const struct image *img, uint64_t addr, size_t len)
+{
+	size_t lo = 0, hi = img->nr_relocs;
+
+	while (lo < hi) {
+		size_t mid = lo + (hi - lo) / 2;
+
+		if (img->relocs[mid].addr < addr)
+			lo = mid + 1;
+		else
+			hi = mid;
+	}
+	return lo < img->nr_relocs && img->relocs[lo].addr - addr < len ? &img->relocs[lo] : NULL;
+}
+
+static int cmp_reloc(const void *va, const void *vb)
+{
+	const struct image_reloc *a = va, *b = vb;
+
+	return a->addr > b->addr ? 1 : a->addr < b->addr ? -1 : 0;
+}
+
+static int read_relocs(struct image *img, Elf_Scn *scn, const GElf_Shdr *shdr)
+{
+	size_t nr = shdr->sh_size / shdr->sh_entsize, i;
+	Elf_Data *data = elf_getdata(scn, NULL);
+	struct image_reloc *relocs;
+
+	if (!data)
+		return -EINVAL;
+	relocs = realloc(img->relocs, (img->nr_relocs + nr) * sizeof(*relocs));
+	if (!relocs)
+		return -ENOMEM;
+	img->relocs = relocs;
+	for (i = 0; i < nr; i++) {
+		GElf_Rela rela;
+		GElf_Sym sym;
+		uint64_t s;
+
+		if (!gelf_getrela(data, i, &rela) ||
+		    !gelf_getsym(img->symbols, GELF_R_SYM(rela.r_info), &sym))
+			return -EINVAL;
+		s = symbol_address(img, GELF_R_SYM(rela.r_info), &sym);
+		if (!s)
+			continue;
+		relocs[img->nr_relocs].addr = image_address(img, shdr->sh_info, rela.r_offset);
+		relocs[img->nr_relocs++].target = s + rela.r_addend;
+	}
+	return 0;
+}
+
+static int read_funcs(struct image *img)
+{
+	size_t i;
+
+	img->funcs = calloc(img->nr_symbols, sizeof(*img->funcs));
+	if (!img->funcs)
+		return -ENOMEM;
+	for (i = 1; i < img->nr_symbols; i++) {
+		struct image_func *f = &img->funcs[img->nr_funcs];
+		GElf_Sym sym;
+
+		if (!gelf_getsym(img->symbols, i, &sym))
+			return -EINVAL;
+		if (sym.st_shndx == SHN_UNDEF ? !img->relocatable :
+		    GELF_ST_TYPE(sym.st_info) != STT_FUNC || sym.st_shndx >= img->nr_sections)
+			continue;
+		f->name = elf_strptr(img->elf, img->strndx, sym.st_name);
+		if (!f->name)
+			return -EINVAL;
+		f->section = img->sections[sym.st_shndx].name ?: "";
+		f->addr = symbol_address(img, i, &sym);
+		f->size = sym.st_size;
+		img->nr_funcs++;
+	}
+	qsort(img->funcs, img->nr_funcs, sizeof(*img->funcs), cmp_func);
+	return 0;
+}
+
+int image_open(struct image *img, Elf *elf)
+{
+	size_t i, shstrndx;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+	Elf_Scn *scn;
+	int err;
+
+	memset(img, 0, sizeof(*img));
+	if (!gelf_getehdr(elf, &ehdr) || elf_getshdrnum(elf, &img->nr_sections) ||
+	    elf_getshdrstrndx(elf, &shstrndx))
+		return -EINVAL;
+	img->elf = elf;
+	img->relocatable = ehdr.e_type == ET_REL;
+	img->sections = calloc(img->nr_sections, sizeof(*img->sections));
+	if (!img->sections)
+		return -ENOMEM;
+
+	for (i = 1; i < img->nr_sections; i++) {
+		struct image_section *s = &img->sections[i];
+		Elf_Data *data;
+
+		scn = elf_getscn(elf, i);
+		if (!scn || !gelf_getshdr(scn, &shdr))
+			return -EINVAL;
+		s->name = elf_strptr(elf, shstrndx, shdr.sh_name);
+		if (!s->name)
+			return -EINVAL;
+		if (shdr.sh_type == SHT_SYMTAB) {
+			img->symbols = elf_getdata(scn, NULL);
+			img->nr_symbols = shdr.sh_size / shdr.sh_entsize;
+			img->strndx = shdr.sh_link;
+		}
+		if (!(shdr.sh_flags & SHF_EXECINSTR) || shdr.sh_type != SHT_PROGBITS)
+			continue;
+		data = elf_getdata(scn, NULL);
+		if (!data || data->d_size != shdr.sh_size)
+			return -EINVAL;
+		s->data = data->d_buf;
+		s->addr = image_address(img, i, shdr.sh_addr);
+		s->size = shdr.sh_size;
+	}
+	if (!img->symbols)
+		return -EINVAL;
+	err = read_funcs(img);
+	if (err)
+		return err;
+
+	for (i = 1; img->relocatable && i < img->nr_sections; i++) {
+		scn = elf_getscn(elf, i);
+		if (!gelf_getshdr(scn, &shdr))
+			return -EINVAL;
+		if (shdr.sh_type != SHT_RELA || !img->sections[shdr.sh_info].size)
+			continue;
+		err = read_relocs(img, scn, &shdr);
+		if (err)
+			return err;
+	}
+	if (img->nr_relocs)
+		qsort(img->relocs, img->nr_relocs, sizeof(*img->relocs), cmp_reloc);
+	return 0;
+}
+
+void image_close(struct image *img)
+{
+	free(img->sections);
+	free(img->relocs);
+	free(img->funcs);
+	memset(img, 0, sizeof(*img));
+}
diff --git a/tools/bpf/resolve_btfids/image.h b/tools/bpf/resolve_btfids/image.h
new file mode 100644
index 000000000000..5ae25f6a362b
--- /dev/null
+++ b/tools/bpf/resolve_btfids/image.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __RESOLVE_BTFIDS_IMAGE_H
+#define __RESOLVE_BTFIDS_IMAGE_H
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <gelf.h>
+
+/*
+ * The code of an ELF file, by address.
+ *
+ * In a linked image (vmlinux) an address is the virtual address and all fields
+ * hold their final values. A relocatable file (a module) has neither: there the
+ * address of a byte is the index of its section in the upper 32 bits and its
+ * offset in the lower ones, and what a field refers to is taken from its
+ * relocation. An undefined symbol lives in section 0, at 16 times its index.
+ */
+struct image_section {
+	const char *name;
+	/* Of a section with code */
+	uint64_t addr, size;
+	const unsigned char *data;
+};
+
+struct image_reloc {
+	uint64_t addr;		/* of the field */
+	uint64_t target;	/* symbol + addend */
+};
+
+/* A function of the file, or an undefined symbol of a relocatable file: no section, no size */
+struct image_func {
+	const char *name, *section;
+	uint64_t addr, size;
+};
+
+struct image {
+	Elf *elf;
+	bool relocatable;
+	struct image_section *sections;
+	size_t nr_sections;
+	struct image_reloc *relocs;	/* sorted by address */
+	size_t nr_relocs;
+	struct image_func *funcs;	/* sorted by name */
+	size_t nr_funcs;
+	Elf_Data *symbols;
+	size_t nr_symbols, strndx;
+};
+
+int image_open(struct image *img, Elf *elf);
+void image_close(struct image *img);
+
+/* Return the address of the symbol NAME, or 0 */
+uint64_t image_symbol(const struct image *img, const char *name);
+/* Return the function NAME, or NULL if there is none or more than one */
+const struct image_func *image_func(const struct image *img, const char *name);
+/* Return the bytes at ADDR and set AVAIL to how many follow in the section */
+const unsigned char *image_bytes(const struct image *img, uint64_t addr, size_t *avail);
+/* Return the relocation of a field in the LEN bytes at ADDR, or NULL */
+const struct image_reloc *image_reloc(const struct image *img, uint64_t addr, size_t len);
+
+#endif
-- 
2.55.0

