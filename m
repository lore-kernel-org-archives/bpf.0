Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEEA24E4AF;
	Mon, 16 Mar 2026 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647655; cv=none; b=I2+EREo2o80QBn+XCAWiS7p5t78i9FzL99SNUkTdr5+f/TOHXQDoAe0ozmzHYFwXscZUPwGJD3o43kpbFo2LZNUhR/vjtbjFrjFEC4hcbufU9acVXBHdaf8ucFNkm2+DFqWeULNxpmB6ZmqjB09NXFQatDLF/qQzZcB0A7vQcPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647655; c=relaxed/simple;
	bh=Ru71sDKfQ5lQxB++PwdYZEsyxmVDIfXJjONG7ELfxYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRwnOix2AlBBbG3bM+wuXykvhZB6WkEbDJ+LQ9wLYZ1T8JLMQBj5yXzSvfk8yaABm9UTreVbAcNKv84TugNo3PrBxdVkYJ0uAkjEKR8FS2FY8C65G5VT7rtLylJQcZu38sO/cnYks0GKv7RN7tLOXHjlmtvS4vYb2Xc+vFhBUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap3MEwd7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap3MEwd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F90C19421;
	Mon, 16 Mar 2026 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773647655;
	bh=Ru71sDKfQ5lQxB++PwdYZEsyxmVDIfXJjONG7ELfxYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ap3MEwd7iiUzg5LlFxUeS0wy75crb0aQmLNI3aCZT4fo8Gpakc2KxZB8NQwKMwsaH
	 ixNYWTNwNfPgI2GkeQIk0Hf/sK7V3Cs+mduLI+2OsllsJkGdBKnoYS/JmiNHMqcVuU
	 o7nq2IiRQ3Vp1AL7UYb7gcv3s6uk8vXUVkqrzCGuE0ly9RZoPBGkpICUPaRGSUjBLn
	 e+tzMVhzaqWfm3y+cvTpRTScjjz0NPjVXbKe57vBClVEUYdBZgW7+C/U2HbPj5qhwV
	 rPLoCbWwN+MqDKYKzMU+GolmJuGx62IdpF1CT6pMCiSOj9V+19tHP5oCc8AkjphsY4
	 6hd2lesy9upCw==
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
Subject: [PATCHv3 bpf-next 14/24] libbpf: Add bpf_link_create support for tracing_multi link
Date: Mon, 16 Mar 2026 08:51:28 +0100
Message-ID: <20260316075138.465430-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316075138.465430-1-jolsa@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
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

