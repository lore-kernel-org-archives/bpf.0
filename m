Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702670;
	b=HO2Obn/itI3s4K8ug7IajZBoEYQgWgQ6PqZi5ePyydhUJhTVD/LVstvR6i6npJbpjkVK
	 Jcd9W0JB+JUazSUhFOv4G/xrgauxdqTY9rYBsTNEi3BDmYTLzsFISGk3WM4n5Mr77ZeXG
	 LYK9SQyq3wBBZOV+WpLHjTDnBFMB0HaxUiqn6JCnzFct5YhYU2m/mRJXzQ6mvARzkI/uZ
	 gjGio/Lqbh7AAL1bT50fnm5BTFXWcf7vf6m8Jr8f7QGw4/ty9SezzOVJMXmpDiAZPA9Pp
	 AkHdLo+UjeimeJxDRMQindab7w9Y0Mk96ERRlmXoQjKR+jfvM0LSt3N5ZjPI37V2K0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=17XzwJZHaXw2iP9Xtn7KbSmnh2vUxKfC3HqCGjI6V7w=;
	b=VgncKvHuOkISUq3QH+yiTvgQbmTE9oxpvYhYJOls3Uh5ao3DZdU+Uju0EFO215vgSHFF
	 lrWwd2o/eVgOU5xDRhxEH/Y/oJK9hueAStBahUHm9II1ew8NGR6Bt1VZOXKVs5/xVqOiU
	 UqPzOj1o6+Hu44Nh/KjXARDr4pmX5yJ/yzfpFp52L5naBSf8Idn2vXZLps+3yQlG5evAr
	 Cayr9W85J1vD+x5ZQSUQ9CiuHgAvU5yQrZRoxWjWLYzTdF1ZB0yU6yI6f5hRdbrPqciYb
	 ziJaFELPDrVppOg0B+14bigMrjIKwjomVm9bWhKRqdt9zucabtc1flJyhZVeBoH1ToA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MzmZ2DhO;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504A606A32D
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2504A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MzmZ2DhO
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so61464875e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702668; x=1796307468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17XzwJZHaXw2iP9Xtn7KbSmnh2vUxKfC3HqCGjI6V7w=;
        b=MzmZ2DhOhporVUizhs0OoW9pvh807IwWo07pcwOjG8f3ZPhiQ1dcZ5v5SPG4W7PoAx
         9Vk9iWjC/j0z62FfFGI5oGX5rB3C8usjJLa02E40UntW/MwNzPw1qmpa1aEEBx9ivxLh
         vM0PCm65tDDP/dXn1VM2N8Rc98YBhjZHgkOE7mR28zLsnGHMS0KjWm0CsrI+8owm2ezY
         xrNNyfTLuqTJnaTIgafCE0ElhCeZUTX3kH2dRPltbhd3VowuosxzuxQN+cMGOoucruLI
         1ppOMTJ2FtCnFJjhnqmDH4HAQE/EuMqLOBAxnwJGomN0Y4F//lZzBHIeQFilUJlmkO5u
         aLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702668; x=1796307468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=17XzwJZHaXw2iP9Xtn7KbSmnh2vUxKfC3HqCGjI6V7w=;
        b=eOL9vHdsD+cyEReqk/aTVnNPhYk8XXARzPiFAxVUcWr85sV6RNz7o3AuujHr82FFTI
         l5suR5BH1P5S0yH2dzXqX18Gvl4dn+Tty0HKOzs4C9w4+/yZIgjR5nTRuRgz1xri7npq
         ztXrDo9P0mfK/BntAnsU8iovaU9bX7/bphF8N8CzrTHPaxpaG34wGzzCrYQvR8DzjU0z
         nw3zEgj0fVEtf2fFx5lbukmoa6vdoxZ4WFN+BWHYnAfxKSX8YkYiUEy443eYS0eQ2ir4
         rpQPn7qipKcCcMpV3wwqu8ZY8o9HIduB1Vn3VjxHBouS/a+qbCzA7K4q+Fxd0r0LwgWq
         lHAQ==
X-Forwarded-Encrypted: i=1; AL+hErF+VfQpbZ5ay4W9CEloZvOmT0eA0GyWGGpbXy784oMc7B2zrrtuHwQj4he9Nl5ONF51xZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8C8W1eTODMebhUkRbfxpYWFctbVliM5TUTg2kHg3JaHfysDRe9
	MtZLfdX3iNOeea3TAtn8vYZtK3yLbQ+am1ckEJi46XTWbsISnzREKHKV
X-Gm-Gg: AZFdTZcdrNwxWXy9ybmjkhQ32A00vBIYnFd+andrYgxjrJ4L2XmcqkNAzAI272cZcYk
	tLjWXh0xtPhMfQZcawvzZS8XzG1X7Lv6uz/+DlDpY5DT8U/AzcfAlY81pIz7cVwSMPgUoMcog0T
	Qs4uunjXSY7RDCg6EzjB94QiahuyZhR+ipWNzRhMwgbJ+fxmwfvrTK3k/frBqO1OHg0tInavfhK
	ssUCv/WgFDtXm88JQE2Q4Rw+cOGFZStD9PgPTvGNqd7olMSPD2tZV+vrQcbNm8nlrXC7X/Xy5Qn
	jABt7OEIj5yGLIx9JeG1JzCRTlsi/NDtT367XBvmTDp2tY2JqQY4qh41e5Pxj3ZmqUhO+ey0fdK
	kuv5dVc6hRyWRsIrxO9MGFQRYBzpDzKSFauPfWAqLOvOlqkct1kZ3qacKzWW3k+zh06zT2pS8AY
	VmRqJytaf5juWTc4+k1Zv3nUDFSgOfcEujvPR7cQ9KW2EQAG3L6CQOqf7HetyMkLUOzKTw35ikE
	jWaFMPsHXeVjsooaaszp1P9oaHWeYkwEaxN9tqMVikS0o83hUT75ixJLe1NY6B0wiJ7e3aq+qnL
	MjGx5d0dUgLyFOlpI0IICO9qMsZC44lH8qOCI0DGvHgPkus=
X-Received: by 2002:a05:600c:19d0:b0:4bb:65ed:b55c with SMTP id 5b1f17b1804b1-4bb88824b18mr433931305e9.33.1795702668377;
        Thu, 26 Nov 2026 06:17:48 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm596496575e9.5.2026.11.26.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:17:48 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 6/7] resolve_btfids: Exclude the code of kernel/bpf and of the JIT
Date: Thu, 26 Nov 2026 14:29:12 +0000
Message-ID: <20261126142915.1106330-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
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

Not every function of kernel/bpf and of the JIT has a BPF type in its
prototype or a bpf_ prefix, e.g. check_attach_modify_return() of the
verifier, range_tree_set() and btf_get_fd_by_id(). Let gen-btf.sh
list the symbols of kernel/bpf/built-in.a and
arch/${SRCARCH}/net/built-in.a with ${NM}, which reads what ${CC}
writes, LTO bitcode included. resolve_btfids gets the list with
--fmodret_deny and does not tag these functions.

Weak symbols count too. Only one tagged function outside BPF has a
weak copy in kernel/bpf, skb_copy_bits(), and it loses its tag. BPF
helpers call it, so this is acceptable.

Co-developed-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 scripts/gen-btf.sh                 | 10 +++++++
 tools/bpf/resolve_btfids/fmodret.c | 46 ++++++++++++++++++++++++++++--
 tools/bpf/resolve_btfids/fmodret.h |  4 +--
 tools/bpf/resolve_btfids/main.c    |  5 +++-
 4 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index b17f1189298a..af40d746f218 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -75,8 +75,17 @@ gen_btf_data()
 		--btf_encode_detached=${btf1}		\
 		"${ELF_FILE}"
 
+	# The code of BPF itself is not a target of fmod_ret
+	fmodret_deny=
+	if [ -z "${BTF_BASE}" ] && is_enabled CONFIG_BPF_FMODRET_SCAN; then
+		fmodret_deny="${ELF_FILE}.fmodret_deny"
+		${NM} --defined-only ${objtree}/kernel/bpf/built-in.a	\
+			${objtree}/arch/${SRCARCH}/net/built-in.a > ${fmodret_deny}
+	fi
+
 	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_FLAGS}	\
 		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
+		${fmodret_deny:+--fmodret_deny ${fmodret_deny}}	\
 		${inline}				\
 		--btf ${btf1} "${ELF_FILE}"
 }
@@ -148,6 +157,7 @@ cleanup()
 	rm -f "${ELF_FILE}.BTF"
 	rm -f "${ELF_FILE}.BTF.inline"
 	rm -f "${ELF_FILE}.BTF.inline.link"
+	rm -f "${ELF_FILE}.fmodret_deny"
 	if [ "${BTFGEN_MODE}" = "module" ]; then
 		rm -f "${ELF_FILE}.BTF.base"
 		rm -f "${ELF_FILE}.BTF_ids"
diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index d2d4db1ca3d5..b950d6b52554 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -266,13 +266,46 @@ static void set_protos(struct scan *scan, const struct image *img, const struct
 	}
 }
 
-int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
+/*
+ * Mark the functions of IMG which are in PATH, the output of nm. The line of a
+ * symbol is "<address> <type> <name>". The other lines have fewer words.
+ */
+static bool *read_denied(const struct image *img, const char *path)
+{
+	bool *denied = calloc(img->nr_funcs, sizeof(*denied));
+	FILE *f = fopen(path, "r");
+	char line[1024], name[1024];
+
+	if (!denied || !f) {
+		fprintf(stderr, "FAILED: --fmodret_deny: cannot read %s\n", path);
+		free(denied);
+		denied = NULL;
+	}
+	while (denied && fgets(line, sizeof(line), f)) {
+		const struct image_func *func = NULL;
+
+		if (sscanf(line, "%*s %*s %1023s", name) == 1)
+			func = image_func(img, name);
+		if (func)
+			denied[func - img->funcs] = true;
+	}
+	if (denied && !feof(f)) {
+		fprintf(stderr, "FAILED: --fmodret_deny: cannot read %s\n", path);
+		free(denied);
+		denied = NULL;
+	}
+	if (f)
+		fclose(f);
+	return denied;
+}
+
+int fmodret_tag(Elf *elf, struct btf *btf, const char *deny_path, int verbose)
 {
 	size_t nr_funcs = 0, nr_scanned = 0, nr_undecodable = 0, nr_tags = 0;
 	const struct btf *base = btf__base_btf(btf);
 	__u32 id, nr_types = btf__type_cnt(btf);
 	struct scan *scan = NULL;
-	bool *bpf_funcs = NULL;
+	bool *bpf_funcs = NULL, *denied = NULL;
 	struct image img;
 	char counts[200];
 	int err;
@@ -289,6 +322,11 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 	bpf_funcs = find_bpf_funcs(btf);
 	if (!bpf_funcs)
 		goto out;
+	if (deny_path) {
+		denied = read_denied(&img, deny_path);
+		if (!denied)
+			goto out;
+	}
 
 	for (id = base ? btf__type_cnt(base) : 1, err = 0; id < nr_types && err >= 0; id++) {
 		const struct btf_type *t = btf__type_by_id(btf, id);
@@ -318,6 +356,9 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 			continue;
 		if (excluded_by_prefix(name, !base))
 			continue;
+		/* Skip the code of kernel/bpf and of the JIT */
+		if (denied && denied[func - img.funcs])
+			continue;
 		nr_scanned++;
 		err = scan_func(scan, func, &values);
 		if (err == -EINVAL) {
@@ -350,6 +391,7 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 		printf("  FMODRET %s\n", counts);
 	}
 out:
+	free(denied);
 	free(bpf_funcs);
 	scan_close(scan);
 	image_close(&img);
diff --git a/tools/bpf/resolve_btfids/fmodret.h b/tools/bpf/resolve_btfids/fmodret.h
index d61a9de026df..177b116ee799 100644
--- a/tools/bpf/resolve_btfids/fmodret.h
+++ b/tools/bpf/resolve_btfids/fmodret.h
@@ -6,7 +6,7 @@
 
 struct btf;
 
-/* Tag the functions of ELF which return errors in BTF */
-int fmodret_tag(Elf *elf, struct btf *btf, int verbose);
+/* Tag the functions of ELF which return errors in BTF, but not those in DENY_PATH */
+int fmodret_tag(Elf *elf, struct btf *btf, const char *deny_path, int verbose);
 
 #endif
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 0ac895222a14..919b301e88f3 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -2104,6 +2104,7 @@ int main(int argc, const char **argv)
 	bool fatal_warnings = false;
 	bool resolve_btfids = true;
 	bool fmodret_scan = false;
+	const char *fmodret_deny = NULL;
 	char out_path[PATH_MAX];
 
 	struct option btfid_options[] = {
@@ -2121,6 +2122,8 @@ int main(int argc, const char **argv)
 			    "extract location BTF into a .BTF.inline file"),
 		OPT_BOOLEAN(0, "fmodret_scan", &fmodret_scan,
 			    "tag the functions which return errors as fmod_ret targets"),
+		OPT_STRING(0, "fmodret_deny", &fmodret_deny, "file",
+			   "output of nm with the functions which get no tag"),
 		OPT_CALLBACK(0, "btf_link", &btf_links, "section:module:btf-file",
 			     "patch a BTF link with --patch_btfids", parse_btf_link),
 		OPT_STRING(0, "patch_btfids", &btfids_path, "file",
@@ -2182,7 +2185,7 @@ int main(int argc, const char **argv)
 	if (btf2btf(&obj))
 		goto out;
 
-	if (fmodret_scan && fmodret_tag(obj.efile.elf, obj.btf, verbose))
+	if (fmodret_scan && fmodret_tag(obj.efile.elf, obj.btf, fmodret_deny, verbose))
 		goto out;
 
 	if (finalize_btf(&obj))
-- 
2.43.0

