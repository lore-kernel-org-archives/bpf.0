Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704019;
	b=gFa/SPUyxkhcDAphUIoirE17Ft5r6tAWniV8uG0J6YmXW5WLBQl4TE88bZwSxOKnjT2R
	 W+A2J17MNQLmZhVtyZudz/4zKikvPNygMKXYzNhGmF7XTHVzaTXELGLjHRrok51QjOBEk
	 H3YOPRSymwCKgjeStO7huPw37nZdC3m6KB88JZjqi7jucvBDJ0wMfDNBvGSrdQSqGz89Y
	 rUcmEoQakFzcROoF+baQCvg6iieoLWk0ZiVoVV1ApZQnoONeOT7YKMfAVsrOTutTI4nc+
	 kbQ7Tzd5/ul6U7Ryuh1CpgAONB6rzx9ejFNiergdftG3xaWh5VDdPxLqma7ipBqHU/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704019;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=sZ/2Mrd5kMftiWGZv98RnIslzdKjGRaNlwNpauUDkbQ=;
	b=JxqQ/K5b3kUp12pAwvaVVn8W1uZyEis477hFE5fNXoAzKbIiUcB0/QJN3om4AgTdTCN1
	 UJsl/5OGBRwXThhll6wedVIw7vMFVkN+CL89rEhOYz4kOoV9skiOd9VM7fSPGTUFa/NhD
	 DpydgPNDbAXsaOuTz/Jo6aXaughSdCagS8oBmlJYgu7Hi0YW3L5oAnDLTlCtFCAVUi3MI
	 1+ppzVbMKp2JB+IaFXiHBKWS8AkK58bJXATU/QZQtInZ1zh0fqyHa7khtUc4VVLAMlKUj
	 aiBSpuLU3KScKDDMzZwmZtvuaB+7Nqcp+Re1pKRcHl/IkuF+tltZAj4kU7mgG6LlWxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=aGieO8E7;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAC60700B5;
	Tue,  3 Nov 2026 11:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14BAC60700B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=aGieO8E7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=sZ/2Mrd5kMftiWGZv98RnIslzdKjGRaNlwNpauUDkbQ=; b=aGieO8E7eap26JWVF3Ie++NYt1
	3nbto6mgCBGfXGz/D8wMlI4DsakqBbmDQSo5Ir4AURG0mKHkl2nYSNKsUUypZRIZM6YEs1sP0ohVf
	T7DosSkHyZEoxeYtVrmgRq6/sUAlGhm0yC6njwLEeMRbU1EnayaML2GHa6PD1hyMAaVeoV+Xn8eV/
	w/E5Ewjq+TqijUyOskPq/ZdWvR5OYyrsXGanM/X9MjOrqpWZUegO7PmsUvz1QNgzi12f0B/GYyN/J
	Aw8NtQkBvjrm+DNdrGxDSY9u6CMugbt34MZKIVxwAxbN84x6ztWBGP9TPoRWHT/UbiRU+FcuQQDQ4
	0rM2xnLA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOCLv-006tDK-01;
	Tue, 03 Nov 2026 11:06:55 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 03 Nov 2026 03:01:03 -0800
Subject: [PATCH net-next v4 4/7] ipv4: igmp: convert ip_mc_gsfget() to
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
Message-Id: <20261103-sockopt_expand_out_v2-v4-4-2d36da923578@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8068; i=leitao@debian.org;
 h=from:subject:message-id; bh=zvHfyHBa22go6wmj3MNgd6pz4l+nA9UbPtlyA+zpzE8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6cAvhWoXija9fOWoLIkM7UoKqZoVa6inZij2u
 JFjeG4wBP6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaunALwAKCRA1o5Of/Hh3
 bVVjD/9XM0LLa8DXwiMyv7MfsidQ6cF6Xxiv1/RyZ6O58dGQbNkjCO36vUBAU6RuPcRNjcGZvcY
 lWHAg37S1KCxQYYNrUuUJxdk3kwj3l2dxgfbSjvOLrmVQczMI37R9RQLjTLBuSn1yLayUorB/+u
 K52G2fBMtzfUlygv43L7aMxRuz1f08xoDuLZ82GxR67uKa7gRTB/ZdpkFJSUJb12c/TtJ0GlL3N
 Lg8MO9zQHy45k+qcFE/rkZIJ8tJuIhYB1sjDsjOycNxk2fR6UsRMeC+ao+T2WDDGkLw3SwtEVTy
 h9v6kaJN/JJQUrKyO2lwB6lyaaL7EVEiEwe2u+K2GXPy8XmZ8DO8giDMySLfMFGqfccETC+CUoX
 DE/LE2qdGlJpNSKXQWjyLaXcOabFp6GIohhreNL1xRHlPjkrJhG8P3OL8MhXBxiiwJGanaGeXrf
 cx5+0Yul/3C2wfUIcFFJNN7Aqy7hvD48ht4MxU1s8DRjpsupMk70ztatZhUHR2pSysXtGDSk4pi
 xlNWJciwe2mmTCqFM/dSdR6Vbp+0lx1j+eqaQPpltb4gvsD53x6Zb01UIsEOQ6DTDbmQDNnP5es
 fjWsS/uOt+1HsVyS8CtN5BIaQs7rb6QnHxUXRwiou7T7EpkjzjMLCMRWAAupo32uBn0L5BUdKmN
 7khSBPgNuRezJ8A==
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
Acked-by: Ido Schimmel <idosch@nvidia.com>
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

