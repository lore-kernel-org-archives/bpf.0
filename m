Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F61396B84;
	Tue, 21 Jul 2026 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643321; cv=none; b=bX1zYlKsRi9kicWyeURnQitg2Avf7Vb6hfCvVDzmrNKJmDYF0rqWliLVQoY8pVHMSNxWLCfbwBYYEOFFhVAPyTGfqBOHJOR5HyBFkBVUt4cq3tSoS6aFVylCgJ89J85HpxJIaubYWmcKQ8JXe/iLEGUfOobkkvnNWUblryKWn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643321; c=relaxed/simple;
	bh=F6D0PvuTQvQf8mA65sb9YaWA3Wr+Jlju8fB0fC0h/A0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n66fFbEJ82tzbuCqnIBAOHbIzmTLAPBBq9W2IADN8teraR2KhJnfXJ1dLJ746fJOy7jNvJOQ/cr09YCv6NQHa8XAg5AhgW+x1KhZp2gY+bEC1mTIb5/7Ldz377i8LArggCwV3lAy1PES0nlMAUb6d0xxtFEbiF/Jd8gnJ1aZSEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDi+9dqu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDi+9dqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4711F00A3A;
	Tue, 21 Jul 2026 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643320;
	bh=JxB9rXhek0NkBHgvSB/buO2qLSUwhPGzB/G5yFfhHG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TDi+9dqugaFjWW+9mGHTkPO3it+doi5MAoIF7jZY87v1HRyotf13AKPk2SfNgAx0B
	 WuwSF+B7fgaVxo9Y8ai1WVqh8LwNEJYimn9QX+cJfMdUT8QpsgHkzPoc7YtwtO2g+M
	 zMfdaO4l0QW96uu10/ZOTbQK+wn3R+QygQRoNVoy7XrRFD4O3bo/7GtjPFdh7nNy/n
	 P3JFfIAdtuFE0Ysw7gWeJ3F51trRAwiDzfKYnwD4C2kXpxx2+nJELZbgJgAw0DW8y6
	 HKAX0d50tYArLKq1zuMWnnicAeN+MKnmjyUPtA/Blhp24s9erB5Q+yMfhhTsROstnd
	 Oc7WpQACaCJeA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:59 +0200
Subject: [PATCH v2 17/21] binfmt_elf_fdpic: consume a stashed PT_INTERP
 substitute
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-17-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2232; i=brauner@kernel.org;
 h=from:subject:message-id; bh=F6D0PvuTQvQf8mA65sb9YaWA3Wr+Jlju8fB0fC0h/A0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1x0Im77iRNvLuf17Nnf/P6aqf7zw51mBoIVnxFvmF
 37wD7kt1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR6ukM/70FTgatPBgWtm56
 5zHb3hLDl02Sa22VGMNN3AqPKTgw+zAyNETszFnt+Or40zPhPnuq1Q447frG7+xb06nj/ifo66P
 nbAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Do what binfmt_elf does. When a binfmt_misc loader entry stashed
bprm->loader use it in place of the path named in PT_INTERP, and drop the
override when the binary names no interpreter at all.

Without this 'L' is unusable on nommu, where fdpic is the only ELF
loader. On ARM with an MMU both loaders are registered but split the ELF
space between them along elf_check_fdpic(), so an fdpic binary is never
picked up by binfmt_elf either.

Declining is what fdpic did so far, but it declined late. The pending
override was only caught in begin_new_exec(), by which point the segment
scan had opened the interpreter the binary itself names and overwritten
bprm->buf with its header, leaving the next format in the round to
inspect a buffer that no longer describes the file it is offered. The
scan consumes the override now, so of the in-tree formats only
binfmt_flat still relies on the refusal, and it reads bprm->buf without
writing it.

Transparent dispatch needs nothing on top of the AT_FLAGS translation
both loaders already share. The binary travels in AT_EXECFD, which
create_elf_fdpic_tables() emits, and the exe and comm labelling is done
in exec.c for every format.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_elf_fdpic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 0a3cdf280307..068c46875c74 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -263,7 +263,8 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			kdebug("Using ELF interpreter %s", interpreter_name);
 
 			/* replace the program with the interpreter */
-			interpreter = open_exec(interpreter_name);
+			interpreter = bprm_open_interpreter(bprm,
+							    interpreter_name);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter)) {
 				interpreter = NULL;
@@ -299,6 +300,9 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 
 	}
 
+	/* No PT_INTERP to substitute for: the override does not apply. */
+	bprm_drop_loader(bprm);
+
 	if (is_constdisp(&exec_params.hdr))
 		exec_params.flags |= ELF_FDPIC_FLAG_CONSTDISP;
 

-- 
2.53.0

