Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756261;
	b=bpcWC8O+45C4UV9xG8fXqyNTx3U2B1Zd0oyi3rKLB6crqhZ0H/SQgqi7HhkbnqbcAA3g
	 WqsFcfg4dHbYI+iTBPRZxBTM9pV8WZQTIGG1BGK1tmYOxf6f4/N5M7G68oVhUQkDUR+Zl
	 zhsjmOiDqHCIWlgLKpPNOtUQ987jGv7BFN/eRpHmUEuZqsua4ef22mTip3vEUqRPZa+e2
	 61SYlJiUjfC7vyNCI68NdS/jPHsAW8BhcNtsmHozFjm+vdZevTh1dtsL2g5g1yK0LE0mZ
	 GPMCa9T1nr7vk1+IZNyHil0ume3IEdhylGunvqQsi4IOttNfkGD048FF0nHWac2J81g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RsdeMcHfOtRvnpyG5YaLPUdVfJcBoSbUaq4yQfndVIw=;
	b=dlls6gMk0mRXmqpDHe4KCsOX0zzACgFve3zL9CnMJ8OvCn1dVGAOa0d2jkn7B++LdnfU
	 fJGP57+q9zGzinA7757VXajJttRSVoGf4rSbT47TALiUAii47VQquk4MieRp3Of6jyBn2
	 mMb8MeNWVPSlVQ8RGsxzS7QmcHy8bkx4NvIUKdL8q3QYhSBuiN9fPky+x1c9amkNggpqp
	 ZafSQFMZX11sXq4ebzOTg/7847ZtcUdnDC5KDoUOs5dZCMm1t/27r15BL5sIBsu2exfwe
	 e/hKv7dzX96aABiO6QiayddLfCi7k5Qp+zaCSCR9yAhrUW7JYnNwrfWBKhezrdYUiDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvqa+OMH;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66763606A31A
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 15:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66763606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvqa+OMH
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3b14c80b210so615110a91.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 07:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794756260; x=1795361060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RsdeMcHfOtRvnpyG5YaLPUdVfJcBoSbUaq4yQfndVIw=;
        b=zvqa+OMHr0nV49/v00q/9VhHcjcV3dmBOQXteWf01yIVlwbfNUDhoEcwIeizNkEoCs
         3drPy2xPOS9nMDjmBAZ0kHOMdFCG/qWJJDsweuOkhHK9GJFrZZ/PJ2wvUaLaE6mqXbol
         BtUdM+78xkq7x1M3DjvdAsvsW5wUaiTvGBr29zQ2LXkuSITd7qdbd7bGm+sfODp938ly
         QdUO9kLTac71RMn64Z6dWmYpBEbwD6WUhr9aHQubJ6Ug7rdGp3yRDtqO4h5UExL2h0ZI
         dgPlss6bwUGqZqnQ8T+1khV4v7/vz+zXqvOP1lS/DhMfSIR/zxx/xqys7viWet1+SCJa
         UY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794756260; x=1795361060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RsdeMcHfOtRvnpyG5YaLPUdVfJcBoSbUaq4yQfndVIw=;
        b=CPXa7Isu48D3cgGpsKXJB2fnlLfZjPvOXl+BTPOIXHHXR4/4r9AbVO6sutdsFswo4s
         v68I1V1hlsycy2IP8UAMeoU8TcR/iRDdo7I1EM0oV50w6okX1G61VXYo7ABgXBPHNqEh
         WBhgLWshWYsYM1hJQeGdejt8gs0h1bPsDUxytJ+shLKWJ5Z1JKWSw6qXNaVwqhfLG0KC
         PPTON5JO4/Ga0sD47dKOueCgF8vvBydGvt8FB2h/D5eYWW0qiiLUQEDVZzkzgekbo+AA
         ZRd1qw06XEepJKGGjrE6bP019GQJL9/TwzqLcqs3GGuOV7KvixZaoxC34JIF6uQGGCbY
         OV3w==
X-Gm-Message-State: APuU4Z/jKqIdvOltNzidp4jcxLebRu+5l2Qcq29qNkz2NXRThxAHAVGY
	hObyZvvOJAppyLu71q7eoptgzRaVHpOO+EO97lmzNNH0l8nTd2CG+Ufo
X-Gm-Gg: AYBFou31tT+hMhpn/gv+Wtjllom8D3/RnbIO+VqAA6Q/XgHi/cVxw6fsNVJyvSrBZGk
	3+7ReX8jksOPQrRM2wG7JLd9Y6D8J14c0YbNl9Ac2cAoQ20D2Prmdfi6ORMbLlaB9uZJogyF/71
	UHmoaABYSwT3SMUCNKWRjqB/gNHf8NTzWZu5hUkYBsGofBtccJTRmbLTk4MZAqvWoosFMOv+2pE
	ammknJpQ6elyTfIJX5NArudoq3Ff7vvj1NiaTUpd6g7BDRDbdEbqIX3NQClKZZr90QYjHsuuKkL
	drMDETtBwfQvU9AxYV8YMu9R2plHRvKg0zePfxCACfynIAUV4Gk1zulq//fl5PFT86RhcuVl63v
	hg+ww27MBL60ZLt8zJcjGwbYpCaShxq3W13TV2xzXZ1kpg+c5gpBZy7N7nkQagRUgKKCv/qFnhV
	vJFOBRI1qm5p5ugc4Pol7vDBoQt6I4DxDrtMAAyHOJnRuwTVB5wrzo614kQowkCU6Z/MPxzOb5B
	FCM8VWd1cBbLtamcdyOuSZmYLsuBS1dFSMG/r1NjP0S0bsu0UsicAcVYgw+rS7guwT2awE3pBgs
	+v0e8NmzXvV6u0b4sEYelAZyJGdJYT9M95BOnv7FmOqL7TE=
X-Received: by 2002:a17:90b:4b0a:b0:3ac:17c:6e89 with SMTP id 98e67ed59e1d1-3b1b09fa36bmr7316575a91.19.1794756259730;
        Sun, 15 Nov 2026 07:24:19 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec66f4csm13173904a91.14.2026.11.15.07.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:24:19 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	edumazet@kernel.org,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	Linux kernel audit <audit@example.invalid>
Subject: [PATCH v1] net: sock_reuseport: check program type on the migration path
Date: Sun, 15 Nov 2026 23:24:08 +0800
Message-ID: <20261115152408.48205-1-shlomojune6@gmail.com>
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

From: Linux kernel audit <audit@example.invalid>

A BPF_PROG_TYPE_SOCKET_FILTER program can be loaded with
expected_attach_type set to BPF_SK_REUSEPORT_SELECT_OR_MIGRATE and
attached to a SO_REUSEPORT TCP group; both steps are allowed without
CAP_BPF.  Closing a listener that still has queued children then runs
that socket filter with a struct sk_reuseport_kern as its context,
while the program was verified against struct sk_buff.  It reads and
writes past the 56-byte object on the stack, which KASAN reports as a
stack-out-of-bounds in ___bpf_prog_run().

The cause is that reuseport_migrate_sock() decides from
prog->expected_attach_type alone.  That field is supplied by user
space and does not identify the program type, and
bpf_prog_load_check_attach() does not reject the value for
SOCKET_FILTER programs.

Fix this by requiring BPF_PROG_TYPE_SK_REUSEPORT before running the
program, and use the same check in reuseport_stop_listen_sock().
Socket filters can still be attached and used as selectors; the
selection path is unchanged.

Fixes: d5e4ddaeb6ab ("bpf: Support socket migration by eBPF.")
Signed-off-by: Linux kernel audit <audit@example.invalid>
---
 net/core/sock_reuseport.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -460,6 +460,18 @@
 }
 EXPORT_SYMBOL(reuseport_detach_sock);
 
+/*
+ * Only a BPF_PROG_TYPE_SK_REUSEPORT program is verified against
+ * struct sk_reuseport_kern, which is the context bpf_run_sk_reuseport()
+ * passes to it.  expected_attach_type is set by user space and does not
+ * identify the program type.
+ */
+static bool reuseport_is_migration_prog(const struct bpf_prog *prog)
+{
+	return prog && prog->type == BPF_PROG_TYPE_SK_REUSEPORT &&
+	       prog->expected_attach_type == BPF_SK_REUSEPORT_SELECT_OR_MIGRATE;
+}
+
 void reuseport_stop_listen_sock(struct sock *sk)
 {
 	if (sk->sk_protocol == IPPROTO_TCP) {
@@ -474,7 +486,7 @@
 						 lockdep_is_held(&reuseport_lock));
 
 		if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_migrate_req) ||
-		    (prog && prog->expected_attach_type == BPF_SK_REUSEPORT_SELECT_OR_MIGRATE)) {
+		    reuseport_is_migration_prog(prog)) {
 			/* Migration capable, move sk from the listening section
 			 * to the closed section.
 			 */
@@ -644,7 +656,7 @@
 
 	hash = migrating_sk->sk_hash;
 	prog = rcu_dereference(reuse->prog);
-	if (!prog || prog->expected_attach_type != BPF_SK_REUSEPORT_SELECT_OR_MIGRATE) {
+	if (!reuseport_is_migration_prog(prog)) {
 		if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_migrate_req))
 			goto select_by_hash;
 		goto failure;
