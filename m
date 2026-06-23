Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62C384CF6
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224663; cv=none; b=bu2bZBxIYwTj90a1YGnxFt2yjgq8B7IIrT8Y2QSr9PdfBJw7Y3Czcoo5iFmPiVPjEwCyhJnJut2ttkUIGbo1CASGrrZ9nrT1OJ1nyzyqNlKUvYC7kEvi10YMe/AlArQm9jSzhqtkjSy/RP2pOqa2/l+EFq9mbKX3UjmWWRJBxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224663; c=relaxed/simple;
	bh=c7+uUjKq0Kn3DX5pnYiw5pPNnw73KqEGRZznlbon9ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZghYdp8MvKqqykck+bEI3OF28Ou3A4EHlmY6Rs0NdrnIhjAAezlq2IAoJfYSmSW46jP6LZzja9H5cxs1LZosA1kkgnoGvITs9l31Uz+mIMJSiXuRgTRKfAkMssOAd2d/WnPUxi/ucPUwJplVm9wSf5uTI0DEOZ3vvW0UlK9JUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF5o/n23; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF5o/n23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DAF1F000E9;
	Tue, 23 Jun 2026 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782224662;
	bh=cn5PLGdOt8ITXiLMJqaoVEA2UkG8y2PoyGnjW6tmhHY=;
	h=From:To:Cc:Subject:Date;
	b=jF5o/n23RrkgL2YCI96d9xBG7q8dslHiVBxJps4JyHcmapSu87VDFegU/+AbKWzaj
	 dH1DzlPCk4xpsJtkme6BOZvJLsn4WUWTiiWa+828XPCXjgOenchl2GRLwT2nfny9er
	 BhQdhWieuqITI+h64E9wQ1mC9Vzy6jkRkrUC8s+FOn5MfeJj3kqVL27vapM+AR5Sjd
	 TB0ncAB55DeJrjIGWjtFOhBC5chSlHFJmX3VfJWiXWaynzt/1lJCqdBWY+188t4e2L
	 ZLISn35SeHpMnrgU8NpWXQ/lvCFgC1ZiSJbvKLsB2XbMdOue3+2Sp1EFFnyPmjJNn8
	 x8jbywpZeoaDw==
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
Subject: [PATCHv2 bpf-next 0/3] bpf: tracing_multi link info support
Date: Tue, 23 Jun 2026 16:24:14 +0200
Message-ID: <20260623142417.275892-1-jolsa@kernel.org>
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
  27: tracing_multi  prog 93
          attach_type trace_fentry_multi  obj_id 1  count 3
          btf_id           addr             cookie           func [module]
          91984            ffffffff824f4a24 a                bpf_fentry_test1
          91986            ffffffff824f6a84 1e               bpf_fentry_test2
          91987            ffffffff824f6a94 14               bpf_fentry_test3
          pids test_progs(1462)

thanks,
jirka


v1: https://lore.kernel.org/bpf/20260621204524.61067-1-jolsa@kernel.org/

v2 changes:
- fix kernel symbol search logic [sashiko]
- typo fixes [bots]


---
Jiri Olsa (3):
      bpf: Add tracing_multi link info support
      selftests/bpf: Add tracing_multi link info tests
      bpftool: Add tracing_multi link info output

 include/uapi/linux/bpf.h                                |   9 +++
 kernel/trace/bpf_trace.c                                |  55 +++++++++++++++++
 tools/bpf/bpftool/link.c                                | 137 +++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h                          |   9 +++
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_fill_link_info.c |   6 ++
 6 files changed, 458 insertions(+)
