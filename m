Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712DC3C81B3
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606383; cv=none; b=iFGvYXHTmR0QwB50wD9mSnjuTZb5IV3XgBZSqeeU2ER5yhs2Agkoipw9byMhbqz1PqJCx8Y/ui/GJQEuDUE4vop9Iuoz40dEUvGiOGBlGGlVyR0ZeSe7s3oZO55s7aXwo+1aCoeOzicIvixN8lA7CTkaYYdekHvrNkVLM4tb770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606383; c=relaxed/simple;
	bh=NgPRoZ8IXWwYkLAa/nHsfmIJ4SXsr+02c2nkNpoPXik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1T+7WAN/MTNv5FWwVmSctJKHIqSz7ytu1w3vJvum6oZFamsWc6pPdeeGay0591CwUchePnoi+5Oeii9c5tlKCxRpGRd7guCCB5Ow9/FybhllYAEHMWqmOGCWUIU34X2m1jdr0wSR8r8oKAFkV0sfoxjgUbhgWaRSUjZhtygl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzOuJuko; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzOuJuko"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso53311685e9.2
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778606381; x=1779211181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSYJlBauomFh9oqoN25nD7dcuF49GuDhVg/e/vdGzNw=;
        b=CzOuJuko763kh16bY3MF15VTFvk1KxLNmKpxEfYNyhWxNAKTHL6x8OLjx5LGRIkGaP
         8S5+y8PYVQMD5YFWsx+4MkKGOHDjkCwmS616EB9qLRm+SxGigkd0Gx3lePNm0WeDiTDd
         w7lUj91QS1qVPpiP6lPzBrZdC2o9FD+Z15/AtmHVqRToVoLAvIQWf6/Yr/XTQK6R+KKH
         BnyPbsNyqZygQEFScGzOTtgXbWeJ8zEfCvr9l9OmU91iZkFXJsRob6H4imwMf/aIwviK
         hv4YvqVFp6Zfi6kJ9qyr8hROzJ+1z6o4CAwtjLZO+C7aygqk/YHOWPUSAnYjSc/uchj8
         7COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606381; x=1779211181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSYJlBauomFh9oqoN25nD7dcuF49GuDhVg/e/vdGzNw=;
        b=FwHVKAo4VNK3vfUPDFZbLQKfQri3QoTsMze/Yxhy3K0iJ+b5W3QcX/w1lMP2NLVP1H
         z6ozmyBspRvqXF9N4ZkaAn57A85zK2W4Y2ni6U01nmprW1IEyvmh1gPJinDsqSJgw4zb
         TouzYYUsrHdkMWt5Lrt6brLCt1FzHVoSmjb+FhVOVMhhIv19LJ2kuJXJnSuiRdVe1pah
         EHiXJ7pBIncbv2QLaXOhmHKjd32WIZphZFF176O1qE6t9hWIjk7Q3Ca9z7zBg0DzcQuV
         pBfS92QHHlZBPxgrlEvicN7OqkJaInApuTXMcHTONkFDCIA3TnTTdvGoNYSk9TMeQq9H
         Aj/A==
X-Gm-Message-State: AOJu0YwTEgsxkfjXNmf7hCiVPOiUURHVkZotyY5ci0JosZSzquUzclkm
	OrpgJmY63QE/hn4VcG5Yxobz9mjhFto19LR5ZLN8pcz/4O0VR51IrKcwOUmpxMmw
X-Gm-Gg: Acq92OH7lYwkgCzqBHJco7I8b6RKvZ9KQdjRjPaNlvehaVH/dSu0D1IF815ZkQkvBOZ
	WazvI34C0TbNPlyPqMf/MuIp6rgkcNYOz8EB+Cpkih/G5ffSm9fZ6sKGcaoEbEdQx7JE1P8aVm7
	kII2NhKeMcAv512jCdQ/DzeZg5rlAybKDFbGB6DtpUjwdv266QBR9ak7qPVV+owVnHckTJVM+y3
	qbnYkIwvFCZOUQ4ZeJ0WVfgAuO0eP1ruVIeyKo3uVi8kWe4SL8MoPQ/iCl5dnKU9rsAN7jwbemr
	YIjzI81HPDA1h4GqIZe5Je1wY/feLVrTE+W71nde3Wss8L16FaFxkfl5op5ojDsrkFJpG3knX12
	aURm0gzWEva4Kz5VTKw1boN76ad2cOItjqACVGscIVdvVzw7PXG4J4I5GonrVVoc1x8pNkTCcww
	i1a/4G5sywfMizOZFSxzb/C7Oe31Me3Cofhwraw7NphMBJzs72CT36pNI3wROLzoA3yZPTBIPFF
	YeICM2Vr9mmloUk33gDfyaDX7wiJ8tsa0tt7HzMUuVu9/DNrw3j6ln5fgGSujYip2A1gqkM+R7b
	zyVCBiKMWAPaHs6Irj3i5wm/J7HlMK/tLsUSlA95Atw=
X-Received: by 2002:a05:600c:5248:b0:48a:906a:9050 with SMTP id 5b1f17b1804b1-48e7069175fmr246113795e9.10.1778606380616;
        Tue, 12 May 2026 10:19:40 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00850765ba98b5d107.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8507:65ba:98b5:d107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f542e56sm21947105e9.34.2026.05.12.10.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:19:40 -0700 (PDT)
Date: Tue, 12 May 2026 19:19:38 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test reported max stack depth
Message-ID: <7d18fcbe5d96a9e164aed1746e75eb25b0d8d8f9.1778604369.git.paul.chaignon@gmail.com>
References: <05f82d1180b68e856bb0cc03a5cd86305f5b7669.1778604369.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f82d1180b68e856bb0cc03a5cd86305f5b7669.1778604369.git.paul.chaignon@gmail.com>

This patch tests the maximum stack depth reporting in verifier logs,
with a couple special cases covered: fastcall, private stacks, and
rounding up to 16 bytes. For that last one, we need to skip the test
when JIT compilation is disabled as the rounding is then to 32 bytes.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c  | 3 +--
 tools/testing/selftests/bpf/progs/verifier_private_stack.c | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 0d9e167555b5..8d7ff38e4c06 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -799,8 +799,7 @@ __naked int bpf_loop_interaction2(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4)
-__msg("stack depth 512+0")
+__log_level(4) __msg("stack depth 512+0 max 512")
 /* just to print xlated version when debugging */
 __xlated("r0 = &(void __percpu *)(r0)")
 __success
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 646e8ef82051..4167d3a09252 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -86,6 +86,7 @@ __naked static void cumulative_stack_depth_subprog(void)
 SEC("kprobe")
 __description("Private stack, subtree > MAX_BPF_STACK")
 __success
+__log_level(4) __msg("stack depth 512+32 max 512")
 __arch_x86_64
 /* private stack fp for the main prog */
 __jited("	movabsq	$0x{{.*}}, %r9")
@@ -324,6 +325,8 @@ int private_stack_async_callback_1(void)
 SEC("fentry/bpf_fentry_test9")
 __description("Private stack, async callback, potential nesting")
 __success __retval(0)
+__load_if_JITed()
+__log_level(4) __msg("stack depth 8+0+256+0 max 272")
 __arch_x86_64
 __jited("	subq	$0x100, %rsp")
 __arch_arm64
-- 
2.43.0

