Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4450E1DE8AF
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774482690; cv=none; b=a/MbSlgZP2LC4Cpz8C+I8BWcmO48TT2QgOaWeNp4i9iKWpOjZDbOncBDbnAjHjhMKRvZjRfzMW7qPT0Udtu3uKmB8FdEgOs92apI2inab076j+c5488O5sO8RPNf2Zy5rDqxSHOutOl7QSZKxhO0NC+Hh83zJtPTp6/zvSe5pWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774482690; c=relaxed/simple;
	bh=YAt3/r8l2LEd4nzKpkbSZBWOggEru2UdGET+/GR0VV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvndRo5BS06+yQnqo0T42/R4/JqbfVQaP67OgFFKRXXnZerdvDlsKy0UWmGSDDeKhQF1JbBeyyw5T0et8MGyPUK99c/nMSFe7emsJetu1BecJ58muNi5VulNnvHrlgLLAFLoyFhDtYY1cXJfeOZ+0zPSGC7NBMWdNAq0jFGOTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyNoco9q; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyNoco9q"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fb112c09so3958905e9.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 16:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774482688; x=1775087488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEom4M+gm3y9BjxyaHRPylsbX/xdQ3PmofFXCETOxK0=;
        b=hyNoco9qBX2JrD7ywA0A6DPugIQXsR9fPu8zNFUHbNDMgFAXFO/eBqVNYP3Ak7RDPe
         c6FKRe2jtNtsWmnjCdItpA5a6TDh9gL6qAJjiNQVvhUKkM0LeLcIHYgy4hayDKmu60M7
         p6IRCVOJaA/yRSLtiGY2PK7i8/WySQQuNrAnKHsI4GNt5fs54UI6poyxhsvwh15tFE4q
         Zu3Q35+6u0IvaMPMrpb0ok5nracFuigaE0oMyzshhxsW0bboW6d1fJ5sn+ZLRPipss/n
         lE17Jttl9L3BQ8OQ4/xUc51wWNR76TkFCwdyPopjLDZmzMQQQFIwLcJTWLt+9h0tgTe7
         mB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774482688; x=1775087488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEom4M+gm3y9BjxyaHRPylsbX/xdQ3PmofFXCETOxK0=;
        b=N09lH3E/n+lcR9Tp4FAv8PaL5y1wosewvZZWJjBnXG+w5WKZJoU2s7kLiLX+jB9YEo
         SC0D5LN/jpoKoaYd1pjDQzfOx//0fRmhsC7fx/LVjmW3+cP5f8/XHRpiGZUuNtlTcmQN
         knI1iHO3p86n+W0KQuguqoOJdNqHsFttlQOfX3EK67Pgn1p9u2dr5D/jyRTmM4wzkBmM
         Ju6sJX5ljDjOZz+B0cQfWU8m2WhbJ7Tb94zrcieWTg27giDwMlr2XYNH2jr4KLSNm4l1
         fRV9PyNhH+NczIXM2gs6nsmYNZIQzkJrnDc0ASDjI4HkbdAXh7WQUOA5bo4Ystx+SASH
         lafw==
X-Gm-Message-State: AOJu0YzWgtur6vr3xeG0l/igWVQbxWKTFNhdwqIDpHg3b6GFiFCo76vv
	r0j9q95tVvRx5m8vRNDso6h7HRF8w0H26tPkeSHxQFMwqg+ixJdLjCmE
X-Gm-Gg: ATEYQzxuV3Z0J6cO9SWsIXb3KbpvL7fXSKHgKyyL9whAYaNP8Apg83b2ji5LyvMfI6q
	kLDyFtYtiCXt1Wo9Sx1lyxMeQvafzebRBRa/sQL0wCTNNOKBsUT4brPi1fUH0B7Cys2rf5PvY10
	4XN+RTdh1uRWiv7zsbd8ytoABv89hWxhQdoCeInW1ztVVHN2wIF31vwv7cgPYIXeZcX5BXjel6k
	ciDnddIVrlqRE9TjB0wGIZu7vLvk7KIZq4hEGpSfbivstEbOLa9rctTJSc2/1ujeLqdKPTLpJ8Z
	EkFYsVCQ69z5Od76ep8J01nRZDgPSxdhxMNGh2gk7uJWg704rxmrXmV+KK5zgpupVwk0wNRSPro
	DbcW4pYFXQilONNlttJJM6VGaHbaVtZSSs9eUQ9Gh1JJq4YibQqs+kBJH9DuIDQAo/ZTgkrDCRF
	H5I4IYa9o5vyFmANtOd9FIjw8lwzqKBCGgIJRvkW7668XEp4D3FPSfVYaZDYcEaXx4h+Pd7OIAT
	6WCdMwAwQ==
X-Received: by 2002:a05:600c:45d4:b0:486:fbf6:abd4 with SMTP id 5b1f17b1804b1-48715fd607cmr80731525e9.9.1774482687293;
        Wed, 25 Mar 2026 16:51:27 -0700 (PDT)
Received: from Tunnel ([78.241.179.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2bdsm3456121f8f.21.2026.03.25.16.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 16:51:26 -0700 (PDT)
Date: Thu, 26 Mar 2026 00:51:24 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v3 bpf 0/4] Fix invariant violation for single-value tnums
Message-ID: <acR0_ORJWmaN1L2P@Tunnel>
References: <cover.1772225741.git.paul.chaignon@gmail.com>
 <4e6dd64a162b3cab3635706ae6abfdd0be4db5db.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e6dd64a162b3cab3635706ae6abfdd0be4db5db.camel@gmail.com>

On Mon, Mar 23, 2026 at 11:02:43AM -0700, Eduard Zingerman wrote:
> On Fri, 2026-02-27 at 22:30 +0100, Paul Chaignon wrote:

[...]

> The verifier produces a more precise result here because of additional
> information inferred by tnum_step: lower 32-bits can be equal to zero
> only for r7 value of 0xffffffff00000000.
> 
> Which implies that reg_bounds* test logic needs further adjustment.
> Could you please take a look? Please let me know if you see any viable
> routes to amend this test.

Hi Eduard,

Thanks for the report! I wasn't aware of this slow mode. I'll take a
look when back from vacation, on Monday.

Paul

> 
> Thanks,
> Eduard
