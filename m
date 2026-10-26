Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057926;
	b=Wqm5pSjJ9FCa+QW1rJ6hZK1uu5uXqF+Oe2SUb42d3pEB1EIRadODbhudexUsE1QIsgGq
	 /dpePD6ZJrd1iPLyJGTmCdt8j3Il8Zqx82VVVY2/QQOpq16x/u92870ip86sP17d1JPwt
	 hZjMCWXA4SU0aHIP4npwwbZRSMeXJGJtVxEZTGuJQOYU+NfJjk8H87dhZtTLcO+ovb1UU
	 Nq/mFMlsRnECpCjcjC5R13pR1aOQok140KcRG12JvhvQL6sUnD2bia1AEXgmk3sMXCLq9
	 rLw+ZcpAGTyAMDPYb6NikZNcuo/i1bNNTdLKaZNRAa6xIGS0jOsc8wvdjiGwiwvRdzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=xBN2DuiySWj8uurezziKoHvD7JfVDhv79BBtT4xBONg=;
	b=C/RavTEZHtgDff/ufDkbZis6qXeNXfInaWRWi1qfGr8DRhi4Hf7hrmr+caiJKt7iGdXY
	 b7P6HxUWqvzDyefDsUsGz7iYfA+sFoIdnzaRWoAF2Xu1xSTla4fHsBOmAq6+blVkLhYDt
	 K+rBBlB83ZDfXwfquuemhdCgh6K1iD3P4QzJLCXKBw6+L2wjUSlmzhzug4OxGnhxdbd/9
	 Sd+zBsmB+11aRz775+l6R/CUwwhNuCUuQ87L92RuFEhAFFaly2jtolKbcdwsEyeYd3b+V
	 WqCLyyS0kzP0meI1glDr1OnkKLUvUmu16GYWRLd+7TliMhd7m5AGSt05l3oygc6ImCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="WBi/O5Rs";
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFD606A322
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DBFD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WBi/O5Rs
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a058f74a54so1301377b3a.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057925; x=1793662725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xBN2DuiySWj8uurezziKoHvD7JfVDhv79BBtT4xBONg=;
        b=WBi/O5RsKwbnEUzGVaIPek5YllXfTx7jmmOkNlM2A09u/C5xiodlthTh1Vu4xBeLdb
         2PwimVSde4OR/81xAtMI+5nryKJfqhpCNINzogkzjeInq/974DTd6fvhS4GWi2/OqWrm
         +QQjcK131nBK4twQfcNcNWJKeHEa3SpQIpeRqMVyjzvKhZTv4onPrr3BKSEWjwgzepvX
         delxHmLb+IUK5Lf7RjXfAjwc7tn8bAN6XcKDQaz1BUPiAXmN4ZjLz1COtbjKc1gDrwpf
         YPflky8ixlQwe/ajDk3lsCuQ8lfHI3kZUxKCv6b6tATDp1Unt0puhLHIBd+SSb3RzAZM
         nJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057925; x=1793662725;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xBN2DuiySWj8uurezziKoHvD7JfVDhv79BBtT4xBONg=;
        b=uL5pMYwxCcJ2YAAvO9ir35vBjq4xTYOFXEabmXo/QmKa3HIN6JydAL/2o1qPGCldWl
         ZoSFmB/49YHjxQTu4RGdrPvLgzOMwc6Di5G3TVucqN5AB2bF0EzaGH4UcjxetmxuPz7Z
         /CxsFWAh+Tli4yHQArQQltMef3+mGMInpByUd2gVlIp+bOlVSmDwmweVx/Dm2bDRzsxr
         +EbJXIeFbPzBw6XE9meuMI75O4FyoTjjH7z//HldpLbZo6XdzxrrYyi6+djQBF9DaB+2
         4ixDFXxsIR5o9cjfTo+qIlShDn254VDYAh8TZVylhrM/59LQgGXiZ19Ieo+S9ppIfVDi
         4/ww==
X-Gm-Message-State: AFq9FYLYuZSDKH1GHQAYloBR84M5MxJ6k3Tpv9TDJdjvBM6QzR4jjyvd
	hgXH0fgyiTcMzKvU1Q+62Mh0xurdfg/X+kEi5GW41nGFiRTLyINx2LXxnj8VhA==
X-Gm-Gg: AYBFou13p63FzO8bRQlkJCOO6YzJSZSmkVlaJ48yDAMJwo5uetMNq/WGM2acw8urzzz
	NaFN0TR2xjkrPRwt7kSO+/Yoo2yYncXhL72LnH+K8n9Awo00smEtaHQFx9RO+9CGD+BKu4Axze0
	vV87DqmM0mpvHd6iJ2GzR7fcb75sUdCC60Ct4lGahkBYC5C3E57YMKcJdyFJ6p86ck2B0Q+8kes
	/4S06/QkxlKVvcRZCXCfxqby/VAy8zm+PIXnzzmNnEAZ3efuni1qUZXyeqoQLfEMvLUOfI2zWZ3
	+UX+mDn2R96Yy0+7XtUklu2mbMCAQ1S/0t60o7TJTfwUlIylcYpqentA5oHfBoGEZJ4QYBwbud4
	6uUx0qrKAWGLNpID6jbgNWUrRwrfEp83Am8Tp1PqiXQSd9wqdzroYLjlVoPZG49sFz6FSKDUb82
	d4fvo+EUEZIeSCEzAfSr+RR44cAOBoloVurTJIjua4tWJP0FNywiDif/Pn195khEdW4asFLX5Wn
	XIjPzWC66TwvW8ZCoH/mybAdSMoLhfi0Fn4SuhPc2vbomeTDNvPAspnyXFzAv4YlIwIeoKGRQ72
	trZlD5P9ieeFZI4gyrqSud4=
X-Received: by 2002:a17:90b:52c4:b0:3a4:8c41:fab6 with SMTP id 98e67ed59e1d1-3adead50adamr6564040a91.46.1793057925425;
        Mon, 26 Oct 2026 16:38:45 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:45 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 05/11] bpf: (zext32 (zext32 X)) -> (zext32 X) SCEV simplification rule
Date: Mon, 26 Oct 2026 16:38:25 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-5-f373aec9825f@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
References: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The compiler can preserve an induction variable across a call by
copying it to a callee-saved register. For example:

        w1 = 0;
loop:
        w7 = w1;
        call foo;
        w1 = w7;
        w1 += 2;
        if w7 < 10 goto loop;

When building expressions for the loop body, each 32-bit move adds a
zero extension:

        w7 = w1;    r7 = (zext32 r1)
        w1 = w7;    r1 = (zext32 (zext32 r1))
        w1 += 2;    r1 = (zext32 (+ (zext32 (zext32 r1)) 2))

The existing ALU32 simplification rules allow recognizing the header
SCEV for r1 as:

        (zext32 (linear r1 2))

Substituting this SCEV into r7's expression at the latch produces:

        (zext32 (zext32 (linear r1 2)))

Add the simplification rule:

        (zext32 (zext32 X)) -> (zext32 X)

This allows recognizing the saved induction variable in r7 as a
32-bit linear SCEV and computing the loop iteration bound.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/scev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index e3c2220f89c9..12b147faa32a 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1502,6 +1502,10 @@ static int simplify(struct scev *scev, u32 id, void *priv)
 		return t;
 	}
 
+	/* (zext32 (zext32 X)) -> (zext32 X) */
+	if (is_zext32(scev, id, &a) && is_zext32(scev, a, &b))
+		return a;
+
 	return id;
 }
 

-- 
2.56.0
