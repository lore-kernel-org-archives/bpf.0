Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702668;
	b=CzkKBuX3XuBQI5j/VkPYO8D5BCAEThCQdM0xU+P7Tkqe+lJctLV13paYl1Dy4XK6kx5g
	 St2Ip7bNczFKEEO5BeCWXynnzmzvm+aQ3yBTTkWCacFWZDCiIHa7R2HbXx75OrAQTS6wW
	 qeSiY2gFghsoeAqfb75APC5lyq3zyqsBf48ym4jtnMTnMsYuWeGm0yVzJP5QNrF9+GFce
	 PEaFOmtanjbhRRAI2d2mmQZr8bjt+Ms02rNztm1rblnZes3AqlMc7pgBc1xWJssQE0bXL
	 8jkPbFuSDar4anyLDKQHKdScABkcl3Y1X3tD073bVap6q8pD0/ctarFhf7h3SHu5MDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ESoP+QJTuqfCDa+Xx4MimCnjj1w9fvQymlDowcWi3Hg=;
	b=pOQ5u6dZg8bjn9jk89VwKUdedAaznQZjffeyhcZzPyq81rZZeZY3Up8sXVhxRsRQXHze
	 NiX1i5jiTxUcFq281UpqhKiZqc+4P3ki/JaSRDyNWToQClCR3gsvXs/yqc6pFTdGX76d/
	 T+4MEu3Lv5ghPvzR66bQzk5Rp9tG7rsOyocdfufv3WdMxDMK6yKlU3gXR2jcaEwX6sQt4
	 1JwiK55Mhh5HTLl/fCmZwQvNjf/di1gABp8bXlkj5pGuUZ+ChOw0LlQTZQsD44VzLN7Li
	 gZJX5th3QMLKJkM4t/L5Gf8R+XtLwY1n9JE5gRzNko6BFTnluw0S9DuKO5SdKwLkupw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GuENOs5S;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5BF606A327
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB5BF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GuENOs5S
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so64287205e9.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702666; x=1796307466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ESoP+QJTuqfCDa+Xx4MimCnjj1w9fvQymlDowcWi3Hg=;
        b=GuENOs5SpPG8bp7NUUK7qm57sNJRJor3bxTF4Gt+aU2UvEMl6N2uWKaE9E+lJCjSnF
         AnaH0xmCB92+rsVQWMMAy8g2u62n4t7Nx0/AwbmDJ4gIk8lneBn+lm6WRIU8vgfbftwJ
         75HRsTC5DMgW/p2Y3i6mDsIA+4Dklr4WGl7PED/bdjlb8H4Uq5iMXSTe+eY178KvkePL
         E1wmnrsZWQNhPDaB0/vi+wZFsVe6/Ec1EPsI8kGt6Y0L87pDWb1FVMkGkTpqa36oQV+2
         tfpM/57VHasqPF8iWSLgs2KLjs+OUvi2IH3TmaNUVU3q9jbexZ447ZykYOEt4ls7LsUd
         7dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702666; x=1796307466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ESoP+QJTuqfCDa+Xx4MimCnjj1w9fvQymlDowcWi3Hg=;
        b=Wq9lmobqKTNqiwK3Xath7ViI10bQFKwfsRS1CkkZ5qLce8U71YYjPbZnel+KuE9Nk5
         Py23aEFvxLggXKXyMPKhMrn27sBdKac6EBn2w1SYXw0gCfsW6kDqT4OWAvQW1vBF3pmZ
         mdP7oLmFc328t1QdiS8fIghovf2euSgrH/u7vNwIRgpEb3xbfa/V1fPB+E54Rab7C/j3
         nrV1K6YEg9Ocln0PuG93VVR5FHb3vJO6WAwNXwmIKZgdZjfhe7+9Cmly6LVafTi11HcQ
         mXcUfzh0adZqukrdLqQ0h4dCMqqkFnJ5v4p3A9yKzF7eXpowp8DHTZW1czeBvd+61Sqs
         0prQ==
X-Forwarded-Encrypted: i=1; AL+hErGe7BKUNk/HomOAu1iq11tG/QnnsWUp1fhwg27aILzZyopWXVRf1e8OBT1qYCROkYsUDbs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IHEONyhP0YoXKml65YpZUTFE+WKH1vQ0/tm6PeYPlYph7ILl1
	nD5AUPWU/Fb9N4VsvFr09OcfiDUDSg6OZ35Mur2zmkboXwVcxWd/ucU/A657fw==
X-Gm-Gg: AZFdTZd0CCEYUMiFHmOYdSUosi+ByxaEuAh6ka8Z2VgYRvfoyZrpP1++cMayLfDdZwF
	tUrLop1/gVCJR2FsFuN6NBSFfi7/1eE9Od0CBI7lL6BWuHgaYa42aSDsh+tIOBRnAnalIs3YBJl
	1hSnve6bLgNxV5WCGVx7UesODjCzn86mn+WmXp6TLpaJ2baxDYXl2T8fgSS9vCz62ZCJceZIp0Q
	XlFOIHSEXUDxfP/O4U4ipSmtcIqCJFHeYBlvZOpuLAhB3+XS9S7AMRwsmKQmOEYzUlmZpeeES3N
	hMN69X0iy/49aStifWR9enSxN1j92Uk/KsFSzzJrMLKmKNOGMJ7T8XMyPGNWMj2eSpwkPdawP6c
	1bC0QSr4nIMy3bHZHBvFL5FdVPEIVbPzYQ4gVs1aIpLCgsVVYhxYqu8ZP7/aEAdhJ38MnFUQJz7
	Fwy6s3WBzm5Q9DM77u90DXsmWz2E2gKldJ8172xvZH/oJNnlfW9grCE3YKawv/9OLy+394Mddfs
	pCPOYgvgc0/NhvBE35Kb8hvQ0TUV5ehrCVZBVKAKcNzg6ra89M0Ij6afXYnBFmluGDUxQQLpKN1
	6MGTVsiYegp7ISAYsUPM03TE/uh9I+IuDIT3vDkJvIXWroo=
X-Received: by 2002:a05:600c:848a:b0:4bb:6626:5a25 with SMTP id 5b1f17b1804b1-4bb88813462mr364760015e9.20.1795702665812;
        Thu, 26 Nov 2026 06:17:45 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm596496575e9.5.2026.11.26.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:17:45 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 3/7] resolve_btfids: Do not tag kfuncs and helpers
Date: Thu, 26 Nov 2026 14:29:09 +0000
Message-ID: <20261126142915.1106330-4-a.s.protopopov@gmail.com>
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

The verifier relies on what a kfunc or a helper does, also on an
error. bpf_skb_load_bytes() clears the buffer on an error, and the
verifier takes it as initialized. After a skip a socket filter reads
what was on the kernel stack.

Do not tag the functions with the "bpf_kfunc" decl tag. A helper
takes only u64 values, so the bpf_* types do not tell it.
BPF_CALL_x() declares a typedef btf_<helper> for each: do not tag the
function of such a typedef.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/resolve_btfids/fmodret.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index aaff58718da3..7d26a5c9b028 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -87,6 +87,29 @@ static bool has_bpf_types(const struct btf *btf, const struct btf_type *func)
 	return false;
 }
 
+/* Find kfuncs and helpers */
+static bool *find_bpf_funcs(const struct btf *btf)
+{
+	const struct btf *base = btf__base_btf(btf);
+	__u32 id, nr_types = btf__type_cnt(btf);
+	bool *funcs = calloc(nr_types, sizeof(*funcs));
+
+	for (id = base ? btf__type_cnt(base) : 1; funcs && id < nr_types; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		const char *name = btf__name_by_offset(btf, t->name_off);
+
+		if (btf_is_decl_tag(t) && !strcmp(name, "bpf_kfunc"))
+			funcs[t->type] = true;
+		if (btf_is_typedef(t) && !strncmp(name, "btf_", 4) && strncmp(name, "btf_trace_", 10)) {
+			int func = btf__find_by_name_kind(btf, name + 4, BTF_KIND_FUNC);
+
+			if (func > 0)
+				funcs[func] = true;
+		}
+	}
+	return funcs;
+}
+
 /*
  * The codes of include/linux/errno.h, 512 and up, never reach user space. They,
  * -EAGAIN, -EMSGSIZE and -EINPROGRESS tell the caller to retry, to go on or to
@@ -225,6 +248,7 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 	const struct btf *base = btf__base_btf(btf);
 	__u32 id, nr_types = btf__type_cnt(btf);
 	struct scan *scan = NULL;
+	bool *bpf_funcs = NULL;
 	struct image img;
 	char counts[200];
 	int err;
@@ -237,6 +261,10 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 	if (!scan)
 		goto out;
 	set_protos(scan, &img, btf);
+	err = -ENOMEM;
+	bpf_funcs = find_bpf_funcs(btf);
+	if (!bpf_funcs)
+		goto out;
 
 	for (id = base ? btf__type_cnt(base) : 1, err = 0; id < nr_types && err >= 0; id++) {
 		const struct btf_type *t = btf__type_by_id(btf, id);
@@ -254,6 +282,9 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 		/* Skip functions which take or return BPF objects */
 		if (has_bpf_types(btf, t))
 			continue;
+		/* Skip kfuncs and helpers which escaped the previous check */
+		if (bpf_funcs[id])
+			continue;
 		/* Init code is gone before a program can attach */
 		name = btf__name_by_offset(btf, t->name_off);
 		func = image_func(&img, name);
@@ -291,6 +322,7 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 		printf("  FMODRET %s\n", counts);
 	}
 out:
+	free(bpf_funcs);
 	scan_close(scan);
 	image_close(&img);
 	return err < 0 ? err : 0;
-- 
2.43.0

