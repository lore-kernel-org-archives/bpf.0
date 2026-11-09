Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254124;
	b=yXSgMDGUdhTBnM06Iryn6+Q3vGPaoMRy4GhzpLDwaXwIH9BSPoFDRpBBaAa4E5XyNCmb
	 AfB4LXqDwsMHpgbvY1R+WxG/A3wRtgwh5EjR42udkMYQ2rx2pYqycCIE07joRfgJkiQvb
	 ef0FJmJEev4fGU5bDmATiNfAD1qIauSnyOxOpxFQYro1HyTm2oAriqF0/i2MXcNSwHr/J
	 qEZ+pWfZD9abIJdEbFEzpSLUzaiRMKIZIzznkd0KoDhZUQxcRKlmBWH6mPWs5ZkT8eBxE
	 YwJQcB8jrV9wuqhMUOsw4VwO/joo5gaoBSeImvvlY6X48imd6Jhr8KwyrcwkDGiKA2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254124;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6nacvov+Xt10hjpdaeu8lh7BbBb3QCZxW68Z63/3sQA=;
	b=4UK7eTcK/GIuyeI0Njna/ef7/r91bwhPoj8f+sfvrRR53Ct/ie3JdUtKSCM5NpKh3Cl1
	 nLlnTN5Ci6MYFrxb1rInUfLj89ootCLe241ROZDoF7wCI8GKeSC+4Ioe9w2EqEauejfcm
	 taKeTBYY3RXSoqCo9Es2ss24Zb9aaiGXAU2frw3dz5K4SmB85xU0zZcg1rWm4DUtO4BDh
	 YXkRBNahhYVfhko8hVnwWV9ic2OizwEoAuPKApo7U6bvvMH7xiheHl4Z11vhBszXguIoh
	 gAYCIn/BbzoxXVMdeIX4sKtp8J/ruKxXc7QSZCeAGOWtd0GDwMeiA+RGqL8wlfGBY0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcM6orzu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44B60A2624;
	Mon,  9 Nov 2026 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcM6orzu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9E61F008BC;
	Mon,  9 Nov 2026 19:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254123;
	bh=6nacvov+Xt10hjpdaeu8lh7BbBb3QCZxW68Z63/3sQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kcM6orzuNroJokHJn0PDLLJCxQ6uJveDk/K78cGPhuvOwgPBl01mVY5QmL9Xd4JTU
	 LIThQFymFmJ42o7sY19pWalzMGN969vFleNSnq45Ku2lCJt6ZSXc8pdIjORrr+tMKs
	 eKCi9sES1NpqhtnREmh0gMwU7RUxJWrMiJ8A4gKSixModmFrCQhwuT20pCEkGpNo2E
	 T53B/IffZiGgiYlO5FOP8SeGcXOtu0c3X2jYtxeU1g6zXo+aOiTViPDr96zOWsjdzC
	 hEj1gVf0ZhdyXU39jrQg1vtqjyy6jD02Es67YkkXw/daDSyRaMUH7euAjPgqiBf0E+
	 EHiDTw7Ip4K0Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alan Maguire <almagui@kernel.org>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 04/13] kprobes: Maintain an rbtree of registered probes
Date: Mon,  9 Nov 2026 20:55:17 +0100
Message-ID: <20261109195517.1090787-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194916.1089703-1-jolsa@kernel.org>
References: <20261109194916.1089703-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an address-ordered rbtree for registered probes. Keep it synchronized
with the hash table when probes are added, removed, or replaced by
aggregator probes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/kprobes.h |  2 ++
 kernel/kprobes.c        | 49 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e6de7ae55bda..6f16cc01a16c 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -28,6 +28,7 @@
 #include <linux/ftrace.h>
 #include <linux/objpool.h>
 #include <linux/rethook.h>
+#include <linux/rbtree.h>
 #include <asm/kprobes.h>
 
 #ifdef CONFIG_KPROBES
@@ -58,6 +59,7 @@ typedef int (*kretprobe_handler_t) (struct kretprobe_instance *,
 
 struct kprobe {
 	struct hlist_node hlist;
+	struct rb_node rb_node;
 
 	/* list of kprobes for multi-handler support */
 	struct list_head list;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2441b9e39343..6be1430a4ebe 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -64,6 +64,7 @@ static int kprobes_initialized;
  * - RCU hlist traversal under disabling preempt (breakpoint handlers)
  */
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
+static struct rb_root kprobe_tree = RB_ROOT;
 
 /* NOTE: change this value only with 'kprobe_mutex' held */
 static bool kprobes_all_disarmed;
@@ -395,6 +396,45 @@ struct kprobe *get_kprobe(void *addr)
 }
 NOKPROBE_SYMBOL(get_kprobe);
 
+static void kprobe_tree_insert(struct kprobe *p)
+{
+	struct rb_node **link = &kprobe_tree.rb_node, *parent = NULL;
+	unsigned long addr = (unsigned long)p->addr;
+
+	lockdep_assert_held(&kprobe_mutex);
+	while (*link) {
+		struct kprobe *kp = rb_entry(*link, struct kprobe, rb_node);
+		unsigned long kp_addr = (unsigned long)kp->addr;
+
+		parent = *link;
+		if (addr < kp_addr)
+			link = &(*link)->rb_left;
+		else if (addr > kp_addr)
+			link = &(*link)->rb_right;
+		else {
+			WARN_ON_ONCE(1);
+			return;
+		}
+	}
+
+	rb_link_node(&p->rb_node, parent, link);
+	rb_insert_color(&p->rb_node, &kprobe_tree);
+}
+
+static void kprobe_tree_erase(struct kprobe *p)
+{
+	lockdep_assert_held(&kprobe_mutex);
+	rb_erase(&p->rb_node, &kprobe_tree);
+	RB_CLEAR_NODE(&p->rb_node);
+}
+
+static void kprobe_tree_replace(struct kprobe *old, struct kprobe *new)
+{
+	lockdep_assert_held(&kprobe_mutex);
+	rb_replace_node(&old->rb_node, &new->rb_node, &kprobe_tree);
+	RB_CLEAR_NODE(&old->rb_node);
+}
+
 static int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs);
 
 /* Return true if 'p' is an aggregator */
@@ -643,6 +683,7 @@ static void do_unoptimize_kprobes(struct list_head *unopt_list,
 			 * (reclaiming is done by do_free_cleaned_kprobes().)
 			 */
 			hlist_del_init_rcu(&op->kp.hlist);
+			kprobe_tree_erase(&op->kp);
 		} else {
 			/*
 			 * Keep on cooling_list until the quiescence period
@@ -722,6 +763,7 @@ static void optprobe_finalize_generation(struct optprobe_generation *gen)
 			 * it will be reclaimed after the next quiescence period.
 			 */
 			hlist_del_init_rcu(&op->kp.hlist);
+			kprobe_tree_erase(&op->kp);
 			list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
 			kick_kprobe_optimizer();
 		} else {
@@ -1006,6 +1048,7 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 					if (!kprobe_gone(&op->kp))
 						arch_disarm_kprobe(&op->kp);
 					hlist_del_init_rcu(&op->kp.hlist);
+					kprobe_tree_erase(&op->kp);
 					list_move(&op->list, &cur->freeing_list);
 				} else {
 					list_move(&op->list, &cur->cooling_list);
@@ -1021,6 +1064,7 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 				if (!kprobe_gone(&op->kp))
 					arch_disarm_kprobe(&op->kp);
 				hlist_del_init_rcu(&op->kp.hlist);
+				kprobe_tree_erase(&op->kp);
 				list_move(&op->list, &cur->freeing_list);
 				kick_kprobe_optimizer();
 			}
@@ -1076,6 +1120,7 @@ static void kill_optimized_kprobe(struct kprobe *p)
 		if (kprobe_unused(p)) {
 			if (optprobe_queued_unopt(op) || optprobe_queued_cooling(op)) {
 				hlist_del_init_rcu(&op->kp.hlist);
+				kprobe_tree_erase(&op->kp);
 				list_move(&op->list,
 					  &optprobe_gens[optprobe_cur_gen].freeing_list);
 				kick_kprobe_optimizer();
@@ -1599,6 +1644,7 @@ static void init_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
 
 	list_add_rcu(&p->list, &ap->list);
 	hlist_replace_rcu(&p->hlist, &ap->hlist);
+	kprobe_tree_replace(p, ap);
 }
 
 /*
@@ -1940,11 +1986,13 @@ static int __register_kprobe(struct kprobe *p)
 	INIT_HLIST_NODE(&p->hlist);
 	hlist_add_head_rcu(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
+	kprobe_tree_insert(p);
 
 	if (!kprobes_all_disarmed && !kprobe_disabled(p)) {
 		ret = arm_kprobe(p);
 		if (ret) {
 			hlist_del_rcu(&p->hlist);
+			kprobe_tree_erase(p);
 			synchronize_rcu();
 		}
 	}
@@ -2075,6 +2123,7 @@ static int __unregister_kprobe_top(struct kprobe *p)
 		 * unoptimizing.
 		 */
 		hlist_del_rcu(&ap->hlist);
+		kprobe_tree_erase(ap);
 		return 0;
 	}
 
-- 
2.43.0

