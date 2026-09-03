Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229C3AFD1C
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427245; cv=none; b=gNoSByL2UAkjaxPdoZ5r+0Jx8XuKTbbwqvuB7Dv9ma0nPVZpLGW9i3QaYZ6qZhSc3uD77TEiFAMQEba5mL39h6g9u2V+Y+JUkrjIvNvEu5hf11y/Pfn8TEyX+a0kh8d155GF0dqbbzxFC/Jyzl4cUwjqHHUc74TdSDpw8QLA9L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427245; c=relaxed/simple;
	bh=ZB3rShCGe31x2t2U+t8rTPNPd1uNHOg0bSY76Hosir0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvhMwS+WPZFBT5Q1akByjeSvnPS6DbdZ7BVE+MYG5vupxOtznVcma/fcN9heonZbBV/YxUmEXO2Y8HABnSrCN+Tpjl12uxHdrtpS3x6nvg1B6ddAx2WKyR0LW1Uh+UCF4FNnufVjKgzNXoN+6eMPBroFlxYztMEdRHlGxKkX8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRsxaNNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRsxaNNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7401F000E9;
	Thu,  3 Sep 2026 09:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427244;
	bh=sI101zL9GNfVJF7SeHYp/pIYAItH5rCxG7A1jYUE8sE=;
	h=From:To:Cc:Subject:Date;
	b=VRsxaNNhcjNeQIU0NwFdHluPAL+Doe9Zlad6K1RhEYRtvy7bWBeLfIQQoG4nSOQZK
	 qelUroSf2k1Vt5peSXuM0BN44Q2Lr7uUMLIFrlQU3LW/ArS4GzAcbBnOss5Cgwbb3R
	 m0nVe0WKLGHZRemNvN5X0/73GWCg2ydPCPjDG8MUvpnhVO05799LSnSnvUW4fFilYu
	 TQnhe8K9W05CQhNlVCnGxfh7YeG1q1u9oZsDPr5h+/lTYOwwRxed8lcW0T3L0RipdV
	 qYZmBtF1NfL3ywDtVBBIquFKeJirPpp0dOc3b4UCmOxjzBjr/Ou/qHyg7IZ/L0+ZO4
	 wDSNYW5agyiEw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCHv2 bpf-next 0/3] bpf, x86: Add jit dry run mode
Date: Thu,  3 Sep 2026 11:20:36 +0200
Message-ID: <20260903092039.477827-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we recently hit performance issue in arch_bpf_trampoline_size,
that Mike fixed in [1].

I wondered we could go completely without emitting jit code for
getting just the trampoline size as we do on arm and it turned
out it actually makes the tracing_multi attachment benchmark
much faster.

With current code:

  # ./test_progs -t tracing_multi_bench_attach -v
  ...
  serial_test_tracing_multi_bench_attach: found 55227 functions
  serial_test_tracing_multi_bench_attach: attached in   1.563s
  serial_test_tracing_multi_bench_attach: detached in   0.256s

With the fix:

  # ./test_progs -t tracing_multi_bench_attach -v
  ...
  serial_test_tracing_multi_bench_attach: found 55235 functions
  serial_test_tracing_multi_bench_attach: attached in   0.798s
  serial_test_tracing_multi_bench_attach: detached in   0.258s

thanks,
jirka


v2 changes:
- drop out label in emit_mov_imm32, it's not needed [ci-bot]


[1] https://lore.kernel.org/bpf/20260818130510.3110054-1-rppt@kernel.org/
---
Jiri Olsa (3):
      bpf, x86: Split x86_call_depth_emit_accounting in two functions
      bpf, x86: Introduce JIT emission context
      bpf, x86: Add support for jit dry run

 arch/x86/include/asm/alternative.h   |   4 +-
 arch/x86/include/asm/text-patching.h |   2 +
 arch/x86/kernel/alternative.c        |   2 -
 arch/x86/kernel/callthunks.c         |   7 +-
 arch/x86/net/bpf_jit_comp.c          | 869 ++++++++++++++++++++++++++++++++++++++++---------------------------------------------------
 5 files changed, 383 insertions(+), 501 deletions(-)
