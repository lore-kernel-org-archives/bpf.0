Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F57369225
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932832; cv=none; b=ANvmASgmvVYa4MYIlOHV62exUlukobLwBjc8XwkN/8spP+FAgGVJyCWZrzuQW32/4a4Ul6+njouzagzdxd5/z5LKq2RfUkC0RmZxXuRenIxSYyPRLP9cbc+Cg7jh7FJrgP6j9PwJkm4KzjtcmnaYwpL3DND4HJk2JmBMid13G7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932832; c=relaxed/simple;
	bh=Ot776AQEnwzzipAjY2N7MVreYHcquqifTPrfFr09PEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alC9hYqYkM6D3iQF220+9Ag4OfJTWFWJ7FtnnXrCrSKh2RWDYVMehRIW8gFD12xLUK8ecRYNxeJSNnW8QYd9RvH9U1MdreYjt5HpcFAdQWktSZaAZj1VdalIajgq5FcKkiwN4KzGR2YDyGjoraFeHkgGjNVrHW4agqJB7UbtbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CiV9jQ2q; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiV9jQ2q"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-674a44b84fcso8093517a12.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776932829; x=1777537629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnn8KxOqoWc7vrekDQprtXmrzTT6cTAMj2Ji6IyRu/E=;
        b=CiV9jQ2qzFzAPolRAFxQa8rxVVL9qozcHhlTAgdzkXe0JiJfIhDa2bouMEDw9zjRit
         IbfjzVbSYVS0HgiaVadWRBTBC2JGEM91H57vXeSPortTnpfJMxfKky++keZ3c/A9mDq5
         npw1nAj6wWKMdHA5im+0WGPk23Ozf65jYFlHfFTU91EEp1vx4DcurXpTSR1VixXzEhf/
         us617O26dkkD5ovv73AzK+YRu3yQyDF8XieUwC3iI8fRU5blSOpKQ22PuWr7WsNPNIiV
         7f8PRdnYhX+HpnXSDlUG0V03ovJDHO9xWFT1YI+qJmulB7uhohmAY5INeDpA8RW8MieG
         UlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776932829; x=1777537629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnn8KxOqoWc7vrekDQprtXmrzTT6cTAMj2Ji6IyRu/E=;
        b=nn7KwuaImZwFxUXvMwpMVDiyGTIHYFT70vJxQXmEcusPsjOYl6tdqewNZGPQmeMfdd
         O+7+OFf7OXYVX2KQmuaaFX6agRD5I7TCfn+hz+u5TtzsTd0HZd6WpfT0Y+/DRskHw29q
         QV0nE2xOb8mwKtwvWaVOmKCLQ6iunJZ21B5I8cFiv6sXjjvXrw9rD4j06wI/3M6c6iUt
         CoSne1y5rWjrq/onN2/gbQV00wSpUREE8hWfUeoCMYo+jbRd5Qe7FZsd0DO1YjSK3lUX
         7vOTzPuBaZ9dJVQXrfsZ3nK7DmrLAG6HzEe2vSyCfxCyLnxu5bciv6GXYOpvzpSk+f+G
         HuRw==
X-Gm-Message-State: AOJu0YwwP20qTp06M2EKEFboL/pugyezaAdZeJmxIrrJWYQ3mQDFtohz
	Ez9aPfU1JbXoQ3N63VqkdEHqFRGY5KoS5i9oNSuVkeyNeDKEquacTevuq1ZYqgjetJD4wS3lVIb
	MSnafQA==
X-Gm-Gg: AeBDievkfX4GvisEsRHb2PAMioAEZPrveERQTAsJXol3CatquR15/3uX8CriMOuXYES
	ebI+UfFIpG1raMc6EQXT3omtHS9ZntRALFxYuBVIMAnjkXOTPM/f30LU/jZbF8B4yIFpIaJfmSn
	RlxQyQ0DLTaV4NSG27xDMc3eEY+IursyQ6j2bGrZ3oQjyRYIKmDUDiNtepvlLvKShBpCqnoZZgq
	fNoV1M97TPR/qhJgXcysvQiArR0x4zD8RBYMTPbcO3e+4NMb6yIp1Nj3QDK/Qf9dFR0F25Po9d2
	wtnhYeZ0IH1zcHf9F6VKK/dNGQ0olt5PMVq5xQUgjen0OR/rxll9slXjTUQOdlbIdwC7/HtRGTv
	1Kl1U1sL59SD5iwTT4610YBh6bBKR59c/qeeemacuCrChkK3TWQuhyKvsZqi/CScpDWBedzHmFo
	cOhpUmWSkUWVkvKk5z8sNizeAMDY0C14Fvw9N7/GpW4savgn0TMIrBp3aIGq7Uq9ILz/QkhFrK9
	CdAbrJra4NF
X-Received: by 2002:a17:907:15c5:b0:ba9:1431:8b7f with SMTP id a640c23a62f3a-ba914318ce4mr518030166b.18.1776932828348;
        Thu, 23 Apr 2026 01:27:08 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1db07sm650961766b.30.2026.04.23.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:27:07 -0700 (PDT)
Date: Thu, 23 Apr 2026 08:27:04 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	memxor@gmail.com, daniel@iogearbox.net, eddyz87@gmail.com,
	song@kernel.org
Subject: Re: [PATCH bpf-next v8 1/8] selftests/bpf: Add ifdef guard for
 WRITE_ONCE macro in bpf_atomic.h
Message-ID: <aenX2EGkEh2qG4k5@google.com>
References: <20260421165037.4736-1-emil@etsalapatis.com>
 <20260421165037.4736-2-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421165037.4736-2-emil@etsalapatis.com>

On Tue, Apr 21, 2026 at 12:50:30PM -0400, Emil Tsalapatis wrote:
> The WRITE_ONCE macro is identically defined both in bpf_atomic.h
> and in bpf_arena_common.h. However, the bpf_atomic.h definition has no
> ifdef guard. If bpf_atomic.h is included after bpf_arena.common.h,
> compilation fails because of the duplicate definition.
> 
> Guard the definiton in bpf_atomic.h with and ifdef to let programs
> include the two headers in any order. Duplicating the definition is
> the simplest solution out of all the alternatives:
> 
> - Keeping one of the two existing definitions is not possible because
> both BPF atomics and arena programs need the macro, and the two features
> are independent. Using one should not require the header for the other.
> 
> - Factoring out the definition into a new header that only includes it
> is more churn than just duplicating it.
> 
> - Factoring out the definition into bpf_experimental.h requires all
> users of WRITE_ONCE to include the header. However, the arena library
> introduced in subsequent commits must be self-contained, while
> bpf_experimental.h is in the base selftests/bpf directory.
> 
> Both headers are moved to the arena library in a subsequent patch.
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Fair enough:

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
