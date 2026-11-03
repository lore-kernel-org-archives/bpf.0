Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704032;
	b=3XYISDJYlrTFtyDa0ov5Gycjag+6M+++JZCHDKH1slxapC8xZlKzqXifrnnaL/qTb9fR
	 8QETWguKFkzmKLIFeUH/UcFaa5Wnqpgj5TjF3LatNRuBsKhvv3EYkOwO3cKp5bvU0ya9M
	 6R90bhEgSUeUaFksR/WQI4xpJEyP4CDorQQFvJlvEqVV79GNRCPAwvuLxqOha6F4n3MZn
	 bl1nPdTL8QXUC8Pdc7rPEeiEbaU1RlTzdowwvuX+ERVqwVqHBl4624IrAEDQCplbVdxmi
	 7faJfrqTnbVqVLIRUdcTJioxgenCY8mv3bE9ondQnClQqlugRNeiVGUr2I/S1Naw6ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704032;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=o7lfRo/QHI3+SU4RoEAu/UYgSnczMJ4pu7Vs1R3jP8A=;
	b=oi1hb+xyifn8mf5ZFuP/NIAu/FpX0DDhDmN979K7Lkl7vGMj8XCuiSS3NSMz8l6OR8Uk
	 M1YBrRmnBEvDQiHzcRGuBQoMOTcsQFhjU8P8of4YUun0zi9u5sSTnZKNLkm9+G0iJ+oVg
	 j3CXyuBELEEj+a663KzX4FnX+dhdmx0kW3KBwNo9Kv0r3rdBoDOPdpGpzHS2knyYUjzlP
	 WKvGIvNyembhBRHqGQUbhPFzWmMBpwiaXlj/5y+xcfq8apuvtBK8GAgU8nMj9yVYlTtzn
	 U8MOwfBEqnquTmy1mHf3E4u8AJJIXTjvhPPoq4eugzR1spoqQR2Xab8PDtWHdxbYF7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=RvFSetQC;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16916083628;
	Tue,  3 Nov 2026 11:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C16916083628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=RvFSetQC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=o7lfRo/QHI3+SU4RoEAu/UYgSnczMJ4pu7Vs1R3jP8A=; b=RvFSetQCwF62NK+6wxUSYm+n8b
	sklJLMC0lhFtke1wYhIw/j8jlzKO/qJ42nm3G/OOKD9rVfzpxN5j/MqQvPGxODohLExdutaWWIGgm
	Q0hHc7BMC4aqNdJdn3Ad5d66R5WYWvJ/ZUoft57utLTPDEbWZVhoAhInu2FlMii/spGmyJzKhSTw1
	iMVaBr7rdRahmq2aMgnvEs8i0WID2TDO/jhOWJRmxDwtS5SHc5GnszhIQWTF9La1zxZXbqXtGvWjS
	FY9/sEshQ2pqfW5FSfL2FrV6xzFlqESkpN0r9bo6z6bZPcbaDXkyFLFXvBWPh9pETK6jj5ZU/hCfo
	ZRBnl74w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOCM7-006tDt-26;
	Tue, 03 Nov 2026 11:07:08 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 03 Nov 2026 03:01:05 -0800
Subject: [PATCH net-next v4 6/7] ipv6: convert do_ipv6_getsockopt() to
 sockopt_t
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-sockopt_expand_out_v2-v4-6-2d36da923578@debian.org>
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
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
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=13168; i=leitao@debian.org;
 h=from:subject:message-id; bh=hGgSrQL68BayIgQzc0i+/m8Ft+LRvqu0CZd/Fj4+F6o=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6cAvLnDT/ui884EtQZ2IrnW8I3GV+FBVR8tZT
 RU5XyEsTQuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaunALwAKCRA1o5Of/Hh3
 bR0jD/9RkHsF9Z75KkrFJ5rbfRhUS6hHvJAmTA6W5fHEFJhH9lzOYB7iTL9U6cwhBtrqkYthqr9
 6S0nMNv1NBXayNs6IgKkju/eK1vNrPtWeLVtGXkX61EaE5UZpwsO7sThmObAXXz0U4oYdOaT4J/
 JgdKCH7oeGm9n0sa54zyDRI1mFlbxjGLy4k/cF3Og5CWO3Jg3TNv1clZtzSMIktRslJz5e/IoJS
 qiTjL03fdDAvSbeywX2TPDzaB4EIPue3SrIDIkh1AXCwW1Yg80ha42s4nqC/RtJRRxpLMxcgOxN
 wqum7gX1YNcbglDq/qe3ATLPI3KFXW5h43lm79Xdyt1F5WRBvxf9SS64aVah9cF4ktfUR8niMd9
 ED0LZ7hEY7hJK2MytgICNMAIK2Z7m/Sd5YPJRus7EfxGIuAeFMpoogLp0jNeUceURNFHU5tileJ
 V1Phw8kQcHJ0Z7kiPiIrlKEpGYxo/4zjGUWHOo6mKBdUIB83F6leL9VKEHA38Cg51v252GZaIHR
 MckJMwvLrlNBGaDYLRQvtLMYO06Nc3Azrx0f2IvYP1T0CoXbthOegBhohGyLiNrMSnJ/FU19YN9
 aM2HNdqpxQcgm5hPxY9duwQJp/BSrSmARw2fFnUa+ApggnCJv5Swl1RI5ftU4ouuexzHWfuprW/
 atomOWkjAhzkzRg==
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
4. See "ipv6: treat a negative optlen as 4 in do_ipv6_getsockopt()".

Instead ipv6_getsockopt() applies that rule itself and builds the
sockopt_t with the new sockopt_set_user(), which sockopt_init_user() now
shares. MRT6_* is the exception: it has always rejected a negative
optlen, and still does.

The write-back also happens before the netfilter fallback, so an
unwritable optlen turns any error into -EFAULT and skips the fallback.
Likewise optlen is now read before the MRT6_* dispatch, so an unreadable
or negative one wins over -EOPNOTSUPP.

For the other options, a failing call that passed a negative optlen now
leaves it as 4 instead of untouched, and the netfilter fallback sees that
4 too.

IPV6_2292PKTOPTIONS and the sticky options used to return the result of
copy_to_sockptr(), the number of bytes not copied, so an unwritable
optlen made getsockopt() return 4. They now return -EFAULT.

The extra code in sol_ipv6_sockopt() will go away when
sol_ipv6_sockopt() receives sockopt_t, but, for now, it only moves the
leaves.

Acked-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/mroute6.h  |  5 ++-
 include/linux/net.h      | 17 +++++++--
 include/net/ipv6.h       |  2 +-
 net/core/filter.c        | 18 +++++++---
 net/ipv6/ip6mr.c         | 13 +++----
 net/ipv6/ipv6_sockglue.c | 93 +++++++++++++++++++++---------------------------
 6 files changed, 76 insertions(+), 72 deletions(-)

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
index de56f89d475ee2..1d5b3524b0846f 100644
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
index fc427876bde839..8bf8b87e5d4fc2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5864,10 +5864,20 @@ static int sol_ipv6_sockopt(struct sock *sk, int optname,
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
index af968a2c2a7847..f14bd12f5d4b91 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1899,8 +1899,7 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
  *	Getsock opt support for the multicast routing system.
  */
 
-int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
-			  sockptr_t optlen)
+int ip6_mroute_getsockopt(struct sock *sk, int optname, sockopt_t *sopt)
 {
 	int olr;
 	int val;
@@ -1931,16 +1930,12 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
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
index 433b25c860d81b..b1011319cd3ec1 100644
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
-	/* Historic bug compatibility: take a negative optlen as 4, as the
-	 * int options always did.
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
@@ -1385,15 +1364,25 @@ int ipv6_getsockopt(struct sock *sk, int level, int optname,
 	if (level != SOL_IPV6)
 		return -ENOPROTOOPT;
 
-	err = do_ipv6_getsockopt(sk, level, optname,
-				 USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
+	if (get_user(len, optlen))
+		return -EFAULT;
+	/* Historic bug compatibility: take a negative optlen as 4, as the
+	 * int options always did. MRT6_* has always rejected it instead.
+	 */
+	if (len < 0) {
+		if (ip6_mroute_opt(optname))
+			return -EINVAL;
+		len = 4;
+	}
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
+		len = sopt.optlen;
 
 		err = nf_getsockopt(sk, PF_INET6, optname, optval, &len);
 		if (err >= 0)

-- 
2.53.0-Meta

