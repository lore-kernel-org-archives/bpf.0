Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F663F5BC2
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001781; cv=none; b=HuOiaObnTJxk4in6AvFjjDUOQfOUZq6iLT1i5gP7gPdm5GSHlEW3RiRbkRG1qf/ljr/f6+En51aCo8Zuhf3qU5RDKFdE9j+5+1dLcitvH13NK5DdeLVxFV0qMAvLEEitroAdrZMnFa1ePj3dXw/oFWqVKk8ieIB7MVQL7HqKzvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001781; c=relaxed/simple;
	bh=WLRpxp2SAdtxHDHMdyxhkBNxEh3bE/rKkEtFQMBL8lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaHnjvT6JebYisqrSGAVEiMLoU77WKRx/hNwy2LNw92FEXEfH+aIov2zHmADoetNoh7k01+N0vV7yNQp6Zps5/GcoNL8Gwx5bP9ZNgN9fEzhEnnLcm85o2TUllzTrPlaUzVXJ8BX5QBzSezk5Jvg5Z29tZSosC4qPy0hhITtqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czHB/zeK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czHB/zeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039891F00893;
	Tue,  9 Jun 2026 10:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781001779;
	bh=fAh3hdP1A8xrtxkFUZoS4arI2XruuHyXfb0IS5zX/Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=czHB/zeK1P1U11HTMsNIk0D2W4QJuzkNx5kav6ww3xCNtZo8DcouxGFCOgIwjHWG2
	 2f8njPjij26M7x/7pxbPaqNuiOFzg8V288rRJCQVqea8+ikJkVYU6gDidR3hADexn7
	 2+KVgB+/LEy1OAfKOIk6BE4hz2YQKwsCtlzHe0fptSdh7iYjV6+k2b+VR90RHzZCvD
	 Adlelyns8OYBt/s0rB6YVyZ531rW8Zc4Vn3ps7UpAvAqI+CVnLOBHAybtEfIGi1eF3
	 IoO3iuDI6XArNtNPdsq7bz6wtzD+ezmgzGUll8IsyyWr1OlpwHL8hIDmACJQvlKf/p
	 CmQCvwih3Ib4w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 1/6] bpf: Use user_path_at for path resolution in uprobe_multi
Date: Tue,  9 Jun 2026 12:42:39 +0200
Message-ID: <20260609104244.588321-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609104244.588321-1-jolsa@kernel.org>
References: <20260609104244.588321-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve the uprobe_multi user path with user_path_at() instead of copying
the string with strndup_user() and passing it to kern_path(). This removes
the temporary allocation and keeps the lookup logic in one helper.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 90432f0fc2a8..970ce7bbf99e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3226,7 +3226,6 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	void __user *upath;
 	u32 flags, cnt, i;
 	struct path path;
-	char *name;
 	pid_t pid;
 	int err;
 
@@ -3261,14 +3260,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
 	ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
 
-	name = strndup_user(upath, PATH_MAX);
-	if (IS_ERR(name)) {
-		err = PTR_ERR(name);
-		return err;
-	}
-
-	err = kern_path(name, LOOKUP_FOLLOW, &path);
-	kfree(name);
+	err = user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
 	if (err)
 		return err;
 
-- 
2.54.0

