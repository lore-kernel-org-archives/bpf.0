Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C9238C41B;
	Tue, 21 Jul 2026 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643275; cv=none; b=WXRywGQdrQ1qSaWsuYgCG/E8QXEqjxEU+7sXGx9KWWEWQP6bm4pBL8WTQflRIOlTeGG8CY8BtEtr6kHwH+nmo+NCdkTprhVR27yTiV40HPDF0wXJ3BsG2JILkDeMnkerqOW1990B1uv8CSFc8t7HHrfmosJ2LsuC34gOMkI3gVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643275; c=relaxed/simple;
	bh=pnQ2H4ThUkWl2NY2YaCVOKuFwWPtz/Wy/4Hat7E6A2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Su0NaDDK1PMafbHZ9+8e7D03ILgPjglcq47A7fIHzaD441mjRu6LDQcBk9j+RFnyqqNuLxbf1HySfxYgDncpCsyBnSXnAyVwSkoocuOlo4sstas76zPjtrcaVhq2s+6RC+XZvXCXQO5A4xUUjJscPBQfGQnI3Wu1LcgfFHApw4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3rXtkLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3rXtkLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B621F00A3D;
	Tue, 21 Jul 2026 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643273;
	bh=IySjUe+fekqEUyus3KN/ReQzmr0jzl1UX4v+5RczmKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k3rXtkLVUYH+tX0EsEcvwjEF14GVctfc1m6YTs77MSVGa0JF/YACJkHEXM83v8MGj
	 o1M3j8M01rePmmJmj0UjyN0Aq57Lp9BLSjV4DAL2WkaENCsPiPoSiBYjdPJPINXAWc
	 AuaPPcZdgj0m0p2qenKaYdrS5NkvxX4SVZFrJZU7XLnmUVrUZ6o648UYUUZJLbuUWf
	 d4s2I6QJAwN3pmwpbHr/eY23QtRg3Lh7Wr76uJ6YA2QG9aNCKvTpLIvh3DHaj3nYsi
	 oDjZrzf4S57TvlV7ascEoskjwcGqhNKYKWRHEHZY85xBIbrUN2JRmmqqE+1vK3rIUP
	 9QLuMGfuNEG3w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:44 +0200
Subject: [PATCH v2 02/21] docs, binfmt_misc: keep general usage out of the
 handler sections
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-2-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4962; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pnQ2H4ThUkWl2NY2YaCVOKuFwWPtz/Wy/4Hat7E6A2U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1+3/6Kh4dh/H9i1bA+N/C8jF2C77IG2Y8C7ZsSZ0r
 7a3KcP+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImk7WX4X3tx+zE2piV6AQc3
 Wx256dV0lCVg1QQdfpflPMsK8lbfus/wV1yzraKoeI/OVdNlHJ7Hzh7SZzXV9ZfeqvlaYtHy3RY
 3mAE=
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
index ce94c8c36534..d689f21858b2 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -104,6 +104,46 @@ There are some restrictions:
    the binary
 
 
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
 
@@ -161,45 +201,6 @@ registered in, falling back to ancestor namespaces, mirroring how
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

