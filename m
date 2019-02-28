Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A02C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 02:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5977920863
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 02:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551321050;
	bh=Iab5tha5WuupiGpwcT7YRGNqkvKv8h580kO3pSA8DYU=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=XS1i/ZcmacErsyHWBi2G2/UfeFEX+5n6/8g3eGmyReFGExMQrubBy88NArPxI5yNR
	 rdWLbIW2zCCY6ob9AzUZ7SigdH9KO1rqt5TRf+OW+pcVZ0x/L18wD1Vrb4xB9PoHi5
	 n8aaCCzXDaukNg36L498Qsw3XxMysbjq20HBKAOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfB1Cau convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 27 Feb 2019 21:30:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32910 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730341AbfB1Cat (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Feb 2019 21:30:49 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S2SgC9028306
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 18:30:48 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qx3exrnkd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 18:30:48 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 27 Feb 2019 18:30:46 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id C851E760BF3; Wed, 27 Feb 2019 18:30:44 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <sfr@canb.auug.org.au>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: fix build without bpf_syscall
Date:   Wed, 27 Feb 2019 18:30:44 -0800
Message-ID: <20190228023044.3802998-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

wrap bpf_stats_enabled sysctl with #ifdef

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 492ecee892c2 ("bpf: enable program stats")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/sysctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 86e0771352f2..7578e21a711b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -224,9 +224,11 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
 #endif
 static int proc_dopipe_max_size(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp, loff_t *ppos);
+#ifdef CONFIG_BPF_SYSCALL
 static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
 					  void __user *buffer, size_t *lenp,
 					  loff_t *ppos);
+#endif
 
 #ifdef CONFIG_MAGIC_SYSRQ
 /* Note: sysrq code uses its own private copy */
@@ -1232,7 +1234,6 @@ static struct ctl_table kern_table[] = {
 		.extra1		= &one,
 		.extra2		= &one,
 	},
-#endif
 	{
 		.procname	= "bpf_stats_enabled",
 		.data		= &sysctl_bpf_stats_enabled,
@@ -1242,6 +1243,7 @@ static struct ctl_table kern_table[] = {
 		.extra1		= &zero,
 		.extra2		= &one,
 	},
+#endif
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
 	{
 		.procname	= "panic_on_rcu_stall",
@@ -3272,6 +3274,7 @@ int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
 
 #endif /* CONFIG_PROC_SYSCTL */
 
+#ifdef CONFIG_BPF_SYSCALL
 static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
 					  void __user *buffer, size_t *lenp,
 					  loff_t *ppos)
@@ -3293,7 +3296,7 @@ static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
 	}
 	return ret;
 }
-
+#endif
 /*
  * No sense putting this after each symbol definition, twice,
  * exception granted :-)
-- 
2.20.0

