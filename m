Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A59931282A
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627451; cv=none; b=j4Shh3d5gKTqmpoDnGeRjrQfQvvw7Nsfej8KF2+pBAtXOr/hqLCcdBO9E7RBSVW22wU2Ron6fLllxx0jnKhuYmivUJXTky7IYxCzQabub8OjyqKXPnwCJ2oQ03dZ72qzxRUbMonmmiTi6YLt41DCyLTW43VdnRK2xQv44ksCwJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627451; c=relaxed/simple;
	bh=4V7u4AwiHl7180ZmhNmFc2DaJP0Vnd1dGtHOc/nnVyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZM3hPBy/MkwCiuYo61jP+wdVsRwuLXfEi62/Ez/LdcyhUdiEBjmVGqSlmjvIZRecOeexRjmZqxRsu2ArARHoxuphUMBUgUbFnXPoCPAYVLuHy1Oy6ehT7s87pVGva4RWsWLZ3/trLx3Y1mJa/gpL7PI8PfbMas63o8VUAhBz3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=TAcqUCgU; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="TAcqUCgU"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-649d4690174so2354574d50.3
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 14:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771627449; x=1772232249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF6ub5uB4xe0B3U7s4II1aZ9t4WKhMJ5Nq+voZ+kOds=;
        b=TAcqUCgULb5L4HxO2gPRMNmwCt94RLQSsn6kx/k7r8E4Msh86Zyg5GHva32ZKlvay5
         p9xoNTiJTFc16Q5DL8I2SEVzBSVFvPoxOEXPEQcldck4JmyTn2GYbMbkx7TfvKZijr+5
         bF6dZT3gTAeWddanmbzlCT21H4OA9Wrh1+0pkM11f+cKr72xyWvLYW1UFMeVp5ki4mvL
         FnhRMFUIZd2iZecfffeLb6AobWIZYHo92fIN/V69jc58Ol64KOqu6gCC+U8ov2DnYuPL
         8wKJzsbDJydd02S7T+z7VgWGH6/xuE7yeO4Sedok3Ri8lb6iEm7PNQyPelqcsrJcPFzX
         kaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771627449; x=1772232249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CF6ub5uB4xe0B3U7s4II1aZ9t4WKhMJ5Nq+voZ+kOds=;
        b=M8pUlMfocppPnUq5W18mW8G0Yg1lfeDcq2nKGc1kLZ8XTI/CvFYFNB9kynqKXGLkV8
         7tYZRChem6X47IcuNUqQ8XAmF4CM2EXS1n3pRh/q8wGgZ7CsO1vBkYRS1KJB1reNWalk
         45CezZ2L3CF5nw2KIU1oW9afrW4bLvA/HTiXd1Mh7pp999Xh/2Dz1miuX/rCIIpva2B9
         afXeQpG8dlvOZaEY7JJ9T7e2MnW/p3zI5rOqJ1hGiYGEnF5QxLIfwv4tV+Tm/2lNcvg5
         TcOZi/9i2h13Gp8mXLIRkdyWDxlX8AJ/9fg4jDn+hVfJIPEWXbHZSDkM4uUMqCNodxuj
         9uTw==
X-Gm-Message-State: AOJu0YxCLyqpRVBGFEoGeugh/oub9vqxVDbFGWhhgA0zwWzRrxUtyLAl
	9PakbreOYAcXQYvqC/0bpBBN9XJ5NMOS63R8TkfrtHj/PjuCsBRHP6GfQhdbIR071R22YUSqUZu
	e6bdw6K84iedn
X-Gm-Gg: AZuq6aJbs1YKDWzgZxfwqeI15e1hFKvKCkxzlZnov9HmvEIxP6M/WuuAAZdtj3cogvY
	xldCAghsI7SeTmG0rxSPmupzWLftOBw+TOkXewfPWm05MuoaNLhGbfTPFyq9RbrPdbgobGxAXqk
	SwB2Jrd7ntebjQGXxiXG9bwJ27khlRjq759lRDM4Eirj746mzhKfDsu0zIrFaqc3z+TlaFfrEB0
	AXRQaFaOzMLs5KxQzGkSTLDHhFcRTGJzygFVaDDsu+3attILmenwWuDWLV8ltjRylduXZwueOs0
	+Owmxn4vxAqZ2s3V7VR6fshE7+oSQ4kBqPRjzIthy6oyzSEwSb+032ZNSH2znVstzjouANxK/3C
	H6q+7Uvz1HGExxnhE6zo24mqNxgH40Yuxa78qYvhQdOU2fVEx06rDKqloIHubVqVoGb50/bZCQ2
	x9FWyh/aRXS4kUKZIcK+mr4Vhz/w==
X-Received: by 2002:a53:d9c8:0:b0:64a:ddd0:366e with SMTP id 956f58d0204a3-64c78e4184cmr976089d50.72.1771627448619;
        Fri, 20 Feb 2026 14:44:08 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a28f9d7sm278467d50.10.2026.02.20.14.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 14:44:08 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v4 2/3] bpftool: support merging multiple module BTFs in btf dump
Date: Fri, 20 Feb 2026 17:43:58 -0500
Message-ID: <d04e23314b04024a61fe295dfd28a0f215a6449b.1771625484.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771625484.git.josef@toxicpanda.com>
References: <cover.1771625484.git.josef@toxicpanda.com>
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
index 946612029dee..16bc1332639f 100644
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
+				err = -errno;
+				p_err("failed to create combined BTF: %s",
+				      strerror(-err));
+				goto done;
+			}
+
+			for (j = 0; j < nr_files; j++) {
+				mod = btf__parse_split(files[j], vmlinux_base);
+				if (!mod) {
+					err = -errno;
+					p_err("failed to load BTF from %s: %s",
+					      files[j], strerror(-err));
+					btf__free(combined);
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

