Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698477;
	b=PmpgLnmaIWvo05yGw+XrFPaEXYL8yfpjudYFLRODp27w/cG7rZjAz781YqJvxGJv7YgP
	 DaoyeakFztOw3k6AeVl9WhcTBzf6jamyATX+I1UG/grl3FdLeLdLX9nJQC98KLDYOi/uE
	 wQV9YrEyle2+jhIMuL2bqMu5JgLz1JH2V71TnScWjxDCfXGr/xUCviCFNMvNgVwWWCRlc
	 x6bBNuozBUzjOpcNxrpJFtc08sYHLqU04S16QEvvN3IVwCxunhen6dbqsvkBJYYYNkDfB
	 WX3v92K71bMbRFKRtnEg1YDV81zHw7R0mX64iVfioJuZS9pPm+hTLWCggRGzWPfzEAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698477;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7QFLKPA11NFHNKFBRdqJfPK1IJ1iQeZsI96jWMQ+U0U=;
	b=tzwUyanH2for3GrbBos4w/POx4yaU87afOMdp7qU6eOhqlJ0EZ+iq/5T1QEsDgDAVLqW
	 bsqE/4u+3BgRcLKmaQ6QQafekLTAmXNlxBk7bL3r5D3doRFOyEPV5JBZkpxDXkwsauidk
	 EaWJKsnIjSBrUKHXb8lo/d9abHBBmIk6NALniNBgicK6Lje60NucBHiE79owuz8YVa5S9
	 xDvzRRHBqiyf8XJb6ypkRaK9PhvXusYjs60frKM4MGXMIkUL1BLoaK9NwQIeI6VBWlvZ5
	 mQMTLn4lD9iygA9WctihrLodOSbsuFWj6SxeJX9lj0nixoPtmDhs3tXhiSmm4NKYKJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0op5Rbp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B90606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0op5Rbp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8C21F000C1;
	Tue,  3 Nov 2026 09:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698476;
	bh=7QFLKPA11NFHNKFBRdqJfPK1IJ1iQeZsI96jWMQ+U0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S0op5RbpB1smyENiE8aa4vmHWAcXrYH7p3OtQsRdT+BCYrbELOLSmU5/FK1SA3b4T
	 /BdBbLwmyfTqHClxSigOEoyNqGVQ9Oi6mfBKAGepb9xTKkeCBYn1WGT2QndadkezKi
	 F75winpS9JFY3VkurkKPe0hSXD5nhofgQ9xIkL8mrr3gTLkL+QC5h4ttTOJM5XQcuP
	 6sCNkCelveVvFB8rcwcOD1RL58H4zRoSYCdHUAdEOyBcx4Ao70j1Ad5up5KHovi+Ax
	 7yiUMcDO0EjFB3a0i5+QtgEnJZpmPD5ElFv7PWIaCSPYXUUz19CVGwJVejRH11zFQa
	 TZcc6MtP5pwKw==
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
Subject: [PATCH bpf-next 3/4] libbpf: Detect BPF_TRACE_UPROBE support
Date: Tue,  3 Nov 2026 10:33:59 +0100
Message-ID: <20261103093400.112178-4-jolsa@kernel.org>
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

Probe whether the kernel accepts BPF_TRACE_UPROBE as the expected
attach type for KPROBE programs. If it does not, load uprobe and
uretprobe programs with zero expected attach type.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Documentation/bpf/libbpf/program_types.rst |  8 +++++---
 tools/lib/bpf/features.c                   | 22 ++++++++++++++++++++++
 tools/lib/bpf/libbpf.c                     | 21 +++++++++++++++------
 tools/lib/bpf/libbpf_internal.h            |  2 ++
 4 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index 3a07ce3b7f79..1c4424aab601 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -90,15 +90,15 @@ described in more detail in the footnotes.
 |                                           |                                        | ``ksyscall+`` [#ksyscall]_       |           |
 +                                           +                                        +----------------------------------+-----------+
 |                                           |                                        |  ``kretsyscall+`` [#ksyscall]_   |           |
-+                                           +                                        +----------------------------------+-----------+
-|                                           |                                        | ``uprobe+`` [#uprobe]_           |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TRACE_UPROBE``                   | ``uprobe+`` [#uprobe]_           |           |
 +                                           +                                        +----------------------------------+-----------+
 |                                           |                                        | ``uprobe.s+`` [#uprobe]_         | Yes       |
 +                                           +                                        +----------------------------------+-----------+
 |                                           |                                        | ``uretprobe+`` [#uprobe]_        |           |
 +                                           +                                        +----------------------------------+-----------+
 |                                           |                                        | ``uretprobe.s+`` [#uprobe]_      | Yes       |
-+                                           +                                        +----------------------------------+-----------+
++                                           +----------------------------------------+----------------------------------+-----------+
 |                                           |                                        | ``usdt+`` [#usdt]_               |           |
 +                                           +                                        +----------------------------------+-----------+
 |                                           |                                        | ``usdt.s+`` [#usdt]_             | Yes       |
@@ -239,6 +239,8 @@ described in more detail in the footnotes.
              non-negative integer.
 .. [#ksyscall] The ``ksyscall`` attach format is ``ksyscall/<syscall>``.
 .. [#uprobe] The ``uprobe`` attach format is ``uprobe[.s]/<path>:<function>[+<offset>]``.
+             libbpf uses ``BPF_TRACE_UPROBE`` for these sections when the kernel supports it;
+             otherwise it loads them with an unspecified attach type for compatibility.
 .. [#upmul] The ``uprobe.multi`` attach format is ``uprobe.multi[.s]/<path>:<function-pattern>``
             where ``function-pattern`` supports ``*`` and ``?`` wildcards.
 .. [#usdt] The ``usdt`` attach format is ``usdt/<path>:<provider>:<name>``.
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index adb5d2e7fdfa..175d96c0a501 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -318,6 +318,24 @@ static int probe_kern_exp_attach_type(int token_fd)
 	return probe_fd(fd);
 }
 
+static int probe_kern_uprobe_attach_type(int token_fd)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.expected_attach_type = BPF_TRACE_UPROBE,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int fd;
+
+	fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns,
+			   ARRAY_SIZE(insns), &opts);
+	return probe_fd(fd);
+}
+
 static int probe_kern_probe_read_kernel(int token_fd)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
@@ -761,6 +779,10 @@ static struct kern_feature_desc {
 		"BPF_PROG_LOAD expected_attach_type attribute",
 		probe_kern_exp_attach_type,
 	},
+	[FEAT_UPROBE_ATTACH_TYPE] = {
+		"BPF_TRACE_UPROBE expected attach type",
+		probe_kern_uprobe_attach_type,
+	},
 	[FEAT_PROBE_READ_KERN] = {
 		"bpf_probe_read_kernel() helper", probe_kern_probe_read_kernel,
 	},
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 02e75b183ed0..1f1c911fa295 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -139,6 +139,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_FENTRY_MULTI]	= "trace_fentry_multi",
 	[BPF_TRACE_FEXIT_MULTI]		= "trace_fexit_multi",
 	[BPF_TRACE_FSESSION_MULTI]	= "trace_fsession_multi",
+	[BPF_TRACE_UPROBE]		= "trace_uprobe",
 };
 
 static const char * const link_type_name[] = {
@@ -424,6 +425,8 @@ enum sec_def_flags {
 	SEC_XDP_FRAGS = 16,
 	/* Setup proper attach type for usdt probes. */
 	SEC_USDT = 32,
+	/* Set BPF_TRACE_UPROBE when the kernel supports it. */
+	SEC_UPROBE = 64,
 };
 
 struct bpf_sec_def {
@@ -8398,6 +8401,12 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 	if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
 		opts->expected_attach_type = 0;
 
+	/* set uprobe attach_type if supported */
+	if ((def & SEC_UPROBE) && kernel_supports(prog->obj, FEAT_UPROBE_ATTACH_TYPE)) {
+		prog->expected_attach_type = BPF_TRACE_UPROBE;
+		opts->expected_attach_type = BPF_TRACE_UPROBE;
+	}
+
 	/* special check for usdt to use uprobe_multi link */
 	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK)) {
 		/* for BPF_TRACE_UPROBE_MULTI, user might want to query expected_attach_type
@@ -10842,11 +10851,11 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
 	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
 	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
-	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
-	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
+	SEC_DEF("uprobe+",		KPROBE,	0, SEC_UPROBE, attach_uprobe),
+	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_UPROBE | SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
-	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
-	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
+	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_UPROBE, attach_uprobe),
+	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_UPROBE | SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kprobe.session+",	KPROBE,	BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
@@ -10858,8 +10867,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("uprobe.session.s+",	KPROBE,	BPF_TRACE_UPROBE_SESSION, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("ksyscall+",		KPROBE,	0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
-	SEC_DEF("usdt+",		KPROBE,	0, SEC_USDT, attach_usdt),
-	SEC_DEF("usdt.s+",		KPROBE,	0, SEC_USDT | SEC_SLEEPABLE, attach_usdt),
+	SEC_DEF("usdt+",		KPROBE,	0, SEC_USDT | SEC_UPROBE, attach_usdt),
+	SEC_DEF("usdt.s+",		KPROBE,	0, SEC_USDT | SEC_UPROBE | SEC_SLEEPABLE, attach_usdt),
 	SEC_DEF("tc/ingress",		SCHED_CLS, BPF_TCX_INGRESS, SEC_NONE), /* alias for tcx */
 	SEC_DEF("tc/egress",		SCHED_CLS, BPF_TCX_EGRESS, SEC_NONE),  /* alias for tcx */
 	SEC_DEF("tcx/ingress",		SCHED_CLS, BPF_TCX_INGRESS, SEC_NONE),
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index e90b5336bac0..d510f9184df6 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -366,6 +366,8 @@ enum kern_feature_id {
 	FEAT_ARRAY_MMAP,
 	/* kernel support for expected_attach_type in BPF_PROG_LOAD */
 	FEAT_EXP_ATTACH_TYPE,
+	/* BPF_TRACE_UPROBE expected attach type for KPROBE programs */
+	FEAT_UPROBE_ATTACH_TYPE,
 	/* bpf_probe_read_{kernel,user}[_str] helpers */
 	FEAT_PROBE_READ_KERN,
 	/* BPF_PROG_BIND_MAP is supported */
-- 
2.43.0

