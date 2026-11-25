Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641437;
	b=VoOOPwVidA1l08F5tLphXEXIkAan9TLkoOjr9tHEYK1DYeXaW5iIh9OwXKn1PJQR2rCG
	 3Fl/yxA3u9hoYF5YWWodajzM1KeJTvqhR/EpKMA2hisckLrqb7+Hdf/M42iKhnvTh+Nu5
	 EhJT1eyfL+Plk1fWoQlMCapJ0RGKX07yrzcDqjp42M+h/zbbYeZcJjKar0UpeD3+a7hbP
	 /BC9+CAM0NVE3kEg4USG291JlwZqsAPXr9AYE59i1YUxzowURE29QNMDwQT4s+JDXF8Tj
	 oHYgbZzoa/tBVfdHpNVYTJGQ+LLTan+5OUpSeY5DImJZ9/URrxzBazBK91GuY0WHU7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eSMyLcDHCG1prqMD9ivdaiUihz9ieGwz5mWOc/jcL0c=;
	b=KcRIlQkp4Zl+8XuBRI3A7tld/IHbssMsaKxdC+KtnQxIBdxBuRi4oQp792imnXh57vCV
	 GSuO5m+wBlEe6bj3zJBZ5Fm3ReGNcX6ttuS8w5cInhuWait97Sol4hjpyKGX8hi6mDWJ/
	 dqMCLhL8n0XneIGOMqwCnBDTtKUeyIZHEVbwPqlmGDAsZoZvMxn7Sc+9WrAGxbJOF1wvl
	 xGqLVvL4fe6rqhXDaMq3YBJd5pZMleRpHp4mJjIxL9T24dkBC0pGfhbZstwBDoH2rqDoP
	 FSRwfyUMt4Iak0cjwjn4RrU8rn87w5txdsbJ1Rsw76t7OHwoPbJ+XuG96GRM/t13SLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgaVZA+E;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2B606A32C
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 21:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF2B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgaVZA+E
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e09aa5264so3662133f8f.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641435; x=1796246235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSMyLcDHCG1prqMD9ivdaiUihz9ieGwz5mWOc/jcL0c=;
        b=QgaVZA+EojVtFnqxqJn/4ganMvadY/jVw3yDfzd9q503oo423B0WuvAK78cUI1LU2p
         HUAlk00ROGshR7WEIG1an+1T2bXNQqewYQPZd1rNh6KYahDOgEm6mIrFZK+xZ0OsL8YA
         5KD1a8DRbxT+e2NbYnG9Xyyh7vP7F/x8xkuZ1TH8gt1tMSi22ch4eDSuXr/LR2D3T4FD
         bfJwzDwcLJl/89vx/cL2KGvLdHYkuW0K9WxiaUuOqKjMD/jsfHJ5GHdKFlHHSrDqpp33
         qkvr0r/kACe23/72oxo5fXFTmY2mMRHbDVPiHN2TXHZ3QYy4aEd/1A3bLOQUzKbIRGFQ
         4F0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641435; x=1796246235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSMyLcDHCG1prqMD9ivdaiUihz9ieGwz5mWOc/jcL0c=;
        b=s9H5aaL0D7AmMfHlKoC1UIYae1D0xzr8ShIhNFsG35B6HJjWAlK+2Nu/9O2ev2bshF
         jBayEPAeBHDlVF8k9Dhl/P2zF1maSzun+NKR9cbPFM9FTZDETsV7xkze8idZhBqLHzMB
         ESDAaY+Du4zojtu50Oz/VOw26XwAAJ+EZBVaPx7xE1g7NrtgkA941viQwfxpZ1tdHjzq
         vjclsOD6JIZapEGvUmhP/qe9Jo+ITbeBsQdEQATpvRmwDdvDhOKnefnEg4PWfwLCkdC9
         KNwUCzeMs822eHS945e7jWNgLeQM5Dky8v3tSdxISgTuD873pdPO/QcI+WmtReg947FK
         3zTg==
X-Forwarded-Encrypted: i=1; AL+hErF3iZViTh+1XDKXT0x+ABRDnXpJHRw7by9kMDYzLiqxXHWrRqzx+BgVDPlkOkqhpHiXdO8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YNtGes13SCCaTiiIZqShcjckkv8jWnGFRlHltmO62Wg4nU3zI
	jNKyKuCnhfFlFL9kfqV0v4fXXLEvacKNCwQFGAKIvN5RfgeqXa3DMBOR
X-Gm-Gg: AZFdTZcE3jnFJkWY0tDxqmpw1QSmoWEa1EM+FGnfdxazku7uHTXOpNXm6a8McWriT2l
	UjX/e1KADt4URZl5SV7aF9XaEbfHdvsJ/PR7fM+BnYg4LaYeIDU9wyL8IiLUfRZeT7+Kkc0xee6
	A6Ewn28NXgH7AfONXuqmQwQeiaaIJZW0iDQALZ9gwO4WOIapgwieBIktQ0NxnqOqLR+L/Ekxd6U
	+JtYIJS2IDeZ5bk5S+uXc5kX2HzSHl0xBAGOoF5zYlrM5aWzaa4iChmTAXdi2gLPfkEGxNyo85T
	LcmIGk2FlrhQwcF4Mp3Bfiq4hh8l0q5FZ/NE55r2oGpzmLQth8/5o9z/SXNR4l8upqoPVR4qmQu
	HmWfinHLHJIS55Yle1d9/1vOt1TR2RhRx4F4DpyjCrZJa3F4tDkee9HJ9/dXoAag4gH3OApN4HG
	h+EUdgt3AD5hxv+jdxAD+Gond3qkOC82hJuG7MaG1XQq780LHvMw85u5lJLZijdOh9CgH6OCJvD
	j2xBC2Kmi03BwbgXOc+addmXzvG1d19rVURlbL7/nfkbW06V0IiAa1DmgeommchHrXvOQkY2Ps/
	2GQnfQRyNWJM84Sy6AFaa5inVkup+sJ7DSxjd2og+Q7EApA=
X-Received: by 2002:a05:6000:4284:b0:4a8:647c:f964 with SMTP id ffacd0b85a97d-4abb6d04d79mr39653771f8f.57.1795641434964;
        Wed, 25 Nov 2026 13:17:14 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm41840507f8f.24.2026.11.25.13.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:17:14 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 2/5] resolve_btfids: Do not tag kfuncs and helpers
Date: Wed, 25 Nov 2026 21:28:35 +0000
Message-ID: <20261125212849.868523-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125212849.868523-1-a.s.protopopov@gmail.com>
References: <20261125212849.868523-1-a.s.protopopov@gmail.com>
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
error. bpf_copy_from_user_str() with BPF_F_PAD_ZEROS and
bpf_skb_load_bytes() clear the buffer on an error, and the verifier
takes it as initialized. After a skip the program reads what was on
its stack.

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

