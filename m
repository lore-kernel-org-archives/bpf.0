Received: from mta0.migadu.com (out-200.mta0.migadu.com [91.218.175.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452B26E165
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259804; cv=none; b=GizIss+YiKKB5OZMYvHMex+fnUtnjyDt2G0TSoVEkuIVsoCV6PNn+bkoK8mRdTGwtzp7BES9necQxHBzl31ZzLNZCS/gg13Bty/gIk8h/1TRjZirxWRI8JfaizSoSCEM+D7UdHL9k1VES55CRbLBMp2d0oG6cSIGe8xp/DcILJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259804; c=relaxed/simple;
	bh=e4A14JjhkHMHsrE/lM9IyERxAQ8ySs6n2okyUEeUz/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2JWMcT5/D+TYGC/DbWmt9feS6I7jC6kcr3+NG4CqObed8mzXNQffpS4Kp2bQS7ta2grVvhsOhkXqRZfzofluHf8Fa4S8DOj0ayhfBkD+pno5H3lHI3I7ixpTV8x+nv3Rs45fCeHjXZbGc8eeVjtd4Z2g88peOLES+H9Lt55TRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gi8f+0Ze; arc=none smtp.client-ip=91.218.175.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gi8f+0Ze"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e4A14JjhkHMHsrE/lM9IyERxAQ8ySs6n2okyUEeUz/A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788259799; v=1; x=1788864599;
 b=gi8f+0ZemH4t0zsoKHdxKfA7nniTRlbPFOXpI4l06+UT6iqm+GaaQRRfBy7D4uZIJypJfX92
 N1KJFgP/QJenpHuLQpFY7kMJIlTlks15brvHO0okLsgjnfggNlgKk1sFkHc+IMQnKjb8IGMalSC
 47RuXasAYlT/sutY8ZQvjhLY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4b111e7144bc5b32;
	Tue, 01 Sep 2026 10:49:59 +0000
X-Mizu-Trace-ID: 4b111e7144bc5b32
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 0/5] bpf: Fix NULL-ptr-derefs when showing a void BTF type
Date: Tue,  1 Sep 2026 18:47:34 +0800
Message-ID: <20260901104924.346187-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three NULL-ptr-derefs in BTF handling.

Patch 1 handles the syzbot report. A key-less BTF (btf_key_type_id == 0) used
to be rejected for hash maps, until htab and rhtab gained a ->map_check_btf
(to register a dtor) that does not look at the key, so a key-less hash map is
now accepted. Dumping it through bpffs feeds the key type_id 0 into
btf_type_seq_show() and NULL-derefs in btf_type_show(). Reject it again.

Patches 2 and 3 fix two related, pre-existing crashes reachable via
bpf_snprintf_btf(), which renders a type_id taken straight from the BPF
program against the vmlinux BTF. A "const void" (a modifier resolving to
void) NULL-derefs in btf_modifier_show() - void has no ->show op; a
BTF_KIND_VAR NULL-derefs in btf_var_show() - the vmlinux base BTF has no
resolved_ids. Patch 2 falls back to btf_df_show(), the "<unsupported kind:N>"
placeholder already used for FWD/FUNC/FLOAT/DECL_TAG; patch 3 resolves the
var's type directly, mirroring the existing guard in btf_modifier_show().

Patches 4 and 5 add selftests. Patch 4 checks a key-less hash and rhash map is
rejected at creation. Patch 5 extends the snprintf_btf test to render a
"const void" and a BTF_KIND_VAR from the vmlinux BTF and checks they resolve
without crashing.

v3 -> v4: Drop the pin-and-read reproducer from the key-less map test, fold
the void/VAR test into the existing snprintf_btf test, and simplify patch 2's
wording (review comments).

v2 -> v3: Fold in a third fix for the same class of bug, btf_var_show(),
reported while reviewing v2. Address review comments (Fixes attribution,
verbatim syzbot trace, skip instead of fail).

v1 -> v2: AI reported a pre-exist issue. Let's fold it in this series.

v3: https://lore.kernel.org/bpf/20260831110314.150870-1-jiayuan.chen@linux.dev/
v2: https://lore.kernel.org/bpf/20260830073242.148092-1-jiayuan.chen@linux.dev/
v1: https://lore.kernel.org/bpf/20260828093142.179856-1-jiayuan.chen@linux.dev/

Jiayuan Chen (5):
  bpf: Reject key-less BTF for hash maps
  bpf: Fix NULL-ptr-deref when showing a void BTF type
  bpf: Fix NULL-ptr-deref in btf_var_show()
  selftests/bpf: Add test for key-less BTF hash map
  selftests/bpf: Add test for showing a void BTF type

 kernel/bpf/btf.c                              | 19 ++++-
 kernel/bpf/hashtab.c                          |  6 ++
 .../bpf/prog_tests/btf_map_keyless.c          | 59 ++++++++++++++
 .../selftests/bpf/prog_tests/snprintf_btf.c   | 79 +++++++++++++++++++
 .../selftests/bpf/progs/snprintf_btf_void.c   | 24 ++++++
 5 files changed, 185 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
 create mode 100644 tools/testing/selftests/bpf/progs/snprintf_btf_void.c

-- 
2.43.0

