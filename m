Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66143712D;
	Fri,  9 Oct 2026 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536967; cv=none; b=u4K4CkWgJpTbaV4N3E3jFt4DthrFUQjOdHwerN7koya8ryXAZs+F94CMsKSiPT8dlM3awMLGeb+ao1qT4HBELzuNWZZfyuS8u5VrLgD3/KDlKqKeo8XfkFgsyDgQepXbSrtIbAsdAtadkmCrbvRctv1pvWHTXcQVqdxtF+loFRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536967; c=relaxed/simple;
	bh=UMwSDMRdbRRnRnsTo/Rf8t95iomelsOPhDec7zyrabk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQWQ0CF0N7dVSHTIyuqrA/NZxCZG67QAJrNLrSWPXGitcZU1p7s+0EPMi/BoeANUBxWpEQjLwqsG4eX/V1BCuBEsXQPCSN3He1DwDrX93+xrNsVJO/jNcgbahkgj5KuHo6mQZLVevxO61E5KRuHJ/e551MYwkELwcu975YXAjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=X3Cpx6lD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="X3Cpx6lD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=CxRbskOPFV9N9M2WxPpokPejPVvG6/b4AeYIdZPmjTY=; b=X3Cpx6lDtyqkaAK/frMjPIs97t
	F1iQNlUUyGKrstaprMfeFD6IESr9iWpTqEIWUQ0Mfa8qMDKkGlMTu3LxSQIqpmi0h52VWzrL7t0zZ
	yYW69y/A0tvqhQGE8P4x6ljKLtRMUOFC7TiR07agWzRr7FcbXvhiUtt45p7eoapE5WfiX0B1FsTWW
	t9ZXeSBkIB8yf/Qq1OkDeHgIVN+oGM9u3xeYDWYyQaAkjqlpiETibca4AyUon6+MBzR+fp+Iy0mqp
	ygldbtNy8Pb2GbvwvYlmYM6wEgY+EqZpwxBOr5XCd/YG8dlO4vcm6BsJrR8D2EbvtAClmgrn6/6Fb
	gevVhZgA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xF6bE-000QKM-2X;
	Fri, 09 Oct 2026 09:09:09 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Oct 2026 01:53:39 -0700
Subject: [PATCH net-next v2 5/7] ipv4: convert do_ip_getsockopt() to
 sockopt_t
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-sockopt_expand_out_v2-v2-5-8ac08c469ecb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10912; i=leitao@debian.org;
 h=from:subject:message-id; bh=UMwSDMRdbRRnRnsTo/Rf8t95iomelsOPhDec7zyrabk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqyK8OFIbdB/FkR3CtDUtVK7zlkyXLnmq7dlrwx
 wfMcTmE572JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCasivDgAKCRA1o5Of/Hh3
 baAhD/9iUwdhcMiVZzr2QYxP5P1rioapt/f5VyZGLW7y9xnsfbhv9uTkjPtO+dWf0C7s4rfUPJe
 T70bD4v/NL7eKltnQbEgtq+LDc71kfK+9lqhU2Van43Dz10Pb+GfUtoosWkVWUd7g+OcBC1ev0I
 mLraZW5iMANflfadvBYL/YuNAK7bvx1rQkXDnnteBXNQJ0GkeJOdiw5rASCr1Pe8ajCE5GBdyHA
 Q47q8gvUgzqOQS/IhVvgtFl4I7UlYWjeyVx+JlrjJvVVg0wB9dWDMcdyIS6n7KlsQB4woyHjxTX
 l0UnMPnIMz4dDj1m/jZk+oBs9f/5rfpjL4TLN8XrYnl2YRmnGvW/+NBEi08pGsj7HOjRlhAjs0k
 i1ihQW4/qcYlg6pPaZtFdc1OYNc+6VUIDtmPgCJSf2AKPtu4hAlEOni4p4FNZPiMt+B6c7LU3nr
 deVGGBRYwjF3F8zJ1WQwY+q6cavMlRTab2dzr/zFaQ2ziqJ1a+yzdU3qg2vHODD2AtwdJ8gspxg
 x5JjY49WIg9ecWkRgajMKFw8nZsmyWjIxaSRxvIK4hYEdcu0mcwPOiWR1eSdhvUv8j4Ttg3al4c
 Zp6QUOOwJEd2mFyVkOA34OHShcA8t/ag9k40mJ86EsMh/whd8Lh2vTr4HwIzCiFBwI4yRxQwC10
 IPkfbhA8Bisa1Nw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert the SOL_IP switch and ip_mroute_getsockopt() to sockopt_t, its
last leaf on a sockptr_t pair. The IP_MSFILTER and MCAST_MSFILTER
bridges go away.

ip_getsockopt() builds the sockopt_t with sockopt_init_user() and
writes optlen back unconditionally

The write-back also happens before the netfilter fallback, so an
unwritable optlen turns any error into -EFAULT and skips the fallback.

This extra code in sol_ip_sockopt() will go away when we convert
sol_ip_sockopt() to talk sockopt as well, but for now we are converting
the leaves.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/mroute.h |  4 +--
 include/net/ip.h       |  3 +-
 net/core/filter.c      | 18 ++++++++---
 net/ipv4/igmp.c        |  3 +-
 net/ipv4/ip_sockglue.c | 87 +++++++++++++++++++-------------------------------
 net/ipv4/ipmr.c        | 11 +++----
 6 files changed, 56 insertions(+), 70 deletions(-)

diff --git a/include/linux/mroute.h b/include/linux/mroute.h
index 4c5003afee6c51..c1c21e61c81c37 100644
--- a/include/linux/mroute.h
+++ b/include/linux/mroute.h
@@ -17,7 +17,7 @@ static inline int ip_mroute_opt(int opt)
 }
 
 int ip_mroute_setsockopt(struct sock *, int, sockptr_t, unsigned int);
-int ip_mroute_getsockopt(struct sock *, int, sockptr_t, sockptr_t);
+int ip_mroute_getsockopt(struct sock *sk, int optname, sockopt_t *opt);
 int ipmr_ioctl(struct sock *sk, int cmd, void *arg);
 int ipmr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
 int ip_mr_init(void);
@@ -31,7 +31,7 @@ static inline int ip_mroute_setsockopt(struct sock *sock, int optname,
 }
 
 static inline int ip_mroute_getsockopt(struct sock *sk, int optname,
-				       sockptr_t optval, sockptr_t optlen)
+				       sockopt_t *opt)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/net/ip.h b/include/net/ip.h
index 604018cbf0f417..ac6dc64d4ac177 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -826,8 +826,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		     unsigned int optlen);
 int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		  unsigned int optlen);
-int do_ip_getsockopt(struct sock *sk, int level, int optname,
-		     sockptr_t optval, sockptr_t optlen);
+int do_ip_getsockopt(struct sock *sk, int level, int optname, sockopt_t *sopt);
 int ip_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 		  int __user *optlen);
 int ip_ra_control(struct sock *sk, unsigned char on,
diff --git a/net/core/filter.c b/net/core/filter.c
index ba536be2915fb9..1bc194a32337ac 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5737,10 +5737,20 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
 		return -EINVAL;
 	}
 
-	if (getopt)
-		return do_ip_getsockopt(sk, SOL_IP, optname,
-					KERNEL_SOCKPTR(optval),
-					KERNEL_SOCKPTR(optlen));
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
+		err = do_ip_getsockopt(sk, SOL_IP, optname, &opt);
+		*optlen = opt.optlen;
+		return err;
+	}
 
 	return do_ip_setsockopt(sk, SOL_IP, optname,
 				KERNEL_SOCKPTR(optval), *optlen);
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index d573c5bf8f038b..bf00810cdd7a13 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2763,12 +2763,13 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf, sockopt_t *opt)
 	if (err)
 		return err;
 
-	opt->optlen = msf_size;
 	if (copy_to_iter(msf, IP_MSFILTER_SIZE(0), &opt->iter_out) !=
 	    IP_MSFILTER_SIZE(0))
 		return -EFAULT;
 	if (len && copy_to_iter(psl->sl_addr, len, &opt->iter_out) != len)
 		return -EFAULT;
+
+	opt->optlen = msf_size;
 	return 0;
 done:
 	return err;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 1b7461f1569c32..90d0b5bee68b59 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1509,8 +1509,7 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockopt_t *opt)
 	return 0;
 }
 
-int do_ip_getsockopt(struct sock *sk, int level, int optname,
-		     sockptr_t optval, sockptr_t optlen)
+int do_ip_getsockopt(struct sock *sk, int level, int optname, sockopt_t *sopt)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	bool needs_rtnl = getsockopt_needs_rtnl(optname);
@@ -1521,10 +1520,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		return -EOPNOTSUPP;
 
 	if (ip_mroute_opt(optname))
-		return ip_mroute_getsockopt(sk, optname, optval, optlen);
+		return ip_mroute_getsockopt(sk, optname, sopt);
 
-	if (copy_from_sockptr(&len, optlen, sizeof(int)))
-		return -EFAULT;
+	len = sopt->optlen;
 	if (len < 0)
 		return -EINVAL;
 
@@ -1620,16 +1618,15 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		rcu_read_unlock();
 
 		if (opt->optlen == 0) {
-			len = 0;
-			return copy_to_sockptr(optlen, &len, sizeof(int));
+			sopt->optlen = 0;
+			return 0;
 		}
 
 		ip_options_undo(opt);
 
 		len = min_t(unsigned int, len, opt->optlen);
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, opt->__data, len))
+		sopt->optlen = len;
+		if (copy_to_iter(opt->__data, len, &sopt->iter_out) != len)
 			return -EFAULT;
 		return 0;
 	}
@@ -1653,12 +1650,12 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
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
 		msg.msg_flags = in_compat_syscall() ? MSG_CMSG_COMPAT : 0;
@@ -1680,8 +1677,8 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			int tos = READ_ONCE(inet->rcv_tos);
 			put_cmsg(&msg, SOL_IP, IP_TOS, sizeof(tos), &tos);
 		}
-		len -= msg.msg_controllen;
-		return copy_to_sockptr(optlen, &len, sizeof(int));
+		sopt->optlen = len - msg.msg_controllen;
+		return 0;
 	}
 	case IP_UNICAST_IF:
 		val = (__force int)htonl((__u32) READ_ONCE(inet->uc_index));
@@ -1692,9 +1689,8 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		len = min_t(unsigned int, len, sizeof(struct in_addr));
 		addr.s_addr = READ_ONCE(inet->mc_addr);
 
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, &addr, len))
+		sopt->optlen = len;
+		if (copy_to_iter(&addr, len, &sopt->iter_out) != len)
 			return -EFAULT;
 		return 0;
 	}
@@ -1711,43 +1707,25 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MSFILTER:
 	{
 		struct ip_msfilter msf;
-		struct kvec kvec;
-		sockopt_t opt;
 
 		if (len < IP_MSFILTER_SIZE(0)) {
 			err = -EINVAL;
 			goto out;
 		}
-		if (copy_from_sockptr(&msf, optval, IP_MSFILTER_SIZE(0))) {
+		if (copy_from_iter(&msf, IP_MSFILTER_SIZE(0), &sopt->iter_in) !=
+		    IP_MSFILTER_SIZE(0)) {
 			err = -EFAULT;
 			goto out;
 		}
-		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
-		if (err)
-			goto out;
-
-		err = ip_mc_msfget(sk, &msf, &opt);
-		if (!err && copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
-			err = -EFAULT;
+		err = ip_mc_msfget(sk, &msf, sopt);
 		goto out;
 	}
 	case MCAST_MSFILTER:
-	{
-		struct kvec kvec;
-		sockopt_t opt;
-
-		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
-		if (err)
-			goto out;
-
 		if (in_compat_syscall())
-			err = compat_ip_get_mcast_msfilter(sk, &opt);
+			err = compat_ip_get_mcast_msfilter(sk, sopt);
 		else
-			err = ip_get_mcast_msfilter(sk, &opt);
-		if (!err && copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
-			err = -EFAULT;
+			err = ip_get_mcast_msfilter(sk, sopt);
 		goto out;
-	}
 	case IP_PROTOCOL:
 		val = inet_sk(sk)->inet_num;
 		break;
@@ -1759,16 +1737,14 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 copyval:
 	if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
 		unsigned char ucval = (unsigned char)val;
-		len = 1;
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, &ucval, 1))
+
+		sopt->optlen = 1;
+		if (copy_to_iter(&ucval, 1, &sopt->iter_out) != 1)
 			return -EFAULT;
 	} else {
 		len = min_t(unsigned int, sizeof(int), len);
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, &val, len))
+		sopt->optlen = len;
+		if (copy_to_iter(&val, len, &sopt->iter_out) != len)
 			return -EFAULT;
 	}
 	return 0;
@@ -1783,19 +1759,22 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 int ip_getsockopt(struct sock *sk, int level,
 		  int optname, char __user *optval, int __user *optlen)
 {
+	sockopt_t opt;
 	int err;
 
-	err = do_ip_getsockopt(sk, level, optname,
-			       USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = do_ip_getsockopt(sk, level, optname, &opt);
+	if (put_user(opt.optlen, optlen))
+		return -EFAULT;
 
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err == -ENOPROTOOPT && optname != IP_PKTOPTIONS &&
 			!ip_mroute_opt(optname)) {
-		int len;
-
-		if (get_user(len, optlen))
-			return -EFAULT;
+		int len = opt.optlen;
 
 		err = nf_getsockopt(sk, PF_INET, optname, optval, &len);
 		if (err >= 0)
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e4c51ca473019c..f249569b4bf8b9 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1638,8 +1638,7 @@ int ipmr_sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 }
 
 /* Getsock opt support for the multicast routing system. */
-int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
-			 sockptr_t optlen)
+int ip_mroute_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
 {
 	int olr;
 	int val;
@@ -1670,16 +1669,14 @@ int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 		return -ENOPROTOOPT;
 	}
 
-	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
-		return -EFAULT;
+	olr = opt->optlen;
 	if (olr < 0)
 		return -EINVAL;
 
 	olr = min_t(unsigned int, olr, sizeof(int));
 
-	if (copy_to_sockptr(optlen, &olr, sizeof(int)))
-		return -EFAULT;
-	if (copy_to_sockptr(optval, &val, olr))
+	opt->optlen = olr;
+	if (copy_to_iter(&val, olr, &opt->iter_out) != olr)
 		return -EFAULT;
 	return 0;
 }

-- 
2.53.0-Meta

