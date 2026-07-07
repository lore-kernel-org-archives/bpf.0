Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72176367B76;
	Tue,  7 Jul 2026 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398308; cv=none; b=Im9fjui30lUycjgG+I54nVBUTsIWG55LyL+u281SVjnrENZCzYR4140wsRudvsaHpFbEbeg+CGzGEajfrDVic9fVSe2gmC94ko/x4A3dVJU2+fXamVsA7Y7zJjnSMFMDnI12VZODhI1hkITyM9bvRY+4UhvvpM9131txURa3bQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398308; c=relaxed/simple;
	bh=opHTuuL9qw5T8tWLSEXG0Rt1luagGrS4UY1zmwZHa6k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=STR7ygj9SG8YcmPtZA45X2iXn34LpLFhtZyR779HUYEc2oDKGDT2iE1ZQ1GAUxGqMjRiHQuzoe+zpjEGCE2fINS/wXMtvQv1o7f6DJi01jD4cZ+tePYwGE4lQSxXlOinoNLk2TiCRMf6xfBL1bLDAYjz7RHx4SARELoxIvsLUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=toXSCDNN; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="toXSCDNN"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wgxMa-00Dei8-MA; Tue, 07 Jul 2026 06:24:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=VEDYRANxd2n4E7p/Uqpqw4YEwTx+raQSJRg3dXH1x+U=
	; b=toXSCDNNz9MfJeIbpiWA0UzebKuDxG6j9ppanpNhNsEqgCZ+XMZ3NFXtszEoNik73B3kv54DB
	RN6tDStprnMIPPpYSBOWxB7EJCZp0DjXyMPOtn3a+gxb84ZGBYtSq3OoU95LWZb+b9MtQT3+3V8fE
	y6u0DcRa0T2jA5wNsfRlAXi9HGXhH5/gg54hP5zqMGLbjlZDD6CGS6p3o4C0+L3fVqQc5Zy+nyNaf
	lu3Tj6fsn/pXA7CwRv2YQh7+Wc5rwNSypTyziOvSQZh9ORTcYTPkq4mYR9Y9DUwdWi6kNu3n58/EM
	D/WJ+XxuwHth2bVEY7jOOui4CpfSO0fjAg8A2Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wgxMZ-0004lH-Bi; Tue, 07 Jul 2026 06:24:51 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wgxMO-00Ctdi-HG;
	Tue, 07 Jul 2026 06:24:40 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v4 0/4] bpf, sockmap: Fix sockmap leaking UDP socks
Date: Tue, 07 Jul 2026 06:23:55 +0200
Message-Id: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ6DIBAF0KsY1qUBRMGueo+mC8WhUlsxoMbGe
 PeiLmwX7mYmf96fkAdnwKNLNCEHg/HGNmHhpwipKm8egE0ZdsQIS0lKBfZW1e+8xS9r677FfRl
 GyGtcKA6JSrikpUDhu3WgzbjKN1S0Gt23o++LJ6huMZdYZXxn3WftH+ga3qpYfFg1UEwwSSThO
 ouJBH51hR3Pyq4dA/tV0mOFBUWAAEaoyhKa/yvxrgjCjpU4KFrLEqSQjKdyV+Z5/gLSI6/LXwE
 AAA==
X-Change-ID: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15.2

Fix for UDP sockets getting leaked during sockmap lookup/release.
Accompanied by selftests updates.

Two Sashiko's concerns to be addressed separately:
https://lore.kernel.org/bpf/20260626205814.BAC3C1F000E9@smtp.kernel.org/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v4:
- selftest: drop redundant `if (err)` [Sashiko]
- Link to v3: https://patch.msgid.link/20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co

Changes in v3:
- selftest: better error handling, ASSERT_*() macros [Sashiko]
- selftest: fix grammar, reorder patches [Kuniyuki]
- Link to v2: https://patch.msgid.link/20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co

Changes in v2:
- selftest: drop the original, adapt old tests
- fix: change approach to rejecting unbound UDP [Kuniyuki]
- Link to v1: https://patch.msgid.link/20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co

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
To: Shuah Khan <shuah@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Eric Dumazet <edumazet@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
To: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemb@google.com>
To: "David S. Miller" <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
To: Cong Wang <cong.wang@bytedance.com>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

---
Michal Luczaj (4):
      selftests/bpf: Ensure UDP sockets are bound
      bpf, sockmap: Reject unhashed UDP sockets on sockmap update
      selftests/bpf: Adapt sockmap update error handling
      selftests/bpf: Fail unbound UDP on sockmap update

 net/core/sock_map.c                                 |  2 ++
 .../selftests/bpf/prog_tests/sockmap_basic.c        |  6 +++---
 .../selftests/bpf/prog_tests/sockmap_listen.c       | 21 +++++++++++----------
 tools/testing/selftests/bpf/test_maps.c             | 13 ++++++-------
 4 files changed, 22 insertions(+), 20 deletions(-)
---
base-commit: 17566290dc802b03a8127729b19c5962d63a7947
change-id: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

