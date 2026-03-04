Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4B19ADB0;
	Wed,  4 Mar 2026 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663016; cv=none; b=ZjcqOkkM1NNKzXy94ZZk0MbctW4tHc6IVbMFIeu9HmxZG1OdhlH0OtIS7JY7H+D9bP3XdLeOV0b3pFcQ/N5VQoyS+FpZ84ecdqMsWS/8CQkZo27ueArF61Xd0ovnzDrMri6e6qQs7YKVJ3Nw/SOLPm+HSDq0/I2NCnWzjpH2YP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663016; c=relaxed/simple;
	bh=6CTuaJiD1ZUilyiqnW6f1ejjbjEX+ncP+NciiLsLH4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOPR52yMEcrAh4Ehtb/VzgNEgYjsr43o/7JfYwit0kveLuDRtHyiE1TQfa1Mg2HDK7n2sJJEL9aRJfzc4vXVN/1iKIma2Pvp0IaczpMZkfwWaiuCY+PMTJp00oi0v6U8/c0x6cwQu66PoUCEfm+gocLyEu+PNjrnv+He8GOF+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJsG7Dwi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJsG7Dwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A316C4CEF7;
	Wed,  4 Mar 2026 22:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663016;
	bh=6CTuaJiD1ZUilyiqnW6f1ejjbjEX+ncP+NciiLsLH4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJsG7Dwi15S7SdnmtYyofmSjKfixYaWgWKl3H17f4yy7YQjRyHE6DpfBW5exkc2LB
	 bThhgxwouc2VlG6EZhm5ggjmjQ34RE7nE4xkmNNrg7+gRLuXA/2ZIB7Gpa6nvHNY0g
	 +OqFGj47GCJsRV9sOYc7mW8rdJ1BDgQ+70rDh/VQUbmFqOCaQFW8RM5S7NUWomQ2Az
	 3W+MfisWYPn+xdcEfFDZS6x6+NTeg2SzWifMrwY+1FTdTTFanghJZtF8EvNDkLi7SN
	 HDRe0MH7jcmiQi8RYDph/gC4INgE8KVYUOS52ZbY+4/pIos107Y2Vc3abDAIxAAv3o
	 +dpP5jG2mQ+UA==
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
Subject: [PATCHv2 bpf-next 10/23] bpf: Add support for tracing_multi link cookies
Date: Wed,  4 Mar 2026 23:21:28 +0100
Message-ID: <20260304222141.497203-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
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
index f22b9400a915..a919143a8b35 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1901,6 +1901,7 @@ struct bpf_tracing_multi_node {
 
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
index c42bf16b6807..1aa723dac209 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1582,6 +1582,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 		mnode = &link->nodes[i];
 		mnode->trampoline = tr;
 		mnode->node.link = &link->link;
+		mnode->node.cookie = link->cookies ? link->cookies[i] : 0;
 	}
 
 	trampoline_lock_all();
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a18aef19c3b5..b8932434e306 100644
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
+	u64 *cookies = NULL;
+	void __user *ucookies;
 	u32 __user *uids;
 	int err;
 
@@ -3645,6 +3648,19 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		goto error;
 	}
 
+	ucookies = u64_to_user_ptr(attr->link_create.tracing_multi.cookies);
+	if (ucookies) {
+		cookies = kvmalloc_array(cnt, sizeof(*cookies), GFP_KERNEL);
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
 	link = kvzalloc(struct_size(link, nodes, cnt), GFP_KERNEL);
 	if (!link) {
 		err = -ENOMEM;
@@ -3659,6 +3675,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		goto error;
 
 	link->nodes_cnt = cnt;
+	link->cookies = cookies;
 
 	err = bpf_trampoline_multi_attach(prog, ids, link);
 	kvfree(ids);
@@ -3669,6 +3686,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
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

