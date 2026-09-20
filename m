Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4524746CE
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789934200; cv=none; b=u7KNfTlGzFi7pMRvaShZj2KEXwlfHsTR7Xz7Dx4ATtuOFni4lu9sEVEOLF/LDGeVmLpJIRT0SqyCiPexgjr5to36NPKZtmbIfqegpTM5pIGHy4XvGrPCsWNJ4I+Taq6eR0cfJs/SSN+cLfXeriJYGM2K2wm9PsHesjsoAbYDeGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789934200; c=relaxed/simple;
	bh=9QtT6FbhjcGUQS/WVzXJqwkcMF7aQ5q5RPT8uqGQEQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ioHmYW+bNje85/rcyP+Oss7D6znmDeVtOAoZbKt3J0aRppzFaobQ5l21v8gq6Cx+h3dRj3sHQzd+0fVSIsrlHNIubhHFfvV7U10OEJKIfgOcL/u7t71l5RQHdBSFGwfujAnTgUmFld7UMBaKMA0cDc6w0T6tnfeoTI+cH5ocSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gzH/Mjpv; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzH/Mjpv"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86a59faf521so3984656b3a.2
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789934198; x=1790538998; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S+FXxUNykn1G7O2VWnnRrL2BFIstKUnisfgS5aB3QMs=;
        b=gzH/Mjpv27fRDpDMvc2AAOhjHL93FFjcEpyn2GlgBG9M51mya9lf8PWioE3vEXfbXz
         Lk8qeah/o3pl/vZwx8fgHS1UGpA5DybiCl3rr0O8kaepmQHreCDg6JFDDznhlTyWgZL3
         Yz7hNx43nQVeXUBnzbphrbhJqSIipY4CTE13LhgZzb8FfBUvHaPNenf6/FsqB2sWjZfX
         We0xqVw3wzMhQxJwSddPCwsTGP6jzpuzUjsB39CLcXzcyxChaMaeRkwBWyj3Ge0c4hIJ
         aM7YCxt3jGmHUlsWKezM6Z/yKXrF69sHPNSlJLUGTkyl4WnuUsZCTtLfQm9JchWcECcO
         ZKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789934198; x=1790538998;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S+FXxUNykn1G7O2VWnnRrL2BFIstKUnisfgS5aB3QMs=;
        b=bGyO1b3BHLev0+bW5HayWhPL6PzWW+exz7Yp/+ZpNUVazUg5Yu8zjMaEVYPdN3CxXc
         RXb4h/67Yiaq1WZ+WanElp9Zj+6qRr+pUZ/uBbRYzWzFv3aEdwsvs28DWvOB4o+lPUBH
         4TFOqC1kpfZIzoLZnMI8pavePSa1R3FUASOTRBgEtk7tjLGrGXTwdQVAZL+3LL5erkGJ
         MNPdMYtJc3Mb9/9G+MZlXSXqJZwgwlcZZunh2YapLihN1oMmIT06iSjoy6x86AIXFJRC
         DDXkgHNPxF6vCqMeWY/pq85t7UO70u2ACGL7qJYDqrPgCzmaj2r8rhvjnHAl5lEisopS
         se6A==
X-Forwarded-Encrypted: i=1; AKwUvBxqlos8i4isAmTGH5L4o6+6paXAYEckSKN04DGzJaKbW7RqxXbuNP5mkD3Qj3Nonqn9Rv8=@vger.kernel.org
X-Gm-Message-State: AFuF++nHaEJSOuCW3RYDBTjGfnElLjTDAL/Wl54LoFHKt3RutCSPgEw2
	cDUArMOFZKs3Obmcs0GwCnyyfLJSuPDl9oYN3I8mF4ydkxfdSJgYJag+mM+Dhd0yidenEEUG2E0
	HAOHUPA==
X-Received: from pfkh29.prod.google.com ([2002:a05:6a00:1d:b0:878:7d16:4125])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:114e:b0:86f:5e14:2422
 with SMTP id d2e1a72fcca58-874db7f1a53mr12726287b3a.1.1789934197658; Sun, 20
 Sep 2026 12:56:37 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:56:12 +0000
In-Reply-To: <20260920195633.3033620-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260920195633.3033620-4-kuniyu@google.com>
Subject: [PATCH bpf-next 3/7] bpf: tcp: Support bpf_sock_ops_cb_flags_set()
 for bpf_tcp_ops.
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

When an error occurs in bpf_tcp_ops.{enqueue,dequeue}_rcvq(),
we want to clear BPF_SOCK_OPS_RCVQ_CB_FLAG to stop invoking
the callbacks.

In addition, bpf_sock_ops_cb_flags_set() is often used during
setup or just after 3WHS completes to enable opt-in hooks.

Let's support bpf_sock_ops_cb_flags_set() in the following
callbacks: connect, listen, {active,passive}_established,
{enqueue,dequeue}_rcvq.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/uapi/linux/bpf.h       |  2 +-
 net/ipv4/bpf_tcp_ops.c         | 27 +++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  2 +-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fe122242b096..8cdf22667775 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3264,7 +3264,7 @@ union bpf_attr {
  * 	Return
  * 		0
  *
- * long bpf_sock_ops_cb_flags_set(struct bpf_sock_ops *bpf_sock, int argval)
+ * long bpf_sock_ops_cb_flags_set(void *bpf_sock, int argval)
  * 	Description
  * 		Attempt to set the value of the **bpf_sock_ops_cb_flags** field
  * 		for the full TCP socket associated to *bpf_sock_ops* to
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index c68d1fa32305..6d0452441b6c 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -220,6 +220,24 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval_proto = {
 	.ret_type	= RET_INTEGER,
 };
 
+BPF_CALL_2(bpf_tcp_ops_cb_flags_set, struct sock *, sk, int, argval)
+{
+	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
+
+	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
+
+	return argval & ~BPF_SOCK_OPS_ALL_CB_FLAGS;
+}
+
+static const struct bpf_func_proto bpf_tcp_ops_cb_flags_set_proto = {
+	.func		= bpf_tcp_ops_cb_flags_set,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_TCP],
+	.arg2_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -265,6 +283,15 @@ get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		if (moff == offsetof(struct bpf_tcp_ops, write_hdr_opt))
 			return &bpf_tcp_ops_store_hdr_opt_proto;
 		return NULL;
+	case BPF_FUNC_sock_ops_cb_flags_set:
+		if (moff == offsetof(struct bpf_tcp_ops, connect) ||
+		    moff == offsetof(struct bpf_tcp_ops, listen) ||
+		    moff == offsetof(struct bpf_tcp_ops, active_established) ||
+		    moff == offsetof(struct bpf_tcp_ops, passive_established) ||
+		    moff == offsetof(struct bpf_tcp_ops, enqueue_rcvq) ||
+		    moff == offsetof(struct bpf_tcp_ops, dequeue_rcvq))
+			return &bpf_tcp_ops_cb_flags_set_proto;
+		return NULL;
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fe122242b096..8cdf22667775 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3264,7 +3264,7 @@ union bpf_attr {
  * 	Return
  * 		0
  *
- * long bpf_sock_ops_cb_flags_set(struct bpf_sock_ops *bpf_sock, int argval)
+ * long bpf_sock_ops_cb_flags_set(void *bpf_sock, int argval)
  * 	Description
  * 		Attempt to set the value of the **bpf_sock_ops_cb_flags** field
  * 		for the full TCP socket associated to *bpf_sock_ops* to
-- 
2.55.0.1082.g2b9226bbc0-goog

