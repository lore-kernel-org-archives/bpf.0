Return-Path: <SRS0=ovpu=UL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42159C31E46
	for <bpf@archiver.kernel.org>; Wed, 12 Jun 2019 17:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F903208CA
	for <bpf@archiver.kernel.org>; Wed, 12 Jun 2019 17:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5ro5SJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409549AbfFLRas (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:30:48 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:54703 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409542AbfFLRas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jun 2019 13:30:48 -0400
Received: by mail-pg1-f201.google.com with SMTP id c4so11782942pgm.21
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2019 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4JPge5G2892WNESlZ4eKnrVnH6/giL39WrMPoTXaExc=;
        b=h5ro5SJSnYzly27OdyE30z6LzTma1LfkgfmjQgh0ex07SM0R4CD8A54tdyKC+Xi+ej
         qM6TgeX24RNNPtcXMnryV6SNqePdy6DqDJCAWv1jlKhlZq0tCHQmlIqDKDyO5l2HX8zl
         rTMoFZtpxRzF2alb51rReatA6TefokA51mk2dEPkRY+BfUu9PedZ9oXJSTkn/hIhTJAa
         vnYaEuGd/hyVdI5z0hsLPb+nV/sUX0c3rZ7emIA++iDd62Y94+lgZRlYDTq/O3zAhJLY
         6HXs4wQfFiOCLBkLLSWOBzCpo52eawcLd8I9H1VmcipR4XTOUkFrevWSewhdyCiK7VEk
         uvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4JPge5G2892WNESlZ4eKnrVnH6/giL39WrMPoTXaExc=;
        b=CxkVFanzQvciYsazz7LTA+jNRBXzOHckY1ZJMdA3A4YLialRw3ewfIHx6N3xDRY0w3
         kv9dnlT5tT7dqYfBAoTDUDlSBfTf13C2uCmVq/6v2klcr8Mwn6MqNU6p3fygG0kYdxbD
         PM7ss2Xxa+vsBgegq3v+T+zBzNJX1NI/0UvxDTH5eQy/5o0D/ECPEYLu27FWesIZYdQu
         KizXeH+E/WGVbSRqzOAcn/Jx+Y6f0jr70pho3OoxtSxacgRtpc66pQVUEh/1MtmbLzFv
         s9AOUuYU3cwmRB3Q9C4qOw355KuxpRjGmezAx64qgSy8JH+UsQQikpFA9+DjC1ggXMhs
         MOfg==
X-Gm-Message-State: APjAAAUAOkS3dsXeOdv5alRKqKX7hmidZe9tGyD2sDJtL4SX8nhuVv9y
        ZanaDPwsUgFzAGgfu9FPG0sbv3A=
X-Google-Smtp-Source: APXvYqyANjMixR1tbGgJel7+CTGj1C+KeoiYGS1TEl5Ypy6xE9mZe2jqZyRjazQiFsS4LGrx0W3wktU=
X-Received: by 2002:a63:2c50:: with SMTP id s77mr25809188pgs.175.1560360647932;
 Wed, 12 Jun 2019 10:30:47 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:30:39 -0700
In-Reply-To: <20190612173040.61944-1-sdf@google.com>
Message-Id: <20190612173040.61944-3-sdf@google.com>
Mime-Version: 1.0
References: <20190612173040.61944-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH bpf-next 3/4] bpf/tools: sync bpf.h
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add sk to struct bpf_sock_addr and struct bpf_sock_ops.

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ae0907d8c03a..d0a23476f887 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3247,6 +3247,7 @@ struct bpf_sock_addr {
 	__u32 msg_src_ip6[4];	/* Allows 1,2,4-byte read an 4-byte write.
 				 * Stored in network byte order.
 				 */
+	__bpf_md_ptr(struct bpf_sock *, sk);
 };
 
 /* User bpf_sock_ops struct to access socket values and specify request ops
@@ -3298,6 +3299,7 @@ struct bpf_sock_ops {
 	__u32 sk_txhash;
 	__u64 bytes_received;
 	__u64 bytes_acked;
+	__bpf_md_ptr(struct bpf_sock *, sk);
 };
 
 /* Definitions for bpf_sock_ops_cb_flags */
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

