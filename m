Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.161.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655700;
	b=aMNOqV+3aWXAuC5X2u+E+Z0r46S72CtbmFNg4iyj0lS8DdvZ6bNYn9fD+d8KhbsD9KEu
	 n16sV4J3jqm3X+hT073UnXppkrmvw+QKwaJ/RyEraVBzLXes4rfQsqle10P9G8V0G0fDJ
	 N3gEwizUP7UfflsWpkj6E0YUlRsigsob9dhlkUbJO39LsMgsWbrd/024hyjiqEqWUu48Q
	 fx01b4KO9x6yqG/W1OrbNArc7bR2Fy63G2g52yn/Zu1lKU+1XMGpVbjdOul2g7Pe8a1yW
	 tzJf/T5G/ki46sPUBR4IL4EPIlZ0ovs4qM6rhJL09MzhThf0RMi00Vx4sR8d/kAnfdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655700;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=hoZxFtjWAwP2ShK8YBvvbvnMsPs7U30uesBNuuyMdNA=;
	b=nQyqmfOhiI08vu0FWhlMeGoeB0FntiUJSDI4arCpW/B907kwlHGCZSGlbE8GLHfhFab7
	 KbQWdJ42hj1RlahP+HSJf55YQviLk8xk1yJwGIhY8eF8m93msSGvKAlOjPYmx2cSdvPzC
	 TN7TU1rA1tgS4BQENw4nsXpEgpEEXEg+7N/hKAnL7k5mYZO2WQX8SrmvRZFPSqV/4y/M9
	 pWKJIgJSb83UQriU+fY3vnzOArk2bltpL4a1bEgtyRQMarhpRrzXCY5SRMVkPRPUJDITw
	 RZieu1GUkNi+AV/IkClUehdvaQaSyzoLRmGnfL4thMuzhxZ/Ry7YmPPW6b6UXC39gXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hust.edu.cn;
	spf=pass smtp.mailfrom=hust.edu.cn;
	arc=none smtp.remote-ip=162.243.161.220
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AC3606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 01:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22AC3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with UTF8SMTP id IQEQrMDmzRAPiAdreqIEAA--.11831S2;
	Thu, 26 Nov 2026 09:14:55 +0800 (CST)
Received: from pride-PowerEdge-R740.tailb307d0.ts.net (unknown [10.12.191.55])
	by gateway (Coremail) with SMTP id _____wAXrRUKiAdrt3MhAA--.17286S2;
	Thu, 26 Nov 2026 09:14:51 +0800 (CST)
From: Quan Sun <m202672221@hust.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	emxor@gmail.com,
	Quan Sun <m202672221@hust.edu.cn>
Subject: [PATCH] bpf: Require a bpf_spin_lock for bpf_list_head and rb_root
Date: Thu, 26 Nov 2026 09:14:47 +0800
Message-ID: <b887fe56f02f8578e41cf0009da7638fb6f8ec0c.1795627805.git.m202672221@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:IQEQrMDmzRAPiAdreqIEAA--.11831S2
Authentication-Results: app2; spf=neutral smtp.mail=m202672221@hust.ed
	u.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxZr47WF48WF4rXFWUury5CFg_yoWrJw1fpa
	y5tr98Cr1kJrn3Zw4DWFnF9rWayws0g3W3GFWUW34YkF4Sgr9xXr1xGF45ZryYkrZ3trs7
	AFn0ga9xAr1DAFDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH0b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUYVMNUUUUUU==
X-CM-SenderInfo: bpsqjlqxssjio6kx23oohg3hdfq/

Commit 0de2046137f9 ("bpf: Implement verifier support for rqspinlock")
relaxed the btf_parse_fields() check so that a bpf_list_head or
bpf_rb_root is accepted with only a bpf_res_spin_lock in the containing
type:

	if ((btf_record_has_field(rec, BPF_LIST_HEAD) ||
-	     btf_record_has_field(rec, BPF_RB_ROOT)) && rec->spin_lock_off < 0) {
+	     btf_record_has_field(rec, BPF_RB_ROOT)) &&
+		 (rec->spin_lock_off < 0 && rec->res_spin_lock_off < 0)) {

The release path was not updated to match.  bpf_obj_free_fields() still
only knows struct bpf_spin_lock:

	case BPF_RB_ROOT:
		if (WARN_ON_ONCE(rec->spin_lock_off < 0))
			continue;
		bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);

so the first map of this shape that is freed splats:

  struct poc_graph {
  	struct bpf_res_spin_lock lock;
  	struct bpf_rb_root root __contains(poc_node, node);
  };

  WARNING: kernel/bpf/syscall.c:880 at bpf_obj_free_fields+0x321/0x350, CPU#3: kworker/u16:5/67
  Workqueue: events_unbound bpf_map_free_deferred
  RIP: 0010:bpf_obj_free_fields+0x321/0x350
  RDX: ffffffffffffffea
  Call stack:
   array_map_free+0xa4/0x230
   bpf_map_free_deferred+0x122/0x200
   process_one_work+0x53e/0xdd0

RDX is -22, i.e. rec->spin_lock_off == -EINVAL.  The WARN_ON_ONCE() is
the only thing standing between the release path and

	bpf_rb_root_free(field, field_ptr, obj + -22)

which would run __bpf_spin_lock_irqsave() on a pointer before the start
of the object and then treat whatever it finds there as a lock.  The
guard holds today only because btf_parse_fields() stores a negative
errno in spin_lock_off; it is a load-bearing coincidence, not an
invariant the code states anywhere.

Nothing in the tree relies on the relaxed form yet: no type in kernel/
or tools/testing/selftests/bpf/ has both a bpf_res_spin_lock and a
bpf_list_head/bpf_rb_root, and the commit being fixed came without a
test for that combination.  Restore the original requirement and let a
follow-up teach bpf_{list_head,rb_root}_free() about rqspinlock if
res-only guarding is actually wanted.  The BPF_F_LOCK checks in
syscall.c already use btf_record_has_field(rec, BPF_SPIN_LOCK) and are
unaffected.

With this patch the BTF of the map above is rejected, so a record with a
res-only guarded container cannot be created at all:

  libbpf: BTF loading error: -EINVAL

This change was drafted with an AI coding assistant during a BPF
subsystem audit. I reviewed the code, built the kernel and ran the
reproducer before and after, and take responsibility for it.

Fixes: 0de2046137f9 ("bpf: Implement verifier support for rqspinlock")
Signed-off-by: Quan Sun <m202672221@hust.edu.cn>
---

Reproduce: boot bpf-next master (8dfce13340ae, 7.4.0-rc3-g8dfce13340ae,
CONFIG_KASAN=y) in qemu and only create then close an ARRAY map whose
value type has a bpf_res_spin_lock and a bpf_rb_root with a
__contains() tag.  No BPF program and no bpf_rbtree_add() is needed:
bpf_map_free_deferred() hits the WARN on the plain free path.

 kernel/bpf/btf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c4386a9a1ad..1008bc4c073 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4302,8 +4302,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 
 	/* bpf_{list_head, rb_node} require bpf_spin_lock */
 	if ((btf_record_has_field(rec, BPF_LIST_HEAD) ||
-	     btf_record_has_field(rec, BPF_RB_ROOT)) &&
-		 (rec->spin_lock_off < 0 && rec->res_spin_lock_off < 0)) {
+	     btf_record_has_field(rec, BPF_RB_ROOT)) && rec->spin_lock_off < 0) {
 		ret = -EINVAL;
 		goto end;
 	}
-- 
2.43.0

