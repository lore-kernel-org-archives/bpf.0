Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2114457B6
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620052; cv=none; b=E7NuJv0sQl5pO2FUnC55HlBhkoxgLcpfOOasUjSdSnryHyS/zSH/0xyJAdmcRa474rQ4kaqx7MavErRlbfxzCn/kLSjjX2h1FCEfl51mQ+ybmt5wKVv46cRQZZo2tH3pfClrgIKMhF7+7cFi4Wx7ryTN9sY5N2IyVvcghRL43V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620052; c=relaxed/simple;
	bh=309ZmjVPz5mgkiq/iuAYWpkubWoU29BzNrP5pOfXKDA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IfTNbMcIJ97BagY+ffqgRbOuuWfiZGF0iphGVZ7bXIaBFQqYyO0o56H1lGeJlVMhCfFY2VQTvGA8qFi1fA02+sfhmJQeZ5MDVIgjx2tMJf++vqsWLjy6OoKL4f3ojrrzV6oktlK++sbTYLf+sipnizJ1++SbUtf+GauYnlUybuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDqemULj; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDqemULj"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so814221a12.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786620046; x=1787224846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+DTbEDzNAkDi7a4YLT3tc3XFoipA7stpV5ODIq5bMqk=;
        b=pDqemULjKTwNOUUQJKGFodQIw5Ps12LW8Ck9gNh06Y2uF0Lh6nObcaoNs7nrvh/LK+
         3Bkgp/oIUzMCiaHCz6vA2+h1vAOa4suYrECiEgooKf51MweNdUcn1LoLmk2u25ncyk9v
         eb0GH++jggTVWtj5yCCQj0xEqFzp9SH1MPij2rWcIAt6dJFoMc2m2aJfXesZgr/1hvP0
         C202L33zJRvVkwjHOxltWB31FSM/WcVPoCaVpYviwY3ZP/Z/+ylqUpNRkzvHKT//jUwh
         mcS3oDC/qj4tzehcTLb3ASmfQ2QZwoYxBP7wwyWLi++UdU02KM/sP6RjgppjMRZKK8PP
         vKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786620046; x=1787224846;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+DTbEDzNAkDi7a4YLT3tc3XFoipA7stpV5ODIq5bMqk=;
        b=anEnh413by0bzmvqnM6A+QIg2TOmqzNrczPEABg9qj7y4aGL31oBVQKhmz3PSV0Kf/
         hr2Gd65cap0pqkZmmtET/shMrijGsPdplw5rsXYkZtqBwRtxfl0bcKE6RAemCw6bFMsG
         bXnD7hLnTE1dQIz3NAR0eGED6SjtlvpeXaZLBDKwg12z++x8zXC9SeldGO+CpI0ZbyBV
         h8mMLmMGq0K5DTYnkaq90KVLa3YAWBHLU5A01OXr/gax+kzSm8rsJQOEmq8wzL90gB/d
         7lMEibzO2+gWyXXiU75Qcd1EpSrI2aRhmknyzyQITIpTM/hW3b0Y2Y8PF/GydyEwNZvD
         cAvQ==
X-Forwarded-Encrypted: i=1; AHgh+Roa6GgaTm2p+XuAXfU7vt+gf3apjzMW9PdsgK3DYonEDTPfztp+H/uWpHWOBna0wtjdCfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+46ahO4YLRhgp0HkHjmIBE6D1/f0VSJnsA1rEEdy7x5WMMLO
	BOv3aR9yCfPd9pbfiT50GgPEql7Sr54VtteYGWDoZ0e1Wis+lBWWv28tRZAoT3xkY+cjjzJvdg=
	=
X-Received: from dlep8-n2.prod.google.com ([2002:a05:701b:4588:20b0:141:729:41df])
 (user=maze job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a8f:b0:3c3:a3f4:5485
 with SMTP id adf61e73a8af0-3cc54f9ccddmr6528786637.6.1786620045894; Thu, 13
 Aug 2026 04:20:45 -0700 (PDT)
Date: Thu, 13 Aug 2026 04:20:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813112039.247862-1-maze@google.com>
Subject: [PATCH bpf-next 1/2] bpf: Support cgroup {get,set}sockopt hooks for
 compat syscalls
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, BPF cgroup socket option programs (BPF_PROG_TYPE_CGROUP_SOCKOPT)
are skipped for 32-bit compat tasks on 64-bit kernels via explicit
!compat checks in do_sock_setsockopt() and do_sock_getsockopt().

While this originally avoided issues with programs assuming native 64-bit
sockopt structure layouts, completely bypassing BPF sockopt hooks allows
32-bit binaries to bypass cgroup network policies and prevents BPF
programs from managing sockopts for compat applications.

Enable BPF cgroup sockopt hooks for compat syscalls by:
1. Adding a read-only `is_compat` field to `struct bpf_sockopt` (and
   `struct bpf_sockopt_kern`) which is 1 for compat syscalls and 0
   otherwise.
2. Passing the `compat` parameter through BPF_CGROUP_RUN_PROG_SETSOCKOPT
   and BPF_CGROUP_RUN_PROG_GETSOCKOPT to populate `ctx.is_compat`.
3. Removing the `!compat` guards in do_sock_setsockopt() and
   do_sock_getsockopt().

BPF programs can now inspect `ctx->is_compat` to handle any 32-bit vs
64-bit layout differences for the very rare cases where it is needed.

Behavioral Note for BPF Programs:
  Previously, compat sockopt calls were completely invisible to BPF.
  Now, attached BPF sockopt programs will run on compat calls.
  For options with arch-dependent structures (e.g. SO_RCVTIMEO with 32-bit
  vs 64-bit struct timeval), BPF programs must now check ctx->is_compat to
  correctly parse/modify the buffer.
  Due to 32-bit userspace being near dead and there being very few such
  options that one would want to overwrite in eBpf, I'm judging this to
  be acceptable (there's probably very few programs that would be affected)=
.

Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 include/linux/bpf-cgroup.h | 35 ++++++++++++++++++-----------------
 include/linux/filter.h     |  1 +
 include/uapi/linux/bpf.h   |  1 +
 kernel/bpf/cgroup.c        |  9 +++++++--
 net/socket.c               | 17 +++++++----------
 5 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 4d0cc65976a1..943eb023b52b 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -138,14 +138,15 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_h=
eader *head,
 				   char **buf, size_t *pcount, loff_t *ppos,
 				   enum cgroup_bpf_attach_type atype);
=20
-int __cgroup_bpf_run_filter_setsockopt(struct sock *sock, int *level,
-				       int *optname, sockptr_t optval,
-				       int *optlen, char **kernel_optval);
+int __cgroup_bpf_run_filter_setsockopt(struct sock *sock, bool compat,
+				       int *level, int *optname,
+				       sockptr_t optval, int *optlen,
+				       char **kernel_optval);
=20
-int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
-				       int optname, sockptr_t optval,
-				       sockptr_t optlen, int max_optlen,
-				       int retval);
+int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, bool compat,
+				       int level, int optname,
+				       sockptr_t optval, sockptr_t optlen,
+				       int max_optlen, int retval);
=20
 int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 					    int optname, void *optval,
@@ -376,21 +377,21 @@ static inline bool cgroup_bpf_sock_enabled(struct soc=
k *sk,
 	__ret;								       \
 })
=20
-#define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optle=
n,   \
-				       kernel_optval)			       \
+#define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, compat, level, optname, optva=
l,   \
+				       optlen, kernel_optval)		       \
 ({									       \
 	int __ret =3D 0;							       \
 	if (cgroup_bpf_enabled(CGROUP_SETSOCKOPT) &&			       \
 	    cgroup_bpf_sock_enabled(sock, CGROUP_SETSOCKOPT))		       \
-		__ret =3D __cgroup_bpf_run_filter_setsockopt(sock, level,	       \
-							   optname, optval,    \
-							   optlen,	       \
+		__ret =3D __cgroup_bpf_run_filter_setsockopt(sock, compat,       \
+							   level, optname,     \
+							   optval, optlen,     \
 							   kernel_optval);     \
 	__ret;								       \
 })
=20
-#define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, optle=
n,   \
-				       max_optlen, retval)		       \
+#define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, compat, level, optname, optva=
l,   \
+				       optlen, max_optlen, retval)	       \
 ({									       \
 	int __ret =3D retval;						       \
 	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&			       \
@@ -400,7 +401,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock =
*sk,
 					tcp_bpf_bypass_getsockopt,	       \
 					level, optname))		       \
 			__ret =3D __cgroup_bpf_run_filter_getsockopt(	       \
-				sock, level, optname, optval, optlen,	       \
+				sock, compat, level, optname, optval, optlen,  \
 				max_optlen, retval);			       \
 	__ret;								       \
 })
@@ -504,11 +505,11 @@ static inline int bpf_percpu_cgroup_storage_update(st=
ruct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ =
0; })
 #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; }=
)
-#define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, \
+#define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, compat, level, optname, optva=
l, \
 				       optlen, max_optlen, retval) ({ retval; })
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sock, level, optname, optval, =
\
 					    optlen, retval) ({ retval; })
-#define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optle=
n, \
+#define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, compat, level, optname, optva=
l, optlen, \
 				       kernel_optval) ({ 0; })
=20
 #endif /* CONFIG_CGROUP_BPF */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4a9bc6a848f2..5ab7d606aea5 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1702,6 +1702,7 @@ struct bpf_sockopt_kern {
 	s32		level;
 	s32		optname;
 	s32		optlen;
+	s32		is_compat;
 	/* for retval in struct bpf_cg_run_ctx */
 	struct task_struct *current_task;
 	/* Temporary "register" for indirect stores to ppos. */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ffd96e8b920b..15f712b5b164 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7616,6 +7616,7 @@ struct bpf_sockopt {
 	__s32	optname;
 	__s32	optlen;
 	__s32	retval;
+	__s32	is_compat;
 };
=20
 struct bpf_pidns_info {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8fbc942a1cc3..910878e991a0 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2055,7 +2055,7 @@ static bool sockopt_buf_allocated(struct bpf_sockopt_=
kern *ctx,
 	return ctx->optval !=3D buf->data;
 }
=20
-int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
+int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, bool compat, int *=
level,
 				       int *optname, sockptr_t optval,
 				       int *optlen, char **kernel_optval)
 {
@@ -2065,6 +2065,7 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *s=
k, int *level,
 		.sk =3D sk,
 		.level =3D *level,
 		.optname =3D *optname,
+		.is_compat =3D compat,
 	};
 	int ret, max_optlen;
=20
@@ -2146,7 +2147,7 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *s=
k, int *level,
 	return ret;
 }
=20
-int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
+int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, bool compat, int l=
evel,
 				       int optname, sockptr_t optval,
 				       sockptr_t optlen, int max_optlen,
 				       int retval)
@@ -2157,6 +2158,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *s=
k, int level,
 		.sk =3D sk,
 		.level =3D level,
 		.optname =3D optname,
+		.is_compat =3D compat,
 		.current_task =3D current,
 	};
 	int orig_optlen;
@@ -2705,6 +2707,9 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_acc=
ess_type type,
 		else
 			*insn++ =3D CG_SOCKOPT_READ_FIELD(optlen);
 		break;
+	case offsetof(struct bpf_sockopt, is_compat):
+		*insn++ =3D CG_SOCKOPT_READ_FIELD(is_compat);
+		break;
 	case offsetof(struct bpf_sockopt, retval):
 		BUILD_BUG_ON(offsetof(struct bpf_cg_run_ctx, run_ctx) !=3D 0);
=20
diff --git a/net/socket.c b/net/socket.c
index 63c69a0fa74e..f4549975f98b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2346,10 +2346,9 @@ int do_sock_setsockopt(struct socket *sock, bool com=
pat, int level,
 	if (err)
 		goto out_put;
=20
-	if (!compat)
-		err =3D BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, &level, &optname,
-						     optval, &optlen,
-						     &kernel_optval);
+	err =3D BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, compat, &level, &optname=
,
+					     optval, &optlen,
+					     &kernel_optval);
 	if (err < 0)
 		goto out_put;
 	if (err > 0) {
@@ -2447,8 +2446,7 @@ int do_sock_getsockopt(struct socket *sock, bool comp=
at, int level,
 	if (err)
 		return err;
=20
-	if (!compat)
-		copy_from_sockptr(&max_optlen, optlen, sizeof(int));
+	copy_from_sockptr(&max_optlen, optlen, sizeof(int));
=20
 	ops =3D READ_ONCE(sock->ops);
 	if (level =3D=3D SOL_SOCKET) {
@@ -2477,10 +2475,9 @@ int do_sock_getsockopt(struct socket *sock, bool com=
pat, int level,
 		err =3D -EOPNOTSUPP;
 	}
=20
-	if (!compat)
-		err =3D BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
-						     optval, optlen, max_optlen,
-						     err);
+	err =3D BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, compat, level, optname,
+					     optval, optlen, max_optlen,
+					     err);
=20
 	return err;
 }
--=20
2.55.0.691.gc56d675ccc-goog

