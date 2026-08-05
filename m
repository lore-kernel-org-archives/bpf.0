Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D253F7A95
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964922; cv=none; b=QOdcS4ju6HU/afaK0szps1NTkR8FpBt8eah/pOeLybwx3LUkEPuRmIJ9KkJIDAy4VU+WLG1aONUTOIZSPeWdPpoAkI3ZErSOAfmMy7nqvWo3IPmTGxEtIWyFuVpfbgF/z9+hEkRCf63DB1LVgpyTec910y2key/wM4J+VCETdEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964922; c=relaxed/simple;
	bh=9DGD9rtllYwSgn8MqLhnreIm6f/gip+ev3Odiso92LM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sSOzZqZ/ACLomldpzYDs8Lhs74WWq1FCSvzaiU5JC76JBOolmb1o+7BlZ87nNFAq50UAdtsAGa0WjJvBJu41ZVMGvummbYbu/z2QrMTlREzeHYNoGqmxMgZ9gB0xlg5a1lvdLHgZGtOUDgwHtp77PH4qy5mZxnMmhvpifpYi3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7nQRr+0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7nQRr+0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceaf8a1265so23264405ad.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785964909; x=1786569709; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9DGD9rtllYwSgn8MqLhnreIm6f/gip+ev3Odiso92LM=;
        b=Q7nQRr+0nhNOyqzvFjdnFM3k4XWLfVEbOlYlsBWV33yVF87H0Hmyor7kXLbo1IOLzE
         7YX+bgVE7edbBH2SX6K7oEekDs7xY3t0avJRR21IN95ri1Ljq4OVqo3PV3pKa5Xkdl/F
         0nfjHqULwiOHtKNwy8kmO8iRgYEpSbmROqZjQxNm+QNmy4thUF4qNBXu18rRX2yzf9Um
         a+3t/WS2tetoF+vMFTsQtRIgpACcu9SDkO9JX9Xp4tsxTZ+YRU8hBx6e+vClH5jZDStJ
         NvCR5cXiJnyoSvv5Q4aMfO+YU5VCw6bieRZKR7X/aWKzNJIVQJ5CdPmNqahy/Py9nln5
         LFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785964909; x=1786569709;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9DGD9rtllYwSgn8MqLhnreIm6f/gip+ev3Odiso92LM=;
        b=dKUSIQ3rTfksNvKtnC+HtYX+hxbjUGy5J8mIOqxnxLZTMchN8mOafO29Y9S208u6kb
         eyapkbbwmfp0puaTklCS8ze44AXCopiKc7IQ38M6i4W5aSJkRFn9ZQUf94vBW+syFM6M
         0ZRkNo8V0MiNLmUDOjXT1GF64oP747Z93dQFgew3T4RCW7DJKThhfIjlM9yL3oyU84Qt
         mKtUizHkgOgLW/3oJV8QyMCRUe68FKBD05vRIgN4NzmYEYxyUpeTpmkUCBqC6NkeQwcY
         j1Y4JEm2v/0OweQmijiux/lSe78ietCCtoBeltNCb5Ot2EI07PRWgASFcV/TFlz4+TIr
         yTHA==
X-Forwarded-Encrypted: i=1; AHgh+Rq03IRTJKmbxxwz1Kln+XOL4D6s3rmnjjwZuHZuxY4B0SluqPosRoaghh6TY4az6PdSivo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4n6ej3E5b5b2Ou7nbuRlmA2PQ1byMmO+jXLp3gpK3dlw7pIG6
	hVvDHV6w2/CIpaa4lE8B233AGgmn9VAe48Q4ac7HMIsZSeLgpfuK3B87
X-Gm-Gg: AR+sD13C9NppEA+Kjj63yZzLClSkLUrLUenuUqc/r42tZ0pNk/xM7u6lhjjzNtBDAwc
	5gJGXmHIr9im0M0mXuuWbeLwmFsL7T1jeEG7c/bg5/Uz/UOKPbsvCCsG52ibCoFCPkA1Syv2ggq
	Sr9JGS0cJxZhgWFgWIYbffVGhA5i/epjGqdmYUlYU7scQlsNNRPody884MVPn1onjSC6jySVDFF
	0iMmq+aVSrGsuvwl1YY3OMvOda61YBDjZF6FJ5T7/5vFUy7vZIK7AiyIaqBVySXXopEquS6mfYW
	Ydnkd6vXDNzUmMDLuibyegL+I5yL9tgsjvLpgFbwwgEZS+7pRVU13NRQuBEo3LKJRIsfHAA+oDv
	En0jgnLFA4RYerSX3QN+b+FWhbOcGY1WsACZrPATAadXSwKlLOvFPapgEvxPga/W+vh2od9ibbD
	7sH5TcazW+lupXXpR/NPeP9y4YDdTQF9gjp/QO9YoRVhMdNQKcqr81z5PFgJ7Nto5wlokfF1c34
	UytkDq5zpy1hB66e2gMG+z94fZ4CjvAqzJk2td6493T
X-Received: by 2002:a05:6300:2213:b0:3b4:b216:2b26 with SMTP id adf61e73a8af0-3cb85df193amr12716017637.5.1785964909279;
        Wed, 05 Aug 2026 14:21:49 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:969b:c0a:ff6f:454e? ([2620:10d:c090:500::5:b61b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586777bdasm20204635eec.22.2026.08.05.14.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:21:48 -0700 (PDT)
Message-ID: <e0c7af1ac6d033e5bf137af8533313601501c7f8.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 1/8] selftests/bpf: keep headers off the
 generic link command line
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Wed, 05 Aug 2026 14:21:47 -0700
In-Reply-To: <20260804170156.1709916-2-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
	 <20260804170156.1709916-2-nickolay.lysenko@gmail.com>
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
> The generic '$(OUTPUT)/%:%.c' rule links with '$(LINK.c) $^', so
> every prerequisite of such a binary lands on the compiler driver's
> command line. That only works while none of them is a header: gcc
> tolerates a stray .h argument on a link line, but clang treats it as
> a request to precompile the header and fails with "cannot specify -o
> when generating multiple output files".
>=20
> Filter headers out of the recipe, with a comment: header
> prerequisites on these targets are useful for dependency tracking -
> the next patch declares one - and the constraint is easy to
> rediscover the hard way.
>=20
> Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
