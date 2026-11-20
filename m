Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207362;
	b=EgVvmo609fhelSnFcUZ3JI/Z3Q1nANhlg6DcBRYXpXEARhL9fgAgKnXcHjnrtHQ2v/Rp
	 FHIZ4MImcYfY3uE+pNjaw2LjoF0CL0vH2xcQwS7G0wdcVt0cgUBW7Dx7XsUxLzun50ywd
	 DWlr3YTN3bZEVqvq1HOTOk0pAKXZ/V4yKjf3uMfFBCdFBZxE3M1qqj+IPJMT9S5Z8Z2OC
	 +jvS5cmDj88H5cHtlWUEDIVk4cpCx2QhxaDAshdiK7JhSW9z50HVm8sx3K8O/DdV/i9Xi
	 9OgyEOIyctCDPCHewzYLRsVo5PWBQZOEXurNkFsLVN8axiyd+QSsSbmcpSTdFmIXNXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207362;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=zvhZlU0ddPN9o2nM/nrK5XTVxzJuCMmPH0NhVRQSvdI=;
	b=noCjZSe7movAMdEd8UP+pkrZPMHc4o+7ftygH3gFld4C9lPWSCOfmkJwtSmw+EzjT8vU
	 c+MkZlISloeN0VEyy8cHRzNMMitVXibiLb2+yyZ18bnLL8kVO+qtlGfryhVmVIVKFAZ58
	 x2q/iTNxtw6B/Fm6jg73VSfNwbOsIKkLFrxFi9/aIPlVy87AV/hMGN4xgvBo5TTsLjoQ8
	 FSlFTLnamuFwxBfOlRvUQyLa2uEAro9PUYmv3Gfh7XqNrq3bjWt4SYhA7sXrM5pQx9gRq
	 DpVFuXsjQoNiR7jJsnOBGRHchPQO7yEdLDHEU+fk1VM2gP3xIgAKOtV/Iqm3l9mZB0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E754606A6CC
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E754606A6CC
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-55c5b6584ceso10065051cf.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207360; x=1795812160;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvhZlU0ddPN9o2nM/nrK5XTVxzJuCMmPH0NhVRQSvdI=;
        b=tO4LaHycYSUq/HcvtkzSwMGa88sPAvSkblZcF8OUHmQ9MHTVQQoqCoKqsWnlFBdYRp
         EQPg7/xoVm1cSB1Lz40/yWBUnVkoaqksevi8B9Ca4UZ8+3y3jQrm2N13sEdMATmRO0DQ
         vvGv5rvIuOexCuN6LJsq2UnqiNlxxDg3ANeIOCRIjOyaJo4tx4XqTY0iajIvNHoQdtN4
         kKXw2EA2Q/TVRE30peMaAt+WCPYaIZlWgCVL1LThIRVWyFwS5QjfOEK/sGza68Vlvx23
         QvVvLKJ5xmRC0Lnwj+rcDgCiqd6BnBikr4Nr/C2CC9Jb+NQqeihLVee1wMPu3Sa0AaOZ
         SCpw==
X-Forwarded-Encrypted: i=1; AL+hErGhiK2hu19MpTOTa/aEvANqn6U8y639D4aGvGGldyApCZa8t3FDzSBv1oSKuL9jtJBkqls=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hzzk0yf+FcSXAwQkWLYSHpg7lcpoCcihtLdDKmOYBDlQ+OBj4
	foNWUt7qsu7Wtwm6XC5CLlmMK8rovh0JVcVT0YvV14wD1uLVsQfr5YdF
X-Gm-Gg: AYBFou0bhiGqUsJH5J2ogQq8VXaAQVhVMU0voDWHMh2mBgB6W8hwaFeJ4gdCD+O03xw
	J/s6S2KDut+aUu39aiUO66y7wbYNnv7rbcWmPigOUWjvHnR80cao10u+/UYCmonKhIn4LXg/Ety
	FhyJL+A9/g1NCY2uuJvKMp+nzpCorz/6JskJ1P0WuSv/6PM7MRzfqtRzx9T7WD6qOh37bgoOYEZ
	U66fXQhhBeRGsEhPWhX+h1L5kaSGpNebNP4t1X6ApgKClBrt2h5k4WVXXsHJZGmLsjUUwFvQF+m
	3BhrUAFzQNrEjk327F3LKkqklmcXChvc9wZ0fA1cBagwmDdfHKiUa3xNjMX8xobB+dLbrMJV/hp
	lYqJuIP3ZjgmDm4Uhx0cak2wiIXL66gJsMsUQI2ehNodQVYIU9wte+ohN3nvV6uJUMxJxx2GBZ9
	YeTE+fmqg7Q3FBk6eOq+irAw/uRM99+yVRUs1gKsxBTBMWhbdzXImf7wVbZWKbh9HnlQdjwXIHb
	SI5H0iKbFo6/i0DkLCpv5kttobR8vDmoZVlAUMu0ukMciYMPhkMkAduPzT4M91V0hC30ycjXcF+
	iqJ4drvPCFTH48YB+3P5NQZc5XMm7mJfBLZt9Cvv6+XXgRZygyLg0qJMNGBogkO83q1oDfluKrs
	TwdbbIzU+MdfaZLtd5rk37+Grpz3hV2uCM1a3PFUwgo9raApvukBg
X-Received: by 2002:ac8:6f07:0:b0:55c:5ebd:8824 with SMTP id d75a77b69052e-55d76a6b9b2mr73460561cf.71.1795207360201;
        Fri, 20 Nov 2026 12:42:40 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788116c9sm32657731cf.4.2026.11.20.12.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:39 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Andrea Righi <arighi@nvidia.com>, Xu Kuohai <xukuohai@huawei.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v2 2/8] libbpf: ringbuf: Prevent NULL callback crash
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711442.18576.14389384506684582728@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <ajVKM9tJskwg9OFa@krava>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-2-33fde039ddf3@kernel.org> <ajVKM9tJskwg9OFa@krava>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> it'd be easier to review/suggest the solution with more details on that

V3 includes the caller-owned iterator and tests using NULL callbacks.
It preserves the validation merged as c0628a0659b6.
