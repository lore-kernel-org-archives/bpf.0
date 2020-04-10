Return-Path: <SRS0=/MlC=52=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C529C2BB55
	for <bpf@archiver.kernel.org>; Fri, 10 Apr 2020 19:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BBC2083E
	for <bpf@archiver.kernel.org>; Fri, 10 Apr 2020 19:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lbWba+Ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJTya (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:54:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54382 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgDJTy3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Apr 2020 15:54:29 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AJncMR015731
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 12:54:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Pg3fVtpnkPW580THJ0VkYyvIf9sqwRgRbdNnZhX8AnY=;
 b=lbWba+Ugz0ILPcx39QsZJ5d+LCUZC9V7Qvr7OjkPE9DBM4NVgHTIt4O7gRbhporFId3J
 H2mmK2OzNJkt672xJK4R09RjCmjJh3kIuPhi7N2AMMQSVyRmRQSC9X4NvbabeWE+LMqX
 bmh6GsSmp7DtUSs4jFdIG+rf6yn3U51hC7Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30atqk1u1f-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 12:54:29 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 10 Apr 2020 12:54:27 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 1954D37007ED; Fri, 10 Apr 2020 12:54:16 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf 0/2] libbpf: Fix loading cgroup_skb/egress with ret in [2, 3]
Date:   Fri, 10 Apr 2020 12:53:59 -0700
Message-ID: <cover.1586547735.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_08:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 suspectscore=13 priorityscore=1501 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 mlxlogscore=551 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100146
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set fixes loading cgroup_skb egress programs that return value=
s
2 or 3 and adds selftest for newly added section name.

See patch 1 for details on the fix.


Andrey Ignatov (2):
  libbpf: Fix loading cgroup_skb/egress with ret in [2, 3]
  selftests/bpf: Test cgroup_skb/egress/expected section name

 tools/lib/bpf/libbpf.c                                 | 2 ++
 tools/testing/selftests/bpf/prog_tests/section_names.c | 5 +++++
 2 files changed, 7 insertions(+)

--=20
2.24.1

