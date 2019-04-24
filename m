Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D601AC282CE
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57C7208E4
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lLsOGZYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfDXWkI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:40:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbfDXWkI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Apr 2019 18:40:08 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OMTscW032678
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 15:40:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=FyY/OEEU1JAxalKeXCHhyYCGQe3/J3CNnBGRqm0YXBY=;
 b=lLsOGZYRrF0v/4s+ZeW6Y2d1ZW2soKMhjkAy3XcSld561sPO9Nb5R+cyOc3CwUaC5fql
 ijHLPvRu3XuIWwDNUpyJke9l8XIiGGBp12Ubo+Bo/OTjqMsXGTzjaGaps550AqzncTXX
 fiTBkerDvEcsVgbLpCpyiZcnxTtAFrOrUxc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2x8e8xp2-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 15:40:07 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 24 Apr 2019 15:39:52 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 2C6D629421BD; Wed, 24 Apr 2019 15:39:52 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/6] bpf: Sync bpf.h to tools
Date:   Wed, 24 Apr 2019 15:39:52 -0700
Message-ID: <20190424223952.516950-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424223948.516788-1-kafai@fb.com>
References: <20190424223948.516788-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch sync the bpf.h to tools/.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/include/uapi/linux/bpf.h | 44 +++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 704bb69514a2..be08ef00b2c8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -133,6 +133,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
 	BPF_MAP_TYPE_QUEUE,
 	BPF_MAP_TYPE_STACK,
+	BPF_MAP_TYPE_SK_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -2622,6 +2623,42 @@ union bpf_attr {
  *		was provided.
  *
  *		**-ERANGE** if resulting value was out of range.
+ *
+ * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ *	Description
+ *		Get a bpf-local-storage from a sk.
+ *
+ *		Logically, it could be thought of getting the value from
+ *		a *map* with *sk* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem(map, &sk)** except this
+ *		helper enforces the key must be a **bpf_fullsock()**
+ *		and the map must be a BPF_MAP_TYPE_SK_STORAGE also.
+ *
+ *		Underneath, the value is stored locally at *sk* instead of
+ *		the map.  The *map* is used as the bpf-local-storage **type**.
+ *		The bpf-local-storage **type** (i.e. the *map*) is searched
+ *		against all bpf-local-storages residing at sk.
+ *
+ *		An optional *flags* (BPF_SK_STORAGE_GET_F_CREATE) can be
+ *		used such that a new bpf-local-storage will be
+ *		created if one does not exist.  *value* can be used
+ *		together with BPF_SK_STORAGE_GET_F_CREATE to specify
+ *		the initial value of a bpf-local-storage.  If *value* is
+ *		NULL, the new bpf-local-storage will be zero initialized.
+ *	Return
+ *		A bpf-local-storage pointer is returned on success.
+ *
+ *		**NULL** if not found or there was an error in adding
+ *		a new bpf-local-storage.
+ *
+ * int bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+ *	Description
+ *		Delete a bpf-local-storage from a sk.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf-local-storage cannot be found.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2730,7 +2767,9 @@ union bpf_attr {
 	FN(sysctl_get_new_value),	\
 	FN(sysctl_set_new_value),	\
 	FN(strtol),			\
-	FN(strtoul),
+	FN(strtoul),			\
+	FN(sk_storage_get),		\
+	FN(sk_storage_delete),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -2806,6 +2845,9 @@ enum bpf_func_id {
 /* BPF_FUNC_sysctl_get_name flags. */
 #define BPF_F_SYSCTL_BASE_NAME		(1ULL << 0)
 
+/* BPF_FUNC_sk_storage_get flags */
+#define BPF_SK_STORAGE_GET_F_CREATE	(1ULL << 0)
+
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
 	BPF_ADJ_ROOM_NET,
-- 
2.17.1

