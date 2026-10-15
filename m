Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC651C04B;
	Thu, 15 Oct 2026 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058782; cv=none; b=L2HJfRFLyIx2TeAY2aFkksyNmlejkJWWXeyPLNdb9+eF95jfRo9S4NvLP563+HUXKbMTZK+1OdHBYJlhym/haCdihOQG5J7U745S1cut/cWju05IBGhvJ7rjARzMhlVwVH1tAuhm4sRGsSub2bwOD8PjmH5IK+kXUgvQTI+UT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058782; c=relaxed/simple;
	bh=BYRhJANNdO1YjTWRgkycE8qyNQ7qeQ6Nb5AtZcxaY0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzX7PbRoo4IWfkc7W453UmlQfG6BsIxrAojqtNwEiSM+yNGp7ZwaBNkEZR7GgTJxRy1zDVtiJ/eiupptOLnyPQCpZ/+bYPJHAgJp6hMtFN1Nr3eYuKpiqFiLv5s7CT+EnU6hBB9+pyGFz8ZAYsRfi48DH3YX2p8GdH7ZHkw/6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fKl/mqws; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fKl/mqws"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=KYzxhyanTZkZWJYm2pKFPbkuJM1ksIaW9DekaUsR23s=; b=fKl/mqws7MbHYoJi7EnsIqjRxk
	2yO1Rs69Bt4OzPbFSnWGWZDZ75w2OMmvaCP8Yz2JwQ6sBAavF0rBuBHnhEW82k+qCRMHPdmPaitID
	wtOS0EszBkN5D18E60JT9YahzzWHf91OpsSgBKoF42sr6GwfG7hHjeubsKpkrF0x2iv+2iGSn6/sU
	z3a/YYRnYt6LBkMWANpx29HU03gWhOXa7143iQGxiuTZTUphtWSZC5uWPOYdzkUkyEvwai3yiFXvQ
	zEPDWzYypSBScyLnisnwSS0Tog99gz6xP0OrteyMVBF04d9dpViPJLDmz30JEWCM3CBo7ZpwHNe/i
	oG+JrSNA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHILq-0057C6-0b;
	Thu, 15 Oct 2026 10:06:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Oct 2026 03:05:34 -0700
Subject: [PATCH net-next v3 5/7] ipv4: convert do_ip_getsockopt() to
 sockopt_t
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sockopt_expand_out_v2-v3-5-7d05ef2df448@debian.org>
References: <20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org>
In-Reply-To: <20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=11565; i=leitao@debian.org;
 h=from:subject:message-id; bh=BYRhJANNdO1YjTWRgkycE8qyNQ7qeQ6Nb5AtZcxaY0Y=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq0KV0/1vumngYHBy0ZVsuTe5sWU1ukYUHw7SuO
 q2PfVfUiROJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCatCldAAKCRA1o5Of/Hh3
 bachD/4nsjxWwAtqW1g2EDLyu6Hw/rRnhxo9gmUnectpMvFBuvATn8Y2nYeHVomsHsTeS2zMp+O
 OaTeW40J8avHOQPBaksnRc94hPhBCmd+BHVPgjM7BCQNXbqK7OKpnUuAeQbAu5xIK2YOTDXZsc6
 oUKw8PiEwry9c8aVyo6XHHQsKDn6v7fcOdLDVzr6fUXruGaim9T3cfnDTjHyNnC+VNpmPjJTEyx
 fvwDi9N/RP4signICcvlsftNt5txlgs0K4coZuNNalTV0qls7a/WzTU91ZCMYrjhh19lzYrfhYl
 H0T6OZPNvnu0kSDb31vOFxAfyuQ7UN7lEwKi15oaaUMqAEucmQM1+qlxL4hLAdYxRAJE60qALnz
 b4iUpvu4TcWMUp6SYzPT1Uz84qsiBQNFAlp85+HGcslNRqejp7unq5QxSAhjqQ//MIrJmjwigv4
 d5iMxrwbwlSMBRa+paw/TEDw4EsHFOINOl2yLNx2SMAS1H7Ej7dxwadQF/btyXW3gVkxvxwwhta
 Rg/ApNL/qDzMyjJULDb2ZUto8VwenzKEkvCsjFNqbVc2xOZzq9oQr04HuB3AbFzOa+5kwaQnIZV
 dRrOug+xHxG7TG/2la9flFjpQLzAhaz3GWXD6IVulSnm4OZe7/sRszc6AUtEsx0OGbPvRbrWC2u
 pUvARUIDQR8VBKQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert the SOL_IP switch and ip_mroute_getsockopt() to sockopt_t, its
last leaf on a sockptr_t pair. The IP_MSFILTER and MCAST_MSFILTER
bridges go away.

ip_getsockopt() builds the sockopt_t with sockopt_init_user() and
writes optlen back unconditionally, because IP_OPTIONS and others
report a length and can then fail. ip_mc_msfget() therefore stores its
length only after its last copy, so a copy failure can't report a
changed one.

The write-back also happens before the netfilter fallback, so an
unwritable optlen turns any error into -EFAULT and skips the fallback.
Likewise optlen is now read before the level check and the MRT_*
dispatch, so an unreadable or negative one wins over -EOPNOTSUPP.

IP_OPTIONS with no options set and IP_PKTOPTIONS used to return the
result of copy_to_sockptr(), the number of bytes not copied, so an
unwritable optlen made getsockopt() return 4. They now return -EFAULT.

sol_ip_sockopt() builds the sockopt_t with sockptr_to_sockopt() and
stores optlen back as well. This extra code will go away when we
convert sol_ip_sockopt() to talk sockopt as well, but for now we are
converting the leaves.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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
index 618b9806c10b0a..c59ffb432b3ed7 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -833,8 +833,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
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
index 5e575981febec7..bb8df3df7ee0d2 100644
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

