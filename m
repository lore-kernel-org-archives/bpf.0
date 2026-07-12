Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE8370AD5
	for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 04:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783829338; cv=none; b=QbOstaRZbikHXWUSpfaFMkM/JE7jUm9wqGYN4/CYpxqbpkr3SNpnbeuxfs7g5P/YRG9oJGfELCSBscADFinpeoWZxCSpH0ShjNZ13jMLydDmLB+UMrKusDfGk+XAi4HdrvmD2zG2Q3oApMrbHEvfCjbXZYpOfgwy4gKYgXmgxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783829338; c=relaxed/simple;
	bh=tLYfqud9Alqsuxe2P8hqfcpiiFUye1isw4lqTTAq7GM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/TwQnB5SaOT172lsiEOFlj/R0ohBR5x8JIpLLgXWNbDMVw3GXqFDrjF9HlWhU0iOQhbCTJbgtGeoDlOkINKRIYCuCj+GxTSvID1RTglwxiyoV/ULFHy3GFJbg8OT5kdhmgcf5IYFZwzmN46fEcv2b/oCeeg9nGZPdXnfkZY7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTkMz0G2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTkMz0G2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso2833218a91.1
        for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 21:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783829336; x=1784434136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QOcBwZZCQda0ksnOyTTPJoQylHUy+3FzULiJTSWI84w=;
        b=YTkMz0G2lYG3k+HO6Zfj+E3IkAtsfUbdK9IHOYMjpSdmm4TnpG+7vES9umMhfv8NCJ
         N3C6+LbQqBfvD+FfZDlhRSb8h+7DkD5bHI6tbEqtTdKJlCfAYMtdVR1gzVW8LU/NOnWB
         JKddzULTjjGuMMrXyflrBLLez5v/ddd35O/RURSsx/a3/aySno6DUV0mvDI4gh3UR0J5
         Re0Do7cxZ/6U5vnv2/qk0PymakVQth/plYR90RlXb0Yp4spekAZ2Yw+AQiKIDhPXqxUQ
         8b5Ilpa54+ugO9bR350EPNf+KodfVSDcytrkRnrWD0Xo7hVvR8tAvm7ZRdGnElLFFZyC
         7Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783829336; x=1784434136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOcBwZZCQda0ksnOyTTPJoQylHUy+3FzULiJTSWI84w=;
        b=swvT1tYYeb19yzXs37T08ftxHd6fCNsLtKkYrlM0Kyjn7XgWWviJzaqPyKwExc5UWs
         7UtGTdqbn8ySThB5RBw8X9tanD/8IPgeoCNNa1Cxm0DLoQ25Pxj0uj9xGXDL6CHyi2hJ
         cDlseG5CpdczQl0oiTE3zDZwFH/oOL3swxMtEdlyFgROEhj4Gb6L7jvvaMCZnn0PdjHL
         W1xz14p3wDRRzW9bR8svagy1USZ68wFn1lzbIkK7oa13Du+BCCMpTGCUggWBqAGpqLev
         TqCp+LhfluYiN7seh8MsWOY4jr5jaTYwq6sKXr4gsPjGSGCuNRt5/ltacHwqqzgCpW38
         cPeQ==
X-Forwarded-Encrypted: i=1; AHgh+RoA9gCqWmbklWM7k0PTk0MQ2cK2IMTfo52efowyvm5HITkNOKRkLAgSZZoiEr3YlIwgyEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqjxCovqtko8TaIiCXsgNwsBRFzokHcS1buXcr74GcFqeizzAX
	hbdkiLUGsvy6utFwfub8twRvE9+wD6uaAZLp0Dzt7ItT+KzBex3vgi2J
X-Gm-Gg: AfdE7cmegaYO3+VZxaj4kpuX57FyZvFbHv4gZhyTpZyf0g3IMHVBVs7I3VjhLaR+WiI
	de3EYuNmuxzz6a8L24fC2mQBXXuTV8ysAL1cR1ABUpO4+Sa13Qx1C/xZCmg/6dAAwycgbiba3HK
	OE6UJZ052Mv3IytAoT02+x75aJ4TKO2t+oD1IxxQkkH3jX4cuMLH26xqKBzafWdDq5X6wCTRlXV
	tpFfNI5tZ3lQ6y2VH99oJIf2uo1fuxB4egtweW9bbzwZV49JryqFZtJE31Zid3NyIhQcnp7pyXc
	4vTDk6X6awRP1O4qT6Tf5NW9BtqwdgzXZV2GFoYk/MyD7Az6jjmJwUE1tj75bsJ/YFjm4pyCxPJ
	axcDxCkiC+J9EERKjL3/xXC89K+BcnR5C+Lcpn3fT/71p1w0aK40IrGHS2IFY3CiDQIHD+bQGUs
	TqtbAR/oiTOPh0mkL0
X-Received: by 2002:a17:90b:39ad:b0:381:abcc:c8e9 with SMTP id 98e67ed59e1d1-38dc73bcfecmr4632607a91.7.1783829335997;
        Sat, 11 Jul 2026 21:08:55 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm56808928eec.10.2026.07.11.21.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 21:08:55 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Sat, 11 Jul 2026 21:08:17 -0700
Subject: [PATCH v2 4/5] bpf: allow fs kfuncs for binfmt_misc_ops programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-binfmt-misc-bpf-v2-v2-4-d6591ceaf207@gmail.com>
References: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
In-Reply-To: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
To: Christian Brauner <brauner@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Jann Horn <jannh@google.com>, 
 John Ericson <mail@johnericson.me>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

The fs kfuncs are currently exclusive to LSM programs. A binfmt_misc
load program needs a subset of them to do anything interesting: to
compute an interpreter relative to the binary's location it wants
bpf_path_d_path() on bprm->file->f_path, and matching on per-binary
metadata wants bpf_get_file_xattr() and friends.

Register the fs kfunc set for struct_ops programs as well and extend
the filter to admit binfmt_misc_ops programs. The xattr setters stay
exclusive to LSM programs: a binary type handler decides how to run a
binary, it has no business modifying filesystem state.

This only takes effect in builds that have the fs kfunc set at all,
i.e. CONFIG_BPF_LSM. Without it a binfmt_misc handler is limited to
bprm fields and the file-backed dynptr, which are provided by the
common kfunc set.

Link: https://lore.kernel.org/20260704211409.1978485-1-farid.m.zakaria@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/bpf_fs_kfuncs.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 768aca2dc..aa1fe988b 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Google LLC. */
 
+#include <linux/binfmt_misc.h>
 #include <linux/bpf.h>
 #include <linux/bpf_lsm.h>
 #include <linux/btf.h>
@@ -387,10 +388,20 @@ BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
+/* Side-effecting kfuncs that stay exclusive to LSM programs. */
+BTF_SET_START(bpf_fs_kfunc_lsm_only_ids)
+BTF_ID(func, bpf_set_dentry_xattr)
+BTF_ID(func, bpf_remove_dentry_xattr)
+BTF_SET_END(bpf_fs_kfunc_lsm_only_ids)
+
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
-	    prog->type == BPF_PROG_TYPE_LSM)
+	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id))
+		return 0;
+	if (prog->type == BPF_PROG_TYPE_LSM)
+		return 0;
+	if (bpf_prog_is_binfmt_misc_ops(prog) &&
+	    !btf_id_set_contains(&bpf_fs_kfunc_lsm_only_ids, kfunc_id))
 		return 0;
 	return -EACCES;
 }
@@ -433,7 +444,13 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 
 static int __init bpf_fs_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	if (ret || !IS_ENABLED(CONFIG_BINFMT_MISC_BPF))
+		return ret;
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					 &bpf_fs_kfunc_set);
 }
 
 late_initcall(bpf_fs_kfuncs_init);

-- 
2.51.2

