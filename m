Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA338A70B;
	Tue, 21 Jul 2026 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643287; cv=none; b=js4dg6OKXOZjliANJk+vOs+YxwP6aX+kD5S4rcKz5tTyEy0JwdrteHQj29pnQwqleyehRvxmqvvILJlhvX6EpBdNMUSfcqAfTQgtuRm6IcvyXD0VgtEN3n+TlIkt6IhUJXlHkzN5NLpWvm+W4pkh/fF4p8VBFuwYkdB4LEE7/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643287; c=relaxed/simple;
	bh=lHTPa0Kuv7ZBQP62Z8DPWg8DZoMxaet8DMO+ZA80gC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etZQfgSDGGo2wTmLMBrr2cx1+XHBoSaRqKefWGarTMpQ622nhicVhHmQfi3TgN0zGYWw7AssRRSiR3PbPpJx+rJRi2cqrdTs8Kw+a+jy3QJQeBAhXSiaYMuH+WAUI1uKY193E3m5zBGmUkY0/KYWOa12FyvzKB45cp7Uz1NAl+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuvplyGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuvplyGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECA31F000E9;
	Tue, 21 Jul 2026 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643286;
	bh=wxkLWep5VFtYgEm6sKvmi+7h5j3tv8fHaNY2zfaitRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CuvplyGDyiHknI6ZZQm/KoAxwwhS1a9bTYsgo72rx1bC6sBqyiHeSVFaF9xrMqZcm
	 8yXTwJwtzy1Zrum/wIhcxLCl1dqkye8g4nnF/JGIFMuQPE6cfwnBqRWMDIVbyt9EW6
	 P8dOx0VkIEIapmsHtOwvmbT+tG23t0/yl0xP1U3YKBcQtLXLKR/CzRs89ej8fbq1Oa
	 SVlcOrX8dk48vC4MYSR7JLk7EPdQQ+lw0OVWO1I8FZpxrY5DvSWQhUwiSFSNiBjJkx
	 RaDb+B5usm247fasankfgqS4/ehXng7ru8uPSVeva5qgiMbmldLw8Ft3f47Rm3ESw2
	 yUx0ZshQGXwdg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:48 +0200
Subject: [PATCH v2 06/21] exec: release the replaced file with
 do_close_execat()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-6-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lHTPa0Kuv7ZBQP62Z8DPWg8DZoMxaet8DMO+ZA80gC8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1+2fteMG09TlmvtEFxoyWx/1m3BJ/gNrvNXcoieiX
 rXX+JJlOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyMpbhv/djHxPD1YfvK6ct
 nnJ5ljrjsQlndAsSm2/uuLX5yHM1hqkM/ysVP870cDyYVXDjqINIePWvYx2ml4sE51tJrU6pa/m
 6nREA
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
index 41e1684d999c..061e0f9fb4ef 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1735,15 +1735,17 @@ static int exec_binprm(struct linux_binprm *bprm)
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

