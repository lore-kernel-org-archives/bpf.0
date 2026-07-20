Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA633D47D4;
	Mon, 20 Jul 2026 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540088; cv=none; b=U55yMXurPe2y/y8fzRDBzOmkTRAvIUL/SsDsHj1VGthIGnph6eO8vX8guGHtj00Ndoh3k0sq5UYH42YpksX6uoH2fnUOclkSz7VAAd3RdmU/zaSL2tz18z17MPCg5F20TQhBFohXoNmZFSK5SjR3UbO97CT8YR/UUtQJOgsDXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540088; c=relaxed/simple;
	bh=2cz/Uon2cc1y44sOqIk8MHfFBV5eE11DUXnjL3cZ21o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MNzfeVlOkjSRUnqpW82uVgfxMncPEHOSO+Ene3O/1Cj7N2dKL4s7hRYpHSwe6cdZINjvGFqRhZoVTN3t0f6KOZj3gXt5OucsSk8vr1QP5SSZFIPR5bBS0FkTH0tHQwjsUBacduH2F8ThJaPgLI39pWtst1GcKTXy4dGKQo7fM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnHZ///A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnHZ///A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7DC1F00A3A;
	Mon, 20 Jul 2026 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540087;
	bh=FAAiNP5sbEBPejy0XpW4wgSJa4O4wifezU7doCgFL3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HnHZ///AFPSNwS4w0n015817chaT6GIyVDdfBMt+eiGmKS7fzL0fwjE9p0zkgIWW7
	 KxQwji0T8qbw/Hka0wWqZnAVB4kQZldXtl7RxyJgHY06hTxejp2AToH9b5Na2RtlB+
	 1yFMMdrEDjBd81bJKLZl6xL6jrDTA3AWPsMnbqiYhebbtTVjqfHOJWTVoX4YDG6BTt
	 zA8Wr/Pt2WfS2F3dMVaxoxoi13zGVS+7GK7cNLUA+WfFSjimV1eUH+wyKjIIWwPy5c
	 WbCgK7GvkACgLASBdDYLrloFJTbL2TD+EizCuJOt+wkMQxQtGd8mgqC1w4f2n8cuK7
	 5q1ua8Dcx4o/A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:38 +0200
Subject: [PATCH 15/21] binfmt_misc: document the transparent identity
 contract
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-15-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2cz/Uon2cc1y44sOqIk8MHfFBV5eE11DUXnjL3cZ21o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm7qtK9MuPohZQm/d6czw3yHUAeXT6+ac/aJWtz/d
 kQz8LBtRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETCvjD8U74v7+K6S+FQhuKd
 XScZZt7UeZms2T7byENUfGNG1xHGjYwMvwxmma9iut0fJ6/FdzFjB3P3lVe3G9c5vagX9zgrUST
 JCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Describe what a transparent dispatch constructs and the loader contract
behind AT_FLAGS_TRANSPARENT_INTERP. Also note what deliberately stays
different (the address space layout) and what stays unchanged
(credential derivation without 'C').

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index b27ad31847ab..0946ca1923f2 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -218,6 +218,31 @@ binfmt_misc instances themselves are looked up. The entry keeps the handler
 alive; deleting the struct_ops map only prevents new activations.
 
 
+Transparent interpreters
+------------------------
+
+With the ``T`` flag or ``BPF_BINPRM_TRANSPARENT`` the dispatch is invisible
+to the resulting process. The argument vector is left exactly as the caller
+built it. The binary is passed through ``AT_EXECFD``. The kernel also labels
+``/proc/pid/exe`` correctly. The binary's file is write-denied while the
+process runs while the interpreter is not, exactly as if it had been executed
+directly. A transparent entry does not change how credentials are derived. As
+with any other entry, set*id bits of the binary are only honored with ``C`` (or
+``BPF_BINPRM_CREDENTIALS``).
+
+The interpreter has to be built for this contract. The kernel announces it
+with ``AT_FLAGS_TRANSPARENT_INTERP`` in the ``AT_FLAGS`` aux vector entry
+next to ``AT_EXECFD``. The argument vector belongs entirely to the program,
+nothing was spliced in, so the interpreter doesn't consume arguments and
+simply loads the program from the descriptor. The bit is also the loader's
+license to finish the identity. After mapping the program it may retarget the
+``AT_PHDR``/``AT_ENTRY``/``AT_BASE`` entries of ``/proc/pid/auxv`` and the
+code/data statistics markers via one ``PR_SET_MM_MAP`` which completes
+what attaching debuggers observe. What remains visibly different from a direct
+execution is the address space layout. The interpreter occupies the main-image
+position and the program lives in the mmap region.
+
+
 Hints
 -----
 

-- 
2.53.0

