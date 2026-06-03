Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724638D3EA;
	Wed,  3 Jun 2026 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484957; cv=none; b=cd3h9YZviyKyYGEJ/y/1f38g+akZrj3dh25q6YoXpUO/mEJo5FA+ao04fbRC3BfhN/buJLkTw10nwApMIJ6AX2PEEJxC0zC2WVb/MW0RNT6jD8rkQjC+j2p4vQo6+9P9ZF8CIydvmhX2nCbwI8fx0EyZ++xS7RTnB52YYbE1tqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484957; c=relaxed/simple;
	bh=B11OWrW7zG00QGD73BHH1f8OjLq1cX9eM+8WsVk86WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XawlZA3IyYApqnd75N053Sa8p9jyoJ++anTD6xBGNsHwYTgM2eNm3qsp7hvQ5dz4EjbGRJ9bwlOT+2LcHc6aPoYtUW3V3ZkHkHEh/u8sbfoCqbe82DLG2lUX0rMY5bEEWoPYlpPw4D/Jqgsn/8QrDg4SKWI2gBsjwg7ush+AqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJKyc5LY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJKyc5LY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE661F00893;
	Wed,  3 Jun 2026 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484954;
	bh=h94aRBnBTR8l+tabnA5vUT9eXHT3NM5cN3p9yJmFkGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bJKyc5LYe0N2+yuFUklWfUPaCNsbk7ErAXWLShWUMTTjg2XX1hLPpnbo6C2/cHqvi
	 5Rbcr/TKLgP3iP/J+zfszrcmoeZ7CD34CzsbWyKGdxWWuAmN7g/Zv3pgKLJwWXgDW0
	 JJj0wFHBL7FtsvXEVKO5ilne4ojnqIQHsI8K5ce3ohsVtfasWx1M/6QqSd3it7svsV
	 rZ64M1KdnB4g7EwJNuU4BIk6PJ0K/qdgkdRdELBC9XocMMqh8QCxRweK2VqKd36rzS
	 rEWN+G9qebgR1+pnYD2KzodYXIi9MuiY0s5m/Wpi8ZoJxfGdM+FxoT/3uZ2MAdevA+
	 RKrXGYz69EM9A==
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
Subject: [PATCHv7 bpf-next 18/29] libbpf: Add bpf_link_create support for tracing_multi link
Date: Wed,  3 Jun 2026 13:05:42 +0200
Message-ID: <20260603110554.29590-19-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603110554.29590-1-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
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

