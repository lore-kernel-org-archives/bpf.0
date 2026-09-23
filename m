Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3277139D3FC
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199447; cv=none; b=K99f+Ak9gWUrj/S7e+knikzTxL9PK4j/pfTB9pBKXddKSu4ZjZ5CVXdFDFs7WZiNFGqafYk0fnXU9RNCeB8lK7pJOcKIG/w4Jm9lm4I9W+BM+ZkDGCI/RMwcVP40TPTPiE99P7eiN3IgONbQujgeVpuGl8GP+sO74qxTnLeYMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199447; c=relaxed/simple;
	bh=3/+1+eMkWeI6H0UBlfnDyhLX+/TN0y96Z5pyrUF8ZP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dmobuL4h2Zu2RmvwrSgmt0OMRjdlsEtuRAWnOe2fh84XZXtW0NZuE4jOliaYZhQEBdPM+p+eG3oRj8qsA3EH/9rMNAN4wHWJ4UGPdAG6Q/Z3f7xmGEvwxvwYmOvvuIATDOd3OrjS9Yzwj61UDHWPDzyAqqWQ6tgStaOzXRJD5tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAVZCX9E; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAVZCX9E"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d55d8cd938so18258235ad.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790199443; x=1790804243; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZagZdA+ul65iAb7C09F0ANSb8lxpTUREosL0NdV8zPw=;
        b=HAVZCX9ExhQv9R4Q6KJHf2v5TZX0v1a3yjtaIqDLFk7Vd0v3ZJK3+CR9gV6Tn8OOYI
         iZTXWBChyC7nFhcRPRhr9RaBn1Y4bAVimi3iKKR2UTShT0O4DyN2K0ZnSSmC0x0TueTn
         39JcWI+ZKih2D/gDbP+//i4E7NDWrkgnKr018emjbpD30SAlwMqceY2FtCf0f+g8FfiR
         it60/6rQIEZdXUg/gwmoS6VMqrqyT0B+VkualhNavCyd81SeRm3sfUiof1bDSLcMcqmP
         gRTB+eXD1qf8LwUPs7b50I5piB372RT9QYKxH/eN4MeVnlPgMwz+hm7WCvmzW1KpsWDw
         kxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199443; x=1790804243;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZagZdA+ul65iAb7C09F0ANSb8lxpTUREosL0NdV8zPw=;
        b=xKe6rAUxXa7PaSBDeXkoHpD0/jZ/n2D5fRrZBAwwH5qq4eFi4LXsbDO2F9pvZQicRs
         Di1fNcR4vLV8slyu0tEwxZQ9KGJnBcf7DHLBhoMoxGBpekIWVg7uB7PJsc2XdlX8PxSh
         8xjVH50akR91Y5NQHA/nAT9UJafVLNNi3C3NUtDQBWVC5nzGtSQjwQ+jZSA58QD5/UPi
         PuDbNOwVSMiE1JHjIx85zeLXtAlw05szx580MJnfl6+erYh2HYzKWuM7yU+0USiQcNob
         ES0hlzzYTrYOIa3OI2jtGu9Q0Q1sg0OrOln/0TG+epg/IRULphsDFm+nmSmBjCKqG7yV
         vwgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLWDZMpvHEr+oXfRRrklT6gl4Z17S739iX00DLK1UB/FCA23gZ06kx/Mi30Vw1gm/egl4=@vger.kernel.org
X-Gm-Message-State: AFuF++nuybWxZqKhx4a8evd/qZChzs3+AI548R/sBRwalzxYK4PKks6o
	ekRcolt5/QGYYE2Fr9ZXMPUT0/62bnHDS5LdANoVR1mZ3wFKlQz1hnqv/9pVMzTDaIujjHLU3mn
	tMDe7Lg==
X-Received: from plbd1.prod.google.com ([2002:a17:902:f141:b0:2df:5bfd:2185])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c40c:b0:2dd:c053:9c6c
 with SMTP id d9443c01a7336-2df7e40706dmr3287995ad.34.1790199443113; Wed, 23
 Sep 2026 14:37:23 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:35:31 +0000
In-Reply-To: <20260923213719.224838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260923213719.224838-2-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 1/8] bpf: tcp: Convert deny-list for
 bpf_{get,set}sockopt() to allow-list.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, four bpf_tcp_ops callbacks are not allowed to call
bpf_setsockopt() and bpf_getsockopt().

However, the deny-list is fragile, and when a new callback is
added, we might re-open a can of worms. [1][2]

Let's convert it to allow-list.

Note that it can be written as offsetof(,X) <= moff <= offsetof(,Y)
but clang can optimise to similar code anyway.

Link: https://lore.kernel.org/r/20220929070407.965581-5-martin.lau@linux.dev/ #[0]
Link: https://lore.kernel.org/bpf/20260421155804.135786-1-kafai.wan@linux.dev/ #[1]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
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

