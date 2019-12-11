Return-Path: <SRS0=sz96=2B=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F39CC43603
	for <bpf@archiver.kernel.org>; Wed, 11 Dec 2019 22:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5455422B48
	for <bpf@archiver.kernel.org>; Wed, 11 Dec 2019 22:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lB/oei63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLKWee (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:34:34 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:49972 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfLKWee (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:34 -0500
Received: by mail-pj1-f73.google.com with SMTP id ck20so56805pjb.16
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2019 14:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5AhdXmPKS0JiQuHlniKRJHWxS22JqYuwMDsvrT9JMfs=;
        b=lB/oei63/sAcH89+V93til6fN/6F4X/UcwDCuMEW2z20zvLpRYxp6tbM7sW3X9BZlo
         /QtDi+qmTeJzFlCzIUcXsgjp2JA+qx9E7EvVKpKIHAy+hvQQSdzV5jPGAe0Wa8bmPB3y
         7eweDWffEI1IaCtN/Fp0OtuL6QF+RNRC73BGNLZtoqCuB8LZEHimoYzhFMpIy5kqEYFC
         X5bc13g9GwWLNfQMaZG+MoifnE9u3uLUqdRDboe309tfHmdqzpkbZP8zcnbNIf9waAUo
         qxMp3jfxIub34hDAOim4pcHB1e92YhnZHAYJYSWAQcrmYrwomrFCrwX+8Axu3BN7PXEd
         fvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5AhdXmPKS0JiQuHlniKRJHWxS22JqYuwMDsvrT9JMfs=;
        b=XNs1yxmojO5cFhKyKsbvucESyLQDooiEQraOO+nUAQ6387JS9KxdK9lRkJuIjZJOPq
         qmC9Scy7ekWvHIvQ4CjXtEKmild6XVBNZyNUCGj/8h7ETk3sdf311xoSXHKFcptOntB3
         +bmZRDGC8mcEmugwG/4PRHBhO4i5DEYHUuXXhfMUxxhdQSTuPbJVjDo4ntDA4YVP/r26
         +O3sNqjUJ1xi6FBg02gg21oagBcPD9/JvDInKYL1uhpef+XvXvVOfV65CjOMNP/4ABSZ
         EcXfrtoiUBFQlhhQABCHiBlf/aKNaVgFf3z4+PBi/uJywePXyNnnxBMOVpB18l2iyMtq
         2eTg==
X-Gm-Message-State: APjAAAVk6ForzQSzNlSHlYfiDetoggWgqNm5jS0aaMKyPqsmZvoZSr4y
        Koxu1JQbYyNbpeAGMjfrkU7Dv+u2aHwl
X-Google-Smtp-Source: APXvYqzvLtomxTN9fAdNSflYuVsHsM/b3e23KaWeDADeXX0GG4+Yzq5XdJNQgJpdumTdY/7TVwHiMmaC4rnx
X-Received: by 2002:a65:4c06:: with SMTP id u6mr7000062pgq.412.1576103673604;
 Wed, 11 Dec 2019 14:34:33 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:33:38 -0800
In-Reply-To: <20191211223344.165549-1-brianvv@google.com>
Message-Id: <20191211223344.165549-6-brianvv@google.com>
Mime-Version: 1.0
References: <20191211223344.165549-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 bpf-next 05/11] bpf: add generic_batch_ops to lpm_trie map
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds the generic batch ops functionality to bpf lpm_trie.

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 kernel/bpf/lpm_trie.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 56e6c75d354d9..92c47b4f03337 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -743,4 +743,8 @@ const struct bpf_map_ops trie_map_ops = {
 	.map_update_elem = trie_update_elem,
 	.map_delete_elem = trie_delete_elem,
 	.map_check_btf = trie_check_btf,
+	.map_lookup_batch = generic_map_lookup_batch,
+	.map_lookup_and_delete_batch = generic_map_lookup_and_delete_batch,
+	.map_delete_batch = generic_map_delete_batch,
+	.map_update_batch = generic_map_update_batch,
 };
-- 
2.24.1.735.g03f4e72817-goog

