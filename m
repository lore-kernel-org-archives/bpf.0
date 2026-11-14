Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633491;
	b=Ib2NIfdjCs9BAbBqljfMMZutb74kwFPgWgGNhvyt18G0ThTOhWhl4xrauO2TnAqpwTGB
	 1kLjt5Pc0Y9DPO++YCdc7f47wLBYydLYhGN1eSsIwJ3a7gys8Mqyc1DcJ6HVUPwHoys44
	 2xb5k+qwW7LsaTBa7vuWNf4Oc/Z/fwbAPzvBxZfYmZWSLK64YbwDKG4qqZh8b6fRMYTJY
	 z4zRhSUURlB55dmZyvul/SNZFIgeC8q60ikle06UHh7R4YCJsBFuzFJW8+Lmp5Ytr+JRL
	 ESzN0v0Oe1vE9cL9/bVI1RO1z7aMliacnecv82YulgunxFREISnv0TDiNfGgvH6Q1Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NKcLM2qV6VpBg99Gz6UY/0/hxyYzx1iR2m691CIfERk=;
	b=Oeegsy7PvYB90ArR/VqwBGlh60yatGPi7TFhQQLFYntVLHA2b7y2u+2eIWPnSrn9DUjR
	 xcTEhyeW52g4D5tbUKhduD1rP3LwQsuaR86Fw4YvrzO3nXqzjGOGeoMnURlBbOqlwZkQ7
	 jCac+Difhy6VRnpZvxmZHD2LekWgbGUsvTrc+dN+1ZWi4JtWv4nnhHhOC/J2/t9FVg8Fh
	 F8b3lx03PmXbWkUMiVUZKCZvPRvxlmD0grr7NbuRUZuEttz9kHYhf0fjhudwrmLDf23im
	 02Qy6Cl0XRZjr8O/M3bfv7KcIkNvIN3LweA7cQMKxXWKtcv7iUwbnD5zk8/fqjYmzRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKYciMMR;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E82606A32D
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E82606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKYciMMR
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso1446447a12.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633490; x=1795238290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NKcLM2qV6VpBg99Gz6UY/0/hxyYzx1iR2m691CIfERk=;
        b=LKYciMMRYUrqkB2HAhDh4p6hyLy9/sKnJ+xfAVqFqKwbod5pWaPqmd2M9WPY0bnuZa
         GBd43RBKBOE8dARKq1zLkyXiTqHDG1R9bl1yHmVen4J/13lJs6bAaeUg585VQsROH3sq
         RBXjyWLMefe0plzIu/sxOrPhYXzf3aUeb+jwrUHH8HDst3EymlQrlFG1vvmMLMpJhdrn
         oqprA2wXHl1pvfPTSu5GB4ibgT8LEwM9AW1oBRl8xpV3zsCoaSQLNeU9QQFKQS2cjSGk
         7tsLfLjnFyQD8kh4dLC7cnkF6cucoZAWI1ZK1UzPM9Gldx7mYJcpMZ+/BSu+uIdOC7KS
         PWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633490; x=1795238290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NKcLM2qV6VpBg99Gz6UY/0/hxyYzx1iR2m691CIfERk=;
        b=TE8SIFd8DxuvfFUZuCPbDATeIZV+xrpwjAEVTir6prt7+9SH5zvqvRo7tcd8WkyvBY
         f0wyhlIn9fCpLDFBDa5+qAQbHpXpq/dZRBQHune6gh86BTK5R6m1hVe5Dk4G+BHGyB6e
         UrNTCvuOPxcCgz2ucC4ipramGvsuvPG2TmPTMCOhxfYIkghqzO6HsMhQyAb1Q8rcm/G0
         XKIqZ+lVQCzU5hRau10D2t5R6HYryuVB1PggWlmWUs2c5FWwY47MdThOSv6yEgaZGHvW
         0zOG9CmGx6zOAicjxpTEkXbk1tyIlDgsUoJrL76fjJKbSgnKXqs8OoeYWI+LARxG9CAy
         Yx0w==
X-Gm-Message-State: APuU4Z+7q+mf5KpebUsVhegjSRwSbSWvezDaKOuPC/sJQEPogi7jJMnb
	jJvlyjo/zLYNGx6B+RGBNW7sM084SBScCMBSOBVT0AZBWk+QdHHq0TwTwcklVw==
X-Gm-Gg: AYBFou1v3TliSDU9LAsY9wUNkuD5DoRVTzQHIqOJo4up9LV6a5Gobg/loiRXxwWEsIC
	ES/S3FLavHFpQRjS8QxhLh2u7uZD/ciKTvk5NjSbDxifJqFYMDwNWvkni1lVzUyA8r3rKdxka7n
	q81n5sQP/iPD7wnsh9mDeXJlMemQ1lP8QmIzEvUgyNtCrT8aIEzQUwSy8ATOzpgG6Be6IcO+DPP
	/TI32vfhQ1zKr8AFks2Vieen+XWyYvu9KBkKGtIhT6xyHMCwNFSMvVT7hzuD2dqmKQWJfc3YQGo
	joWEhhiVdY08K4VG9ZRzV0QHKEa/8fqUC/FfOA0qGTESN/+5EJOygKdn/WHpT/5npnWo8KcGFmj
	xLRQ/LDanpWZ2Ab3HRrrOQn2WXOkS0NobKgkwidbtIQ+0NuFkpRZd8cPacKfTBskv/SwZNtkICu
	+a0/i5/SZQkOEVClJXXbhUOOrky1kdUe/LbMnKk1FGMhJdI+2w8GNyQBsWW7mxYKu7trdprM9C1
	xS2jPvHJZRyeTYH/ib5SfOfvXoI9H6MhdFijgXrqexwkmMbI5wqBuLc6bP1C8qQqnN2uaOKBFBF
	iqtxxweuin7RUSvrpMiO58/VmW0RP8yuqkfKddmbcLmFYRp1wXogboixPa8EpirfI0Z0fgjIOxn
	bvTEa2+q2a+D1vAkixfjBIT5S0SOxSltX06daKacWbulpTUIYqRd1FBp3ERTiJa0JQXVKfHRTMA
	==
X-Received: by 2002:a17:90b:3f50:b0:3b0:a1af:e4fc with SMTP id 98e67ed59e1d1-3b1b0d984bcmr4975032a91.63.1794633489475;
        Fri, 13 Nov 2026 21:18:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aed76745sm7689238a91.16.2026.11.13.21.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:18:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v3 bpf-next 00/11] bpf: fmod_ret for each function that returns errors
Date: Sat, 14 Nov 2026 05:17:54 +0000
Message-ID: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

In short: with CONFIG_BPF_FMODRET_SCAN=y the build tags the functions that
return errors, 12096 of them. A program with CAP_BPF and CAP_PERFMON can
attach to one, skip a call and return one of its errors. No file of net, fs
or mm changes. Test: one skipped call per function, 4401 functions of net,
fs, mm. With this set 1 function in 180 then damages the kernel. A deny
list by name can take those out.

1. What for?
BPF can keep user space away from a security bug in the rest of the kernel
until the fixed kernel runs. An fmod_ret program attaches to a function on
the way to the bug and fails the bad call:
  SEC("fmod_ret/vfs_fallocate")    return len > MAX_LEN ? -EFBIG : 0;
  err = vfs_fallocate(..) --> program
                               returns 0      --> call it, err = its result
                               returns -EFBIG --> skip it, err = -EFBIG
Such a program needs targets in net, fs and mm. Today it has 1000 syscall
entries, the security hooks and about 20 other functions. Of 417 fixes of
one year that add a failing check to a function, the fixed function is a
target: today 1 %, Anton's set (4) 17 %, this set 50 %.

2. What is a target?
  THE RULE  A function f() that returns errors is a target.
            A program returns 0, or an error that f() returns.
  EXCEPTION An error is not allowed if each path to its "return" calls a
            void function with a pointer: an argument of f() or
            &arg->member, not a loaded arg->ptr.
            If no error is left, f() is no target.
A caller can get each of these errors today, without a program. The rule
is simple on purpose. It does not aim at 100 % safety (5).
Why the exception? "spin_unlock(&arg->lock); return -EBUSY;". If f() fails,
the lock is free. A skip of f() leaves the lock held. So a program cannot
return this -EBUSY (5).
A program can only fail a call. Loss of function is the purpose: a program
that switches off a part of netfilter to keep a bug out of reach works as
designed. Who may load does not change: CAP_BPF and CAP_PERFMON, or a BPF
token. An attach does not taint the kernel, as today. The arguments have
the types that an fmod_ret program gets today.

3. How are targets found?
  vmlinux, *.ko      machine code of GCC or clang, inlined and linked
  resolve_btfids     "the tool". It runs at the link, after pahole
    | 1 decode       LLVM's MC (machine code) layer gives the length, the
    |                branches, the written and the read registers
    | 2 analyse      data flow, backward, may, like liveness: the constants
    |                -4095..-1 that reach the return value register.
    |                Forward, may: is a path free of the exception's call?
    v 3 tag
  DECL_TAG 'bpf_fmodret_retval:-95,-29,-27,-26,-22,-21,-19,-9,-1'
           on FUNC 'vfs_fallocate'. This is "the list" of vfs_fallocate()
    v verifier       at load
  The program attaches. At each exit R0 is 0 or an error of the list.

4. What do I get, and what is the price?
"Anton's set" is "[PATCH v3 bpf-next 00/18] Auto-detect BPF fmodret
targets" by Anton Protopopov. This set is a rework of it. The idea,
resolve_btfids as the place, the tag, the check, the tests, and that
Kconfig asks llvm-config and a host C++ compiler are his. So is the
question behind the exception: what has f() done before the error?

                     targets   kernel damage   the build reads
  allowed today         1290    not measured   -
  Anton's set           4457           0.2 %   LLVM IR, in a clang plugin
  this set             12096     0.6 - 0.7 %   machine code, GCC or clang
  targets: tags in one x86-64 clang kernel. GCC: 11432. arm64: 10954.
  A program can attach to each of them, and to 4454 of Anton's 4457.
  kernel damage: the share of the functions in net, fs, mm where one
  injected error ends in a panic, a stall or a lockdep report (5). 0.7 %:
  a second run, and a blind run on new functions.
  allowed today: 957 syscall entries, 312 security_*(), 21 others. They are
  no safe baseline. security_*() is a match by name: 47 are internals of
  SELinux, 59 return void, 12 are hooks that BPF LSM refuses. The value
  that a program returns is not checked. This set does not change that.
Anton's rule: a "clean path", one without side effects, leads from the
entry to "return -E..". A call, a store or a shared "goto err" label ends
it. The exception (patch 8) takes that clean path and narrows what ends it:
only a call of a void function on an argument.

5. Does the kernel survive?
An injection: one program attaches to one tagged function. At one call it
returns one error of the list, whoever calls. The control attaches and
always returns 0. The kernel is x86-64 GCC with inline KASAN, lockdep,
kmemleak and a wide config. The workload is 530 tests and scripts, mostly
selftests. It calls 8027 tagged functions, 4401 of them in net, fs, mm.
Each gets one injection:

                                         panic
                                         oops
                               kernel    BUG()   hang   lock
                  functions    damage    KASAN   stall  dep    WARN   leak
  net                  2716   25  0.9 %     20      4     1      14     34
  fs                   1307   18  1.4 %      5     13     0       4      2
  mm                    378    7  1.9 %      6      1     0       2      0
  net + fs + mm        4401   50  1.1 %     31     18     1      20     36
    error is dropped    290   27  9.3 %     16     10     1       1     16
    error stays        4111   23  0.6 %     15      8     0      19     20
      Anton's has it    903    2  0.2 %      2      0     0       3      1
      only this set    3208   21  0.7 %     13      8     0      16     19
  kernel damage = the three columns right of it. WARN stands apart.
  A leak is the lowest concern: it is not in the rate.
  The run has the lists without the exception. "error is dropped": the
  exception takes the injected error out of the list.

 1 With the exception about 1 function in 180 damages the kernel after one
   injection. It is not 1 in 2, not 1 in 10.
 2 The exception takes out 27 of the 50 cases, for 7 % of the functions.
   These 27 functions have no error left: no tag, no attach. The exception
   comes from this run. In a blind run on 632 new functions: 3 of 9 cases.
 3 Anton's rule is safer per function, 0.2 % against 0.7 %. It has far
   fewer functions: 903 of the 4111.
 - Of all 8027 injections 48 % only give user space an error, 50 % nothing.
 - 354 of 355 runs of the control are clean. A second harness with its own
   program sees all 50 cases again.
 - Are the 50 cases bugs in the kernel? By the source of each case: at most
   2 are, on an error path. In the other 48 a real failure of f() at that
   call does not do that damage, or cannot happen.

  A skip of f() is not a failure of f(). 38 of the 50 cases come from that.
  The exception of (2) is made for them. It closes 26 of the 38. An
  example, fs/file.c. ksys_dup3() takes the lock and ends with
  "return do_dup2(..)":
      static int do_dup2(..) __releases(&files->file_lock)
      ..
      Ebusy:
              spin_unlock(&files->file_lock);
              return -EBUSY;
      do_dup2() fails        dup2() = -EBUSY, the lock is free
      do_dup2() is skipped   dup2() = -EBUSY, the lock stays held
  With this set do_dup2() has no tag: a program cannot attach to it. The
  tool sees that in the machine code. It needs no name and no __releases():
      mov  %rdi,%r13           r13 = files: a pointer argument
      lea  0xc0(%r13),%rdi     rdi = &files->file_lock: no load
      call _raw_spin_unlock    BTF: it returns void and takes a pointer
      mov  $0xfffffff0,%eax    -EBUSY: each path to it has this call
  A void function cannot fail: it has done its work when f() returns the
  error. The caller relies on that work, and a skip leaves it out. Most
  unlock, put, free and init functions return void. A function that returns
  a value can be the one that failed: it does not count.
  Anton's set has no do_dup2() either: the unlock ends its clean path.
  Functions with __releases() and no __acquires() that have a tag, without
  and with the exception: 7 and 0 in this kernel, 4 and 0 in the GCC kernel
  of (4), 3 and 1 with clang and on arm64.

  What stays? In four runs, all directories, 169 functions cause kernel
  damage in this kernel. The exception takes out 55. A deny list by name,
  not in this set, can take out the other 114, 55 of them in net, fs, mm.

6. What does it cost me?
  CONFIG_BPF_FMODRET_SCAN    option off   option on
  each Kconfig run           +3 ms        +3 ms: one run of llvm-config
  build host                 as today     C++17, llvm-config, headers and
                                          libraries of LLVM 17 or later
  the tool on vmlinux        0.31 s       0.9 s, after 4.3 s of pahole
  BTF of vmlinux             8.02 MB      8.24 MB = +2.8 %
  kernel memory              -            +0.31 MB: BTF and its index
 - Nobody gets the option without a question: no default, not in defconfig.
   allmodconfig and allyesconfig have no BTF, so they do not have it.
 - A GCC build needs LLVM too. It need not be the LLVM of the compiler.
 - LLVM's C++ API and opcode names change between releases. The build then
   stops and says why. So a new LLVM can stop the build of an old kernel
   with the option on.
 - x86-64 and arm64 only.
 - No file outside of BPF's entries in MAINTAINERS changes.

7. Why this rule? Why machine code? Why LLVM?
  the rule (* = taken)                 targets  against it
  Anton's: an error on a clean path       4457  17 % of the fixed f() (1)
  an error reaches a return              13002  0.9 - 1.3 % kernel damage
* the same with the exception            12096  0.6 - 0.7 % (5, patch 8)
  + the errors of callees               + 40 %  3 - 6 % are never returned
The exception drops none of the 5249 errors of Anton's set.

  who reads what               lines  against it
  Anton's: clang plugin, IR    +1913  no GCC, no LTO yet
  objtool, Anton's rule        +1272  no arm64
* resolve_btfids at the link   +2239  LLVM on the host
  lines: the part that finds and tags.
The rule makes the targets, not the reader. A plugin with "an error reaches
a return" finds 14229. But a plugin serves one compiler, before the link.
Why LLVM? A decoder by hand is 300 - 800 lines per arch, for ever. The MC
layer takes 546 lines, and a table of 142 (x86-64) or 127 (arm64) lines:
what an opcode computes, by opcode name. The tool checks the table against
LLVM at each start. LLVM's C API gives only text, so it is C++ (patch 3).

v2 -> v3:
- Patches 11 - 13 of v2, "the arguments are untrusted pointers", are not in
  this set. They come in a set of their own, with the arguments of fentry
  and fexit programs: Anton asked why not fentry.
- No tag for a function that no program can attach to: no nop of ftrace at
  the entry, or parameters that a trampoline refuses. It was 537 of the
  12633 tags (patch 5, Anton).
- New patch 10, by Anton: the JIT is required for an fmod_ret program on
  a tagged function that returns long.
- Registers are counted as in bpf_jit_place_args(): a parameter of 9 - 16
  bytes takes two, the count stops at a bigger one (patch 8).
- An exception callback can return two errors of the list (patch 9).
- The tag of a function of vmlinux no longer lets a program attach to a
  function of a module that has the same name and no tag (patch 9).
v1 -> v2:
- New patches 11 - 13: the arguments are untrusted pointers.
- BPF CI: the test modules build with a kernel build directory that has no
  resolve_btfids (patch 11).
- arm64: no return value passes a brk, like ud2 on x86-64: the brk of BUG()
  has no next instruction. WARN() has the same brk: 58 functions that load
  the error before it lose the tag. x18 is caller saved. The Makefile names
  the interpreter of llvm-mc.sh (patch 3).
- x86-64: the stack pointer is never based on an argument (patch 8).
- -EAGAIN, -EMSGSIZE, -EINPROGRESS have the numbers of the kernel, not of
  the build host (patch 5).
- Applies on top of bpf-next.
v2: https://lore.kernel.org/bpf/20261113050901.1399091-1-alexei.starovoitov@gmail.com/
v1: https://lore.kernel.org/bpf/20261112164610.1917256-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (5):
  selftests/bpf: Don't depend on the width of a BTF id in
    verifier_live_stack
  resolve_btfids: Describe machine instructions with LLVM's MC layer
  resolve_btfids: Fold the constants of a select without a branch
  resolve_btfids: Say which registers an instruction reads
  resolve_btfids: Don't list an error that follows work on an argument

Anton Protopopov (6):
  resolve_btfids: Read the code of an ELF file by address
  resolve_btfids: Find the definitions that reach the return value
  resolve_btfids: Tag the functions that return errors
  bpf: Allow fmod_ret on tagged functions and check the return value
  bpf: Require the JIT for fmod_ret programs on tagged 64-bit targets
  selftests/bpf: Test fmod_ret on tagged functions

 include/linux/bpf.h                           |   3 +
 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/Kconfig                            |  19 +
 kernel/bpf/btf.c                              |  30 ++
 kernel/bpf/flow.c                             |   2 +
 kernel/bpf/verifier.c                         |  83 ++++
 scripts/Makefile.btf                          |   1 +
 tools/bpf/resolve_btfids/Build                |  13 +
 tools/bpf/resolve_btfids/Makefile             |  23 +-
 tools/bpf/resolve_btfids/fmodret.c            | 254 ++++++++++
 tools/bpf/resolve_btfids/fmodret.h            |  12 +
 tools/bpf/resolve_btfids/fmodret_scan.c       | 284 ++++++++++++
 tools/bpf/resolve_btfids/fmodret_scan.h       |  31 ++
 tools/bpf/resolve_btfids/image.c              | 222 +++++++++
 tools/bpf/resolve_btfids/image.h              |  62 +++
 tools/bpf/resolve_btfids/llvm-mc.sh           |  59 +++
 tools/bpf/resolve_btfids/main.c               |  11 +
 tools/bpf/resolve_btfids/text_flow.c          | 263 +++++++++++
 tools/bpf/resolve_btfids/text_flow.h          |  77 +++
 tools/bpf/resolve_btfids/text_insn.h          |  94 ++++
 tools/bpf/resolve_btfids/text_mc.cpp          | 437 ++++++++++++++++++
 tools/bpf/resolve_btfids/text_mc.h            | 109 +++++
 tools/bpf/resolve_btfids/text_mc_arm64.c      | 127 +++++
 tools/bpf/resolve_btfids/text_mc_x86.c        | 142 ++++++
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/fmodret_retval.c | 155 +++++++
 .../selftests/bpf/progs/fmodret_retval.c      | 203 ++++++++
 .../selftests/bpf/progs/fmodret_retval_ext.c  |  18 +
 .../selftests/bpf/progs/verifier_live_stack.c |   6 +-
 .../testing/selftests/bpf/test_kmods/Makefile |  16 +
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   4 +-
 .../bpf/test_kmods/bpf_testmod_retval.c       | 153 ++++++
 32 files changed, 2911 insertions(+), 5 deletions(-)
 create mode 100644 tools/bpf/resolve_btfids/fmodret.c
 create mode 100644 tools/bpf/resolve_btfids/fmodret.h
 create mode 100644 tools/bpf/resolve_btfids/fmodret_scan.c
 create mode 100644 tools/bpf/resolve_btfids/fmodret_scan.h
 create mode 100644 tools/bpf/resolve_btfids/image.c
 create mode 100644 tools/bpf/resolve_btfids/image.h
 create mode 100755 tools/bpf/resolve_btfids/llvm-mc.sh
 create mode 100644 tools/bpf/resolve_btfids/text_flow.c
 create mode 100644 tools/bpf/resolve_btfids/text_flow.h
 create mode 100644 tools/bpf/resolve_btfids/text_insn.h
 create mode 100644 tools/bpf/resolve_btfids/text_mc.cpp
 create mode 100644 tools/bpf/resolve_btfids/text_mc.h
 create mode 100644 tools/bpf/resolve_btfids/text_mc_arm64.c
 create mode 100644 tools/bpf/resolve_btfids/text_mc_x86.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
 create mode 100644 tools/testing/selftests/bpf/progs/fmodret_retval.c
 create mode 100644 tools/testing/selftests/bpf/progs/fmodret_retval_ext.c
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c


base-commit: 1440a14a7ed58d5fbc3b9170b68fc977939b4985
-- 
2.55.0

