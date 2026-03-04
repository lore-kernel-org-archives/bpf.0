Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D82B39478B;
	Wed,  4 Mar 2026 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663058; cv=none; b=Ur2Edir6/EBSKjGcg8OVfGTPKCBaiYhFNXX+L+8UpxvmxtvF3FI+O8cvWRKMCOJSjDDPW9OBIraaBG9tMdGHGtVDWF/TfJWcKYwu0t7TGr4YEVTj8yWsYZZ2zXXXbl2KYgo2ektb+S4uQKwo/imhBqVakv/0UnHcPnFOrFjmlXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663058; c=relaxed/simple;
	bh=G/L+0aRKNjAspIF0dYZbWb/2XnmjWz/Vumuf0YhaMSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cecbw3w7TgevlyNP3odrWc1+XhXzznKA5Vzfx+Uz2WWU5CuQUdMK014en5Iz07hrci02kJ9kitRgXK99UhIbct8pPnvhDrN09KoC8p5uqZnr8TjSs3WZ3J3/3kE1Njd0wWQI05jdBSbxzmQ2dhtKmUM49f4jNHmVunOJG8v/GL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih6+zSOx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih6+zSOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E26C2BC86;
	Wed,  4 Mar 2026 22:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663058;
	bh=G/L+0aRKNjAspIF0dYZbWb/2XnmjWz/Vumuf0YhaMSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ih6+zSOxFHAA0SdigOF3kbIhQbbcrcoP7uafMwdagzem9aCW6SHWLv4uWYi18E9Fr
	 JdDmc5vfVHk5Y5id0IZ6QOm6DdHNHHS24lxAy9hdPVPTWiMEh0mbhL4oFKbDY8Wf3Z
	 Hhy7jWgLKBhOZD+RYwVc5JtfABLraRvY2oOCZHLhjfkx+me5zu3TDomsqOFWnQiYXP
	 imh83BSAOiuN9aBfR1Xul5OidTpkWuC2t0MAFJV/Do+d2Ar16gGki+NLlwebRcFBvg
	 +se17A2tQaMg+Te/SV/UswOOXcSSHpXxiGkduJZ0Cg69FR2JOXjw2kLEsqRCDUU2UN
	 hAuTIYRxBNFDg==
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
Subject: [PATCHv2 bpf-next 14/23] libbpf: Add bpf_link_create support for tracing_multi link
Date: Wed,  4 Mar 2026 23:21:32 +0100
Message-ID: <20260304222141.497203-15-jolsa@kernel.org>
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

Adding bpf_link_create support for tracing_multi link with
new tracing_multi record in struct bpf_link_create_opts.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c | 9 +++++++++
 tools/lib/bpf/bpf.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5846de364209..6c741df4c311 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -790,6 +790,15 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, uprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_TRACE_FSESSION_MULTI:
+		attr.link_create.tracing_multi.ids = (__u64) OPTS_GET(opts, tracing_multi.ids, 0);
+		attr.link_create.tracing_multi.cookies = (__u64) OPTS_GET(opts, tracing_multi.cookies, 0);
+		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
+		if (!OPTS_ZEROED(opts, tracing_multi))
+			return libbpf_err(-EINVAL);
+		break;
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 2c8e88ddb674..726a6fa585b3 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -454,6 +454,11 @@ struct bpf_link_create_opts {
 			__u32 relative_id;
 			__u64 expected_revision;
 		} cgroup;
+		struct {
+			__u32 *ids;
+			__u64 *cookies;
+			__u32 cnt;
+		} tracing_multi;
 	};
 	size_t :0;
 };
-- 
2.53.0

