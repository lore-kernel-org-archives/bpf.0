Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8947F2E9
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686254; cv=none; b=ejuHvafEqyQ/W9pUKiyAeyA+ra2d2zGT6cgcokQYQFJD8nQjLpKcvxNr9gWS9QgWnARtKMLOYq+W6lKw3tdO75Tk9sfp9Fl4GsECKGjAEhOuYaa/tKMh8LcF2PijbUEh9V+vE9N5m/drlZ+6Uh09LR08fhulGyozfYNS9knPKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686254; c=relaxed/simple;
	bh=mbuD0JF9KaUEuPIUs6xAsmmDkMJ/Km6xGJoIuowhhZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEs3FfN6INkhvJiYgQEBGfNf9UV9YAIaQMD51IiJi6S9SEipCy6zZq6+SrtGV1VpYdFcEQhuBfpqU7F3nJ4S7KaDUUy3NKP9qErDRXEnM5tTsH0Mfx32l59kbdUNMh1p5646eyQ3n7aAI66LzDu5t8YNHAD2OB7Z3x+NIqPRsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9lgWWYJ; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9lgWWYJ"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-366087480d8so6247022a91.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 08:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686253; x=1779291053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WEkxdb5zhixaN862xcykga1EtiV0FhFLsCrfHJvXPCk=;
        b=A9lgWWYJz8SsdDXQcuks5hSiwua4TwQ57+MERJGv+1wSGHqiDnillQHdQWiesl0wSz
         ukN/lZW33ZjcgHL1cSPcqubzLFGDFg16kewwnXMHYETxpX4DWyIkqIKSQ95ku9/Vd9Z9
         1WKbZbfHf+OHHSxN2W3SQG9ENGB9y9HlwBPZQeT/ixJu1FCmd62KxatTUxS07TMpll9m
         VYgBlUybt2BK/JuyCGkSLRdgipUp7DTjIV5jPd0d/KytGFGp12UrGrljj9AKvMV1yv6y
         AARG7OfRTn/RlMW2wVdVVi7vWAwLH2QgBUO8s7+TzVCR09yPoIF1OUWrTuSXuubKQO+b
         jSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686253; x=1779291053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEkxdb5zhixaN862xcykga1EtiV0FhFLsCrfHJvXPCk=;
        b=G74OYNYVWwPLUutQxdjg1Nlch0itVp+vTSCdVVetSeKX5sEMFz82Ix/HtnnPBr9aTy
         oQo/2vBwgEp2JszJ7uJJVFXe1/tXlnNWpjQVn5QSOEq2d3yakR8WWgtHcW6KnrwChBkl
         sykQ1BE6jTjwwDWpZMRhUI52MP0ctwHTLMeOsVq1zg8DNnBWRRZ915LpQHYNGR94POeu
         62BMabCMvwxYUJtTvWrV06Jucixo3MhsTicsmMcIUyHJjLbLR2CUgu5BtORHuR+gN3oI
         J131QviCLhbnhNKGjaAnXLt4d+m9W5OzqUzR04TbmNMDrKvwgbo5P2I9OJnN/1snrJ49
         54FQ==
X-Forwarded-Encrypted: i=1; AFNElJ96HTm0vR2HKPBOri6jBFBHIDOsaC18+XVugzmBa+xUhjIcTedi5WqHIuApIwyFqkq+POo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy3XX6/RpGNHiZjRt/KcQ8POXlj58x9BFA32ZfbN5OcnE1dDye
	/j/81kT4jMFtvVmAuqWdZ5sjaxY7kqukHd2+et1fOYpj/0XOeJ4Rq0Jq
X-Gm-Gg: Acq92OFPCZo7C4EVW92iW6V623ThY/Xj7HBNuOcgPYg7bRgjE9md9kr5wY0YZjThZe1
	68dkVp+DYWgyoOPkJ13fJpHQFgW8n5NQex/ZzsPxbVnzM7MWngT1/xT6IlptZqguIEP9pHCqEC/
	SI1ifj5Edo8X27sQtoGe1FwOHNB0GLFvYEOT4sR/0/ansqPQtlE3F4olJaT/64O5xWIFehgxtsT
	4TJ+CC/HRb6Zz/llFC0F9RzkvqN80vzkeyreEsxd6uedPXzsOXWr+K2KzvzTj7dafIVouyOEjkV
	pefgyM+PGC0OrUfdHsAYMLaX/1LZGkWi1/WdkWwCJEq/fhtcaV/eLYmt2lq25bLbgKuWpTp4fR3
	IkaaZ+1loLB94pPpLmFgP74Zi1cVPkU8ll3k5kCo+vvTO6Fd/oFXr1PaopgNpoJl7NOSQdUzaj7
	88v2tv8qsQA8d+npI3
X-Received: by 2002:a17:90a:f946:b0:364:e97f:64e7 with SMTP id 98e67ed59e1d1-368f3e69a23mr4490008a91.27.1778686252746;
        Wed, 13 May 2026 08:30:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf4d95bsm4782439a91.6.2026.05.13.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:30:52 -0700 (PDT)
Date: Wed, 13 May 2026 08:30:51 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 3/6] af_iucv: convert to getsockopt_iter
Message-ID: <agSZI50mjW_1q5ia@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-3-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-3-fe7f0e756fac@debian.org>

On 05/13, Breno Leitao wrote:
> Convert IUCV socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
