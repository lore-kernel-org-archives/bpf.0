Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503265;
	b=oAQZsiZVDaFF4s+53elrEi+bz/hzLk9pZEFX1qt1PvaMQJna0QEH3kjnsoahMAj2+Zj5
	 DBOy7HOl+BmvpnRMG43CC35KQ9HFzAZcoZanegpDY059ec4IIQu4uQc6RwBOwYWZFPc+W
	 temvdorzGaz0DJa6v18EAecbTHnx8oSobP+q1fZHu3FE75NmEeDTAbfTToioGOUsJCpd/
	 iTR6y4+5ULN0ofCgGBbg+If4CqWa5juVVEaPhV/yoq7QEoWQojFDFz9dfqbYuU6J+S4dV
	 ThLGfaS2EWfQqmNlNy/0gqviAuuCwImf+rNtAaNnJynirMTAeLiQVxXt0WD1Nd8TC/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503265;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=Ojqa0XJldiIPvWKnxsSzSwPPgqzGjP+HUV7neZ/Ynso=;
	b=zZp4f4IZgeslpNelVmYZ5INs0mXDZc+jJZ3YYwWPY6vo7eNyM/HEs0bCqwAH2pzEuA7M
	 YXb0REZ8yLty8RA5wlSjbbLmZQGFvxFEGuP5Nrgdw5cM0kKP53JIwk1gR7QRjrysQ9ikX
	 /U373rsbras7dgz9eZHBI4k9ybvzveVi12XoJ1YpwWDAFJ4AM3aTnG3wDw/4u4rTTTiZr
	 3ZxFdlOOP8yTS9PWeC9m1jrnkOmyYaMqW8Iv5D9BXJOx2kyAVA0ksoensG0+/cMxMAHt7
	 SUCwfaUDDAcvOgDhia89GTuiVU7WBb/erixm2+G+4Fa7LhfTMmlFMfj1WskAr5QAwNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=StAZuchq;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C9606A330;
	Thu, 12 Nov 2026 17:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 478C9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=StAZuchq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Ojqa0XJldiIPvWKnxsSzSwPPgqzGjP+HUV7neZ/Ynso=; b=StAZuchqKGcnW3WuAm+EpqDq/H
	63NH8qrd5XuwtmaM4LFX/tUGuc/n3s2gZz5l/ihkno3PiWttciimPiKBGLeVHTbCIWadbxJNi+eC4
	8qNa6UEyyUBWYrWWZIH7u+snhNiGYRGtHbh4bzA9XDV2i9ZL5g0X1jWBsGzvzjtpZtZHNqePJxGcQ
	zkubFqI9D11YbCuSqMpnCf26EemTtQkA2sGqIZdcl4hv53rYBXrGDA491v6vtN3OLZDNlKZqpoRfi
	9f2jLZWiOeBUTotyvRCBTAJ2DRt81y1jxMXhXSq1HUPLzg/Wk8fq7b5VHwe4qdqxPwE0oD9XJFhhG
	LPGAoy8g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRYGv-00E7a5-0y;
	Thu, 12 Nov 2026 17:07:37 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 12 Nov 2026 09:05:25 -0800
Subject: [PATCH net-next 1/3] net/tcp-ao: convert the getsockopt helpers to
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
Message-Id: <20261112-getsockopt_phase7-v1-1-1eb759dd0929@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12017; i=leitao@debian.org;
 h=from:subject:message-id; bh=B3Z9SdvlbpC+8rsw7DMS0Gb33wx1vZmvzI07dWn1rzE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9fJMbHRis7nIEpY4rbAOZkwbk/Y7SriMV1Ju0
 olgh2iT5rGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavXyTAAKCRA1o5Of/Hh3
 bdjIEACViABSIWsWP+07ahfm8zDmLBdHQOc1TsQtO/Mi8Q+8qcE64em5j4feKJGdv2UgGFcvjo9
 OCnjuVHqpF+lJ0S74SqIgbVEDTmWmVo4yPst/62/lQ3ugAFbR6oQzzal7tEbV62Ed8k5b/v+XkU
 oViNYh5HluU7i0bPT1v3PCsviiWmH6I1vc5DmO225Sho5Q2G5cwUpM6dOnjJPgxcdk62Dy/azlw
 J0hV562NzgseIFS3eBjMwHFWaA7cLkNLgfeHA6QnqJQpBZncdySLiPuW/0fuMD7osGED3lCc41Q
 reyNLiQeaZCc2bdSwHjvbDgRSGh9bO9R/qC24r1cphaJNXqldKniHK+MjvnvAI/F6C83/DMjxMT
 z4Lsp4rICZaa3GtwGCbzeL9RmmW4hY6q39jRzxzEz9PyY51pl05WqODucDN3VdwDM1ZhMfMF6mb
 XH4k4kz6mKOQUO2O0lUBMeEMUz6K7QcqUv1j/nsNSCdNoaaqCyeEV4wW62DfPlr6kPbu4rOSMhZ
 T6XU23RDWenXNISWyE+fLePEQu1TrQqrpv05aE2aO7Hz/HPAnlu1TO4X+zOk2RPPWQkZDKsol3h
 POMOTM3sxdasF4tMyG3e7AAwfCgd/esszIQfJyXx1ZBLsUSOAyHIi5/vZ8LG9u9N4UFdOMhmlNt
 aOaznkBULEtMWCg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

TCP_AO_GET_KEYS, TCP_AO_INFO and TCP_AO_REPAIR are read through
tcp_ao_get_mkts(), tcp_ao_get_sock_info() and tcp_ao_get_repair(),
reached from do_tcp_getsockopt() and from nowhere else. Convert them to
sockopt_t. While do_tcp_getsockopt() still carries a sockptr_t pair, it
calls them through tcp_ao_get_sockptr(), which builds the sockopt_t and
writes optlen back.

TCP_AO_GET_KEYS and TCP_AO_INFO read a versioned struct from optval.
Only a user buffer gets there, as BPF's sol_tcp_sockopt() takes no
TCP-AO option, so they keep reading it with copy_struct_from_user(),
now on iter_in.ubuf. A kernel buffer gets -EINVAL, as in
sockopt_expand_out().

TCP_AO_GET_KEYS is sized by a field in optval rather than by optlen:
optlen is the size of one entry, and nkeys says how many entries the
buffer holds. The match count then goes into the first entry's nkeys,
past optlen when the caller's struct is shorter than that field.

Userspace relies on this, so sockopt_expand_out() grows optval for the
reply, as for MCAST_MSFILTER. The growth is bounded by the keys on the
socket, not by nkeys alone: sockopt_expand_out() refuses a reply above
MAX_RW_COUNT, and a large nkeys would otherwise get -EINVAL.

iter_out only moves forward, so the entries are written in turn and the
bytes past each one are skipped, as before. The match count is written
last, through a copy of iter_out saved at the head of optval.

A reply that still needs more than MAX_RW_COUNT bytes now fails with
-EINVAL. With two keys on the socket, that takes entries of about 1 GiB.

TCP_AO_INFO and TCP_AO_REPAIR now write optlen back on success, with
the value they were given. TCP_AO_GET_KEYS stores optlen after nkeys
instead of before it, which only shows when one of the two writes
faults.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/tcp_ao.h | 13 ++++-----
 net/ipv4/tcp.c       | 28 +++++++++++++++++--
 net/ipv4/tcp_ao.c    | 77 ++++++++++++++++++++++++++++++----------------------
 3 files changed, 76 insertions(+), 42 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 9a2333e62e9940..0e1edd777a600a 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -210,9 +210,9 @@ void tcp_ao_calc_traffic_key(const struct tcp_ao_key *mkt, u8 *traffic_key,
 void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp);
 bool tcp_ao_ignore_icmp(const struct sock *sk, int family, int type, int code);
-int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen);
-int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen);
-int tcp_ao_get_repair(struct sock *sk, sockptr_t optval, sockptr_t optlen);
+int tcp_ao_get_mkts(struct sock *sk, sockopt_t *sopt);
+int tcp_ao_get_sock_info(struct sock *sk, sockopt_t *sopt);
+int tcp_ao_get_repair(struct sock *sk, sockopt_t *sopt);
 int tcp_ao_set_repair(struct sock *sk, sockptr_t optval, unsigned int optlen);
 enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
@@ -334,18 +334,17 @@ static inline void tcp_ao_connect_init(struct sock *sk)
 {
 }
 
-static inline int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+static inline int tcp_ao_get_mkts(struct sock *sk, sockopt_t *sopt)
 {
 	return -ENOPROTOOPT;
 }
 
-static inline int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+static inline int tcp_ao_get_sock_info(struct sock *sk, sockopt_t *sopt)
 {
 	return -ENOPROTOOPT;
 }
 
-static inline int tcp_ao_get_repair(struct sock *sk,
-				    sockptr_t optval, sockptr_t optlen)
+static inline int tcp_ao_get_repair(struct sock *sk, sockopt_t *sopt)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a1f89c1fa2ae51..552e8fe22e7e20 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4492,6 +4492,25 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	return stats;
 }
 
+/* Bridge the sockptr_t pair of do_tcp_getsockopt() to a TCP-AO getter. */
+static int tcp_ao_get_sockptr(struct sock *sk,
+			      int (*get)(struct sock *sk, sockopt_t *sopt),
+			      sockptr_t optval, sockptr_t optlen)
+{
+	struct kvec kvec;
+	sockopt_t sopt;
+	int err;
+
+	err = sockptr_to_sockopt(&sopt, optval, optlen, &kvec);
+	if (err)
+		return err;
+
+	err = get(sk, &sopt);
+	if (!err && copy_to_sockptr(optlen, &sopt.optlen, sizeof(int)))
+		err = -EFAULT;
+	return err;
+}
+
 int do_tcp_getsockopt(struct sock *sk, int level,
 		      int optname, sockptr_t optval, sockptr_t optlen)
 {
@@ -4830,16 +4849,19 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_AO_REPAIR:
 		if (!tcp_can_repair_sock(sk))
 			return -EPERM;
-		return tcp_ao_get_repair(sk, optval, optlen);
+		return tcp_ao_get_sockptr(sk, tcp_ao_get_repair,
+					  optval, optlen);
 	case TCP_AO_GET_KEYS:
 	case TCP_AO_INFO: {
 		int err;
 
 		sockopt_lock_sock(sk);
 		if (optname == TCP_AO_GET_KEYS)
-			err = tcp_ao_get_mkts(sk, optval, optlen);
+			err = tcp_ao_get_sockptr(sk, tcp_ao_get_mkts,
+						 optval, optlen);
 		else
-			err = tcp_ao_get_sock_info(sk, optval, optlen);
+			err = tcp_ao_get_sockptr(sk, tcp_ao_get_sock_info,
+						 optval, optlen);
 		sockopt_release_sock(sk);
 
 		return err;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bb7bbc20ba3fad..af33042478f9a8 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -2054,14 +2054,11 @@ int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen)
 	return tcp_parse_ao(sk, cmd, AF_INET, optval, optlen);
 }
 
-/* tcp_ao_copy_mkts_to_user(ao_info, optval, optlen)
+/* tcp_ao_copy_mkts_to_user(ao_info, sopt)
  *
  * @ao_info:	struct tcp_ao_info on the socket that
  *		socket getsockopt(TCP_AO_GET_KEYS) is executed on
- * @optval:	pointer to array of tcp_ao_getsockopt structures in user space.
- *		Must be != NULL.
- * @optlen:	pointer to size of tcp_ao_getsockopt structure.
- *		Must be != NULL.
+ * @sopt:	optval and optlen of that getsockopt(), described below.
  *
  * Return value: 0 on success, a negative error number otherwise.
  *
@@ -2091,29 +2088,31 @@ int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen)
  */
 static int tcp_ao_copy_mkts_to_user(const struct sock *sk,
 				    struct tcp_ao_info *ao_info,
-				    sockptr_t optval, sockptr_t optlen)
+				    sockopt_t *sopt)
 {
 	struct tcp_ao_getsockopt opt_in, opt_out;
 	struct tcp_ao_key *key, *current_key;
 	bool do_address_matching = true;
 	union tcp_ao_addr *addr = NULL;
 	int err, l3index, user_len;
+	unsigned int nr_keys = 0;
 	unsigned int max_keys;	/* maximum number of keys to copy to user */
-	size_t out_offset = 0;
 	size_t bytes_to_write;	/* number of bytes to write to user level */
+	struct iov_iter head;
 	u32 matched_keys;	/* keys from ao_info matched so far */
-	int optlen_out;
+	size_t reply_len;
 	__be16 port = 0;
 
-	if (copy_from_sockptr(&user_len, optlen, sizeof(int)))
-		return -EFAULT;
+	user_len = sopt->optlen;
 
 	if (user_len <= 0)
 		return -EINVAL;
 
 	memset(&opt_in, 0, sizeof(struct tcp_ao_getsockopt));
-	err = copy_struct_from_sockptr(&opt_in, sizeof(opt_in),
-				       optval, user_len);
+	if (WARN_ON_ONCE(!iter_is_ubuf(&sopt->iter_in)))
+		return -EINVAL;
+	err = copy_struct_from_user(&opt_in, sizeof(opt_in), sopt->iter_in.ubuf,
+				    user_len);
 	if (err < 0)
 		return err;
 
@@ -2214,6 +2213,21 @@ static int tcp_ao_copy_mkts_to_user(const struct sock *sk,
 	}
 
 	bytes_to_write = min_t(int, user_len, sizeof(struct tcp_ao_getsockopt));
+
+	/* The reply is up to nkeys entries, user_len apart, with the match
+	 * count in the first entry's nkeys, so it can outgrow optlen. Size it
+	 * by the keys on the socket rather than by the caller's nkeys.
+	 */
+	hlist_for_each_entry_rcu(key, &ao_info->head, node,
+				 lockdep_sock_is_held(sk))
+		nr_keys++;
+	reply_len = max(array_size(min(max_keys, nr_keys), user_len),
+			offsetofend(struct tcp_ao_getsockopt, nkeys));
+	err = sockopt_expand_out(sopt, reply_len);
+	if (err)
+		return err;
+	head = sopt->iter_out;
+
 	matched_keys = 0;
 	/* May change in RX, while we're dumping, pre-fetch it */
 	current_key = READ_ONCE(ao_info->current_key);
@@ -2275,25 +2289,22 @@ static int tcp_ao_copy_mkts_to_user(const struct sock *sk,
 			strscpy(opt_out.alg_name, tcp_ao_algos[key->algo].name);
 
 		/* Copy key to user */
-		if (copy_to_sockptr_offset(optval, out_offset,
-					   &opt_out, bytes_to_write))
+		if (copy_to_iter(&opt_out, bytes_to_write, &sopt->iter_out) !=
+		    bytes_to_write)
 			return -EFAULT;
-		out_offset += user_len;
+		iov_iter_advance(&sopt->iter_out, user_len - bytes_to_write);
 	}
 
-	optlen_out = (int)sizeof(struct tcp_ao_getsockopt);
-	if (copy_to_sockptr(optlen, &optlen_out, sizeof(int)))
-		return -EFAULT;
+	sopt->optlen = sizeof(struct tcp_ao_getsockopt);
 
-	out_offset = offsetof(struct tcp_ao_getsockopt, nkeys);
-	if (copy_to_sockptr_offset(optval, out_offset,
-				   &matched_keys, sizeof(u32)))
+	iov_iter_advance(&head, offsetof(struct tcp_ao_getsockopt, nkeys));
+	if (copy_to_iter(&matched_keys, sizeof(u32), &head) != sizeof(u32))
 		return -EFAULT;
 
 	return 0;
 }
 
-int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+int tcp_ao_get_mkts(struct sock *sk, sockopt_t *sopt)
 {
 	struct tcp_ao_info *ao_info;
 
@@ -2303,18 +2314,17 @@ int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen)
 	if (!ao_info)
 		return -ENOENT;
 
-	return tcp_ao_copy_mkts_to_user(sk, ao_info, optval, optlen);
+	return tcp_ao_copy_mkts_to_user(sk, ao_info, sopt);
 }
 
-int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+int tcp_ao_get_sock_info(struct sock *sk, sockopt_t *sopt)
 {
 	struct tcp_ao_info_opt out, in = {};
 	struct tcp_ao_key *current_key;
 	struct tcp_ao_info *ao;
 	int err, len;
 
-	if (copy_from_sockptr(&len, optlen, sizeof(int)))
-		return -EFAULT;
+	len = sopt->optlen;
 
 	if (len <= 0)
 		return -EINVAL;
@@ -2323,7 +2333,9 @@ int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen)
 	 * that may be needed to extend (struct tcp_ao_info_opt) and
 	 * what getsockopt() provides in future.
 	 */
-	err = copy_struct_from_sockptr(&in, sizeof(in), optval, len);
+	if (WARN_ON_ONCE(!iter_is_ubuf(&sopt->iter_in)))
+		return -EINVAL;
+	err = copy_struct_from_user(&in, sizeof(in), sopt->iter_in.ubuf, len);
 	if (err)
 		return err;
 
@@ -2355,7 +2367,8 @@ int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen)
 		out.rnext = ao->rnext_key->rcvid;
 	}
 
-	if (copy_to_sockptr(optval, &out, min_t(int, len, sizeof(out))))
+	len = min_t(int, len, sizeof(out));
+	if (copy_to_iter(&out, len, &sopt->iter_out) != len)
 		return -EFAULT;
 
 	return 0;
@@ -2396,15 +2409,14 @@ int tcp_ao_set_repair(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	return 0;
 }
 
-int tcp_ao_get_repair(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+int tcp_ao_get_repair(struct sock *sk, sockopt_t *sopt)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_ao_repair opt;
 	struct tcp_ao_info *ao;
 	int len;
 
-	if (copy_from_sockptr(&len, optlen, sizeof(int)))
-		return -EFAULT;
+	len = sopt->optlen;
 
 	if (len <= 0)
 		return -EINVAL;
@@ -2425,7 +2437,8 @@ int tcp_ao_get_repair(struct sock *sk, sockptr_t optval, sockptr_t optlen)
 	opt.rcv_sne	= READ_ONCE(ao->rcv_sne);
 	rcu_read_unlock();
 
-	if (copy_to_sockptr(optval, &opt, min_t(int, len, sizeof(opt))))
+	len = min_t(int, len, sizeof(opt));
+	if (copy_to_iter(&opt, len, &sopt->iter_out) != len)
 		return -EFAULT;
 	return 0;
 }

-- 
2.53.0-Meta

