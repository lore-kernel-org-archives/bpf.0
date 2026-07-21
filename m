Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17187381EAA;
	Tue, 21 Jul 2026 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643269; cv=none; b=E4BQlfIw27iz9Usdl9Yc/Mt1k3yRbeLIVawzL/lhUpJSAkWe1qC0taUWuTf39fZ2Zb4XiZ+Hpj5KwuxGVOzlSN6PKbQppjR8+s4q9LSapPWTs/iMPE4MUcakWFs2dnfhqoUytXyTQnO1ffoErGSa3+m9B2jye9Fys6ZHuqY/iWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643269; c=relaxed/simple;
	bh=E1xjytujcSid3WpFAgBvYYkChqfWuL8uWCM2ZU8eHpI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aZbiA7q3cdr/XPo4jHcdHAXDuOvUhygJiyUOh6k8CqLUAbOY5fWgdQnrRANra7tTposOJbjCH4mF27y0BDGqD62dCNdxnOuVFABWrbABg1X858YoNmlX1ayHKx7C6yXFwwbB9fCezth/H6K1+/kuURwApcS7gD19glLeKKF2BkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVxseVZt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVxseVZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F01C1F00A3A;
	Tue, 21 Jul 2026 14:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643267;
	bh=tqbxt3y278iXN6ohccdVVcDmD1G+Sg1keCQvLR/Ac7Y=;
	h=From:Subject:Date:To:Cc;
	b=HVxseVZtpHJNvvLXnLl1GQ1lEMzzXBHTOOy5tjPGmFa6SBNTKBgdHkPRxEQka/3YG
	 R1IX5BGQ9X87JcEjEwViXps8HVUykF5nWwVA9XN+lvr6X1EdubiForupJwvENJun5r
	 auS7f10xxc6PY4sK6liwLXqUJhxx+4I3Key3OfBSkK7aO8CXnbThLDs9e9tMXxeQwc
	 GO0yKsj8guKveR9mVJzzqn0W7yFrOjrXrO/0JbZSL4L4hJajRSPHvOwOvsol6TRyTl
	 MMONtQcHg+yFjKOeRVl3lY2a3IDj8q2Ln4mXrIe5jeYdlniRQWn6G1G5n0QFdW0Rp9
	 T+6P4y8LLyqSA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/21] binfmt_misc: transparent interpreters and
 PT_INTERP loader substitution
Date: Tue, 21 Jul 2026 16:13:42 +0200
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJd+X2oC/4WOyw6CMBBFf4V07ZCCkYcr/8MY05YpjEgh04oaw
 79L1b3Lc3Nzcl7CIxN6sU9egnEmT6NbId8kwnTKtQjUrCxymReyzGq4j9yDnixocnYI54G8gSm
 QC8gTYIFY19YWWlVidUyMlh4f//H0ZX/TFzQhSuNDK4+gWTnTxWm2Hsp0m37t8dCRDyM/P4VzF
 kW/mFz+iZkzkNA0uixMrXaywkOP7PCajtyK07Isb4Caa4D+AAAA
X-Change-ID: 20260719-work-bpf-binfmt_misc-ptinterp-e6ee99ff6ba8
To: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6322; i=brauner@kernel.org;
 h=from:subject:message-id; bh=E1xjytujcSid3WpFAgBvYYkChqfWuL8uWCM2ZU8eHpI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1+3XWfU7e9nvsLur45sZI1R9uv/+W978LUw892vtf
 rvJ66y0OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayXYSR4eS9Mx2Si/5LX2rd
 wrZi1vtdm66Ip73yvN0z4Vzjnyqv628Y/kp5vq7ryZMu3OYvL+ean3DsrJkbr4DRvoB/JU5pUgu
 MWAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

binfmt_misc has exactly one execution model where the registered
interpreter becomes the executed program and the matched binary is
handed to it as an argument. For wine or qemu-user that is the point.
For a per-binary loader it is backwards. The interpreter is an
implementation detail of running the binary, yet it owns the entire
process identity:

- argv[0] and /proc/pid/cmdline show the interpreter invocation, not
  what the caller executed.

- /proc/self/exe names the interpreter. Relocatable programs commonly
  locate themselves through it and find the dynamic linker instead.

- A binary passed to execveat() as an inaccessible O_CLOEXEC fd
  cannot run at all as the interpreter has no path to open it by.

- gdb cross-validates AT_ENTRY/AT_PHDR against the exe file and
  discards the load displacement on mismatch leaving PIE symbols
  unrelocated.

This series adds two dispatch modes that close the gap from opposite
ends:

(1) transparent dispatch

    Registered with the 'T' flag or chosen per exec with
    BPF_BINPRM_TRANSPARENT. The binary is sent to the interpreter through
    AT_EXECFD, the argument vector stays exactly as the caller built it,
    and the kernel labels mm->exe_file and comm with the binary. A new
    AT_FLAGS_TRANSPARENT_INTERP aux vector bit is raised indicating that
    nothing was spliced, argv belongs to the program, and to load it from
    the descriptor.

    The interpreter keeps control of mapping the binary, so the mode
    covers foreign architectures and non-ELF payloads.

    The exe label is not a new privilege. It names precisely the file the
    caller passed to execve(), not a file of the process's choosing. That
    file is permission-checked, write-denied while the process runs and
    recorded by audit. Credential derivation does not change exactly as
    today.

(2) loader substitution

    The kernel executes the matched binary natively as the main image
    and substitutes the registered interpreter for the binary's
    PT_INTERP. binfmt_misc functions as a PT_INTERP override. There is
    no contract and no identity to reconstruct. So a stock dynamic
    loader works unchanged. Hence, 'L' is for native-arch ELF with
    PT_INTERP.

The two modes compose. A bpf handler reads the ELF header from bprm->buf
and grades per binary, picking 'L' where it applies and 'T' or classic
dispatch for the rest. If userspace control over relocation is wanted
'T' is the way to go.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- Move "exec: do not act on a stale execfd request without an
  executable" into vfs.fixes.
  Link: https://patch.msgid.link/20260720-beglichen-kognitiv-organismus-5e1e55326c56@brauner
- support 'L' for binfmt_elf_fdpic
- Share the substitution between the two ELF loaders instead of
  open-coding it twice.
- Reject a relative interpreter path when registering an 'L' or 'C'
  entry without 'F'.
- Map -ENOEXEC from the loader-substitution interpreter open to -EACCES.
- Keep the write denial on bprm->executable unconditionally until
  begin_new_exec() hands the file over.
- Reject a staged interpreter argument for a transparent dispatch
  instead of silently discarding it.
- WARN_ON_ONCE() a loader staged by an earlier format in
  load_misc_binary().
- Fix various selftests issues.
- Link to v1: https://patch.msgid.link/20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org

---
Christian Brauner (21):
      binfmt_misc: require an absolute interpreter path with 'C'
      docs, binfmt_misc: keep general usage out of the handler sections
      binfmt_misc: table-drive the register string flags
      binfmt_misc: normalize the per-exec invocation flags
      binfmt_misc: split out entry_open_interpreter() and build_interp_argv()
      exec: release the replaced file with do_close_execat()
      selftests/exec: convert the binfmt_misc bpf test to the kselftest harness
      exec: add AT_FLAGS_TRANSPARENT_INTERP
      exec: label mm->exe_file with the binary for a transparent dispatch
      binfmt_misc: add transparent interpreter dispatch
      binfmt_misc: add a static transparent flag 'T'
      binfmt_misc: let a bpf handler run the interpreter transparently
      selftests/exec: test the transparent binfmt_misc mode
      binfmt_misc: document the transparent identity contract
      exec: carry a PT_INTERP substitute in struct linux_binprm
      binfmt_elf: consume a stashed PT_INTERP substitute
      binfmt_elf_fdpic: consume a stashed PT_INTERP substitute
      binfmt_misc: add the 'L' loader substitution flag
      binfmt_misc: let a bpf handler request loader substitution
      selftests/exec: test binfmt_misc loader substitution
      binfmt_misc: document loader substitution

 Documentation/admin-guide/binfmt-misc.rst          | 177 ++++++++--
 fs/binfmt_elf.c                                    |  10 +-
 fs/binfmt_elf_fdpic.c                              |  11 +-
 fs/binfmt_misc.c                                   | 314 +++++++++++------
 fs/binfmt_misc_bpf.c                               |  22 +-
 fs/exec.c                                          |  84 ++++-
 include/linux/binfmt_misc.h                        |   8 +
 include/linux/binfmts.h                            |  25 ++
 include/uapi/linux/binfmts.h                       |   7 +
 tools/testing/selftests/exec/.gitignore            |   5 +
 tools/testing/selftests/exec/Makefile              |  27 +-
 .../testing/selftests/exec/binfmt_loader_payload.c | 167 ++++++++++
 tools/testing/selftests/exec/binfmt_misc_bpf.c     | 342 ++++++++++---------
 tools/testing/selftests/exec/binfmt_misc_common.h  | 205 ++++++++++++
 tools/testing/selftests/exec/binfmt_misc_loader.c  | 371 +++++++++++++++++++++
 .../selftests/exec/binfmt_misc_transparent.c       | 108 ++++++
 .../selftests/exec/binfmt_transparent_interp.c     | 130 ++++++++
 tools/testing/selftests/exec/loader.bpf.c          |  56 ++++
 tools/testing/selftests/exec/transparent.bpf.c     |  57 ++++
 19 files changed, 1823 insertions(+), 303 deletions(-)
---
base-commit: 6cea93ff6fe97df34b63fe94487473e16c73b74b
change-id: 20260719-work-bpf-binfmt_misc-ptinterp-e6ee99ff6ba8

