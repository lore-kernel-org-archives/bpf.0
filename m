Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207374;
	b=Lls3eDdTqLk0iocQNxczZABNP2Ton5JcCALkQr+neC/zwj0Mdva9d4cCFvkGuu5KJBPa
	 217DMxFJsEdzkIE+AHqGwTKfp0TTlgARVOa98pDbAo0JooMTF7gLOMxuVkD/jJwcGVGAD
	 QPRAKiFcHXxSv8P5Mcvqpjfir3joklGq6hDrmO2KL6R9ecq91T0cPwQGL3AxzUHPBkcnt
	 hjHMnXu0L1+C6Lbo5b5hJISfInCqC8AJajGDhIbyc/fsr0HpOdOAKe0CvZEFdiYDvhMU7
	 +dgMOEo/cijzIdXF+wwe24YyZypTaXZemt6e2M7oZg73vxvJ0NKvLoSc4b9xFqeyN8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207374;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=tokKV+ZbU+lf/1B8MUnFvi6VmCUJYKTRqvgFuF70WpQ=;
	b=HSYZFf0J+KWMW/8yv81k7acNjxw9otJe0B1qladvyTzdBRro1eAf8Z9LNBpuz6eahLl3
	 t6OsFQFFR6smeO4ltOeC9S8aYlbqufjwEoMt4Ax4GdzCb16imB3qlYbcXdR4YmB1i40Jn
	 BFq5IZSBUtugeHqm9s0XaxF3Yj85j+xtI9zOv0rH4/Cw4B918dhL6SymEXdQmghPeIs19
	 jPJ5OTREGlOIIgjS3Md3Gk3hsXCKohRPPtSfcgicblR2x8bh9yTNxZS+STYnYJ/jVJ5lk
	 apYKkTtAlT6WxRsivJ0+4Q356rsWNA6s9ywE8G2OxY6LvO0+EnGH/m/dmpDp4yoUbwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF8606DB52
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FAF8606DB52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-94961b68685so115097085a.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207373; x=1795812173;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tokKV+ZbU+lf/1B8MUnFvi6VmCUJYKTRqvgFuF70WpQ=;
        b=PA5arB0z///PiUxFbqtH7ThHikk96738sQxz8Lk/KJ9mgjhQErs6vHFxw3Wp8kDFLh
         yiFQ37FkN8hnPJFY/aWsVqiVaQK+kcqxVHgyyTYzSAmp2ICscepbvE2rDnjOfTeVtA3d
         hAp991Hdms/hd12pfy5oMwoQDGxFsrZQ3dB8Cm+mrBn3pGA32imWOegGaXv9U/JBv16Z
         dj+pbLU2ZAJmqTh9yxCsyxxg7RHENsJquLsmZ9b4psx4sYQAQXXpQscn+AmrR85U4aBv
         pT2/9bhvYezhF3V/rrGt304+1910fMAWfJvP9vfs2Ga5qeixydhmnEBt3w+KPuBSMxpO
         uOcQ==
X-Forwarded-Encrypted: i=1; AL+hErGi/Mnyz+EhKQZm2rtmaOdj3nz6FymDzU+2eSSIPPg/AJ6PVQJ0CpJfnkIibF68DodrHQk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wz+Li0HbarkyIQgvuwzB2g1Gp/+I9Be+D2Q/IIzbooijhX2Ms
	orILBV6ISguPPZnkRjd7TDalxkBKU/JNGfDUsaS5NaUkCXgbs3OY7ACN
X-Gm-Gg: AYBFou1qZ9wJ1Qm86kk5kFBgbLkjEwxQq+sh4+D/ZHlKdG49mbIPFYiXISz3adWioD7
	g2wTkH/oFMbhnJJyLaVc9bJfIpIlGp0kP3POeDxr1JR4Ca0vwotzEMEAZtFpNX/amwQgi/ALa55
	3HSKw9Czk5tGeUyxH+qzjdFKMiCHdnC3J6dPJe0Q6OZJIUuTgyvfGb+13nbcFoK16QqVGCUaHGt
	oo3nWw8KsuGcJp8kS7ef1RdcWQa7FC+LBpoBVVSs4D431YvkEw4alz63hldFoCJ9xaWsarqiHWg
	y9PdyvjbSQKHNhCtvcct7ag4JIOK1MHMVEdBihkYHgZeJznitibK1ktX/fVpsCG4sYFUtfa2IrM
	2NxPeVZxE71WDZtGe0E+Rkr/jVha+bcmIt7hF/Qm81yYHmVnUIgBcVhm48AeFy8V152D9XyzZLJ
	LjepXV6LyqWpjqqRrdtysnt0NUBMw8YgPizeMaIrABf4Ils6SOGAkfo/N6e2UEp/6OPq4W/hOZG
	TVqbOuiuZChTDO1rhN7e+idO6d0NhWIw4NutzwrAf7XWMa0LutfTf/jzlSwrDPM0tTtuEx/0Ey7
	wEG8G3mNWqXEW3mGKif7ngO4DIekSIkTixiMOtXuF9493AU8vl5wal4o68HRsjq3afj+6FnpfTD
	yWsG9PqRvK2zuPXHCH4InSM58XZNSnJoj/eTwRR5r3I5/lb6c6fWL
X-Received: by 2002:a05:620a:f11:b0:93e:5016:e3a6 with SMTP id af79cd13be357-949ba9c6e0bmr795897085a.26.1795207372569;
        Fri, 20 Nov 2026 12:42:52 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb424fa6sm270598785a.40.2026.11.20.12.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:52 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>,
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>,
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf v2 8/8] libbpf: ringbuf: Prevent missed wakeups
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711456.18576.9562508567420854149@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <be221942819c7654f054b53907fe9ff2e9526f79.camel@gmail.com>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-8-33fde039ddf3@kernel.org> <be221942819c7654f054b53907fe9ff2e9526f79.camel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Please move the test to a separate commit, I'll review it a bit later.

Done in v3.
