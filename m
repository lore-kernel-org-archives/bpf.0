Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206887;
	b=DHGAFWY1nK8qIQlpd47fKwDDks788SUEen5enQG8vEDY1HQV50Sb+ePJUNxsT+elaUew
	 diQi+T5ROWLNb/tbA2YfpC2YGqW+KMerywxHDViPAeHz1QKPrAWUAlv06GJx31Yk54AqE
	 r0ppzoZYsgN/v3VmrDSHM9qrRD53SZgzYryE8dxNzEcrkVVK8+L3cmFi2Vyc7AS6VB222
	 KUsMrVlBD9vglVyOD92yxdO+IXB6j7A371F8avSmtvllp1YhehYF+KLfbNKevDqURqDfv
	 7FoqyyVJ7pLv+NV/8uenAZ9u1Nz4FtBAlilLPalyXkDXZB4UVALY5i+iTMHywpGQ/lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j+AB2UdB4nDl+iGmPMk5cPg7+7YmgrthKDgxxnJ57uk=;
	b=Jy+pQWj9wuEiWtQtNXpv4aanAmhXFgs5JII2I9weAspKdNcujwQrZ+y3jvvYdygaFp3i
	 KR9CxzEXB3Dsd+55avD9m87UtL4qTKIhynU1x3smUoJWwN4P7xF0AYjufFqX7O7BfASh1
	 7tKBkyRU8uqf/hPFzEWKZVspiMTk4ulexdySPwB1cizkq3KtleAGP68rx44/Wgy3SbKL+
	 2ZDmi1sslzwcZhT5AJcGD/ypZEDJMdxdY/1cVTvmi2uYHSzTgSWN+PVh7BfJI226iiu5Y
	 sQny1c3iScbSX2U2ahCwWrld2KapcvinfeXBNIs/Bg5sMDH7oIb0ywZKZc+NUjcU+0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B8wQXAn2;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D33606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D33606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B8wQXAn2
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9ae391a05so2625285ad.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206886; x=1794811686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j+AB2UdB4nDl+iGmPMk5cPg7+7YmgrthKDgxxnJ57uk=;
        b=B8wQXAn2FoQkwnptw0WWhiv2nfR0r7uWIMy/CTqA3HFROF9DZTzhMokCYIzhLgXbFq
         wbeLSBWbNrfE4bmEp+7Q4lbnkwnZ/g8+uBzBihzf7kS2Zh2iKTwkElySrG5+z+U8QvIZ
         u833tmF/YFwneU89QC04zA6Oqhrip0RmNOYxdhDA6QDe9exRY/wkiKLRd1UvYpH+vl/n
         xGw0gs2ON3Yy/sjuTnIrXAJbB2rAgThThDRm0jzAT9tOmnD30pnKL3Nol5Jqqnygz6Te
         oKEVKTFcAglij8EkbuVCwSmbPTkSYPtaoujW9z4VKWHcS9/sR1egwtj744WiYSqS/Cxn
         8L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206886; x=1794811686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j+AB2UdB4nDl+iGmPMk5cPg7+7YmgrthKDgxxnJ57uk=;
        b=xNE/Jy38K1IRa7ducDgqSc5/2lkpzC62GCQwhOLgouact8kspGkoAw2arXoiNfbZer
         I3g23y6aqCqmwBqEvrZ6whYHw9VlbJ+ormCmxkywXsCFjfabtxP++jtQWd2BTakoao8K
         qQmZbcyyV/48P2aXwhH9KBmZp8YshaYhphquYn9hky001fNn82VAIB8NtCvhMwl4h9Mu
         fv4iTN4wET6LuiUj5LEh15DGnxV2vPR5CczHnzoTsqOnrqUZ9QvEO6Veus5JcfQrATSo
         HWAinxwH2lruCJHM5eot7r+RJ9VzaUEX8p8Rw8fLzuUE/MZqP5M3ggRfdpUMs5Z8Uy58
         6Qrg==
X-Gm-Message-State: APuU4Z8+3fCz7s0EDCCskDbuwUA27b3Vj18hQSF0MpgliczXbg0hx+Om
	Ajd85FRVbcY51yPYjT/ZS4arZ4CJtN3h2P34OJHN7Q/LdovJeUvT7gRimoBsoQ==
X-Gm-Gg: AYBFou39LbWcUVHAFkRO8rugwpbw8FjZkvaMe3LvxFcVQfE9/atTpoaOCLA8IFUy3b5
	76XmWQOgwzSCkLl860VD6visoJcZgo8lUXVhQAO7RFp/WLGj3qDsPq907fUhTqXwUVXod+2ssti
	nFGdMAVmZHcIm/PcXt/8xTdgWlyIWvyPgnCyMMxgEepuO/gnKlZqzTqLbYO69V+5jpBYinG2odj
	iG0o0KCTg1XkvfG6QTHIiSSGfyNHaXBAuOzYGzmcmfMmOSwf7u9XqKA0o40Nn7dzfLC2L/s4elb
	i9hxHXnhCTGjzBd/sC/Y+pnlk7EPL2Mt0HtcTZrC5bi1WmHHh0fxaI+VzM3DUp17yCeLf9iWBuu
	rgsAL7qIzkgd9/7nvV0p2xFrde0ATrU4EQEAyRpwnTRajkzxoQxmUIuL8KDbsI3X4MVg+UPSFDW
	5UAhZ4mygtv3IhIiZ49OVQyL81U4SkNULrIYOqhTAMQ3+781GbhYdzm7Xc4TWwyGEoeWJTmT3ov
	6N8A/uwtSTLDYPGcNrBrqnRNUq1ZXNvUZu4V7a2lffUQpIbTS7mJSoZ6yzPUKfwBEb1SKZyXHKt
	+DdOoUACw3du0IwOoRNs1WRnKoOvi9F0xEVM3gmknqjMNu+bVfd6PvcXeMgev7NcDo5XOvl7ZiN
	MzgcehOVhJPYyzCzPMn+fiBwGUOc0laDI9YJiCjIn5h9nvZS9M022JsukWZAfnl8Y0gQeRa+yYw
	==
X-Received: by 2002:a17:902:d552:b0:2e8:81e2:1d42 with SMTP id d9443c01a7336-2ed837a9badmr23612285ad.39.1794206885489;
        Sun, 08 Nov 2026 22:48:05 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed815e796dsm7719145ad.19.2026.11.08.22.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:48:05 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 08/26] bpf: Mark the attr argument of bpf_sys_bpf() as MEM_WRITE
Date: Mon,  9 Nov 2026 06:46:52 +0000
Message-ID: <20261109064715.2382452-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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

A fix of the declaration of a helper. This series needs it: scalar
evolution keeps the expression of a stack slot across a call unless
bpf_may_write_mask() of the call has the slot, and liveness.c computes that
mask from the argument types of the helper.

  union bpf_attr attr = { .btf = .., .btf_size = .., .btf_log_level = 1 };

  bpf_sys_bpf(BPF_BTF_LOAD, &attr, sizeof(attr));

BPF_BTF_LOAD and BPF_PROG_LOAD store log_true_size into the attr of the
caller. When BPF_PROG_LOAD rejects func_info, line_info or core_relo
records that are larger than it knows, it stores the record size that it
expects. For the helper the attr is a kernel pointer, so
copy_to_bpfptr_offset() writes to the memory of the program.

arg2_type in struct bpf_func_proto bpf_sys_bpf_proto is
ARG_PTR_TO_MEM | MEM_RDONLY. So the verifier keeps what it knows about an
attr on the stack across the call: a slot that held 0 is taken for 0 after
it. bpf_may_write_mask() of the call does not have the slots of the attr.
And an attr in a map that the program cannot write to is accepted.

Say MEM_WRITE.

Fixes: 79a7f8bdb159 ("bpf: Introduce bpf_sys_bpf() helper and program type.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9004f2673ccf..04a3b3c80c74 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6692,7 +6692,7 @@ static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.might_sleep	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_MEM_SIZE,
 };
 
-- 
2.55.0

