Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620802;
	b=hETU2fE/J6T1/tqAPiilK+pMqM2ho65tbYp8ZyzNmGBAn8qVqc2LDPoze9Vvoi1B534m
	 jPjBXBKjP8bdGErEKjgWDVob+hflRjFuepIuAj4IMeOkdD9e4reraIIEqqwMPP7K1Vqt+
	 qS6ZnbUFaz23vfWrwaFmtsMZc4XSKxCfGYohAf8dTqi41XCmkXK6Z+KdX/lSujMojwVkJ
	 7+gKFUyFLm/+aV1XDEbQKZF1eohtWBY6ye1YSXZgDsYjJ2ShihxtzdYNwt2AjUdWYq690
	 vsPnUpZpVuDBAO8GbIu5v6XTRcLg7A6CanQ91qfNMKoN3YkmR/cv05c50Ji8QoWf3GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620802;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=Jw0Zc1KniHa5V/wsDV8IErYtkkiDqvdTbI8JpEzye8M=;
	b=YKzXd7EAj0tMoQA9MYt8oNpQzurM4K8Q5nCx0G0pcIcO6IW76g8+NHhyHKHbZUtLDa9C
	 M/DEpjbChjumq/fPC5E92zm8HarLpvkcBJ9oB6W+tGjz/+HpX8Y6F171gWso+lTZCCfqQ
	 uabFcmutek3gvnueND5ndxZdGg7RwmDk/9yKpSuZx6eUxYax0oBxCJDq+UfXi38XmxSr+
	 7TUYodGr/k1JuF8XTqBe38cVSCN85Drp4DqcZrlLQhnoUUy4Ube5Km8J07fsSTdaLZGwm
	 RIkS7NLQazL3P5mKsxF5EVizHzMJNjWWC2HMZK52IcxyMP0HfSQhlrnD4AbhJdaQfSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=S550l6P1;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728CB606A32E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 15:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 728CB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=S550l6P1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795620791; bh=TT/FqEfb3cOl2EftQEceU2ScT8twZOYPX+pkyx9OgRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S550l6P1i7Sa9HR17MFHqMbUNQmDRmg+3GNptEUS2R2xIxY8p6r84tCarTHebQLLE
	 YQV3qQTUGx+Dg1LnQP8nCHr6nyLt+55wfYhIFMHMhn4bmVDP8S3GDrUrsaWddCk0nj
	 EWQRR9IQz0e7S5FR+TgQeaAhvGK/T4Upzy2rtoACD/MafJjVxjdejg2S7wIpw9Udzn
	 zc/Fe71NXrH16kk8F3x1lVPAynxU9/U4xPu6Tu80njCZ1KPHCVeq1dKYU/pEvozqYG
	 k914jLCYOFDQL10JkFmyCWD110D1cyLKOeLE9Eun31k6US1N4mBxM4ff66LyV0XNYJ
	 vHJKl/UM9nSQg==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Wed, 25 Nov 2026 16:31:52 +0100
Subject: [PATCH bpf-next 1/7] bpf: Relax BPF_*_GET_NEXT_ID permission
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
Message-Id: <20261125-bpf-relax-get-next-id-v1-1-49175227c8cf@toke.dk>
References: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
In-Reply-To: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
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

