Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C990337688
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402427; cv=none; b=T3/Qcb+/eCvWdz/F+PrCEwxS0EC7ZtTKumFMWan4613jpNqeeqnmaa2ARxM4LMyxap58/LX+wv4omYlodTCzt04bBgwOLmSG0Rt8HH3Zk4Z+YcRooBsgJd3iw6Cfy8fWmJYmS7Ooj2L/zfBAMYrqHHv5zRl2rvqJSZvgqJ/sMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402427; c=relaxed/simple;
	bh=WOE7wLbbvRU8FgaBC5rUeJf8gIH9muDGxcDHJSJJdIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F990fO68AkWv6Q+FJsZdFE3fsC4m2LufM1KVYf+6CVaBjMLwbxUhzk7bqWZeR7apV+NAXmurQOT1xj/O8iOlB8hQBhdF6MOOHA9ynFokwsSkYRDC4hBXf8CNueNb0HtbDm33DmjHAkBbYXcKF0XnblUockXUdqhbobR5qjcEchE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOfNF7ZL; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOfNF7ZL"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so5179555a12.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789402424; x=1790007224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HUA9GTKlfEJ9Kcts+kjmYdq566/PhPCngZ+RfrbQ/JI=;
        b=gOfNF7ZL2PWuE18WXaJev+IRgM0rSHg8exHga/KnRxzDD1BSR2sAOQo5mWADoUFK2j
         9CMlWQq4CSATa4snrF2snkG2zcNPifs3h2rQZ0KxAyIoIWojRJWq4ARqK+/s712OIp2E
         DkZozL54FTEn90oOz3JmoIXxkhG5YJNpgxZbYvTNrebDf9Fxg9m5CcZyplCBjPrwI6NE
         8/EAEj4vtvBj+OJiVlC+GInU+nTj0ImMQMqfS9HcNot0EequElY4e9vJy7kn00jG53PS
         3WuNXgiIfFm1xWZuacVLOMNyf+jrE4QiXgsepwPL0JX3W1OmNI4ws/TOFM/v18OAug/S
         KYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789402424; x=1790007224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HUA9GTKlfEJ9Kcts+kjmYdq566/PhPCngZ+RfrbQ/JI=;
        b=Bw9GBF4WHbjSHYXJZlS+RHoxjRkWWhu3woSWJJQ3VRA6okKBOqqmzK1aZpH1B0sL5y
         yhMjVIc+CbvUH2PPaFTyRd6YCrMlR5j+tY8EGr0jV0zjhZLFb+40Bw7L1Akrz+3ezlyo
         IINAvDBuMuoujytd8Q9OMwDwNk6rdU74f5+4XdviulH4uZ1NBkGd2f5v7ruA1J5IHvIC
         jNQ2UjlpIhCNWWAfmQXQhDjh7I8wbwRtyEV64g2bGwLug+6xwy/0WN4BxKYON1gQ2Pv7
         9ZXoDCbfMomKz2LFijPzPXEoMQHAXMoENk0XgGzWpj8j3bszfiNQ535BUIp4BAWnjSa+
         9+gA==
X-Gm-Message-State: AFuF++nreaxRJIq7s1gasuMU774OZyg01qh3/TPqvuzEX68P0wMRYfEd
	2Pb9ljfN8qlOLPDwe4Hch0vmH3zdZO3Xip4tbHlfUWO50byuGaasyUEmDi/d/V4u
X-Gm-Gg: AYBFou1gOlTyvCMoeUCfw9rfdO7PbRG10G61Sjvc82bHcPAE6GIHvb9mlWzOCg1z/Du
	Z6BAzWR6ntGVcCt72030CzURnlmPKbJFKi63d8Nlf5raK5UunPbBGPyCx6EqA00F32nsSIVMovX
	JGyKR9dJ37j3+28pnRr0I8B/HurJL1V8hD8u/MnblUyISvYv3T91R9extB7y0mtjVQDrA0sJWSH
	09H3+ViERareMLQT/QQq5t6azjnPqB3Uh1D4thd7uNDX1M2x6MeJn2Sf8AjHlQOKXrPUiKj8qg5
	APesCM7xpRaUsjFb1FY12mJPaJUAd4la7FswPkHwsD4CO6nvLnQWMcGYoe97EbVYKxONKiEEvJU
	nlNdNJKbc92USjBpRdO8Ik9g/93BFfaoPd1V43+VM3yGotf5V91hX0eT1+bSYUZx626KBK2YzNs
	jRTj9Q7WxOe4H2QkLnI17uOozUie3lZg1ikwVZ2B4fCsMES/lEybUcXaWVnfNrHtWeBmPVgJiGa
	oA6XDmgRHDGnpdRBsRY2X4sg2+ajPA5INl5kxIdYvpJ5Z8hXKKo8fgbZcyO4gR6nNuGXPspCCX1
	XVa6+gvS1SE9ZI+27NVJ3E/eHQ6GEUiI8RL6mg==
X-Received: by 2002:a17:906:9c82:b0:c25:5a26:3787 with SMTP id a640c23a62f3a-c29c89688b5mr10308166b.8.1789402423528;
        Mon, 14 Sep 2026 09:13:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b5935eb5sm4779211a12.20.2026.09.14.09.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:13:43 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/2] bpf: Compare stack frames in regs_exact()
Date: Mon, 14 Sep 2026 18:13:37 +0200
Message-ID: <20260914161340.3419141-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914161340.3419141-1-memxor@gmail.com>
References: <20260914161340.3419141-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2763; i=memxor@gmail.com; h=from:subject; bh=WOE7wLbbvRU8FgaBC5rUeJf8gIH9muDGxcDHJSJJdIs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuFyL9AmbwEs0dLny5MiFr796TIyQIFUdO4LAmlZxvzV s7wPnO/o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABMRvcrwz7B+ks2as7n6j9Qm /3J44GjAId03z49/Xwu/wB+Br4xh6xn+ymyc/P+xcEWLVd93njl25Vue+yusrhNbM3Eyf+fBlKY L7AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

regs_exact() compares the register state up to id, followed by the ID
mappings, but does not compare frameno. The PTR_TO_STACK case in regsafe()
checks frameno separately, which is bypassed when exact comparison is
requested. Consequently, infinite-loop detection can treat pointers to
different stack frames as the same pointer and reject a finite loop.

For example, initialize fp-8 to zero in the caller and to one in the
callee, then pass the caller's fp-8 to the callee as r1:

    loop:
        r0 = *(u64 *)(r1 + 0);
        if r0 != 0 goto done;
        r1 = r10;
        r1 += -8;
        goto loop;
    done:
        exit;

The loop terminates after reading the callee's slot on its second
iteration. At the loop header, however, the only relevant difference is
r1's frameno, so exact comparison incorrectly reports an infinite loop.
The same problem occurs when the pointer is spilled to the stack.

Include frameno in regs_exact() so both exact and ordinary stack-pointer
comparisons enforce it. The field stays zero for other register types.

Continue to ignore precise. Precision marks control whether pruning may
ignore scalar ranges; they do not change the represented values, and exact
comparison already compares those ranges unconditionally. Marks can also
change through backtracking while an ancestor state is still being
explored.

Fixes: d5b892fd607a ("bpf: make infinite loop detection in is_state_visited() exact")
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/states.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..827038ec18b7 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -491,7 +491,8 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 {
 	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 	       check_ids(rold->id, rcur->id, idmap) &&
-	       check_ids(rold->parent_id, rcur->parent_id, idmap);
+	       check_ids(rold->parent_id, rcur->parent_id, idmap) &&
+	       rold->frameno == rcur->frameno;
 }
 
 enum exact_level {
@@ -639,10 +640,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
 	case PTR_TO_STACK:
-		/* two stack pointers are equal only if they're pointing to
-		 * the same stack frame, since fp-8 in foo != fp-8 in bar
-		 */
-		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
+		return regs_exact(rold, rcur, idmap);
 	case PTR_TO_ARENA:
 		return true;
 	case PTR_TO_INSN:
-- 
2.53.0

