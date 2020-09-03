Return-Path: <SRS0=zf1N=CM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0C1C2D0A7
	for <bpf@archiver.kernel.org>; Thu,  3 Sep 2020 20:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F97B20678
	for <bpf@archiver.kernel.org>; Thu,  3 Sep 2020 20:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KSLb4mPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgICUh6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:37:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63062 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728988AbgICUfy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Sep 2020 16:35:54 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083KYLe4011008
        for <bpf@vger.kernel.org>; Thu, 3 Sep 2020 13:35:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nBWtBxtyHmjoS2voQlhYPBCiKjNcxWGI+7tWUJVYzn8=;
 b=KSLb4mPvSLZ6WKDMLf804KNUua4DNXaxBimJ+Gil8mY9Zp6j6RD/PPXkN2njvcRJLuhi
 26Si4RGK0TaFubarGu7IS/7L1S9QE+Ctsfsmo8g8VB4eUkjZ/fdAU8vrmZdEnntQpmUr
 30TGITx70MaB8iHeGQfut4qOYMdpbX1vKkg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 338gqnr9a5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2020 13:35:52 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Sep 2020 13:35:50 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 825972EC6814; Thu,  3 Sep 2020 13:35:45 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH v3 bpf-next 01/14] libbpf: ensure ELF symbols table is found before further ELF processing
Date:   Thu, 3 Sep 2020 13:35:29 -0700
Message-ID: <20200903203542.15944-2-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200903203542.15944-1-andriin@fb.com>
References: <20200903203542.15944-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_13:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=8 malwarescore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=749 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030183
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf ELF parsing logic might need symbols available before ELF parsing =
is
completed, so we need to make sure that symbols table section is found in
a separate pass before all the subsequent sections are processed.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b688aadf09c5..ac56d4db6d3e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2720,14 +2720,38 @@ static int bpf_object__elf_collect(struct bpf_obj=
ect *obj)
 	Elf *elf =3D obj->efile.elf;
 	Elf_Data *btf_ext_data =3D NULL;
 	Elf_Data *btf_data =3D NULL;
-	Elf_Scn *scn =3D NULL;
 	int idx =3D 0, err =3D 0;
+	const char *name;
+	Elf_Data *data;
+	Elf_Scn *scn;
+	GElf_Shdr sh;
=20
+	/* a bunch of ELF parsing functionality depends on processing symbols,
+	 * so do the first pass and find the symbol table
+	 */
+	scn =3D NULL;
 	while ((scn =3D elf_nextscn(elf, scn)) !=3D NULL) {
-		const char *name;
-		GElf_Shdr sh;
-		Elf_Data *data;
+		if (elf_sec_hdr(obj, scn, &sh))
+			return -LIBBPF_ERRNO__FORMAT;
+
+		if (sh.sh_type =3D=3D SHT_SYMTAB) {
+			if (obj->efile.symbols) {
+				pr_warn("elf: multiple symbol tables in %s\n", obj->path);
+				return -LIBBPF_ERRNO__FORMAT;
+			}
=20
+			data =3D elf_sec_data(obj, scn);
+			if (!data)
+				return -LIBBPF_ERRNO__FORMAT;
+
+			obj->efile.symbols =3D data;
+			obj->efile.symbols_shndx =3D elf_ndxscn(scn);
+			obj->efile.strtabidx =3D sh.sh_link;
+		}
+	}
+
+	scn =3D NULL;
+	while ((scn =3D elf_nextscn(elf, scn)) !=3D NULL) {
 		idx++;
=20
 		if (elf_sec_hdr(obj, scn, &sh))
@@ -2766,13 +2790,7 @@ static int bpf_object__elf_collect(struct bpf_obje=
ct *obj)
 		} else if (strcmp(name, BTF_EXT_ELF_SEC) =3D=3D 0) {
 			btf_ext_data =3D data;
 		} else if (sh.sh_type =3D=3D SHT_SYMTAB) {
-			if (obj->efile.symbols) {
-				pr_warn("elf: multiple symbol tables in %s\n", obj->path);
-				return -LIBBPF_ERRNO__FORMAT;
-			}
-			obj->efile.symbols =3D data;
-			obj->efile.symbols_shndx =3D idx;
-			obj->efile.strtabidx =3D sh.sh_link;
+			/* already processed during the first pass above */
 		} else if (sh.sh_type =3D=3D SHT_PROGBITS && data->d_size > 0) {
 			if (sh.sh_flags & SHF_EXECINSTR) {
 				if (strcmp(name, ".text") =3D=3D 0)
--=20
2.24.1

