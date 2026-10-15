Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF350C2B4;
	Thu, 15 Oct 2026 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058770; cv=none; b=r/S0ZMhesASQu0lew5IwHY7Rj+FDY0WOMDh1PtTZHgDylu0tu2qKfP0e8ZVB77cNKTFvpUivzF9x+aMd8L9PFyz1GH3lYFtgc4SbwwDDJoc2KjKXS2jBYo8F5uM0VR/4WqIt0WZirAF13ckHplKgvQCe5WvfwqxGnS0VGUecxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058770; c=relaxed/simple;
	bh=g27oPNOG4Cx6eARtCFLFp4HlKkoS4WlY9EstK+Dabc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ds6VhditZcZfYLx2UiZG3PhofvmP7grbZmjjHnWKJfZiVmr6klilCmSGMdQA3WzPtdDaC7Bh3K0BRr91sU7ftqipJn+rXhZJfCjN5uCQaeH9uWKySmQ3RL6EmoZ1qXiHTPwf6jboUfvr7+ABr0MZ2vR6sJiQFmAbkH5g5TARwr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=lEZJCw/n; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="lEZJCw/n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Ca+LFH9SZchbL2VvMn1ZskSkxpdY+irc59QRwwBQxVI=; b=lEZJCw/n9hemQeKlJ5rvp0KTbw
	etrUDwrQocYOzkYKlc0WPiJXnF4ZXnBY2M1o39kSTs4fOM7LjE8Kq6h8tQMkq+1SiJRw+rWyC90x3
	dgoqZ/P0un8AgAGOGy3v1VZQbXGTDw3rVD1ExzdrgEqwOd6YsTUljoMWXtDhhC2HmTZ/O85KDyo+s
	b+2iBS3J+vQyVKlSSnLjLkMeHIkATxnKPauPwUKG0rBX5L0UuJlnWcTqptpL24xkqVILQAnpHf5k0
	Q+ze9hHvEXLlXsKWQCQovoNPSLvBSDFhus2uhem/ichrgY0NRfEw4/kkqsk4aq/2rNqSRTsrv0qal
	6hmBDu9A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHILe-0057BW-0p;
	Thu, 15 Oct 2026 10:06:06 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Oct 2026 03:05:32 -0700
Subject: [PATCH net-next v3 3/7] ipv6: mcast: convert ip6_mc_msfget() to
 sockopt_t
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sockopt_expand_out_v2-v3-3-7d05ef2df448@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7851; i=leitao@debian.org;
 h=from:subject:message-id; bh=g27oPNOG4Cx6eARtCFLFp4HlKkoS4WlY9EstK+Dabc0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq0KV0gDNkxIlPfkqId44rJOryGtxRXEr7sF5m9
 CvL/FXr9h+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCatCldAAKCRA1o5Of/Hh3
 baGvD/9wymu5WLlzL9MG6vrOM1BIBksa4qwqQWbPM3p3UxLAesHkB8b2jibc67KPaY/+52ldhKI
 iXxA2ngb3KmUoLqwoI7pSjKuooy490qbwyA4gMdg6kFRuIENBzkpNxSawHnueAkVDhoxdTNJVW3
 xGbJ6lN8/Pt0nncOhp6k+rN6+flTbO5z/l7qdecgU55mww7w38mV7JEGS0KM3pFlEJPB7foHWsa
 GARLMtfpy3IBDQYyTlz7glUxodBz5Z+nIhHfiYxUWqI6lEOwU+GS0x9TZKcQhRG8xqJQPGX3wLB
 ElHBk2DiZXgZv9kwsIRUBEQgBcM0k60BHLz/46o/AFm7zOJG0CUmQL+bFXVpHvNKuKO4hvwp3ry
 8MVuyDotanQHuFKBtV8RrKDfdU3LNNdE6kL5+RdhINEK0S8qWFunSoeokmJk0jW9V215vs5YQZ0
 Vg1orQLY1iTqXm1NeU8jsv05WVTmxRVFs3/LXA8tfdp+GBXS5E04AEnbjcKeOEf+qADcZFXTlhZ
 uKXBtpfPFasyjFaQuuVmQ9Q0A2+J1bDZrFwqzWzASQAXtmHGQjNBBg4CcBZ/74sVCoUlncnPDy/
 LUEgumcHZmu75y+G1jNhkJ17/NmZ8CSaZj/eXYYmAX/ybjVQyzEmlUAEaWXuPKB03UICUN+6re7
 jm8hM+RR4laxXLg==
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

