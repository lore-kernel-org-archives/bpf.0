Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56935353ED1
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770239555; cv=none; b=uIzRsZjDdsQO6zqrj5qRAAA/hbEFWlfgvbAkbeqx8oiepQeRROuWUudZ6AyyQWYLHQp7UOylKhMaOADBhmuxFm/xXaPfLWNMaKXakNSpOdc0T6SmqF2aMsG9NTwvYjiP/sgzWxNvMSB1ZU4neaFvVkwrW93dstFwvv3lpFEG5E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770239555; c=relaxed/simple;
	bh=eU0RUgTHXGDPCiN8j85KUZ7TBl9ZYV3Uqnyow4HAQ7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hR8oKutkS5oGxW/EVifDViFNaWpO+S79CRP6SVE0pAeBVHgQxGrA7jDf+ZbKcAtTvdVA7hbnepUhl+Kktu3F2jA/oLJjkddtt9yOqc+4P5BPC8Vt7sod4j0h4zeMUeMiJeTxZt76CXI27lbIJLsHVRZbtGvnUwH/icf7zKptvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKahF4Rp; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKahF4Rp"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b704f08e73so191990eec.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 13:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770239554; x=1770844354; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eU0RUgTHXGDPCiN8j85KUZ7TBl9ZYV3Uqnyow4HAQ7o=;
        b=kKahF4RpS6d2qlxGJuh0R9lRCSJYOBmALq15CT23JpIG/xMt1xsKZLCTEgATMMeR7p
         L3eN+8+a0+QdzkbJU0tMWbhpMqoYVkOXcoYLC54PnC+YQ5MHMckdX1XKGFSPYQfpt7Uh
         wPf7tJh8mAnrDqhinv6yqvzxsz4/AnDA9HwDBUF3c1Yw81BQl35x0WtHlIgT7VrHxd1A
         Or9NKiy/WqYX+k0P/ySX6CWBq3qlVAkKumZEhXLD3EnneZjfSLSIj7h7L9zHjyq3qXUL
         lDr4iflTs61OtmKuCP5xlVaaftNPIU6af+Y7pK5uwDO5uA1jA2YnaUzy3jgv4vW3GXXY
         TMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770239554; x=1770844354;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eU0RUgTHXGDPCiN8j85KUZ7TBl9ZYV3Uqnyow4HAQ7o=;
        b=pVwhqgS7+CKxxAb0ovn7TS94BfFJt7Sa16CNRMHfUTX9sClKrzopT0wilM/JkkX1+g
         CyPmcXN8cP6O5JeVvzlIyP0F30Jr/Khq24aCEB8Db6Dxy5qOiATcH0BB9ChAj0U3Ncch
         WP8d4k+xn30FpON5emhUrR82XivyM7g2TL7+SPtv4VLfh7uQd2HQD3Sh9lygIOzv9lWB
         665qOVlXnPcaykD93F5po60TAGX5rWpg7TIikXHpNPcLcAWByqSyal96SSoe5Y4Qetyq
         z87gjqo+v8r6r1JSYPLg01NkCXyNKTnSDD+g2WaxNt3z7GFNrd7KduuDgQIWc5WmxPb7
         2FkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV50j64ko4pFHMThlmWMFT+wDbxP+mFCdzNpTFksoAXhxGxPRYZMXEgX9Tdh6KtzMz3QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cG1MEmMkqSoMeYp/jb+2t0kBBh9VYy8L1JzUFf5VAcTlK8nV
	XYS/ZZPyOQOcmxLlJPlmFaTHazcJtWn6eXgb23ExVniDFivCj2BT67Xx
X-Gm-Gg: AZuq6aJPUPgYF3N3oQxpE1O0n5YZ1O1eJz7NZRe6qEJrqB6hy+9DYc8c/1qZ9qTF2Qa
	mhzTDK/JIJmFQqYi/jyeiIqPofOqGPyND5qr36xEicQbF/cfX33NQYcmXBglsH960E0/c+FqkG2
	rR0i2HW5vTNBpvZlRm7IRZg3yBuQY5NG1ry1aaMzsyNDhuavtnlLzV+75B1xOpcqxVd1glnwbft
	3rMiPiSH5iG2Je6Ao04B6+nZUWObExcT1w8c6d8qFVoKnMUGNQOmhNvHkgCmg+elLU2Pn2T7EGt
	MW6XrVa5Y65hfn2Q8bjX9VtGti5SQqKI9Iqh9UO1ueC7w69V+cO8rfkgOB64kKtCSzuLHr/+wnT
	HLHghUJCInj93PnTW/wAILC2ZmKBiK3THSw2j6U2v0s0Cnk6xVOsawWAMDUnSPQS39sC9WKkahe
	z76cd4k2DKkULE1npI3A756dnSE12RAPi/kELvLgDvGmIyDJRljQtJyC0F/D6RiPJO9Vk3
X-Received: by 2002:a05:693c:2298:b0:2b8:3b47:8951 with SMTP id 5a478bee46e88-2b845b58bfcmr288639eec.1.1770239554449;
        Wed, 04 Feb 2026 13:12:34 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ac05:8e30:1e93:7ef5? ([2620:10d:c090:500::2:5ebc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832fb363esm2214741eec.26.2026.02.04.13.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 13:12:34 -0800 (PST)
Message-ID: <314151a78544a462f2b4a0c0fd5166fe390eee44.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add tests for improved
 linked register tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Wed, 04 Feb 2026 13:12:32 -0800
In-Reply-To: <20260204151741.2678118-3-puranjay@kernel.org>
References: <20260204151741.2678118-1-puranjay@kernel.org>
	 <20260204151741.2678118-3-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-04 at 07:17 -0800, Puranjay Mohan wrote:
> Add tests for linked register tracking with negative offsets, BPF_SUB,
> and alu32. These test for all edge cases like overflows, etc.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
