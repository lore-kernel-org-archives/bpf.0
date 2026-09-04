Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A924192F9
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514044; cv=none; b=X7smHZCRBGaADT829Q7K51EaTakql4cuglJWDD3gbOhUHoo8NHfL3xqcK3qThrBZwCOQHe81UfPXlXcMRCAAUbBLeJylzITNlU3Vwsip2b1VLrAJhZXJbU9IupxEtwUeAMI0BqIAbcWrZX0cPgSqZAjBWfoZU3NYoMniv9kYkeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514044; c=relaxed/simple;
	bh=6Jh9YwKMSnQM3tAKjwVqWhn34D0cgvjhP0P8CvPoS7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkENgEHSlrJyq+q4DQbmJlVnnsQAOxlv12nkjSYMewbxXOLgPHLavGvqBJjRj03Lr+Omq5nM0u3r/BlYIeLyA4KOhIEckXRTmocsWFIuXrk0JV7qYctSEWIH1OXjHMlAQ/3C6pgUFp/XIwLi2EKqmvVrYECfF34AYs1if5h9X4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKdey59Q; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKdey59Q"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso579511a91.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 02:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788514042; x=1789118842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Jh9YwKMSnQM3tAKjwVqWhn34D0cgvjhP0P8CvPoS7E=;
        b=fKdey59Qh4FEpmUGSdu5C+eaI1AzPYtvxFxEWVl1Rvc/CB57UD08YGoFmIatSdZWMG
         AB0dStvltuIs9DDHQnjZLPG+/SwhQgHaL82tZFrulKIudL+bxWGCLDlmH2c+kysy9wXm
         4QzbDnQCSUPnbCAtZfg1Eesp5mK6JDljwebqbe9a1ZiXje3tUP1EXAlNZu0EYi51C+59
         mRNUFmuTLXG/rxNcQK9OXD42Z0EOzJ84hzN1FDTezLF7IrM7e8MwKN5ahcBCn4b1rLmp
         Ez1ApjObu34rw2u8cplIpcggSjlcRuwi5sT1YPJp3kYucYwKUp/GPuqFnb6vqVQdGtcO
         1xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514042; x=1789118842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Jh9YwKMSnQM3tAKjwVqWhn34D0cgvjhP0P8CvPoS7E=;
        b=a+S9xYRP0C0VkF2lFTz75tSpqZPA+Rv5bwRnxM9/K14lKWSk6R4fA+0OMxzQqrikZZ
         sY6Nc+JNFhdjCjBS3Dmp0k6vsLYv1PLGBpnga/l3SDQV9YyrRE5KV2Vfgks6Adw3eYqD
         qaQAKHYlR22AYTGwc+3Vn4cmlFB1TAVXePtjAvRSmMhsH4q9bJzRRFspudtET5KKDAdl
         YF6bNUxIKvCU4V8iTI2Cy415B47nnRiCzcgzNvUYB0jke9e49G3SqaVbFj4riT8qzPGv
         ykU7ln2Rf9U2dB9hC+vGp70Fjb+0ym9GL9kxxcaNZCoVVrlXDtjq6sRUhfGAOWXyr6ad
         vrig==
X-Gm-Message-State: AFuF++mkI5OoP3c2ebTMJXgOcZ4HfD0eDNYjHBbX/qxtSYMJ1hYnx5Rj
	xabYsJISbofqM/yoncLOzvFzsVoTuk+btd95uItiXr4fIY6XWadLln8=
X-Gm-Gg: AYBFou0KcTAcmFspRhR1oUMtPQ/NzA6Imxd7GC4pVn9h4pgfE1Wg7skOQBXs7hoxYbs
	JHXeS/bPqmBE5LDZk9xC6I6tKa3cX06ZOzpeceObE6IB/XU9WNkyqGuKTeZD41UfGErX2PyjcHM
	52Hm1TgvIwjPmS1HNake9xEA/zCnY9slu+hokEprkXB85FP4U+UZn7sGeWanL+UXTouGZd2LHFA
	yqVVmXb3iwVaKe5jG0I6YY/4yTQIxHkjbLUMa6qSdbX3jjGiEF0TxgOuOXbP9yGq3F6c5LBcEjc
	VsXt8znFFBgMiO4Xes6s9+zEX/5FqpxD8AispoE8obAy9ckRuoz4yCdb4QFL+6I/x1GPVwOgbEO
	vNvWSTSlmSYHodNFdmzoTZt0zKv86ENXkO8hOghaAo9wQSfqibmXbedzxypU6t+Y14amGYm+j02
	Jkzg4knIyumbnXpbTHbOiO1oxOMD+caA2s32nHjvM0GJIoCcGnk2BgYUixACnn+CyF4nsLrCthg
	BVXJSSPuTfS7cM=
X-Received: by 2002:a17:90a:10c9:b0:39b:34ef:3b2b with SMTP id 98e67ed59e1d1-39b34ef401dmr941098a91.14.1788514041803;
        Fri, 04 Sep 2026 02:27:21 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:646c:494:158f:c4ff:121b:b906])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fe843sm3518116a91.10.2026.09.04.02.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:27:21 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: bot+bpf-ci@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	shuah@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	xukuohai@huawei.com,
	martin.lau@kernel.org,
	mason@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: cover the exception callback using its own BPF stack
Date: Fri,  4 Sep 2026 18:27:12 +0900
Message-ID: <20260904092712.10691-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6aec8f5c91db3edfd8becf6f41bcb33fda2cbea1bb894888cbcdab4579b0f086@mail.kernel.org>
References: <20260904070210.4163193-3-donggeunyoo.kernel@gmail.com> <6aec8f5c91db3edfd8becf6f41bcb33fda2cbea1bb894888cbcdab4579b0f086@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Sep 04, 2026 at 08:09:36AM +0000, bot+bpf-ci@kernel.org wrote:
> This isn't a bug, but would 'u64' fit the surrounding declarations in this
> file a little better than '__u64' for the three new locals/globals?

Right, the rest of exceptions.c uses u64. I'll switch the three new
declarations. Holding the respin for now in case more feedback comes in.
