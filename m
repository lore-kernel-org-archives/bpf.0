Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E45156F45
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553651; cv=none; b=OeZbQFl43A7SfV6TD9CWg1s3utf+mnIeWjDr/RLbvW+xzdrgHu7cTp99K3gqiVoBzKvvksfqWAZyaH4HBsopf5GP6jaL6HU2hyFIA2g0Jj7nLfnQIJrTzSaT3f0wiiASxylbnkGl0s8LxQefIvQqvbVz5a0WHGkJw3NzFbLIDUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553651; c=relaxed/simple;
	bh=F8nw7M0+tF4OHZ6NYPgvS8E02lHrwRSGwOXPHLI3pV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=egnHSyT2eJ2TBugpa5gMOqZ7vJVvbdK1P/lspwFzRkENwfM7s1foCyTKjzUiXNpHnuOL8YK38QGQtNNP7uYVorbcY6oNXMW6pZKNxkBmt6QjEp2h6SqtWSOsymfAP66wzITjpsI4qrHmrysoU8PkZziZcV8kLgisx/bMQUf56oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YgqtrW+s; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgqtrW+s"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ee34588671so9360431eec.0
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779553649; x=1780158449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd/tUqQcMfFQAxReTEdDtkWo6QGX1KBNJNik7T9QchI=;
        b=YgqtrW+sOIn1nmmQfrDG5kCxxhhR362bMPLAX+niaLPz01l2e8dZJlIU5AAnE/RbPH
         WU+1JC3SO27J8hStvfUD0RgOalo2yCBNuspl6YY8WxTyGSMzTHVsUtmiBMetnIDyMs04
         wz2RJVo0qwbq2B3qaZRjx3D4/fRr6z8jm8WZnOZG6lOUaju6jhuiJ5Ycf7Vn8n6LAPMw
         w8bF1kJ0iLdRUoPCRDyE6UtAG6/uK27uEYBKBhLi0KsHzu5PeGq0dVUH5jMsggdW47ZF
         CQbh6kBXhEfKo/tmDbC1RzfBzSZqE808GeoGW8KAtOuuZl9905uVkdLPFmKGq7CGKagl
         PvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779553649; x=1780158449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd/tUqQcMfFQAxReTEdDtkWo6QGX1KBNJNik7T9QchI=;
        b=sSlBnpy5YDbk9ZJxUBqPxYM0LP3NxFIVB0XwtAoL/qn9EoQlUt5rn6Ty+ghlMRaO+S
         UzCoVPpNlzljIUrl1ZwIu8qahvEzOhfQv2w1dPOwkqK5/Nc5RgcrrtaFG4c5KEng2aOm
         Yby5uKs30RxbAV/s3aQlIIsQ9xxkfO6KZNqsk+wD9mRNrhIx5kp49TwxMBHrb9pUgnXU
         kqQ+w8/I2nNgWGEhrRZ8XF10bi8GN4XFI1r4Ywh7LwcO3KpR89/2nIYM1UMEJLJ4vHEK
         qbMJm+SM0+VOgCT9aYqxy8NobOagqv07gf/kEOz0C0/qgDu5LDN/wSfJCryiG2p48ZIv
         ccMg==
X-Forwarded-Encrypted: i=1; AFNElJ+bQwlIVh6Q2fsszxwZhPaHlXbCQ6F6rROmEBtL4MR6kBeqIBvHetEcbqV43oVRrB5Eawk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLzoKl5XySmBbE0nDOORTvXtbMvfr0M197VMG5JzIoJZrWQOEQ
	nku/zdzA0uNs8j0J8XOERzRQX8jQYsyHfXQIEfIhlUBASS+/jIlKAfj02wveQGjcmTZSAerUq7q
	HgY4o49kf9zSkTQ==
X-Received: from dyu18.prod.google.com ([2002:a05:693c:8112:b0:2d5:d26c:d4bc])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:3809:b0:304:ab8:f89a with SMTP id 5a478bee46e88-30448fd5c6amr4254238eec.1.1779553648914;
 Sat, 23 May 2026 09:27:28 -0700 (PDT)
Date: Sat, 23 May 2026 16:27:21 +0000
In-Reply-To: <CAEf4BzbM7G8nVqtrW+fs5J9Hm4cqszA9CTETBCHLP7T8GPMs3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAEf4BzbM7G8nVqtrW+fs5J9Hm4cqszA9CTETBCHLP7T8GPMs3Q@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523162722.2718940-1-cmllamas@google.com>
Subject: [PATCH v4] libbpf: fix UAF in strset__add_str()
From: Carlos Llamas <cmllamas@google.com>
To: mykyta.yatsenko5@gmail.com, andrii.nakryiko@gmail.com, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	"open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>
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
v4:
  Store pointers as integers in advance before realloc to prevent UB.
  Access set->strs_data directly, not through external API.

v3:
  Switch to 's' reconstruction approach suggested by Andrii.
  Adjusted names and commit log accordingly.
  https://lore.kernel.org/all/20260518050550.2600101-1-cmllamas@google.com/

v2:
  Implemented the fix in strset__offset() helper as suggested by Mykyta.
  Added support to handle "substrings" of existing ones.
  Used 90d76d3ececc as Fixes tag as suggested by Sashiko.
  https://lore.kernel.org/all/20260515044759.2863546-1-cmllamas@google.com/

v1:
  https://lore.kernel.org/all/20260513232055.1681859-1-cmllamas@google.com/

 tools/lib/bpf/strset.c | 59 +++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
index 2464bcbd04e0..b9faca828f09 100644
--- a/tools/lib/bpf/strset.c
+++ b/tools/lib/bpf/strset.c
@@ -107,6 +107,38 @@ static void *strset_add_str_mem(struct strset *set, size_t add_sz)
 			      set->strs_data_len, set->strs_data_max_len, add_sz);
 }
 
+static long strset_str_append(struct strset *set, const char *s)
+{
+	uintptr_t old_data = (uintptr_t)set->strs_data;
+	uintptr_t old_s = (uintptr_t)s;
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
+	if (old_data && old_data != (uintptr_t)set->strs_data &&
+	    old_s >= old_data && old_s < old_data + set->strs_data_len)
+		s = set->strs_data + (old_s - old_data);
+
+	memcpy(p, s, len);
+
+	return len;
+}
+
 /* Find string offset that corresponds to a given string *s*.
  * Returns:
  *   - >0 offset into string data, if string is found;
@@ -116,16 +148,12 @@ static void *strset_add_str_mem(struct strset *set, size_t add_sz)
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
@@ -142,24 +170,13 @@ int strset__find_str(struct strset *set, const char *s)
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
2.54.0.746.g67dd491aae-goog

