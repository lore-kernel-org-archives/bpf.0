Received: from mta1.migadu.com (out-124.mta1.migadu.com [95.215.58.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A213C5848
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728748; cv=none; b=OfoPFJPKTZOiVOTrliemDkbaKCBi4bRnvWIlYFqEQmEt4fksb+cIFfnUpZ94+fMJQiIG1dwH4Iwsm121YAmNPv4LK3ZfKcezxNL9xPE6h26porVyAqxVUckfrUq5Q3k9+BlwvlJbGdrnkz86AR0JTk6y02yn/1/OPk8aPENx6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728748; c=relaxed/simple;
	bh=NvRYYL0yYX5D+CIIYXISxMYW8nyH10DC4SsIu3RId7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGhTrbXIB2KVxRY77xZrKMZIfqfFQJ6FPW/bJUc5MiesU5BExjci8Y28f1sl0pzQMCXIpGCFm65ZQrgb1GUV+SazJQ4QgftUgJluunJJLGg/TurMuhMlzrzx4LFAWG+Iwvrs4VGRDEwLH6CEgTXHcSJJiani1PbogjZlNWUK4UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FPMN0D2x; arc=none smtp.client-ip=95.215.58.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FPMN0D2x"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NvRYYL0yYX5D+CIIYXISxMYW8nyH10DC4SsIu3RId7A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786728743; v=1; x=1787333543;
 b=FPMN0D2xuA9+2ThXozxCg3fEoGmxBkFi740Z7birpcidkMztoZbQJbI21NRwDIFwuVoQF+oe
 iazhVV6zjn2815Zbjx+F+DzJsGoitLLS04pGgswf8wf4bt1lGOHameUDSekZpFWVpTgc7bBeILd
 hKuLBX5SNHv24A3NJDhMI73A=
X-Envelope-To: bpf@vger.kernel.org
Received: from .linux.dev (117.20.149.103)
	by smtp.migadu.com with ESMTPS id 1cc4271eb4a5c820;
	Fri, 14 Aug 2026 17:32:23 +0000
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
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/5] bpf: Followups for global percpu data series
Date: Sat, 15 Aug 2026 01:32:01 +0800
Message-ID: <20260814173206.93082-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address some LLM reviews in
"[PATCH bpf-next v12 00/10] bpf: Introduce global percpu data" [1].

[1] https://lore.kernel.org/bpf/20260813152324.97937-1-leon.hwang@linux.dev/

Leon Hwang (5):
  bpf: Drop duplicate blank line in verifier
  libbpf: Avoid unnecessary mmap resize for percpu data maps
  bpftool: Update comments about skel data maps
  selftests/bpf: Avoid flaky resize value test for percpu data
  selftests/bpf: Improve readability in iter test for percpu data

 kernel/bpf/verifier.c                         |  1 -
 tools/bpf/bpftool/gen.c                       |  4 +-
 tools/lib/bpf/libbpf.c                        | 17 ++++----
 .../bpf/prog_tests/global_data_init.c         | 43 ++++++++++---------
 .../bpf/progs/test_global_percpu_data.c       | 14 +++---
 5 files changed, 41 insertions(+), 38 deletions(-)

-- 
2.55.0

