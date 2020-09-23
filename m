Return-Path: <SRS0=NOCw=DA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94481C4727D
	for <bpf@archiver.kernel.org>; Wed, 23 Sep 2020 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD18235FC
	for <bpf@archiver.kernel.org>; Wed, 23 Sep 2020 15:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VXVNo55c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIWPyw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:54:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726332AbgIWPyv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Sep 2020 11:54:51 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08NFgY56008215
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 08:54:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=2+MBgJTgIFETTVodkRYKxIV+fEzB+bOk7szmkoeGDj8=;
 b=VXVNo55cjr4YjyFiFtnKmSMG8K/ScPFRW1cqLs9bKSW3Fm12hTPWIawDXpp0vX5WhAUq
 a93AagQWjmBejhoA26nOlo3FuqYx8QVAyGIEXGhLOa6hRsIvTQW/a+zIwlphWNsZ2lig
 /WSkARzDELwfJv3HhRVLFMZxrrz/NVdHjkQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 33qsp7cc9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 08:54:49 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 23 Sep 2020 08:54:49 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 48ECD2EC7442; Wed, 23 Sep 2020 08:54:46 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH bpf-next 4/9] libbpf: extract generic string hashing function for reuse
Date:   Wed, 23 Sep 2020 08:54:31 -0700
Message-ID: <20200923155436.2117661-5-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200923155436.2117661-1-andriin@fb.com>
References: <20200923155436.2117661-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_12:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 mlxlogscore=876 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 suspectscore=8 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Calculating a hash of zero-terminated string is a common need when using
hashmap, so extract it for reuse.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf_dump.c |  9 +--------
 tools/lib/bpf/hashmap.h  | 12 ++++++++++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 6c079b3c8679..91310e528a3a 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -90,14 +90,7 @@ struct btf_dump {
=20
 static size_t str_hash_fn(const void *key, void *ctx)
 {
-	const char *s =3D key;
-	size_t h =3D 0;
-
-	while (*s) {
-		h =3D h * 31 + *s;
-		s++;
-	}
-	return h;
+	return str_hash(key);
 }
=20
 static bool str_equal_fn(const void *a, const void *b, void *ctx)
diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index e0af36b0e5d8..d9b385fe808c 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -25,6 +25,18 @@ static inline size_t hash_bits(size_t h, int bits)
 #endif
 }
=20
+/* generic C-string hashing function */
+static inline size_t str_hash(const char *s)
+{
+	size_t h =3D 0;
+
+	while (*s) {
+		h =3D h * 31 + *s;
+		s++;
+	}
+	return h;
+}
+
 typedef size_t (*hashmap_hash_fn)(const void *key, void *ctx);
 typedef bool (*hashmap_equal_fn)(const void *key1, const void *key2, voi=
d *ctx);
=20
--=20
2.24.1

