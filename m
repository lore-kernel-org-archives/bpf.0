Return-Path: <SRS0=IWuG=RQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA6CC43381
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 16:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C8C2147C
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 16:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oev04SPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfCMQ4E (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:56:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40336 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726842AbfCMQ4E (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Mar 2019 12:56:04 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2DGpmE7001162
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2019 09:56:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=VSuo33gBRTIxlGzZk+wVbL1azBeTWddhNZAkkUdw7rw=;
 b=oev04SPnlXJPeNnB6vzbPwFdU+hbbD2YlybLzTXXJsyO7uufnkiJWu3Ni3ADF9bDteBE
 ontPvstxfVoPb2s21FNfKFstRXSDgO3+jdQzhgLRehhCd2elAF3cpd/XzSku2D/Vy6wc
 R/ytwmEqLhTSR4YtazGIJj86S4dekEbYoa0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2r75nc81sc-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2019 09:56:02 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 13 Mar 2019 09:53:31 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 0CE408613C1; Wed, 13 Mar 2019 09:53:31 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <dwarves@vger.kernel.org>,
        <bpf@vger.kernel.org>, <acme@kernel.org>, <ast@fb.com>,
        <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole] loaders: strip away volatile/const/restrict when fixing bitfields
Date:   Wed, 13 Mar 2019 09:53:01 -0700
Message-ID: <20190313165301.2739423-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_loader and ctf_loader didn't remove const/volatile/restrict, so
bitfields using modifiers were not adjusted properly.

This patch abstracts logic of stripping aways typedefs and access
modifiers into tag__strip_typedefs_and_modifiers, which handles any
interleaving of typedefs and modifiers. dwarf_loader was adapter to
reuse this function as well, instead of custom goto loop.

REPRO:
$ cat vc_map.c
typedef unsigned int u32;
typedef volatile u32 vu32;
typedef vu32 vu32_t;

typedef struct vc_map {
        volatile unsigned int tx: 1;
        vu32_t rx: 1;
        void *x1, *x2;
} vc_map;

int main() {
        struct vc_map s;
        return 0;
}

BEFORE:
$ ~/pahole/build/pahole -F btf vc_map
struct vc_map {
        volatile unsigned int      tx:1;                 /*     0: 0  4 */
        vu32_t                     rx:1;                 /*     0: 0  4 */

        /* XXX 30 bits hole, try to pack */
        /* XXX 4 bytes hole, try to pack */

        void *                     x1;                   /*     8     8 */
        void *                     x2;                   /*    16     8 */

        /* size: 24, cachelines: 1, members: 4 */
        /* sum members: 20, holes: 1, sum holes: 4 */
        /* bit holes: 1, sum bit holes: 30 bits */
        /* last cacheline: 24 bytes */
};

AFTER:
$ ~/pahole/build/pahole -F btf vc_map
struct vc_map {
        volatile unsigned int      tx:1;                 /*     0:31  4 */
        vu32_t                     rx:1;                 /*     0:30  4 */

        /* XXX 30 bits hole, try to pack */
        /* XXX 4 bytes hole, try to pack */

        void *                     x1;                   /*     8     8 */
        void *                     x2;                   /*    16     8 */

        /* size: 24, cachelines: 1, members: 4 */
        /* sum members: 20, holes: 1, sum holes: 4 */
        /* bit holes: 1, sum bit holes: 30 bits */
        /* last cacheline: 24 bytes */
};

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 btf_loader.c   |  2 +-
 ctf_loader.c   |  2 +-
 dwarf_loader.c |  7 +------
 dwarves.c      | 10 ++++++++++
 dwarves.h      | 13 +++++++++++++
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 9a0714a..e04175e 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -457,7 +457,7 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu, struct btf
 	struct type *tag_type = tag__type(tag);
 
 	type__for_each_data_member(tag_type, pos) {
-		struct tag *type = tag__follow_typedef(&pos->tag, cu);
+		struct tag *type = tag__strip_typedefs_and_modifiers(&pos->tag, cu);
 
 		if (type == NULL) /* FIXME: C++ BTF... */
 			continue;
diff --git a/ctf_loader.c b/ctf_loader.c
index 1631ea7..68479e2 100644
--- a/ctf_loader.c
+++ b/ctf_loader.c
@@ -613,7 +613,7 @@ static int class__fixup_ctf_bitfields(struct tag *tag, struct cu *cu)
 	struct type *tag_type = tag__type(tag);
 
 	type__for_each_data_member(tag_type, pos) {
-		struct tag *type = tag__follow_typedef(&pos->tag, cu);
+		struct tag *type = tag__strip_typedefs_and_modifiers(&pos->tag, cu);
 
 		if (type == NULL) /* FIXME: C++ CTF... */
 			continue;
diff --git a/dwarf_loader.c b/dwarf_loader.c
index c2abdad..28d1393 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2123,12 +2123,7 @@ static int class_member__cache_byte_size(struct tag *tag, struct cu *cu,
 	}
 
 	if (member->bitfield_size != 0) {
-		struct tag *type = tag__follow_typedef(&member->tag, cu);
-check_volatile:
-		if (tag__is_volatile(type) || tag__is_const(type)) {
-			type = tag__follow_typedef(type, cu);
-			goto check_volatile;
-		}
+		struct tag *type = tag__strip_typedefs_and_modifiers(&member->tag, cu);
 
 		uint16_t type_bit_size;
 		size_t integral_bit_size;
diff --git a/dwarves.c b/dwarves.c
index 4c6a12c..0b95d37 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -128,6 +128,16 @@ struct tag *tag__follow_typedef(const struct tag *tag, const struct cu *cu)
 	return type;
 }
 
+struct tag *tag__strip_typedefs_and_modifiers(const struct tag *tag, const struct cu *cu)
+{
+	struct tag *type = cu__type(cu, tag->type);
+
+	while (type != NULL && (tag__is_typedef(type) || tag__is_modifier(type)))
+		type = cu__type(cu, type->type);
+
+	return type;
+}
+
 size_t __tag__id_not_found_fprintf(FILE *fp, type_id_t id,
 				   const char *fn, int line)
 {
diff --git a/dwarves.h b/dwarves.h
index 67ec014..f65dbe2 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -411,6 +411,18 @@ static inline bool tag__is_volatile(const struct tag *tag)
 	return tag->tag == DW_TAG_volatile_type;
 }
 
+static inline bool tag__is_restrict(const struct tag *tag)
+{
+	return tag->tag == DW_TAG_restrict_type;
+}
+
+static inline int tag__is_modifier(const struct tag *tag)
+{
+	return tag__is_const(tag) ||
+	       tag__is_volatile(tag) ||
+	       tag__is_restrict(tag);
+}
+
 static inline bool tag__has_namespace(const struct tag *tag)
 {
 	return tag__is_struct(tag) ||
@@ -498,6 +510,7 @@ void tag__not_found_die(const char *file, int line, const char *func);
 size_t tag__size(const struct tag *tag, const struct cu *cu);
 size_t tag__nr_cachelines(const struct tag *tag, const struct cu *cu);
 struct tag *tag__follow_typedef(const struct tag *tag, const struct cu *cu);
+struct tag *tag__strip_typedefs_and_modifiers(const struct tag *tag, const struct cu *cu);
 
 size_t __tag__id_not_found_fprintf(FILE *fp, type_id_t id,
 				   const char *fn, int line);
-- 
2.17.1

