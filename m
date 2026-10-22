Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792648098;
	b=SsHUFBTI9H6VDkpawFL9JBpOBBWw+ZnhSYX6yyzLV47uiDRmKF6qnoZzfhNrGPKTbQX6
	 ICP5rzSucR0OachnhzQROV+dtJgUdW6UwvDQeb0m37i2nvyIUUrvWsS8F1ps1H1RD5WKo
	 zzeUNJzj77yzAVGqgDPaUBM9dH2X2yQVM21GzFvI7bfyi5Nbvyl3gLMzCAjLeSFm8n8y8
	 BQVNRCtsRMBrRikZW/0S/HzEo9uIdDnYO1oxXB9qSaOI0y69emODffY43AR59/QrRu9Sk
	 E7Htl6IQboLmH4JP+wmFMFYw5lXzHHON8V+LGRxKpnpzuRcBzgdnf/glnfkA8vgZviw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792648098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9iUZRB7DdZpj4oQEX0/Fw+dU5phcWs0bFKzSNLar0ak=;
	b=bRkFgZA/N53rQzKJCSrtpg0n/wbZpsEBOtjukQm27LhZbBeOQWZ5mAWPiUfoyeE0dpAD
	 USJUVCX/7SyLm/KG2zIW+0w9wT2TQ34by8ZqREyjD/1UCqi4rhSXckHYdwVkVaGS7nNLr
	 3YDjJqyuQjp42VbYnjry4pmN66Nu+yPFufvYE/szcpjztClV0OQ3pWrtq1kpSjWqxXqZ0
	 s5ZYW60N49X7Tqzi4wUWiwZp0VLB5Y6uacSuJIIyGxk7t6ZJOoyexa3bS1PbnYdKISiF2
	 0pdn5CywqFhVyohlH37fqxC3LuHrxZGa9xGjTmb5q4/a3fKGVJdkDRt7DifDeXJtnmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R0+lGWax;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB72606A31A
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 05:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAB72606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R0+lGWax
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso860033a91.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792648097; x=1793252897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9iUZRB7DdZpj4oQEX0/Fw+dU5phcWs0bFKzSNLar0ak=;
        b=R0+lGWaxSnQVRvcQbN9nHZHI4Chs+KJm3LGQjWazWEz/D7zVpm2Ef2ZnknMBbuID/0
         E/jCL9vEbNvQBLIt2ziHaYNutcA8WMR2KXzT4U708IApBYutEaW3lRZDIZyIEUMEfy8H
         0bFBR5L942+38NB4e3KeLAp9sAqdaVVNR7uhivvxlY8J5YI7UtliYRBkMF/s8gIr6wjN
         la+TUUWmFaauUnwN0jYz8dP7v1dQkq702kWWxhbm8m4obS2grrXrjjLfzFfNRg/WsppN
         ClZRFv+FscTmbXCR8EK8UdjnZibcxA40Fa5NF0+jSCaDHIQiVVm2FiYvSq4PgBdho9/e
         UMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792648097; x=1793252897;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9iUZRB7DdZpj4oQEX0/Fw+dU5phcWs0bFKzSNLar0ak=;
        b=b0v8ZOp4bzKZ3jEMd+DOjxn6WW/2rse+FCXpakHhQiwTSpVud2TdTrSYkWXlvfFJjQ
         jSnBbYuEi6v+dVXb7v/2JOTmSdXe/Vkpt9N76fX1m7Y1WtG6bSsIUjkKPJrYdR4Xv6Pw
         G+7/T0WNVHbzVTitaem7VdsayZGX2UH8VWrGJaloNVgE05CD8JfufoWSe3ERVtegM7kp
         bY2iYNn06E8ecvHgTFxPY5KlK4Mx8ODbKwidqKG/LCObUIa8gESuM0KbNzj7IIAB4jv0
         j6WEvaYckUraR9mXM267gGPvdFeD3H776NWMV7JzINYJ0DukJoBwdcfBgnoV4Dsgi8yn
         kZeA==
X-Forwarded-Encrypted: i=1; AKwUvBwgaFwmMJFZu+uBBrzcrQZBVQO0TNHXhFVioorEDZnSt6Q15VlrRQWwCPE0o6aB/F4ffiY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXspfOm2nBLgbh7DoozBjbJFqcdophtXB6tts2GPkBK3lJgNt4
	p9FgVpl6M6u0ybVrCeP3eH4mq4mjV554ec09yeFz1GHr2fsIKwal8esVe8NVxw==
X-Gm-Gg: AYBFou3c4Jgz3RPrp+X8CuapS47td5CNxBXbns4+/mQwV8o5W7G7cuvS+3yQUa3BptU
	vUk7Rua9g8ILOQpo4xtrQrISP9WW9N6ETUGtfNpVxXds8F6/AN6eSRHYyxzDxHlF4uuEoKUFiFh
	8UAgsfByGPQHoFNkSr/gAXTo6AfMlXxrTGEsA0clzs0zLHWfpjEFGD/UVxW57yEjDPmA5W6NAGL
	aMmpSAlI0r7kxvkBBQxKuyincsrDBBL5bqjvDEQUMGmR5Gq0PO8ImOA7wuyQUtn870L2wsJt4Oc
	YlpuD47QA4SWOr4sx27VFizjZVIKwIQLZscWNiewShAXjUmIRdl7vy/kdX5iJp1aun/kS/xyO6V
	6wjHWuTl6KjgJjGyhv0+0+r1HAO8ZNuYsHeVZp9X2Y2SASkTdMJHoxOpxAoEGFhdEkwMrRTWRV/
	UxpoQ4PBfYfNagRYEg/n6ms94cvSjCQyp6yV4IVDC3nQEfT7agEU0WPr1xTrS7EewMYJZHpOWwm
	dgxFiUHMG4RTsWe112fbaj8RODeVV3zXoMM4MA47K3sTTi3EG+eILfc/1jtBwCm6IEHEQQ45Vck
	5m8b3Qc6a5QH+2x4NQpqQY4OO+j3aG7h5i77tsxmeT911OQIPYTdsJ+jCHk/YVATzYmVCH8vMQ6
	OCqjKu3GEjEM=
X-Received: by 2002:a17:90b:4b92:b0:3a7:d2b5:2e99 with SMTP id 98e67ed59e1d1-3ad86c7abf9mr3317341a91.20.1792648097005;
        Wed, 21 Oct 2026 22:48:17 -0700 (PDT)
Received: from localhost.localdomain ([218.253.131.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b434e67sm18767215ad.27.2026.10.21.22.48.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:48:16 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data races
Date: Thu, 22 Oct 2026 13:48:11 +0800
Message-Id: <20261022054811.35008-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20261021155629.68813-1-phx0fer@gmail.com>
References:  <20261021155629.68813-1-phx0fer@gmail.com>
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

The sockmap link/unlink paths touch three psock fields from one CPU while
another CPU touches them under a different lock.  A KCSAN run with two
SOCKMAPs sharing one socket reports all three:

  BUG: KCSAN: data-race in sock_map_link / sock_map_unref
  BUG: KCSAN: data-race in sock_map_link / unix_dgram_bpf_update_proto
  BUG: KCSAN: data-race in sk_psock_start_verdict / sock_map_unref

  - psock->psock_update_sk_prot: written in sock_map_init_proto() without
    sk->sk_callback_lock, read in sock_map_del_link() under it.
  - psock->saved_data_ready: written by sk_psock_start_verdict() under
    sk->sk_callback_lock, read in sock_map_del_link() under
    psock->link_lock -- a different lock instance.
  - sk->sk_prot: replaced by sock_replace_proto() (via the protocol's
    psock_update_sk_prot()) under sk->sk_callback_lock, read by
    sock_map_link() / sock_map_sk_is_suitable() outside it.

Annotate every one of these accesses with READ_ONCE()/WRITE_ONCE(),
matching the existing convention for the same fields: sk->sk_data_ready
and sk->sk_write_space were already annotated this way, as were the
sk_psock_stop_strp() accesses to saved_data_ready.  The indirect calls
read the pointer once into a local, so the guard and the call cannot see
different values.

No Fixes: tag: the three fields were introduced by three different
commits, so no single one is the origin.  psock->saved_data_ready was
folded into struct sk_psock by commit 5a685cd94b21 ("skmsg: Get rid of
struct sk_psock_parser"); the psock->psock_update_sk_prot read in
sock_map_del_link() came with commit c0d95d3380ee ("bpf, sockmap:
Re-evaluate proto ops when psock is removed from sockmap"); the lockless
sk->sk_prot reads are older still.

Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
v2:
 - Drop the Fixes: tag; the three fields came from three different
   commits, so explain the provenance in the message instead (bpf-ci).
 - Read the function pointer once into a local before the guard and the
   call, so the two cannot see different values: psock->saved_data_ready
   in sk_psock_stop_strp() and sk_psock_stop_verdict(), and
   psock->psock_update_sk_prot in sk_psock_restore_proto(),
   sock_map_del_link() and sock_map_init_proto() (Jakub).
 - READ_ONCE() the source sk->sk_data_ready in sk_psock_start_strp()
   and sk_psock_start_verdict() (Jakub).
 - Annotate the sock_map.c accesses that KCSAN actually reports:
   sock_map_init_proto(), sock_map_del_link(), sock_map_link(),
   sock_map_psock_get_checked() and sock_map_sk_is_suitable()
   (Alexei).

Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (KCSAN); it
reported the races above.  The reproducer source is not posted here per
Documentation/process/security-bugs.rst; it is available on request.

Post-fix verification
---------------------
Tested: the patch was built for arm64 and booted in a QEMU guest with
KCSAN; the reproducer passes.  Concretely, the reproducer was re-run on
the guest, once on the base tree and once with this patch applied.  On
the base tree the sockmap-path races are five -- the three listed above,
plus

  BUG: KCSAN: data-race in sock_map_update_elem_sys / unix_dgram_bpf_update_proto
  BUG: KCSAN: data-race in sk_psock_stop_verdict / sock_map_unref

With this patch all five are gone and no new race is introduced.  The map
operations complete identically in both runs (same op counts, no failures,
no KASAN memory errors), so the annotation does not change behaviour.

The reproducer also reports four unrelated races that this patch does not
touch and that fire the same way with or without it: three are the
socket-lock fast path (the 8-byte try_cmpxchg on sk_lock.combined against
the slock-protected sk_lock.owned write, by design), and one is a plain
sk->sk_prot read in generic release_sock(), which is a different scope
from the sockmap paths annotated here.

Triggering conditions
---------------------
CAP_BPF / the ability to update sockmap and attach verdict programs.
The two writers run on separate CPUs (the guest has 2), one cycling a
map with a verdict program, the other a bare map, on the same socket.

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and the affected objects were rebuilt for arm64
with the KCSAN config -- no new warnings or errors.  scripts/checkpatch.pl
reports 0 errors, 1 warning (its 'BUG: KCSAN:' commit-message
heuristic, i.e. it is asking for a Fixes: tag, which we deliberately omit).

 include/linux/skmsg.h |  7 +++++--
 net/core/skmsg.c      | 24 +++++++++++++++---------
 net/core/sock_map.c   | 34 +++++++++++++++++++++-------------
 3 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index d5e35f24738d..cb17426f63be 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -488,8 +488,11 @@ static inline void sk_psock_cork_free(struct sk_psock *psock)
 static inline void sk_psock_restore_proto(struct sock *sk,
 					  struct sk_psock *psock)
 {
-	if (psock->psock_update_sk_prot)
-		psock->psock_update_sk_prot(sk, psock, true);
+	int (*update_proto)(struct sock *sk, struct sk_psock *psock, bool restore);
+
+	update_proto = READ_ONCE(psock->psock_update_sk_prot);
+	if (update_proto)
+		update_proto(sk, psock, true);
 }
 
 static inline struct sk_psock *sk_psock_get(struct sock *sk)
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5a961e..54d832039f09 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1167,22 +1167,25 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 
 void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
 {
-	if (psock->saved_data_ready)
+	if (READ_ONCE(psock->saved_data_ready))
 		return;
 
-	psock->saved_data_ready = sk->sk_data_ready;
+	WRITE_ONCE(psock->saved_data_ready, READ_ONCE(sk->sk_data_ready));
 	WRITE_ONCE(sk->sk_data_ready, sk_psock_strp_data_ready);
 	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
 
 void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
 {
+	void (*saved_data_ready)(struct sock *sk);
+
 	psock_set_prog(&psock->progs.stream_parser, NULL);
 
-	if (!psock->saved_data_ready)
+	saved_data_ready = READ_ONCE(psock->saved_data_ready);
+	if (!saved_data_ready)
 		return;
 
-	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
+	WRITE_ONCE(sk->sk_data_ready, saved_data_ready);
 	WRITE_ONCE(psock->saved_data_ready, NULL);
 	strp_stop(&psock->strp);
 }
@@ -1260,22 +1263,25 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 {
-	if (psock->saved_data_ready)
+	if (READ_ONCE(psock->saved_data_ready))
 		return;
 
-	psock->saved_data_ready = sk->sk_data_ready;
+	WRITE_ONCE(psock->saved_data_ready, READ_ONCE(sk->sk_data_ready));
 	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
 	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
 
 void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
 {
+	void (*saved_data_ready)(struct sock *sk);
+
 	psock_set_prog(&psock->progs.stream_verdict, NULL);
 	psock_set_prog(&psock->progs.skb_verdict, NULL);
 
-	if (!psock->saved_data_ready)
+	saved_data_ready = READ_ONCE(psock->saved_data_ready);
+	if (!saved_data_ready)
 		return;
 
-	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
-	psock->saved_data_ready = NULL;
+	WRITE_ONCE(sk->sk_data_ready, saved_data_ready);
+	WRITE_ONCE(psock->saved_data_ready, NULL);
 }
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 38df84284328..4dc69316ac17 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -145,6 +145,7 @@ static void sock_map_del_link(struct sock *sk,
 {
 	bool strp_stop = false, verdict_stop = false;
 	struct sk_psock_link *link, *tmp;
+	int (*update_proto)(struct sock *sk, struct sk_psock *psock, bool restore);
 
 	spin_lock_bh(&psock->link_lock);
 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
@@ -152,11 +153,11 @@ static void sock_map_del_link(struct sock *sk,
 			struct bpf_map *map = link->map;
 			struct sk_psock_progs *progs = sock_map_progs(map);
 
-			if (psock->saved_data_ready && progs->stream_parser)
+			if (READ_ONCE(psock->saved_data_ready) && progs->stream_parser)
 				strp_stop = true;
-			if (psock->saved_data_ready && progs->stream_verdict)
+			if (READ_ONCE(psock->saved_data_ready) && progs->stream_verdict)
 				verdict_stop = true;
-			if (psock->saved_data_ready && progs->skb_verdict)
+			if (READ_ONCE(psock->saved_data_ready) && progs->skb_verdict)
 				verdict_stop = true;
 			list_del(&link->list);
 			sk_psock_free_link(link);
@@ -171,8 +172,9 @@ static void sock_map_del_link(struct sock *sk,
 		if (verdict_stop)
 			sk_psock_stop_verdict(sk, psock);
 
-		if (psock->psock_update_sk_prot)
-			psock->psock_update_sk_prot(sk, psock, false);
+		update_proto = READ_ONCE(psock->psock_update_sk_prot);
+		if (update_proto)
+			update_proto(sk, psock, false);
 		write_unlock_bh(&sk->sk_callback_lock);
 	}
 }
@@ -189,10 +191,13 @@ static void sock_map_unref(struct sock *sk, void *link_raw)
 
 static int sock_map_init_proto(struct sock *sk, struct sk_psock *psock)
 {
-	if (!sk->sk_prot->psock_update_sk_prot)
+	int (*update_proto)(struct sock *sk, struct sk_psock *psock, bool restore);
+
+	update_proto = READ_ONCE(sk->sk_prot)->psock_update_sk_prot;
+	if (!update_proto)
 		return -EINVAL;
-	psock->psock_update_sk_prot = sk->sk_prot->psock_update_sk_prot;
-	return sk->sk_prot->psock_update_sk_prot(sk, psock, false);
+	WRITE_ONCE(psock->psock_update_sk_prot, update_proto);
+	return update_proto(sk, psock, false);
 }
 
 static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
@@ -202,7 +207,7 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (psock) {
-		if (sk->sk_prot->close != sock_map_close) {
+		if (READ_ONCE(sk->sk_prot)->close != sock_map_close) {
 			psock = ERR_PTR(-EBUSY);
 			goto out;
 		}
@@ -303,7 +308,8 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 	}
 
 	write_lock_bh(&sk->sk_callback_lock);
-	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
+	if (stream_parser && stream_verdict &&
+	    !READ_ONCE(psock->saved_data_ready)) {
 		if (sk_is_tcp(sk))
 			ret = sk_psock_init_strp(sk, psock);
 		else
@@ -314,9 +320,11 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 			goto out;
 		}
 		sk_psock_start_strp(sk, psock);
-	} else if (!stream_parser && stream_verdict && !psock->saved_data_ready) {
+	} else if (!stream_parser && stream_verdict &&
+		   !READ_ONCE(psock->saved_data_ready)) {
 		sk_psock_start_verdict(sk,psock);
-	} else if (!stream_verdict && skb_verdict && !psock->saved_data_ready) {
+	} else if (!stream_verdict && skb_verdict &&
+		   !READ_ONCE(psock->saved_data_ready)) {
 		sk_psock_start_verdict(sk, psock);
 	}
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -536,7 +544,7 @@ static bool sock_map_redirect_allowed(const struct sock *sk)
 
 static bool sock_map_sk_is_suitable(const struct sock *sk)
 {
-	return !!sk->sk_prot->psock_update_sk_prot;
+	return !!READ_ONCE(sk->sk_prot)->psock_update_sk_prot;
 }
 
 static bool sock_map_sk_state_allowed(const struct sock *sk)
