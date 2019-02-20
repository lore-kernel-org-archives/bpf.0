Return-Path: <SRS0=w44S=Q3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8F6C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Feb 2019 20:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303A82146E
	for <bpf@archiver.kernel.org>; Wed, 20 Feb 2019 20:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YoTaYoJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBTU5s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:57:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57954 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726215AbfBTU5r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Feb 2019 15:57:47 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KKrWnV000580
        for <bpf@vger.kernel.org>; Wed, 20 Feb 2019 12:57:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=o/UCSwwb3d+rpg1/zZ3JbHuAzJiH+RKfW/xN0Z7dQNQ=;
 b=YoTaYoJ7NtdqGxaEIjQHu57J7ypEFsj1qqB/TggcMopzTpEJSZJIvXd0ldUwEKs6GVw0
 U30Mav4Y2d10ZSX5Kc4bHCZcg4U1GjhGG3DE7zRJo6DjDgf4oUuxnM6UQkbMkySjNEfD
 J+kvbHqcIyZfjugSA8MI6uMJl6BPOKAf/cs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qscy5gb0d-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Feb 2019 12:57:46 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 20 Feb 2019 12:57:34 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 37B56B3AA4BF; Wed, 20 Feb 2019 12:57:34 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <acme@kernel.org>,
        <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>, <ast@fb.com>,
        <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole 3/3] btf_loader: fix bitfield fixup code
Date:   Wed, 20 Feb 2019 12:57:32 -0800
Message-ID: <20190220205732.2514975-4-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220205732.2514975-1-andriin@fb.com>
References: <20190220205732.2514975-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Existing code assumes alignment of any integer type, which breaks for
packed structs. This patch fixes all the current discrepanies between
dwarf and btf loader, when compared using btfdiff. It preserves
bit_offset of non-bitfield members, while for bitfield ones it
re-calculates initial byte/bit offset using natural alignment of the
underlying integer type, which seems to be always the case for
bitfields.

I've tested this on toy examples for both x86-64 and arm targets, there
were no differences reported by btfdiff.

Testing on vmlinux on x86-64 shows only these discrepancies, which are
unrelated to bit offsets:

$ ./btfdiff /tmp/vmlinux4
--- /tmp/btfdiff.dwarf.GIVfpr   2019-02-20 12:18:29.138788970 -0800
+++ /tmp/btfdiff.btf.c3x2KY     2019-02-20 12:18:29.351786365 -0800
@@ -16884,7 +16884,7 @@ struct pebs_record_nhm {
 };
 union hsw_tsx_tuning {
        struct {
-               unsigned int       cycles_last_block:32; /*     0: 0  4 */
+               u32                cycles_last_block:32; /*     0: 0  4 */
                u32                hle_abort:1;        /*     4:31  4 */
                u32                rtm_abort:1;        /*     4:30  4 */
                u32                instruction_abort:1; /*     4:29  4 */
@@ -26154,7 +26154,7 @@ struct acpi_device_power {
        /* last cacheline: 40 bytes */
 };
 struct acpi_device_perf_flags {
-       unsigned char              reserved:8;           /*     0: 0  1 */
+       u8                         reserved:8;           /*     0: 0  1 */

        /* size: 1, cachelines: 1, members: 1 */
        /* last cacheline: 1 bytes */

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 btf_loader.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index fc28884..62e7e30 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -502,19 +502,26 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu, struct btf
 		 * such unlikely thing happens.
 		 */
 		pos->byte_size = integral_bit_size / 8;
+		pos->bit_size = type_bit_size;
 
 		if (integral_bit_size == 0) {
-			pos->bit_size = integral_bit_size;
+			pos->bit_size = 0;
 			continue;
 		}
 
-		pos->bitfield_offset = pos->bit_offset % integral_bit_size;
-		if (!btfe->is_big_endian)
-			pos->bitfield_offset = integral_bit_size - pos->bitfield_offset - pos->bitfield_size;
+		if (pos->bitfield_size) {
+			/* bitfields seem to be always aligned, no matter the packing */
+			pos->byte_offset = pos->bit_offset / integral_bit_size * integral_bit_size / 8;
+		} else {
+			pos->byte_offset = pos->bit_offset / 8;
+		}
+
 
-		pos->bit_size = type_bit_size;
-		pos->byte_offset = (((pos->bit_offset / integral_bit_size) *
-				     integral_bit_size) / 8);
+		if (pos->bitfield_size) {
+			pos->bitfield_offset = pos->bit_offset - pos->byte_offset * 8;
+			if (!btfe->is_big_endian)
+				pos->bitfield_offset = integral_bit_size - pos->bitfield_offset - pos->bitfield_size;
+		}
 	}
 
 	return 0;
-- 
2.17.1

