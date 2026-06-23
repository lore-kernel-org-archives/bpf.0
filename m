Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11BC359A91;
	Tue, 23 Jun 2026 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782239530; cv=none; b=knlSaSx+rS03wCTTBWxEm5+KB+N44bEeSydIHnSkn2HJPM1zfvnAjPKkDfsnMym7gy5alUAszAGP8zUT9kjCNTgJHajcr2q7DQdhjV6eEsfI5WSxx5rkK4llbjhg4x/5K15iQ/L3v8lEtk05fg9LthqZqDgQRYs1dXt4xzu0MMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782239530; c=relaxed/simple;
	bh=o2SHWTofhxRkanpNrEO5U0csdR5JtfU2ZtOrfn/cyTg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=as9PWETdxuQ0VdiJxQwvzhQVkvyTcuGOlcBEgOD936CHoh+RXv2dg/ucK0wEaoMlHVI4mETu7JpjtNfmY2lad9BCCetee0fOWA++vgtiAvSZx4B11hNbTTzNkvJtBrJnzGnvK0udOWsIdFmbAKhHmn+gPuvfxXuaq9PTASYWS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=pJPxf0sC; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="pJPxf0sC"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wc5Td-001WV9-98; Tue, 23 Jun 2026 20:04:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=JtRtCSPn/CTA9bmTH0wClGxUVvAD6YfA42NZj2PW6vk=
	; b=pJPxf0sCT8cUrRE9FLGbkiDjDuK9KioNF844/jQBReWzPg9O4OSPitDSou+KY9qvLQow4fsEM
	dkJuGAxSUKT+Wcs0lY2SlSF/tCUharPdWIOIods9vp7Y1pDHYYOuzrmI0+AFFn6gcocfgdYFDPzpJ
	b67riQiClwNrTfrnpLw8wXPZDh8cy0+K6ixjQKkYIJNiZK4ndB6Km2ASVugFYhMcf3jOqy/x1JkzM
	qNeYPULiNgWANfvdVdlbQWTs245q4jEgs6N6FCCCiBO+y04rWYUOWoNUn9IPveXcUg8eTRmj/aA+V
	f40Yg5niCsNgk41EdwHFos6U59Fg1rX5JWBd2Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wc5TW-0006hG-O0; Tue, 23 Jun 2026 20:03:55 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wc5TO-00GZY0-Jl;
	Tue, 23 Jun 2026 20:03:46 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf 0/2] bpf, sockmap: Fix sockmap leaking UDP socks
Date: Tue, 23 Jun 2026 20:03:08 +0200
Message-Id: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2oGm9CH+irhIJlMdo03INCKU/
 rtRd/dcOGcD5SyscGo2yPwSlbhUMIcG6GaXK6P4ytC13diOZkKNFJ424SPGUBIWXyfbgI56Hmj
 oj8ZPUO2UeZb3r3wGl2a4/E8t7s60fpuw7x8EZoOBgAAAAA==
X-Change-ID: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Fix for UDP sockets refcount asymmetry in sockmap lookup/release.
Accompanied by a selftest.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (2):
      bpf, sockmap: Don't leak UDP socks on lookup-bind-release
      selftests/bpf: Add test for UDP sock leak on sockmap lookup-bind-release

 net/ipv4/udp_bpf.c                                 |  3 ++
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 50 ++++++++++++++++++++++
 .../bpf/progs/test_sockmap_lookup_bind_release.c   | 37 ++++++++++++++++
 3 files changed, 90 insertions(+)
---
base-commit: 12091470c6b4c1c14b2de12dcbae2ada6cb6d20b
change-id: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

