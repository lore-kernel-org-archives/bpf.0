Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460B2ED843
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153747; cv=none; b=DP/TbOUQIHW/VTl7XTfBL/+zfHG6kZZq8PdkHbxJchP1EGYIpDCAeG+Wk3H6D6WrJaIOw/8aDQ+Z7ZWQ7kFszIOOjtWZevu4CmIs60yHThjrpbFYkSzdi5ohh1ZF3OK5kbyTBzweWSreIVr00cDbgAfN5ZTTsbWla13QA+NJS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153747; c=relaxed/simple;
	bh=IIywgjkMC9eqbw9rC0HyEr06ynE2YeurqmcObpG0GOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y3aLggV7D9WTBbHxUisT5L+ij3OpraA6dZ1RnTA9byPhsA3xcYDqCctfbjpBiCB1oHuCY7CmbsLRD/+Fz87cDB5LpW5Qs7Q06cB8W6R+H97GQp+HmRMqYFLDU11JdzbgXjIqgYCE2Ii4YLvwgBj46EqL7NytSCJYFbv9j8GMBbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0mDaVfs; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0mDaVfs"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-823210d1d8eso73066b3a.1
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 23:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153745; x=1769758545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fAB/7HVJCG/sTMtuKVDS52s4Pq0JlJT4Mf/3agprN40=;
        b=B0mDaVfsNdogqwyhMdYpLN5p8FoPC6KNfOQNrVsMqNrnRIPDmRUP7zq0B7b3qFtYUx
         UrEfpLB5P6Xo+THDtVQfHmL2jCiob2VH8axd5LIsUyF8PyEZLD/Hrbxpz0ZP+mozhDxg
         EyxIXGxphhSdu/mhIFPd6RFSqRXy2nFxKCGvIa1n8QvviOQfkqSWEKA6/SbTYNi2e6HG
         sEOo1ScwQP0EAkIcrwz2Dc88BJ4wshYOQU7FVv82Z6vHrLujeEiWQOZU3Il+eYGMK4rY
         wZvuY9enRvEjwShcWyr3OYbo7KppDCTGyDRWfLC1CkapIw2DubMuYAN7BH3hHb9Udxcf
         9AKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153745; x=1769758545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAB/7HVJCG/sTMtuKVDS52s4Pq0JlJT4Mf/3agprN40=;
        b=jvPCs18gcbbctXwoBhI0K6iZ5p1Pap/1rbx5TMMoSgFftKNERoyssiQ7hGhPXqoP/E
         K+l7QNzVYX+9g58iQTkfFVhxyBHUWojobmO1ahpwjBO1Re7kcD2w5yXx8mL8N5e94auW
         3RtxyuaYWa5RguLJ8THt10BgF6EHh5nrmqpqRB+C16PEpcMtsTcEXKlHYaspG0kwqkuZ
         6nremL+ci5ktr7ZotuUhJAKnk77uB/P5rrVc6uZ6m5cE0W8ID1DbBGhhz1b8TW1BDmdC
         4q0SUBdUQaL1fXfG4ppvfYLRr7t6Pc1cwvsiH5g0tZw73PJSl+1NSsGJEyNb9mQQlmZJ
         w1gg==
X-Forwarded-Encrypted: i=1; AJvYcCX8XhZ9N9VMDEiKF+gVi0p5vv4TXxtji7nideG7xkZTMk9VsaRNAPmADicuKN7xSPB9mN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS67hPBMAwWPQ/Sivvig54E+KaPeMysoO0AlFE6QwSU9X5e4kt
	WlNwwH6dNvFv6H3rX5Dq7l1CSLeNMGEXaIGYjx0Cy/6BAQ4bUqxvuKNz
X-Gm-Gg: AZuq6aJ9Kr+i/FvL7jRSNsrQe7bx6zVUz9gVsqREfS2sTtXdrQMrM1IP8uR+t6x5028
	0lXiddyjWf8kLEv4Gz/uCLwSSgGC8Jx+L8TMJ7c5i4nY7AepBbJKXtMo78o+kgvQIqNljdL99T/
	ZKItGysajOWM3DA27cTn3Hp7A17BOlAangLt7bpoIPPw8fDG6oIb1NFk3J3t7hVCDhnDDs/fIKk
	QUwJG54p4MI7XrXKOzgVhtVcFz1Wbo+EJ+9o82RIbjcT731Ry/aSGpJDxNcAYBZI+sFbpSO/udQ
	5WUAMID2urFaD4WCAyw6gkmrRsk6O73zEUSze/MC3T8889Pb6pXwcky6k6xygs3tww+Gur+hnN1
	q7Q15WTEnQruC/TssGEKWfE82TCzSIu/1f7iKUeKBp7ukWZs2tyHWGunPFpn6QBHcT/Dp7MIB0t
	2YwygKMOUN
X-Received: by 2002:a05:6a00:3e03:b0:81f:4999:ae46 with SMTP id d2e1a72fcca58-82317eb1529mr1812648b3a.48.1769153745313;
        Thu, 22 Jan 2026 23:35:45 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:35:44 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v11 00/12] bpf: fsession support
Date: Fri, 23 Jan 2026 15:35:20 +0800
Message-ID: <20260123073532.238985-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

overall
-------
Sometimes, we need to hook both the entry and exit of a function with
TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
function, which is not convenient.

Therefore, we add a tracing session support for TRACING. Generally
speaking, it's similar to kprobe session, which can hook both the entry
and exit of a function with a single BPF program.

We allow the usage of bpf_get_func_ret() to get the return value in the
fentry of the tracing session, as it will always get "0", which is safe
enough and is OK.

Session cookie is also supported with the kfunc bpf_session_cookie().
In order to limit the stack usage, we limit the maximum number of cookies
to 4.

kfunc design
------------
In order to keep consistency with existing kfunc, we don't introduce new
kfunc for fsession. Instead, we reuse the existing kfunc
bpf_session_cookie() and bpf_session_is_return().

The prototype of bpf_session_cookie() and bpf_session_is_return() don't
satisfy our needs, so we change their prototype by adding the argument
"void *ctx" to them.

We inline bpf_session_cookie() and bpf_session_is_return() for fsession
in the verifier directly. Therefore, we don't need to introduce new
functions for them.

architecture
------------
The fsession stuff is arch related, so the -EOPNOTSUPP will be returned if
it is not supported yet by the arch. In this series, we only support
x86_64. And later, other arch will be implemented.

Changes v10 -> v11:
* rebase and fix the conflicts in the 2nd patch
* use "volatile" in the 11th patch
* rename BPF_TRAMP_SHIFT_* to BPF_TRAMP_*_SHIFT
* v10: https://lore.kernel.org/bpf/20260115112246.221082-1-dongml2@chinatelecom.cn/

Changes v9 -> v10:
* 1st patch: some small adjustment, such as use switch in
  bpf_prog_has_trampoline()
* 2nd patch: some adjustment to the commit log and comment
* 3rd patch:
  - drop the declaration of bpf_session_is_return() and
    bpf_session_cookie()
  - use vmlinux.h instead of bpf_kfuncs.h in uprobe_multi_session.c,
    kprobe_multi_session_cookie.c and uprobe_multi_session_cookie.c
* 4th patch:
  - some adjustment to the comment and commit log
  - rename the prefix from BPF_TRAMP_M_ to BPF_TRAMP_SHIFT_
  - remove the definition of BPF_TRAMP_M_NR_ARGS
  - check the program type in bpf_session_filter()
* 5th patch: some adjustment to the commit log
* 6th patch:
  - add the "reg" to the function arguments of emit_store_stack_imm64()
  - use the positive offset in emit_store_stack_imm64()
* 7th patch:
  - use "|" for func_meta instead of "+"
  - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
    computing it with "stack_size + 8"
  - pass the "cookie_off" to invoke_bpf() instead of computing the current
    cookie index with "func_meta"
* 8th patch:
  - split the modification to bpftool to a separate patch
* v9: https://lore.kernel.org/bpf/20260110141115.537055-1-dongml2@chinatelecom.cn/

Changes v8 -> v9:
* remove the definition of bpf_fsession_cookie and bpf_fsession_is_return
  in the 4th and 5th patch
* rename emit_st_r0_imm64() to emit_store_stack_imm64() in the 6th patch
* v8: https://lore.kernel.org/bpf/20260108022450.88086-1-dongml2@chinatelecom.cn/

Changes v7 -> v8:
* use the last byte of nr_args for bpf_get_func_arg_cnt() in the 2nd patch
* v7: https://lore.kernel.org/bpf/20260107064352.291069-1-dongml2@chinatelecom.cn/

Changes v6 -> v7:
* change the prototype of bpf_session_cookie() and bpf_session_is_return(),
  and reuse them instead of introduce new kfunc for fsession.
* v6: https://lore.kernel.org/bpf/20260104122814.183732-1-dongml2@chinatelecom.cn/

Changes v5 -> v6:
* No changes in this version, just a rebase to deal with conflicts.
* v5: https://lore.kernel.org/bpf/20251224130735.201422-1-dongml2@chinatelecom.cn/

Changes v4 -> v5:
* use fsession terminology consistently in all patches
* 1st patch:
  - use more explicit way in __bpf_trampoline_link_prog()
* 4th patch:
  - remove "cookie_cnt" in struct bpf_trampoline
* 6th patch:
  - rename nr_regs to func_md
  - define cookie_off in a new line
* 7th patch:
  - remove the handling of BPF_TRACE_SESSION in legacy fallback path for
    BPF_RAW_TRACEPOINT_OPEN
* v4: https://lore.kernel.org/bpf/20251217095445.218428-1-dongml2@chinatelecom.cn/

Changes v3 -> v4:
* instead of adding a new hlist to progs_hlist in trampoline, add the bpf
  program to both the fentry hlist and the fexit hlist.
* introduce the 2nd patch to reuse the nr_args field in the stack to
  store all the information we need(except the session cookies).
* limit the maximum number of cookies to 4.
* remove the logic to skip fexit if the fentry return non-zero.
* v3: https://lore.kernel.org/bpf/20251026030143.23807-1-dongml2@chinatelecom.cn/

Changes v2 -> v3:
* squeeze some patches:
  - the 2 patches for the kfunc bpf_tracing_is_exit() and
    bpf_fsession_cookie() are merged into the second patch.
  - the testcases for fsession are also squeezed.
* fix the CI error by move the testcase for bpf_get_func_ip to
  fsession_test.c
* v2: https://lore.kernel.org/bpf/20251022080159.553805-1-dongml2@chinatelecom.cn/

Changes v1 -> v2:
* session cookie support.
  In this version, session cookie is implemented, and the kfunc
  bpf_fsession_cookie() is added.
* restructure the layout of the stack.
  In this version, the session stuff that stored in the stack is changed,
  and we locate them after the return value to not break
  bpf_get_func_ip().
* testcase enhancement.
  Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
  the testcase for get_func_ip and session cookie is added too.
* v1: https://lore.kernel.org/bpf/20251018142124.783206-1-dongml2@chinatelecom.cn/

Menglong Dong (12):
  bpf: add fsession support
  bpf: use the least significant byte for the nr_args in trampoline
  bpf: change prototype of bpf_session_{cookie,is_return}
  bpf: support fsession for bpf_session_is_return
  bpf: support fsession for bpf_session_cookie
  bpf,x86: introduce emit_store_stack_imm64() for trampoline
  bpf,x86: add fsession support for x86_64
  libbpf: add fsession support
  bpftool: add fsession support
  selftests/bpf: add testcases for fsession
  selftests/bpf: add testcases for fsession cookie
  selftests/bpf: test fsession mixed with fentry and fexit

 arch/x86/net/bpf_jit_comp.c                   |  76 +++++---
 include/linux/bpf.h                           |  36 ++++
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |  18 +-
 kernel/bpf/trampoline.c                       |  53 +++++-
 kernel/bpf/verifier.c                         |  89 +++++++--
 kernel/trace/bpf_trace.c                      |  49 +++--
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/libbpf.c                        |   3 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   3 -
 .../selftests/bpf/prog_tests/fsession_test.c  |  90 +++++++++
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_test.c       | 179 ++++++++++++++++++
 .../bpf/progs/kprobe_multi_session_cookie.c   |  15 +-
 .../bpf/progs/uprobe_multi_session.c          |   7 +-
 .../bpf/progs/uprobe_multi_session_cookie.c   |  15 +-
 .../progs/uprobe_multi_session_recursive.c    |  11 +-
 22 files changed, 554 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0

