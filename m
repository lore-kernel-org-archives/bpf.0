Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207367;
	b=HMQkI35pPSIVQu3YOtPges5Qtn59R3PT0bpKL4khO5z5552zd5tsoze3B7lMu9sYlrlM
	 mIKeqBl/zkLaIm3RdkdtEBMhHzC69Ni2OZB7uuXTiNRMg1pC+mk3gaMBzt5P8Yxk4icEE
	 EDL0gUAGaRm3UdsPp6tYo8T2edRDQRidHPUcp/rywnrFKiQy8Fc7XSAr4xQqJgv1eEVoU
	 gMewV/nEDxoTGEn09GW/9ajJp8C22wWpAu8ThAgmBj6L/EA2Vpo/TyezRWacq1pAo+YEo
	 0r+9n1oj8huzXZsQF/dsdlE+bJKw5rA1AwM261r0PSgj/J/TvHgHoFD8D4Ji6DUUPMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207367;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=pCml9rYMYB7fB2Zy79l25CZ2iG6ygatLQQpuCxucxW8=;
	b=J3KZ1ZNdzjjk8mxgVYoWqHS8VrkP9Qmp5swLvczY/n5wxHCAR0A84RySlXFjaNmGc8SG
	 RIh2wXmDufscU5UFG3XJZWGctOF3sc3Lpt0yMbTHtvnHOh5JZzmgz9QRY2mOP0Bvg3big
	 dKwPJY984dX1eZmFB6EmkIT5H6jhC1SCBkEjcDxJevCysl0Kv8J8RfXLVrksxpwUUrMuX
	 M9/RBVSpeailjyNjAWzh5MHT5MuMIg4ZO79SBF0tj0marg3UU0aFE9L1PsIM6QGN2sA15
	 p679CCRzBdnKKIg2dTLV24fZs/jR3TFAvV738MMsx8/D8gojaiwOPccJzN45sXH329g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3FE60A5BFC
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC3FE60A5BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9496400270fso119541185a.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207365; x=1795812165;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pCml9rYMYB7fB2Zy79l25CZ2iG6ygatLQQpuCxucxW8=;
        b=cSD++5jcghr+Hudt4V061dclIv0nRliz2Rym8kfdb9kpWizuzru2w7GW4saIw1ltaw
         jCXMWMXvpIfmolw8a9Id5unfoVVjoQHef549AFO4FWY0y12U0AvO3XarmZJjztyJgjQE
         QtvV3CipBcjkW63QcvjG1yCpoJAZ5R8quY2egvNEU/dVNxffQm2Xh5hft9ID8yYXIulw
         JHaqkE9emb9TkTEO603FNe741z6uvUe8mCMLF68dkJcg/ShT2xK/fwGQ9L2M9fRhJgTD
         zNQi/+/eAbskvJ0XowitkF+3iUAgcPLJdBldTbjY7USWVKjFnrui5JwHhnSiTuwp2EEU
         aDcA==
X-Forwarded-Encrypted: i=1; AL+hErE8PngVdI50Hwc4ZUVvsH6HpNt7/i51uTpJ1xzr5B+MJ+JyhXGE417l3/0Ie7cT+4Ke6ro=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XAwcyvAlplf08iYk29wjelje80NyIQQB9YUSgUDMRi393LqHz
	1Uc1alYrLacyXuwuCfY0qLr57FAfPDwI3lJAzWjlZw6GLvfjffT2fP43
X-Gm-Gg: AYBFou3IxYUzKSQ1N49ia5ktQE1bV9Zknk6bg+VDoY1+fBZI85WO2R8jqVLgdUFMZRS
	qSGTw+VbqrP9EfdFC85nWTj3uJO5MmLL7UXOi7I2qfM/xGU+TgZy4OyUG8QGOJJWHIXP3TL9bqH
	G69mPO6B2VU26nlS2VPldqw0r7WKAhdNg5gd1TyyBJuLNjZ4G7cDRYUE44mFdpBB8Z6nR3z7y5f
	g55Z7pV/BDwQo1/TGzbzbaPGY3aiQ+2KPqQvG/kYjWkdy2yYChtkBKaHMlGTXnMc7VtvtSr5qcD
	JhL37WdeWE6fopF39aat9zG2l82GYDn1U2e82SjqA63hdH/Xilhnumhw5TmQWhkUHRia8IOUgmV
	7+r+guDcFlt3j0gRfDEAdZScGCLl+Osr3SFBg0aet2Zth4CXFRyVzpJqcwH9gT/+pMxaAa1e4dG
	ywQgQcvEZSl6oUr193YzDIRqfm8PUve0Zelxg470J1CZAgTkq+Q2MYcGG5dAA4FxG9vjMgSD1Os
	WyE2urV8mdxrIpzZg1ATXJVgSdK2dZ5T7HImhebyEOZQ3DejAGNClDuFQsUZUFprtzWBxXGDncR
	7eLMrHkqeJhmG9wleZJG2S7hzJ2P8X/SX8ESW7IOF+DNwDMDUkwIYUH/6dYdlZWKTE+wB/BDIVc
	VKELLkAa+k9jr/KtRfc+Jv2YqYxtJHstjM4CgkME1l9bGhHkjZHrf
X-Received: by 2002:a05:620a:2844:b0:943:b019:f011 with SMTP id af79cd13be357-949ba9b3e47mr780500985a.28.1795207364641;
        Fri, 20 Nov 2026 12:42:44 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb0319fcsm277058185a.4.2026.11.20.12.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:44 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
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
Message-ID: <179519711447.18576.11461006206277762922@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <130931685c8b2064325fc65a856ecd810c8a6b5c.camel@gmail.com>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-2-33fde039ddf3@kernel.org> <ajVKM9tJskwg9OFa@krava> <130931685c8b2064325fc65a856ecd810c8a6b5c.camel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> ring_buffer__new() and ring_buffer__add() when callback is NULL or
> when overwrite map flag is present.

Iterator-only rings need construction with a NULL callback; v3 includes
that API. It preserves the merged consumption-time checks.

Overwrite registration remains unchanged. Both callback consumption and
the public iterator reject overwrite maps.
