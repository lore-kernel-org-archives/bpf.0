Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55686519DFB;
	Thu, 15 Oct 2026 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058776; cv=none; b=geTh1zzyzsp994la3HyEF8gumRVfps75Fd4vYmc95GdtZX216NkZhTgdrm63DkgMlD/cZbBD+CaVh//KrItrMMSMvgyMJq8Nla1Ol7O7e+3yv194+Zkac5REnUR12RFyRv8C8vp368LKmbVSMqg22xnAzr3QRf05Usi92Y0q1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058776; c=relaxed/simple;
	bh=jZvIF6Um7hdspDLmuKHLMsPfspQuFqojdqrOiZVmQ6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3WtnB3HLUMGhZvZx87V84jydsN7hpT6UPZEtIuiAaokKMJUvBvMh83eNo1bgZgGMBmnPUGe894mfgc+5IWjawEtPFdSVpX76Wta+1HVdJawZT+30hsQFuZw6qsvmbgbQbpCNrZcdpkn9t3m/g7uc1M1CmHuMMJrrpkMmWTKUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=G006Eq7m; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="G006Eq7m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=xLpiKoXJyj8JNjwHTlllc2VGnMmWrXdHmGo07ZS732c=; b=G006Eq7mxwNtgdCz94owHlmkP5
	djbsOuKRBvnAiuKbmaRGGOSfkAaU75+HaOvoBTXtu8Xn3exUO9H5+5PzD04uWKZIn4uRRqR2zq+cx
	LZ9f/yX004UayxMkd/3Dk4WDcypLVG/wft5wRlGYsBvLnmO3leIXjiC3sVRynk/ILC/kY/+8S8u30
	DAZMiziH2X3hreTv50X0cYjryU/tHIdmYtEeRCklq75WOGbH50aUuyCWncqa8/mOo8pLSi3LXpHTu
	nC+1jT+nqGjv7+vt0c590K6A6RKstf1XSKKzc1IiiHkPGggRDONVjDFb4/bvq+bghLxDRor4tObdT
	cW8muCUA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHILk-0057Bo-0p;
	Thu, 15 Oct 2026 10:06:12 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Oct 2026 03:05:33 -0700
Subject: [PATCH net-next v3 4/7] ipv4: igmp: convert ip_mc_gsfget() to
 sockopt_t
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sockopt_expand_out_v2-v3-4-7d05ef2df448@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8024; i=leitao@debian.org;
 h=from:subject:message-id; bh=jZvIF6Um7hdspDLmuKHLMsPfspQuFqojdqrOiZVmQ6g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq0KV0euBs1oj7uVqNHZI/G628B8j2mAbajWm84
 dgWYrljDdOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCatCldAAKCRA1o5Of/Hh3
 bVwHD/4hzEOtHaMw1vsFmdKcMvDkbDYGlaf9MzPmcKA9NLkze/OdtNeotpr5dta65rLG8fWyk84
 1NsbFkxu4EKdc+BgXnWSIxdmsFmQCdPKpmOLvqLRreSFiVEl4Xv9jnEWmR2v10LqDO/p4D8032u
 cVrPydj9pfho79OIOXLnXEW4+kWQwikIl1nLABHOP9EUigII1U8XQLsf+eUpBXl7INaAFQPyIqP
 y+pdCo45lmTKeB8hAbSIkV1OgldxuGT9HzKPtwhEOhGcmEFyQwHpEgg1ELDWH+qhBk1fRfNsuTm
 AcCzeSwwMyhUAyA0o36KLzqNQvbnLqc3SSVNyWblX2x81q7CuS68Ljrbv3IpQtRWgNhP9rafjyb
 itzGkjQUQatf9iXw9BuxrZ3ZedjcpoE9j6difZZDtl3U3vEH73jsLj5T+LYIPuNSsRXOoybGXHE
 m2WOF7NbMXjAu/IkgrYQNdhJlHbxbtiXBAxPzUfIF7mrg5nLByZjmscJZii7qQ+TRqhe417i9ux
 ZbaIk+VqiyspBJU3eNAGCjcu/N8EHxlqCIK1BwBB3xd7aos9EO/eLH7CqfF5zmYXTEZ6VepIc+A
 Gy+EwzA/7+Dww3QsOUSRmMMl9SqhKTdaL0IgcG+8JY+nzv8KqWW7U69X2HjuiOM8waOF/rwuMH3
 QRskQV+Oq0KcarQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

MCAST_MSFILTER reads its reply through ip_mc_gsfget(), reached from
do_ip_getsockopt() and from nowhere else. Convert it the same way as
the ipv6 side, and build the sockopt_t at the call site for as long as
the caller still carries a sockptr_t pair.

optlen here only has to cover the fixed part, and the real reply size
comes from the gf_numsrc field inside it. This is nasty, but userspace
relies on it, so sockopt_expand_out() preserves the same mechanism: it
grows optval only for a user address, and only far enough for the
sources the socket has.

ip_mc_gsfget() writes the source list, and its two callers write the
fixed part afterwards, at the head of optval. iter_out only moves
forward, so the callee advances over the fixed part rather than
addressing each source by offset.

The callers then rewind. The reply length they already compute is
exactly what the callee consumed, ss_offset plus the sources it wrote,
so both land back where they used to write: offset 0 for the native
reply, gf_fmode for the compat one. The bytes are the same.

ip_get_mcast_msfilter() and compat_ip_get_mcast_msfilter() only store
*optlen after their own copy succeeds, so a copy failure can't report
a changed length: -EINVAL, -EADDRNOTAVAIL and -EFAULT all leave the
caller's optlen word unchanged.

The old code stored *optlen before writing the fixed part, so an
unwritable optlen word stopped the fixed part from being written. Now
the fixed part is written first.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/igmp.h   |  2 +-
 net/ipv4/igmp.c        | 20 +++++++++++++-----
 net/ipv4/ip_sockglue.c | 57 +++++++++++++++++++++++++++++++-------------------
 3 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index e075611344ef3b..0a1abf3552d2bb 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -276,7 +276,7 @@ extern int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf,int ifindex);
 extern int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
 			sockopt_t *opt);
 extern int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
-			sockptr_t optval, size_t offset);
+			sockopt_t *opt, size_t offset);
 extern int ip_mc_sf_allow(const struct sock *sk, __be32 local, __be32 rmt,
 			  int dif, int sdif);
 extern void ip_mc_init_dev(struct in_device *);
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 144fca158adcb0..d573c5bf8f038b 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2775,9 +2775,9 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf, sockopt_t *opt)
 }
 
 int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
-		 sockptr_t optval, size_t ss_offset)
+		 sockopt_t *opt, size_t ss_offset)
 {
-	int i, count, copycount;
+	int i, count, copycount, err;
 	struct sockaddr_in *psin;
 	__be32 addr;
 	struct ip_mc_socklist *pmc;
@@ -2805,6 +2805,18 @@ int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
 	count = psl ? psl->sl_count : 0;
 	copycount = count < gsf->gf_numsrc ? count : gsf->gf_numsrc;
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
 		struct sockaddr_storage ss;
 
@@ -2812,10 +2824,8 @@ int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
 		memset(&ss, 0, sizeof(ss));
 		psin->sin_family = AF_INET;
 		psin->sin_addr.s_addr = psl->sl_addr[i];
-		if (copy_to_sockptr_offset(optval, ss_offset,
-					   &ss, sizeof(ss)))
+		if (copy_to_iter(&ss, sizeof(ss), &opt->iter_out) != sizeof(ss))
 			return -EFAULT;
-		ss_offset += sizeof(ss);
 	}
 	return 0;
 }
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index e06c1f48ecad6e..1b7461f1569c32 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1442,45 +1442,46 @@ static bool getsockopt_needs_rtnl(int optname)
 	return false;
 }
 
-static int ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
-				 sockptr_t optlen, int len)
+static int ip_get_mcast_msfilter(struct sock *sk, sockopt_t *opt)
 {
 	const int size0 = offsetof(struct group_filter, gf_slist_flex);
 	struct group_filter gsf;
 	int num, gsf_size;
 	int err;
 
-	if (len < size0)
+	if (opt->optlen < size0)
 		return -EINVAL;
-	if (copy_from_sockptr(&gsf, optval, size0))
+	if (copy_from_iter(&gsf, size0, &opt->iter_in) != size0)
 		return -EFAULT;
 
 	num = gsf.gf_numsrc;
-	err = ip_mc_gsfget(sk, &gsf, optval,
+	err = ip_mc_gsfget(sk, &gsf, opt,
 			   offsetof(struct group_filter, gf_slist_flex));
 	if (err)
 		return err;
 	if (gsf.gf_numsrc < num)
 		num = gsf.gf_numsrc;
 	gsf_size = GROUP_FILTER_SIZE(num);
-	if (copy_to_sockptr(optlen, &gsf_size, sizeof(int)) ||
-	    copy_to_sockptr(optval, &gsf, size0))
+
+	/* ip_mc_gsfget() consumed the whole reply; rewind to the fixed part. */
+	iov_iter_revert(&opt->iter_out, gsf_size);
+	if (copy_to_iter(&gsf, size0, &opt->iter_out) != size0)
 		return -EFAULT;
+	opt->optlen = gsf_size;
 	return 0;
 }
 
-static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
-					sockptr_t optlen, int len)
+static int compat_ip_get_mcast_msfilter(struct sock *sk, sockopt_t *opt)
 {
 	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
 	struct compat_group_filter gf32;
 	struct group_filter gf;
-	int num;
+	int num, len;
 	int err;
 
-	if (len < size0)
+	if (opt->optlen < size0)
 		return -EINVAL;
-	if (copy_from_sockptr(&gf32, optval, size0))
+	if (copy_from_iter(&gf32, size0, &opt->iter_in) != size0)
 		return -EFAULT;
 
 	gf.gf_interface = gf32.gf_interface;
@@ -1488,19 +1489,23 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
 	num = gf.gf_numsrc = gf32.gf_numsrc;
 	gf.gf_group = gf32.gf_group;
 
-	err = ip_mc_gsfget(sk, &gf, optval,
+	err = ip_mc_gsfget(sk, &gf, opt,
 			   offsetof(struct compat_group_filter, gf_slist_flex));
 	if (err)
 		return err;
 	if (gf.gf_numsrc < num)
 		num = gf.gf_numsrc;
 	len = GROUP_FILTER_SIZE(num) - (sizeof(gf) - sizeof(gf32));
-	if (copy_to_sockptr(optlen, &len, sizeof(int)) ||
-	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter, gf_fmode),
-				   &gf.gf_fmode, sizeof(gf.gf_fmode)) ||
-	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter, gf_numsrc),
-				   &gf.gf_numsrc, sizeof(gf.gf_numsrc)))
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
 
@@ -1727,12 +1732,22 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		goto out;
 	}
 	case MCAST_MSFILTER:
+	{
+		struct kvec kvec;
+		sockopt_t opt;
+
+		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
+		if (err)
+			goto out;
+
 		if (in_compat_syscall())
-			err = compat_ip_get_mcast_msfilter(sk, optval, optlen,
-							   len);
+			err = compat_ip_get_mcast_msfilter(sk, &opt);
 		else
-			err = ip_get_mcast_msfilter(sk, optval, optlen, len);
+			err = ip_get_mcast_msfilter(sk, &opt);
+		if (!err && copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
+			err = -EFAULT;
 		goto out;
+	}
 	case IP_PROTOCOL:
 		val = inet_sk(sk)->inet_num;
 		break;

-- 
2.53.0-Meta

