Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A769238D27;
	Tue,  7 Jul 2026 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453028; cv=none; b=nJF0fNjSJBNd8Dca9nibeTXkibiXQl1jdNKM9dq9J0PuScVtb1r9u0T29VxqyWbTsxWCCGLBkqLWLRg2QSgLN1FpC0UEWx0nVPVNwDFsHoR3dSqT2xtHP6hHXZMCEvyUPJlnc+He5uPjgyXnikUNVdlQZqe49t/T4zfYV68o2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453028; c=relaxed/simple;
	bh=yKu5qj7eKjA1JXXIoGTmnPEVv3FdKvaF/LpZwd0PtMw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u2Z6M54eMeCQU6Dj/7XkPX4uTtsbQyKPP9F9tZDVEN10JnU+1iG7OwValiZNhc97PwIw2Fg3E3YK/W8C1P0Gn7175xohFm6MSla8oAWd0XJj6xGzOFVy8Kn7AXez5RWuMMyT9EVIx/QFNIXDMafCDzRdZhz2wXHRVJvKyG9lbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaMgFmqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaMgFmqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEFD1F000E9;
	Tue,  7 Jul 2026 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783453027;
	bh=gPg3vEkTcsR+KYYDQEQ2rLyjD9CYaZB6AwFxCwPiuy0=;
	h=From:Subject:Date:To:Cc;
	b=IaMgFmqU5pubSutB4iA1G7DbzzM5RtlUJsfqzS2sQXdzTzfjZMrYd20PogFsSLOBc
	 p8qBZ+n50ZcMzHX3QujgzaxCBEqACvFhoEQx972siupx1b4zBAKPcZSS7eOoocx3Hr
	 /+G2/b/La0Rvtfl/RonslsVnGXwyOFVTr3yKIPxGf7dTs3KVD3ABUtS/2uArK2ZK3F
	 3BB7ahSY0kTShyiXiJldj61HeTt2Md+01Tpf3MYJKpvqBS8TSMuyvC9wEZRm752n3E
	 DHkW2RP0vTvgN4PZ2iMGLLezxFtd5qM31XAk5iRuRjHmAbPGP+2k81K1ZMSoV14GCQ
	 SMFe37CVIsftQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC POC 0/4] binfmt_misc: bpf-backed binary type handlers
Date: Tue, 07 Jul 2026 21:36:44 +0200
Message-Id: <20260707-work-bpf-binfmt_misc-v1-0-74b995c84ec1@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1VTWoC/yWMTQuCQBCG/4rMuZFVq4WuQteia0TsbmNO4SozZ
 oH439M6Pu/HM4KSMCnskhGEBlZu4wzZKoFQu3gn5NvMkJt8a6yx+G7lib6r0HOsmv7asAYk4+2
 mWGe2KAjmaydU8eenPcNpXybHQwmXf6Ev/6DQL9Jl6p0SenEx1EvUOO1J0sGmOUrIYJq+9tK5e
 aMAAAA=
X-Change-ID: 20260707-work-bpf-binfmt_misc-e0b75341733e
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 jannh@google.com, linux-mm@kvack.org, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6770; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yKu5qj7eKjA1JXXIoGTmnPEVv3FdKvaF/LpZwd0PtMw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5hiZs5W7tKJ86Sab+qgaX08U2icTV382fiCZbKzimH
 WJnurGlo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIm/Ax/BW0mZEgy+pvWLWA+
 OfXUJ9Hvy1e8kdP/eH9pwEY2n6AHCQz/0+f8uSTUkeh/9LbzblEJdvsU+6kv1HhvXhGzOKcc/N2
 ZHQA=
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
{c,sh}ould actually look like. It is a POC: it builds, the design is
what I want to discuss, selftests and runtime testing are still missing.

A handler is an instance of the new binfmt_misc_ops struct_ops with a
single sleepable op and a name:

	struct binfmt_misc_ops {
		int (*load)(struct linux_binprm *bprm);
		char name[BINFMT_MISC_OPS_NAME_MAX];
	};

The load program receives the bprm as a trusted BTF pointer, so it can
match on the header in bprm->buf, read arbitrary file content through
bpf_dynptr_from_file() (e.g. to parse ELF program headers), and resolve
the binary's location via bpf_path_d_path() on &bprm->file->f_path. That
also solves the prototype's limitation of only seeing the first 256
bytes of the file.

The one genuinely new piece of bpf surface is a single kfunc:

	int bpf_binprm_set_interp(struct linux_binprm *bprm,
				  const char *path, size_t path__sz);

which stages an absolute path in the bprm. It cannot go through
bprm_change_interp() directly because load_misc_binary() copies
bprm->interp into argv[1] after the program ran, hence the staging field
added in patch 1.

Registering (attaching) the struct_ops map publishes the handler under
its name in a registry keyed by the registering task's user namespace.
Activation reuses the existing text interface with a new 'B' type where
the offset field carries the handler name and magic, mask, and
interpreter must be empty:

	echo ':origin:B:nix::::' > /proc/sys/fs/binfmt_misc/register

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

The 'C' and 'F' flags are rejected for 'B' entries. 'F' has no fixed
interpreter to pre-open and 'C' would let a program-chosen interpreter
run with a setuid binary's credentials. AT_EXECVE_CHECK never invokes
programs and interpreter chains stay capped by the usual ELOOP depth.

A handler for the Nix case then looks roughly like:

	SEC("struct_ops.s/load")
	int BPF_PROG(nix_load, struct linux_binprm *bprm)
	{
		char path[256];
		long n;

		if (bpf_strncmp(bprm->buf, 4, "\x7f" "ELF"))
			return 0;

		n = bpf_path_d_path(&bprm->file->f_path, path, sizeof(path));
		if (n < 0)
			return 0;

		/* derive the loader location from the binary's path */

		return bpf_binprm_set_interp(bprm, path, sizeof(path)) ?: 1;
	}

	SEC(".struct_ops.link")
	struct binfmt_misc_ops nix = {
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
Christian Brauner (4):
      exec: stash a bpf-selected interpreter in struct linux_binprm
      binfmt_misc: add binfmt_misc_ops bpf struct_ops
      binfmt_misc: wire up bpf-backed 'B' entries
      bpf: allow fs kfuncs for binfmt_misc_ops programs

 Documentation/admin-guide/binfmt-misc.rst |  40 ++++-
 fs/Kconfig.binfmt                         |  14 ++
 fs/Makefile                               |   1 +
 fs/binfmt_misc.c                          | 143 ++++++++++++++--
 fs/binfmt_misc_bpf.c                      | 275 ++++++++++++++++++++++++++++++
 fs/bpf_fs_kfuncs.c                        |  23 ++-
 fs/exec.c                                 |   1 +
 include/linux/binfmt_misc.h               |  49 ++++++
 include/linux/binfmts.h                   |   1 +
 9 files changed, 529 insertions(+), 18 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260707-work-bpf-binfmt_misc-e0b75341733e

