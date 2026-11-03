Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793731582;
	b=ImAjt4CJP0j4Cru5zsInxwDb7OWRQPadmbjpdy3o9XcBSn4mXl38f+j9KLmwsVIjsofg
	 qRFKcUZ82Ey1p7fakUmn4Ievyd0nqnQ5EhxmAEtQyBR6SpDhaZaTUxWsQXwd1FSQdWhz/
	 ShMtw7ErRdd49qhlhjA5iAV5f+nuSdosxFRNF5MoLHRPJjV1tn05SyK+gJ1W7IMVhyGr8
	 15cl6nB32kXv2YXGWz2H1XBmvuTroSp7712QnzbqfDt3CCa4EU02BpNY+lbOsSqsbk2sf
	 y9zNq8AP1JGyCJgfWc8YIwgtzHjTVsvmWttOB35SajSyZB4BcFM+qiIM0pNyqcHNQPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731582;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AKNP0YSrPQQyrujHx1udkkjSsaGnpEo3c0z+B5qETWc=;
	b=ROLfnqhN+CMYEZ/L7fGI8S4C3ieomWcSa90Pks/kLlkgdmP7fuinFOapvcbb6Pd2QpJl
	 85h4UdavtS0XOoa830534HFiQQ/wr23JrkHKHTsg45hzmzAuLAOc/gSKewX8YNE1G5raT
	 p1CQm+LN/QlNp2d5iuSSu4/Zl1Jjfj+Dso3Qc9jjzc+Y6rxAGV44wIcn7hIgL0EgrJhaZ
	 OTyZIYP8NU83JkHtd4MAad6ifaYAT6/0AUgnrLkQOuMiYqbWuNpd5VYEtCSLEb6YXObAy
	 S5Q8equGUc0fyQ/e6IGWiIeYMgvXaWh5npJIGPpZZYiEAG38cRqG2PnA9s2luUG93Dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VvjOMMSU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D18606A324;
	Tue,  3 Nov 2026 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VvjOMMSU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793731581;
	b=Gf90M9b6VEbi7NdyMmv9tVSU927mH7ueNYWL9djqiqUsO0+mxa6uI3fE83KXGDEP+Jx0
	 jKxf7AspFNY0isblJRSrTCiLGo89CEhUz0dtRcmBopAlhrIE3BeTjc33GFNNpyI8Dg1LS
	 TdM1GuZtCB2bkHJxl/XyfgFO+n2wAKp/i+EE8KHCAbWadK7w52AYQsd4lGBlGI8V6m8vz
	 xedkxvi5RXOSo8p1bocfN3+pdW2jXFQl5xc62Cocnx7W4G2xjRqglzFrcuaXnr20HwtNi
	 rGDX2WiwTGM0MbKBnyNe5LCBHZFIaG5Hw2Hynh3AYfV0jZ4f2F6zFDqW7/i6j+6dLHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793731581;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AKNP0YSrPQQyrujHx1udkkjSsaGnpEo3c0z+B5qETWc=;
	b=zKkLluRAC1LlYUXXG9yDgbwdk7YnoIbFwnJ+Rj5/ZZNRuJ5p6xz/g60d+CvOdE/XaIKa
	 wPyMs5vEOQZ0IOzHOAEjMeEIDJKuDB2hSE18Bv2bcweUax/WtKxbmgfo3n6KKra0FKY5K
	 pGgIOMyZ09EfEzMMOg3Oy8CbwqVJbLBigUd2CTjKlHnUe26HrT95oT+iZgOy/Fe9ql8+v
	 b0j/1/dlzcX+/DpBiusHIz+iOjSOtJRzFiTx/o+wJCqNfSm9pPakIuacgbwrYFUWKYBcp
	 5n09ar4KxCJmzE7ueaM8B0W36npVJlZ/TTe2smpQjJx9rXQ7Lo1V1Qp+WmGxpTnEW+w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0ABA61F000C1;
	Tue,  3 Nov 2026 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731581;
	bh=AKNP0YSrPQQyrujHx1udkkjSsaGnpEo3c0z+B5qETWc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=VvjOMMSUDUr7sIBvD1C4k9G++hovBmyPPwuedan8Ewb6iJxMIKJ+lL/wXq/RDL74N
	 ZeVvKb7FdO2lfE4ldsEmU435A52ea9mj3M1e2eWj7iQNisGkQ3vtyXRc/1ty4Tfd3/
	 iR4cW8zthcaXArcUdBmV/tr6j+dBfNwqjoCZE2DunDXFlofp5Jv3RUuaqm6Z/N6lbK
	 GxsTcstOSNln183Eb5yEuJstSyQpNYQFHq4aIIo8yOhr+TYF8P0WKeBxlLUtNiarVK
	 eGiZz7+z70RWqsLXyXcbBOgjtb/L8cJQByx3F8Zy39GLxU5RRB/aGzzPLkCbijjsJ7
	 UWwkaWVhNBQpQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 903FE46950;
	Tue,  3 Nov 2026 18:46:20 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Tue, 03 Nov 2026 13:46:20 -0500
Subject: [PATCH bpf] bpf: Fail rhtab inserts and deletes with IRQs disabled
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-bpf-rhtab-irqs-disabled-v1-1-9874d96a088c@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywqDMBAAf0X23IUklYD9Fekhj42uFKu7thTEf
 29ajzMws4OSMCncmh2E3qz8nCvYSwNpDPNAyLkyOOO8teaKcSko4xYisqyKmTXEB2VMrW996sg
 UclDrRajw53/uoUZwP6W+4kRp+z3hOL5OQ3zIgAAAAA==
X-Change-ID: 20261103-bpf-rhtab-irqs-disabled-c4646c9e0fe2
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykyta Yatsenko <yatsenko@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793731580; l=4598;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=k/fbalQH7E1usqP989+bFkfP43DzltNbY4941FlxG7Q=;
 b=L0FtAKcGFsRCo7qWQx89izPH5DV/0Lc1sSd0BeHxZN7aYi09wyNRr++7gm950zOYdQjmwMF9l
 yU1A1QSMTJvAQ2olkOHog2fGOluO/mvo7tspiwrIeTTMU6huyEiD0SF
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

A BPF program can spin forever on a resizable hash map's bucket lock
that its own CPU already holds.  Inserts and deletes take the
rhashtable bucket lock, a bit spinlock that can't detect re-entry.  The
resize worker calls the hash function with that lock held, so a kprobe
program on the hash function that deletes a key of the same bucket
never gets the lock:

  rht_deferred_worker()
    rht_lock(old_tbl, bkt)
    rhashtable_jhash2()
      kprobe program
        bpf_map_delete_elem()
          rht_lock(old_tbl, bkt)
            /* spins with IRQs disabled */

  [   29.890449] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  ...
  [   29.906964] NMI backtrace for cpu 0
  [   29.906977] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Tainted: G        W            7.3.0-17087-gd865f2677c44 #1 PREEMPT
  [   29.907021] Workqueue: events rht_deferred_worker
  [   29.907041] RIP: 0010:rhtab_delete_elem+0x15f9/0x1c80
  ...
  [   29.907139] Call Trace:
  [   29.907145]  <TASK>
  [   29.907193]  rhtab_map_delete_elem+0x61/0x120
  [   29.907208]  bpf_prog_12e9295082de5b34+0xa0/0xee
  [   29.907231]  trace_call_bpf+0x2ca/0x930
  [   29.907334]  kprobe_perf_func+0x106/0x700
  [   29.907381]  aggr_pre_handler+0x8f/0x110
  [   29.907403]  kprobe_int3_handler+0x335/0x750
  [   29.907433]  do_int3+0xd/0x50
  [   29.907445]  exc_int3+0x165/0x340
  [   29.907467]  asm_exc_int3+0x39/0x40
  [   29.907477] RIP: 0010:rhashtable_jhash2+0x5/0x360
  ...

A program in NMI over any holder of a bucket lock can do the same.

A bucket lock is only ever held with IRQs disabled, so return -EBUSY
from deletes and from inserts of new keys when IRQs are already
disabled, like the other hash maps do on re-entry.  Lookups and updates
of existing keys don't take the lock and still work.  With the fix, the
delete fails with -EBUSY and the resize finishes.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 1s.

Fixes: 16b4d3e2fb24 ("bpf: Implement resizable hashmap basic functions")
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
This is the check Alexei suggested on the RFC of the series [1].  It also
stops perf_event and other programs that run with IRQs disabled from
inserting or deleting keys.  I can turn the reproducer into a selftest
if that helps.

[1] https://lore.kernel.org/all/CAADnVQKvp2tnQSWW4Kh3ofGLvaEYJ47kyZeNUscAH_DShw8XHw@mail.gmail.com/

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/rhashlock.c
---
 kernel/bpf/hashtab.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6e2115477cb9..1a9f07b71bca 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3144,11 +3144,14 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 	int err;
 
 	/*
-	 * disable_instrumentation() mitigates the deadlock for programs running in NMI context.
-	 * rhashtable locks bucket with local_irq_save(). Only NMI programs may reenter
-	 * rhashtable code, bpf_disable_instrumentation() disables programs running in NMI, except
-	 * raw tracepoints, which we don't have in rhashtable.
+	 * rhashtable takes its bucket bit locks with IRQs disabled and can't
+	 * detect re-entry. With IRQs already disabled this CPU may already
+	 * hold one, e.g., in NMI or in a program attached inside the resize
+	 * worker's locked section.
 	 */
+	if (irqs_disabled())
+		return -EBUSY;
+
 	bpf_disable_instrumentation();
 
 	if (rhtab->map.key_size == sizeof(long))
@@ -3261,6 +3264,10 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 	if (atomic_read(&rhtab->ht.nelems) >= map->max_entries)
 		return -E2BIG;
 
+	/* see rhtab_delete_elem() */
+	if (irqs_disabled())
+		return -EBUSY;
+
 	elem = bpf_mem_cache_alloc(&rhtab->ma);
 	if (!elem)
 		return -ENOMEM;
@@ -3268,7 +3275,6 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
 
-	/* Prevent deadlock for NMI programs attempting to take bucket lock */
 	bpf_disable_instrumentation();
 
 	if (map->key_size == sizeof(long))

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261103-bpf-rhtab-irqs-disabled-c4646c9e0fe2

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


