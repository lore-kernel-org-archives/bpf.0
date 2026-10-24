Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792856184;
	b=EDApJvH5Eve6GiKj/6zhit1weifitt//vZUokQwT4uZeTH0o6vb4gQ0IHE1SDD++R/L0
	 iPJ8VMVsvwSdZ+eMlKTJ8h5v+/0nEdXGgSDB+GW14Ti5WJm2bsLJa9MI7F9CkHUBVvXDz
	 GhTLB4ngoIR0o+rAiRnrGCzQMz6qxoHrnVG0Kch8/Tk7uWUL+/V2ja9KQDRot9sPi0lm5
	 QdSaq/iIIMsag3BzY1FT8C+Jx0n7/76T23fqccVUqxBnbv8xKXzRxVK56Vi0OxhSvfq8B
	 edJfu33+XrmzFjJZwfwdi832JgnOXu5HFUABKW56yjui3dCpRwDReOqErMLm9QP23IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792856184;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SU23wimUV2O9Kr887mHEYzQkX67Pl7prB5aGY6kmyZg=;
	b=WQw9WAsd4joOsK97JEOkyP+VUikzvC/BTwBzBannaHvt98Bri7RVmUMRvNeRM9QSeHwG
	 FIi5pnaRR8rAWpISoLSNQrEWCOS4/Nncj671p5zdmH6cxusjJ3e1RSZy6AkRfd2FNJGEu
	 S2L1t2zWpbNcn7YJyUpeJz1LhOWt5N/YWW58F6dO9K5kdpLjkKUFytK7wOMyFQjMgKTb7
	 2uky64rchR0tVOIm0Rhr17prGdiIqdNjgnh8SNAbAqsUeqiGcKO5GDtkJcuEdV7mLkq/d
	 DZLmRqcGWhpPZSPpqdrVHfW46lKXwLbHVMQl5y5F/PYUvr6/Xh2pEHU6R4abPHnb+zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QHdmibg0;
	arc=none smtp.remote-ip=95.215.58.206
Received: from mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6806606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 15:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6806606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QHdmibg0
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lkiUzgBYqoo5dMOvB4u6X+W6b0S+xloWwMi5V8DIHqk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792856180; v=1; x=1793460980;
 b=QHdmibg0jG1pCFe5ZFZzMhX5Sv1evbuKASSWMjZwVudmiyfFomtjK/VfxAxchXRSRoXB93TQ
 ZyTAorHIs0bEvpCvUTAghu2WYTM5yrEaboOj61VHMd2MytevsW526VY0ABKtKvqP6TYIUAYdH7e
 lCAnDB9urD2hQWc/fyKM9ERY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1700512b1c0e2c8e;
	Sat, 24 Oct 2026 15:36:20 +0000
X-Mizu-Trace-ID: 1700512b1c0e2c8e
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
Subject: [PATCH bpf-next v4 0/6] bpf: Add syscall common attrs support for xdp link_create
Date: Sat, 24 Oct 2026 23:36:01 +0800
Message-ID: <20261024153608.58569-1-leon.hwang@linux.dev>
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
 kernel/bpf/syscall.c                          |  43 ++++++--
 net/core/dev.c                                |   7 +-
 tools/lib/bpf/bpf.c                           |  61 +++++++----
 tools/lib/bpf/bpf.h                           |   5 +-
 .../selftests/bpf/prog_tests/xdp_attach.c     |  65 -----------
 .../selftests/bpf/prog_tests/xdp_link.c       | 102 ++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          |  54 ----------
 9 files changed, 190 insertions(+), 167 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c

-- 
2.55.0

