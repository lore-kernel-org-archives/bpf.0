Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA13064B2
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784986036; cv=none; b=cpx3fqOb1fQKvPuyBDDS3sbntE4eJzFNDQSjdEZhWT+ODiM6aMz+bP8zmDSajcfHrbnHGNsrVBlStyu9SHXmIZLyfdNHJu+WN95zMXpXF4aG6PPVIDJdyDFGZ23qPiTWpGwhfVwrH2lmhX4YxZdnpUwMi3tm0UWVtxAsZkzh4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784986036; c=relaxed/simple;
	bh=dXnO2CVcVShG8lP+gpd8VYYjwBsfavrtuqXmi6o1zdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shkTttDxTwv1iNlTbYri2b+zrQPhvFMLDstwZtiBOcuRcIAz/nLd4H4IfssQmX/S9K/50leg6+Q/EhuHw6OseMc6JtdsuPX7xe7m0bHh2roxv0F//LsFtKgl8KitPeKeQrerF0p41YhtE1SLo66fbOGH2SU9U1t2Gr6yewOy9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LvT3B+tC; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LvT3B+tC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784986022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GlVzZJS0JTsV98D/V1kP7SM0ZnBbLTv2sUFIA2Id9Mk=;
	b=LvT3B+tCQVTCVDHWaj4oWobopdhM4Dsq2DWL05AOewKFErmevCAuZaV9+YVcutUex85isB
	hieRII+6QQEbRGQjfbNPKBQQ5pV7hBDRNI9ldnA0E1tJB09n7DgoQiMy+lSndZm8pchore
	eDV3x1YvvkFrh+rzf3qkwA8+jcKP8B0=
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
Subject: [PATCH bpf-next v2 0/2] bpf: Fix sleepable check for tracing prog
Date: Sat, 25 Jul 2026 21:26:22 +0800
Message-ID: <20260725132624.78373-1-leon.hwang@linux.dev>
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

Fix it by disallowing sleepable tracing prog always when its target is
bpf prog.

Changes:
v1 -> v2:
* Drop redundant 'prog->sleepable' check.
* Collect Acked-by from Viktor, Thanks.
* v1: https://lore.kernel.org/bpf/20260724141422.10463-1-leon.hwang@linux.dev/

Leon Hwang (2):
  bpf: Fix sleepable check for tracing prog
  selftests/bpf: Verify rejection of sleepable tracing prog

 kernel/bpf/verifier.c                         |  9 ++-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 57 +++++++++++++++++++
 .../selftests/bpf/progs/fentry_sleepable.c    | 19 +++++++
 tools/testing/selftests/bpf/progs/xdp_dummy.c |  6 ++
 4 files changed, 88 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_sleepable.c

--
2.55.0
