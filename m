Return-Path: <SRS0=Lh3l=QV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA6C43381
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D96222D4
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550152886;
	bh=4Z5jY6ojue/BQJL7Cv18v8kl0dQC6eE2ciY2CNLuOmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wk035gfVTa1a8R6W0zc6sGdqHomP+HF3gxpZRgKowhlUDAuoapAqrnGccQdcJkLnH
	 2HFN1kdm6nsJeUv65EQW5e+wnatBHZT7QH19qwIb51b916LbAczbzMCyIYFnkpBxr8
	 OGSO+DaL0au4hZluOGIAStLY9jV9NaG2yJb3/cBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439013AbfBNOBZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:01:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439020AbfBNOBY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Feb 2019 09:01:24 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CEF22229F;
        Thu, 14 Feb 2019 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550152882;
        bh=4Z5jY6ojue/BQJL7Cv18v8kl0dQC6eE2ciY2CNLuOmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VX2p2upXYfSQU0R17m9sWiDc62Op2xgtfnR3aCiE5OkKt9/2E1p+4lXt74RrCrw2N
         ZbMC9dCtWVVRQbfbcqV0dkU2RGY5xV167MtyHAQw95TL7BXOe2qsZUEEIPbXeAatAL
         1t9QzxHmqMvoCkOzs9Qa8PGBwhqwUaLdQBrsVQf8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CD735410D5; Thu, 14 Feb 2019 11:01:18 -0300 (-03)
Date:   Thu, 14 Feb 2019 11:01:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin Lau <kafai@fb.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
Message-ID: <20190214140118.GC7074@kernel.org>
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
 <20190214124757.GP3269@kernel.org>
 <20190214131156.GU3269@kernel.org>
 <20190214132029.GA7074@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214132029.GA7074@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Feb 14, 2019 at 10:20:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Feb 14, 2019 at 10:11:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Feb 14, 2019 at 09:47:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Wed, Feb 13, 2019 at 09:43:43PM -0800, Andrii Nakryiko escreveu:
> > > > happy with it. So consider this email a solicitation for naming
> > > > suggestion. Keep in mind, that all the pahole's functions of the form
> > > > btf__xxx will be renamed as well for consistency. If you like
> > > > btf_info, let me know as well, I'll just stick with it.
> > 
> > > Can you try thinking if splitting this further into 'struct btf_loader',
> > > 'struct btf_encoder' that would live in the pahole sources and that
> > > refer to a 'struct btf' that lives in libbpf (or in libbtf, at some
> > > point) is a move that eases your current needs?
> > 
> > So, the btf__new() in tools/lib/bpf/btf.c is basically a variant of
> > btf__new() in the pahole sources, probably we should go ahead and make
> > pahole use that btf__new() and do changes in tools/lib/bpf/btf.c to
> > allow for it to access internal state that it needs to do its job?
> 
> No, we can't, because tools/lib/btf/btf.c btf__new() is centered on
> getting some BTF buffer no matter where it comes from and passing it to
> the kernel.
> 
> So probably we should backtrack to my previous suggestion of having
> pahole use 'struct btf_loader', or even more explicitely, 'struct
> btf_elf' to make extra clear that this has nothing to do with the
> kernel, its purely about loading/encoding the BTF info from/to a ELF
> file.

So, I have this in my private branch, please see if this helps get
things moving forward:


commit 0233cc17568866f741af05ce2c8f4c2b1a4dc606
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Feb 14 10:47:32 2019 -0300

    btf: Rename 'struct btf' to 'struct btf_elf'
    
    So that we don't clash with libbpf's 'struct btf', in time more internal
    state now in 'struct btf_elf' will refer to the equivalent internal
    state in libbpf's 'struct btf', as they have lots in common.
    
    Cc: Alexei Starovoitov <ast@fb.com>
    Cc: Martin Lau <kafai@fb.com>
    Cc: Yonghong Song <yhs@fb.com>
    To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/btf_encoder.c b/btf_encoder.c
index 362c9ca39166..5ba8875107f2 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -33,8 +33,7 @@ static int tag__check_id_drift(const struct tag *tag,
 	return 0;
 }
 
-static int32_t structure_type__encode(struct btf *btf, struct tag *tag,
-				      uint32_t type_id_off)
+static int32_t structure_type__encode(struct btf_elf *btfe, struct tag *tag, uint32_t type_id_off)
 {
 	struct type *type = tag__type(tag);
 	struct class_member *pos;
@@ -63,9 +62,7 @@ static int32_t structure_type__encode(struct btf *btf, struct tag *tag,
 		}
 	}
 
-	type_id = btf__add_struct(btf, kind, type->namespace.name,
-				  kind_flag,
-				  type->size, type->nr_members);
+	type_id = btf_elf__add_struct(btfe, kind, type->namespace.name, kind_flag, type->size, type->nr_members);
 	if (type_id < 0)
 		return type_id;
 
@@ -86,7 +83,7 @@ static int32_t structure_type__encode(struct btf *btf, struct tag *tag,
 		 * which corresponds to bits 2-3 from big endian
 		 * perspective.
 		 */
-		if (btf->is_big_endian || !pos->bitfield_size)
+		if (btfe->is_big_endian || !pos->bitfield_size)
 			bit_offset = pos->bit_offset;
 		else
 			bit_offset = pos->byte_offset * 8 +
@@ -94,10 +91,7 @@ static int32_t structure_type__encode(struct btf *btf, struct tag *tag,
 				     pos->bitfield_offset -
 				     pos->bitfield_size;
 
-		if (btf__add_member(btf, pos->name,
-				    type_id_off + pos->tag.type,
-				    kind_flag, pos->bitfield_size,
-				    bit_offset))
+		if (btf_elf__add_member(btfe, pos->name, type_id_off + pos->tag.type, kind_flag, pos->bitfield_size, bit_offset))
 			return -1;
 	}
 
@@ -116,7 +110,7 @@ static uint32_t array_type__nelems(struct tag *tag)
 	return nelem;
 }
 
-static int32_t enumeration_type__encode(struct btf *btf, struct tag *tag)
+static int32_t enumeration_type__encode(struct btf_elf *btfe, struct tag *tag)
 {
 	struct type *etype = tag__type(tag);
 	struct enumerator *pos;
@@ -128,22 +122,21 @@ static int32_t enumeration_type__encode(struct btf *btf, struct tag *tag)
 
 		bt.bit_size = etype->size;
 		bt.is_signed = true;
-		return btf__add_base_type(btf, &bt);
+		return btf_elf__add_base_type(btfe, &bt);
 	}
 
-	type_id = btf__add_enum(btf, etype->namespace.name,
-				etype->size, etype->nr_members);
+	type_id = btf_elf__add_enum(btfe, etype->namespace.name, etype->size, etype->nr_members);
 	if (type_id < 0)
 		return type_id;
 
 	type__for_each_enumerator(etype, pos)
-		if (btf__add_enum_val(btf, pos->name, pos->value))
+		if (btf_elf__add_enum_val(btfe, pos->name, pos->value))
 			return -1;
 
 	return type_id;
 }
 
-static int tag__encode_btf(struct tag *tag, uint32_t core_id, struct btf *btf,
+static int tag__encode_btf(struct tag *tag, uint32_t core_id, struct btf_elf *btfe,
 			   uint32_t array_index_id, uint32_t type_id_off)
 {
 	/* single out type 0 as it represents special type "void" */
@@ -151,37 +144,31 @@ static int tag__encode_btf(struct tag *tag, uint32_t core_id, struct btf *btf,
 
 	switch (tag->tag) {
 	case DW_TAG_base_type:
-		return btf__add_base_type(btf, tag__base_type(tag));
+		return btf_elf__add_base_type(btfe, tag__base_type(tag));
 	case DW_TAG_const_type:
-		return btf__add_ref_type(btf, BTF_KIND_CONST, ref_type_id, 0, false);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_CONST, ref_type_id, 0, false);
 	case DW_TAG_pointer_type:
-		return btf__add_ref_type(btf, BTF_KIND_PTR, ref_type_id, 0, false);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_PTR, ref_type_id, 0, false);
 	case DW_TAG_restrict_type:
-		return btf__add_ref_type(btf, BTF_KIND_RESTRICT, ref_type_id, 0, false);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_RESTRICT, ref_type_id, 0, false);
 	case DW_TAG_volatile_type:
-		return btf__add_ref_type(btf, BTF_KIND_VOLATILE, ref_type_id, 0, false);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_VOLATILE, ref_type_id, 0, false);
 	case DW_TAG_typedef:
-		return btf__add_ref_type(btf, BTF_KIND_TYPEDEF, ref_type_id,
-					 tag__namespace(tag)->name, false);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_TYPEDEF, ref_type_id, tag__namespace(tag)->name, false);
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
 	case DW_TAG_class_type:
 		if (tag__type(tag)->declaration)
-			return btf__add_ref_type(btf, BTF_KIND_FWD, 0,
-						 tag__namespace(tag)->name,
-						 tag->tag == DW_TAG_union_type);
+			return btf_elf__add_ref_type(btfe, BTF_KIND_FWD, 0, tag__namespace(tag)->name, tag->tag == DW_TAG_union_type);
 		else
-			return structure_type__encode(btf, tag, type_id_off);
+			return structure_type__encode(btfe, tag, type_id_off);
 	case DW_TAG_array_type:
-		return btf__add_array(btf, ref_type_id, array_index_id,
-				      /*TODO: Encode one dimension
-				       *       at a time.
-				       */
-				      array_type__nelems(tag));
+		/* TODO: Encode one dimension at a time. */
+		return btf_elf__add_array(btfe, ref_type_id, array_index_id, array_type__nelems(tag));
 	case DW_TAG_enumeration_type:
-		return enumeration_type__encode(btf, tag);
+		return enumeration_type__encode(btfe, tag);
 	case DW_TAG_subroutine_type:
-		return btf__add_func_proto(btf, tag__ftype(tag), type_id_off);
+		return btf_elf__add_func_proto(btfe, tag__ftype(tag), type_id_off);
 	default:
 		fprintf(stderr, "Unsupported DW_TAG_%s(0x%x)\n",
 			dwarf_tag_name(tag->tag), tag->tag);
@@ -195,16 +182,16 @@ static int tag__encode_btf(struct tag *tag, uint32_t core_id, struct btf *btf,
  */
 extern struct strings *strings;
 
-static struct btf *btf;
+static struct btf_elf *btfe;
 static uint32_t array_index_id;
 
 int btf_encoder__encode()
 {
 	int err;
 
-	err = btf__encode(btf, 0);
-	btf__free(btf);
-	btf = NULL;
+	err = btf_elf__encode(btfe, 0);
+	btf_elf__free(btfe);
+	btfe = NULL;
 
 	return err;
 }
@@ -217,7 +204,7 @@ int cu__encode_btf(struct cu *cu, int verbose)
 	struct tag *pos;
 	int err = 0;
 
-	if (btf && strcmp(btf->filename, cu->filename)) {
+	if (btfe && strcmp(btfe->filename, cu->filename)) {
 		err = btf_encoder__encode();
 		if (err)
 			goto out;
@@ -227,11 +214,11 @@ int cu__encode_btf(struct cu *cu, int verbose)
 			printf("\n");
 	}
 
-	if (!btf) {
-		btf = btf__new(cu->filename, cu->elf);
-		if (!btf)
+	if (!btfe) {
+		btfe = btf_elf__new(cu->filename, cu->elf);
+		if (!btfe)
 			return -1;
-		btf__set_strings(btf, &strings->gb);
+		btf_elf__set_strings(btfe, &strings->gb);
 
 		/* cu__find_base_type_by_name() takes "uint16_t *id" */
 		uint16_t id;
@@ -242,16 +229,14 @@ int cu__encode_btf(struct cu *cu, int verbose)
 		array_index_id = id;
 
 		if (verbose)
-			printf("File %s:\n", btf->filename);
+			printf("File %s:\n", btfe->filename);
 	}
 
-	btf_verbose = verbose;
-	type_id_off = btf->type_index;
+	btf_elf__verbose = verbose;
+	type_id_off = btfe->type_index;
 
 	cu__for_each_type(cu, core_id, pos) {
-		int32_t btf_type_id = tag__encode_btf(pos, core_id, btf,
-						      array_index_id,
-						      type_id_off);
+		int32_t btf_type_id = tag__encode_btf(pos, core_id, btfe, array_index_id, type_id_off);
 
 		if (btf_type_id < 0 ||
 		    tag__check_id_drift(pos, core_id, btf_type_id, type_id_off)) {
@@ -265,11 +250,11 @@ int cu__encode_btf(struct cu *cu, int verbose)
 
 		bt.name = 0;
 		bt.bit_size = 32;
-		btf__add_base_type(btf, &bt);
+		btf_elf__add_base_type(btfe, &bt);
 	}
 
 out:
 	if (err)
-		btf__free(btf);
+		btf_elf__free(btfe);
 	return err;
 }
diff --git a/btf_loader.c b/btf_loader.c
index 8583cc8a7406..390f107595c2 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -45,8 +45,8 @@ static void *tag__alloc(const size_t size)
 	return tag;
 }
 
-static int btf__load_ftype(struct btf *btf, struct ftype *proto, uint16_t tag,
-			   uint32_t type, uint16_t vlen, struct btf_param *args, long id)
+static int btf_elf__load_ftype(struct btf_elf *btfe, struct ftype *proto, uint16_t tag,
+			       uint32_t type, uint16_t vlen, struct btf_param *args, long id)
 {
 	int i;
 
@@ -56,8 +56,8 @@ static int btf__load_ftype(struct btf *btf, struct ftype *proto, uint16_t tag,
 
 	for (i = 0; i < vlen; ++i) {
 		struct btf_param param = {
-		       .name_off = btf__get32(btf, &args[i].name_off),
-		       .type	 = btf__get32(btf, &args[i].type),
+		       .name_off = btf_elf__get32(btfe, &args[i].name_off),
+		       .type	 = btf_elf__get32(btfe, &args[i].type),
 		};
 
 		if (param.type == 0)
@@ -75,11 +75,11 @@ static int btf__load_ftype(struct btf *btf, struct ftype *proto, uint16_t tag,
 	}
 
 	vlen *= sizeof(*args);
-	cu__add_tag(btf->priv, &proto->tag, &id);
+	cu__add_tag(btfe->priv, &proto->tag, &id);
 
 	return vlen;
 out_free_parameters:
-	ftype__delete(proto, btf->priv);
+	ftype__delete(proto, btfe->priv);
 	return -ENOMEM;
 }
 
@@ -133,24 +133,24 @@ static struct class *class__new(strings_t name, size_t size)
 	return class;
 }
 
-static int create_new_base_type(struct btf *btf, void *ptr, struct btf_type *tp, long id)
+static int create_new_base_type(struct btf_elf *btfe, void *ptr, struct btf_type *tp, long id)
 {
 	uint32_t *enc = ptr;
-	uint32_t eval = btf__get32(btf, enc);
+	uint32_t eval = btf_elf__get32(btfe, enc);
 	uint32_t attrs = BTF_INT_ENCODING(eval);
-	strings_t name = btf__get32(btf, &tp->name_off);
+	strings_t name = btf_elf__get32(btfe, &tp->name_off);
 	struct base_type *base = base_type__new(name, attrs, 0,
 						BTF_INT_BITS(eval));
 	if (base == NULL)
 		return -ENOMEM;
 
 	base->tag.tag = DW_TAG_base_type;
-	cu__add_tag(btf->priv, &base->tag, &id);
+	cu__add_tag(btfe->priv, &base->tag, &id);
 
 	return sizeof(*enc);
 }
 
-static int create_new_array(struct btf *btf, void *ptr, long id)
+static int create_new_array(struct btf_elf *btfe, void *ptr, long id)
 {
 	struct btf_array *ap = ptr;
 	struct array_type *array = tag__alloc(sizeof(*array));
@@ -168,16 +168,16 @@ static int create_new_array(struct btf *btf, void *ptr, long id)
 		return -ENOMEM;
 	}
 
-	array->nr_entries[0] = btf__get32(btf, &ap->nelems);
+	array->nr_entries[0] = btf_elf__get32(btfe, &ap->nelems);
 	array->tag.tag = DW_TAG_array_type;
-	array->tag.type = btf__get32(btf, &ap->type);
+	array->tag.type = btf_elf__get32(btfe, &ap->type);
 
-	cu__add_tag(btf->priv, &array->tag, &id);
+	cu__add_tag(btfe->priv, &array->tag, &id);
 
 	return sizeof(*ap);
 }
 
-static int create_members(struct btf *btf, void *ptr, int vlen, struct type *class,
+static int create_members(struct btf_elf *btfe, void *ptr, int vlen, struct type *class,
 			  bool kflag)
 {
 	struct btf_member *mp = ptr;
@@ -191,9 +191,9 @@ static int create_members(struct btf *btf, void *ptr, int vlen, struct type *cla
 			return -ENOMEM;
 
 		member->tag.tag    = DW_TAG_member;
-		member->tag.type   = btf__get32(btf, &mp[i].type);
-		member->name	   = btf__get32(btf, &mp[i].name_off);
-		offset = btf__get32(btf, &mp[i].offset);
+		member->tag.type   = btf_elf__get32(btfe, &mp[i].type);
+		member->name	   = btf_elf__get32(btfe, &mp[i].name_off);
+		offset = btf_elf__get32(btfe, &mp[i].offset);
 		if (kflag) {
 			member->bit_offset = BTF_MEMBER_BIT_OFFSET(offset);
 			member->bitfield_size = BTF_MEMBER_BITFIELD_SIZE(offset);
@@ -209,42 +209,42 @@ static int create_members(struct btf *btf, void *ptr, int vlen, struct type *cla
 	return sizeof(*mp);
 }
 
-static int create_new_class(struct btf *btf, void *ptr, int vlen,
+static int create_new_class(struct btf_elf *btfe, void *ptr, int vlen,
 			    struct btf_type *tp, uint64_t size, long id,
 			    bool kflag)
 {
-	strings_t name = btf__get32(btf, &tp->name_off);
+	strings_t name = btf_elf__get32(btfe, &tp->name_off);
 	struct class *class = class__new(name, size);
-	int member_size = create_members(btf, ptr, vlen, &class->type, kflag);
+	int member_size = create_members(btfe, ptr, vlen, &class->type, kflag);
 
 	if (member_size < 0)
 		goto out_free;
 
-	cu__add_tag(btf->priv, &class->type.namespace.tag, &id);
+	cu__add_tag(btfe->priv, &class->type.namespace.tag, &id);
 
 	return (vlen * member_size);
 out_free:
-	class__delete(class, btf->priv);
+	class__delete(class, btfe->priv);
 	return -ENOMEM;
 }
 
-static int create_new_union(struct btf *btf, void *ptr,
+static int create_new_union(struct btf_elf *btfe, void *ptr,
 			    int vlen, struct btf_type *tp,
 			    uint64_t size, long id,
 			    bool kflag)
 {
-	strings_t name = btf__get32(btf, &tp->name_off);
+	strings_t name = btf_elf__get32(btfe, &tp->name_off);
 	struct type *un = type__new(DW_TAG_union_type, name, size);
-	int member_size = create_members(btf, ptr, vlen, un, kflag);
+	int member_size = create_members(btfe, ptr, vlen, un, kflag);
 
 	if (member_size < 0)
 		goto out_free;
 
-	cu__add_tag(btf->priv, &un->namespace.tag, &id);
+	cu__add_tag(btfe->priv, &un->namespace.tag, &id);
 
 	return (vlen * member_size);
 out_free:
-	type__delete(un, btf->priv);
+	type__delete(un, btfe->priv);
 	return -ENOMEM;
 }
 
@@ -261,22 +261,22 @@ static struct enumerator *enumerator__new(strings_t name, uint32_t value)
 	return en;
 }
 
-static int create_new_enumeration(struct btf *btf, void *ptr,
+static int create_new_enumeration(struct btf_elf *btfe, void *ptr,
 				  int vlen, struct btf_type *tp,
 				  uint16_t size, long id)
 {
 	struct btf_enum *ep = ptr;
 	uint16_t i;
 	struct type *enumeration = type__new(DW_TAG_enumeration_type,
-					     btf__get32(btf, &tp->name_off),
+					     btf_elf__get32(btfe, &tp->name_off),
 					     size ? size * 8 : (sizeof(int) * 8));
 
 	if (enumeration == NULL)
 		return -ENOMEM;
 
 	for (i = 0; i < vlen; i++) {
-		strings_t name = btf__get32(btf, &ep[i].name_off);
-		uint32_t value = btf__get32(btf, &ep[i].val);
+		strings_t name = btf_elf__get32(btfe, &ep[i].name_off);
+		uint32_t value = btf_elf__get32(btfe, &ep[i].val);
 		struct enumerator *enumerator = enumerator__new(name, value);
 
 		if (enumerator == NULL)
@@ -285,61 +285,60 @@ static int create_new_enumeration(struct btf *btf, void *ptr,
 		enumeration__add(enumeration, enumerator);
 	}
 
-	cu__add_tag(btf->priv, &enumeration->namespace.tag, &id);
+	cu__add_tag(btfe->priv, &enumeration->namespace.tag, &id);
 
 	return (vlen * sizeof(*ep));
 out_free:
-	enumeration__delete(enumeration, btf->priv);
+	enumeration__delete(enumeration, btfe->priv);
 	return -ENOMEM;
 }
 
-static int create_new_subroutine_type(struct btf *btf, void *ptr,
+static int create_new_subroutine_type(struct btf_elf *btfe, void *ptr,
 				      int vlen, struct btf_type *tp,
 				      long id)
 {
 	struct btf_param *args = ptr;
-	unsigned int type = btf__get32(btf, &tp->type);
+	unsigned int type = btf_elf__get32(btfe, &tp->type);
 	struct ftype *proto = tag__alloc(sizeof(*proto));
 
 	if (proto == NULL)
 		return -ENOMEM;
 
-	vlen = btf__load_ftype(btf, proto, DW_TAG_subroutine_type,
-			       type, vlen, args, id);
+	vlen = btf_elf__load_ftype(btfe, proto, DW_TAG_subroutine_type, type, vlen, args, id);
 	return vlen < 0 ? -ENOMEM : vlen;
 }
 
-static int create_new_forward_decl(struct btf *btf, struct btf_type *tp,
+static int create_new_forward_decl(struct btf_elf *btfe, struct btf_type *tp,
 				   uint64_t size, long id)
 {
-	strings_t name = btf__get32(btf, &tp->name_off);
+	strings_t name = btf_elf__get32(btfe, &tp->name_off);
 	struct class *fwd = class__new(name, size);
 
 	if (fwd == NULL)
 		return -ENOMEM;
 	fwd->type.declaration = 1;
-	cu__add_tag(btf->priv, &fwd->type.namespace.tag, &id);
+	cu__add_tag(btfe->priv, &fwd->type.namespace.tag, &id);
 	return 0;
 }
 
-static int create_new_typedef(struct btf *btf, struct btf_type *tp, uint64_t size, long id)
+static int create_new_typedef(struct btf_elf *btfe, struct btf_type *tp, uint64_t size, long id)
 {
-	strings_t name = btf__get32(btf, &tp->name_off);
-	unsigned int type_id = btf__get32(btf, &tp->type);
+	strings_t name = btf_elf__get32(btfe, &tp->name_off);
+	unsigned int type_id = btf_elf__get32(btfe, &tp->type);
 	struct type *type = type__new(DW_TAG_typedef, name, size);
 
 	if (type == NULL)
 		return -ENOMEM;
 
 	type->namespace.tag.type = type_id;
-	cu__add_tag(btf->priv, &type->namespace.tag, &id);
+	cu__add_tag(btfe->priv, &type->namespace.tag, &id);
 
 	return 0;
 }
 
-static int create_new_tag(struct btf *btf, int type, struct btf_type *tp, long id)
+static int create_new_tag(struct btf_elf *btfe, int type, struct btf_type *tp, long id)
 {
-	unsigned int type_id = btf__get32(btf, &tp->type);
+	unsigned int type_id = btf_elf__get32(btfe, &tp->type);
 	struct tag *tag = zalloc(sizeof(*tag));
 
 	if (tag == NULL)
@@ -356,70 +355,70 @@ static int create_new_tag(struct btf *btf, int type, struct btf_type *tp, long i
 	}
 
 	tag->type = type_id;
-	cu__add_tag(btf->priv, tag, &id);
+	cu__add_tag(btfe->priv, tag, &id);
 
 	return 0;
 }
 
-void *btf__get_buffer(struct btf *btf)
+void *btf_elf__get_buffer(struct btf_elf *btfe)
 {
-	return btf->data;
+	return btfe->data;
 }
 
-size_t btf__get_size(struct btf *btf)
+size_t btf_elf__get_size(struct btf_elf *btfe)
 {
-	return btf->size;
+	return btfe->size;
 }
 
-static int btf__load_types(struct btf *btf)
+static int btf_elf__load_types(struct btf_elf *btfe)
 {
-	void *btf_buffer = btf__get_buffer(btf);
+	void *btf_buffer = btf_elf__get_buffer(btfe);
 	struct btf_header *hp = btf_buffer;
 	void *btf_contents = btf_buffer + sizeof(*hp),
-	     *type_section = (btf_contents + btf__get32(btf, &hp->type_off)),
-	     *strings_section = (btf_contents + btf__get32(btf, &hp->str_off));
+	     *type_section = (btf_contents + btf_elf__get32(btfe, &hp->type_off)),
+	     *strings_section = (btf_contents + btf_elf__get32(btfe, &hp->str_off));
 	struct btf_type *type_ptr = type_section,
 			*end = strings_section;
 	unsigned int type_index = 0x0001;
 
 	while (type_ptr < end) {
-		uint32_t val  = btf__get32(btf, &type_ptr->info);
+		uint32_t val  = btf_elf__get32(btfe, &type_ptr->info);
 		uint32_t type = BTF_INFO_KIND(val);
 		int	 vlen = BTF_INFO_VLEN(val);
 		void	 *ptr = type_ptr;
-		uint32_t size = btf__get32(btf, &type_ptr->size);
+		uint32_t size = btf_elf__get32(btfe, &type_ptr->size);
 		bool     kflag = BTF_INFO_KFLAG(val);
 
 		ptr += sizeof(struct btf_type);
 
 		if (type == BTF_KIND_INT) {
-			vlen = create_new_base_type(btf, ptr, type_ptr, type_index);
+			vlen = create_new_base_type(btfe, ptr, type_ptr, type_index);
 		} else if (type == BTF_KIND_ARRAY) {
-			vlen = create_new_array(btf, ptr, type_index);
+			vlen = create_new_array(btfe, ptr, type_index);
 		} else if (type == BTF_KIND_STRUCT) {
-			vlen = create_new_class(btf, ptr, vlen, type_ptr, size, type_index, kflag);
+			vlen = create_new_class(btfe, ptr, vlen, type_ptr, size, type_index, kflag);
 		} else if (type == BTF_KIND_UNION) {
-			vlen = create_new_union(btf, ptr, vlen, type_ptr, size, type_index, kflag);
+			vlen = create_new_union(btfe, ptr, vlen, type_ptr, size, type_index, kflag);
 		} else if (type == BTF_KIND_ENUM) {
-			vlen = create_new_enumeration(btf, ptr, vlen, type_ptr, size, type_index);
+			vlen = create_new_enumeration(btfe, ptr, vlen, type_ptr, size, type_index);
 		} else if (type == BTF_KIND_FWD) {
-			vlen = create_new_forward_decl(btf, type_ptr, size, type_index);
+			vlen = create_new_forward_decl(btfe, type_ptr, size, type_index);
 		} else if (type == BTF_KIND_TYPEDEF) {
-			vlen = create_new_typedef(btf, type_ptr, size, type_index);
+			vlen = create_new_typedef(btfe, type_ptr, size, type_index);
 		} else if (type == BTF_KIND_VOLATILE ||
 			   type == BTF_KIND_PTR ||
 			   type == BTF_KIND_CONST ||
 			   type == BTF_KIND_RESTRICT) {
-			vlen = create_new_tag(btf, type, type_ptr, type_index);
+			vlen = create_new_tag(btfe, type, type_ptr, type_index);
 		} else if (type == BTF_KIND_UNKN) {
-			cu__table_nullify_type_entry(btf->priv, type_index);
+			cu__table_nullify_type_entry(btfe->priv, type_index);
 			fprintf(stderr,
 				"BTF: idx: %d, off: %zd, Unknown\n",
 				type_index, ((void *)type_ptr) - type_section);
 			fflush(stderr);
 			vlen = 0;
 		} else if (type == BTF_KIND_FUNC_PROTO) {
-			vlen = create_new_subroutine_type(btf, ptr, vlen, type_ptr, type_index);
+			vlen = create_new_subroutine_type(btfe, ptr, vlen, type_ptr, type_index);
 		} else if (type == BTF_KIND_FUNC) {
 			/* BTF_KIND_FUNC corresponding to a defined subprogram.
 			 * This is not really a type and it won't be referred by any other types
@@ -428,7 +427,7 @@ static int btf__load_types(struct btf *btf)
 			 *
 			 * No warning here since BTF_KIND_FUNC is a legal entry in BTF.
 			 */
-			cu__table_nullify_type_entry(btf->priv, type_index);
+			cu__table_nullify_type_entry(btfe->priv, type_index);
 			vlen = 0;
 		} else {
 			fprintf(stderr,
@@ -447,12 +446,12 @@ static int btf__load_types(struct btf *btf)
 	return 0;
 }
 
-static int btf__load_sections(struct btf *btf)
+static int btf_elf__load_sections(struct btf_elf *btfe)
 {
-	return btf__load_types(btf);
+	return btf_elf__load_types(btfe);
 }
 
-static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu, struct btf *btf)
+static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu, struct btf_elf *btfe)
 {
 	struct class_member *pos;
 	struct type *tag_type = tag__type(tag);
@@ -510,7 +509,7 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu, struct btf
 		}
 
 		pos->bitfield_offset = pos->bit_offset % integral_bit_size;
-		if (!btf->is_big_endian)
+		if (!btfe->is_big_endian)
 			pos->bitfield_offset = integral_bit_size - pos->bitfield_offset - pos->bitfield_size;
 
 		pos->bit_size = type_bit_size;
@@ -521,14 +520,14 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu, struct btf
 	return 0;
 }
 
-static int cu__fixup_btf_bitfields(struct cu *cu, struct btf *btf)
+static int cu__fixup_btf_bitfields(struct cu *cu, struct btf_elf *btfe)
 {
 	int err = 0;
 	struct tag *pos;
 
 	list_for_each_entry(pos, &cu->tags, node)
 		if (tag__is_struct(pos) || tag__is_union(pos)) {
-			err = class__fixup_btf_bitfields(pos, cu, btf);
+			err = class__fixup_btf_bitfields(pos, cu, btfe);
 			if (err)
 				break;
 		}
@@ -536,48 +535,47 @@ static int cu__fixup_btf_bitfields(struct cu *cu, struct btf *btf)
 	return err;
 }
 
-static void btf__cu_delete(struct cu *cu)
+static void btf_elf__cu_delete(struct cu *cu)
 {
-	btf__free(cu->priv);
+	btf_elf__free(cu->priv);
 	cu->priv = NULL;
 }
 
-static const char *btf__strings_ptr(const struct cu *cu, strings_t s)
+static const char *btf_elf__strings_ptr(const struct cu *cu, strings_t s)
 {
-	return btf__string(cu->priv, s);
+	return btf_elf__string(cu->priv, s);
 }
 
-struct debug_fmt_ops btf__ops;
+struct debug_fmt_ops btf_elf__ops;
 
-int btf__load_file(struct cus *cus, struct conf_load *conf,
-		   const char *filename)
+int btf_elf__load_file(struct cus *cus, struct conf_load *conf, const char *filename)
 {
 	int err;
-	struct btf *state = btf__new(filename, NULL);
+	struct btf_elf *btfe = btf_elf__new(filename, NULL);
 
-	if (state == NULL)
+	if (btfe == NULL)
 		return -1;
 
-	struct cu *cu = cu__new(filename, state->wordsize, NULL, 0, filename);
+	struct cu *cu = cu__new(filename, btfe->wordsize, NULL, 0, filename);
 	if (cu == NULL)
 		return -1;
 
 	cu->language = LANG_C;
 	cu->uses_global_strings = false;
-	cu->dfops = &btf__ops;
-	cu->priv = state;
-	state->priv = cu;
-	if (btf__load(state) != 0)
+	cu->dfops = &btf_elf__ops;
+	cu->priv = btfe;
+	btfe->priv = cu;
+	if (btf_elf__load(btfe) != 0)
 		return -1;
 
-	err = btf__load_sections(state);
+	err = btf_elf__load_sections(btfe);
 
 	if (err != 0) {
 		cu__delete(cu);
 		return err;
 	}
 
-	err = cu__fixup_btf_bitfields(cu, state);
+	err = cu__fixup_btf_bitfields(cu, btfe);
 	/*
 	 * The app stole this cu, possibly deleting it,
 	 * so forget about it
@@ -589,9 +587,9 @@ int btf__load_file(struct cus *cus, struct conf_load *conf,
 	return err;
 }
 
-struct debug_fmt_ops btf__ops = {
+struct debug_fmt_ops btf_elf__ops = {
 	.name		= "btf",
-	.load_file	= btf__load_file,
-	.strings__ptr	= btf__strings_ptr,
-	.cu__delete	= btf__cu_delete,
+	.load_file	= btf_elf__load_file,
+	.strings__ptr	= btf_elf__strings_ptr,
+	.cu__delete	= btf_elf__cu_delete,
 };
diff --git a/dwarves.c b/dwarves.c
index 250eaae61d75..093de117886b 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1457,12 +1457,12 @@ out:
 /*
  * This should really do demand loading of DSOs, STABS anyone? 8-)
  */
-extern struct debug_fmt_ops dwarf__ops, ctf__ops, btf__ops;
+extern struct debug_fmt_ops dwarf__ops, ctf__ops, btf_elf__ops;
 
 static struct debug_fmt_ops *debug_fmt_table[] = {
 	&dwarf__ops,
 	&ctf__ops,
-	&btf__ops,
+	&btf_elf__ops,
 	NULL,
 };
 
diff --git a/libbtf.c b/libbtf.c
index 42da6a37de40..2d1ccf7af140 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -41,13 +41,13 @@ struct btf_array_type {
 	struct btf_array array;
 };
 
-uint8_t btf_verbose;
+uint8_t btf_elf__verbose;
 
-uint32_t btf__get32(struct btf *btf, uint32_t *p)
+uint32_t btf_elf__get32(struct btf_elf *btfe, uint32_t *p)
 {
 	uint32_t val = *p;
 
-	if (btf->swapped)
+	if (btfe->swapped)
 		val = ((val >> 24) |
 		       ((val >> 8) & 0x0000ff00) |
 		       ((val << 8) & 0x00ff0000) |
@@ -55,11 +55,11 @@ uint32_t btf__get32(struct btf *btf, uint32_t *p)
 	return val;
 }
 
-int btf__load(struct btf *btf)
+int btf_elf__load(struct btf_elf *btfe)
 {
 	int err = -ENOTSUP;
 	GElf_Shdr shdr;
-	Elf_Scn *sec = elf_section_by_name(btf->elf, &btf->ehdr, &shdr, ".BTF", NULL);
+	Elf_Scn *sec = elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr, ".BTF", NULL);
 
 	if (sec == NULL)
 		return -ESRCH;
@@ -78,15 +78,15 @@ int btf__load(struct btf *btf)
 
 	err = -EINVAL;
 	if (hp->magic == BTF_MAGIC)
-		btf->swapped = 0;
+		btfe->swapped = 0;
 	else
 		goto out;
 
 	err = -ENOMEM;
-	btf->data = malloc(orig_size);
-	if (btf->data != NULL) {
-		memcpy(btf->data, hp, orig_size);
-		btf->size = orig_size;
+	btfe->data = malloc(orig_size);
+	if (btfe->data != NULL) {
+		memcpy(btfe->data, hp, orig_size);
+		btfe->size = orig_size;
 		err = 0;
 	}
 out:
@@ -94,23 +94,23 @@ out:
 }
 
 
-struct btf *btf__new(const char *filename, Elf *elf)
+struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
 {
-	struct btf *btf = zalloc(sizeof(*btf));
+	struct btf_elf *btfe = zalloc(sizeof(*btfe));
 
-	if (!btf)
+	if (!btfe)
 		return NULL;
 
-	btf->in_fd = -1;
-	btf->filename = strdup(filename);
-	if (btf->filename == NULL)
+	btfe->in_fd = -1;
+	btfe->filename = strdup(filename);
+	if (btfe->filename == NULL)
 		goto errout;
 
 	if (elf != NULL) {
-		btf->elf = elf;
+		btfe->elf = elf;
 	} else {
-		btf->in_fd = open(filename, O_RDONLY);
-		if (btf->in_fd < 0)
+		btfe->in_fd = open(filename, O_RDONLY);
+		if (btfe->in_fd < 0)
 			goto errout;
 
 		if (elf_version(EV_CURRENT) == EV_NONE) {
@@ -119,82 +119,82 @@ struct btf *btf__new(const char *filename, Elf *elf)
 			goto errout;
 		}
 
-		btf->elf = elf_begin(btf->in_fd, ELF_C_READ_MMAP, NULL);
-		if (!btf->elf) {
+		btfe->elf = elf_begin(btfe->in_fd, ELF_C_READ_MMAP, NULL);
+		if (!btfe->elf) {
 			fprintf(stderr, "%s: cannot read %s ELF file.\n",
 				__func__, filename);
 			goto errout;
 		}
 	}
 
-	if (gelf_getehdr(btf->elf, &btf->ehdr) == NULL) {
+	if (gelf_getehdr(btfe->elf, &btfe->ehdr) == NULL) {
 		fprintf(stderr, "%s: cannot get elf header.\n", __func__);
 		goto errout;
 	}
 
-	switch (btf->ehdr.e_ident[EI_DATA]) {
-	case ELFDATA2LSB: btf->is_big_endian = false; break;
-	case ELFDATA2MSB: btf->is_big_endian = true;  break;
+	switch (btfe->ehdr.e_ident[EI_DATA]) {
+	case ELFDATA2LSB: btfe->is_big_endian = false; break;
+	case ELFDATA2MSB: btfe->is_big_endian = true;  break;
 	default:
 		fprintf(stderr, "%s: unknown elf endianness.\n", __func__);
 		goto errout;
 	}
 
-	switch (btf->ehdr.e_ident[EI_CLASS]) {
-	case ELFCLASS32: btf->wordsize = 4; break;
-	case ELFCLASS64: btf->wordsize = 8; break;
-	default:	 btf->wordsize = 0; break;
+	switch (btfe->ehdr.e_ident[EI_CLASS]) {
+	case ELFCLASS32: btfe->wordsize = 4; break;
+	case ELFCLASS64: btfe->wordsize = 8; break;
+	default:	 btfe->wordsize = 0; break;
 	}
 
-	return btf;
+	return btfe;
 
 errout:
-	btf__free(btf);
+	btf_elf__free(btfe);
 	return NULL;
 }
 
-void btf__free(struct btf *btf)
+void btf_elf__free(struct btf_elf *btfe)
 {
-	if (!btf)
+	if (!btfe)
 		return;
 
-	if (btf->in_fd != -1) {
-		close(btf->in_fd);
-		if (btf->elf)
-			elf_end(btf->elf);
+	if (btfe->in_fd != -1) {
+		close(btfe->in_fd);
+		if (btfe->elf)
+			elf_end(btfe->elf);
 	}
 
-	__gobuffer__delete(&btf->types);
-	free(btf->filename);
-	free(btf->data);
-	free(btf);
+	__gobuffer__delete(&btfe->types);
+	free(btfe->filename);
+	free(btfe->data);
+	free(btfe);
 }
 
-char *btf__string(struct btf *btf, uint32_t ref)
+char *btf_elf__string(struct btf_elf *btfe, uint32_t ref)
 {
-	struct btf_header *hp = btf->hdr;
+	struct btf_header *hp = btfe->hdr;
 	uint32_t off = ref;
 	char *name;
 
-	if (off >= btf__get32(btf, &hp->str_len))
+	if (off >= btf_elf__get32(btfe, &hp->str_len))
 		return "(ref out-of-bounds)";
 
-	if ((off + btf__get32(btf, &hp->str_off)) >= btf->size)
+	if ((off + btf_elf__get32(btfe, &hp->str_off)) >= btfe->size)
 		return "(string table truncated)";
 
-	name = ((char *)(hp + 1) + btf__get32(btf, &hp->str_off) + off);
+	name = ((char *)(hp + 1) + btf_elf__get32(btfe, &hp->str_off) + off);
 
 	return name[0] == '\0' ? NULL : name;
 }
 
-static void *btf__nohdr_data(struct btf *btf)
+static void *btf_elf__nohdr_data(struct btf_elf *btfe)
 {
-	return btf->hdr + 1;
+	return btfe->hdr + 1;
 }
 
-void btf__set_strings(struct btf *btf, struct gobuffer *strings)
+void btf_elf__set_strings(struct btf_elf *btfe, struct gobuffer *strings)
 {
-	btf->strings = strings;
+	btfe->strings = strings;
 }
 
 #define BITS_PER_BYTE 8
@@ -220,16 +220,15 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
 };
 
-static const char *btf__name_in_gobuf(const struct btf *btf,
-				      uint32_t offset)
+static const char *btf_elf__name_in_gobuf(const struct btf_elf *btfe, uint32_t offset)
 {
 	if (!offset)
 		return "(anon)";
 	else
-		return &btf->strings->entries[offset];
+		return &btfe->strings->entries[offset];
 }
 
-static const char * btf__int_encoding_str(uint8_t encoding)
+static const char * btf_elf__int_encoding_str(uint8_t encoding)
 {
 	if (encoding == 0)
 		return "(none)";
@@ -244,21 +243,21 @@ static const char * btf__int_encoding_str(uint8_t encoding)
 }
 
 __attribute ((format (printf, 5, 6)))
-static void btf__log_type(const struct btf *btf, const struct btf_type *t,
-			  bool err, bool output_cr, const char *fmt, ...)
+static void btf_elf__log_type(const struct btf_elf *btfe, const struct btf_type *t,
+			      bool err, bool output_cr, const char *fmt, ...)
 {
 	uint8_t kind;
 	FILE *out;
 
-	if (!btf_verbose && !err)
+	if (!btf_elf__verbose && !err)
 		return;
 
 	kind = BTF_INFO_KIND(t->info);
 	out = err ? stderr : stdout;
 
 	fprintf(out, "[%u] %s %s",
-		btf->type_index, btf_kind_str[kind],
-		btf__name_in_gobuf(btf, t->name_off));
+		btfe->type_index, btf_kind_str[kind],
+		btf_elf__name_in_gobuf(btfe, t->name_off));
 
 	if (fmt && *fmt) {
 		va_list ap;
@@ -274,26 +273,26 @@ static void btf__log_type(const struct btf *btf, const struct btf_type *t,
 }
 
 __attribute ((format (printf, 5, 6)))
-static void btf_log_member(const struct btf *btf,
+static void btf_log_member(const struct btf_elf *btfe,
 			   const struct btf_member *member,
 			   bool kind_flag, bool err, const char *fmt, ...)
 {
 	FILE *out;
 
-	if (!btf_verbose && !err)
+	if (!btf_elf__verbose && !err)
 		return;
 
 	out = err ? stderr : stdout;
 
 	if (kind_flag)
 		fprintf(out, "\t%s type_id=%u bitfield_size=%u bits_offset=%u",
-			btf__name_in_gobuf(btf, member->name_off),
+			btf_elf__name_in_gobuf(btfe, member->name_off),
 			member->type,
 			BTF_MEMBER_BITFIELD_SIZE(member->offset),
 			BTF_MEMBER_BIT_OFFSET(member->offset));
 	else
 		fprintf(out, "\t%s type_id=%u bits_offset=%u",
-			btf__name_in_gobuf(btf, member->name_off),
+			btf_elf__name_in_gobuf(btfe, member->name_off),
 			member->type,
 			member->offset);
 
@@ -310,14 +309,14 @@ static void btf_log_member(const struct btf *btf,
 }
 
 __attribute ((format (printf, 6, 7)))
-static void btf_log_func_param(const struct btf *btf,
+static void btf_log_func_param(const struct btf_elf *btfe,
 			       uint32_t name_off, uint32_t type,
 			       bool err, bool is_last_param,
 			       const char *fmt, ...)
 {
 	FILE *out;
 
-	if (!btf_verbose && !err)
+	if (!btf_elf__verbose && !err)
 		return;
 
 	out = err ? stderr : stdout;
@@ -326,7 +325,7 @@ static void btf_log_func_param(const struct btf *btf,
 		fprintf(out, "vararg)\n");
 	else
 		fprintf(out, "%u %s%s", type,
-			btf__name_in_gobuf(btf, name_off),
+			btf_elf__name_in_gobuf(btfe, name_off),
 			is_last_param ? ")\n" : ", ");
 
 	if (fmt && *fmt) {
@@ -339,7 +338,7 @@ static void btf_log_func_param(const struct btf *btf,
 	}
 }
 
-int32_t btf__add_base_type(struct btf *btf, const struct base_type *bt)
+int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt)
 {
 	struct btf_int_type int_type;
 	struct btf_type *t = &int_type.type;
@@ -358,26 +357,26 @@ int32_t btf__add_base_type(struct btf *btf, const struct base_type *bt)
 	}
 	int_type.data = BTF_INT_ENCODE(encoding, 0, bt->bit_size);
 
-	++btf->type_index;
-	if (gobuffer__add(&btf->types, &int_type, sizeof(int_type)) >= 0) {
-		btf__log_type(btf, t, false, true,
+	++btfe->type_index;
+	if (gobuffer__add(&btfe->types, &int_type, sizeof(int_type)) >= 0) {
+		btf_elf__log_type(btfe, t, false, true,
 			      "size=%u bit_offset=%u nr_bits=%u encoding=%s",
 			      t->size, BTF_INT_OFFSET(int_type.data),
 			      BTF_INT_BITS(int_type.data),
-			      btf__int_encoding_str(BTF_INT_ENCODING(int_type.data)));
-		return btf->type_index;
+			      btf_elf__int_encoding_str(BTF_INT_ENCODING(int_type.data)));
+		return btfe->type_index;
 	} else {
-		btf__log_type(btf, t, true, true,
+		btf_elf__log_type(btfe, t, true, true,
 			      "size=%u bit_offset=%u nr_bits=%u encoding=%s Error in adding gobuffer",
 			      t->size, BTF_INT_OFFSET(int_type.data),
 			      BTF_INT_BITS(int_type.data),
-			      btf__int_encoding_str(BTF_INT_ENCODING(int_type.data)));
+			      btf_elf__int_encoding_str(BTF_INT_ENCODING(int_type.data)));
 		return -1;
 	}
 }
 
-int32_t btf__add_ref_type(struct btf *btf, uint16_t kind, uint32_t type,
-			  uint32_t name, bool kind_flag)
+int32_t btf_elf__add_ref_type(struct btf_elf *btfe, uint16_t kind, uint32_t type,
+			      uint32_t name, bool kind_flag)
 {
 	struct btf_type t;
 
@@ -385,24 +384,22 @@ int32_t btf__add_ref_type(struct btf *btf, uint16_t kind, uint32_t type,
 	t.info = BTF_INFO_ENCODE(kind, kind_flag, 0);
 	t.type = type;
 
-	++btf->type_index;
-	if (gobuffer__add(&btf->types, &t, sizeof(t)) >= 0) {
+	++btfe->type_index;
+	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >= 0) {
 		if (kind == BTF_KIND_FWD)
-			btf__log_type(btf, &t, false, true, "%s",
-				      kind_flag ? "union" : "struct");
+			btf_elf__log_type(btfe, &t, false, true, "%s", kind_flag ? "union" : "struct");
 		else
-			btf__log_type(btf, &t, false, true, "type_id=%u", t.type);
-		return btf->type_index;
+			btf_elf__log_type(btfe, &t, false, true, "type_id=%u", t.type);
+		return btfe->type_index;
 	} else {
-		btf__log_type(btf, &t, true, true,
+		btf_elf__log_type(btfe, &t, true, true,
 			      "kind_flag=%d type_id=%u Error in adding gobuffer",
 			      kind_flag, t.type);
 		return -1;
 	}
 }
 
-int32_t btf__add_array(struct btf *btf, uint32_t type, uint32_t index_type,
-		       uint32_t nelems)
+int32_t btf_elf__add_array(struct btf_elf *btfe, uint32_t type, uint32_t index_type, uint32_t nelems)
 {
 	struct btf_array_type array_type;
 	struct btf_type *t = &array_type.type;
@@ -416,22 +413,22 @@ int32_t btf__add_array(struct btf *btf, uint32_t type, uint32_t index_type,
 	array->index_type = index_type;
 	array->nelems = nelems;
 
-	++btf->type_index;
-	if (gobuffer__add(&btf->types, &array_type, sizeof(array_type)) >= 0) {
-		btf__log_type(btf, t, false, true,
+	++btfe->type_index;
+	if (gobuffer__add(&btfe->types, &array_type, sizeof(array_type)) >= 0) {
+		btf_elf__log_type(btfe, t, false, true,
 			      "type_id=%u index_type_id=%u nr_elems=%u",
 			      array->type, array->index_type, array->nelems);
-		return btf->type_index;
+		return btfe->type_index;
 	} else {
-		btf__log_type(btf, t, true, true,
+		btf_elf__log_type(btfe, t, true, true,
 			      "type_id=%u index_type_id=%u nr_elems=%u Error in adding gobuffer",
 			      array->type, array->index_type, array->nelems);
 		return -1;
 	}
 }
 
-int btf__add_member(struct btf *btf, uint32_t name, uint32_t type, bool kind_flag,
-		    uint32_t bitfield_size, uint32_t offset)
+int btf_elf__add_member(struct btf_elf *btfe, uint32_t name, uint32_t type, bool kind_flag,
+			uint32_t bitfield_size, uint32_t offset)
 {
 	struct btf_member member = {
 		.name_off   = name,
@@ -439,17 +436,17 @@ int btf__add_member(struct btf *btf, uint32_t name, uint32_t type, bool kind_fla
 		.offset = kind_flag ? (bitfield_size << 24 | offset) : offset,
 	};
 
-	if (gobuffer__add(&btf->types, &member, sizeof(member)) >= 0) {
-		btf_log_member(btf, &member, kind_flag, false, NULL);
+	if (gobuffer__add(&btfe->types, &member, sizeof(member)) >= 0) {
+		btf_log_member(btfe, &member, kind_flag, false, NULL);
 		return 0;
 	} else {
-		btf_log_member(btf, &member, kind_flag, true, "Error in adding gobuffer");
+		btf_log_member(btfe, &member, kind_flag, true, "Error in adding gobuffer");
 		return -1;
 	}
 }
 
-int32_t btf__add_struct(struct btf *btf, uint8_t kind, uint32_t name,
-			bool kind_flag, uint32_t size, uint16_t nr_members)
+int32_t btf_elf__add_struct(struct btf_elf *btfe, uint8_t kind, uint32_t name,
+			    bool kind_flag, uint32_t size, uint16_t nr_members)
 {
 	struct btf_type t;
 
@@ -457,21 +454,20 @@ int32_t btf__add_struct(struct btf *btf, uint8_t kind, uint32_t name,
 	t.info = BTF_INFO_ENCODE(kind, kind_flag, nr_members);
 	t.size = size;
 
-	++btf->type_index;
-	if (gobuffer__add(&btf->types, &t, sizeof(t)) >= 0) {
-		btf__log_type(btf, &t, false, true, "kind_flag=%d size=%u vlen=%u",
+	++btfe->type_index;
+	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >= 0) {
+		btf_elf__log_type(btfe, &t, false, true, "kind_flag=%d size=%u vlen=%u",
 			      kind_flag, t.size, BTF_INFO_VLEN(t.info));
-		return btf->type_index;
+		return btfe->type_index;
 	} else {
-		btf__log_type(btf, &t, true, true,
+		btf_elf__log_type(btfe, &t, true, true,
 			      "kind_flag=%d size=%u vlen=%u Error in adding gobuffer",
 			      kind_flag, t.size, BTF_INFO_VLEN(t.info));
 		return -1;
 	}
 }
 
-int32_t btf__add_enum(struct btf *btf, uint32_t name, uint32_t bit_size,
-		      uint16_t nr_entries)
+int32_t btf_elf__add_enum(struct btf_elf *btfe, uint32_t name, uint32_t bit_size, uint16_t nr_entries)
 {
 	struct btf_type t;
 
@@ -479,57 +475,55 @@ int32_t btf__add_enum(struct btf *btf, uint32_t name, uint32_t bit_size,
 	t.info = BTF_INFO_ENCODE(BTF_KIND_ENUM, 0, nr_entries);
 	t.size = BITS_ROUNDUP_BYTES(bit_size);
 
-	++btf->type_index;
-	if (gobuffer__add(&btf->types, &t, sizeof(t)) >= 0) {
-		btf__log_type(btf, &t, false, true, "size=%u vlen=%u",
-			      t.size, BTF_INFO_VLEN(t.info));
-		return btf->type_index;
+	++btfe->type_index;
+	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >= 0) {
+		btf_elf__log_type(btfe, &t, false, true, "size=%u vlen=%u", t.size, BTF_INFO_VLEN(t.info));
+		return btfe->type_index;
 	} else {
-		btf__log_type(btf, &t, true, true,
+		btf_elf__log_type(btfe, &t, true, true,
 			      "size=%u vlen=%u Error in adding gobuffer",
 			      t.size, BTF_INFO_VLEN(t.info));
 		return -1;
 	}
 }
 
-int btf__add_enum_val(struct btf *btf, uint32_t name, int32_t value)
+int btf_elf__add_enum_val(struct btf_elf *btfe, uint32_t name, int32_t value)
 {
 	struct btf_enum e = {
 		.name_off = name,
 		.val  = value,
 	};
 
-	if (gobuffer__add(&btf->types, &e, sizeof(e)) < 0) {
+	if (gobuffer__add(&btfe->types, &e, sizeof(e)) < 0) {
 		fprintf(stderr, "\t%s val=%d Error in adding gobuffer\n",
-			btf__name_in_gobuf(btf, e.name_off), e.val);
+			btf_elf__name_in_gobuf(btfe, e.name_off), e.val);
 		return -1;
-	} else if (btf_verbose)
-		printf("\t%s val=%d\n", btf__name_in_gobuf(btf, e.name_off),
+	} else if (btf_elf__verbose)
+		printf("\t%s val=%d\n", btf_elf__name_in_gobuf(btfe, e.name_off),
 		       e.val);
 
 	return 0;
 }
 
-static int32_t btf__add_func_proto_param(struct btf *btf, uint32_t name,
-					 uint32_t type, bool is_last_param)
+static int32_t btf_elf__add_func_proto_param(struct btf_elf *btfe, uint32_t name,
+					     uint32_t type, bool is_last_param)
 {
 	struct btf_param param;
 
 	param.name_off = name;
 	param.type = type;
 
-	if (gobuffer__add(&btf->types, &param, sizeof(param)) >= 0) {
-		btf_log_func_param(btf, name, type, false, is_last_param, NULL);
+	if (gobuffer__add(&btfe->types, &param, sizeof(param)) >= 0) {
+		btf_log_func_param(btfe, name, type, false, is_last_param, NULL);
 		return 0;
 	} else {
-		btf_log_func_param(btf, name, type, true, is_last_param,
+		btf_log_func_param(btfe, name, type, true, is_last_param,
 				   "Error in adding gobuffer");
 		return -1;
 	}
 }
 
-int32_t btf__add_func_proto(struct btf *btf, struct ftype *ftype,
-			    uint32_t type_id_off)
+int32_t btf_elf__add_func_proto(struct btf_elf *btfe, struct ftype *ftype, uint32_t type_id_off)
 {
 	uint16_t nr_params, param_idx;
 	struct parameter *param;
@@ -543,13 +537,13 @@ int32_t btf__add_func_proto(struct btf *btf, struct ftype *ftype,
 	t.info = BTF_INFO_ENCODE(BTF_KIND_FUNC_PROTO, 0, nr_params);
 	t.type = ftype->tag.type == 0 ? 0 : type_id_off + ftype->tag.type;
 
-	++btf->type_index;
-	if (gobuffer__add(&btf->types, &t, sizeof(t)) >= 0) {
-		btf__log_type(btf, &t, false, false, "return=%u args=(%s",
+	++btfe->type_index;
+	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >= 0) {
+		btf_elf__log_type(btfe, &t, false, false, "return=%u args=(%s",
 			      t.type, !nr_params ? "void)\n" : "");
-		type_id = btf->type_index;
+		type_id = btfe->type_index;
 	} else {
-		btf__log_type(btf, &t, true, true,
+		btf_elf__log_type(btfe, &t, true, true,
 			      "return=%u vlen=%u Error in adding gobuffer",
 			      t.type, BTF_INFO_VLEN(t.info));
 		return -1;
@@ -560,22 +554,19 @@ int32_t btf__add_func_proto(struct btf *btf, struct ftype *ftype,
 	ftype__for_each_parameter(ftype, param) {
 		uint32_t param_type_id = param->tag.type == 0 ? 0 : type_id_off + param->tag.type;
 		++param_idx;
-		if (btf__add_func_proto_param(btf, param->name,
-					      param_type_id,
-					      param_idx == nr_params))
+		if (btf_elf__add_func_proto_param(btfe, param->name, param_type_id, param_idx == nr_params))
 			return -1;
 	}
 
 	++param_idx;
 	if (ftype->unspec_parms)
-		if (btf__add_func_proto_param(btf, 0, 0,
-					      param_idx == nr_params))
+		if (btf_elf__add_func_proto_param(btfe, 0, 0, param_idx == nr_params))
 			return -1;
 
 	return type_id;
 }
 
-static int btf__write_elf(struct btf *btf)
+static int btf_elf__write(struct btf_elf *btfe)
 {
 	GElf_Shdr shdr_mem, *shdr;
 	GElf_Ehdr ehdr_mem, *ehdr;
@@ -585,9 +576,9 @@ static int btf__write_elf(struct btf *btf)
 	int fd, err = -1;
 	size_t strndx;
 
-	fd = open(btf->filename, O_RDWR);
+	fd = open(btfe->filename, O_RDWR);
 	if (fd < 0) {
-		fprintf(stderr, "Cannot open %s\n", btf->filename);
+		fprintf(stderr, "Cannot open %s\n", btfe->filename);
 		return -1;
 	}
 
@@ -628,8 +619,8 @@ static int btf__write_elf(struct btf *btf)
 
 	if (btf_elf) {
 		/* Exisiting .BTF section found */
-		btf_elf->d_buf = btf->data;
-		btf_elf->d_size = btf->size;
+		btf_elf->d_buf = btfe->data;
+		btf_elf->d_size = btfe->size;
 		elf_flagdata(btf_elf, ELF_C_SET, ELF_F_DIRTY);
 
 		if (elf_update(elf, ELF_C_NULL) >= 0 &&
@@ -645,7 +636,7 @@ static int btf__write_elf(struct btf *btf)
 			llvm_objcopy = "llvm-objcopy";
 
 		/* Use objcopy to add a .BTF section */
-		snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", btf->filename);
+		snprintf(tmp_fn, sizeof(tmp_fn), "%s.btfe", btfe->filename);
 		close(fd);
 		fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
 		if (fd == -1) {
@@ -655,9 +646,9 @@ static int btf__write_elf(struct btf *btf)
 		}
 
 		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
-			 llvm_objcopy, tmp_fn, btf->filename);
+			 llvm_objcopy, tmp_fn, btfe->filename);
 
-		if (write(fd, btf->data, btf->size) == btf->size &&
+		if (write(fd, btfe->data, btfe->size) == btfe->size &&
 		    !system(cmd))
 			err = 0;
 
@@ -672,39 +663,37 @@ out:
 	return err;
 }
 
-int btf__encode(struct btf *btf, uint8_t flags)
+int btf_elf__encode(struct btf_elf *btfe, uint8_t flags)
 {
 	struct btf_header *hdr;
 
 	/* Empty file, nothing to do, so... done! */
-	if (gobuffer__size(&btf->types) == 0)
+	if (gobuffer__size(&btfe->types) == 0)
 		return 0;
 
-	btf->size = sizeof(*hdr) +
-		(gobuffer__size(&btf->types) +
-		 gobuffer__size(btf->strings));
-	btf->data = zalloc(btf->size);
+	btfe->size = sizeof(*hdr) + (gobuffer__size(&btfe->types) + gobuffer__size(btfe->strings));
+	btfe->data = zalloc(btfe->size);
 
-	if (btf->data == NULL) {
+	if (btfe->data == NULL) {
 		fprintf(stderr, "%s: malloc failed!\n", __func__);
 		return -1;
 	}
 
-	hdr = btf->hdr;
+	hdr = btfe->hdr;
 	hdr->magic = BTF_MAGIC;
 	hdr->version = 1;
 	hdr->flags = flags;
 	hdr->hdr_len = sizeof(*hdr);
 
 	hdr->type_off = 0;
-	hdr->type_len = gobuffer__size(&btf->types);
+	hdr->type_len = gobuffer__size(&btfe->types);
 	hdr->str_off  = hdr->type_len;
-	hdr->str_len  = gobuffer__size(btf->strings);
+	hdr->str_len  = gobuffer__size(btfe->strings);
 
-	gobuffer__copy(&btf->types, btf__nohdr_data(btf) + hdr->type_off);
-	gobuffer__copy(btf->strings, btf__nohdr_data(btf) + hdr->str_off);
+	gobuffer__copy(&btfe->types, btf_elf__nohdr_data(btfe) + hdr->type_off);
+	gobuffer__copy(btfe->strings, btf_elf__nohdr_data(btfe) + hdr->str_off);
 
-	*(char *)(btf__nohdr_data(btf) + hdr->str_off) = '\0';
+	*(char *)(btf_elf__nohdr_data(btfe) + hdr->str_off) = '\0';
 
-	return btf__write_elf(btf);
+	return btf_elf__write(btfe);
 }
diff --git a/libbtf.h b/libbtf.h
index 780f3ec888d7..3388a6fb30fd 100644
--- a/libbtf.h
+++ b/libbtf.h
@@ -12,7 +12,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 
-struct btf {
+struct btf_elf {
 	union {
 		struct btf_header *hdr;
 		void		  *data;
@@ -31,39 +31,39 @@ struct btf {
 	uint32_t	  type_index;
 };
 
-extern uint8_t btf_verbose;
-#define btf_verbose_log(fmt, ...) { if (btf_verbose) printf(fmt, __VA_ARGS__); }
+extern uint8_t btf_elf__verbose;
+#define btf_elf__verbose_log(fmt, ...) { if (btf_elf__verbose) printf(fmt, __VA_ARGS__); }
 
 struct base_type;
 struct ftype;
 
-struct btf *btf__new(const char *filename, Elf *elf);
-void btf__free(struct btf *btf);
+struct btf_elf *btf_elf__new(const char *filename, Elf *elf);
+void btf_elf__free(struct btf_elf *btf);
 
-int32_t btf__add_base_type(struct btf *btf, const struct base_type *bt);
-int32_t btf__add_ref_type(struct btf *btf, uint16_t kind, uint32_t type,
-			  uint32_t name, bool kind_flag);
-int btf__add_member(struct btf *btf, uint32_t name, uint32_t type, bool kind_flag,
-		    uint32_t bitfield_size, uint32_t bit_offset);
-int32_t btf__add_struct(struct btf *btf, uint8_t kind, uint32_t name,
-			bool kind_flag, uint32_t size, uint16_t nr_members);
-int32_t btf__add_array(struct btf *btf, uint32_t type, uint32_t index_type,
-		       uint32_t nelems);
-int32_t btf__add_enum(struct btf *btf, uint32_t name, uint32_t size,
-		      uint16_t nr_entries);
-int btf__add_enum_val(struct btf *btf, uint32_t name, int32_t value);
-int32_t btf__add_func_proto(struct btf *btf, struct ftype *ftype,
-			    uint32_t type_id_off);
-void btf__set_strings(struct btf *btf, struct gobuffer *strings);
-int  btf__encode(struct btf *btf, uint8_t flags);
+int32_t btf_elf__add_base_type(struct btf_elf *btf, const struct base_type *bt);
+int32_t btf_elf__add_ref_type(struct btf_elf *btf, uint16_t kind, uint32_t type,
+			      uint32_t name, bool kind_flag);
+int btf_elf__add_member(struct btf_elf *btf, uint32_t name, uint32_t type, bool kind_flag,
+			uint32_t bitfield_size, uint32_t bit_offset);
+int32_t btf_elf__add_struct(struct btf_elf *btf, uint8_t kind, uint32_t name,
+			    bool kind_flag, uint32_t size, uint16_t nr_members);
+int32_t btf_elf__add_array(struct btf_elf *btf, uint32_t type, uint32_t index_type,
+			   uint32_t nelems);
+int32_t btf_elf__add_enum(struct btf_elf *btf, uint32_t name, uint32_t size,
+			  uint16_t nr_entries);
+int btf_elf__add_enum_val(struct btf_elf *btf, uint32_t name, int32_t value);
+int32_t btf_elf__add_func_proto(struct btf_elf *btf, struct ftype *ftype,
+				uint32_t type_id_off);
+void btf_elf__set_strings(struct btf_elf *btf, struct gobuffer *strings);
+int  btf_elf__encode(struct btf_elf *btf, uint8_t flags);
 
-char *btf__string(struct btf *btf, uint32_t ref);
-int btf__load(struct btf *btf);
+char *btf_elf__string(struct btf_elf *btf, uint32_t ref);
+int btf_elf__load(struct btf_elf *btf);
 
-uint32_t btf__get32(struct btf *btf, uint32_t *p);
+uint32_t btf_elf__get32(struct btf_elf *btf, uint32_t *p);
 
-void *btf__get_buffer(struct btf *btf);
+void *btf_elf__get_buffer(struct btf_elf *btf);
 
-size_t btf__get_size(struct btf *btf);
+size_t btf_elf__get_size(struct btf_elf *btf);
 
 #endif /* _LIBBTF_H */
