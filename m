Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7970344DAD
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345174; cv=none; b=GoTBErPY1vLi1x8+LM+XBjHVSeAI2Zx6n9Oa2bgiNULdAEkaPfKgu0ZiSnZ7CgczSqzvrgEavAkAu+i+ScIY2gDya6hbUtwYDdP4QU20KgED/Zn6iVA/aPFam5s5cWLWZwDyxF4Rcpc2K6r04KwJKVSOiJkMaTMN1ilun6hhqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345174; c=relaxed/simple;
	bh=Z50jSNeLeGTyMRpxmGVh8iUwVhsSEfaUGZ+I1whNrdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqsWMavIYBHACfDIYrq0WtkHiLwXI1ea33vQAv4uBzSJGj1zEa7VrMC2owaLzztICelfm7LxId1XqSZj1AyKaZgJOzrUApB7YETy4wsRAVlp02kd8Q8YwgUqK7BppfwJeQ1xEoUeZlnRNcIKQddQxUJ0FMxTdXYzNoEb4YKdLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYsjQQ18; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYsjQQ18"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso80905815e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345171; x=1776949971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqW69gPfsBdFMFFtMxVFS6nM1cBA288eCVvqNT4w9vA=;
        b=iYsjQQ18dv65kXN8OvpGHYkhr25JhyKqj1EF0xeuNyq5AKghKnbTTomZxqZLX9RA9P
         n9gjz2MFojJ993XkaMEldmu1Ji+LzjKU77pQhPl0xBeDe366hoAmKX5bvTXn2/O9xpwp
         1OpZbC3WAd5WdX+fgh5aCbkHavy4JhlLJo52aDe+ItSxZ+R5iELi3K+Mc0fFiJgcza2a
         5v/+AjDlfsHD7dAHmojnsCg50v+ZA0kKZ6OVQe5Y+PeuDMAXV7+6Y2QarmnGBkJPKTk+
         s3vJk97F0CjWNNhGjqbBfF32DhkNQnZFQFDxat1aYhOV7JfXvEmLu7taBzunPedmygBo
         y8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345171; x=1776949971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqW69gPfsBdFMFFtMxVFS6nM1cBA288eCVvqNT4w9vA=;
        b=KhFcYU5/5PL9E+6mKBeVcO8pqQAj6Caz3qaODVlrxjPnvwthjKYwqBtZPJGne3rcLl
         TjON1+ZbJnnCw+8p8/xBEnkdak6nA+paVQCVES6MXN4ZLPjPQ/taI8DI8NYH7y6r7GKo
         0fTo2x9edRqN2l/WmrITnx2/TvYEgu9ulrubt+WWPpCOezfyQrAcb/VxFkgxSEyUvIge
         6FnFDgbh/JF0vGZMwLkq54nqxuCnaBbuXT2FE7p0bxSzKn2Xz2qFq5T0YsVVKYo+SKEC
         eAOwPP5prlehiJCE7r/e5Y1SmtEDrzzhOS1yiW4pPWaeYShgubVxRXoQGbdyqIHim/ve
         R/uQ==
X-Gm-Message-State: AOJu0YwbOfeo5jwsghiaK1TpX69h9HFuqfjMMJNEcibLtj7dYcOU/+0Z
	USHVdP3eHQsVpdxsh/5Pbw1xmDBeAKeM0POFsuk+6AVaXa90IW1TCVDhC/wPLN33
X-Gm-Gg: AeBDieu1iP3cnkZOxxopGdVMAvLfe2PCXwq6LLJH9l/TmW+pD4HW8RDEwILQEKMZUjl
	VMmPiAfr/kN0F7/FTqB+gohgjAcCA21FoIqVtlH2h/YVkhJuvbc/hBVZO4KbvtmRW5RuDRKQ2WX
	FP3LvhBQ5Ox1ghmc8xDD4A/IHpnZ26vGLqLzaeCYF/GqYB8FME6DimZAVwy9Csvffq2FRu/VkKP
	VyWiGWxBgIQRPX7aNdifdbYlQk23zq/A4SETk+1QKFcK9+GC8xeL616HXpUHCc4C0qDJ5QBDkQq
	E/xhdcNtJ+lsWwtedQtN68NiM9FZAU0qTEuXNI9JmI5GcNzply06Ku8AOa3tBQ2mZkTPsVcsy32
	eWigN+iWZPG4DKC6j0LJnXYgPeAQNWAcJ8na03Zp7MmHwCXm4JfHZXQ/onj2uoJO0BOK4VMPaC4
	RfSU6SODwJyNcMa3A2Ppi9deh9Ak9jjtHUfy6C8uo+mFc4IeDlDzMDT5gubwz5dFtUZKYKHEFjR
	jLX4jkA/nt2+lHuciF16klCKM7/seXyWAUe7AxePUxlg8+A2GlKoDA2VYTL+PvKvu9x4WfsRvUj
	dr7bBt90n96cwkN3vv8GiH42yrUeD8igB3Jwtsd9zYGRoM4gHboe
X-Received: by 2002:a05:600c:5249:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488d680577dmr344793685e9.2.1776345170809;
        Thu, 16 Apr 2026 06:12:50 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b55a04a9836ebec0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b55a:4a9:836e:bec0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5827145sm56855405e9.13.2026.04.16.06.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:12:50 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:12:48 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Helen Koike <koike@igalia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH RFC bpf-next 4/7] bpf: Improve 64bits bounds refinement from
 u32 bounds
Message-ID: <b2a0346a5b0818008503b721c62621918d84ad0a.1776344897.git.paul.chaignon@gmail.com>
References: <cover.1776344897.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776344897.git.paul.chaignon@gmail.com>

This patch improves the refinement of 64bit bounds from the u32 bounds.

u32:     xxx         xxx         xxx         xxx         xxx
     |-----------------------------|-----------------------------|
u64:                        xxxxxxx

The above diagram represents a u32 range mapped on the u64 line.
Because the umin64 doesn't match the u32 bounds, it's clear that it
could be tightened to match the next umin32 value:

u32:     xxx         xxx         xxx         xxx         xxx
     |-----------------------------|-----------------------------|
u64:                             xx

This patch implements the logic for this refinement, for the min and
max bounds of u64 and s64. This refinement only takes place if the 32
lower bits of umin64 are outside of the u32 range. In that case, we
update umin64 to the next matching umin32 value. For the max bounds, we
proceed in the same way, but update umax64 to the previous matching
umax32 value.

Note that when updating the min, we can run into an overflow. It
corresponds to the following case and doesn't require special handling.

u32:     xxx         xxx         xxx         xxx         xxx
     |-----------------------------|-----------------------------|
u64: xxxxxx                                                   xxxx

This patch also updates reg_bounds to implement the same refinement.
That change is small because commit 2fefa9c81a25 ("selftests/bpf: Fix
reg_bounds to match new tnum-based refinement") already implemented
similar logic to the above in reg_bounds.

Together, these changes to the verifier and reg_bounds fix the selftest
"(s64)[0xfffffffe000000ff; 0xffffffff00000000] (u32)<op> S64_MIN+255".

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c                         | 50 ++++++++++++++++---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 10 ++--
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d5d2b7e5140..bcf8a38a4d72 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2273,17 +2273,51 @@ static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
 	 */
 	__u64 new_umin, new_umax;
 	__s64 new_smin, new_smax;
+	__u32 umin_32lower, umax_32lower;
+	__u32 smin_32lower, smax_32lower;
 
 	/* u32 -> u64 tightening, it's always well-formed */
-	new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
-	new_umax = (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
-	reg->umin_value = max_t(u64, reg->umin_value, new_umin);
-	reg->umax_value = min_t(u64, reg->umax_value, new_umax);
+	umin_32lower = reg->umin_value & 0xffffffffULL;
+	if (umin_32lower < reg->u32_min_value || umin_32lower > reg->u32_max_value) {
+		new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
+		if (new_umin < reg->umin_value)
+			/*
+			 * The potential overflow here corresponds to the
+			 * following case and doesn't require special handling.
+			 *
+			 * u32:     xxx        xxx        xxx        xxx
+			 *      |---------------------|---------------------|
+			 * u64: xxxxxx                                   xxxx
+			 */
+			new_umin += 0x100000000;
+		reg->umin_value = new_umin;
+	}
+	umax_32lower = reg->umax_value & 0xffffffffULL;
+	if (umax_32lower < reg->u32_min_value || umax_32lower > reg->u32_max_value) {
+		new_umax = (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
+		if (new_umax > reg->umax_value)
+			/* Cf comment on new_umin for potential overflow. */
+			new_umax -= 0x100000000;
+		reg->umax_value = new_umax;
+	}
+
 	/* u32 -> s64 tightening, u32 range embedded into s64 preserves range validity */
-	new_smin = (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
-	new_smax = (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
-	reg->smin_value = max_t(s64, reg->smin_value, new_smin);
-	reg->smax_value = min_t(s64, reg->smax_value, new_smax);
+	smin_32lower = reg->smin_value & 0xffffffffULL;
+	if (smin_32lower < reg->u32_min_value || smin_32lower > reg->u32_max_value) {
+		new_smin = (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
+		if (new_smin < reg->smin_value)
+			/* Cf comment on new_umin for potential overflow. */
+			new_smin += 0x100000000;
+		reg->smin_value = new_smin;
+	}
+	smax_32lower = reg->smax_value & 0xffffffffULL;
+	if (smax_32lower < reg->u32_min_value || smax_32lower > reg->u32_max_value) {
+		new_smax = (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
+		if (new_smax > reg->smax_value)
+			/* Cf comment on new_umin for potential overflow. */
+			new_smax -= 0x100000000;
+		reg->smax_value = new_smax;
+	}
 
 	/* Here we would like to handle a special case after sign extending load,
 	 * when upper bits for a 64-bit range are all 1s or all 0s.
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index c0b3a357a0f4..d38550fc1624 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -500,7 +500,7 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 	    (s64)x.a >= S32_MIN && (s64)x.b <= S32_MAX)
 		return range_intersection(x_t, x, y_cast);
 
-	if (y_t == U32 && x_t == U64) {
+	if (y_t == U32 && !t_is_32(x_t)) {
 		u64 xmin_swap, xmax_swap, xmin_lower32, xmax_lower32;
 
 		xmin_lower32 = x.a & 0xffffffff;
@@ -518,8 +518,8 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 			 */
 			if (xmin_swap < x.a)
 				xmin_swap += 0x100000000;
-			if (xmin_swap == x.b)
-				return range(x_t, x.b, x.b);
+			if (xmin_swap != x.a)
+				return range(x_t, xmin_swap, x.b);
 		} else if (xmax_lower32 < y.a || xmax_lower32 > y.b) {
 			/* Same for the umax64, but we want to *decrease*
 			 * umax64 to the *maximum* value that matches the u32
@@ -528,8 +528,8 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 			xmax_swap = swap_low32(x.b, y.b);
 			if (xmax_swap > x.b)
 				xmax_swap -= 0x100000000;
-			if (xmax_swap == x.a)
-				return range(x_t, x.a, x.a);
+			if (xmax_swap != x.b)
+				return range(x_t, x.a, xmax_swap);
 		}
 	}
 
-- 
2.43.0

