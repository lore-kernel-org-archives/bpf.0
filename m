Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F3DC43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C930820854
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gaq8B3dP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfCNLkh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:40:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35139 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfCNLkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 07:40:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id y15so2404506wma.0
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n4hL1tN1CEOGoCmqb01t2n9uqIM1W+sHW/nYFgLgWGs=;
        b=gaq8B3dP57hAaURx0vTz2Jandf2dIUX18YE0/hGZ8awEXNa41PjOwu/ETpC9u9GdGP
         YcmVdIP3DyklqHA5NcafDJSFwd5c/6cZJN+x3Ig6bSb/7aSA6Unt2z7gmtfK+nyra1vq
         NBk9rbh3ypOk0gKEdVEftm5xDMxmSLBoAAHZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n4hL1tN1CEOGoCmqb01t2n9uqIM1W+sHW/nYFgLgWGs=;
        b=OLKtGeA0BVtd86DccOsJTbFH8q2RQ1zHWDppVXtJyBcZTsyb4VMF9AdLh6Sf1HnKwn
         pk8NDJd91UA0fElUcyKU35bk6/X1aPLiJq+WX9jsOPm3T0tEGkLFWhoH2EcSCu8863I8
         yqEqdV7SC3VxSsxrDq0MCIiBGADa57iY43fpBYwbA4FHtFT6MSKYDf9rm2/JSXfifLvi
         NNQb7OeFk2u19YUYflOkW7Jjqm/WLG6QH7z51IlVrlzpir3wFVL3YuLlb2QOLB+xXcPL
         lK9GdNBVzQe9pHBHHXjfHk2seFchf9nfQJnVg2CjnC4vwoKY7gZQbC6OM1Kz14ljfnYV
         LcfQ==
X-Gm-Message-State: APjAAAWIVbl2dcUgsL7nQpZ5CdSaYkWYDNeaTOjpmwbRTdDEdv0KuUR/
        GOu1ZHanIRzU+9rk8D/8XI5O/Q==
X-Google-Smtp-Source: APXvYqyr2D0RodvZ3IJ70VdRTS8IkUgDH/dIEhGGI4yvAhKkJqrV54z8n9Go2ddeX5RMDXvBsz6zXw==
X-Received: by 2002:a1c:3842:: with SMTP id f63mr2238525wma.25.1552563634697;
        Thu, 14 Mar 2019 04:40:34 -0700 (PDT)
Received: from antares.lan (5.8.9.5.4.5.2.4.f.f.6.d.4.1.5.8.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:8514:d6ff:4254:5985])
        by smtp.gmail.com with ESMTPSA id a9sm1804017wmb.30.2019.03.14.04.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:40:33 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, theojulienne@github.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 1/8] bpf: track references based on is_acquire_func
Date:   Thu, 14 Mar 2019 11:39:47 +0000
Message-Id: <20190314113954.10210-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190314113954.10210-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190314113954.10210-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

So far, the verifier only acquires reference tracking state for
RET_PTR_TO_SOCKET_OR_NULL. Instead of extending this for every
new return type which desires these semantics, acquire reference
tracking state iff the called helper is an acquire function.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7c80f7f8f331..a52e723c8e5d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3147,19 +3147,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 	} else if (fn->ret_type == RET_PTR_TO_SOCKET_OR_NULL) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_SOCKET_OR_NULL;
-		if (is_acquire_function(func_id)) {
-			int id = acquire_reference_state(env, insn_idx);
-
-			if (id < 0)
-				return id;
-			/* For mark_ptr_or_null_reg() */
-			regs[BPF_REG_0].id = id;
-			/* For release_reference() */
-			regs[BPF_REG_0].ref_obj_id = id;
-		} else {
-			/* For mark_ptr_or_null_reg() */
-			regs[BPF_REG_0].id = ++env->id_gen;
-		}
+		regs[BPF_REG_0].id = ++env->id_gen;
 	} else if (fn->ret_type == RET_PTR_TO_TCP_SOCK_OR_NULL) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK_OR_NULL;
@@ -3170,9 +3158,19 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		return -EINVAL;
 	}
 
-	if (is_ptr_cast_function(func_id))
+	if (is_ptr_cast_function(func_id)) {
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
+	} else if (is_acquire_function(func_id)) {
+		int id = acquire_reference_state(env, insn_idx);
+
+		if (id < 0)
+			return id;
+		/* For mark_ptr_or_null_reg() */
+		regs[BPF_REG_0].id = id;
+		/* For release_reference() */
+		regs[BPF_REG_0].ref_obj_id = id;
+	}
 
 	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
 
-- 
2.19.1

