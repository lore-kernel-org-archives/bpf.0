Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2FD4CA76B
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215146; cv=none; b=U4E4Vo4oWJUFbS6uWV5Y0Sr0T7+ouJ8Hd/3xaDi45HrDOxSt1H1NtDZ6cJiomxuO1bssb8060YqXP5CVFMmwIBJIV2QXkAiahN+RJaopMdkAC2Bs7TzdFDRsCa9paTRAU5gWNfreL+E39HdLmGDX8Lk93Zsq6RmKMcQ5W1kwZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215146; c=relaxed/simple;
	bh=LKON1EKnK9DYqhaLkSInSe97gphQQyf421uoN7A+Vgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gLtzRxMu4uJjrdFtFznYXCqlkzHuxJuS2yUZvq//2oSc6aj7iVvlDD2cC9NxkP8VdDU2hKhjx+ZDKuHFF202iLxsApo/hkEBkZTavcBLlkJMd5V1hWSB/hn5bOzzMhh+ZmOzrM7r6znfWio5V3cdHRC/CSuJ73XkxMpWf7ie4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3eVp9B9; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3eVp9B9"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a470ead068so1646774a91.3
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215139; x=1791819939; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L7jwFvJPDLgaMRhdozCz9+3uyw7Hai+N8bAgKpVpvaU=;
        b=K3eVp9B9/g7QdbKfDCvNUpp/Tu6wJiUsyMWmFvypEBRqPvRc9bHBA9EdZfySpY7y4W
         icKfz+5sNBesuJ4ORfSGAfUh9yqCVz/BHumVSC+meJPgCUY5aIRWFcZn8uwU+weuG7TH
         nRBT6DY8b6NGyLeqvXsImlrCf/w2QlAMLrmnFvl5BuN+0XTujAHK3rHwSS4NvaPxJcIU
         pU6cHqbfYbSAIEtVkG9rewgUFSKVYx2+GGpw+8CTNd2efk2WpbHiZfRYfvYkCVAT1Sef
         akZaT0vB+AyZodVFys82CKNmISfVVf4NFYYYuR6G39vRs/88qT3PTd9rqzfjfzuli7Je
         zP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215139; x=1791819939;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L7jwFvJPDLgaMRhdozCz9+3uyw7Hai+N8bAgKpVpvaU=;
        b=ckgzbYhoSZ8aNch8crCPYXEi87kxQ7UoeGkAJPPRMeRRXsvY3fl7SX6DC9ROAQxFes
         xzRxzpE8qtXHh4jUU4psR+Z5EUAdVj2O0n90rCtyuH1kLeJHEzqT3OefOCmwe8bOj+Fb
         e3az+IRpWYSjBcXVKucNRQmerdat7nikIWSq3rmc/2T6WHDBc+FKcb4afaTwW6cAb2FT
         nDWkIPwOOVlDqxh2e4aWO+6j4y4dWqHur3Iy+2KYhzhmsP1n/4ipcn5/enuVKolGVCsv
         3aCRHiMr+vQcFqc0lGcRZseV/tVEtutuRQO9RN4eat70Lc+pZIN7JO9zn85dcC2pdjWv
         hklw==
X-Forwarded-Encrypted: i=1; AKwUvByTHjhuEtaY8bq3QTWQFoCrbf6xqtJidkczaMGsfYHFMJcS19tez8DsxgefAS2vM0tuNJo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKJc+fCcBLwvrloAytdSMuexec8ypXOqsF7rm5nXGLsNsWZa+y
	QSP/51oI5aNehR5SpowEUhFu9CtV4O/BSLRoOc5e5Ncns4W98X60VvCNqauYQckiNUF7ruOH2rz
	uGL2lEw==
X-Received: from pjbmw9.prod.google.com ([2002:a17:90b:4d09:b0:3a7:239:2141])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac1:b0:3a0:22bd:6ef6
 with SMTP id 98e67ed59e1d1-3a6ce64fb77mr5849039a91.2.1791215139088; Mon, 05
 Oct 2026 08:45:39 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:40:43 +0000
In-Reply-To: <20261005154533.4147685-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005154533.4147685-2-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 1/9] bpf: tcp: Convert deny-list for
 bpf_{get,set}sockopt() to allow-list.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"

Currently, four bpf_tcp_ops callbacks are not allowed to call
bpf_setsockopt() and bpf_getsockopt().

However, the deny-list is fragile, and when a new callback is
added, we might re-open a can of worms. [0][1]

Let's convert it to allow-list.

Note that it can be written as offsetof(,X) <= moff <= offsetof(,Y)
but clang can optimise to similar code anyway.

Link: https://lore.kernel.org/r/20220929070407.965581-5-martin.lau@linux.dev/ #[0]
Link: https://lore.kernel.org/bpf/20260421155804.135786-1-kafai.wan@linux.dev/ #[1]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/ipv4/bpf_tcp_ops.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 681fed642999..1ada3b781bf1 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -210,6 +210,24 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval_proto = {
 	.ret_type	= RET_INTEGER,
 };
 
+static bool is_sockopt_supported(u32 moff)
+{
+	switch (moff) {
+	case offsetof(struct bpf_tcp_ops, active_established):
+	case offsetof(struct bpf_tcp_ops, passive_established):
+	case offsetof(struct bpf_tcp_ops, rto):
+	case offsetof(struct bpf_tcp_ops, rtt):
+	case offsetof(struct bpf_tcp_ops, set_state):
+	case offsetof(struct bpf_tcp_ops, retrans):
+	case offsetof(struct bpf_tcp_ops, connect):
+	case offsetof(struct bpf_tcp_ops, listen):
+	case offsetof(struct bpf_tcp_ops, parse_hdr):
+		return true;
+	}
+
+	return false;
+}
+
 static const struct bpf_func_proto *
 get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -221,22 +239,13 @@ get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
 	case BPF_FUNC_setsockopt:
-		/* The sk may be an unlocked listener (synack path) or NULL
-		 * fullsock; disable for members that can run unlocked.
-		 */
-		if (moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
-		    moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
-		    moff == offsetof(struct bpf_tcp_ops, hdr_opt_len) ||
-		    moff == offsetof(struct bpf_tcp_ops, write_hdr_opt))
-			return NULL;
-		return &bpf_sk_setsockopt_proto;
+		if (is_sockopt_supported(moff))
+			return &bpf_sk_setsockopt_proto;
+		return NULL;
 	case BPF_FUNC_getsockopt:
-		if (moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
-		    moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
-		    moff == offsetof(struct bpf_tcp_ops, hdr_opt_len) ||
-		    moff == offsetof(struct bpf_tcp_ops, write_hdr_opt))
-			return NULL;
-		return &bpf_sk_getsockopt_proto;
+		if (is_sockopt_supported(moff))
+			return &bpf_sk_getsockopt_proto;
+		return NULL;
 	case BPF_FUNC_get_retval:
 		if (moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
 		    moff == offsetof(struct bpf_tcp_ops, rwnd_init))
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

