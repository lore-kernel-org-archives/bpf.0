Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546598;
	b=BhbtuUQtKwS4oYinv7/PeNMPtkaQ1NYT4mwxse4nvUVvb88kt2dCCDm7FnsQIJiCxU2n
	 35wZ8daaeUyTRPxbj484WCI/BOK/rEO+iPjFBFrkVFpF3jYBh5U/ITYm75tzRj5L00O50
	 se9UfThvMNDyJ3SA+Qmvtfa0rZUn0cmDeZDLQ3TsTaQ5DBP9EVoriVWEZQdzyy/QGZHLj
	 oEnk78xqGni5ff+0e4J1Cgimz7NYwlxvhPNpV2ZKYSit6YPNa2+p56X2HD0wiFPFtwqW7
	 aR2xb5KR3l3tvxmQeIddmVvw60cXDcSiZB+TPbp/Hb3NuP+Tr/d+0hD71i6X5cAH8PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I7T+uIKfYk6pVFbY3a+K1Ttx22aFMgRZlkbTPGnwELQ=;
	b=m1bns0IYMRv+RVCf3LZMLOWLPYWLcnWnWnmOyB6t/l4yuDhq2erA7B5RMfb8DSQsnanD
	 42wlGq58D4OTQ3l1C1k1Fh/MLpJnl2sVxA+hQln50YBm/u3oxplsjaJBT12muFY0HWFvQ
	 Py93upIezRNbQdupxL8UrPDU6b/ELon695t56pKA3ohQY5nafFTPFEAM6PrDnkEb1V7lD
	 Q76gBq3ToXe+4qub2Xy3/yAE3VPMd5rbLuy6d0gzHcq9O1IJyknTCCklQ13xRc4hz7i9H
	 SrRdmqgdwpu7k9iXPrQ5iH62fvL09vEgSMZXxSLH71/2NlALfZfIbYcO7CptzDqrkPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjGf2xH+;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E3606A31C
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 823E3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjGf2xH+
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ea7987517aso6441045ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546597; x=1795151397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I7T+uIKfYk6pVFbY3a+K1Ttx22aFMgRZlkbTPGnwELQ=;
        b=fjGf2xH+ViNH/mjzqJFQ43ts8j8w+aFissCSp1WE3cPlo9fAEhQOYFCqPNcCJMx8vM
         LDBnZ8BYU4oVNSXPW7AauDVIqIKrhN4CNFw/3GMOeN0lOitj5PujQ38BP4OXG248yLaC
         91UBZ+grFj0kHjO/tKzQsrc/vzLSviDIA2oE3TW9MLz7TWSM+rVOiZZhQ9QCIkUQGPUS
         qMFm21qyvhG4Si6HVCg13rN6/J3Bs4eYj0c+kJM4Uy5hjCNwT3lK5noaRlHR5PqS2vER
         uhS8qPUx7MxFomZOKr4aqYdgMqa/Y/4epfBVwPLtKeSizi21v1THTwjbm04zZ5Vf2AAP
         lnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546597; x=1795151397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I7T+uIKfYk6pVFbY3a+K1Ttx22aFMgRZlkbTPGnwELQ=;
        b=eCgJY1AsBRfm2iilo6o7wSw/8iv23Sx4Ta60ooNAKj20GMhNNMFbFstDO8UAEZVHAx
         YynJQcjyxuUAsyTM7EL3WSh+gEx5mb3czyqPp3nuzdnj+jyS9b1RitVi/WWuG5sgRb6u
         8eBV8VKWh1U7GqlNQgTTJW0yKid+sjR36LTbhrFoQg3l9gN+Nouo+eXohlztBiCcavkF
         SIFZJxvhtmoAItxKnTWi5khqinfh3HGN/3A3uQr0DBmSHJTy2oIAWZ6ktBGzxSOgg4j5
         tmivPy5sbwcogqmIKIyvjq62xR5EboCzMtALLp2sw4kdJUljoz2bk13hEEJR988T5kgT
         VaFQ==
X-Gm-Message-State: APuU4Z8edvr15SLpndmwPsrpw2wOl2iElUjyGmrL7VIuqeAXD5ip+pb/
	hjhDIRQ/me9OHgB2NDXeWrNAsKlXMkwJZNvO/PPtB3h4Jky8EIjkZuN9g1jx/w==
X-Gm-Gg: AYBFou3Cf6T6yhWrlNe86uLPhSSgvI6fZ74z4NG5R2shZ5a67JVWnzSZbHxcvs78D8Z
	nDutk8T69cvYD7xKDBdbw1srFB6XHbbYBjM1xTNyN7OJlJVIR5to4TntX1xMLYKC/KHezKns7H9
	kj6cOGZdKdA0Z+dO9GTVgnLyPdQUnnn09ZU/1cWTGI/rLS64TFFcSykSVjHJdpPu9XBWT4vs79R
	B5yoylZZ/RQww2WGrWpXP4xzLENAR4cw/dHKfuhszyc7beGg5cTgJGh+KZHKI8NlLiY12fRwqVA
	2Ps4qJNX+tCyhrePVcfDvIEKfi0h0EG0W2tooouz8171mfzTQ4xwFjUGfoE9NW02URDqSTdehSO
	eQOPMrfcNLuA/cPVs5LyOL6KbN61rnI1G0zC7m5NbHFlFo/1iWiTzoqzN3Uo6ADuaGTXjroriVU
	9415LcpnKBG4nDIISz0TvpR/bI2q4JyWm6mt/UwUk6KkvIr8EaPd0rKW14yuceOH1tZedchsy8n
	dxDlG1XbQHmRIvyMiZsuFydc4PJjIfZP8mTqDeeIR/0ixVrmGeQr3DqRV1d15Xdxr3TSWuZilK+
	jzProiU1xU+fSwOESJmg/FAlW7eDK0elOfb5agsSY2wrizm6gS29t8tIFZMXLldxZfQfhM6Nw5x
	D+tNGtglG4WFNNtBn13o7MIEuWe4pDO32vNQEdoO0cA8fqMeNQDn3pbvkGVgd7przX8a78dWGyg
	==
X-Received: by 2002:a17:903:249:b0:2e4:b112:14d with SMTP id d9443c01a7336-2ee0dcc6572mr13358785ad.54.1794546591819;
        Thu, 12 Nov 2026 21:09:51 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f80b7f6sm4477555ad.40.2026.11.12.21.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:09:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v2 bpf-next 08/13] resolve_btfids: Don't list an error that follows work on an argument
Date: Fri, 13 Nov 2026 05:08:56 +0000
Message-ID: <20261113050901.1399091-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
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

	forward, may   the registers that hold a based pointer. A call that
	               hands one to a void callee is an effect. Does a path
	               without an effect lead from the entry to here?
	backward, may  the analysis that is there. It stops at an effect

f() stays a target if its list keeps an error.

	                tagged            errors
	x86-64 GCC      12817 -> 11985    20967 -> 19248
	x86-64 clang    13549 -> 12633    22964 -> 20889
	arm64 clang     12435 -> 11543    21304 -> 19186
The run on vmlinux takes 0.2 s more.

The tool does not see
 - an unlock that is inlined: it is a store, not a call
 - a callee that takes the object and returns a value, a computed callee
 - a void callee without BTF: f.isra.0, a name that two functions have
 - a pointer that was spilled to the stack, or loaded from the object
 - that BUG() and panic() do not return: the next block counts as reached
It also leaves out
 - an error between mutex_lock(&arg->lock) and its unlock: both are void
 - an error after a void callee that only prints a message about arg

Outline KASAN and KCSAN add void callees that get a pointer, such as
__asan_load8(p) and __tsan_read8(p). Each read of *arg is an effect then:
in 32 files of fs, net and mm 76 % of the errors go, not 6.5 %.
Inline KASAN and KCOV: 6.3 % and 6.6 %. Targets are lost, none is added.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/resolve_btfids/fmodret.c       | 35 ++++++++++++
 tools/bpf/resolve_btfids/fmodret_scan.c  | 64 ++++++++++++++++++++++
 tools/bpf/resolve_btfids/fmodret_scan.h  |  8 +++
 tools/bpf/resolve_btfids/text_flow.c     | 69 ++++++++++++++++++++++++
 tools/bpf/resolve_btfids/text_flow.h     | 27 ++++++++++
 tools/bpf/resolve_btfids/text_insn.h     |  6 +++
 tools/bpf/resolve_btfids/text_mc_arm64.c |  2 +
 tools/bpf/resolve_btfids/text_mc_x86.c   |  4 ++
 8 files changed, 215 insertions(+)

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index 2e729cad225b..8dfbbf1f9aa6 100644
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
  * Whether ftrace can attach a program to the function is not looked at: as for
  * fentry, that is found out when it is tried.
  */
@@ -77,6 +81,36 @@ static bool format_tag(char *tag, const int64_t *values, size_t nr, __u32 size)
 	return n && errors[0] < -1;
 }
 
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
+		unsigned int pointers = 0, i;
+
+		if (btf_is_func(t))
+			func = image_func(img, btf__name_by_offset(btf, t->name_off));
+		if (!func)
+			continue;
+		t = btf__type_by_id(btf, t->type);
+		for (i = 0; i < btf_vlen(t) && i < 32; i++) {
+			int type = btf__resolve_type(btf, btf_params(t)[i].type);
+
+			if (type > 0 && btf_is_ptr(btf__type_by_id(btf, type)))
+				pointers |= 1U << i;
+		}
+		scan_set_proto(scan, func, pointers, !t->type);
+	}
+}
+
 int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 {
 	size_t nr_funcs = 0, nr_scanned = 0, nr_undecodable = 0, nr_tags = 0;
@@ -94,6 +128,7 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 	scan = scan_open(&img);
 	if (!scan)
 		goto out;
+	set_protos(scan, &img, btf);
 
 	for (id = base ? btf__type_cnt(base) : 1, err = 0; id < nr_types && err >= 0; id++) {
 		const struct btf_type *t = btf__type_by_id(btf, id);
diff --git a/tools/bpf/resolve_btfids/fmodret_scan.c b/tools/bpf/resolve_btfids/fmodret_scan.c
index 231433f61715..29b405807a4b 100644
--- a/tools/bpf/resolve_btfids/fmodret_scan.c
+++ b/tools/bpf/resolve_btfids/fmodret_scan.c
@@ -21,9 +21,18 @@
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
+	uint64_t entry_hook;
+	struct callee *callees;		/* one for each of img->funcs, sorted by address */
 	/* The function which is being looked at */
 	struct text_flow flow;
 	size_t max_insns;
@@ -31,6 +40,33 @@ struct scan {
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
@@ -44,15 +80,21 @@ static int decode(struct scan *s, uint64_t addr, uint64_t size)
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
@@ -72,6 +114,13 @@ static int decode(struct scan *s, uint64_t addr, uint64_t size)
 			insn->imm += reloc->target - reloc->addr;
 		if (insn->kind == TEXT_BRANCH && insn->imm == s->return_thunk)
 			insn->kind = TEXT_RETURN;
+		if (insn->kind != TEXT_CALL)
+			continue;
+		callee = callee_at(s, insn->imm);
+		if (insn->imm == s->entry_hook)
+			insn->kind = TEXT_OTHER;
+		else if (callee && callee->effect)
+			insn->pointers = callee->pointers;
 	}
 	return 0;
 }
@@ -137,6 +186,8 @@ int scan_func(struct scan *s, const struct image_func *f, const int64_t **values
 
 	if (err)
 		return err;
+	s->flow.entry = f->addr;
+	s->flow.args = callee_at(s, f->addr)->pointers;
 	text_flow_fold(&s->flow);
 	text_flow_solve(&s->flow);
 
@@ -149,6 +200,8 @@ int scan_func(struct scan *s, const struct image_func *f, const int64_t **values
 
 		if (insn->kind != TEXT_MOV_IMM && insn->kind != TEXT_SELECT_IMM)
 			continue;
+		if (flow->reach[i].path == TEXT_EFFECT_PATH)
+			continue;
 		out = text_flow_out(flow, i);
 		for (n = 0; n < 2 && !err; n++) {
 			if (out.same & BIT(insn->dst))
@@ -167,6 +220,7 @@ struct scan *scan_open(const struct image *img)
 {
 	struct scan *s = calloc(1, sizeof(*s));
 	GElf_Ehdr ehdr;
+	size_t i;
 
 	if (!s || !gelf_getehdr(img->elf, &ehdr))
 		goto err;
@@ -178,6 +232,14 @@ struct scan *scan_open(const struct image *img)
 	s->img = img;
 	if (s->flow.arch->return_thunk)
 		s->return_thunk = image_symbol(img, s->flow.arch->return_thunk);
+	if (s->flow.arch->entry_hook)
+		s->entry_hook = image_symbol(img, s->flow.arch->entry_hook);
+	s->callees = calloc(img->nr_funcs, sizeof(*s->callees));
+	if (!s->callees)
+		goto err;
+	for (i = 0; i < img->nr_funcs; i++)
+		s->callees[i].addr = img->funcs[i].addr;
+	qsort(s->callees, img->nr_funcs, sizeof(*s->callees), cmp_callee);
 	return s;
 err:
 	free(s);
@@ -190,6 +252,8 @@ void scan_close(struct scan *s)
 		return;
 	free(s->flow.insns);
 	free(s->flow.facts);
+	free(s->flow.reach);
+	free(s->callees);
 	free(s->values);
 	free(s);
 }
diff --git a/tools/bpf/resolve_btfids/fmodret_scan.h b/tools/bpf/resolve_btfids/fmodret_scan.h
index a8906fe0f694..4f425d4aba5c 100644
--- a/tools/bpf/resolve_btfids/fmodret_scan.h
+++ b/tools/bpf/resolve_btfids/fmodret_scan.h
@@ -11,9 +11,17 @@ struct scan;
 /* Return NULL, after a message, if the code of IMG cannot be read */
 struct scan *scan_open(const struct image *img);
 void scan_close(struct scan *scan);
+/*
+ * FUNC takes pointers in the parameters POINTERS: bit N is parameter N. If EFFECT,
+ * a call of it changes the objects which they point to.
+ */
+void scan_set_proto(struct scan *scan, const struct image_func *func, unsigned int pointers,
+		    bool effect);
 /*
  * Find the constants which FUNC returns and whose low 32 bits are an error. Set
  * VALUES to what the return value register holds then, until the next call.
+ * Leave out a constant if each path from the entry to its return has an effect
+ * on an object which FUNC gets a pointer to, see text_flow.h.
  * Return how many there are, or -EINVAL if the code cannot be decoded.
  */
 int scan_func(struct scan *scan, const struct image_func *func, const int64_t **values);
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
index 2b148e74835d..93417cd587d2 100644
--- a/tools/bpf/resolve_btfids/text_insn.h
+++ b/tools/bpf/resolve_btfids/text_insn.h
@@ -55,13 +55,19 @@ struct text_insn {
 	/* For the user of the decoder */
 	u64 addr;
 	u32 target;	/* the index of the instruction at imm */
+	/* Of a TEXT_CALL: the registers with pointers to objects which the callee changes */
+	u32 pointers;
 };
 
 struct text_arch {
 	u8 retval;		/* the register with the return value */
+	u8 args[8], nr_args;	/* the registers with the arguments */
 	u32 caller_saved;	/* the registers which a call may write */
+	u32 stack_pointer;	/* a mask, 0 if it is not one of the registers */
 	/* A branch to this symbol is a return */
 	const char *return_thunk;
+	/* A call of this symbol, at the entry of a function, writes no register */
+	const char *entry_hook;
 	/*
 	 * Describe the instruction at ADDR, whose bytes are at CODE. At most LEN
 	 * bytes can be read. Return a negative value if it is not an instruction.
diff --git a/tools/bpf/resolve_btfids/text_mc_arm64.c b/tools/bpf/resolve_btfids/text_mc_arm64.c
index 2fe9bc281d83..c446b8b54e51 100644
--- a/tools/bpf/resolve_btfids/text_mc_arm64.c
+++ b/tools/bpf/resolve_btfids/text_mc_arm64.c
@@ -106,6 +106,8 @@ static const struct mc_test arm64_tests[] = {
 const struct mc_arch mc_arch = {
 	.arch = {
 		.retval = 0,
+		.args = { 0, 1, 2, 3, 4, 5, 6, 7 },
+		.nr_args = 8,
 		/* AAPCS64: x0 to x18 and x30 */
 		.caller_saved = 0x4007ffff,
 	},
diff --git a/tools/bpf/resolve_btfids/text_mc_x86.c b/tools/bpf/resolve_btfids/text_mc_x86.c
index e73cb8f1b4a3..a75b71caf8bf 100644
--- a/tools/bpf/resolve_btfids/text_mc_x86.c
+++ b/tools/bpf/resolve_btfids/text_mc_x86.c
@@ -121,9 +121,13 @@ static const struct mc_test x86_tests[] = {
 const struct mc_arch mc_arch = {
 	.arch = {
 		.retval = RAX,
+		.args = { RDI, RSI, RDX, RCX, R8, R9 },
+		.nr_args = 6,
 		.caller_saved = BIT(RAX) | BIT(RCX) | BIT(RDX) | BIT(RSI) | BIT(RDI) |
 				BIT(R8) | BIT(R9) | BIT(R10) | BIT(R11),
+		.stack_pointer = BIT(RSP),
 		.return_thunk = "__x86_return_thunk",
+		.entry_hook = "__fentry__",
 	},
 	.machine = EM_X86_64,
 	.triple = "x86_64-unknown-linux-gnu",
-- 
2.55.0

