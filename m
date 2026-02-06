Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC52EC080;
	Fri,  6 Feb 2026 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770418762; cv=none; b=h8436UYvwi7ug5mPhHf9dM5aoMORWKoKO123oVb3I5OKM54HyemDsl5/Rzu1qquDB5EKGBeZ9EBir2f4Mifi7tb8yFWJKueV/kh2DD+SSp/EYw4OgFLoL3019KTSwlPHZH0AZMEzshv8vckLfaf44Mg8qjQInt02MjdpciKSNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770418762; c=relaxed/simple;
	bh=HgrPqahvKSC+3pLJbLbSqxeZA+MNAMItNVfs14dPLzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UK02kb7ZByehDAhJyt0UT4LcVKcOciaFyi6R0tAe3l2UVQo2VxOUeSIn8XylUOvEex7d8MDJYwACDyAUKR+ngpFYf/mvXUjqnppXVMjZ5oPS6csTX5G5aD0HmjpyHRHRmDm1t3uYRRTfnu87/j6r2XJSZiOSnkXReGkdoP0N1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YyzMC78p; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YyzMC78p"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 82B7340C3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1770418761; bh=RBeZ3QqeRRrFj81rm3Ls1gh3UuGDICwkpAl601siemc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YyzMC78p4uc6xu28e8vgtoPqMypY5xFMnDOgvZXDtINjD9hAA9rSluQ6SejloPR2K
	 98OGQr1IUV7GV8jevu52Lir0ixlyqwnAtuBbeWnSaA06m6DlLPEsBi3ok3LtywF2+A
	 8Kp/8VySVkAaxf7CHWPdENjgQ6/m7rqIIvAMoGArlMY2xRkWr/nZWT9o6j3BFwPaRh
	 HiWuw3DbWsK65Sp+KPgli/VEa1ReWjIJk5GcpecJf749d7tjARBNTTYxmVkvd8SzHJ
	 37Sa+Y/eLzYj35c4UToHdvyD/Naxbs/7A9UjJ2cxphn80j8xlwOvcsQM0E2k15K15Z
	 lKKhUxJqLyIsg==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 82B7340C3E;
	Fri,  6 Feb 2026 22:59:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Viacheslav Dubeyko <slava@dubeyko.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com, slava@dubeyko.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] Machine Learning (ML) library in Linux kernel
In-Reply-To: <20260206191136.2609767-1-slava@dubeyko.com>
References: <20260206191136.2609767-1-slava@dubeyko.com>
Date: Fri, 06 Feb 2026 15:59:20 -0700
Message-ID: <87343deawn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Viacheslav Dubeyko <slava@dubeyko.com> writes:

> This patchset introduces initial vision of Machine Learning (ML) library
> in Linux kernel. It is an effort to define the ML library API and
> to elaborate the way of running ML models in Linux kernel.

I went looking for the documentation files ... but then I've always been
known as an optimist.  That would be a nice thing to fill in.

Perhaps more important, though, would be a real user for this facility.
You must certainly have one in mind, can we see it to get a sense for
how this library is meant to be used?

Thanks,

jon
