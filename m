Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF62040B6
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770909651; cv=none; b=oWK0Sc1Fnw6vQu4aCeStQJV2eT9FDpoDJDC+ATDbw0DzG2Gp50ZILbg4GSSCAljSS5DPb/bR2DBJy92SmODoBkipenHvbMXkzQXfOt0j/omtJaiZDBtOb8brOkRys6SHZm702UnJ1Nr5N9x86wF23fbN2EeZXPcvmj0oSagPa8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770909651; c=relaxed/simple;
	bh=y3/Zft9RtaunwArVFlLk1lfDfG9fKjc0Fa8tLxaFbqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHAAagKwyehfvcf0rd6HbxvEdA8PN0ewACmFZpHAjQuAdq0Nd59KxU12efNpHBDQzeBOXutz1aLpzsCXUMMfsE2MWqk+23M++M0miaRR65AGgxaUcsCYWMO1qmXCFJKDfj/nenjCS3kL6u3tOo9n9CBO1W/uFFswyxhyB+wx/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0/tUw18; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0/tUw18"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a77c1d5c3bso13882935ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 07:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770909649; x=1771514449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDwv8yNiuDH+se7b+twM3cODmLXHz04TBPbHtHsRt58=;
        b=Z0/tUw187YdNXiZFHp/BkSCxh/HEWqla2ifS/+6fcP4WcDwPE6b4tgzdRX1gzzZ+eJ
         VQ9b0LqBXZ2+iV7imD7SltiHEATtmZTr6yFPU59HvQgoYPi8W+1+a0A7Ltnpyy2Xe9h8
         JFBKoXoaqhBvV9cC6pnPsiFyBkzu45A2gPtA2t8giyOZXDlmKJsPYNbwIFM8QILWTsC1
         /ckL3fejKYoA/E3Nxpmz7DKv7lh/8iApwFB/VxGGZV60YmalXw0f2d+UOcbkLFf0Tidy
         6KW9e4EX3YwuhYvnKYz2Y6JD+sgjht2XF7vMJcCBaRMXnzXKQAnutLZNZ+GVzxY9Yfx9
         tI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770909649; x=1771514449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UDwv8yNiuDH+se7b+twM3cODmLXHz04TBPbHtHsRt58=;
        b=d76ipspRQKyLbNmYO8GkQHjH2BH2TiDknhZimKxQabjuEiIc7F3QbpWS9v27vIngOh
         WzSeakDCHr/5+1u77fTBU+z+a4RmCKRV1BUAoVfEU3uwyFnuDEWa7SuTeadNv2js2Jv2
         V/837E2klg2/qPcK7APi24pjmz5OelysPwOMRaVlSzYOf5yGp5K41bs+TgRtopvrkc6T
         LZpGirZdA+IF/wbOXJhT5dyP2dHyQtcwSwf0XPgIp3QXraGn304zQ3kn/RgXwZEva0iD
         s4uSmB7RJmhh9NEht1DoFUq0zj1LlbKc0IZkkrEeW6Wl5CG0fThyuIn0LT+D9E0ya78x
         YYRg==
X-Forwarded-Encrypted: i=1; AJvYcCXrjvLlKrmBJ0tvoYvk78w+S6kgA1Xz3aRG96+s4Vb+s3bgIKj4izKguGcKOAMsCAe5ag8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAtKE5MihUBy3+YZlcm0dSCQa20LeMeifBIrIc4LKK6Vvr4URq
	bwxxduxj/0WzYYsOO3ItGh7rvVaADwmRGv3nukZfrGRcRVGqtaHGx1JD
X-Gm-Gg: AZuq6aKOd7XRtk6IZ4El7zDpkIMf33WCB8+7kCqUIFEDFiQYfd1+lN6gLRpjRhLAlsV
	NUnZnocYZV5vvD19JNkzXpCu03EHZKFpfwhhJH3zeRcV9eu9z17gujpV7NWqc0dauq8zCjztVyB
	bqhNFvO8EfPBnpPkoVgeC3OtaPSd89pTDaAcEjW2Rw8/h17ko0xd91K9AT4uMcVqer6qK9+6Zbt
	YsObqBAttCRTj186LqYiD3eDgRHN4u82uLXfwcjdJudS6ZwFhQQwRljZgQaP36xuCszAisoVNz7
	XemxjWeD1n77K3AkpLNc5k+GCGezm0nZznA8Cu5wzvppdxY9oRZMMmYVO7Tm/YP2vGRN/q1IMhz
	UAA1TfXhQj3r2D8uW1ZJTJdl50Zfot7o5cRe3udQLybJW6fqofmPhOZT6cP7kJXui4CEMulx9iH
	X6rPHk+6WOKOc/bKZzZJTTGowgPob+HTke/rQfJMe3IYOJoXhSszkrq2cQ5puB4x4tdRo=
X-Received: by 2002:a17:902:ce0e:b0:2a5:8c1c:744f with SMTP id d9443c01a7336-2ab3b258fbemr28127615ad.40.1770909648756;
        Thu, 12 Feb 2026 07:20:48 -0800 (PST)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b4:a82::10c:60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad4asm55943795ad.6.2026.02.12.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 07:20:48 -0800 (PST)
From: Varun R Mallya <varunrmallya@gmail.com>
To: andrii@kernel.org,
	alan.maguire@oracle.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [RFC PATCH bpf-next 1/1] libbpf: Auto-upgrade uprobes to multi-uprobes when supported
Date: Thu, 12 Feb 2026 20:50:13 +0530
Message-ID: <20260212152013.17351-2-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212152013.17351-1-varunrmallya@gmail.com>
References: <20260212152013.17351-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies libbpf to automatically "upgrade" standard
SEC("uprobe") and SEC("uretprobe") programs to use the multi-uprobe
infrastructure (BPF_TRACE_UPROBE_MULTI) at load time if the kernel
supports it, making them compatible with BPF tokens.

To maintain backward compatibility and handle rare cases where singular
uprobes are required, new SEC("uprobe.single") and SEC("uretprobe.single")
section types are introduced. These force libbpf to use the legacy
perf_event_open() attachment path.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 tools/lib/bpf/libbpf.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce4..a32f221d3245 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8265,6 +8265,22 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 		prog->type = prog->sec_def->prog_type;
 		prog->expected_attach_type = prog->sec_def->expected_attach_type;
 
+		/* set BPF_TRACE_UPROBE_MULTI if sec_name matches "u[ret]probe"
+		 * otherwise, leave alone.
+		 */
+		if (kernel_supports(obj, FEAT_UPROBE_MULTI_LINK)) {
+			char *probe_type = NULL;
+			int n;
+
+			n = sscanf(prog->sec_name, "%m[^/]", &probe_type);
+			if (n >= 1)
+				if (!strcmp(probe_type, "uprobe") ||
+				    !strcmp(probe_type, "uretprobe"))
+					prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+
+			free(probe_type);
+		}
+
 		/* sec_def can have custom callback which should be called
 		 * after bpf_program is initialized to adjust its properties
 		 */
@@ -9822,9 +9838,11 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
 	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
+	SEC_DEF("uprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
 	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
 	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
+	SEC_DEF("uretprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kprobe.session+",	KPROBE,	BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
@@ -12722,10 +12740,10 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
  */
 static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
-	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
 	char *probe_type = NULL, *binary_path = NULL, *func_name = NULL, *func_off;
 	int n, c, ret = -EINVAL;
 	long offset = 0;
+	bool is_retprobe;
 
 	*link = NULL;
 
@@ -12752,15 +12770,27 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
 			else
 				offset = 0;
 		}
-		opts.retprobe = strcmp(probe_type, "uretprobe") == 0 ||
-				strcmp(probe_type, "uretprobe.s") == 0;
-		if (opts.retprobe && offset != 0) {
+		is_retprobe = strcmp(probe_type, "uretprobe") == 0 ||
+			      strcmp(probe_type, "uretprobe.s") == 0;
+		if (is_retprobe && offset != 0) {
 			pr_warn("prog '%s': uretprobes do not support offset specification\n",
 				prog->name);
 			break;
 		}
-		opts.func_name = func_name;
-		*link = bpf_program__attach_uprobe_opts(prog, -1, binary_path, offset, &opts);
+		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI) {
+			DECLARE_LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+
+			opts.retprobe = is_retprobe;
+			*link = bpf_program__attach_uprobe_multi(prog, -1, binary_path,
+								 func_name, &opts);
+		} else {
+			DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
+
+			opts.retprobe = is_retprobe;
+			opts.func_name = func_name;
+			*link = bpf_program__attach_uprobe_opts(prog, -1, binary_path,
+								offset, &opts);
+		}
 		ret = libbpf_get_error(*link);
 		break;
 	default:
-- 
2.52.0

