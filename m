Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A5F3DE43D
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001829; cv=none; b=lqzp3D4xmbf4JTa0TGaF2FG0T9WJQB5suwXKeWj3fqfs5Bs6dDczSVa1ZmO1KPjt+YRkrzCU6vH3u7DMDLEQ3Rnfb98kUOHquV3+Pn1pD5bglI5QeJifV+Ir38nXIuRfWlhZZgG5vMuOHeYPpGdeqI8Far3c18i6GiMcpdOTgMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001829; c=relaxed/simple;
	bh=ORq7DarFv5ZgnM/ud7SEGpM3teVE/ke2NqVN3y1Y+dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL0XPWcpLmliWOffnPvzhi4n24vY56PKLXt6iTv7kbFwx4nfLic21gaQZBqT8cxuF1fWz9e2DUokwjK+tHGyw+LtWF6JFdRd3P6TysOAJGOblh5D8vLrTBiaiyM2y7loqUXGqP7OoOnNRYhw1ivSw4D650k/8I+tSTMM3aJ2GrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4+1u7uL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4+1u7uL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715F11F00893;
	Tue,  9 Jun 2026 10:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781001828;
	bh=Nn/qQowSlpSjtEFjyDl6VJygQJqh6tZT7OeMansn/Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4+1u7uLJwbHAjhUyGjsvDzX0+MLW5ZTlruy+KWLc88ssyP1I0WqDrwK2mFC6V4rt
	 RDXmzgU4lsNEMykCzS5I2fkFoS40+K/zJ2K5r1cD8OO9OWGlCqYrSFUzcBVZzGKXYl
	 B4ON3TXM1Ca/k8uYAqk4ogBAIlcwbTHPVkSoPcOueEmAgQhZyg+8TGiOiuXlChlvRc
	 4FkfXBq29BR6ZT8hlR8KGXkRNYcvqVgBxnchy8sSkK6AB6yojeXKHogI5Le7WLFerr
	 t8x0+2xk3s6OFH9gtzpBal8b0uifxJ+rYJxF+h8O0ADJOcdNxvpq2LCKnNgS3dxX1s
	 b7ZcG/qNZBSXA==
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
Subject: [PATCH bpf-next 6/6] selftests/bpf: Fix typo in verify_umulti_link_info
Date: Tue,  9 Jun 2026 12:42:44 +0200
Message-ID: <20260609104244.588321-7-jolsa@kernel.org>
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

We verify info.uprobe_multi.flags against wrong kprobe-multi flag
(BPF_F_KPROBE_MULTI_RETURN). It's the same value as the correct
flag (BPF_F_UPROBE_MULTI_RETURN), so there's not functional change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index e40114620751..f589eefbf9fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -469,7 +469,7 @@ verify_umulti_link_info(int fd, bool retprobe, __u64 *offsets,
 
 		ASSERT_EQ(info.uprobe_multi.pid, getpid(), "info.uprobe_multi.pid");
 		ASSERT_EQ(info.uprobe_multi.count, 3, "info.uprobe_multi.count");
-		ASSERT_EQ(info.uprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN,
+		ASSERT_EQ(info.uprobe_multi.flags & BPF_F_UPROBE_MULTI_RETURN,
 			  retprobe, "info.uprobe_multi.flags.retprobe");
 		ASSERT_EQ(info.uprobe_multi.path_size, strlen(path) + 1, "info.uprobe_multi.path_size");
 		ASSERT_STREQ(path_buf, path, "info.uprobe_multi.path");
-- 
2.54.0

