Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8722BB1D
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445725; cv=none; b=PuoMsSOuad3n91qVtDJZqOPTgJKy211Mv0DNzfdebFS3eC4ndQnTHrpgqNUNpIU9ZBJfdhJIboKuLPDJUOn1IE9ZcAbsaP4NZjsxRMqfg2g3RF9Ewcajowt7xiX31T3WdCn8N1S/Qlza6MZxRYp6dUiM9lUJj2CoqHQLUYQrgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445725; c=relaxed/simple;
	bh=3JurCMt3UXo3YVngPWeqNr2Comw6WXz9dKCY++QX8g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6SPcPUuG24w273HmNfI96ecEhUKw08a6XKXk999UMcODYM3HwhzbCep2wpWCvGuPIbBBHHmzQK18XyTNeQjRqL52yCGxqeH4aAMhmn1WEMa78DBiYR545eyHCuLLw1CoYmJC0l/UHK3nDdW4kCIsHa0JRxlquE6ehO3iwxbaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imn5zwIM; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imn5zwIM"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2c0c2a68d01so19625695ad.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 17:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780445723; x=1781050523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9gWSPng4QFqLQy/HiuRSP5r03pMfSfEnn2EDlkojFQ=;
        b=imn5zwIMc6rMQtoJuHGGE1vYKafQ7KE4tdBBI3y6tms7iPsWL4yK4LoqNxcGPZ7ln2
         /DzxFrG/qftCkP9UlkoV3NLIPWNWAuUCd/pfcZhUToMPE9uoEuxTW79hnXh+MoYZn+nl
         sCv4hYsg2jB6Yi00wJaU6CT0g0Htpu2v4QBzz11RgM24ErWJj6k2kvv0K1hHC7Hy44o7
         eX64wFHAEXiRVBWudQwi56WHGi9gooTPS/BX4HkV34M3R/+j6SGAYyUQEcU/shf8hKn0
         eNEnT+iMxZFQbfLB2yTF+eK2Ng2nAnXHjOQR26EqP86X0sXYqF8Y8xbwK3R4CkvhzLb+
         Ex7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780445723; x=1781050523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V9gWSPng4QFqLQy/HiuRSP5r03pMfSfEnn2EDlkojFQ=;
        b=Xj0qiX/mtboCuH2OJXUeHgqYcIQRL2XXgJ2wEWNJdgXeTE5SMvi6BO1mS5yjTevfvR
         z+nvJHUewlPY7rKp3pP7YtKjcRz82wMVg04N3jOg60UdVKQ+Wkbwt/vZHqB5/7cDbK8f
         auRpGyVSZFTQktcfunIGDOJn6ZlnxOSJBpPgpCoWW+M2u/VMtCazKTbL9bMvbRD0ssyF
         od5AWqNwJ9jvd4uUlvr43AOS2VN3ubLfMwjU0u5WlD3/BVw9mdLE4srckYeIREHBNzHz
         0sEtL6C0B2WkJWnKYB0n372TnJur8cXhnvWtOp1+gJbVhG51j8Dag+pYlTaXZV0lPCAr
         POAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LoieoHb2q/rQbgC10GfQDSQGOa0ypkbyIjfyXhBuStf6dgy6yhbHS85yvxNDzy1xWUwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9PX57M997XMkCR61RVwWU48YrupA3TL3yYnRlhJFY4aBD9u1z
	0NA7DpggqOoW+dcyGUjdyNE5C+KxOQGmNFwgnE23nvTFPpIvWiK9IStX
X-Gm-Gg: Acq92OHp5Wn6bx6EbVoSsDq4BibAPI8lWq71r1LLJL15bHgikR7frkbeQ3I42IiFE0V
	SbV8D658X/iITV2sezbvKxY6KhZJV9nWdLX48WyCjKigTsnQIEfcuQSPBVS7HqUAOa/eixTJ81f
	a04eBM8SuwA5WiBBOl/r2y9pq2YcXiwvc+mbk0fD8xoircLG5Hsc80uqTkjqkdMd2vuBCsnzExl
	RSidX/PTw0WQhLjCxRmqy9fv/18sfvqtoANWb0/dVTBebcsTftmUpI8XYnuYRp3zT5JvgrDFkux
	I9RbVwfBkiSRh+GKoLuuLQT2BPfXT9h47NDJG6mxKEqKIphQggkoHh3gMSBESBl2oLW9tejj/bp
	zJAIdNVAW9tqVJRsrqM/IP/C+WDape7Q09L6+CMhfiTG8hLlZgcbNWU9Ou2lsBw3eObSDspzD/2
	KjM4aoIb7D/V/wfgFRjGZbVnRVpdRj
X-Received: by 2002:a17:903:288:b0:2bf:1486:e6ca with SMTP id d9443c01a7336-2c163d61cbemr9890435ad.12.1780445723143;
        Tue, 02 Jun 2026 17:15:23 -0700 (PDT)
Received: from laptop ([61.254.29.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm4166505ad.60.2026.06.02.17.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:15:22 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: yonghong.song@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	qmo@kernel.org,
	random6.xyz@gmail.com,
	sdf@fomichev.me,
	song@kernel.org
Subject: Re: [PATCH bpf] bpftool: Use libbpf error code for flow dissector query
Date: Wed,  3 Jun 2026 09:15:12 +0900
Message-ID: <20260603001512.19824-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <22ab9375-e7e6-4929-a80c-0ee9cc74a907@linux.dev>
References: <20260602170350.261035-1-random6.xyz@gmail.com> <18dda63b-79d0-47ad-b60b-82436ae0a017@linux.dev> <22ab9375-e7e6-4929-a80c-0ee9cc74a907@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for taking a look.

Yes, the fd is opened read-only, so I do not mean to claim that close() on
/proc/self/ns/net commonly fails in normal use, or that delayed writeback
errors are expected here.

The fragile part is that the BPF_PROG_QUERY error is consumed only after an
intervening close(), even though bpf_prog_query() has already returned the
negative errno in err. If close() changes errno, the old-kernel -EINVAL
compatibility case can be missed.

I reproduced this with an LD_PRELOAD fault injector that forced
BPF_PROG_QUERY for BPF_FLOW_DISSECTOR to fail with EINVAL, and then forced
close() on the netns fd to fail with EIO. The unpatched bpftool reported:

  Error: can't query prog: Input/output error

With this patch, the same injected failure is handled as the intended
non-fatal EINVAL compatibility case.

I'll send a v2 with the commit message updated to make this clearer. The code
change itself is unchanged.
