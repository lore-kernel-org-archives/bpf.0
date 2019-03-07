Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D390CC43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 00:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8749B20675
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 00:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eOmvV9d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfCGAXa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:23:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58094 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbfCGAXa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Mar 2019 19:23:30 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x270KKqD027229
        for <bpf@vger.kernel.org>; Wed, 6 Mar 2019 16:23:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=0+uL3OYXrfJTLZMg9s1VFuz716TdzXcdo6nPD6Gw0Mo=;
 b=eOmvV9d0BZupMV7Owh+oCupWsBbZk9lq+vHAzq8mhtDIvQko162RlEwQxcCMColoKb+W
 BAb0z0v8pDXrT2UCB2ROwhWSQGfsDtt/KbOsMokFTuTxdqNkDOTrrU8gruIaGm9Dp71O
 LHje47dnOBXaKsm6lm/Se9Nx4ROWDd9J6qM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r2ptc8cxn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2019 16:23:28 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 6 Mar 2019 16:23:26 -0800
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id F10C1861291; Wed,  6 Mar 2019 16:23:23 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <acme@kernel.org>, <arnaldo.melo@gmail.com>,
        <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole] pahole: use 32-bit integers for iterations within CU
Date:   Wed, 6 Mar 2019 16:23:21 -0800
Message-ID: <20190307002321.4071708-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Existing code base assumes that single CU doesn't have more than 65535 types
per each CU, which might be a reasonable assumption for DWARF data. With BTF,
though, all we get is single, potentially huge, CU which can easily have more
than 65k types. For example, this is the case for allyesconfig version of
Linux kernel, which has >200k types.

Due to this assumption, libdwarves and other parts of pahole are using 16-bit
counters to iterate over entities within CU. This can cause infinite loop when
iterating BTF data, if there are more than 65535 types. This patch changes
non-public variables to use 32-bit integers, where appropriate.

This still leads to invalid reported data when using BTF loader (due to using
(X & 0xFFFF) type ID, instead of X, when X > 65535) and loading huge files,
but at least it's not stuck in an infinite loop anymore.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 btf_loader.c      |  4 ++--
 dwarves.c         | 16 ++++++++--------
 dwarves_fprintf.c |  8 ++++----
 pahole.c          | 36 ++++++++++++++++++------------------
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 867c608..3de774a 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -45,7 +45,7 @@ static void *tag__alloc(const size_t size)
 	return tag;
 }
 
-static int btf_elf__load_ftype(struct btf_elf *btfe, struct ftype *proto, uint16_t tag,
+static int btf_elf__load_ftype(struct btf_elf *btfe, struct ftype *proto, uint32_t tag,
 			       uint32_t type, uint16_t vlen, struct btf_param *args, long id)
 {
 	int i;
@@ -100,7 +100,7 @@ static struct base_type *base_type__new(strings_t name, uint32_t attrs,
 	return bt;
 }
 
-static void type__init(struct type *type, uint16_t tag,
+static void type__init(struct type *type, uint32_t tag,
 		       strings_t name, size_t size)
 {
 	INIT_LIST_HEAD(&type->node);
diff --git a/dwarves.c b/dwarves.c
index 111797b..3594ae3 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -349,7 +349,7 @@ reevaluate:
 
 static void cu__find_class_holes(struct cu *cu)
 {
-	uint16_t id;
+	uint32_t id;
 	struct class *pos;
 
 	cu__for_each_struct(cu, id, pos)
@@ -566,7 +566,7 @@ struct tag *cu__type(const struct cu *cu, const uint16_t id)
 struct tag *cu__find_first_typedef_of_type(const struct cu *cu,
 					   const uint16_t type)
 {
-	uint16_t id;
+	uint32_t id;
 	struct tag *pos;
 
 	if (cu == NULL || type == 0)
@@ -582,7 +582,7 @@ struct tag *cu__find_first_typedef_of_type(const struct cu *cu,
 struct tag *cu__find_base_type_by_name(const struct cu *cu,
 				       const char *name, uint16_t *idp)
 {
-	uint16_t id;
+	uint32_t id;
 	struct tag *pos;
 
 	if (cu == NULL || name == NULL)
@@ -611,7 +611,7 @@ struct tag *cu__find_base_type_by_sname_and_size(const struct cu *cu,
 						 uint16_t bit_size,
 						 uint16_t *idp)
 {
-	uint16_t id;
+	uint32_t id;
 	struct tag *pos;
 
 	if (sname == 0)
@@ -638,7 +638,7 @@ struct tag *cu__find_enumeration_by_sname_and_size(const struct cu *cu,
 						   uint16_t bit_size,
 						   uint16_t *idp)
 {
-	uint16_t id;
+	uint32_t id;
 	struct tag *pos;
 
 	if (sname == 0)
@@ -663,7 +663,7 @@ struct tag *cu__find_enumeration_by_sname_and_size(const struct cu *cu,
 struct tag *cu__find_struct_by_sname(const struct cu *cu, strings_t sname,
 				     const int include_decls, uint16_t *idp)
 {
-	uint16_t id;
+	uint32_t id;
 	struct tag *pos;
 
 	if (sname == 0)
@@ -699,7 +699,7 @@ static struct tag *__cu__find_struct_by_name(const struct cu *cu, const char *na
 	if (cu == NULL || name == NULL)
 		return NULL;
 
-	uint16_t id;
+	uint32_t id;
 	struct tag *pos;
 	cu__for_each_type(cu, id, pos) {
 		struct type *type;
@@ -1128,7 +1128,7 @@ void lexblock__add_label(struct lexblock *block, struct label *label)
 }
 
 const struct class_member *class__find_bit_hole(const struct class *class,
-					    const struct class_member *trailer,
+						const struct class_member *trailer,
 						const uint16_t bit_hole_size)
 {
 	struct class_member *pos;
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 490dc30..530c27b 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -163,7 +163,7 @@ static const char *tag__accessibility(const struct tag *tag)
 	return NULL;
 }
 
-static size_t __tag__id_not_found_snprintf(char *bf, size_t len, uint16_t id,
+static size_t __tag__id_not_found_snprintf(char *bf, size_t len, uint32_t id,
 					   const char *fn, int line)
 {
 	return snprintf(bf, len, "<ERROR(%s:%d): %#llx not found!>", fn, line,
@@ -425,7 +425,7 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
 		return tag__ptr_name(tag, cu, bf, len, "&");
 	case DW_TAG_ptr_to_member_type: {
 		char suffix[512];
-		uint16_t id = tag__ptr_to_member_type(tag)->containing_type;
+		uint32_t id = tag__ptr_to_member_type(tag)->containing_type;
 
 		type = cu__type(cu, id);
 		if (type != NULL)
@@ -1213,7 +1213,7 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
 	struct type *type = &class->type;
 	size_t last_size = 0, size;
 	uint8_t newline = 0;
-	uint16_t nr_paddings = 0;
+	uint32_t nr_paddings = 0;
 	uint32_t sum = 0;
 	uint32_t sum_holes = 0;
 	uint32_t sum_paddings = 0;
@@ -1225,7 +1225,7 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
 	struct tag *tag_pos;
 	const char *current_accessibility = NULL;
 	struct conf_fprintf cconf = conf ? *conf : conf_fprintf__defaults;
-	const uint16_t t = type->namespace.tag.tag;
+	const uint32_t t = type->namespace.tag.tag;
 	size_t printed = fprintf(fp, "%s%s%s%s%s",
 				 cconf.prefix ?: "", cconf.prefix ? " " : "",
 				 ((cconf.classes_as_structs ||
diff --git a/pahole.c b/pahole.c
index 2230e37..bec279c 100644
--- a/pahole.c
+++ b/pahole.c
@@ -41,9 +41,9 @@ static size_t cu__exclude_prefix_len;
 static char *decl_exclude_prefix;
 static size_t decl_exclude_prefix_len;
 
-static uint16_t nr_holes;
-static uint16_t nr_bit_holes;
-static uint16_t hole_size_ge;
+static uint32_t nr_holes;
+static uint32_t nr_bit_holes;
+static uint32_t hole_size_ge;
 static uint8_t show_packable;
 static uint8_t global_verbose;
 static uint8_t recursive;
@@ -156,7 +156,7 @@ static void nr_definitions_formatter(struct structure *st)
 }
 
 static void nr_members_formatter(struct class *class,
-				 struct cu *cu, uint16_t id __unused)
+				 struct cu *cu, uint32_t id __unused)
 {
 	printf("%s%c%u\n", class__name(class, cu), separator,
 	       class__nr_members(class));
@@ -168,26 +168,26 @@ static void nr_methods_formatter(struct structure *st)
 }
 
 static void size_formatter(struct class *class,
-			   struct cu *cu, uint16_t id __unused)
+			   struct cu *cu, uint32_t id __unused)
 {
 	printf("%s%c%d%c%u\n", class__name(class, cu), separator,
 	       class__size(class), separator, class->nr_holes);
 }
 
 static void class_name_len_formatter(struct class *class, struct cu *cu,
-				     uint16_t id __unused)
+				     uint32_t id __unused)
 {
 	const char *name = class__name(class, cu);
 	printf("%s%c%zd\n", name, separator, strlen(name));
 }
 
 static void class_name_formatter(struct class *class,
-				 struct cu *cu, uint16_t id __unused)
+				 struct cu *cu, uint32_t id __unused)
 {
 	puts(class__name(class, cu));
 }
 
-static void class_formatter(struct class *class, struct cu *cu, uint16_t id)
+static void class_formatter(struct class *class, struct cu *cu, uint32_t id)
 {
 	struct tag *typedef_alias = NULL;
 	struct tag *tag = class__tag(class);
@@ -224,7 +224,7 @@ static void class_formatter(struct class *class, struct cu *cu, uint16_t id)
 	putchar('\n');
 }
 
-static void print_packable_info(struct class *c, struct cu *cu, uint16_t id)
+static void print_packable_info(struct class *c, struct cu *cu, uint32_t id)
 {
 	const struct tag *t = class__tag(c);
 	const size_t orig_size = class__size(c);
@@ -267,14 +267,14 @@ static void print_stats(void)
 }
 
 static struct class *class__filter(struct class *class, struct cu *cu,
-				   uint16_t tag_id);
+				   uint32_t tag_id);
 
 static void (*formatter)(struct class *class,
-			 struct cu *cu, uint16_t id) = class_formatter;
+			 struct cu *cu, uint32_t id) = class_formatter;
 
 static void print_classes(struct cu *cu)
 {
-	uint16_t id;
+	uint32_t id;
 	struct class *pos;
 
 	cu__for_each_struct_or_union(cu, id, pos) {
@@ -352,7 +352,7 @@ static int class__packable(struct class *class, struct cu *cu)
 }
 
 static struct class *class__filter(struct class *class, struct cu *cu,
-				   uint16_t tag_id)
+				   uint32_t tag_id)
 {
 	struct tag *tag = class__tag(class);
 	const char *name;
@@ -608,7 +608,7 @@ static void cu_fixup_word_size_iterator(struct cu *cu)
 	original_word_size = cu->addr_size;
 	cu->addr_size = word_size;
 
-	uint16_t id;
+	uint32_t id;
 	struct tag *pos;
 	cu__for_each_type(cu, id, pos)
 		tag__fixup_word_size(pos, cu);
@@ -659,11 +659,11 @@ static void cu__account_nr_methods(struct cu *cu)
 
 static char tab[128];
 
-static void print_structs_with_pointer_to(const struct cu *cu, uint16_t type)
+static void print_structs_with_pointer_to(const struct cu *cu, uint32_t type)
 {
 	struct class *pos;
 	struct class_member *pos_member;
-	uint16_t id;
+	uint32_t id;
 
 	cu__for_each_struct(cu, id, pos) {
 		bool looked = false;
@@ -702,10 +702,10 @@ static void print_structs_with_pointer_to(const struct cu *cu, uint16_t type)
 	}
 }
 
-static void print_containers(const struct cu *cu, uint16_t type, int ident)
+static void print_containers(const struct cu *cu, uint32_t type, int ident)
 {
 	struct class *pos;
-	uint16_t id;
+	uint32_t id;
 
 	cu__for_each_struct(cu, id, pos) {
 		if (pos->type.namespace.name == 0)
-- 
2.17.1

