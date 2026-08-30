Received: from mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DE2EDD58
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788075180; cv=none; b=eMJc5sJHKP0lS1Mw6goR+uFFkSKZxJKk2wKFPmi1L47pgZwtgKguXihVkK66e46HaX/FX2j/i018diZ4vljD3W2ylE7hd7K4j8WxGJmcz1qH/EBvvp2pdHddU4BVKbwSmdjiAorjnV+kl7F9NpCvJq+A9QOj1Ne2S9hO8MwJDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788075180; c=relaxed/simple;
	bh=6xntamfeW32wUM07IwVlvDyiu2IdVEVIlYpCj0aHlwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSbxWj5xff6TAxuzIzPTq6xlDcrE0W/piqTz76bNKHBwfCCyme5a3c0yMoHENV+4BudOo6roeTYLUtNi7ujJwqt/Osn9b2ivwZQaN2uIgZq+STmBMtEBvTLFFEQZD5mBpD8tGhWRuMg1WbcUtiX1IND7CRRmKmD8LiTDs2qB7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w/fx58pw; arc=none smtp.client-ip=91.218.175.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w/fx58pw"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6xntamfeW32wUM07IwVlvDyiu2IdVEVIlYpCj0aHlwg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788075174; v=1; x=1788679974;
 b=w/fx58pwdFL7XujoAU9x/7ZHJ4niomO2uWKU8EZL8vwmB3MFioVgkbjPbAAf0FrGMI7K9V3W
 36H8Z180EGu7xPAwa1lhf8ucWUA+DYAJSBMASnIGEuS/aitGxykgjb4QGpfTDDhM87aJHs7sRUp
 iM2MHD2gsO3wGicATXbbT7LY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 69d9142b7f0d6869;
	Sun, 30 Aug 2026 07:32:54 +0000
X-Mizu-Trace-ID: 69d9142b7f0d6869
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
Subject: [PATCH bpf v2 0/4] bpf: Fix NULL-ptr-derefs when showing a void BTF type
Date: Sun, 30 Aug 2026 15:30:55 +0800
Message-ID: <20260830073242.148092-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two NULL-ptr-derefs in BTF handling.

Patch 1 handles the syzbot report. A key-less BTF (btf_key_type_id == 0) used
to be rejected for hash maps, until htab and rhtab gained a ->map_check_btf
(to register a dtor) that does not look at the key, so a key-less hash map is
now accepted. Dumping it through bpffs feeds the key type_id 0 into
btf_type_seq_show() and NULL-derefs in btf_type_show(). Reject it again.

Patch 2 fixes a related, pre-existing crash reachable via bpf_snprintf_btf().
A "const void" type_id (a modifier that resolves to void, present in the
vmlinux BTF) NULL-derefs in btf_modifier_show() - void has no ->show op.
void has no size and nothing to render, so route the show call sites through
a helper that falls back to btf_df_show() - the "<unsupported kind:N>"
placeholder already used for FWD/FUNC/FLOAT/DECL_TAG.

Patches 3 and 4 add selftests for the two cases. They are meant to reproduce
the crashes: each deliberately walks the faulting path, so on an unfixed
kernel it oopses the task (and panics it under panic_on_oops). That is
intentional - the tests verify the fix and reproduce the bug - so a static
review flagging them for crashing an unfixed kernel can be ignored.

v1 -> v2: AI reported a pre-exist issue. Let's fold it in this series.

v1: https://lore.kernel.org/bpf/20260828093142.179856-1-jiayuan.chen@linux.dev/


Jiayuan Chen (4):
  bpf: Reject key-less BTF for hash maps
  bpf: Fix NULL-ptr-deref when showing a void BTF type
  selftests/bpf: Add test for key-less BTF hash map
  selftests/bpf: Add test for showing a void BTF type

 kernel/bpf/btf.c                              | 10 ++-
 kernel/bpf/hashtab.c                          |  8 ++
 .../bpf/prog_tests/btf_map_keyless.c          | 83 +++++++++++++++++++
 .../selftests/bpf/prog_tests/btf_show_void.c  | 57 +++++++++++++
 .../selftests/bpf/progs/btf_show_void.c       | 22 +++++
 5 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_show_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_show_void.c

-- 
2.43.0

