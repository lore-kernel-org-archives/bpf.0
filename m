Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633539;
	b=Afaf5GbjY7WrDio5NphKQTl0k4o//YyisUVR+WsADOF/N5ygkR0LfEW9RUyDiVUGkLhv
	 C+RMMp/3wo6bIv1sHImOJaSrLm+FfeIi6rWMFDlCt4azu6wz3t5W+4qZimR97uOMQITYs
	 rdGA+nwgNcm+AyYD2h16XFy0S04DCdzO6vP/FMJuiO11E1SjRxnAQeiJ1J9cZThu/DKCt
	 ZN/mRaB7P6aqFIw05Z7QgkPjufDYu5N9NJD7pgS0te3McQOXvUZf8Bp3r1jtovxIbgvHa
	 wlGWHn62S6TzqSzRJoFy9rjA96/BkMwQlM5vMr9ArtUYDzM01unXjZ75OVHzXfJ6UVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bo9gI/MfMewv9Wl7rh1JFEcvYTMfNaIL49zK6YDWMaA=;
	b=5tatcTOXBtxF1pEy7NNfzrKNKSIKSBBX6ZpUc05ZLnmdfyC5jBYSClrfo6rYEV1XHbm/
	 LYXDWFPX0EwFIzT9nQLe2c9LIHZjsYf02UBfT4Kc5pVOSrOs6MdoQtlv34HYkFXPGQvaA
	 XJOynaMb35jjMyXbn9jUpTfSckvWTcEKH5I2AsdJ7oqGhFnKETDew+t4dfc8c1Ux6H1eR
	 1Xh49RI28hVfZ4HwGzkMyFyNcUZ85b1kdsBOWBj3NmfZsI3XNCGziechHOejcrvp3oKl/
	 HfsbDzwhSSjth0KJUgjRYmQXbQVF0YyGFMCzRPtNZAkkFxVlZ4dU4qWxRPjCVDh/FNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiZtmsjB;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658E606A32E
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4658E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiZtmsjB
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so1411739a91.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633539; x=1795238339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bo9gI/MfMewv9Wl7rh1JFEcvYTMfNaIL49zK6YDWMaA=;
        b=BiZtmsjB0qvq35LoFwa2hI59LsJgLsoI4Z0YLZkyFA9xYQ2RSWJAZFZlsFjn0QMzWQ
         yTjeIkvz4scuDOgad2d9P14hNJojfQiSV/3xSDYzhT/uJQg5LJFLUNmFKhpIK53c1hfq
         xuS5KpAOQIZUn1PEwKbmzPLY6bPuX64LTjfYBJF/xI+w42K7fh2fKd5p1xlUNHLBPDUj
         rmM7n+/GvQA9J19BPc6hVri8Mwa3BKtaZOVPmvpb0u7zSo0Mo/xYLRH/kww1oJDOe/VD
         3Zsx6xJj8KByyqONinAWcu4o7BikXTNjWpw6/sfgCTayWoY1R2dYX8Yb4RXDE4uuMb5d
         Jzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633539; x=1795238339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bo9gI/MfMewv9Wl7rh1JFEcvYTMfNaIL49zK6YDWMaA=;
        b=vanJ5ZRYHjgFBXtIh9o7gICoq5OGJPmN/w2Pund04XAqRmWkOh5Xox8oj5gZGuHVAJ
         ayCB8oVQLxN+7g0tLZydGQfK/2xn+1A4vCcs0EG49hEirc3CGQoJvdafYGXFVc1W4M5A
         vSmQX5thPMA2rdVgmXfVQs3HW1iwBg35NNik4z5QPnYrERQx9TYbBNisd58sNWVDvFMl
         AZeSS+LciYuCNgew46oSeGP+iINc0laNZb/uERVE7g4IBOhRyFjqtqwpCdr68CujU3qS
         XgTI1RcFRlbPCTs7R29+0Pm2/qHoV8Xe9RgaPB5pqIRYgdq1NmfsM8tqCfDDT6dHQT4M
         VOIQ==
X-Gm-Message-State: APuU4Z+e+mWdg1wPtVVhRC4rmlpoVW02BlXkE3NSwbkxLTweupdEuMXR
	gdkMYMQJzA0BKcpjpqKiTXzVUtNp87mGox9wXrpRbufapZEPdmtJMrBNKB7zUA==
X-Gm-Gg: AYBFou0nNH4RC0XoCLOrNVTgjsUyRdsMoXs8kfqIGKhSxr7w3UqvrIRPVoEK0NDDMT4
	p4oeCD79oHvkmWQ1OjQkzhFJSek9n5DB2NrAWpwLYpzZdOmmcx/xwDpcqCLl9O5ETBJjdhETQt/
	bYtbzLudxwkzI+/IYPATL9JPYRNDDGqZq58OAh1lAOTdoMEcQKJUkoczlrxSROST/wt6IodKiYJ
	JxjsEkgHhcrMoZOXoq3O3De8RVEeFy2OepuLdQg6w5qEEAxW6iifj9aXgEAbFBEdosXR+sMoiFL
	w0DsRSeloMMiDlAd6JgE3FydvK7mXlozhuD4b1luQlPdB1+KdL0oPcaD47NaSOIn0FxYsPQfgj1
	ueZLIc948x7mwdWT+idbypc7xNxrih7E3yteMMRlILIg+DoF8zS/hn+tzSdVgo1EivT+4SXE63f
	+6v3jKB5PnuGD3qge40THPxNRVVN823bJDP+7Cpx9+hVkfnTC+9j9L5Aw5gBART80wDEFMY9Omb
	GrEzIxMQkNZSY78FAI3kmNZvQtIasbmI35zOKpk8QcXuLlfK+uah3cKnmSYEK9Yod3T2awA5/46
	Zb1fxNIDuhDU2FwfgWbu705UVAwAqvsx+vfnCBtKvpjaDCkVTwqkBoiCUKG0ezP/tDQkmjPccNt
	wVwMdIPs+mDA/d48GCCY6BedYEYIfkXr992lt1wJMuZz2yS/XpcIZ4O13ethAiw5/Au2K31F4rE
	njOz2aUop5kXlH/EXYR5OO
X-Received: by 2002:a17:90b:3d87:b0:3ac:9259:122c with SMTP id 98e67ed59e1d1-3b1b0a3956bmr4498082a91.40.1794633538236;
        Fri, 13 Nov 2026 21:18:58 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f6e0sm12625890a91.9.2026.11.13.21.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:18:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v3 bpf-next 08/11] resolve_btfids: Don't list an error that follows work on an argument
Date: Sat, 14 Nov 2026 05:18:02 +0000
Message-ID: <20261114051805.683966-9-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A program that returns an error skips f(). A skip of f() is not a failure
of f(). ksys_dup3() takes the lock and ends with "return do_dup2(..)":

	static int do_dup2(..) __releases(&files->file_lock)
	..
	Ebusy:
		spin_unlock(&files->file_lock);
		return -EBUSY;

	do_dup2() fails         dup2() = -EBUSY, the lock is free
	do_dup2() is skipped    dup2() = -EBUSY, the lock stays held

A caller can rely on what f() does on each path to "return e". The rule:

	An error is not in the list if, on each path from the entry to its
	return, f() hands a pointer that is based on one of its pointer
	arguments to a callee that returns void.

A callee that returns void cannot fail: what it does to the object is done
when f() returns the error. Most unlock, put, free and init functions
return void. BTF says so, no name is needed. A callee that returns a value
may have failed. "Based on": computed without a load, as &arg->lock is.

BTF gives the parameters, the code has registers. Registers are counted as
in bpf_jit_place_args(): a bpfptr_t takes two. The count stops at
a parameter of more than 16 bytes and at a packed struct.

	forward, may   the registers that hold a based pointer. A call that
	               hands one to a void callee is an effect. Does a path
	               without an effect lead from the entry to here?
	backward, may  the analysis that is there. It stops at an effect

f() stays a target if its list keeps an error. The run takes 0.2 s more.

	                tagged            errors
	x86-64 GCC      12256 -> 11432    19989 -> 18293
	x86-64 clang    13002 -> 12096    22112 -> 20063
	arm64 clang     11837 -> 10954    20325 -> 18237

The tool does not see
 - an unlock that is inlined: it is a store, not a call
 - a callee that takes the object and returns a value, a computed callee
 - a void callee without BTF: f.isra.0, a name that two functions have
 - a pointer that was spilled to the stack, or loaded from the object
 - a pointer on the stack, or behind a parameter where the count stops
It also leaves out
 - an error behind a void callee that locks arg, or only prints about it

Outline KASAN and KCSAN add void callees that get a pointer, such as
__asan_load8(p). Each read of *arg is an effect then: targets are lost.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/resolve_btfids/fmodret.c       | 88 ++++++++++++++++++++++++
 tools/bpf/resolve_btfids/fmodret_scan.c  | 64 +++++++++++++++++
 tools/bpf/resolve_btfids/fmodret_scan.h  |  9 +++
 tools/bpf/resolve_btfids/text_flow.c     | 69 +++++++++++++++++++
 tools/bpf/resolve_btfids/text_flow.h     | 27 ++++++++
 tools/bpf/resolve_btfids/text_insn.h     |  6 ++
 tools/bpf/resolve_btfids/text_mc_arm64.c |  3 +
 tools/bpf/resolve_btfids/text_mc_x86.c   |  4 ++
 8 files changed, 270 insertions(+)

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index 8f43e92f32bf..0751519b95d2 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -5,6 +5,10 @@
  * machine code. This file decides which functions it looks at, and which of the
  * errors count.
  *
+ * A program skips the function. That is not a failure of the function if it
+ * works on an object of its caller before it returns the error: it unlocks,
+ * frees or initializes it. Such an error does not count, see set_protos().
+ *
  * A function which no program can attach to gets no tag: ftrace has to find a nop
  * at its entry, see scan_func(), and a BPF trampoline has to take its parameters.
  */
@@ -19,8 +23,11 @@
 #include "fmodret.h"
 #include "fmodret_scan.h"
 #include "image.h"
+#include "text_insn.h"
 
 #define TAG	"bpf_fmodret_retval:"
+/* More than any arch has argument registers */
+#define MAX_PARAMS	16
 
 /* Return the size of the integer which FUNC returns, or 0 */
 static __u32 int_return_size(const struct btf *btf, const struct btf_type *func)
@@ -92,6 +99,86 @@ static bool format_tag(char *tag, const int64_t *values, size_t nr, __u32 size)
 	return n && errors[0] < -1;
 }
 
+/* As btf_func_arg_align(): is TYPE, or a member of it, an integer of 16 bytes? */
+static bool is_align16(const struct btf *btf, __u32 type)
+{
+	const struct btf_type *t = btf__type_by_id(btf, btf__resolve_type(btf, type));
+	unsigned int i;
+
+	for (i = 0; btf_is_composite(t) && i < btf_vlen(t); i++)
+		if (is_align16(btf, btf_members(t)[i].type))
+			return true;
+	return btf_is_array(t) ? is_align16(btf, btf_array(t)->type) :
+				 btf_is_int(t) && t->size > 8;
+}
+
+/*
+ * Count registers like bpf_jit_place_args(): a parameter of up to 16 bytes takes
+ * one or two of the argument registers, or the stack if they are not left. Set
+ * REGS[N] to the first register of parameter N of PROTO, as scan_set_proto() takes
+ * it, or to 0. Return for how many parameters that is known: what a bigger one
+ * takes depends on the arch, and x86-64 has a struct with an unaligned member on
+ * the stack. Nothing is known if the return value is bigger.
+ */
+static unsigned int place_params(const struct btf *btf, const struct btf_type *proto,
+				 const struct text_arch *arch, unsigned int *regs)
+{
+	unsigned int i, reg = 0;
+
+	if (proto->type && btf__resolve_size(btf, proto->type) > 16)
+		return 0;
+	for (i = 0; i < btf_vlen(proto) && i < MAX_PARAMS; i++) {
+		__u32 type = btf_params(proto)[i].type;
+		__s64 size = btf__resolve_size(btf, type);
+		unsigned int nr = (size + 7) / 8;
+
+		/* btf__align_of() is 1 for a packed struct */
+		if (size <= 0 || size > 16 || (size > 1 && btf__align_of(btf, type) == 1))
+			break;
+		if (arch->even_reg_align && is_align16(btf, type))
+			reg += reg & 1;
+		regs[i] = 0;
+		if (reg + nr <= arch->nr_args) {
+			regs[i] = 1U << reg;
+			reg += nr;
+		} else if (!arch->backfill_after_stack) {
+			reg = arch->nr_args;
+		}
+	}
+	return i;
+}
+
+/*
+ * Tell SCAN what BTF says about the functions of IMG. A function which returns
+ * nothing cannot fail: what it does to an object is done when its caller returns
+ * an error. Unlock, put, free and init functions are of this kind. A function
+ * which returns a value may have failed, and that may be the reason for the error.
+ */
+static void set_protos(struct scan *scan, const struct image *img, const struct btf *btf)
+{
+	__u32 id, nr_types = btf__type_cnt(btf);
+
+	for (id = 1; id < nr_types; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		const struct image_func *func = NULL;
+		unsigned int pointers = 0, regs[MAX_PARAMS], nr, i;
+
+		if (btf_is_func(t))
+			func = image_func(img, btf__name_by_offset(btf, t->name_off));
+		if (!func)
+			continue;
+		t = btf__type_by_id(btf, t->type);
+		nr = place_params(btf, t, scan_arch(scan), regs);
+		for (i = 0; i < nr; i++) {
+			int type = btf__resolve_type(btf, btf_params(t)[i].type);
+
+			if (type > 0 && btf_is_ptr(btf__type_by_id(btf, type)))
+				pointers |= regs[i];
+		}
+		scan_set_proto(scan, func, pointers, !t->type);
+	}
+}
+
 int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 {
 	size_t nr_funcs = 0, nr_scanned = 0, nr_undecodable = 0, nr_tags = 0;
@@ -109,6 +196,7 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 	scan = scan_open(&img);
 	if (!scan)
 		goto out;
+	set_protos(scan, &img, btf);
 
 	for (id = base ? btf__type_cnt(base) : 1, err = 0; id < nr_types && err >= 0; id++) {
 		const struct btf_type *t = btf__type_by_id(btf, id);
diff --git a/tools/bpf/resolve_btfids/fmodret_scan.c b/tools/bpf/resolve_btfids/fmodret_scan.c
index 5b5eb8cb414b..3753aa1e50c3 100644
--- a/tools/bpf/resolve_btfids/fmodret_scan.c
+++ b/tools/bpf/resolve_btfids/fmodret_scan.c
@@ -21,10 +21,18 @@
 #define MAX_ERRNO	4095
 #define MAX_SUBFUNCS	3
 
+/* The function at an address, whatever its names are. See scan_set_proto() */
+struct callee {
+	uint64_t addr;
+	u32 pointers;	/* the registers */
+	bool effect;
+};
+
 struct scan {
 	const struct image *img;
 	uint64_t return_thunk;
 	uint64_t entry_hook;
+	struct callee *callees;		/* one for each of img->funcs, sorted by address */
 	/* The function which is being looked at */
 	struct text_flow flow;
 	size_t max_insns;
@@ -32,6 +40,38 @@ struct scan {
 	size_t nr_values, max_values;
 };
 
+static int cmp_callee(const void *va, const void *vb)
+{
+	const struct callee *a = va, *b = vb;
+
+	return a->addr > b->addr ? 1 : a->addr < b->addr ? -1 : 0;
+}
+
+/* Of two names for ADDR always the same one is found */
+static struct callee *callee_at(const struct scan *s, uint64_t addr)
+{
+	const struct callee key = { .addr = addr };
+
+	return bsearch(&key, s->callees, s->img->nr_funcs, sizeof(key), cmp_callee);
+}
+
+const struct text_arch *scan_arch(const struct scan *s)
+{
+	return s->flow.arch;
+}
+
+void scan_set_proto(struct scan *s, const struct image_func *f, unsigned int pointers, bool effect)
+{
+	struct callee *callee = callee_at(s, f->addr);
+	unsigned int i;
+
+	callee->effect = effect;
+	callee->pointers = 0;
+	for (i = 0; i < s->flow.arch->nr_args; i++)
+		if (pointers & BIT(i))
+			callee->pointers |= BIT(s->flow.arch->args[i]);
+}
+
 /* Append the instructions of SIZE bytes at ADDR */
 static int decode(struct scan *s, uint64_t addr, uint64_t size)
 {
@@ -45,15 +85,21 @@ static int decode(struct scan *s, uint64_t addr, uint64_t size)
 		return -EINVAL;
 	for (off = 0; off < size; off += flow->insns[flow->nr_insns++].len) {
 		const struct image_reloc *reloc;
+		const struct callee *callee;
 		struct text_insn *insn;
 
 		if (flow->nr_insns == s->max_insns) {
 			size_t max = s->max_insns ? 2 * s->max_insns : 1024;
 			struct text_facts *facts = realloc(flow->facts, max * sizeof(*facts));
+			struct text_reach *reach;
 
 			if (!facts)
 				return -ENOMEM;
 			flow->facts = facts;
+			reach = realloc(flow->reach, max * sizeof(*reach));
+			if (!reach)
+				return -ENOMEM;
+			flow->reach = reach;
 			insn = realloc(flow->insns, max * sizeof(*insn));
 			if (!insn)
 				return -ENOMEM;
@@ -78,6 +124,11 @@ static int decode(struct scan *s, uint64_t addr, uint64_t size)
 			insn->kind = TEXT_OTHER;
 			insn->nop = true;
 		}
+		if (insn->kind != TEXT_CALL)
+			continue;
+		callee = callee_at(s, insn->imm);
+		if (callee && callee->effect)
+			insn->pointers = callee->pointers;
 	}
 	return 0;
 }
@@ -160,6 +211,8 @@ int scan_func(struct scan *s, const struct image_func *f, const int64_t **values
 		return err;
 	if (!has_entry_nop(flow, f->addr))
 		return 0;
+	s->flow.entry = f->addr;
+	s->flow.args = callee_at(s, f->addr)->pointers;
 	text_flow_fold(&s->flow);
 	text_flow_solve(&s->flow);
 
@@ -172,6 +225,8 @@ int scan_func(struct scan *s, const struct image_func *f, const int64_t **values
 
 		if (insn->kind != TEXT_MOV_IMM && insn->kind != TEXT_SELECT_IMM)
 			continue;
+		if (flow->reach[i].path == TEXT_EFFECT_PATH)
+			continue;
 		out = text_flow_out(flow, i);
 		for (n = 0; n < 2 && !err; n++) {
 			if (out.same & BIT(insn->dst))
@@ -190,6 +245,7 @@ struct scan *scan_open(const struct image *img)
 {
 	struct scan *s = calloc(1, sizeof(*s));
 	GElf_Ehdr ehdr;
+	size_t i;
 
 	if (!s || !gelf_getehdr(img->elf, &ehdr))
 		goto err;
@@ -203,6 +259,12 @@ struct scan *scan_open(const struct image *img)
 		s->return_thunk = image_symbol(img, s->flow.arch->return_thunk);
 	if (s->flow.arch->entry_hook)
 		s->entry_hook = image_symbol(img, s->flow.arch->entry_hook);
+	s->callees = calloc(img->nr_funcs, sizeof(*s->callees));
+	if (!s->callees)
+		goto err;
+	for (i = 0; i < img->nr_funcs; i++)
+		s->callees[i].addr = img->funcs[i].addr;
+	qsort(s->callees, img->nr_funcs, sizeof(*s->callees), cmp_callee);
 	return s;
 err:
 	free(s);
@@ -215,6 +277,8 @@ void scan_close(struct scan *s)
 		return;
 	free(s->flow.insns);
 	free(s->flow.facts);
+	free(s->flow.reach);
+	free(s->callees);
 	free(s->values);
 	free(s);
 }
diff --git a/tools/bpf/resolve_btfids/fmodret_scan.h b/tools/bpf/resolve_btfids/fmodret_scan.h
index ef3b4ed4d189..f390ab7f5956 100644
--- a/tools/bpf/resolve_btfids/fmodret_scan.h
+++ b/tools/bpf/resolve_btfids/fmodret_scan.h
@@ -11,9 +11,18 @@ struct scan;
 /* Return NULL, after a message, if the code of IMG cannot be read */
 struct scan *scan_open(const struct image *img);
 void scan_close(struct scan *scan);
+const struct text_arch *scan_arch(const struct scan *scan);
+/*
+ * FUNC takes pointers in the argument registers POINTERS: bit N is the one with
+ * number N. If EFFECT, a call of it changes the objects which they point to.
+ */
+void scan_set_proto(struct scan *scan, const struct image_func *func, unsigned int pointers,
+		    bool effect);
 /*
  * Find the constants which FUNC returns and whose low 32 bits are an error. Set
  * VALUES to what the return value register holds then, until the next call.
+ * Leave out a constant if each path from the entry to its return has an effect
+ * on an object which FUNC gets a pointer to, see text_flow.h.
  * A function which ftrace cannot patch has none: no program can attach to it.
  * Return how many there are, or -EINVAL if the code cannot be decoded.
  */
diff --git a/tools/bpf/resolve_btfids/text_flow.c b/tools/bpf/resolve_btfids/text_flow.c
index 3fe2c75eb2fc..d7d3f9d1c6c1 100644
--- a/tools/bpf/resolve_btfids/text_flow.c
+++ b/tools/bpf/resolve_btfids/text_flow.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Which values does a function return? See text_flow.h */
 
+#include <string.h>
+
 #include <linux/bits.h>
 #include <linux/compiler.h>
 
@@ -130,6 +132,9 @@ static struct text_facts transfer(const struct text_flow *flow, u32 i)
 		break;
 	}
 	join(&out, flow, next_insn(flow, i));
+	/* An effect: the paths without one end here */
+	if (insn->pointers)
+		out = (struct text_facts){};
 
 	in = out;
 	kill(&in, insn->defs);
@@ -155,6 +160,65 @@ static struct text_facts transfer(const struct text_flow *flow, u32 i)
 	return in;
 }
 
+/* Return the registers which hold a based pointer behind INSN, if BASED do before it */
+static u32 transfer_based(const struct text_flow *flow, const struct text_insn *insn, u32 based)
+{
+	u32 defs = insn->defs;
+
+	/* endbr64, the ud2 or brk of WARN(): LLVM does not say what it writes. It may be nothing */
+	if (defs == TEXT_ALL_REGS)
+		return based;
+	if (insn->kind == TEXT_CALL)
+		return based & ~(defs | flow->arch->caller_saved);
+	if (insn->kind != TEXT_OTHER && insn->kind < TEXT_BRANCH)
+		defs |= BIT(insn->dst);
+	if (insn->kind == TEXT_MOV_IMM || insn->load || !(insn->uses & based))
+		return based & ~defs;
+	/* push %rdi reads a based pointer and writes the stack pointer */
+	return (based | defs) & ~flow->arch->stack_pointer;
+}
+
+/* Join OUT into the facts before instruction I. Return true if they change */
+static bool join_reach(struct text_flow *flow, u32 i, const struct text_reach *out)
+{
+	struct text_reach *in, old;
+
+	if (i == TEXT_NO_INSN)
+		return false;
+	in = &flow->reach[i];
+	old = *in;
+	in->based |= out->based;
+	if (in->path < out->path)
+		in->path = out->path;
+	return memcmp(in, &old, sizeof(old));
+}
+
+/* Sweep from the first instruction to the last one until nothing changes */
+static void solve_forward(struct text_flow *flow)
+{
+	const struct text_reach entry = { flow->args, TEXT_CLEAN_PATH };
+	bool changed;
+	u32 i;
+
+	memset(flow->reach, 0, flow->nr_insns * sizeof(*flow->reach));
+	join_reach(flow, insn_at(flow, flow->entry), &entry);
+	do {
+		changed = false;
+		for (i = 0; i < flow->nr_insns; i++) {
+			const struct text_insn *insn = &flow->insns[i];
+			struct text_reach out = flow->reach[i];
+
+			out.based = transfer_based(flow, insn, out.based);
+			if (insn->pointers)
+				out.path = TEXT_EFFECT_PATH;
+			if (insn->kind == TEXT_BRANCH || insn->kind == TEXT_COND_BRANCH)
+				changed |= join_reach(flow, insn->target, &out);
+			if (insn->kind != TEXT_BRANCH && insn->kind != TEXT_RETURN)
+				changed |= join_reach(flow, next_insn(flow, i), &out);
+		}
+	} while (changed);
+}
+
 /*
  * Sweep from the last instruction to the first one until nothing changes. The
  * sets only grow, and one more sweep is needed only for what goes around a loop.
@@ -172,6 +236,11 @@ void text_flow_solve(struct text_flow *flow)
 		if ((insn->kind == TEXT_BRANCH || insn->kind == TEXT_COND_BRANCH) && insn->imm)
 			insn->target = insn_at(flow, insn->imm);
 	}
+	/* Where do the pointers go? A call which gets none is not an effect. Then the paths */
+	solve_forward(flow);
+	for (i = 0; i < flow->nr_insns; i++)
+		flow->insns[i].pointers &= flow->reach[i].based;
+	solve_forward(flow);
 	do {
 		changed = false;
 		for (i = flow->nr_insns; i--; ) {
diff --git a/tools/bpf/resolve_btfids/text_flow.h b/tools/bpf/resolve_btfids/text_flow.h
index a266419400f9..56cd13c277f3 100644
--- a/tools/bpf/resolve_btfids/text_flow.h
+++ b/tools/bpf/resolve_btfids/text_flow.h
@@ -23,8 +23,34 @@ struct text_facts {
 	u32 sext;	/* the low 32 bits are returned, sign extended */
 };
 
+/*
+ * What has the function done to the objects of its caller when it returns a
+ * value? An effect is a call which hands a pointer that is based on a pointer
+ * argument to a callee which changes the object, see text_insn.pointers. The
+ * sets above stop at an effect: they are about the paths without one. A forward
+ * may data flow analysis finds the effects, and the paths from the entry.
+ */
+enum text_path {
+	TEXT_NO_PATH,		/* None shows in the code, see text_flow.insns */
+	TEXT_EFFECT_PATH,	/* Each path has an effect */
+	TEXT_CLEAN_PATH,
+};
+
+/* The facts before an instruction. The join is the union, and the better path */
+struct text_reach {
+	/*
+	 * The registers which may hold a pointer that is based on a pointer argument:
+	 * it is computed from the argument without a load, so it points into the
+	 * same object. Memory is not tracked: a pointer which is spilled is lost.
+	 */
+	u32 based;
+	u32 path;	/* from the entry to here */
+};
+
 struct text_flow {
 	const struct text_arch *arch;
+	u64 entry;	/* The address of the first instruction which runs ... */
+	u32 args;	/* ... and the registers which hold pointer arguments there */
 	/*
 	 * All instructions of the function in the order of their addresses,
 	 * whether they can be reached or not: the way to a block may be a jump
@@ -34,6 +60,7 @@ struct text_flow {
 	u32 nr_insns;
 	/* The result: the facts before each instruction */
 	struct text_facts *facts;
+	struct text_reach *reach;
 };
 
 /*
diff --git a/tools/bpf/resolve_btfids/text_insn.h b/tools/bpf/resolve_btfids/text_insn.h
index 5c3ba3a54856..e498245a5b73 100644
--- a/tools/bpf/resolve_btfids/text_insn.h
+++ b/tools/bpf/resolve_btfids/text_insn.h
@@ -56,11 +56,17 @@ struct text_insn {
 	/* For the user of the decoder */
 	u64 addr;
 	u32 target;	/* the index of the instruction at imm */
+	/* Of a TEXT_CALL: the registers with pointers to objects which the callee changes */
+	u32 pointers;
 };
 
 struct text_arch {
 	u8 retval;		/* the register with the return value */
+	u8 args[8], nr_args;	/* the registers with the arguments */
+	/* How the parameters take them, as in struct bpf_jit_arg_abi */
+	bool even_reg_align, backfill_after_stack;
 	u32 caller_saved;	/* the registers which a call may write */
+	u32 stack_pointer;	/* a mask, 0 if it is not one of the registers */
 	/* A branch to this symbol is a return */
 	const char *return_thunk;
 	/*
diff --git a/tools/bpf/resolve_btfids/text_mc_arm64.c b/tools/bpf/resolve_btfids/text_mc_arm64.c
index c2576473773e..5d2fa8a23a14 100644
--- a/tools/bpf/resolve_btfids/text_mc_arm64.c
+++ b/tools/bpf/resolve_btfids/text_mc_arm64.c
@@ -108,6 +108,9 @@ static const struct mc_test arm64_tests[] = {
 const struct mc_arch mc_arch = {
 	.arch = {
 		.retval = 0,
+		.args = { 0, 1, 2, 3, 4, 5, 6, 7 },
+		.nr_args = 8,
+		.even_reg_align = true,
 		/* AAPCS64: x0 to x18 and x30 */
 		.caller_saved = 0x4007ffff,
 	},
diff --git a/tools/bpf/resolve_btfids/text_mc_x86.c b/tools/bpf/resolve_btfids/text_mc_x86.c
index d8d48b0f68fe..4f60a8f3263c 100644
--- a/tools/bpf/resolve_btfids/text_mc_x86.c
+++ b/tools/bpf/resolve_btfids/text_mc_x86.c
@@ -123,8 +123,12 @@ static const struct mc_test x86_tests[] = {
 const struct mc_arch mc_arch = {
 	.arch = {
 		.retval = RAX,
+		.args = { RDI, RSI, RDX, RCX, R8, R9 },
+		.nr_args = 6,
+		.backfill_after_stack = true,
 		.caller_saved = BIT(RAX) | BIT(RCX) | BIT(RDX) | BIT(RSI) | BIT(RDI) |
 				BIT(R8) | BIT(R9) | BIT(R10) | BIT(R11),
+		.stack_pointer = BIT(RSP),
 		.return_thunk = "__x86_return_thunk",
 		.entry_hook = "__fentry__",
 	},
-- 
2.55.0

