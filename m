Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E80446053
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267377; cv=none; b=MlHLq9FzlmQFX18vGu8KfcJwjT2QAquwhG82Nycjl29Cu05dvDeVOT3zQq7lbTc42NWNT9IPPlbvNEQ17SBsVrM6DVJTTNHHTqMIUls/9gW2IN7bovFiG9TxG/yPPlzYv7vwAQSL26+eBXBRpYgcivj/pkflzLwLbREBNAiJVsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267377; c=relaxed/simple;
	bh=ib7UiOqTilW/pmz3zKSGcxxj57tqUPLwSbILKAZkAuo=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=RTMuLykyXFfNrkjOHE/QFyphVAIRipcNSFRxXgt0eXHCzwCz7YWjqceZWAnVvWczzrQ2v8Aw5HkeAJzTzParpi7QiarTvG+iARS0B+MrbSLY0jjSvPjfZUZ6YiN1qD1nWxwx5OLkKV/N6DQhrX9uEYp23FjpjJPtlQpeRqJYOsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/0nicYo; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/0nicYo"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43db0c17so34536187b3.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267375; x=1790872175; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RmzIBZNKMyBzEVYhMNYG/K2K7dQaYu2u+07iT7sDqzA=;
        b=q/0nicYoH8E9PJyg2NSrx+MZRJamoX4HdahPtG6zirQoH94GzaLygZMWcsQNhLklC+
         9+v/VJ3QwyjS3EM1asbJ5wV4jCa+l7KNXH0ODDmHQ+esax+coSYFetzSe1SOTjF4Ou7r
         rTZpaktosJVbPE9jKr6GuNdyYScw2CIq+8RBFfdNxsoqX2wfT79fxDNZwMFFvGr0+90H
         LZRjYPpEuUf1wbcb1z3boOrP7tXIHhgsDycSyjtgJeLovEqISvFqFLRGgeZdIpwWluNm
         OXq9p9aGB7osd3mTzPRSPZdZiT09nSiM/xyWoshbQ7Bj8ojZKmN+kXUaTBn3ff2ZpMRV
         m02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267375; x=1790872175;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RmzIBZNKMyBzEVYhMNYG/K2K7dQaYu2u+07iT7sDqzA=;
        b=RsGuDFmFHgV1KTmZLNlU7Q3HmYrGHmWgaS8T6vk7V1lRpdZ6/z+1jv2UfZlPbIFaSJ
         g3fODJu0/viXikWZBUIwKZBMk91jgDN6Xk4Y9HpujvIJSmFhNiScu14bWh+SRCYBd/EQ
         InUYWteTWGY9DUafOvXM4icuh6bw0J99iabvlcfe1zG4oo6Z8hCHxLE0xVUbXZlsyr11
         auwRitr3lrOWEdc3JwGHCanGxzN1oB3IIQ+FgMk8N6F8DEGptlHtYXdfbxEtmlen3o8N
         CNlS31VbRdssd5DJHXuztucqRWfifOEhR/vsF/JKeRtSBA1FTIdbyysMmdRp+br7uYO9
         iYZw==
X-Forwarded-Encrypted: i=1; AKwUvBzwHneJhKkRi9T1bQF1+AY5C8ITt7gd1zsxl9utTnYcbFOfcnDIRLBokDwB++L9C4bXMOs=@vger.kernel.org
X-Gm-Message-State: AFuF++n4fM9RzPfDRszDy7L1UsBjdZ4LG/kh+PZTfkCT9TIYkGLm9Ud+
	EPgSt7d8yLkIoSDfDbam270dRJ3VL7SUwaUko/RnBak2GO/hdIBYGqRD
X-Gm-Gg: AYBFou1nfbFHUwK9qLudqOfJIwUHmfC7e69Sw5Dy4hYlziOECsjQmrfpO2P95zkLTUs
	44BKb27REeeTR6itsdC6V2kUSO6KCtMDtDW8vuHoOb2lk9NNsfU6MsiNTIQSkvcnNIj3JA22sVO
	aPJqnA+MNWOZHev0sfWU7JlIPTjP89K4eIYI5rvEqvdeXh19K7l4C4p6kDal9iVX4uvV01q7kSZ
	/aHY1DY539IMO36bsEBQAMg6DUxbvKaRzCrNKKgxlq0qlykipu0XlDSm5Kvcpeyfpu8TvNLW2nO
	jSf/syWx3c03JyUQRF9PENymnHTUDj1vh2z448dYKTWnLKgdTC4zl4QkmMQeydQO4chrXAy4CT3
	20sCr8D5+A36Jp9dgE0mvDOsuGeoAPFqi1Nk8LAftFXZ/+7csV7RkFTEj2tQA2Iq4JLPRiBHuTT
	dU3yKXjnCdSi1dQUe0NPib/mXZDo1Nn/ppX1IX07MR/6KeAhQcpJmJTVtEClxE5QB53ghX3/lr8
	YvuigmmzW2CzJBPey6hD5prCTWIjSUn0geuxw3gU4o4sbyirbdHoYPAZSVGVG7SkniIdInz+/LL
	C2EI
X-Received: by 2002:a05:690c:e3e2:b0:887:f24e:cb60 with SMTP id 00721157ae682-8a64a4895dbmr16421357b3.38.1790267374649;
        Thu, 24 Sep 2026 09:29:34 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a6d3c8b41bsm6874817b3.22.2026.09.24.09.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:29:33 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 16:29:32 +0000
Message-Id: <DLNOTGX1CRYG.3N0BDEFH1WPQQ@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Test fetching AND/OR/XOR
 atomics in arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Tejun Heo" <tj@kernel.org>, "David Vernet"
 <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min"
 <changwoo@igalia.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260924160354.531101-3-puranjay@kernel.org>
References: <20260924160354.531101-1-puranjay@kernel.org> <20260924160354.531101-3-puranjay@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 09:03 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> -#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
> -	__c11_atomic_fetch_and(&and64_value, 0x011ull << 32, memory_order_relaxed);
> -	__c11_atomic_fetch_and(&and32_value, 0x011, memory_order_relaxed);
> -#else
> -	__sync_fetch_and_and(&and64_value, 0x011ull << 32);
> -	__sync_fetch_and_and(&and32_value, 0x011);
> -#endif
> +	and64_result = __sync_fetch_and_and(&and64_value, 0x011ull << 32);
> +	and32_result = __sync_fetch_and_and(&and32_value, 0x011);
> +	/* Discarding the result is what selects the non-fetching insn. */
> +	__c11_atomic_fetch_and(&and64_noreturn_value, 0x011ull << 32, memory_order_relaxed);

The 32-bit non-fetching and/or/xor in arena are not tested anymore.
Pls keep them too.
