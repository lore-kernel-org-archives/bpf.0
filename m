Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3DAC4361B
	for <bpf@archiver.kernel.org>; Sat, 12 Dec 2020 02:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEE022DFB
	for <bpf@archiver.kernel.org>; Sat, 12 Dec 2020 02:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437939AbgLLCuG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Dec 2020 21:50:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19696 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437693AbgLLCtY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Dec 2020 21:49:24 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BC2jGqq005066
        for <bpf@vger.kernel.org>; Fri, 11 Dec 2020 18:48:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=fHK02DMY3e9CuY9vd0yEYe9+aiFFQzzSEnF0c5NhuB8=;
 b=kMmPW3arSVgtPBcM85ee0LICp/ZW0dIoLTHuXREfrajYChu2Q+Ib2Bc7/AYKLupeG3kH
 elbUuRI+45P9DmcUe9OBJ1zLNigwXiSOlGUfCeVkGlJbcsI0yeWzJSWWezSiCvCLcjle
 AjFje6RuIdG7OTpgbEY8aWQP9RGJOt05fHY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35c9rekxxn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Dec 2020 18:48:43 -0800
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 11 Dec 2020 18:48:42 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 5133B62E50ED; Fri, 11 Dec 2020 18:48:37 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next 3/4] libbpf: introduce section "iter.s/" for sleepable bpf_iter program
Date:   Fri, 11 Dec 2020 18:48:09 -0800
Message-ID: <20201212024810.807616-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201212024810.807616-1-songliubraving@fb.com>
References: <20201212024810.807616-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_10:2020-12-11,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=802 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012120020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sleepable iterator program have access to helper functions like bpf_d_pat=
h.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/lib/bpf/libbpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9be88a90a4aad..9204d12d04bf8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8535,6 +8535,11 @@ static const struct bpf_sec_def section_defs[] =3D=
 {
 		.expected_attach_type =3D BPF_TRACE_ITER,
 		.is_attach_btf =3D true,
 		.attach_fn =3D attach_iter),
+	SEC_DEF("iter.s/", TRACING,
+		.expected_attach_type =3D BPF_TRACE_ITER,
+		.is_attach_btf =3D true,
+		.is_sleepable =3D true,
+		.attach_fn =3D attach_iter),
 	BPF_EAPROG_SEC("xdp_devmap/",		BPF_PROG_TYPE_XDP,
 						BPF_XDP_DEVMAP),
 	BPF_EAPROG_SEC("xdp_cpumap/",		BPF_PROG_TYPE_XDP,
--=20
2.24.1

