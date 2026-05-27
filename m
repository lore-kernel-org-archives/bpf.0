Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D63FD121;
	Wed, 27 May 2026 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882193; cv=none; b=oeiI3Q+hEEit5wkWHw6NgwD8TkuEwQCRFg77l9qdB73qj4KFGn6Vge13GXTOX/vnu6otWyHxKzmDovweXBswvGUmjIoC0QSU7mZ6MazKZYUM+ir/A5MhMwo8C4S9JI2C1MOJRwb+zywPmVlOwgLahiZ5n9ZO8MvKAapGvxNv/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882193; c=relaxed/simple;
	bh=CQOLkY64hGarxRXb8R4iBbGH01lJOS5nErYFpL8e0C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGukM2Z/IB3MQu/pDt1AGwmGCAdsKdBUNWV/UbNpmX8usvEq9TT273Yc+TssoNJQ2kVHPWDuptLKEclkthN4fvlM7wpsmBbipH4MCJu+hNplR8NmkjhyY2Po6jOvVKllVKMHR4qxe0aRL51iO4IaQ4GPu7xd6jKFaJ0NvKA2Awc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaZEqBQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaZEqBQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED1F1F000E9;
	Wed, 27 May 2026 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882190;
	bh=6JOc6buNdpoPflTfBlkgqREXqcnGjJ2I3Sbk5gfhDuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WaZEqBQFfmFDFcLVuYxkuMgjIHP12WCTgJdRKayesE2ffWh5Tk8+majKsYvXeDcQ5
	 7kmjkLqQNKk9wrxz2vdo4sc/FFdooStMr2zwD1Z03knJicUOM+UbDGozMj7KkNEUbz
	 1DfoAty51x0WzmpjyDqQ3vydRfh71+O6erhENl/gXf79jUPMlhv6klWX4y0Gmc81EH
	 kwBcFrS4OxrhtR1aYkkkTvyg5euh0P1CxRC2EcRT6Ev3GWrvzSlw7gLS5JGCPO7zLc
	 izQP1tWT/8zUmyCWIdegy+jeMcEWbXEH2suSELYrBO0ZGHgCFNdPZe4da5hKnEyZgD
	 Vr9vHMKekRONw==
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
Subject: [PATCHv6 bpf-next 18/29] libbpf: Add bpf_link_create support for tracing_multi link
Date: Wed, 27 May 2026 13:39:40 +0200
Message-ID: <20260527113951.46265-19-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527113951.46265-1-jolsa@kernel.org>
References: <20260527113951.46265-1-jolsa@kernel.org>
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
index 3cd705802330..ff342972ca4a 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -843,6 +843,15 @@ int bpf_link_create(int prog_fd, int target_fd,
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

