Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4D32B9A8;
	Tue, 24 Mar 2026 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340451; cv=none; b=glRgj5VIS6oydgM1K+MoNMmGeQjNagnt72unZXNi7AJ95dpBDqpD4zjCwMDlW9udUFL1tQ3ngKzecnEiVuGJmNtC4RCVYqfhlDlNyuNROh7K+k7rPAsyM5HmClfb60XMJKZPcIAZ1+O0O4fesQFTldqAnEQ6GH7h2DehhGzm3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340451; c=relaxed/simple;
	bh=eX77jaO29+JUXlUPt66u5QwN8mHqh0p/NC+iu6vXfMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlrPEhcz8jhdSRN0Maba104G9s4XZ5Dki91fQUqYKqBhVpODDs+CaDKGtd4XyWE0+ShtlQQrGLHxLMq3o1YpoqO+qLKp+nP54SPPmmGuTYJOmjDuUdvZjoaydEPwM6oVnA4svqRoSFx6Uq09P3fK06UyDiiwXmm75Wee8qUE+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhroHQLc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhroHQLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24555C19424;
	Tue, 24 Mar 2026 08:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340451;
	bh=eX77jaO29+JUXlUPt66u5QwN8mHqh0p/NC+iu6vXfMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhroHQLcnSq1NmvAoYnyB9YTDgrS/9gzHy9rAsYJOLEMe/yAa3QihK7315g7xT2fm
	 X1Dvdam69OkzA9XlvQAxdZIJw+j0WoojCt3B7qb8ty3hLNIxWUB3OfcHjkXcfr8tP2
	 a1EC7wmGtYCBVv9KUKypOJ3S+AaPIV9D0qtLVTB4EkFWk3sH35zY26x0wGHS2ilHC9
	 9uNwkLCl+ec8ABQVCrcqlIpuKqvsZ0Ga2aRLL313yTLbqOdbwYRc819NOc21d/bgTE
	 nplqFs5zjJ3Q+YsSvf5lB6XPGXBD7X2ovImJLQMtVUvuVePihb/RKxOL/WZ1EgR/1O
	 dLX793+jHpxTw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv4 bpf-next 11/25] bpf: Add support for tracing_multi link cookies
Date: Tue, 24 Mar 2026 09:18:32 +0100
Message-ID: <20260324081846.2334094-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324081846.2334094-1-jolsa@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to specify cookies for tracing_multi link.

Cookies are provided in array where each value is paired with provided
BTF ID value with the same array index.

Such cookie can be retrieved by bpf program with bpf_get_attach_cookie
helper call.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/trampoline.c        |  1 +
 kernel/trace/bpf_trace.c       | 18 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 5 files changed, 22 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 113c9eb7a207..4a501eb12951 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1912,6 +1912,7 @@ struct bpf_tracing_multi_node {
 
 struct bpf_tracing_multi_link {
 	struct bpf_link link;
+	u64 *cookies;
 	int nodes_cnt;
 	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7f5c51f27a36..e28722ddeb5b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1866,6 +1866,7 @@ union bpf_attr {
 			} cgroup;
 			struct {
 				__aligned_u64	ids;
+				__aligned_u64	cookies;
 				__u32		cnt;
 			} tracing_multi;
 		};
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 2986e5cac743..85a3b8c340e0 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1580,6 +1580,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 		mnode = &link->nodes[i];
 		mnode->trampoline = tr;
 		mnode->node.link = &link->link;
+		mnode->node.cookie = link->cookies ? link->cookies[i] : 0;
 	}
 
 	trampoline_lock_all();
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4a92d47d1eaf..5e3ff9ffc0ab 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3612,6 +3612,7 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
+	kvfree(tr_link->cookies);
 	kvfree(tr_link);
 }
 
@@ -3625,6 +3626,8 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	struct bpf_tracing_multi_link *link = NULL;
 	struct bpf_link_primer link_primer;
 	u32 cnt, *ids = NULL;
+	u64 __user *ucookies;
+	u64 *cookies = NULL;
 	u32 __user *uids;
 	int err;
 
@@ -3647,6 +3650,19 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		goto error;
 	}
 
+	ucookies = u64_to_user_ptr(attr->link_create.tracing_multi.cookies);
+	if (ucookies) {
+		cookies = kvmalloc_objs(*cookies, cnt);
+		if (!cookies) {
+			err = -ENOMEM;
+			goto error;
+		}
+		if (copy_from_user(cookies, ucookies, cnt * sizeof(*cookies))) {
+			err = -EFAULT;
+			goto error;
+		}
+	}
+
 	link = kvzalloc_flex(*link, nodes, cnt);
 	if (!link) {
 		err = -ENOMEM;
@@ -3661,6 +3677,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		goto error;
 
 	link->nodes_cnt = cnt;
+	link->cookies = cookies;
 
 	err = bpf_trampoline_multi_attach(prog, ids, link);
 	kvfree(ids);
@@ -3671,6 +3688,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	return bpf_link_settle(&link_primer);
 
 error:
+	kvfree(cookies);
 	kvfree(ids);
 	kvfree(link);
 	return err;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7f5c51f27a36..e28722ddeb5b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1866,6 +1866,7 @@ union bpf_attr {
 			} cgroup;
 			struct {
 				__aligned_u64	ids;
+				__aligned_u64	cookies;
 				__u32		cnt;
 			} tracing_multi;
 		};
-- 
2.53.0

