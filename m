Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7837E317;
	Fri,  9 Oct 2026 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536947; cv=none; b=bfIYirjC+5YM/9NkBUiPKVfcN9sFicQ1LXQAaf6+JuL+4rf5hesdA2EsJo0963fDq8e4xubTKggoQx5RzvCyAGPSFwUBbAJsGYgLSgU0Yt9+ymiglTT/TxpsPEDdMFPklGarCmlGmp6lMqSZePFHxQ6GQF3e7oLdkqG3JIYNaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536947; c=relaxed/simple;
	bh=gX5pcCVzVcNKDBaeae9zQCp0h+h+RTX03m8beg0799E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hqkaS4RJVUWmvHEjaLdxbuGyNhDMHRvcOrTIiihsDLvR/uOso6odZu31WJDHOW2aHNoYghxPYRSy4PhFtTVF4JuhKTdrlqrO1Qabcj4gcFuVq6bK62gKtdX56aLEuf2Hfnc13cWGyWombPLZfdEbo57H2XoW5Pilm66BRWdk3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mXl8PQ8R; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mXl8PQ8R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=BIPcv72plFQhhYcp1xMn5j7TxCofgL9oG5R3/1n0Q6k=; b=mXl8PQ8RRPbGNxmjRPUThioApT
	jixsPoGswzSuUIARnt/KHaokg9nUDFRrsIQlxbZrLq/PyXNU0Symt8akCbqmu3deLEwCttGcmdIrf
	1F/1mYbCMbBbF87lUVQIX4GDohUctiHFXAAzmpPZ+4+21Vfp0db+cNMyK6OIfIRKDCQPLzU9oedfW
	BYeZLgm37EsPe2WCqcyjSVBptRnrHYaNutF97DwStupuK2JcAJH5iEcYOd3f+/NMbM0xmqD6TGNut
	X6AUj0+JBMn7ofnpDH87nqCdnj/TmVb6WQhJZusxpm1RuluM1LSD4eltuc1xGBNGjcx7vfLyHmDl3
	3xopcLkQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xF6aj-000QD1-2D;
	Fri, 09 Oct 2026 09:08:38 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/7] ipv4,ipv6: convert the getsockopt switches
 to sockopt_t
Date: Fri, 09 Oct 2026 01:53:34 -0700
Message-Id: <20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+ryGoC/3XN0QqDIBiG4VuR/ziHWW2so93HiFD7KhmoqJNGd
 O+D2OmOX3jenRKiRaKe7RRRbLLeUc9kxcisyi3gdqKekRTyKu6y5cmblw95xBaUm0b/zmORHGi
 1uWnVGiiqGIWI2W6n+ySHzB22TEPFaLUp+/g5h6U++8/u/til5oKbBrNEo3VnxGOCtspdfFxoO
 I7jC3hYHg7FAAAA
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
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4810; i=leitao@debian.org;
 h=from:subject:message-id; bh=gX5pcCVzVcNKDBaeae9zQCp0h+h+RTX03m8beg0799E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqyK8N3Ukp0KuzzsNG3FdC2ZSqHGO82PfCfBm3Q
 JIEFrxwVDSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCasivDQAKCRA1o5Of/Hh3
 bc8fEACFD+9vnmQF+nvH+AgiTdtHPn+A2CJVE9vcc7fCwKeFDhE+e+1+AQ1N0mWn2FdPETcOezA
 Xv5OnChtma/5i8iFq55aXfi8ZV57F8xIeg4EGx58IwzNdofoK+jNXArr2mKj2ddgdG5Z3KBjC5F
 7ohXIjhj+bopolHyDTw7CShIp58cCd3jqlJVxY4Vvf/tX1pg9GvPeXBg19dOOfOSxVfFqncSQia
 5feG+cLuEIf3BFJRcnBsC++O1fHomFgFONK9/u7ALJw0XR8WO5Si+3b1pGTxPZDYj7C/YMeeA7b
 /Ng+7q1epmyGaU843pt2H8RODAXglGKNokQYJCAzGz9GdvnrNY5QhT+pAT9mG3/CtG48Or7co4a
 QuuiXedepnHxpK6Dz1amOd4RmcI3c5PYQj2DLiUzPeuIRwaOkmlzwEGJnIAU850vvDu+pUB+tMn
 LysMWRx429qBfBnV5sf2Xq4mcxNa3BivykRpN0zApLhf1enAEGLg94Cip/qPGyBB/+Be1VPZpKB
 +8L8cGBlPRtVr2vs4CnCRew6Zlom1Uj4dh2VfUWPZ4+2rOFNsiH7rydC5Hl/yErWkAVQd5+pwIH
 Zv7iovnGwsE+TstNRp9iD+3ie7tJVET5da/LLxULcOLUs4cKIpLfxqT98jkvu4u/6j+ddeXi57V
 7w08o8fyqtiPoFA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

This series continues the migration to sockopt_t, as described in [1].
do_ip_getsockopt() and do_ipv6_getsockopt() are the last two switches
still taking a sockptr_t pair, and everything they forward to now takes
a sockopt_t, so convert them both.

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
Changes in v2:
- Treat a negative optlen as 4 instead of rejecting it with
  -EINVAL as v1 did, per David Laight and Stanislav Fomichev. 
- Fix sashiko findings
- Link to v1: https://patch.msgid.link/20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org

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
 include/linux/net.h                           |  27 +-
 include/net/ip.h                              |   3 +-
 include/net/ipv6.h                            |   4 +-
 net/core/filter.c                             |  36 ++-
 net/ipv4/igmp.c                               |  23 +-
 net/ipv4/ip_sockglue.c                        | 118 ++++-----
 net/ipv4/ipmr.c                               |  11 +-
 net/ipv6/ip6mr.c                              |  13 +-
 net/ipv6/ipv6_sockglue.c                      | 117 +++++----
 net/ipv6/mcast.c                              |  19 +-
 tools/testing/selftests/net/getsockopt_iter.c | 359 ++++++++++++++++++++++++++
 14 files changed, 577 insertions(+), 164 deletions(-)
---
base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
change-id: 20260924-sockopt_expand_out_v2-ee4bc7ba4cea

Best regards,
--  
Breno Leitao <leitao@debian.org>

