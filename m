Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11672134A
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854036; cv=none; b=Q4dLxoQ/uGzu6QlMvTmojQDx6Uysqta+PWkIx8KhKUhWfpD412NC9kLW2CYY34ZVjIpYlDRaWilxX7db42/CETtFK2wiCbEoBTy+yD0vm1H7GVYkePuD01Y0o8CxkRZAXqzfnInup47fac1CJoNpVaQNASLd6BwdGgCl3Fs2Ngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854036; c=relaxed/simple;
	bh=LWAJK+Gf47OWMiko3RylyUKheAnZUdALRpAxRs44si8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6VzupbJK3Xw+8rU3qDlT7SBAavpbsnKnzAY0mi1WJ1VVFbkgSVZwGQwkq675o1pbojA8Ro5OWbwlcbyirGz/mmbOXZhyf0M4+jdf1B3q0EFiH+TZ8Uvt80QuDVb2oUvnkRdpU0L7JEcAk0fy7FPrnPY8jiBzkcIuVD50N2mGSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D237E164A197; Thu,  7 Mar 2024 15:27:05 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yury Namgung <ynamgung@meta.com>
Subject: [PATCH bpf-next 1/5] bpf: Allow helper bpf_get_ns_current_pid_tgid() in cgroup and sk_msg programs
Date: Thu,  7 Mar 2024 15:27:05 -0800
Message-ID: <20240307232705.1116787-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240307232659.1115872-1-yonghong.song@linux.dev>
References: <20240307232659.1115872-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently bpf_get_current_pid_tgid() is allowed in tracing, cgroup
and sk_msg progs while bpf_get_ns_current_pid_tgid() is only allowed
in tracing progs.

We have an internal use case where for an application running
in a container (with pid namespace), user wants to get
the pid associated with the pid namespace in a cgroup bpf
program. Currently, cgroup bpf progs already allow
bpf_get_current_pid_tgid(). Let us allow bpf_get_ns_current_pid_tgid()
as well.

With auditing the code, bpf_get_current_pid_tgid() is also used
by sk_msg prog. So I added bpf_get_ns_current_pid_tgid()
support for sk_msg prog, so now for all places where
bpf_get_current_pid_tgid() can be used, bpf_get_ns_current_pid_tgid()
can be used as well.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/cgroup.c | 2 ++
 net/core/filter.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5a568bbbeaeb..375b92204881 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2577,6 +2577,8 @@ cgroup_current_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
 		return &bpf_get_current_uid_gid_proto;
 	case BPF_FUNC_get_current_pid_tgid:
 		return &bpf_get_current_pid_tgid_proto;
+	case BPF_FUNC_get_ns_current_pid_tgid:
+		return &bpf_get_ns_current_pid_tgid_proto;
 	case BPF_FUNC_get_current_comm:
 		return &bpf_get_current_comm_proto;
 #ifdef CONFIG_CGROUP_NET_CLASSID
diff --git a/net/core/filter.c b/net/core/filter.c
index 8adf95765cdd..d4e43303a66b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8344,6 +8344,8 @@ sk_msg_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 		return &bpf_get_current_uid_gid_proto;
 	case BPF_FUNC_get_current_pid_tgid:
 		return &bpf_get_current_pid_tgid_proto;
+	case BPF_FUNC_get_ns_current_pid_tgid:
+		return &bpf_get_ns_current_pid_tgid_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
--=20
2.43.0

