Return-Path: <SRS0=z+Sy=3C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAE9C33CAE
	for <bpf@archiver.kernel.org>; Mon, 13 Jan 2020 07:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE93207FF
	for <bpf@archiver.kernel.org>; Mon, 13 Jan 2020 07:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ama4yWB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAMHbx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:31:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728810AbgAMHbx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Jan 2020 02:31:53 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00D7R2O4003110
        for <bpf@vger.kernel.org>; Sun, 12 Jan 2020 23:31:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=jGkJgb9d7SiQELqF2hmCjZQtNXuJanXQbJxx1tDRqgU=;
 b=ama4yWB23o0ItF1J92JS6WCWgr9cgbh6KVCIP2chOS9AmjphJvmOzvGsk+BkEs4KVnpO
 kq4a/TLYJW5MEX/IZnvWj8AvmF3O+J2wlvuBEchFwZCkOxrW0+oW2PBAIbjP6aYk6Ezg
 CanURDvcWkuiEaNc9q3lvIfq2FxxokXHf20= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2xfar46v9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 12 Jan 2020 23:31:52 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sun, 12 Jan 2020 23:31:51 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 7C4A92EC2329; Sun, 12 Jan 2020 23:31:50 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 1/6] tools: sync uapi/linux/if_link.h
Date:   Sun, 12 Jan 2020 23:31:38 -0800
Message-ID: <20200113073143.1779940-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113073143.1779940-1-andriin@fb.com>
References: <20200113073143.1779940-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_01:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=894 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=8
 phishscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001130062
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync uapi/linux/if_link.h into tools to avoid out of sync warnings during
libbpf build.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/include/uapi/linux/if_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 8aec8769d944..1d69f637c5d6 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -169,6 +169,7 @@ enum {
 	IFLA_MAX_MTU,
 	IFLA_PROP_LIST,
 	IFLA_ALT_IFNAME, /* Alternative ifname */
+	IFLA_PERM_ADDRESS,
 	__IFLA_MAX
 };
 
-- 
2.17.1

