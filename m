Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02BE3090D7
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 04:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820487; cv=none; b=qXLqkxjrjSvT3XhF2b8pyhhJVgGxNGW7/VN5T8sS39eQxCgTf5wiMudKfGXqRmJAuKAra1/IQ61WGWAJTzWESUS3/LvUMf3BhpsmARBwA4YsGwnw9E6H4aslnTNF6ZTHY8l/X7zcXK79Vp4+vHb3ARE/XBICC9eS6jpISTgGzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820487; c=relaxed/simple;
	bh=qTEOizOeHgrKtAJFuO3cnaAsij6UlVmxM3796iF7vDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o4A7AU7VF5v5gWGP3pXHfgoWmdh0phOoe8CLgeexZl0NSmlc1gFUF/rVhqs6C8z2cZMxYlOdJdUqYxhrpxog01E8blTIT+GNDVli3Vc5D8Lo08raTPKtrervFvZnStLJMF/cuzzSd6D2BPb5+Fxro2uNtq8e0k7eN8IJo5uBSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UM15ceF+; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UM15ceF+"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13312af37fdso1558402c88.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 21:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778820484; x=1779425284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAMpwBcg60oTzS31N53VrOTJbcKgVIhyBAqPOW2GB5c=;
        b=UM15ceF+y/XsdRiKoBVSUL8lldB5ILKzqu2V8ImxjXUu+dGwCalBlyghKkc7QFqr1j
         NRmqsYI34NAKb/E8t0RXSVYoSb2Sh4ksAi86UKjGagPk1MWib6LQ6Lrci+o+2CiKWa04
         zZgrXAfvpkCIIRvzyo62XkteqOeLXO3aiaCoBzrmpWO3JIXrbfgWonvHL/3bwm0vptTr
         DQdyMaOXdk8l8mBb22CWLCcP5bQR7S9vIsXIvPVnyTki1MHRgofEenAjOYC5SZDbhVB+
         tmL2dd6+/XyrvVaD1nsgJKAaA3Uis6TjTONQnVRaF3h9d4hxPeI3tB4a6bub+AGiAYaP
         nUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778820484; x=1779425284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAMpwBcg60oTzS31N53VrOTJbcKgVIhyBAqPOW2GB5c=;
        b=lNkcL/vOCt19wK6FPs5SNyauliZyHHE2GKBnROJAhq1smX2Bvm70H7HcPSOUZPWkjp
         50HWOZE6Wn5U8NovR/o92Q4DQmc5CHXN8f5fmwWkuPxE7sk0Ic0bE+i8A4OJad9cD6hw
         v8xgiPZxMWdA8WRafOxfq46LzkhTzrbZnaQEYVW0sCo6VKvBazLLGzzxaKbQblYct/9Y
         zYjRrAJP4V8VLOAGELbKV9x9iKmCPLOplJPK3DAkTHg1SqUsjMpNxB/6JkTPaF9/VMhn
         n2UyL/qavd2F+MTvuHMexyd0PvIvu+tw4UpI3R70rBqJtrR8zdVbjto8tCjVJSKgTyhg
         SSZg==
X-Forwarded-Encrypted: i=1; AFNElJ+qRP4u7+gkSWrfLNzkx7q9fxGdCA5tHbFU4gxPjwacgDS6iN/7gcv8YBf6wYI/vdKPcvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxksgMwZntrqQXvpd7Bm+UH6VSCHeTUr2ResJ5O74dkpXrtsdEI
	aJ2Rg+YbPMmd9TBiY9tbhRQ7YUX5WBWjnv96s0QTNAJchfx6wxn60DqBj9f+9FnBou/cvR0OstL
	OnicrdpxYrsI/7w==
X-Received: from dlbrh6.prod.google.com ([2002:a05:7022:f306:b0:12c:1f83:7b4c])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:b11:b0:12d:ceaf:ffcc with SMTP id a92af1059eb24-1350451e06cmr1008180c88.5.1778820483381;
 Thu, 14 May 2026 21:48:03 -0700 (PDT)
Date: Fri, 15 May 2026 04:47:58 +0000
In-Reply-To: <89d34016-cf82-4beb-989c-e4fc2e3cd29e@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <89d34016-cf82-4beb-989c-e4fc2e3cd29e@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515044759.2863546-1-cmllamas@google.com>
Subject: [PATCH v2] libbpf: fix UAF in strset__add_str()
From: Carlos Llamas <cmllamas@google.com>
To: mykyta.yatsenko5@gmail.com, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
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
strset data buffer boundaries, and skip appending it at the end of the
buffer again.

While already here, also fix strset__find_str() which suffers from the
same problem by factoring out the common operations into a new helper
function strset__offset() as suggested by Mykyta.

Fixes: 90d76d3ececc ("libbpf: Extract internal set-of-strings datastructure APIs")
Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v2:
  Implemented the fix in strset__offset() helper as suggested by Mykyta.
  Added support to handle "substrings" of existing ones.
  Used 90d76d3ececc as Fixes tag as suggested by Sashiko.

v1:
  https://lore.kernel.org/all/20260513232055.1681859-1-cmllamas@google.com/

 tools/lib/bpf/strset.c | 70 ++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
index 2464bcbd04e0..e50da238914d 100644
--- a/tools/lib/bpf/strset.c
+++ b/tools/lib/bpf/strset.c
@@ -107,25 +107,53 @@ static void *strset_add_str_mem(struct strset *set, size_t add_sz)
 			      set->strs_data_len, set->strs_data_max_len, add_sz);
 }
 
-/* Find string offset that corresponds to a given string *s*.
- * Returns:
- *   - >0 offset into string data, if string is found;
- *   - -ENOENT, if string is not in the string data;
- *   - <0, on any other error.
+/* Returns the offset of the string in set, and populates *grow* with the
+ * length which set needs to grow by to include *s*.
  */
-int strset__find_str(struct strset *set, const char *s)
+static long strset__offset(struct strset *set, const char *s, long *grow)
 {
-	long old_off, new_off, len;
+	const char *strs = strset__data(set);
+	long len;
 	void *p;
 
-	/* see strset__add_str() for why we do this */
+	/* Check whether 's' is already within the buffer */
+	if (strs && s >= strs && s < strs + set->strs_data_len) {
+		*grow = 0;
+		return s - strs;
+	}
+
+	/* Hashmap keys are always offsets within set->strs_data, so to even
+	 * look up some string from the "outside", we need to first append it
+	 * at the end, so that it can be addressed with an offset. Luckily,
+	 * until set->strs_data_len is incremented, that string is just a piece
+	 * of garbage for the rest of the code, so no harm, no foul. On the
+	 * other hand, if the string is unique, it's already appended and
+	 * ready to be used, only a simple set->strs_data_len increment away.
+	 */
 	len = strlen(s) + 1;
 	p = strset_add_str_mem(set, len);
 	if (!p)
 		return -ENOMEM;
 
-	new_off = set->strs_data_len;
 	memcpy(p, s, len);
+	*grow = len;
+
+	return set->strs_data_len;
+}
+
+/* Find string offset that corresponds to a given string *s*.
+ * Returns:
+ *   - >0 offset into string data, if string is found;
+ *   - -ENOENT, if string is not in the string data;
+ *   - <0, on any other error.
+ */
+int strset__find_str(struct strset *set, const char *s)
+{
+	long old_off, new_off, grow;
+
+	new_off = strset__offset(set, s, &grow);
+	if (new_off < 0)
+		return new_off;
 
 	if (hashmap__find(set->strs_hash, new_off, &old_off))
 		return old_off;
@@ -141,25 +169,12 @@ int strset__find_str(struct strset *set, const char *s)
  */
 int strset__add_str(struct strset *set, const char *s)
 {
-	long old_off, new_off, len;
-	void *p;
+	long old_off, new_off, grow;
 	int err;
 
-	/* Hashmap keys are always offsets within set->strs_data, so to even
-	 * look up some string from the "outside", we need to first append it
-	 * at the end, so that it can be addressed with an offset. Luckily,
-	 * until set->strs_data_len is incremented, that string is just a piece
-	 * of garbage for the rest of the code, so no harm, no foul. On the
-	 * other hand, if the string is unique, it's already appended and
-	 * ready to be used, only a simple set->strs_data_len increment away.
-	 */
-	len = strlen(s) + 1;
-	p = strset_add_str_mem(set, len);
-	if (!p)
-		return -ENOMEM;
-
-	new_off = set->strs_data_len;
-	memcpy(p, s, len);
+	new_off = strset__offset(set, s, &grow);
+	if (new_off < 0)
+		return new_off;
 
 	/* Now attempt to add the string, but only if the string with the same
 	 * contents doesn't exist already (HASHMAP_ADD strategy). If such
@@ -172,6 +187,7 @@ int strset__add_str(struct strset *set, const char *s)
 	if (err)
 		return err;
 
-	set->strs_data_len += len; /* new unique string, adjust data length */
+	set->strs_data_len += grow; /* new unique string, adjust data length */
+
 	return new_off;
 }
-- 
2.54.0.563.g4f69b47b94-goog

