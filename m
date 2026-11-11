Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374164;
	b=aDe7eisCzCQuff05gOc6TDVm2tJT9oV/XHS6bWlx5VItOYeisJAbg8qGimEBdb+qZPHb
	 95esWyxirX9vhyRQZ70ehAFQVCPB362mYe1vgMmwaJn0a2hzzxaGGin78OXZC7OSt9Qzh
	 W/2pc+ij/LwE3DCseCFmjPOOGxZFF9un6uRShOwJw0+v/677ItBeiZ/gZ6KscAnf+TXjB
	 Gm4nys4+Imid17LsJauF5QfGvBXzpescJE1AbIEvV+F68qgIyYI+JVnoe3bVOM55EbFUV
	 Mw7cVubdu8yftj7eo49RIbw9YSGpWFUgYYpOCkPxSxfRJTWjUTi7MGXcv6RVpRf4iZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zmvsoqg0UvyFkmW741QEMpZ+DDOrvdomqQq9bMxi3nA=;
	b=47GjExw22QvBKAF9EfoMLbxJDS0WwNUh4xCYapJqayfrgv1N7xRxeCV4V7O3XGFMOe/W
	 dEu/HjoCuoGIY8YDkXbLYLiRuSaIg/LhGzeUyzbSv8OWFmAUBT3sxepw3/6JUBrBREb+z
	 SJkXWnsLbjAVWVV/GehzUKcIpsKOfWzB1CDyVwnxNF1UgCGLaKy4U7R/uVMgNffpBbMap
	 qmb/k/DPbVMeUCDogvA/vDUtZNvXlsi4q1Z6ftx2yfgsgh00SEOyibji4VqGc8eS0X0mg
	 oc613vu9Q3Ozkj2YBQX0lFuWxIK2hGoEMOVrlSGxQ5mfI1eR+lAYfEeFXaHifWGBJ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aUiFBU0x;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDD606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44FDD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aUiFBU0x
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so1272944b3a.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374164; x=1794978964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmvsoqg0UvyFkmW741QEMpZ+DDOrvdomqQq9bMxi3nA=;
        b=aUiFBU0xQEH9S+T1IIjncAcM9D4C6Kj+wM86y0xO9H3MW0VrV2Ho3cgzo10o6niTWM
         7L8y9axhVLCbz+toOvga/knnS5+RjqSGGBJiR00FV0ohDdi6sIljtrtgRvqUIXUFeSGB
         IPF7hd1SZ3OGRoTVSZIjufJIJ/U1WmeySjBpgMp57XP7jUDzn6LvXvMhzsA2xYjfhilB
         kZX7tfEgmDN0gV+/uxDeGfphnEihGoeLkSijbpYcgkJ6Vbe5JAmHRcKV8cEebKlFwNg0
         s9kyqms3gDP9V/Btgf/z6mIWH3QIAbHQEhgyVd/aKLrg6qssU/M6zuYfu/oiWcHqPmum
         20mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374164; x=1794978964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmvsoqg0UvyFkmW741QEMpZ+DDOrvdomqQq9bMxi3nA=;
        b=m8ZQVbmYCAMY5kh5djp8viJGlJQR/THCsSVz2dF1c9cw0gvGGwuorZTSMu8vs/5xt0
         4zwZ95iAZ3vHDoqUDuxBE9KGUfv1c+auzgQ0CacBZ1MSEEe/T+OVEFVLACX/hBH7QZhC
         Iyh9mDB5HGE1oDRFtqAqZHDGDLZd0Yi8yEJboS57w9hgTe/HCSL0ln7qxr6x9dFy8ONP
         3eEL4jeov3vYupaYJHZNzH6V+v28Bq21jjLMn5KN7xKhLXftxd57132Taw7jPDZ7fZ63
         zboHbJ+8++/ddTKKq8O+H5NVRiKKQilXxbtEmFTbIzgXSYavONR2+Dl1GKK+z4bJgCTT
         SymA==
X-Gm-Message-State: APuU4Z/luYSB1kqSgiRmpu8sSx+NMSfvJJqM9bV/bpaRyil8mGvmiqSx
	w0WXa/Ts6WPmmDCeJak87xIWuHHVMET+GKhqzWapjXm4+4lwzB31RBlOlTBYmA==
X-Gm-Gg: AYBFou1qy186lII2SjUXuKLz3G43CTlyThgwA46s764Zbv+WyD6scamBWIFFWzN79ze
	+PkuGRUKUrCOze90lbxyngre3LaLI2tBHhMvm+UV07ygQl+ofcfqagS2m4kvN9BrpL7HRa/BpPJ
	uSyqwLEXbIFNBR7uMqsrHgsACS9bxE34Gd0lztRAb4Z2ZRBeZz3jAXLZ3xshI3/EA+19cvmEUsT
	3P7TnjX4hud6VlcO9tcfqUphYLKB3moM0FdlQNbG20jrGrRSV0gfnGIOfeHLm557hA/G9/mTAVV
	+wBqA2lA8OF09PgNzrM7bBov0Nk5abIOnaqL+fau0YMN569OCiyrkHLRHGaWM/VLDIh2nQGvEZT
	VJcXB1Ai3t+DqIsVaD7kSzyJ7iltaX1dfhU/rfykv75b7VN2tYx1tVHrFtTOCXrb/C5HTJeP/q1
	Tj7t/JkpRdVNpzz+EncPqRg880GnJAVGMhRCUf/cAaDMRF2tb/A2pTe3wBr0jBSiPddSud3FTMW
	EOpRv14RqA28FEK8PfsselilkDItFfp1fKX/uJTEjInxsXrSRhyUGqYqOxWesCR1Eq/C8nwnyTU
	hAYHCy/rUddr+VVYsFGEbLpgyRceRz9rfoxIJiiOLHAtekI7L02qH3s+YBenI/WDP+zcHMn+Zxt
	L3xgUuED5WQu//3ppmZXBK+PMAndDo78A7hFgt9qxJ1C35Zv+0ertqd5C6nLmdIBDFudzf9qrjU
	1TiWwnCtE25VGUBv0yTwTj
X-Received: by 2002:a17:90b:2584:b0:3ac:ffb8:1809 with SMTP id 98e67ed59e1d1-3b182f3eec3mr1222087a91.39.1794374163584;
        Tue, 10 Nov 2026 21:16:03 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17da4cd8csm2735691a91.2.2026.11.10.21.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:16:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 23/29] bpf: Recognize copies of a scalar by their ranges in flow_join_makes_up()
Date: Wed, 11 Nov 2026 05:13:34 +0000
Message-ID: <20261111051341.2800252-24-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

A prerequisite of the removal of scalar ids. flow_join_makes_up() is the
last code that learns something about the prog from them: which registers
and stack slots hold copies of a scalar. Recognize the copies by their
ranges. The function is a heuristic that decides which states are joined.
So this patch is about the number of states. Soundness does not depend on
it.

	err = update(); ret = err < 0 ? DROP : 0;
	..
	if (err < 0) goto out;
	..
	if (ret < 0) ..

The states (err >= 0, ret = 0) and (err < 0, ret = DROP) get to a join
point before the jumps. Their join loses the correlation of err and ret:
it has err < 0 with ret = 0. So two states stay apart if two scalars that
later jumps test each have disjoint ranges in the two states, as err and
ret do. Copies of a scalar are treated as one scalar there. A jump that
tests one of them refines the others, so their join makes up nothing, and
compilers keep a value in a register and in stack slots at the same time.
Copies are recognized by their id, in one of the two states:

	if (one && (!id || id != (ra->id & ~BPF_ADD_CONST)))
		return true;

If every copy is a scalar of its own, too many states stay apart. The
init prog of a sched_ext scheduler in Rust goes from 36 to 512 states at
one insn and takes twice as long to load. At 512 flow_has_room() is false,
and states are joined by force.

Copies have the same range and tnum, in each of the two states. Treat
scalars with that property as copies. Two scalars that are not copies can
have it too. Then two states are joined that stayed apart.

veristat over the selftests, Cilium, sched_ext, katran, bpfjailer and
programs in Rust: no verdict changes, 199 of 32913 progs move, by 0.01 % of
the insns in all. The scheduler stays at 36 states.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index c9458b3ad114..778288acb5ba 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2603,10 +2603,9 @@ static bool flow_join_makes_up(const struct bpf_flow *flow, struct bpf_verifier_
 			       struct bpf_verifier_state *b)
 {
 	struct bpf_func_state *fa = a->frame[a->curframe], *fb = b->frame[b->curframe];
-	const struct bpf_reg_state *ra, *rb;
+	const struct bpf_reg_state *ra, *rb, *one_a = NULL, *one_b = NULL;
 	const struct flow_need *tested = flow->need[FLOW_NEED_JUMP], *need;
-	u32 fr, i, id = 0;
-	bool one = false;
+	u32 fr, i, len = offsetof(struct bpf_reg_state, id);
 
 	if (!tested)
 		return false;
@@ -2623,11 +2622,11 @@ static bool flow_join_makes_up(const struct bpf_flow *flow, struct bpf_verifier_
 				continue;
 			if (flow_gap(ra, rb))
 				return true;
-			/* copies of a number are one number */
-			if (one && (!id || id != (ra->id & ~BPF_ADD_CONST)))
+			/* copies of a scalar count once: same range and tnum in each state */
+			if (one_a && (memcmp(ra, one_a, len) || memcmp(rb, one_b, len)))
 				return true;
-			one = true;
-			id = ra->id & ~BPF_ADD_CONST;
+			one_a = ra;
+			one_b = rb;
 		}
 	}
 	if (!flow_needed_consts_differ(flow, FLOW_NEED_FLAG, a, b))
-- 
2.55.0

