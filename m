Return-Path: <SRS0=nwYh=VD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C217C0650E
	for <bpf@archiver.kernel.org>; Sat,  6 Jul 2019 04:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D047921670
	for <bpf@archiver.kernel.org>; Sat,  6 Jul 2019 04:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ac+ZNBRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfGFEfe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 6 Jul 2019 00:35:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60652 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725870AbfGFEfe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 6 Jul 2019 00:35:34 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x664WZCd005763
        for <bpf@vger.kernel.org>; Fri, 5 Jul 2019 21:35:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=igo48dLXUoO1xvGJwJgrPogT3Hl9Qc2jBouXbBUNG64=;
 b=ac+ZNBRbb1DzWc6VfFzLhIOSdmT04zY0cULoAmjytpc9JsANUBQWKY1G7NKefum4Yk69
 F43WbjYiCgh+JVhmRMIx50MIWlgRsoy/YtVxgSQyvtzVSPa2Gzma6G+qf53g42mLTDla
 RTHwqtgHmZtaH186zR9Dwi9MknM0pfflG+g= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2tj6yd2jm0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2019 21:35:33 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Jul 2019 21:35:31 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id CA90886163A; Fri,  5 Jul 2019 21:35:30 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v5 bpf-next 2/5] libbpf: auto-set PERF_EVENT_ARRAY size to number of CPUs
Date:   Fri, 5 Jul 2019 21:35:19 -0700
Message-ID: <20190706043522.1559005-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190706043522.1559005-1-andriin@fb.com>
References: <20190706043522.1559005-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907060058
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For BPF_MAP_TYPE_PERF_EVENT_ARRAY typically correct size is number of
possible CPUs. This is impossible to specify at compilation time. This
change adds automatic setting of PERF_EVENT_ARRAY size to number of
system CPUs, unless non-zero size is specified explicitly. This allows
to adjust size for advanced specific cases, while providing convenient
and logical defaults.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 tools/lib/bpf/libbpf.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 72149d68b8c1..e4df833b5138 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2116,6 +2116,7 @@ static int
 bpf_object__create_maps(struct bpf_object *obj)
 {
 	struct bpf_create_map_attr create_attr = {};
+	int nr_cpus = 0;
 	unsigned int i;
 	int err;
 
@@ -2138,7 +2139,22 @@ bpf_object__create_maps(struct bpf_object *obj)
 		create_attr.map_flags = def->map_flags;
 		create_attr.key_size = def->key_size;
 		create_attr.value_size = def->value_size;
-		create_attr.max_entries = def->max_entries;
+		if (def->type == BPF_MAP_TYPE_PERF_EVENT_ARRAY &&
+		    !def->max_entries) {
+			if (!nr_cpus)
+				nr_cpus = libbpf_num_possible_cpus();
+			if (nr_cpus < 0) {
+				pr_warning("failed to determine number of system CPUs: %d\n",
+					   nr_cpus);
+				err = nr_cpus;
+				goto err_out;
+			}
+			pr_debug("map '%s': setting size to %d\n",
+				 map->name, nr_cpus);
+			create_attr.max_entries = nr_cpus;
+		} else {
+			create_attr.max_entries = def->max_entries;
+		}
 		create_attr.btf_fd = 0;
 		create_attr.btf_key_type_id = 0;
 		create_attr.btf_value_type_id = 0;
@@ -2155,9 +2171,10 @@ bpf_object__create_maps(struct bpf_object *obj)
 		*pfd = bpf_create_map_xattr(&create_attr);
 		if (*pfd < 0 && (create_attr.btf_key_type_id ||
 				 create_attr.btf_value_type_id)) {
-			cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+			err = -errno;
+			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 			pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
-				   map->name, cp, errno);
+				   map->name, cp, err);
 			create_attr.btf_fd = 0;
 			create_attr.btf_key_type_id = 0;
 			create_attr.btf_value_type_id = 0;
@@ -2169,11 +2186,11 @@ bpf_object__create_maps(struct bpf_object *obj)
 		if (*pfd < 0) {
 			size_t j;
 
-			err = *pfd;
+			err = -errno;
 err_out:
-			cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-			pr_warning("failed to create map (name: '%s'): %s\n",
-				   map->name, cp);
+			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
+			pr_warning("failed to create map (name: '%s'): %s(%d)\n",
+				   map->name, cp, err);
 			for (j = 0; j < i; j++)
 				zclose(obj->maps[j].fd);
 			return err;
-- 
2.17.1

