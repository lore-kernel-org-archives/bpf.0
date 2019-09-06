Return-Path: <SRS0=IQzl=XB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48174C43331
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 23:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD1C20692
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 23:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567811476;
	bh=aq3xHX9p5XnWfJEDjF+VBT5iPOprL7pzDvsxGT0EgSg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QQQfcjB8EXkm6Wx7HMyr+OfolI8EmQZFob6Ew125tT72fed+0H7XKS0zHRrdPIXMy
	 IH34Adp8m9DvHNbjPPajgF6Hf4zMshAdI9/RvHP6FvFv+kskW3wOqpIK6TuuCJIsz+
	 nJzjvVxqrNcyH77opMQ5n8PNGoIDCOKkHoH4IaOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405298AbfIFXLP convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 6 Sep 2019 19:11:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20132 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405322AbfIFXLK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Sep 2019 19:11:10 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86NAq94020808
        for <bpf@vger.kernel.org>; Fri, 6 Sep 2019 16:11:09 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uu8mdxdbw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2019 16:11:09 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 6 Sep 2019 16:11:07 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 80FBB760B80; Fri,  6 Sep 2019 16:11:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <peterz@infradead.org>,
        <luto@amacapital.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-api@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 4/4] selftests/bpf: use CAP_BPF and CAP_TRACING in tests
Date:   Fri, 6 Sep 2019 16:10:53 -0700
Message-ID: <20190906231053.1276792-5-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190906231053.1276792-1-ast@kernel.org>
References: <20190906231053.1276792-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-06_11:2019-09-04,2019-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 suspectscore=3 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1034 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909060226
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make all test_verifier test exercise CAP_BPF and CAP_TRACING

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 46 +++++++++++++++++----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index d27fd929abb9..0d5567962c4e 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -807,10 +807,20 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	}
 }
 
+struct libcap {
+	struct __user_cap_header_struct hdr;
+	struct __user_cap_data_struct data[2];
+};
+
 static int set_admin(bool admin)
 {
 	cap_t caps;
-	const cap_value_t cap_val = CAP_SYS_ADMIN;
+	/* need CAP_BPF to load progs and CAP_NET_ADMIN to run networking progs,
+	 * and CAP_TRACING to create stackmap
+	 */
+	const cap_value_t cap_net_admin = CAP_NET_ADMIN;
+	const cap_value_t cap_sys_admin = CAP_SYS_ADMIN;
+	struct libcap *cap;
 	int ret = -1;
 
 	caps = cap_get_proc();
@@ -818,11 +828,26 @@ static int set_admin(bool admin)
 		perror("cap_get_proc");
 		return -1;
 	}
-	if (cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_val,
+	cap = (struct libcap *)caps;
+	if (cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_sys_admin, CAP_CLEAR)) {
+		perror("cap_set_flag clear admin");
+		goto out;
+	}
+	if (cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_net_admin,
 				admin ? CAP_SET : CAP_CLEAR)) {
-		perror("cap_set_flag");
+		perror("cap_set_flag set_or_clear net");
 		goto out;
 	}
+	/* libcap is likely old and simply ignores CAP_BPF and CAP_TRACING,
+	 * so update effective bits manually
+	 */
+	if (admin) {
+		cap->data[1].effective |= 1 << (38 /* CAP_BPF */ - 32);
+		cap->data[1].effective |= 1 << (39 /* CAP_TRACING */ - 32);
+	} else {
+		cap->data[1].effective &= ~(1 << (38 - 32));
+		cap->data[1].effective &= ~(1 << (39 - 32));
+	}
 	if (cap_set_proc(caps)) {
 		perror("cap_set_proc");
 		goto out;
@@ -1051,9 +1076,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 
 static bool is_admin(void)
 {
+	cap_flag_value_t net_priv = CAP_CLEAR;
+	bool tracing_priv = false;
+	bool bpf_priv = false;
+	struct libcap *cap;
 	cap_t caps;
-	cap_flag_value_t sysadmin = CAP_CLEAR;
-	const cap_value_t cap_val = CAP_SYS_ADMIN;
 
 #ifdef CAP_IS_SUPPORTED
 	if (!CAP_IS_SUPPORTED(CAP_SETFCAP)) {
@@ -1066,11 +1093,14 @@ static bool is_admin(void)
 		perror("cap_get_proc");
 		return false;
 	}
-	if (cap_get_flag(caps, cap_val, CAP_EFFECTIVE, &sysadmin))
-		perror("cap_get_flag");
+	cap = (struct libcap *)caps;
+	bpf_priv = cap->data[1].effective & (1 << (38/* CAP_BPF */ - 32));
+	tracing_priv = cap->data[1].effective & (1 << (39/* CAP_TRACING */ - 32));
+	if (cap_get_flag(caps, CAP_NET_ADMIN, CAP_EFFECTIVE, &net_priv))
+		perror("cap_get_flag NET");
 	if (cap_free(caps))
 		perror("cap_free");
-	return (sysadmin == CAP_SET);
+	return bpf_priv && tracing_priv && net_priv == CAP_SET;
 }
 
 static void get_unpriv_disabled()
-- 
2.20.0

