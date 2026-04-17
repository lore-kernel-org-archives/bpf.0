Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A603B6364;
	Fri, 17 Apr 2026 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454067; cv=none; b=t+6/GUaTqyqD5Xn2QtnZ9J5fX/BBbv25HK8z9xg9gnvVvIhF7PX5Lmz4C4IrgqZTyBk4ywThoj8mhJ6jHBV1f0kyQlTqTPagtk5AeHcvYbR9X7q7Con44AowaVR/eVZFG3TJVGoknwriguz+oFH4t/Qfz4svhqSNPNLS1f+sTWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454067; c=relaxed/simple;
	bh=z3b+l0nZecB31WMCX1Z5UfQ6kUMIQ5suuXrE0kahHS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkYcFyuZ1gp2srDVribGVQ1ijxkAV4OYNkL6vF7+sJ8Dm6+Z48HitwABi0KjBSc5sYHjcVA0IFuJ7bs3pLGSlUROR5J/OcCnBhOXTQ3CJGgnve1BPFpNN/aqi48wxkxOKPWDYAg1jsI+cy9QZUbs78oDPrO1J8HkqX8bJbM3hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgMPmEs/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgMPmEs/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51E5C19425;
	Fri, 17 Apr 2026 19:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776454066;
	bh=z3b+l0nZecB31WMCX1Z5UfQ6kUMIQ5suuXrE0kahHS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgMPmEs/38+eaTvcokfD9WTDmfVSqm20M70Nux6Ko45/yippFc1VRHFm9LkUPkIlW
	 1cVnEjEsB3FQbXZFhY3/5sUU03uEcaQt6Yb9xVifDQQI84J3xmyvOxKg8VW01LsQhZ
	 /TKiREpGsC4g84Yj3svf9tlMbVSPQBhHZ28t0Z2Fp1htyxh+FROpBdE6KA2o9tmj1H
	 EqNZHBsuq3z3etSRlGte2f3FQqYtteHGuoRLN3E4mrnciZyi4PLz04RLFSu4a0b+E6
	 A1XHSOM/u2re3bjXIEu9OLJMR/oUubjeeqou0FEWiHi54sVU2pQue7eAcmNQSC2hGy
	 g0QrSSatZlf9Q==
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
Subject: [PATCHv5 bpf-next 14/28] bpf: Add support for tracing_multi link cookies
Date: Fri, 17 Apr 2026 21:24:48 +0200
Message-ID: <20260417192502.194548-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417192502.194548-1-jolsa@kernel.org>
References: <20260417192502.194548-1-jolsa@kernel.org>
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
index 37c96daaae9a..e6e859cf64bf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1931,6 +1931,7 @@ struct bpf_tracing_multi_data {
 struct bpf_tracing_multi_link {
 	struct bpf_link link;
 	struct bpf_tracing_multi_data data;
+	u64 *cookies;
 	int nodes_cnt;
 	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9eeffc93faeb..61f124992416 100644
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
index f6180f15d5a4..c0d85befe0f0 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1613,6 +1613,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 
 		mnode->trampoline = tr;
 		mnode->node.link = &link->link;
+		mnode->node.cookie = link->cookies ? link->cookies[i] : 0;
 
 		cond_resched();
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index df06a733a2e7..59b65d3d789f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3616,6 +3616,7 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
+	kvfree(tr_link->cookies);
 	kvfree(tr_link);
 }
 
@@ -3629,6 +3630,8 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	struct bpf_tracing_multi_link *link = NULL;
 	struct bpf_link_primer link_primer;
 	u32 cnt, *ids = NULL;
+	u64 __user *ucookies;
+	u64 *cookies = NULL;
 	u32 __user *uids;
 	int err;
 
@@ -3651,6 +3654,19 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
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
@@ -3665,6 +3681,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		goto error;
 
 	link->nodes_cnt = cnt;
+	link->cookies = cookies;
 
 	err = bpf_trampoline_multi_attach(prog, ids, link);
 	kvfree(ids);
@@ -3675,6 +3692,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	return bpf_link_settle(&link_primer);
 
 error:
+	kvfree(cookies);
 	kvfree(ids);
 	kvfree(link);
 	return err;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9eeffc93faeb..61f124992416 100644
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

