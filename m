Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA228380FCA
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 05:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080756; cv=none; b=NvPn1Jn4G92Lyqsw22AJOScUjwHMqgqhujwiARHr7eFkhSA+u7flFRhGtvdItMouA4v26iqJjkiMKtwgfhrSLS6QKLEvCGflHBig/3fP13g5h0Q09fK/UdJWuShDrl8xdcYWI8hFukaofwDNTITweRs3Z8e1c87mChzDAuwZsOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080756; c=relaxed/simple;
	bh=K1Wq278vsgpAJ82/1xnQlDmx7QnSoRuuUTYRlUgEGik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YbkJ4cA67uC1+9Ljr+zzMWgNZoNY9QD9hvSJqi9M/wNGd8PNIlNtLRTIhO64DwtqmjygrEWqoKZzFhs5NZv9pyzQae9cdWVI9Pw8n10/CcJXGuQEc2MxUGgd6XbzdSPWZxBHGL3tdCWVpoMtD1wZ4kEdJT1nmPCP+f07JLwYi20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBatnoQY; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBatnoQY"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f485961555so6648392eec.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 22:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779080753; x=1779685553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldbviCQOock1GEaZ68ZDQA1lEpoIOnI4AhsQB6ucOCg=;
        b=BBatnoQY9TpBzunvTwewmrKCwlkoq/uUDDu7QvLgS27rt57YQfeQb5Nqvkhnk0EX+U
         oDBZoREio9FZYaUH/wwcCsBhoKuVV7gZRqEhC+5eQ/CNUvyaxAhd619SvSDg65vFsD20
         tt26LODSBZaoUpmn+Y+K4Fnk5yL5GD8Cke6121sBxOVAeYqpLa93kl1A3jQg8djQfjYY
         bX/4IeTPiblbpXLeZsUiix/cWlxaqvaBqvl0v3X/k+TJmx5JBIach4V9e6gFF2wFOetu
         gYAze/dxbZy/Hkie4fpHcA37+ylPr/0bK9ZqjgqMCBEBRDivONkP74/skf7ExGiXAo5Y
         pu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779080753; x=1779685553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldbviCQOock1GEaZ68ZDQA1lEpoIOnI4AhsQB6ucOCg=;
        b=ouLyTjvQCSfFrAB6IdEgYbRScm45GQ7HQQi7/HlQBTVBbbOzDAR2ffAxfMdyWEaFNe
         YiD2FGSLVFvgCnxUKiDRZvqDsUeRbUibzQD8uAmMo/7mnDMg7HkReuhv79OLarUu3ZPI
         C+SduZdw13CXGpQTpysRNBugY0+5B5igTT9tHO65T5C6wjxJrLuZRA89Ph6LfqA6sCtC
         ynJMF14Rrrf8h8ZFuvE4K/XuCYT7aotPMzEqZahr0FRpWhQ44YHulrEw6Hpf0yRJVW9z
         QtirMecbw1aiRD8UqKAqBE8bdaRE4IPEZ9I16wOSq1mypgIX6A2mTYHnPPi1SCCQzUJh
         l5aQ==
X-Forwarded-Encrypted: i=1; AFNElJ+00HLeRWTy91UCBBntBQsIboSKOKojSLY4FMicQYMAnNIlbR2mby34TCwWQiuf4mzMC6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2x56l58TEh89ycE0hMtn1cX2D4a3u/NHjmfEmRsohQnAQuB+/
	DiJCrFzJOp1UI80A1vvRsK0XUBW1RswZJCGtDOzJIGPnfv9Ef3mBmHMMhirtR06jwTbpe6v3vmJ
	BFrdEB0T9y6dckg==
X-Received: from dybpn9.prod.google.com ([2002:a05:7301:4389:b0:303:c170:9611])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:2a0f:b0:2d9:6373:ad10 with SMTP id 5a478bee46e88-3039812a653mr5447126eec.7.1779080752752;
 Sun, 17 May 2026 22:05:52 -0700 (PDT)
Date: Mon, 18 May 2026 05:05:49 +0000
In-Reply-To: <CAEf4BzZMoWdgYFGXwT9kkZ1TKbe9ZB=XKJCuKy0+2uqzSMDMUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAEf4BzZMoWdgYFGXwT9kkZ1TKbe9ZB=XKJCuKy0+2uqzSMDMUw@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518050550.2600101-1-cmllamas@google.com>
Subject: [PATCH v3] libbpf: fix UAF in strset__add_str()
From: Carlos Llamas <cmllamas@google.com>
To: mykyta.yatsenko5@gmail.com, andrii.nakryiko@gmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
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
similar scenarios.

Let's check if set->strs_data was reallocated and whether 's' points to
an internal string within the old strset buffer. In such case, 's' is
reconstructed to point to the new buffer.

While already here, also fix strset__find_str() which suffers from the
same problem by factoring out the common operations into a new helper
function strset_str_append().

Fixes: 90d76d3ececc ("libbpf: Extract internal set-of-strings datastructure APIs")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v3:
  Switch to 's' reconstruction approach suggested by Andrii.
  Adjusted names and commit log accordingly.

v2:
  Implemented the fix in strset__offset() helper as suggested by Mykyta.
  Added support to handle "substrings" of existing ones.
  Used 90d76d3ececc as Fixes tag as suggested by Sashiko.
  https://lore.kernel.org/all/20260515044759.2863546-1-cmllamas@google.com/

v1:
  https://lore.kernel.org/all/20260513232055.1681859-1-cmllamas@google.com/
 tools/lib/bpf/strset.c | 58 +++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
index 2464bcbd04e0..d229961ff2fc 100644
--- a/tools/lib/bpf/strset.c
+++ b/tools/lib/bpf/strset.c
@@ -107,6 +107,37 @@ static void *strset_add_str_mem(struct strset *set, size_t add_sz)
 			      set->strs_data_len, set->strs_data_max_len, add_sz);
 }
 
+static long strset_str_append(struct strset *set, const char *s)
+{
+	const char *old_data = strset__data(set);
+	long len = strlen(s) + 1;
+	void *p;
+
+	/* Hashmap keys are always offsets within set->strs_data, so to even
+	 * look up some string from the "outside", we need to first append it
+	 * at the end, so that it can be addressed with an offset. Luckily,
+	 * until set->strs_data_len is incremented, that string is just a piece
+	 * of garbage for the rest of the code, so no harm, no foul. On the
+	 * other hand, if the string is unique, it's already appended and
+	 * ready to be used, only a simple set->strs_data_len increment away.
+	 */
+	p = strset_add_str_mem(set, len);
+	if (!p)
+		return -ENOMEM;
+
+	/* The set->strs_data might have reallocated and if 's' pointed
+	 * to an internal string within the old buffer, then it became
+	 * dangling and needs to be reconstructed before the copy.
+	 */
+	if (old_data && old_data != strset__data(set) &&
+	    s >= old_data && s < old_data + set->strs_data_len)
+		s = strset__data(set) + (s - old_data);
+
+	memcpy(p, s, len);
+
+	return len;
+}
+
 /* Find string offset that corresponds to a given string *s*.
  * Returns:
  *   - >0 offset into string data, if string is found;
@@ -116,16 +147,12 @@ static void *strset_add_str_mem(struct strset *set, size_t add_sz)
 int strset__find_str(struct strset *set, const char *s)
 {
 	long old_off, new_off, len;
-	void *p;
 
-	/* see strset__add_str() for why we do this */
-	len = strlen(s) + 1;
-	p = strset_add_str_mem(set, len);
-	if (!p)
-		return -ENOMEM;
+	len = strset_str_append(set, s);
+	if (len < 0)
+		return len;
 
 	new_off = set->strs_data_len;
-	memcpy(p, s, len);
 
 	if (hashmap__find(set->strs_hash, new_off, &old_off))
 		return old_off;
@@ -142,24 +169,13 @@ int strset__find_str(struct strset *set, const char *s)
 int strset__add_str(struct strset *set, const char *s)
 {
 	long old_off, new_off, len;
-	void *p;
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
+	len = strset_str_append(set, s);
+	if (len < 0)
+		return len;
 
 	new_off = set->strs_data_len;
-	memcpy(p, s, len);
 
 	/* Now attempt to add the string, but only if the string with the same
 	 * contents doesn't exist already (HASHMAP_ADD strategy). If such
-- 
2.54.0.563.g4f69b47b94-goog

