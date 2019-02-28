Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5537BC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 17:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288AC218AE
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 17:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y4Qdnkf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbfB1RvI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:51:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37466 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732473AbfB1RvI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 12:51:08 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1SHcpNi094417;
        Thu, 28 Feb 2019 17:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=kzkTtUuhncYyvVyLHIcdoJsZcyYVhfhJFJPik9qu4Y4=;
 b=y4Qdnkf7KTOt4Ose3pwzUnSe1FTvyBBBUVuyWF4+oXQ7dCPv0elRYHXREbnUTQm8BMJF
 jtlMEa58u7u00yJfIU0ZQy9Gq62NOwRRiSc31t1eB56uGRnRRKmAsw48JecVKMubDLkK
 4lQ73lxxHhIJUGHtdWVXyqnEOEaJggQXRUFlnhewKAc2d3ofgo9njg6Iduwkzrbwmwvr
 +y6RAnyXXmnM5el96R34YH/B7K2ujzchpfRfCfJCQLTUFuXcc0N9cVO7OYNov7NqucOR
 /5i5VchabbK4ews/4Ddlfk8brbFd/bUpFuXTgoaPx4KHqQXbuZjVEZKJ9g7Ok/tBD0Tp gw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qtwkujnsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 17:50:46 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1SHoj0l020209
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 17:50:45 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1SHoif1009524;
        Thu, 28 Feb 2019 17:50:44 GMT
Received: from kadam (/197.157.0.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Feb 2019 09:50:44 -0800
Date:   Thu, 28 Feb 2019 20:50:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] tools/libbpf: signedness bug in btf_dedup_ref_type()
Message-ID: <20190228175035.GA30148@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34432d0-b838-c004-ef79-052cd50996c0@fb.com>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9181 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=978 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902280121
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

This goes through the BPF tree probably, although it does apply to
net-next.

 drivers/infiniband/ulp/iser/iscsi_iser.h | 2 +-
 tools/lib/bpf/btf.c                      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 120b40829560..ee7d3f6a666e 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -197,7 +197,7 @@ struct iser_data_buf {
 	struct scatterlist *sg;
 	int                size;
 	unsigned long      data_len;
-	unsigned int       dma_nents;
+	int		   dma_nents;
 };
 
 /* fwd declarations */
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

