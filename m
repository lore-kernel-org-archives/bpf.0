Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0AA3203B0;
	Tue, 10 Feb 2026 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770751667; cv=none; b=cO6bUDRxFROeRzF3RowjKZ0HOMwfrk9ufrTzOqsHgSZjdWLAthuTbNS//B03QbD/3xflDKnd9fCP7vB5ANDN7gPU5rEL6Y0fpw+dPqNZMixBHw/cQtRQ6mComXAY0X9RSLqgEMJNyl8HUpabM5JbMdcsgBpq01xbsKZx3b15dfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770751667; c=relaxed/simple;
	bh=wkqp2wPWayOvVJQZcLiwtChcNMqp6C7A1Am7bm/3V5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NV2R2DHsRltgu4R2FnpqbkG7iQqxlM0KmamWhwtyc/RT5R5Lsym0/hTyLisdvSGTS8VaPp8SXaIlGdwxZp6IUyI+0rmxKr0hLWKxAbUSadZcrepVkK0xshinCkcDvwRkv3sFVP92ZjdGqkZrrZKXqB/tBbPgb+/CGP/7tVK8Rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KemG4Sqs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KemG4Sqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E616FC116C6;
	Tue, 10 Feb 2026 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770751667;
	bh=wkqp2wPWayOvVJQZcLiwtChcNMqp6C7A1Am7bm/3V5A=;
	h=From:To:Cc:Subject:Date:From;
	b=KemG4Sqs9ukBU7zErKNReg/06R20qHNXnHuts5awsxDwSLOSqe1UJ602jx6hliW9u
	 uPtIQdehjo9AmefRsQfYrt6UxMeAtj1BxTACwhy08dirC7zI5KeRUknrnTCwLZoGAM
	 oV0U5Tf4N4X08iogIIMektrIIotXCJtpecFdjabCUzbYlUeSNaOU3dv5IU43B2mMjS
	 YATifKGsI6gUi/ydRvS/l4toXejdgu6L3Vg2eh0+mNok7PkMpwRS9l1amRKlBS5+LX
	 jhb05mcmwWbwKIUMxuOCiShc4/f5Wv9r4QcUUIJHqokoCuuh+ufw9VkxWdGhzDTATS
	 i2ntxMitxqqmQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	surenb@google.com,
	shakeel.butt@linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	Ruikai Peng <ruikai@pwno.io>,
	Thomas Gleixner <tglx@kernel.org>,
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
Subject: [PATCH mm-hotfixes-stable] procfs: fix possible double mmput() in do_procmap_query()
Date: Tue, 10 Feb 2026 11:27:38 -0800
Message-ID: <20260210192738.3041609-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When user provides incorrectly sized buffer for build ID for PROCMAP_QUERY we
return with -ENAMETOOLONG error. After recent changes this condition happens
later, after we unlocked mmap_lock/per-VMA lock and did mmput(), so original
goto out is now wrong and will double-mmput() mm_struct. Fix by jumping
further to clean up only vm_file and name_buf.

Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA lock")
Reported-by: Ruikai Peng <ruikai@pwno.io>
Reported-by: Thomas Gleixner <tglx@kernel.org>
Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 26188a4ad1ab..2f55efc36816 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -780,7 +780,7 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 		} else {
 			if (karg.build_id_size < build_id_sz) {
 				err = -ENAMETOOLONG;
-				goto out;
+				goto out_file;
 			}
 			karg.build_id_size = build_id_sz;
 		}
@@ -808,6 +808,7 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 out:
 	query_vma_teardown(&lock_ctx);
 	mmput(mm);
+out_file:
 	if (vm_file)
 		fput(vm_file);
 	kfree(name_buf);
-- 
2.47.3

