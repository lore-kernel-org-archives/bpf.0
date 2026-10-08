Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DA36F914
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429370; cv=none; b=p2vY3VztzIWoG6IFAYS4TTdi2D/C+j5OeyyH1A8zeoMmIfYq0qeCI2U6ZodRE2RZmCcA36xwXcOyBJ0mkqOO7ow6Fy47S9bZwMRStoCkJHqV2AbY0OW1DuVSLPvQMi0ZGrsJwGT0f8YTYVc71gb3v1MwwgTefNyyyKEuhdkGssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429370; c=relaxed/simple;
	bh=GqNjevvYkhKkTxknJ9DHX8blF4SVGXpMhqLJY03srpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EVanx0dpAMTAl/8XrckWuNnNxeH56vzPqZgbMLjZCJdMpHt4+16MGAAhYCFtDYmhNVtoY8IiW/MVFxgRIuLEEsnmmzGeBTXc/O7DqhJ2hhyL9yZv7yMbI6GaHaslbRL5JHcfv1svPKdlUfFthrdeKkch28kmPJkK4RvjcjPk0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nl3Xtrrd; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nl3Xtrrd"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e818ca61bfso660135ad.2
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429368; x=1792034168; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bQ8hhMkpKjjpGU9yaS6THJZOrlZMxioUji7j6gmBEmc=;
        b=nl3Xtrrd11AdtJeQOSyjpdvRZII7J/IhDdC25yofhIGv4Xvg/zk4iyqZzHbJFrpPK9
         CfeuKsH55EsJuP+B702eZphZqnA0bn0UB3LrmrJL0puakhc/ic+7olc5VEOjx1v2cKKz
         PNbvCDRY/os77AHRI9hklLopSAcG1aWHXQcAYOvOsH0UQZzI74yrYD/oaGF1GcA7g1AA
         iL+YhaV+b2PdykTw7fI44z/s6udZAQ68H7G7jY56HnIME1DeDs3NblkO+JdR38o6Ycdb
         YxE8f7PJFH3+N9hxX9WjqZhg7RnqiRXTq8Z3jdOg7g0wwkCDyYwdPyACTQNI7OGjkoeD
         36EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429368; x=1792034168;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bQ8hhMkpKjjpGU9yaS6THJZOrlZMxioUji7j6gmBEmc=;
        b=G1fuK4LqEdjByGM7DkgyvvtNjyJQqoGvjW5OJKtSk4Y8g54TNpoeN+L5FtIDnqlQ2m
         hARfxgPF52isZx2iktgQDyJTEms/CGZKNGAiQUXsVKZo26JRuWwC7/mpMP2F7bNLwPER
         kbul1ogOvnLdqbAMr8KZoAzYlXLN0UTDHtgZYXoEtU9Puoay8RNANRX2rU5yMfKxAB4Q
         5jkDYNdw0yORC3o9tECLHKukicInBL6j17+xT6dLDybPzzoAdDEgKhqq3fyX/Qyq9fdm
         pCwCSsWtnEuLIoRsjZSTjPegS4oz1TYosulNZNJtkUdsXMlWjO+fDcLQqm35XYq2+zcQ
         tRXg==
X-Forwarded-Encrypted: i=1; AKwUvBwug+QbBIMTjr7Cu0vz5w+JLCySWxDWSTV5BnZGhZ9Z2xv+ZhpXCg/mIvBWJJ2z+izw2Pk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLG+wDH9+p14D+kAIEL7BxgGpdJHsJRMGXLgRrMscvwpktJrd7F
	TCAKUQ963FApj3RFL1tE7Qhd86Vn8X4M9m041jwCVcjorws4O3NCTIqTS2duoQYCXeqmWawtq9Y
	VYPgrWQ==
X-Received: from plblv4.prod.google.com ([2002:a17:903:2a84:b0:2df:a554:8274])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef09:b0:2e5:9923:5582
 with SMTP id d9443c01a7336-2e6004e36b0mr36246405ad.29.1791429367677; Wed, 07
 Oct 2026 20:16:07 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:21 +0000
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-2-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 01/10] bpf: tcp: Convert deny-list for
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
Reviewed-by: Amery Hung <ameryhung@gmail.com>
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
2.56.0.360.g66cac248cb-goog

