Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378A69DE4
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084745; cv=none; b=Sd4m2jYIehhjTOD8nQNOIBnj6fR559IYpp+H/d76K9Dt0BtCPIEqdarbyMI2CF8UYKG0IkBEQRi0T8GR6C/B+BnezIpwPKum6i7uLRv7W5BXHbnKDi3OrWU9dHmKIbXQcYg1w/RpjCahmf0eXUd7HTvYD/g1p1db83xIHxkc5DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084745; c=relaxed/simple;
	bh=HI/TsB1tHZyWZj2JEJcxFsOTxMSTW4U8TtLDx3tv5XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mpi0sO2VZTL5fDxZG4/6EgcNhpPe+YOiUyMi8ZdHUAV3ClQDbOM1zr1jTuZBtsunMY3sD7wGuaIkbmSTnNV95SxVHBf28xtw+n4hJnjyZlW/Ur43ntD035MJGXuzj2VhyF6ywRSlRqRtwzMWUGLRRiDfCJkTTkfOariD9F7JhDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BptTO++3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BptTO++3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A68C433C7;
	Tue,  2 Apr 2024 19:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712084745;
	bh=HI/TsB1tHZyWZj2JEJcxFsOTxMSTW4U8TtLDx3tv5XU=;
	h=From:To:Cc:Subject:Date:From;
	b=BptTO++3t73G4UQ4BRKJAnrZtEJFW2UkXGxBLcpvLbjZ/4Wte5uSveiYN/pLisYIc
	 rd4EeWFTbtmHKBh42gaZ7xinqminPJwv4djuwz2pnR8c9mOSbC1q/a1VvLp5SvDoV8
	 Mhf4DtxXRkDjiCj+C+r/wxNHxV912bdzV5aB8dMAIZ1bVosZp3I3ChiIKBPvYpm46A
	 R1uROPqIDBUg0nF6yh/C579Tm97dle26w18c+c7g1IzZUTtcs//LXkPo4xVmcE0PRV
	 k3g6QsvlTGhgIJlO64IIQSqDPxRhtdKXKDPeLOlOchoFrKg9StwWUHYUFvPClgCGIq
	 vvukY2/TDZkcQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/2] Inline bpf_get_branch_snapshot() BPF helper
Date: Tue,  2 Apr 2024 12:05:40 -0700
Message-ID: <20240402190542.757858-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement inlining of bpf_get_branch_snapshot() BPF helper using generic BPF
assembly approach. This allows to reduce LBR record usage right before LBR
records are captured from inside BPF program.

See v1 cover letter ([0]) for some visual examples. I dropped them from v2
because there are multiple independent changes landing and being reviewed, all
of which remove different parts of LBR record waste, so presenting final state
of LBR "waste" gets more complicated until all of the pieces land.

  [0] https://lore.kernel.org/bpf/20240321180501.734779-1-andrii@kernel.org/

v1->v2:
  - inlining of bpf_get_smp_processor_id() split out into a separate patch set
    implementing internal per-CPU BPF instruction;
  - add efficient divide-by-24 through multiplication logic, and leave
    comments to explain the idea behind it; this way inlined version of
    bpf_get_branch_snapshot() has no compromises compared to non-inlined
    version of the helper  (Alexei).

Andrii Nakryiko (2):
  bpf: make bpf_get_branch_snapshot() architecture-agnostic
  bpf: inline bpf_get_branch_snapshot() helper

 kernel/bpf/verifier.c    | 55 ++++++++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c |  4 ---
 2 files changed, 55 insertions(+), 4 deletions(-)

-- 
2.43.0

