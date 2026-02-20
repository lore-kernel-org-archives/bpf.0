Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1AA28727E
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606158; cv=none; b=VYi7K7leMMYhBPPFa+TZxJwMGpDA8AT/MxJ6OxckVFCYng9L6hAHGWM1WvZaB/oEHDHrT5Y8rY23N9catWnzNjdEYtcHkgyzF0yIFYTcw0oV/SFlil+n7KRZQohaCTjkCzKqjmaRFZNzlkxwmrfEHNtT9IVkyxAQNqHSfUkYfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606158; c=relaxed/simple;
	bh=6IqwdrIyUjBeZkSJMqCdsGq4DBL9Q2ONHrfywbhxnYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQL2ylNqsrnEv7cz//W2mmrH0zmot0bHsVUdByxnJv2f8sbbFdUqGx6Mr2KQxJnDlmZnrN+wLSNqajFPS67yLrMRK1NBxJ9PbY3eFVVC+5r9U9vNjwRNz/SCX5MR5yYl9/chJgmkGb6iTSS4l7Do4kpx2H34oTyt1833sAFRbZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=BTzhYI4d; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="BTzhYI4d"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7950881727cso17077207b3.3
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 08:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771606155; x=1772210955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkcV0EKcoZWuSk2vrr0Y1tvsSf32bGpv8eTMpksOkmY=;
        b=BTzhYI4dxRj9mQ7wPo3avwfgRgFB1Wqr95wyeH4cCWRk93hooKNqCZP/x/Nn6cBB/i
         ut0p8+/z9LRfhUmMWpwRZ+e1CU+EZcWnaIQYfXKJ+c6T4YExPqe+E5rhI0k/fhdrXrOS
         d02BOGIJgDHqy/VywCqRU4UGnGbym027LcNCNKN0S2vjHFi5wvW7+WzHXma4raTs2jQt
         AQcjt2oUCUTXuSbGbqqsIkO7mO2ktrtl2SqTaQfdRQDy0se6Xo40b+koCvBogIbBel39
         OLfI0k+oaVeLmj8NKWkNZ8cfvOFV7VB3BXZz9eGnQD94Bo5HaGyVCYCCixkEQ9QsPosN
         6V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771606155; x=1772210955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UkcV0EKcoZWuSk2vrr0Y1tvsSf32bGpv8eTMpksOkmY=;
        b=LnX4VGFmdcRdfjHoJPmQKRqw5zPSt0So3M7D0u5bqpW5OGJ4Zu7cC+ehj9nPtlgHsF
         UlJE2nMOfQOfIZGqMr2tk2WiVdXz2i1cugk2taNpyLHOirMNMSqLmSIpde1UC1Y8RvM0
         mVwDdCQvU83dx1cnqBkT4BhylPOg9FRCKHi3dCmLFGIITnJQ3w6IByVXE5knwYd4/r5M
         9h8fxjUZS+VVV1QVYd2iHDl6YYf9vnP1NlRhHxEzG0U/uuKZmEzgdrjDdPAUiFaLoiCd
         QHilwzt34ySz19HcbBNWd+u3QEWR6GNxM8IqNkoF3R1ZlWgRwVthI/+hMIxo1uJ7Cxbf
         Di6Q==
X-Gm-Message-State: AOJu0YwTmasHwQEBoQhg8LEa9t00dbTxs5XKQ9zmcl7jOvnc9H2EeTKH
	6SWHeoD4lHZXnRCGH+2LRS+EP1szx/U22RcSrQ+vE0BnZGJe24sIKucIwG/fZN/yhuG0nQWw0T0
	0w3rpCwcUfVmj
X-Gm-Gg: AZuq6aKCgcv37gbxa1rIAkm/FaU2xjIRwtGnBobObqlXy5N2Ju7EMqqI4YytvDrAfoJ
	SN1q+GO9G1DCFd84wZObB9zC1dr3Ne/aGxK66oxtYt1QMOPg8OOqlhCVd9VfIlo3x2ASZrAkHVO
	gHv+hyAFL48S9Xi41pienNl7Y4rhyYw+F6VrjvqiRB7A7XnY92iLeTeoqUZsvxOM0KujItXbB7e
	0reub4u31F3OI9mnyidxq8xsjEobBQgn9QCixqJdVc7uU6zf5GjrL6eSANYLHhGv+QjBZkbywK5
	595dVkXh9quTU3/Svj1i0lodlOM5gOz5Le/inLkapQtGTKnoTUmKJ5W0Nmm49CjlJIPxB9S538q
	Dx2hAzjbnxzJ6tlmNX+u4KWqS6RJWtfWNoTM7KMSgmbMqPFm07lBN0pBIRDb4Q074yZjIPCSIux
	QmYH53WsoltnqXJosaqm5iSeoN42Gn79pIWhzZ
X-Received: by 2002:a05:690c:dd5:b0:797:ffb6:fd5d with SMTP id 00721157ae682-79828f07419mr5859917b3.19.1771606155293;
        Fri, 20 Feb 2026 08:49:15 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c16e7c6sm145892807b3.1.2026.02.20.08.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 08:49:14 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 2/3] bpftool: support merging multiple module BTFs in btf dump
Date: Fri, 20 Feb 2026 11:48:46 -0500
Message-ID: <1d82d75af9211bf359088b3a1b09ee69e3e6fe7f.1771605821.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771605821.git.josef@toxicpanda.com>
References: <cover.1771605821.git.josef@toxicpanda.com>
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
 tools/bpf/bpftool/btf.c | 126 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 113 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 946612029dee..be546a6d222f 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -28,6 +28,7 @@
 #define FASTCALL_DECL_TAG	"bpf_fastcall"
 
 #define MAX_ROOT_IDS		16
+#define MAX_BTF_FILES		64
 
 static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_UNKN]		= "UNKNOWN",
@@ -958,20 +959,118 @@ static int do_dump(int argc, char **argv)
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
+			btf = combined;
+		}
 	} else {
 		err = -1;
 		p_err("unrecognized BTF source specifier: '%s'", src);
@@ -1445,7 +1544,8 @@ static int do_help(int argc, char **argv)
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

