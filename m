Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592840D587
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782074730; cv=none; b=GdMOSQFJWeE0MZaR72pS0fQFx3bLYfxfit63UboMmkMrLP5BjUkeqU43HEtT8q17hdmPLsZrM8cpBK4FvbkI5NK7psuyDEPf0P5u+Q9AESpaaPaqhBilEGzx9p/e3wteeCB5rgfsYZ2FxhdnDG564VZSxBC5rBh3GpAkq4UdMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782074730; c=relaxed/simple;
	bh=6A2Yu0LvTUbDAmjiNLejIucUCoJubQ33wgMN4uXhdOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ctkhh52NsBC+TJFed0SyJvVWrAoWLEy6jil9hZFtyqnrBnhxN1bZaoLmbKB81wyJBn/ytxBpj0z0he2j9pXdtLbfYqOL6nybKhOcEqedSKYQeR4k42QrBl3l8yrR+I8HEepap6E7O36TKDH83mth2Jkh8Z9BBjUVtExpCnvF5q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKFT49p8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKFT49p8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DBC1F000E9;
	Sun, 21 Jun 2026 20:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782074729;
	bh=fdS09Z56jc07JvN0EDd9zdXAMgSKOS1/VNrQLcKMzTo=;
	h=From:To:Cc:Subject:Date;
	b=JKFT49p8vdXIBKpDWORJoLNzNMlFD1BJ3e4Gv8zqDt9yDW2XPLAoiSzuaOLytRZQp
	 63M/RG8zoytwDJ2Pug6Qfnu7KCx4hn/GiLFTlXAsrkmpw5g51DoDFimAa80+r4gya8
	 gDQXZY2YDP7oIJvpe73KCvDEuSoJzhqFh6LZ+MZ5t7cUOzJAHSn7/nc17CA3lr3JBz
	 n4ADAQKUt/tdC7s6a28Hh4NIRDNodzes2WbJOPbB3k7tMhQILoGhSTeWhu+oWZHGza
	 5I1V0ezg48vcURl8/WiA5FDAvU991U6/o8lXpSRZ2J0eRmBVv1PaHtC7QbzKoTSdDj
	 53Zbs8If2Fzeg==
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
Subject: [PATCH bpf-next 0/3] bpf: tracing_multi link info support
Date: Sun, 21 Jun 2026 22:45:21 +0200
Message-ID: <20260621204524.61067-1-jolsa@kernel.org>
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


---
Jiri Olsa (3):
      bpf: Add tracing_multi link info support
      selftests/bpf: Add tracing_multi link info tests
      bpftool: Add tracing_multi link info output

 include/uapi/linux/bpf.h                                |   9 +++
 kernel/trace/bpf_trace.c                                |  55 +++++++++++++++++
 tools/bpf/bpftool/link.c                                | 135 ++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h                          |   9 +++
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_fill_link_info.c |   6 ++
 6 files changed, 456 insertions(+)
