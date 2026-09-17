Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECBA4D37C5
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642788; cv=none; b=iATepyR/i97C1aeinje/koi/ZFsGPNcZ5NlKSrkqt6QR0qXBOKSWuxbFuLtPlCOri3c3tbPh8L1ci9u3xjaQT9TYN7yx+iAKazp5aegUERqiveUrHfHcG+iZk3H9gF2Wee3apHoUOiUzTdzoGKHM+RqwGk0otafgTFq6am+r3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642788; c=relaxed/simple;
	bh=8e8Ah+7WlZHbhtXBLLlQRSAvSloayfN47Xg8BoeWzkI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ei49rvWY8Qq5HVntEMgGeNg0y01AWBa+grtJhvbgwD3V3w4PGVZr08hOC40j6RiwmhEYsO13hyMewroQT0qT9AEn0/Ce65wIprlZ6iNQMsZKCRz4A3kYzlW4i2tsyswtahAXOqcpdocSQHoG6x2ufPk/Yy0MzU3PjWQ66++V4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/6iZZCo; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/6iZZCo"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso2572545e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789642772; x=1790247572; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h0M7opCWPOuxBFEuwAzPAI3fMW+G/LVbMC9tyOg7hDc=;
        b=d/6iZZCoppIIVZl9QpIgklFXZXZoKkLRQJryB2oLdVbShfOhnrYe7qEzJKAGHg9Fhs
         9HaGUP3r3/vT4HfOI0wARNf9i3EP9pCxoUekepUKAPKHN4ZUo/fDlMBbPZFk4NuMEtpZ
         jEscfmibdxyykCl82IEkOU5qwoCXV9jQaErqKObXxE6udizhFIcWIRq+bO7BgB++Pixf
         //EcCX2xtTEmJksO8NE9/8ozoG8X1ZxHLDh+UTwkgVZLA+06A1Rrmdab6x9Shl7mnLuD
         bEdRFB7oiOeClRwahH7eXIsFmpiJL+daucAfypDOcx7MdGLbpe6CdPnEBNCwYZ47Nzxk
         jqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642772; x=1790247572;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h0M7opCWPOuxBFEuwAzPAI3fMW+G/LVbMC9tyOg7hDc=;
        b=s9L3qJz1JC6QmFJit6HhvO2XXib/bjepgtppTYU9NbkNNYH+MI59vI1yt1mPTnf7Pd
         oEybaOvRlcyvamDKH3k0M7e/V2u1y6n2VaVL9mXlyWFrm30CjaG3LTr+bIL5T8LCOre4
         DSWipKwjvmxoO1zG2yrBeVDe+GazVxMTh8ylGCiX2+EGAlItLCWaTRztmNFaZi9zLGEf
         gVXeDiF79rLSUXud8lOqe3zJBLjG1TUWaw2ud06De/pty/xZdvWi7lOKoe4COPts4XvB
         HWMWOR19E+pzcQd84V6ZnyGjKtH8DNKFjnczLKUz5sZdld/fFUbPJP4j5+cp025aSL0K
         943A==
X-Forwarded-Encrypted: i=1; AKwUvBwcmQVf7/8/MBDQ7GMiu+AxJFEX0auUSG6ZoZVLmyq2Hu1QdSTtVTkC2ue+8mh8kMmilfs=@vger.kernel.org
X-Gm-Message-State: AFuF++m+8zVcRSekPYqBa3HXrGaEOmAfnurU6M2b/Yjt3dfJa0SVDK6d
	1vuX5gVuOcFyniPJP7S72Clq/nnVU8uc1LwHrV+/QzYewv8b5gzt24dM
X-Gm-Gg: AYBFou1NnaNOHicbpvNeUlr253TO+j4H3ZeA05DJz/267aFmJJ7ma6T8JThJZ6fGqgM
	YNDeH5TqIiD7WmvxirONRVdzlnbtqz1o6W0EbR4U8QKebwIxAcWBQyxDhVYJyL+YA4aCR24Bt/X
	kLcMMCGxd0Yh0bAShI+UO/O/4xh+/Th+lyLIercOwot369UTF4Yv9+ILY3NIRnfbsiXq8jlPLb2
	tnkrEuOHLB/ppFnsBTfR/+kAZx5eNyH8us0TzFV6aSbAEPpohZNGxNNZJl11tUFt0nAQxo2sK8u
	uWWXMVp88QfbTZaAbAN3/vJwmKCUFMfDN4+syg63M+haBbPCS1Lp/Lf0f4U8Eo+6lJBIqCNCrIz
	KhSta+nVV1nQS3GBP1CqTgq3FP89pGuQ81TtQSHCoRagFHjUhOKapKpxwH3m6kjRV1eZS5BSn9I
	wgvNryhxfpgp08J9Utd1j80x18YraQxFoe7oqOgN/R7+NSd+LFrwhDxVFbYJw6bvT5bUYqY7MBn
	qFGwPVsk6PPm+dY8XMIJXSBo2socmLoKG7ex2gzdau7qy9Nsc8E3Q185WHahs/M1d3t7fSopbbo
	ZQy8+EHUoB8DKhie80OnS2i8DRmHTv9Urx0jJr4=
X-Received: by 2002:a05:600c:4e0a:b0:49e:8238:6feb with SMTP id 5b1f17b1804b1-49eb73088c2mr72472075e9.14.1789642771777;
        Thu, 17 Sep 2026 03:59:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fa70sm14454462f8f.9.2026.09.17.03.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 03:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 12:59:30 +0200
Message-Id: <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mark Brown" <broonie@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "bpf" <bpf@vger.kernel.org>, "Networking"
 <netdev@vger.kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>
Subject: Re: Missing signoff in the bpf tree
X-Mailer: aerc 0.21.0
References: <aqvBPVcN__UX8P85@sirena.org.uk>
In-Reply-To: <aqvBPVcN__UX8P85@sirena.org.uk>

+To Eduard

On Thu Sep 17, 2026 at 12:30 PM CEST, Mark Brown wrote:
> Commits
>
>   4499609f99fd5 ("selftests/bpf: Test global subprog callback contexts")
>   3506b9a2f1085 ("bpf: Verify global subprogs in each sleepability contex=
t")
>
> are missing a Signed-off-by from their committers

