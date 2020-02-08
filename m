Return-Path: <SRS0=/2zk=34=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AD5C352A1
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 15:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AEC2082E
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581176586;
	bh=ljnkCDVkrn2XiZnxaowLYIApTeOQPrlxcyBxI6VV54o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jwLNh2xGDy+AxChjDg8/NoxgpSU+oeUeiKfNwJ6m2g0wasJu3QNfq0BnL1vm+fzYZ
	 CGHT5/xYMYoEkpRxmEv7HcRHCJ+dAlmUoEnhDQj9+PGuo7OxqJHo/RHADwSHBtSu5B
	 iYyoJwWGuGtBVePbt50/HfVrWv4lLnje5M6t5Iog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBHPnG convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 8 Feb 2020 10:43:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727574AbgBHPnF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Feb 2020 10:43:05 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-nBi2I-omMnqZKroaQ9IxGQ-1; Sat, 08 Feb 2020 10:43:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07BFF100726F;
        Sat,  8 Feb 2020 15:42:59 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-79.brq.redhat.com [10.40.204.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35AFB5C21B;
        Sat,  8 Feb 2020 15:42:56 +0000 (UTC)
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
Subject: [PATCH 11/14] bpf: Rename bpf_tree to bpf_progs_tree
Date:   Sat,  8 Feb 2020 16:42:06 +0100
Message-Id: <20200208154209.1797988-12-jolsa@kernel.org>
In-Reply-To: <20200208154209.1797988-1-jolsa@kernel.org>
References: <20200208154209.1797988-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: nBi2I-omMnqZKroaQ9IxGQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Renaming bpf_tree to bpf_progs_tree and bpf_tree_ops
to bpf_progs_tree_ops to better capture the usage of
the tree, which is used for the bpf_prog objects only
for exception tables search.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 66b17bea286e..50af5dcf7ff9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -580,13 +580,14 @@ bpf_get_prog_addr_start(struct latch_tree_node *n)
 	return aux->ksym.start;
 }
 
-static __always_inline bool bpf_tree_less(struct latch_tree_node *a,
-					  struct latch_tree_node *b)
+static __always_inline bool
+bpf_progs_tree_less(struct latch_tree_node *a,
+		    struct latch_tree_node *b)
 {
 	return bpf_get_prog_addr_start(a) < bpf_get_prog_addr_start(b);
 }
 
-static __always_inline int bpf_tree_comp(void *key, struct latch_tree_node *n)
+static __always_inline int bpf_progs_tree_comp(void *key, struct latch_tree_node *n)
 {
 	unsigned long val = (unsigned long)key;
 	const struct bpf_prog_aux *aux;
@@ -601,9 +602,9 @@ static __always_inline int bpf_tree_comp(void *key, struct latch_tree_node *n)
 	return 0;
 }
 
-static const struct latch_tree_ops bpf_tree_ops = {
-	.less	= bpf_tree_less,
-	.comp	= bpf_tree_comp,
+static const struct latch_tree_ops bpf_progs_tree_ops = {
+	.less	= bpf_progs_tree_less,
+	.comp	= bpf_progs_tree_comp,
 };
 
 static __always_inline unsigned long
@@ -646,7 +647,7 @@ static const struct latch_tree_ops bpf_kallsyms_tree_ops = {
 static DEFINE_SPINLOCK(bpf_lock);
 static LIST_HEAD(bpf_kallsyms);
 static struct latch_tree_root bpf_kallsyms_tree __cacheline_aligned;
-static struct latch_tree_root bpf_tree __cacheline_aligned;
+static struct latch_tree_root bpf_progs_tree __cacheline_aligned;
 
 static void __bpf_ksym_add(struct bpf_ksym *ksym)
 {
@@ -706,7 +707,8 @@ void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 	bpf_get_prog_name(fp);
 
 	spin_lock_bh(&bpf_lock);
-	latch_tree_insert(&fp->aux->ksym_tnode, &bpf_tree, &bpf_tree_ops);
+	latch_tree_insert(&fp->aux->ksym_tnode, &bpf_progs_tree,
+			  &bpf_progs_tree_ops);
 	__bpf_ksym_add(&fp->aux->ksym);
 	spin_unlock_bh(&bpf_lock);
 }
@@ -717,7 +719,8 @@ void bpf_prog_kallsyms_del(struct bpf_prog *fp)
 		return;
 
 	spin_lock_bh(&bpf_lock);
-	latch_tree_erase(&fp->aux->ksym_tnode, &bpf_tree, &bpf_tree_ops);
+	latch_tree_erase(&fp->aux->ksym_tnode, &bpf_progs_tree,
+			 &bpf_progs_tree_ops);
 	__bpf_ksym_del(&fp->aux->ksym);
 	spin_unlock_bh(&bpf_lock);
 }
@@ -726,7 +729,8 @@ static struct bpf_prog *bpf_prog_kallsyms_find(unsigned long addr)
 {
 	struct latch_tree_node *n;
 
-	n = latch_tree_find((void *)addr, &bpf_tree, &bpf_tree_ops);
+	n = latch_tree_find((void *)addr, &bpf_progs_tree,
+			    &bpf_progs_tree_ops);
 	return n ?
 	       container_of(n, struct bpf_prog_aux, ksym_tnode)->prog :
 	       NULL;
-- 
2.24.1

