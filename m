Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5A3ACF18
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255180; cv=none; b=mNa2MSODk91oW1nsCGpV2LjTDglnisX+pamPvEYXNE734hUDgc4+8KQBEtoM0ChpnYymLww88B4FZ1WJ2eoYOCyOZtzIK4UHYhu4raWILZK+jRR1C33cA5osyfBB+HtyetzDSKfWaU2OLRGyKyMN5VE63kuv0Uwihnh/3v597k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255180; c=relaxed/simple;
	bh=jqT5Ab18KbkMPLG5nuVmKYwi9/htcEz1suyx38WJeRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=im4+c25XNKTKencWRQpJJDnI+9/pRlUnAYaUVi0PQZTb40x7/0gki3QaaqYGB9quixE3TqOoURzJBIIRlSmttztiHpz/ZwcMFBwyMy7KwDFX3RemRtMSpJJLkwU3UKRNLyQR4da0L/pySayWa0O1YOtb2L+8rT5M4S3z11ZMdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHp+M4b8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHp+M4b8"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so358687b3a.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255178; x=1792859978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nIpcC7WsRUsfob/M32I+w1LmmQqZv3hP9zFFPAjnTx0=;
        b=KHp+M4b8kEF4X4L9pHkqbUBN3Cx44JEyv0oAmlCh2OOSMPhXu66oIVkXkXyt77RBcE
         eUu9xOWnhD9OdIG/gEWOKSe6hPTSAHsLExd+jXkvX/FEHyiAqv+29U2jHOaHBXTfR9XP
         p6KrsxJEesYbP+Cm10LDm8x8ILQGgRu4fhoKDKaA/crC+7TO6vTeiA0M7+hnzCUWSbSP
         j3iG/LJz0IEFHC/uCbkaALTwo9oJYdK6jFQNHAkRp5yiB0cqxNtSUmrCy1D/89ar4B0r
         5qs5/yv0SVOR3h1eLt/lbqhkHUwXqKfzHcBa0Hqkrm4inAWE/20MHqMPoLGT10GO0gEC
         Q/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255178; x=1792859978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nIpcC7WsRUsfob/M32I+w1LmmQqZv3hP9zFFPAjnTx0=;
        b=27e3X85Fno8WuPN7cAdqj+Q8HCCnNw8ND9GZe7NcuZDVKVXsFJQRA5EaNTArk4WiI2
         XAK7MtbmLjMkT6cLMChrzTBPltTqgVArmqnfaWSScy5mgmnPVLVD3AevXmuiGwyH6Dhn
         HbbjFD0pzQBRzD1oD7gaaPIUHaDjsZD3NZjDqIdspBGzgVrHe01085pTydA7778Atl2w
         pv7jLHakN1TAhSszBdwcfu95OglCf0MoT9TgxJu0RB2jCsVj6BYJaRYHy1lOYJOnYuhl
         Dud5z4IoY7US/bpnOVcf8vspDjbyftlRguZ8hJzcX7PXzYaKIKPBjqDAP89Hfh9C+iYm
         oSeA==
X-Gm-Message-State: AFq9FYIEjhFLxDKbgykna4QHoQavqfORc0h82Jz51duVhSbBNUzeWcRO
	3scnsO02X4AYsYUmXfYsODdU0i0pcV3ef6aL3QzToFjcT9Q1qx+v3dOH8DATBw==
X-Gm-Gg: AYBFou07b2G0pPUIKmBi7OBG8qVBTMTukUlqqFU6VkLK169mj3F8au58slixUuoOMNP
	6MFIjy8bqyuwKLWGUKFIH1g34H8ORyT4HJad30aqF6/9pVDyDv+l9+/xy1r1rHz7clIFlm+jG7B
	Ah//A7T12eo7OrJDlrP0TGAfF3siAWQ5ID4GFuHXNGAGKmGLLonu3cRJj9dTT4NOMyEemt18TUK
	2bnLlhhaDjWUNXrM9Mhezd7s2oqTIe0gIk7j9xAB4U5RviA5PHBq1OWkGVrwE5MAYASZEeZfcov
	hwL5WM9bvKgRy+jP7uYx91jFX+vvV9Nms1+pdxdhilZWPRtPPGAZMVuUkWIsFHJrKC6c+WkcOMH
	rxpuhZ/iAhoYgykBrCtbECGRhyn64tD+YHI+lvVtJLECzfgiQTiVAq1YIh9+caNdJX0isSLB9ZZ
	uhHMW410VzWobka9dASMFWLZnyOpq+ngJpPfotv9zmvqSQFkfuZeHRzN93Kwg2JwJgupc6LuycN
	PltGddobMRri867TzSkSsDT/B4gt7jSeHJGfUNy+KJKttwVZoLufJbTtJTeX4J2QinU2wbNLgkW
	qby7n6gQ3ZW/PjFxgnZ0hJvklAGGjtBE3hrqS9Goe5B/
X-Received: by 2002:a05:6a00:1891:b0:89f:5ac6:32f1 with SMTP id d2e1a72fcca58-8a04bb360fbmr2044013b3a.23.1792255178073;
        Sat, 17 Oct 2026 09:39:38 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5735dd55sm2296489b3a.26.2026.10.17.09.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 18/43] bpf: Bound the nesting that the BTF show code follows
Date: Sat, 17 Oct 2026 16:37:20 +0000
Message-ID: <20261017163745.3341787-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

btf_struct_show() and btf_array_show() recurse for every nested struct
and array.  MAX_RESOLVE_DEPTH bounds one resolve walk when BTF is loaded,
not the nesting: a member whose type is resolved already is not walked
again, so BTF that defines its types from the inside out can nest them as
deep as it has types.

Whoever may load BTF, with CAP_BPF or a BPF token, can give such a type
to the value of a map.  Reading the file of that map in bpffs then
overruns the kernel stack: with a few hundred levels the stack guard page
is hit and the kernel panics.

Stop at 32 levels.  That is MAX_RESOLVE_DEPTH, and __btf_show_indent()
has as many columns.  Nothing is shown for a member that lies deeper, and
the status becomes -E2BIG, which bpf_snprintf_btf() and
bpf_seq_printf_btf() return.  The types of an x86_64 defconfig kernel nest
14 deep.

Fixes: b00b8daec828 ("bpf: btf: Add pretty print capability for data with BTF type info")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64c78434fa05..a9bf4c3c0a27 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1081,6 +1081,8 @@ static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf,
 }
 
 #define BTF_SHOW_MAX_ITER	10
+/* nested structs and arrays shown; __btf_show_indent() has as many columns */
+#define BTF_SHOW_MAX_DEPTH	32
 
 #define BTF_KIND_BIT(kind)	(1ULL << kind)
 
@@ -1474,8 +1476,18 @@ static void *btf_show_start_aggr_type(struct btf_show *show,
 				      const struct btf_type *t,
 				      u32 type_id, void *data)
 {
-	void *safe_data = btf_show_start_type(show, t, type_id, data);
+	void *safe_data;
 
+	/*
+	 * Structs and arrays are shown by recursion.  BTF loading bounds the
+	 * depth of one resolve walk, not how deep resolved types may nest.
+	 */
+	if (show->state.depth >= BTF_SHOW_MAX_DEPTH) {
+		show->state.status = -E2BIG;
+		return NULL;
+	}
+
+	safe_data = btf_show_start_type(show, t, type_id, data);
 	if (!safe_data)
 		return safe_data;
 
-- 
2.55.0

