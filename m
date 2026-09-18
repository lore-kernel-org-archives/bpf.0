Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C53D34B6;
	Fri, 18 Sep 2026 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723216; cv=none; b=QU9p1DI4qqGRVQVUeT4Vlbizlj2UuUnkQXBRoxY7Na9v0vsaOWdS3L5/pzq4QzZLhtSNKJjFOALsQbnVRH+X7qYqO+wC9SUuLhXtL38H3aJqC+dfNod7S62Gki1Qo/j7QPZCAQbZzO+E2/yE/GzvTBhhe4iYH+tKAOlIIX361Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723216; c=relaxed/simple;
	bh=xpxkGsFs2znX7tyIDqWniWwsMv3P7WFY27DlsDXEghg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuFozC3DGLnM5pjRTtW/hGOc31YeJjsUXUOIknryu0SX8RRG2ar4OuWpm/UA8XJfnORmEDzUmtdxK9io6xkuAYOkjOIw9WBRZQJ5TPwBJ4jyDvRD7glj55EoYj+U82JNQYtYybqT8gcq0hVV59Irfz0c4pjZJy9KsFdkpqe0J1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML/vU9wU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML/vU9wU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F691F000FF;
	Fri, 18 Sep 2026 09:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723214;
	bh=rp+rJmhTE7Df7VsQPiO1xXybhrFkjWSbdjcw3UfOXPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ML/vU9wUTiV7IpxrbkVbrPIZCCpeS5W9MCafzrH4LCoogdtHsIhfCx/8jLLzjz65e
	 gpiG8/V3KZVETLi/KYkGLg94yjTjgNPJY4LqxVc4RldYsZPHC72JaXcE3yFEAdprK0
	 aTLp6m49wnCkhn6XWaAUZG2gKK3XcaTQNehkOAzRJnY04Mg2qZD5Ab5aIYwTDszWr8
	 b/s+RvHPecLLYqF9THIvZuy0Mka+jhB2Ep2DFQjXD8crxDtyoTNAeYb5oJgpeWHI/Z
	 nrS3jxjehGNm2dBMPqFhSw9I8/Nia46U2gLs683QjkivQmXOm+zOgEiEZ11q9+xMDV
	 5P4BXDIrfMEfw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 18 Sep 2026 11:20:00 +0200
Subject: [PATCH 2/2] binfmt_misc: fix racy checks in bpf set_interp kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-work-binfmt_misc-fixes-v1-2-647b24bc1c46@kernel.org>
References: <20260918-work-binfmt_misc-fixes-v1-0-647b24bc1c46@kernel.org>
In-Reply-To: <20260918-work-binfmt_misc-fixes-v1-0-647b24bc1c46@kernel.org>
To: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=5856; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Hnw5hxTi5fYqyBdtFSZVwFO8KP68FjOAa84bLk+sgF0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStZXK7MefV3Irf6m2zfdU2vZjKuFwiQXpHo6pWacSVT
 8kzz1rKdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkcwPD/9Bjil6fOJYoFi7i
 yZvykt9i04GknBuCl3yXfTBYfHqHJgvD/7CN8T8lLZ4x/1wQ1t/x0cj/ZFF0sX3JAvf0ouo+7rK
 /nAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

From: Chris Mason <mason@kernel.org>

bpf_binprm_set_interp() tests path[0] != '/' on the buffer its load
program passes and then reads the same buffer again to copy it with
kmemdup_nul(). The buffer can be a BPF map value that another CPU
rewrites between the two reads. If byte 0 is overwritten in that
window, the kfunc stages a relative or empty interpreter path. The
staged path is not checked again, so open_exec() resolves a relative
path against the working directory of the task doing the exec.
bpf_binprm_set_interp_arg() has the same pattern for its "!len" test
and can stage an empty argument, which the interpreter then receives
as an empty argv entry.

The verifier checks the path and path__sz pair with BPF_READ |
BPF_WRITE, so a writable array map value is an accepted argument.
bpf(BPF_MAP_UPDATE_ELEM) on an array map copies the new value over the
old one in place and takes no lock. Both kfuncs are KF_SLEEPABLE and
allocate with GFP_KERNEL between the test and the copy, so the task
can sleep inside the window:

    load program                          bpf(BPF_MAP_UPDATE_ELEM)
    bpf_binprm_set_interp()
      strnlen(path, path__sz)
      path[0] != '/' is false
      kmemdup_nul(path, len, GFP_KERNEL)
        allocation may sleep
                                          array_map_update_elem()
                                            copy_map_value()
                                              rewrites byte 0
        copy reads path again
      bm_bpf_stage_selection()

The test in the load program's column proves what byte 0 held only at
the moment the test ran. The map update takes no lock, so it can store
to byte 0 right after. kmemdup_nul() then copies the rewritten bytes,
and bm_bpf_stage_selection() publishes them as bprm->bpf_interp.

The staged path is not checked again on its way to open_exec():

    load_misc_binary()
      entry_select_interpreter()     returns bprm->bpf_interp unchanged
      build_interp_argv()
        copy_string_kernel()         copies it as argv[0]
      bprm_change_interp()
        kstrdup()
      entry_open_interpreter()
        open_exec()                  unless a bound file is staged or
                                     the entry is an 'F' entry

None of these functions tests the first byte, and load_misc_binary()
hands the pointer to nothing else.

In bpf_binprm_set_interp_arg(), strnlen() finds a non-zero len, a NUL
is then stored to byte 0, and build_interp_argv() later copies the
empty bprm->bpf_interp_arg with copy_string_kernel().

The handler's own load program has to pass a writable map value, and
something has to store into it while the kfunc runs. The allocation can
sleep inside the window, and with a BPF_F_MMAPABLE array the store is a
plain user space write into the mapped value, so a loop can hit it
without a single bpf() call.

Check the private copy in both kfuncs, so that the string that gets
staged is the string that was checked. bpf_binprm_select_interp()
already looks its name up in a private copy for the same reason. The
remaining tests work on path__sz, arg__sz or the local len, and the
copy length is len, so the copy stays inside the extent the verifier
checked.

Results of bpf_binprm_set_interp() with the check on the copy:

- A NUL stored to byte 0 fails interp[0] != '/' and gets -EINVAL.
- For len == 0, kmemdup_nul() returns an empty string, so an empty path
  still gets -EINVAL.
- A NUL stored further into the string only shortens it to another
  absolute path, or another non-empty argument, that the program could
  have passed anyway.
- A path that both lacks the leading '/' and is PATH_MAX or longer now
  gets -ENAMETOOLONG instead of -EINVAL.
- A path that is empty or lacks the leading '/' is now rejected after
  the copy rather than before it, so such a call makes an allocation
  and returns -ENOMEM instead of -EINVAL if that allocation fails.

bpf_binprm_set_interp_arg() still rejects an empty argument before
allocating, so its results are unchanged apart from the raced case
fixed here.

Both new checks run before the previously staged string is freed or
replaced. A failing call frees only its own allocation and leaves the
earlier selection in place, as the -ENOMEM path already does.

Fixes: b4bfe2f6b011 ("binfmt_misc: add binfmt_misc_ops bpf struct_ops")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc_bpf.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_misc_bpf.c b/fs/binfmt_misc_bpf.c
index ce1bc78e8511..a3e26e8a4027 100644
--- a/fs/binfmt_misc_bpf.c
+++ b/fs/binfmt_misc_bpf.c
@@ -141,8 +141,6 @@ __bpf_kfunc int bpf_binprm_set_interp(struct linux_binprm *bprm,
 	len = strnlen(path, path__sz);
 	if (len == path__sz)
 		return -EINVAL;
-	if (path[0] != '/')
-		return -EINVAL;
 	if (len >= PATH_MAX)
 		return -ENAMETOOLONG;
 
@@ -150,6 +148,15 @@ __bpf_kfunc int bpf_binprm_set_interp(struct linux_binprm *bprm,
 	if (!interp)
 		return -ENOMEM;
 
+	/*
+	 * The program may pass memory that is written to while this runs,
+	 * so check the private copy and not the buffer it was made from.
+	 */
+	if (interp[0] != '/') {
+		kfree(interp);
+		return -EINVAL;
+	}
+
 	bm_bpf_stage_selection(bprm, interp, NULL);
 	return 0;
 }
@@ -241,6 +248,15 @@ __bpf_kfunc int bpf_binprm_set_interp_arg(struct linux_binprm *bprm,
 	if (!val)
 		return -ENOMEM;
 
+	/*
+	 * The program may pass memory that is written to while this runs,
+	 * so check the private copy and not the buffer it was made from.
+	 */
+	if (!val[0]) {
+		kfree(val);
+		return -EINVAL;
+	}
+
 	kfree(bprm->bpf_interp_arg);
 	bprm->bpf_interp_arg = val;
 	return 0;

-- 
2.53.0

