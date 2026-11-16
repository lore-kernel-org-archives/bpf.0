Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840854;
	b=VSTbUfFXgaoLzC8eVSax/8y/QGwegiHurhFxHcWDTh9LEMdcK8SC/P2bCCurzAJP3stZ
	 pXuOmNFxNZv0zJg+ZPhxMiiiYNCaTWbtLFRB+XXQZgjhIcDoNvB5ySsDfJcb3A4v9fFlH
	 9+pOQY4Dw91KB81oqVV+/b5Imew4dorrDR1aWhoU5AhkKzOgbimGRFrd4VV19oUoshuIi
	 1cCIA6e88W39gX+4knPa0OvEaZUKVOYIlsbsfF5PqKYYldu2QciGe7n0DXmiDT2eLkHc/
	 3hMAtScpeOsM/X5YcrOm23E+m5GlKioC2algf7g+jKX3RHmlFU/GCvadS99xVVecQQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840854;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eH2UHe4VWazhocvwFexn3tZ8GCYCG/aM7ikfKTsInMs=;
	b=e5Zpj1/x+iRzG4Ih108EtfutAOGDmp5QJ0daWRmEtKtLyqNsOTPs72oUXtADYFTqzlDN
	 II+AfnSsNVZrsnZ8Bb8v6B2QIWVy+nqfK3mswYoKdYn+PCYy5IiANK+hgpFgc4D7bFuFU
	 Mm39dLq7hZWyMgwJDSTIP45gBp922xBg+CH8zl/jbuyajQ+boCmr1sK7WtxVGtBy4tKLF
	 xRsrYjc09q47EZyf5kzh2hh2JgzNUuC50lstHL2zHwOrbaI5UIY+pOyyewvIfJF/fCJmZ
	 4TNXn3Iieajz+wyFkppJdKIwVZlA22XQC2XSUUkZo/h0auOwhf6/zoc/nW5mC58fXqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IpDOhHb8;
	arc=none smtp.remote-ip=115.124.30.97
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C7606A31C;
	Mon, 16 Nov 2026 14:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE6C7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IpDOhHb8
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794840850; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=eH2UHe4VWazhocvwFexn3tZ8GCYCG/aM7ikfKTsInMs=;
	b=IpDOhHb8/TOfQ2QgCRuFqm8LJfvGZKlGJNpVB3anbor+POOFpGdvYlPLRDYvBOEVex2c5xYvaO3JXM12gLush9IIP5TU0uzKYTe+oQMqNeuC7Du8OqJZy5DNSvqciXRLi7UJ2+MRiBBFIdgwl88XqVHPRqhRyC0bSI4wyTyAJjQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=shijing.wuqi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XEvJFpD_1794840833;
Received: from localhost.localdomain(mailfrom:shijing.wuqi@linux.alibaba.com fp:SMTPD_---0XEvJFpD_1794840833 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 22:54:08 +0800
From: Qi Wu <shijing.wuqi@linux.alibaba.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH bpf-next v3] bpf, mprog: Defer RCU synchronization until peer reuse
Date: Mon, 16 Nov 2026 22:53:18 +0800
Message-ID: <20261116145318.34084-1-shijing.wuqi@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bpf_mprog_attach() swaps the active entry and the caller then waits
for a grace period (tcx_entry_sync() / netkit_entry_sync()) before
returning. But attach releases nothing: the old entry only has to
stay intact until the next attach or detach overwrites it as the
peer. The unconditional wait buys nothing on the attach path, yet it
runs inside rtnl_lock() and serializes the whole machine's network
control plane. Creating containers in bulk pays 2N grace periods for
N devices, one first attach per direction.

Borrow the scheme used by mini_qdisc_pair_swap() in commit 267463823adb
("net: sch: eliminate unnecessary RCU waits in mini_qdisc_pair_swap()"):
record the grace-period state after the swap and only wait before the
old buffer is written again. bpf_mprog_defer_sync() records
start_poll_synchronize_rcu() on the attach swap, bpf_mprog_peer() calls
cond_synchronize_rcu() before returning the peer to be overwritten, and
a new bundle starts with get_completed_synchronize_rcu() so the first
attach never waits. The state is recorded only on the attach swap, not
in bpf_mprog_commit(): a detach or replace leaves it alone, so it does
not charge an extra grace period to the next change. This removes the
attach-path sync from both tcx and netkit with no 'created' special
case, and covers a clsact qdisc having published the entry first.

A/B on the same bpf-next base (8835113107b2), identical configs apart
from LOCALVERSION, lock/RCU debugging off, 64 vCPU KVM guest. Average
operation latency. The attach rows use 30 samples each. The detach
row measures close(link_fd), excluding the first detach in each run:
35 samples across five runs of eight links.

  scenario                 base        v3        speedup
  first link attach        14.377 ms   268.4 us    54x
  first prog attach        12.411 ms   290.0 us    43x
  clsact qdisc first       11.562 ms   116.2 us    99x
  detach after detach      6.2 ms     5.2 ms     ~1x

An attach waits only if the grace period recorded by an earlier
attach swap has not completed. Detach after detach stays at the base
cost: recording the cookie on every commit makes a detach following
another detach wait twice (N links cost 2N-1 grace periods rather
than N, measured 15.0 ms), because bpf_mprog_peer() charges the
previous commit's grace period to the next detach. Recording it only
on the attach swap avoids that.

Functional checks pass and a 300-cycle attach/detach churn under live
traffic shows no splats.

BPF CI: https://github.com/kernel-patches/bpf/pull/14821 (39 passed,
0 failed; x86_64 gcc-15/llvm-21, aarch64, s390x).

The implementation and measurement were produced with the help of an
AI coding assistant; the change was reviewed by the submitter.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Qi Wu <shijing.wuqi@linux.alibaba.com>

---
 drivers/net/netkit.c      |  4 ++--
 include/linux/bpf_mprog.h | 27 ++++++++++++++++++++++-----
 kernel/bpf/tcx.c          |  4 ++--
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 82e608e733d9..75a1a561e5aa 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -772,7 +772,7 @@ int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (!ret) {
 		if (entry != entry_new) {
 			netkit_entry_update(dev, entry_new);
-			netkit_entry_sync();
+			bpf_mprog_defer_sync(entry);
 		}
 		bpf_mprog_commit(entry);
 	}
@@ -854,7 +854,7 @@ static int netkit_link_prog_attach(struct bpf_link *link, u32 flags,
 	if (!ret) {
 		if (entry != entry_new) {
 			netkit_entry_update(dev, entry_new);
-			netkit_entry_sync();
+			bpf_mprog_defer_sync(entry);
 		}
 		bpf_mprog_commit(entry);
 	}
diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
index 0b9f4caeeb0a..2e180a43c8a0 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -30,8 +30,8 @@
  *   if (!ret) {
  *       if (entry != entry_new) {
  *           // swap @entry to @entry_new at attach location
- *           // ensure there are no inflight users of @entry:
- *           synchronize_rcu();
+ *           // nothing is released, no need to wait for users of @entry:
+ *           bpf_mprog_defer_sync(entry);
  *       }
  *       bpf_mprog_commit(entry);
  *   } else {
@@ -104,9 +104,13 @@
  *
  * Fast path accesses the active bpf_mprog_entry within RCU critical section
  * (in case of tcx it runs in NAPI which provides RCU protection there,
- * other users might need explicit rcu_read_lock()). The bpf_mprog_commit()
- * assumes that for the old bpf_mprog_entry there are no inflight users
- * anymore.
+ * other users might need explicit rcu_read_lock()). In the detach case the
+ * bpf_mprog_commit() assumes that for the old bpf_mprog_entry there are no
+ * inflight users anymore. In the attach case nothing is released, and the
+ * old bpf_mprog_entry only has to stay intact until its users are gone:
+ * bpf_mprog_defer_sync() records the RCU state after the swap, and
+ * bpf_mprog_peer() waits for it before the old bpf_mprog_entry is written
+ * again.
  *
  * The READ_ONCE()/WRITE_ONCE() pairing for bpf_mprog_fp's prog access is for
  * the replacement case where we don't swap the bpf_mprog_entry.
@@ -147,6 +151,7 @@ struct bpf_mprog_bundle {
 	struct bpf_mprog_cp cp_items[BPF_MPROG_MAX];
 	struct bpf_prog *ref;
 	atomic64_t revision;
+	unsigned long rcu_state;
 	u32 count;
 };
 
@@ -158,12 +163,23 @@ struct bpf_tuple {
 static inline struct bpf_mprog_entry *
 bpf_mprog_peer(const struct bpf_mprog_entry *entry)
 {
+	/*
+	 * The peer was active until the last swap and the caller is going
+	 * to overwrite it, therefore ensure that there are no inflight
+	 * users on it anymore. Paired with bpf_mprog_defer_sync().
+	 */
+	cond_synchronize_rcu(entry->parent->rcu_state);
 	if (entry == &entry->parent->a)
 		return &entry->parent->b;
 	else
 		return &entry->parent->a;
 }
 
+static inline void bpf_mprog_defer_sync(struct bpf_mprog_entry *entry)
+{
+	entry->parent->rcu_state = start_poll_synchronize_rcu();
+}
+
 static inline void bpf_mprog_bundle_init(struct bpf_mprog_bundle *bundle)
 {
 	BUILD_BUG_ON(sizeof(bundle->a.fp_items[0]) > sizeof(u64));
@@ -172,6 +188,7 @@ static inline void bpf_mprog_bundle_init(struct bpf_mprog_bundle *bundle)
 
 	memset(bundle, 0, sizeof(*bundle));
 	atomic64_set(&bundle->revision, 1);
+	bundle->rcu_state = get_completed_synchronize_rcu();
 	bundle->a.parent = bundle;
 	bundle->b.parent = bundle;
 }
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 02db0113b8e7..12a16200cb44 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -42,7 +42,7 @@ int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
-			tcx_entry_sync();
+			bpf_mprog_defer_sync(entry);
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);
@@ -156,7 +156,7 @@ static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id_or_fd,
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
-			tcx_entry_sync();
+			bpf_mprog_defer_sync(entry);
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);
-- 
2.47.3
