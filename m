Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238143BFAE2;
	Thu, 30 Jul 2026 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418483; cv=none; b=N6gQ9h/hCDmIZ5La6+uJf3tfqM3uTRayQPw+V86TyNM3NEC4LaXaBmKHz38uVS5CQiIMl9wj2Y2eR3GJApekew0zElYevQ8NX3GF0w1NKh64fDwZNIT8dZwTlO92wb5uSHWnH1W1cmuW0AdXzN3TI40KGp7QIAU4/e2vC2rWEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418483; c=relaxed/simple;
	bh=io4rvUC7+JoPMBsCH5pmm5CbseXDfdm4tqym72NwEk4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QEjx+vyNxKwPso8Dmy8LS2r0cfsk+KzVEdLPbI4paUCywO8ZVJszpet39duXMDTYPo3bexvzi4kDugrv4i43JVTx0o97IZaceKIjWyC6JAuSQh2xTtfOK0oH1QifZ6V4tk708uZR7nPBh+X1nDO8f8eK1v6BQPg2wkKVlY/AJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeZmocRT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeZmocRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE221F000E9;
	Thu, 30 Jul 2026 13:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785418481;
	bh=cTKth7UNQeBwmsZO2B2Pp13WvIQsQKMZ6nrWV73pGKM=;
	h=From:Subject:Date:To:Cc;
	b=oeZmocRTJDKm7/UH/6M2EoYytUvah2fMlxFriOxG1INcFHLoBFl+ggFV5uJK30tEQ
	 NQtHGLQ8xlDiwVIfFdoSN+WwbIaAROECahisvdnxdYm4ELvwtBk4bm0AyK4Ga95lOK
	 VRIIfaiOMgFTHC+uGMcc5ahTxyT87qsPdMGyvdMk2pyoT/RRIwZ3fGdFUraLnjYVlY
	 43u6SmbFPDntakSdhbZe0BnnRes+93D8j3e9LBb8kuyBGMdwQZEc7clypNfAgQcp1S
	 M68f0sWObqvXuhw/WrrtRO79N07GJalU462KMbshwv8xCCYcqqLZRO+ahPiynaFDo+
	 /PJivJEAGNU+Q==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/9] binfmt_misc: bind interpreters to a bpf-backed entry
Date: Thu, 30 Jul 2026 15:34:02 +0200
Message-Id: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpSa2oC/yWMUQ6CMBAFr0L22yUFFIJXIcbQdiuroSVdRBPC3
 S3yOZP3ZgWhyCRwzVaItLBw8AmKUwZm6P2DkG1iKFVZq6Zs8RPiCzV7N873kcXgFClM5LGtL5X
 TrS2sOkO6J+/4+093t4PlrZ9k5r23L3QvhDr23gy7Wpxgk1f5EYdt+wFB2SGQnQAAAA==
X-Change-ID: 20260729-work-binfmt_misc-preopen-9653fb9d1d04
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-3e0c3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3493; i=brauner@kernel.org;
 h=from:subject:message-id; bh=io4rvUC7+JoPMBsCH5pmm5CbseXDfdm4tqym72NwEk4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlB71bM6l2ccmN36uk9y1vqdhqbFj+XT5qzgXTDQqai
 7ao/VD92FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR9QpGhokyak8Kd06PN9Dw
 nii75EnMjCe3YqrbHladb974muFH+2yG/24yM2O3qC356rI9+0q6vJXrlvDjXwIc/m8NsHmz4uV
 pP3YA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A 'B' entry's load program hands the kernel an absolute path and
open_exec() resolves it at exec time in the mount namespace of whoever
runs the binary. So the handler names an interpreter but never gets to
say which file that is. Whoever controls the filesystem view of the exec
does.

Static entries have had the answer for a while. 'F' opens the file at
registration and every exec runs a clone of it. I can't just reuse it as
it stands. It pre-opens the one interpreter named in the register string
and a 'B' entry has no fixed interpreter. The program picks per exec,
and a qemu-user shaped handler wants one per guest architecture. So it
may want a whole set of them and that doesn't fit in a register string.

An entry is matchable the moment it is registered, so everything it
needs has to fit in that one write. Patch 1 adds a 'D' flag that creates
the entry disabled and splits a registration into create and activate:

    echo ':qemu:B::::qemu_user:D' > register
    echo '+aarch64 /usr/bin/qemu-aarch64' > qemu
    echo '+arm /usr/bin/qemu-arm' > qemu
    echo 1 > qemu

Each path is opened by its write, with the credentials the entry file was
opened with. Same open_exec() call, same place as 'F'. The program picks
one per exec with bpf_binprm_select_interp() and gets a clone of the
file. Nothing is resolved again, in any namespace.

A 'D' entry simply isn't hashed until that first '1', so the rcu
insertion that publishes the entry also publishes its interpreters and
the exec side needs no barriers. Reading the entry file doesn't take any
locks either. Bindings are rcu-published and the open file already pins
everything the read looks at. We use paths, not fds which makes the
config remain nice and static and can be shipped via /etc/binfmt.d.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (9):
      binfmt_misc: let a register string create an entry disabled
      selftests/exec: let binfmt_flag_supported() return a bool
      selftests/exec: test registering an entry disabled
      binfmt_misc: document registering an entry disabled
      selftests/exec: share the bpf handler preconditions
      binfmt_misc: carry pre-opened interpreters in struct binfmt_misc_interp
      binfmt_misc: let a 'B' entry bind its interpreters
      selftests/exec: test interpreters bound to a 'B' entry
      binfmt_misc: document interpreters bound by a 'B' entry

 Documentation/admin-guide/binfmt-misc.rst          |  75 +++-
 fs/binfmt_misc.c                                   | 459 +++++++++++++++++----
 fs/binfmt_misc_bpf.c                               |  75 +++-
 fs/exec.c                                          |   2 +
 include/linux/binfmt_misc.h                        |  39 +-
 include/linux/binfmts.h                            |   3 +
 tools/testing/selftests/exec/Makefile              |  11 +-
 tools/testing/selftests/exec/binfmt_bind_interp.c  |  14 +
 tools/testing/selftests/exec/binfmt_misc_bpf.c     | 306 ++++++++++++--
 tools/testing/selftests/exec/binfmt_misc_common.h  |  45 +-
 .../testing/selftests/exec/binfmt_misc_disabled.c  | 172 ++++++++
 .../selftests/exec/binfmt_misc_transparent.c       |   2 +-
 tools/testing/selftests/exec/interp_bind.bpf.c     |  76 ++++
 13 files changed, 1164 insertions(+), 115 deletions(-)
---
base-commit: 4bdcf682a476e8d9f52b2c5c01e998d70e45656c
change-id: 20260729-work-binfmt_misc-preopen-9653fb9d1d04

