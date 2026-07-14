Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB143A7EB;
	Tue, 14 Jul 2026 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059100; cv=none; b=FMvws1L7BJskv6/7NV93qkjXcCZMjaHmz22bo89HKXTRGr6W4ATdbbwzy7IRbRNSQ1k5YAMKnDZQYw2qvsn8uve5F5V2Y9+jzqUWzrrT31Ihl0bYLtKqRP6tBoLAhjRt2zFef73Eu1vE4TW9XB6a9l6vYcNS95gMicfTFHeqRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059100; c=relaxed/simple;
	bh=+Fhq4WBUwXUuVMPhkkNw3LIZ5NFYviQlVdneWiRlnYc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h+mDWwkM77zeFVb4q6PUTzSxn6WWU5D2gxttrVqrzVPUCQNtDexVkv8FkFxMOouJdIkhpW0LZgEe0UZ5ew69jtChUxhUkWA9uvZlHwtzSnCJIEi11VvP+4bh4DVhoiBNWqjL3myeSXIn8xNanT5huGPBQhkXIovB3c71tN5XZpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgvXNdtu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgvXNdtu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5CD1F000E9;
	Tue, 14 Jul 2026 19:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059096;
	bh=Iuyux5xbPAzzpVBZ7DcRFpizqwoZ1n/qz3miW0eeZ0o=;
	h=From:Subject:Date:To:Cc;
	b=fgvXNdtuwo5j+sPp4ijS+Kyg2MMqH5ALAfVv8b9N4q+ySTmtoDEOShg+v9O3Rfvow
	 UZNy6A5T8drm+viHBE1cYO2mWBZIrDcUvaddjh+k+vHXtD0dZi7IO7j6lu1DNr/WtL
	 fOeEl3T7WoiB8fkP4KTT7Xw8wlz1EscA3u9Xcyp7yrJu9QmksCBCFkmG1LWo5JgCKo
	 aibt+TRPMNOYHIs6NWCVhfmnt/THIzpc/oKYTJ+O2aIK8JpyibkJRRQr8yH7oYSGmU
	 2u9C/Vk0yCtJRrVfpbmzA4Hadzw4NKHoAgl1XiL2zdeR+Wm0VCpKqNXTKiyOj3e+ul
	 ybLDbj7syXuDQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/9] binfmt_misc: bpf-backed binary type handlers
Date: Tue, 14 Jul 2026 21:58:05 +0200
Message-Id: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM2UVmoC/4WOQQ6CMBREr0K69pNCwYor72GIofUXKtKSFquGc
 HcpHMDlm8y8zEw8Oo2enJOZOAzaa2tWyA8JkV1jWgR9X5nkND9STjm8retBjAqENmqYboP2EpA
 KXrIi44whWaejQ6U/m/Za7+xf4oFyiq7YEI1HEK4xsotRUB54ytJdGgud9pN13+1YyKLoz4eQA
 QVeiKoq5alAmV16dAafqXUtqZdl+QHRPZzf7AAAAA==
X-Change-ID: 20260707-work-bpf-binfmt_misc-e0b75341733e
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, bpf@vger.kernel.org, jannh@google.com, 
 mail@johnericson.me, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=12582; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+Fhq4WBUwXUuVMPhkkNw3LIZ5NFYviQlVdneWiRlnYc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSFTbm8+dXEkqtiMmqdES9lMjJijr2X2e2kzH1bZNIu8
 d3n09Zv7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI3TCGf+aOydezDNm/T7A6
 NqPG+JYn97G3h3a8juj6cNN+1wrWn/yMDFcOCb/s3r28tOX47bKvTMo7X17ssGZ7EKbdlVuVN8f
 WmxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This is a POC for the nix people and Farid and Eric in particular. I
would take my hands off the wheel now that I POCed this and hand it to
Farid if he likes to take it forward.

VL;MR (very long, must read):

For a while now Farid has been trying to make relocatable, hermetic
binaries (think Nix-style store layouts) work without patchelf tricks
or wrapper scripts. For such binaries the right dynamic loader can only
be determined relative to the location of the binary itself, which
neither PT_INTERP nor a fixed binfmt_misc interpreter string can
express.

The first attempt was $ORIGIN expansion in PT_INTERP [1]. I pushed back
on that. Userspace guards $ORIGIN behind AT_SECURE so the kernel would
have to make the used loader depend on the type of binary, LSMs would
need a say, it changes long-standing behavior in ways that are ripe for
loader injection attacks, and bprm->file may not have a usable path at
all (memfds, deleted files, unresolvable paths). Making the kernel
splice bprm->file back together with PT_INTERP is terrible. The second
attempt was a pluggable ELF interpreter loader registry [2] which would
mean actual kernel modules for custom binary formats. Also no.
binfmt_misc was invented to kill exactly this horrendous past.

What I suggested instead [3] was to put this where delegating binary
formats to userspace already lives: binfmt_misc. The only things
binfmt_misc cannot do today are matching programmatically and computing
the interpreter per binary instead of using a fixed string recorded at
registration time. Farid prototyped that with an eBPF program [4] and
it turned out quite workable, but the prototype ran a SOCKET_FILTER
program over bprm->buf, added a new helper to the frozen uapi helper
list, and returned the computed path through per-CPU memory.

This series is the proposal turned into what I think the bpf side
{c,sh}ould actually look like. It is a POC: it builds, the selftests
pass, and the design is what I want to discuss. The selftests are
Farid's from his v2 posting, adapted to the contract below.

A handler is an instance of the new binfmt_misc_ops struct_ops with a
name and two ops:

	struct binfmt_misc_ops {
		bool (*match)(struct linux_binprm *bprm);
		int (*load)(struct linux_binprm *bprm);
		char name[BINFMT_MISC_OPS_NAME_MAX];
	};

Both programs receive the bprm as a trusted BTF pointer and both are
sleepable. The match program decides from the entry lookup walk whether
the handler applies, under the same rules as magic matching:
registration order, first match wins. It is not limited to the
prefetched 256 bytes in bprm->buf: it can read arbitrary file content
through bpf_dynptr_from_file(), e.g. to find an ELF interpreter
segment at whatever offset it sits. That is what makes multiple
independent handlers workable at all - a handler that cannot read the
file would have to match broadly and reject from its load program,
stealing the binaries of every handler registered after it. To make
this safe the entry walk becomes an SRCU read-side section. The load
program of the matched handler then selects the interpreter, reading
the file the same way and resolving the binary's location via
bpf_path_d_path() on &bprm->file->f_path. That also solves the
prototype's limitation of only seeing the first 256 bytes of the file.
Selecting is the load program's privilege: the verifier rejects the
selection kfuncs in match, keyed off the struct_ops member a program
attaches to. A match commits the exec to the handler: a failing load
fails the exec instead of falling through to later entries, with
-ENOEXEC handing over to the remaining binary formats, so the walk is
never left and re-entered.

The genuinely new piece of bpf surface is a small family of kfuncs:

	int bpf_binprm_set_interp(struct linux_binprm *bprm,
				  const char *path, size_t path__sz);
	int bpf_binprm_set_interp_arg(struct linux_binprm *bprm,
				      const char *arg, size_t arg__sz);
	int bpf_binprm_set_flags(struct linux_binprm *bprm,
				 enum bpf_binprm_flags flags);

staging the selected interpreter, an optional single argument for it
(the slot the optional argument of a #! interpreter line has), and the
per-exec invocation flags - 'P', 'C' and 'O' equivalents plus a
transparent invocation mode as BPF_BINPRM_* bits - in the bprm.
Selection cannot go through bprm_change_interp() directly because
load_misc_binary() copies bprm->interp into argv[1] after the program
ran, hence the staging fields added in patch 1.

Registering (attaching) the struct_ops map publishes the handler under
its name in a registry keyed by the registering task's user namespace.
Activation reuses the existing text interface with a new 'B' type where
the interpreter field carries the handler name - it consistently names
whoever supplies the interpreter - and offset, magic, and mask must be
empty:

	echo ':origin:B::::nix:' > /proc/sys/fs/binfmt_misc/register

This keeps the existing permission and namespacing model completely
intact. Activating a handler requires the same write access to a
binfmt_misc instance as any other registration, a container mounting
its own instance escapes the host's entries exactly as before, and
shadowing e.g. all ELF binaries takes the same privilege as a static
'M' entry matching \x7fELF does today.

The only novelty is that matching becomes programmable. Handler lookup
walks the user namespace hierarchy upwards, mirroring how binfmt_misc
instances themselves are resolved, so a handler registered on the host
can be activated from a container's own instance without being forced
upon it.

The computed interpreter is opened with open_exec() under the caller's
credentials and goes through the full LSM vetting as the next binprm
level, exactly like a statically registered interpreter, so the program
cannot widen access. It only ever redirects the caller to something the
caller could exec anyway.

A 'B' entry carries no flags in the register string: the load program
chooses the invocation flags per exec through bpf_binprm_set_flags()
instead. BPF_BINPRM_PRESERVE_ARGV0, BPF_BINPRM_CREDENTIALS and
BPF_BINPRM_EXECFD keep the static 'P', 'C' and 'O' semantics -
BPF_BINPRM_CREDENTIALS honors the matched binary's suid bits exactly
as a static 'C' entry does, with the setuid transition gated by
vfsuid_has_mapping() in the caller's user namespace either way, which
makes 'B' handlers usable for a per-binary loader over setuid
binaries. BPF_BINPRM_TRANSPARENT has no static counterpart: the binary
is handed to the interpreter through AT_EXECFD with the argument
vector left untouched, so the exec looks like a direct execution of
the binary and a binary passed as an inaccessible O_CLOEXEC fd to
execveat() can be run at all. 'F' (pre-open a fixed interpreter) is
rejected: a 'B' entry has no fixed interpreter. AT_EXECVE_CHECK never
invokes programs and interpreter chains stay capped by the usual ELOOP
depth.

A handler for the Nix case then looks roughly like:

	SEC("struct_ops.s/match")
	bool BPF_PROG(nix_match, struct linux_binprm *bprm)
	{
		return !bpf_strncmp(bprm->buf, 4, "\x7f" "ELF");
	}

	SEC("struct_ops.s/load")
	int BPF_PROG(nix_load, struct linux_binprm *bprm)
	{
		char path[256];
		long n;

		n = bpf_path_d_path(&bprm->file->f_path, path, sizeof(path));
		if (n < 0)
			return n;

		/* derive the loader location from the binary's path */

		return bpf_binprm_set_interp(bprm, path, sizeof(path));
	}

	SEC(".struct_ops.link")
	struct binfmt_misc_ops nix = {
		.match = (void *)nix_match,
		.load = (void *)nix_load,
		.name = "nix",
	};

Farid, this should slot underneath your qemu demo from [4] with the
program ported to struct_ops. Feel free to take it from here.

[1]: https://lore.kernel.org/20260622043934.179879-1-farid.m.zakaria@gmail.com
[2]: https://lore.kernel.org/20260702214247.1253741-1-farid.m.zakaria@gmail.com
[3]: https://lore.kernel.org/20260703-meditation-ratsuchende-moratorium-9ecdf1f3f8bb@brauner
[4]: https://lore.kernel.org/20260704211409.1978485-1-farid.m.zakaria@gmail.com

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- Rebase onto vfs-7.3.binfmt (write access fixes, RCU handler lookup
  and cleanups): the entry walk is lockless now.
- Split the handler into a match program consulted from the lookup
  walk itself - exactly like magic/extension matching - and the load
  program invoked once the walk has committed to the entry. Both are
  sleepable and can read the file: a match limited to the prefetched
  bprm->buf cannot recognise formats whose distinguishing data sits
  past 256 bytes, and with several handlers registered
  match-broadly-and-reject-in-load would break first-match-wins. The
  entry walk becomes an SRCU read-side section (srcu-fast) to allow
  that. The selection kfuncs are restricted to the load program by the
  verifier via the struct_ops member offset. A failing load fails the
  exec instead of falling through to later entries, so the walk is
  never left and re-entered: the v1 skip cursor and its rescan loop
  are gone and 'B' entries need no special semantics against
  concurrent (un)registration.
- Move the handler name from the offset field to the interpreter
  field: it consistently names whoever supplies the interpreter, a
  path for static entries and a handler for 'B' entries.
- Let the load program pass a single optional argument to the
  interpreter via the new bpf_binprm_set_interp_arg() kfunc, mirroring
  the optional argument of a #! interpreter line.
- Let the load program choose the invocation flags per exec via the
  new bpf_binprm_set_flags() kfunc - BPF_BINPRM_PRESERVE_ARGV0,
  BPF_BINPRM_CREDENTIALS and BPF_BINPRM_EXECFD mirroring 'P', 'C' and
  'O' - instead of fixing them at registration; the register string
  rejects 'P', 'C' and 'O' for 'B' entries. BPF_BINPRM_CREDENTIALS
  keeps the static 'C' semantics: the setuid transition stays gated by
  vfsuid_has_mapping() in the caller's user namespace.
- Add BPF_BINPRM_TRANSPARENT on top of the static flags: the binary is
  handed to the interpreter through AT_EXECFD with the argument vector
  left untouched, so the exec looks like a direct execution of the
  binary and a binary passed as an inaccessible O_CLOEXEC fd to
  execveat() can be run at all.
- Picked up Farid's selftests from his v2 posting and adapted them to
  the contract above: the register grammar, both programs sleepable
  with nix_origin's match reading PT_INTERP itself, the load return
  convention, and a skip on kernels without CONFIG_BINFMT_MISC_BPF.

---
Christian Brauner (8):
      exec: stash bpf-selected interpreter state in struct linux_binprm
      binfmt_misc: add binfmt_misc_ops bpf struct_ops
      binfmt_misc: let the entry lookup walk sleep
      binfmt_misc: wire up bpf-backed 'B' entries
      bpf: allow fs kfuncs for binfmt_misc_ops programs
      binfmt_misc: let bpf handlers pass an argument to the interpreter
      binfmt_misc: let a bpf handler choose the invocation flags per exec
      binfmt_misc: let a bpf handler run the interpreter transparently

Farid Zakaria (1):
      selftests/exec: add binfmt_misc bpf-backed handler test

 Documentation/admin-guide/binfmt-misc.rst        |  73 ++++-
 fs/Kconfig.binfmt                                |  14 +
 fs/Makefile                                      |   1 +
 fs/binfmt_misc.c                                 | 306 ++++++++++++++++----
 fs/binfmt_misc_bpf.c                             | 351 +++++++++++++++++++++++
 fs/bpf_fs_kfuncs.c                               |  23 +-
 fs/exec.c                                        |   2 +
 include/linux/binfmt_misc.h                      |  74 +++++
 include/linux/binfmts.h                          |   8 +
 tools/testing/selftests/exec/.gitignore          |   5 +
 tools/testing/selftests/exec/Makefile            |  48 ++++
 tools/testing/selftests/exec/binfmt_bpf_app.c    |  12 +
 tools/testing/selftests/exec/binfmt_bpf_interp.c |  15 +
 tools/testing/selftests/exec/binfmt_misc_bpf.c   | 277 ++++++++++++++++++
 tools/testing/selftests/exec/bpf_interp.bpf.c    |  61 ++++
 tools/testing/selftests/exec/nix_origin.bpf.c    | 224 +++++++++++++++
 16 files changed, 1434 insertions(+), 60 deletions(-)
---
base-commit: 79dec1889331ba2d4898886779f4d0a063f6a1ef
change-id: 20260707-work-bpf-binfmt_misc-e0b75341733e

