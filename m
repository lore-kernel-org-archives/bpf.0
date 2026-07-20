Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94F3D6CCA;
	Mon, 20 Jul 2026 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540095; cv=none; b=HwfcQ+OhzrKFBTE5DumkOciWowRH1eO8qJIRbNqqnMywWo+JsYQT/9edDufjNP7Ugh68IYbPdyVDnUQXj8Zj17tV6j/iCXh+PqKDTYQ/tcenumVDliEB1RFDfA08wUlXhRyQgEVBaI+Yg55m5lEwtRkS+dtAtXM7i0/8U68rfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540095; c=relaxed/simple;
	bh=xHwXWmqSGpJLIvfrJ5UTAUuagvvd4JFCHu+wcBQmPnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgNMJp3N7yl8+HZ/wseHDp5TmAmpRYR0oXgRpgSNIgP5qtsyjHpVbDxQM3RxUiO1bJkZODzMAvWeidOHRL1hVU6kEmuQi5Ss2wUPH/tLvRLVpmSLnCwbpyyKZu4QR3GzmkQN9z7VYaS7rAbJOzfz90e2wJrjYkr+qMJhE+c5epY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGj4vUdt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGj4vUdt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8E81F000E9;
	Mon, 20 Jul 2026 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540093;
	bh=0uxigeI5a8sxnmPaz7DRAYhYlKGQhDnDoL1eW8DC+Yc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nGj4vUdtq3iU0KiO//sBFGNDSF5zCmhfkBhXIr3Vod5LRmxgyqMFf6wiBjCj5HSQS
	 EmU8AWJnxTxhQU7bypvWkOUDWIRyJckvFuz2QkjOFP9p7Jz0rVwNy4Srv4EGa/K/U7
	 4sSB58MTm17tCPH8ZHcv243mFFtGhFhIk4jULZtlgOnHdJqFWe/SdyQ20A3Rv3Wt0I
	 aDUOCEt+O7C4mGxgUsJj3nEuqkHkiJRQxYJNYJk9tg3X7OpQxBVdXK74cheyFaWS9q
	 GYF9EiIrQj6JwQ37yMBxjL536IgVMJs3NIQUG6gKJUMqfMhQ06NQhHepH0yKmaKFgz
	 NGykFQeSW+dMQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:40 +0200
Subject: [PATCH 17/21] binfmt_elf: consume a stashed PT_INTERP substitute
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-17-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xHwXWmqSGpJLIvfrJ5UTAUuagvvd4JFCHu+wcBQmPnc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm4y6+ZL5nnMMSe5PuBAc9XqX5HrvjiIf2c/Hbtag
 utMf/ecjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImUXmFkuKH72riw9dJzhf5H
 wiVC07hNmeviG/V8Q2fMWpzotLSFiZHh1t/dvzwO5dWKWq65bC/F/XDL/pfP7uz7031C4IHh9vw
 wHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When a binfmt_misc loader entry stashed bprm->loader use it instead of
opening the path named in PT_INTERP. The substitution deliberately
changes as little as possible. Ownership transfers into the local
interpreter reference which the existing success and error paths already
release.

A binary without PT_INTERP has nothing to substitute for. Drop the
override at the end of the segment scan and load the binary natively.

Nothing sets bprm->loader yet.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_elf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index e44230242f3a..3455af6be2b5 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/binfmts.h>
+#include <linux/cleanup.h>
 #include <linux/string.h>
 #include <linux/file.h>
 #include <linux/slab.h>
@@ -907,7 +908,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
 			goto out_free_interp;
 
-		interpreter = open_exec(elf_interpreter);
+		/* A binfmt_misc loader entry substitutes for PT_INTERP. */
+		if (bprm->loader)
+			interpreter = no_free_ptr(bprm->loader);
+		else
+			interpreter = open_exec(elf_interpreter);
 		kfree(elf_interpreter);
 		retval = PTR_ERR(interpreter);
 		if (IS_ERR(interpreter))
@@ -938,6 +943,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out_free_ph;
 	}
 
+	/* No PT_INTERP to substitute for: the override does not apply. */
+	if (bprm->loader) {
+		struct file *loader = no_free_ptr(bprm->loader);
+
+		exe_file_allow_write_access(loader);
+		fput(loader);
+	}
+
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
 		switch (elf_ppnt->p_type) {

-- 
2.53.0

