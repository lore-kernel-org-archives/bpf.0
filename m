Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207377;
	b=Iusv+xMbazUtKWIsNw+WodxMakt2piArDio0mu5S6EBD8hPoOFqGfNUT00+EFhRn07mn
	 Ep3roaTK4ZkMFDRTz94ugix2ie7iOEwayWKqBptL1LyocEPNjwdj8VGGIyYsNWLYeL/sS
	 3caONjpocoWSDb52Uv9NWQ5oDS+lb+ayjunjp8Nc4xfhhcQIJYecSTbXv8nGzrSTOdsQY
	 ki5/1Wh4ZdN4PLfRHt2qvxwEuxW6Z1//Cr7Sh96JEDJf3okOGwfg2uwowHmx5W1Dy62m2
	 4HrWp4fbpcs61cl8xnN3IgxAbN/kane2OUdvGJ2u7Jhtl3u3+P+I87iETa3mBpqxI9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207377;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=4GH1ahEms1dqA45xIo5IOe2rBwRqoWw8ywFNljYwSWo=;
	b=j+x3K8J5ZmYvA5MHVj7HTWOxk1GU7DmDKTL0Z0RVNs0Wk6Ncb/baBLgBASWeaGdhYqnP
	 Wxb2/qZ492LfbwodibFyhhNxpmwj7N4x2Yjd94p+OYyVfR66sKHsnFjsP5kXjjSilDWxl
	 4a3nTPuukR++a3f0xx4itIRxDZ4PhY9t0hw44wYQ95cpoS8EreBHqNaVlFzyZ3ivFNgG5
	 BS2Ue7m2KipFYF0+4IF21Zs+GxFzbh4c4XCIKvg6jr0X6e8ee9f8LygWR6e6TpMlkbvpY
	 HwZqx6YAqiVhSteSmHylIz6Rel+EggCq/DbWhSRHNQNmj2w5Oj1NDxSpU2NFCAIREPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBF7606EEEF
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CBF7606EEEF
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9495c633eb5so77385385a.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207375; x=1795812175;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GH1ahEms1dqA45xIo5IOe2rBwRqoWw8ywFNljYwSWo=;
        b=PVzPuhnu7fIaThDVtmy4ZnlTj4vVcmUpoiECubdHK5DbRHlSd2eCLcQEd5GXgfweDM
         NUZWtT7fpDuRcKzg1t/jHczvhatnee9GhLHW83TtsYQ12cx8qB3vWfpzFQqjLDcSylIq
         cWoHaljfj/GRjHZEqbgWwjZ2MMtGoLE077D50YdQzMKiSANcukJq60Yt8rbm+DV13sJ2
         urhFHSqnVJihT98O81t2EYbwpGnlqdq+WelH26EJZsWANm5qM7QtYSxPAJi3uDxBCMWy
         39J24vq80KXjqgG3VOM5FYenhG7A0bHrFgaQjAXVB/h7ssYRYiytDoaTgAHfF2ATSRzK
         bc1A==
X-Forwarded-Encrypted: i=1; AL+hErGJBRE+RYVVPqXnz5/ssFT5i1glSH+2I+WAMs+sCg+F9OiLuYte2IknIOCt3PtL/+4Xpig=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0Q66ZgYfjbQxC00qyywDmRrzjJucob1SFesupM7uyHOKDFvXl
	9/k/chhCqPpjfV/ehXx48441mRSAaNter2AqdSEV/v1qobY+y39I511W
X-Gm-Gg: AYBFou3CLuQBhdfp4GBKthqY0wRQO6hjWLSEg4WebUUTGx1HJOaITAvOKIhAeaFkpzl
	ONQvmcRzU/GmWedNc9x4xPah/HpoK/Hs5+uoJ/QqH/WcVsa7QPm3xAH6mxX3tATEcWFup1X9hJ6
	8goxcSzN73pBnPtePXJD976X/+HWQSbl/QLpvEwonwHgGULbeTqEd7j9+FZouwd1ExNWepIFOUq
	/R0SJzQW4B9qtlvVHyq/MGoaUiIQbncweNPK1H6NfMU10mS+2AnAhO+ONIAyltiQbvdkMIOcNxe
	GyZVkzdRUndikmYQI1IhFtDbUBsUSc5c60j8TXl9SoFgNRa5fDnM6vb1YfM7NO7JZARy2PoT2Ta
	E0SLv3ESawV3oWPXcKrR8QLKKauDtjRpoEjqm2lY9e1IGBB9deqj5k9dBMxGy66A/pgWx4gUwCn
	yVgJ8oz7za/RxR6cPkmaYyx885stxpRgbXedjAuXcezP6gOu03U/MkOqSgCWWlBAINJf60Agz8d
	l+uoATi/vPch6xHrzdvlPkhq3xWmqNGOkZ0O4EpZIZc+kjQOCqVwSHg0tD4JhZR/N6taDiHfkRU
	n4QAQCylUcOpbF1qgEUoKslJOXMAry2o+kiV96/V1akgMRTxBIFArdbR/Rj9JP9qWkGN7mvbU1O
	jqhOl85nYhUIWhRIvNqZRt9ma3On078Zlbujp8cBmx2ma6dSYEPUx
X-Received: by 2002:a05:620a:4453:b0:949:7502:695 with SMTP id af79cd13be357-949bab651bdmr693737185a.68.1795207375597;
        Fri, 20 Nov 2026 12:42:55 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb0354a9sm288439785a.5.2026.11.20.12.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:55 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Andrea Righi <arighi@nvidia.com>, Xu Kuohai <xukuohai@huawei.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, David Vernet <void@manifault.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Andrew Werner <awerner32@gmail.com>, Zvi Effron <zeffron@riotgames.com>,
 Andrii Nakryiko <andriin@fb.com>, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v2 2/8] libbpf: ringbuf: Prevent NULL callback crash
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711461.18576.2987868815331228057@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAADnVQLuNSE5AM6Cqzs4yDFrhTyD=j-y5dfya3dLwk3si9v26w@mail.gmail.com>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-2-33fde039ddf3@kernel.org> <ajVKM9tJskwg9OFa@krava> <130931685c8b2064325fc65a856ecd810c8a6b5c.camel@gmail.com> <CAADnVQLuNSE5AM6Cqzs4yDFrhTyD=j-y5dfya3dLwk3si9v26w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> If there is a need to check
> callback nullness it's better to discuss altogether.

Combined in v3, including the iterator API and its NULL-callback tests.
