Received: from mail-oa2-f8.google.com (mail-oa2-f8.google.com [74.125.231.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316D470842
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421340; cv=none; b=dTEGTMTvt1tsHOasorGh45z8W3iXSJhwdSq9U4RpxZd4J588RzbcFykMJCxeftdyMFRccUBkkliCJYD+0ZNMJiCQjmDabw25XZ3RdMYXamnlVdpuNdZRL04/tfRto0cjMcUzdXfR1Ymi07NUXSJD6CeIdi/aq88bNSf61BBQ8Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421340; c=relaxed/simple;
	bh=r70qANGCdYuPtanpEtM8/w1F4XQDZkmusc5/gq/zjsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNYTMW1Jj+RIsr+7FiIDoTorcEcTzJPNlqwBYmYxRTWpTJ1R/7a2QqZThLLXhB3sbcDVP1F46G7NtIBNCuTA6a/wNO7CyH/vJ3rI2cYPoRqouJBrEFcU4jRbYykcyehKt1yWrvHOe2muujd6qoKgJgdowhQIlPUUm3SN4RoTVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XatjFzwC; arc=none smtp.client-ip=74.125.231.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XatjFzwC"
Received: by mail-oa2-f8.google.com with SMTP id 586e51a60fabf-48f1c6a7779so856199fac.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792421337; x=1793026137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNaQowP2U+6F3DAWkZxmhhC2HEdbs2mfZ20Mf3gAglY=;
        b=XatjFzwCMirucNP9IEpWSxlvmRPLAF0/GEEt3FQhmYxf+ITn4AbqNvLrmKxPQsGCB5
         iVD8+Y9qQ9m1U6tzdIn65WY9elxzpK9Kz6n+Rw3R4IC99Yz9xYuMGA8Z5kO9cZ+vqSPT
         ujxTlNWuqrS8WSbnbt9Eip94M+eUL86AdiEIHlxcCPuQMJKMCp0n6pypcrUDy5v4sXSx
         96fEi4Zh57jBR10Ww+YEFSJftX0ClEbIPvSPdAO8iUT3PzeeaVYJBYa83LemMChs12If
         3kbG9X/6i5Dau/BRHQzKChjRCiPJFL9s+1knmdUVrxmvI7Xkf+qPKgfLdiri47jNTlTK
         kyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421337; x=1793026137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SNaQowP2U+6F3DAWkZxmhhC2HEdbs2mfZ20Mf3gAglY=;
        b=fsW2UsgNq3UsRe7gXqQc4Wdctyoc4SQ+6ENv6dO3wD84xD7aeF4IjXTgnXXJulMp2R
         58M100P1Ex64YG7HbFlQ1Uu/Ra6cO2TyvAkPVzVN0WB3v69X6+LB4TeLPI9t+tSl8e8k
         I9yGeIQqGIlucC1KdJpVNIg4Kot+/CNqWdOquy0c++gRBZrP17Pa3EFT/R0AcHei/MH4
         92gQcQgbrZc5WI8ex44PrpX0K1Xo70JjEqMKUOHPB6VXLkWdATrZztvt7xWphXZ1q6qA
         4TlIFrPUKs0q/1BXGCz+RtrY1A7PuKm/ihBEZ9qeG8x+SEtsbuF3yo4bwHA+4tpuo6AB
         SJmQ==
X-Gm-Message-State: AFq9FYIKZBiGDaI8+yLwHFmQuVBQJGcOXzW6vbOXeUHowT37GgmLfZTs
	4nd5st2hd/gbrSz7ceskEXHvVUlZYHXs8jAW3sdC8cmagUOLvx+5ivg7fEk8LjqB1/I=
X-Gm-Gg: AYBFou1cgRwn6vbDdr+T5LdUfvTdu6x5NYIN19+wXqMSQuebTcKXFyYGTqRPumSHo5h
	rSFagkOlghRAeqW9ci23rZipiADk97NuTOAUNSNUvqJGtW7q5je3FpbsPJZqKFuqSyyMeNW0edI
	CoAPydzSkTuQ4o6/owKOgp7uPW5hkwCYuLc2ljMI7mdKxWQ6if9M2jKINMNdBwPENvhCbN+3cqx
	hFT2QQCRKpVLX+Zt7Gyihh49wEjaDttgJodUdfbt1ixoKD6eqZ4MsyOLC/qP2TSN6QxnJc9lyyF
	2etJS7U8cmoqgUNMP/hMzrYbUOiRJKfsRVHf1f1BscJ9/c4XsyZ02/C6y4fst4Sad7ACJR//wts
	LEGa6SEONvVOehJJPAYic++i6G7em7WVwjABd39LuxnWRtWRYoorIRd2V91VVI8hOtY2KSW/Ge5
	EOK82n63LoA7eNy99darHgg6RQKniJziWjtafJ3JMAnrbZM17/ercW6LO+XwOidV7vgVLHUxow9
	WGhMwD1EZbznXPSlVqSJxTJB6YrAnKOSvuYNAdaGLQpXqleWY6aDUerzfgXHFRBgsHYdFy7Lep9
	nidN
X-Received: by 2002:a05:6871:4727:b0:486:cf17:7f2 with SMTP id 586e51a60fabf-4a7575fcf9amr6511289fac.4.1792421337397;
        Mon, 19 Oct 2026 07:48:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b6e4a79sm8382190fac.13.2026.10.19.07.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:48:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Refuse CO-RE relocations for a signed program
Date: Mon, 19 Oct 2026 16:48:49 +0200
Message-ID: <20261019144851.4052056-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019144851.4052056-1-memxor@gmail.com>
References: <20261019144851.4052056-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538; h=from:subject; bh=r70qANGCdYuPtanpEtM8/w1F4XQDZkmusc5/gq/zjsM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeua7rbve1blP302lbumSnF29/8pFpY6tlZ2ypMz6hgThI8e iWDqKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERuMDMyrFFb9235IfWe67e9xT6dfL J2d3JP1IqS1HP6EkeU/334toKR4WqS2Kk5stxBAi96Xtet213Vy/MgTvYth8+65ov5RjMlGQE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The signature of a program covers its insns as submitted, along with the
frozen metadata maps of a signed loader, and bpf_prog_verify_signature()
checks it before the verifier does anything else with the program. CO-RE
relocations are the one input besides the insns that changes them: the
loader hands them in with the program, and bpf_check_core_relo() applies
them after the signature check, rewriting the immediate or the offset of
every insn a record names with a value the loader chooses, a field
offset, a type size or id or an enum value of the kernel BTF, or a type
id of the BTF the loader supplies itself. Whoever holds a signed program
can so change its constants once the signature has passed, the offsets a
signed loader reads its metadata map with for instance, and run a
program the signer never saw. The exclusive metadata map of a signed
loader does not make up for it: the hash that binds the map to a program
is chosen by whoever creates the map, so it can name the relocated
program as well.

Refuse a signed load that carries relocations, before the signature is
examined, like the other checks on the shape of a signed load. A signed
loader has none to lose: the programs it embeds are relocated by the
loader itself through bpf_core_apply(), and nothing relocates the loader.
The BTF of the program itself can stay: without relocations it steers
only the verification, through func_info, line_info and the annotations
of global function arguments, and rewrites nothing.

Fixes: 349271568303 ("bpf: Implement signature verification for BPF programs")
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d13868846823..24ff4102dd54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23401,6 +23401,15 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
 	u64 data_sz;
 	int err = 0;
 
+	/*
+	 * The signature covers the insns as submitted. CO-RE relocations would
+	 * have the kernel rewrite them afterwards, with values the loader picks
+	 * through the BTF it supplies, see bpf_check_core_relo().
+	 */
+	if (attr->core_relo_cnt) {
+		verbose(env, "signed program cannot carry CO-RE relocations\n");
+		return -EACCES;
+	}
 	if (!attr->signature_size ||
 	    attr->signature_size > BPF_PROG_MAX_SIGNATURE_SIZE)
 		return -EINVAL;
-- 
2.53.0-Meta

