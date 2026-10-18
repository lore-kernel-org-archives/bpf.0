Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF83D88FA
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344511; cv=none; b=O/3nSAsPHXuk4l3ObVCbznCfUPI0QFUsV6p2Raky9AC1vnBOHIyyGi7rWboEsX5DAW9bKLzPphVQ8alWSmzTx/SKOkkPWyAvazbcv4fDsy7t51zLfEzLzSQ2VhvFDaeE/aQH6WOWhoh0dNBHC96LugGI2l2bGj7w2BjVJ6nFeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344511; c=relaxed/simple;
	bh=GqnVpycvp/gSL0yInzS41OkXSX2S56Zu2D2P69MnKHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5KpmGz/wcTMtaqFGw9RgMB2Ul381pX6JjrOwxbN0cUQCtS1ypnvkk91L++u94BXXmqhijvK+3aQBNefDPUyP0q8lBI8t1wkOdJA+pefnAxrm+us8/edRvche7rzgNWekVKBlYmY5yt9dVlz5/mLIzZDAzCTxMriMA379rq303E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE9aUNhQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE9aUNhQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1e3098ee2so5323815e9.3
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792344508; x=1792949308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gK+nm4guBVLWEst0QUYTIzdz/9/IYVNbhQShbRBd2MU=;
        b=JE9aUNhQtEw/+uE/nXr20cOhX9F9SEdCCCFaCQfJzldmPr/ah2r84dGHQ4EiROr8LK
         3JYcs//eZY5oXDYGcB9HdzQ++P6RUGsePeLXI+EW8C1FKzV8DZkr1wNzUfM6qFe7X7Ry
         AuwYwqYi7zLvdb6JIgtzxPc3an8QI8mDOS/LVKYGOfwrFvzaEtjGAXiGRl+n9+kjLf2l
         1iU1ZeWTmyGpfR6BY1QYSyJtCXtrNH9vqgiehOfXYiycKL4Rs8Elc+/YTecIY24FmncP
         +tVmqrclvphGhZMF/B0XhqD+zvv4a3EWrdxJJGKNxyd3nmb0/wpLfRjSxwkzoOPRhEwC
         wVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344508; x=1792949308;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gK+nm4guBVLWEst0QUYTIzdz/9/IYVNbhQShbRBd2MU=;
        b=AuESv7ETR3bw+a6UHJA1g7TmaxbBooi/Nkpb/GEpi3AGqjI0bZ3GhNOEj0YLUR6et3
         nO3Bh7iek7l3nWaYHfJl/fGc/jarDX6YjjwqKyTNLRziNuskL2KB7RtsaaAnU4WOmdYH
         sSakcOPuWvqYj4teCa7bjZv8OFtBwzdnC/NNrOLnTt62Y7x39Fib3WjUBdzMwW9TDEGs
         X+QG0dW/FqiwxV4PchsczpvBAs5Cbgd6bXi4UZDlRCyC6VS/XiZ+3K+YCB14mP72/Uwd
         14C4PD9Lqatl4mKM4d6D08xlsEo1mOG69Ydy8dADJUhxkNFhfrXNO30fvFNYkRYEfEfr
         hdEw==
X-Forwarded-Encrypted: i=1; AKwUvByMLMVpH/PeeGpyS5lx2ozUCXnKsy46ErggaQBIs2JDrc41X1GO9hjCH6eaZIc2gyMWVVo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKdU7jFujbTJEcggn+SoccwdjdaYRWyJe4EHEkXeqcQWK38Oq7
	2b+v2p6SkRhHr6wDA7IwPjowsnnUxOH26uBxhLgu7EbHj3gHQHOR0taJOTb69o4f
X-Gm-Gg: AYBFou2X4eWf4InOEtabp7FVnAUQE+9zcYv6Ae/NgNrAXytt0dRIsxLezxVU4vzSkGf
	5jLdgdv7K5y3Caw8R0LH8Zklq8pcj+uIXyDK2NnmwCHnTmE7OY3oAia9uJlxUupUmllK2ZOSpXR
	cE1Zp4jBtV50YBb+uc/e4KPVHb1ICaz4AnHRESp962p/D2LSKedO/nldw+/uNNOTPEwmtgDyZuq
	8NsL+giuFybPTxv5btKn86D/EyIEidmf2QF8GwhgOIaGOAsZ+8XHfddO9vhf3YGluqQhMHEqsFR
	3L1Eclv2CuYIRasSg0FOY5Q0oZy2ffPsdgmEpV6RMubPE8Ks8SdpKM6VH2MG9GZQUVP17azw+G4
	HjWKiBgtdpw9xyj2SzwJ8pK83j5YhlhT9pyPHASWsP7Sj/uMM06gl/Ii6GUTGAhlbyNnXSXtWVy
	5zHYK6P9Lvf5DoA75M14MIOHbV5v3CzRK/T66wdJCuHlTXM0cVKP9a2bj24uy1cUEPfJai3dECT
	N57OWPfoAMUDs5Stf4m+sAMqnPOTWxxdh0=
X-Received: by 2002:a05:600c:4ed1:b0:4a0:2500:2cd0 with SMTP id 5b1f17b1804b1-4a1d760381fmr116248835e9.18.1792344507529;
        Sun, 18 Oct 2026 10:28:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8a81587sm412237035e9.1.2026.10.18.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:28:26 -0700 (PDT)
Date: Sun, 18 Oct 2026 18:28:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Andrew Morton"
 <akpm@linux-foundation.org>, "Petr Mladek" <pmladek@suse.com>, "Kees Cook"
 <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky"
 <andrey.grodzovsky@crowdstrike.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, nathan@kernel.org, nsc@kernel.org
Subject: Re: [PATCH 15/15] kallsyms: scripts/kallsyms: Improve compression
 by about 2%
Message-ID: <20261018182825.3e407c81@pumpkin>
In-Reply-To: <sashiko-outbox-176259@kernel.org>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
	<20261018155206.132411-16-david.laight.linux@gmail.com>
	<sashiko-outbox-176259@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 16:05:10 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] kallsyms: infinite loop in optimize_result() on self-overlapping token pairs
> --
> 
> commit 36121744ef0b7fd951486247d0297f67eaca31d8
> Author: David Laight <david.laight.linux@gmail.com>
> 
> kallsyms: scripts/kallsyms: Improve compression by about 2%
> 
> This commit improves kallsyms compression by expanding infrequently used
> merged tokens back into their original constituent pairs when no unused
> tokens remain, freeing slots for more profitable token pairs.
> 
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index 8576fe6ad90b7..9dbd7c85eec1e 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c  
...
> > +static int split_token(unsigned int profit)
> > +{
> > +	struct token_table *tt, *left, *right;
> > +	unsigned int i;
> > +	int best = -1;
> > +
> > +	for (i = 0; i < 256; i++) {
> > +		tt = token_table + i;
> > +
> > +		if (tt->len == 1 || tt->refs >= profit)
> > +			continue;
> > +
> > +		/* Ignore tokens where the original parts have be reused */
> > +		left = &token_table[LEFT(tt->pair)];
> > +		right = &token_table[RIGHT(tt->pair)];
> > +		if (tt->len != left->len + right->len ||
> > +		    memcmp(tt->str, left->str, left->len) ||
> > +		    memcmp(tt->str + left->len, right->str, right->len))
> > +			continue;
> > +
> > +		best = i;
> > +		if (tt->refs == 2)
> > +			break;
> > +		profit = tt->refs;
> > +	}
> > +	if (best < 0)
> > +		return -1;
> > +
> > +	uncompress_symbols(token_table[best].pair, best);
> > +
> > +	return best;
> > +}
> > +
>...
> 
> [Severity: Medium]
> Can optimize_result() enter an infinite loop when find_best_token() selects a
> homogeneous token pair best = PAIR(x, x) that overlaps with itself in runs of
> 3 or more identical tokens?
> 
> For a homogeneous pair PAIR(x, x) where LEFT(best) == RIGHT(best),
> learn_symbol() and uncompress_symbols() count every adjacent pair, so a run
> of [x, x, x] increments token_profit[PAIR(x, x)] by 2. However, when
> compress_symbols(PAIR(x, x), i) replaces the first pair to form [i, x], it
> calls:
> 
>     adjust_profit(RIGHT(token_pair), idx, p[2], p[2]);
> 
> which is adjust_profit(x, i, x, x), decrementing token_profit[PAIR(x, x)] by
> 1 for each triple. As a result, compress_symbols() performs fewer
> substitutions (refs) than the initial token_profit[best] passed to
> split_token().

(Well done for spotting that one - it got me confused at one point.
It is one reason why calling it 'profit' (historical name) is wrong.)

In theory maybe, in practise no.
There are two characters that get repeated more than twice (and I don't
remember seeing any repeated tokens.)
They are '_' and 'm'; "__" is by far the most common pair, "mmm" appears
in _commmon_choices_show() in drivers/acpi/platform_profile.c
(and looks like a typo).
A token is allocated to "mm" but there are enough different uses that
it isn't going to get split.

I will put a check in the next version.
(probably just avoiding splitting XX.)

David

