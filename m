Return-Path: <SRS0=j30r=B4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D024C433DF
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 16:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9252076E
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 16:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ClKmrYRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHRQYc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:24:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53370 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726974AbgHRQYU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Aug 2020 12:24:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07IGNaKp011824
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 09:24:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=WNlC6NtHElyUgrXwifo9sCuDjF4s4+LzDLnlnV7krG0=;
 b=ClKmrYRU5n9Moz39kWOneEy9BrD1/lGOEFrTZKeHE4vSKv77Uu8wk4o/U5bK7hooK5nT
 NFNEajRK4pw/nNPl/KuLfGVgkFPNPfi1rsWuSi9vPFtzzWLTUqXTfnUuzSJKmnK+c4DC
 cM+Ktl2/Rw2LCncG0QH764EhaXKj70Pb10s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3304p7unrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 09:24:13 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 18 Aug 2020 09:24:11 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 3E28E37036A5; Tue, 18 Aug 2020 09:24:08 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 0/2] bpf: two fixes for bpf task/task_file iterators
Date:   Tue, 18 Aug 2020 09:24:08 -0700
Message-ID: <20200818162408.836759-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_11:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=630
 clxscore=1015 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008180116
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Patch #1 fixed a rcu stall warning by adding proper cond_resched()
when traversing tasks or files.
Patch #2 calculated tid properly in a namespace in order to avoid
visiting the name task multiple times.

Yonghong Song (2):
  bpf: fix a rcu_sched stall issue with bpf task/task_file iterator
  bpf: avoid visit same object multiple times

 kernel/bpf/task_iter.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--=20
2.24.1

