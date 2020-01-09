Return-Path: <SRS0=lXkO=26=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F706C33CA2
	for <bpf@archiver.kernel.org>; Thu,  9 Jan 2020 00:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7432720705
	for <bpf@archiver.kernel.org>; Thu,  9 Jan 2020 00:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mnE7t8NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgAIAfP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Jan 2020 19:35:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45714 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727701AbgAIAfP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Jan 2020 19:35:15 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0090Ywur026160
        for <bpf@vger.kernel.org>; Wed, 8 Jan 2020 16:35:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=9ZmtUZE0KCjT48/efHjhXGhS2xo6nY/ckyGFV+ODGE0=;
 b=mnE7t8NG7Okq5AAje9DzjoiZFy4bqv+hDUF3Ol0gWa1addvyZ9SvR8p5OEqrwEyaaHIQ
 mzI4Ak9eH8gSNLtURKJCiSM1gs5GgW3dgdw34EDYrjBxPzydLjjWcQOfL9DPeuZsrldU
 c8TVZ7boqQngmLitZv9gO0NPv7Dk2OwrPA0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xdkut9w9y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2020 16:35:14 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 8 Jan 2020 16:35:13 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id B02462942576; Wed,  8 Jan 2020 16:35:12 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v4 09/11] bpf: Synch uapi bpf.h to tools/
Date:   Wed, 8 Jan 2020 16:35:12 -0800
Message-ID: <20200109003512.3856559-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109003453.3854769-1-kafai@fb.com>
References: <20200109003453.3854769-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_07:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=13 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=971 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001090003
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch sync uapi bpf.h to tools/

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/include/uapi/linux/bpf.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7df436da542d..2d6a2e572f56 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -136,6 +136,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_STACK,
 	BPF_MAP_TYPE_SK_STORAGE,
 	BPF_MAP_TYPE_DEVMAP_HASH,
+	BPF_MAP_TYPE_STRUCT_OPS,
 };
 
 /* Note that tracing related programs such as
@@ -174,6 +175,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
 	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 	BPF_PROG_TYPE_TRACING,
+	BPF_PROG_TYPE_STRUCT_OPS,
 };
 
 enum bpf_attach_type {
@@ -397,6 +399,10 @@ union bpf_attr {
 		__u32	btf_fd;		/* fd pointing to a BTF type data */
 		__u32	btf_key_type_id;	/* BTF type_id of the key */
 		__u32	btf_value_type_id;	/* BTF type_id of the value */
+		__u32	btf_vmlinux_value_type_id;/* BTF type_id of a kernel-
+						   * struct stored as the
+						   * map value
+						   */
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
@@ -2831,6 +2837,14 @@ union bpf_attr {
  * 	Return
  * 		On success, the strictly positive length of the string,	including
  * 		the trailing NUL character. On error, a negative value.
+ *
+ * int bpf_tcp_send_ack(void *tp, u32 rcv_nxt)
+ *	Description
+ *		Send out a tcp-ack. *tp* is the in-kernel struct tcp_sock.
+ *		*rcv_nxt* is the ack_seq to be sent out.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2948,7 +2962,8 @@ union bpf_attr {
 	FN(probe_read_user),		\
 	FN(probe_read_kernel),		\
 	FN(probe_read_user_str),	\
-	FN(probe_read_kernel_str),
+	FN(probe_read_kernel_str),	\
+	FN(tcp_send_ack),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -3349,7 +3364,7 @@ struct bpf_map_info {
 	__u32 map_flags;
 	char  name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
-	__u32 :32;
+	__u32 btf_vmlinux_value_type_id;
 	__u64 netns_dev;
 	__u64 netns_ino;
 	__u32 btf_id;
-- 
2.17.1

