Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794754059;
	b=YZ8qlKnSaDttz2WIf6/RG36BflTyTZLkZeJiheziJGGHo2QqOYM5bxSHzl/ohg8ZE/iP
	 cNFMEHa2+mqA7OJI10//cBV5IZnp4sQl2VFbxDd3oyoDBKUi6Tk0PDS4ly8V/0DTwDVL4
	 FMVVBVRPbDXLd61aBc1RCc7PIdZrVvBcEtsrikAYOLKMhg566/hhRM5rDwGKYM465veMc
	 VPbVjspzpilXQZl95BdYbTY9dF7+apj6zgMPqFpbxGNLp2zHUtrJC4SUXGC/W74qfD0SD
	 puV4SaS91FSoe5RipqlcEK5YVUHyWHwBGRoVdDjMwg6WU8JpfpxXB4P2jjoJDTwXknw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754059;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gOqKfulGpfH+MgA/Vdc67V/m561rzIB41f/h7I53GGw=;
	b=TyqEjltuvOBon3+GcwPbz5kGyb6cdj6zImTcrZNnVRb2JBLrNdSqADOqE+x8vIyveY87
	 k2DjuXcTOmdRzLDo4zmlIAp+rjmK/aXM9Ui+8eGLd3dok7JCmSjDbbTj11nl/25585jru
	 qLJ82tt6whlv7mGYF7O7M1HN3NDSJFYrz12/YhOKN/Jla9YffZTg84nCxiC+XNeUUa7Mr
	 9P1f+ojFKqlXBB1+d/id97oP42y2dO0zqBm04nJS+WxR1XyXUlegIB3ZXa+6JO3Ynq+qj
	 UdIa9i9ajDYMqq+KjtPJ/0dUumOvPch+nl8bnFdjaQkpFM+26GoRpClk3oapICDSXbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="jN/m+K7W";
	arc=none smtp.remote-ip=115.124.30.118
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16B606A31A;
	Sun, 15 Nov 2026 14:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE16B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jN/m+K7W
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794754047; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gOqKfulGpfH+MgA/Vdc67V/m561rzIB41f/h7I53GGw=;
	b=jN/m+K7WYDJEnfWkAdAhjjCeR01Rsz/65w840lJU/k91yMXUfitz4S9mCO8oLGtMbdiaUl61bb7eQzFZOMnYkAUlvN+RathjhYNm5nw3pfVJd3geixAGxMtdzgItJexmiep6lrQ6ww8pJxRiMaQESx+i+p86zfkT9qmb8ftyiak=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=shijing.wuqi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XEk3YBd_1794754031;
Received: from localhost.localdomain(mailfrom:shijing.wuqi@linux.alibaba.com fp:SMTPD_---0XEk3YBd_1794754031 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 15 Nov 2026 22:47:25 +0800
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
Subject: [PATCH bpf-next v2] bpf, mprog: Defer RCU synchronization until peer reuse
Date: Sun, 15 Nov 2026 22:45:56 +0800
Message-ID: <20261115144556.41927-1-shijing.wuqi@linux.alibaba.com>
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
old buffer is written again. bpf_mprog_commit() records
start_poll_synchronize_rcu(), bpf_mprog_peer() calls
cond_synchronize_rcu() before returning the peer to be overwritten,
and a new bundle starts with get_completed_synchronize_rcu() so the
first attach never waits. This removes the attach-path sync from both
tcx and netkit with no 'created' special case, and covers a clsact
qdisc having published the entry first.

A/B on the same bpf-next base (8835113107b2), identical configs apart
from LOCALVERSION, lock/RCU debugging off, 64 vCPU KVM guest. Average
bpf() syscall latency, 30 iterations per scenario:

  scenario                 base        v2        speedup
  first link attach        11.375 ms   277.1 us    41x
  first prog attach        13.226 ms   264.2 us    50x
  clsact qdisc first       12.547 ms   114.5 us   110x

An attach within a grace period of the previous change still waits
(e.g. a tight loop); spaced-out attaches do not. Detach retains its
post-swap synchronization; peer reuse can add a conditional wait
before a detach. Functional checks pass and a 300-cycle attach/detach
churn under live traffic shows no splats. BPF CI:
https://github.com/kernel-patches/bpf/pull/14821 (39 passed, 0 failed).

The implementation and measurement were produced with the help of an
AI coding assistant; the change was reviewed by the submitter.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Qi Wu <shijing.wuqi@linux.alibaba.com>
---
 drivers/net/netkit.c      |  8 ++------
 include/linux/bpf_mprog.h | 23 ++++++++++++++++-------
 kernel/bpf/tcx.c          |  2 --
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 82e608e733d9..aa15fedadaeb 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -770,10 +770,8 @@ int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 			       attr->attach_flags, attr->relative_fd,
 			       attr->expected_revision);
 	if (!ret) {
-		if (entry != entry_new) {
+		if (entry != entry_new)
 			netkit_entry_update(dev, entry_new);
-			netkit_entry_sync();
-		}
 		bpf_mprog_commit(entry);
 	}
 out:
@@ -852,10 +850,8 @@ static int netkit_link_prog_attach(struct bpf_link *link, u32 flags,
 	ret = bpf_mprog_attach(entry, &entry_new, link->prog, link, NULL, flags,
 			       id_or_fd, revision);
 	if (!ret) {
-		if (entry != entry_new) {
+		if (entry != entry_new)
 			netkit_entry_update(dev, entry_new);
-			netkit_entry_sync();
-		}
 		bpf_mprog_commit(entry);
 	}
 	return ret;
diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
index 0b9f4caeeb0a..de0021a66214 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -28,11 +28,8 @@
  *   [...]
  *   ret = bpf_mprog_attach(entry, &entry_new, [...]);
  *   if (!ret) {
- *       if (entry != entry_new) {
+ *       if (entry != entry_new)
  *           // swap @entry to @entry_new at attach location
- *           // ensure there are no inflight users of @entry:
- *           synchronize_rcu();
- *       }
  *       bpf_mprog_commit(entry);
  *   } else {
  *       // error path, bail out, propagate @ret
@@ -104,9 +101,12 @@
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
+ * bpf_mprog_commit() records the RCU state after the swap, bpf_mprog_peer()
+ * waits for it before the old bpf_mprog_entry is written again.
  *
  * The READ_ONCE()/WRITE_ONCE() pairing for bpf_mprog_fp's prog access is for
  * the replacement case where we don't swap the bpf_mprog_entry.
@@ -147,6 +147,7 @@ struct bpf_mprog_bundle {
 	struct bpf_mprog_cp cp_items[BPF_MPROG_MAX];
 	struct bpf_prog *ref;
 	atomic64_t revision;
+	unsigned long rcu_state;
 	u32 count;
 };
 
@@ -158,6 +159,12 @@ struct bpf_tuple {
 static inline struct bpf_mprog_entry *
 bpf_mprog_peer(const struct bpf_mprog_entry *entry)
 {
+	/*
+	 * The peer was active until the last swap and the caller is going
+	 * to overwrite it, therefore ensure that there are no inflight
+	 * users on it anymore.
+	 */
+	cond_synchronize_rcu(entry->parent->rcu_state);
 	if (entry == &entry->parent->a)
 		return &entry->parent->b;
 	else
@@ -172,6 +179,7 @@ static inline void bpf_mprog_bundle_init(struct bpf_mprog_bundle *bundle)
 
 	memset(bundle, 0, sizeof(*bundle));
 	atomic64_set(&bundle->revision, 1);
+	bundle->rcu_state = get_completed_synchronize_rcu();
 	bundle->a.parent = bundle;
 	bundle->b.parent = bundle;
 }
@@ -243,6 +251,7 @@ static inline void bpf_mprog_commit(struct bpf_mprog_entry *entry)
 {
 	bpf_mprog_complete_release(entry);
 	bpf_mprog_revision_new(entry);
+	entry->parent->rcu_state = start_poll_synchronize_rcu();
 }
 
 static inline u64 bpf_mprog_revision(struct bpf_mprog_entry *entry)
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 02db0113b8e7..0079be0b16f0 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -42,7 +42,6 @@ int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
-			tcx_entry_sync();
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);
@@ -156,7 +155,6 @@ static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id_or_fd,
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
-			tcx_entry_sync();
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);
-- 
2.47.3

