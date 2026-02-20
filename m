Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C87322DB7;
	Fri, 20 Feb 2026 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582141; cv=none; b=TxYLlRyiwT9kUAk4v5UcgQM15DF/KZRkPrFio2YvNVLn9EbuDckI8c+/3tXeCQlc3X34Flzwn0Ysvd+8sLUY9emSk6tjIlOOLx+UZBuCevJnXeiQRTN8bN388hRs7JfqU43ef8uhqeT0oiX90kK6zDA+yLdH1T1JvRzNw+1EnAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582141; c=relaxed/simple;
	bh=KwtlRCVwRv3IHTHOpXPlSKKATA0NlSUY5if4AHZJUo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNhyRSDd9CPWOQopuFD+WySgvN3udmkS0RMOhPcQsf0VxPwZJAdSWKiP41RYR3SrvVWIvhIBXAUYP5TWKeI4hFjBSx7klXW/C2yIuThU6ABuPqHZ9Udug1DtnWg1ScbJ5pG4CYj2pAPt5BTTHaIkuJeiCEGzywnhgXCs/pt7kiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvPcEI9f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvPcEI9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6B9C116C6;
	Fri, 20 Feb 2026 10:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582141;
	bh=KwtlRCVwRv3IHTHOpXPlSKKATA0NlSUY5if4AHZJUo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvPcEI9fH/YVwqeekZF54TbvcyGXPP8jLavjkuIdumMZ44G/0z2St634C1bEOUZNL
	 wJcICezju4pHT+YcWlZZqugTjUSHHHWTQupXvYcTi1wRMzs/8yO5wwp1pmm1kT1CUz
	 0UmnR0z9fcPTBg8W5T2v0ZH4n+nR75rKLkWw/aQSS4MfJkqPIpmZyTD9txqyzoGcfL
	 PAmL6g/+gt7Z7g+QhXSEuCkRhbHkASm3hEUWFFR1UJAN6FsZL/CybHckRVuIkoAh1g
	 zGtiUek9zL/+orTEa4bbuiy8kDa8c36Uy9h5gGD+i4/6nbDci3PhpV9EGWBMuUriJP
	 icUxWeeWxnO2w==
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
Subject: [PATCH bpf-next 09/17] bpf: Add support for tracing_multi link cookies
Date: Fri, 20 Feb 2026 11:06:41 +0100
Message-ID: <20260220100649.628307-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220100649.628307-1-jolsa@kernel.org>
References: <20260220100649.628307-1-jolsa@kernel.org>
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
index 00585693d31a..63a06c85103b 100644
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
index c32205adfebe..516c27b89701 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1546,6 +1546,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 
 		mnode->trampoline = tr;
 		mnode->node.link = &link->link;
+		mnode->node.cookie = link->cookies ? link->cookies[i] : 0;
 	}
 
 	trampoline_lock_all();
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bfae9ec5d1b1..927fa622c5ea 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3609,6 +3609,7 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
+	kvfree(tr_link->cookies);
 	kfree(tr_link);
 }
 
@@ -3622,6 +3623,8 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	struct bpf_tracing_multi_link *link = NULL;
 	struct bpf_link_primer link_primer;
 	u32 cnt, *ids = NULL;
+	u64 *cookies = NULL;
+	void __user *ucookies;
 	u32 __user *uids;
 	int err;
 
@@ -3642,6 +3645,19 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
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
 	link = kzalloc(struct_size(link, nodes, cnt), GFP_KERNEL);
 	if (!link) {
 		err = -ENOMEM;
@@ -3656,6 +3672,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		goto error;
 
 	link->nodes_cnt = cnt;
+	link->cookies = cookies;
 
 	err = bpf_trampoline_multi_attach(prog, ids, link);
 	kvfree(ids);
@@ -3666,6 +3683,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	return bpf_link_settle(&link_primer);
 
 error:
+	kvfree(cookies);
 	kvfree(ids);
 	kfree(link);
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
2.52.0

