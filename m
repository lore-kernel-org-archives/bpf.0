Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28007279DB6
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506233; cv=none; b=iOF7d6BSP7Ybu14r4i9e8VuIhc1vfupsEH8oZVCiMpgUbM1vMG+1C17EXxde2iWnsIgDJZnaND+SpL6cfuT0VnaXN0Cp2lsMY91ufEHlvPusn25a2cXr+LMdTuqZqp2pF4sPrFBDNydaW3HJLflnJC8Tg3tLFolHsWlCXIJvCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506233; c=relaxed/simple;
	bh=pKVjCjcmwgLFIBfm/gjvwtOU+DQ4pjGWSvVcM4JnwZY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MhYk24NyxLgrAAquheSacHO4otNXshDvGsEbxq8qkKiWMgMh/fJASQ37Gr3TOeca58Tc2NVDsqF2q2YxBE+QWW+26Wo8KQ7pA8gTX8jA7pkbNhyH8Pk+jIQi2BZb79MRcQ7mjQvzEGeUtISjWPz8fW1YzESkmeOXpa8yZCkg72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=g3vLQTxf; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="g3vLQTxf"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wdDIJ-00DBGR-MH; Fri, 26 Jun 2026 22:36:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=ly+rs5U3NFQZDhMCTmcjPlOV6xPqKVnp71dYXhsnJ9M=
	; b=g3vLQTxfMgbgck9LjrMYPOiXAqzvpS1ZvYCYczUpEeiykwFrJADJUOSZCMCAEkPmd+Jg+C8Uk
	G1rXCm21GeRGXULNkp+SXCogNP7fO9zQgcGxhK4uj1jGVMpP/ruwcCYe2V9NQqnsuZ0xeUMitz5GH
	m7/3PbNw02CvVf/yFu9BBLtcRDrNwOeZfi5aOnz6H2a0SSYOqQ521FuQ2K5d65Vi8/AZodKXZY1Ay
	KB1ActC51x9AQnnxzLmLoapiiMk0YRUbSD9X4CWuEFatJ36mARdDWMJEjcUuMBh4s/lN4rgvUpzuR
	7M4A0LgV9Ol70upVBLhNu6cKTWG1enuF5Xt/Gg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wdDIH-0003ZS-S8; Fri, 26 Jun 2026 22:36:58 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wdDI7-006anB-ML;
	Fri, 26 Jun 2026 22:36:47 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v2 0/4] bpf, sockmap: Fix sockmap leaking UDP socks
Date: Fri, 26 Jun 2026 22:36:28 +0200
Message-Id: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNzQ6CMBCEX8Xs2TVtKT968j0MB1oWqShtWiAYw
 rtb4OxtZjIz3wKBvKEAt9MCniYTjO2jEecT6Lbqn4Smjh4EExnLeI7B6u5TOXxb240OxzpKqjp
 UWlKqU1nwOoe4dp4aM+/PD1CugfIIw6hepIftc6u1JgzWf3f+xPfygRLJX9TEkSFLCyaba8IKk
 nev7HzRFsp1XX+eRwPL0wAAAA==
X-Change-ID: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
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

Fix for UDP sockets getting leaked during sockmap lookup/release.
Accompanied by selftests updates.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- selftest: drop the original, adapt old tests
- fix: change approach to rejecting unbound UDP [Kuniyuki]
- Link to v1: https://patch.msgid.link/20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co

---
Michal Luczaj (4):
      bpf, sockmap: Reject unhashed UDP sockets on sockmap update
      selftests/bpf: Ensure UDP sockets are bound
      selftests/bpf: Adapt sockmap update error handling
      selftests/bpf: Fail unbound UDP on sockmap update

 net/core/sock_map.c                                     |  2 ++
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c  |  6 +++---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 17 +++++++++--------
 tools/testing/selftests/bpf/test_maps.c                 |  6 +++---
 4 files changed, 17 insertions(+), 14 deletions(-)
---
base-commit: 26490a375cb9be9bac96b5171610fd85ca6c2305
change-id: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

