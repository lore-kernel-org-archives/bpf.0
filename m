Return-Path: <SRS0=Ijne=BG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF2C433F4
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 18:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A672078E
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 18:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BC5nIVRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbgG0Spu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:45:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12720 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732038AbgG0Spu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Jul 2020 14:45:50 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RIjgE2027163
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 11:45:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qtv1hcL85DQtdggLDfs5igg/8M6CQm4swYBZDjhA5jA=;
 b=BC5nIVRYqrDnDrlnUFLpNp8J+FhWk/zRJ/z8bfv9t3YsyuxochnNvuK0uUGSqoKbSMUB
 ww2VIN/IGF5ZN/UKSbGDzk4OZorhYw/9UaSu58kzV6t1GP0KOiq6JUrevHJ0QDLbzJ5N
 Y3JHbj4J1ywNZ33SDgt3n1slQmf1axHElAs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32h50vnsy2-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 11:45:49 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 27 Jul 2020 11:45:16 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id B20B51DAFE81; Mon, 27 Jul 2020 11:45:10 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v2 08/35] bpf: memcg-based memory accounting for lpm_trie maps
Date:   Mon, 27 Jul 2020 11:44:39 -0700
Message-ID: <20200727184506.2279656-9-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200727184506.2279656-1-guro@fb.com>
References: <20200727184506.2279656-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_13:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=755 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270127
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include lpm trie and lpm trie node objects into the memcg-based memory
accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/bpf/lpm_trie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 44474bf3ab7a..d85e0fc2cafc 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -282,7 +282,7 @@ static struct lpm_trie_node *lpm_trie_node_alloc(cons=
t struct lpm_trie *trie,
 	if (value)
 		size +=3D trie->map.value_size;
=20
-	node =3D kmalloc_node(size, GFP_ATOMIC | __GFP_NOWARN,
+	node =3D kmalloc_node(size, GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT,
 			    trie->map.numa_node);
 	if (!node)
 		return NULL;
@@ -557,7 +557,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *att=
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

