Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEFD3D093E;
	Mon, 20 Jul 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540062; cv=none; b=WZ9a7BXUhJRsMfL2htfNV2Lz2/hTYAB86C1ROA0cWekQ/9R5IeLcM3Hn9d5lG2IaiO/pP2mTkFJRTXtzFooLhSKX8vZhPVVbK5OvF7YJzIWXgOjMegkgH1EYOXjSPlH+2oxlpsX/jukhedc6DOC6JMOOuXaKoZC+klLypO/vT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540062; c=relaxed/simple;
	bh=2ognuNn86edeBu6t/u9qeT9TK9VxXPcwlqVi+uJovvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F7368JRxa4CzNXtGZG92zyXHrbQdNuRwKtwrfsq1rUC7vvy7ANz6hfFmLFkT/nV+uUgJBNq1j27P0CLGW6LTQJSOc1az/6z/al/lx53xLpnfevjdidEIKtjEQmjddCMV64Thm0dZECbsSEAdSLwdpeU173t7pXIAUD4zfJXfBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuV1+Oma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuV1+Oma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84281F00A3F;
	Mon, 20 Jul 2026 09:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540061;
	bh=AoAN0y6FBHdhYz5mnXN2m/MenuFvaBCTttN3p/SNEU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nuV1+OmaDbtEE/kpSxVOmzaONIL4JzbAvSzY05OdMIMfnHz+AMqh6mjFlPOsJJXs0
	 6bozl+rb0H/Httt4MayhClDm65xHlUsRM3kUXid3E8vzWbUh6dK3Y8iMClD8cKw84f
	 fRhPSA4Q/vAyw5oyV51YUiouhkpi+RjQH2/6wterf8hvPt9mcPp9GOlYQFD5xrq//i
	 IICsbMeJnPGZXafX6jdU+Ppab/SQ5Wqlv1rdnKZRzmexXOTRNg5d9gvxBkHzPwW7sM
	 mCJV28eaVM1+AjqqrcTyJKu53GAM8ne6KlZZkgX0bPXmhoRrN0y4RzEltWI/1cGd+u
	 9RSHe3ic/VQlg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:30 +0200
Subject: [PATCH 07/21] exec: release the replaced file with
 do_close_execat()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-7-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2ognuNn86edeBu6t/u9qeT9TK9VxXPcwlqVi+uJovvk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm6yk95+L0+Z49/6X8GM+3szX3Hy3uFhM7p/oGdf9
 O97onVGHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpn8rwTyP1k5HXEXvH1brH
 5yk8ZL/WFT7tLtMm3vWNSk15q37JujAyrG9Y/uYS02ut5lau62Lf2187Xs/Y/rrVJ9nZpjy46GY
 mDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When the format search stages an interpreter exec_binprm() swaps it
in and releases the file it replaces. Dropping the write denial the
open took is done manually ahead of both release paths. The one path
that keeps the file silently relies on it not being called.

Let's just use do_close_execat() on the two paths that release the file
and drop the denial explicitly on the one that does not.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 2f50aa039827..6e540f4b43d8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1741,15 +1741,17 @@ static int exec_binprm(struct linux_binprm *bprm)
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
 
-		exe_file_allow_write_access(exec);
 		if (unlikely(bprm->have_execfd)) {
 			if (bprm->executable) {
-				fput(exec);
+				do_close_execat(exec);
 				return -ENOEXEC;
 			}
+			/* Only the reference is kept, for AT_EXECFD. */
+			exe_file_allow_write_access(exec);
 			bprm->executable = exec;
-		} else
-			fput(exec);
+		} else {
+			do_close_execat(exec);
+		}
 	}
 
 	audit_bprm(bprm);

-- 
2.53.0

