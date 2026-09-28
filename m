Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C63C5540
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621629; cv=none; b=RFMuw0nVLryc8zzkuvI2bcrRZ3cmS8WDUtYPtVKRUkLb7oYoRQwIyfOn+Sfu9PTP0JoO/vXZ3biM7RthOSZLeB20flTdqbcq4jpCRx2qG2ZSiwjvdbz3VPmwPgBJ0yfy4NgGEdMrmm7L6PtduE7GEw08vy7tXPQIdYxEB5Pv9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621629; c=relaxed/simple;
	bh=Q/DdDsaBCqjL3vFWtidI/0si/tfecfClP2I5FMFiNg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzsDtvY/pBtflumvFnbrU8SNZKcG9LO/U7sqc78Blg373xVe/d3eGAN3KHDgCT6NY729h3WeW0Edep9M7oIHsa5lwph/I0JhNuixOsz2Pw9AO7c+NsPjlA6S3ixtzBtNOOr/t1GebgeV8eRX0RWhrUuxPln1z+hsK/wmvt1/mUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3hx0vDM; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3hx0vDM"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d817a94745so1099294eaf.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621622; x=1791226422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAA1oxC/Si35rANIMUxwNhN/QhOhmOfMHuPUbyhEi0w=;
        b=m3hx0vDMn72xhlObdkImK91ZUdB10fYS5zsId5leCqaTLt1i5/UOrGIcibgDqMu3iu
         L376BbyKTfZlWHpy8SClqMuhaE2qtmgmYZiOVm68/e/i0JSbakRsCOIAlQQ6pxaInMEt
         0TWQEaYfppoTqT/A/wVvZeHc5Qclsm011qk2t7fLthCJ6NQWJb9JQBLffIoV6RWXnkwJ
         n7YGoNHNilvySF7uWWjZhoO4V/0hNBm9lvrr24ZAEBkmnGY604pKBSszalM2n9yblbcF
         cnytm3XVFukiX8oDbxhX7ZRxbpJlFbv2QfV2wac+WnqpHRtZdajXsW3I77/IthYKz58P
         yX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621622; x=1791226422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAA1oxC/Si35rANIMUxwNhN/QhOhmOfMHuPUbyhEi0w=;
        b=nlfRAhdXvS5++FVVrnX4yL+bfqGxxR0BQ3dWDK16THnz9tnEWgKcVA3vEPWxbSGGpY
         tsxBFaGsmMCQXLUfz2qzKAE1HyIU0kFHbAv9jGpqApVJTlzqpoqqq+PRV418+uya71k/
         wpbnjIOcLdMDNc8E5jxiihFkTLg+NEtHkrX7L9NgL/V+c59VPzV5kVPC6Phv6ervPnWJ
         8OQ0IuzGptgqTV+3bOIacxtrqx3bwiqYEzJQJPMJ7MbJ/bhIxqGCa3/VYvAu007jYTnO
         3E1e83fGFT3K5jUKCCdFoXw0Ei98TVwdf0ba7XT7L7bYPYFBSd45k57qF58K1dHQw7Jn
         4KYQ==
X-Gm-Message-State: AFuF++kXbIcJtdE2E4nkS6ICRYWxmozmcH24zzcHIV11JPu6AqDOMbQJ
	QtZoFn9/SsV0OKj45QmzwYiCdi+IW+dt+dLSbltDarQqNrerW3HHyUfYdTUfGQ==
X-Gm-Gg: AYBFou0XtbNHCMMjtV4mH1y1F/opE/hoROmPCBlsA2/2MmVaIwztjhtBd7Z1bd30xln
	XEAiULEzoxww18PeRPEzDlAh5kcZ4/VrXmZsQ2szU5i4yvEiOs48skuslqTSt8rkzwfGDClUjeW
	yueOlUSN43qIL4XNLYhc+J4JS9Q2xAqtuSU6uhkegd+1ExDUT2JLEaCJ2wJVP/IUtJ6FBnv7BWx
	u0m04wBZVyjYYl7PV03H56wvzN8fMwP4htbJUDTb/kLjf41nOvEhPRTsDZSeMYOziXMXK7/oudZ
	YF58WLaGN7JjsiIrqdBo61al+SzHfGyujW0lH50gdkuAC2XhqFBm1K2mkOo7l/GFzHoyoPc9oXb
	amHTw9m0+nclSTwfoevNnLH4FIdsJcudhGFa0yiUSZQOvQidN0Wp5DgwwNJQGJp9VW+9URW+aRJ
	tf9O3DBduYXwcmp74MLMgKp+uVflMWTFEtprgrPGpE8EKMrlL3bdfnFBtTN71AtA==
X-Received: by 2002:a05:6820:80c5:b0:6c8:d1cc:38a9 with SMTP id 006d021491bc7-6d43e22b5a9mr13584706eaf.8.1790621622164;
        Mon, 28 Sep 2026 11:53:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d882dc49dbsm6011351eaf.9.2026.09.28.11.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:53:41 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 04/11] bpf: Check subprog scalar arguments in the common path
Date: Mon, 28 Sep 2026 11:53:27 -0700
Message-ID: <20260928185334.1004200-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928185334.1004200-1-ameryhung@gmail.com>
References: <20260928185334.1004200-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF subprogram scalar arguments are checked separately even though the
common argument checker enforces the same SCALAR_VALUE requirement.
Start the migration by routing the scalar branch through check_func_arg()
and update the verifier-log expectation.

Use the BTF parameter index for metadata and the ABI slot index for
register lookup. Route extra slots of by-value aggregates through
check_arg_extra_slot() so every occupied slot follows the common path.

Following patches can extend this guarded common-check branch as each
remaining BPF-subprogram-specific implementation is removed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 19 ++++++-------------
 .../selftests/bpf/progs/aggregate_arg_func.c  |  2 +-
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e677e5615fee..e3c7c1aa0573 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10872,10 +10872,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		nslots = btf_arg_slots(t);
 
 		if (arg_type == ARG_SCALAR) {
-			if (reg->type != SCALAR_VALUE) {
-				bpf_log(log, "%s is not a scalar\n", reg_arg_name(env, argno));
-				return -EINVAL;
-			}
+			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
+			if (ret)
+				return ret;
 		} else if (arg_type & PTR_UNTRUSTED) {
 			/*
 			 * Anything is allowed for untrusted arguments, as these are
@@ -10965,15 +10964,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		}
 
 		for (k = 1; k < nslots; k++) {
-			argno_t extra_argno = argno_from_arg(slot + k + 1);
-			struct bpf_reg_state *extra_reg;
-
-			extra_reg = get_func_arg_reg(caller, regs, slot + k);
-			if (extra_reg->type != SCALAR_VALUE) {
-				bpf_log(log, "%s is not a scalar\n",
-					reg_arg_name(env, extra_argno));
-				return -EINVAL;
-			}
+			ret = check_arg_extra_slot(env, caller, slot + k, &meta);
+			if (ret)
+				return ret;
 		}
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_func.c b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
index d0a4f84a6fbf..2132b926a8f0 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
@@ -43,7 +43,7 @@ __naked int aggregate_arg_pair_asm(void)
 }
 
 SEC("tc")
-__failure __msg("R2 is not a scalar")
+__failure __msg("R2 type=fp expected=scalar")
 __naked int aggregate_arg_pair_ptr_fail(void)
 {
 	asm volatile (
-- 
2.52.0

