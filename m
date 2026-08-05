Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E616A395
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785967879; cv=none; b=YBRAOpt+LundrGv973vboxCuLV3YPpuk2Wm6mgbTWG2/mtrLx0rRGD6jKYx1dyatAiS0w9IuZDiTpuvlYKWZDTHdTWvwovc0OhWjHrI0z+BICUFQEkkPC7bvJdDuN2EbWVVecIFLlp3gIsET80LAuzV2rMWlWNqjPwyJOfxWOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785967879; c=relaxed/simple;
	bh=vxnjsqcVejSQbfii7CM514fBgG1xwC+NBmetSd+iVfk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2cZQ7jGmywJy+mGQAyreDX7g/EhP/Obc9KvKljJhiNPkAnejXYv5OfoHC9FYBLBgug+3lRxACiOCR4DCk+lVbEJ0NIX/VbfGrjUNjeeI75/TSVmkcSzMGAiQvIqQN9oGy4p8GIPuobY2650/Z6ZFKx/Dj9LGtH025RbAnn/B50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XASztxrs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XASztxrs"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1631877a91.0
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785967878; x=1786572678; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vxnjsqcVejSQbfii7CM514fBgG1xwC+NBmetSd+iVfk=;
        b=XASztxrssYBx5NBawnc9ykAeHoIvMCqsSyGUi4aUYotSzCjC/pyqy65OIho08IjLth
         5z++/q+jJ9fdLn3Ss8rgVHKwsT16DO/2jpWZg0dTgKROO/rhFtjRrSERE1qzn2nmfZq4
         Zv4akwndbWCraQDNG961ENgGbxGvp+VxivH0w0q3W4P51oJtAtA4lsL9+CHNdvmZn1Rf
         jQ1EzHZOrd0WupYUSxNP+3vVDNSQapfEi21PIBwh0GlSgw2wUF1+Ir7HudSLoCkVSg4s
         nNFJ3aWYsudbEhEH9WrV9t8meVFBg48uMf4Ru6wU8xjrqdBAFp7+OF78zAofJ8JZUS6C
         +QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785967878; x=1786572678;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vxnjsqcVejSQbfii7CM514fBgG1xwC+NBmetSd+iVfk=;
        b=l3/J5lat2PZWQgADyBQlw+5bnZMpfHjCF4jc+iBzWtVMtoLlD2PNQvTM5P3Fpta0I2
         IaSem3wprOqzh3t9iZvE0K+d/tpSaDh1mJsjC7xQfo8H3Hi+SAvbz9ef2wv3SRkNh2Uw
         2m8uX3bEGF3pOFPmhw+6UK7xWMmhDhMMl5CRY8lADYcX5swthWC1HfYxGu3FOCfF8QF0
         zR0PckjwQrskSoy8+X/GW+luZMgwpGtm9hQdmVlCTROEPhiQmcTbOtJus4bRp68U8wmI
         qxw4fBAQBEwTnGUT4O1uX27XeF9LmHuMRWBFeiVv8ypW/F0Wce8hG8pYsRCzLRzrCEwc
         unCg==
X-Forwarded-Encrypted: i=1; AHgh+RrO8s6jwJXLZGgXBV/Xnm74hpuVF//pIPJfmnzt1J5gY8eQeJ+rNWHBhcjTJd/NLjKd0vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJitQms6a4bNFJGE2CMxegQxVKnVLArRvbVVKWmta3vL6HBdND
	WiNMhr3HB10t+1ERpcAcMqJlZks4FnTLiHy4rua8bgMC0ctIp9X7QGLI9ivFZ6nk
X-Gm-Gg: AR+sD12OFhdv++SeQAn2xFinvxaInfsBjrAyLQ3pFvIPfKHC93F68wg9lUSH/RIfPIg
	tvDJJrg7KDcRHvc55NY0rS1xNADLdZ1g1HDWTZ3MlDMK7UGED7dEwd5zNfC5tFUTkdILDzMNCye
	nElgxpAs5lY3XAEdio8MvakVSsMPCzoC2gnmczRQRxY2Uaq0YPpxzySgwmN6L0+gl1TpQM8+ekY
	s2EMwKGcs6J9LojlbI2oR0qicSJeE/MjRF2OwAmrbEBULyT0X1OXseUW1o7TGPNjbm/j4niC5Ar
	Mq2SwkGaTJJptPRJfeAVVpmdLLfvyEj1N6twpHJvPSfbxfG/y7bpme34htKERhJx1/M0YApDOsp
	nRmHR+eEuixRP7aKGGQndMxylt/g3hRcFlnzkNg/iryMhsB4K8jlZGQW3QpR8eK9euwLdLEXMMb
	ZFXpRvH5as16OBfD0BZc5Q+xHvOl1ouPWvXHz95+1z/6gtTxVTzyHduLYwFH2n3r1/lMsriNFJg
	bWqsxvMFBC+RtgGjV6gpcQpadYC5O/EfBmFPEivHNsQ
X-Received: by 2002:a17:90a:ec8c:b0:38d:c74d:29c5 with SMTP id 98e67ed59e1d1-3903c5c0c92mr10663769a91.19.1785967877814;
        Wed, 05 Aug 2026 15:11:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:969b:c0a:ff6f:454e? ([2620:10d:c090:500::5:b61b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca508a48sm16029828c88.1.2026.08.05.15.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 15:11:17 -0700 (PDT)
Message-ID: <4c9b44c253abe75d9fcbc8581e7a4071f2a5c4d6.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 5/8] selftests/bpf: generate
 verifier/tests.h in a regular recipe
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Wed, 05 Aug 2026 15:11:16 -0700
In-Reply-To: <20260804170156.1709916-6-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
	 <20260804170156.1709916-6-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 10:01 -0700, Mykola Lysenko wrote:
> The verifier/tests.h recipe is a $(shell ...) expansion: the command
> runs while make expands the recipe line - including under make -n -
> its exit status is discarded, and the resulting (empty) expansion is
> what make actually executes. Turn it into a plain recipe.
>=20
> Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
