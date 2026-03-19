Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B93D523D
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926660; cv=none; b=PM1yT39swR5Lt3d9OFxVMqjPDBhtTdNLFf1u4PfVJrBErCFyTXKFLHrtY2Dfs7Quei8mrp6VuxfYB2jh2c7bpjlY9mq0cGXBZ/DzB7vRcjRuOHyXko3JlD4XeppYCXnko2XJR71Kdqyni3e2qHzjXaCumNMHW0crSuIbV/F+qGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926660; c=relaxed/simple;
	bh=1JjXQZ0Ix6V11YRCybUcCwN3aK889ehs17fGHxeZu6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlXfd0rMDygkis+Q6ooNTtFosG89ISYw+eBRwWXhnzzUz/fKAdHzkF6CZqKxmgpdK2zsVXiftfsH4uMaRX+75wSOA86GwlPkSaztqZuFC8ZD1kLeL/9PNh9ZfyHC4nVwjzhiPBkV5BgpageHozw96FlCiksW8ecJYO/zZr3nezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1SySbQt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1SySbQt"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso9833865e9.3
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773926657; x=1774531457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d9SdmRpsBlveThR1KIVVShCqfmaw8QF26GnYrjY2FxE=;
        b=Z1SySbQt/w4psYJ085Wf9vCiDpbpKJnjftytDOVksQ+hbHhztK9igtRs+uAOQlT9u2
         YvI0xyDKBBL4O2cqR7Z/EmgDfrgdJGAqk6eRYyk4827SsfM5w0+9mqa77ue8M/XD2oSt
         Cc6JV7UmtaSiTGaPZd06tVBpsWMimnFppiw8ovHfSVEPCWkL/Zy1LbFVZsTwyIjm90hc
         Wyuj5V45Dcu7+HZW8fFfmCxZi2S1WDHUjE+V9Umf017z+onfw5zv5QlSJNXaGq/Ns+zB
         1o4u3UGhpnaCMHSwbJkisoIOK0SIyalU9dG3uyFOMpHX5y6W2Yi7eiEc4GX1UxpJsRs3
         XJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773926657; x=1774531457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9SdmRpsBlveThR1KIVVShCqfmaw8QF26GnYrjY2FxE=;
        b=qb1A0OvjE+jq/J5ia5JQn9f2m24tKZVZLIgeRjJOJX/2BkF17roYdVOrn87DrkpWfP
         XY9kVtiR/vjk1S7XXJJGJJ8YsjaQjla7VuK2lmbS9lGKTq0kHctCDAYjc3j0pSOylNqy
         /6Q9mgDea4nWtEQdjZ9Y3QAiBW2TykOEL6T4lYxZb8RKTQFind9QN8DnybOkBgQNQT/D
         nrzbfSjezVZg3oR7pBlFspnUxPsSXXF69M2VuD3F+gg2L194+k1z9NvJvCRhULuI/QZM
         oMJQXx19FYpYlTXCZ34e8qAa21wVEEKKXs4z+FKgt+KNoNopcBP9NjugkKJL3EAyb7SA
         /wcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfZE24lQ5ezLWHa/IObn9OemWYu7+JUTuRYF1/RjOATCDT0jTWzGbGMgVTPk3g+2aKtlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLoI1EWCjAexC8l7Zk0LwcBLzlC6ZOxhP6FAxUIM/xNBa2S/T
	GuGKUPyT5Qy3bJEzs/STkqcmGpZvnTc9pGejCSAxizeBQehMBcOcAhE8
X-Gm-Gg: ATEYQzwycvr+ewNfHp5mM89/zQqHxn04JIP+1IFZgVpJv43DfxnGQ2+6uj2FD6N4SKp
	+DEJ3TVlq0k2NmztcJCkGFtZH2yAQ1Vm6ho9w1LGMoBNZ43Glq6aCRIq2RjtQw2/AMIvKge9HlW
	hWUKiIvIMRXc0KPfWjf9EiDJWKD5x2JC5t+RnFgnOF1vNBdiDPj3vepkyJBndAAojsCdaNCE3fy
	4F3drNQE3XJ0JN4ziixLMbJxJzqySjw9ibc100bYS/Hj96BYYU6gV7nUDEodxB5L5bz3YktNOOG
	A5znEqMraAmnPTWpNE98fiud+5v7EgwJc7UytRd6H2ukJKW07DQ5cUQ3IfLr/Fazw/a6OGk9PNM
	49tkV+ynXPntc4sGQx+IPNomS+/dexNeKnz9hgVg1YLYxTowy9JvCLq516R49OHdRtsFUZ+BXWM
	N6t8jI+VeDHWxOpaxTGiLqMWseCNikX16DyzqU8rpirBxie4zB/Wtm/6LtBwA81AjVDmt0XPSrn
	N93ZSQSWtSBwu01O+RapkFjYxkalIdfjM+XiDkvvXQwGy32soGywYJ6oCwNrSA=
X-Received: by 2002:a05:600c:1d10:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-486f4421c84mr109885025e9.5.1773926657303;
        Thu, 19 Mar 2026 06:24:17 -0700 (PDT)
Received: from mail.gmail.com (lfbn-ren-1-685-61.w81-53.abo.wanadoo.fr. [81.53.253.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8bd5f7csm69524715e9.0.2026.03.19.06.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:24:16 -0700 (PDT)
Date: Thu, 19 Mar 2026 14:24:14 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, john.fastabend@gmail.com,
	martin.lau@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Simplify tnum_step()
Message-ID: <abv4_pz96HWU804z@mail.gmail.com>
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch>
 <atwy3evusj7cjafp3fnrzgimj3dimcyuxasohegjc2enplb3cb@4l7i5hoe2ify>
 <CACkBjsbcv4woDZZ0_BA4idBwfLPXNTX7BzJMXTH54zq_8F0BuA@mail.gmail.com>
 <abvDSjl633b_Hb1O@mail.gmail.com>
 <CACkBjsZBiQdA-yKCAt0Ng_PRyQBkXFK5ymN0RXx2xG+uJ6P7PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsZBiQdA-yKCAt0Ng_PRyQBkXFK5ymN0RXx2xG+uJ6P7PQ@mail.gmail.com>

On Thu, Mar 19, 2026 at 02:12:54PM +0100, Hao Sun wrote:
> On Thu, Mar 19, 2026 at 10:35 AM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> >
> > On Thu, Mar 19, 2026 at 10:01:31AM +0100, Hao Sun wrote:
> >
> > Thanks for the cc Shung-Hsi. We were discussing it with Hari who's
> > planning to double check soundness.
> 
> Great, let me know the result when the verification is done; I will then
> send the v2.
> 
> >
> > > [...]
> > > > > -             res = w;
> > > > > -     }
> > > > > -     return res;
> > > > > +     d = z - t.value;
> > > >
> > > > A bit of comment explaining would be nice.
> > > >
> > >
> > > The commit message is self-contained; anyone interested can git blame.
> > > But I am unsure. If a detailed description is preferred, I can add a
> > > comment to v2.
> >
> > Not disagreeing about the role of git blame, but it's not a replacement
> > for code comments either. Having just the intuition in comments can help
> > a lot; as you mention below, it's one less indirection ;)
> >
> > In its current form, I find the proof harder to follow than the
> > previous, very verbose version. Maybe there's a good middle ground?
> >
> 
> By `proof`, you are referring to the description/commit message,  not
> the Lean4 proof, right? I was a bit confused here.

Seems I thought one word and wrote another :/ I meant the code, the
tnum_step function.

> 
> [...]
