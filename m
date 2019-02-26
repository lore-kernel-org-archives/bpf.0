Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0511EC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 00:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D13218AC
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 00:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GC6ljaWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfBZAIc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:08:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54710 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729170AbfBZAIc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Feb 2019 19:08:32 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q04Z0x022229
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 16:08:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=dlYbISBq8yOBrZ0MjOWSH4Ul5whZNLP1pigYuJu6FmA=;
 b=GC6ljaWvS3YuP99XWSNlXI1binAORwchRsOr8ULOGsBMRs8/Qb3Gpfbg2KO9YMy7CyVH
 9O+pZ5YmJ19ENWiBgr7OSpiSmH1qo1NA5NlmbiWIqHqK0KlKAPTJk81iWnJGNkaM+U2U
 ZaVHO7wLX07gdLM/o7xm3VV6DJ3KCGUVtks= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvs1y8as9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 16:08:31 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 25 Feb 2019 16:08:29 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id F2FC9BBAF822; Mon, 25 Feb 2019 16:08:22 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <acme@kernel.org>, <yhs@fb.com>, <ast@fb.com>,
        <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>,
        <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole 1/2] btf_loader: simplify fixup code by relying on BTF data more
Date:   Mon, 25 Feb 2019 16:08:14 -0800
Message-ID: <20190226000815.385229-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226000815.385229-1-andriin@fb.com>
References: <20190226000815.385229-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_loader relies on guessing base integral type size for enums and
integers, which is unreliable. There doesn't seem to be a need for
that, as all this information could be extracted from BTF information.

Before:
$ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/libc-2.28.so.debug
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
--- /tmp/btfdiff.dwarf.aV4wSL   2019-02-25 13:31:54.787923673 -0800
+++ /tmp/btfdiff.btf.22NQmJ     2019-02-25 13:31:54.802923668 -0800
@@ -461,9 +461,15 @@ struct La_x86_64_retval {
        uint64_t                   lrv_rdx;              /*     8     8 */
        La_x86_64_xmm              lrv_xmm0;             /*    16    16 */
        La_x86_64_xmm              lrv_xmm1;             /*    32    16 */
-       long double                lrv_st0;              /*    48    16 */
+       long double                lrv_st0;              /*    48     8 */
+
+       /* XXX 8 bytes hole, try to pack */
+
        /* --- cacheline 1 boundary (64 bytes) --- */
-       long double                lrv_st1;              /*    64    16 */
+       long double                lrv_st1;              /*    64     8 */
+
+       /* XXX 8 bytes hole, try to pack */
+
        La_x86_64_vector           lrv_vector0;          /*    80    64 */
        /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
        La_x86_64_vector           lrv_vector1;          /*   144    64 */
@@ -472,6 +478,7 @@ struct La_x86_64_retval {
        __int128                   lrv_bnd1;             /*   224    16 */

        /* size: 240, cachelines: 4, members: 10 */
+       /* sum members: 224, holes: 2, sum holes: 16 */
        /* last cacheline: 48 bytes */
 };
 struct r_debug {
@@ -2044,7 +2051,7 @@ union ieee754_float {
        } ieee_nan;                                    /*     0     4 */
 };
 union ieee854_long_double {
-       long double                d;                  /*     0    16 */
+       long double                d;                  /*     0     8 */
        struct {
                unsigned int       mantissa1:32;       /*     0: 0  4 */
                unsigned int       mantissa0:32;       /*     4: 0  4 */
@@ -2141,7 +2148,7 @@ struct ucontext_t {
        /* last cacheline: 8 bytes */
 };
 union ieee854_float128 {
-       _Float128                  d;                  /*     0    16 */
+       _Float128                  d;                  /*     0     0 */
        struct {
                unsigned int       mantissa3:32;       /*     0: 0  4 */
                unsigned int       mantissa2:32;       /*     4: 0  4 */
@@ -2219,7 +2226,7 @@ union printf_arg {
        long unsigned int          pa_u_long_int;      /*     0     8 */
        long long unsigned int     pa_u_long_long_int; /*     0     8 */
        double                     pa_double;          /*     0     8 */
-       long double                pa_long_double;     /*     0    16 */
+       long double                pa_long_double;     /*     0     8 */
        const char  *              pa_string;          /*     0     8 */
        const wchar_t  *           pa_wstring;         /*     0     8 */
        void *                     pa_pointer;         /*     0     8 */

$ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/libc-2.28.so.debug
<empty output>

Still good for kernel image:
$ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/vmlinux4
<empty output>

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 btf_loader.c | 59 ++++++++++------------------------------------------
 1 file changed, 11 insertions(+), 48 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 62e7e30..3b4fb40 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -463,64 +463,27 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu, struct btf
 			continue;
 
 		pos->bitfield_offset = 0;
+		pos->byte_size = tag__size(type, cu);
+		pos->bit_size = pos->byte_size * 8;
 
-		uint16_t type_bit_size;
-		size_t integral_bit_size;
-
-		switch (type->tag) {
-		case DW_TAG_enumeration_type:
-			type_bit_size = tag__type(type)->size;
-			/* Best we can do to check if this is a packed enum */
-			if (is_power_of_2(type_bit_size))
-				integral_bit_size = roundup(type_bit_size, 8);
-			else
-				integral_bit_size = sizeof(int) * 8;
-			break;
-		case DW_TAG_base_type: {
-			struct base_type *bt = tag__base_type(type);
-			char name[256];
-			type_bit_size = bt->bit_size;
-			integral_bit_size = base_type__name_to_size(bt, cu);
-			if (integral_bit_size == 0) {
-				fprintf(stderr, "%s: unknown base type name \"%s\"!\n",
-					__func__, base_type__name(bt, cu, name,
-								  sizeof(name)));
-			}
-		}
-			break;
-		default:
-			pos->byte_size = tag__size(type, cu);
-			pos->bit_size = pos->byte_size * 8;
+		/* bitfield fixup is needed for enums and base types only */
+		if (type->tag != DW_TAG_base_type && type->tag != DW_TAG_enumeration_type)
 			continue;
-		}
 
-		/*
-		 * XXX: integral_bit_size can be zero if base_type__name_to_size doesn't
-		 * know about the base_type name, so one has to add there when
-		 * such base_type isn't found. pahole will put zero on the
-		 * struct output so it should be easy to spot the name when
-		 * such unlikely thing happens.
-		 */
-		pos->byte_size = integral_bit_size / 8;
-		pos->bit_size = type_bit_size;
-
-		if (integral_bit_size == 0) {
-			pos->bit_size = 0;
+		/* if BTF data is incorrect and has size == 0, skip field, 
+		 * instead of crashing */
+		if (pos->byte_size == 0) {
 			continue;
 		}
 
 		if (pos->bitfield_size) {
 			/* bitfields seem to be always aligned, no matter the packing */
-			pos->byte_offset = pos->bit_offset / integral_bit_size * integral_bit_size / 8;
-		} else {
-			pos->byte_offset = pos->bit_offset / 8;
-		}
-
-
-		if (pos->bitfield_size) {
+			pos->byte_offset = pos->bit_offset / pos->bit_size * pos->bit_size / 8;
 			pos->bitfield_offset = pos->bit_offset - pos->byte_offset * 8;
 			if (!btfe->is_big_endian)
-				pos->bitfield_offset = integral_bit_size - pos->bitfield_offset - pos->bitfield_size;
+				pos->bitfield_offset = pos->bit_size - pos->bitfield_offset - pos->bitfield_size;
+		} else {
+			pos->byte_offset = pos->bit_offset / 8;
 		}
 	}
 
-- 
2.17.1

