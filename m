Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C83CBE79;
	Sat, 19 Sep 2026 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789811101; cv=none; b=Ku7gK04ciiQKUnfqWWP+6TJ9OkoSz3AIerG7mVZ9P6f1EmKzJHh9K7qWOpZy6PlwurO6ksUNiNC7HBkc+d2ITZKTVijcU6LSExTo4j2A6/qwIdWO/3TBZMpJvY0c0/6WJz7D2hIk0WNIFCCiI0i+TwxQLxGVw9BYfGfZeT4ovsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789811101; c=relaxed/simple;
	bh=J0VzSDZQmuR/ny4xw4pcK0QXPE0s4hb51DZx21HbVTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBceb/bYKmI526E1uiqpd0W/X74HImP2merw8HUGSGSe5Mwok3h6zEWUIzaEJmHGpG+LJt4KstkroMpYoDrgRbhlEkS/cxqQEogTPwn+2GZJdh+yZFg3poGZ73DJgLp+54qXVu/3mSIym5OyY/ErC1YrVDxyp/6ub/Wvn2nuPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hJzQBPlb; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hJzQBPlb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Il
	rQt5VrdhD9gIkiQAfFKZQskxVSv6LD4qqQfdMNGgw=; b=hJzQBPlbFV1h4tRMDn
	gaoNsMuib3Ca4eU4Ndo9DPfetlMSphMfYEJEzm1cNvpLRKT51VJcEnqV6BKxsgys
	LHmdfkizEfKsAHtWZSUHT1Jzfe9UiitPbtVEM78NeuJ3RndOak5/TzByOcuaVmC6
	VU6LkyWbT+ZES0M9cFWOFmXDY=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAn5MxhWa5qaUAsBg--.43112S2;
	Sat, 19 Sep 2026 17:44:02 +0800 (CST)
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
Subject: [PATCH bpf-next v2 1/3] bpf: Report BPF_F_PREORDER in cgroup program queries
Date: Sat, 19 Sep 2026 18:43:58 +0900
Message-ID: <20260919094400.600585-2-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919094400.600585-1-sh_def@163.com>
References: <20260919094400.600585-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn5MxhWa5qaUAsBg--.43112S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1rXr17uF1rJFyxZrWxtFb_yoW8Kw4kpF
	4vqFW7C3W7Zr1aqa18t3yFvFW0g3Z3XF1UCF9xJw15uay7Wr1xtr92yFW5uFy5ArW7Ar10
	vF90vrn8WF1jvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zioq2tUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/

Commit 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
introduced BPF_F_PREORDER to request pre-order execution across the
cgroup hierarchy, altering the effective prog array ordering.

While pl->flags stores BPF_F_PREORDER for each attached program,
__cgroup_bpf_query() currently does not report it. When querying
attached programs (!effective_query), __cgroup_bpf_query() fills
prog_attach_flags[] with cgrp->bpf.flags[atype] for all entries,
omitting the per-program BPF_F_PREORDER attribute.

Extend direct cgroup program queries to merge (pl->flags & BPF_F_PREORDER)
with the cgroup-wide flags when copying prog_attach_flags to user space.
Only BPF_F_PREORDER is extracted from pl->flags to ensure transient
positioning flags (such as BPF_F_BEFORE, BPF_F_AFTER, BPF_F_ID, or
BPF_F_REPLACE) are not leaked to user space. Also perform both ID and
attach flags copies within the same hlist iteration.

This extends prog_attach_flags[] with the per-program BPF_F_PREORDER bit.
This can introduce new prog_attach_flags[] values with BPF_F_PREORDER set,
for example 0x40 (BPF_F_PREORDER), 0x41 (BPF_F_ALLOW_OVERRIDE |
BPF_F_PREORDER), or 0x42 (BPF_F_ALLOW_MULTI | BPF_F_PREORDER) depending
on the cgroup-wide attachment mode.

Older bpftool versions treat such combinations as unknown flags; bpftool
support is updated later in this series.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/bpf/cgroup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 696b27383974..eb9e0985ac43 100644
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

