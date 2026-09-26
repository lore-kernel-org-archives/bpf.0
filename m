Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F71E32D6
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437520; cv=none; b=MdESPtc+aQw/LhIPL/jz4+0N/lrqoZJ9DNemk3qgyKwBBC8/vmK4oaGv32aeUQUIIBth3XgGopKt21elqPxek7NSdDnQCku8R+vFDa+RrXpmPwk6YHrqjzQ9+GpvSefdO4qjULsqc9psrTbIYDLyjyV2tdHP0MBjr7OdFKZ0UAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437520; c=relaxed/simple;
	bh=SZSfDIcU01oCJJjpY5YqZXxBvEuKx5QL7hP8XNEKZz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJqgSIZc6cwPW6Qwis1L4v8fug/+oeyim84ElDtqKM8nrDzaQ0p7s64VMsAjzg3tFxMelGkw9gcxyH4Hox7ZE+03EbmFZW6bWydwFD+ZNB1omikC/w8BDhdnGRmNetGZ2lJTsXVh5a4V6/lnW9Kc+TBHhPDykIIdP67oaAR5zVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avNaLDf5; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avNaLDf5"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ffd31dd58so1195175e9.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437517; x=1791042317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SV+qQX3p5A4pWiA1HjeLdHiu8rd47lH84A4U4zOYlCE=;
        b=avNaLDf5Q8qeqHqk1HcwkDe0KwQfs+BJkzSc7TivwjzQDageKRHPx81zU+vbnuCgyT
         3b99qFulWoeq1DmSAFP/g42e12C3NHLjsPk5z8VFmsb6BnUqCl33AvWRVXgzJEPJSpJ8
         6WEeDGnYtC7yftHiEX7/gEJxZ40b/l46n4ejXB47d6TN5xVNViLi4/56CeUebIJr+b28
         ab35dJpVYp9IYHIRO4YaXyGbNM0BPNTMGlrtWpe+ZiCulUc6GF+fDzESiIPm3zRDpF85
         Y9XGRfRrt2LWrOQ2pC7i552Sm5jlAxJTm1lt0XlmHyAbpqBRTVwc6d8BRupJKIodXbs1
         +Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437517; x=1791042317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SV+qQX3p5A4pWiA1HjeLdHiu8rd47lH84A4U4zOYlCE=;
        b=xapXzGwKekYvJDFYbhlWR5TgoWQidz8hzq7tDDuzY4CBrGj2hYo804dQZ37BVqXY5x
         KVAwMzQ+fLn6/gGzqlKIsBUU3O+/WWjYzALYvPOHA/qoGk7Whe8oDNWeBBbdB8Q97qZI
         2J6xtbiLjFbntP+g7ISa8WnyuhK5eTHxc8U20u863WvUUYfTHbsmAiGayDBS2XpstTM0
         9+HL5CVnapvwHvKyGDLU6Ol31jdp4SpDqgaECExBx//J+OOCdspasPIx4Vj7JKK6nbAB
         cXS1fXn/3wAk0Tl0XCrmwgV2D18LaerQywSnyho/7xSBJbz1IXio6a2S7Ffv0i0Qs9HY
         MHLg==
X-Gm-Message-State: AFuF++nzvy30Z+EToXDNtIdkW3C59ylG0oBXIWrkUJ5nNfZgJJd9btCU
	kXAMGbwkkkjmfZPkjf/kLx4H7oYuIR3j1/M9b4ggmvK1z5fLo64jXkfSRMiWEyYH
X-Gm-Gg: AYBFou38n0KB2RmAPqUIDzK3mlkvaFoUEbvybKc+s7D9BelZ162yCzMaqmMm69YJvD8
	SLsAo2vbABesU/eSFa/KVuF9sFNZdXphcT8EU56m07HC2Tvpl8NuSyV/R2lkO8ljHp9eK8qHhvn
	xxWmCNmFk8RvrTmRluPIVqnda/G+F9SZCo01oat92906nYKpj6TMuYht+h3cIEvSyCFQnMgOHV0
	9jzvOagM90L2u9Vz6ddGusG9772peuPiKFpNn+pSKubJG0J4cVX0nHb+pm/HjuN0fccNRcBBhG0
	ncQdz0wN4/YugW0h9POi7IiZu+vci2ak0Wy6VDJ5MCJopdUYJgOG1JwV8GNjsAC882wTvzFhQJ4
	L79/ds8Rq8s1PaTct41aUuk2Spn9MlKoKd8zJSQK9bTI4LBfirVqrJ4kSs+THHbSuwt2xrQH1+l
	qagUO/A1br3w6vqCtg6+Rvex9WFqQ9BKA/LKTGiel3stmevWndXIheWGwY1J3WT/5wt6YZ9WyTN
	zoo8WexuynmhGLVYEXpqjGRRy0MRMIlGu7F6THef1XnXj4NArByGT/lTOP2Ow4swyhwJq6HBr8k
	GJkiRw6EArLOAA6PofN1PiQRciBTEGsKuJhJwcPWI/wQt+D6
X-Received: by 2002:a05:600c:698d:b0:49d:1df6:2592 with SMTP id 5b1f17b1804b1-49ff06e504dmr99447835e9.21.1790437516587;
        Sat, 26 Sep 2026 08:45:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff06b6108sm166229535e9.8.2026.09.26.08.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:45:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Quentin Monnet <qmo@qmon.net>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpftool: Exit from the stream wait signal handler with _exit()
Date: Sat, 26 Sep 2026 17:45:14 +0200
Message-ID: <20260926154515.191689-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpftool prog tracelog -w ends from its SIGINT, SIGHUP and SIGTERM handler,
which calls exit(). exit() is not async-signal-safe: it runs atexit
handlers and flushes stdio streams, and the signal may land while the read
loop is inside fwrite() or fflush() on the stream being flushed. Whether
that deadlocks or flushes a half-updated buffer depends on the C library.

Call _exit() instead. The loop flushes every chunk as soon as it is
printed, so the stdio buffer is empty except while a chunk is being
written, and skipping the exit-time flush loses nothing.

While here, note in the manual page that opening a stream as a file
descriptor arrives in Linux 7.4, and restrict the -w/--wait description to
the stdout/stderr form of the tracelog command, since the trace pipe form
does not take the option.

Link: https://lore.kernel.org/bpf/d64c6402-175f-4ea6-be6d-1a544a95c97c@qmon.net
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 8 +++++---
 tools/bpf/bpftool/prog.c                         | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 17aa0d560e32..8dbd34ef3d8b 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -190,7 +190,8 @@ bpftool prog tracelog { stdout | stderr } *PROG*
     By default, bpftool prints the output buffered so far and exits. With
     **-w** or **--wait**, it keeps printing new output as the program produces
     it, until the program is unloaded or <Ctrl+C> is hit. Waiting requires a
-    kernel that supports opening a stream as a file descriptor.
+    kernel that supports opening a stream as a file descriptor, introduced
+    upstream in Linux 7.4.

 bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ctx_in *FILE* [ctx_out *FILE* [ctx_size_out *M*]]] [repeat *N*]
     Run BPF program *PROG* in the kernel testing infrastructure for BPF,
@@ -274,8 +275,9 @@ OPTIONS
     signing.

 -w, --wait
-    When dumping a program stream with **bpftool prog tracelog**, wait for new
-    output instead of exiting once the buffered output has been printed.
+    When dumping a program stream with **bpftool prog tracelog** { **stdout** |
+    **stderr** } *PROG*, wait for new output instead of exiting once the
+    buffered output has been printed.

 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 5e27b22444f2..a60414aaa494 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1121,7 +1121,7 @@ enum prog_tracelog_mode {

 static void exit_stream(int signo)
 {
-	exit(0);
+	_exit(0);
 }

 /* Consumes prog_fd. */
--
2.53.0

