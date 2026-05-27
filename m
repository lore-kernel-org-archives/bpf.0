Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF93F0761;
	Wed, 27 May 2026 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882153; cv=none; b=GIVqYuXmkE5MUpU0+jTgcECH1u0ZwTq/gSNa3dJmbNgHfndPrQ6VepD4G/pl7p7xT+KCtnA9dtIy9d2ddGgD8YTdPM7MC5BHoYzrLLPJ8fk/XlGk5BnxRNhDmxLtxpzNjPmMzD0H+C1lQHDHHAJU60OFov+V495PnbOFK2WQ0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882153; c=relaxed/simple;
	bh=8EThdworY8pZNmeokJJjPqlExmja2MmTz9le5RRr4G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KegdRZbN4mnu7+thC3SRkIOWEtmYnDdWbOSzUIpjHqIdTRyjyjp+mdQcghfBgSp5+m2Qjqq57OT09pT10BUozwZF/VSzcb42cTDKX9hj5/HJlSxCV4p0hEFmltlw33B9/UkXxbor622qv+NlfZRrjcEYdut9YlQnUh/i265U3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5kG2dOx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5kG2dOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687271F00A3A;
	Wed, 27 May 2026 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882150;
	bh=GyPBhBrJDtBJH0uIIzXfsk8eBGPocOS2VQuaPZsdaCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d5kG2dOx8Y0U+AKYztsGqwQWnoGlkHNOWKxAimnIe9+SEM0/qwCXYB6JDN9n8mAkB
	 XGCqYBHx/OhkHqu0MALIL3cKWS/UiQ7pPgyCfyQlEL6DqN9Vq3tctcp2zDBQmngrHS
	 gRG+6swbvI2rNb//gA+3EVS9T2Ok2zOBmwK/jm1/NsgV/KLS8DMZPZflvKZuWqulLR
	 OgcCQe9Rcg6s9hkAnXydoX27CuGVSHFO1mEIS44s0EOZQ/nHa9Fv0WwjmYNtwRrypR
	 VQ6ldrJnuwHqU0qb127eaUOey5VAqPRz9StMLBT83SCosmgKyr8QEtRweR/VZLtbBs
	 mQyr0Mt4+r7eg==
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
Subject: [PATCHv6 bpf-next 14/29] bpf: Add support for tracing_multi link cookies
Date: Wed, 27 May 2026 13:39:36 +0200
Message-ID: <20260527113951.46265-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527113951.46265-1-jolsa@kernel.org>
References: <20260527113951.46265-1-jolsa@kernel.org>
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
index 93a94669ca90..03d4ce0ef93e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1951,6 +1951,7 @@ struct bpf_tracing_multi_data {
 struct bpf_tracing_multi_link {
 	struct bpf_link link;
 	struct bpf_tracing_multi_data data;
+	u64 *cookies;
 	int nodes_cnt;
 	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 951a0122baaf..39407a77133b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1874,6 +1874,7 @@ union bpf_attr {
 			} cgroup;
 			struct {
 				__aligned_u64	ids;
+				__aligned_u64	cookies;
 				__u32		cnt;
 			} tracing_multi;
 		};
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 476b7db3a809..acccf52f6792 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1613,6 +1613,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 
 		mnode->trampoline = tr;
 		mnode->node.link = &link->link;
+		mnode->node.cookie = link->cookies ? link->cookies[i] : 0;
 
 		cond_resched();
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7cf22d69a1e1..6639751fab08 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3659,6 +3659,7 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
+	kvfree(tr_link->cookies);
 	kvfree(tr_link);
 }
 
@@ -3701,6 +3702,8 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	struct bpf_tracing_multi_link *link = NULL;
 	struct bpf_link_primer link_primer;
 	u32 cnt, *ids = NULL;
+	u64 __user *ucookies;
+	u64 *cookies = NULL;
 	u32 __user *uids;
 	int err;
 
@@ -3727,6 +3730,19 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	if (err)
 		goto error;
 
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
@@ -3741,6 +3757,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		goto error;
 
 	link->nodes_cnt = cnt;
+	link->cookies = cookies;
 
 	err = bpf_trampoline_multi_attach(prog, ids, link);
 	kvfree(ids);
@@ -3751,6 +3768,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	return bpf_link_settle(&link_primer);
 
 error:
+	kvfree(cookies);
 	kvfree(ids);
 	kvfree(link);
 	return err;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 951a0122baaf..39407a77133b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1874,6 +1874,7 @@ union bpf_attr {
 			} cgroup;
 			struct {
 				__aligned_u64	ids;
+				__aligned_u64	cookies;
 				__u32		cnt;
 			} tracing_multi;
 		};
-- 
2.54.0

