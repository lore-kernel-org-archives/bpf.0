Return-Path: <SRS0=/2zk=34=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DFBC35250
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 15:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108BE22464
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581176580;
	bh=xV2fnQ04DWVZnB3pstlAkw/PtgQFMKSpt5fDPB8sHeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WIdLYwOzfWJEJfLOOLdt4CaCwlnMSTE8VrMaQZbmpyc5HYe/0QAc48961G4CLm0y2
	 wB2/G7984KSGNujVQ5xY2WZA5XZKvT0lYCNwj6P3kibXmkGzLTct8jcGmtV6J99TdN
	 BSqcvHUxdW5hdrscO25kt1Y2YgxSz1TgZzQM03Rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgBHPm7 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 8 Feb 2020 10:42:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26967 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727527AbgBHPm7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Feb 2020 10:42:59 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-9hSWATo-PHOSsWW2Or6T6g-1; Sat, 08 Feb 2020 10:42:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A4151800D42;
        Sat,  8 Feb 2020 15:42:49 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-79.brq.redhat.com [10.40.204.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6ADB95C21B;
        Sat,  8 Feb 2020 15:42:46 +0000 (UTC)
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
Subject: [PATCH 08/14] bpf: Separate kallsyms add/del functions
Date:   Sat,  8 Feb 2020 16:42:03 +0100
Message-Id: <20200208154209.1797988-9-jolsa@kernel.org>
In-Reply-To: <20200208154209.1797988-1-jolsa@kernel.org>
References: <20200208154209.1797988-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 9hSWATo-PHOSsWW2Or6T6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Moving bpf_prog_ksym_node_add/del to __bpf_ksym_add/del
and changing the argument to 'struct bpf_ksym' object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f4c16b362858..ee082c79ac99 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -648,20 +648,20 @@ static LIST_HEAD(bpf_kallsyms);
 static struct latch_tree_root bpf_kallsyms_tree __cacheline_aligned;
 static struct latch_tree_root bpf_tree __cacheline_aligned;
 
-static void bpf_prog_ksym_node_add(struct bpf_prog_aux *aux)
+static void __bpf_ksym_add(struct bpf_ksym *ksym)
 {
-	WARN_ON_ONCE(!list_empty(&aux->ksym.lnode));
-	list_add_tail_rcu(&aux->ksym.lnode, &bpf_kallsyms);
-	latch_tree_insert(&aux->ksym.tnode, &bpf_kallsyms_tree, &bpf_kallsyms_tree_ops);
+	WARN_ON_ONCE(!list_empty(&ksym->lnode));
+	list_add_tail_rcu(&ksym->lnode, &bpf_kallsyms);
+	latch_tree_insert(&ksym->tnode, &bpf_kallsyms_tree, &bpf_kallsyms_tree_ops);
 }
 
-static void bpf_prog_ksym_node_del(struct bpf_prog_aux *aux)
+static void __bpf_ksym_del(struct bpf_ksym *ksym)
 {
-	if (list_empty(&aux->ksym.lnode))
+	if (list_empty(&ksym->lnode))
 		return;
 
-	latch_tree_erase(&aux->ksym.tnode, &bpf_kallsyms_tree, &bpf_kallsyms_tree_ops);
-	list_del_rcu(&aux->ksym.lnode);
+	latch_tree_erase(&ksym->tnode, &bpf_kallsyms_tree, &bpf_kallsyms_tree_ops);
+	list_del_rcu(&ksym->lnode);
 }
 
 static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
@@ -686,7 +686,7 @@ void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 
 	spin_lock_bh(&bpf_lock);
 	latch_tree_insert(&fp->aux->ksym_tnode, &bpf_tree, &bpf_tree_ops);
-	bpf_prog_ksym_node_add(fp->aux);
+	__bpf_ksym_add(&fp->aux->ksym);
 	spin_unlock_bh(&bpf_lock);
 }
 
@@ -697,7 +697,7 @@ void bpf_prog_kallsyms_del(struct bpf_prog *fp)
 
 	spin_lock_bh(&bpf_lock);
 	latch_tree_erase(&fp->aux->ksym_tnode, &bpf_tree, &bpf_tree_ops);
-	bpf_prog_ksym_node_del(fp->aux);
+	__bpf_ksym_del(&fp->aux->ksym);
 	spin_unlock_bh(&bpf_lock);
 }
 
-- 
2.24.1

