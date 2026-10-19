Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792431502;
	b=JctsVjrlywqPU+KTEPKXu9hBFl1BZyIo+Y1AiShWn3Dv7NdnnsF9Klg+Kd6fn8glq867
	 XtGUb6q+IrAY/KOE7BpwjNOE5JRYYvp5Hfg0FickD+Xa1oaq56SJaNB8kBBnjPF3u1MJY
	 BM628LoO91gTdKmLEjouZ0yUd/PpR0xKLQKprIIo+mKqi72qg/vgXblLxyY80UtoL/SEF
	 gK/ch6hEEwri9l1Kcch0iToJk9AjdcIj/icqKA77bdv0YUnidJyFrhLOnplwzSokWtgJu
	 0iv0v0xEZuOwlObZKaVPhLMCDybREbF/LLZDAPhc0Gk+KSl8RCgZwNoTmrtglFbV8Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431502;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DnMksxBeVgGBLISVAmVNMYiivsdCkOY1OzObG07U/BQ=;
	b=Quzto20dh0YsK9FlAw2dZGbwC5BOp5+1Tonq4jCW4R9BPb42q/PcJwtImMj24kTQZs4A
	 yggRbLnYtf1d7XvlqUzFHvEH46/1R0Ge9lcGIS2w2A1j/Qhg4ckrv/G0Z8d3yHzqjB6vq
	 qYufcpybUxudkf3qMbeLb1S3TVJNFlXdbEFEtRnLvryqWn+kRiM3jDQZEovvGRoJtl5Bo
	 1nWapYXI+V06VUpypsy1c3nqtixU9wqW8kHankkEA5bqm9wFpTClHyyLIePY2maOrgNWw
	 uhYsER1yK6QmTccsZTazLh8ihizqqPNVL3tFYTIxeACGEyGuLFufRdSakniWzPY2I2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhe+6Z2q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3EE606A31D;
	Mon, 19 Oct 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhe+6Z2q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792431501;
	b=ZkBhE66yOM2NGCjQ0+6OnHSDF3lhRpjaBb4ARxBX30NtbVTdUIbi91qgIwzifvTfHcCj
	 2pRKUB3crIs/lataXtXihOxlqLquZwUgU3jRJ5JaOUveLAJknVjE9xoO3OOmsGXM6IsDD
	 MhWCjAm+hxZ+I/LOYLREJaBfzlz/6sXrBHQQlkvYORlVr1vT5XzXXNuLCWT737OB0cK03
	 LZAn8Ugq9wzWTq5T8B/3MLri2uWQZZJcZGYNNLaC/FJ5iKzT2Q6ZsFAZStT4kthazisGy
	 pK1P0BIVkZ9iew9uRmpfVH+6ucQSPfAuWO6CuEqekULBmWg20SOnPQEUrDpuRjL978g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792431501;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DnMksxBeVgGBLISVAmVNMYiivsdCkOY1OzObG07U/BQ=;
	b=Df1+vpJh0LPkn/kBPBVIs3o27qkcWbqsPO6920CabUobQ71M3nqIXbprcuYFy71VeYWU
	 QEyomrqcB/K0RJ7nOi9SFbVRp02iC9JnbSlVJbJ3kXSj4E7EgLNqOP9nrsOQMBIydQmke
	 ULjpizcUnHzuuxqtat4IQ+gfTaFGMBGjIYgeD7WthfajFkyqPZ7Gs3ZBWWQIszNtzG7j2
	 5CfK1WLRp2CYNxrz5JVL5am4dMaJNq5IUxbD/9gJkLTwW8PHYV4RK2Gub2YcVjPlY6Qow
	 sT13AIxu09S4KWMo+6/P0O5Z5E7UtbZY+Wyt0yeteR15V+2wuth3FZwLk2K76UinPaw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F2B961F000C4;
	Mon, 19 Oct 2026 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431501;
	bh=DnMksxBeVgGBLISVAmVNMYiivsdCkOY1OzObG07U/BQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=lhe+6Z2qBF7EhuvKVl0Pq1oFenam5uSDpbvjbrmUoUSHYvJ6FdeArwSVgCs91cE1h
	 ZySVNNoD5j67mHskjs2tA4q3kTTZRYanYiQgt68gjpGtShlOKeNx46JD30Jfrb7B79
	 jExNGI3NKkKWLz1AQF2XKEJHxd6E8YrXST4S/OpeWIJVQ4EfTwTLhqYM2P0BDR/Y/V
	 1pe21A3c3IQ5VeBWrWVkZy8Ng4XVALZGmc1UDCljkNjVxENbnsGYuy6kaFeMp3CIMa
	 /g6baFC2Uw3Qwe/XWjlqOkNMtg/xn4KoYyR86JpdBwnR70qEJukf1QEVckw7d+VP1d
	 VsA7MRxQVIOeg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 53641400AB;
	Mon, 19 Oct 2026 17:38:20 +0000 (UTC)
From: Nicholas Velten via B4 Relay <devnull+nicholasfvelten.gmail.com@kernel.org>
Date: Mon, 19 Oct 2026 14:38:20 -0300
Subject: [PATCH bpf-next v2] bpf: Annotate data races on bpf_lru_node type
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
Message-Id: <20261019-fix-lru-node-type-kcsan-v2-1-c10a410b3565@gmail.com>
X-B4-Tracking: v=1; b=H4sIAItV1moC/4WOQQ6DIBREr2L+ur8R1Np01Xs0LgA/SqtgQI3Ge
 PeiPUCXk5k3MxsE8oYCPJINPM0mGGej4JcEVCtsQ2jqqIGn/MZSlqE2C3Z+QutqwnEdCD8qCIs
 5zwqV3gtZSgGRHjzF6Nn8AjlotLSMUP2cMMk3qfEoPrKtCaPz63liZifxd29myDCVZZ7pQmius
 2fTC9Ndleuh2vf9C54yZjLaAAAA
X-Change-ID: 20261013-fix-lru-node-type-kcsan-4235c085b7ba
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+1ea4f564bf6f1f3d1dc4@syzkaller.appspotmail.com, 
 Nicholas Velten <nicholasfvelten@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792431499; l=4464;
 i=nicholasfvelten@gmail.com; s=20261014; h=from:subject:message-id;
 bh=vlUE37PtQTyOLq5PXbvONu4Xi4bntjAirjuFev9xeZY=;
 b=JZxRDHgecZKvX7el63L+yAF4pfGpixN4R034psx0LcMfaL23UJrM4JhFNTmIoIeIF5DZ/pcRr
 RfDrhWOWENtDM/LNh0/BhEjQCrZIogg3RW0HBM7bSLKxo4vOgBIIyF1
X-Developer-Key: i=nicholasfvelten@gmail.com; a=ed25519;
 pk=WVTZgm6yXQ+XrhULAObg4lwcHPhhxAXrAY+YY6svXzg=
X-Endpoint-Received: by B4 Relay for nicholasfvelten@gmail.com/20261014
 with auth_id=1173
X-Original-From: Nicholas Velten <nicholasfvelten@gmail.com>
Reply-To: nicholasfvelten@gmail.com
Content-Transfer-Encoding: 7bit

From: Nicholas Velten <nicholasfvelten@gmail.com>

KCSAN reports a data race on bpf_lru_node::type between the LRU list
rotation and the free path of the common LRU:

  BUG: KCSAN: data-race in __bpf_lru_list_rotate / bpf_lru_push_free

  write to 0xffff88811b758022 of 1 bytes by task 4756 on cpu 1:
   __bpf_lru_node_move
   __bpf_lru_list_rotate_active
   __bpf_lru_list_rotate
   bpf_lru_list_pop_free_to_local
   bpf_common_lru_pop_free
   bpf_lru_pop_free
   htab_lru_map_update_elem

  read to 0xffff88811b758022 of 1 bytes by task 4752 on cpu 0:
   bpf_lru_list_push_free
   bpf_common_lru_push_free
   bpf_lru_push_free
   htab_lru_push_free
   htab_lru_map_update_elem

  value changed: 0x00 -> 0x01

bpf_lru_list_push_free() reads node->type for a WARN_ON_ONCE() sanity
check before taking l->lock. __bpf_lru_node_move(), called right after
under l->lock, does the same check, so drop the unlocked one.

bpf_common_lru_push_free() re-checks node->type under loc_l->lock after
the lockless READ_ONCE() at function entry. By then the node has been
removed from the htab, so only flush and rotate can change its type,
through __bpf_lru_node_move_in() and __bpf_lru_node_move() under
l->lock. Mark that re-check with READ_ONCE() and those two writers with
WRITE_ONCE(), following commit 6df8fb83301d ("bpf_lru_list: Read
double-checked variable once without lock"). The remaining writers
operate on a node with a single owner that nobody else reads and are
left alone.

Tested on bpf-next with CONFIG_KCSAN=y in a 4-vCPU virtme-ng guest,
using a reproducer that runs 8 threads issuing BPF_MAP_UPDATE_BATCH
on a 64-entry BPF_MAP_TYPE_LRU_HASH with overlapping keys.

Reported-by: syzbot+1ea4f564bf6f1f3d1dc4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1ea4f564bf6f1f3d1dc4
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Nicholas Velten <nicholasfvelten@gmail.com>
---
The reproducer used for testing is a small userspace program (8 threads
issuing BPF_MAP_UPDATE_BATCH on a 64-entry BPF_MAP_TYPE_LRU_HASH with
overlapping keys). I can post it, or turn it into a selftest, if that
would be useful.

Not tested: architectures other than x86_64, sparse, and the full
test_maps / test_progs suites (only test_lru_map was run).
---
Changes in v2:
- Drop the Fixes: tag (Alexei)
- Remove the unlocked WARN_ON_ONCE() in bpf_lru_list_push_free() instead
  of annotating it; __bpf_lru_node_move() does the same check under
  l->lock (Alexei)
- Keep WRITE_ONCE() only in __bpf_lru_node_move_in() and
  __bpf_lru_node_move(), the only writers that can race with the
  re-check in bpf_common_lru_push_free() (Alexei)
- Link to v1: https://patch.msgid.link/20261013-fix-lru-node-type-kcsan-v1-1-0b743f5af2f3@gmail.com
---
 kernel/bpf/bpf_lru_list.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 5ed7cb4b9..3858886b0 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -71,7 +71,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 		return;
 
 	bpf_lru_list_count_inc(l, tgt_type);
-	node->type = tgt_type;
+	WRITE_ONCE(node->type, tgt_type);
 	bpf_lru_node_clear_ref(node);
 	/* Reset pending_free only when moving to the free list */
 	if (tgt_type == BPF_LRU_LIST_T_FREE)
@@ -94,7 +94,7 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
 	if (node->type != tgt_type) {
 		bpf_lru_list_count_dec(l, node->type);
 		bpf_lru_list_count_inc(l, tgt_type);
-		node->type = tgt_type;
+		WRITE_ONCE(node->type, tgt_type);
 	}
 	bpf_lru_node_clear_ref(node);
 
@@ -298,9 +298,6 @@ static void bpf_lru_list_push_free(struct bpf_lru_list *l,
 {
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(node->type)))
-		return;
-
 	if (raw_res_spin_lock_irqsave(&l->lock, flags)) {
 		WRITE_ONCE(node->pending_free, 1);
 		return;
@@ -542,7 +539,7 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 			return;
 		}
 
-		if (unlikely(node->type != BPF_LRU_LOCAL_LIST_T_PENDING)) {
+		if (unlikely(READ_ONCE(node->type) != BPF_LRU_LOCAL_LIST_T_PENDING)) {
 			raw_res_spin_unlock_irqrestore(&loc_l->lock,
 						       flags);
 			goto check_lru_list;

---
base-commit: 763187dbbf83764a57d5811168ef9de7b9a60e2d
change-id: 20261013-fix-lru-node-type-kcsan-4235c085b7ba

Best regards,
--  
Nicholas Velten <nicholasfvelten@gmail.com>


