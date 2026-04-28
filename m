Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DE3C3420
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407279; cv=none; b=qdafFw8L3/HXEu77XlZIfpOSBaDtgRulSPmDgGZHSEtpG788cdV/t3gdOXox3iBoYwcdfv08IYlpKEEl/ze+EaLzrndeOCxV66p+A4qBuI4QPxoVDQadOFkxfnpF35QyQ8PoTj7FOmN737sa9Ie0eLcSsFvy8no6l0MHLo8xp5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407279; c=relaxed/simple;
	bh=BErp0d1U5+aEsynElziAxBshyx8aO6tR8ZO7B0oRntI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfPMYHNJMemU/BVVOC/IAE28ssEEaXeBwC1t3uY1mczKEjGxg4qqQ9L3KZ+4283McTbXKdW3jdCX2wxWoO2OCQns4tZHn98Oj94iSXn3kqZBe8z7wfFalhL51bZN5iy+voPUmSG+yEmJSRQe4osOg+ccy28zfbNJSIgrabIChao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngJKw7ed; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngJKw7ed"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7baee75f874so102306517b3.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777407277; x=1778012077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxGpxJeTifp2DHb1htw3WR22i3J2taOg3LY7h1xl2kk=;
        b=ngJKw7edwXy13ciAqO5cygnWrQbFPlxGEcXqQgD1YQduBNTohnAN38mWtHm/n4Rhrk
         YgeEfYPgZP6FnYz9YD3CIVDrmpjDKKtCCgKBNVRpCyXwxpsyrlWLH4ARuMzXOOmLeXEV
         Z+D6qBQ05LWa9Z2hQqcw2AA8Cy07+w7WVEMXvOCD877DPSBcfIBg+jomIHSJkqGENNqj
         DBKoZtk/aB9Ad90d2apaHzJ+YIC9qtS5Tdw/3d1mDsay8tXg8sjjl6x+ZKgVl3JhUedz
         m5EjdewANCPUC0Q66IPRhxhv+y584tlSKPsZeX0OLKIkhgAZyMW+1e7nT/BcetwHwcHx
         68pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777407277; x=1778012077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxGpxJeTifp2DHb1htw3WR22i3J2taOg3LY7h1xl2kk=;
        b=PByTFsmvej33WzczGx8GAQ0C1HWNbbitygGX5gseRWldWnaMVZ2etZwF7x9grpqDvF
         kF6iVxKsPMtzdjbNGoHXpHmdn8lx0hLkDTXz5oNn32U+4xIo9Zl7pKnvTJIzZotJ+7t8
         n2GzNhAU2KRggIpuw403YTrrDr9ReMiPxK0uWr2PeRCV7i38PPatx/i7jQQCNrncq983
         /O7TamPLeGm022kMjP2YjUIJVsmK1dgIDzBRhjiQJNGsHAykD52bYogKprFMlJaGunky
         5qHgAxBJ6LwXOx66ipDft0L6xSvGvTnILcUoZpyHF7U1ssEe4YNR4yrwBhZLmLEdqJN0
         7KSA==
X-Forwarded-Encrypted: i=1; AFNElJ/RhLw1xy9pE4s4eeZ8yhawhOc7xfWteyVeLMfusVvn5pzwrXc6vEeYVC3DIDKIPVJgGno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+4digQ0XM3cA46hpvHkGPnzY1gY7QKpoOdvqfRzzkM8c8s7p
	0KkxMU0p9RbQlh5nSp3p63yd7WYm2f8KFH5MVQM8AYq1OI6PAITRb/LI
X-Gm-Gg: AeBDieu4R30dWvcqowGj7yM6AXWuzmcevhqlD03omhfCGmJx/t5jvnbydyAsqfYi5j5
	OPhZkK2F+cdsEHCuDGcIbuL280m85bbyp8fY5LGJz2qgzpcK1XPojyeO5v4bZYBmZDMHR9MbMOg
	sBPao7eXYQVkNuJrjkCYCk5/xHekH2XOq0kIrsscWve8rF1Kwt97PbqmMmyHsrfKCCu9lCgdetu
	4WEgyvBUQ7X2KyKP6BXja27+GAWbd9gC9C/c6Q1lzfxTrZxP+LvMmvbY08lCIkGDMnTfL5vhh8q
	O1wnFD1dlabC6BPfE1ztqndH28gSUNzh2t9Y6QoaFZx/fowj+B5oohSjE2JgyVjNes9xZmFFBq6
	32LS2g3+TxypyQGKA2hWKhFqlA6+FS1uiyPQf/UrVxWJ88inKY50DXvqllRxgEry5RKqI0Zje5f
	fgnfWIXMqVGWdaNHmnxjeBaVI0s1j/B9SBQeW7YRjd/Jcz8FzHRUxGEZ05wIIM1ONXSosVFzsD0
	hQF5vcisrM=
X-Received: by 2002:a05:690c:e3cb:b0:7ba:f6b4:358b with SMTP id 00721157ae682-7bd1dac9a1cmr12156067b3.43.1777407277081;
        Tue, 28 Apr 2026 13:14:37 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:4c60:c627:eabb:73c3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd25af5385sm1392077b3.48.2026.04.28.13.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 13:14:36 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 1/4] bpf: Limit fields used in btf_record_equal comparisons
Date: Tue, 28 Apr 2026 16:14:19 -0400
Message-ID: <20260428201422.1518903-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428201422.1518903-1-utilityemal77@gmail.com>
References: <20260428201422.1518903-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compare the fixed btf_record header and each btf_field explicitly
instead of memcmp'ing the whole allocation at once.

This is necessary for the follow-on patches which extend record contents
with data outside fields but part of the record that can't be compared
meaningfully.

The comment is updated to reflect individual field comparison, and
retain useful information about zeroing behavior, while referencing
auxiliary data attached to records as a reason for the individual field
comparison.

The reference to auxiliary data attached to the record will be relevant
with the next patches.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/syscall.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3b1f0ba02f61..2caafce00f24 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -760,7 +760,8 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b)
 {
 	bool a_has_fields = !IS_ERR_OR_NULL(rec_a), b_has_fields = !IS_ERR_OR_NULL(rec_b);
-	int size;
+	size_t size;
+	int i;
 
 	if (!a_has_fields && !b_has_fields)
 		return true;
@@ -768,7 +769,6 @@ bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *r
 		return false;
 	if (rec_a->cnt != rec_b->cnt)
 		return false;
-	size = struct_size(rec_a, fields, rec_a->cnt);
 	/* btf_parse_fields uses kzalloc to allocate a btf_record, so unused
 	 * members are zeroed out. So memcmp is safe to do without worrying
 	 * about padding/unused fields.
@@ -780,10 +780,24 @@ bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *r
 	 *
 	 * So while by default, we don't rely on the map BTF (which the records
 	 * were parsed from) matching for both records, which is not backwards
-	 * compatible, in case list_head is part of it, we implicitly rely on
-	 * that by way of depending on memcmp succeeding for it.
+	 * compatible; in case list_head is part of a record, we implicitly
+	 * rely on that by way of depending on memcmp succeeding for each
+	 * individual field.
+	 *
+	 * Comparing the whole record may be incorrect due to auxiliary data
+	 * attached to the record.
 	 */
-	return !memcmp(rec_a, rec_b, size);
+	size = offsetof(struct btf_record, fields);
+	if (memcmp(rec_a, rec_b, size))
+		return false;
+
+	for (i = 0; i < rec_a->cnt; i++) {
+		if (memcmp(&rec_a->fields[i], &rec_b->fields[i],
+			   sizeof(rec_a->fields[i])))
+			return false;
+	}
+
+	return true;
 }
 
 void bpf_obj_free_timer(const struct btf_record *rec, void *obj)
-- 
2.53.0

