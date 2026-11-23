Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446986;
	b=dG/8Agw1d6cGS+Ztob1eOZBbhmdKL8ic6VuAoaV5x4jRr//AeND5TiVxqTcLEpZAIyDL
	 Ym5sNwzCwvNBOix7+bW0jJeEWS3Gna94iO9iB+GTsGlwxnzOnTI9YGzd5U+u6Ps8ZUbvK
	 5j/zHSSM00t4hwaAyk4D5I8LS9OtqFTlSymvpqDSCSSzK88Tbj3R75OmFVO4Ylp5kPF1C
	 d/X1YsTujsQgkxut9m6v+9uG1Drnzx5rV3S6OvS9ncE7cygf984THlPLUK/mC8m8ObgKY
	 DdzDyNVWIpWYEF6oPxUR43r8Iee6k19R3pW7ptlTsI68q76fT4zRQMFQU4/b0EE2k7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zU4u9OuB0kAzpM8Ni10ONWkHcrXktg8RLRPjBw1LN3c=;
	b=DZlcjCs/0XaUVceLF0SDcfY5hMncmO7PDzK1AMXAz4hX+oQiHIsizpIWa7xLCIWUOinX
	 CNRD/tk2M38Gngf6CUCjdbCDhm849qodCX74vNNCAzA7dkrT98Dv8FVjpMTU98HH46Tdj
	 Ixr3FMZZnlZ0nANQ4+bQF/6FSOkCFttT5aAxcbmUohbB7HF//HqCnfycIS7A/7k8ruM/H
	 56HyhGNrxbfotZkyv3pWcN3oTS7BSrYOtl+QNOxvEUHxGkgv7hSOBIgOjkRn4F9XuwEnc
	 n536ce0jWVv/IWewAlOHkvG8bIRAOXW6m9OCfnrGFwptbhv7kpD+Qwe3/Jw8RhB0rIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JKe6jmuu;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B040606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B040606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JKe6jmuu
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-84a248254f4so2146980a34.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446984; x=1796051784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zU4u9OuB0kAzpM8Ni10ONWkHcrXktg8RLRPjBw1LN3c=;
        b=JKe6jmuukjMd48UGzerbDd1BfhlQxZwLjGKRj6JEQKQKVrPH7PHrF3+K5fWFJbQXPy
         uButlWP9Y9zEYCyAyf/MYM78SUiwH53jS3ym413KcM4G41i56Pfd0NVOZFr0f+LCq7SM
         uwya7Ws/v1Lq0Hf/ZJGHshghnZYh4mizRB6rJ1f9dfQY+ES+0za02CM4CoGYkG+G2NtV
         3H1rqZyYpEsQ6yvQbtIpMXL+YGQVwP4Lugh4SMpvixnf+dRiB4u6/+kZQOyO3Hzjp0yK
         GIR8gU5s2eL8ZWMuCbOvch6OMmWfaMHbO8EmF5vCiawHvUOUD1dy/0WgStl6DilbwhfL
         UoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446984; x=1796051784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zU4u9OuB0kAzpM8Ni10ONWkHcrXktg8RLRPjBw1LN3c=;
        b=vqzv5E6SKq+ZOBnSpvfQjW7GPsYCbXjo+hilj/x9rw9Cvd/IsApTZrNcsypvXZCyoi
         TlgoZMS5s3akied5U7YL+Z4wMRsjCxbJ58fZ3IKo8hGcRJ/4qeEsTczpSBFXfwW67Pny
         ikonYKcJglndS1RFGg3Da7u6yBqKUi0ogmg59+uSCyBh62WbEzeE2SOt6Zjt9WD/OQ2C
         hYPm3+pdyTff6w+pGijteL21bJSztNr8kDfqTmkYNNmB/vh/xEj7INK5QeyatgLk/+pK
         J9MLwBGOUVQ2WPIdgjQpTBi9sE3BEkY5HhIscDRAiccY2WDqRcPoSSdJT7E7XL5Gysw9
         kXlA==
X-Gm-Message-State: APuU4Z8ysOFKhNIA3APZYB7Ap61uiXy2ZZ1TcB4Af7yJETNQ9l0l/+wx
	7YGS/hn01vVTCfgH6WT7VOxlm3iqZZWpSYyxvyE1LggPW2QDq8vDkphbC/AB1+fKfdY=
X-Gm-Gg: AZFdTZcm6Mfb1tyFpPxo0gwLcPSd/PZw5LK3ZEfrnpN+m+qZEQDaX9FMJt7QIaRHL7w
	Hcui6E4U+Ss/xaVK/93P0B1VxrQFAkEZxwHaGdEM2dHmHS8SImJv4UWR3coB8BpLngyhoevZVja
	ASpUobCUnBf49uMPz77bCEM3uTSsCEG+38S8c284K7NY6UlBszqkwm5lRl+AvOesmTkiMSK5XSH
	nnZ3mSuHP7FdXbNX/C/GBp3ElWrUmEdtE9PF8tJ0h/MJUTLK+cYYc9F5WxWvWdSRJl/dMdSvTUG
	j7lGR4DFhbv5p6j4SCaYljkyMEoc+dKf2htFIm5Xt00a9G8TXY/ThmvP0TyulHjQ5NKO7km4xkW
	HW5m9qrtgvA+ofFpIfaQ1le+uGZlNrvr1gNtoVVHId/2smCTb+qaZAAyVwNBnt44egxDrmEs34k
	DicKN1YrckIzOj0zDEOK98P5EP2bpuRpk/wGaHP8oRrvjquWjQtq7v3sWpBHENYv64oTpAtUwmG
	TCnsyawdBZKG/yCaQv7SjmJHG6i8zP5tfuaIHTJyngNKqWuWtU7cZhf75ilR6fzNv9x3uXCQVKu
	PQodZ2jGsSs8Nej2AFE=
X-Received: by 2002:a05:6820:8598:20b0:71a:f1f3:55a8 with SMTP id 006d021491bc7-71b395e7436mr7002029eaf.72.1795446984339;
        Mon, 23 Nov 2026 07:16:24 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380155cfsm7784696eaf.5.2026.11.23.07.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:16:24 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 23 Nov 2026 07:15:51 -0800
Subject: [PATCH bpf-next v2 11/13] libbpf: Do not retry local storage map
 create without BTF
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
Message-Id: <20261123-sls_f1-v2-11-76474de9b052@meta.com>
References: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
In-Reply-To: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795446955; l=1797;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Vtyxh3kTuxXISP2F626pBciFltfs9pDlEXnqeldwqtQ=;
 b=JIfdogwoLSykqFZWjdqONflSmGcBJ69zgbUCdQdxtR4ERiiztyTu0uGYrYw4lVGu0LREY3lZ/
 QsyNbi5JXQSDrgb9XAyRuAbpPXZUHH68vN7W2RW2v5foDSmrdFYif5q
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Local storage maps need BTF, so the retry without BTF always fails with
-EINVAL. That hides the real error, for example -ENOSPC, -E2BIG or
-EOPNOTSUPP for a BPF_F_INLINE_VALUE map, and the application cannot see
when to create the map without the flag. Return the first error.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1efc0dd37b2e..01185fa917c9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5531,6 +5531,20 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 
 static void bpf_map__destroy(struct bpf_map *map);
 
+/* The kernel refuses these map types without BTF */
+static bool map_type_needs_btf(enum bpf_map_type type)
+{
+	switch (type) {
+	case BPF_MAP_TYPE_SK_STORAGE:
+	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
+	case BPF_MAP_TYPE_CGRP_STORAGE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, bool is_inner)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
@@ -5631,7 +5645,8 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 					def->key_size, def->value_size,
 					def->max_entries, &create_attr);
 	}
-	if (map_fd < 0 && (create_attr.btf_key_type_id || create_attr.btf_value_type_id)) {
+	if (map_fd < 0 && (create_attr.btf_key_type_id || create_attr.btf_value_type_id) &&
+	    !map_type_needs_btf(def->type)) {
 		err = -errno;
 		pr_warn("Error in bpf_create_map_xattr(%s): %s. Retrying without BTF.\n",
 			map->name, errstr(err));

-- 
2.53.1-Meta

