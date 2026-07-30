Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709A433BC6;
	Thu, 30 Jul 2026 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418511; cv=none; b=eDqjHk7RZtj1Ntf1d2B8a7suQe0kmFZUfWRZw3m8FJE6bQsfeuX24V4sRdqlsUMA0YuKJ8Mwgjt2KYXpRh8Gp9snCuG2oaY7AgxMWX9sJKNRtoaOH4jV53KxIn0XZnJ6YEDKXjkIj9Yl51DoTAdzWnKfg0+znygfl3qrLR9V6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418511; c=relaxed/simple;
	bh=ZgIy0p0xGptvlB+oxU1uGqExeQGJH889CMBMK7z03Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ki54LAE181xKpdqaO1X6hAe6Vy0pNFQud/ci6nxYyZg6gKW+btw8m1FgzGM4XUl1AKvkNzTlvnf8oyi1TGQxOvE7Gk8V3AGZDNcd9OI0TVcLvenmWXHWv327AmuZJgfktKQIg39x3NGLtpAYsu2j6CFcsHkWT7P0t4f6DHtHjyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaEA3rl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaEA3rl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E5A1F00A3A;
	Thu, 30 Jul 2026 13:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785418509;
	bh=z2257Xq+XVLaRCtpiJteqDp78M7Gp8HHO3wMLpggA60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iaEA3rl6qCrrchvoPMIgoqeuEHTg7TVXdrfny4buMU97tftIO9RLtblTDpmGLrLJm
	 zDXRCFcNUrTtS/+fmg2q+oudI7VKn9lpuyUFnSoUyrxnC2yVviWyC1XGU4eSrf06we
	 V0nMQ5Y5c0oUetb9niF4eST5Qa9xw4NL82U9qcfCL9Ps6s7jIUe5UxANGtsKsmKctc
	 sI6wvTvRssX9i/AGskL52y+5GL/eorsxYPRaeuGbUaRNXeFuGvbEzELHQrJBrKAghv
	 MVWsMIcDlCR8Oqt8xid3BsdNz6UlYU1MYQFHGKIjR/OvAvAhDgecYC8L2CD2fl0LGJ
	 VcLh191qsKdNw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Jul 2026 15:34:11 +0200
Subject: [PATCH 9/9] binfmt_misc: document interpreters bound by a 'B'
 entry
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-work-binfmt_misc-preopen-v1-9-4a0b0da71f16@kernel.org>
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
In-Reply-To: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-3e0c3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5175; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZgIy0p0xGptvlB+oxU1uGqExeQGJH889CMBMK7z03Hs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlB73n5Kvc6W3QxL/N5z0XVyVP5r95sV0MzOGsXQIHn
 x8q3sDfUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBGP84wMbed1ty4NDLw8/Y/2
 SsHGmX3O/NeT9Jv1vSKdvrjc7b21j5Ghw53Hc/v91ne3fiz+cVxSppZNuKlI4lWRZVBMbaBN2A5
 OAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Describe the interpreters a 'B' entry can bind while it is disabled, what
binding a file buys over naming a path the exec resolves, how a load
program picks one, that an entry binds at most 100 interpreters, and
that enabling the entry seals the set.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 66 ++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 8254ddcb3389..3e2b2a9415bc 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -195,9 +195,62 @@ and derive the interpreter from the binary's location. It selects the
 interpreter by calling the ``bpf_binprm_set_interp()`` kfunc with an
 absolute path and returning ``0``. A match is committed: a failing
 ``load`` fails the exec with its error instead of falling through to later
-entries; ``-ENOEXEC`` lets the remaining binary formats have a go. The
-interpreter is opened with the credentials of the task doing the exec,
-exactly as a statically registered interpreter would be.
+entries; ``-ENOEXEC`` lets the remaining binary formats have a go. A path
+selected this way is opened with the credentials of the task doing the
+exec, exactly as a statically registered interpreter without ``F`` would
+be.
+
+An entry can instead bind the interpreters its handler may use, so that no
+path is resolved at exec time at all. An entry registered with ``D`` is not
+matchable yet, which is what leaves it open to being given them, one
+``+name path`` write at a time::
+
+    echo ':qemu:B::::my_handler:D' > register
+    echo '+aarch64 /usr/bin/qemu-aarch64' > qemu
+    echo '+arm /usr/bin/qemu-arm' > qemu
+    echo 1 > qemu
+
+Each path is opened during its write, in the writing process's context and
+with the credentials the entry file was opened with, exactly the way ``F``
+pre-opens a static entry's interpreter; the paths must be absolute. The
+path is everything past the first space, so there is nothing it cannot
+express, and no interpreter has to fit in a register string. An entry
+binds at most 100 interpreters; a write past that is refused with
+``-ENOSPC``. To bind a file that has no path of its own - already
+unlinked, a ``memfd``, or reachable only in another mount namespace -
+open it and write ``/proc/self/fd/N``.
+
+The ``load`` program then selects one per exec by name with the
+``bpf_binprm_select_interp()`` kfunc, and every exec runs a clone of the
+file that was opened. The path decides which file is bound and nothing
+else: it is not resolved again, in any namespace, so what it holds later -
+or what it holds in the namespace of whoever runs the binary - no longer
+decides anything.
+
+Enabling the entry ends this. Its interpreters are read at exec time with
+nothing but a reference held on the entry, so an entry that has ever been
+matchable can never have its set changed again: the first ``1`` seals it,
+from then on ``+`` is refused with ``-EBUSY``, and an entry registered
+without ``D`` is sealed from the start. Binding a name twice is refused
+with ``-EEXIST``.
+
+Selection is by name so that the configuration and the program need not
+agree on an order, and so that a handler is not tied to where a distribution
+puts its interpreters. A name is a single word of printable ASCII, at most
+32 characters; a name the entry did not bind gives the program ``-ENOENT``,
+which it can act on or return. The interpreter runs under the path it was
+registered under, and the entry reports what it bound::
+
+    $ cat /proc/sys/fs/binfmt_misc/qemu
+    enabled
+    bpf my_handler
+    bpf-interpreter aarch64 /usr/bin/qemu-aarch64
+    bpf-interpreter arm /usr/bin/qemu-arm
+    flags:
+
+The path reported is the one the interpreter was bound under, which named
+the file at that moment; it is not re-resolved, so it is a record of what
+was bound rather than a promise about what that path holds now.
 
 The ``load`` program can also pass a single argument to the interpreter with
 the ``bpf_binprm_set_interp_arg()`` kfunc. It is inserted between the
@@ -234,9 +287,10 @@ handler can decide them differently for each binary it handles:
   flag). It excludes the other flags and a staged interpreter argument.
 
 Because these are program choices, a ``B`` entry carries no invocation
-flags in the register string; ``F`` (pre-open a fixed interpreter) has no
-meaning for it. The registration directive ``D`` is the exception: it
-decides how the entry starts out, not how the interpreter is invoked.
+flags in the register string; ``F`` has none to spell for it either, since
+the interpreters it binds already pre-open what ``F`` would. The
+registration directive ``D`` is the exception: it decides how the entry
+starts out, not how the interpreter is invoked.
 
 Handlers are looked up in the user namespace the struct_ops map was
 registered in, falling back to ancestor namespaces, mirroring how

-- 
2.53.0

