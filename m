Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641449;
	b=Me33IGRp0ZvOs024t7n9pRBZ3CnIHrXNIUYDsJCICFjxiqIL/HTpGhM3FEjzQtfVr/8x
	 0X3jLR7E7M8YS78VF1mBY3xXOOmPpDINgXvCQ7+UqmWM7WcYgBcTAof7qwvBM7Lpz94z8
	 2sJdGBRN9WskU4+k3zP0DC0V7XzOFUNHY01uue8x0teJTEc5j1Y1Ne89bpp2DxRTqhO1l
	 CAWhxbZ0Ip3fyBOJptGzalPI9T0Q4KfcWh1Falsgi4sth1kWOGs7NnWu/QsP6dcL8JcJR
	 MH+Mw+B8dxxxtrbC3q8w3EW8+xEon2q6tvvGPOkKD7RkPhX+2v7Qvt57GlVjwQDUPEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EHCQadAY8CNjmskwtsv6n18ePfbYCbVyW2mXEHaCPTM=;
	b=d3ZIvSjaxp9eHccg30XunqdzfXdlir9G5QrpHKRi4hdWSE0fEPJve8r71cgMZ0NTvScU
	 beFpssyp1kUgPcN3kuKWNJcALa8B79jBb3uRqGqmz6WGwM94iV9g7vkkxNeLzy/3uvzZC
	 brQCzPbv43haSkIKmtgBOroXIjzXhei6GL0k8ryaw7d9sJv+qoItW9Zu2MKUu0jcjUjJH
	 T3xovhdsPfKSr/S5TMkqrj6fT0EQCabkzJLP+JwCYeKkIC1F7xLHqBgZWyZPXOdDC1pQt
	 a9DWATnNcIggja6ZVUMjIXFKvxh7cgsVw3qI9PZN7eb4TDGK684+2zlEgEZduYLoGhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJ51Tyww;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0F606B913
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB0F606B913
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJ51Tyww
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so21934265e9.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793641447; x=1794246247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EHCQadAY8CNjmskwtsv6n18ePfbYCbVyW2mXEHaCPTM=;
        b=HJ51Tywwr+XZ29wAcoNwa9GQAlHT0bah+gLnEkAQFMja3qlxMk6TqNCGw9my5l6Dro
         dQdYGNv28qI8GBzghwIkdic0jM+DSXmYOrDPTawyx2OyfDy5YaohmLT5k0EfNRGBsFuO
         yZD0FP84XkVLufxeQXYrcoN7UL3q5woDEGrfpo4qyQ0gp0GJr5nK3Y0j9gxgBnKRksu0
         iUKWka26+TcczH3mb5I6se00SFAHPhaedfxtf4B9VWcQEZyePOIL4XKZzRzdmTA8coqz
         goiwoRdsNLWeG7xEPfBdLdIf3U8Me6xiv+bfpJtYf7wgncLwXF946g4G5ZIZFupR++kw
         eG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641447; x=1794246247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EHCQadAY8CNjmskwtsv6n18ePfbYCbVyW2mXEHaCPTM=;
        b=AkKFsVdcOks3Yj3glgtqSXClRPWJK/0/JXNwLTQ30iKw/tfCXTrcB1fjKwF3tI78ZS
         wmfSIMT8UG3fm0KbH6PGWylJX7MUoukhT4quA9f+bwVdU+qFozII/IGgF9TlynXxuUef
         AU4gQWXbaR9vvFUCURMjViV9cVPvDXI+XK0MGENrcMvqAbifjPRdmSr/GdJbR0UBZ4nw
         Pycsk6V4a/eQWRIoIJH0c1t8uaImg5Y+YxhCBOS9PUsRbtRvsx/p+xVRSfcYO6FlD8zo
         +dJp+mTgt1hp0ziAW5tnnhb3dcEbw+3c0Kc9Ui/OmLlqoDopGVK6TdcBIJf8Mb/RuYxI
         ZfuQ==
X-Gm-Message-State: AFq9FYL8ntU8U9eBiHugZZOCgFs7D3UNjVz4WcDBHjaM1HIp3B+l/jT5
	niSLMsY7yVUTAbhnG68+tw+YRnIDgCpeBdxM06cLINoZZBHO1T9HNRaxis3m/hMjM9fBQg==
X-Gm-Gg: AYBFou2lxFrQnI4FUh/ArbsReCIhNDwDyjQLvo9Vg8Z6ySqyVi04VYRM4rTut1Pev4U
	AeTGfA2gsQ9VfM8IxvIIT210rdcPd08ovQ4pG5f1h/bMwMeYoywY7V+DpjnZjiJRUvOh2us2oBl
	2kCNmDH/GtIjzVbLzLrIXrr8Tv3cPX5rmlhTWAYvGZjWhF542EzEymFVuGZYGSfLEPMryLsgSiL
	6buBMXW8U2QTZoqZxmvDT6etUbcXUr2/Sxqv+xepCMR2LzclPpBygsTqc4Y2WGRLDFJW6RrgBh4
	GJxVQlz3bu/g82KmqcfwshECezDWYbnU0cO7xZKbGv47T4bGBDaseBa/lj9++mXRHLmwS9dgjl5
	szL9/1Odj8lBDOhPRX8ycXAz6B8G9UXst2kT6fPUxtppg2bk3h2Vvix7s6ZUqyT856lGk1Zvky5
	G+ZUldqOsrsJQJ7eh6TjDcVDJQDm0X+rge8aYcNCloFRIIYGxZLmxdMB9uvOYT2WDDZcpOb1Z87
	O3bJWN6wSUcTHfAOfd9jOL6DBgt9hp/5rGTZB/LtaGOrlw9YTigsiFAodyDNqu0ZdgtWAP6c2VZ
	BtFARhQS3xw17Z5dQpip+ot3N3ZgwwK8uEFEVPshdOgZrETBh0aszUMLESH/I9Iy9dHnFlVmYS+
	T
X-Received: by 2002:a05:600c:6215:b0:4a1:a45a:88f with SMTP id 5b1f17b1804b1-4ac187a6c3amr233296855e9.20.1793641447321;
        Mon, 02 Nov 2026 09:44:07 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4abea533a1esm196311865e9.1.2026.11.02.09.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:44:07 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Tianyi Chen <hi@tychen.cc>,
	Gyutae Bae <gyutae.bae@navercorp.com>,
	Hui Su <sh_def@163.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 4/5] bpftool: Add attach option for light skeleton generation
Date: Mon,  2 Nov 2026 17:43:49 +0000
Message-ID: <20261102174350.472592-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102174350.472592-1-mahe.tardy@gmail.com>
References: <20261102174350.472592-1-mahe.tardy@gmail.com>
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

Add an optional attach keyword to gen skeleton when the loader backend
is selected, and pass the request through gen_loader_opts.gen_attach.

Extend the loader context to receive link FDs, using zero for empty slots.
Generate attach functions that check the returned links, and detach
functions that close and reset the FDs. Document the option and add shell
completion.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/bpftool/Documentation/bpftool-gen.rst | 11 ++-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/gen.c                       | 67 +++++++++++++------
 3 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index d0a36f442db7..4bf8b0b99ea2 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -24,7 +24,7 @@ GEN COMMANDS
 =============

 | **bpftool** **gen object** *OUTPUT_FILE* *INPUT_FILE* [*INPUT_FILE*...]
-| **bpftool** **gen skeleton** *FILE* [**name** *OBJECT_NAME*]
+| **bpftool** **gen skeleton** *FILE* [**name** *OBJECT_NAME*] [**attach**]
 | **bpftool** **gen subskeleton** *FILE* [**name** *OBJECT_NAME*]
 | **bpftool** **gen min_core_btf** *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
 | **bpftool** **gen help**
@@ -51,6 +51,15 @@ bpftool gen object *OUTPUT_FILE* *INPUT_FILE* [*INPUT_FILE*...]
 bpftool gen skeleton *FILE*
     Generate BPF skeleton C header file for a given *FILE*.

+    With **-L**, **attach** requests attachment during execution of the
+    generated loader. Supported programs are ordinary LSM programs and
+    BTF-based tracing programs using **fentry**, **fexit**, **fmod_ret**, or
+    **tp_btf** sections, with kernel targets resolved during loading.
+    The generated **__load()** function loads and attaches the programs;
+    **__attach()** checks that the links exist, and **__detach()** closes them.
+    Reattaching after detachment is not supported in this mode. Without
+    **attach**, loading and attachment remain separate operations.
+
     BPF skeleton is an alternative interface to existing libbpf APIs for
     working with BPF objects. Skeleton code is intended to significantly
     shorten and simplify code to load and work with BPF programs from userspace
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index a28af31937ad..9247a9fdcaef 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -1021,7 +1021,7 @@ _bpftool()
                             return 0
                             ;;
                         *)
-                            _bpftool_once_attr 'name'
+                            _bpftool_once_attr 'name attach'
                             return 0
                             ;;
                     esac
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 74c2c949458a..19670b3454ec 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -567,7 +567,8 @@ static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
 		");
 }

-static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
+static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name,
+				 bool gen_attach)
 {
 	struct bpf_program *prog;

@@ -583,21 +584,30 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 				int prog_fd = skel->progs.%2$s.prog_fd;		    \n\
 			", obj_name, bpf_program__name(prog));

-		switch (bpf_program__type(prog)) {
-		case BPF_PROG_TYPE_RAW_TRACEPOINT:
-			tp_name = strchr(bpf_program__section_name(prog), '/') + 1;
-			printf("\tint fd = skel_raw_tracepoint_open(\"%s\", prog_fd);\n", tp_name);
-			break;
-		case BPF_PROG_TYPE_TRACING:
-		case BPF_PROG_TYPE_LSM:
-			if (bpf_program__expected_attach_type(prog) == BPF_TRACE_ITER)
-				printf("\tint fd = skel_link_create(prog_fd, 0, BPF_TRACE_ITER);\n");
+		if (gen_attach) {
+			if (bpf_program__autoload(prog) && bpf_program__autoattach(prog))
+				printf("\tint fd = ((void)prog_fd, skel->links.%s_fd <= 0 ? -ENOLINK : 0);\n",
+				       bpf_program__name(prog));
 			else
-				printf("\tint fd = skel_raw_tracepoint_open(NULL, prog_fd);\n");
-			break;
-		default:
-			printf("\tint fd = ((void)prog_fd, 0); /* auto-attach not supported */\n");
-			break;
+				printf("\tint fd = ((void)prog_fd, 0);\n");
+		} else {
+			switch (bpf_program__type(prog)) {
+			case BPF_PROG_TYPE_RAW_TRACEPOINT:
+				tp_name = strchr(bpf_program__section_name(prog), '/') + 1;
+				printf("\tint fd = skel_raw_tracepoint_open(\"%s\", prog_fd);\n",
+				       tp_name);
+				break;
+			case BPF_PROG_TYPE_TRACING:
+			case BPF_PROG_TYPE_LSM:
+				if (bpf_program__expected_attach_type(prog) == BPF_TRACE_ITER)
+					printf("\tint fd = skel_link_create(prog_fd, 0, BPF_TRACE_ITER);\n");
+				else
+					printf("\tint fd = skel_raw_tracepoint_open(NULL, prog_fd);\n");
+				break;
+			default:
+				printf("\tint fd = ((void)prog_fd, 0); /* auto-attach not supported */\n");
+				break;
+			}
 		}
 		codegen("\
 			\n\
@@ -641,6 +651,8 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 			\n\
 				skel_closenz(skel->links.%1$s_fd);	    \n\
 			", bpf_program__name(prog));
+		if (gen_attach)
+			printf("\tskel->links.%s_fd = 0;\n", bpf_program__name(prog));
 	}

 	codegen("\
@@ -692,7 +704,8 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 		obj_name);
 }

-static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *header_guard)
+static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *header_guard,
+		     bool gen_attach)
 {
 	DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
 	struct bpf_load_and_run_opts sopts = {};
@@ -703,6 +716,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	char ident[256];
 	int err = 0;

+	opts.gen_attach = gen_attach;
 	if (sign_progs)
 		opts.gen_hash = true;

@@ -739,7 +753,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	}
 #endif

-	codegen_attach_detach(obj, obj_name);
+	codegen_attach_detach(obj, obj_name, gen_attach);

 	codegen_destroy(obj, obj_name);

@@ -756,6 +770,8 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 			skel->ctx.sz = (char *)&skel->links - (char *)skel; \n\
 		",
 		obj_name, opts.data_sz);
+	if (gen_attach)
+		printf("\tskel->ctx.sz += sizeof(skel->links);\n");
 	bpf_object__for_each_map(map, obj) {
 		const void *mmap_data = NULL;
 		size_t mmap_size = 0;
@@ -1262,6 +1278,7 @@ static int do_skeleton(int argc, char **argv)
 	struct bpf_map *map;
 	struct btf *btf;
 	struct stat st;
+	bool gen_attach = false;

 	if (!REQ_ARGS(1)) {
 		usage();
@@ -1270,10 +1287,9 @@ static int do_skeleton(int argc, char **argv)
 	file = GET_ARG();

 	while (argc) {
-		if (!REQ_ARGS(2))
-			return -1;
-
 		if (is_prefix(*argv, "name")) {
+			if (!REQ_ARGS(2))
+				return -1;
 			NEXT_ARG();

 			if (obj_name[0] != '\0') {
@@ -1283,6 +1299,8 @@ static int do_skeleton(int argc, char **argv)

 			strncpy(obj_name, *argv, MAX_OBJ_NAME_LEN - 1);
 			obj_name[MAX_OBJ_NAME_LEN - 1] = '\0';
+		} else if (is_prefix(*argv, "attach")) {
+			gen_attach = true;
 		} else {
 			p_err("unknown arg %s", *argv);
 			return -1;
@@ -1291,6 +1309,11 @@ static int do_skeleton(int argc, char **argv)
 		NEXT_ARG();
 	}

+	if (gen_attach && !use_loader) {
+		p_err("attach requires a light skeleton (-L)");
+		return -1;
+	}
+
 	if (argc) {
 		p_err("extra unknown arguments");
 		return -1;
@@ -1454,7 +1477,7 @@ static int do_skeleton(int argc, char **argv)
 			goto out;
 	}
 	if (use_loader) {
-		err = gen_trace(obj, obj_name, header_guard);
+		err = gen_trace(obj, obj_name, header_guard, gen_attach);
 		goto out;
 	}

@@ -2018,7 +2041,7 @@ static int do_help(int argc, char **argv)

 	fprintf(stderr,
 		"Usage: %1$s %2$s object OUTPUT_FILE INPUT_FILE [INPUT_FILE...]\n"
-		"       %1$s %2$s skeleton FILE [name OBJECT_NAME]\n"
+		"       %1$s %2$s skeleton FILE [name OBJECT_NAME] [attach]\n"
 		"       %1$s %2$s subskeleton FILE [name OBJECT_NAME]\n"
 		"       %1$s %2$s min_core_btf INPUT OUTPUT OBJECT [OBJECT...]\n"
 		"       %1$s %2$s help\n"
--
2.43.0

