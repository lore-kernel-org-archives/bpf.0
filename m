Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353C3B27C6;
	Tue, 22 Sep 2026 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045731; cv=none; b=YGSXzCob1x16Rf3YiYhCaiNQb5qWFtidkx3leDdPJMRAutY9gVGHPzums7YUDteDHcDSXEpyzekgpwgPK2+TUdsRZR59Zhylvtaii9GwV/EBfbTgnvlumL08lO313QPNzCCPavIh3NzY8QT4l4uhw85+wC2NYMBdM/Qnm6kd6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045731; c=relaxed/simple;
	bh=+7tk65VehXfxdW/hJz5YnXEKaDRQhunCVmEtXDvuLSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feJv52DMTdIWEzMx4vldAVcseC6Ld0zAHd8XnJnqeESoSoN70sJHZwDtLntBBv/3gYWVK73jiUlJvhCqQWH61W3e5ODdqD6tG7EaVvi/TjITkEulhxzfaEmCU0oRoo5HLflJ76QjIOKPVlij1jRbrmVhC9oWL5Jl02ho1dn+XCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KJ6+18KJ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KJ6+18KJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vl
	kyJfsgylXlYUWQ2UWwJsTEdH4rKHN0ZElZoFLMfkg=; b=KJ6+18KJkW2LVVH234
	PpZ4ACc+3fFo8HQupPsTz2+SjIysMgPn62KO/lxrjFIMFURFS/nzoZpIelakCuTD
	kOyw69RSxEzSB0gy5ki1ht/GdMpnzJ0sAb6PY+Sf8YZd85YoUa9rB6dPFZBVkosK
	pE28PRC+GNV/wugCu/J70fne8=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCn8HP07bFqT6riAg--.6728S2;
	Tue, 22 Sep 2026 10:54:45 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf-next v3 1/3] bpf: Report BPF_F_PREORDER in cgroup program queries
Date: Tue, 22 Sep 2026 11:54:40 +0900
Message-ID: <20260922025442.3176057-2-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922025442.3176057-1-sh_def@163.com>
References: <20260922025442.3176057-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCn8HP07bFqT6riAg--.6728S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4xCryftw47JrWfZrW7CFg_yoW8Cw17pF
	s5XFW7K3Wjvryaqw40g34FvrW0g3Z3XF1UCF9xG34fuayagr18tr9akFW5CFy5trZxCr10
	vF90vr4Ygr1jvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zioq2tUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hW-H2qx7fXSfwAA3x

Extend direct cgroup program queries to merge
(pl->flags & BPF_F_PREORDER) with the cgroup-wide flags when copying
prog_attach_flags to user space. Only BPF_F_PREORDER is extracted from
pl->flags to ensure transient positioning flags (such as BPF_F_BEFORE,
BPF_F_AFTER, BPF_F_ID, or BPF_F_REPLACE) are not leaked to user space.

This can introduce new prog_attach_flags[] values with BPF_F_PREORDER
set, for example 0x40 (BPF_F_PREORDER), 0x41
(BPF_F_ALLOW_OVERRIDE | BPF_F_PREORDER), or 0x42
(BPF_F_ALLOW_MULTI | BPF_F_PREORDER), depending on the cgroup-wide
attachment mode.

Older bpftool versions treat such combinations as unknown flags;
bpftool support is updated later in this series.

Signed-off-by: Hui Su <sh_def@163.com>
---

Notes (bpf-preorder-v3-20260922-check):
    Testing:
    - PASS: ./test_progs -t cgroup_mprog_opts (x86_64 QEMU/KVM).
    - Result reused after a content-equivalent rebase; the patch diff is unchanged.

 kernel/bpf/cgroup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 1cb5e6a6ffc1..2bbe77de89f0 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1515,19 +1515,19 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 				id = prog_list_id(pl);
 				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
 					return -EFAULT;
+				if (prog_attach_flags) {
+					flags = cgrp->bpf.flags[atype] |
+						(pl->flags & BPF_F_PREORDER);
+					if (copy_to_user(prog_attach_flags + i,
+							 &flags, sizeof(flags)))
+						return -EFAULT;
+				}
 				if (++i == cnt)
 					break;
 			}
 
-			if (prog_attach_flags) {
-				flags = cgrp->bpf.flags[atype];
-
-				for (i = 0; i < cnt; i++)
-					if (copy_to_user(prog_attach_flags + i,
-							 &flags, sizeof(flags)))
-						return -EFAULT;
+			if (prog_attach_flags)
 				prog_attach_flags += cnt;
-			}
 		}
 
 		prog_ids += cnt;
-- 
2.55.0

