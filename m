Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF373AC0DE;
	Tue,  7 Jul 2026 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453031; cv=none; b=bavwAkuHdc8XHEkgpJJeWuRQnE4oJrE/bWEMFh0a1oPeIk92bQztLLtorp4LAM9EXTM/yXfKID+S6Yxeovj0hVGV3ScqrI0K9QBbPildpOJg+AWYypsnZN1q4YOZCFBOluJNXszZbM20Y7dK3Jzw0PFlq5u0tPV5/w6+oOJObFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453031; c=relaxed/simple;
	bh=ua7v+d3uKRKy32nv1LaWcJpAPv7PpPmfHINLqR8HXQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/XvzGnUf88MkGCUeS5j+cy4kSHlqoBksawvN8irx+7+0mkylYcMrudDe222a4dWfcLS9Eqzvlo1Hx1XOPwtOrUQpCgb00KD9LN1/zrMqc2YvcH9pmhIzPHKO7zDfjo3sE0+D9o9+qeJHRBYfUOWDnNXPfMRomIPn9fsjm1DapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/R1GcGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/R1GcGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA281F00A3A;
	Tue,  7 Jul 2026 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783453030;
	bh=BgA1geaqq5El280u44lqj9rGD3DnVSHSrxwzp95cFOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=J/R1GcGeuq4+Jk08FVaiJaApToeqiDQEV6pLbvoDFOseUk6N8hg5rfagsSB2xavRb
	 TVUlUjm0QFpyNzb3JcaORHuja5/n5PIwFLOvm042VBH49wuXusAgVypXZ7MQrXrT4D
	 sm3QbLC6ygKlzpF5CNCOFxpJifTSCsrHeCPx7T8hpQsSLOEPzYX1h1mHkTpTGvFZ9d
	 G6A5jl/JzAtxNxGv5eBe1sgZG+b5OeTdYwfdzYu23OD2fqtz2ChB3VFrBd+TGpjUhu
	 /yG2u6YTsOIh7/Cad8fnYUbXiuB0oOhO+OS15uSAm4l455LE7eq83CcZ2+VLHPalEp
	 vOcan58Mh+CHg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 07 Jul 2026 21:36:45 +0200
Subject: [PATCH RFC POC 1/4] exec: stash a bpf-selected interpreter in
 struct linux_binprm
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-work-bpf-binfmt_misc-v1-1-74b995c84ec1@kernel.org>
References: <20260707-work-bpf-binfmt_misc-v1-0-74b995c84ec1@kernel.org>
In-Reply-To: <20260707-work-bpf-binfmt_misc-v1-0-74b995c84ec1@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 jannh@google.com, linux-mm@kvack.org, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ua7v+d3uKRKy32nv1LaWcJpAPv7PpPmfHINLqR8HXQk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5hibssbE2kvx9I+R4s8QiS7bb78Q8e87e+jMtcCLP0
 xVseg79HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZuYeRYa5OkkfiTNde62PX
 vLdOuRhjdnrmvFAfjsYZk6szXIyiUhgZzs7QYt2os2nZ5dyooqriD46/713laRDaXLqQN2Biz8Q
 qHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The upcoming bpf-backed binfmt_misc handlers select the interpreter for
a binary programmatically at exec time. The selection runs before
load_misc_binary() has copied the binary path from bprm->interp into
the argument vector, so the selecting program cannot go through
bprm_change_interp() directly without clobbering argv[1].

Stage the selected path in the bprm instead. The bprm is exclusively
owned by the task doing the exec so no synchronization is needed. The
consumer frees and clears the field once the exec attempt that set it
is finished; free_bprm() covers all error paths.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c               | 1 +
 include/linux/binfmts.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index b92fe7db176c..7c9e28f549a4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1418,6 +1418,7 @@ static void free_bprm(struct linux_binprm *bprm)
 	/* If a binfmt changed the interp, free it. */
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
+	kfree(bprm->bpf_interp);
 	kfree(bprm->fdpath);
 	kfree(bprm);
 }
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 2c77e383e737..0070d207d54f 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -65,6 +65,7 @@ struct linux_binprm {
 				   of the time same as filename, but could be
 				   different for binfmt_{misc,script} */
 	const char *fdpath;	/* generated filename for execveat */
+	const char *bpf_interp;	/* interpreter selected by a bpf handler */
 	unsigned interp_flags;
 	int execfd;		/* File descriptor of the executable */
 	unsigned long exec;

-- 
2.53.0

