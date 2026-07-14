Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3143A7E4;
	Tue, 14 Jul 2026 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059104; cv=none; b=q9QPx+e2Xeii7pCUBpk8uJ6JLgE9YsdMescY0xqFOyi3ZmeRFB2X04n13wY6/dt1cGsUX/huhsikOgHHb2I8LaGvYsiP8pp/Bnn7gafFno0ZrPzlvxzPJjMh9d5TR0dtnm/jqWuz4DPyCHcDppF6nq87/YvWEonvNuJlkQuG+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059104; c=relaxed/simple;
	bh=6Azi4to0L64siZLaQPCVUQz4l3wCCHwGb9UfT2JXkmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsv1bVqxaZIfib8UqC+34VxiFnyvEymDX05T9JkhYNKdhGrOeo6nSJ2hOALjdDDLMkn2dKsIX9NrTSaY5ZFA8bKoGpPg9e4eW/dG7AXmXedxRVtr2WNoplhMov9bmMVolaHVtO/1iq3Ohq0lhhAb3QSW5qqWTRQhxBXoZ9hhok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuMfvKUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuMfvKUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF5D1F00A3A;
	Tue, 14 Jul 2026 19:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059100;
	bh=jdIn5AHlooZhD1sz2RSUUVQOfpEr8yJUCf5hCDznaDg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NuMfvKUpRuif84rJCICwZO+gLN3KedxW9zB0faIVPg6JjWBtyedJrUOBYm7GuopoW
	 XtzCd3CX2OmJKg3zL364QJkAjgon1Ah2Zky5sSKcAivPfqISQusif+v0DizphdJ81B
	 r2N7zAW+whc4EdC9fXb8w5Gj0I2OQdfLiQ9+zVdOh0voCKVIATzgjDqUyOqI4zcQq7
	 uoetOuoVZTA8oPAAlR0UEBRUJ0w/WFrf2BJi9InsAkYV3zkW2HYpW8zeSqxbeXWcfm
	 Kr00siciyJZpB42DzVI+MVUDHdga7MXkRqxr+zljHKbupKnWshc3vIEN1eY4z9MIFm
	 VP4jXGtHCzeGA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 14 Jul 2026 21:58:06 +0200
Subject: [PATCH v2 1/9] exec: stash bpf-selected interpreter state in
 struct linux_binprm
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-work-bpf-binfmt_misc-v2-1-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, bpf@vger.kernel.org, jannh@google.com, 
 mail@johnericson.me, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6Azi4to0L64siZLaQPCVUQz4l3wCCHwGb9UfT2JXkmo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSFTbm8g0viyrzNx0Jn/92z6aK1TSvbdaPCLe2cxoouL
 9q2lPuXdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyErYGRYZ5km4jOHe5bvo5b
 50Z13sz9f1F8k+bx31L24Yb+jsEyfxj+Rxaqmic2V9U6B/88ZfZS+P9O/R3POzlv2Th7xt6dlLu
 dAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The upcoming bpf-backed binfmt_misc handlers decide how a binary is run
programmatically at exec time: the interpreter itself, an optional
single argument to pass to it, and the invocation flags that a static
binfmt_misc entry fixes at registration time. The selection runs before
load_misc_binary() has copied the binary path from bprm->interp into
the argument vector, so the selecting program cannot go through
bprm_change_interp() directly without clobbering argv[1].

Stage the selected state in the bprm instead, grouped in struct
binfmt_misc_bpf and embedded anonymously in struct linux_binprm so the
bprm->bpf_* accesses stay direct. The bprm is exclusively owned by the
task doing the exec so no synchronization is needed. The consumers
free and clear the fields once the exec attempt that set them is
finished; free_bprm() covers all error paths.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c               | 2 ++
 include/linux/binfmts.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index b92fe7db176c..c698aabe9abd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1418,6 +1418,8 @@ static void free_bprm(struct linux_binprm *bprm)
 	/* If a binfmt changed the interp, free it. */
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
+	kfree(bprm->bpf_interp);
+	kfree(bprm->bpf_interp_arg);
 	kfree(bprm->fdpath);
 	kfree(bprm);
 }
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 7e7333b7bb0f..03e1794b5cbb 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -12,6 +12,13 @@ struct coredump_params;
 
 #define CORENAME_MAX_SIZE 128
 
+/* Interpreter selection staged by a bpf binfmt_misc handler. */
+struct binfmt_misc_bpf {
+	const char *bpf_interp;		/* interpreter selected by a bpf handler */
+	const char *bpf_interp_arg;	/* interpreter argument from a bpf handler */
+	u64 bpf_flags;			/* enum bpf_binprm_flags from a bpf handler */
+};
+
 /*
  * This structure is used to hold the arguments that are used when loading binaries.
  */
@@ -65,6 +72,7 @@ struct linux_binprm {
 				   of the time same as filename, but could be
 				   different for binfmt_{misc,script} */
 	const char *fdpath;	/* generated filename for execveat */
+	struct binfmt_misc_bpf;	/* bpf handler interpreter selection */
 	unsigned interp_flags;
 	int execfd;		/* File descriptor of the executable */
 	unsigned long exec;

-- 
2.53.0

