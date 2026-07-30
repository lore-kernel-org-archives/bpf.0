Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F2F431492;
	Thu, 30 Jul 2026 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418495; cv=none; b=W47z5DUvUmi/YemJu0jf3Ji17MKqKYGv+XvTtsG47ykHpIzeY3eh56LeDyfPH3HMeS/Npl5wM8uIBsle6Ah4b+2DdnbSbeNT5FZRLbR/5y2pKyTqSTBA+Z7De+2rzIxOoWitUCi3fBFcYucpgWVxVpH9n+1sup9HFZiBBSvvhmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418495; c=relaxed/simple;
	bh=JwE3rtGBn2iCx+TRsmqXKFLG9WMlHl4uFYo2z04LHvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLHfUIYgmbJKG2CRVdh0z5y65Lr2sbKxH8QRLE+xREAphBMKiOdFLpXPQ0EwlWqMypibc9QFRCLCWLx4SOTDVavvw3PVvGH6bfOgk6KctLo9wYo5U4Lb23BWZ3ejd1Y5Ima/tAzUwfoEbwgUdMTB9S00hkeEjCZUQGqAp31NYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpD6ZCDp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpD6ZCDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D8B1F00A3D;
	Thu, 30 Jul 2026 13:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785418494;
	bh=d90a+IuGYr7k1vJHi62UpvEXaFbPpLFLGqIFk5fm34Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kpD6ZCDpRUDEVRZEQxHAn3/f0p4jsUl69dWThamJMiEKtEuJ0bOMyCV/OZ0YQxxJZ
	 h7vWZntQEMoU4ZLtpnChFr/eWY+En/DZN+jhg7GtQ7ZTbz1E5G98bkOTEXsecNjoni
	 BUuUohpkFIWRGLhtnDpJMr5BO4xtVVPpWzGBflICX454aBYxDONH9OYnu0BEteqtP9
	 6rxnk4PfzGyMxw6PPaKUponVYPBJcTPEKrF+oSdsXryuWlH0bzqK8OjLYZKK7nKk9d
	 SxxTLxx9zzYCVEitPPekrkX6xa4HsJF/yiFiImzv1Gqpz22j3eL1h4FhoxEHhH7tiz
	 b9WGYe7N4uTxw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Jul 2026 15:34:06 +0200
Subject: [PATCH 4/9] binfmt_misc: document registering an entry disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-work-binfmt_misc-preopen-v1-4-4a0b0da71f16@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2413; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JwE3rtGBn2iCx+TRsmqXKFLG9WMlHl4uFYo2z04LHvw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlB70TuXCE755s+mnNIncukYnyTPPmnFmzRu7qE9Z6v
 UaFAm/tjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkk72f4w2c/Y0/prm+SqosW
 3RO7sUW3mPHwD0VXPd84qaKkzLe9MQy/2Q9MO+V/W3NPkHvY7S89efccslMvS56ZwDPp+D/Nt16
 b2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Describe the 'D' flag and what it changes about a registration:

- that the entry has to be enabled before it dispatches anything
- and that the flag is not read back

Scope the bpf section's "carries no flags" rule to invocation flags now
that 'D' composes with 'B'.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index c80702b4ccd5..8254ddcb3389 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -107,6 +107,15 @@ Here is what the fields mean:
             ``PT_INTERP``. See the "Loader substitution" section
             below. ``L`` rejects ``T``, ``P``, ``O`` and ``C``;
             ``F`` composes.
+      ``D`` - registered disabled
+            The entry is created disabled instead of being matchable at
+            once, and has to be enabled by writing ``1`` to its file
+            before it dispatches anything. This splits a registration
+            into creating the entry and activating it, leaving room to
+            configure it in between - which is what a ``B`` entry that
+            binds interpreters needs; see the bpf section below. The flag
+            is spent on the registration and is not read back: what an
+            entry file reports afterwards is whether it is enabled.
 
 
 There are some restrictions:
@@ -224,8 +233,10 @@ handler can decide them differently for each binary it handles:
   ``PT_INTERP`` and runs the binary as a fully native exec (the ``L``
   flag). It excludes the other flags and a staged interpreter argument.
 
-Because these are program choices, a ``B`` entry carries no flags in the
-register string; ``F`` (pre-open a fixed interpreter) has no meaning for it.
+Because these are program choices, a ``B`` entry carries no invocation
+flags in the register string; ``F`` (pre-open a fixed interpreter) has no
+meaning for it. The registration directive ``D`` is the exception: it
+decides how the entry starts out, not how the interpreter is invoked.
 
 Handlers are looked up in the user namespace the struct_ops map was
 registered in, falling back to ancestor namespaces, mirroring how

-- 
2.53.0

