Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4FE31353C
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097654; cv=none; b=NczMeUv8VXi/ncrDCdTHUKocudkUFbgd7wmcAPLaxfyMHsRUNKakkmdxp3rhh5QA/iyPGfRcRfMltgn8Tjhz4mykvU6u9eB+QASa6kZURAl1eSZ/GSbNoexRfc576AAHrntn+CKG6QfNJvZuuusX4jnJpbcKRV4BJXJK0EUjPoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097654; c=relaxed/simple;
	bh=knjNBY6KXAPQZlQe9bRNtDcGvCjmUroOBBgMdrKU/6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMmIZrfFk1iFtqvbJnEGfhevfypAfMleCIUkIyR/nLcn48Rb9X7CtZOzJF24nj3/+wx8jBYA/x6Dlftat0jcs8q8qCb9MBOkEHp2seJhw3y0kHU+zFz5y0mAZwyJpg150VOVYdAbGnnh5fqimdylfqv1ld4CA3B9t/tnF24drnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsOhXMFV; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsOhXMFV"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so2740229a34.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 23:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784097652; x=1784702452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnUjOU2zNsXgWD5I54XqK3e2II0iMbHQ5Y9pLOU3ZO8=;
        b=LsOhXMFVdcj0q6HIEOH4Xxgo54353y8h1e9Y3cSlXn09sHsuMke1bdwVdE4gxJlSFt
         0kPsoyQ3d5PjRttPOl+Gvhf/udB0A6cdKzoKsIBLW7VOJlVqfhWOQj0ejGcSTIpc6G84
         HH6YY3twBfQDtomoBZHYzRIkdu02ADlpdOnkgswpmA+33gNvRukneNE6fqT4DK7ytdkY
         2HXs98ZWsXBdcj8QnHC48jwz7Dz1aydK4lc2We+QHOcF8wFFixAdSWQORcpK0VsgL01+
         BNKdA0DC2Ej7hOf6sRoKu0S0VcJenANzAAs5KS8VFzwB2lLqFtKVWAYpbor8WBuXQxvD
         UYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097652; x=1784702452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RnUjOU2zNsXgWD5I54XqK3e2II0iMbHQ5Y9pLOU3ZO8=;
        b=ENQrp6GJ47KaqdShy0ZCJxvpAHrMTe9lE/CKicvAL7Lu9cfgCzt4XUoNyJBb6T4VYZ
         moR7iLa2Jsw/M1dYfQbJ8yGg8SiEXEDTNiWwDobJ3NvVyIUzg6d2S/hKwdsabsluTuv2
         n4aAmIqUpkxfWy95DIQvNV1eqEm4PtTnbfjH9si4XnJ+M1I7t/5fzVEwoWL+gUmwOCPn
         cOyReZyZfgtlshFF3lVsXFvXW+J79qiiL74RTIcj0sK8mEXaVuhfhid1gv5CXRnx3ZIf
         6Y7eVILDBTHMCiyVpNBWVlCw5+HgpVdA+asxdhY/1x3q231BzD9Mt/0ntduFbltBIFnu
         K8tw==
X-Gm-Message-State: AOJu0YwbPUzrZMJ7iCQgn1N6UBXfMGJ1WWXsAmYMTHB3sLwWKRQdm6XC
	xWEgnPQuKxsi24FnCVZzIymwg9rPhJ/D011rGlSaNLT284jC+IWB5x4t6Ieisw==
X-Gm-Gg: AfdE7ckerKWvqi0CEMVJFmEq5rJRJAqIX+akYHZW/3psYsu9f/JPPbk5/ptzrJUDKxV
	fjdOiwCMpt0Nu1U7244wr9nwSkAPH9uDopoBEh7/EeHmWXSdmlHj73TCfmBq7RbqN/IMj+bsHa6
	ubDnGMEms1Qed/vnNwZtFV3sqtegeP/bt0gUYb7nHQMmJ9x+8bLUFOXLhbGgePeqQUNdy5gl5D8
	5tpdQta/j3AAeoZ0y9vnbpnpjXGtpJ91ENK2bdGYFB+uEdoHJ3b53ZIvAmEO2FlKFV51SHxRL9Q
	c6HEgpugd8uYgoOEbBZbJgpR5e3vXBKfwdAZHUvOPoyyz+UMblyR6+F/UBt4sq5VS27s6Y8nFQg
	qfPHcvaKt1Q7YVYLW0H7ifwjvsl8bWGhOakgD3e8euEbYM5PBEaER/QPMYK1zo+gTKOnGiI9mJP
	6i5Y5rpkqNFwZW
X-Received: by 2002:a05:6830:6519:b0:7eb:6891:c372 with SMTP id 46e09a7af769-7ec4a946e1emr3086906a34.13.1784097651794;
        Tue, 14 Jul 2026 23:40:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae206e2sm16665730a34.2.2026.07.14.23.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:40:51 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/7] bpf: Remove dynptr check in check_stack_range_initialized()
Date: Tue, 14 Jul 2026 23:40:41 -0700
Message-ID: <20260715064047.1793790-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715064047.1793790-1-ameryhung@gmail.com>
References: <20260715064047.1793790-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a MEM_UNINIT ("raw mode") helper argument,
check_stack_range_initialized() open-coded a scan that rejected any
STACK_DYNPTR slot in the range with "potential write to dynptr". This
duplicated, and was stricter than, the handling that runs when the
buffer is actually marked initialized. check_helper_call() later replays
the write byte by byte via check_mem_access(), which goes through
destroy_if_dynptr_stack_slot(), which rejects overwritting a referenced
dynptr. Therefore drop the redundant scan and rely on check_mem_access().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 25 -------------------
 .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +--
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03e2202cca13..7dd961ede88d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6733,31 +6733,6 @@ static int check_stack_range_initialized(
 	}
 
 	if (meta && meta->raw_mode) {
-		/* Ensure we won't be overwriting dynptrs when simulating byte
-		 * by byte access in check_helper_call using meta.access_size.
-		 * This would be a problem if we have a helper in the future
-		 * which takes:
-		 *
-		 *	helper(uninit_mem, len, dynptr)
-		 *
-		 * Now, uninint_mem may overlap with dynptr pointer. Hence, it
-		 * may end up writing to dynptr itself when touching memory from
-		 * arg 1. This can be relaxed on a case by case basis for known
-		 * safe cases, but reject due to the possibilitiy of aliasing by
-		 * default.
-		 */
-		for (i = min_off; i < max_off + access_size; i++) {
-			int stack_off = -i - 1;
-
-			spi = bpf_get_spi(i);
-			/* raw_mode may write past allocated_stack */
-			if (state->allocated_stack <= stack_off)
-				continue;
-			if (state->stack[spi].slot_type[stack_off % BPF_REG_SIZE] == STACK_DYNPTR) {
-				verbose(env, "potential write to dynptr at off=%d disallowed\n", i);
-				return -EACCES;
-			}
-		}
 		meta->access_size = access_size;
 		meta->regno = reg_from_argno(argno);
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 344fb2aa0813..94489ac64da8 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1112,7 +1112,7 @@ int dynptr_overwrite_ref(void *ctx)
 
 /* Reject writes to dynptr slot from bpf_dynptr_read */
 SEC("?raw_tp")
-__failure __msg("potential write to dynptr at off=-16")
+__failure __msg("cannot overwrite referenced dynptr")
 int dynptr_read_into_slot(void *ctx)
 {
 	union {
@@ -1558,7 +1558,7 @@ int BPF_PROG(skb_invalid_ctx_fexit, void *skb)
 
 /* Reject writes to dynptr slot for uninit arg */
 SEC("?raw_tp")
-__failure __msg("potential write to dynptr at off=-16")
+__failure __msg("cannot overwrite referenced dynptr")
 int uninit_write_into_slot(void *ctx)
 {
 	struct {
-- 
2.52.0

