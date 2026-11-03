Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704014;
	b=dElgxYDYqxoHFFNX6hsuLM55ERUUe5QerenRmm/UgbyKBhPuOoWBMkRuhq6guReRpttl
	 wNED+QW/W5sYKhen6/Sbdycsag8km67U6g8KDBUaeQCZmpKhKumenb98oSIiojUzLVk9/
	 LjbQ0tnNaXToaSMcO8XV+XPbNjCy3xjuyVuwb/wLQOwhSaEWXYouzJDaKRoiKz1E7gyYz
	 317lUZjLdFM2MkanxttGiveAGIYgW7+ZI+GHsXtFcwB8L1OML0+x52FS0V5CsZav/hQhQ
	 LJw65z1dTa9mEmWn0voP2ABr34x5UEechvFS7zIdghe2m9o9geXaNu2r+Zs6jNYWF3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704014;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=SK0wWTKnBn72BBWDJ2oYBdwcfSNoVd/Z5coEK9oB0VA=;
	b=YGvsTWVoXxMvrYyiLpGQP9EdZWt15PERFrPqmq5/pRw0WAw9P/NNfHislMSBKUwihQkP
	 frUVgsEv5+uWHgCdUrCHDZe32kkW8UEHY4HzKS3Pu8OGElHxQIBvvTqhEVCF1V2HuGqZT
	 TktaJ/0DZXtWdLqojzFw6XrqqEN6r0xvMIHMcPG7L6gmmUhSAt+ErTD5OvIk06q1qCxcm
	 gONRNggrw8mzxO9qtdXMmjLbFIZtHn8BVhEfAgW2La3P16F9YrTxhOqOS+Bh0emsGyICF
	 DSlt8XcIpMoOiR29Gf2zlxTyujZT2eaPDWDH+eI6GdV23z/kTbl9s554ByMQ7h88ncQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Ld5NZrtK;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB8C606C5B7;
	Tue,  3 Nov 2026 11:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB8C606C5B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Ld5NZrtK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=SK0wWTKnBn72BBWDJ2oYBdwcfSNoVd/Z5coEK9oB0VA=; b=Ld5NZrtK/fHVovrHoH23ul9N6F
	Z2JO4ZUve+9/9wYHlcRQpVcy6qOY2N/CxulIvLhqt/sxVOjYRabNmd8UMxJnyalgfjeIsZMZjbUXk
	zSoCGc8MEobhtlPhscOrrQ2Kqtf2oU0dyhIqHUr7FKlBY/n3dYv8VcNwBh/jDE+NzuFYpm2SGKiFM
	o7QP77QkJGu4oIvccz1+4K1/AnG3IwTfNaU1G3M5TsryVfPii+ImqzaSNGpxD5AN3vn9LiZIROOwj
	U3tGrvM296OsX4cjyLLDx9zRn3nk+9ZG5kxixex31Xfx6FXTDpfPo079qEQUzQNSHRtAjaRmoPT5X
	uk58iPkQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOCLo-006tD2-1h;
	Tue, 03 Nov 2026 11:06:48 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 03 Nov 2026 03:01:02 -0800
Subject: [PATCH net-next v4 3/7] ipv6: mcast: convert ip6_mc_msfget() to
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
Message-Id: <20261103-sockopt_expand_out_v2-v4-3-2d36da923578@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7895; i=leitao@debian.org;
 h=from:subject:message-id; bh=0XpX94xyVX2xU7DbWAGAPPiwsfvDVkcFpTpHF7iGo8A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6cAvb+QLKeP9HLWTfBrcJamuOrjshWZpDEhjc
 Qb8aTNDv2mJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaunALwAKCRA1o5Of/Hh3
 bYhVD/9+JBlfNy7DAd7wht7XXK3P7y1wFKVLXyuOsedO+SHypu19nq9GJjesg0csb+U5PxVcr7d
 +apIG++LtGvjLegi9q7WbqTpD0O00Dw9iXXrbp73Kc4fNThquT8eaUwN1xnkByP9dGQdl6ry6JX
 vhwfEbCsEuWDMYU+FuaOA4qpzF7cdrtM0X/cyE3dkLgDgcHToMbFuq5o/eyQSV5S0b6vAB1snsl
 fVV864uX2aAL3aXw5W1JHo0drOj3It7umY/EERxxZe9IgKjTXFjGOrem9mDLf1jaAnE7JVNISOC
 /Ztu9NUK9AaHoK04+U5KWWXk+zLBj8eGBOv1KGtIoT3rTZeO+/TL7dQGsAlNIxJTMUfqy9axGei
 kdaUOvcrt0kIrBEmRQvkQl7LQOc0oGrmD3gVRgJ0c2TO7VsCkCaVybp8UUKriwZsjyIrrYUy9bN
 BL66Y15Jze97Vt/HRrYGe/AYvDlhD0/cbTwPhHcbVxNqhafbcKqpVfRdaZLap/kXlBJjN0sBJXP
 8AVqNEi0OFhi4saLn2HDIcvqIT4oEHCPuYJtR7BIvE7Azub8UR1tDv262ysabuW6R0oe/86jF1Z
 Ug96+gkPD1bE97RMs1V/2oOzDHZK/c6l13+g6kHQaNIvh95ottu8XsiWNU/eB6XNSH+/PuSmyrK
 MiD38BfLd+iUoIg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

MCAST_MSFILTER reads its reply through ip6_mc_msfget(), reached from
do_ipv6_getsockopt() and from nowhere else. Convert it, and build the
sockopt_t at the call site for as long as the caller still carries a
sockptr_t pair.

optlen only has to cover the fixed part, and the real reply size comes
from the gf_numsrc field inside it. Userspace relies on that, so
sockopt_expand_out() grows optval past optlen, for a user address only
and only far enough for the sources the socket has.

ip6_mc_msfget() now advances over the fixed part and writes the source
list through iter_out. Its callers rewind by the reply length they
already compute, which is exactly what the callee consumed, and land
back where they used to write: offset 0 for the native reply, gf_fmode
for the compat one.

ipv6_get_msfilter() and compat_ipv6_get_msfilter() only store *optlen
after their own copy succeeds, so a copy failure can't report a
changed length: -EINVAL, -EADDRNOTAVAIL and -EFAULT all leave the
caller's optlen word unchanged.

The old code stored *optlen before writing the fixed part, so an
unwritable optlen word stopped the fixed part from being written. Now
the fixed part is written first.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/ipv6.h       |  2 +-
 net/ipv6/ipv6_sockglue.c | 64 ++++++++++++++++++++++++++++++++----------------
 net/ipv6/mcast.c         | 19 +++++++++++---
 3 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 3de07e738538f7..9bb68d75890364 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1195,7 +1195,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 		  struct sockaddr_storage *list);
 int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
-		  sockptr_t optval, size_t ss_offset);
+		  sockopt_t *opt, size_t ss_offset);
 
 #ifdef CONFIG_PROC_FS
 int ac6_proc_init(struct net *net);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 700133e2fd11c2..433b25c860d81b 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -922,48 +922,52 @@ static int ipv6_getsockopt_sticky(struct sock *sk, struct ipv6_txoptions *opt,
 	return len;
 }
 
-static int ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
-			     sockptr_t optlen, int len)
+static int ipv6_get_msfilter(struct sock *sk, sockopt_t *opt)
 {
 	const int size0 = offsetof(struct group_filter, gf_slist_flex);
 	struct group_filter gsf;
-	int num;
+	int num, len;
 	int err;
 
-	if (len < size0)
+	if (opt->optlen < size0)
 		return -EINVAL;
-	if (copy_from_sockptr(&gsf, optval, size0))
+	if (copy_from_iter(&gsf, size0, &opt->iter_in) != size0)
 		return -EFAULT;
 	if (gsf.gf_group.ss_family != AF_INET6)
 		return -EADDRNOTAVAIL;
 	num = gsf.gf_numsrc;
 	sockopt_lock_sock(sk);
-	err = ip6_mc_msfget(sk, &gsf, optval, size0);
+	err = ip6_mc_msfget(sk, &gsf, opt, size0);
 	if (!err) {
 		if (num > gsf.gf_numsrc)
 			num = gsf.gf_numsrc;
 		len = GROUP_FILTER_SIZE(num);
-		if (copy_to_sockptr(optlen, &len, sizeof(int)) ||
-		    copy_to_sockptr(optval, &gsf, size0))
+
+		/* ip6_mc_msfget() consumed the whole reply; rewind to the
+		 * fixed part.
+		 */
+		iov_iter_revert(&opt->iter_out, len);
+		if (copy_to_iter(&gsf, size0, &opt->iter_out) != size0)
 			err = -EFAULT;
+		else
+			opt->optlen = len;
 	}
 	sockopt_release_sock(sk);
 	return err;
 }
 
-static int compat_ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
-				    sockptr_t optlen, int len)
+static int compat_ipv6_get_msfilter(struct sock *sk, sockopt_t *opt)
 {
 	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
 	struct compat_group_filter gf32;
 	struct group_filter gf;
 	int err;
-	int num;
+	int num, len;
 
-	if (len < size0)
+	if (opt->optlen < size0)
 		return -EINVAL;
 
-	if (copy_from_sockptr(&gf32, optval, size0))
+	if (copy_from_iter(&gf32, size0, &opt->iter_in) != size0)
 		return -EFAULT;
 	gf.gf_interface = gf32.gf_interface;
 	gf.gf_fmode = gf32.gf_fmode;
@@ -974,19 +978,23 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
 		return -EADDRNOTAVAIL;
 
 	sockopt_lock_sock(sk);
-	err = ip6_mc_msfget(sk, &gf, optval, size0);
+	err = ip6_mc_msfget(sk, &gf, opt, size0);
 	sockopt_release_sock(sk);
 	if (err)
 		return err;
 	if (num > gf.gf_numsrc)
 		num = gf.gf_numsrc;
 	len = GROUP_FILTER_SIZE(num) - (sizeof(gf)-sizeof(gf32));
-	if (copy_to_sockptr(optlen, &len, sizeof(int)) ||
-	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter, gf_fmode),
-				   &gf.gf_fmode, sizeof(gf32.gf_fmode)) ||
-	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter, gf_numsrc),
-				   &gf.gf_numsrc, sizeof(gf32.gf_numsrc)))
+
+	/* Rewind to gf_fmode, which gf_numsrc follows. */
+	iov_iter_revert(&opt->iter_out,
+			len - offsetof(struct compat_group_filter, gf_fmode));
+	if (copy_to_iter(&gf.gf_fmode, sizeof(gf32.gf_fmode),
+			 &opt->iter_out) != sizeof(gf32.gf_fmode) ||
+	    copy_to_iter(&gf.gf_numsrc, sizeof(gf32.gf_numsrc),
+			 &opt->iter_out) != sizeof(gf32.gf_numsrc))
 		return -EFAULT;
+	opt->optlen = len;
 	return 0;
 }
 
@@ -1009,9 +1017,23 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		len = 4;
 	switch (optname) {
 	case MCAST_MSFILTER:
+	{
+		struct kvec kvec;
+		sockopt_t opt;
+		int err;
+
+		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
+		if (err)
+			return err;
+
 		if (in_compat_syscall())
-			return compat_ipv6_get_msfilter(sk, optval, optlen, len);
-		return ipv6_get_msfilter(sk, optval, optlen, len);
+			err = compat_ipv6_get_msfilter(sk, &opt);
+		else
+			err = ipv6_get_msfilter(sk, &opt);
+		if (!err && copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
+			err = -EFAULT;
+		return err;
+	}
 	case IPV6_2292PKTOPTIONS:
 	{
 		struct msghdr msg;
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index ecef55f261890c..4ca2d77811f4eb 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -600,14 +600,14 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 }
 
 int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
-		  sockptr_t optval, size_t ss_offset)
+		  sockopt_t *opt, size_t ss_offset)
 {
 	struct ipv6_pinfo *inet6 = inet6_sk(sk);
 	const struct in6_addr *group;
 	struct ipv6_mc_socklist *pmc;
 	struct ip6_sf_socklist *psl;
+	int i, copycount, err;
 	unsigned int count;
-	int i, copycount;
 
 	group = &((struct sockaddr_in6 *)&gsf->gf_group)->sin6_addr;
 
@@ -629,6 +629,18 @@ int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
 
 	copycount = min(count, gsf->gf_numsrc);
 	gsf->gf_numsrc = count;
+
+	/* The source list is sized by the gf_numsrc the caller left in optval,
+	 * not by optlen, which only has to cover the fixed part.
+	 */
+	err = sockopt_expand_out(opt, ss_offset +
+				 copycount * sizeof(struct sockaddr_storage));
+	if (err)
+		return err;
+
+	/* The caller fills the fixed part in once it knows gf_numsrc. */
+	iov_iter_advance(&opt->iter_out, ss_offset);
+
 	for (i = 0; i < copycount; i++) {
 		struct sockaddr_in6 *psin6;
 		struct sockaddr_storage ss;
@@ -637,9 +649,8 @@ int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
 		memset(&ss, 0, sizeof(ss));
 		psin6->sin6_family = AF_INET6;
 		psin6->sin6_addr = psl->sl_addr[i];
-		if (copy_to_sockptr_offset(optval, ss_offset, &ss, sizeof(ss)))
+		if (copy_to_iter(&ss, sizeof(ss), &opt->iter_out) != sizeof(ss))
 			return -EFAULT;
-		ss_offset += sizeof(ss);
 	}
 	return 0;
 }

-- 
2.53.0-Meta

