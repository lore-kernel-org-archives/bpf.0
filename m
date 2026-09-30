Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D740531B101
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759391; cv=none; b=Z3hOdPaAxoK4rOBDeJ59IUJG89n78rVyb2fKjbzRq3cfYNY4eMBpI9RkMZRR8Brf0U65ljwZsKHNIwc3RjfokCYnC4APL474T3RiAtRcsGz2ppvwUH6jfnV0R9ufWPLvrNQdknRvM5SSX+NGtfspp1YQ9XCfBhKmlzoHGXGRWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759391; c=relaxed/simple;
	bh=7XZaUPvHQNr+4NrH/lnoEkZpSe8RXWKZgME0Ghq9tI0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=ZgkG0XrWaw/6vvix8QipC73uYRWMXMk5eeGNQ6DZyUNXlnHyifwfbGTapgvv2kkA0TGOPMIR6/NbPjujcV02HKXwoxpEL8zqqguGM4nR0CQJ1BU8S98++z3851kdKEhcUTw+4jEARe64c4Hbq+lw4I3T/cKoXeMKLnaZOZtVjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIAXjTdx; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIAXjTdx"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso2889794a91.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790759389; x=1791364189; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7XZaUPvHQNr+4NrH/lnoEkZpSe8RXWKZgME0Ghq9tI0=;
        b=lIAXjTdxsXRtp39gXIV5KzBrr2u9oA1dQTimJSI5ch4Ci2WNG+XFthOq2ReC5Yre2P
         olnXd49prUGRAhwEDaf/dyczoly2JEDKl6S5L/TdiDOo8u+IwOXNdrCcwgYj4jVc41xj
         PYBq3oNCzbkCn0iisIfuyxN6FaGQ5iqP6Fi7UlhJnQv+/gzoe/T9MLCspYrRsi4JNlg3
         52Oy9a2hdZFva6pj3OLWM+obyRfEEp6yNRX96bQp8Vu16dcZ8JI7RJuKPIU/0rWnD6Rx
         QyL/2nROV4J7mToV8HeuILOWNGT4w3iGacT5rcZHQk01iUZk84OuZTlwiR+qWStlpUOs
         wgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790759389; x=1791364189;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7XZaUPvHQNr+4NrH/lnoEkZpSe8RXWKZgME0Ghq9tI0=;
        b=JZcuO3zDKSt1PnxGgDU30Gb5qjv60KHJEY+FdHzqHyK2jX7UlLDHXBKPBd8wJlpHS9
         kgbYDLm6x/gU9p8R1K2vHbIQUEmZZqmsL4RJbvFcYCdzOfEmEExeXQJChDsUfuayiybx
         sP2VPq8fCv4Hw/nEgD51tNDGPFu1OerRXQkhR+GFtae2ywoQ6LXQthg8G0LftbSuYz5W
         1nMfLNnkZPH/dWLLzBHkfF5cCnNxzl7IPJDhH53h4oDJVI9bSuwFJXRrfKP53XjtCa5U
         HhF6JcjqV96e0Kx1ZH9SaGXmhRYJLzs1lcsXK9Wmvfgr0GF+ple2f3Gl99k1UmPgFB0P
         m8/A==
X-Forwarded-Encrypted: i=1; AKwUvBymcZ6PDlVC6h8jijbO3pznt5Cp8hCsb4VqibL9xUlsFqG0zTVz7c4od/wQWd+BgYHKWWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHdS4bOXLK3bpg6cPxzKrMmuhng+20NPxwyHRSbU6IcLBmsUCL
	5IQsXeHlf1/FsRXXNGDACNEOoWcnnHOA9FqlduOb4f8k08ElDiQLcMxL
X-Gm-Gg: AYBFou1v4aq0u000JPMJxTjLSv4j5jp740wcXU6GGiTpcO2uBWAswF7XyZ20Uin9qK1
	Cpj4lbwESYuh1ouBs8qYbESNYOLpMrB/Ai/dGmnQCOiobqj6R+BWBYJ1tItgRU8EqomQZ5mLKF1
	S2w0tkDPfyrK30zYeFmGYe+OZyrAK6Cma3LoKumFzfwNSEvJuZ5SRsgrPwmxJa9COlaJQcSMwb8
	NKPdxenH3+orpyptD0xzOSFkkSE7Ve8uLcKVQitbXWZoefdxSoYTDxY74ZekukmmtJwhrW75V9f
	CyD4ifJY5K6y3EU5ppdtjdQTgoMKni4JSYRsBX4twugygVa2ZPeWmN3Q3b2lb5WSdwWGRyE5hip
	8N6p/Ru6hqdhF0sp5pIExd3+ou3U+XwVL9MK1HJGFUefk/2IT+CfHgOXQBudroxRUop7Pv+rEox
	GQcc4Yg7aL2LoU+88bKO12e9s2ltYKZ5eQqWxAOXsLK2CqTNTAArOwjoT8grnw1AJDFJVxlB+Qt
	jQL6rJKh19ArwTPqUJqkKBYnKww/Qs1lTbb2HYDHjqnFBVKTO7KMqEX/LK/gxSOiA5gDA/Rk8/8
	UXk=
X-Received: by 2002:a17:90b:5450:b0:3a0:9aa4:f9bf with SMTP id 98e67ed59e1d1-3a4d154254bmr713552a91.12.1790759388764;
        Wed, 30 Sep 2026 02:09:48 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cac131c7sm2608929a91.11.2026.09.30.02.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 02:09:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 09:09:48 +0000
Message-Id: <DLSJ81WE2HAS.28FPKEA7RBKAQ@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v6 0/7] Make sleepable arena paths use
 sleepable alloc_pages
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260929183928.4896-1-emil@etsalapatis.com>
References: <20260929183928.4896-1-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 06:39 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> v5 -> v6 (https://lore.kernel.org/bpf/20260928202643.9114-1-emil@etsalapatis.com/)
>
> - Use verifier_bug_if() for diagnostics (bot)

The WARN_ON_ONCE()-s are still there in patch 6.
Sent the wrong branch?

pw-bot: cr
