Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33149D598;
	Fri,  9 Oct 2026 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536976; cv=none; b=kHubMCVKoRNOt0kKUTTqfwHCrHukdE1GKRa+mAywf8zuRu+7caTk/kp6z98p7hOtJ9fBhn+iRj7SdCXuslObRDc0uVM24QbDFT8jw/gF7/4vN5HCQi7gUB3nd1as7j+5HjGgyWS8a942rOlKi6tW1zCNYeKWn9XL/99cLxnq5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536976; c=relaxed/simple;
	bh=1TiCu8G7SqXfkjo1OZq42b5dLHB8EEP6h3Ax1g+K3L0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huU0BY9vl83BgDlQ7jlxpaCgrqTkJDMthUeeo6zk5JXN/OuHpQeBlijuGDRZgr/VIVrATFHKnpkuBc5jl5PvwzOsxjR/+6avV1ZrKvFPMKocbubupbV7kYlljxOxfN/n+ojr3soSL9gk0Q5k3eIRH+BwtI2GYMq0409QbbnrRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=R+O1Ewyx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="R+O1Ewyx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=QWhmkQIh8BIaW9JXlXT66TW1iOU11xiHT6H610QR7rc=; b=R+O1Ewyxdh/ASZYNuxkZH4T5ln
	xYrmgscnp7zYesyftNHckM/aQZn83LCkzcpY5QCKWEgKDSSy8TgrA7Hj+W8yx3HgmhB2rN1uGdXPN
	8dJeSxxj/qUGxDRrRKBjEsiNw4v4WSK2hys1hqxewrgw/dYuPeuu+wO6+z+3zoG3lxlx8Iv3v2XIz
	wmfZuUaZAdpLi4ZnWgj3HixBH96/0fP8Ma0vgTkloShVddg8cFdmclw631V3ah+TPPxSj/utv0rJm
	tQok23slJI0yAQY4KKfTjT7Y4xMj08Q21qShjn/kqRScv5WTOWDG3hDpN1OVuueu8mR2BitH+vvex
	W/OiwEmg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xF6bK-000QKj-3D;
	Fri, 09 Oct 2026 09:09:15 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Oct 2026 01:53:40 -0700
Subject: [PATCH net-next v2 6/7] ipv6: convert do_ipv6_getsockopt() to
 sockopt_t
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-sockopt_expand_out_v2-v2-6-8ac08c469ecb@debian.org>
References: <20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb@debian.org>
In-Reply-To: <20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb@debian.org>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=12346; i=leitao@debian.org;
 h=from:subject:message-id; bh=1TiCu8G7SqXfkjo1OZq42b5dLHB8EEP6h3Ax1g+K3L0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqyK8ONgUS1N+FwL9qRM23vOVF/WQh1ANYQZk98
 nuYsuVEXNGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCasivDgAKCRA1o5Of/Hh3
 bbrAEACHmJ8LIWR/fQl4yBCY+ju4jW6Lo1GQASt9F87/AzbGDTa4tNMtEl/299j0y6FvCOD1fJO
 9PqQhD+jqY9yz/VKM394JhzhcMpAF/e7PFnUowevRIdmt7QFsxp6n1Ky4L9tweVyBD6jEZu8neQ
 a+rn07K/NLWTBI+72oCjeOVlvVzpa40dBqelZXovR27xbrlatjrAnfqPfO72hkedZLrDYSdIXWM
 kP6ovl04jKnNaSgLJMaVUwavUHx2U18015cnhjfjaonFruerHh8BhU8YYfwXJfMmMU0cH5WmEEE
 djBbl8sicxDOK49lo+/b2eeqC1L7KF/1fg/4BRZvRoSreBWIqPzntcL/stMnG+a55y3v0UO6aOE
 A8AK0eWNYaxSA94fBAUoqiTLjLrpOoug3KXQvIcOGghVfWX1NNdyEABkhzEJj5mSaVn4C6/ruSJ
 tjNgkD2VCiD7Ud9slj3p7y155V2eJ6Z5UdIPWX4Xt8HUpKZBx48R/loPhOMCxtBmHYgsaCsEBRL
 hnvF00mv25jELQs05ICBebymAXNdmrZZG+L8dRCwkjM3vZHGdY0UcSqzYEIIoKgrGNhuerof8oK
 6jFegPG5duPkSjKaB1H/x1QtuFaFlMbAMayZG+e07Jz9+h/BbbLj8Xa+E6Y35SrW0/BFDYA/ZlA
 /vUe01B6pa4uDsw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert the SOL_IPV6 switch and its two remaining sockptr_t leaves,
ip6_mroute_getsockopt() and ipv6_getsockopt_sticky().

ipv6_getsockopt() writes optlen back unconditionally, and
sol_ipv6_sockopt() builds the sockopt_t with sockptr_to_sockopt() and
stores optlen back as well.

ipv6_getsockopt() cannot use sockopt_init_user() as its IPv4 sibling
does, since that rejects a negative optlen and this level answers it as
4. See discussion in the previous patch/commit.

The write-back also happens before the netfilter fallback, so an
unwritable optlen turns any error into -EFAULT and skips the fallback.

The extra code in sol_ipv6_sockopt() will go away when
sol_ipv6_sockopt() receives sockopt_t, but, for now, it only moves the
leaves.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/mroute6.h  |  5 ++-
 include/linux/net.h      | 17 +++++++--
 include/net/ipv6.h       |  2 +-
 net/core/filter.c        | 18 +++++++---
 net/ipv6/ip6mr.c         | 13 +++----
 net/ipv6/ipv6_sockglue.c | 90 ++++++++++++++++++++----------------------------
 6 files changed, 73 insertions(+), 72 deletions(-)

diff --git a/include/linux/mroute6.h b/include/linux/mroute6.h
index fddafdc168f733..ab4d206fb32065 100644
--- a/include/linux/mroute6.h
+++ b/include/linux/mroute6.h
@@ -27,7 +27,7 @@ struct sock;
 
 #ifdef CONFIG_IPV6_MROUTE
 extern int ip6_mroute_setsockopt(struct sock *, int, sockptr_t, unsigned int);
-extern int ip6_mroute_getsockopt(struct sock *, int, sockptr_t, sockptr_t);
+int ip6_mroute_getsockopt(struct sock *sk, int optname, sockopt_t *sopt);
 extern int ip6_mr_input(struct sk_buff *skb);
 extern int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
 extern int ip6_mr_init(void);
@@ -42,8 +42,7 @@ static inline int ip6_mroute_setsockopt(struct sock *sock, int optname,
 }
 
 static inline
-int ip6_mroute_getsockopt(struct sock *sock,
-			  int optname, sockptr_t optval, sockptr_t optlen)
+int ip6_mroute_getsockopt(struct sock *sock, int optname, sockopt_t *sopt)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/linux/net.h b/include/linux/net.h
index 461137bdc8817e..3fe84daaa5e2e2 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -50,6 +50,19 @@ typedef struct sockopt {
 int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval, sockptr_t optlen,
 		       struct kvec *kvec);
 
+/*
+ * Point a sockopt_t at a user-backed (optval, len) pair whose length is
+ * already known, e.g. because the caller applied its own optlen quirks
+ * before this point.
+ */
+static inline void sockopt_set_user(sockopt_t *opt, char __user *optval,
+				    int len)
+{
+	iov_iter_ubuf(&opt->iter_out, ITER_DEST, optval, len);
+	iov_iter_ubuf(&opt->iter_in, ITER_SOURCE, optval, len);
+	opt->optlen = len;
+}
+
 /*
  * Initialize a user-backed sockopt_t from the (optval, optlen) __user pair of
  * a getsockopt() callback. Used by transitional __user getsockopt wrappers
@@ -66,9 +79,7 @@ static inline int sockopt_init_user(sockopt_t *opt, char __user *optval,
 	if (len < 0)
 		return -EINVAL;
 
-	iov_iter_ubuf(&opt->iter_out, ITER_DEST, optval, len);
-	iov_iter_ubuf(&opt->iter_in, ITER_SOURCE, optval, len);
-	opt->optlen = len;
+	sockopt_set_user(opt, optval, len);
 
 	return 0;
 }
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 9bb68d75890364..a1e1de7da8c70d 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1142,7 +1142,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval
 int ipv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		    unsigned int optlen);
 int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
-		       sockptr_t optval, sockptr_t optlen);
+		       sockopt_t *sopt);
 int ipv6_getsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, int __user *optlen);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 1bc194a32337ac..8606d5d9a3181b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5774,10 +5774,20 @@ static int sol_ipv6_sockopt(struct sock *sk, int optname,
 		return -EINVAL;
 	}
 
-	if (getopt)
-		return do_ipv6_getsockopt(sk, SOL_IPV6, optname,
-					  KERNEL_SOCKPTR(optval),
-					  KERNEL_SOCKPTR(optlen));
+	if (getopt) {
+		struct kvec kvec;
+		sockopt_t opt;
+		int err;
+
+		err = sockptr_to_sockopt(&opt, KERNEL_SOCKPTR(optval),
+					 KERNEL_SOCKPTR(optlen), &kvec);
+		if (err)
+			return err;
+
+		err = do_ipv6_getsockopt(sk, SOL_IPV6, optname, &opt);
+		*optlen = opt.optlen;
+		return err;
+	}
 
 	return do_ipv6_setsockopt(sk, SOL_IPV6, optname,
 				  KERNEL_SOCKPTR(optval), *optlen);
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 36f117ad367081..9513258b95fb88 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1893,8 +1893,7 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
  *	Getsock opt support for the multicast routing system.
  */
 
-int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
-			  sockptr_t optlen)
+int ip6_mroute_getsockopt(struct sock *sk, int optname, sockopt_t *sopt)
 {
 	int olr;
 	int val;
@@ -1925,16 +1924,12 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 		return -ENOPROTOOPT;
 	}
 
-	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
-		return -EFAULT;
-
-	olr = min_t(int, olr, sizeof(int));
+	olr = min_t(int, sopt->optlen, sizeof(int));
 	if (olr < 0)
 		return -EINVAL;
 
-	if (copy_to_sockptr(optlen, &olr, sizeof(int)))
-		return -EFAULT;
-	if (copy_to_sockptr(optval, &val, olr))
+	sopt->optlen = olr;
+	if (copy_to_iter(&val, olr, &sopt->iter_out) != olr)
 		return -EFAULT;
 	return 0;
 }
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b488391496af3c..c9787579531f64 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -889,7 +889,7 @@ int ipv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 EXPORT_SYMBOL(ipv6_setsockopt);
 
 static int ipv6_getsockopt_sticky(struct sock *sk, struct ipv6_txoptions *opt,
-				  int optname, sockptr_t optval, int len)
+				  int optname, sockopt_t *sopt, int len)
 {
 	struct ipv6_opt_hdr *hdr;
 
@@ -917,7 +917,7 @@ static int ipv6_getsockopt_sticky(struct sock *sk, struct ipv6_txoptions *opt,
 		return 0;
 
 	len = min_t(unsigned int, len, ipv6_optlen(hdr));
-	if (copy_to_sockptr(optval, hdr, len))
+	if (copy_to_iter(hdr, len, &sopt->iter_out) != len)
 		return -EFAULT;
 	return len;
 }
@@ -998,42 +998,21 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockopt_t *opt)
 	return 0;
 }
 
-int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
-		       sockptr_t optval, sockptr_t optlen)
+int do_ipv6_getsockopt(struct sock *sk, int level, int optname, sockopt_t *sopt)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	int len;
 	int val;
 
 	if (ip6_mroute_opt(optname))
-		return ip6_mroute_getsockopt(sk, optname, optval, optlen);
+		return ip6_mroute_getsockopt(sk, optname, sopt);
 
-	if (copy_from_sockptr(&len, optlen, sizeof(int)))
-		return -EFAULT;
-	/* Historic bug compatibility: the int options have always taken a
-	 * negative optlen as 4, so take it as 4 everywhere.
-	 */
-	if (len < 0)
-		len = 4;
+	len = sopt->optlen;
 	switch (optname) {
 	case MCAST_MSFILTER:
-	{
-		struct kvec kvec;
-		sockopt_t opt;
-		int err;
-
-		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
-		if (err)
-			return err;
-
 		if (in_compat_syscall())
-			err = compat_ipv6_get_msfilter(sk, &opt);
-		else
-			err = ipv6_get_msfilter(sk, &opt);
-		if (!err && copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
-			err = -EFAULT;
-		return err;
-	}
+			return compat_ipv6_get_msfilter(sk, sopt);
+		return ipv6_get_msfilter(sk, sopt);
 	case IPV6_2292PKTOPTIONS:
 	{
 		struct msghdr msg;
@@ -1042,12 +1021,12 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		if (sk->sk_type != SOCK_STREAM)
 			return -ENOPROTOOPT;
 
-		if (optval.is_kernel) {
+		if (iov_iter_is_kvec(&sopt->iter_out)) {
 			msg.msg_control_is_user = false;
-			msg.msg_control = optval.kernel;
+			msg.msg_control = sopt->iter_out.kvec->iov_base;
 		} else {
 			msg.msg_control_is_user = true;
-			msg.msg_control_user = optval.user;
+			msg.msg_control_user = sopt->iter_out.ubuf;
 		}
 		msg.msg_controllen = len;
 		msg.msg_flags = 0;
@@ -1098,8 +1077,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 				put_cmsg(&msg, SOL_IPV6, IPV6_FLOWINFO, sizeof(flowinfo), &flowinfo);
 			}
 		}
-		len -= msg.msg_controllen;
-		return copy_to_sockptr(optlen, &len, sizeof(int));
+		sopt->optlen = len - msg.msg_controllen;
+		return 0;
 	}
 	case IPV6_MTU:
 	{
@@ -1154,12 +1133,13 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		sockopt_lock_sock(sk);
 		opt = rcu_dereference_protected(np->opt,
 						lockdep_sock_is_held(sk));
-		len = ipv6_getsockopt_sticky(sk, opt, optname, optval, len);
+		len = ipv6_getsockopt_sticky(sk, opt, optname, sopt, len);
 		sockopt_release_sock(sk);
 		/* check if ipv6_getsockopt_sticky() returns err code */
 		if (len < 0)
 			return len;
-		return copy_to_sockptr(optlen, &len, sizeof(int));
+		sopt->optlen = len;
+		return 0;
 	}
 
 	case IPV6_RECVHOPOPTS:
@@ -1213,9 +1193,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		if (!mtuinfo.ip6m_mtu)
 			return -ENOTCONN;
 
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, &mtuinfo, len))
+		sopt->optlen = len;
+		if (copy_to_iter(&mtuinfo, len, &sopt->iter_out) != len)
 			return -EFAULT;
 
 		return 0;
@@ -1292,7 +1271,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		if (len < sizeof(freq))
 			return -EINVAL;
 
-		if (copy_from_sockptr(&freq, optval, sizeof(freq)))
+		if (copy_from_iter(&freq, sizeof(freq), &sopt->iter_in) !=
+		    sizeof(freq))
 			return -EFAULT;
 
 		if (freq.flr_action != IPV6_FL_A_GET)
@@ -1307,9 +1287,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		if (val < 0)
 			return val;
 
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, &freq, len))
+		sopt->optlen = len;
+		if (copy_to_iter(&freq, len, &sopt->iter_out) != len)
 			return -EFAULT;
 
 		return 0;
@@ -1367,9 +1346,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 	len = min_t(unsigned int, sizeof(int), len);
-	if (copy_to_sockptr(optlen, &len, sizeof(int)))
-		return -EFAULT;
-	if (copy_to_sockptr(optval, &val, len))
+	sopt->optlen = len;
+	if (copy_to_iter(&val, len, &sopt->iter_out) != len)
 		return -EFAULT;
 	return 0;
 }
@@ -1377,7 +1355,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 int ipv6_getsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, int __user *optlen)
 {
-	int err;
+	sockopt_t sopt;
+	int len, err;
 
 	if (level == SOL_IP && sk->sk_type != SOCK_RAW)
 		return ip_getsockopt(sk, level, optname, optval, optlen);
@@ -1385,15 +1364,22 @@ int ipv6_getsockopt(struct sock *sk, int level, int optname,
 	if (level != SOL_IPV6)
 		return -ENOPROTOOPT;
 
-	err = do_ipv6_getsockopt(sk, level, optname,
-				 USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
+	if (get_user(len, optlen))
+		return -EFAULT;
+	/* Historic bug compatibility: the int options have always taken a
+	 * negative optlen as 4, so take it as 4 everywhere.
+	 */
+	if (len < 0)
+		len = 4;
+	sockopt_set_user(&sopt, optval, len);
+
+	err = do_ipv6_getsockopt(sk, level, optname, &sopt);
+	if (put_user(sopt.optlen, optlen))
+		return -EFAULT;
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err == -ENOPROTOOPT && optname != IPV6_2292PKTOPTIONS) {
-		int len;
-
-		if (get_user(len, optlen))
-			return -EFAULT;
+		int len = sopt.optlen;
 
 		err = nf_getsockopt(sk, PF_INET6, optname, optval, &len);
 		if (err >= 0)

-- 
2.53.0-Meta

