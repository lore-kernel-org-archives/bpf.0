Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707303FC5B4;
	Thu, 21 May 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367491; cv=none; b=hhtvuZSzRyaplYGOYMOzZK1TyR85SXfE+b7sUR6AaqFUVQ71ZbLa+qfSl2Utp8XkmNdcNtmM4bR9WJxAjIx1qjRWV8urxrEKxEcac7Q98IUo61aitBEiS48KHKFQjsiBzqAjJeNsOjqMnbRes0bezmGDwBFDRQa/Xen5IpwJD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367491; c=relaxed/simple;
	bh=g8cDMqz4KQ2T1yso78qIeV3gV7XxI8tRuwZ4Hr9y/tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYj9l5dzV+ZIZaugXgRydZdUZ9zruzJBbbuHl4aqdwX34aB2MSNbU9LLAgnv7uQCZ1K/s383D9QCxIy9HyDW8yztZt+AWE8uDbphJwMTgq03WQj3p4QjJjr1WT9VMEd/IYT+aRd0q2XRJFmhA9mISJ60hGFz7aUfX/ONmBF9X3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz8vwF+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz8vwF+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D821F000E9;
	Thu, 21 May 2026 12:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367485;
	bh=atLJ6pkgHr+hjw3dqLsMQKa3LWMJJXyW/9YwnXV5Zhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gz8vwF+labxhuxj/FisXZaYIZQ8ixzAAftpNUXAAoTJw/uoyHnTxfnYm6Z1hCrkVe
	 VgKEWqfjgPIXkIohAxqWNvwgU74S0PvCF56B5r57MBq68M27ZBXfZhFo+XqBZrikZK
	 44q+YPdIQ501G2csHYvtRrvX/DhrC9FAvjftmoIfw4COofDxbZGawB4lKJKIo5lITd
	 F92dz1JEzZ+h2ZD3cywxHCiX6z519e7Xdp9nRIq86vyhwfrc/HxR1c+gxtEXB8qfXR
	 Uf/jVBU1AM5Uy3sgrFSyc096kjiuZAiAQIE1C7pUsVqNTraWprljhR3MNIrrgLnupr
	 HvTG1z6+JTdtQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 03/12] uprobes/x86: Allow to copy uprobe trampolines on fork
Date: Thu, 21 May 2026 14:44:02 +0200
Message-ID: <20260521124411.31133-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521124411.31133-1-jolsa@kernel.org>
References: <20260521124411.31133-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we do fork or clone without CLONE_VM the new process won't
have uprobe trampoline vma objects and at the same time it will
have optimized code calling that trampoline and crash.

Fixing this by allowing vma uprobe trampoline objects to be copied
on fork to the new process.

Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 6824376e253d..11ec6b89b135 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -701,7 +701,7 @@ static struct vm_area_struct *get_uprobe_trampoline(unsigned long vaddr)
 		return ERR_PTR(vaddr);
 
 	return _install_special_mapping(current->mm, vaddr, PAGE_SIZE,
-				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
+				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
 				&tramp_mapping);
 }
 
-- 
2.53.0

