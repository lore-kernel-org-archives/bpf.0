Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2669650255F;
	Fri, 18 Sep 2026 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752306; cv=none; b=YCIP53VXhWJFRycHKwcXg6gjNtYHvNoVICEXoHJqC0gJ14OJwemPC7p0GB6SrgljHhlBUXVxXKvSpg80zaeRAfNGtoWmXxO8cQGzGdhN2f4Q7d3fSpZV35OjEAxq+jKKtzTepFI/VACoEF64GRiZoGNkg2VBQzCQXIGJpGSJBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752306; c=relaxed/simple;
	bh=LaO+SqfW2deYM/scbJpdFmumIN9PsPB68r8/lRl4k94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qy/gvLwFcGdWLMTjF9XbRu+80Nw39mN0fuchuloPm766OLGjHjoatIvSHWazG7YF70s+L8/GopUjDvoimOk+yMHcBPww6vSXp94YWx/YFsUE0uMCkiI7SlMlxUpra4devDgpquAysI8R++g1AoakJdEorUidKrysipBBarcPHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QYYah+fV; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QYYah+fV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ti
	9A+/UoRybWlQcIRPQ3w4tKAGiqMm7blYW1NdiCiEc=; b=QYYah+fVudniydHECO
	JIqm6UwIWfMPUPWHzmCh6CHxYeMhilNsZTBYjkWRdOP2T/NjDzMxpCyYr4by5uT2
	Oyjb27Em2F5w0F2QvrqOzDy8FuXoiLg95X0TIAU6aZwinZkyVG3xjEetwkXyAjQw
	0WoFW+hPQOpk/iTmPe5l752B0=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnLZG5c61qRycvBQ--.1403S2;
	Sat, 19 Sep 2026 01:24:10 +0800 (CST)
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
Subject: [PATCH bpf 1/3] bpf: Report BPF_F_PREORDER in cgroup program queries
Date: Sat, 19 Sep 2026 02:24:05 +0900
Message-ID: <20260918172407.3459188-2-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918172407.3459188-1-sh_def@163.com>
References: <20260918172407.3459188-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnLZG5c61qRycvBQ--.1403S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1rXr17uF1rJFyxZrWxtFb_yoW8uFWfpF
	4kXFy7Wa1qvr12qanFv3yrXFW8Kwn3XF4UCFZxJw1rCFW3Wr1IyryIkFWYvFy5ArZFyr10
	yF90vrn0gF1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zioq2tUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRoRcGqtc7pTUwAA30

Commit 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
introduced BPF_F_PREORDER to request pre-order execution across the
cgroup hierarchy, altering the effective prog array ordering.

While pl->flags stores BPF_F_PREORDER for each attached program,
__cgroup_bpf_query() currently fails to report it. When querying
attached programs (!effective_query), __cgroup_bpf_query() fills
prog_attach_flags[] with cgrp->bpf.flags[atype] for all entries,
omitting the per-program BPF_F_PREORDER attribute.

As a result, user space tools and query callers cannot distinguish
pre-ordered programs from standard multi-prog attachments via
BPF_PROG_QUERY.

Fix this by merging (pl->flags & BPF_F_PREORDER) with the cgroup-wide
flags when copying prog_attach_flags to user space. Only BPF_F_PREORDER
is extracted from pl->flags to ensure transient positioning flags (such
as BPF_F_BEFORE, BPF_F_AFTER, BPF_F_ID, or BPF_F_REPLACE) are not
leaked to user space. Also perform both ID and attach flags copies
within the same hlist iteration.

Fixes: 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/bpf/cgroup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 149672c76c49..e7c7efa1baa7 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1353,19 +1353,19 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 				id = prog->aux->id;
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

