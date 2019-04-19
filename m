Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91CEC282DA
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CBB205ED
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555700329;
	bh=vtojSE/Szq3iFi7Rs36qb3/w2h1mHKmlacuxVMdLz9E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jLTttRZcDws4AVYFI/64BAHaDss17PxMV7v+MJWCgeRCWA6o2DD4JN/M5O/yTJJTH
	 8AUiAzSSXjFZrI7YvYFIHTFg6z/OQBDuAfEmQJlAFUAXvO/FyPAfMzRDeGgbYXCNUh
	 HEWs0MJP6R2tCD67WVWsmqtoO3PhIPt0CWWQPmwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfDSS6t convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 19 Apr 2019 14:58:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46036 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727665AbfDSS6s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Apr 2019 14:58:48 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JEj86d023535
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 07:45:36 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rxyd0tv1c-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 07:45:35 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 19 Apr 2019 07:45:00 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 8975F7605DE; Fri, 19 Apr 2019 07:44:59 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/2] bpf: drop bpf_verifier_lock
Date:   Fri, 19 Apr 2019 07:44:55 -0700
Message-ID: <20190419144455.853134-3-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190419144455.853134-1-ast@kernel.org>
References: <20190419144455.853134-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Drop bpf_verifier_lock for root to avoid being DoS-ed by unprivileged.
The BPF verifier is now fully parallel.
All unpriv users are still serialized by bpf_verifier_lock to avoid
exhausting kernel memory by running N parallel verifications.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5f0eb5bd5589..423f242a5efb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8132,9 +8132,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
+	is_priv = capable(CAP_SYS_ADMIN);
 
 	/* grab the mutex to protect few globals used by verifier */
-	mutex_lock(&bpf_verifier_lock);
+	if (!is_priv)
+		mutex_lock(&bpf_verifier_lock);
 
 	if (attr->log_level || attr->log_buf || attr->log_size) {
 		/* user requested verbose verifier output
@@ -8157,7 +8159,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
 		env->strict_alignment = false;
 
-	is_priv = capable(CAP_SYS_ADMIN);
 	env->allow_ptr_leaks = is_priv;
 
 	ret = replace_map_fd_with_map_ptr(env);
@@ -8270,7 +8271,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 		release_maps(env);
 	*prog = env->prog;
 err_unlock:
-	mutex_unlock(&bpf_verifier_lock);
+	if (!is_priv)
+		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
 	kfree(env);
-- 
2.20.0

