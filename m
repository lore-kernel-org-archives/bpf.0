Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158957;
	b=CrjspdGlywDubMyvnP8Ueh6jMp897H8BnrWhy34gSSr7ILvjjsYrpaYt8DOWQLce4pYH
	 YZTDjecgsKlf+OTwqi/JOWFj1cftuRLMGYIzReITqVZl8Ee/5KDOkMxauuTF/A86DSkoK
	 s5oZxLqtDSSk3KSIMW2ZE7FFdM0Zt6hywlPx0DytZp8Hcmle+1DGPyn/aGW+GnmKnxdwC
	 I9pa3YU+RSijhNDxHfQWsvGWWL2s1V1onoU6Qtw8eYtGKn4ReINSXzoMSB6qW0SFgoVjT
	 99UmUibcE9NHzop++ANS+9VPRy030Vl58avbR4Y93vgnUysIuy6/DOt1EeFNIbjtHQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158957;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=di8Vl5Bw3dyNLt52tx2nDL/ZIFPjP9I0cBBm4Yj8Esk=;
	b=Oa1aZmkFpb1DThkx5k7fM4BQw1ALVm2I5Zi3wSKeg5BMqL6AormVO+64Cpxsee89vgF6
	 ReIFlHSJdS8QDIjZKxCHNPGgjJqoMrjG3TVRTDiCNeGcyty4IxoPaQgrwICSI4iRNYFaJ
	 JEv2mn0PCbdCQiIAjaIh27ZOWgA13EHVzb8RNn14erdMMjAocl322OKN1qneqzny6Vkfr
	 VDSHkmh3eaFfxOX0jbcxJbJpO0oso41o/8rEXr+Uf78mPA6P9pTAx4nlg+2H6qJdpWRWL
	 UFTi5FhCkfAtzLDIDpY2gurWviX5AJO2KX9ljt7jN0/77IC16SRzX8rDVT7ru1K+dOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4B606A33D;
	Fri, 20 Nov 2026 07:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE4B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jW66T0tPJz1yJX;
	Fri, 20 Nov 2026 15:14:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B853240830;
	Fri, 20 Nov 2026 15:15:51 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgA3dfSm8_9qDM9HFA--.40246S3;
	Fri, 20 Nov 2026 15:15:51 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH 1/3] bpf: Introduce classic BPF filter cache
Date: Fri, 20 Nov 2026 06:48:50 +0000
Message-ID: <adf466cb2cad6c674b7da5efbebfc2c3e3e8800c.1795139109.git.xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795139109.git.xukuohai@huaweicloud.com>
References: <cover.1795139109.git.xukuohai@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgA3dfSm8_9qDM9HFA--.40246S3
X-Coremail-Antispam: 1UD129KBjvAXoW3KFW5Cw4DCFWDuw18tF4fXwb_yoW8Gw17Co
	WfZan8Xr18KryxAr4jgr1xJF15uas5KrW7JrZ5Xrs3Xa1DAryYgFZ7Ca15ta4YvFyrGay8
	ur9rJa1jyrWDJFy8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO17kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	4l82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8-_
	-PUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Introduce a cache for prepared classic BPF filters. It is implemented as
a hash table that maps user-space filter instructions to the prepared
bpf prog. The cache key consists of the raw instructions (stored as
orig_prog) and a snapshot of the constant blinding and JIT policy read
at load time. This ensures that sysctl changes produce different keys
even for identical instructions.

Lookup occurs before filter preparation:
- cache hit: Returns the shared bpf prog directly.
- cache miss: Reserves an entry. Concurrent tasks loading the same
  filter wait on a wait queue until preparation completes.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/filter.h |  25 +++-
 io_uring/bpf_filter.c  |   3 +-
 kernel/seccomp.c       |   3 +-
 net/core/filter.c      | 318 ++++++++++++++++++++++++++++++++++++++++-
 net/packet/af_packet.c |   2 +-
 5 files changed, 343 insertions(+), 8 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 61448be53f8d..a3951e9bde0e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -794,9 +794,30 @@ struct compat_sock_fprog {
 	compat_uptr_t	filter;	/* struct sock_filter * */
 };
 
+#define CBPF_CACHE_BITS	8
+#define CBPF_CACHE_SIZE	BIT(CBPF_CACHE_BITS)
+
+/* cache of classic bpf filters. Identical filters share same prog */
+struct cbpf_cache {
+	struct hlist_head	hash[CBPF_CACHE_SIZE];
+	spinlock_t		lock[CBPF_CACHE_SIZE]; /* per-bucket */
+};
+
+/* define a classic BPF filter cache */
+#define DEFINE_CBPF_CACHE(name)					\
+	struct cbpf_cache name = {				\
+		.lock = {						\
+			[0 ... (CBPF_CACHE_SIZE - 1)] =		\
+				__SPIN_LOCK_UNLOCKED(name.lock),	\
+		},							\
+	}
+
+struct cbpf_cache_entry;
+
 struct sock_fprog_kern {
 	u16			len;
 	struct sock_filter	*filter;
+	struct cbpf_cache_entry *cache_entry;
 };
 
 /* Some arches need doubleword alignment for their instructions and/or data */
@@ -1360,7 +1381,9 @@ typedef int (*bpf_aux_classic_check_t)(struct sock_filter *filter,
 
 int bpf_prog_create(struct bpf_prog **pfp, struct sock_fprog_kern *fprog);
 int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
-			      bpf_aux_classic_check_t trans, bool save_orig);
+			       bpf_aux_classic_check_t trans, bool save_orig,
+			       struct cbpf_cache *cache);
+void cbpf_cache_put_prog(struct bpf_prog *prog);
 void bpf_prog_destroy(struct bpf_prog *fp);
 
 int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk);
diff --git a/io_uring/bpf_filter.c b/io_uring/bpf_filter.c
index 4a21511c4811..6237bb2a2795 100644
--- a/io_uring/bpf_filter.c
+++ b/io_uring/bpf_filter.c
@@ -375,7 +375,8 @@ int io_register_bpf_filter(struct io_restriction *res,
 	fprog.filter = u64_to_user_ptr(reg.filter.filter_ptr);
 
 	ret = bpf_prog_create_from_user(&prog, &fprog,
-					io_uring_check_cbpf_filter, false);
+					io_uring_check_cbpf_filter, false,
+					NULL);
 	if (ret)
 		return ret;
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3eecba5ccdef..01e26bfc6ea1 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -701,7 +701,8 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 
 	mutex_init(&sfilter->notify_lock);
 	ret = bpf_prog_create_from_user(&sfilter->prog, fprog,
-					seccomp_check_filter, save_orig);
+					seccomp_check_filter, save_orig,
+					NULL);
 	if (ret < 0) {
 		kfree(sfilter);
 		return ERR_PTR(ret);
diff --git a/net/core/filter.c b/net/core/filter.c
index 946b07a17fce..51c6c6c36359 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -49,6 +49,9 @@
 #include <linux/if_vlan.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/jhash.h>
+#include <linux/wait_bit.h>
+#include <linux/rculist.h>
 #include <net/sch_generic.h>
 #include <net/cls_cgroup.h>
 #include <net/dst_metadata.h>
@@ -1166,11 +1169,14 @@ static int bpf_prog_store_orig_filter(struct bpf_prog *fp,
 
 	fkprog = fp->orig_prog;
 	fkprog->len = fprog->len;
+	/* release path checks cache_entry to decide if the prog is cached */
+	fkprog->cache_entry = NULL;
 
 	fkprog->filter = kmemdup(fp->insns, fsize,
 				 GFP_KERNEL | __GFP_NOWARN);
 	if (!fkprog->filter) {
 		kfree(fp->orig_prog);
+		fp->orig_prog = NULL;
 		return -ENOMEM;
 	}
 
@@ -1187,6 +1193,282 @@ static void bpf_release_orig_filter(struct bpf_prog *fp)
 	}
 }
 
+struct cbpf_cache_entry {
+	struct hlist_node	node;
+	struct rcu_head		rcu;
+	refcount_t		users;
+	struct cbpf_cache	*cache; /* cache this entry belongs to */
+	struct sock_fprog_kern	*orig; /* cache key: the original bpf filter */
+	u32			tag; /* cache key: JIT and blinding states */
+	u32			bucket; /* bucket index of this entry */
+	/*
+	 * cache value: the shared prog. prog is set to NULL before the filter
+	 * preparation, and set to the result prog on success, or ERR_PTR when
+	 * preparation failed.
+	 */
+	struct bpf_prog		*prog;
+};
+
+/*
+ * calculate tag from the allocation-time JIT and blinding states, so sysctl
+ * changes produce a different tag.
+ */
+static u32 cbpf_cache_tag(const struct bpf_prog *prog)
+{
+	u32 tag = 0;
+
+	tag |= (prog->jit_requested << 1);
+	tag |= (prog->blinding_requested << 2);
+#ifdef CONFIG_BPF_JIT
+	tag |= (bpf_jit_enable << 3);
+#endif
+
+	return tag;
+}
+
+static u32 cbpf_cache_bucket(const struct bpf_prog *prog)
+{
+	const struct sock_fprog_kern *orig = prog->orig_prog;
+
+	return jhash(orig->filter, orig->len * sizeof(struct sock_filter),
+		     cbpf_cache_tag(prog)) % CBPF_CACHE_SIZE;
+}
+
+static bool
+cbpf_cache_match(const struct cbpf_cache_entry *entry,
+		 const struct bpf_prog *prog)
+{
+	const struct sock_fprog_kern *orig = prog->orig_prog;
+	size_t size;
+
+	if (entry->tag != cbpf_cache_tag(prog))
+		return false;
+
+	if (entry->orig->len != orig->len)
+		return false;
+
+	size = orig->len * sizeof(struct sock_filter);
+	return !memcmp(entry->orig->filter, orig->filter, size);
+}
+
+static void cbpf_cache_free_entry_rcu(struct rcu_head *rcu)
+{
+	struct cbpf_cache_entry *entry =
+		container_of(rcu, struct cbpf_cache_entry, rcu);
+
+	if (IS_ERR(entry->prog)) {
+		/* the failed prog was freed during the preparation */
+		kfree(entry->orig->filter);
+		kfree(entry->orig);
+	} else {
+		bpf_release_orig_filter(entry->prog);
+		bpf_prog_free(entry->prog);
+	}
+	kfree(entry);
+}
+
+static void cbpf_cache_put_entry(struct cbpf_cache_entry *entry)
+{
+	if (!refcount_dec_and_test(&entry->users))
+		return;
+
+	/* an aborted entry was already unlinked by the abort. */
+	if (!IS_ERR(entry->prog)) {
+		spin_lock_bh(&entry->cache->lock[entry->bucket]);
+		hlist_del_rcu(&entry->node);
+		entry->orig->cache_entry = NULL;
+		spin_unlock_bh(&entry->cache->lock[entry->bucket]);
+	}
+
+	call_rcu(&entry->rcu, cbpf_cache_free_entry_rcu);
+}
+
+/* Release a shared prog, the last user frees it after a grace period. */
+void cbpf_cache_put_prog(struct bpf_prog *prog)
+{
+	cbpf_cache_put_entry(prog->orig_prog->cache_entry);
+}
+
+static struct cbpf_cache_entry *
+cbpf_cache_find(struct cbpf_cache *cache, const struct bpf_prog *fp)
+{
+	struct cbpf_cache_entry *cur, *hit = NULL;
+	u32 bucket = cbpf_cache_bucket(fp);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(cur, &cache->hash[bucket], node) {
+		if (!cbpf_cache_match(cur, fp))
+			continue;
+		/* skip dead entries (users == 0). */
+		if (refcount_inc_not_zero(&cur->users)) {
+			hit = cur;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return hit;
+}
+
+/*
+ * Wait for the preparation to finish. Returns 0 when the entry
+ * holds a prepared prog, -EAGAIN when the preparation failed.
+ */
+static int cbpf_cache_wait(struct cbpf_cache_entry *entry)
+{
+	struct bpf_prog *prog;
+
+	wait_var_event(&entry->prog, READ_ONCE(entry->prog));
+
+	/* acquire pairs with the complete() release. */
+	prog = smp_load_acquire(&entry->prog);
+	if (!IS_ERR(prog))
+		return 0;
+
+	/* preparation aborted, drop our ref and signal retry. */
+	cbpf_cache_put_entry(entry);
+
+	return -EAGAIN;
+}
+
+/*
+ * Insert a preparing entry for prog. Returns 0 and the entry in *pentry
+ * when the caller is the preparer, 1 and the winner in *pentry when
+ * another entry was found in the race, or -ENOMEM out of memory.
+ */
+static int cbpf_cache_insert(struct cbpf_cache *cache, struct bpf_prog *prog,
+			     struct cbpf_cache_entry **pentry)
+{
+	struct cbpf_cache_entry *entry, *hit, *cur;
+	u32 bucket = cbpf_cache_bucket(prog);
+
+	entry = kzalloc_obj(*entry, GFP_KERNEL | __GFP_NOWARN);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->orig = prog->orig_prog;
+	entry->cache = cache;
+	entry->tag = cbpf_cache_tag(prog);
+	entry->bucket = bucket;
+	refcount_set(&entry->users, 1);
+
+	hit = NULL;
+	spin_lock_bh(&cache->lock[bucket]);
+	hlist_for_each_entry_rcu(cur, &cache->hash[bucket], node) {
+		if (!cbpf_cache_match(cur, prog))
+			continue;
+		if (refcount_inc_not_zero(&cur->users)) {
+			hit = cur;
+			break;
+		}
+	}
+	if (!hit)
+		hlist_add_head_rcu(&entry->node, &cache->hash[bucket]);
+	spin_unlock_bh(&cache->lock[bucket]);
+
+	if (hit) {
+		kfree(entry);
+		*pentry = hit;
+		return 1;
+	}
+
+	/*
+	 * The entry owns the orig_prog now. The preparation error paths
+	 * release the prog, a stale prog->orig_prog would make them free
+	 * the orig_prog too, though it is owned by the cache entry.
+	 */
+	prog->orig_prog = NULL;
+	*pentry = entry;
+
+	return 0;
+}
+
+/*
+ * Find the shared prog in the cache, or reserve a cache entry to prepare it.
+ * Returns 1 when a prepared entry was found: *pentry holds it with one
+ * reference. Returns 0 when the caller becomes the preparer, or with *pentry
+ * NULL when out of memory.
+ */
+static int
+cbpf_cache_find_or_reserve(struct cbpf_cache *cache, struct bpf_prog *fp,
+			   struct cbpf_cache_entry **pentry)
+{
+	int ret;
+	struct cbpf_cache_entry *entry;
+
+	*pentry = NULL;
+	entry = cbpf_cache_find(cache, fp);
+	for (;;) {
+		/*
+		 * Wait for the preparation of the entry, on a
+		 * preparation failure find a new one, a concurrent
+		 * preparer may have appeared by then.
+		 */
+		while (entry) {
+			ret = cbpf_cache_wait(entry);
+			if (ret != -EAGAIN)
+				break;
+			entry = cbpf_cache_find(cache, fp);
+		}
+
+		if (entry) {
+			/* cache hit */
+			*pentry = entry;
+			return 1;
+		}
+
+		ret = cbpf_cache_insert(cache, fp, &entry);
+		if (ret == 0) {
+			/* we become the preparer now */
+			*pentry = entry;
+			return 0;
+		} else if (ret < 0) {
+			/* no memory, run the preparation uncached */
+			return 0;
+		}
+		/* lost the race, entry is the winner, wait for it */
+	}
+}
+
+/* publish the prepared result, and wake up waiters */
+static void cbpf_cache_complete(struct cbpf_cache_entry *entry,
+				struct bpf_prog *fp)
+{
+	fp->orig_prog = entry->orig;
+	fp->orig_prog->cache_entry = entry;
+
+	/* pairs with the acquire load in cbpf_cache_wait() */
+	smp_store_release(&entry->prog, fp);
+	/*
+	 * pairs with the barrier in wait_var_event(), both sides write one
+	 * variable then read the other.
+	 *
+	 *       waker                    waiter
+	 * write entry->prog     |  write wq_head->head
+	 * this smp_mb() barrier |  smp_store_mb barrier in set_current_state
+	 * read wq_head->head    |  read entry->prog
+	 */
+	smp_mb();
+	wake_up_var(&entry->prog);
+}
+
+/* preparation failed, remove the entry and wake up waiters */
+static void cbpf_cache_abort(struct cbpf_cache_entry *entry)
+{
+	spin_lock_bh(&entry->cache->lock[entry->bucket]);
+	hlist_del_rcu(&entry->node);
+	spin_unlock_bh(&entry->cache->lock[entry->bucket]);
+
+	/* pairs with the acquire load in cbpf_cache_wait() */
+	smp_store_release(&entry->prog, ERR_PTR(-EAGAIN));
+
+	/* see the comment above smp_mb() in cbpf_cache_complete() */
+	smp_mb();
+	wake_up_var(&entry->prog);
+
+	cbpf_cache_put_entry(entry);
+}
+
 static void __bpf_prog_release(struct bpf_prog *prog)
 {
 	if (prog->type == BPF_PROG_TYPE_SOCKET_FILTER) {
@@ -1422,15 +1704,21 @@ EXPORT_SYMBOL_GPL(bpf_prog_create);
  *	@fprog: the filter program
  *	@trans: post-classic verifier transformation handler
  *	@save_orig: save classic BPF program
+ *	@cache: cache prepared progs in this cache, NULL disables caching.
+ *	        The cache needs the saved program as its key, it is
+ *	        saved even without @save_orig.
  *
  * This function effectively does the same as bpf_prog_create(), only
  * that it builds up its insns buffer from user space provided buffer.
  * It also allows for passing a bpf_aux_classic_check_t handler.
  */
 int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
-			      bpf_aux_classic_check_t trans, bool save_orig)
+			       bpf_aux_classic_check_t trans,
+			       bool save_orig,
+			       struct cbpf_cache *cache)
 {
 	unsigned int fsize = bpf_classic_proglen(fprog);
+	struct cbpf_cache_entry *entry = NULL;
 	struct bpf_prog *fp;
 	int err;
 
@@ -1450,20 +1738,42 @@ int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
 	fp->len = fprog->len;
 	fp->orig_prog = NULL;
 
-	if (save_orig) {
+	if (save_orig || cache) {
 		err = bpf_prog_store_orig_filter(fp, fprog);
 		if (err) {
+			if (save_orig) {
+				__bpf_prog_free(fp);
+				return -ENOMEM;
+			}
+			/* fall back to the uncached pipeline */
+			cache = NULL;
+		}
+	}
+
+	if (cache) {
+		err = cbpf_cache_find_or_reserve(cache, fp, &entry);
+		if (err > 0) {
+			/* cache hit */
+			bpf_release_orig_filter(fp);
 			__bpf_prog_free(fp);
-			return -ENOMEM;
+			*pfp = entry->prog;
+			return 0;
 		}
+		/* we are the preparer, or uncached out of memory. */
 	}
 
 	/* bpf_prepare_filter() already takes care of freeing
 	 * memory in case something goes wrong.
 	 */
 	fp = bpf_prepare_filter(fp, trans);
-	if (IS_ERR(fp))
+	if (IS_ERR(fp)) {
+		if (entry)
+			cbpf_cache_abort(entry);
 		return PTR_ERR(fp);
+	}
+
+	if (entry)
+		cbpf_cache_complete(entry, fp);
 
 	*pfp = fp;
 	return 0;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 73222563fb70..eb7cd153ae66 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1617,7 +1617,7 @@ static int fanout_set_data_cbpf(struct packet_sock *po, sockptr_t data,
 	if (ret)
 		return ret;
 
-	ret = bpf_prog_create_from_user(&new, &fprog, NULL, false);
+	ret = bpf_prog_create_from_user(&new, &fprog, NULL, false, NULL);
 	if (ret)
 		return ret;
 
-- 
2.43.0

