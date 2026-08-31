Received: from mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D501340DA6
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174211; cv=none; b=OOLY45sgCKHQWMG7a1cEM3Wx9cLmP1SeYa6Gp4cNZg2iaZjQ/IgQAWxtnLToqK1Fvpv3jPa5CPn5pE8WkMx/WV8HsWnJS0Vx+Q4WLnBNUkleKceUxwtHwUMPxflnmDriFyAtXJoozLuTmFEFvRvkD2q9P5oB+uUWWnDK0R52nig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174211; c=relaxed/simple;
	bh=/NN2WxM2riQ1V3asB40Qhut8hxnm4DYXi01Ct2unvcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5Y3t2nuweAx4RIRKWBHtSl1WFAA9dvanK2AXpuuhSUfdLC8MduRXrPYr2x9saH+B8fuacZGibqoDqHOGVc5B5HR71HR3QKX4qT9nlATGO0P5dExbm7YOP4qVyO+nWzdPC2Fu6MAqh+pWMEBjb/462Xnj4ZElhnfpa2gAoCGnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZjEI6aWB; arc=none smtp.client-ip=95.215.58.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZjEI6aWB"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/NN2WxM2riQ1V3asB40Qhut8hxnm4DYXi01Ct2unvcc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788174205; v=1; x=1788779005;
 b=ZjEI6aWBUKrH0KqAZV9PYhMxsOMeaHfHNh3KAIoHP/E6DG0YeFunLwXEG8yws1q9m95EGMWp
 Hnq168PdNFnJ9wm5QrGssnsP7Pu/E/b5YCqQbpi4KxdYEzxudpXOcCYy99gMESy1Y4+fnUwQgg6
 x2ZKaDntLlEDZxTZwZ2rInkA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 30aa6c88d071e977;
	Mon, 31 Aug 2026 11:03:25 +0000
X-Mizu-Trace-ID: 30aa6c88d071e977
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
Subject: [PATCH bpf v3 0/5] bpf: Fix NULL-ptr-derefs when showing a void BTF type
Date: Mon, 31 Aug 2026 19:01:05 +0800
Message-ID: <20260831110314.150870-1-jiayuan.chen@linux.dev>
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

Patches 4 and 5 add selftests for the three cases. They are meant to reproduce
the crashes: each deliberately walks the faulting path, so on an unfixed
kernel it oopses the task (and panics it under panic_on_oops). That is
intentional - the tests verify the fix and reproduce the bug - so a static
review flagging them for crashing an unfixed kernel can be ignored.

v2 -> v3: Fold in a third fix for the same class of bug, btf_var_show(),
reported while reviewing v2. Address review comments (Fixes attribution,
verbatim syzbot trace, skip instead of fail).

v1 -> v2: AI reported a pre-exist issue. Let's fold it in this series.

v2: https://lore.kernel.org/bpf/20260830073242.148092-1-jiayuan.chen@linux.dev/
v1: https://lore.kernel.org/bpf/20260828093142.179856-1-jiayuan.chen@linux.dev/

Jiayuan Chen (5):
  bpf: Reject key-less BTF for hash maps
  bpf: Fix NULL-ptr-deref when showing a void BTF type
  bpf: Fix NULL-ptr-deref in btf_var_show()
  selftests/bpf: Add test for key-less BTF hash map
  selftests/bpf: Add test for showing a void BTF type

 kernel/bpf/btf.c                              | 20 ++++-
 kernel/bpf/hashtab.c                          |  8 ++
 .../bpf/prog_tests/btf_map_keyless.c          | 82 +++++++++++++++++++
 .../selftests/bpf/prog_tests/btf_show_void.c  | 81 ++++++++++++++++++
 .../selftests/bpf/progs/btf_show_void.c       | 24 ++++++
 5 files changed, 213 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_show_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_show_void.c

-- 
2.43.0

