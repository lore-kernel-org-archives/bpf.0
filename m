Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.234
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029808;
	b=EwrwAEikfLBF/39ghw/Ygiuk7L1OIjQybLd7rYbNH1QpCMu2QMk1ibURFmp58If/ggFG
	 PLllluKlL/jhD6StYU3ecYMs1Dl6FAicNHk8K7DY1GFhmI8myqkEakSpxSDK/F71k1NXs
	 RGjPYbzWDt6Sce1n09NF+qMZDtQvu34sHti2RZKJIPupC1G37cCRhCLzsWvYBTdO2Bf5+
	 OMeENb/VCWIqoHJa5E30j2JeaDEhIpuvnr2JGtZfBg8wB8PEZLS1tUwpNsoAO5bxb1vp3
	 4wam0xz6DnwHKyOQ/oREIw5H/VbrEobGZdA8nmMro0lOJ+IZY3c0XR4TgqcxEv/3Ebw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029808;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WpSLr0mnkD3A26BLviDmf8/ukvUES6KQGLkx6go5JLU=;
	b=MOwhy1DZMJcszaX09OuNsDGe9SN6TgYLGzV+EWUxx+PQL+X9NuHBSEJhQrhb8o8DuR8V
	 20JcEmpSOEl0P6/hjo/x5+/wBW5ZsZYYNu0raGeb1zmVqE+1Gp3lYsLm6VhXVfjAsZ8Zt
	 Y1kOacq1YZZq1CI0dZPtG4iJgb0IYsaVUJTA0PM5F/hcoeXgQcjbE1y83L9wrQFJK/SZg
	 1dXZPq/loDVJ8oSF/PFY4ArKcO55QDP1g8oLU8ybugPIfU3K93ONlgMbQ74CThPr8dTIY
	 QpTpfaEm5I7fNcw+eXs04VeZy1kAQP1o2UJM4m7QuVcw0L8MXkn8153YRSpdr/jHPlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wERNDmkS;
	arc=none smtp.remote-ip=95.215.58.234
Received: from mta1.migadu.com (out-234.mta1.migadu.com [95.215.58.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811CE606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 15:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 811CE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wERNDmkS
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=st2/QlNSvQzde1SErsdmz3PrDCKyO8sDhyBvEgAtY4M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793029804; v=1; x=1793634604;
 b=wERNDmkSQsNMGtxAXHQSvdro28RTP2fqUsr0p0arU1RAJuhbqHs9wIB7iBydn1jFxgnxbYxU
 io5WQC2ozLBN0+jc4CC6955qVEWp7OZKdPr5wSBv/F3bhnDzXhUlxR1aCqMw8oPj68qWGyV9oV6
 hjnP1BaMiKjuJurml9+pJFCs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1aaa5aa80541b88d;
	Mon, 26 Oct 2026 15:50:04 +0000
X-Mizu-Trace-ID: 1aaa5aa80541b88d
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Masashi Honma <masashi.honma@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v5 0/6] bpf: Add syscall common attrs support for xdp link_create
Date: Mon, 26 Oct 2026 23:49:41 +0800
Message-ID: <20261026154948.99408-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
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

I'm planning to add syscall common attrs support for LINK_CREATE cmd.

This is the first series for the plan, that adds syscall common attrs
support for xdp LINK_CREATE.

Thereafter, retire the tracepoint bpf_xdp_link_attach_failed, because
the underlying driver's error can be back-propagated to user space via
the syscall common attrs.

Changes:
v4 -> v5:
* Pass extack instead of errmsg pointer to bpf_xdp_link_attach(). (Alexei)
* Move cmd as first argument in __sys_bpf_fd() helper. (bot+bpf-ci)
* v4: https://lore.kernel.org/bpf/20261024153608.58569-1-leon.hwang@linux.dev/

v3 -> v4:
* Pass errmsg pointer to bpf_xdp_link_attach(). (Jakub)
* Place log_opts at the slot of iter_info in libbpf. (Andrii)
* v3: https://lore.kernel.org/bpf/20261020152804.39863-1-leon.hwang@linux.dev/

v2 -> v3:
* Drop bpf_log_attr_report_size() helper. (Alexei)
* Drop 2nd write for log_true_size and the put_prog label. (Alexei)
* v2: https://lore.kernel.org/bpf/20261019153628.15912-1-leon.hwang@linux.dev/

v1 -> v2:
* Add log for invalid prog type in link_create().
* Reject log_opts for fallback bpf_raw_tracepoint_open() in libbpf.
* Report log_true_size as 0 before creating concrete link, and report
  the actual log_true_size when fail to create the concrete link.
  (Sashiko)
* Add stub bpf_log() when CONFIG_BPF_SYSCALL is not set. (bots)
* Check 'extack._msg' before adding 'extack._msg' to log buffer.
  (Sashiko, bot+bpf-ci)
* Change __bpf_sys_fd to __sys_bpf_fd in the subject and body of
  patch 4. (bot+bpf-ci)
* Move OPTS_VALID(opts, bpf_link_create_opts) to __sys_bpf_fd(). (Sashiko)
* Move bpf_link_create_log to the LIBBPF_1.9.0 section. (Sashiko)
* Update patch msg with a concrete case in patch 5. (bot+bpf-ci)
* Factor out helpers to simplify the tests code. (bot+bpf-ci)
* v1: https://lore.kernel.org/bpf/20261017142649.51047-1-leon.hwang@linux.dev/

Leon Hwang (6):
  bpf: Add syscall common attrs support for link_create
  bpf: Add syscall common attrs support for xdp link_create
  bpf: Retire tracepoint bpf_xdp_link_attach_failed
  libbpf: Factor out __sys_bpf_fd helper
  libbpf: Add log_opts support for bpf_link_create
  selftests/bpf: Add tests to verify link_create logs

 include/linux/netdevice.h                     |   3 +-
 include/trace/events/xdp.h                    |  17 ---
 kernel/bpf/syscall.c                          |  41 +++++--
 net/core/dev.c                                |   8 +-
 tools/lib/bpf/bpf.c                           |  61 +++++++----
 tools/lib/bpf/bpf.h                           |   5 +-
 .../selftests/bpf/prog_tests/xdp_attach.c     |  65 -----------
 .../selftests/bpf/prog_tests/xdp_link.c       | 102 ++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          |  54 ----------
 9 files changed, 187 insertions(+), 169 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c

-- 
2.55.0

