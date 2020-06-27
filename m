Return-Path: <SRS0=Nv13=AI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A084C433DF
	for <bpf@archiver.kernel.org>; Sat, 27 Jun 2020 00:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43BAB20857
	for <bpf@archiver.kernel.org>; Sat, 27 Jun 2020 00:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="odF6NMD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgF0A30 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Jun 2020 20:29:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29878 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726101AbgF0A3S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Jun 2020 20:29:18 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05R0FNvT023087
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 17:29:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PXwo5w25H1G3trFLqpf6ijaWoyxKihUhCvb9tnUjxmk=;
 b=odF6NMD8YIbMvoo09KZr6IoAUUDHIEYxGC47yE7Qf6eJMxfNO0KT6mRTMxT/2omjfJow
 0U/bs5e6HT5aLNCrrchL+gLBGwelwpehyDIU3BdYjSYEdUF90n5b4fB4B7h0d30wR0nJ
 1DfFD5iALLNNhaJLc1y5Yvm95tF+MEhZdCs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31wudn81g0-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 17:29:17 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Jun 2020 17:29:14 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C4AAD62E4EB1; Fri, 26 Jun 2020 17:26:20 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@chromium.org>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 3/4] bpf: allow %pB in bpf_seq_printf() and bpf_trace_printk()
Date:   Fri, 26 Jun 2020 17:26:08 -0700
Message-ID: <20200627002609.3222870-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200627002609.3222870-1-songliubraving@fb.com>
References: <20200627002609.3222870-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_12:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 suspectscore=8 priorityscore=1501 phishscore=0 lowpriorityscore=0
 cotscore=-2147483648 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006270000
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This makes it easy to dump stack trace in text.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/trace/bpf_trace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 977ba3b6f6c64..1d874d8e4384b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -376,7 +376,7 @@ static void bpf_trace_copy_string(char *buf, void *un=
safe_ptr, char fmt_ptype,
=20
 /*
  * Only limited trace_printk() conversion specifiers allowed:
- * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pks %pus %s
+ * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pB %pks %pus %s
  */
 BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	   u64, arg2, u64, arg3)
@@ -420,6 +420,11 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_s=
ize, u64, arg1,
 				goto fmt_str;
 			}
=20
+			if (fmt[i + 1] =3D=3D 'B') {
+				i++;
+				goto fmt_next;
+			}
+
 			/* disallow any further format extensions */
 			if (fmt[i + 1] !=3D 0 &&
 			    !isspace(fmt[i + 1]) &&
@@ -636,7 +641,8 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char=
 *, fmt, u32, fmt_size,
 		if (fmt[i] =3D=3D 'p') {
 			if (fmt[i + 1] =3D=3D 0 ||
 			    fmt[i + 1] =3D=3D 'K' ||
-			    fmt[i + 1] =3D=3D 'x') {
+			    fmt[i + 1] =3D=3D 'x' ||
+			    fmt[i + 1] =3D=3D 'B') {
 				/* just kernel pointers */
 				params[fmt_cnt] =3D args[fmt_cnt];
 				fmt_cnt++;
--=20
2.24.1

