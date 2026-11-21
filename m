Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257166;
	b=bwcffkMUtVMPUwLk0RRk7f9P9jd1ZhGQaBAcOpBo916F17kYeq1G/tRQ8oz7epldP4Ta
	 1O0fShLSMD9PksepqeoAzcczQPOgKzNC1hExS2+kieIOMlKK8Euk2A5gVnq1716JDTycD
	 TfA0hJ33P6pE92BMDuhAP8b4AmaAK4j/2SYYVoC/6FwTA616qBZjiw3F5g6N2S/c/XA7H
	 LulU2ZD0jU1DiLFmEhHq8xg0hJ8510mQOBVyVLlg8+ta1xnRgRF7V7zhCGSOK52F55jGM
	 ZryFw6QOorYvDTw1esb8p3DnCRhwF0nBPKZmj0euDxgThAhdIlRmvB9LbbDLH5O16Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257166;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OvEjtdai0kpY7vmfUkOscZqwft6Dm3Bu6Xjzn36T494=;
	b=VaCaLCMjlS5M/VmbdwoQhFpa8Cqarca1StBw/y7lQAU4s/I/09quctXVzKcrvo+5TEEl
	 nFQYJUXA9ps7eV+fpK0doKv47+L0b9AHjvPqvPwUhOZFl7zwHmZK+KUntlmovYgwLgxlB
	 XJOvW2xCv3m8S38fAN0CetypYhT0cCSPhMZxXSeTdRoSpxTPb/OS6uqXFu4hx50StswXN
	 K6YkLzlfk+Ow70sM67M1N4R2NTYYlHGlZmEmxCZmPJOqA5u5Ii9wWhva1C2WiGPRI4SH1
	 IB6VzrnsDp7/EIsNaQrB9pITfYPqtrmDr/hSGHbVWHw07HUXlHGwK5w0wyQl3jfoGYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PjI3pDfS;
	arc=none smtp.remote-ip=95.215.58.43
Received: from mta1.migadu.com (out-43.mta1.migadu.com [95.215.58.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092B606A325
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D092B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PjI3pDfS
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jXBhceP3FXuZJgFiHDC3WWIwTQ/bMGes850E8yWRlIg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795257162; v=1; x=1795861962;
 b=PjI3pDfSnuXwz7fH33xarOnVo/p3zFFthb3n6wt4B6MRS6HnjaxAXZmYS5esXaMY7IwAy+zF
 oW8XTGEnMli0OLA1IUqKFk/SEN3+lY3Dsq8hzXss7BRdpy6+GibQwaPp+D7o4SSJ0qokdrx1gtx
 nPv0Q/YabEeMn0ZZU1y+fQdc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0390872aa68e2c24;
	Sat, 21 Nov 2026 10:32:42 +0000
X-Mizu-Trace-ID: 0390872aa68e2c24
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Mattia Meleleo <mattia.meleleo@coralogix.com>,
	Michal Luczaj <mhal@rbox.co>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 00/11] fix misc sockmap issues
Date: Sat, 21 Nov 2026 18:30:01 +0800
Message-ID: <20261121103222.88209-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes misc issues in sockmap. Most of them are old.

Patches 1-2 fix copied_seq when a strparser is attached and SK_PASS data
is left unread, with a selftest. It was reported by Vega and comes from
my earlier fix, commit 36b62df5683c ("bpf: Fix wrong copied_seq
calculation").

Patches 3, 4 and 7 are old issues I ran into while reading the code:

  03  strparser is initialized again while the old one is still alive,
      after the parser link is removed and added back
  04  an ingress redirect queues an empty sk_msg
  07  sk_psock_backlog() takes the refcnt of the wrong psock

The rest (patches 5, 6 and 8-11) are the old issues that came up in the
review of Alexei's sockmap series [1]. They are not from that series, so
they were left for a follow-up.

Patch 05 returns -EBUSY to a second concurrent sender, and patch 06
rejects disconnect with -EOPNOTSUPP like TLS does. Both change what
user space sees, see the commit messages for why.

[1] https://lore.kernel.org/bpf/20261102072112.4160195-1-alexei.starovoitov@gmail.com/

Jiayuan Chen (11):
  bpf, sockmap: Fix copied_seq updates with strparser
  selftests/bpf: Add test for unread SK_PASS data with strparser
  bpf, sockmap: Fix strparser reinit after the parser link is removed
  bpf, sockmap: Fix empty sk_msg queued by ingress redirect
  bpf, sockmap: Fix concurrent senders on one psock
  bpf, sockmap: Fix reconnect with a psock by rejecting disconnect
  bpf, sockmap: Fix psock refcnt taken in sk_psock_backlog()
  bpf, sockmap: Fix socket lock taken on a child before accept()
  bpf, sockmap: Fix apply_bytes when a redirect sends only a part
  selftests/bpf: Fix errno expected by the wait send mem test of
    test_sockmap
  selftests/bpf: Add test for apply_bytes when a redirect sends a part

 include/linux/skmsg.h                         |   8 ++
 net/core/skmsg.c                              |  44 +++++-
 net/core/sock_map.c                           |  67 +++++++++-
 net/ipv4/tcp_bpf.c                            |  79 +++++++++--
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 126 ++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_strp.c   |  86 ++++++++++++
 .../bpf/progs/test_sockmap_msg_apply.c        |  46 +++++++
 tools/testing/selftests/bpf/test_sockmap.c    |   3 +-
 8 files changed, 436 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_apply.c

-- 
2.43.0

