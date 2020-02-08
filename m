Return-Path: <SRS0=/2zk=34=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02030C35254
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 15:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B8922314
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581176594;
	bh=ZAbfmer89NHo6IyHm1sKqLmgXCLhLgyYmHUFfYmtYu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F2Hf7tt7F2K4gtXarobz1m8cgov0TZVfAW5CVAQiY5wdl8wM0ASiilFyKSz1NR7u5
	 svLohUkiczqmv1K7mw5zjZZBR23Mu2hP1T7afOlTOfA9fJqWsG32JtMEHEk8U678uR
	 ij4BvdABjwPP3nB1BXC9TUrTw34dhN0af4/wxI4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgBHPnO convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 8 Feb 2020 10:43:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42877 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727591AbgBHPnO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 8 Feb 2020 10:43:14 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-7bPdM3CtNmWEZytLkHEdMQ-1; Sat, 08 Feb 2020 10:43:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC7DA1800D42;
        Sat,  8 Feb 2020 15:43:08 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-79.brq.redhat.com [10.40.204.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3D325C28F;
        Sat,  8 Feb 2020 15:43:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [PATCH 14/14] bpf: Sort bpf kallsyms symbols
Date:   Sat,  8 Feb 2020 16:42:09 +0100
Message-Id: <20200208154209.1797988-15-jolsa@kernel.org>
In-Reply-To: <20200208154209.1797988-1-jolsa@kernel.org>
References: <20200208154209.1797988-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 7bPdM3CtNmWEZytLkHEdMQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently we don't sort bpf_kallsyms and display symbols
in proc/kallsyms as they come in via __bpf_ksym_add.

Using the latch tree to get the next bpf_ksym object
and insert the new symbol ahead of it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 50af5dcf7ff9..c63ff34b2128 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -651,9 +651,30 @@ static struct latch_tree_root bpf_progs_tree __cacheline_aligned;
 
 static void __bpf_ksym_add(struct bpf_ksym *ksym)
 {
+	struct list_head *head = &bpf_kallsyms;
+
 	WARN_ON_ONCE(!list_empty(&ksym->lnode));
-	list_add_tail_rcu(&ksym->lnode, &bpf_kallsyms);
 	latch_tree_insert(&ksym->tnode, &bpf_kallsyms_tree, &bpf_kallsyms_tree_ops);
+
+	/*
+	 * Add ksym into bpf_kallsyms in ordered position,
+	 * which is prepared for us by latch tree addition.
+	 *
+	 * Find out the next symbol and insert ksym right
+	 * ahead of it. If ksym is the last one, just tail
+	 * add to the bpf_kallsyms.
+	 */
+	if (!list_empty(&bpf_kallsyms)) {
+		struct rb_node *next = rb_next(&ksym->tnode.node[0]);
+
+		if (next) {
+			struct bpf_ksym *ptr;
+
+			ptr = container_of(next, struct bpf_ksym, tnode.node[0]);
+			head = &ptr->lnode;
+		}
+	}
+	list_add_tail_rcu(&ksym->lnode, head);
 }
 
 void bpf_ksym_add(struct bpf_ksym *ksym)
-- 
2.24.1

