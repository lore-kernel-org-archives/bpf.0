Return-Path: <SRS0=He8s=BM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B7C433E1
	for <bpf@archiver.kernel.org>; Sun,  2 Aug 2020 01:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F6620829
	for <bpf@archiver.kernel.org>; Sun,  2 Aug 2020 01:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="n2SOMluj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHBBcd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 1 Aug 2020 21:32:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32512 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727945AbgHBBcd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 1 Aug 2020 21:32:33 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0721TUtH019516
        for <bpf@vger.kernel.org>; Sat, 1 Aug 2020 18:32:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=J3sP0pRRU0wS1BmPVHElWGIZ0FCXyj9T1i4TlorBDrA=;
 b=n2SOMluji5GUbIjWSSezrYnKW/OOv3oqzF7RjTFkDivDZ5ESHohT8oTW9ILLQfKzK6dS
 DxNZE+fuP6L5kY1jRVuK+OTBFkqeQ2lAl469UW27Slhx75X2Ve3zTlQwUel4WPZOBbRm
 qlLgQUJmizaVkpQsfpMmfvMrGvfo5eWEtfg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32n7sb1smh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 18:32:32 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 1 Aug 2020 18:32:32 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 2610D2EC50C3; Sat,  1 Aug 2020 18:32:27 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 3/3] tools/resolve_btfids: use libbpf's btf__parse() API
Date:   Sat, 1 Aug 2020 18:32:19 -0700
Message-ID: <20200802013219.864880-4-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200802013219.864880-1-andriin@fb.com>
References: <20200802013219.864880-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-02_01:2020-07-31,2020-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxlogscore=797
 suspectscore=25 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008020009
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of re-implementing generic BTF parsing logic, use libbpf's API.
Also add .gitignore for resolve_btfids's build artifacts.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/resolve_btfids/.gitignore |  4 ++
 tools/bpf/resolve_btfids/main.c     | 58 +----------------------------
 2 files changed, 5 insertions(+), 57 deletions(-)
 create mode 100644 tools/bpf/resolve_btfids/.gitignore

diff --git a/tools/bpf/resolve_btfids/.gitignore b/tools/bpf/resolve_btfi=
ds/.gitignore
new file mode 100644
index 000000000000..a026df7dc280
--- /dev/null
+++ b/tools/bpf/resolve_btfids/.gitignore
@@ -0,0 +1,4 @@
+/FEATURE-DUMP.libbpf
+/bpf_helper_defs.h
+/fixdep
+/resolve_btfids
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
index 6956b6350cad..52d883325a23 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -403,62 +403,6 @@ static int symbols_collect(struct object *obj)
 	return 0;
 }
=20
-static struct btf *btf__parse_raw(const char *file)
-{
-	struct btf *btf;
-	struct stat st;
-	__u8 *buf;
-	FILE *f;
-
-	if (stat(file, &st))
-		return NULL;
-
-	f =3D fopen(file, "rb");
-	if (!f)
-		return NULL;
-
-	buf =3D malloc(st.st_size);
-	if (!buf) {
-		btf =3D ERR_PTR(-ENOMEM);
-		goto exit_close;
-	}
-
-	if ((size_t) st.st_size !=3D fread(buf, 1, st.st_size, f)) {
-		btf =3D ERR_PTR(-EINVAL);
-		goto exit_free;
-	}
-
-	btf =3D btf__new(buf, st.st_size);
-
-exit_free:
-	free(buf);
-exit_close:
-	fclose(f);
-	return btf;
-}
-
-static bool is_btf_raw(const char *file)
-{
-	__u16 magic =3D 0;
-	int fd, nb_read;
-
-	fd =3D open(file, O_RDONLY);
-	if (fd < 0)
-		return false;
-
-	nb_read =3D read(fd, &magic, sizeof(magic));
-	close(fd);
-	return nb_read =3D=3D sizeof(magic) && magic =3D=3D BTF_MAGIC;
-}
-
-static struct btf *btf_open(const char *path)
-{
-	if (is_btf_raw(path))
-		return btf__parse_raw(path);
-	else
-		return btf__parse_elf(path, NULL);
-}
-
 static int symbols_resolve(struct object *obj)
 {
 	int nr_typedefs =3D obj->nr_typedefs;
@@ -469,7 +413,7 @@ static int symbols_resolve(struct object *obj)
 	struct btf *btf;
 	__u32 nr;
=20
-	btf =3D btf_open(obj->btf ?: obj->path);
+	btf =3D btf__parse(obj->btf ?: obj->path, NULL);
 	err =3D libbpf_get_error(btf);
 	if (err) {
 		pr_err("FAILED: load BTF from %s: %s",
--=20
2.24.1

