Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A114B96B;
	Tue,  4 Jun 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531418; cv=none; b=L7ZR5ajpmpFGXVC6xqSUPGXYTUqSnkjJZ/1KtRuMzclujppFz2YKPlthfNWBOn/5HPn/h+yHEBgbNIP+EVdLwxbVVW37BLk3//LF73EV5bcvGYrlbMf9Hg/ZG/a/O4NO9/UceQaetTOGETXnH7vo1oYUFPGWItp+Y+I7PAmHQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531418; c=relaxed/simple;
	bh=OrDWdwFwBLOPijaiiAiolWQlzUYYleCq1cewcCwIhJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVcH3UxN5XId6uRKbBO4yG3IBpZqFe5+j43rBqYOWGKob0W2UGnn+PU/eyIkrJZFVLhtYua6W19Y99WTAbnXFxFXs48kb0YN3XDB6+AtgwqMtFmCyFsUelyyWVQGSVd5pNAjPS8ed27ni1cke4PEwPU8An3kTs/JVrJmNxWDnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehjPsO2l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehjPsO2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C42BC3277B;
	Tue,  4 Jun 2024 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531418;
	bh=OrDWdwFwBLOPijaiiAiolWQlzUYYleCq1cewcCwIhJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehjPsO2lhV7tnUjWUmMCssQDh6/Fd4Z+C5Rih1oLZ3VJTIrkxNTfS4Zh1qOM3bhWd
	 Y3deZO9smgwc3vN/jjZps8X27DP548QFpTNLvR7nKP6r92QyyIAHJptVp3nZQuUOQ2
	 rH54R4xrmVsyGqC79kj5Yp2hK1QJGlef1lYesQrfmqIExc5tR5pGkwmAQQq8bAWReS
	 uwqetWOXUF4uKTTmRyR5qzeeY5UTQqQiQ2Yt2QT42Ai9FnTeX34w9fSoIiTf6utmZy
	 LjksAUZghB0aJkoij86zg2lACWW/vjVkgV2/EHrXJqblLvhMN5CMhdYNx520YTNXhk
	 RaBvVS7TAWhKw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC bpf-next 05/10] libbpf: Add uprobe session attach type names to attach_type_name
Date: Tue,  4 Jun 2024 22:02:16 +0200
Message-ID: <20240604200221.377848-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604200221.377848-1-jolsa@kernel.org>
References: <20240604200221.377848-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe session attach type name to attach_type_name,
so libbpf_bpf_attach_type_str returns proper string name for
BPF_TRACE_UPROBE_SESSION attach type.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a0044448a708..702c2fb7e4df 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -133,6 +133,7 @@ static const char * const attach_type_name[] = {
 	[BPF_NETKIT_PRIMARY]		= "netkit_primary",
 	[BPF_NETKIT_PEER]		= "netkit_peer",
 	[BPF_TRACE_KPROBE_SESSION]	= "trace_kprobe_session",
+	[BPF_TRACE_UPROBE_SESSION]	= "trace_uprobe_session",
 };
 
 static const char * const link_type_name[] = {
-- 
2.45.1

