Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660081;
	b=JkyuTegNIRAyyM53ccuN8m8oKe0Pjuxlgr98VGoHgwDxv4mggkbaOuTlCdRK5pfSzRZF
	 PMz2tBFkFlbfde+NegcO0qkksfD8Lpp6vgev/zSTk+UsikU+BeEtI4WqzyFdJaAMJggdc
	 IGzSkbGzD1iPR781DKZT3I5sjVmTqkWKp79NQsLfR2czu9FkrmgcjAqHFBnzuaFSN7TiT
	 8UHpdhjAzz9SZuJc4Gj4nYr1KuHEuyy5i6u7l8S2V7ETIE+0JOcLyUm0PVupa3OR3XTdP
	 zBM6B6PZr8fSc+Qoo+LTzqU8meEx1snhltwciKfb+AwqoRIYHFp59jgCRZsu4xBZr4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660081;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mrKm3r6+KeAx8vEVmUmrhYw4c89XmrEW63aeUDbFu+w=;
	b=4zjyL8RkpBg37/jWgFgMhl6nnpYnBlLC2x2c2OYNWhpO39UZ1hlqWFE0LGy9SL7Th81A
	 0BUYLzP/NBE4iy5ABWmpCw6CNWASF2iQY2Ptulb3j1wjrue+doDlo83KX7VvSmXJC0YVz
	 pN6KYZWEHzwl9DJrwUwrWGKEMzhOEbWAUmx+xXl4w+m8aP2J3tmHn+UhEF9taYMyQ3Nsv
	 pIL1zQgaQE9k2ZOqbT/fXp1eMAf3Q5ON234luYutOPKIY4CBvR8lK6fjeSkXNyfjHSbXJ
	 9sqLpERYuJ+BRdar7pHnCxWPjEHI1PpzjmKquuCTDAbyUBFzQyNi+ZesSSZB8iFV1bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sWhB4y0u;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D934606A327;
	Sat, 14 Nov 2026 12:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D934606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sWhB4y0u
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794660071; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mrKm3r6+KeAx8vEVmUmrhYw4c89XmrEW63aeUDbFu+w=;
	b=sWhB4y0uJyjVnWX1EPY8Wjc2g4TG7q9UtsVpSssZBT4lWpXov1eDro91/7Te1/rxPQ4lvRNZyTXjEpir838yoT5XrPIJmCz7tvRJ4IUCB3+Zn4iHmXi5C7cG+jNtPL8bCaoij9jlp6l3SBGJXrBEN4Uwiw4OBoTaGD3hY71CNn4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=shijing.wuqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XEhae5E_1794660055;
Received: from localhost.localdomain(mailfrom:shijing.wuqi@linux.alibaba.com fp:SMTPD_---0XEhae5E_1794660055 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 14 Nov 2026 20:41:10 +0800
From: Qi Wu <shijing.wuqi@linux.alibaba.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next] bpf, tcx: Skip RCU synchronization when the entry was newly created
Date: Sat, 14 Nov 2026 20:40:38 +0800
Message-ID: <20261114124039.111360-1-shijing.wuqi@linux.alibaba.com>
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

tcx_prog_attach() and tcx_link_prog_attach() call tcx_entry_sync()
unconditionally after tcx_entry_update(). tcx_entry_sync() is a bare
synchronize_rcu() whose stated purpose is to ensure there are no
inflight users of the bpf_mprog_entry that got swapped out, so that
the next attach can safely reuse it as the peer and bpf_mprog_commit()
can safely drop the old prog reference.

When tcx_entry_fetch_or_create() reports created == true, the entry
being swapped out is bundle.a of a freshly allocated tcx_entry that
has never been published: dev->tcx_{ingress,egress} was NULL, so
sch_handle_ingress() and sch_handle_egress() always dereferenced NULL
and returned early. No RCU reader can hold a reference to it.
entry->parent->ref is also NULL on this path, because
bpf_mprog_mark_for_release() is only called from bpf_mprog_delete(),
so bpf_mprog_commit() does not drop any prog reference either.

Both preconditions for the grace period are therefore absent and the
synchronize_rcu() is pure overhead. It runs inside the rtnl_lock()
critical section, so it also serializes the whole machine's network
control plane. This is visible when creating containers or sandboxes
in bulk: each new netdev needs one first attach per direction, i.e.
2N grace periods for N devices, all serialized under RTNL.

Skip tcx_entry_sync() when created is true. Note that created means
"this direction had no tcx_entry before", not "this is the first BPF
program": if a clsact or ingress qdisc was created first,
ingress_init()/clsact_init() already published bundle.a via
tcx_entry_update(), so created is false and the sync is still
performed. This mirrors the existing behaviour of those two functions,
which publish a newly created entry without any synchronize_rcu().

Detach, replace, multi-program chains and the error rollback path are
unchanged. The replace path already skips the sync today, since
bpf_mprog_replace() returns entry_new == entry.

The numbers below come from an A/B pair built from the same bpf-next
base (2e14a351662d) with identical configs apart from LOCALVERSION, and
all lock/RCU debugging disabled. 64 vCPU KVM guest, CONFIG_HZ=1000,
CONFIG_NO_HZ_FULL=y. 30 iterations per scenario, plus ftrace kprobes
on tcx_prog_attach, tcx_link_attach and synchronize_rcu filtered by
common_pid.

bpf() syscall latency, base -> patched:

  scenario                     base        patched     change
  first link attach (ingress)  12.730 ms   263.8 us    -97.9%  48x
  first link attach (egress)   12.824 ms   286.0 us    -97.8%  45x
  first prog attach (fd API)   12.462 ms   273.5 us    -97.8%  46x
  attach #1 on a device         9.870 ms   204.8 us    -97.9%  48x
  bulk, per device (2 dirs)    13.746 ms   296.2 us    -97.8%  46x

Where the time went, from the ftrace attribution:

  scenario          base total  base sync  share   patched total  sync
  first link        12.113 ms   11.923 ms  98.4%   243.5 us       none
  first prog        11.435 ms   11.260 ms  98.5%   293.7 us       none
  bulk, 64 attaches  6.560 ms    6.552 ms  99.9%     7.4 us       none

Creating 32 veth devices and attaching tcx to ingress and egress on
each (64 first attaches, all serialized under rtnl_lock):

  base     440.184 ms
  patched    9.930 ms      -97.7%, 44x faster

BPF_PROG_QUERY, which takes RTNL but performs no sync, averages 0.8 us
on both kernels, so lock acquisition itself is not the cost.

The created=false paths keep their grace period, as intended:

  scenario                     base sync   patched sync
  clsact qdisc first           11.924 ms   11.972 ms
  attach #2..N on a device      6.749 ms    7.303 ms

synchronize_rcu() call counts were checked per caller and match the
expectation exactly in all 12 cases: the attach-path counts drop to
zero for created=true scenarios, stay identical for created=false
scenarios, and every detach/release count is unchanged.

Functional checks pass on the patched kernel: attachment ordering
(BPF_F_BEFORE/BPF_F_AFTER), BPF_F_REPLACE, expected_revision/-ESTALE,
duplicate attach/-EEXIST, full detach and re-attach.

A concurrency test runs flood ping through a veth pair split across
two net namespaces while repeatedly attaching and detaching a chain
of tcx links. Each cycle detaches everything, which frees the bundle,
so the next cycle hits created == true again: 300 cycles exercised
300 created=true and 900 created=false attaches under live traffic,
with no failures and no RCU or memory-safety splats in dmesg.

BPF CI was run on this change via kernel-patches/bpf pull request #14821:

  https://github.com/kernel-patches/bpf/pull/14821

42 checks passed and none failed, across x86_64 gcc-15, x86_64 llvm-21,
aarch64 gcc-15 and s390x gcc-15. This covers test_progs (including
tc_links, tc_opts and tc_netkit), test_progs_no_alu32, test_progs_cpuv4,
test_progs_parallel, test_progs_no_alu32_parallel, test_maps and
test_verifier. The tc_links cases exercise both branches of this change:
dev_mixed attaches tcx before creating the clsact hook (created == true),
while chain_classic creates the hook first (created == false).

netkit has the same pattern: netkit_entry_fetch() falls back to
&nk->bundle.a when nk->active is NULL, so its first attach also waits
for a grace period on an entry that was never published. Addressing that
is left to a separate change to keep this one minimal.

The analysis and the measurement harness were produced with the help
of an AI coding assistant; the change was reviewed by the submitter.

Signed-off-by: Qi Wu <shijing.wuqi@linux.alibaba.com>
---
 kernel/bpf/tcx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 02db0113b8e7..7652069271e0 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -42,7 +42,11 @@ int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
-			tcx_entry_sync();
+			/* A newly created entry was never published, so
+			 * there are no inflight RCU users to wait for.
+			 */
+			if (!created)
+				tcx_entry_sync();
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);
@@ -156,7 +160,11 @@ static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id_or_fd,
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
-			tcx_entry_sync();
+			/* A newly created entry was never published, so
+			 * there are no inflight RCU users to wait for.
+			 */
+			if (!created)
+				tcx_entry_sync();
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);
-- 
2.47.3

