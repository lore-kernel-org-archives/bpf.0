Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAC42E8DC;
	Thu, 15 Oct 2026 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058758; cv=none; b=EWcn9WAtGgd0/zcnlLy42WtMEqQHYeY6QzjiTnzJQgxrIMyvD6zEl79hevKJGpdJ1u0Uzxn337jTWn6idZs4IW+jbO594n5YYQ7XVJrlWBSOdpUgLJLEWlr28+n+i1SWWdtReChVLar5xbM1p3tdF2Sc+rot+NhzCAJ9jwb+aoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058758; c=relaxed/simple;
	bh=Ab/tK1Z4TLk/dIwm7xnf+BsJbup/XQpBqmam9wbS4AE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVPuCtCTftHUBH4EyAJo5fqukhPDDyc6JsgzGxufVDFZapaliAc9TD18oQFFwvikc0zWRqUTMCcLIFXLho6blfVyShIzB5QjE+1DUJ3JD5x5EdEaCz3RY3fL3WORn9IbozKzjEkoS6a4rtutqITNpgGCZ6c4G8sIZP0FOzTGERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Y+z00THC; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Y+z00THC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Q79JpLj96QE6hpuovBO29fD/uYFny8JBrGRCxNuE+hE=; b=Y+z00THCQybJW6l2eGw7c+bhBr
	YVR6V3yj0y9arbjlxlaGSR1sC6iUgjzfpZFITlKJ2Emy3c9n7eUq2zTS+JYe15WysVomOPb9d2BH6
	ABs7xyDFQ+SzYNwGZUOHHVnqerN3G0Q81VIHDnkXXHNCZjP6gW0WQPlyrFjYl39vnhDxLBgVzPWXa
	PxqpnjNo1WyhAKe91S+OvEnWV7lRyAnpeCTm4bPMMaAzsw+5zB0BMxwBv3Red/MnkvBUO5/fLbrVG
	utKPAS/1I+A7aL1Pt7MJSOmqtuSPDsG0S5Bmsbl/P+q3GXtR24Zw3oR2iEUi19SGRJ3W6o/mrq4qE
	yP9cbPVg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHILS-0057B5-1e;
	Thu, 15 Oct 2026 10:05:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Oct 2026 03:05:30 -0700
Subject: [PATCH net-next v3 1/7] ipv6: treat a negative optlen as 4 in
 do_ipv6_getsockopt()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sockopt_expand_out_v2-v3-1-7d05ef2df448@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2399; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ab/tK1Z4TLk/dIwm7xnf+BsJbup/XQpBqmam9wbS4AE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq0KV0CaPKCXgInCQ5BDR++tML+tOHvVcOm8LR+
 373q9/JFAqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCatCldAAKCRA1o5Of/Hh3
 bagnD/4okayDqFRgTAVXdkU8f3wEee1bfYikRYjAV/mKUYozZ8wyBo/5yFZCzDeM20achARDPoG
 AlqbVBfqHQe67N9ekwZRqMsCZlndOMA2YbXhrPf156NE0SCX8UqX71bycO3wDZbFv5Sj15OMV7g
 XKpbFRnjwBj84TLSFzS7OXOzMXsLBtTCsIPWNP3A9W5S/2BeV19GO46kj4pfv83+gkBWICLvEAP
 RxF9h95H6QikZQFZg5USY161bBNoVjBgd4uuPLDYfR/fl+MpI9nGZYAWFoLEBTZFf+wY5Djzl1R
 UPtyJI1lPTOvt1U8A83p7km8OQvfTqLBxZS1Ztrsx3rOuSGt8ILrX6XsCV16mD8EayTMQuLyN2i
 pRh5Dl5q3d+WbN4MO0qmbY6+GdDWVOZpcP8dRjQjrUIUu8nQgqDrNnXk3CfnZ8lwLkjZOFTUk5i
 gknu+u10bgprGzFaZXasEUEkWRvXtQzwNuxxWPyZTjNMUjHIr9rEJAnJamj1hhg8/Gpdu51itvj
 6OVi/Xe3IRjoWKjFRPddKpDmnKc4xLc69PRQCYXEKLkCSMOBWNdgzfnv/8sSqEpCudVt5fimVH6
 U3DC2VlhDb6KmsexdERMq7nb3WVBZeF/gsyueJMGitul1StIAaL68pI+9l/WFy61pXwYj0UfPnH
 zGdtG7OeeUalsSw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

do_ipv6_getsockopt() reads optlen into an int and never checks its
sign. Most of what consumes len compares it as unsigned, so a negative
optlen reads as a huge buffer, and the reply depends on the option.

The int options clamp it to their own size:

	len = min_t(unsigned int, sizeof(int), len);

so getsockopt(fd, SOL_IPV6, IPV6_TCLASS, buf, &len) with len set to -1
answers 4 bytes and reports 4, rather than failing.

The other options see a huge buffer. The sticky options reply with
their whole header, IPV6_2292PKTOPTIONS writes every pending control
message without a limit, and IPV6_PATHMTU and IPV6_FLOWLABEL_MGR pass
their length check.

do_ip_getsockopt() rejects a negative optlen, but doing that here would
turn a call that works today into an error for a caller that passes an
uninitialized length. Answer it as 4, as the int options do, for every
option this function handles itself.

That leaves the int options as they are. The sticky headers are cut to
4 bytes, IPV6_2292PKTOPTIONS gets a 4 byte control buffer, and
IPV6_PATHMTU and IPV6_FLOWLABEL_MGR fail with -EINVAL, as they do for
any other undersized buffer.

MRT6_* is dispatched earlier and keeps rejecting a negative optlen, and
the netfilter fallback still sees the caller's value.

This changes what callers that pass a negative length see. It is a
behaviour change, not a fix, so there is no Fixes: tag.

The conversion of this function to sockopt_t builds its buffers from
optlen, which the standard helpers reject when negative, so the answer
has to be settled before that.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/ipv6_sockglue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 4b3536571c9804..700133e2fd11c2 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1002,6 +1002,11 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
+	/* Historic bug compatibility: take a negative optlen as 4, as the
+	 * int options always did.
+	 */
+	if (len < 0)
+		len = 4;
 	switch (optname) {
 	case MCAST_MSFILTER:
 		if (in_compat_syscall())

-- 
2.53.0-Meta

