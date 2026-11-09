Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254187;
	b=agLzdBHKLvdbK3OfJmHOP93KE5pAseFBl5cjTR/AkoUGPfU7wAwAy39cpbXEW15FE1Cr
	 pKSb4kGZxvsAXaKQaOA9mbvxAv5Ul3rhUMSsk34SqZHcNb+xSTyCRSVEOqUPSJciWRBlR
	 Ys3WfZnXzS12yXF8cpqRfTJohWgkEYUatGbsQhujxqg7jHyoBRqczvrjDMgBIwUATLXVD
	 ktu7NCOV8GZDGIb+cDZLPWPJqLp8LpXpfDMvSci/f50PdoMG845p6WpWLw2VsgrJt4a7a
	 PZGEmM6TR9IDisbwREzY8GONDwBnrxLuVqYHGhZvBxOiWhazlMobcMFMjcpX03Z2tjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254187;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZQMhPWgPRNJ2b8c4pHjYuK7vfz0bI1SC6YhKwaZw9mM=;
	b=sSADM2+00VdWcblQA1UcKnGoMl3wx3I9mpCmRCUfcvlr43LfvOEEhdf5q/URKQLQ65am
	 ALHtJXsZ7Hqx+FHDKXVYxlDJwUYiuwJPwvF3a/iGHvFBO2eSyU/9tSraRivNKOuYDC7Mf
	 O9BI1clazP9BGOp+TRXPl6FA0TBpKqNeYW1Avye7WWkJh8H/CvTC+HR26juMAGWjaFlzk
	 KXH8d3YGi28W/vJAW2Cy5ldQH0ULoPo1bFkdZPSNx4zu0KgdOOgbKLbXPQT27fiIYew2V
	 5Ew6kzIWhojrQVIiasfxGM687DfQ7SGTP63QPEUTMpLy5tGgcqrqkBO9bb5pTX+e4wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISiAJyPj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18451606A337;
	Mon,  9 Nov 2026 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISiAJyPj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F1A1F0089F;
	Mon,  9 Nov 2026 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254186;
	bh=ZQMhPWgPRNJ2b8c4pHjYuK7vfz0bI1SC6YhKwaZw9mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ISiAJyPjpsTLsUqAdYl0WjdGnYm99YHzViFfWB1CJoPaP40u+LjMh+SpbPo5efv1V
	 6gbV1drOUtpjcNx4VwEnHBtmR0cBlID5JD3aN+rG5/5ty9BfWuUwODXvex5gQJ9zNU
	 Rt/FPiLxNp9HPzXvgbxDkS4r+6/S4/FtbmlhFto1gWJEx+wz8hkGC3K2AynWKFP9K9
	 Un5w0hqbv2d8qOVFx1ZjPg/S9PH1YjRmLw2Eel/p58Nia9UOG8DRnXj2qzbS5ZceXL
	 3Wgh483cqiiwAD3i4RF552ZkpMAEFCzyquuW9GmD6qo55ckXpLGqQRzMTBl6WpGTRJ
	 beBBVBsAuCO6g==
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
Subject: [PATCH 05/13] kprobes: Add an iterator for address ranges
Date: Mon,  9 Nov 2026 20:56:20 +0100
Message-ID: <20261109195620.1091012-1-jolsa@kernel.org>
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

Add an iterator that walks registered probes in address order within
a specified range. Use the kprobe rbtree to find the first probe at
or after the start address, then advance through the tree.

Require kprobe_mutex to be held while iterating and provide a
for_each_kprobe() helper.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/kprobes.h | 13 +++++++++++++
 kernel/kprobes.c        | 42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 6f16cc01a16c..bdba893cc0b2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -95,6 +95,11 @@ struct kprobe {
 	u32 flags;
 };
 
+struct kprobe_iter {
+	struct kprobe *next;
+	unsigned long end;
+};
+
 /* Kprobe status flags */
 #define KPROBE_FLAG_GONE	1 /* breakpoint has already gone */
 #define KPROBE_FLAG_DISABLED	2 /* probe is temporarily disabled */
@@ -386,6 +391,14 @@ static inline void kprobe_ftrace_kill(void) {}
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
 
+struct kprobe *kprobe_iter_start(struct kprobe_iter *iter,
+				 unsigned long start, unsigned long end);
+struct kprobe *kprobe_iter_next(struct kprobe_iter *iter);
+
+#define for_each_kprobe(iter, p, start, end)			\
+	for ((p) = kprobe_iter_start(&(iter), (start), (end));	\
+	     (p); (p) = kprobe_iter_next(&(iter)))
+
 /* kprobe_running() will just return the current_kprobe on this CPU */
 static inline struct kprobe *kprobe_running(void)
 {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6be1430a4ebe..bbd51e0fab7e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -435,6 +435,48 @@ static void kprobe_tree_replace(struct kprobe *old, struct kprobe *new)
 	RB_CLEAR_NODE(&old->rb_node);
 }
 
+struct kprobe *kprobe_iter_start(struct kprobe_iter *iter, unsigned long start,
+				 unsigned long end)
+{
+	struct rb_node *node = kprobe_tree.rb_node;
+	struct kprobe *kp, *next = NULL;
+
+	lockdep_assert_held(&kprobe_mutex);
+	iter->next = NULL;
+	iter->end = end;
+	if (start > end)
+		return NULL;
+
+	while (node) {
+		kp = rb_entry(node, struct kprobe, rb_node);
+		if ((unsigned long)kp->addr >= start) {
+			next = kp;
+			node = node->rb_left;
+		} else {
+			node = node->rb_right;
+		}
+	}
+
+	iter->next = next;
+	return kprobe_iter_next(iter);
+}
+
+struct kprobe *kprobe_iter_next(struct kprobe_iter *iter)
+{
+	struct kprobe *kp = iter->next;
+	struct rb_node *node;
+
+	lockdep_assert_held(&kprobe_mutex);
+	if (!kp || (unsigned long)kp->addr > iter->end) {
+		iter->next = NULL;
+		return NULL;
+	}
+
+	node = rb_next(&kp->rb_node);
+	iter->next = node ? rb_entry(node, struct kprobe, rb_node) : NULL;
+	return kp;
+}
+
 static int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs);
 
 /* Return true if 'p' is an aggregator */
-- 
2.43.0

