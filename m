Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5699DC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0CE20850
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 14:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfDJOap (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:30:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60013 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732675AbfDJOao (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 10:30:44 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEEFN-0002Y9-I2; Wed, 10 Apr 2019 16:30:41 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] bpf: Use spinlock_t in lpm_trie
Date:   Wed, 10 Apr 2019 16:30:25 +0200
Message-Id: <20190410143025.11997-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410143025.11997-1-bigeasy@linutronix.de>
References: <20190410143025.11997-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no difference between spinlock_t and raw_spinlock_t for !RT
kernels. trie_update_elem() will allocate memory while holding ->lock
which is not possible on RT kernels.

Make the ->lock a spinlock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/bpf/lpm_trie.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 93a5cbbde421c..2ceb32452b594 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -37,7 +37,7 @@ struct lpm_trie {
 	size_t				n_entries;
 	size_t				max_prefixlen;
 	size_t				data_size;
-	raw_spinlock_t			lock;
+	spinlock_t			lock;
 };
 
 /* This trie implements a longest prefix match algorithm that can be used to
@@ -318,7 +318,7 @@ static int trie_update_elem(struct bpf_map *map,
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&trie->lock, irq_flags);
+	spin_lock_irqsave(&trie->lock, irq_flags);
 
 	/* Allocate and fill a new node */
 
@@ -425,7 +425,7 @@ static int trie_update_elem(struct bpf_map *map,
 		kfree(im_node);
 	}
 
-	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
+	spin_unlock_irqrestore(&trie->lock, irq_flags);
 
 	return ret;
 }
@@ -445,7 +445,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&trie->lock, irq_flags);
+	spin_lock_irqsave(&trie->lock, irq_flags);
 
 	/* Walk the tree looking for an exact key/length match and keeping
 	 * track of the path we traverse.  We will need to know the node
@@ -521,7 +521,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 	kfree_rcu(node, rcu);
 
 out:
-	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
+	spin_unlock_irqrestore(&trie->lock, irq_flags);
 
 	return ret;
 }
@@ -583,7 +583,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 	if (ret)
 		goto out_err;
 
-	raw_spin_lock_init(&trie->lock);
+	spin_lock_init(&trie->lock);
 
 	return &trie->map;
 out_err:
-- 
2.20.1

