Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498839;
	b=F/8sxdJUPZ+GGu/YvHU1bu2ZWbZMeaNO67w8Vqbj+4FPpBCuBs6JpCbbxe6KM2zIqSRC
	 AwiqYFROTJoPhAyvKRvi1H85AuFhOcrjHV8iQzDPt7y4kXRJoY8GCoLOKRc2s0pxeNfGP
	 qRmR/Hyb0iZk9q/fTq4V0qfw2nGA7gBFAUS6u0Sc5kINxg73VTtCuIOqKur9qTgsfPyex
	 MlqM3myMtG59iIk6CdlkohY8eaI6UTWCTTm4FbH7Q4b1L/Lc5KDKky2bJkwt94KiPMpNk
	 +Xc7xn2w+XDhvNdYnnMaKy1uhI5BZ5z42Y8cFwUx2StjencdKStqPicMy/0pDZk4lqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1ZqqznTTrwvGBYn5ZPIQ7kVW197WFmFHWFW6mt1F/b4=;
	b=4BKwYZsIyO7HRgktEyiHYshhOOcPOnjm3YsonKWoQSDLJcUMJl2uNpSbi9SQBtDJHkA0
	 +vWWu+QI8jU1RWOErazVES4P0zDw+lGYMXDpz0IOG3yk/AkoAxSARZvbDtylw07ywsWp7
	 1+6bEoSqTGkuEfFCrO/piy+T1gVO2h7Sd8pZeYh4tW2UTYNKr5yZeARcmxXiH7Y69GR4u
	 q7Z4akBQsayFgHTk/Q/HYGOUsTvuxNdir87o0Z3tb2uJ3TPGUGwyiGOm+gAsCvpBFxSUL
	 OX9g/MeAnsXM1uk3eGWHDNPRDddEfT5UQbynWqK8Jdkgry9ycXHA4X8NyVdKtZ8qRwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDmtAPZi;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B859606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B859606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDmtAPZi
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso2841103a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498838; x=1795103638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ZqqznTTrwvGBYn5ZPIQ7kVW197WFmFHWFW6mt1F/b4=;
        b=TDmtAPZiEcIqghh93y7wDB0FnzAA9LXrjvUJaYoBBT+dZ8ik5fqcrA4g+QIqcpc/Pr
         gXtHstHjkUn/S5SoZZP4tXcyDzy2uLNXJZKkeOiNTt+QWThcFtSv3ittwt4Pq2gRbAXr
         sW3W6tGXS4RHSHzIbzJYAZaYEDjrvrF5VRPHvKxWQlqiLJNXATbTo09Vq+AT0s78sXYh
         4ZnLYx06IxF8wRLaWmR/bS4j0ZbOvnw95q7pEPNRq8C4vLNv2oF46lgyNIgBvoglpgyI
         zPtl3RyeDE18F0WDj1cn7kblQ7iZn8uBY/f0KY3rRF4zAFl2et3eD3/UDOpR90QC+nlD
         G5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498838; x=1795103638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ZqqznTTrwvGBYn5ZPIQ7kVW197WFmFHWFW6mt1F/b4=;
        b=LAr4O39id0/V3aG+tcAjQI0myPEHIMstcBNd7pWguMsmScLYKEUgHmYNopJgqfFDWu
         2rJYX6m0yN+2oPEleKJ91LvPD9kOlTKd1Ihl8ZHaXtcgxKJB9vkq0ZXAvFPPSbKUEyLw
         eUJd0CQn0C+05dNMyXF9k0zWC8bs/aWmv5thzIcsPjsMhCL9XP4YVgxCrcat8nc0aKWo
         0V8DDwchcBQtuCCgSO4HjMB98oRab/ROsA5JDniLQka9BYKCZfartlE5+xB3R1Rb08hb
         x+TZ0yqCLbtaLaAO+MeNI6X/l5j/Z5+O/EqbdpxAjtTuJjeo5tnUP/gaL66VcNOi3JbY
         NvUA==
X-Gm-Message-State: APuU4Z9My/XygAP6DDvTZRBCc6kKpKqphONtiGOmLjuAEfmzIGI0uaDR
	6FupX398Y8u8KBhdYKEjmx9g7wafE7CzsuPpOYTXQX70oiVVBtvVHjLYF60Fow==
X-Gm-Gg: AYBFou0fhqPLphqIgZr2n64yEtBzQMWVjScD2uEG9/9rRMhyNHc7koPhjN42aSrZqdf
	viwJGsxjfx7tRY1IVd/3crHvnWgiMM7ABkO09FM26VsxUN/X4BwjzWNwjO7Pev6HK6WmCFM4n9/
	+Lhhhqe/8jGEE0QptDgBPPj7t4hMIju1ohm/WtzXVeIhE1c9d9v5q7uuoaCzkb0VQhBjQFwqCQx
	mht3LfLOGYfB3yVZ3D9jJ7wti5M9ke5kpT8djXVENliYc4MqS6IWnKzcqMyqtLM17ymxB6TNkSm
	GjlUKWriZCvxAD0VgD/4WmK8gkmh7OXwTKWZ/Zn0f1GcNLV18e7y1z8SwWu8/i0ru1zm7GYQ6jR
	PFqSUMjj1s2L3wze9KTm8z15Fn6Qm3lsghFCTiIvCI4t9zSw86QMEWioUJF5QkCWixYijlCYLc4
	JWqN7rNK3z/i56u7omaJSRWH9PCXrsWYNmKPu3xZQ/2dX1D9u30/r01Jfa026+x4+n+QPO7q6Q5
	QS9EZJVqkHExQzJyafDm3LyEhVYy5ddZkhdz8X6PadP8iIjesKgv+RV2wJWK5G3qWu7fR/fU+FW
	vAC4XreKURB/OFu1Pa7H9Q8LUrzLBkNiFKXqyGo45dCp8kCgh/9U1uRuEBziALOdz2Zv2/v1wnR
	Lw6qC3Euc0StLsPzzUTmKkoEJ/oJlIgAycOpbqf+an1RtQhI6qF8zmw6/btLnqWlu1tAiNB+GAw
	==
X-Received: by 2002:a17:90b:2f04:b0:3ae:2969:903f with SMTP id 98e67ed59e1d1-3b182ff1be6mr5923065a91.45.1794498838549;
        Thu, 12 Nov 2026 07:53:58 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67adcfsm3176644a12.8.2026.11.12.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:53:58 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 03/12] bpf: Don't leave map_ptr in the address of an arena variable
Date: Thu, 12 Nov 2026 15:53:28 +0000
Message-ID: <20261112155337.1040699-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
References: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The address of a variable in an arena is a scalar for the verifier.
check_ld_imm() used to set map_ptr first and to call
__mark_reg_unknown() then, which cleared it. Since commit 022ac0750883
("bpf: use reg->var_off instead of reg->off for pointers") the
assignment stands behind the call, and the scalar keeps a pointer to the
map.

map_ptr means nothing in a scalar. But reg_value_equal() compares the
whole union, so two equal scalars can look different. ADD, SUB, MUL and
the shifts keep the pointer, NEG and an AND that gives a constant clear
it.

Remove the assignment. Now a SCALAR_VALUE has no ids and an empty union:
verifier.c sets the type in 14 places, each time on a register that
__mark_reg_known() or bpf_mark_reg_unknown() clears, and a load from ctx
calls mark_reg_unknown(). Nothing else writes an id or a member of the
union of a scalar. The next patch relies on it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56924ce392e0..ed1ec6c2a21a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19927,7 +19927,6 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
 		if (map->map_type == BPF_MAP_TYPE_ARENA) {
 			bpf_mark_reg_unknown(dst_reg);
-			dst_reg->map_ptr = map;
 			bpf_diag_mod_end(env);
 			return 0;
 		}
-- 
2.55.0

