Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682D4C226C;
	Fri, 25 Sep 2026 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351757; cv=none; b=LOMOuaSxnufO+QXmE4Da3hdR2/XG0ea0pORg50/nxvsIW3sHGT6To+q2wdG8JZY6Lx4SLdjlIhewX4xJb0RpBraScw6PPHEvchG+1l49LJPAmg6huJdwuSNeXa4SHhSoBt84t3SlYO5HzdkxwoSAJ133spdA14GlyvG0g5uJG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351757; c=relaxed/simple;
	bh=SfDTbJJw7dc2WROcCFWMWBfZVQrV8KomkidIc8Bsjqg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UNrVf+EBWJ4ruYsyD2TDwiD9gdEX2dMrgWbIT8tKKn/8jFKL6I4b9zbUNd9UBtDpz5TPR2c/6B8YOQXP0CwDoOptY5LpAS09E7hrHUFTxN9KQV0KB3oJNcEfuRCpKfFBjImn8WvIeecxdora4cpyzkXFkZ9HlyXX/8Yc/f/gonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hQQhUnme; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hQQhUnme"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=LHhOcHajl/RCz3aKIy6XLbbprq7ug0zwcg6Z8E4tJtc=; b=hQQhUnmeVDDfIgpemwDWblcib9
	93ltTzqmepbA7EphiU3aghEH6mCR+MEdoaaknU4j/ZRKggo4pUklzc1PJeGxnIlWj5PI8LJDgI+BD
	mBKtJxCZ/lC3h570YWUroNSv78qFJtM9xgrmOSd2jo0Q18bnrBUFsZeJewa8CFFkjg881CN9rIE88
	r+Pt5tAvxN21zdeQd65IOnHETM6GA48yAco1il9Gg4FDpTrtyxb9u1bewJ9lgE1SoiecvL2YIVyU7
	JcYkF36vz3zPJE15XNiShv09KoYC+XqTWedcg32/GmyjifKaqkV8kpwp+UdamvmKTnnkfKbF6CXeU
	oo6el0KA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA8H3-005Pkx-25;
	Fri, 25 Sep 2026 15:55:46 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/6] ipv4,ipv6: convert the getsockopt switches to
 sockopt_t
Date: Fri, 25 Sep 2026 08:55:15 -0700
Message-Id: <20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGSZtmoC/x3M4QrCIBgF0Ff5uL8nLJEiXyVCnLuVBCrqhjD27
 kHnAc6BxhrZYOVA5R5bzAlWLpMgfHx6U8UVVqBnfZ3v2qiWwzeX7jiKT6vLW3e7VqRZwm3xJtB
 jEpTKVxz/94HErhJHx/M8f/bxwtlxAAAA
X-Change-ID: 20260924-sockopt_expand_out_v2-ee4bc7ba4cea
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3739; i=leitao@debian.org;
 h=from:subject:message-id; bh=SfDTbJJw7dc2WROcCFWMWBfZVQrV8KomkidIc8Bsjqg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqtpl6fHlb65rB+lD0cDbiUFM4wKhokXaziy94Y
 ILKTM8/foeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaraZegAKCRA1o5Of/Hh3
 bYi9D/9TMhMvycPHY1bo/l+NinvEGVY1oGi7i46LYpniXobAecmH7ZQ7Po8Hf1sKAdrj/4v81HF
 4zrX/UmX43ma1od+iWkfFs1kgWiW3bsPehORT2YhSA0CN3tWY1BbcAQx03ZnS1jpVzenlWOqyrV
 6KBrSFEYi4exfD23gadiOXhX6LsCcCywbWwCbL0cA6sGCy3YDq5rFlazbhqfrspwe7XgElAmSPY
 rSYtK4bxOj1af/kY23XZbBpb9Ci/RmHkh+fzXKL6BuZoWbygJWKitF88my9WvjCXt2o4qb5NfWl
 1UjZ1V2XzLMUVeBjQb4bX8xE5OxOfEPDr4qzh4Q1TnhY77p+pzvDx4gwyxa1ddxsBTohJlL+CLk
 OFTSZft0WBEFUAKGV0KkfXeM6KpydRZg9al45iNXqKCFXplvNr+3e3NGMh2r+Ft20KUALDFEg4n
 XHfLkfFuEocTUmfAwJ5rtbYGlL+6GDfTCnWEX/muOdjf92jI3jnPsj1g9J9rAkPKYCPDo3IHIUv
 pAJ3uDbIwqfrZrgXjzOB704KzIFBRbP9xQ1PD29W3B+hHxBYwRwKEiMtzLSD6Un3p2eH2yOFlCg
 hBfvxQgSHx6cJg0CbYU2w+HUCYHvX/SUmn79TdhuOSv2T+FrJ49WFXQqIUev4o00WJkA6QbIpXX
 ocRmejjQCL0N7GA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

This series continues the migration to sockopt_t, as described in [1].
do_ip_getsockopt() and do_ipv6_getsockopt() are the last two switches
still taking a sockptr_t pair, and everything they forward to now takes
a sockopt_t, so convert them both.

Patch 1 first rejects a negative optlen on ipv6, which do_ip_getsockopt()
already does. len is an int, but every consumer compares it unsigned, so
-1 reads as a huge value and each site clamps to its own reply size. The
conversion cannot carry that.

MCAST_MSFILTER has to move before the switches above it. It is the last
option with the quirk sockopt_expand_out() was added for [2]: optlen only
covers the fixed part, and the real reply size comes from the gf_numsrc
field inside it. Patches 2 and 3 convert it on both families.

Patches 4 and 5 convert the switches themselves. Each wrapper keeps its
__user prototype and builds the sockopt_t with sockopt_init_user(), so
the proto layer is untouched. Patch 6 grows the selftest an ip and an
ipv6 fixture, pinning the returned length and errno.

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
Breno Leitao (6):
      ipv6: reject a negative optlen in do_ipv6_getsockopt()
      ipv6: mcast: convert ip6_mc_msfget() to sockopt_t
      ipv4: igmp: convert ip_mc_gsfget() to sockopt_t
      ipv4: convert do_ip_getsockopt() to sockopt_t
      ipv6: convert do_ipv6_getsockopt() to sockopt_t
      selftests: net: getsockopt_iter: cover ip and ipv6

 include/linux/igmp.h                          |   2 +-
 include/linux/mroute.h                        |   4 +-
 include/linux/mroute6.h                       |   5 +-
 include/net/ip.h                              |   3 +-
 include/net/ipv6.h                            |   4 +-
 net/core/filter.c                             |  36 ++-
 net/ipv4/igmp.c                               |  23 +-
 net/ipv4/ip_sockglue.c                        | 118 +++++-----
 net/ipv4/ipmr.c                               |  11 +-
 net/ipv6/ip6mr.c                              |  13 +-
 net/ipv6/ipv6_sockglue.c                      | 111 +++++-----
 net/ipv6/mcast.c                              |  19 +-
 tools/testing/selftests/net/getsockopt_iter.c | 302 ++++++++++++++++++++++++++
 13 files changed, 494 insertions(+), 157 deletions(-)
---
base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
change-id: 20260924-sockopt_expand_out_v2-ee4bc7ba4cea

Best regards,
--  
Breno Leitao <leitao@debian.org>

