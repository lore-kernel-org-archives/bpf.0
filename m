Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545837B01E
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581718; cv=none; b=cUuU9w+PhI90pXCKDNGuVI8yWp+Dor7LFog634zBPwIBfG8IBHNpd/8EFPPGrgFRbF7D7u1w1KULFA2Mxa8mVGygUsCF9j2lmhcF03jGMxZAwNquxRXkvbGacvP8t7AL5dx/nTmqP2mlW8MXZ4EHqiSpJ9W4E4/FfgRCQXXYKB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581718; c=relaxed/simple;
	bh=FVEHpdiwvMC7UliGeRBKqzyenyVO/eVH9K2CHQ9L4oE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=o+7xt1Wkpt+cK85kIg8qhSR3RWHsZEO5DxIicsgdpveI5GLeIvaGkUHss10VBQK8rC/c/u+uP1vYMEEPD2ewLHaM3x9/TZrugFCBU5JGSw0gZEaUsSjMU06wtI5/FWKYj1TRefDHbBuTWRbqaEQPaGPrUAFVLuDfNwxjiXwyCI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlKPW3L2; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlKPW3L2"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e69so630963a12.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790581716; x=1791186516; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FVEHpdiwvMC7UliGeRBKqzyenyVO/eVH9K2CHQ9L4oE=;
        b=jlKPW3L2QgrRw4jPjrqapp68cGBIPKa1YRlKyf+l2M58o5tM9rMhL2tpdRNWbTaFex
         mX746blM8pHhmstb+lY5P+R3wUUG9UOyMYNCEzo0VYhFflt5wedAHmtbitkuLpdKOW8O
         gNCPLE9uTxpzOIU29yCvj/GC+bD35OP4s3UP7mkYcx5CCRi9VRlLsFYwsaI/w3RKzSwc
         /pzeFsB/5HHoHs1jp8dudaazi6ZBppqjfUDtB0fKyE6Ftqsayx6+Z45qkGHX7oDLac/O
         jWJZXoethJhBuBVPw1IKqWgSFRwfZvb6KDw540PmPUDxJU6kg9ZBHzr91Shg7yWiJZFH
         vvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581716; x=1791186516;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FVEHpdiwvMC7UliGeRBKqzyenyVO/eVH9K2CHQ9L4oE=;
        b=1lfnGSvITkF79U2MtqqO/T9lIOpaEOXqP+Mmru5+r+dh0EdwQCFeAxv16rNexPbzLl
         9B7O3lzSJLXmRZkNok/7HKsknIA4gZfoZTNmg8p3RPGaScsXBPAyMVRiHeYz/pe/Q+7P
         x3u1rvyfF9Sp7h6vJqAfXlkfLF23EPooSxV0h1CALGx7KKeJt0icTUL6ekKK0MYrzudO
         KKAZ5RyOn80DmxGK4sR/DL0Zo+85s3l8mJfXS/15R5RCkT9aQl6RxvVMZeay8WxPYaVa
         lIJqjbDYFeQEauKHY6lqA1Y3BPoL+HNm/LFQCuEWh/K5M91yMKtNnwuim7Fd92EggXMD
         S03g==
X-Forwarded-Encrypted: i=1; AKwUvBwttMIONJH04L1nKvSDgnmbx8JDQ6Nq1/jXmOm3uvR8K/4rBOVTjJEvsGHzhJ1tKiv92j0=@vger.kernel.org
X-Gm-Message-State: AFuF++lG6e3xmXzll00gcZAIOSE8UIEHUV5sbUkfgpNKyc+5rvDFKYpU
	D3S+H8XZmcrDyDFqvQ1YrFom3Rly2L5muSLKhnP3UpljO1aDUqNNir3E
X-Gm-Gg: AYBFou0If05ePmO266EgAEkuosqZn7CB0yJ5aOozExKWVnBT4RzndHL/XpKAHYtyiUm
	/pbS1p4T19juMfd1rERSVBrN7aTyWXb7ZTK0wHmkiIhdrkQZ8w12g9gHCnt9nvSDDcKmqBSZBtC
	PdRQRD04jctLCACDZJKzoE/oSo10eITkTPLhCYntOmqmfB582JyiH0AaRVPopthKNawZOl3B8Ur
	KLZEsQ4S81RtH7sCVtz5zSw51gSYRUeWHMeEJ/6WjyXKefr02znnFLh9tBQ7FSSvoj74sKL0lH0
	4FPQ7UkDy16KlO2MC/1ISx0+nCcP2TZtzZUKI0xeu8lM+6McE8hvKFULf2qc0zuERW+LIChmFCF
	hUVZrTziKcmwtlM3yGsVvMYWqT4xshawemP1KkMO0EhtTJRwT1ex66IBwpeDzsvIZaj73kokd1S
	zcL/Ti/Sw3VrD3m2U8rQFbEiVw4ZoqNHJQO8qToQV9Gh0WcR4wWvZeZsYjM4k2nqOB/EpxFvzYK
	YoCR4+CPOcZ/9CXb6R2RfZ2dg94mXLk73mQK3zntk9WAc2dKSYOSx3F1zraqmqf/FUWXU0dEsKE
	OGrY
X-Received: by 2002:a05:6300:210e:b0:3d1:39e9:b267 with SMTP id adf61e73a8af0-3de0e67622cmr10607469637.3.1790581716294;
        Mon, 28 Sep 2026 00:48:36 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7ae09698csm1383579a12.31.2026.09.28.00.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 00:48:35 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 07:48:35 +0000
Message-Id: <DLQS8S2AXJX4.2UUWRPBC46X2G@gmail.com>
Cc: <john.fastabend@gmail.com>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: Fix bpf_loop() depth check to use
 32-bit max for nr_loops
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>,
 <daniel@iogearbox.net>
In-Reply-To: <20260928001609.429840-1-omermetekaya0@gmail.com>
References: <20260928001609.429840-1-omermetekaya0@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 28, 2026 at 03:15 AM Ömer Mete Kaya <omermetekaya0@gmail.com> wrote:
> The verifier compares callback_depth (u32) against reg_umax(), which
> returns the 64-bit upper bound of R1. If the upper 32 bits of R1 are
> set, reg_umax() can be U64_MAX, causing the depth check to be
> ineffective and triggering excessive push_callback_call() invocations
> until the complexity limit is hit.
>
> Use reg_u32_max() instead. The change is sound for both runtime paths:

It's not a fix. Nothing is broken.

pls stop the spam.

pw-bot: cr
