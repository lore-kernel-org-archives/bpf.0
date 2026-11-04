Received: from out-2uec-a117.jellyfish.systems (out-2uec-a117.jellyfish.systems [63.250.43.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8B6098F79
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 19:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DD8B6098F79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=Kds8R4nd
Received: from [10.18.116.108] (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jKbkP659hz8sWS;
	Wed, 04 Nov 2026 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793822082;
	bh=WGGGdGC355BKZ7pTGFjLIU9XKUJbrb0oDfm9CXS0DUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kds8R4ndXbBgsKAZlR9dijXgu+HbKEqrKR7HiWXOjSrOaIKlNSqacqMA+BuMzvNrm
	 4ZYTqUOViFe82WiztmwBONdPb9bDbsaY917+q4HRshmOT9+3m94AX5MbfTIyEQcAMq
	 uQ8YAgTH5tUwjO3evEbbD55uXfZF5XRFGJAbVEbZb4jB0Wg6m03Iu/Ucwi7AgZHdur
	 E9gLetRKg+m9miML6rytaqxTW5AghckPKsemu/rQuw6qweHtlUAp/He8PX+Kmz/pMo
	 xkSnXkokMvKwhNOtGu7pI4INuSGQMWuS2fZaHDyNK8/GZhVapDT6eUdTJrWVzG8p6G
	 mf4EPMskOcZyA==
From: Tianyi Chen <hi@tychen.cc>
To: bot+bpf-ci@kernel.org
Cc: hi@tychen.cc, bpf@vger.kernel.org, qmo@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ihor.solodrai@linux.dev, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 mason@kernel.org
Subject:
 Re: [PATCH bpf-next v8 2/2] selftests/bpf: Check bpftool batch map dumps
Date: Thu, 05 Nov 2026 04:54:13 +0900
Message-ID:
 <179382205321.440318.6667723439394018790.bpftool-batch-v9-review@tychen.cc>
In-Reply-To: <8397ab89d713edcda68bf7dfa564b3a6f2c7d4c420a9a1a9a49fa2dfc8833233@mail.kernel.org>
References:
 <4b2b24fdabd4cdef1364a8664d7d9615e960c72c.1793818387.git.hi@tychen.cc> <8397ab89d713edcda68bf7dfa564b3a6f2c7d4c420a9a1a9a49fa2dfc8833233@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Envelope-From: hi@tychen.cc

> The test still works, because dump_map_batch() in bpftool treats any error
> other than -ENOENT the same way.

Correct. v9 removes the bucket-lock errno claim from the commit message
and clarifies the comment. The injected -EBUSY still exercises non-ENOENT
fallback; the test behavior is unchanged.

v9: https://lore.kernel.org/r/cover.1793821981.git.hi@tychen.cc

Thanks,
Tianyi
