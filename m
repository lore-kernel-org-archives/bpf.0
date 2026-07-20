Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A53D6CB0;
	Mon, 20 Jul 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540047; cv=none; b=BTUwTmAy1Al5EFJwfBo6e2mDdRU7siors7LSFQN2gTqNK1EvccbrhYZW/Jf94dEDXZwY/bDFux1ek26UyifcVEV27qP5pLZ4nlv1PkzjW6BwjWGyr4r+PGbCQ7zRP6JqavRD3RZzQp+zchb9H94UX7dez2sw35hce8IabKagI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540047; c=relaxed/simple;
	bh=2Dmgft1OiugYUN2xyA/RXN0gIP7maCn/2G4x9cjoFwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzlxyaVnD7utU7Q9fEYTed0GXPZw3ibOdBk+3kL8Z6I4bFdIIg76gBOYsq3BUBHaT6kadxzSHecP4NRLGYixqeBBg/jZwTNCI83i5yOy1ggXJg5qcTrYM+XkqUd05xXsCcb5IVns1zZy5GxTRjTUXGPKnnxzgrPSDaE+Jz2k/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRoTrgBZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRoTrgBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF711F000E9;
	Mon, 20 Jul 2026 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540045;
	bh=F4itZKWQME8jwhlzgHXdE8ELH+XUCzY/UCLuUE5rOx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oRoTrgBZPFtsB54X1XUeaOOhvGJlOE1ogUwA52KlsK/cRgu5W9tXkCYkheS9qW888
	 1EnZWIGAq4NvQgMRVkvct5/3yrt3ls0u4qcAEqpCxFrfgPEr2MQlHfPvhz1cVBDr8S
	 gQ3HOHrFcagVkOsgphdD7clxfADYmyKCVBQzv1g9NJ7wZFhzQPdFsW/F1O37PwYTeM
	 w3imUNEhUN+m35QKkrAq5air73Lb4rNSE+PDDIXLEHDANrYOkRxgCGdFGj3yX17kxa
	 KZ9GwBcunDbc66c23nUU7IT8FizNVIiUwdY76P5xE4SOc27RUK47emzFVLVxRIJ3bM
	 eHwcp1p1IfLXw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:25 +0200
Subject: [PATCH 02/21] docs, binfmt_misc: keep general usage out of the
 handler sections
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-2-ddb76c9a508e@kernel.org>
References: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
In-Reply-To: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5004; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2Dmgft1OiugYUN2xyA/RXN0gIP7maCn/2G4x9cjoFwg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm40X7L1b1+9ybPj7y9eOdV5KMBbZeKCHDZOxiC+6
 RztHgv2dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk0pPhf7zbA81D/brTWXdw
 PNxpm9yt72jpntofcUH2x/e9X2WXWzAy3CyJ+TA/4GC1xoPmxDNFM55/fbF6tsBMFYcVAv06tlI
 5DAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The general usage trails the bpf-backed handlers section and therefore
reads as part of it. It predates that section and applies to binfmt_misc
as a whole.

Move it back up so the handler section ends where the file does.
Upcoming sections describing the transparent and loader dispatch modes
append after it without swallowing the general prose again.

Pure text move, no content changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 79 ++++++++++++++++---------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 7f42abf9cfba..c76381a4bcad 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -100,6 +100,46 @@ There are some restrictions:
  - the interpreter string may not exceed 127 characters
 
 
+To use binfmt_misc you have to mount it first. You can mount it with
+``mount -t binfmt_misc none /proc/sys/fs/binfmt_misc`` command, or you can add
+a line ``none  /proc/sys/fs/binfmt_misc binfmt_misc defaults 0 0`` to your
+``/etc/fstab`` so it auto mounts on boot.
+
+You may want to add the binary formats in one of your ``/etc/rc`` scripts during
+boot-up. Read the manual of your init program to figure out how to do this
+right.
+
+Think about the order of adding entries! Later added entries are matched first!
+
+
+A few examples (assumed you are in ``/proc/sys/fs/binfmt_misc``):
+
+- enable support for em86 (like binfmt_em86, for Alpha AXP only)::
+
+    echo ':i386:M::\x7fELF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03:\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfb\xff\xff:/bin/em86:' > register
+    echo ':i486:M::\x7fELF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x06:\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfb\xff\xff:/bin/em86:' > register
+
+- enable support for packed DOS applications (pre-configured dosemu hdimages)::
+
+    echo ':DEXE:M::\x0eDEX::/usr/bin/dosexec:' > register
+
+- enable support for Windows executables using wine::
+
+    echo ':DOSWin:M::MZ::/usr/local/bin/wine:' > register
+
+For java support see Documentation/admin-guide/java.rst
+
+
+You can enable/disable binfmt_misc or one binary type by echoing 0 (to disable)
+or 1 (to enable) to ``/proc/sys/fs/binfmt_misc/status`` or
+``/proc/.../the_name``.
+Catting the file tells you the current status of ``binfmt_misc/the_entry``.
+
+You can remove one entry or all entries by echoing -1 to ``/proc/.../the_name``
+or ``/proc/sys/fs/binfmt_misc/status``. A single entry can also be removed
+by simply unlinking (``rm``) ``/proc/.../the_name``.
+
+
 bpf-backed handlers
 -------------------
 
@@ -157,45 +197,6 @@ registered in, falling back to ancestor namespaces, mirroring how
 binfmt_misc instances themselves are looked up. The entry keeps the handler
 alive; deleting the struct_ops map only prevents new activations.
 
-To use binfmt_misc you have to mount it first. You can mount it with
-``mount -t binfmt_misc none /proc/sys/fs/binfmt_misc`` command, or you can add
-a line ``none  /proc/sys/fs/binfmt_misc binfmt_misc defaults 0 0`` to your
-``/etc/fstab`` so it auto mounts on boot.
-
-You may want to add the binary formats in one of your ``/etc/rc`` scripts during
-boot-up. Read the manual of your init program to figure out how to do this
-right.
-
-Think about the order of adding entries! Later added entries are matched first!
-
-
-A few examples (assumed you are in ``/proc/sys/fs/binfmt_misc``):
-
-- enable support for em86 (like binfmt_em86, for Alpha AXP only)::
-
-    echo ':i386:M::\x7fELF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03:\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfb\xff\xff:/bin/em86:' > register
-    echo ':i486:M::\x7fELF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x06:\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfb\xff\xff:/bin/em86:' > register
-
-- enable support for packed DOS applications (pre-configured dosemu hdimages)::
-
-    echo ':DEXE:M::\x0eDEX::/usr/bin/dosexec:' > register
-
-- enable support for Windows executables using wine::
-
-    echo ':DOSWin:M::MZ::/usr/local/bin/wine:' > register
-
-For java support see Documentation/admin-guide/java.rst
-
-
-You can enable/disable binfmt_misc or one binary type by echoing 0 (to disable)
-or 1 (to enable) to ``/proc/sys/fs/binfmt_misc/status`` or
-``/proc/.../the_name``.
-Catting the file tells you the current status of ``binfmt_misc/the_entry``.
-
-You can remove one entry or all entries by echoing -1 to ``/proc/.../the_name``
-or ``/proc/sys/fs/binfmt_misc/status``. A single entry can also be removed
-by simply unlinking (``rm``) ``/proc/.../the_name``.
-
 
 Hints
 -----

-- 
2.53.0

