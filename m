Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D684C8FE5
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029283; cv=none; b=Y1FgRI/biSS3lhR7VQLRKiWbI+Ng7KJMlASMaakZ1xegjuCOnN6vGA/fQNJJMxgVNYgPnf3aGCx3067lfKdTbRd4FMcfutL8XHurFLhaZUMYJWOXN3qIBogaTJNwssYEbu8u3xTsIculE9mC//3MfJKelROiGJ2EGFZOPDiTM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029283; c=relaxed/simple;
	bh=aLZRncmr18YxwwguInWkfInwLV9m26EAfQTh0GJh5nw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tH08FfDbgAif2Wo8iwnKyiDIgb+gRk/U3GLn6jB6wull9nzYdAsR+wDi0Do7zwXvphWsfqyHakPo3JgTG0/L64xICXUhK8UYps3Np57BJKc/OwplTLoE1KWBzHhB65xwUn2hb3ymOOXWzEZ9rb7E1ePrcCEGP7D6AoSbVUKBnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jjm25Coi; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jjm25Coi"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1365060ac82so4725210c88.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781029281; x=1781634081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwDN93lZCM2zufO4Mz1V1Pa6J/4Bys/WrOBYdP1FWiI=;
        b=Jjm25CoiM6FF0+UoEn7x28ptEJJXhPrzGTY/S0uD5aUMK7nXCkjVv3kOzUrOPP91eV
         59FP9+VcPIY5Hn19taYjhuq1mhqvwk1VRCckbNHVawmibnEvImizN0J328Obg5jzzeHF
         AfGkru4bcpAI+MigJ1QFro/+Kt2l8EsOlQuaPOjbEcCBcb63Ak6UGp4AMfvW8MWMWn+7
         7FWLwvXMB7Ot+ImktKDlrkswZ+mF9xTvrPWOv/J0GaXE8NQclgMO6vp9Wv676s0ud01o
         yVexFuEyG+v783msWqa4W0r17S3l/3fZlXMIekJuJnhQGy6fZTz2/dyjN9d+Kr+VJ475
         ViFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029281; x=1781634081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwDN93lZCM2zufO4Mz1V1Pa6J/4Bys/WrOBYdP1FWiI=;
        b=J3Hq3X0CJfyzrRFTU0DZrE2TwCpb6khz+1huXIGPkDUzJKepvyoP1ahDbxyuGdtBno
         2Lrm8MYLjJE+tB5Th4X1UdbYdanz6YaDPHp1f/u4geP9t3PsM3fooJTmF9ptAg5gLD6w
         e7mMNDfLZhDY/bRbKLYG6J0BMewgptOwb1z9BCfnrvxrTsMaE16tBo6NVp5FjavqLBAt
         CD3zIfx0r41Qlx/94mRSkbjZ/YLyj3z88RbW714I69S7ItBxG/gK/TQB8Eq3f2J7atqv
         4bKty/nAVvY538T8M7XqYiWaJ9XCDu2By2hrl8NIPgZjWgrWYbpbdA49EFd2ocOryP4b
         wcig==
X-Forwarded-Encrypted: i=1; AFNElJ9JEvC35dbY25F+8Mv45c9bq91O0PkK6BrLPIEBL+NcZIAkUUY/0SiPflNtoo41MhLADXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXrgsbq9Gxyn7enqEH83QPYae6XbfDDm2d9kCuj1Ln2FGL1Q1g
	eyTiusXlFt546rsgamfmprCbvr+qxvIaUiRnUHhq7MOhInY/vs4NVDirOuOhKpyGmjm90tjmLsI
	vtQ/odlE9TA==
X-Received: from dleb5-n1.prod.google.com ([2002:a05:701b:4245:10b0:138:3274:8cd4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b96:b0:137:e9b3:1ac5
 with SMTP id a92af1059eb24-13807d94e4dmr10268367c88.18.1781029280418; Tue, 09
 Jun 2026 11:21:20 -0700 (PDT)
Date: Tue,  9 Jun 2026 11:21:05 -0700
In-Reply-To: <20260609182108.975586-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com> <20260609182108.975586-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609182108.975586-5-irogers@google.com>
Subject: [PATCH v3 4/7] perf annotate: Add --disassembler command-line option
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, blakejones@google.com, bpf@vger.kernel.org, 
	costa.shul@redhat.com, dsterba@suse.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark@klomp.org, mingo@redhat.com, 
	mjeanson@efficios.com, nathan@kernel.org, peterz@infradead.org, 
	rong.bao@csmantle.top, serhei@serhei.io, terrelln@fb.com, tglozar@redhat.com, 
	tianyou.li@intel.com, yuzhuo@google.com, zecheng@google.com
Content-Type: text/plain; charset="UTF-8"

Add the --disassembler command-line option to perf annotate. This
allows users to explicitly request or override the disassembler
preferences (e.g. --disassembler libasm) directly on the command
line.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8a0eb30eac24..57a88adfb130 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -699,6 +699,7 @@ int cmd_annotate(int argc, const char **argv)
 		.set = 0,
 	};
 	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
+	const char *disassemblers_str = NULL;
 	struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
@@ -782,6 +783,8 @@ int cmd_annotate(int argc, const char **argv)
 		    "Do not display empty (or dummy) events in the output"),
 	OPT_BOOLEAN(0, "code-with-type", &annotate_opts.code_with_type,
 		    "Show data type info in code annotation (memory instructions only)"),
+	OPT_STRING(0, "disassembler", &disassemblers_str, "names",
+		   "comma separated list of disassemblers to use"),
 	OPT_END()
 	};
 	int ret;
@@ -825,6 +828,13 @@ int cmd_annotate(int argc, const char **argv)
 			return -ENOMEM;
 	}
 
+	if (disassemblers_str) {
+		memset(annotate_opts.disassemblers, 0, sizeof(annotate_opts.disassemblers));
+		ret = annotation_options__add_disassemblers_str(&annotate_opts, disassemblers_str);
+		if (ret)
+			return -EINVAL;
+	}
+
 	if (annotate_check_args() < 0)
 		return -EINVAL;
 
-- 
2.54.0.1099.g489fc7bff1-goog

