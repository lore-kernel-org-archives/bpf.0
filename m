Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9F36E46F
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774788279; cv=none; b=oUuLJKcrC18DQMWyQpcE4coX7nh3hxSw8moS8CLjjITQtEHNevyYKz4Yy4FrH+a9Lh1MnzEb4IHXv7pkkXJFEUFM1PJ95b7UnV6uh59YNkg9qqoKzSCz40r+LP4Z6RMaLUgV6HuDWLVYBm7TWZPeW2YQc4yArn/BXCsyfulGWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774788279; c=relaxed/simple;
	bh=Rmh3Y+JrArpJE7iqH6JLEcKEfdpuVbpvkJS7lyIHjzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDmDQ8KcK9j46I75b0GTtOadK7JJSgFKNIHjFpdzHoarahs1g0aCvPOUjryjytxEO4mFre8rjDHp+V58SA/3mkqy4vYNpU5SmUYI+FGATmKwVV73cfJ3rHi/CZAMSP21AwLTQkrNoOYKMGoe7IoV+PDSviQhwCWiLWJrEtfOY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dnXMdCkV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dnXMdCkV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so27332735e9.0
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774788276; x=1775393076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMhuHeD7KIQLmawFhIk+JJPpQUf9loVrwxnFpBfk5n8=;
        b=dnXMdCkVm5madfRT6P0ezSg720NIs3rc3IdYHXtNSPo+e0ql0rLWCaDZUoR5zVWTnL
         wTvwDXSJaquyL6hIkrUAk1m910HuxsnB78WwnT7+StVl5MZsudbD/x9adkquCwQd8BPm
         XNDDurbSXXW9XOos05BJ/5Hv+gkEi3YwWujdsU0bLtR82tMc8D0ASfDhspiJmz6eiHHI
         pHyJXOQ7Q7fPIk1ZC+OhPvpKxxPojDyfbi64aTXesM8pzRyVsXTOr9k0/HawTcF2KXFH
         XDtLAG+hOeoQwt+Ac/GyN5+aAKMPAsix/EMT28zQC5G0sa3awuhh/zQ3nJQ40hK+XP9P
         qspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774788276; x=1775393076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMhuHeD7KIQLmawFhIk+JJPpQUf9loVrwxnFpBfk5n8=;
        b=Qiab0qrbqRasF0tS2nmxr8hP+hx6D28C56XNDvUHixIINv0ZUgAp3mO8FVCNbX7TQR
         ximWZIY17PGjz1mC5tuXz0AQfJePKgMF1whAmtDMOymJwBcVs56FyxbZs2UvH+kqF9Uj
         CAdE2gx3rtT8ex1opm7ZFdJq724EL/Lar679qFH9qy2TJkF6mLiFCxpOixilMV9WIK+W
         1NKTi2Q9Y+M5dMcffAmuHRkoy5hP73D9I3/PZKazwsP8wYVI2iRruZMMQpuPzDMwsM6N
         w9pjxA5tExOUCOuSXg5DEhaGH8AzYDmjxU/6W/KHwXHeSjkuIwHysH1+nSRiNQeVWHL0
         M/Bw==
X-Gm-Message-State: AOJu0YzTQ0zPO7LMq8JL2S5ahhBypdyl48q6hYQVpidYxO3LsOg5L813
	dyWdHOJ4ikvjr19wF4VG/p1TFiXWXqZIix+LYXnGZqvpdGkwQGNizvUItS1l5Yy0gBzj3+sTmB5
	TgpKnN7I=
X-Gm-Gg: ATEYQzwvu/JRdQbmLYXqZZGRfJq/DpWiVLI+OesGf7LdZaFYi24aWT6z4IrP8j8s8FR
	OSSFGwkri60wJ1dkg84mATKgwf6E8lNDq+zFW6luo9AMXFmjnTc8o/Tlm9zwE8m/TMy6xtmWO4o
	X4N8n5PMsxnkGlZW8P/mxOwSp7G1ITwgQXOARzBvijOvN2ctqe6bU112BwxpH9s+T4hK/pLhNcw
	B8ahlPcaEJUAKce+qyikMVn20PVq5KuBCr5eXxOpTKV8t2t0PnB/XPGfWkCJwwYCx53gtetlf0O
	o+ukeG6YYxbyzkdIZQfSYikmkJrnWz/mTiTdhJ/CMHD97SnJcbT+IlEI1I/AFvR3JL7LG64PurR
	NiGsXakLZrvUYKuL2mZ+QXEprZmzwNrRJFBg5L1GbpanuRx0SWTjm8e+TUD9if/B5SSu+uTDaE0
	7r4Cn3uCaXolmvMasD2Hu9CUVf6nKd2SW6W3KpXi7qlFUB9A6o2ZbiV2mH2rzi7w==
X-Received: by 2002:a05:600c:524a:b0:486:f9a4:d487 with SMTP id 5b1f17b1804b1-48727c816e6mr142138465e9.0.1774788275973;
        Sun, 29 Mar 2026 05:44:35 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916da892sm3700321a12.14.2026.03.29.05.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:44:34 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] libbpf: allow address-based single kprobe attach
Date: Sun, 29 Mar 2026 21:43:37 +0900
Message-ID: <20260329124429.689912-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today libbpf can attach a single kprobe only by function name, with an
optional offset. But the kernel also supports attaching a single kprobe
directly by raw kernel address, through both legacy tracefs/debugfs
kprobes and PMU-based non-legacy kprobes. Since libbpf doesn't support
this yet, callers that already have a target IP still have to drop down
to perf_event_open() or direct tracefs writes.

This patchset adds address-based single-kprobe attach support to
bpf_program__attach_kprobe_opts() and covers it in selftests/bpf. The
first commit adds bpf_kprobe_opts.addr so that libbpf can attach single
kprobes by raw address through both legacy tracefs/debugfs and PMU-based
non-legacy paths. The second commit extends attach_probe selftests/bpf
with address-based kprobe attach subtests for these paths.

---
Changes in v2:
- Fix line wrapping and indentation

Hoyeon Lee (2):
  libbpf: allow address-based single kprobe attach
  selftests/bpf: add test for address-based single kprobe attach

 tools/lib/bpf/libbpf.c                        | 88 +++++++++++++------
 tools/lib/bpf/libbpf.h                        |  5 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 49 +++++++++++
 3 files changed, 114 insertions(+), 28 deletions(-)

-- 
2.52.0
