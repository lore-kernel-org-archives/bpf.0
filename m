Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795654442;
	b=opnGvnhAiZg7Au39SmaZVr/eNlnJezznzR+DKNQgNPfn94GGVa5hY7nbnS+Rhc0Bls8m
	 eMXB++31f4SDcBwfxgv0wmn0DSfcU1lw4qT0WEcd7d/QhGq8huzkt1eLnU37p46c1135A
	 aNFZNZWrIkPrnrgihskZZAXXuSHLABQ7xOv2M784pYGSTLwg+6TRfoN03DlBXkRKBwWEG
	 IhzV+NhBV8a6fY0pXXlh87ZYc6FhT4pzQmX/kLK5irH/8YAxp9Til65outNUX4VQO38z6
	 Lo2dAxA9ZIeE8PryanXDqQ+oispZ7eMICGglsotw8nhO5cEHt18UTJLeYjhG8+DvZtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=98cf/8mtmNoT8GGw7cQ1J4o8GeVXMUs//JNPNbEqGKE=;
	b=i0LCKZgvSTaswRS00bSSX1dT9C0tlQ2uzWA/76jx15KkT+YvJpuwwVWpRd7DakTmXEDh
	 YMpxob50d8/tuf+emSMYIa6DM53KfIN47iMle69vKl01uIAx6UmqO6QrzrVCLS+YtP6Tn
	 0/QHa9b71TmdjnDZHjALxXK67C/QTVv/b0jMEBQ6NoQnvoq1nsxgh2v2eiWYQkz+wXg6H
	 QXZpSxnYrRcuzP3zpiQ8kX3wFmwRLCLFwDMNs7BJ9BPMec/pqUiZRrTPiYYsB7WnDmnuo
	 674qeIpIXN7z99cThucTj0f/iQe1v9eSunrG8IP14ZspuBnZXRJuwLUBKdnbgSSVxdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pRM05+HA;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4D606A688
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 00:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B4D606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pRM05+HA
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so5241399a91.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795654441; x=1796259241; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98cf/8mtmNoT8GGw7cQ1J4o8GeVXMUs//JNPNbEqGKE=;
        b=pRM05+HARc9+7hsQ1mFSA/W5myrL07S3NZNghmXFdsWRY0Y9d0ZDIiIOhzxfUEoX23
         ksy6KDyFb/nZRfKUEliM8ZuOiOuKIlezmxJhhavQlsN2FfLOaKK2ugyTd1KHssXxwSL3
         f/6m0WMcmX7DHE/reSp2RyNeI4L21qmRuhsoPvVL9cxL1JN+gNxCCBvaSoDaNlPSPoai
         h1deVE/cwqIQIsrzzbH6PsxGx6ACnWk5OEFj4xRbtLWmIERVcJVpfO0ezWpfLbLrMvFP
         aJAFiouUcT7R4uAbfNepM55VWpHeWQSn62+3T+A+wMIjmWS+4VQqSF9h/xDkUhRAOt9u
         gK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654441; x=1796259241;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98cf/8mtmNoT8GGw7cQ1J4o8GeVXMUs//JNPNbEqGKE=;
        b=h4B/YJuY8PDOhxKLpMx/tFygnJAIV4x1DbD3tT18nEpyFZZxq76NuTCgojtBU8zwnH
         +Ji8IzxeMW6GtOl7bpe30nE8opN/REqAFqEGHkxqP6ryMCJX9xy3IYOV4n69R636UWzO
         xCQsT5NoS9nGTW383QJF2waOEOXO3Xg8gn/tx+IRSriQmNshte5vh4rExSWCcCPqB9LS
         FNDWHdLmht4yqxonkbdJA0PnEeWLhS68DdIc4ZvK6y/W0/P7+6pKkF29VKSkNjzlUVhI
         TiQTGibEGhFAH0rHrF2vc1URK0eucB9UTW55+vrfG1e761XrOo3dW6IU17IG6TADXJ4v
         9WGw==
X-Forwarded-Encrypted: i=1; AL+hErF82j1nFso0zHYkN6nPrihINoLD78ueDhrA1OuCrELhGrfVd0RcmLx9EultvQfBxk+dS54=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nsP2zuKPktPcMaX2B7JOiR9EWpqSGutGCbs0Vi24YmGa3vM0v
	JkStY6DwoO6H9DzyRXUhdlTBSfvdN1816rTX9KOqw4C/9GB/rfENx21j
X-Gm-Gg: AZFdTZdzAGlSMm4HJosysK7tIw2V9C9W/yN/8TwTRFPBRHVrRqosRTJHkF9DX63d7k1
	w43DITBmT9HaMFty3siyqf/AhSfykovVT7ZeCAhTbuYFn5tRbJtY3Jl4SSZ0Jdoo0Qwppj4JYlv
	3E4vyYhuwPVhS2cWBFVRvw3uOAzlrfq9Vaq1Yoj5iZQ01b41X8rpYiqyGBG98pDgI3V8XT12DX6
	4UTEtDIxUDrroOTWRgjxcBTRugLJ9ePhSQqa2IGxI2jOwF8NePQfEbzJIv1K3ommwUFCqCu62Ik
	Wy0ACfVvNKozaLvzxOwXuTioQM2mzHur6oO9n+TwJnOJxp52iasQtIgb2PhO2g1jkzY0Sj55Q6H
	riypDaWp43SVQIfucOpC5rs7571AydmQ2HGlNQJVZylcY8iPWCcYrHadX8X9BXsm1OSYCj7+YmW
	cvWz6yWE+xzSukzs2EYqs/PVvpnDOz7mnHcBByNa8qw846HDbC9udjE44AAYXZThgohvrGc8VBD
	NOXAgaHsWpBMxuVR+jpTLbwsxICXQLUHB7CvF9mm59dAmCHhGP80k3lmehxXK+JqR5aZ1L0PoPn
	MQMRNC4c8Z/hcs8apArShnKgHEXL2IAZGt13pnhP8WIDAmyXttY5cHVaEWjXCMhx/JiyE5f5qYW
	996WLlN2zAt2T07BBOvF7iuQIuVldUQOGaA==
X-Received: by 2002:a17:90b:2416:b0:3b4:a6ab:b841 with SMTP id 98e67ed59e1d1-3b4a6abb92dmr6670700a91.32.1795654440645;
        Wed, 25 Nov 2026 16:54:00 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b495035339sm17006163a91.0.2026.11.25.16.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 16:54:00 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 00:53:59 +0000
Message-Id: <DN4QDHMFA99A.27B7GAJLQQ7DK@gmail.com>
Subject: Re: [PATCH v1 bpf-next 4/5] resolve_btfids: Exclude the code of
 kernel/bpf and of the JIT
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Jiri Olsa" <jolsa@kernel.org>, "Alan Maguire"
 <almagui@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 <bpf@vger.kernel.org>
In-Reply-To: <20261125212849.868523-5-a.s.protopopov@gmail.com>
References: <20261125212849.868523-1-a.s.protopopov@gmail.com> <20261125212849.868523-5-a.s.protopopov@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 01:28 PM Anton Protopopov <a.s.protopopov@gmail.com> wrote:
> bpf_tramp_ftrace_ops_func() and bpf_arch_text_invalidate(). Read the
> symbols of kernel/bpf/built-in.a and arch/<arch>/net/built-in.a with
> the llvm-nm of llvm-config, which reads ELF objects and LTO bitcode,
> and do not tag these functions.

bot is correct.
Let's run ${NM} in gen-btf.sh and give its output to resolve_btfids ?
kbuild knows the paths and the arch. The tool doesn't have to.
${NM} reads what ${CC} writes. HAS_LTO_CLANG requires it to be llvm-nm.
link-vmlinux.sh runs it for kallsyms already.
llvm-config can be of another LLVM than the compiler. llvm-mc.sh says so.
image_func() finds a function by name. No need to copy and sort the names.
Then LLVM_NM, the nm mode of llvm-mc.sh, bpf_archives[], popen(), qsort()
and bsearch() go away.

It replaces patch 4.

diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index b17f118..341885b 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -75,8 +75,17 @@ gen_btf_data()
 		--btf_encode_detached=${btf1}		\
 		"${ELF_FILE}"

+	# The code of BPF itself is not a target of fmod_ret
+	fmodret_deny=
+	if [ -z "${BTF_BASE}" ] && is_enabled CONFIG_BPF_FMODRET_SCAN; then
+		fmodret_deny="${ELF_FILE}.fmodret_deny"
+		${NM} --defined-only kernel/bpf/built-in.a	\
+			arch/${SRCARCH}/net/built-in.a > ${fmodret_deny}
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
index e1afdb6..d2fa9b7 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -188,12 +188,41 @@ static void set_protos(struct scan *scan, const struct image *img, const struct
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
+	bool *denied = NULL;
 	struct image img;
 	char counts[200];
 	int err;
@@ -206,6 +235,11 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 	if (!scan)
 		goto out;
 	set_protos(scan, &img, btf);
+	if (deny_path) {
+		denied = read_denied(&img, deny_path);
+		if (!denied)
+			goto out;
+	}

 	for (id = base ? btf__type_cnt(base) : 1, err = 0; id < nr_types && err >= 0; id++) {
 		const struct btf_type *t = btf__type_by_id(btf, id);
@@ -225,6 +259,8 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 		func = image_func(&img, name);
 		if (!func || !strcmp(func->section, ".init.text"))
 			continue;
+		if (denied && denied[func - img.funcs])
+			continue;
 		nr_scanned++;
 		err = scan_func(scan, func, &values);
 		if (err == -EINVAL) {
@@ -257,6 +293,7 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 		printf("  FMODRET %s\n", counts);
 	}
 out:
+	free(denied);
 	scan_close(scan);
 	image_close(&img);
 	return err < 0 ? err : 0;
diff --git a/tools/bpf/resolve_btfids/fmodret.h b/tools/bpf/resolve_btfids/fmodret.h
index d61a9de..177b116 100644
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
index 0ac8952..b277a65 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -2100,6 +2100,7 @@ int main(int argc, const char **argv)
 		.sets     = RB_ROOT,
 	};
 	const char *btfids_path = NULL;
+	const char *fmodret_deny = NULL;
 	struct btf_links btf_links = {};
 	bool fatal_warnings = false;
 	bool resolve_btfids = true;
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

pw-bot: cr
