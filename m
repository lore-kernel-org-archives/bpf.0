Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503265;
	b=cEPMb4+gBczU2FBMOIrKUxW+wAGjUtrdcuqBtIgQ8bm27zicBfhEGnsJlGHI52Ct7wxe
	 mV8FuPt7//NBwsQWqwTbqPghsoEbsVU80p10Z0K0gY9JbC6BFpYSkAWymyIk7nGzFmMwv
	 BllpGcNHeolOZgCYrL266+LlUF6IZ6xdo0Pzotbpec5y77xaXvYPCJ4b+xiFVQxgMX+x4
	 RnH7MEd7zbE819D7zIq7zdbPiUwLkkIC/XRjUr97PupalZy1VBqU6ON5wnDAcVN1e+J7J
	 xeYgh+LZZjW/e7XhDeQJn1qb2IJP6pypYlvpUYwDUinw37mzZL9KoCBk2h+ytkf38Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503265;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=JFOfatZsgWg4PDJ3jy8YXTWFyxIYdBmfjS0qeLPltk0=;
	b=IIxLRAEhnAS5pN/OiadZW6T5QbHgwUt7qdWAwIImTjMS49m7b9PBVa2X+8n9vyKihA6y
	 6ZATceolhw9Hxaf+tuRf8PZqqW1ykbZ50HU2jSblR6lBuM32AFNEtKnHRvzliQ4ZW4CpM
	 UnM0YiteUzBjrEgtfhJOqfVSY0m7TK+Gru1P4M8PUZ4YgpOSYNcrAwjSOP/597ZmmdikN
	 JxZ7doheuRsy5ZmN44HLaMp85SvSQpOnFUW1DiJCbHqRjSuT0BUi1uqSZkYjlBQ8OcZfx
	 S2N7fV6D0FI0Uo12rFCUjJZ3jnrw7f2PKVfN3KHU49iQXFCHWQE0/ZEoeWO2Fh0IhYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=KQ4JGc7I;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797C606A331;
	Thu, 12 Nov 2026 17:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4797C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=KQ4JGc7I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JFOfatZsgWg4PDJ3jy8YXTWFyxIYdBmfjS0qeLPltk0=; b=KQ4JGc7IPSLZ5X2+RZt7Lcso3z
	SOWp1vO8gmtq/ijJJYgRRr4ZpwwsxJiN0qjWZGZiW024yiT+AMvTvfwGGPtRdUwTlr1R97PVVUfC1
	UK0KZX7DVxxVbH1fQYP777f0Wirii0BoQ0gbyFSJChg5oq+GtZaVE7CrjkeOuuXP7fUi7rrp2IUJD
	g+SOEpYfMZD1l9RImbmVQKxEalB3qOHIqO+CHCVZoeW7ZCuMBiGMujFaudu2RIb4vFvfnVU9pj/dY
	SMExP98U+4ST/yUYQig+rsXNuRFfrFCqUyJJUtIN65+kQ5r8mEKAuZ8jLSW50KmvUj7KDQPfU5IDF
	kHCGDiTg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRYGp-00E7a2-00;
	Thu, 12 Nov 2026 17:07:31 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/3] tcp: convert the SOL_TCP getsockopt path to
 sockopt_t
Date: Thu, 12 Nov 2026 09:05:24 -0800
Message-Id: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
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
X-B4-Tracking: v=1; b=H4sIANnx9WoC/x3M4QqCMBQG0FcZ328HzlbiXiUiln3qJdjG7ghBf
 Peg8wDngLIKFcEcqPyKSk4IxnUG8xbTSitvBIOhH27O9ZNd2TTPn1zas2xROdppcd5fR77ixaM
 zKJWL7P/zjsRmE/eGx3n+AEQxOR5tAAAA
X-Change-ID: 20261109-getsockopt_phase7-9f14457eba34
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990; i=leitao@debian.org;
 h=from:subject:message-id; bh=mAX8cKz3Q/X4G9+DwThbM4f+lGRWBFAlSdAveeuO7+E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9fJMrWKQfBI+voKgPkbtdBNpxVuxT2KTkppY8
 sOEroHTtRKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavXyTAAKCRA1o5Of/Hh3
 bXfND/4+CQv0hWQXeF1sZs1/bkr2Sp3JoLNnrKywLUPOaQ9+I08eV9HHFJGDzKWSD8N5Q9Nqf/v
 pdhjv7UHW2t1ZSD7IQdFkzVW5Dqgs4CVXt+D64XE+taYdhGLGA4UjD+eSD1mdnakrMI6XZu1eie
 VF+d81xZQTXic9SWrUAL3vG9arTaeXhcaFwEl6aLIWErVXTm0R34flDYIn9Ya3HpYq4SzLhJb4v
 DXytBhYHTEraixBlcW65xVqFP8ivxI1Xevy3ej7e/SKRKCU3jJQDXsqTfr1CakwAtD7/UYwmQWx
 gxRXBVGXhDTc7Di/bMMi0M4IvObhiflgQi5RxKWUcmEKfAj4TBbmfjWXeO9WmocCnu6aTxJvLQR
 ahgPotOV9HmW7e9hiJ85+woTTMVissNxvYU68b2EvV/c1kooZXSwpLCUvyXhNqH4tp7F7AXDuhi
 PDWOixEOZjgUBnXCD3IHVVI3qFpF7hiAVG9iEbDME1wq4wPjEcDJxk+3R3EPZwnMstGoKA6IyxW
 HxtsS4CCz3VBcs9iil6ys6hEskyiHR/GUN+2MdSmcSj7wf44SuimiVbvA52DbOM7SkNXIVbWOMF
 B1RzEMNa6pnMgIGuVsevm5zuzMCG8AcEGpD4qnRiionLs4cXOJc3CQ2VVEqzcjh2mmIuIisahm1
 Krc8Azuu9Re/TCg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

This series continues the migration to sockopt_t, as described in [1].
do_ip_getsockopt() and do_ipv6_getsockopt() moved to sockopt_t in [2];
this does the same for do_tcp_getsockopt(), which still takes a
sockptr_t pair.

Once this lands, the MPTCP and SCTP getsockopt paths come next. MPTCP
builds on this series: with do_tcp_getsockopt() on sockopt_t,
mptcp_getsockopt_first_sf_only() can pass its own sockopt_t to it on the
first subflow, instead of calling tcp_getsockopt() with the user
pointers.

Patch 1 converts the TCP-AO getters.
Patch 2 converts do_tcp_getsockopt() itself. tcp_getsockopt() keeps its
__user prototype and builds the sockopt_t once the level is SOL_TCP, as
ip_getsockopt() does. 
Patch 3 adds a tcp fixture to the getsockopt_iter selftest.

Link: https://lore.kernel.org/20260401-getsockopt-v2-0-611df6771aff@debian.org [1]
Link: https://lore.kernel.org/20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org [2]
Link: https://lore.kernel.org/20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org [3]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (3):
      net/tcp-ao: convert the getsockopt helpers to sockopt_t
      tcp: convert do_tcp_getsockopt() to sockopt_t
      selftests: net: getsockopt_iter: cover tcp

 include/net/tcp.h                             |   3 +-
 include/net/tcp_ao.h                          |  13 +-
 net/core/filter.c                             |  30 +++-
 net/ipv4/tcp.c                                | 116 ++++++------
 net/ipv4/tcp_ao.c                             |  77 ++++----
 tools/testing/selftests/net/getsockopt_iter.c | 245 ++++++++++++++++++++++++++
 6 files changed, 372 insertions(+), 112 deletions(-)
---
base-commit: c88fd6989aea9237a60a4859139a265bfb7ddc0b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261109-getsockopt_phase7-9f14457eba34

Best regards,
--  
Breno Leitao <leitao@debian.org>

