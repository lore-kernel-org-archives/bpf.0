Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702667;
	b=eYLVu0ADsNEYnTkCifJe9Gupolao0r7qzPU3tA3yexiBlb9pFoFgeJmGpc9tsrFnyCLd
	 631ytAElSahxwrOLHte8rIFFJc6AfIQhRawXwXPqoaUBV9DP2tiqNHwgAfFQFoEsBI/cI
	 lmTy3VG3B0ZuD7nVZvOgmlO30/xitx5xPn/swnjK0PbiJXAeMKFyuFebF42grP3GdF9HV
	 QT7sxx+gnnZpWC5cJOygHz6AYuwR8dAh7Qdj9P8cLsenbmsO55rpbHaCbqAhCaHBpEaNj
	 h0CrCjSmWuDcTKKm8Uqs1TFk+H6Y0T0nVPOHvqvqfum4pCm5EKacb+zlAcxm+sVLkMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TEG9M41Q8ewXtwGQfG4tnvfBTrejLAcva0flrqD/WdY=;
	b=bH7Uwz8/ojq1Ma6u5nBIZMwNmO6+getRQ70v/80xK9rSgpE4OSNnUdghM53x8da04Ej2
	 j/pg07r+sGfb8mC6u78rceiRE19udnIcDe65OsHXFt6GalvPdxQjcFCMevcW+bwItwm9X
	 bsFpNxos8ClVg7leaZflo1KI7G7Zu+9jF7KeWnfTG1VqvvD0olbEfYLVbU9mcFW00Ud4u
	 r1dMJCxuRXRTiknh/Hr9khmgjOtQTk5lguGnDtfUAN7UHwPY2q5SP3CwCFtFkwrLvWtYA
	 aFyUojrI2q8PjRxTl0TnT6O7k1/Fn6K4HQDFUllVfqCRtbdp62zbmSF7Ya+tuZtsBIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UUExD2lS;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD45606A331
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD45606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UUExD2lS
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so57390145e9.3
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702665; x=1796307465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TEG9M41Q8ewXtwGQfG4tnvfBTrejLAcva0flrqD/WdY=;
        b=UUExD2lSHlv1C8XJ58Swk3tRE7jjkVbazal67gFvBdd/yTOZvUw6ioYN6f2rHKrA5u
         5ER4A6LttQZ8lxmyQHQ4iasQQq5ftufLqJiAd9jfjNoVPHmLWqHmFQYOXggJXMNJKKqq
         8MOOlGOICHLP9M6QJAJ2iJiUL3B7z4pjPYe/qlUDKtahfGzly0YAkygyECZAg0W9p5T1
         NcSjLjIbHpbA1iHK0evCtQIw9+fm3Df/kW+akbC2F9mJXpYngRdbe+AXiiTwmexjiHeA
         A2+I90v7XkYlP5zIplBKPRceHKa3O0gwlbGlOL8mcX6Qb85mrxr31+6yUq7NhGx/cOty
         ptxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702665; x=1796307465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TEG9M41Q8ewXtwGQfG4tnvfBTrejLAcva0flrqD/WdY=;
        b=cL1r2eSFPgfvM7Ta+6bu8T87mVovSSAHupwl2x6xFRcKcXAX5cRZA6B39qGl8QrPLa
         Ma4P1202lRpnaH/JphDeIIE2WFEXu8Z7cjixTqrS33YBo8DaSkx/ZV/RPsZyieJI9v0W
         Mhh9F2iIvEi1EW2JzJQe9EVcKKxhg6cWmcywCjBusR84kpDnthBE/KuxfWwQ1KVOZLm0
         hsSAxJeZvz/J6sjmR59U2HXUgcShRiK4+iPvtKHJIWd3KjHcqjGXVHWsoW1Stnukz0Uo
         Chs8TqSPkTmBKIWhcUh6hqaRMD2mcQnvZMdWaOPv88mDWV8qc0jJ82xczS3Fqqr+qSzo
         t6aQ==
X-Forwarded-Encrypted: i=1; AL+hErFKM54d4nh+Ky/gvydYRPzX+rpsRxcaifC6LhJcBY929wCu0dchMSmxIpcsqaIKRRMFhrI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SC3qUVz8g513WLz1Q+k8BSH3Ntv+uDSO5pcf8ICrjv5HQrURE
	KjAECRDMEN4oHEmSI7dRNihtrNcjjNCSy38ijQdORbx3T5miiC6swyfL
X-Gm-Gg: AZFdTZeoAj+l9iKL+3a1SEhdyibJ9SQs2xe5wL1VnYfqYjDYKWykCNEomUYRotJZWpt
	99ld5tZx64X2x5KI5FUMV2Tuw8bcfHg6a7hCbT+BQUZyXDCGuq9A9yyWOEyTh786oESEM4yqa3w
	HdNW/z/PBFXThjVqVyLr9RBro6ZgHUJuMsZHKcq8OrPPvml/+H1Xs3grCyUCGpW6joH43/j/A45
	s1WOegwqxSB1KEqENmvjuDgHKwnXV64Lh0yOEkyX3wBhqwI6x2Akx1kncmJh2alDkvelnj7Ppgu
	WEfsdrfINBaQZRON+5k3rWAam23Ll5LDi3vStxloLwgfyiG3pmc9dFv1zhhrPKlsYdexXk0vAc7
	d07bNJDysI+HNEBA+/5CfuIddSVQe+M/QqG+Mh+uyw8i6Ufy8+lr15mstXmc0rOQQ8hyOIqN29U
	wSF5cuLwgVDb30FFXivQLnSQ+DNOSd+Tgiv7eKrmEFoF+3V5+HarzQoywQ/XoKPj+JNnpKTCOqZ
	0C4AJDt1W1axGF1d4Voj5w/aV7dGfpr2iGDMl+jPwzD486BGQy+xF058Yz9v8gF2/jSfcYN236H
	tNCTOpXsrVq15zRpPjuNBDjwygCUynxaV7OU4fk6FGzoe+E=
X-Received: by 2002:a05:600d:82e4:b0:4bb:6847:7927 with SMTP id 5b1f17b1804b1-4bb8882677cmr449695905e9.7.1795702664892;
        Thu, 26 Nov 2026 06:17:44 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm596496575e9.5.2026.11.26.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:17:44 -0800 (PST)
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
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 2/7] resolve_btfids: Do not tag functions which work on BPF objects
Date: Thu, 26 Nov 2026 14:29:08 +0000
Message-ID: <20261126142915.1106330-3-a.s.protopopov@gmail.com>
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

A program on tracing_iter_filter() which returns -EACCES makes the
verifier miss that a global subprog throws. A function which takes or
returns a bpf_* or btf_* type, or struct btf, works for BPF itself:
for the verifier, a link or a map. Do not tag it.

__sys_bpf() loses its tag. A program can still deny a bpf command on
the syscall, which is on the error injection list, or on a
security_bpf*() hook.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/resolve_btfids/fmodret.c | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index e1afdb6dedd5..aaff58718da3 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -56,6 +56,37 @@ static bool fits_trampoline(const struct btf *btf, const struct btf_type *func)
 	return btf_vlen(t) <= 12;
 }
 
+static bool is_bpf_type(const struct btf *btf, __u32 type)
+{
+	while (type) {
+		const struct btf_type *t = btf__type_by_id(btf, type);
+		const char *name = btf__name_by_offset(btf, t->name_off);
+
+		if (!strncmp(name, "bpf_", 4) || !strcmp(name, "btf") || !strncmp(name, "btf_", 4))
+			return true;
+		if (btf_is_array(t))
+			type = btf_array(t)->type;
+		else if (btf_is_ptr(t) || btf_is_mod(t) || btf_is_typedef(t))
+			type = t->type;
+		else
+			return false;
+	}
+	return false;
+}
+
+static bool has_bpf_types(const struct btf *btf, const struct btf_type *func)
+{
+	const struct btf_type *proto = btf__type_by_id(btf, func->type);
+	unsigned int i;
+
+	if (is_bpf_type(btf, proto->type))
+		return true;
+	for (i = 0; i < btf_vlen(proto); i++)
+		if (is_bpf_type(btf, btf_params(proto)[i].type))
+			return true;
+	return false;
+}
+
 /*
  * The codes of include/linux/errno.h, 512 and up, never reach user space. They,
  * -EAGAIN, -EMSGSIZE and -EINPROGRESS tell the caller to retry, to go on or to
@@ -220,6 +251,9 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 		size = int_return_size(btf, t);
 		if ((size != 4 && size != 8) || !fits_trampoline(btf, t))
 			continue;
+		/* Skip functions which take or return BPF objects */
+		if (has_bpf_types(btf, t))
+			continue;
 		/* Init code is gone before a program can attach */
 		name = btf__name_by_offset(btf, t->name_off);
 		func = image_func(&img, name);
-- 
2.43.0

