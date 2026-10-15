Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2294ED18A;
	Thu, 15 Oct 2026 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058755; cv=none; b=mNf1eFjhR60YUg317NHccdCx7xXZRuwl1bXYnnx9JKByd1dLJRUVvG+d/enmhp6dwdw/zpWNfNSThOHNbEA0ca7MkYfyi2k+Z2485g8O361zeGswy4gXjzydtDEVxgpjqNzmiUGnUSadGXAhoxqB9RPxUAdDtFIF/LlXaJRF95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058755; c=relaxed/simple;
	bh=RScIEV0hfbD2tBW5CXzHJowq1kQbypZEdCwsy1w6XV8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cIapqC0s9JCTadMFfbA26D5sNkAECr0cGLsa9xJHlnB1X+1rhOkJN8LMLeU+OkJBO3B5TCG/fbQ/oPP0uQjVvZUYEFKjSuWyKdWXWfQNky1RLfzEngI+nO1p2tL3qaUo6DLoxVoDBOG0XpccZWoIt4G+E6CQedlUsNTd6mrbo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ODsSXgr1; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ODsSXgr1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=hEveyat88KTY+fewpr8cR1EEbZqPDDgPFGX/+adKZM8=; b=ODsSXgr1mSQp3iQy8TG3FLkAuW
	dik6kGqYeNe4MLUmGa8vPsCjnJ8NNHSZN6QF01lgm/7VWhqloGmdECdvRA+N6DCT/jkM2Hp69T2yU
	wk5hGPl7pZTStfiLz9jDv+PICPfg3wGHMbtvOdzzC6gyH/iyZJ+sHRz3+XZnZa+BFf4HaLzN3wcOH
	/MIY4xZfMdsIgWNmPKwVakWIQOiGQIn6Q8u+X5ITlt8VNhqkTc9ZHMd30X+St2PN7gWJyrel6p/Lb
	A5D6yZVBcXNEJwW1QDJ9QglDKBAZHCRNLXbIKrZb6WpzWaOaH5Sfjm50OO+fAqW9D+AUe7XTPlMaG
	Hd0lJD4w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHILL-0057Ay-0Q;
	Thu, 15 Oct 2026 10:05:48 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/7] ipv4,ipv6: convert the getsockopt switches
 to sockopt_t
Date: Thu, 15 Oct 2026 03:05:29 -0700
Message-Id: <20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGql0GoC/3XNTQqDMBBA4auEWZsS40/VVe9RiiTjqKGQSJIGi
 3j3gpRCF64ffG+DQN5QgI5t4CmZYJyFjhUZA5yVnYibAToGUshatLLkweHTLbGndVF26N0r9kl
 yolLjVasSSUHGYPE0mvVw72ApcktrhEfGYDYhOv8+hik/+teuTuyUc8GxoFFSoXWF4jaQNspen
 J8OMskfkwvRnjGSC94oFA2WdUuo/5h93z/SaZk0DAEAAA==
X-Change-ID: 20260924-sockopt_expand_out_v2-ee4bc7ba4cea
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6214; i=leitao@debian.org;
 h=from:subject:message-id; bh=RScIEV0hfbD2tBW5CXzHJowq1kQbypZEdCwsy1w6XV8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq0KV0Ob2/3ovUI7RK+I9viSGeWc99/HSI3gJDN
 axTr+tE5OaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCatCldAAKCRA1o5Of/Hh3
 bXEZD/0co0m6Dq9lKVgbOlFrpdzQuPEInc5bTLt9H8bBQ+qUffm9YeVq2IF5sq/eMvSs2Ichmvb
 xn5HlAlSjhdFWFtMG53rg6eYP0cOHBnaQseEOyEEu3h8W6mpPIJrjV++NB+dXVSVEsVOroW7RF2
 Q+qXvrUXLtGt/lUeUEY7woAVyIz7fKO6Gv3ERnPyNPGdyKsMQIupO2v/aBcT4PzecRL7TM3NJMs
 N8WkFN6FyP9D1C/mbn9Ijwpyl5YbI1KHk1dFzSxhj8X1y0LgNBDjQHGToAe4rLPBNIJNjJd0Sk7
 USr+LWWdM0HaCVfWRp/Xvo+JI3I5t192wwz9/VKW5m69deoHtkLkCYOhLBtmd6OupTqzNwuL2SA
 79EkPHQet8+SHl1wh9oTrfo04eGh3drrWZ+OKh6vni1OGqpxmqELcU1wNc1OzgUCgcuMBGhWifF
 yJZbQKecbyexre/R0fWJ/irc8sRNl6/jtQjVlUXSTtwxq1z/xenZL/8XL5o4B2b2si/vbYVvrVm
 t6SDjHEcno3aYZ8GTeIVRst6fto8bxeU6FVa4Sb50hcBi4ikWEIbBUHOeTqaSmw/ablbN1UzDqP
 Nthx8hEEVKw/9L+vqwtUX7hH74Y2V+bd3CZD6e9X6DguE2WpS45cjADTzBeKmsCGEhoJlvfd2dJ
 F/iO4wYSe/LKUaw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

This series continues the migration to sockopt_t, as described in [1].
do_ip_getsockopt() and do_ipv6_getsockopt() still take a sockptr_t pair,
and everything they forward to now takes a sockopt_t, so convert them
both.

Patch 1 settles what a negative optlen means on SOL_IPV6 before the
conversion makes it matter. do_ip_getsockopt() rejects it, but
do_ipv6_getsockopt() never has, and the int options answer it as 4.
Treat it as 4, as David Laight suggested, instead of failing callers
that rely on it.

Patch 2 fixes a latent bug in sockopt_expand_out() [2] itself: it caps
the expansion at INT_MAX, but iov_iter_revert() refuses to unroll past
the smaller MAX_RW_COUNT.

MCAST_MSFILTER has to move before the switches above it. It is the last
option with the quirk sockopt_expand_out() was added for [2]: optlen only
covers the fixed part, and the real reply size comes from the gf_numsrc
field inside it. Patches 3 and 4 convert it on both families, and store
the reply length only after the final copy succeeds, so a copy failure
can't report a changed optlen.

Patches 5 and 6 convert the switches themselves. Each wrapper keeps its
__user prototype and builds the sockopt_t, so the proto layer is
untouched. ipv6_getsockopt() cannot use sockopt_init_user(), which
rejects a negative optlen, so patch 6 moves the clamp of patch 1 up
there and builds the sockopt_t after it.

Patch 7 grows the selftest with an ip and an ipv6 fixture, pinning the
returned length, errno and reply bytes.

The temporary sockptr_t-to-sockopt_t glue can go away once the higher
level callers take sockopt_t too. For now, the series keeps the proto
callbacks unchanged and converts only the leaf helpers.

Link: https://lore.kernel.org/all/20260401-getsockopt-v2-0-611df6771aff@debian.org/ [1]
Link: https://lore.kernel.org/all/20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org/ [2]

To: David Ahern <dsahern@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: John Fastabend <john.fastabend@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: david.laight.linux@gmail.com

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v3:
- Fix sashiko findings:
  - MRT6_* keeps rejecting a negative optlen instead of answering 4
  - Selftest: add CONFIG_IP_MROUTE=y and an IPV6_PATHMTU negative optlen
    test
  - Fixing random commit message issues reported by sashiko. Trying to
    get sashiko happy.
- Link to v2: https://patch.msgid.link/20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb@debian.org

Changes in v2:
- Treat a negative optlen as 4 instead of rejecting it with
  -EINVAL as v1 did, per David Laight and Stanislav Fomichev. 
- Fix sashiko findings
- Link to v1: https://patch.msgid.link/20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org

To: David Ahern <dsahern@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: John Fastabend <john.fastabend@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Breno Leitao (7):
      ipv6: treat a negative optlen as 4 in do_ipv6_getsockopt()
      net: cap sockopt_expand_out() at MAX_RW_COUNT
      ipv6: mcast: convert ip6_mc_msfget() to sockopt_t
      ipv4: igmp: convert ip_mc_gsfget() to sockopt_t
      ipv4: convert do_ip_getsockopt() to sockopt_t
      ipv6: convert do_ipv6_getsockopt() to sockopt_t
      selftests: net: getsockopt_iter: cover ip and ipv6

 include/linux/igmp.h                          |   2 +-
 include/linux/mroute.h                        |   4 +-
 include/linux/mroute6.h                       |   5 +-
 include/linux/net.h                           |  30 ++-
 include/net/ip.h                              |   3 +-
 include/net/ipv6.h                            |   4 +-
 net/core/filter.c                             |  36 ++-
 net/ipv4/igmp.c                               |  23 +-
 net/ipv4/ip_sockglue.c                        | 118 ++++----
 net/ipv4/ipmr.c                               |  11 +-
 net/ipv6/ip6mr.c                              |  13 +-
 net/ipv6/ipv6_sockglue.c                      | 120 +++++----
 net/ipv6/mcast.c                              |  19 +-
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/getsockopt_iter.c | 372 ++++++++++++++++++++++++++
 15 files changed, 596 insertions(+), 165 deletions(-)
---
base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
change-id: 20260924-sockopt_expand_out_v2-ee4bc7ba4cea

Best regards,
--  
Breno Leitao <leitao@debian.org>

