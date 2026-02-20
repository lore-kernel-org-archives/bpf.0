Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EA308F39
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771622456; cv=none; b=c8xWLxkaL96hxlQOeYhAQXITfy9CfY//oS5V+P75UngfoU/NSJlQjtX+aWC30pJmKjSaOg365BJM7ERrBV0hyCzrbclhT3AyLMf/E5PRCNm8xCtRMZw72lYn009ISc2v4vAQqUq0sR7/YwQ90XVZQzQBsArrSIAvgYSpaI+imaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771622456; c=relaxed/simple;
	bh=4V7u4AwiHl7180ZmhNmFc2DaJP0Vnd1dGtHOc/nnVyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZUj+XUmP3mjpDPWKT3csb4sQlB1+4Ik9WXk4ot2GjztWD4VC47adP2hpXd45SJhKLGImn4zYs1rCDuIL7x+mrOb9pPWjzq++Q8DAMMZMGAiF54D4hHCS8aZDOWQLC08DyafaPXk8B8fXHlzDqws4oTexKZhP3FKd74oZpMnkAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=JjYl9hpq; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="JjYl9hpq"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7982c3b7da9so3216207b3.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 13:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771622454; x=1772227254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF6ub5uB4xe0B3U7s4II1aZ9t4WKhMJ5Nq+voZ+kOds=;
        b=JjYl9hpqRNEtyrz6ShReyjcwWCBvCeT6O1dUGkKqiOcFUoF4U6CyIgwCRjyoKmud/y
         8zaN2+S8/YM9L7JDdamvoda2rCIzUJe40Tfi2cXrHQj08p2MzCge6OACxHQHXVju6oU8
         C2eTUDdqygjtjKwvmpI5LPYGiqxkK1xncmB1UChTPngDNX0CdVzSC5qWg66oE4B0cFB3
         9Vmq+UBW+uxDYDQkfYEJWamxS82jjLQwF8cDRWLOdqBhnnnp/bhvtS1Z8VF0CbF8Q0UP
         PGD5avBm7K3HbBVIhEo4uDl0IF93bPxpPniad3Ksujbdo5lEdWSttja25IOLmkZ31Xkp
         XCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771622454; x=1772227254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CF6ub5uB4xe0B3U7s4II1aZ9t4WKhMJ5Nq+voZ+kOds=;
        b=JZASu672NC0BbBeR4L8MFS9T6R1WKaUsz4vMpWffK9hYt9nKVSRr1n4wIge3APoZ2v
         dHjgxYsJjdJL/2BNimcMb7nIXx0JEkVuzeOZjCqZXxPrX5YdDNTPJV7T3sQ06pzH5wDF
         Dfz2sBVC/Kmj8/ui03QDQpcD2L4meYbnN8alAC2mqbrghEBvlTiy3Dr+XX1vp1/M+Cx8
         W/BEhkzGkN1pV/ElejCehfAr2q3e5Q2yRwnLGsZJcVVHTmmAQLCJr81vb7Vgd1topXoi
         g04IQIaO9wP3Emlhbrl4q2jo6uJsedu4lyK4Qf2HxKIScDKco6pmlJ6qmguHsX5ESGNA
         tQuQ==
X-Gm-Message-State: AOJu0Yys9Df4+/8/5xVswgIvK+oyWdoDSYJOLUqBCR6pllHTAY1UoxTi
	j1lt2aiE03SkYoWeT4W/gk5Z558prjhFPrsdO4gb49Y9xOWoTQkdOaDRjtqINcXWebxL2WsHhIG
	wYu6tPv2cEZ3c
X-Gm-Gg: AZuq6aJsr+Z39wc40r0TC6PHKkZRP70Jf259j1FldrZl69KY19nlw17nLevY+mU08Kj
	I8ENF2/GC4T1HU5j7lAPkhP/AgGay5RdU3xF3d0Po/AvIvMjjdugDkVvJS6nf3aM3tPnEvbxGcp
	8Xl1pMImVKfPbhe8d3dHaa/yRBePFYjk7vfWoIirN2pRIkoQQ2AOJXnr+2svKFdYaZ2PdsrsYa/
	4/O2xvYuZ0U6pIo4GfmpwHrTfeUopvLBAJnjz6rCsMm3kXMtOK+IqlVihPOWRZe/IQQl3Cm4vzG
	sxCQ+feMj/LJOg1w5eSy/lHOFlh1sdAEQUmRLR8xXMbT/FBaXqn2q7QfLzsXKLGjwkD/Plq8BZ2
	lfDnTS5s4uffSYC5gueXw/5rt1M95NXVebdGNnlM+Si3VOOOoad7ttUWHKhfiB2j+WK3y/glnmV
	oE4cU6vHiK3XSuVUcQe93jZ4l72g==
X-Received: by 2002:a05:690c:6992:b0:798:286:1961 with SMTP id 00721157ae682-79828ef415bmr15506867b3.15.1771622453921;
        Fri, 20 Feb 2026 13:20:53 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982db9415csm1740577b3.4.2026.02.20.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 13:20:53 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v3 2/3] bpftool: support merging multiple module BTFs in btf dump
Date: Fri, 20 Feb 2026 16:20:43 -0500
Message-ID: <ccdbeb06748a8d8df73dff6e8b88aff15f1c4694.1771622266.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771622266.git.josef@toxicpanda.com>
References: <cover.1771622266.git.josef@toxicpanda.com>
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

