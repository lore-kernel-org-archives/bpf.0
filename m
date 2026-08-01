Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880517B505
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785589421; cv=none; b=r1grOpJWJZUWotk7QYOFT7Bd8ULjMpyTSGh19N/4krwMhHAIHtuGWqWBFcGUSm118Hu9qmIuNKkCjV4GUxlMWcAdczKW+RdByJHisdZ0DRWzpa235G3pLJfnZT7ukus0aXidYPi30JFIQZlMRBFSlpcFC1W6jMAHSFSYQInhXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785589421; c=relaxed/simple;
	bh=JFwfi9dbKX/euBP0yZ2Dolwafn3XksN2JHdb7UuHaHU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l6z4Nq+vVKvIk0O0MijVb/JLNuU+PEeHjSXDwlFR+Pam/bUsQJpZekJg8hmwuUN9HWMkgKTZn9B6hOGFu10gXmvH7Upgj48ojh0ncNdKPmKSWQqF0Sen330ugW5gbIF/tcf+TKwIx1V5mOzIIjHr4Xl6giYBA77oBzbzMqEy7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net; spf=pass smtp.mailfrom=bobrowski.net; dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b=Opj2JAMN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b="Opj2JAMN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf52d15d88so15684745ad.2
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1785589419; x=1786194219; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOnBwUwt1o/UpHuKkwuSQpQ1MWvUSQDoDNOR96t9v6I=;
        b=Opj2JAMNEi47F4+jzyoFZCWLhMil/nQ82voxTHrxh6HKhmGL+p59HPOl5MVlxHMf3T
         sIKDkTD3VmelrUGnl7sHDSWrW3asGEoO97NTCItgKGjcMsi6rUPrTjNIhNpwanl4IRE6
         OF1qj6MpmS4JJkzYlz9e4NDWIajH/xWRuK4tvns5Ujmj7rAobk1YMArjtsaUnQSiKYhH
         g/MEhcWRtyXfcPJerMEGmXw+j3o1uiYbiTvHxpKTKrsq3vn/3S0N2b2Avp+JG42Uh+/p
         KD3iRsmee9vzqiVUymCVq2l0iH/uhIoLOMbUw89IOkYZeC11duk2F2Ug1i4EXy4pLjuz
         TEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785589419; x=1786194219;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uOnBwUwt1o/UpHuKkwuSQpQ1MWvUSQDoDNOR96t9v6I=;
        b=XhptrCue8p2WvEJwso9A1k9EFBe1h4aQ8QQBwxEBhULUS5CT1KBmwcuq9J/nb5GiGg
         OZJAwIFpJ6eL59v+bdfSgIJlNLg18nn8ROAs5BZq9Y8QqA7Hev9jNf5H84ClHZEIwblD
         4yPFhIljgJLIkueaQy+u2MSkVzz5TW12tFqgdeytR0Hd7bq4jOkHUlQ8ONWTNMUXG23I
         tQL4RTO5Tg3OSmSNwXEL64D9/e/OHBL+N89roJurV1eh/OEZQJPWRNxYeC8crZeiGyHa
         THmRCjuXGMKC+WH9/gzdDrgDGVsvqOKKf8BqjuEBtOGWHDp4/iI51FMxk5Rau46hVPhW
         za/w==
X-Gm-Message-State: AOJu0YzuN2d3E54bVC7MWlPkK6oZPgqXfWZf/5frYJP2EYCqJDVsBL3F
	zQzysr/WjrLW8R4EHkNsgusS1TXqzCGyYhzAhTFCmW9cbe70D3xEIMEFxeAplDqdjD8qwOavN16
	1jt+X5+C+
X-Gm-Gg: AR+sD137CQm8vNbhSE10nhlbXk6BQrolSq5KjW8WHWPgUtTZDYyxZ/VQdxE08xhvojz
	B0HtNsUKBg1SBTXtlf74AxpHTTQHm/v2NvAxt1gO56TCbwnxUgAdtho0pwqzCeyA6Z4QHY7fS1P
	ZjgkEwGxvLbHiFJoMBA7H0CsOuefr3vXqpKBHx+/qAKUuYr3/qudGBPKaseyEG6Rjhl80v9xwx+
	/hFUPB7f63/25j2gdYL7D9CVDWdAFnnZ4wo1W9N8HcMIFbF+wYhvj5i1djDrhHeIXuJzyIm7eRl
	3a2KijSeTDXEHKg5oxLfMyCSs2F69TutqIuQ92WScsaWEFohlruYyzMLc5bDF8jHdt/ELfALX/y
	46OlGKBzhib8hWPVzdBwjfraWaX8wmIiGM+gycJFsqBU9UMEJZYLOdWsinwJ5tzrcb2nqiB8jt9
	tZL6Sqm/RCjV0ZXy04q2hnMxzKa4U8c9hih2S9cVjd3uqH+IYBXVKPDAlSYckmTDLVWhd5fsQ9y
	zYmk6XUv8R1kEQnhp/X2n+Pw9hdnMtXnKsVrNbFznQ=
X-Received: by 2002:a17:90b:3b83:b0:381:973e:fa08 with SMTP id 98e67ed59e1d1-38fbc48ec1cmr3094656a91.18.1785589418781;
        Sat, 01 Aug 2026 06:03:38 -0700 (PDT)
Received: from lima-development (202.128.115.4.nsw.leaptel.network. [202.128.115.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e47dsm26153787eec.3.2026.08.01.06.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 06:03:38 -0700 (PDT)
Date: Sat, 1 Aug 2026 23:03:30 +1000
From: Matt Bobrowski <matt@bobrowski.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, kpsingh@kernel.org
Subject: [PATCH] bpf: update BPF LSM maintainer list
Message-ID: <am3uorMW7_UWA5An@lima-development>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've recently left Google, so my mattbobrowski@google.com mail address
is now inactive. Update the BPF LSM maintainer entry with a mail
address that I do still have access to and use.

Note that I lost access to my mattbobrowski@google.com mail address
before being able to make this MAINTAINER entry change from it.

Signed-off-by: Matt Bobrowski <matt@bobrowski.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32ca23e58f2b..e46c57f8493c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5030,7 +5030,7 @@ F:	kernel/bpf/ringbuf.c
 
 BPF [SECURITY & LSM] (Security Audit and Enforcement using BPF)
 M:	KP Singh <kpsingh@kernel.org>
-M:	Matt Bobrowski <mattbobrowski@google.com>
+M:	Matt Bobrowski <matt@bobrowski.net>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	Documentation/bpf/prog_lsm.rst
-- 
2.47.3

