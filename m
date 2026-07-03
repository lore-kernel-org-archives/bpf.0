Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD63CAA57;
	Fri,  3 Jul 2026 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079411; cv=none; b=Vo8tDVuSS7y6iwGXw+YBziV7l/bCVf6y+9WG2xAeNvX4UYMjEUk8Ho8RReJbRD8R6mAXiabJWCzN/q/q9syrcM8VYC1gJ+P3VM/VhOpRqCqB21dH4JMzHs4t3385zi7ZKrF6+PA95mb2jyj86h6r0SKiZkgo8MWYqDanV0bu7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079411; c=relaxed/simple;
	bh=uWNSsQ5nooAPg9SGuXfuEik0pZXXEpwLRhXcY95+FDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8zb5QeyYkIqeXao/soijgCa8J38JdBGHZAtfjr5zisj3Qq19+Ny/28+/MBqEI5+Pq5l8wDjhnw+oBn419lI6s43n1nG9hclkD14N5Vouy3nj5fKH8uTBDhsQaX3SF7mWBjDCEqZrVS/ZWEuMqALx500VUnF+9JLfb2i1oj231s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqFgXFKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqFgXFKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5841F000E9;
	Fri,  3 Jul 2026 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079410;
	bh=YVKq4klbVibOmH5jy+G13M3OVF8qflNh2OGvx3uM9XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YqFgXFKfx8JU1MVH0Y1urY6+1wq0XeHiKHazRMStxCM8QUkBsM62CyzK3bt7gwZxc
	 QT2Cep2fsPOZalWdmmQ3UumCyLkqwkKleuVw2Gw0HEV+MokfkRmZU2KYq+7r7cMB2+
	 7KXjmkncAW+sLkVRnJrirKp3KM0dpSisCIac/gdqo9ISj/8tb86EOa6yjwlckj/n/g
	 GdIr6Qi2rR5n/Ma5viNFp+rkmfo2OBA7d7ULEU6qP/VV20duk730yIO3u/Dg+jRbg7
	 FDRfuR1/zu5uBuuuZ5VxUk1b3lD0Nx+H3pRCgMj+PtyDP3LG8kswqKOiwi7mfUe1Nn
	 of4r5QTQNEwFw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv6 04/13] uprobes/x86: Allow to copy uprobe trampolines on fork
Date: Fri,  3 Jul 2026 13:49:08 +0200
Message-ID: <20260703114917.238144-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703114917.238144-1-jolsa@kernel.org>
References: <20260703114917.238144-1-jolsa@kernel.org>
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
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5730d41eb5f2..af5af7d67999 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -701,7 +701,7 @@ static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsign
 
 	*new_mapping = true;
 	return _install_special_mapping(mm, vaddr, PAGE_SIZE,
-				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
+				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
 				&tramp_mapping);
 }
 
-- 
2.54.0

