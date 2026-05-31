Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58E37A4BC
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780214169; cv=none; b=SaolXDsFJgd3p8Za1W4TC0J5zIh7VuISO6Bx7rJYqdObBuLZ3k+AbiWyOitNBt1AoDa3z4c8jluIDxxiMkl4i6xfAPo81m+qWBCBAECt0Ri1dVhwEbbqEEjvJI6Pnsa1aoN1xe/hJRg7aMrzVc8KJR/t+4gVVgNpjFY1ejsJoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780214169; c=relaxed/simple;
	bh=vc8uI7fre2knoMD29lzdG+t4n+4hmgPxv/UuJ0IxiIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DMzAeaNsocihTlCDNJGOgzVGPY0/erbxnrbk4dyi9MZil7fmIGfnQvtuzsFV1sRjjfDz45M7dItLJVV/9P+35Q1xvAxFNZyDhc7NINaIlY9orHn6lPxIx8DMU+4PHdzxsSuL10+jKIZPqQhRr/HrsMOm2MzOyuT0KV6MAdYbXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQ+EY/cA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQ+EY/cA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c1e08848so3824985ad.0
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780214167; x=1780818967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hm6Ja/EoBGgEc/73Iq1ADAFuOLcm1TTBVWrOlqOfnI=;
        b=uQ+EY/cAaztK4OhIdVXG5+zGffY0ZEoUb6IKGVJzwgfv/ptyewHL9+Zr9AZ0zyhASD
         +dGSgmeVRXGitrNgqom7p8W+Xm8oWS46dKkkKYadPVFFOgY6qoVwpnxXa7hZQJgZ2MIb
         DToprtKXmDGxJOVNG8fhBoSkoccZZYLpqlju/ryDQgL7oViyOjqTMExr0lt6zf0yEKbD
         ozlF2zOTjMib2dq0ITWoZUwxfxGmkIGeSiHNJ60VL0UTeNShf5ziHIbVVkL7cbrpMG04
         93xjSm5KOutGxxBEXKJtCZWxleLm6oIgo9ofYz81mDQmCtXv+j1OIbHXTZX+tloTWue4
         Yk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780214167; x=1780818967;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7hm6Ja/EoBGgEc/73Iq1ADAFuOLcm1TTBVWrOlqOfnI=;
        b=mSbY6O34PidbRVgwc9u8vXSFirVRxI73Xs5MY0W4GIARp4L9hCqGKGnPEOa80cnMwW
         MSKbOUPbXMjbo4rguKHq5c//KKyoDrnlQuxCw2F1uGvxKqW+hAQSLeSpSulv63lhUqry
         XbsOlb89IKZXaD6N36yUk8E8EAIvlDQhVRRgJkTjOjAGg9Xju09mUg9SS9UXmGV9Rs/e
         v27ZD3ChDHOpKnG0zSICPMeB0lbI1+QTHlH5sHnyWlwyAn7PV1rk3pdSpFarC08NRnsj
         KN8LCZpU31fxg6i+Nii+eSwRZ6Iz8bwRUR+kFLKbvJ3q/R9KXlx+v858WV8ey96tZZkr
         mv8A==
X-Forwarded-Encrypted: i=1; AFNElJ9KwYZdo5sxmBcVthDVHqlz3lgo48t3j0iqSdRf+Cf4xN3u7c+8gjNiFOKo8NxAakU18aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pQG9b5Ys6eKM9ODmf4MLQXZ1MItjivvZFeWNouYpqd85F0hh
	eDwhU+c//iFFxsbO4INAnxDPlIAFr/wl/TrkHvaf+W7pgKSixXRjL06VXKIt1YIIekdlrq3Ml7e
	3FT9hEk+2fmrPytRyG/WpHD2g+Q==
X-Received: from plpl1.prod.google.com ([2002:a17:903:3dc1:b0:2c0:a516:2c2])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:94e:b0:2bf:2d0:887b with SMTP id d9443c01a7336-2bf367bd713mr69747635ad.9.1780214167090;
 Sun, 31 May 2026 00:56:07 -0700 (PDT)
Date: Sun, 31 May 2026 15:55:59 +0800
In-Reply-To: <20260531075600.4058207-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531075600.4058207-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531075600.4058207-2-yuyanghuang@google.com>
Subject: [PATCH bpf-next v3 1/2] bpf: fix BPF_PROG_QUERY OOB write and cgroup
 backward compat
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

BPF_PROG_QUERY writes back the 'query.revision' field unconditionally to
userspace. If userspace passes a smaller 'bpf_attr' structure (e.g. 40
bytes, which was the layout before the addition of 'query.revision'),
the kernel performs an out-of-bounds write.

Fix this by propagating the user-provided attribute size 'uattr_size'
down to the cgroup query handlers, and conditionally skipping writing
the revision field to userspace when the provided buffer size is
insufficient.

query.revision in bpf_mprog_query is structurally identical to the
cgroup case: a late tail field, written unconditionally.

But the backward-compat hazard is not the same.

The min-historical-size test is per command, and bpf_mprog_query only
serves attach types that were born with revision in the struct:

- tcx_prog_query -> BPF_TCX_INGRESS/EGRESS
- netkit_prog_query -> BPF_NETKIT_PRIMARY/PEER

tcx, netkit, the revision field, and bpf_mprog_query itself all landed in
the same v6.6 merge window (053c8e1f235d added the mprog query API +
revision; tcx in e420bed02507, netkit in 35dfaad7188c). There has never
been a tcx/netkit BPF_PROG_QUERY userspace that doesn't know about
revision. So for these commands the minimum legitimate struct already
covers offset 56-64 =E2=80=94 no old binary can be broken here.

Contrast with cgroup: BPF_PROG_QUERY on cgroup attach types shipped in
2017; revision write-back was bolted on years later (120933984460). That
path has a real population of pre-revision callers.

Fixes: 120933984460 ("bpf: Implement mprog API on top of existing cgroup pr=
ogs")
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 include/linux/bpf-cgroup.h |  5 +++--
 kernel/bpf/cgroup.c        | 13 +++++++------
 kernel/bpf/syscall.c       |  6 +++---
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index b2e79c2b41d5..4d0cc65976a1 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -421,7 +421,7 @@ int cgroup_bpf_prog_detach(const union bpf_attr *attr,
 			   enum bpf_prog_type ptype);
 int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *pr=
og);
 int cgroup_bpf_prog_query(const union bpf_attr *attr,
-			  union bpf_attr __user *uattr);
+			  union bpf_attr __user *uattr, u32 uattr_size);
=20
 const struct bpf_func_proto *
 cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog);
@@ -452,7 +452,8 @@ static inline int cgroup_bpf_link_attach(const union bp=
f_attr *attr,
 }
=20
 static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
-					union bpf_attr __user *uattr)
+					union bpf_attr __user *uattr,
+					u32 uattr_size)
 {
 	return -EINVAL;
 }
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 876f6a81a9b6..2c2bdaa86aa7 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1208,7 +1208,7 @@ static int cgroup_bpf_detach(struct cgroup *cgrp, str=
uct bpf_prog *prog,
=20
 /* Must be called with cgroup_mutex held to avoid races. */
 static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *a=
ttr,
-			      union bpf_attr __user *uattr)
+			      union bpf_attr __user *uattr, u32 uattr_size)
 {
 	__u32 __user *prog_attach_flags =3D u64_to_user_ptr(attr->query.prog_atta=
ch_flags);
 	bool effective_query =3D attr->query.query_flags & BPF_F_QUERY_EFFECTIVE;
@@ -1259,7 +1259,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, co=
nst union bpf_attr *attr,
 		return -EFAULT;
 	if (!effective_query && from_atype =3D=3D to_atype)
 		revision =3D cgrp->bpf.revisions[from_atype];
-	if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
+	if (uattr_size >=3D offsetofend(union bpf_attr, query.revision) &&
+	    copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
 		return -EFAULT;
 	if (attr->query.prog_cnt =3D=3D 0 || !prog_ids || !total_cnt)
 		/* return early if user requested only program count + flags */
@@ -1312,12 +1313,12 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
 }
=20
 static int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *att=
r,
-			    union bpf_attr __user *uattr)
+			    union bpf_attr __user *uattr, u32 uattr_size)
 {
 	int ret;
=20
 	cgroup_lock();
-	ret =3D __cgroup_bpf_query(cgrp, attr, uattr);
+	ret =3D __cgroup_bpf_query(cgrp, attr, uattr, uattr_size);
 	cgroup_unlock();
 	return ret;
 }
@@ -1520,7 +1521,7 @@ int cgroup_bpf_link_attach(const union bpf_attr *attr=
, struct bpf_prog *prog)
 }
=20
 int cgroup_bpf_prog_query(const union bpf_attr *attr,
-			  union bpf_attr __user *uattr)
+			  union bpf_attr __user *uattr, u32 uattr_size)
 {
 	struct cgroup *cgrp;
 	int ret;
@@ -1529,7 +1530,7 @@ int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	if (IS_ERR(cgrp))
 		return PTR_ERR(cgrp);
=20
-	ret =3D cgroup_bpf_query(cgrp, attr, uattr);
+	ret =3D cgroup_bpf_query(cgrp, attr, uattr, uattr_size);
=20
 	cgroup_put(cgrp);
 	return ret;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a3c0214ca934..edd6b0dad0d3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4654,7 +4654,7 @@ static int bpf_prog_detach(const union bpf_attr *attr=
)
 #define BPF_PROG_QUERY_LAST_FIELD query.revision
=20
 static int bpf_prog_query(const union bpf_attr *attr,
-			  union bpf_attr __user *uattr)
+			  union bpf_attr __user *uattr, u32 uattr_size)
 {
 	if (!bpf_net_capable())
 		return -EPERM;
@@ -4693,7 +4693,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_CGROUP_GETSOCKOPT:
 	case BPF_CGROUP_SETSOCKOPT:
 	case BPF_LSM_CGROUP:
-		return cgroup_bpf_prog_query(attr, uattr);
+		return cgroup_bpf_prog_query(attr, uattr, uattr_size);
 	case BPF_LIRC_MODE2:
 		return lirc_prog_query(attr, uattr);
 	case BPF_FLOW_DISSECTOR:
@@ -6260,7 +6260,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr=
, unsigned int size)
 		err =3D bpf_prog_detach(&attr);
 		break;
 	case BPF_PROG_QUERY:
-		err =3D bpf_prog_query(&attr, uattr.user);
+		err =3D bpf_prog_query(&attr, uattr.user, size);
 		break;
 	case BPF_PROG_TEST_RUN:
 		err =3D bpf_prog_test_run(&attr, uattr.user);
--=20
2.54.0.823.g6e5bcc1fc9-goog

