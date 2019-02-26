Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482DEC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 01:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7A12184D
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 01:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oRMgV7SQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfBZBTe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 20:19:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54432 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfBZBTe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Feb 2019 20:19:34 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q1FPfi014888
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 17:19:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=1JaymjNyfcZTwxUpsUUPYkhHQwaCb/3L8hEFjWrNM4M=;
 b=oRMgV7SQ8pt8o4Znoe0xiEaluS3HbGK3AvzKU8SKv5fpf5CZgbwOJWAOH0vCIaWhVd3/
 +HtvDfbcwx3QV0CwrWsTnbQasn1swNUGgJ3U6LFyeph68tTxLJJERlfwNaRWlF1pqssV
 JIMyNEf3UbIZwueojNmltlrhR4C+6onkvdw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvsk98ctc-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 17:19:33 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 25 Feb 2019 17:19:28 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 3BC2ABBBC45F; Mon, 25 Feb 2019 17:19:28 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <acme@kernel.org>, <yhs@fb.com>, <ast@fb.com>,
        <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>,
        <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 pahole 2/2] btf_encoder: don't special case packed enums
Date:   Mon, 25 Feb 2019 17:19:27 -0800
Message-ID: <20190226011927.597075-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226011927.597075-1-andriin@fb.com>
References: <20190226011927.597075-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF data can represent packed enums correctly without any special
handling from pahole side. Previously pahole's own `enum vscope` would
be omitted causing problems.

Original commit tried to generate correct struct bitfield member type if
the member is an enum. This was dated before kind_flag implementation.
Later, kind_flag support was added and now pahole always generates BTF
with kind_flag = 1 for structures with bitfield, where bitfield size is
encoded in btf_member, so this workaround is not needed any more.
Removing this "hack" makes handling it easier to handle packed enums
correctly.

Repro:

$ cat test/packed_enum.c
enum packed_enum {
        VALUE1,
        VALUE2,
        VALUE3
} __attribute__((packed));

struct s {
        int x;
        enum packed_enum e;
        int y;
};

int main()
{
        struct s s;
        return 0;
}

$ gcc -g -c test/packed_enum.c -o test/packed_enum.o

$ ~/local/pahole/build/pahole -JV test/packed_enum.o
File test/packed_enum.o:
[1] INT (anon) size=1 bit_offset=0 nr_bits=8 encoding=SIGNED
[2] STRUCT s kind_flag=0 size=12 vlen=3
        x type_id=3 bits_offset=0
        e type_id=1 bits_offset=32
        y type_id=3 bits_offset=64
[3] INT int size=4 bit_offset=0 nr_bits=32 encoding=SIGNED

$ ~/local/pahole/build/pahole -F dwarf test/packed_enum.o
struct s {
        int                        x;                    /*     0     4 */
        enum packed_enum           e;                    /*     4     1 */

        /* XXX 3 bytes hole, try to pack */

        int                        y;                    /*     8     4 */

        /* size: 12, cachelines: 1, members: 3 */
        /* sum members: 9, holes: 1, sum holes: 3 */
        /* last cacheline: 12 bytes */
};

$ ~/local/pahole/build/pahole -F btf test/packed_enum.o
struct s {
        int                        x;                    /*     0     4 */
        nameless base type!        e;                    /*     4     1 */

        /* XXX 3 bytes hole, try to pack */

        int                        y;                    /*     8     4 */

        /* size: 12, cachelines: 1, members: 3 */
        /* sum members: 9, holes: 1, sum holes: 3 */
        /* last cacheline: 12 bytes */
};

Notice how pahole's log doesn't have a mention of encoding 'packed_enum'
(anonymous integer is generated instead), which causes 'nameless base
type!' output above.

Fix this change:

$ ~/local/pahole/build/pahole -JV test/packed_enum.o
File test/packed_enum.o:
[1] ENUM packed_enum size=1 vlen=3
        VALUE1 val=0
        VALUE2 val=1
        VALUE3 val=2
[2] STRUCT s kind_flag=0 size=12 vlen=3
        x type_id=3 bits_offset=0
        e type_id=1 bits_offset=32
        y type_id=3 bits_offset=64
[3] INT int size=4 bit_offset=0 nr_bits=32 encoding=SIGNED

$ ~/local/pahole/build/pahole -F btf test/packed_enum.o
struct s {
        int                        x;                    /*     0     4 */
        enum packed_enum           e;                    /*     4     1 */

        /* XXX 3 bytes hole, try to pack */

        int                        y;                    /*     8     4 */

        /* size: 12, cachelines: 1, members: 3 */
        /* sum members: 9, holes: 1, sum holes: 3 */
        /* last cacheline: 12 bytes */
};

$ PAHOLE=~/local/pahole/build/pahole ./btfdiff test/packed_enum.o

Also verified on pahole, kernel and glibc:

$ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/pahole.debug
$ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/libc-2.28.so.debug
$ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/vmlinux4

Fixes: b18354f64cc2 ("btf: Generate correct struct bitfield member types")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 btf_encoder.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 9cf0831..d8dc368 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -116,15 +116,6 @@ static int32_t enumeration_type__encode(struct btf_elf *btfe, struct tag *tag)
 	struct enumerator *pos;
 	int32_t type_id;
 
-	/* if enumerator bit_size is not 32, generate an int type instead. */
-	if (etype->size != 32) {
-		struct base_type bt = {};
-
-		bt.bit_size = etype->size;
-		bt.is_signed = true;
-		return btf_elf__add_base_type(btfe, &bt);
-	}
-
 	type_id = btf_elf__add_enum(btfe, etype->namespace.name, etype->size, etype->nr_members);
 	if (type_id < 0)
 		return type_id;
-- 
2.17.1

