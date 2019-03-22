Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D295EC43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22A3218FC
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CxQzIgv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfCVBy1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:54:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45531 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfCVBy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 21:54:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so325694pgk.12
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 18:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZY4iMerFf3oc3fyXl4BxDRKcJ+uuJ5mc1g/4bPlNws=;
        b=CxQzIgv/1BV0szdswL32lV97Oe20rEXDU5VsiqxwGvlDGFF4FKb4KsbEfsLARHX+3Q
         qITlE/52GTmHTw5miTCpzxLebLWOCGtDp2EFQjHs8FyFQkiMBp4K3nem58P+gBwvYMEq
         u0rIM9gDjVs3x6WaQ+vYeTEWUcJPZGAMNOIT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZY4iMerFf3oc3fyXl4BxDRKcJ+uuJ5mc1g/4bPlNws=;
        b=gcXUZDKSLzBxHNJqxgQg7cumyO20h4ip2+Cr1D7wR6d/II4o+YbD82DugNdWf2lIxH
         WbOC0D7QoGaY3fM20aZds3t6DgGjk5AVIAPCgwkTKJFmYNyQkiVa59Zk1bur0UN/KG+Q
         ad3Fe5j+O5UsZiEbUAxlrU7nojsHdgdnMcUh5W0bzfj6LyUkoZXvHa4MoKdHp0o5C/zL
         6h26768TDtCnrccv3Kh3nJe1bLLSo2Nt/GUwa1mbKHus3MrY/3ietS3JirflfvIP5Nmm
         Zh7aOEAyx96lOcPrrAgrVYykVQmznLZ7EVmMsLZzPXYZcvZnIC2GQlv3r0kyGvZr8DZl
         +lYA==
X-Gm-Message-State: APjAAAV6XxugPuJqDwKDfJASfhwbwn4efQ0ebxOFOzK4RBj+jkSrUy0g
        AaM5vanZQgMNvOIJ58MJvc5eD6LvqEYNTw==
X-Google-Smtp-Source: APXvYqzJbqBWmUZ9WA3da8Hzr8owuV/cfFhx1Ie5ZQzDkJgS6dOF+TROS94nSq6aV5nbC6wq/6K/tg==
X-Received: by 2002:a62:7049:: with SMTP id l70mr6607371pfc.78.1553219666394;
        Thu, 21 Mar 2019 18:54:26 -0700 (PDT)
Received: from localhost.localdomain ([157.120.241.186])
        by smtp.gmail.com with ESMTPSA id i10sm7161799pgs.26.2019.03.21.18.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:54:25 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 1/8] bpf: track references based on is_acquire_func
Date:   Fri, 22 Mar 2019 09:53:59 +0800
Message-Id: <20190322015406.26453-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190322015406.26453-1-lmb@cloudflare.com>
References: <20190319102103.7380-1-lmb@cloudflare.com>
 <20190322015406.26453-1-lmb@cloudflare.com>
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
index 86f9cd5d1c4e..868a82ad5597 100644
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

