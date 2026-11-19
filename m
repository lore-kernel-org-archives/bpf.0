Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098506;
	b=ZlYzpj3aR5zkt7Jla4drFQLsnhRf3DW2K/VyeJ95u6NCRI81696Zuxvj85Hjnq8gIHET
	 6IrH/TQ5uvZabqAvokrOSsa7H/VaZZmzbx5NmZzslEu4FwKf0sHlDoJw1pzsqo3FX7qUy
	 h24db1YYNspGjhZy6vvycIbngnWpDgmQAm9Be1A0yQBANS9Y1gZzGv7JlrQsvE6nfiHh/
	 ujUIYhE2GFZV3FmLlLY3AqD+QfDuduWNB7TlQIpV0Qa9pyjA9vBoZolAPkWdQ8ndh6ZUs
	 XlgxcMpazmAR1O+6cgHx0kp8kXE/Fszyla1FAHlYiXkaXgkkHc+8IUo/LfGVIXjgmMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aKq5GFCa2wHx+1qOMPWq1YgXXJNmBi0r3D1T/T7rUyE=;
	b=aHztphsIsA2EjMsRHNqW7ptfYxycVyrMW2K+eKo0DAM+g9uqisv2dIzRfm569L2+XyHH
	 VZYio5cFm9eFtJqPc+2meG4EBHjBvjy6VJ/00Tx1hjIFyBy8f67Ok4BrHGBtM3zKljx6P
	 IUKvZIe5uo/VGfk7bkJ3R3i8ooe+GaasMLzkZnF9W0TLUOtUAkvV+56rKxhiN6eIaxR12
	 fCDVTTQeYrZ65LUq2B7Y7NzFLi0bB4+M+kO8fehsfD6/ys627S9LCI58haRx4KHA6DNH0
	 RZpWIzNO3AK6TBjIh7glNfHEwIhLqGTt0xcKzLu0UMw6aUUmNBWlr17M6QB4HyzADvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=UGoymCNa;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301F1606A326
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 301F1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=UGoymCNa
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dee593f18so2288939f8f.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795098504; x=1795703304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aKq5GFCa2wHx+1qOMPWq1YgXXJNmBi0r3D1T/T7rUyE=;
        b=UGoymCNa+/eN0LXnupX5p/jacH1RyZGH0JMruwtff1DDRmCSeD0h0/maPQIcBzSr2c
         nAQgbLCiIwZS7i4wBi2OJ5Tk6yTveHda0P7+4mScavr8XAarK0sCDlfqDpCS+3RblsGQ
         wt66NEYPBdB8e43vl7mERobQVkDoYteznXqay6/ZQSSNe8+GWFg2eYjUstZBsVkJljcP
         nwtdeWGGZH+xC+7cwj1MwB+Bji15s+AjXDkM7kRTGlj9R2Jk057CvnELRlRsmegnmE6n
         siwLBPnBubEYhDqYankzaUGuIY90mSrY24I0z534RgSE9+4UBs0s7BBXEZQ9+1EsBBSG
         b1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098504; x=1795703304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aKq5GFCa2wHx+1qOMPWq1YgXXJNmBi0r3D1T/T7rUyE=;
        b=VgdW+klK36w8Jz0ZhO01QNtZyHMYq1z3TrKx4jf4RwNLvPKsO5Yw29vkjpG9iegjcs
         F01UNk6ygzOu2Yqjf4VV5xCPg1UaKvhZSdpoL7JrOcHGg/rhEpB/dXXtt8Dh6Hjar0kz
         XI7Ka9JHaLYTHW2u/6BOaGmh7h79AYyTBj13zs3uq9pLrnpssGHfMgnQu743+UFYp+F6
         JmEQjfgX8q7qKKMOSzB50ZFZfoN3jme4nJrQ7TzP91JjtC8pIwkCqyQV7N7uUQuzV0yI
         I4Bf6vRjvkU9ZMO8ppmv5/nnwXXMVaznUaU41ena29iQJkesXNTVrFFxy/iVduLyGIa9
         Ci2A==
X-Gm-Message-State: APuU4Z9owWfCS2vYLHWu605PIFLO6VMZJFIfj2Eb0tVJShOMi8upOsQm
	3rr/pbaVKZ+/lgT0wO2pOxYsW7MT/EOj3yvutSzVqsSFZBPsCsDtp1i6XP+jmlo3fZSqj5/OOGY
	NOtRrMbJtZq5T
X-Gm-Gg: AZFdTZdUXB1sKatIqQWst5OaDi3ITNFYknkO2LS/XJ4jVfzT1UI6AZtnM+1u8vq8zzR
	7qfBm4qRzS2bn9AM/N7G1fqP382kHbTAhvw7nZTaMDIjlMEKH6xyQpONfJkeDtAUnt6sMLmTGpD
	yc/N1zfO0e53tfHaodJ86iB60s9rNLZ7dOios7WqburR1Dp6GBLuX0Q9dvDtTZuoBEML0WnYEgf
	InDPa6ZSXpoHlzzu6sGhFM/RGO/H3i/J1vAuXTlV/IHwEasq9GzT3MKT2Fvg59XCnqnHFEYOY2d
	9nwkmShyueidpuOGoMGIrS9uszTQvM+dh9hwExHMMIzEcDmRg49ZyJozBrXdrLFQT4Vw9HV3Wof
	athyd5u4/rORMVyfJGoRP9XtN7dP/HRNduCz5tfGnhZCdltG7Q7j3c61LVIyWNIsi3lWatd16dA
	TLRWWxVhs7Kju2eeG1XXmP9jbDCifUaONuUqSzJW2Mt4ej3yGLv9JwZNx47+qOGFT9t459wYMWq
	L/JWK6BmxIMJdfp5rF4ryhskiJYo1B/7YNdAz4jq8/cxbQ6ggepdK/HFGMHIxlWyhNpD198dQpq
	pIsqQDVzwXxCYsW2CAdlebj8P9FvV7brxGWoNNYkqNBsjmdxr+U=
X-Received: by 2002:a5d:64ed:0:b0:491:fd47:5e02 with SMTP id ffacd0b85a97d-4a638eb6b36mr12401561f8f.22.1795098504640;
        Thu, 19 Nov 2026 06:28:24 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab5539ab89sm116115f8f.40.2026.11.19.06.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:28:24 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Paul Chaignon <paul@isovalent.com>,
	Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>
Subject: [PATCH bpf-next 5/8] selftests/bpf: Delete assign_reuse namespace when opening it fails
Date: Thu, 19 Nov 2026 16:22:27 +0200
Message-ID: <20261119142231.2612515-6-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119142231.2612515-1-razor@blackwall.org>
References: <20261119142231.2612515-1-razor@blackwall.org>
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

Delete the newly created test namespace when open_netns() fails,
instead of returning before cleanup.

Fixes: 22408d58a42c ("selftests/bpf: Test that SO_REUSEPORT can be used with sk_assign helper")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>
CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC: Martin KaFai Lau <martin.lau@linux.dev>
CC: Song Liu <song@kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Emil Tsalapatis <emil@etsalapatis.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>
CC: Paul Chaignon <paul@isovalent.com>
CC: Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>

 tools/testing/selftests/bpf/prog_tests/assign_reuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
index 989ee4d9785b..23ed1290957b 100644
--- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
+++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
@@ -180,7 +180,7 @@ void test_assign_reuse(void)
 
 	tok = open_netns(NS_TEST);
 	if (!ASSERT_OK_PTR(tok, "netns token"))
-		return;
+		goto cleanup;
 
 	if (test__start_subtest("tcpv4"))
 		run_assign_reuse(AF_INET, SOCK_STREAM, "127.0.0.1", PORT);
-- 
2.47.3

