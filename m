Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508212;
	b=YrqRNyLUOdCZJ8W+HZ7FcTpTsjehf8MmNIn6FPmovf12u825f8rzMbcN2nImB08lq1mr
	 a6Ga2IjPUOEDvZt2AJhefsLCTwPsBXRCQubaiM5moIGOIwdbNewdJmw/0yWMDgNK9Jr5P
	 Vyl8eLNnHAZNaqh+4bjOZckHh8x2VhktmvrBgZ9egUHOoAf1QWhyrjDmZ9PkHQI+2ldfm
	 aNgVX5Cttj4m43HV05/O80hvSD6B+wGmGJQdlgJ8ufV5In2bPK5eLfcBctmtCXAm/Tlhd
	 gcOaoTmdQpXkN4dvzMjdnjZDXyrt12Oi/cmiyVo1O0WK4ASpRtueezOIQLcgNBcxleQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sEH+gk6m5/qnpp5QLh7H9z4ZLDT2OcNjYujc4qYm+Dk=;
	b=KlodpTaZfl19KeeW0GDc/e6+mFF6+lezto7iE5vKm/iIOdQlnvSpHjpCDajiSr4UbTBB
	 BOI4Z2wdKbe3nEH18E53t1PS55upkUOSn/RphoNiFFWEb2qlX0ugMXTI8eAa5l7u14f3i
	 RyfH3uePYySPlNhxx4Yyh1otUwdYg7MAOOGVVKqwzWxNqy+PtGVSWRVU3ZA+bDFkiFqUe
	 RONdxykGlA+U6OqiAz1tGfGCyuNCKcDb+a59WpJ2iGWWI3hCOuyXg6C4gufv7zF+m3DpC
	 uhwlSt+JcTnvRcDt2DZ1hato/YZQmbtXQZ2z7Z44lO6NRP4TibVML48N3uZnwPOu60w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zrcu6evo;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C6606A322
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A53C6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zrcu6evo
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-679a2b5fe87so3096671d50.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508210; x=1793113010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sEH+gk6m5/qnpp5QLh7H9z4ZLDT2OcNjYujc4qYm+Dk=;
        b=Zrcu6evof4TmTlL8EJ+vNp/AeZmAZM4UEJQuTO2FWlDRtEUBlcsAwqWBEkBqrxqy88
         lFcR5J6zuQFTB1wdnpvwB1eTdao4YRs3/EymhL5rcjlB6fo0X19isGR5i+aNtHWtBnYJ
         /FpX1zV1jOK6apWLvv00EO4J/haV3Z1I+yJBFvAZFasa9WM8Qz7Rn593imidrqyW2sD4
         xAZWbA/OGlD6YD7tlna0paFcDg4TybGYOitSFpUjJgsPUOcPpAFVX2ivniGvIz9eG5OG
         oV73HkZaHqzH1DSVhf9gab/O9emUrxXnc43UibE8+yswRfwRIzDHZvEP9pVB5cfefETr
         btHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508210; x=1793113010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sEH+gk6m5/qnpp5QLh7H9z4ZLDT2OcNjYujc4qYm+Dk=;
        b=LVPsXFRAmYtkibCSejcLs2/sK5nQwPb9CG1htrtwRVWSlvr7/7zpVE9NIAONtAprcn
         dbUlPicsLGAJt381r0iQmFTLYcS2kFI9b1zzbcwemGyPuGyfSv8dGUQMiqKemd1hIkx0
         vYq0V+1JcL8Tgv/xcNH4Ol+53GAZhEpxwPDjPxzI2alE9UNdVGqccp1zdow+1dao3XBr
         LXJ8IaYKVgUNj399xic6jfaN3/wSiZBxsGLBLvspnrxbIytKumJfj+yWB0gCxKMnks9V
         MrsCB61Az9pMAdviXsM6jzGLcJeEiEhtiPY4BjQWyZrQziaYyEXsjFMARBzjHzXwLgRK
         dtOg==
X-Forwarded-Encrypted: i=1; AKwUvBydyitnuF9oMy7nHsDB+cgtU1ykUTTX6i4Aaq58dYa/iFfe0dSyBsdQiODUHN164W0WapE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrMayvCao4yC9QWH2+een/QR0pVi2ebRvR90UQ2c5XkcMOuTRL
	ayE3Xi1X+8f2nZGiAfO6J3gXNohJ4MN4XwsPMYlfNi1xFlPdaYr4EYnC
X-Gm-Gg: AYBFou0nYyYz+HXuvbPnXKJ8OMfWZT0jGpahVjUaq3J/2lzWkQ9hZYpnQA1gke+HTOt
	pHbuFvpPXPy2Yc01xm3/hfy8gi2FWY8VsmLD/4MsHL8+pAZfOkxbeIaKmsRJCpj4qowV2zLLFwa
	4f6tquu9nJpAHS1xd0l+m7e43dI1HgCwZNx6stw+BEH6nf61x+KS0yiBoWQVOfUxgcAmqXf0kKq
	juhjmDoc5rLfoyP27GNJT8G+TTBr1HE0ULcnhczgOVQhfmIZI5FQvu6Jbv7zNkCj09z64CT9WSH
	V7ZjvfUmxh6ONotbXhfL52Aag4OUj7/MnpYbHAi4rOWcWs4rvmtuCdrrKuBzBJDnSCyYwbqJfty
	WyL4cDz+XKs9mE5N+aiY3Wt52F1uQFnUoq0zhVs5OByMnvyzciDSdU3k07aZ8SI5dwgcj0hYWvi
	5/iR07FWmplcRDBZMLloc/VN9mIXMmLwcnbJEA7s43GqkNU83d3f9wdktFfEW6gDlO1ClZLKG+
X-Received: by 2002:a05:690e:1448:b0:679:992e:3ad8 with SMTP id 956f58d0204a3-679ca92c9ccmr3733258d50.132.1792508210509;
        Tue, 20 Oct 2026 07:56:50 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8701:205:573e:17eb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1c98a1esm5239944d50.1.2026.10.20.07.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:56:50 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf-next v2 3/6] bpf: Bind trusted fields to their parent's reference
Date: Tue, 20 Oct 2026 10:50:56 -0400
Message-ID: <20261020145059.2146170-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020145059.2146170-1-utilityemal77@gmail.com>
References: <20261020145059.2146170-1-utilityemal77@gmail.com>
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

A field in the __safe_trusted or __safe_trusted_or_null set walked out
of a referenced parent yields PTR_TRUSTED with nothing tying it to the
reference that keeps it alive. Releasing the parent invalidates the
parent's own register but not the walked field, which stays fully
trusted after the object may already be freed:

	file = bpf_get_task_exe_file(task);	/* acquired */
	inode = file->f_inode;			/* __safe_trusted */
	bpf_put_file(file);			/* inode stays trusted */

Set the walked field's parent_id to the parent's reference id, or to
the parent's own parent_id so a chain of derived fields stays bound to
the original reference. release_reference() already invalidates every
register whose parent_id matches, recursively, and regsafe() already
maps parent_id through check_ids(), so no other verifier changes are
needed. An RCU-protected parent keeps bounding its fields to the RCU
critical section through MEM_RCU instead.

Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 534200c0d27d..c85c83a6ee63 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6562,6 +6562,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	const char *tname = btf_name_by_offset(reg->btf, t->name_off);
 	const char *field_name = NULL;
 	enum bpf_type_flag flag = 0;
+	u32 parent_id = 0;
 	u32 btf_id = 0;
 	s64 min_off;
 	int ret;
@@ -6716,6 +6717,11 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 			 */
 			flag = PTR_UNTRUSTED;
 		}
+
+		/* A trusted field is pinned by whatever pins its parent. */
+		if (flag & PTR_TRUSTED)
+			parent_id = reg_is_referenced(env, reg) ? reg->id :
+								  reg->parent_id;
 	} else {
 		/* Old compat. Deprecated */
 		clear_trusted_flags(&flag);
@@ -6725,6 +6731,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 		if (ret < 0)
 			return ret;
+		regs[value_regno].parent_id = parent_id;
 	}
 
 	return 0;
-- 
2.55.0

