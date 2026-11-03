Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704036;
	b=BUGs3ilmuJCsVci4Ecq3NgokeToo7y2sRvnflUMKuoAZdHf9Xlcg+UwOsiuc7yeexOG/
	 I2kdqg5sQkywFeDZ4xDw6wktmINBCXplUfHkXDxwephkxmhuP+iaqzkHep1VlFHvZStjJ
	 kX80oOGuix2gU0JZH0VXVjxJEulwmsS2JSjmpj6qevhoIOh1j1C7nTUpJBjhbYqjbGkSm
	 SPhOA2g6k/yoI8w7KroWfJh6Rb9ehnmYHL+Y3BIYnmsFlfftDtr2mHH0k5z9V3L2X/Br7
	 aXwuwmAxujaRfni45uOWkNGfXM5MGZAMoAfKex28E9p6My0bssLngXtdJo6w0O5iKxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704036;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=dzN4wcFssSNA9/6XFEEFZP84HEkL9ea4j8E+SEc6U5A=;
	b=b+fE2lcSB0AthHJ3K5flAADNjMYSjKlHW6Df3jLhymeQoDtUtBA868wUE5PLf4BTI31c
	 GFCrZGv/qeXlQylSOAkoqyv2m8HY0egcOd4/VVlAwtU0qlDjTP7NVikKjlvDuruA603iu
	 jD16Fl0l4AgyuM2coA7eFLaqdub2MDeFuHHbxroNAorn74tOqqkLnVsZSXwKGTxI7/c7R
	 gEKIfp4L3ZCNKL8d49tFnzK3GMVcfTP7EURCgIQ3ny8+LbpTgvl3FvIai8fDfemPjAgz6
	 3nAKhvZRTgkbC9/LOw1ejON43l12SxEeEUwDOfLXHzgTGxm5PKoKrRK1TSFTfDPdTZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FF6082BFE;
	Tue,  3 Nov 2026 11:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E33FF6082BFE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=dzN4wcFssSNA9/6XFEEFZP84HEkL9ea4j8E+SEc6U5A=; b=tXD48DHrT7Pqjo92esn7dvwRec
	IpjIDnGjH4Io5n2IEMmPNPhEjHq9AkkpIARfIAAe5e9B+q4rLRPjXl9sVwauyN9BsbJrcEkW72jGp
	piW7eCVVIospXL6d2wcyI7gkO9SaxKA73zRGregrwVRLKZClYV5Gglazanjk5m8jleVFw6a7Ie4b2
	PtQyRvfQqogdiCqmSsEpP1NghqxPtJV3N4EMZKDcrXog/gTh0D+pcm19zkI08j06FXTLybOPcLSsL
	cklgVz9SuAeTacjgrwxLu1PXE+Nfqd+lQmv2wFiSotko32J23qFFdIYybIoUuqnXRX1XNuCLV19iq
	0Avd6W/w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOCM1-006tDa-1K;
	Tue, 03 Nov 2026 11:07:01 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 03 Nov 2026 03:01:04 -0800
Subject: [PATCH net-next v4 5/7] ipv4: convert do_ip_getsockopt() to
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
Message-Id: <20261103-sockopt_expand_out_v2-v4-5-2d36da923578@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11609; i=leitao@debian.org;
 h=from:subject:message-id; bh=eGxHi+sShVxjfnYzKfdQ44uavrMPHoL5qHyjWJKbFmI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6cAvdh3AHofmsaiRO9zjooFw05SFb2LgvtznD
 RPL2J/G9OeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaunALwAKCRA1o5Of/Hh3
 bZk9D/9B4qN3mbdKZ6j1YCoiSH80zhl+suMkrCrnK2ja3VZBm7E1VIWP3Aw6zx31SCE/1ZM8fQV
 vi7jrjRfQCLx0LhaezcXIUitD7u7YcTXkCwQgniCagw8zhnxO0JA/BzKItgVFAqI6l2qHsTuaei
 mbkuQAkqJk0aRUssIh5TsQ2Dyfwd/flxIdJr1mPWaQpkMHbIuLz6PSMSZorR9X9BtguHKpmxjdk
 bUPlMQ7FY/Ru1Uj4m8xDBtCjKz+711yGh8+NBPyw/JIN2KZon63grinYtn//0KlL8b+WdCE6+Jr
 w+slpy+9AKiRxvdvRN9QLAI7nhlAw8QKdJCDw9V5D8wOG6zW4osHBvR+cVTKQkzde5r/PyR9QyE
 1B5TOO5Yg9S2xG75Glo7o+ggOmCWwuuTkE9zaFTN5PcA9lzza+AgkX4t0oJ9Rpxzd52eQKNyibR
 lnvodHwr51+L62m2McLY4LZWJmTW7edejMc0JixFic2SyVkpe7oxtTn3hxNiXWsIxbr8LJLpTIo
 ulnuhXW5L4u3JFgA1KHtxHObWX3yR5YdUAI2pYH6XRMmQ0f7f6wY4ulGu0haiGD+Kb3sg5oCSWb
 F1iMR2MsTCcVOpxJI82YUFwi5sVXYI0FNxpEku6TlDvtPo2vLb85R8wPvXeNkQNWcTyAUEvvesr
 pTQMnAAZ/yC8SuQ==
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
Acked-by: Ido Schimmel <idosch@nvidia.com>
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
index 0acc4ba5e5b340..5035b313a26b0d 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -808,8 +808,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
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
index 9245009d9f1ebc..fc427876bde839 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5827,10 +5827,20 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
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
index e8f7d3b573d0f4..e4c9accbb13ea9 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1657,8 +1657,7 @@ int ipmr_sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 }
 
 /* Getsock opt support for the multicast routing system. */
-int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
-			 sockptr_t optlen)
+int ip_mroute_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
 {
 	int olr;
 	int val;
@@ -1689,16 +1688,14 @@ int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
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

