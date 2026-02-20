Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A3C194C95
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616417; cv=none; b=ruPC+MXZSArWURk2focJFU9iWC5U3a9tTwjX2cLzSsc8UjKiBfppT40opqI8MOp9drTB+fZYb6f1u0K+xFTMPEzizgvVW4CnJXAJzdr46qKnRLxaKaBmlM17MgyOGghKsPJXxZplQ6lfIHbwO5BHznHdzlwSnkp32yJnWzPFMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616417; c=relaxed/simple;
	bh=kDoCoJDtKxLkHIy+uXcWb3pPgiReTrUl7WtSJPfmpgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIVkOkm4qoWPNRquiFmxZtWEh8g0bH/M7bmHzrdMIpaZsaaOEsU0sHJkCG4P1OenuZAM0o73p1H+UOha9iMnKwM77qxpuH2dU3f5q8ILQ07gUNXZRrlHvBxYW9vvdzhvNvm1W46uyp4dj8+KP0wxV2pPYTRjzcMiyucU8F+N1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=AywvrerO; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="AywvrerO"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c7199e7f79so299900685a.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 11:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771616414; x=1772221214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8jQkDYeCBYsRtW0MW1HOrphQHyf/tYN+FHdjKr6hBg=;
        b=AywvrerOOCymbV48OPhJn3/TVJ0xpBiiuMfLjKiFHwsmODci+YAVrQBsorbW50R4Nv
         iGXqH/qz0VTfdFYsTLO5zjTeKQUFrCebBcY1e7MUavo26fSPn/01vBzKpb+Pk82cwMAG
         aCgpAFo1Uc3eeRJU3RMT4KOE55OUJnqQN3+2raDD86g2TVJfv7W389Opm3gmQt0EsJgH
         r2JoPulVg5dC5CA5i+FGl5QdXNA4EyVxGwcUnqw/wiB+8uheNxTcSpS0oofOBPoTl8qp
         /JMHxVgst1lL9wKHC18zn/AWKK1xQ8WsUY0BsVAxA02QcULuUBabXKeFt+/0JN99cpIJ
         VZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616414; x=1772221214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k8jQkDYeCBYsRtW0MW1HOrphQHyf/tYN+FHdjKr6hBg=;
        b=TMcrCfoTAjzgwMy9tZlmqxXvLN4xqv3pEsKazlVu94SlTAktiuKiOArkIlffJPxbI3
         HO4B+mhebfYHqGvexDA4+/dfTjlU/CAOgh9pwpbjlm+nZxKxCFmW0aaFmw+rTExARPNO
         zkH8n2sFtIQFex74isjUtuuYpK7pNJ0pYSttipaLT7hh/2rvXfSUSEIh0oIfFJQ+tKTQ
         AzbbPrV1u9DD4zBoNGwZaKJG/iRVHsdtxYi1hFvdDSrEKWULBbQwjU2Yg/BMQjWfYZhh
         kmXBjyZ9LMe551BYfi1mwvtumj9doBqs8D19an0JC8v5uO1tg0INbAbcyLwzIiS4Dt8v
         rIEA==
X-Gm-Message-State: AOJu0YzqLGBRYCPZQFPRxzY/qYgve1Or4mbdNCz2Z7FSkOxeIMH4aRA0
	OsM83YTUkJAA3H1/hO87PlS3C96Ym33yhFGvG+getfp1jbNqlrYOwoT/KeGTxF8cbXkoDQfB3XF
	WFU+9iYnseH3z
X-Gm-Gg: AZuq6aJ5FfEUkLlnCfRPc+wDgDS/C/NALu3CGfxPD3w9qk7zotu/WL6Yq4Bo+9IBdPz
	ld6Vf0L6qWHX4Wl4TPNuaEJOeun5wXt5loKzScLoSVa9FXwZ1lxGNFvvRKy8BraGHq+GYwQSNzO
	b9imGGlzaoCeD1WCc2LzUIJgqO6usF4yQ3hQAIjkHIvMiVUbWwM6Ptt4whMVgEXl2EksrKRXoiP
	0C9oESVRFqNJqVLK030ynYiFlWRv4bJIyVvooQjlXj04GMFJxM38KCXJ6D/KYI79l3jbPEYKpn2
	lmmkJvZiQ1gigIrzpMp/2hIv97ernkicbUVxrHcxEfqUF4zUiLTjgagQkh4QCh8AmzHFUtZIyH6
	VtmYzva1ezEQU+VC/Puexf/39x+STMiszpNHLaYitdp4pYHBsCoR+Mn1pX9LogDromIgEbp4rjK
	MAO0LOVC5yMd49Rlfm2zK4AJoazQ==
X-Received: by 2002:a05:620a:6919:b0:8cb:50d6:18bf with SMTP id af79cd13be357-8cb8c9cde8dmr108391085a.4.1771616414158;
        Fri, 20 Feb 2026 11:40:14 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d575a8bsm1419051cf.14.2026.02.20.11.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:40:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v2 2/3] bpftool: support merging multiple module BTFs in btf dump
Date: Fri, 20 Feb 2026 14:40:02 -0500
Message-ID: <b2266866dd310ee411345565a5f4febb745cd326.1771616227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771616227.git.josef@toxicpanda.com>
References: <cover.1771616227.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for specifying multiple file sources in 'bpftool btf dump'
to generate a single C header containing types from vmlinux plus
multiple kernel modules:

  bpftool btf dump file /sys/kernel/btf/mod1 file /sys/kernel/btf/mod2 format c

This is useful for BPF programs that need to access types defined in
kernel modules. Previously this required a separate bpftool invocation
for each module, producing separate headers that could not be combined
due to overlapping vmlinux type definitions.

The implementation collects all file paths, then for the multi-file
case creates an empty split BTF on the vmlinux base and iteratively
merges each module's types into it via btf__add_btf(). The single-file
code path is preserved exactly to avoid any regression risk.

Auto-detection of vmlinux as the base BTF from sysfs paths works as
before. If vmlinux itself appears in the file list it is skipped with
a warning since its types are already provided by the base.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 tools/bpf/bpftool/btf.c | 135 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 122 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 946612029dee..b925923c6fb6 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -28,6 +28,7 @@
 #define FASTCALL_DECL_TAG	"bpf_fastcall"
 
 #define MAX_ROOT_IDS		16
+#define MAX_BTF_FILES		64
 
 static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_UNKN]		= "UNKNOWN",
@@ -958,20 +959,127 @@ static int do_dump(int argc, char **argv)
 		NEXT_ARG();
 	} else if (is_prefix(src, "file")) {
 		const char sysfs_prefix[] = "/sys/kernel/btf/";
+		const char *files[MAX_BTF_FILES];
+		int nr_files = 0;
 
-		if (!base_btf &&
-		    strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1) == 0 &&
-		    strcmp(*argv, sysfs_vmlinux) != 0)
-			base = get_vmlinux_btf_from_sysfs();
-
-		btf = btf__parse_split(*argv, base ?: base_btf);
-		if (!btf) {
-			err = -errno;
-			p_err("failed to load BTF from %s: %s",
-			      *argv, strerror(errno));
-			goto done;
-		}
+		files[nr_files++] = *argv;
 		NEXT_ARG();
+
+		/* Collect additional file arguments. Use strcmp (exact match)
+		 * to avoid ambiguity with file paths that are prefixes of
+		 * "file" (e.g., "./f").
+		 */
+		while (argc && strcmp(*argv, "file") == 0) {
+			NEXT_ARG();
+			if (!REQ_ARGS(1)) {
+				err = -EINVAL;
+				goto done;
+			}
+			if (nr_files >= MAX_BTF_FILES) {
+				p_err("too many BTF files (max %d)",
+				      MAX_BTF_FILES);
+				err = -E2BIG;
+				goto done;
+			}
+			files[nr_files++] = *argv;
+			NEXT_ARG();
+		}
+
+		if (nr_files == 1) {
+			/* Single file — preserve existing behavior exactly */
+			if (!base_btf &&
+			    strncmp(files[0], sysfs_prefix,
+				    sizeof(sysfs_prefix) - 1) == 0 &&
+			    strcmp(files[0], sysfs_vmlinux) != 0)
+				base = get_vmlinux_btf_from_sysfs();
+
+			btf = btf__parse_split(files[0], base ?: base_btf);
+			if (!btf) {
+				err = -errno;
+				p_err("failed to load BTF from %s: %s",
+				      files[0], strerror(errno));
+				goto done;
+			}
+		} else {
+			struct btf *vmlinux_base = base_btf;
+			struct btf *combined, *mod;
+			int j, ret;
+
+			/* Auto-detect vmlinux base from sysfs if needed */
+			if (!vmlinux_base) {
+				for (j = 0; j < nr_files; j++) {
+					if (strncmp(files[j], sysfs_prefix,
+						    sizeof(sysfs_prefix) - 1) == 0 &&
+					    strcmp(files[j], sysfs_vmlinux) != 0) {
+						base = get_vmlinux_btf_from_sysfs();
+						vmlinux_base = base;
+						break;
+					}
+				}
+			}
+			if (!vmlinux_base) {
+				p_err("base BTF is required when merging multiple BTF files; use -B/--base-btf or use sysfs paths");
+				err = -EINVAL;
+				goto done;
+			}
+
+			/* Filter out vmlinux from the file list */
+			for (j = 0; j < nr_files; j++) {
+				if (strcmp(files[j], sysfs_vmlinux) == 0) {
+					p_info("skipping %s (already loaded as base)",
+					       sysfs_vmlinux);
+					memmove(&files[j], &files[j + 1],
+						(nr_files - j - 1) * sizeof(files[0]));
+					nr_files--;
+					j--;
+				}
+			}
+			if (nr_files == 0) {
+				p_err("no module BTF files to merge (all paths were vmlinux)");
+				err = -EINVAL;
+				goto done;
+			}
+
+			combined = btf__new_empty_split(vmlinux_base);
+			if (!combined) {
+				p_err("failed to create combined BTF: %s",
+				      strerror(errno));
+				err = -errno;
+				goto done;
+			}
+
+			for (j = 0; j < nr_files; j++) {
+				mod = btf__parse_split(files[j], vmlinux_base);
+				if (!mod) {
+					p_err("failed to load BTF from %s: %s",
+					      files[j], strerror(errno));
+					btf__free(combined);
+					err = -errno;
+					goto done;
+				}
+
+				ret = btf__add_btf(combined, mod);
+				btf__free(mod);
+				if (ret < 0) {
+					p_err("failed to merge BTF from %s: %s",
+					      files[j], strerror(-ret));
+					btf__free(combined);
+					err = ret;
+					goto done;
+				}
+			}
+
+			ret = btf__dedup(combined, NULL);
+			if (ret) {
+				p_err("failed to dedup combined BTF: %s",
+				      strerror(-ret));
+				btf__free(combined);
+				err = ret;
+				goto done;
+			}
+
+			btf = combined;
+		}
 	} else {
 		err = -1;
 		p_err("unrecognized BTF source specifier: '%s'", src);
@@ -1445,7 +1553,8 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s dump BTF_SRC [format FORMAT] [root_id ROOT_ID]\n"
 		"       %1$s %2$s help\n"
 		"\n"
-		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
+		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] |\n"
+		"                    file FILE [file FILE]... }\n"
 		"       FORMAT  := { raw | c [unsorted] }\n"
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
-- 
2.53.0

