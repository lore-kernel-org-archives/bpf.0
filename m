Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CB4A5EAE
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842920; cv=none; b=Vqym5ILFU3ea3iIVEqCPj/dZegl+xyL/SufuJqhe+wYlAy0BMcAM0aC0j0a6BciYzLtF2ZTzXdQgFU+GJszxe/H8p3SgBFtpmWhbb36tqER8OwG5uz+Kv1j3P3KmFSdeDOhAkSrDLpSTWwQDdvh1R6iN1SJqwma+gMa9JTiLAKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842920; c=relaxed/simple;
	bh=SFWYPhaEGj3UnxBHEe2gf32Y8aVtv6hsGGY2LkfRXaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw4HEzqMNNTEay8zGjpyUxruqkj7cx3yVFUuAfR/afWSn4cI1wqlWWFkUPzBeK8lotEFj/F0kUVr7KIFsFBbQtEhXrH5l9h8Ei+nMhR0QouepkjK7qF3ogh8Sq3A7b70cCeaLNSHLwZcUmUxxVJ92Q+FHhlu7mQ7Je2c8f/R3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQw6RjaV; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQw6RjaV"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d8239so50105565e9.0
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790842911; x=1791447711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YVIqIlAeBaodz/jKHUPLRi2NF2+TX33O2kKv6cYqX/g=;
        b=DQw6RjaVQHBZD01xAfg/34C4S9kUsnymCITopTWkK9FRLcMGXcipdx63ivh514e586
         eNWWjdYaP2szyyTiOMqYPDSXoPMBGByEKLhflxEyPrips8OdDqjubb5pjv8UCuRHY75N
         nwo8TCbXUQTYuzCAqnjs9dTR02O4jxlKoxlEw5BA6iKH8w6nhl3hkzsHJyJLVtcU7fNw
         aqFgzqx5/cS+IYMbYENy0/fUVb1m1p68cY07E98HnL6YdPHr4AE4dJSvjabpVQ5qNLJ2
         0ThM9fzOzPhwsDeqVV9txmNF7teeK6nfpBdt6pZS3cO8KCg/+NZbfxWpgq59j1EYZKM3
         +0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790842911; x=1791447711;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVIqIlAeBaodz/jKHUPLRi2NF2+TX33O2kKv6cYqX/g=;
        b=rSw2zCaLxbwbHMBlgJyo2MEHfzVH38Q6ltbGfMByel4340h5ndigbXfcTAIItVr0wy
         YCwHCfA4EJf3+r+4IDupp9CQbhO/u0s/tXLNRpupyrZ8RJgJswxV4UujBEy9pluxiWUV
         Fh9koPIF+OupoBDD+zKVO6EDYl3pg3QzlypDG/Aptc51R5gNEulSnlbVJ5X8ZX2ZV/OO
         L04wD8E5VFBqLezIhJqcWUrgOaR4/weCefW4Qvg1O15KsjKRfTS1Pae1UO7nnoDbjaPH
         /CmFCcvl0ZlTja7u1tbqep/yeyRvWM92YpYzUX0HYCdlt1wHnuzhWKVSdw9xTnbHrenr
         aSGw==
X-Forwarded-Encrypted: i=1; AKwUvBwA46nUrcLwM91fbJypRylDEGaE6t+Cd7Dq79qwL3smwBNWp0XEeu2gtmkIRIaN4tin0ac=@vger.kernel.org
X-Gm-Message-State: AFuF++lRDXqogY324vTTDKSgFAREB2k/7X488lDwb4pW3bim6UJcpXh+
	1vJD8hnqZnJzKKu/QFIekN+IHAsLCjrn0ZutWsINC04NReWEQl+e0Hsr
X-Gm-Gg: AYBFou0ixdZxkGYbtfU24tuyJHb9alLOtpZBIfQ+4QiyTNSQW5qBCgGRdaUCdcpvwWC
	pOMdG9FPzMlxCE69ygb2Tefgw/s9iFa/QmsDvRtOpUcJZvazY/Sqr3/RTfMUVLmdgiQYfQD7jwu
	2FhRyuGS/T/6pMcJRXNsZRIUIb1KcbzzLAQdJmwHLDz9slugZ3WjU2G36aMf3RiELq097bY1WZS
	hnepPzIIKIg+XIKJXptr4oLHU28oS0jfrOS3jbFOznIvxvCAO/DTFB3Br1KxOoPIkVlLs1NUSds
	+f7VZGnBjAhr94Wf9dxuMbYb0E0x0rBFoGSpMN9Xpp+hc6SEtCoyC71ASzoDkmu7mMcEOqXJVNx
	Q0d+/9h9cMd0QhlBoSIVehSx/ELrQDd7e2qRnQolKy0f5ICkYnuk293scF28cAE04eelnXk+Pz/
	0mxYy84spk425CBfq2RbBaetevEYMgdgPWJfKB0d4n9bWPnF9P9KakUH201ayQ5tmYp50vIgZRI
	Z8vcArwn2IVx8dMs/wXIJND6YWfgMbq/14=
X-Received: by 2002:a05:600c:4e56:b0:49e:8377:c880 with SMTP id 5b1f17b1804b1-4a01b00ef27mr71316935e9.33.1790842910996;
        Thu, 01 Oct 2026 01:21:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6ef459sm36030645e9.1.2026.10.01.01.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 01:21:50 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:21:49 +0100
From: David Laight <david.laight.linux@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, pmladek@suse.com, kees@kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 bpf@vger.kernel.org, jim.cromie@gmail.com, ljs@kernel.org,
 thunder.leizhen@huawei.com, mcgrof@kernel.org,
 andrey.grodzovsky@crowdstrike.com, rostedt@goodmis.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
Subject: Re: [PATCH 2/2] kallsyms: Optimise symbol name search
Message-ID: <20261001092149.22e07e90@pumpkin>
In-Reply-To: <c26e2afbfa2cd71b2cf8bb0e963bb1d67dc5519bb5c4307c96b826ae5fdce269@mail.kernel.org>
References: <20260930132109.260597-3-david.laight.linux@gmail.com>
	<c26e2afbfa2cd71b2cf8bb0e963bb1d67dc5519bb5c4307c96b826ae5fdce269@mail.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Oct 2026 00:45:19 +0000 (UTC)
bot+bpf-ci@kernel.org wrote:

> > kallsyms: Optimise symbol name search  
> 
> TL;DR:
> - kallsyms 24-bit table struct may be padded to 4 bytes on ARM OABI, giving
>   wrong offsets and a possible out-of-bounds read

I hate ARM OABI :-)
I think it is the only architecture Linus still supports that aligns
structures on 32bit boundaries.

> - weak table symbols may not read as NULL on relocatable x86-32, so the wrong
>   table may be chosen

I'm not entirely happy with that bit of the code.
There is a conditional in every table index.
It is crying out for either a static branch or just compiling the file
(or selecting between two object files) once the symbol table size is known.
Either removes the need for weak symbols.

Anyone know if there is 'prior art' for a late compilation?

David
