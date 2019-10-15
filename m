Return-Path: <SRS0=zD4z=YI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8008C10F14
	for <bpf@archiver.kernel.org>; Tue, 15 Oct 2019 13:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9ECC2064B
	for <bpf@archiver.kernel.org>; Tue, 15 Oct 2019 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571144481;
	bh=sNSX+USdgqfv+7WQfMGKMlkNjbaOyoQl14HtTg2Ig9M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ts8L/Pm6lJgwMgEQ7ZYtOfUZQBp8VL2GgIqcpjZ3gCT+Ts60h0zv2SeBk2nhqjiCF
	 lskHD9QRGhDVHHT5uW3tRoJQhA7oT8mtNF+T9aycBcAATv/DMREjAxPtuIX5YgG+af
	 nrtsbRc7IgujPO4rhqsb5NsrmO7Hoswaq5tA+xvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfJONBV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:01:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfJONBV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Oct 2019 09:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84D3E7FDEC;
        Tue, 15 Oct 2019 13:01:20 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C62B60BE2;
        Tue, 15 Oct 2019 13:01:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: [RFC] libbpf: Allow to emit all dependent definitions
Date:   Tue, 15 Oct 2019 15:01:17 +0200
Message-Id: <20191015130117.32292-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Oct 2019 13:01:20 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently the bpf dumper does not emit definitions
of pointers to structs. It only emits forward type
declarations.

Having 2 structs like:

   struct B {
     int b;
   };

   struct A {
     struct B *ptr;
   };

the call to btf_dump__dump_type(id = struct A) dumps:

   struct B;
   struct A {
     struct B *ptr;
   };

It'd ease up bpftrace code if we could dump definitions
of all dependent types, like:

   struct B {
     int b;
   };
   struct A {
     struct B *ptr;
   };

So we could dereference all the pointers easily, instead
of searching for each access member's type and dumping it
separately.

Adding struct btf_dump_opts::emit_all to do that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/btf.h      |  1 +
 tools/lib/bpf/btf_dump.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 9cb44b4fbf60..2c0d3158efd4 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -113,6 +113,7 @@ struct btf_dump;
 
 struct btf_dump_opts {
 	void *ctx;
+	bool emit_all;
 };
 
 typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list args);
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 139812b46c7b..bab08f6428e7 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -132,6 +132,7 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 	d->btf_ext = btf_ext;
 	d->printf_fn = printf_fn;
 	d->opts.ctx = opts ? opts->ctx : NULL;
+	d->opts.emit_all = opts ? opts->emit_all : false;
 
 	d->type_names = hashmap__new(str_hash_fn, str_equal_fn, NULL);
 	if (IS_ERR(d->type_names)) {
@@ -612,7 +613,12 @@ static bool btf_dump_is_blacklisted(struct btf_dump *d, __u32 id)
 static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 {
 	struct btf_dump_type_aux_state *tstate = &d->type_states[id];
-	bool top_level_def = cont_id == 0;
+	/*
+	 * Emit difinitions (instead of forward declarations) in case
+	 * we are top level id, or we are asked to emit all definitions
+	 * via options.
+	 */
+	bool emit_def = cont_id == 0 || d->opts.emit_all;
 	const struct btf_type *t;
 	__u16 kind;
 
@@ -668,7 +674,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 		tstate->emit_state = EMITTED;
 		break;
 	case BTF_KIND_ENUM:
-		if (top_level_def) {
+		if (emit_def) {
 			btf_dump_emit_enum_def(d, id, t, 0);
 			btf_dump_printf(d, ";\n\n");
 		}
@@ -714,7 +720,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 		 * members have necessary forward-declarations, where
 		 * applicable
 		 */
-		if (top_level_def || t->name_off == 0) {
+		if (emit_def || t->name_off == 0) {
 			const struct btf_member *m = btf_members(t);
 			__u16 vlen = btf_vlen(t);
 			int i, new_cont_id;
@@ -728,7 +734,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 			tstate->fwd_emitted = 1;
 		}
 
-		if (top_level_def) {
+		if (emit_def) {
 			btf_dump_emit_struct_def(d, id, t, 0);
 			btf_dump_printf(d, ";\n\n");
 			tstate->emit_state = EMITTED;
-- 
2.21.0

