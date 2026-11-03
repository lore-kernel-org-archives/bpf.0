Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698467;
	b=sXcxxsTQmsp21Z9ij0cNqf0I1UXYr60DTRX2vAnPQ/dzjlz4YPbZ3v1JgzBgy0pXKoOy
	 K1SYgjng0glKBxD/A0yUon1NzKr0rL74JRwjj91TK3TjOFvoVQ2dconHlBjob4J74+myc
	 S/lZpyYTtsF5HhPo6EpjBwwq2mAtom3Cf8QDp3cSgTYkywAwiaC/++WQdE7B9vi1c2kvs
	 qH12PaRPG8XHsbsf3YZ37BmsqX7SFkc1OI2VEohArDrZTqyGnbNzx6XtkqHRWrOHB0k0G
	 PLhjvLgDbjSScEEaTEBciSnyO8Frseuh4F+WdNvwT+0GZ6jynlUIi1il9h5tehKcnCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698467;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N9e6ZQkhyh6vRtMVZitQcqbLx+m4FSsOTyobXPMYCeg=;
	b=XHOjvYg4+pJJ9NK9Kgl7HyrhofRyAf0lzLI8CGpYvVpXKGJFN6qb/HeLdOYJgweeC8sh
	 CUdE2L2eUfJdKt0FfkXYuXjFpAFvF623349L009l1pfwXCFmrd4n5DAFGAfehXwowkaL6
	 uq5+upOndfZsg3dwP98Rdr3MemfC8YcWzVAlPYqe05l8IXUcgGpMGy78G6vEPlFxrsPMy
	 QQEcf+h39LRnhoPp0hjebGJ3QG7JOzo+lgE2+Sg5ed0zyuCpOql5hMJSyTN6yN5ZT7D+O
	 0JZ38bT8wMI/99D6Tuz3ICbuxuEstd24OCFt3glGRu10y6l5SV04cTx0ibE+uNQ0phw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csakDo7n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DC606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csakDo7n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5401F00919;
	Tue,  3 Nov 2026 09:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698466;
	bh=N9e6ZQkhyh6vRtMVZitQcqbLx+m4FSsOTyobXPMYCeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=csakDo7njcPVOcBqs0xik7MExh78WAHOW48y2kUsp8kopQx7uDQuabmEJ6dRHOMRI
	 8T2OpwNl9+oq/siWB7u8NSwn6TCfOI0ap6rDfivxXpDEpZRvhQ2UMS7IyXdr5BUW6T
	 nDNO3LVOyD7+OUpPFqHvR+HYJ9PrwyiFr2nVVFQ/KytP8mXLKRWa79MVYJmv/oagDp
	 QdJEnPhQWLCxGZW1fzUunK5r3zv4pThxC2p9ldInlf6zBmo+iRNkOku0ZG8cXhNgD7
	 AAw514UgpzjHV/mKr2uA2hWKIs38INi8UjveRnkBm4Ks43s3MsMiPAmqZXSyDepAHh
	 v+cO8jRDpbdDw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	HyeongJun An <sammiee5311@gmail.com>,
	Christian Simon <simon@swine.de>
Subject: [PATCH bpf-next 2/4] bpf: Add BPF_TRACE_UPROBE attach type
Date: Tue,  3 Nov 2026 10:33:58 +0100
Message-ID: <20261103093400.112178-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103093400.112178-1-jolsa@kernel.org>
References: <20261103093400.112178-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an expected attach type for classic uprobe programs.
Reject attaching these programs to non-uprobe perf events
and disable the private stack for them.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       | 1 +
 kernel/bpf/verifier.c          | 3 ++-
 kernel/events/core.c           | 3 +++
 tools/include/uapi/linux/bpf.h | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 62de0919db72..3c8a75b4c744 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1206,6 +1206,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FENTRY_MULTI,
 	BPF_TRACE_FEXIT_MULTI,
 	BPF_TRACE_FSESSION_MULTI,
+	BPF_TRACE_UPROBE,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a9c6a4b8eecc..7c941e009a33 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5707,7 +5707,8 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
 	switch (prog->type) {
 	case BPF_PROG_TYPE_KPROBE:
 		/* Disable private stack for uprobe programs. */
-		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI ||
+		if (prog->expected_attach_type == BPF_TRACE_UPROBE ||
+		    prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI ||
 		    prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION)
 			return NO_PRIV_STACK;
 		fallthrough;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea7142..016d479467ed 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11835,6 +11835,9 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
 	    (is_syscall_tp && prog->type != BPF_PROG_TYPE_TRACEPOINT))
 		return -EINVAL;
 
+	if (prog->expected_attach_type == BPF_TRACE_UPROBE && !is_uprobe)
+		return -EINVAL;
+
 	if (prog->type == BPF_PROG_TYPE_KPROBE && prog->sleepable && !is_uprobe)
 		/* only uprobe programs are allowed to be sleepable */
 		return -EINVAL;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 62de0919db72..3c8a75b4c744 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1206,6 +1206,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FENTRY_MULTI,
 	BPF_TRACE_FEXIT_MULTI,
 	BPF_TRACE_FSESSION_MULTI,
+	BPF_TRACE_UPROBE,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.43.0

