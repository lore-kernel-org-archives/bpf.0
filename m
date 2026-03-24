Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934423C39A;
	Tue, 24 Mar 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340360; cv=none; b=NlaexeZBDbLAjXAW9Zqq+3aOkP8wIUtCHI2IkHL0nNFKO2aU3ytxj+uBFr0wCGm2fwd88t1CdJcvi1uimL+0ZYPBcG6nZl2flF0ZK2NnGP/HkWeqQGVnBAywynsXVhF6rH/sV0R48buN5EujXD4oZlmb9HiX4poAq3OvVHpth8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340360; c=relaxed/simple;
	bh=7+78+WPcY39DLO9p5hS3KIHY1sZDHwtT+k3et2rpFls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2wua9Sc/4zru0eEzrufwmtAxfl7cACSRuAysZ5ZDKfZWmwcecbIErJoaOiqZT+3fNdqBP7TuW1qU/NFUnfnnnFw/+L+WwjHbgn8H3ZgcLdy2Yb5EQObyc8QPFLZz/ofPmPrpAXRR8Ppt4i72yvVh9FrYZqHxJcQP0ded4GjGUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFF97LQZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFF97LQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA0AC2BCB2;
	Tue, 24 Mar 2026 08:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340360;
	bh=7+78+WPcY39DLO9p5hS3KIHY1sZDHwtT+k3et2rpFls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFF97LQZ3HZ2PFYLtPan5DwMExTCWKOjw3kM7nyY6ASYtRs5n44DjTEqFgjrLF8JJ
	 JW0rdBDdUEy0MalFW+VYAPrcPsWsX03r5Co56/nB4aRzRUjU+cgwrMF9Bj2ZLv4e/u
	 uJLUVjCy8SFhe2sueMf0x4ihA1HL9yPECix9r3c1BEtMLR76hobE/PwV4cVb6tfYqN
	 RhAJwtacput17of0w8ssIYpt0CoFlCX3TPTsPFAHM2no2T538Aim6wFqk/YaJCPBZD
	 i/4i1IO8/+8OQVjpxApVK+72sM02Orf/wqSBHeXYKCsxeaGJWBa17t9qDOlm7a2wzi
	 PPLJfAU1yXvhg==
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
Subject: [PATCHv4 bpf-next 02/25] ftrace: Make ftrace_hash_clear global
Date: Tue, 24 Mar 2026 09:18:23 +0100
Message-ID: <20260324081846.2334094-3-jolsa@kernel.org>
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

Making ftrace_hash_clear function global, it will be used in
following changes outside ftrace.c object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h | 1 +
 kernel/trace/ftrace.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 401f8dfd05d3..c1265f26a73d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -416,6 +416,7 @@ void free_ftrace_hash(struct ftrace_hash *hash);
 struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
 						       unsigned long ip, unsigned long direct);
 unsigned long ftrace_hash_count(struct ftrace_hash *hash);
+void ftrace_hash_clear(struct ftrace_hash *hash);
 
 /* The hash used to know what functions callbacks trace */
 struct ftrace_ops_hash {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 68a071e80f32..632f5fad60ec 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1249,7 +1249,7 @@ remove_hash_entry(struct ftrace_hash *hash,
 	hash->count--;
 }
 
-static void ftrace_hash_clear(struct ftrace_hash *hash)
+void ftrace_hash_clear(struct ftrace_hash *hash)
 {
 	struct hlist_head *hhd;
 	struct hlist_node *tn;
-- 
2.53.0

