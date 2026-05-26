Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA652F28FC;
	Tue, 26 May 2026 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829163; cv=none; b=YGCbRvXpX86oHEjaM9SNZevs13qpiIuPQP7uMqQoP5N1g9XtXqIFqu4l1lKRUIuwjQW6rNI3Vb6tw2crRblnQjcid99CVj0Jy542yCfMVSa9XDe+lj9WJ+xbilbxP2LqELz+LI8Md1ZN7DYV8gV0p3NusVBiIUyBHk/vqYRNJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829163; c=relaxed/simple;
	bh=VUi5k0/It3haRbaP6ozzweOFAA4LC43id13aTPi0Pys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMPcLiz8Imu+P5vv/vR2g0BOp7UyhF3uSdiF+QhgcSt+LeLvW2TUa2/EHAgcrPg0CxQGuhrLaFZmdYV6f+SfTMnrMZiOhM6I3hJ4Hp9T9H2ZOBEqDtZIFfrcqg07RhZnlYR0lisq8+o8BKu0FxXuD6pj26BiU3m1nRk0/uuoRDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7qT64aK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7qT64aK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1349C1F000E9;
	Tue, 26 May 2026 20:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779829162;
	bh=TfZJnEjts0F6bjfyNC2z5RmYBG+z+bzSxvFBRuDLAgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n7qT64aKXNMAGxqDn05/gLLdCrhJDL/iUstdSd1pSsvp1H7nhhe21u0M469u2BKFS
	 fWntFxg7KEm0U2KuA5DZs35A1Dur9TY9kEDV1ZqMYRUd8s83BwFEIXpxUHHsnHjVDL
	 tt1yLj5OLB8Q9PuCv0TIyzXXOz0Sh2fLVJ0r6dggHdJU9OhIU/Fj7kq6aa1dJz4Iiw
	 7gRgyh440FfqYtk/aeM4Lq8hglfSWBL3MGxkpTKaMuLGSzSJ9XQydkfdsarH5ooBw+
	 UWRC9mJHYiW2qieyGae3MvfWGamznR/jOU1KifhUX5bxgEtadWlWFStjxcKXn5xzLJ
	 iHH3csDbq2icQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 04/13] uprobes/x86: Unmap trampoline vma object in case it's unused
Date: Tue, 26 May 2026 22:58:31 +0200
Message-ID: <20260526205840.173790-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526205840.173790-1-jolsa@kernel.org>
References: <20260526205840.173790-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case the optimization fails, we leak new-ly created trampoline
vma mapping (in case we just created it), let's unmap it.

Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index c8af41ed681a..af5af7d67999 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -677,11 +677,14 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
 	return high_tramp;
 }
 
-static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr)
+static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr,
+						    bool *new_mapping)
 {
 	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 
+	*new_mapping = false;
+
 	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
 		return ERR_PTR(-EINVAL);
 
@@ -696,6 +699,7 @@ static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsign
 	if (IS_ERR_VALUE(vaddr))
 		return ERR_PTR(vaddr);
 
+	*new_mapping = true;
 	return _install_special_mapping(mm, vaddr, PAGE_SIZE,
 				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
 				&tramp_mapping);
@@ -1053,16 +1057,21 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 {
 	struct pt_regs *regs = task_pt_regs(current);
 	struct vm_area_struct *vma, *tramp;
+	bool new_mapping;
+	int ret;
 
 	if (!user_64bit_mode(regs))
 		return -EINVAL;
 	vma = find_vma(mm, vaddr);
 	if (!vma)
 		return -EINVAL;
-	tramp = get_uprobe_trampoline(mm, vaddr);
+	tramp = get_uprobe_trampoline(mm, vaddr, &new_mapping);
 	if (IS_ERR(tramp))
 		return PTR_ERR(tramp);
-	return WARN_ON_ONCE(swbp_optimize(auprobe, vma, vaddr, tramp->vm_start));
+	ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
+	if (WARN_ON_ONCE(ret) && new_mapping)
+		WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
+	return ret;
 }
 
 void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
-- 
2.54.0

