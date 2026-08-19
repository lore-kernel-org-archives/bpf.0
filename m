Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE037B3FD
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787112436; cv=none; b=WmCE8F2/EP0132EWl3GU+zj2IlW5Ahq9Kbmnj5N+mlhJrCR043CfdoTS7t3gRanHwTNECc4PSoUu4MmdnkimSpXpQVlyDEEwzKgaYw7Xw5alPSTiE4EiXcIRl87UdhBmEm3JiZPs1fz4dT0fAppK6kTbRSh0WATIxQhUh8v8sLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787112436; c=relaxed/simple;
	bh=OaLue05Oo/WlRFNgYwj+AENc6fATkJKTEEra5eECPGs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XruLDwy25kc2t1tDik9ZxyVIQP+7C5qSlDidAs6U0b/oiFgwrFzy11BcugFnc/ixfumGQAlh82O2Jpg6KIxTqykX9swLtCK3VScq1IXsAl3xU1l5Rip5zW/GcQgIgu8P2Dfn0TyLz3GNi2hCer0LEijCA0ZKV8g3t1PQu1Zkuco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qi6BQL/e; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qi6BQL/e"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so660446a91.2
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 21:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787112435; x=1787717235; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OaLue05Oo/WlRFNgYwj+AENc6fATkJKTEEra5eECPGs=;
        b=qi6BQL/epslOOoRCHlIlt4AdPQFzHG2QmL0wKF9+GTgKl0CPweGGBbvuc921jtaLbA
         OBxwVhAbOzJZ39aDQn/wH2BXf8Z25w2WeFswu8BJiMk6SxUGn5HjiKmcWTnDTXpxES82
         wt2uzal27SP+aSzfHSdSmgRH6FPHyXG1NiHzfvgOXPPJsSog8lMjkGk9dtBVqMpMJQKs
         Q/e1BSuyKIwfrZ3w8j+1HQkOtXamjHCoXq4R+UcYmWWrKQxrGB7aiSj0Wc0qJvNiLAIN
         DDgX65JHOJM+UXaHZhzC7GciyJMF/kFek7vEPOFaF17twEGSUSmwZI3wvJDwCZFCqm70
         Kheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787112435; x=1787717235;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OaLue05Oo/WlRFNgYwj+AENc6fATkJKTEEra5eECPGs=;
        b=rZBlEfzNsq9JJfuPYnhP0/k/555n2bPXXvlflRdy2tpISM1gMavKmsChrVRJX7u+8L
         i2TBwLdIKOrLYc1wjpZvOS+/Uw00k4Mto+wu0VRVaUdIrFNS/Y99HMgJkC1O6WkWBLD3
         JwMLWINowOG9iAh6RDkXbYDR0WOSjRMOTNXVrnZTjHxhAkhoJ8aau/Z7tqkpLYODHCFg
         pyc4OT7tYRuYVVioby1tPhpVzYhd7YGo3VRP7D0tVHLAe7tqZKqs9bgQzEbCdzRAkKDb
         cXj1as5P6ghYLLI/ij6DmwhYGK6u57kC30GbK85OpSPk+31m8uXNtTqNyOXN0/FY6f1n
         L07w==
X-Forwarded-Encrypted: i=1; AHgh+RqEwRD4m73Q1W6WVFNBtTv9ie+Gfjq/n3LOqlujHqrdXMQgDH2MvtwwtsHINVE6SFHZs5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvISLHdqyYwN48SuH2EZVGchlLjrmahJiXaPeBZ0zV39UjH5SK
	6lJO463Ceod5cGio5kBtw4i0YjLZIQu9bVnI4w5KaD6vSsMTJJmgcsBZ
X-Gm-Gg: AR+sD10iX2zIrvXCCkTlz2f14/HfE1EkjBwzl0SrKMfH3r171+ArKScyWSZAoeVoX4B
	MigGQTmUsbn7cg500JPzrQPp8kTjWjLDZUcxAOE2XalvbWJuh5Qaz0Ss58iGNyhufR5JiA8SHE5
	TwPpUQQBYaV/wXdn/HmStaDujZMonHeLKbw+/uMVCfj55QjJU/W3THLWe3IwXHKYghWQQlN7hTu
	uz/lFzYC5dDtm9QOnxbvJJbcgQyo4fMqL0FEB4Hbl47fWs0WKHaKZ5Tqz+BdtpB08g8CKyaOs9v
	kFa6VCZt48R+Iy/oAgJ0xU2UARLMgH3lKFOqqJhLUnqqnH9te3HNdZ1pNXBXW9K0gIjIsZLUX7Q
	7SGaMSnIP0IW8/kRJV2FumBwgyjiP1tdS9+sCz8CMQpTgvIMDOH0hMEdthwKcqmntdJRF5FZifW
	bwcfMwhehz61/8c8wYTToeKyNIUwwiT6fTZElQHFJPsiDj9RnORq7tjj6LrJlR/arNyDYbtGsVg
	CypZQgp7FoXKsg5
X-Received: by 2002:a17:90a:d60d:b0:392:6638:2e6a with SMTP id 98e67ed59e1d1-3958146f387mr3217929a91.13.1787112434469;
        Tue, 18 Aug 2026 21:07:14 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f96cb76sm1061851a91.1.2026.08.18.21.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 21:07:14 -0700 (PDT)
Message-ID: <3409369bebc67b512257583556b02104710fcd1c.camel@gmail.com>
Subject: Re: [RFC bpf-next 3/6] bpf: support low-32 subreg scalar linking
 for zero-extending movs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 18 Aug 2026 21:07:11 -0700
In-Reply-To: <20260814231945.3884596-4-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
	 <20260814231945.3884596-4-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 16:19 -0700, Vineet Gupta wrote:

...

> =C2=A0include/linux/bpf_verifier.h | 10 ++++
> =C2=A0kernel/bpf/states.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 23 ++++++++-
> =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 9=
1 ++++++++++++++++++++++++++++++++----
> =C2=A03 files changed, 114 insertions(+), 10 deletions(-)

Also, would be nice to reflect ZEXT flag when printing the register in log.=
c.
