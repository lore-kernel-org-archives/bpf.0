Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503269;
	b=VaHpfN6e3zjELHS7FnRlKyrU6t3upEZV2FgFf5GRxMoBSIBE0K/m6s3kWHLWl9MBC59a
	 dmRSYk/r0CmJFaGll3X/Fau2nXqNfowkLc77G03zf2FhkwofiZxWSQsDfqzZx/GZ1OM1b
	 y/QUa5TV/r3+A7YAx+u2YxTUQmFFXIu44PwXqFQw/XQumI2I4vHfc8QNvPXb3Dfe27tz4
	 xKFsHcFB2OYXz3QvNQaEgHODB+1pw5sjAqqr8xxPlFGRD2WpbbDEZumqh1qFS07JwmiuK
	 UcU3IHoBfwEFWb8WVvCeFWUm8jWwO68IV3H80x7IryF7xsbpClBt+/J2Z82VVOT2irg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503269;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=tOCxO+6QdC1PzbE/+dDglgL9/Ez94VjJU/9+X3cd+m4=;
	b=lcX2uR17eEDxGr0Rkhu1nK/zsbOsfqEn1V3JlMSkGlN/tEKtjPSmnCnngmZUwQ00zw8e
	 aJEZZnDB8f3xrLDjiK1/UpGpAgvnZt0ht9tP9N0XRGzse4o3gdwxFG0wsjrLtf6h3O+Du
	 Cg6L2AGIIGn97OwepImMyvNOms16I96NUlusB1H0tDL9wVHyz/2iXRtHS0efrUs6iMh1n
	 +syTpAO1OivTGWeQFPC+0fRyZSFAjNgGw+6HS5zd2GQpgDEktssiknFphvL/u/KucVSUc
	 4HKlAEG7NlR4F1zVYVcdAXQNvgc/oSdeqOLVsFwiNMUZRJvjdgFakbOeHeflz779hCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=DA7+bfBY;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D6606A337;
	Thu, 12 Nov 2026 17:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA6D6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=DA7+bfBY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=tOCxO+6QdC1PzbE/+dDglgL9/Ez94VjJU/9+X3cd+m4=; b=DA7+bfBYutaDjlU71JOt6qFKse
	udPW/ZOKNxvMX9r7H76oNwgxEDn8HnR9SrzgH6UwYUfJ/0U/C9Qu4Xf8xvilg+unFYO5urbail4P6
	iPLsOT9nQCoG+cZSL72axLSbYtBgJw2sPiuvs3dg0iSWfJv16hdlorP/UiVmI1uHCmu5XCBOvW+2b
	iBKhywA31EXgc8ai8zaJihQUtGLGlA0Cky6k4K526fUzA6VcFsE7dk32cVxYwF4RzMEGMD8LKQtOs
	SvvAUYN5nTuwrg9WwsnNjTWYV0/2U+4iyFVZSrBHvhQ+FR2A7yuBiPIXuTesQ3/FT3ZKUf77//Olu
	aX9Ixtvg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRYH1-00E7aA-37;
	Thu, 12 Nov 2026 17:07:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 12 Nov 2026 09:05:26 -0800
Subject: [PATCH net-next 2/3] tcp: convert do_tcp_getsockopt() to sockopt_t
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
Message-Id: <20261112-getsockopt_phase7-v1-2-1eb759dd0929@debian.org>
References: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
In-Reply-To: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=14048; i=leitao@debian.org;
 h=from:subject:message-id; bh=cAPkjowXzXBlMyXn/ozUV3GeP7/m3BlMdmf4TQ1wblM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9fJMZ/y/hOma2S4LIgebEYzrkJgUEnXSoG14T
 4TTK3d/55yJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavXyTAAKCRA1o5Of/Hh3
 bbVXD/47WhCGSBUGubWwWvgeR3kwoCecQSMX93F04TBvPnAgJCLTNP0OCDIDobjyTPK/tzNHEpi
 Xt3zWbeL2RKEWhgpqdY1xmyAQNOKyKG3j1dsBCltw5cyRTwT+WxFWVnlw6ifGTHfTuLHPOKPOGY
 osgcIw6gvc4YQvAS4VsdvI8CM6wX1iI0UT2T2xPcxglhjV1hdvCVpGE+Bt58ztWxFWjaUmrHBNI
 jCWBrI9O8sSaLaszPLOnYaupzPGLYFQMRucEC9rEg1DaImSAdO+u2VCBTaQeGw7GsOqoxS4ZvVk
 3QIuAfdhbsRF+ebpMXDKAnWWeQZFihXSctL9SgnGZG4xzBp0DT/Q4srzGe2lcNBXfACa2GYi9mO
 adk52PG+l4FinZwb2+Aoe/keib4RFzqMLG9YF6ImwLrgHwJHzTc6m7KWl/HYk5lG2VLPJ7xfYYU
 mcGaA3b7HA6MxJg4ChGyzL+0BjFvi8qbbez7jDbX/ohhqHsLgkOo5VpDvqrCjNpCWjqR9u72cbl
 wgN9jzPAN8/hlF4VctD2yK7+LnQAmb/hwIE2lUJC/WPINFWaBAfKwzmkLV+wirBCCNI65LWJ61X
 xrvFl4hKZeqMzhtW7uOTmLdm+nqCK7R5uyJt2jiSUxdlQ+fVH7LMgRdF51v+SIoEnGZCjZUdfxK
 liV8vBMc7EI3qjA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert the SOL_TCP switch to sockopt_t. The TCP-AO helpers already
take one, so they get it directly and the tcp_ao_get_sockptr() bridge
goes away.

The options that re-read optlen to get past the sizeof(int) clamp at
the top take it from sopt->optlen instead, so optlen is read once.

Only a user buffer reaches TCP_ZEROCOPY_RECEIVE: BPF's sol_tcp_sockopt()
does not take it, and it maps pages into the caller's mm anyway. It
keeps checking the bytes past its struct with check_zeroed_user(), now
on iter_in.ubuf, and a kernel buffer gets -EINVAL.

tcp_getsockopt() builds the sockopt_t with sockopt_init_user() once the
level is known to be SOL_TCP, and writes optlen back unconditionally,
because TCP_SAVED_SYN reports the length it needs and then fails with
-EINVAL. This mirrors ip_getsockopt().

Every SOL_TCP getsockopt() now writes optlen, including the ones that
did not before, such as TCP_REPAIR_WINDOW, TCP_ZEROCOPY_RECEIVE and the
error returns. An unwritable optlen word therefore turns them into
-EFAULT.

The others stored optlen before optval, so an unwritable optlen word
stopped optval from being written. Now optval is written first.

sol_tcp_sockopt() and sol_tcp_sockopt_congestion() reach
do_tcp_getsockopt() through sol_tcp_getsockopt(), which builds the
sockopt_t with sockptr_to_sockopt() and stores optlen back, as
sol_ip_sockopt() does.

copy_to_iter() runs the hardened usercopy check on its source, which
copy_to_sockptr() skips for a kernel buffer. BPF programs call
bpf_getsockopt() from the receive softirq too. On the vmapped IRQ
stack, the check then takes the lock in find_vmap_area(), which is not
softirq safe, and lockdep reports an inconsistent lock state.

sol_tcp_getsockopt() therefore calls do_tcp_getsockopt() with page
faults disabled, which makes check_heap_object() skip that lookup.
Commit d319f344561d ("mm: Fix copy_from_user_nofault().") added that
guard for BPF and kprobes.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/tcp.h |   3 +-
 net/core/filter.c |  30 +++++++++---
 net/ipv4/tcp.c    | 138 ++++++++++++++++++++----------------------------------
 3 files changed, 76 insertions(+), 95 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f265ae06bb558a..8e936770fc97c6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -498,8 +498,7 @@ void tcp_init_sock(struct sock *sk);
 void tcp_init_transfer(struct sock *sk, int bpf_op, struct sk_buff *skb);
 __poll_t tcp_poll(struct file *file, struct socket *sock,
 		      struct poll_table_struct *wait);
-int do_tcp_getsockopt(struct sock *sk, int level,
-		      int optname, sockptr_t optval, sockptr_t optlen);
+int do_tcp_getsockopt(struct sock *sk, int level, int optname, sockopt_t *sopt);
 int tcp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
 bool tcp_bpf_bypass_getsockopt(int level, int optname);
diff --git a/net/core/filter.c b/net/core/filter.c
index 9b8d5191c4ba27..0d5afe1c5606b1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5686,6 +5686,28 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 	return 0;
 }
 
+static int sol_tcp_getsockopt(struct sock *sk, int optname, char *optval,
+			      int *optlen)
+{
+	struct kvec kvec;
+	sockopt_t opt;
+	int err;
+
+	err = sockptr_to_sockopt(&opt, KERNEL_SOCKPTR(optval),
+				 KERNEL_SOCKPTR(optlen), &kvec);
+	if (err)
+		return err;
+
+	/* BPF may call this in softirq: with page faults disabled, the
+	 * usercopy check skips find_vmap_area() and its lock.
+	 */
+	pagefault_disable();
+	err = do_tcp_getsockopt(sk, SOL_TCP, optname, &opt);
+	pagefault_enable();
+	*optlen = opt.optlen;
+	return err;
+}
+
 static int sol_tcp_sockopt_congestion(struct sock *sk, char *optval,
 				      int *optlen, bool getopt)
 {
@@ -5700,9 +5722,7 @@ static int sol_tcp_sockopt_congestion(struct sock *sk, char *optval,
 			return -EINVAL;
 		/* BPF expects NULL-terminated tcp-cc string */
 		optval[--(*optlen)] = '\0';
-		return do_tcp_getsockopt(sk, SOL_TCP, TCP_CONGESTION,
-					 KERNEL_SOCKPTR(optval),
-					 KERNEL_SOCKPTR(optlen));
+		return sol_tcp_getsockopt(sk, TCP_CONGESTION, optval, optlen);
 	}
 
 	/* "cdg" is the only cc that alloc a ptr
@@ -5788,9 +5808,7 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 			return 0;
 		}
 
-		return do_tcp_getsockopt(sk, SOL_TCP, optname,
-					 KERNEL_SOCKPTR(optval),
-					 KERNEL_SOCKPTR(optlen));
+		return sol_tcp_getsockopt(sk, optname, optval, optlen);
 	}
 
 	return do_tcp_setsockopt(sk, SOL_TCP, optname,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 552e8fe22e7e20..de287845e6c0dc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4492,27 +4492,7 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	return stats;
 }
 
-/* Bridge the sockptr_t pair of do_tcp_getsockopt() to a TCP-AO getter. */
-static int tcp_ao_get_sockptr(struct sock *sk,
-			      int (*get)(struct sock *sk, sockopt_t *sopt),
-			      sockptr_t optval, sockptr_t optlen)
-{
-	struct kvec kvec;
-	sockopt_t sopt;
-	int err;
-
-	err = sockptr_to_sockopt(&sopt, optval, optlen, &kvec);
-	if (err)
-		return err;
-
-	err = get(sk, &sopt);
-	if (!err && copy_to_sockptr(optlen, &sopt.optlen, sizeof(int)))
-		err = -EFAULT;
-	return err;
-}
-
-int do_tcp_getsockopt(struct sock *sk, int level,
-		      int optname, sockptr_t optval, sockptr_t optlen)
+int do_tcp_getsockopt(struct sock *sk, int level, int optname, sockopt_t *sopt)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -4520,8 +4500,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	int user_mss;
 	int val, len;
 
-	if (copy_from_sockptr(&len, optlen, sizeof(int)))
-		return -EFAULT;
+	len = sopt->optlen;
 
 	if (len < 0)
 		return -EINVAL;
@@ -4573,15 +4552,13 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_INFO: {
 		struct tcp_info info;
 
-		if (copy_from_sockptr(&len, optlen, sizeof(int)))
-			return -EFAULT;
+		len = sopt->optlen;
 
 		tcp_get_info(sk, &info);
 
 		len = min_t(unsigned int, len, sizeof(info));
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, &info, len))
+		sopt->optlen = len;
+		if (copy_to_iter(&info, len, &sopt->iter_out) != len)
 			return -EFAULT;
 		return 0;
 	}
@@ -4591,8 +4568,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		size_t sz = 0;
 		int attr;
 
-		if (copy_from_sockptr(&len, optlen, sizeof(int)))
-			return -EFAULT;
+		len = sopt->optlen;
 
 		rcu_read_lock();
 		ca_ops = READ_ONCE(icsk->icsk_ca_ops);
@@ -4601,9 +4577,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		rcu_read_unlock();
 
 		len = min_t(unsigned int, len, sz);
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, &info, len))
+		sopt->optlen = len;
+		if (copy_to_iter(&info, len, &sopt->iter_out) != len)
 			return -EFAULT;
 		return 0;
 	}
@@ -4614,34 +4589,29 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_CONGESTION: {
 		char ca_name[TCP_CA_NAME_MAX] = {};
 
-		if (copy_from_sockptr(&len, optlen, sizeof(int)))
-			return -EFAULT;
+		len = sopt->optlen;
 		len = min_t(unsigned int, len, TCP_CA_NAME_MAX);
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
+		sopt->optlen = len;
 
 		rcu_read_lock();
 		memcpy(ca_name, READ_ONCE(icsk->icsk_ca_ops)->name,
 		       sizeof(ca_name));
 		rcu_read_unlock();
 
-		if (copy_to_sockptr(optval, ca_name, len))
+		if (copy_to_iter(ca_name, len, &sopt->iter_out) != len)
 			return -EFAULT;
 		return 0;
 	}
 	case TCP_ULP:
-		if (copy_from_sockptr(&len, optlen, sizeof(int)))
-			return -EFAULT;
+		len = sopt->optlen;
 		len = min_t(unsigned int, len, TCP_ULP_NAME_MAX);
 		if (!icsk->icsk_ulp_ops) {
-			len = 0;
-			if (copy_to_sockptr(optlen, &len, sizeof(int)))
-				return -EFAULT;
+			sopt->optlen = 0;
 			return 0;
 		}
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, icsk->icsk_ulp_ops->name, len))
+		sopt->optlen = len;
+		if (copy_to_iter(icsk->icsk_ulp_ops->name, len,
+				 &sopt->iter_out) != len)
 			return -EFAULT;
 		return 0;
 
@@ -4649,15 +4619,13 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		u64 key[TCP_FASTOPEN_KEY_BUF_LENGTH / sizeof(u64)];
 		unsigned int key_len;
 
-		if (copy_from_sockptr(&len, optlen, sizeof(int)))
-			return -EFAULT;
+		len = sopt->optlen;
 
 		key_len = tcp_fastopen_get_cipher(net, icsk, key) *
 				TCP_FASTOPEN_KEY_LENGTH;
 		len = min_t(unsigned int, len, key_len);
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, key, len))
+		sopt->optlen = len;
+		if (copy_to_iter(key, len, &sopt->iter_out) != len)
 			return -EFAULT;
 		return 0;
 	}
@@ -4683,8 +4651,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_REPAIR_WINDOW: {
 		struct tcp_repair_window opt;
 
-		if (copy_from_sockptr(&len, optlen, sizeof(int)))
-			return -EFAULT;
+		len = sopt->optlen;
 
 		if (len != sizeof(opt))
 			return -EINVAL;
@@ -4698,7 +4665,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		opt.rcv_wnd	= tp->rcv_wnd;
 		opt.rcv_wup	= tp->rcv_wup;
 
-		if (copy_to_sockptr(optval, &opt, len))
+		if (copy_to_iter(&opt, len, &sopt->iter_out) != len)
 			return -EFAULT;
 		return 0;
 	}
@@ -4748,26 +4715,20 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = tp->save_syn;
 		break;
 	case TCP_SAVED_SYN: {
-		if (copy_from_sockptr(&len, optlen, sizeof(int)))
-			return -EFAULT;
+		len = sopt->optlen;
 
 		sockopt_lock_sock(sk);
 		if (tp->saved_syn) {
 			if (len < tcp_saved_syn_len(tp->saved_syn)) {
 				len = tcp_saved_syn_len(tp->saved_syn);
-				if (copy_to_sockptr(optlen, &len, sizeof(int))) {
-					sockopt_release_sock(sk);
-					return -EFAULT;
-				}
+				sopt->optlen = len;
 				sockopt_release_sock(sk);
 				return -EINVAL;
 			}
 			len = tcp_saved_syn_len(tp->saved_syn);
-			if (copy_to_sockptr(optlen, &len, sizeof(int))) {
-				sockopt_release_sock(sk);
-				return -EFAULT;
-			}
-			if (copy_to_sockptr(optval, tp->saved_syn->data, len)) {
+			sopt->optlen = len;
+			if (copy_to_iter(tp->saved_syn->data, len,
+					 &sopt->iter_out) != len) {
 				sockopt_release_sock(sk);
 				return -EFAULT;
 			}
@@ -4775,9 +4736,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 			sockopt_release_sock(sk);
 		} else {
 			sockopt_release_sock(sk);
-			len = 0;
-			if (copy_to_sockptr(optlen, &len, sizeof(int)))
-				return -EFAULT;
+			sopt->optlen = 0;
 		}
 		return 0;
 	}
@@ -4787,21 +4746,21 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		struct tcp_zerocopy_receive zc = {};
 		int err;
 
-		if (copy_from_sockptr(&len, optlen, sizeof(int)))
-			return -EFAULT;
+		len = sopt->optlen;
 		if (len < 0 ||
 		    len < offsetofend(struct tcp_zerocopy_receive, length))
 			return -EINVAL;
 		if (unlikely(len > sizeof(zc))) {
-			err = check_zeroed_sockptr(optval, sizeof(zc),
-						   len - sizeof(zc));
+			if (WARN_ON_ONCE(!iter_is_ubuf(&sopt->iter_in)))
+				return -EINVAL;
+			err = check_zeroed_user(sopt->iter_in.ubuf + sizeof(zc),
+						len - sizeof(zc));
 			if (err < 1)
 				return err == 0 ? -EINVAL : err;
 			len = sizeof(zc);
-			if (copy_to_sockptr(optlen, &len, sizeof(int)))
-				return -EFAULT;
+			sopt->optlen = len;
 		}
-		if (copy_from_sockptr(&zc, optval, len))
+		if (copy_from_iter(&zc, len, &sopt->iter_in) != len)
 			return -EFAULT;
 		if (zc.reserved)
 			return -EINVAL;
@@ -4841,7 +4800,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 zerocopy_rcv_inq:
 		zc.inq = tcp_inq_hint(sk);
 zerocopy_rcv_out:
-		if (!err && copy_to_sockptr(optval, &zc, len))
+		if (!err && copy_to_iter(&zc, len, &sopt->iter_out) != len)
 			err = -EFAULT;
 		return err;
 	}
@@ -4849,19 +4808,16 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_AO_REPAIR:
 		if (!tcp_can_repair_sock(sk))
 			return -EPERM;
-		return tcp_ao_get_sockptr(sk, tcp_ao_get_repair,
-					  optval, optlen);
+		return tcp_ao_get_repair(sk, sopt);
 	case TCP_AO_GET_KEYS:
 	case TCP_AO_INFO: {
 		int err;
 
 		sockopt_lock_sock(sk);
 		if (optname == TCP_AO_GET_KEYS)
-			err = tcp_ao_get_sockptr(sk, tcp_ao_get_mkts,
-						 optval, optlen);
+			err = tcp_ao_get_mkts(sk, sopt);
 		else
-			err = tcp_ao_get_sockptr(sk, tcp_ao_get_sock_info,
-						 optval, optlen);
+			err = tcp_ao_get_sock_info(sk, sopt);
 		sockopt_release_sock(sk);
 
 		return err;
@@ -4882,9 +4838,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		return -ENOPROTOOPT;
 	}
 
-	if (copy_to_sockptr(optlen, &len, sizeof(int)))
-		return -EFAULT;
-	if (copy_to_sockptr(optval, &val, len))
+	sopt->optlen = len;
+	if (copy_to_iter(&val, len, &sopt->iter_out) != len)
 		return -EFAULT;
 	return 0;
 }
@@ -4904,13 +4859,22 @@ int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 		   int __user *optlen)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	sockopt_t sopt;
+	int err;
 
 	if (level != SOL_TCP)
 		/* Paired with WRITE_ONCE() in do_ipv6_setsockopt() and tcp_v6_connect() */
 		return READ_ONCE(icsk->icsk_af_ops)->getsockopt(sk, level, optname,
 								optval, optlen);
-	return do_tcp_getsockopt(sk, level, optname, USER_SOCKPTR(optval),
-				 USER_SOCKPTR(optlen));
+
+	err = sockopt_init_user(&sopt, optval, optlen);
+	if (err)
+		return err;
+
+	err = do_tcp_getsockopt(sk, level, optname, &sopt);
+	if (put_user(sopt.optlen, optlen))
+		return -EFAULT;
+	return err;
 }
 
 #ifdef CONFIG_TCP_MD5SIG

-- 
2.53.0-Meta

