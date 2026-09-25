Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A645F4DD3B8;
	Fri, 25 Sep 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351765; cv=none; b=CLO1+JmoAcDJbSaPiMSHnLBR/YRoZB4uZG1KIHg3cQpoWnjXlVtu4GSwWDIgJLGttxS/wEDMMY0pesDU0gjtmRf+7Hhfj2S/XFfs5tsx3cCSN3HUAT2Gu1gPnUQw9vS0Ti7M45IDdHTs3ls3GWW5aJhfBcteH9QEnOQuN62Ypn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351765; c=relaxed/simple;
	bh=BjZ++SUYoQm2n1DaeG7Bw9nwVyZs2jG15b14CFSgcTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sw/XXgSGfslwQQB2hGS5Q+dfa3TkNCyqMaAUtLuGENUM6Of2tOFXK9jbQO8Y5bZrXeT+DUqkMYdXcLMp6OM7FReMtyKXgGvNYU2WFpc2INfg6A0O9F04PSV5UkcZtrm9t+p83mg5wu49pT+2a5M3mJ9KYLmQIjjxANd4j4LF/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=oKbMDPZn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="oKbMDPZn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=6OrO8WKkdYKUocZdJ49o6ccAH+3u2HMdZnA+MR7Axd8=; b=oKbMDPZnZB0flpKudGaETP0N7J
	JcLK+GtaJVlV0PwYCuTY6Ak2F7TN6/M00NXfWFnMiyPYp1vbWt+J03w+ZNKx2A3FBIGjx5hkWNWZ0
	EmIPbuvSaaJHaOAPHbSJeu8zRbS/FEiUGOKWM2me0IgxJXwZw+9IwxgkOCX2Wofc6mL/x0cxgjFLZ
	9yPsgC07z8e1q2b9nfhB8mV2Uyyo/EDBFzHSFCF8dh8hDrdaWJm1TAbXViQCbHBOMn36NBMKtNLKJ
	6CozfCHUuiVbM/nS04PytPM0skavRdXhmuDdb0ilLuC6men6LyPqffRWhdWsSTYbijUBZxngDknya
	MLj/MSmg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA8HG-005PlO-1T;
	Fri, 25 Sep 2026 15:55:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 25 Sep 2026 08:55:17 -0700
Subject: [PATCH net-next 2/6] ipv6: mcast: convert ip6_mc_msfget() to
 sockopt_t
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-sockopt_expand_out_v2-v1-2-c3ef2e3bb5c0@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7553; i=leitao@debian.org;
 h=from:subject:message-id; bh=BjZ++SUYoQm2n1DaeG7Bw9nwVyZs2jG15b14CFSgcTQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqtpl68NVmdVHggiH9tBPL4n2nSu9nQknCbXFGT
 sEXxG3jelyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaraZegAKCRA1o5Of/Hh3
 bT9qD/0eLkvtoHRKgyMVuNzxQbsgy5MonaczaAsLP1JIb7bEryyv0GhttCD0vYZ6ld+3t4g4SI4
 KHI0aarJ/Oo9Ywt5wNlj/pkIcASkZ1tUQR3mixwLTd09D04VnTmpvtaghqhSyLc6jBs5MLfjIB5
 YrAXaBvtMpj2KYrPXBs+1b45Pcj/tIMwgwjHQW6T0qT4dvCxxqY06Wr/3EU6YFw6w02t6wHoBsz
 U2FvTAggIe2cCFjVo/A7m5gczUEo/b4A3oxu73ftnU0ei1Uy3G5fAIbc2Jyb+CPHGQknD6dKqU6
 qrdSR6l4Fh3U5vyM0lWTIvFic0C4J4hf9cIPjBo56vqAA79EisPZPSltPaQ5RTU22n5afhgitXz
 Ww6ZjTzhduLRwS5gDHMUkEe4/kC+3tBSkzx6PGuM6PjcwJd2HYkxgq+Is+Q4w7MtwCr4giZ0zIH
 hMb8q/gGUplQjGG5pmDgs4sklpncBsHEJm0vU25zOZC0aodGz5X1cf3rGFZ39ge400jgqXucSzA
 Qzaz2N7/GqFzLLKBKEQ3XIZIhpY8XTfU6bY3oJfg7uN3PKNS7NzexUP2Osb9AMbjZ2HMu3RQ9aF
 +1nHoG+mLcDodvDvgDCRywNyS0faHR2EZ4KR8Dym6bBjmCUgGQnOadcb43qb6VgDc46XIlNIiNe
 e8+gLdiyJUDwerA==
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

The *optlen store moves out to the call site, guarded by !err so the
-EINVAL, -EADDRNOTAVAIL and -EFAULT returns still leave the caller's
optlen word untouched.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/ipv6.h       |  2 +-
 net/ipv6/ipv6_sockglue.c | 63 ++++++++++++++++++++++++++++++++----------------
 net/ipv6/mcast.c         | 19 ++++++++++++---
 3 files changed, 58 insertions(+), 26 deletions(-)

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
index 5c6a0819a2aaff..1bdb3e001e4fe6 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -922,48 +922,51 @@ static int ipv6_getsockopt_sticky(struct sock *sk, struct ipv6_txoptions *opt,
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
+		opt->optlen = len;
+
+		/* ip6_mc_msfget() consumed the whole reply; rewind to the
+		 * fixed part.
+		 */
+		iov_iter_revert(&opt->iter_out, len);
+		if (copy_to_iter(&gsf, size0, &opt->iter_out) != size0)
 			err = -EFAULT;
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
@@ -974,18 +977,22 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
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
+	opt->optlen = len;
+
+	/* Rewind to gf_fmode, which gf_numsrc follows. */
+	iov_iter_revert(&opt->iter_out,
+			len - offsetof(struct compat_group_filter, gf_fmode));
+	if (copy_to_iter(&gf.gf_fmode, sizeof(gf32.gf_fmode),
+			 &opt->iter_out) != sizeof(gf32.gf_fmode) ||
+	    copy_to_iter(&gf.gf_numsrc, sizeof(gf32.gf_numsrc),
+			 &opt->iter_out) != sizeof(gf32.gf_numsrc))
 		return -EFAULT;
 	return 0;
 }
@@ -1006,9 +1013,23 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		return -EINVAL;
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

