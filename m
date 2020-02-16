Return-Path: <SRS0=y2UD=4E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98F6C7619B
	for <bpf@archiver.kernel.org>; Sun, 16 Feb 2020 19:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67602084E
	for <bpf@archiver.kernel.org>; Sun, 16 Feb 2020 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581881453;
	bh=y6C2XzunqnsoPhz4Ua2WYjboWzp25Z+ayP7IMJrZOEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bkzxKWKpz1XIaiiP7j4QFrbUtz2pKLEPC4zfDjubqSBjRL3HBL9xAvk2HhCvl/Fut
	 Eo3+mRkFLOYfqH8Dv153FQoOcWaxeMWTJyTQkv0bUJ/nO94W4raCU3kJaobVq8XQd/
	 uSUlTt0J8bF7dZEr+nSXPfXB9UrU/Omc+QlDLIJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgBPTax convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sun, 16 Feb 2020 14:30:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47746 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727842AbgBPTax (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 16 Feb 2020 14:30:53 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-pxlWIaZZOnKLZwG0I9XutQ-1; Sun, 16 Feb 2020 14:30:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C93913E4;
        Sun, 16 Feb 2020 19:30:46 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79C9C8AC5B;
        Sun, 16 Feb 2020 19:30:42 +0000 (UTC)
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
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/18] bpf: Move bpf_tree add/del from bpf_prog_ksym_node_add/del
Date:   Sun, 16 Feb 2020 20:29:54 +0100
Message-Id: <20200216193005.144157-8-jolsa@kernel.org>
In-Reply-To: <20200216193005.144157-1-jolsa@kernel.org>
References: <20200216193005.144157-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: pxlWIaZZOnKLZwG0I9XutQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Moving bpf_tree add/del from bpf_prog_ksym_node_add/del,
because it will be used (and renamed) in following patches
for bpf_ksym objects. The bpf_tree is specific for bpf_prog
objects.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9fb08b4d01f7..2fc6b28291cf 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -652,7 +652,6 @@ static void bpf_prog_ksym_node_add(struct bpf_prog_aux *aux)
 {
 	WARN_ON_ONCE(!list_empty(&aux->ksym.lnode));
 	list_add_tail_rcu(&aux->ksym.lnode, &bpf_kallsyms);
-	latch_tree_insert(&aux->ksym_tnode, &bpf_tree, &bpf_tree_ops);
 	latch_tree_insert(&aux->ksym.tnode, &bpf_ksym_tree, &bpf_ksym_tree_ops);
 }
 
@@ -661,7 +660,6 @@ static void bpf_prog_ksym_node_del(struct bpf_prog_aux *aux)
 	if (list_empty(&aux->ksym.lnode))
 		return;
 
-	latch_tree_erase(&aux->ksym_tnode, &bpf_tree, &bpf_tree_ops);
 	latch_tree_erase(&aux->ksym.tnode, &bpf_ksym_tree, &bpf_ksym_tree_ops);
 	list_del_rcu(&aux->ksym.lnode);
 }
@@ -687,6 +685,7 @@ void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 	bpf_get_prog_name(fp);
 
 	spin_lock_bh(&bpf_lock);
+	latch_tree_insert(&fp->aux->ksym_tnode, &bpf_tree, &bpf_tree_ops);
 	bpf_prog_ksym_node_add(fp->aux);
 	spin_unlock_bh(&bpf_lock);
 }
@@ -697,6 +696,7 @@ void bpf_prog_kallsyms_del(struct bpf_prog *fp)
 		return;
 
 	spin_lock_bh(&bpf_lock);
+	latch_tree_erase(&fp->aux->ksym_tnode, &bpf_tree, &bpf_tree_ops);
 	bpf_prog_ksym_node_del(fp->aux);
 	spin_unlock_bh(&bpf_lock);
 }
-- 
2.24.1

