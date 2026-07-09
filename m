Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702F2D877B
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638169; cv=none; b=s/qa8/fp4eUNo6jnhiuQaRiA0bTg2ni71W3gQgexLm4tmRtME0w5ihlAVT3O7ylEBYbfhduNLyCeGPhcdOOXa/8ekosNHIUH+mW9QClbe9bWuQ4nLuNQEkTBhtVNArYabiKBkK5UZSyPDjxSTf9jItPDAkRuuAtNGIBy6hqZf/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638169; c=relaxed/simple;
	bh=FrhD4/YV4DGu+RWFem9Uu8+EJM9mrKhpEScSlXe6k6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSAXyK1k6ncjHH3fikK7a7IQK3g9oViU6ipHpQNHAj3BmR06cSYDLOcLQF8oz33J1zqYGcz8Ij45a+jT/oGp3BU0tc24vwJmyXaBRktWs4o7fdizPmV9jS6a6TgnvU8UftkryQPof8LnopZkulUDqb8jhosxPCBxV7vjTMVVsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mln85YrP; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mln85YrP"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-448cf99c133so1256007fac.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783638166; x=1784242966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgSD3EUqB3AmxANNmrjpirCAN3EIHnQPfDuWGTGqsnw=;
        b=Mln85YrP9EklcMnEEzpdzIyR5jKUreRQMvLVPAwoQ6nRciMIJ4k+bb4WuMObGHp5O0
         7P9Pv4+CkrrPT4umX1qTZKevW1gGJ1SeWdHCp+DuF6Qv6BjEl0vYDSZH2rumLshmPBUo
         yzB4U/4wPduP/eSd3mGTQ+HnKdwFDHUTMxGuwcMZm4nDxcsTLf10w81LfNhHuv99oSIl
         3R4h36rDsWgnxAFWD2DzPEQzpkjWwx6eDNHFaZhy0EyL7yglVlXyGtGFYhSpFJzUX/HD
         px4JOypPjGleLm7wK1gqbOzw7ZhW6LGCaIoR6qA0sOpShpYERSXP6Wl6Ss1c3FTKpRBc
         Nyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783638166; x=1784242966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rgSD3EUqB3AmxANNmrjpirCAN3EIHnQPfDuWGTGqsnw=;
        b=qYjibTvS8KxAurIPCVmENxhxJiy4fASaKkQtfZWV8/YBgkvqcnMwNXPia6gYtE5MFC
         NOl75wPUSTkR34yCz/l68hQ0MWRPZP11Vjx5H8QsCfdZuUDWWxDjAWl1uA1N39pdzvN6
         LAlBLd148qURfYDfNrPbCyFjcBUcyCW4wKqDBXfRf49lBCTg80iVyA+rbsCDBfgFXbcQ
         efzWanRuJR5WTh7AABz0ZZo4HqB1Kg2u8pt/z95M/K+pRoJkrHGI3o03xm6XQ9b45YHH
         X0pcwFw2SxLGpC3nMW+TTo+CDt1AiPiFKuJPNRts9H7zg3KaNZv8enmwF5+CvY3sKBc8
         jOjw==
X-Gm-Message-State: AOJu0YxCo/BXAjB4p6eOBSp1SwrV4McFZioNH8Qu4XhP/52g5wcdd9OE
	39EhjuQVhZnnxBP5g/mbssZvaE1HHSvoX/k3n3EmhcsylK5PSP1xOpmz2XKg3g==
X-Gm-Gg: AfdE7cnVeAiDr2XVqWk4/Ktmdpge46aHwW0WPm1DVs3LNERr4rNCH1topkJsdRVDNqH
	UD703lOZyimDZSp8mtuE8vori9xttavShOprgRwPgbtexn8CmEXRFr4Zu/jgdBsel5nDxevGIVO
	e/9EAYT/ha9pRa990hJ8NNBzJ6qEc1TmpB7UIqLw4sgkY/X5OgTygD6w4VDBpR5AD2CLYAs1BB/
	VE9iwmBBlqSjcp/TeZQcmXiMH1HUlDgX74w8R5+1Z2d1IQWWg9tvFLFP+7GLcNhsUi93cDvCa3n
	kOFaaHaMX81XprUvZJb1noFd5YVAzFCm9pND53Qiv094HGSAd02B8AbbUIyxgeC7/1TJ6BXyME1
	cdG2sTZnJifssfAjUlZ2AslAYO4pvwTAm3L5UcubHrPdIuznA9Cjkgs40KyC1GW8fCfYDPipprl
	MeI4FBmPjlTA==
X-Received: by 2002:a05:6808:1381:b0:497:db25:8a2a with SMTP id 5614622812f47-4a40f57d52emr628245b6e.13.1783638166321;
        Thu, 09 Jul 2026 16:02:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1b01f1722sm4998473b6e.16.2026.07.09.16.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 16:02:46 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/4] bpf: Remove dynptr check in check_stack_range_initialized()
Date: Thu,  9 Jul 2026 16:02:38 -0700
Message-ID: <20260709230242.2003459-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260709230242.2003459-1-ameryhung@gmail.com>
References: <20260709230242.2003459-1-ameryhung@gmail.com>
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

