Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF7514752
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786432; cv=none; b=uyLqSY/3x4wWF8VHzmdCfJvBy2+XU2HfBCBpgA8fC4qPCLGr7f76PsOMpDEFIpgtLWRT/g+bfO8mzg9goM8WC/e7dsSwsErra/JTKDHX3+mhz39BjiDrwfK0RRmEpxjdbK8FShCvQxnMbfd+4YuHIz46Gg0DivsdbvDt3QFEJ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786432; c=relaxed/simple;
	bh=4iSwdRqxeGsKM/7Nr7afgG7Tp0SKnui1kMN3db8IyMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8X1GhEEI6zJ6u1OcEvPs0gfChQTrIyQUUcRe8zWWsCF3EGi5BocRNxfLlk36QDl2l+3ETbrGmCl0cLhVV6QjJzZOgCJw0T2lvGMW+wGfKQxztaxZEAUIN+IVQpjPlxr4Oupl4Dst2ThATnPMcxGZM8rGQQH2NZvqLFXuK+MQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6Uu6kdi; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6Uu6kdi"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2df921c1d0eso15866215ad.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790786431; x=1791391231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJOL8eapI7GAaLzLb2iDD1PGi2cMFOi1vId90W3h87g=;
        b=g6Uu6kdiBZzx7MgBnzyVifPoDRL/NkJMKFpx7dhcHReEEGcwb2j6++Lx6oIVCPFiZD
         /YiYVGI2NaAH67+oWPnnzicTLRf/TMoBjHh9Nd1a9m1I/xLynobz3/49sxv8Docu/prK
         St8/nrm2UF8bcg/gtONGsFgrV0K9JAdGMNd1HodWYSRBuuV+pGydazobm6czpmC9bVFB
         R/vkfUEjNR9bqfO5NhMo0NdmbTSyTxbrXJ17tarN6+5tZv7SVehgqYMo/4lyMQP8VmXf
         GJJr/dK8ddJGYG0Juzhem2tWvYzQkzyJ0gL0tPZfxocYnrwXbSIwIPQEFOeSHv+b4rZB
         5+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790786431; x=1791391231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJOL8eapI7GAaLzLb2iDD1PGi2cMFOi1vId90W3h87g=;
        b=WtTZ5PsfjCE3bMvCKJ5M+BHhdc9KnyU5/ibTywfT0bjTUmfEy0skr8zmjQuAs5/Kng
         7suWCnxSiiMR0ZQ1/4ay01g+4uCDQ4TatHHISXr2lP/097L8Kai1nBkwJH8f+hg+KsGt
         354zMoxLhGa28Q0g1JTKl02f02oijgoRO1oTJz7owPu5WdKq/OJiJYCJEyJl8X99yatE
         n2dkxPBOy17Jy0LapM8rg3Udu5I9gOpiDniKKl3q5o1897SV4km9Cg0A9cK+BCyX/Bnd
         3YFtCPcu8hmaaerUm0P9z3C6adxZpiC9tWZqQEnS53bF5YzrbrNEWgJVzaRUl2cIuM3X
         fThQ==
X-Gm-Message-State: AFuF++nzJsce1VG1hhX6FOOT/JQeUUjgwkbUFQdfwjEy9IsnsBWUxtuN
	04Ke9yU4QkYe/j7F6tGF9tleb+LXP4Py3Yl6R368NijJmMDFudsUx0QBB3oCqoz/kQOg4wHy
X-Gm-Gg: AYBFou3xYVBi1cfk5vkktjsauas7l5JktKm67orQjpw3dtaEOoZkM7i9JXm3mG3S8R/
	/70l7seKj5MaDytBMx+7LdU7qwM5+Lh2aB5zYHs1OL0azoOVpjlx4tV5pFbVKBziABgT9G7n8ZL
	aGesV522xJM5ICNwYE4d72gohHGma4YuGKICfnDA4IcHHrfPIUSfbxCqKR4xNb9LUc/riO6fuQb
	51IYj826tWxLAGTIRtN5LyLwZ6fqVYGQFrHTqxDmiJichRO62p5b0orMzxfdqd1kP3hGXkXUE/+
	NXf7ub8ed5VpCmGQrECWtkCRx087/hwLeFnzoMEMkbvGD7e7anuHrGmZN6uBQXIH2VadT4Q6Efg
	8bigbpXWLyCMPosSy0qeG5vmJjt9TGgSItr5MvciRhE37Doa2Mc8c+wAdWmlvDb6Q1yE+rbKBxY
	Ig+evJEI4vGtkkktg14aVO/tRrNay7ebYFWfFKCxlUwVVmnOEMRjgCmVKDp5/zMptfQFY9wscx7
	C+WHK+mpDWnoiiG/Hz0fAhJkA==
X-Received: by 2002:a05:6a21:4e01:b0:3cd:9dea:2be1 with SMTP id adf61e73a8af0-3de9dbfe945mr1830859637.0.1790786430415;
        Wed, 30 Sep 2026 09:40:30 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([120.235.123.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7e54a4121sm168735a12.20.2026.09.30.09.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:40:29 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: reject incompatible socket assignments
Date: Thu,  1 Oct 2026 00:40:19 +0800
Message-ID: <20260930164020.41006-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_sk_assign() permits TC ingress programs to associate an IPv6 packet
with an AF_INET socket. The receive path can then interpret IPv6 skb
control data as IPv4 metadata. When IP_RETOPTS is enabled, this can cause
__ip_options_echo() to copy beyond its stack buffer.

Reject incompatible packet and socket families before attaching the socket,
while preserving IPv4 assignments to dual-stack AF_INET6 sockets. Validate
request, mapped, and time-wait sockets using their effective family.

Use the packet's effective protocol for VLAN checks and share the same
predicate across bpf_sk_assign() and bpf_sk_assign_tcp_reqsk().

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Assisted-by: LLM
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
Changes since v2:
- Use the effective packet protocol for VLAN-aware family validation.
- Handle IPv4-mapped AF_INET6 sockets, TCP children, and TIME_WAIT sockets.
- Share the protocol-based check with bpf_sk_assign_tcp_reqsk().

v2:
https://lore.kernel.org/netdev/20260911172313.64009-1-shlomojune6@gmail.com/

Changes since v1:
- Move family validation out of the IPv6 receive fast path and into
  bpf_sk_assign() and bpf_sk_assign_tcp_reqsk().
- Preserve IPv4 assignments to dual-stack AF_INET6 sockets.
- Check request sockets using rsk_ops->family.
- Split the fix into two patches and target the BPF fixes tree.

v1:
https://lore.kernel.org/netdev/20260823101809.26802-1-shlomojune6@gmail.com/
---
 include/uapi/linux/bpf.h       |  4 +++
 net/core/filter.c              | 63 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 +++
 3 files changed, 71 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 732b35cc08d1c..5d8f5e2c8db38 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4568,6 +4568,10 @@ union bpf_attr {
  *		**-EOPNOTSUPP** if the operation is not supported, for example
  *		a call from outside of TC ingress.
  *
+ *		**-EAFNOSUPPORT** if the socket family is not compatible with
+ *		the network layer of the packet, for example an **AF_INET**
+ *		socket and an IPv6 packet.
+ *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
  *		Helper is overloaded depending on BPF program type. This
diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e7535523..5f64065523584 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3491,6 +3491,64 @@ static int bpf_skb_proto_xlat(struct sk_buff *skb, __be16 to_proto)
 	return -ENOTSUPP;
 }
 
+static bool bpf_sk_assign_family_ok_proto(const struct sock *sk, __be16 proto)
+{
+	const struct inet_connection_sock_af_ops *af_ops;
+	unsigned short family;
+
+	switch (proto) {
+	case htons(ETH_P_IP):
+		family = AF_INET;
+		break;
+	case htons(ETH_P_IPV6):
+		family = AF_INET6;
+		break;
+	default:
+		return true;
+	}
+
+	/* Requests inherit the listener family, but have family-specific ops. */
+	if (sk->sk_state == TCP_NEW_SYN_RECV)
+		return inet_reqsk(sk)->rsk_ops->family == family;
+
+	/* A dual-stack listener accepts both packet families. */
+	if (sk->sk_state == TCP_LISTEN && sk->sk_family == AF_INET6)
+		return family == AF_INET6 || !ipv6_only_sock(sk);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	/* IPv4-mapped and pure IPv6 time-wait sockets retain AF_INET6. */
+	if (sk->sk_state == TCP_TIME_WAIT && sk->sk_family == AF_INET6) {
+		const struct inet_timewait_sock *tw = inet_twsk(sk);
+		bool mapped;
+
+		mapped = ipv6_addr_v4mapped(&tw->tw_v6_daddr) &&
+			 ipv6_addr_v4mapped(&tw->tw_v6_rcv_saddr);
+		return family == (mapped ? AF_INET : AF_INET6);
+	}
+#endif
+
+	/* IPv4-mapped and pure IPv6 TCP children keep AF_INET6 in sk_family. */
+	if (sk_fullsock(sk) && sk->sk_family == AF_INET6 && sk_is_tcp(sk)) {
+		af_ops = READ_ONCE(inet_csk(sk)->icsk_af_ops);
+		if ((family == AF_INET6 &&
+		     af_ops->net_header_len == sizeof(struct iphdr)) ||
+		    (family == AF_INET &&
+		     af_ops->net_header_len == sizeof(struct ipv6hdr)))
+			return false;
+	}
+
+	return sk->sk_family == family ||
+	       (family == AF_INET &&
+		sk->sk_family == AF_INET6 &&
+		!ipv6_only_sock(sk));
+}
+
+static bool bpf_sk_assign_family_ok(const struct sk_buff *skb,
+				    const struct sock *sk)
+{
+	return bpf_sk_assign_family_ok_proto(sk, skb_protocol(skb, true));
+}
+
 BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
 	   u64, flags)
 {
@@ -7989,6 +8047,8 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 		return -ENETUNREACH;
 	if (sk_unhashed(sk))
 		return -EOPNOTSUPP;
+	if (!bpf_sk_assign_family_ok(skb, sk))
+		return -EAFNOSUPPORT;
 	if (sk_is_refcounted(sk) &&
 	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 		return -ENOENT;
@@ -12526,6 +12586,9 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 	if (net != sock_net(sk))
 		return -ENETUNREACH;
 
+	if (!bpf_sk_assign_family_ok(skb, sk))
+		return -EAFNOSUPPORT;
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		ops = &tcp_request_sock_ops;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 732b35cc08d1c..5d8f5e2c8db38 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4568,6 +4568,10 @@ union bpf_attr {
  *		**-EOPNOTSUPP** if the operation is not supported, for example
  *		a call from outside of TC ingress.
  *
+ *		**-EAFNOSUPPORT** if the socket family is not compatible with
+ *		the network layer of the packet, for example an **AF_INET**
+ *		socket and an IPv6 packet.
+ *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
  *		Helper is overloaded depending on BPF program type. This
-- 
2.43.0
