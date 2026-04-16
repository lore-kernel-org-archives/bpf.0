Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74293248F64
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776315091; cv=none; b=ukIwRJksEYUq3BCIBUPS7+ldCFTo6r1Z+MoMqr/SRb+xNQ4G1m0nj4OjZ8vZmVAP1djgWb0Ne3qVIvyq2H9yRZ4TxCFHRFHPbiEX+h5/TzVVx6CIQH/S4+vL74aLoR3SKF6YRki+m6fX7v9SIu8odeJVOsy6Du9Q4XJ6V6fMi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776315091; c=relaxed/simple;
	bh=UCajn+9EV3V8fL1geKXufd72TATvD5WPpF9SbkbsQsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LybkHmwVNzsk8gmxDved2s7Hu9cEHMu6EVdNmmLwiuAhT4fG4e+k3ujlyu8C3de9ZGaAimAaY5d9+2DiHFO9lVGhf6P/1cRcFC6KuwyOGClA6JpfeznHrVeIigRdx+q7rz32VxQyqabMAd1aZ0e/cu9Yi+xfd59nT9Uf/VTgPzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axHXJJtH; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axHXJJtH"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c19d23b19so9148631c88.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 21:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776315090; x=1776919890; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+k2pnRQP7eHbEwO6Gxr96/yH0gBJp4sY3rx6d7V0tU=;
        b=axHXJJtHYCUebpuuV+9WCDglw33/m+YsqV7dYQfkHhusNn/5H4C/YlgufPrNgqutWz
         7fThH04C0wf7BWD7wYV8zX/lOPa6QhbPjM6k2Tws+0vBZ5QnXucedRuT40YMC9jxuKPD
         tMdm9yIQAxPFYk5vHxASnegKY358v1V8a6T+P8fZkr9TRkgFXq8ObZIjiK4jm170xbbK
         Lhntp086Kz6IT4Dl4NNkkF8LU441hGKXWI5OzVR9jreE+9oCIJGKCTd8FF5Ya5z2tc4i
         ldLMritzTLv0rdjG+YIQ/ngO6eg7I1netBOTHLObFc9PzjmIkzIVAqRRFDNyui38rdRy
         HYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776315090; x=1776919890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+k2pnRQP7eHbEwO6Gxr96/yH0gBJp4sY3rx6d7V0tU=;
        b=T2dAcxxFSFlUJidb9ZYByJor408fPxblBstOEjQTpTqmecGeCuXWbjgKICKUkQ38TW
         FFT2W2/cOOnD60rTFEs+jCn6n0jZuGdtbMgEzrtKXXLh1SvTwj/VRA5oAt/wyE8YoxFQ
         RCoRxLg/6YwO91u9iR5o+ckRhXeI9SKDorPpgiRUcRpgyDLgL1QTIR1pVoVlo53ObTl4
         UjNd1+ckkoOgWKBdNsc3brgMovbypGybhsNpj1ttO+BfMqmgyTxN91jQ3dtkaCEt1P2h
         hEpqsJsABah5NLX1jl+ZlbREj7/p4YCjGM/hcA4ES8NJxcjSmJ/AzJGOHLw+exWbeFnM
         nrkA==
X-Forwarded-Encrypted: i=1; AFNElJ/GelnNxs5CA9QQHQ4Pk1N2xlr+UWgD8N9BCm8sjmnBSEAwHGcUSgivE+zGHaVC6/LmZyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmyr5Hxx3CwsTNCx/aY9CeRYCrB/BQPdYZq5lFunrfmm2PJCA
	q/EOBIV6kKkTOL4SqpAjDjXulchLABM7xA3wq4CakqF0Hl+hNq3t6kmV
X-Gm-Gg: AeBDieunotUm1ksRjys8byftChTvadbx3L0zop8vMtbPp+bbtlRmj1Pyy7330liN+GG
	Ph3i9OXcW8jVAWQctHb/6VO18lJjh1+l9VREFDvxwnBcQyC+qLg3g0pPkpSQ04B4wSJmqlNoW0K
	HxJAj1bTrwkP53M9/6BIY9HODNZ6zNqzCmNpO3BtSHmKgQPPJTlbEjYIDih5evGdw0u2sQEiWSS
	MWO5mVOxnpG1SrUdeMXtzacUlqYsBek2ZcFOySSgKW+Q1d+NjtSkk4x0vdHL9YJ2cc0bC7TwRAB
	GRc1YN4gYsVDBUZKsBWF1q7ZfbErcMql6Az9Jrmmx6cj0Q6kVJyTI8QhSefpzZgsEjRU1nLZDZj
	NNMR1r2kqDOO+RCeWIYdvyfn+2TdA655+FbssiQlbFu5AcYJrknzvzVBu18K+iWHKAtrkjn/RTY
	ToPtl+fAxVfda7LGUHC6234OYF2WtoFwPJ0rQ+oJFBliCOVUhUlrKkGL3b2M6WbZCn
X-Received: by 2002:a05:7022:6b8d:b0:129:fe5:117e with SMTP id a92af1059eb24-12c34edd87dmr13371418c88.26.1776315089576;
        Wed, 15 Apr 2026 21:51:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d5d3:8a61:7d0b:71c9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8fe4ea2bsm5804115eec.31.2026.04.15.21.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 21:51:28 -0700 (PDT)
Date: Wed, 15 Apr 2026 21:51:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, roman.gushchin@linux.dev
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next v4 06/14] xsk: support dynamic xmit.more
 control for batch xmit
Message-ID: <aeBqnMc9whoFKOgB@google.com>
References: <20260415082654.21026-7-kerneljasonxing@gmail.com>
 <20260415093539.4A4BFC19424@smtp.kernel.org>
 <CAL+tcoDUa=MpXSEtweT0LvkBEM2hcYnrjn4FK-ntU3WNMbLEWQ@mail.gmail.com>
 <aeBp7gJSEIYRfS2K@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeBp7gJSEIYRfS2K@google.com>

+Roman

On Wed, Apr 15, 2026 at 09:50:10PM -0700, Dmitry Torokhov wrote:
> On Thu, Apr 16, 2026 at 11:43:53AM +0800, Jason Xing wrote:
> > On Wed, Apr 15, 2026 at 5:35 PM <sashiko-bot@kernel.org> wrote:
> > >
> > > Sashiko AI review found 1 potential issue(s):
> > > - [High] Stalled TX queue due to missing hardware doorbell ring on early loop exit
> 
> Does sahshiko bot have reply-to set to "sashiko@lists.linux.dev" by
> chance? And can it be changed? I am subscribed here for discussions and
> news about sashiko itself, not for replies from all different kernel
> subsystems to reviews of their patches...
> 
> Thanks.
> 

-- 
Dmitry
