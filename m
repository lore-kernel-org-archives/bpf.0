Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303383655F1
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714462; cv=none; b=QWZi0R3gwxiCIk/8WsXVDhBxoRPML2DjeFZXkHwPybTDwGmDHpQXr5uly5vFQBulTYNnmuA1XFrQuyQCS/3Nsw+uyE0mn4gG4xDOCGe3NZk7g0zJNRWGXT0gpRohMg/g2nI7Nf4YDAQ6fEZN4cSoX3qebNjMZPmiYys0xgCMwYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714462; c=relaxed/simple;
	bh=157LL/t9eeZ/pgrP0TXqxaQ/Lk/DSrR163aWNC+F9WU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kPWSRSIuMY040gGlhWnXLk1kkTEPqerR28GSpDJyUzPSzCw12wA7jV7/yNzMrQoQ/xLekYa2qo4bSFJTogkiA+TPGie8v7gw/deFwfISQqnt0LqQxaalXZ0AFbUD0ZWG4ubsFpWNObr8OUAAAGDA+IK8Fkaj0bLofajBWG4IAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNY2JJA+; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNY2JJA+"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132a8f93432so1762002c88.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778714459; x=1779319259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uSJnULhbkIDKrwGHNFIHrScxGoINGLJNTDxkyd47QQE=;
        b=sNY2JJA+mpaMR/owb//X9CoPgSko0Q0xnkvq+Ef3qIGfEw4emyhBXR39iEhASzbGPC
         P9ylwJOJ+9V2xbCnTi9TRxfMM66EnATbjx1gZZRxOjM43PCvEtorC60FXn5v0+4Azo3E
         giprFgjrbrj/VquuFvMZI4BwdbyyA34TieKCLCN8PBNvrFpE12umKBEmCH3IPsW7dRKP
         yoP2TZKSdDFYafFPaUH4+7hwUPQ6kanu0Yu4tb+MQcJyN/9T0w8mbSHHLMw8AK8XnTmk
         tdAi/wNF8TndhEWJDxadMnYaj35XCQdUi4XA6HdEM6wFAmxOPuWP8WYtqaTOiXobw9eD
         fLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778714459; x=1779319259;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSJnULhbkIDKrwGHNFIHrScxGoINGLJNTDxkyd47QQE=;
        b=F6t+OPHEw16YX7li36UMfcQbInkSGPp4vWWiUK9bY/fz89ZcCT87tpafWwYwkRddWr
         H70npmZVkBJ6iUh9L90HbpjkgY8sCa7Vjn5FIJhIb8GDlFQY7eWSzEutH4BjERkPVwD5
         jDgde0aFqwGzypf+Pxfz6oyoGCpUjrZLbFbgUXZsQevyEN2oS6Z2vommFiqoK9/6LGlu
         t9HYISiml07/fdyVRn3bniFJlqDoemlE5ofa9/krNe+GCYijwOR3+5DJz6IELfVmtf3d
         MmvXK7O13FVHOrHbrGfLHhK1vbOfIeRqdw8Flu3QKrpDylg8GDaT3MQUVQ1iMMTmHi4Z
         HRRw==
X-Forwarded-Encrypted: i=1; AFNElJ/ECMHQS+N7EaeKD+SV2LgSa4iUoO4gCqJ+RVhnrMu79kFjrw8fc72DJhYCE8H3ynQRDm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPswU20HuFtB/VYwgvB108Qcsk3I1OyLkvCGNDmacGVKMRDSiT
	/xb6z3+kaQNwRAp8Y+HFOK6z4RXSpW91FT0e0raUDnfkJ20hhYddzv+1db9Hl7fkEHiT1MEgJO3
	tVmV4uYeZLXVgow==
X-Received: from dycqb10.prod.google.com ([2002:a05:7300:fe8a:b0:302:67a7:5890])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:43a4:b0:12a:713b:8964 with SMTP id a92af1059eb24-1349a808236mr3152721c88.11.1778714458906;
 Wed, 13 May 2026 16:20:58 -0700 (PDT)
Date: Wed, 13 May 2026 23:20:54 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513232055.1681859-1-cmllamas@google.com>
Subject: [PATCH] libbpf: fix UAF in strset__add_str()
From: Carlos Llamas <cmllamas@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, Andrii Nakryiko <andriin@fb.com>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

strset_add_str_mem() might reallocate the strset data buffer in order to
accommodate the provided string 's'. However, if 's' points to a string
already present in the buffer, it becomes dangling after the realloc.
This leads to a use-after-free when attempting to memcpy() the string
into the new buffer.

One scenario that triggers this problematic path is when resolve_btfids
attempts to patch kfunc prototypes using existing BTF parameter names:

 | resolve_btfids: function bpf_list_push_back_impl already exists in BTF
 | Segmentation fault (core dumped)

Compiling resolve_btfids with fsanitize=address generates a detailed
report of the UAF:

 | =================================================================
 | ERROR: AddressSanitizer: heap-use-after-free on address 0x7f4c4a500bd4
 | ==1507892==ERROR: AddressSanitizer: heap-use-after-free on address 0x7f4c4a500bd4 at pc 0x55d25155a2a8 bp 0x7ffcef879060 sp 0x7ffcef878818
 | READ of size 5 at 0x7f4c4a500bd4 thread T0
 |     #0 0x55d25155a2a7 in memcpy (tools/bpf/resolve_btfids/resolve_btfids+0xcf2a7)
 |     #1 0x55d2515d708e in strset__add_str tools/lib/bpf/strset.c:162:2
 |     #2 0x55d2515c730b in btf__add_str tools/lib/bpf/btf.c:2109:8
 |     #3 0x55d2515c9020 in btf__add_func_param tools/lib/bpf/btf.c:3108:14
 |     #4 0x55d25159f0b5 in process_kfunc_with_implicit_args tools/bpf/resolve_btfids/main.c:1196:9
 |     #5 0x55d25159e004 in btf2btf tools/bpf/resolve_btfids/main.c:1229:9
 |     #6 0x55d25159cee7 in main tools/bpf/resolve_btfids/main.c:1535:6
 |     #7 0x7f4c78e29f76 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
 |     #8 0x7f4c78e2a026 in __libc_start_main csu/../csu/libc-start.c:360:3
 |     #9 0x55d2514bb860 in _start (tools/bpf/resolve_btfids/resolve_btfids+0x30860)
 |
 | 0x7f4c4a500bd4 is located 13268 bytes inside of 2829000-byte region [0x7f4c4a4fd800,0x7f4c4a7b02c8)
 | freed by thread T0 here:
 |     #0 0x55d25155b700 in realloc (tools/bpf/resolve_btfids/resolve_btfids+0xd0700)
 |     #1 0x55d2515c426c in libbpf_reallocarray tools/lib/bpf/./libbpf_internal.h:220:9
 |     #2 0x55d2515c426c in libbpf_add_mem tools/lib/bpf/btf.c:224:13
 |
 | previously allocated by thread T0 here:
 |     #0 0x55d25155b2e3 in malloc (tools/bpf/resolve_btfids/resolve_btfids+0xd02e3)
 |     #1 0x55d2515d6e7d in strset__new tools/lib/bpf/strset.c:58:20

While resolve_btfids could be refactored to avoid this call path, let's
instead fix this issue at the source in strset__add_str() and avoid
similar scenarios. Let's simply check whether 's' is already within the
strset data buffer boundaries, and return the offset directly if so.

Fixes: 919d2b1dbb07 ("libbpf: Allow modification of BTF and add btf__add_str API")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 tools/lib/bpf/strset.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
index 2464bcbd04e0..7d2b2784172e 100644
--- a/tools/lib/bpf/strset.c
+++ b/tools/lib/bpf/strset.c
@@ -141,10 +141,15 @@ int strset__find_str(struct strset *set, const char *s)
  */
 int strset__add_str(struct strset *set, const char *s)
 {
+	const char *strs = strset__data(set);
 	long old_off, new_off, len;
 	void *p;
 	int err;
 
+	/* Check whether 's' is already in the strset data buffer */
+	if (strs && s >= strs && s < strs + set->strs_data_len)
+		return s - strs;
+
 	/* Hashmap keys are always offsets within set->strs_data, so to even
 	 * look up some string from the "outside", we need to first append it
 	 * at the end, so that it can be addressed with an offset. Luckily,
-- 
2.54.0.563.g4f69b47b94-goog

