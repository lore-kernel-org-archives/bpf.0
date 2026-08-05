Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0C42EEA1;
	Wed,  5 Aug 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942531; cv=none; b=pYpOJCXkqEZDq7/SKb2kqq6aKHWNsKFXO8yfpTEq/PymOLGKXvmKSs3KpZpa/3xhWtWpxTrLV2HkSjdnxVcomM3NbEidfyMnA0Ud60oeo2vs6o4fXvpicvES7tJbpcXO8r0KBrUnoWfPe9GnqGu/10grOVHnMLB7AIlAO+te42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942531; c=relaxed/simple;
	bh=IQfLQdClZMPZWBWuUP7MTmaessUwzjFwaPvlNJSzg54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oh/nqsvh6euJ3Pc3inU67xDW74jOH2Esx+LGIcd6fOvsShVZlVG+PcfIhP+MICaG/djVDD5q1EqsB9KeaA5/8fIWxDuykrZE5DbgHJT3L+oac18wSpl7x1MROSnIKatAy/zz5OoP8pFopT5uAYkPRc35KLkAtoT89DxO7UP19kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aJywKU/R; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aJywKU/R"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785942513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ARFtpgOT454Lo9ITBNeyHQKUU++b3Gc1sMwAfKESuoA=;
	b=aJywKU/RoubdNLur0gS5E0MRYqQUCEtlr47i7RrioDXJ8ry6AW4GzACLap8lC9o3XTj5mv
	XgVOjhZul1HKmuJO5MaRB0y5tRTUWKN1FQKZoLyY3f4/ilw53jr+PNZig2uVEC5ivWsk5I
	ZP3lpA3ypwZpA1wq8KIUnslB6hKzSA4=
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
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Viktor Malik <vmalik@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] bpf: Fix sleepable check for tracing/lsm prog
Date: Wed,  5 Aug 2026 23:08:08 +0800
Message-ID: <20260805150810.34907-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing prog
is allowed to attach to '__x64_'-alike prefix symbols.

It is because the verifier does not verify whether the symbol is a kernel
function or a bpf prog. That said, a sleepable tracing prog is allowed to
attach to a bpf prog target whose name has '__x64_'-alike prefix.

For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
prog, and copies buffer from a user pointer with bpf_copy_from_user()
helper. After attaching the XDP prog to lo interface, the kernel BUG
could be triggered by 'ping -c 1 -W 1 127.0.0.1':

[    3.460756] BUG: sleeping function called from invalid context at kernel/bpf/trampoline.c:1324

Similar issue could be applied to lsm prog, when the
prog->aux->attach_btf_id is in the LSM allowing list but the attach_btf is
a malicious bpf prog's btf.

Fix it by disallowing sleepable tracing/lsm prog always when its target
btf is not kernel's btf.

Changes:
v3 -> v4:
* Add Fixes tag for sleepable LSM case.
* Move btf check outside of 'switch (prog->type)'. (per Andrii)
* v3: https://lore.kernel.org/bpf/20260804145710.43062-1-leon.hwang@linux.dev/

v2 -> v3:
* Use btf_is_kernel() instead of passing 'tgt_prog'. (per Andrii)
* v2: https://lore.kernel.org/bpf/20260725132624.78373-1-leon.hwang@linux.dev/

v1 -> v2:
* Drop redundant 'prog->sleepable' check. (per Viktor)
* Collect Acked-by from Viktor, Thanks.
* v1: https://lore.kernel.org/bpf/20260724141422.10463-1-leon.hwang@linux.dev/

Leon Hwang (2):
  bpf: Fix sleepable check for tracing/lsm prog
  selftests/bpf: Verify rejection of sleepable tracing prog

 kernel/bpf/verifier.c                         |  3 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 57 +++++++++++++++++++
 .../selftests/bpf/progs/fentry_sleepable.c    | 18 ++++++
 tools/testing/selftests/bpf/progs/xdp_dummy.c |  6 ++
 4 files changed, 84 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_sleepable.c

--
2.55.0
