Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA539B956;
	Tue, 21 Jul 2026 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643312; cv=none; b=CYfEtZ2h6NmThyLGtGu2ua56Ud9puoXJR7tzAgdmUMDD2PPbf0+uMASGq+KCp2mGvSNsoY0T2k4fPncXi63qeSRHGnVAuZnCqxgJnLAirzFMpjZw2vo56t+V+G95jMAlss7j2KvfZSrOcVa/z+gNQcRShC62nzN18QQJqQ6Gllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643312; c=relaxed/simple;
	bh=XclEE/Ai2/yaq+1kn6/7w1hPUg3O6QDYJzvXiuRCLbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=looSI6EM7GWxnmzV9DYCGJj+FzDzV1yyLWHaYx3CWLuXo0W12uC7zsSMORliR4w5+3rcnK1vIgDjzRPHArzE5Kjn8h0LRxxD/10OudYgzcxspnsHumfHQEEH/nR1UmmsfEKWDIFfj93jb1YGuXcGYMu1C+vDL/cPusnXSTgggUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2zXb/dZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2zXb/dZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E331F00A3D;
	Tue, 21 Jul 2026 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643310;
	bh=bLaf5tyDxWCxvlHTtD5Z4k1xuBW7w64hgCUEqdp/QWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S2zXb/dZrasMLZ/uaMCz9boorv4beZgIxRhuENjwATRQZ5mqaqFSIXVSo+kkHYylU
	 tITkd3LgsxjZQVwAtIDa3JvBdNFf11ZQ79AKpfCh0RbLZPNAQTZeVJX3L0dJNzf1Lc
	 nT0ygtbqd0grOh0+mgwmmv1srlpQpl35NAOw9898Ih1upg9j9QClYBL4tZawNdQUcS
	 5DsWrVhen21diStt0c9ZGQYw//KpfFrau4zLZcBTDjZm7WE4lEIA8W+q4iQ735uJls
	 x6Tj03wFS9TDvYvulQbG/ymFVj4gIt401+prpY8UUF/IMYXX/vBhMHPJaRDgZ4EKgF
	 sTkqXyD5WoAQA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:56 +0200
Subject: [PATCH v2 14/21] binfmt_misc: document the transparent identity
 contract
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-14-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2622; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XclEE/Ai2/yaq+1kn6/7w1hPUg3O6QDYJzvXiuRCLbI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1x1oqX23496J52lX1D4bXdGbwuNXwdYls+9sbknIx
 PXLpgbHdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk8xgjw+YK15lBK6enJLUn
 R1tb55XZqPCdbb1iaj9FWPJvlprjTYb/SYcPRPSEVjZd1n/nfoD/b1my6DUlzavrTpfcm7nqT7E
 0LwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Describe what a transparent dispatch constructs and the loader contract
behind AT_FLAGS_TRANSPARENT_INTERP. Also note what deliberately stays
different (the address space layout) and what stays unchanged
(credential derivation without 'C').

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 81b78e315fad..ea1c1c0676c8 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -223,6 +223,36 @@ binfmt_misc instances themselves are looked up. The entry keeps the handler
 alive; deleting the struct_ops map only prevents new activations.
 
 
+Transparent interpreters
+------------------------
+
+With the ``T`` flag or ``BPF_BINPRM_TRANSPARENT`` the dispatch is invisible
+to the resulting process. The argument vector is left exactly as the caller
+built it. The binary is passed through ``AT_EXECFD``. The kernel also labels
+``/proc/pid/exe`` correctly. The binary's file is write-denied while the
+process runs and the interpreter's is not, exactly as if the binary had been
+executed directly. A transparent entry does not change how credentials are
+derived. As
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
+what attaching debuggers observe. The prctl is privileged - it takes
+``CONFIG_CHECKPOINT_RESTORE`` plus ``CAP_CHECKPOINT_RESTORE`` or
+``CAP_SYS_ADMIN`` in the caller's user namespace - so a loader running
+without these leaves the aux vector and the markers as the kernel set
+them. What remains visibly different from a direct
+execution is the address space layout. The interpreter occupies the main-image
+position and the program lives in the mmap region.
+
+
 Hints
 -----
 

-- 
2.53.0

