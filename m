Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641438;
	b=m/+5YXxagoylQVvoLvi3Zk2BNJztEbQeWVnbhINF+7clfwjsIejzuNd1GXYrofbN48qg
	 jkAsMizQygmbgF3x4rIS4JS/3a5fC229V5GTNYtJE29M11DsSlZeCkFruOTJ1VfVNQyCY
	 SjbFOpFvJLxtTc+uHZVw5+A4bYFeTUOZ5EBhsREDiDfnGf3oqzD5vHvlDvU4NdojSjzRn
	 H2IxP5naCKtlsWkyF2pswEFt0mKK5vdS8V8495t7puAVu7JdIypPzYpddhSoHKFVyo7Ev
	 /TrOIHWKnCHVaMziiDGq9JuvlCpC2jVi9l6FaGASEqM+02J+8B4yuPNs1tfQUp7IoNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VVPvsnNQQoZn0PRczRzKaCf9H1AIdXbc6boh7d/wBd4=;
	b=g9adh+2qEe1HOkRnLNT+i3yozvjodCJ90R5dAx6QDHDHcO4Ab4U2OnUrws49nT974CFz
	 dYMFTnSbOf4ymxmdown5zjhaSPBo6gFXG9pqa/CwqGPVmgXZytYMpfaQnOJEoYdJTZhcA
	 /n4t3lJ7TjvWevoAopA5yRRrqUqyibELP67FBnrHSpgFp6VxHUokGqyj6N52kd0aHmABT
	 B/uN9Hy78i3/YGFI0pTTYarL0qcCynOxeOMXyX04e5gYcSRRriPGNqTsi2sckQevTn2xP
	 wnu/YNxaB67QANEqyfgS1L/Jr1naf8/BDZNjFG0+tsLwJ5+6uHGcgqTj3OwdoOPg1VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAV3oE4E;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC5606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 21:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52EC5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAV3oE4E
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so53370935e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641437; x=1796246237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VVPvsnNQQoZn0PRczRzKaCf9H1AIdXbc6boh7d/wBd4=;
        b=pAV3oE4E8yw7XEBNbtbp3O7I79soqbJTSMyjO0+lkZ4IzwXWqapg7QaVHNnfy7rj6a
         zqDCj1fliSsUwTp0+qD+2V0rcx27b4eJGMcd2GxjXUYUcYjlXTgN2/LObH6NDEncFhPY
         R5+DJb8HkEgkJKlPSXXPd1/RyQRhyJVfA2vylFP4TVCWBNr5P0qnuobJOBBzp2ocex69
         zStKGUbexlx9435ss86Tdrpt7hv3m+nBr35hhTTvAPWK/gB7llOYMYlYoh5Nywas5qO4
         zByQWK9un5OYTMNTbpp6mRPknr15YcHAgjz/LwRDx5qXpwXPP5gkgewqmNbewUf8rjBy
         dwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641437; x=1796246237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VVPvsnNQQoZn0PRczRzKaCf9H1AIdXbc6boh7d/wBd4=;
        b=oNS6xBWWS8q7Xw6Xi46lXl3SPnSr6+DX/oSF6YhNRoRYXsEhytuaCshwlp+pVOxFQ3
         pvHI+Zv9CXGRlPTWaCfB8cyQN4P5Kqm0SRbdH5LRvSNOqDWk/lwYMWKxXcx3d+Q8Zmt6
         v7a+LOUdEsyVVDCIWn/sAn3fUJBXn3IChqRgl26zuSZbGiLETqh+lJP2RkboGIIq6SHd
         I5VNXS6vnHvj6ahwWhljzWxJ6rhMb2It+QBl+DWLeFTRDB6zSj0qtscXSlIPT+UMhgox
         6QkB0FgNJtz9K6d0XKB+MPY4Aqao/1QenDaA4l3v/oRBICf3bUNzP/DBNvFoH2k+/uMm
         9W6w==
X-Forwarded-Encrypted: i=1; AL+hErG6Z9hTzUmcc4AbYiru9aaTnt5F5k19dJrkLjdNrdVHgZWT20sDWJYIO7e8yTpSCyV6gaI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lvfkLcI56QlqyN4w4PoMWwyW10dkkvB0dmp+AEGM5GuuME192
	sdqFu4EUKW5Z6GNhbxGnI3iHXjLo9iU8mNKhPqLPhkN/x0jvYgc0aXpS
X-Gm-Gg: AZFdTZdXY4lkIzev7U0wT563PWGJKXbVg5tYkQJlKLpceRlB6WbBtzDhY7FKBj5BNA2
	xM0jaT6UFnYNmUgCORIzJiwYTqZOYl6zCgeCBZ2Q+lw2J8yA7+PZ/Zy6iMng2Ff7SSSVY3MEWaM
	vTUEMGXV3jS+AIG/3TtsonyPC2NKMbcxUYm9lpy5Ge9EF3FvK74V/LqAtGZEO+oRhVmdjCLQR26
	s6YffJPHzhv6d9Y1jh8VwtZ9vOW+tE27rq5aDnay+Mh/CLnddmBvbaHNNlxUf3xiVwI1ze9m3f+
	EKTtJQ4f8Hk18bNfRyIqA6+QGJ3geg4m+tY6yvbW8UA22iREQ/VvayifmwecK56QCjfxGevuduQ
	aO1GBBFL+ACxWO/famFOlaAYaOXLDv1C6fAHkOfb7DMmTmmnDOX6ptIRko2714RIS7RO90PqMtb
	jURhAPzJJJVVziEy473dsLaD/Yc/iZPxEIdLdxCOQOgJyyD+q4pvtm8KUfK8C+UDCzElk0m5wIF
	4JQlrhVe2+4j338xseMPQf2tv23nUNfh1HgfWOuiPWeAyfxMPp4ySFceet1+thlVr/egKu84xgv
	0w9qIOnyhwc38bbhevZNr9LOlkMhPbYCQbsIOuii1X5Kr1Y=
X-Received: by 2002:a05:600c:46cc:b0:4bb:6f41:399f with SMTP id 5b1f17b1804b1-4bb888236a3mr400221105e9.24.1795641436612;
        Wed, 25 Nov 2026 13:17:16 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm41840507f8f.24.2026.11.25.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:17:16 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 3/5] resolve_btfids: Exclude a set of functions by name
Date: Wed, 25 Nov 2026 21:28:36 +0000
Message-ID: <20261125212849.868523-4-a.s.protopopov@gmail.com>
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

ftrace reads the code it patches with copy_from_kernel_nofault(). A
program which makes it fail breaks the detach of fentry on x86:

  unregister_fentry()
    update_ftrace_direct_del()    returns 0
      ftrace_replace_code()       ftrace_bug(), no text poke
        ftrace_verify_code()      -EFAULT
    bpf_tramp_image_put()         the function still calls the freed image

On arm64 ftrace writes the code with
aarch64_insn_patch_text_nosync(), which is traceable without KPROBES.
The same holds for it.

bpf_set_dentry_xattr_locked() and bpf_remove_dentry_xattr_locked() are
kfuncs without the "bpf_kfunc" tag: specialize_kfunc() calls them
instead of the kfuncs without _locked. Do not tag these four.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/resolve_btfids/fmodret.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index 7d26a5c9b028..5a392452471e 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -87,6 +87,22 @@ static bool has_bpf_types(const struct btf *btf, const struct btf_type *func)
 	return false;
 }
 
+static bool excluded_by_name(const char *name)
+{
+	static const char *const names[] = {
+		"copy_from_kernel_nofault",
+		"aarch64_insn_patch_text_nosync",
+		"bpf_remove_dentry_xattr_locked",
+		"bpf_set_dentry_xattr_locked",
+	};
+	unsigned int i;
+
+	for (i = 0; i < sizeof(names) / sizeof(names[0]); i++)
+		if (!strcmp(name, names[i]))
+			return true;
+	return false;
+}
+
 /* Find kfuncs and helpers */
 static bool *find_bpf_funcs(const struct btf *btf)
 {
@@ -290,6 +306,8 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 		func = image_func(&img, name);
 		if (!func || !strcmp(func->section, ".init.text"))
 			continue;
+		if (excluded_by_name(name))
+			continue;
 		nr_scanned++;
 		err = scan_func(scan, func, &values);
 		if (err == -EINVAL) {
-- 
2.43.0

