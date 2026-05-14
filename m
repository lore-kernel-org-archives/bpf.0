Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046F3B960F
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735441; cv=none; b=BTzwvVD7K7VnlhFwk9tE6GfxPH0U2M99fhenky7rjyIWTeZcoU1RcHgtZBtG4vvNrgnnHKeZ41ss4ChjTqDWhLkcQ/S12KaS3FI5e0vpcFg+rxAmD44LGj1qAUk41DXgFgPUwy8Lrke/s4+L/e3UjcvStgyJtPTvWkqz5Ab5J+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735441; c=relaxed/simple;
	bh=HscCd40h4IXjgl6QvhloOnaj1tz+SpMNc1axYSXQjjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZUa718V3AG/zkxiytYWSluV0jE/Oxra7i3n33TrWbWCBNP4KOpLb847UEs8hrgTJfsOkjgYflf/zFF4kLGYvUdQ0/qv9aVRgtNQqJh7RJiNiX1SIjldKS5V/IVCt+1RR2hBGNtUll1XXdsGKBuFgf/7ouJwACIlbBgQtwK9Q2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MrEbvadi; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MrEbvadi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778735436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0DhVK8ibYLXXtHt744ue2KCHhBHIPe4oMwlveBBIeI=;
	b=MrEbvadiWOwbxhclbAmgsiNemFCOrHDnxWFpAXYo1pKsuJL0M+8BvOJqnUr/1X7EXXd4rU
	RAelj39/DLE9e8p9lcQcnf8QhB1N83qGq0B0uzI2DK6EsIFqOavv6pGBTBExABlhjXmPD7
	2GZJaY7FkgNfItbt7JVNHSy//2T4Ahw=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 1/2] net: add missing syncookie statistics for BPF custom syncookies
Date: Thu, 14 May 2026 13:09:57 +0800
Message-ID: <20260514051015.177926-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260514051015.177926-1-jiayuan.chen@linux.dev>
References: <20260514051015.177926-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

1. Replace IS_ENABLED(CONFIG_BPF) with CONFIG_BPF_SYSCALL for
   cookie_bpf_ok() and cookie_bpf_check(). CONFIG_BPF is selected by
   CONFIG_NET unconditionally, so IS_ENABLED(CONFIG_BPF) is always
   true and provides no real guard. CONFIG_BPF_SYSCALL is the correct
   config for BPF program functionality.

2. Remove the CONFIG_BPF guard around struct bpf_tcp_req_attrs.
   Since CONFIG_BPF is always selected by CONFIG_NET the guard is a
   no-op, and the struct is referenced by bpf_sk_assign_tcp_reqsk()
   in net/core/filter.c which is compiled unconditionally, so its
   visibility is not actually conditional on BPF being enabled.

3. Fix mismatched declaration of cookie_bpf_check() between the
   CONFIG_BPF_SYSCALL and stub paths: the real definition takes
   'struct net *net' but the declaration in the header did not.
   Add the net parameter to the declaration and all call sites.

4. Add missing LINUX_MIB_SYNCOOKIESRECV and LINUX_MIB_SYNCOOKIESFAILED
   statistics in cookie_bpf_check(), so that BPF custom syncookie
   validation is accounted for in SNMP counters just like the
   non-BPF path.

Compile-tested with CONFIG_BPF_SYSCALL=y and CONFIG_BPF_SYSCALL
not set.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

---
To sashiko: We already called skb->sk = NULL before calling
reqsk_free(req). So there is no worry about skb->sk becoming
dangling pointer after cookie_tcp_reqsk_init() fails.
---
 include/net/tcp.h     |  7 +++----
 net/ipv4/syncookies.c | 10 +++++++---
 net/ipv6/syncookies.c |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ecbadcb3a7446..7d87bc2d21d17 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -599,7 +599,6 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    struct tcp_options_received *tcp_opt,
 					    int mss, u32 tsoff);
 
-#if IS_ENABLED(CONFIG_BPF)
 struct bpf_tcp_req_attrs {
 	u32 rcv_tsval;
 	u32 rcv_tsecr;
@@ -613,7 +612,6 @@ struct bpf_tcp_req_attrs {
 	u8 usec_ts_ok;
 	u8 reserved[3];
 };
-#endif
 
 #ifdef CONFIG_SYN_COOKIES
 
@@ -716,13 +714,14 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
 		dst_feature(dst, RTAX_FEATURE_ECN);
 }
 
-#if IS_ENABLED(CONFIG_BPF)
+#ifdef CONFIG_BPF_SYSCALL
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
 	return skb->sk;
 }
 
-struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb);
+struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
+				      struct sk_buff *skb);
 #else
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index df479277fb801..9251d4a15c888 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -294,8 +294,9 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_BPF)
-struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
+#ifdef CONFIG_BPF_SYSCALL
+struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
+				      struct sk_buff *skb)
 {
 	struct request_sock *req = inet_reqsk(skb->sk);
 
@@ -305,6 +306,9 @@ struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
 	if (cookie_tcp_reqsk_init(sk, skb, req)) {
 		reqsk_free(req);
 		req = NULL;
+		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
+	} else {
+		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
 	}
 
 	return req;
@@ -419,7 +423,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		goto out;
 
 	if (cookie_bpf_ok(skb)) {
-		req = cookie_bpf_check(sk, skb);
+		req = cookie_bpf_check(net, sk, skb);
 	} else {
 		req = cookie_tcp_check(net, sk, skb);
 		if (IS_ERR(req))
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4f6f0d751d6c5..111d7a41d9573 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -190,7 +190,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		goto out;
 
 	if (cookie_bpf_ok(skb)) {
-		req = cookie_bpf_check(sk, skb);
+		req = cookie_bpf_check(net, sk, skb);
 	} else {
 		req = cookie_tcp_check(net, sk, skb);
 		if (IS_ERR(req))
-- 
2.43.0

