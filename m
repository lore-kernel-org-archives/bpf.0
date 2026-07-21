Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D739769D;
	Tue, 21 Jul 2026 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643318; cv=none; b=ALCNJ65YLzoaZe7n/j5ay9TGfl9gCkLP+Ny7X2S6o6fWZCpUBVAvIcb4Pgn1mQ1JoVDW3HAWgQgz5M4euqifXVx8Slpqa3YqTs7LxhZkKW31MqYsTm6/8r7DOnZTWS52gr3zuZi9+jNnYhLj0FScJ2p0YgEWx8+FpBWNWsidFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643318; c=relaxed/simple;
	bh=64u5m6QOKfkJeGSkjeAlH+MI9emFWrAvETsceMdnnkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HuGEZU8IUB8cp11aajrSAw/PvkPU/wZChwV2x5OZHijvOzwp1DKlMeU9g3dicZ8BWYJEgl3Nq+RkLIw4PfozgNtSeE319rBOTAmRwlWR1ImClZUqkW+QFDvdTd5ZbGvjNhEgOCu8EpPfHzPo6vdW8IUYyWwCN+zRL7TRBT8racI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOJyNJXL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOJyNJXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583231F000E9;
	Tue, 21 Jul 2026 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643317;
	bh=/7Tm4RCgUtWKY56+njHwkepgkA9xUFGEGOQPYsg9B+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MOJyNJXLyGpqijpk5v4ODaoFMiEL2VlKtJbS2YgccRyIo+QPYy4pGlpnVv22/WIoe
	 Us/lCcqvKRy3k6HhsMMJUWjZwFgVgZ3B0tPD9Y8nT0siA37E9/Mn7NxXtkB2/1yxRt
	 L9iy90GXi6/AqXmPj7LtrD/7lmJqXuxNkZaQWDhqlRo3vIethdvHgGmAdi+03/XloP
	 sh+iVi4VaMO+2hfxh8avpTfySYqp9ZNSV1W0iMRtiawheSl3ybMoVrsEjEc0hng3Yl
	 aITQLLh/6lYx8GuZsWVZkxfvFTAW5YThwBJ28Y4nsklf4GoAX80Bb938foq/ioDV4q
	 vU9VdMfY+f3Ng==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:58 +0200
Subject: [PATCH v2 16/21] binfmt_elf: consume a stashed PT_INTERP
 substitute
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-16-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=brauner@kernel.org;
 h=from:subject:message-id; bh=64u5m6QOKfkJeGSkjeAlH+MI9emFWrAvETsceMdnnkY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1x245hK6iIlZa/2CR9yPv6ad4PpiVcAxLWDyyuvvn
 Gz3Pv2s3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARjcmMDMtnNG88blWx4VFA
 6+yNFdFKj3tDeJpjv0XdbzeP3tv1/QHDfx/d9x9mXWcPvaS2bRLDXP/nrVJxu21vymXoHs8p3PS
 SiQcA
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
 fs/binfmt_elf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index be8fd437b5a3..00ff35cad441 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -901,7 +901,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
 			goto out_free_interp;
 
-		interpreter = open_exec(elf_interpreter);
+		interpreter = bprm_open_interpreter(bprm, elf_interpreter);
 		kfree(elf_interpreter);
 		retval = PTR_ERR(interpreter);
 		if (IS_ERR(interpreter))
@@ -932,6 +932,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out_free_ph;
 	}
 
+	/* No PT_INTERP to substitute for: the override does not apply. */
+	bprm_drop_loader(bprm);
+
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
 		switch (elf_ppnt->p_type) {

-- 
2.53.0

