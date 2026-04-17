Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424D33C9ED6;
	Fri, 17 Apr 2026 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454108; cv=none; b=ukQd4TdIuU7ekZ9RnnFFn2vs8884BxhcNtPdQR/bz3IF6xI+eMm0ajGtfjTT9y37ddspm/q71RvEf8853M3XF4yIUAKfC5Jta5mPYVL1g65fhK6rPCTQ/NjZYeZ70NWZaM86BpQ0nOePtNP9zbobSEaaPoy2TtYbN0Fmp51LCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454108; c=relaxed/simple;
	bh=G2oEZMNahjZVDxpLMAFhcuvHjsJn76nkuktreEeokDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jABlAfKij5T589apvlDAUslkzmiJEckCXGcZ3gnEAtd7a2Lu5NhXEIHGoO2cY4Qo7cqMxmWVh77com0QeHFsmhk3VR8fk5yx2nNLI/lrBAiaU4SLNnuwMjmuXKpuIDy3OCGVZHKUL1stRtFhsLwno9H5QIErP/1U3N8667g13fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slj3FDUi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slj3FDUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD8EC2BCB3;
	Fri, 17 Apr 2026 19:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776454107;
	bh=G2oEZMNahjZVDxpLMAFhcuvHjsJn76nkuktreEeokDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slj3FDUieYeeRnEP/LCMW84Qp6FWRPcUKQzPsY/nJzZ4StP8QDJnFNGQEZ6mwA87+
	 qs7b+2GJOit3ozlWCf3ZEvoQevGqYsADe8Vou72+7Hth3FmJVCHxGt2m+KgN6cJIcb
	 lIT8nxLMg/7x0L5iN/ErJJnh1H258pFDQImVkXr5z1hC1iHy+OGaVRrlzK2ZTTNkH1
	 EppzDGnds3VABaSSbONUjXgWThHMQH658GA2N8uWX4mx81a7ThyHzTYy0VYkrZFZoi
	 DI8HPMXo07CcSxUtMB2/tLQ1D3xbLdQ4BaDncktXgjNMagx3mJqhgaHUQNnn2PDw/l
	 2viq3IRSOqNkw==
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
Subject: [PATCHv5 bpf-next 18/28] libbpf: Add bpf_link_create support for tracing_multi link
Date: Fri, 17 Apr 2026 21:24:52 +0200
Message-ID: <20260417192502.194548-19-jolsa@kernel.org>
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

Adding bpf_link_create support for tracing_multi link with
new tracing_multi record in struct bpf_link_create_opts.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c | 9 +++++++++
 tools/lib/bpf/bpf.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5846de364209..ad4c94b6758d 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -790,6 +790,15 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, uprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_TRACE_FSESSION_MULTI:
+		attr.link_create.tracing_multi.ids = ptr_to_u64(OPTS_GET(opts, tracing_multi.ids, 0));
+		attr.link_create.tracing_multi.cookies = ptr_to_u64(OPTS_GET(opts, tracing_multi.cookies, 0));
+		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
+		if (!OPTS_ZEROED(opts, tracing_multi))
+			return libbpf_err(-EINVAL);
+		break;
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 2c8e88ddb674..bc3b7bc5275e 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -454,6 +454,11 @@ struct bpf_link_create_opts {
 			__u32 relative_id;
 			__u64 expected_revision;
 		} cgroup;
+		struct {
+			const __u32 *ids;
+			const __u64 *cookies;
+			__u32 cnt;
+		} tracing_multi;
 	};
 	size_t :0;
 };
-- 
2.53.0

