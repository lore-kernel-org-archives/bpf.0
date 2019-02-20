Return-Path: <SRS0=w44S=Q3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB62C10F07
	for <bpf@archiver.kernel.org>; Wed, 20 Feb 2019 20:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A32214AF
	for <bpf@archiver.kernel.org>; Wed, 20 Feb 2019 20:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="C4dUvd2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfBTU6C (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:58:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38722 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726070AbfBTU6C (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Feb 2019 15:58:02 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1KKrqkg018243
        for <bpf@vger.kernel.org>; Wed, 20 Feb 2019 12:58:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=b6VxCNd+0osj9YRCdhS0k/VYv5byL7r6SyXMZ/lBUFY=;
 b=C4dUvd2oP0Cz4WAQO3dQiLcZuLzX2qF6S18hgu3kIjmSWUZy0kGwdH3v+JX44qtMoEKX
 Q6rYv6HZ5z2VE9Pdxb2wVeKfmaIl96tJLbDp3AsTmopVQRfnNwm2mT+DlUVOvKpS+tIu
 1ElZ8hzf2KbG2iDxuQd15L7ZHr7eesQsezE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2qsax5rqp6-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Feb 2019 12:58:00 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 20 Feb 2019 12:57:34 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 3340BB3AA4BD; Wed, 20 Feb 2019 12:57:34 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <acme@kernel.org>,
        <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>, <ast@fb.com>,
        <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole 2/3] pahole: complete list of base type names
Date:   Wed, 20 Feb 2019 12:57:31 -0800
Message-ID: <20190220205732.2514975-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220205732.2514975-1-andriin@fb.com>
References: <20190220205732.2514975-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Clang seems to generate base type with name "short", instead of "short
in", but it also isn't inconceivable to imagine other compilers
generating just "long" and/or "long long". This patch adds all those
short forms to a list of base type names.

$ cat type_test.c
struct s {
    short x1;
    long x2;
    long long x3;
};

int main() {
    struct s s;
    return 0;
}

$ clang -g type_test.c -o type_test && ~/local/pahole/build/pahole -JV type_test
File type_test:
[1] INT int size=4 bit_offset=0 nr_bits=32 encoding=SIGNED
[2] STRUCT s kind_flag=0 size=24 vlen=3
        x1 type_id=3 bits_offset=0
        x2 type_id=4 bits_offset=64
        x3 type_id=5 bits_offset=128
[3] INT short size=2 bit_offset=0 nr_bits=16 encoding=SIGNED
[4] INT long int size=8 bit_offset=0 nr_bits=64 encoding=SIGNED
[5] INT long long int size=8 bit_offset=0 nr_bits=64 encoding=SIGNED

Before:

$ ~/local/pahole/build/pahole -F btf type_test
base_type__name_to_size: base_type short
class__fixup_btf_bitfields: unknown base type name "short"!
struct s {
        short                      x1;                   /*     0     0 */

        /* XXX 8 bytes hole, try to pack */

        long int                   x2;                   /*     8     8 */
        long long int              x3;                   /*    16     8 */

        /* size: 24, cachelines: 1, members: 3 */
        /* sum members: 16, holes: 1, sum holes: 8 */
        /* last cacheline: 24 bytes */
};

After:

$ ~/local/pahole/build/pahole -F btf type_test
struct s {
        short                      x1;                   /*     0     2 */

        /* XXX 6 bytes hole, try to pack */

        long int                   x2;                   /*     8     8 */
        long long int              x3;                   /*    16     8 */

        /* size: 24, cachelines: 1, members: 3 */
        /* sum members: 18, holes: 1, sum holes: 6 */
        /* last cacheline: 24 bytes */
};

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 dwarves.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dwarves.c b/dwarves.c
index 093de11..adc411a 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -147,11 +147,13 @@ static struct base_type_name_to_size {
 	{ .name = "signed short",	    .size = 16, },
 	{ .name = "unsigned short",	    .size = 16, },
 	{ .name = "short int",		    .size = 16, },
+	{ .name = "short",		    .size = 16, },
 	{ .name = "char",		    .size =  8, },
 	{ .name = "signed char",	    .size =  8, },
 	{ .name = "unsigned char",	    .size =  8, },
 	{ .name = "signed long",	    .size =  0, },
 	{ .name = "long int",		    .size =  0, },
+	{ .name = "long",		    .size =  0, },
 	{ .name = "signed long",	    .size =  0, },
 	{ .name = "unsigned long",	    .size =  0, },
 	{ .name = "long unsigned int",	    .size =  0, },
@@ -159,6 +161,7 @@ static struct base_type_name_to_size {
 	{ .name = "_Bool",		    .size =  8, },
 	{ .name = "long long unsigned int", .size = 64, },
 	{ .name = "long long int",	    .size = 64, },
+	{ .name = "long long",		    .size = 64, },
 	{ .name = "signed long long",	    .size = 64, },
 	{ .name = "unsigned long long",	    .size = 64, },
 	{ .name = "double",		    .size = 64, },
-- 
2.17.1

