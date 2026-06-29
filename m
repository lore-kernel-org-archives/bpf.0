Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14EA356767
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743932; cv=none; b=GHcQTO9C8EjlTaZgrnGWLx90LNboP6UFcdZYIommfGKSoX95SQA6Sb0OO856V9H/MHkGLLzWcrY1MwqHqhP1qR47pOP/JBed80LQv9Sye79rNDCY3KCuz4Q7FpUR937nAJmyJeCn0/4IeVF/UqgfZOJoVpm4GMNBcRAdPMTrxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743932; c=relaxed/simple;
	bh=HyK6/2Fq0N4GlAzH7LfDGAi5PN1+aH3MycftfCgUUck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cr/xKIST4rdT6+H/YtCoRiBPblvXPQ2W/19J9Hk/D/PdjL0zwKIKv6coZ0+26qfo6RjOkrpHflmTzvGI8F/aJDsSOSL93gdkYuWPz4MeSuqr1WivrjyKpC43I8JVOSqhe9rien7hqp55NH1AJPcT3dLVhB+S3RhTVCszIuA99cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PysI31+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PysI31+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1361F000E9;
	Mon, 29 Jun 2026 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782743931;
	bh=OEFxQ3TjzgLLP+xAavU/6S5tek39pLJ98IoxA9i3enY=;
	h=From:To:Cc:Subject:Date;
	b=PysI31+g22kDLArxflC3FbLHHsMnbRydpnBKk5Jyx074zWlElGHBZcoHIjaxUPgRq
	 ai6fhtZHAcO8PyRMn1p/AXurXr8zFzzT5NC2ngj9nl0JTkyYJToQ9vfUHeWqQ8E240
	 P7gXFZoyyg+vaK7o41i7D95oNm3fBfaRLXzSNXJrY57Tp82S/zp+Hst2VMqIVS2qnY
	 fedTO5LBx1JfgqWGSnIDGeZj3hSa1xcEKO1nRSxKC8ew6M2gaFIbeuV1bnzHA8eJKh
	 xbL0RKz0FT+z6sm8i0fbRGi+ySKJH9YL2sPLeKs8MHUP2tQJ/UH8RTXy+LqFlaFPxq
	 LgEqpop3BBhDw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCHv3 bpf-next 0/3] bpf: tracing_multi link info support
Date: Mon, 29 Jun 2026 16:38:41 +0200
Message-ID: <20260629143844.862369-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding link info support for tracing_multi link.

Adding the kernel support with related selftests and bpftool support
to display the tracing_multi link info, the output looks like:

  # bpftool link
  ...
  61: tracing_multi  prog 167
          attach_type trace_fentry_multi  btf_obj_id 1  count 3
          btf_id           addr             cookie           func [module]
          92598            ffffffff825017c4 10               bpf_fentry_test1
          92600            ffffffff82503814 30               bpf_fentry_test2
          92601            ffffffff82503824 20               bpf_fentry_test3
          pids test_progs(1540)

thanks,
jirka


v1: https://lore.kernel.org/bpf/20260621204524.61067-1-jolsa@kernel.org/
v2: https://lore.kernel.org/bpf/20260623142417.275892-1-jolsa@kernel.org/

v3 changes:
- added acks [Andrii, Leon]
- display cookies as decimal numbers [Andrii]
- renamed obj_id to btf_obj_id [Andrii]
- several fixes in bpftool change [Andrii]

---
Jiri Olsa (3):
      bpf: Add tracing_multi link info support
      selftests/bpf: Add tracing_multi link info tests
      bpftool: Add tracing_multi link info output

 include/uapi/linux/bpf.h                                |   9 +++
 kernel/trace/bpf_trace.c                                |  55 +++++++++++++++++
 tools/bpf/bpftool/link.c                                | 133 ++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h                          |   9 +++
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_fill_link_info.c |   6 ++
 6 files changed, 454 insertions(+)
