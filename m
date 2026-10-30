Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361224;
	b=lDwa+jfihHS/Bn+3pmBasRIT95zqFYlxQvv+syyE741KFNjQz32t2lPkpRoZ4D6fTMj7
	 MBohn5GgkQTFllsQqDNmnGQfLb/UOb5uT715cy4sPLyW0do6hqulxdEwX9gUVyV+RBDbz
	 YPkmE2X07Cc7kZ9ZQvWIm4o0mA26JBMQJhsfJOplH0cN9yw4FztKoV4ylYlMowcl5r5nQ
	 Ci/Bh16MLdmu19/cw/h/T9FN5hzy/D4Tyi6SN0QYuP/wV3hKD7m1JctUcu+ejDFQEuYTD
	 AfHGXgiuzhwa95zgfroseggzKGZVhUp3qdI13yVU13xMfR+wU2smc3P/WW+YJjP2sPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=6ruo65qqTejJkM60HrkQCd1JUBkgnydByGT5wOincoQ=;
	b=pyYSWEVOSy12aji/pt7ivl4wOSU6f29cRqrI/PWNHUD3mSKuS3bkuvN9+y+CLUW5lEIE
	 GDRTU1SrBFNzwfj7UsC+S3uX5yUMAimmw+IqYy5as+8v3roB2W2CpKPkxz1ybCzxLbitl
	 nbOMD5dd+cws8VDNrP/00e3gqB3z1rVCWJOI+J+bvF67878CDq/I11fx5yJh/o9LzAlmE
	 30IgYzLXwXCocnlRFHwYG/VMPyRBc3UsDBhZuJ0A7w+BCq+3q1GPSiEzCPN2670WJGHkW
	 eTLtEshBPk0lBqg0m4TfMLhZFGT0WQY8VOYfcgthJyyZ9s0RlxpWanSu2hoVC+Tcqqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F347P88d;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF3607085D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70FF3607085D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F347P88d
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-188406bb948so599686c88.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361223; x=1793966023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ruo65qqTejJkM60HrkQCd1JUBkgnydByGT5wOincoQ=;
        b=F347P88dkcNAwI/Py3aXKr3+GIgiMhP4IWCqBMWkNV7OXrzJ2M6pEPoVHM6sqTsaUm
         XD3pg/LaMNPZv3sPxiypCmqUB7mvFhieZnQ3uMqxCM04uVto9LUn58B1wIsAi9f5ETEI
         j/QbfrJeNkLI+V+SjFVhhufAkqxtCHXaHVMUvv/i4Tezyfe+uoFsXv4MGwcdObizxLZW
         xE9jFwFHDEE4lBlq0KV4ePg2oDqRbNpO4rQ3beNX2yPaOCWWKeDnS5gCLTaA9q4ql/v0
         euV+/1RoBqCqKFpGP2EJNp3zXpht0aB2Y5WecI6trv1GqOb9rj99mAvbV0gVgboQzIyh
         UWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361223; x=1793966023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ruo65qqTejJkM60HrkQCd1JUBkgnydByGT5wOincoQ=;
        b=LyxDmW+W9twzycp8Du/UYktp4NRikDg4d5FicPrBlk7xJN+f/0yfC0tA/xdixuOBmh
         pYq5uVHYyfWxwaLs4GMFVbXPlybrhdKhNW5H987twWLGVF7WlnMxU0SoGDy50QAOJw61
         JBqsVobiXpbaZAjYcUhcllRr9QTIzfYFfWe5WA7/gePU3UZR44/5foEGqWSZNxmjudA4
         aR973chDaqhtnH/uUQ6Lk7OqRtlJp6yWfKx5SuCBnhRSftTfolUCfKYxEn99MJJg+gi7
         6kMjkfvWb3PGnpcsgvlj2ba9G0+zczozRgccBYdgnNOwpE5ue7v49L1ocNUhY8YCXUDZ
         JEvw==
X-Gm-Message-State: AFq9FYKtpDRI6wjCSq/4Ssr22xDQeuxEjsiSBBfrZ/wX8oHKninNMnXd
	KZF5pV0QlbPS5jmaQMsR3Cgu2Wypff8A8DvJJIZj90xdsJdyCBTh5s6N
X-Gm-Gg: AYBFou3YNCGHJd8+ZmNKqSxIyb8OC3siAScvNpWQ18a0nSrur/XoMpgy1cJEv7pE/dN
	nIUhI3vZuBxowdbKF3aE/2DokTuTCnCXWCgisGvmePx059sZopmBV2qyRZQGo8vtS8NPxUlB3eg
	AYy2DY/YwhVwWpcTf8Xvq3IZqyAppQxlnHlGm9kjtUzeU/QlMDXUD8Fw925XfBEKJcFUuSDvSTf
	FPWzZJ0IWkdvOdexBOXTnVJ2rLUWh/KGEdB0BKweIGJHC3fCCibsyFe16jLMtk5BKwXIMazyJz0
	PPri+sKQIdx+Y7xQLCpox3bLXOdG0t2M8nGQBMOQ2ZBNxP5aijhtsSWeqtmaDOmx5wK8pydVZua
	S/x3HlmHCUuOEkB49js+wZrbIgpGxjvk+DMzQH4kacWhsN6Qw0Rn3R99Zs1TYBEACMZcEmpeElJ
	w4OKi//acRSl7Obkgb1RV8RfwwWxTepD1tMVKs6C3+FUvnLvWLCKZCfpUbhqVEbVbhM5iWUaHz1
	q0P7n9HmyJDuFsD+jCoiDTUIAa2sEDzSc1hyYGUK45W4ryOtfWVFHEQT5pMMjv7YQrsG5DguNmY
	Qn7O4/+X8wOEokOSvL3SsvYRZmNsOXA76P41UiKNbQ/DIw==
X-Received: by 2002:a05:7022:b047:20b0:16d:dd5c:4261 with SMTP id a92af1059eb24-1ac5e6f4e87mr3095742c88.46.1793361223437;
        Fri, 30 Oct 2026 04:53:43 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:53:42 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:52:03 -0400
Subject: [PATCH bpf-next v2 18/22] bpf: Apply the patch list without a
 verifier env
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-verifier-patch-batch-v2-18-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

Rewrites outside of the verifier, like the blinding of constants in
classic BPF programs, have no verifier env, and core.c is built without
the verifier as well.

bpf_patch_list_commit() needs the env for the aux data and the tables
of the verifier, so these rewrites can't use the patch list.

Add bpf_patch_list_apply(), which builds the new image of a program,
puts it in place and moves its poke descriptors and line info along.
Without the aux data and the tables of the verifier, it can't remove
instructions.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/core.c            | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9562665757a79..b133bbaf614ac 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1118,6 +1118,7 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 			 struct bpf_patch_image *img);
 void bpf_patch_image_free(struct bpf_patch_image *img);
 void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image *img);
+struct bpf_prog *bpf_patch_list_apply(struct bpf_prog *prog, struct bpf_patch_list *pl);
 
 /* single container for all structs
  * one verifier_env per bpf_check() call
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0447e3b4cfa48..10d2c37f81280 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -880,6 +880,37 @@ void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image
 					      prog->aux->linfo[i].insn_off);
 }
 
+/*
+ * Apply the patches queued for 'prog' without a verifier env, which can't
+ * remove insns. Return the patched program, which may have moved.
+ */
+struct bpf_prog *bpf_patch_list_apply(struct bpf_prog *prog, struct bpf_patch_list *pl)
+{
+	struct bpf_patch_image img;
+	struct bpf_prog *new;
+	int err;
+
+	if (!pl->cnt)
+		return prog;
+
+	err = bpf_patch_list_build(pl, prog, &img);
+	if (!err && WARN_ON_ONCE(img.del))
+		err = -EINVAL;
+	if (!err) {
+		new = bpf_prog_realloc(prog, bpf_prog_size(img.new_cnt), GFP_USER);
+		if (new) {
+			prog = new;
+			bpf_patch_image_install(prog, &img);
+		} else {
+			err = -ENOMEM;
+		}
+	}
+
+	bpf_patch_image_free(&img);
+	bpf_patch_list_release(pl);
+	return err ? ERR_PTR(err) : prog;
+}
+
 static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
 {
 	int i;

-- 
2.43.0

