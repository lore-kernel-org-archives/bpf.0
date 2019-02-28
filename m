Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9570DC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6957B20863
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qh9UsEC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbfB1SHW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:07:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42968 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfB1SHW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 13:07:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1SHwoT2112994;
        Thu, 28 Feb 2019 18:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=e8cuSMex66hmLUuGTCLEgfNto/vUtTFmF8L73UNbtE0=;
 b=Qh9UsEC4+MwisvsL4shAO0wHC5S4qtTGmLocZjXzdAMgpuompG1WelV9eUO/SxFUqh5K
 mywWoGR2qx7N1zw1geSa5Ik91kkAonMUXaJS6G8bg4M3w+4sPeKlq4qN4l1Zp2zflv5O
 9qOZKzm5cfjXjZmBEnsgZYLbOW2VPXlIGjeYIEkM2wiUfpUL+2DHzp643YZCMlUZvbIa
 azJTdpFVE4NH/V0mAv/dOoBXh2soOwXu1fWxTE1L6CDlOZ8AQzUY6QBQJ5htw3/MpCGu
 lG8Qz8M4GYZ1U4ALvKAShSQT040fi+Ex7JiwgscbZ+ShMRWrRKh+ozmdEw1LoVmD4yHD 8A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qtxts2mt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 18:07:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1SI6wdv010937
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 18:06:59 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1SI6v1F007256;
        Thu, 28 Feb 2019 18:06:58 GMT
Received: from kadam (/197.157.0.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Feb 2019 10:06:57 -0800
Date:   Thu, 28 Feb 2019 21:06:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v3] tools/libbpf: signedness bug in btf_dedup_ref_type()
Message-ID: <20190228180647.GF9806@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34432d0-b838-c004-ef79-052cd50996c0@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9181 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902280122
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The "ref_type_id" variable needs to be signed for the error handling
to work.

Fixes: d5caef5b5655 ("btf: add BTF types deduplication algorithm")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
v2: Use reverse Christmas tree style
v3: Remove the bonus fix.

This goes through the BPF tree probably, although it does apply to
net-next.

 tools/lib/bpf/btf.c                      | 3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 68b50e9bbde1..00a2f06e38fd 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2326,7 +2326,8 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 	struct btf_type *t, *cand;
 	/* if we don't find equivalent type, then we are representative type */
 	__u32 new_id = type_id;
-	__u32 h, ref_type_id;
+	int ref_type_id;
+	__u32 h;
 
 	if (d->map[type_id] == BTF_IN_PROGRESS_ID)
 		return -ELOOP;
-- 
2.17.1
