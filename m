Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699271;
	b=At0+ftdw5p6uVCqYgDibaXbFIT3FrJWhJa270jA6mTzxxMadLKbS7znQnccSD+odq+yr
	 J+f2ASbz6+HQC22OZAYE7WkFgkWH7HU/UxMxdVQfztBrLMebTomGZLKec5jjop0haBxpz
	 zQTpKdyXvKCyz+l8EzTdqJckpnSxhKQ8Mdzv3WxJsx3tVD13y2aJbeFE2xcRT3BLMH0xW
	 yfwKsJhAUOcmELfE9vNMtK+aCAE58TQFbJus30Cuj6Hta6wU+c4/zlU1D7wfQt1WY+rzy
	 xAfYpRjraOvgl4HyLaSGXUrCTdGbKA/PhPGD6kL+pMtBZLQ8eMdHbLzin5vFb+Q28FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699271;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=Jw0Zc1KniHa5V/wsDV8IErYtkkiDqvdTbI8JpEzye8M=;
	b=Woau4cYWp5k1M/1tBu2evXEXDAa9AxpcBY1Vupi609hvbLkcHRbCSfPJ4fQ5GdqxuRV+
	 ctSSUD9debnAsGcSOftUTg8v7sVV3RcgKw0Y/YJWFGSpwvbJMYYjhX9sCVcudFNM5uM/2
	 TVphCxjpzHiZMdBaJgYddSUDabuHw7JfNeM+nbvPnxY7EdabhOGeLhOgMzDidNX/y1Rft
	 baWuVk79ZXz2mMyMAvcnVPAZAxmslB0PAIqGDXzNiUIn1UbzNrZ34w1eUeinTFeOFPeOP
	 zliHWr5sjL8I9g/rYJvYqWo5Ase5sonjinEGO7AbN6IsQsg4a5P9tmm1H9TJ6IVSvgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b="c/5MnqIL";
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8DB606A682
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D8DB606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=c/5MnqIL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795699267; bh=TT/FqEfb3cOl2EftQEceU2ScT8twZOYPX+pkyx9OgRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c/5MnqIL40hWZ6ammeCtyn3BU5T6if0NPln5KXccERCGUVfxIMMgJYD/oNmojg9Qw
	 wWrqWieOM69y8BDFOQV8c8XmaJ3zPE7Pevc8N1+FSdil+BBiuK3be9+w3ytKrmj2qw
	 e25Em74bSmIVLBpbqgqweDVWX6ByHTF6R0O4aeaBJdlF7m6Jy+O6iM5Lfznin0tHlu
	 4fz6ycjWuc2VjBNAgteNfsK0/CfOCd+t6v4JARn2vLJP5xbdBCM2bfLR6rPVio++gd
	 lqyXLG9mR6Nr2tYL6qUsj871DOCfNTlgh+vyniJ3mGYmKPmA/SrRqgYGElPY036GoL
	 0B9rYrz7EMdQg==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 14:20:59 +0100
Subject: [PATCH bpf-next v2 1/7] bpf: Relax BPF_*_GET_NEXT_ID permission
 checks to CAP_BPF and bpf_token
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-bpf-relax-get-next-id-v2-1-039e92757f9c@toke.dk>
References: <20261126-bpf-relax-get-next-id-v2-0-039e92757f9c@toke.dk>
In-Reply-To: <20261126-bpf-relax-get-next-id-v2-0-039e92757f9c@toke.dk>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>

The BPF_*_GET_NEXT_ID commands are currently restricted to system-wide
CAP_SYS_ADMIN, but iterating the objects themselves is not actually an
administrator-only operation, so this seems overly restrictive.

In particular, being able to walk the BTF IDs is necessary for libbpf to
attach to functions in modules. So the CAP_SYS_ADMIN restriction
prevents some BPF applications from working with permissions delegated
by a bpf_token.

Relax the permission check in bpf_obj_get_next_id() to
token_capable(CAP_BPF). There is no change to the operations that turn
the IDs into file descriptors (BPF_*_GET_FD_BY_ID commands).

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 include/uapi/linux/bpf.h       |  5 ++++-
 kernel/bpf/syscall.c           | 33 ++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h |  5 ++++-
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 62de0919db72..cdc313f9ab14 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1786,7 +1786,10 @@ union bpf_attr {
 		};
 		__u32		next_id;
 		__u32		open_flags;
-		__s32		fd_by_id_token_fd;
+		union {
+			__s32		fd_by_id_token_fd;
+			__s32		get_next_id_token_fd;
+		};
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ec8e78792911..1440c10ea0cc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4872,21 +4872,40 @@ static int bpf_prog_test_run(const union bpf_attr *attr,
 	return ret;
 }
 
-#define BPF_OBJ_GET_NEXT_ID_LAST_FIELD next_id
+#define BPF_OBJ_GET_NEXT_ID_LAST_FIELD get_next_id_token_fd
 
-static int bpf_obj_get_next_id(const union bpf_attr *attr,
+static int bpf_obj_get_next_id(enum bpf_cmd cmd,
+			       const union bpf_attr *attr,
 			       union bpf_attr __user *uattr,
 			       struct idr *idr,
 			       spinlock_t *lock)
 {
+	struct bpf_token *token = NULL;
 	u32 next_id = attr->start_id;
 	int err = 0;
 
 	if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >= INT_MAX)
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (attr->open_flags & ~BPF_F_TOKEN_FD)
+		return -EINVAL;
+
+	if (attr->open_flags & BPF_F_TOKEN_FD) {
+		token = bpf_token_get_from_fd(attr->fd_by_id_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		if (!bpf_token_allow_cmd(token, cmd)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	if (!bpf_token_capable(token, CAP_BPF)) {
+		bpf_token_put(token);
 		return -EPERM;
+	}
+
+	bpf_token_put(token);
 
 	next_id++;
 	spin_lock_bh(lock);
@@ -6523,15 +6542,15 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_prog_test_run(&attr, uattr.user);
 		break;
 	case BPF_PROG_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr.user,
+		err = bpf_obj_get_next_id(cmd, &attr, uattr.user,
 					  &prog_idr, &prog_idr_lock);
 		break;
 	case BPF_MAP_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr.user,
+		err = bpf_obj_get_next_id(cmd, &attr, uattr.user,
 					  &map_idr, &map_idr_lock);
 		break;
 	case BPF_BTF_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr.user,
+		err = bpf_obj_get_next_id(cmd, &attr, uattr.user,
 					  &btf_idr, &btf_idr_lock);
 		break;
 	case BPF_PROG_GET_FD_BY_ID:
@@ -6586,7 +6605,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_link_get_fd_by_id(&attr);
 		break;
 	case BPF_LINK_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr.user,
+		err = bpf_obj_get_next_id(cmd, &attr, uattr.user,
 					  &link_idr, &link_idr_lock);
 		break;
 	case BPF_ENABLE_STATS:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 62de0919db72..cdc313f9ab14 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1786,7 +1786,10 @@ union bpf_attr {
 		};
 		__u32		next_id;
 		__u32		open_flags;
-		__s32		fd_by_id_token_fd;
+		union {
+			__s32		fd_by_id_token_fd;
+			__s32		get_next_id_token_fd;
+		};
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */

-- 
2.56.1

