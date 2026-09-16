Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0A531AFE
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583598; cv=none; b=OtNgf3gjyBTip9lQ1JT16un9G5RTZU3bVP/N2SbUeuS0cWnFGhR6gn7dw6499pFM38xFySLaEi+BPmHStEp03pop9saKRidd+K3R+Omlh10HeBLCTu3hnJjhRsOSGVRQWrgg8oHoClRzUz4AoUhYy7Ra7eA87gWjWxhLe71vvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583598; c=relaxed/simple;
	bh=7bZ+CD7MxU7KyaS2HcKIEJd5GKcxRooEie8Av6bWjK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYLg3sBgYm8kt+JKv0D+bQu6Ge/GdMxZqH6xleHt8f5bVoeHxlJDG9I7XdwuX5Ta5a67SGy7CSP3N7uEghqBOaeiy3QCy6h8bxxkkL7fcU1r8AbcfMdg33MYFfRZ2FMruor+YDOXu8ko7UM/ypNaKxGhqDV/SV+BAbK32BFXSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4TOxlxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4TOxlxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619071F0089E;
	Wed, 16 Sep 2026 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583586;
	bh=avwd/pLizCblJy1+dOq4I9WvHtAxM0pHrDvv48z6tWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4TOxlxQ8y+6qW18LmieJFFUshTJPiH+GDV1rOTzL77aLlnuBeDvkDSn+t78enP8b
	 nTl2zz3lJuLYQOhZKx2qygZ5C8fG/0hXAxgbGRND2Rn/m6bHSfr4gxsyD4XLkGR+Ne
	 urPkYDM1L+hBBLTAt+GWxY4Y3RmvUEaz1iWLBrgxT888j+qpQBNox5CrhjRjo970k7
	 pDCn0EKbaxSL+PEm5dXbii72KdKg2b+9QpTrrHCOkpE8NBGmz8tNd0t1kcbljuOQGE
	 4xQLhgMnFF9ZP0ECMzI1O2F4G5W3kW7qLGLc1BnFF16/dBZ3Vf+U0zFEDSGdbODI7K
	 dmj1VlRgZ9s5Q==
From: Chris Mason <mason@kernel.org>
To: mason@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	brauner@kernel.org
Subject: [PATCH RFC 1/2] bpf: fix UAF via trusted BTF walk after release
Date: Wed, 16 Sep 2026 18:33:02 +0000
Message-ID: <20260916183303.3504885-2-mason@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916183303.3504885-1-mason@kernel.org>
References: <20260916183303.3504885-1-mason@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BPF program can keep dereferencing a trusted pointer that it loaded
from a referenced object after it has released that reference. With a
file from bpf_get_task_exe_file(), f->f_inode stays usable after
bpf_put_file(), and loads through it read freed or reused inode memory.

A pointer derived from a referenced object is only valid while the
reference is held. release_reference() enforces that by invalidating
every register whose id or parent_id matches the released id. However,
check_ptr_to_btf_access() builds the loaded register with
mark_btf_ld_reg(), which is not given the source register and zeroes
both fields. The verifier state for the f_inode case:

    file = bpf_get_task_exe_file(task)   file:  id=N, referenced
    inode = file->f_inode                inode: trusted, id=0,
                                                parent_id=0
    bpf_put_file(file)                   release_reference(N)
                                           skips inode
    inode->i_ino                         accepted, unprobed load

Reproduced by reading inode->i_ino after bpf_put_file() once the task
owning the file had exited and new fds were created.

Fix this by recording the source's reference id in the parent_id of a
trusted PTR_TO_BTF_ID load. A program that dereferences such a pointer
after the release is now rejected with "invalid mem access 'scalar'".

Assisted-by: kres
Fixes: 57539b1c0ac2 ("bpf: Enable annotating trusted nested pointers")
Signed-off-by: Chris Mason <mason@kernel.org>
---
 kernel/bpf/verifier.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d8520cd..8b48bf796823 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6219,9 +6219,25 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	}
 
 	if (atype == BPF_READ && value_regno >= 0) {
+		u32 link_id = 0;
+
+		/*
+		 * A trusted pointer walked from a referenced object is only
+		 * valid while that reference is held. Remember the reference
+		 * id of the source, or the one it inherited, so that
+		 * release_reference() invalidates the loaded register too.
+		 * Read it now, reg may alias regs[value_regno].
+		 */
+		if (ret == PTR_TO_BTF_ID && (flag & PTR_TRUSTED))
+			link_id = reg_is_referenced(env, reg) ? reg->id : reg->parent_id;
+
 		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 		if (ret < 0)
 			return ret;
+
+		/* mark_btf_ld_reg() cleared parent_id, set it afterwards. */
+		if (link_id)
+			regs[value_regno].parent_id = link_id;
 	}
 
 	return 0;
-- 
2.54.0

