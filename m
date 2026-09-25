Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D464DF4D0;
	Fri, 25 Sep 2026 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351771; cv=none; b=B6jBZGTx8PWrD/GDRL9RhU2DKSYgzz8340l2q+uS8ZNDfS/7IXuHeFuUO1xPs9m9gLKcO+L82004wR4ENuCi9kI4uzqltZwBE/PI48Z6Xv6Nta5v8KhM+fS7JgYMVdFE18jfExXZw3LZWZXww9Q3QX+ZmsoSnK48F3HiAYuy4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351771; c=relaxed/simple;
	bh=8zhUGCE3YkFXyJkHjnG8/S7o8UJggLrTZKx87kd9A30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sCHVmPBj4uafy9fzML+lTLhfaKFZK5sAPRP7oD6pjZW4AzrmEVt3LCpXg5YgbRtG3GMeEA4Sb/dUfMmvhBVRI1FO67dwof0kY6IwjIlDtezDPn4uO64RtuYNb/DSJsKb+q5tPD4+4KMSt3QvxKjBQCUH5bynjqzriGjp42pr+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=taVUHIFu; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="taVUHIFu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=w2gPInNEhbYbc8d2YUyDFXGcxVtrALEK3yUZaaqdEEM=; b=taVUHIFuT6mxeUrk6tYuYnZd+2
	sNozoBfYftInQE5xe6BCsARjL32R/cctVRbtD0ku0sbEH6/4ql9U9H1NzjFx6lM8G2DD2msyYCtQX
	PgsDN0JgBM0b9GCDvcxNdoEvxDtOlIUV3t2tE0pQv0x8aFWqK0iD/YWajw2lTc3wK6S3gBUt7vDqs
	5vhB+RvwyxXV4LSOyizZdIpi58vCRtuYbu0Pb/dphrXWpzASQl6gZuXWRZrPvmd1WtAd+8BbYgKek
	axEEI9lVV0BvD52xjdhw+a51xlpuSJ9/2RKLm01pDKXc+cCdKZpwjvWS2KxdvsN2qrhL9QEHSDwAg
	K/QL3vtg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA8HM-005Plg-2U;
	Fri, 25 Sep 2026 15:56:05 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 25 Sep 2026 08:55:18 -0700
Subject: [PATCH net-next 3/6] ipv4: igmp: convert ip_mc_gsfget() to
 sockopt_t
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-sockopt_expand_out_v2-v1-3-c3ef2e3bb5c0@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7720; i=leitao@debian.org;
 h=from:subject:message-id; bh=8zhUGCE3YkFXyJkHjnG8/S7o8UJggLrTZKx87kd9A30=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqtpl6VjF2WTr7LnRDsEXVgRMWFudyEJxmmkYzK
 maE8UPPcUOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaraZegAKCRA1o5Of/Hh3
 bVKpD/4kmPIgIKS/NDzh2BOlksQkT1m5GU/UZjrDgUYQmaPRhu276GzoLk1w69b19O9nj41wFE0
 FS1YdzVafVb19s4Rg6YwefUIo5VJrn+3PPbZXBworpSmyUTmxKYjJQYfDTtTIFWGbAPapu5nHjD
 0JW+e+dos2k+zi8GdbftbbqYoYppaiJ7ufwvidnv5qICQhscf0iQxINxnToB8ZqylZEZAiZC8eX
 Ks2TLm/qzdw2e5C3PVrbS+uWcjQfUDcg8c8LnD2VW2wfag/lCX1vYuvOkyeAp/LIvZ13If8NrCq
 9OcJGQQIwVEbaPYbwQYBlCeW2ZluAB/jOVaWVpxEs2LWAqdn3V5mFS/HXLLdfJBYyHEPIxFtTuv
 OJLczOKhBzsbModDYAEsVjBf4OnPpHLyyvRJQyFkqfIJPYigW9oof/o7X6qxw/OgEeLZ4Ny6dSR
 DriNasgH2gxZnGvPUFzUQaeXQkL0WSd88hzYKTDKQjzIWkJ6WLvR3ZG4DIIRGbFFrUGSchWVU3W
 dcj0knj6Lp1JO9FhTe6rLBzqOyKhn3z0j8Ce7Opv8eI62405s5l59jlbubiw4WkCm5YIYQIijha
 W/6d1E2AqjGXfHlLmfJk/f+w1hLrdwBKeL/rufi8i3/eTWbQcATOFS8Dhk+5/KQVrwmVuMf8ogy
 NWbM1NUDUZ9sXsQ==
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

The *optlen store moves out to the call site, guarded by !err so the
-EINVAL, -EADDRNOTAVAIL and -EFAULT returns still leave the caller's
optlen word untouched.

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
index e06c1f48ecad6e..1f452b6ea86e9d 100644
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
+	opt->optlen = gsf_size;
+
+	/* ip_mc_gsfget() consumed the whole reply; rewind to the fixed part. */
+	iov_iter_revert(&opt->iter_out, gsf_size);
+	if (copy_to_iter(&gsf, size0, &opt->iter_out) != size0)
 		return -EFAULT;
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
@@ -1488,18 +1489,22 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
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

