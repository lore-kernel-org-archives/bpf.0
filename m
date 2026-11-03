Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703997;
	b=i6QvbYI2Dxo322DKIWbhvwKZnpwyW2s3c68WoHKlT3QamGioP11tjAh3rcjLznvPVqXw
	 Mq0J+Yc52zH8PYVa5NB3dogj3AFMCNiMA00L3PR+BTFex3Emun6OrjGRy9gB/grdg6dQN
	 Od0PytQN6g7/ThRpDF33WsaAi7Po83EhtZy/q9Qir1tlCWK2NAd1x06OHBYwkMWq6UJSg
	 BEQ14dQtY0SfS0iUyh+t7A0E5SdxuKYJgmNg/41811ofH3naOPD2tP34+5cfpLhxALV4Q
	 E4qf3N1XhIj33hs5J5jHUWXQcV33xcKKzxCEtIkrWZRDI6NtYXtI/0HwUiEqefrOLPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703997;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=Y3S+q5h/f6UyMdTf7wDo+uWvNu5dofd5PPkdJcvBO8s=;
	b=FfHaLbbJLSDj+h6gAQI2KK6BX5lQfbC2Ej/afOXHSQc53INwhwcCFcfdSzQpkv6D1gAv
	 jd5Plk7+C9SiIgYcY7zD+0atWFhdFmtF/njCGiGvMCQR07zoT+0tBQg3Q9Wjz+cv0XfL4
	 25kFdVQbSiuWkWyqQc8gwAzNkuIT3HyNLkTj5+w7bouTyX8W48Jz5oG0o+VhyhVMpcZjF
	 HZse7V9/QgBLazgpzaNRM/gZvGJUdIT5WL4jkTCW9bmIT4wAswBd/+jLW3jIa4Je+0qHj
	 wh3aBPjG8iwZ8e5sVxplzvInds4CVt2UpMsCW25+o4ZeG0z+M/hIrHyVtN2JiT62xCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=F5dktL+u;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F86606C5B3;
	Tue,  3 Nov 2026 11:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F86606C5B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=F5dktL+u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Y3S+q5h/f6UyMdTf7wDo+uWvNu5dofd5PPkdJcvBO8s=; b=F5dktL+ueoLV9TKgr8yKZRn60D
	y3y0d2ZtPyb9CpsaXNVRsmXrwtbWm4jBAC19skpljqwfnPotDvxiWUfEBa3z7lBBeizNJUeGzTvoJ
	fZCV6hdLKhYrrJtQLfoacrlD1+eprXJ4H9PY0VmwD1+7Ub/jeAxm3OPpc5f3f7DhFNlivaYuWa4a5
	th92bmRPixdU3JrKT165Ziiic+vyNF0qu9dfRzpjJvNcCK7suzbhfV9BFaj0V5Xo5bqfCU5+hboV4
	eI5/I1Sei+Ny35KwvAiwh0qXIyiY8qRkP6nGevQMH1dF0NIm6VyXNGMaKJaqwwWY1h1nK9u+SqLWK
	jfF160+w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOCLV-006tCO-07;
	Tue, 03 Nov 2026 11:06:30 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v4 0/7] ipv4,ipv6: convert the getsockopt switches
 to sockopt_t
Date: Tue, 03 Nov 2026 03:00:59 -0800
Message-Id: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
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
X-B4-Tracking: v=1; b=H4sIAPG+6WoC/3XO3WqEMBCG4VsJc+yUMcZd9WjvoxTJz7gbCokka
 bAs3ntBSmkpHn/wfO8TMifPGSbxhMTVZx8DTEI1AuxDhzujdzAJkCQvNEqFOdr3uJaZt1UHN8e
 PMleJzMrYq9HKsoZGwJp48dvhvkLggoG3Am+NgIfPJabP47C2x/5t9yd2bZHQdrxI7ozpLd0cG
 6/DS0z3g6zyh2mJxjNGIuGgLQ1WXUa25h/T/WLa05oOCa+Oel6kW5Qa/jD7vn8BwNKUqVMBAAA
 =
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
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6549; i=leitao@debian.org;
 h=from:subject:message-id; bh=yJkNL0GeXccgua2LpQLtTpKSITy2Snw/sc0yaHCnwzY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6cAuPGeCx8RrwJa27WGh6h1vvNFnVyQU8IXCy
 d092vBpnhOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaunALgAKCRA1o5Of/Hh3
 bU8tD/4wsd7YgOJiTUzZhIikOSSaWwe19OOymEsEF0wWXcnHPp7w71TLu60+OzPPIGewYNwZqsn
 tBjCrYu6Qhd6ZVW1RKHXpP86hinz7E6KPngbtmuK2ChLrKkZNSkYD5EixwMI8DPgHAG0bWsMBIL
 ZG4je86eOt98ElGFeoO7O/WI3YdSv3ypvB8zIZmt4f+gdPnL8HZLw+1OViTeA19X+AX0yNfCK5H
 +1DnSVhcUY5+/qlWO9uWRT6dWBx/VUJNb5aYclBAmkwN30CpdMfpqCfIJpK+QKUrVgHFdSNlKj7
 Qht68ekMdks0IxFIKEO2ihaXm/iLfisAmWchfCzz3NrM+CsT2yjPQy/B6V0KUNgBML+M3tUt6Lp
 qnVPeaJadmPhajFREd6Sml3xamzA70T1wM4MhFey4dPotR07lmZ+DGQClnIoGe+7EIjZocSq9ZW
 68fcEEA0iaK1VXGHkwuFamxJy2UOGda23SxMllWEA/yBivrFq1CnByoUZevm1LSt6Hckd65mmSZ
 5b3A62Lfl6NAovSdRYfckRP/lC0E2M1uHkavUc+N+LSIJh/9MnUDDpkwNBwC9tzJOFq3dpEA2Hs
 SEMpGpFtIm5QQCLkEhNpIbJB2cO5jdTdPjHyycD2sD0sypSGcsx2PVRMkC2jv7V0IiNTHSeLuXY
 SYngxqtL/INBMCA==
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
Changes in v4:
- Selftest: add CONFIG_IP_MULTICAST=y, which CONFIG_IP_MROUTE depends on,
  per Paolo Abeni
- Collect Acked-by from Ido Schimmel
- Link to v3: https://patch.msgid.link/20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org

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
 tools/testing/selftests/net/config            |   2 +
 tools/testing/selftests/net/getsockopt_iter.c | 372 ++++++++++++++++++++++++++
 15 files changed, 597 insertions(+), 165 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20260924-sockopt_expand_out_v2-ee4bc7ba4cea

Best regards,
--  
Breno Leitao <leitao@debian.org>

