Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BF4CDA37
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643512; cv=none; b=BJgii2DR1Kr/qecjX5jw7VUEOOyKrQ4+hmTFrGXkaXVUJrQoWEBvN5hJVd7xbKy/dLT6pFvRIyfqcOYX4PMYG9IY+0JzYX38CNifZbBZln5QgRnjuCeRHMRdyUqelvmDmknMN3FS7EQt/ALyjFJ5ghlzyT1yp6AZunScY0sglp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643512; c=relaxed/simple;
	bh=J6DLyFJwVFLZc4nxdNn2lz7nxCbemOUYpTK/01sXfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oh0KAPg/vB9wMjGjLvbtR2ON4nIrT/8KKIjNqzo2ujVmDL5dTV56e0k6iTpyvY6JNh/FAXRzKW5FbgnFCRn5WWN9ekyc5y/18ReFOi05uPfabFeUtpHRyHGouZOZKjTxyZubFJV2o+Ypw5826Bjt9rzxb+27q3g5mid/yL0G218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pt7gKerc; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pt7gKerc"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so1555105e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643506; x=1790248306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3kpIJNizqxB2qWInAAS+MYGZhpffsKBqS99TtmYKIpY=;
        b=pt7gKercEtf/ntv/47c6UmN1SRUYYCS4qQ3Fi8nB0XHlvlNKFjDMVveyerimHKEq2H
         0OETTfrNL0/+BON39uDK8oznjXi0CiibP1fIEpmyBLjjwb38723O47ho1CAkErb4roRT
         Su6zNld2yH6hjnjEZTrFNyUTtKEgGzmqONeuJYUTscJ0/95sRBMHTDrv3RFUt/pHBlU8
         bnHGGBa0JvQIIn1OnN4LJ7Xw44MchJOuejSh+MbISHM20RMVPMJ+bMSEzm88EuQrqCMi
         06rLO/LHdqRieow9qe0YKVKrjLkTDyzNbgV17vpbALKXKMR3n89UZb0NaUZCrB8gHPuJ
         1X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643506; x=1790248306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3kpIJNizqxB2qWInAAS+MYGZhpffsKBqS99TtmYKIpY=;
        b=eCXuLNxTDGpA6HRBuTXCS6aCzUkuK4SS2wHRw+zwzTYzysdhFgn7c6AR09URW42Mo4
         GJ3fZ7rzL8OE2qVXalRVt/vq1/3WCJyKUuaQQORh8m3RE/FMhjbJ7oF3WNLZTv/ml+G6
         h02eAJX6uZtHIijxMoj/XQBlZ/evIgEFDSXbxd+cBgA4GTsQoBqWrOQ3G/7thrmbLrBV
         zEl1Qoh7vex2rOBThmxSjx5pT4rULpFY3fyHKi/FeO5SawGMLI/wrdC6QsBLttLpYeBZ
         MisPku0d55v9nUAECDmy7ae7+QPX1NvYNwPPPLxaHL7eYVOoYgQUk+c0eI/7j9h8OGf8
         KQdA==
X-Gm-Message-State: AFuF++nibpmlqHI7+bgS8reTm59FMTu8lIm5unT/oj2ccm0gOWHMeFQZ
	OWAjl0LjjPD9pVMmsr9j4W0TyGod30dt4VCbkzXkmxxaMkhUagUEdPfZZ2zPgWjD
X-Gm-Gg: AYBFou3affNFWMuKIZ+XFkoyo3uq7hSBzf/TI4LinCz+d28lz/oMwQ1grwQfB6PSLLF
	uyjNDc+10g5Y9MsMAmk7MUUnFwhwrYcGvXqHvZkJUWS6j79BPcf01DqYvm2aNmsxKoJVX+wiTmN
	A/ouXNuGWrlg6dCR42yc6CDtoKwkbaSt7Bj1wtl05mbRj5Kh3dqZc6WmVN+4SDUMI43UCvXXW1c
	XRmfcgZoYTuK8Bi0SiU3f70XbDv0DYDI0uaQe2mRCiopWMZCqhche9n6AwmYEqjXDcGDX6gT8+p
	uCZoHMFiTg9p6/2FQqpkoQB03Ppl8Y+Y+S6ntdc0G0kHugyISAvJGFkwHc0A3k+50vjWlCgYOcX
	6bspnhyv+WYjMyfPC0Fk3jKgUci97gihMxAsgpZLSeDqc0O0zANC/9say7kUS5LbRUs2kW+k2VQ
	oFyaJtjDdzlZU5wprg/HRwdZzupGAUTan+w1MOJ249mTRaQwTW/u4ldAYHpxINOm9HXHaudNzmC
	R4aMD6HSI7VlgZPX5Xn2Fp/tNcP8Fdrxzi9uuJjm1SHj8w/NLetQAFNmOxIL8kAAc371VbXS3DI
	iiL8v1Rv5zp483SYwzUGk/JE7o8wvC8huUnzzQ==
X-Received: by 2002:a05:600c:350d:b0:49c:dc14:d681 with SMTP id 5b1f17b1804b1-49eac463a22mr76046045e9.3.1789643505959;
        Thu, 17 Sep 2026 04:11:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm114066265e9.11.2026.09.17.04.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:11:45 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v6 10/10] libbpf: Reject truncated ldimm64 CO-RE relocations
Date: Thu, 17 Sep 2026 13:11:22 +0200
Message-ID: <20260917111127.3780880-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111127.3780880-1-memxor@gmail.com>
References: <20260917111127.3780880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=memxor@gmail.com; h=from:subject; bh=J6DLyFJwVFLZc4nxdNn2lz7nxCbemOUYpTK/01sXfDQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv1qRQ7hSmP/2hEfv6qrSu98YvvgpRnD7afd+ezuP9za 68tQ9mSjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExk6wyGv8LfJB239f5wmS8t 0fmdv2FjYfb1+8Ff/vrP/s64UEWKv5eRYfkRO4+rTJvKGb7MvtwbwWAze+UkjR6Onl1rvq748OV FMisA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

CO-RE relocation of an ldimm64 instruction operates on two instruction
slots. A malformed BPF ELF can end a function after the first slot and
attach a CO-RE relocation to it. libbpf allocates the instruction array
according to the function symbol size, so the shared relocation code would
then access beyond the allocation.

Reject a terminal ldimm64 in libbpf's relocation loop, where the program
length is available, before resolving or applying the relocation. Both
resolved and unresolved relocations validate the absent second slot, and
unresolved relocation poisoning would additionally write past the array.

The in-kernel caller is protected by the verifier's early instruction-stream
check before it applies CO-RE relocations.

Fixes: eacaaed784e2 ("libbpf: Implement enum value-based CO-RE relocations")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/20260914140852.03DA21F0089B@smtp.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee..bfa64ae6c94d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6206,6 +6206,13 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 				return -EINVAL;
 			insn = &prog->insns[insn_idx];
 
+			if (is_ldimm64_insn(insn) && (size_t)insn_idx + 1 >= prog->insns_cnt) {
+				pr_warn("prog '%s': relo #%d: insn #%d (LDIMM64) is truncated\n",
+					prog->name, i, insn_idx);
+				err = -EINVAL;
+				goto out;
+			}
+
 			err = record_relo_core(prog, rec, insn_idx);
 			if (err) {
 				pr_warn("prog '%s': relo #%d: failed to record relocation: %s\n",
-- 
2.53.0

