Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5163AC43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 23:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDAB20684
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 23:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qlpC4AEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfCHX6v (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:58:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35188 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbfCHX6u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Mar 2019 18:58:50 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x28NmxBC009522
        for <bpf@vger.kernel.org>; Fri, 8 Mar 2019 15:58:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=U4bPA3wL2pxBdE3KoKFy5PmdSjtMfOzXc/iiaRdk0Dc=;
 b=qlpC4AEnJWymHeJ+PPeZmIKcwIxF5yJdrtfP++0+N7C950uMpm+9IBbiGyITaz75lJEC
 jcOhFl5bwU9zekcDHLuj+sDBmA84CeX0iuu6fXMNPRsZBTl47S5YrGisjfWY8X+fhQkH
 vv8N1i/jwD4tYcGePgQo8fiYKCdQ26NimwE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2r40kh8b9k-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Mar 2019 15:58:49 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 8 Mar 2019 15:58:24 -0800
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 38F2A860B36; Fri,  8 Mar 2019 15:58:22 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <tehnerd@tehnerd.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf] libbpf: handle BTF parsing and loading properly
Date:   Fri, 8 Mar 2019 15:58:20 -0800
Message-ID: <20190308235820.3854596-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-08_20:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch splits and cleans up error handling logic for loading BTF data.
Previously, if BTF data was parsed successfully, but failed to load into
kernel, we'd report nonsensical error code, instead of error returned from
btf__load(). Now btf__new() and btf__load() are handled separately with proper
cleanup and warning reporting.

Fixes: d29d87f7e612 ("btf: separate btf creation and loading")
Reported-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d5b830d60601..5e977d2688da 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -835,12 +835,19 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
 			obj->efile.maps_shndx = idx;
 		else if (strcmp(name, BTF_ELF_SEC) == 0) {
 			obj->btf = btf__new(data->d_buf, data->d_size);
-			if (IS_ERR(obj->btf) || btf__load(obj->btf)) {
+			if (IS_ERR(obj->btf)) {
 				pr_warning("Error loading ELF section %s: %ld. Ignored and continue.\n",
 					   BTF_ELF_SEC, PTR_ERR(obj->btf));
-				if (!IS_ERR(obj->btf))
-					btf__free(obj->btf);
 				obj->btf = NULL;
+				continue;
+			}
+			err = btf__load(obj->btf);
+			if (err) {
+				pr_warning("Error loading %s into kernel: %d. Ignored and continue.\n",
+					   BTF_ELF_SEC, err);
+				btf__free(obj->btf);
+				obj->btf = NULL;
+				err = 0;
 			}
 		} else if (strcmp(name, BTF_EXT_ELF_SEC) == 0) {
 			btf_ext_data = data;
-- 
2.17.1

