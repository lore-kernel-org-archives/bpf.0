Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233310;
	b=OulrvrBUos+WtOz12o9XuS5NcaAgk0jQ0FXXHdP57frFnDpuvHTWN6v4k5x2UdfttTLX
	 I1ppqOWEbnEANmJsYeMZeIX0B/FdzbQc2I/rzH4F6Gb9/5wz1ro2+1KSMHea5zgej7Vzd
	 31fcL2sA27CL4AlKMiOFQJHDfyHuxG298rwHihXF30UsIRc2bVZe96AAMmCk/sHiIBvym
	 ERdzRSobhVDAZUkmHWI/yDa6x1pfGVHU8RhlV7Mt9xqvaRFJaDx/Sz4ExI5zQ+wBlE1J8
	 QbJ/8yXgml1I50CwQtg8UQXeljL6VJ8JNKGDNNorHV7kRAuMOzjHt11zt7Vympk33AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233310;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nMfShMoTWWZnzsnuXz7dZMMK1Ty2nWujG10KYlZdues=;
	b=2X2lbylqgi4Hxtu1g8LfNmUI2Gu+qW8hCsBYBfr83w0IPHS1Jy0T6zquaJxkqSYq0gSU
	 U+q/hbR/RKu+DuA+Dl4WohffKD1ZjV5KigS63sRTQgcshsUviR2ioUwykZgzf51zlBa6s
	 OLYb4OdM+P24OZJTpyAz1xpA6ooxDHrVz70Bp+NMs18XEggJbIV5IdAgnzt412DJjhK6X
	 XX6uuatxWnevIpqZBbt/d6pu7T+WT0tsM9JQV6ZnGoI1avNDsiCbRRji132oeH4vppBy1
	 vxS/ibtCKmQ/8TVnVDkBdIpd2ACd57LZVIdTGpXBVguVxc3W/DGfDxKzyDzmZvewn7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Zih1Nypg;
	arc=none smtp.remote-ip=91.218.175.165
Received: from mta0.migadu.com (out-165.mta0.migadu.com [91.218.175.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF19606D806
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 14:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FF19606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Zih1Nypg
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=od9iAb6nN4npUfkIdrpGNq33ktulcg+4meU3VJi0/YM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794233306; v=1; x=1794838106;
 b=Zih1NypgBkrIfUFE7W935KqWvPgHOj1qCug/vkFsewJ6uTBIONAicMmbYcArKwmsk3MSAH/Y
 oBbVCrd3g9C5RBDIBqvS9vS8Qpi1ldtu3yyFM4heyVuDKUBvza2BNQQCnTrUy0/Q4GGD+K4vVe4
 isJKj08Oh6qgFo/ee9XTVb2Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4ce0702978e98536;
	Mon, 09 Nov 2026 14:08:26 +0000
X-Mizu-Trace-ID: 4ce0702978e98536
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 0/9] bpf: Add log support for tracing link_create
Date: Mon,  9 Nov 2026 22:08:07 +0800
Message-ID: <20261109140816.5196-1-leon.hwang@linux.dev>
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

I'm adding syscall common attrs support for LINK_CREATE cmd.

This is the second series for the plan, that adds syscall common attrs
support for LINK_CREATE of tracing prog and cgroup prog.

BTW, address Andrii's review [1] in patch 5:
1. Change if (!OPTS_ZEROED(opts, iter_info_len)) to if
   (!OPTS_ZEROED(opts, log_opts)).
2. Add comment to iter_info and iter_info_len that they are
   deprecated, and use iter.info and iter.len instead.

Links:
[1] https://lore.kernel.org/bpf/CAEf4BzbW4zwL-9j8e2B6KNXVNwsfWyMSAo_RsGCqv-nu_yGhTg@mail.gmail.com/

Leon Hwang (9):
  bpf: Add log support for tracing link_create
  bpf: Add log support for tracing_multi link_create
  bpf: Add log support for iter link_create
  bpf: Add log support for cgroup prog link_create
  libbpf: Add log_opts support for BPF_TRACE_ITER
  selftests/bpf: Verify tracing link_create logs
  selftests/bpf: Verify tracing_multi link_create logs
  selftests/bpf: Verify iter link_create logs
  selftests/bpf: Verify cgroup prog link_create logs

 include/linux/bpf-cgroup.h                    |   7 +-
 include/linux/bpf.h                           |   3 +-
 include/linux/trace_events.h                  |   7 +-
 kernel/bpf/bpf_iter.c                         |  27 +-
 kernel/bpf/cgroup.c                           |  76 +++-
 kernel/bpf/syscall.c                          |  28 +-
 kernel/trace/bpf_trace.c                      |  26 +-
 tools/lib/bpf/bpf.c                           |  17 +-
 tools/lib/bpf/bpf.h                           |   8 +
 .../selftests/bpf/prog_tests/cgroup_link.c    | 324 +++++++++++++++
 .../selftests/bpf/prog_tests/iter_link.c      | 132 ++++++
 .../selftests/bpf/prog_tests/tracing_link.c   | 377 ++++++++++++++++++
 12 files changed, 979 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iter_link.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_link.c

-- 
2.55.0

