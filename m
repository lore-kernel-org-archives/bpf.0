Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A738DEA
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558014; cv=none; b=NbOjnvu8KktivCRZyYu50jYuy6GYQwbTDymFqXZWJmyiICIn2uXucNnnI/JIvpqEBKZT9ulOfJm/ZEa/Gf+OoS1cc+5UFn/iA8Ijg76LeSf//WnX3OpQgGVvxPu8EQqyriWnNGkqhqx8xyoDYktGKdMmr2lrzficErJuvaq2msM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558014; c=relaxed/simple;
	bh=MI838sloP2oLq5Vtfr+J9Gc6CMTwPAK5DbX1re6Uk+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2GFg9uOxsE1aHZAsYJnp8OCx8VidYXLi97h4Jb9vnEWeMY3/Nva1bqqIH4ZIT4D12/TY73SPNO3Iw7kag29N/WXxSu+o4UuKuV8kEITOVO3K1ENqZjvBfWdbFancSmmVRbziIlSOsm3NcvZkFwyDDDjIFYUOPUui/wJyxTa2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZomSyrwE; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZomSyrwE"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so6121097a12.3
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 05:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709558011; x=1710162811; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xLB1Zh/9xc9omLfGt+RhOzb47FrTVRgl9O1R9wHG/XA=;
        b=ZomSyrwEG+4oVDZTQet3K+uAuea0I3pEvHGojuvUYPAGgwbKYHeOphIwoI1euYkMzO
         URDbFnSmHV0Pi/iiM8RCb+RTS7Hg1ERTLvIAtEsQ0w1szLkRKVCPu3Dn0aB5LHDcoYVO
         zQs64gUhwe+X7fYuI/vpx7VN/A/J6bPiMTqAORZTPaGnKNpIHeDivaf57xSKkwD4g9Il
         eucOY/hEOUihCv3xnI5WhqnrIVyoqi22WJcpr3EvDR6KdDSC7puITgI+t/jO+xl39R8N
         kVit+Gn6bfP9yhuHi8adIeTWBwfaXMrH4nusprHLAUf5S/ne5AAL9SXion51EqUM1zbz
         5DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709558011; x=1710162811;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLB1Zh/9xc9omLfGt+RhOzb47FrTVRgl9O1R9wHG/XA=;
        b=v939htXO5EysQ8/LMk+dU29OGPj4WCyBZTiNWGP9XMUiMrBktPj74YKUwW+PBi9K1v
         EMmL69M7iMdd+hVcUZOZy3rDb4IdjoHpEBwM9juP73/LuY7wXwOCzfRbywQeXXok/joS
         maSNSRuXLsW5ftJgKBsnGfM2lUNhQ8U6lrd7Jf4rLvYeg6Xf0TkWaFRgiVNXmh7x5O8M
         cv1m6OpptkQ8ZC8sgYg/wuWIjLF9LwA53Uw9VZhVzpnGJmxkq6LG0+G6CS+yzCXb3L/i
         4dSSLrKVindTGbM6IfRX6OkiE6W29csO7Cs4wjhFc2Hej9ZqXpI7jn6G6xGaMBuV9rZz
         zEnQ==
X-Gm-Message-State: AOJu0Yxb41ZMazvAk/4Ivs1ke7Tprw9O0UXbvOIeBmwRJbmz0yG1Y7NL
	oOshQHefWGdMAYFsJiEWYe8wtfZdZ+lwhzrT5/SWH9u78k/TS6Hj
X-Google-Smtp-Source: AGHT+IGSgEnqJZ7pWNnUXglO6av+lQpIYRjAl2mw+6WqvgiSMGfDi6MGDsoQHY8fMdquT1sfDDkp9A==
X-Received: by 2002:a05:6402:903:b0:566:95e3:1759 with SMTP id g3-20020a056402090300b0056695e31759mr5541727edz.26.1709558011366;
        Mon, 04 Mar 2024 05:13:31 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i17-20020aa7c9d1000000b00567566227a5sm921585edt.18.2024.03.04.05.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 05:13:30 -0800 (PST)
Message-ID: <564df7e8c14864641c2f57a5283de53c746ea047.camel@gmail.com>
Subject: Re: [PATCH] bpf: check mem for dynptr type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>
Date: Mon, 04 Mar 2024 15:13:29 +0200
In-Reply-To: <ZeXGTP3ZIFRPGFCG@hackbox2.linaro.org>
References: <20240303023732.1390919-1-haojian.zhuang@linaro.org>
	 <07f7315efef78b7a19dec16b59b74b15f7b97dd6.camel@gmail.com>
	 <ZeXGTP3ZIFRPGFCG@hackbox2.linaro.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-04 at 13:02 +0000, Haojian Zhuang wrote:
[...]

> Yes, I'm referring to bpf_user_ringbuf_drain() helper function.
>=20
> Yes, I should extend bpf/progs/user_ringbuf_success.c. And it could be
> loaded by bpf/prog_tests/user_ringbuf.c.

Before doing so, could you please share example you have in mind?

> But I failed to find the binary of user_ringbuf.c after bpf test cases
> built. And there're no binaries for the test cases in bpf/prog_tests
> directory. How to make use of these test cases? I failed to find
> documents on it. Could you help to share any tips to me? Thanks

The binary that runs tests is called "test_progs" and is compiled
using target "test_progs" under "tools/testing/selftests/bpf" directory.
Specific tests could be run using commands like:
- "./test_progs -a user_ringbuf" (to run all subtests in the group);
- "./test_progs -a user_ringbuf/test_user_ringbuf_loop"
  (to run one subtest from the group).

I have an old writeup on setting up local testing environment,
if you need it I can update and share it.
