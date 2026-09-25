Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D64E1C9F;
	Fri, 25 Sep 2026 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351785; cv=none; b=bRHtWew1Otpg+dDEJiWBFdcZ01gjepiqn4Isff2cpmkL5FuYDy2xIkAeW9y972H8V3OctX6DPMggaA1tr841HXGRUBeihgvAjDIcF75Nu01I8+hTc7khYm+cC58VvGJ/KTBd8tLuWzxM+drtOg0i0d5Yoa5OiV3yIndx9AfHRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351785; c=relaxed/simple;
	bh=oo/olnVSIzYB/d58EvBDtBhxDkF1/f5cqybu9drymSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSphP+MZbBa+jXWkuxXsygDkI9eO+fdRVTYldQcKAUoDIUnM6zL7ff2hGNrF+QAvF11W+CHnMq4/OpmFiwuVLmTL69Rp+5kgKfFcQPXQLdbc4fAaQfHUwFAIwCM8FdMEdO009WjEe2yix2IPoh1KGFdtXvItc/3ehFkWuFlXJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QGgTmLOo; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QGgTmLOo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=OKP2QY/AaMwR2Z3P6A8XZRlvVFVARae09QOBmwhMqMg=; b=QGgTmLOoC/GZDSno4fsKEIPqVW
	O8FOJp8y5z2cXTj/QYMPUArj7qSTrDynlxofYXt7Nv8FVNJfcptUAfxALzEpHMzlkAEyN8ZandHmX
	wI17zl10o9UAAIqHaXZbGRc3ekEVT2U7rjDAbGdjIN9GdBT8zu/wMms2iebPweWH+QkEEvxToPdsv
	Ss5jMMGAdAnz6ayyE8d1xJVJQ+Rd85NJ1xjl4I4OocUU7Y0VVcPqMTkRZoJvcmlrFK9hM7LwjLYPh
	+4t8XAzISpfUo8DV+YYrPQqNS/kV5MnsGf+yk31MitR5eb2eyRJKYXPh4YHxscTPCOrib8JN9CLtW
	ASNuVY+Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA8Ha-005PmK-0f;
	Fri, 25 Sep 2026 15:56:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 25 Sep 2026 08:55:20 -0700
Subject: [PATCH net-next 5/6] ipv6: convert do_ipv6_getsockopt() to
 sockopt_t
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-sockopt_expand_out_v2-v1-5-c3ef2e3bb5c0@debian.org>
References: <20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org>
In-Reply-To: <20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=10536; i=leitao@debian.org;
 h=from:subject:message-id; bh=oo/olnVSIzYB/d58EvBDtBhxDkF1/f5cqybu9drymSs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqtpl6Hsw4PFrxlH68VEcxvWd9NifmidloN376L
 rfGuqry3UGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaraZegAKCRA1o5Of/Hh3
 bQn+D/94oHWhFVv1UhXS9391gJVgYki5IjaxK8hm4kXrZ7QLUB/4cIdgKtp0dt6R5qGGyxOhGgM
 KBBAyyQhKHy26mDplGQ3q00M+K8xZ6M0PoIf8H/E3oZ5dCBtPI4c21DcTP7vW+lKC0Ur8QZVHdB
 EsdVHQ3NY/wY0mw+43yac7H4HVhenLHbNMbCyEX1sqIhdSLoCgvLwqZWSdCM+gWEexDMWkbaXT1
 ZovufN5bUQ9pbiEL0GQGfTlG3HI0eGiuL4oza3HRwbsGScDZfccXhm3YlIFfihNlbae41NZdNmr
 8QJrgqsBu3ZQIH0g+6Vl9msalqDOzZxuRH9qSEGpzcDgPj8eXvRVq95CO+eLJzrVhIgA9jyGWGi
 ZIsENCKjNkV88bADfubZjJ9K7t8fydPwf1IKmJQlo3WvsgBiRZsmFIciW3fA2qbNkPb5NKATKjg
 bmjviWWqE1o/cRH6BeXVv1+kKOqyIO10WEPvSZRxnTZknVIFoMkFL9v+cAw8RGQPdip36DnCX9i
 JvrpJbvf6d/HGHN1GQG9j7RN1cGzmzti7SjQiEAqPEcLfs8K7iDJ6eqDnuKf+OnOEJx1xGQfkih
 tEHmHRJjrC69xjg/mEcPw+YrCOeUrIrvyxoTEhFupro23MmDomEmxIITLxvtRL7BT9EGSRTFHIq
 e6OPc5bPaCRZusg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert the SOL_IPV6 switch and its two remaining sockptr_t leaves,
ip6_mroute_getsockopt() and ipv6_getsockopt_sticky(). The
MCAST_MSFILTER bridge goes away.

ipv6_getsockopt() builds the sockopt_t with sockopt_init_user() after
its own level checks, and writes optlen back unconditionally.
IPV6_2292PKTOPTIONS takes its buffer off iter_out; IPV6_FLOWLABEL_MGR
reads through iter_in. The argument is sopt, since the sticky options
already have an ipv6_txoptions local named opt.

MRT6_* is still dispatched before optlen is validated, so a negative
optlen there wins over -EOPNOTSUPP.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/mroute6.h  |  5 ++--
 include/net/ipv6.h       |  2 +-
 net/core/filter.c        | 18 ++++++++---
 net/ipv6/ip6mr.c         | 13 +++-----
 net/ipv6/ipv6_sockglue.c | 78 ++++++++++++++++++++----------------------------
 5 files changed, 53 insertions(+), 63 deletions(-)

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
index 9a706ec1f7f122..e0b79c78c9a9c8 100644
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
index 1bdb3e001e4fe6..3a43e26234eea3 100644
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
@@ -997,39 +997,23 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockopt_t *opt)
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
+	len = sopt->optlen;
 	if (len < 0)
 		return -EINVAL;
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
@@ -1038,12 +1022,12 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
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
@@ -1094,8 +1078,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
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
@@ -1150,12 +1134,13 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
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
@@ -1209,9 +1194,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		if (!mtuinfo.ip6m_mtu)
 			return -ENOTCONN;
 
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, &mtuinfo, len))
+		sopt->optlen = len;
+		if (copy_to_iter(&mtuinfo, len, &sopt->iter_out) != len)
 			return -EFAULT;
 
 		return 0;
@@ -1288,7 +1272,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		if (len < sizeof(freq))
 			return -EINVAL;
 
-		if (copy_from_sockptr(&freq, optval, sizeof(freq)))
+		if (copy_from_iter(&freq, sizeof(freq), &sopt->iter_in) !=
+		    sizeof(freq))
 			return -EFAULT;
 
 		if (freq.flr_action != IPV6_FL_A_GET)
@@ -1303,9 +1288,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		if (val < 0)
 			return val;
 
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, &freq, len))
+		sopt->optlen = len;
+		if (copy_to_iter(&freq, len, &sopt->iter_out) != len)
 			return -EFAULT;
 
 		return 0;
@@ -1363,9 +1347,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
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
@@ -1373,6 +1356,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 int ipv6_getsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, int __user *optlen)
 {
+	sockopt_t sopt;
 	int err;
 
 	if (level == SOL_IP && sk->sk_type != SOCK_RAW)
@@ -1381,15 +1365,17 @@ int ipv6_getsockopt(struct sock *sk, int level, int optname,
 	if (level != SOL_IPV6)
 		return -ENOPROTOOPT;
 
-	err = do_ipv6_getsockopt(sk, level, optname,
-				 USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
+	err = sockopt_init_user(&sopt, optval, optlen);
+	if (err)
+		return err;
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

