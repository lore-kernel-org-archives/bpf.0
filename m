Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7F2C33CB1
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EA9207E0
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579185929;
	bh=v9XSHMwY4zRV2HP2e0bNBZ2kNH3h9xSoS9wOX3LfJyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s4Mklhvl2wOJe2uZFlk5gZFkezfInghvs5CJz0LDdZuSMG1VYkKys/NVgeOj0B9ui
	 qZjMiqv6ijZqDFgva718wv0rEU8rVieLObYfw71dBrzfs6r3FSJojgsFZyjczocnvf
	 WEINS+ke/Pcq8M0ZkvuKt3mi8H8V+KiIudjYKuHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgAPOp2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:45:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPOp2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:45:28 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CDA620684;
        Thu, 16 Jan 2020 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185928;
        bh=v9XSHMwY4zRV2HP2e0bNBZ2kNH3h9xSoS9wOX3LfJyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZmsfnjl/45yfEKSdW3gYOarkWTgBYTp1NCFZ0ZWJoxamfHp/pY0DZqEnA1pce2Pu
         oiiTZ1xkqZ8GaZ4b50ORoHpdXhWGOeDXprvArZuIJdebKMHF/QZN7HcSvo/75qeVLq
         wvEXzznDuHFyvOB8nuZCFV+KPdNA9jKDV/K+UfGY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [RFT PATCH 07/13] kprobes: Use normal list traversal API if a mutex is held
Date:   Thu, 16 Jan 2020 23:45:23 +0900
Message-Id: <157918592332.29301.1564446199611592837.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157918584866.29301.6941815715391411338.stgit@devnote2>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use normal list traversal API instead of rcu_read_lock,
RCU list traversal and rcu_read_unlock pair if a mutex
which protects the list is held in the methods of
kprobe_insn_cache.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 848c14e92ccc..09b0e33bc845 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -141,8 +141,7 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	/* Since the slot array is not protected by rcu, we need a mutex */
 	mutex_lock(&c->mutex);
  retry:
-	rcu_read_lock();
-	list_for_each_entry_rcu(kip, &c->pages, list) {
+	list_for_each_entry(kip, &c->pages, list) {
 		if (kip->nused < slots_per_page(c)) {
 			int i;
 			for (i = 0; i < slots_per_page(c); i++) {
@@ -150,7 +149,6 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 					kip->slot_used[i] = SLOT_USED;
 					kip->nused++;
 					slot = kip->insns + (i * c->insn_size);
-					rcu_read_unlock();
 					goto out;
 				}
 			}
@@ -159,7 +157,6 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 			WARN_ON(1);
 		}
 	}
-	rcu_read_unlock();
 
 	/* If there are any garbage slots, collect it and try again. */
 	if (c->nr_garbage && collect_garbage_slots(c) == 0)
@@ -244,8 +241,7 @@ void __free_insn_slot(struct kprobe_insn_cache *c,
 	long idx;
 
 	mutex_lock(&c->mutex);
-	rcu_read_lock();
-	list_for_each_entry_rcu(kip, &c->pages, list) {
+	list_for_each_entry(kip, &c->pages, list) {
 		idx = ((long)slot - (long)kip->insns) /
 			(c->insn_size * sizeof(kprobe_opcode_t));
 		if (idx >= 0 && idx < slots_per_page(c))
@@ -255,7 +251,6 @@ void __free_insn_slot(struct kprobe_insn_cache *c,
 	WARN_ON(1);
 	kip = NULL;
 out:
-	rcu_read_unlock();
 	/* Mark and sweep: this may sleep */
 	if (kip) {
 		/* Check double free */

