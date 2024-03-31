Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000D114534F
	for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711915436; cv=none; b=mD4Nj0pA9MGmvUpDBnuKUQKXhjI60qfQ7m/cs0G9DvzJU/pxwmmbKGbGLecUsFZmNz9ZpixaV5mKe6fDVlK1RWmgJd4rZWDCnXDzeQiw9YfAUkBxQEVTiiEg58K0CG5kASx499IYxGkKEvJHoaQlSbu+KOIUrz7ErWcoVb6pgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711915436; c=relaxed/simple;
	bh=l+TXHcBg5UfJdK/+qrd+Jay80oNs1nvkDKeGdEMVJLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dvgTD+sKlLcJth/++B4V/uwr44JFOY3trneAa6oZRWStxlkjG0unJiA0we9HF32MK3yMKuVv2uddi2xbEU8JJ1es1IolBXGLrvlaLp0DaUaHhv7KM2PkhZkOj38WTPb3Ac/lf6z8itM7zsw0EDv49uvDsPSV2NjPUm+ufJS91aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJG8E8Ll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJG8E8Ll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF493C433C7;
	Sun, 31 Mar 2024 20:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711915435;
	bh=l+TXHcBg5UfJdK/+qrd+Jay80oNs1nvkDKeGdEMVJLQ=;
	h=From:To:Cc:Subject:Date:From;
	b=aJG8E8Llk3fo/4pGU+xnJOsq19g0wRZPDBzfx7xwp73dVgwEayf/KZAG6+L/vBUTp
	 5OOhk+Z3TA2Qjc9+pVf8E6tRpczrwGqd7/FI52AreuMpz0PI0mGsBWsSna53GO1BKE
	 6FtXDCFpsgh8ImUiNVFvSMwJvwt/rIM+hSLaDTPPNa7yIb7hAO95KMaXLeSEzinJ1Y
	 G7M1fLXy9HKB8j+Akl3gSMathM8LEos5+c4b1tTniNj2AANJvFxO9SXtrzmSrYJY4G
	 dzZVWRtZVzdW7LausP0NK+/S9AExtiaXqBcS85DJLVDNDNQ44YXFGo22F8aUg1ySUk
	 ERN6X3uI9Ky9w==
From: Quentin Monnet <qmo@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Rameez Rehman <rameezrehman408@hotmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 0/3] bpftool: Clean up indentation and formatting in docs
Date: Sun, 31 Mar 2024 21:03:43 +0100
Message-Id: <20240331200346.29118-1-qmo@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rST manual pages for bpftool would use a mix of tabs and spaces for
indentation. While this is the norm in C code, this is rather unusual
for rST documents, and over time we've seen many contributors use wrong
levels of indentation for documentation update. This series simplifies
the indentation in the rST files by removing some unnecessary levels of
indent, and by using spaces only for what remains.

This clean-up is done in the firt patch. The following two patches
contain some additional formatting clean-ups or typo fixes.

Rameez Rehman did most of the work; I added a few fixes myself, rebased,
and formatted the patch set.

Rameez Rehman (3):
  bpftool: Use simpler indentation in source rST for documentation
  bpftool: Remove useless emphasis on command description in man pages
  bpftool: Clean-up typos, punctuation, list formatting in docs

 tools/bpf/bpftool/Documentation/Makefile      |   6 +-
 .../bpf/bpftool/Documentation/bpftool-btf.rst | 116 +++--
 .../bpftool/Documentation/bpftool-cgroup.rst  | 193 ++++----
 .../bpftool/Documentation/bpftool-feature.rst | 115 +++--
 .../bpf/bpftool/Documentation/bpftool-gen.rst | 338 +++++++-------
 .../bpftool/Documentation/bpftool-iter.rst    |  52 +--
 .../bpftool/Documentation/bpftool-link.rst    |  73 ++-
 .../bpf/bpftool/Documentation/bpftool-map.rst | 232 +++++-----
 .../bpf/bpftool/Documentation/bpftool-net.rst |  98 ++--
 .../bpftool/Documentation/bpftool-perf.rst    |  34 +-
 .../bpftool/Documentation/bpftool-prog.rst    | 426 +++++++++---------
 .../Documentation/bpftool-struct_ops.rst      |  71 ++-
 tools/bpf/bpftool/Documentation/bpftool.rst   |  60 +--
 .../bpftool/Documentation/common_options.rst  |  26 +-
 14 files changed, 876 insertions(+), 964 deletions(-)

-- 
2.34.1

