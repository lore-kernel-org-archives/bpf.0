Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD34C81;
	Sat,  6 Jun 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749783; cv=none; b=KhUNWomeFEj7vi8tIyXF4VTrQtxXIW0b0KHobOPKGtfcDO3g6F8Yk5S9wCMtaWzX72sNY+Haz1E7cQMNJmTXM25z1wdoEvs8m2OQnOipc4+7V7EfQga3OHYbkqMHb+nnklM9cfu7j2y7pZhdMFyGQbI6vo5fQo82f6+mNan6Pgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749783; c=relaxed/simple;
	bh=B11OWrW7zG00QGD73BHH1f8OjLq1cX9eM+8WsVk86WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaDqnujOp3dHCbIc+cXWO94sC+tHsnxhcwqarTw/qnSZrlsusVmMTyWbkfdvXrtufzWFwZihgjcu7CQlG0w5VNwggSIfGqYDz5juY060N6D8YzMUy1MCXnVj3upRqjt51fGPz8QzHx/d8Q77xf3fotz6QT7/AuENoI2OxEHs0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9bnf+HI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9bnf+HI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8A71F00898;
	Sat,  6 Jun 2026 12:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749782;
	bh=h94aRBnBTR8l+tabnA5vUT9eXHT3NM5cN3p9yJmFkGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P9bnf+HI5cXmksp1z1Cvsbp2upEHK5prJXJkBrN6w4cLkidTEgsqo6Wu7/dKzasi+
	 qW2TZa6LN7ARHDMC5jzJoc+nfJjPyjM8iN0HuXQnAWx+BiggzDxHgQ3CrSp3vUjmxA
	 EcilbKwm4wTYpRui3SA7kdhDQnkmaF4xebNUzNaV6LSA8I9UEpI4P+8IyZ9jPb5//n
	 I2lxYMVhsEhUPMETG5qKuWbPZSInNMEAGvj/IxEmqWVgj3MzeN/PIOg0nNFx4ubNgU
	 ipsDkF+fIVfzNcDO/umcrUnvOcZgH0WN9WKrAqkqv7pv9VLZm+JM63ILMXta1V6geV
	 Cu/RSJAmfL3oQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 18/29] libbpf: Add bpf_link_create support for tracing_multi link
Date: Sat,  6 Jun 2026 14:39:43 +0200
Message-ID: <20260606123955.345967-19-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
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
index bc513aa8f404..f37e3416f61a 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -845,6 +845,15 @@ int bpf_link_create(int prog_fd, int target_fd,
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
index 2312900a3263..012354131cf6 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -469,6 +469,11 @@ struct bpf_link_create_opts {
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
2.54.0

