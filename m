Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60210332EA7
	for <bpf@vger.kernel.org>; Sun,  1 Mar 2026 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387998; cv=none; b=k6/RPc5TIu9YG247PZ7Nsf0G0I4taiHDsLsQHTaNnfPc4IUrHKZsMGSyRCZi9Uxb8gI1tJ0lZB+WXMuIq1RWXMb6tlpKuDfKbGUCAVDL+7orHQIlyxEuhJAEHR/Zr0lIjOCrNV+aKNk5Y6QPVtfGTDIqeUehtZumvH5xL6/v9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387998; c=relaxed/simple;
	bh=waHuXg1cR/lNxdO7JwWx5WCgUHMStoTszzOXqaMK+2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xoui8dG+I4TmTfxWh3ScUD8M1qLSLBtRv9a0Bzsz4C3lOmxLYmBQJIKsWHHa2lK5YeR5QfjLBIkxQXXboEF+lFtT3NmcGXJXM8XGp7XclJz7DwsFM4T4ieudXv6VRrSqfyqH72r8/MFrB4Wd2mdnNd/4lYAb6p1kdDd9RQrtLp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QGpbxEMw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QGpbxEMw"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9358bc9c50so383007766b.1
        for <bpf@vger.kernel.org>; Sun, 01 Mar 2026 09:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772387996; x=1772992796; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUriLEKIKpf7k3NxTjsJxgBlXx8URXMNCEQZ8pvmz+I=;
        b=QGpbxEMwqmSi8MXhx1v2I3f6cbO6LbepsKDKJTqf57NMkiqfF2TmtRdLpl6HMe20si
         jyEWuXHOYsXfui+AsgbyTLoUyePaYxiwfXS7IHbXdyu2opV2GKAn+air1H67kUKGn6uL
         HCruFoMuv2AccDJ4Ck35qJ/uRtyNTHpGdhOgD+dt2GQ3QKSn26poFFdY7BWs6ITqZ0Jj
         VhkVjUvVOhMtyAXu3TBQ/VmdYaZAD/Hgdx5uVaFFIMClcdBPPeQvvY+QZRB+Yd6vuRKB
         xyNPnXZGyXDWGpsWZ/VdA/45gpBPzkFJrn242l0UAb0qtJltWrA16YMyhlUvVgm3SYWl
         RxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772387996; x=1772992796;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUriLEKIKpf7k3NxTjsJxgBlXx8URXMNCEQZ8pvmz+I=;
        b=mrPlEE6LQuDnO77b9NBQ/La07dMGqB6HgDEukLWDjvVD998PJOCouldyA9pZ266dOS
         fxvU5LlcxfaW7hU6qI674qZn84xo6TwTqRK2jcIpVyIMtl2wDNnRm2388R97Lb6knhW4
         Hu3TqHRY9bbvLLsGOexKZY9lIdO5sFrmqevU0MEncjCAON6AvIoxyb2G66UlHW0eogPz
         9rj9Hz5N66q5m6Bz1q7wM0G0n4GFMGLhPQfxJaUpy691HuzffU/cWeXkbhZ1AaUxh5EL
         vdSvCouFjpfe/8rR8oTn+N8tLgTaSLMWdLDgjZESjrNKNaIARLNl5wWM7ILBPgRA/ckp
         tsRw==
X-Forwarded-Encrypted: i=1; AJvYcCXRt+2MOCQvPjGsxsFhfg54obFe9+x+5eLUGdX1TIIYsF37lpuKZ75FHk3u5weWXNBCfUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQk+7Yey/liHOFKcWApNw2g1LGeqjA9Fb0VQdZXVe7PGUnmBY0
	+hkEHgA7ny262FQSj8iIvD4F4RN6/zkjfyFXLMpoh/Wcm9LhQtx+A7ozYQ4/5Xirb7Q=
X-Gm-Gg: ATEYQzxP0RdpHns4fpg8+65v03mS1g8MOyzCENp1qOPIX3MzNlCMbLWRdjbzfyAvfg/
	pTwgrs0DSNWljzlTCLGAojSUcVGOah+aLHXTzFvWTUyM3Su5Fcqcmr+TpZdZ+MxZVZVoRG4duyz
	AefPhSvMhjqjYCFpi0rQOCuGQCK/i8NwdYWLHkPHCoRZjW1NIdnMsZfSHz0Bm1XEYxzXvqNnzEX
	9G55mgC4FC2PXdIMEatAG6EhZYuam0rm8TMUC5WdCD03e/2ZfElCEm5bQSanwodBZ+cv11Hc38W
	F8duksBUiKbQVh0HMrxEofnvBKsX04jLPdu8K6d6W9baYW2e7UGR9ebwUUIskHgHnncoWKki67B
	Cvbwwu/q1oC2JgPkSShgDHWedPyfAJau2wNdiXhVtn+FV/FwIr99/Ihh0ZUV5LoN45WYjxAtMDl
	/ohvtYguMiJu9yuOswG+1ymRRUv/Y=
X-Received: by 2002:a17:906:6cf:b0:b8e:796a:fd5d with SMTP id a640c23a62f3a-b93765110ecmr474922066b.39.1772387995610;
        Sun, 01 Mar 2026 09:59:55 -0800 (PST)
Received: from cloudflare.com ([104.28.193.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec3ea3sm381222466b.57.2026.03.01.09.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 09:59:55 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,  Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,  bpf <bpf@vger.kernel.org>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Network Development <netdev@vger.kernel.org>,
  kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 0/5] skb extension for BPF local storage
In-Reply-To: <20260228155021.1dc9b127@kernel.org> (Jakub Kicinski's message of
	"Sat, 28 Feb 2026 15:50:21 -0800")
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
	<CAADnVQKVfyh3_OZshvYf7GJUF-ph2eMfmaQsxNgwBJd1AJgXTQ@mail.gmail.com>
	<87wlzydk12.fsf@cloudflare.com> <20260228155021.1dc9b127@kernel.org>
Date: Sun, 01 Mar 2026 18:59:54 +0100
Message-ID: <87seaje8h1.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Feb 28, 2026 at 03:50 PM -08, Jakub Kicinski wrote:
> On Fri, 27 Feb 2026 21:11:05 +0100 Jakub Sitnicki wrote:
>> So to exhaust all alternatives I gotta ask - would you and Jakub be open
>> to the idea of a plain byte buffer embedded in skb_ext and exposed as a
>> bpf_dynptr?
>
> I'm fine with that, but admittedly I (like you?) live in 
> the comfortable universe of controlling which .config options
> are suitable for the narrow use cases I care about.
> So I don't really trust my judgment. Adding Paolo..

Good point. Distro's would have to pick one-size-fits-all which won't
work. This needs to be at least a boot-time configurable, which looks
doable with minimal changes to skb_ext setup code.

Thanks for feedback.
