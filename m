Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D069AC64E7C
	for <bpf@archiver.kernel.org>; Wed, 25 Nov 2020 03:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8092120872
	for <bpf@archiver.kernel.org>; Wed, 25 Nov 2020 03:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kkPXcfNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgKYDDz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:03:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3704 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727234AbgKYDB2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 22:01:28 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AP2s9F0020697
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 19:01:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=RH10uTc2SABI5+AuWBz8rVMMslGuSfje99oYC4biZTk=;
 b=kkPXcfNnOh9u2ltCtGQJrhSWzLQlD2awXeYK6BoI1tO+2YDsM0d13LcksD4hRPixhrEO
 jdGx4YLqD8aJ+OjmLtkAFrnMXAU5UVV+0NKeKeD+iq23wSaeYBNBuAEoFI1MaTNeRVqf
 /s31ixMoc6Dr01+WVG/4RtSAi2QO4wbVYQk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 34yx1t31xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 19:01:27 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 19:01:26 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 257C516A189B; Tue, 24 Nov 2020 19:01:22 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v8 13/34] bpf: memcg-based memory accounting for lpm_trie maps
Date:   Tue, 24 Nov 2020 19:00:58 -0800
Message-ID: <20201125030119.2864302-14-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201125030119.2864302-1-guro@fb.com>
References: <20201125030119.2864302-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=13 spamscore=0
 mlxlogscore=757 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011250018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include lpm trie and lpm trie node objects into the memcg-based memory
accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/bpf/lpm_trie.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 00e32f2ec3e6..a7d1e5cb80da 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -282,8 +282,9 @@ static struct lpm_trie_node *lpm_trie_node_alloc(cons=
t struct lpm_trie *trie,
 	if (value)
 		size +=3D trie->map.value_size;
=20
-	node =3D kmalloc_node(size, GFP_ATOMIC | __GFP_NOWARN,
-			    trie->map.numa_node);
+	node =3D bpf_map_kmalloc_node(&trie->map, size,
+				    GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT,
+				    trie->map.numa_node);
 	if (!node)
 		return NULL;
=20
@@ -557,7 +558,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *att=
r)
 	    attr->value_size > LPM_VAL_SIZE_MAX)
 		return ERR_PTR(-EINVAL);
=20
-	trie =3D kzalloc(sizeof(*trie), GFP_USER | __GFP_NOWARN);
+	trie =3D kzalloc(sizeof(*trie), GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT=
);
 	if (!trie)
 		return ERR_PTR(-ENOMEM);
=20
--=20
2.26.2

