Return-Path: <SRS0=/2zk=34=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7B8C352A1
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 15:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771542253D
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581176582;
	bh=DP1OHmMSmFCIl9z0E6jyTwTY+bdho1z1pUNjrvVh/bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J+Evcfze3M0Rc0xVdPbuLvP9sfalLe9vz0bL0oxbUDOCdgA1h8dnMs8eGZqwRfLnt
	 F7AGcW4VW4sSyOUEi7/5OsYYayPzqVQiB1qQnVvCQR62TzLgR6djtCeO30nO5+KfgT
	 kAF+PK/wYC9uUoyWa+EmR8PX8yHwLuA7Eh0wMTXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBHPnC convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 8 Feb 2020 10:43:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29714 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727559AbgBHPnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Feb 2020 10:43:01 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-HyJJIwAUNOCmXiVbmAIorA-1; Sat, 08 Feb 2020 10:42:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 778598014CE;
        Sat,  8 Feb 2020 15:42:52 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-79.brq.redhat.com [10.40.204.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A44685C28F;
        Sat,  8 Feb 2020 15:42:49 +0000 (UTC)
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
Subject: [PATCH 09/14] bpf: Add bpf_ksym_add/del functions
Date:   Sat,  8 Feb 2020 16:42:04 +0100
Message-Id: <20200208154209.1797988-10-jolsa@kernel.org>
In-Reply-To: <20200208154209.1797988-1-jolsa@kernel.org>
References: <20200208154209.1797988-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: HyJJIwAUNOCmXiVbmAIorA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding bpf_ksym_add/del functions as locked version
for __bpf_ksym_add/del. It will be used in following
patches for bpf_trampoline and bpf_dispatcher.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h |  3 +++
 kernel/bpf/core.c   | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 151d7b1c8435..7a4626c8e747 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -573,6 +573,9 @@ struct bpf_image {
 #define BPF_IMAGE_SIZE (PAGE_SIZE - sizeof(struct bpf_image))
 bool is_bpf_image_address(unsigned long address);
 void *bpf_image_alloc(void);
+/* Called only from code, so there's no need for stubs. */
+void bpf_ksym_add(struct bpf_ksym *ksym);
+void bpf_ksym_del(struct bpf_ksym *ksym);
 #else
 static inline struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ee082c79ac99..73242fd07893 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -655,6 +655,13 @@ static void __bpf_ksym_add(struct bpf_ksym *ksym)
 	latch_tree_insert(&ksym->tnode, &bpf_kallsyms_tree, &bpf_kallsyms_tree_ops);
 }
 
+void bpf_ksym_add(struct bpf_ksym *ksym)
+{
+	spin_lock_bh(&bpf_lock);
+	__bpf_ksym_add(ksym);
+	spin_unlock_bh(&bpf_lock);
+}
+
 static void __bpf_ksym_del(struct bpf_ksym *ksym)
 {
 	if (list_empty(&ksym->lnode))
@@ -664,6 +671,13 @@ static void __bpf_ksym_del(struct bpf_ksym *ksym)
 	list_del_rcu(&ksym->lnode);
 }
 
+void bpf_ksym_del(struct bpf_ksym *ksym)
+{
+	spin_lock_bh(&bpf_lock);
+	__bpf_ksym_del(ksym);
+	spin_unlock_bh(&bpf_lock);
+}
+
 static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
 {
 	return fp->jited && !bpf_prog_was_classic(fp);
-- 
2.24.1

