Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416738E5DC
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689704; cv=none; b=REWhYJ9uwXgS2IH8+0y64TjlAQE9DAaKNgL+ZjV5RYgu0iMOfHZn48Z6Mzg+ezIwvf5nxSa2uVuAOPA9O49xaoPVRQt0Y73J1+e6GMyXBai4asrxjIumddpsaxTln5gPmTnrhQleHKSt+70srZTlP1eUopUUehx72wfQrsVksXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689704; c=relaxed/simple;
	bh=Y9AgaNKzbi50Cdst9/QmsCQAUOboAw+fAPpCVgHQNHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fun5kUBZQ7YB/ZP5hcbQnd2upr6xYG+ldxrtLPSb3fAy5/hitCF6wqYmmpzWg35SeDeIv93Hj0QPYClFPdRsJcRMA4G8FwIX0bsGIin1cQvstoYY5ri8xqBwW68kiep8M2HEVMObJPChZLozBE2eTvsYHWxpQTMLaBrL7R3pQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfxeL6Yo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfxeL6Yo"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so75130735e9.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689702; x=1779294502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsU03lYTM/RXSXlVeN63h9XyzTBMSciFuDaNAzXFfVo=;
        b=NfxeL6YotMHjY/pICtwoYEEfvz00dW0+c9UXB9BypOPAb8KCJtcAQMeyXTKgysxWNL
         0Zu/1TMyOOvxAfCosXTYvWVyjGDLolY8v6woGLl8Cs7wRfeleiOZlWkdz0gdAdXO9GzM
         8W5HHJAFLnX+OXq9a/0AHv+IrWtnaaI+Tib0Rvm8AkIa8Y1onyAoM4f32/3HaV+7jnMn
         94LAbDpdVljlMCuD1zeM7KlBeABJS4XCxdYBUnOAI4RAsJ3HLAoDfixTFZtr6TYtyDNS
         B7/ELC1PH/LbvszJt6XKJQLZ1W/E77t9wHBPwFtYNmCN1wn2eGjrqiJ4s4QHwtzckOOc
         qq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689702; x=1779294502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsU03lYTM/RXSXlVeN63h9XyzTBMSciFuDaNAzXFfVo=;
        b=ic8pPJU7nPXSTv7k0YkyoYUAcWcWMlseu7dVV1X7Ib6U/7nOoxYCNvJK209dvQHGG0
         NNWuHhJIVOLv/BY/f3gH/a0N+3g6Jn3o0sDJC6oQgNg+QwMkHsOjuV0Qvn4mjp1kL1M/
         7PP5dyc6ZIzRxW7dHH0LWVQyu9QzvOtQ2IgF4pNYZNiPItjCfjkEGlUdwjWIUPbLjpFn
         YXyaRYHi5zzBSDQdlAqdHfbjwpl1iedBzY71PGXXJxp+X3Uj8si+b/EiITq9mVFV2bgz
         PcTmhcGWWZOZj4o81KzJfOOWF6NMWrPBuJxRXv14Axjb31AR7+unIxDHlm3K662j/Ool
         mcNg==
X-Gm-Message-State: AOJu0YyXmuyleEGyVEI7yIxancdkdSzEddR4gUdYih2Ft/fcHeplu0uk
	lA7gJ05rEaR45h2yLkh2JNRQ9fNp8ORXVfgv7mK8iO1yUicoxhzLK7EuarrBVQ==
X-Gm-Gg: Acq92OEUKhMxb1/SAxxaFXJHPAtMj59TDXGyvS1Wzne8T/gZYvZ+EhQXX4sbMGKxmsh
	YzFfoAM/sCeTwxtduoJBVHgDg/qM0rQQpT4R8R9vZaAjQ6QRvAVzTyruzIqEnBGiRfiaT1vqZ7V
	wm0RE5FmjkDy5d7JE0UcV/J1fLBISPBqt7R+mbKP+963HIQsf3qp1zOva9KUg3NpNQXIzGd89RA
	7HsfvxqxYWO8ccyCFTlweGbWZx+VPs/JatCJi06lw599INcYG4JR2QsQ1gl4ikfTl21yq3YLcpX
	YbzZPwIy+i1A9bk+b1Rgdj5z2dwrAfqJXrjpeIibtNj/RBIZ0cJV1QEBPdev8xxcrQwTkPMhJQ0
	d+ygheGuN8Exs/l0cwiPHsEzlcoSCuonPQzATIXUcam65ztIAXy1D8fEwnXXtoIMl7bfDiOn8G8
	Ifb1PqRs7HN6NyoZwjjg1RK/R3IZPh6dxxQCdJDnbfl/QkOMuJa+qfEIGYt1hJY2MY07rVcxStc
	oYwozU/dqG28O8M7p2Oe/KO8zhhb1jn61QY3pAWJriKmG8ARhO8c3JhuQwkbq707dxUbhNIhWJ+
	NX6mjCNkrwn6R3st1D8fFT/e9xC+Mn/ux2j7wgUKfDc=
X-Received: by 2002:a05:600c:3507:b0:489:1cda:bbb7 with SMTP id 5b1f17b1804b1-48fc9a4a68dmr63837995e9.25.1778689701639;
        Wed, 13 May 2026 09:28:21 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0055c0fd718e6af73d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:55c0:fd71:8e6a:f73d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd62dac74sm1116315e9.20.2026.05.13.09.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:28:21 -0700 (PDT)
Date: Wed, 13 May 2026 18:28:19 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 1/3] bpf: Report maximum combined stack depth
Message-ID: <d3d23a0410f87f116f3bbaa98a815dbae113bda2.1778689025.git.paul.chaignon@gmail.com>
References: <cover.1778689025.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778689025.git.paul.chaignon@gmail.com>

We've hit the 512 bytes limit on stack depth a few times in Cilium
recently. As a result, we started reporting in CI our current maximum
stack depth across all configurations for each BPF program.

Unfortunately, that is not trivial to compute in userspace. The
verifier reports the stack depths of individual subprogs at the end of
the logs. However the maximum combined stack depth also depends on the
callgraph of those subprogs (the max combined stack depth is the height
of the callgraph weighted by per-subprog stack depths). We can compute
a callgraph in userspace from the loaded instructions, but it often
doesn't match the verifier's own callgraph because of dead code
elimination. Our current approach relies on dumping the BPF_LOG_LEVEL2
logs, but this feels overkill considering the verifier already has the
information we need.

The patch lets the verifier dump the maximum combined stack depth in
the logs, on the same line as the per-subprog stack depths:

    stack depth 16+256 max 272

The per-subprog stack depths and the new max stack depth are not
directly comparable. The former is sometimes updated during fixups,
while the latter is not. As a result, even with a single subprog, we
may end up with two slightly different values. The aim of the new max
value is to be closest to what is actually enforced by the verifier.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/linux/bpf_verifier.h | 2 ++
 kernel/bpf/verifier.c        | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c15a4c26a43b..b051671c7239 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -952,6 +952,8 @@ struct bpf_verifier_env {
 	u32 prev_insn_processed, insn_processed;
 	/* number of jmps, calls, exits analyzed so far */
 	u32 prev_jmps_processed, jmps_processed;
+	/* maximum combined stack depth */
+	u32 max_stack_depth;
 	/* total verification time */
 	u64 verification_time;
 	/* maximum number of verifier states kept in 'branching' instructions */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0e654ef01ae0..ae92223d1106 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5038,6 +5038,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	}
 
 	if (subprog[idx].priv_stack_mode == PRIV_STACK_ADAPTIVE) {
+		if (subprog_depth > env->max_stack_depth)
+			env->max_stack_depth = subprog_depth;
 		if (subprog_depth > MAX_BPF_STACK) {
 			verbose(env, "stack size of subprog %d is %d. Too large\n",
 				idx, subprog_depth);
@@ -5045,6 +5047,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		}
 	} else {
 		depth += subprog_depth;
+		if (depth > env->max_stack_depth)
+			env->max_stack_depth = depth;
 		if (depth > MAX_BPF_STACK) {
 			total = 0;
 			for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller)
@@ -18289,7 +18293,7 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
 		for (i = 1; i < subprog_cnt; i++)
 			verbose(env, "+%d", env->subprog_info[i].stack_depth);
-		verbose(env, "\n");
+		verbose(env, " max %d\n", env->max_stack_depth);
 		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
 		for (i = 1; i < subprog_cnt; i++)
 			if (bpf_subprog_is_global(env, i))
-- 
2.43.0

