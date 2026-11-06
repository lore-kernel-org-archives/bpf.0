Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937280;
	b=u0hOr81NIxQQDI/htGJAS9Ok/gv5+/Yi9iCtEUd+C9bJDIGYendc0PUNn7S0hyu9ONNA
	 ARJTOwPrFifu+jGIC8dAXw/ADsOdrSh71IABkK0NBjwF/Muqc+gmJL7sFH29gisAd1WCo
	 WqQAAPfJ8H7/VeEgm+HX0Ng5KUh/e51wSSccAwzLHPKmw0OpGKeckXRvMC42EVHA7Iwf2
	 7hSCxtqKJ/Chd/KBC1GWLZF8rKvrVdYL5SoWh7ExtrBancm9zx14a0PRF9EYkC+T5viil
	 1vibaVgAq/qCLNVuBNOsfTx0KHBJl4J99eWhst+6a2vgoQDWM+S3IZtL1yd7GG8XRqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d6k6QrULjhW9MhiViPhZFzjO5Le5dKKexXrn9h4RIZ0=;
	b=tkLL5WFgV/CB5zmhq2CPc9W2IQB7ef29QaAtMJ5AL/o95zBO2CO6Zw3CqGauSBXlGZF+
	 OqqzktSloxu6gP3Yx+ekB1B4vTsttsYDwtWYEoxKubdBpLHrTFclG4SAhVEmSOH9LA5/V
	 QAehe8YGq0UBQpWwyJvTH0h0DJUhz6VIApd3NqTsU9t/vDPNNVi03i1lsUQPpcbpInnmo
	 C0zA+RVPHjSsjD7pzpul7hNuKlzhxBU1aUzupipsPqZOjC6Dgu8+ImuweT19EXWKnOEqT
	 +k2JvEieG2/TpVKp2fDg7TYCJQF0GIgggzgXoPsBfOOzqmJJh1u7MmXh/YciYNJKWAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fqCYcS1b;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6479606A328
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6479606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fqCYcS1b
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so101019a91.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937279; x=1794542079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6k6QrULjhW9MhiViPhZFzjO5Le5dKKexXrn9h4RIZ0=;
        b=fqCYcS1bkuKMf3YzoYcXdRVXSl23n+QZ4BthIRHAg2nxWdLC8+1pVcq2hvwn5igGUX
         0W810GdBMR/dqmaN+MntyOwoJ6V0h0t5SySWFdMJ2rHWoCSH0mAIOurFnxtf+YnfHK/c
         ZuURbvV5vTSKkReOX9p2l4mOlpkDr68Vtg00wVNYBJn5AVnUapljiAoBiF2tsd3b19zg
         Q0SmGczp4ohMLy0lBYkiCehtIpkux+xIcHCIETgL/mQNuyLxNDx/R2LbsSQ4OHx264WT
         8AKfKac521UooTCYhKUo83/wWuOFZy/S+8QU0KaVrYspRu9QOFAP9GWTCECXRgPx/3YA
         RMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937279; x=1794542079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d6k6QrULjhW9MhiViPhZFzjO5Le5dKKexXrn9h4RIZ0=;
        b=FpgHm57G2FBT80F/zCwUi1wp3Df2ti4srhDEvh/OQX+TjlQNS1IN9K4CU7CxsslvOy
         0PSZbUXvCK4PkniohzAI8/Cyq318lHPzyKn6VMt1sYGuWb75/2b7z30CtrAxKd6LSM8L
         3dRHtz+pn5mlszIvxVSeAgKFQsCCcubD7OvwzO5FIkaXDS0dDn/5JMu1GwPZWjuxaz2U
         oq2omhXB+Ug9GrnJLR0OkJknWEUomfzlcZS/T5KzPXPvMUoFJ6miyEOpAaNqsYu3qpLm
         GVB0JhRbM8aHuxYnD98ATRNJ7pYlWX8e+yckRoruHt2oN0xMl9QbvsjqqF2zRqU2Jola
         /L3Q==
X-Gm-Message-State: APuU4Z8KFAzteeArqGec6Lq3z0IiqH+iwRjzAwrtL63SPFUoeaGeu9xl
	cFcuH2lKO6qQoenRP5Kaikfk//Z0tnV13BPpEO4n08vGqNoNPi59tcRft8c/UA==
X-Gm-Gg: AYBFou24UBIoUckSECQAOvUK5Q6/TJOaXgA8ELtC1y+lihxucH7JYwzmdnTnJZhpMGh
	1eN41Ap3AXAAdqZX5hTZugTi2IBC2f3D7SDv2JQE5DIFY1Cvv8GnrVETk39sPkLPhC6IG0MdDLe
	7NkXSAyusxOCDGlJs1mAkmUuiUteeArrie/4JgYOrmUj3O+jQee9T3Yz+OsZ43um8sJMXflq0ZU
	q95lKhnr0WtS+8+iR/S8UWpwyhoIUy6zJCp3UueQwFqbudus7Arx9JuH358rv+W7CJRR+fNFWt6
	pt1aNzbeE7gjMAcOKZaiS7VT4ixAE7uYbU57uu8l9LbLGTKZGYX8fef4uLdaeUxRjx4aqy/dGVu
	19TVlv/4a2YS+P+zeyKYQrk/UVmvKSmU6ts9t3gvctJtXKylUAohjGZAsoa1pi1/gB9F63X9RLt
	uDcn68mtKoaqopOIsDNCh13mpFJO1SVyuUU1KdikH6G3zi79jrMqZ1hjYrW0+nIjp37C2Q8nI2O
	fNYPnixGUb9hEuza6T8gcrU7/Poma4pz+j/yw4KPCOPFjpF+Ireo8Q1T++Crkqx2G2lhAY8ZpHh
	JhfHpKj6Fl8bbKIvTFYFV1Gi3a7LteNekI5I7dUlyUt0JigiwbDlf3eCflg+hLE7k5RkSmVENUN
	lIHoNc23wH+sCWpCHqCLqy+Yvi/ESXJw3F14RgD+wWcz3RAw9NzIAjrlYbcQ332bpX4xv3+1zUA
	==
X-Received: by 2002:a17:90b:270e:b0:3ac:b6eb:e0dd with SMTP id 98e67ed59e1d1-3b0db70914dmr1164344a91.50.1793937278830;
        Thu, 05 Nov 2026 19:54:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c42932sm1516744a91.6.2026.11.05.19.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:54:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 35/45] bpf: Keep the step of a number in the union of two ranges
Date: Fri,  6 Nov 2026 03:50:59 +0000
Message-ID: <20261106035111.3315285-36-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

  u32 n = x & 15;

  for (i = n; i >= 0; i--)
          sum += a[i];

clang counts in bytes and leaves the loop one element below the array:

     r2 <<= 2			; off = n * 4
  1: r3 = a ll
     r3 += r2
     r3 = *(u32 *)(r3 + 0)
     w1 += w3
     r2 += -4
     if r2 != -4 goto 1b

Scalar evolution does not count a loop that '!=' ends when the start is
a range and the step is not 1. So the states at the loop head are widened.
The offset does not get past -4 because it is a multiple of 4. The union
of two ranges forgets that, and a prog that loaded before is rejected:

  math between map_value pointer and register with unbounded min value

a + s * k and b + t * k are both of the form a + gcd(s, t, a - b) * k.
Compute that step in bpf_reg_union_range(). Widening drops it when a bound
moves. A step gives way to one of its divisors only, so it needs no
widening of its own.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e7875e8bebf..83baaf1a6f2a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18425,7 +18425,7 @@ void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *
 		     reg->r32.base != old->r32.base || reg->r32.size != old->r32.size;
 	s64 min = reg_smin(reg), max = reg_smax(reg);
 
-	/* Only the step is gone, see bpf_reg_union_range() */
+	/* Only the step got weaker. It comes to rest without help, see below. */
 	if (!moved && reg->var_off.value == old->var_off.value &&
 	    reg->var_off.mask == old->var_off.mask)
 		return;
@@ -18462,14 +18462,36 @@ void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *
 		reg->var_off = min >= 0 ? tnum_union(reg->var_off, tnum_range(min, max))
 					: tnum_unknown;
 	}
+	/*
+	 * No range moved: the known bits or the step got weaker. The step comes to rest without
+	 * help: it gives way to one of its divisors only.
+	 *	off = n * 4; do { sum += *(u32 *)(a + off); off -= 4; } while (off != -4);
+	 * counts on "a multiple of 4".
+	 */
+	if (moved)
+		reg_step_reset(reg);
 }
 
 void bpf_reg_union_range(struct bpf_reg_state *acc, const struct bpf_reg_state *src)
 {
+	bool acc_const = cnum64_is_const(acc->r64), src_const = cnum64_is_const(src->r64);
+	/* A constant is its own base. Its step is 0: every number divides 0. */
+	s64 a = acc_const ? cnum64_smin(acc->r64) : acc->base;
+	s64 b = src_const ? cnum64_smin(src->r64) : src->base;
+	u16 step = gcd(acc_const ? 0 : acc->step, src_const ? 0 : src->step);
+	s64 diff;
+
 	acc->r64 = cnum64_union(acc->r64, src->r64);
 	acc->r32 = cnum32_union(acc->r32, src->r32);
 	acc->var_off = tnum_union(acc->var_off, src->var_off);
-	reg_step_reset(acc);
+
+	/* a + s * k and b + t * k are both of the form a + gcd(s, t, a - b) * k */
+	if (check_sub_overflow(a, b, &diff) || (!step && (diff > U16_MAX || diff < -U16_MAX)))
+		step = 1;
+	else
+		step = (step ? gcd(step, imod(diff, step)) : abs(diff)) ?: 1;
+	acc->step = step;
+	acc->base = imod(a, step);
 	/*
 	 * No reg_bounds_sync(): every part of the result has to include that
 	 * part of both inputs, and an input is not always in sync.
-- 
2.55.0

