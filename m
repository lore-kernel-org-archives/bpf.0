Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF1542EDC
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924758; cv=pass; b=RHukz8pbl8ZWr9mwU65Y1nFBU1kIqit6oD5XGpDzYSqU0HnLpirhcgh3mCxQpq4BRXa43AAxIE83GEikKpHiV7qCnVZ1paIBRkiQ5UrzMNevkE0n3VYz5lp0THYpv06YNT3/bHYiWztXytaKFFK2IC1M2lW5hrDwl9ojpE7GL/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924758; c=relaxed/simple;
	bh=/vVh4JekJSXHTPyscsLCDkMqYS00gf29hChLgo3TST4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiZKZMPT9vQUKkLZApMzAM0v6D345/oKiJPqLaaFZQXD9MiZtNUivt+yQGiIETxlJb7pg6yBXzZaYNTAmMBJ9GdXpBjDJMS9Y0jPVtx5z8kxmoTSsJ5PmAXCOsFyAZS7pFuF/l6DkkYiz10qYtxlgqvp66gZ9rKVViPVaP+TWaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2wOCwT+; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2wOCwT+"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7c4818e4165so2919273137.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 13:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924755; cv=none;
        d=google.com; s=arc-20260327;
        b=GretTr2GH+6yneu5O7mWdqdmYNrRzUknzydWUcAe8yrO52EGV5WMYtyhjf+K26WnjM
         lP/yK6aEWsliWwFe0s0OuUdfP7D1RBy9w6oE6mXrix51DFu/SfuPjS7HZojyNhtJ3SEB
         TZ8sU0Tm/pqKv/ZrEIE/ns4wJW2ZXaaPJ1DkHHkUrKm8scLHn/c82wS2SVmhfCmS/CyA
         ggb6srl3DlSMttcZQ115uO/xjqZp/8SPhtIG/ydjjTKtEG8uzydwD5Hg+bZDQsGaYc1t
         yTB/n+BdiqvcqfT9uGoZ2frEXg7GYeaH0c+3ptn3Qnw9328Z3qlLgiB52Ep3LZ4pR8tn
         7Brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rkhVrgc9OmPuX9zRiI9eMYevNzdxLtYphs0y5uGuLPs=;
        fh=RrXw/OHvpABWawcTOghTqZN+eJRhbOeh80KpkN2+BMk=;
        b=gzO+ID3Z91CFC7xcJtGwha/xUT7y+ZUtNhCSHnwzymZucBEL/3lr9KB7ZBypZoJ6ha
         1Le3RGpA2KxB939IVru4xyfFLedY2qe6Sx9bGzdllLZy1JxqPE46c3vnylgsdtmWqQgj
         FLKY3l/LcS+QQMdSJ/f0QDyNMdYh/Op/X/FVnAqbaQcV3kTcKFJciyT3X8+636j8FdbM
         178daal0Eoua7LYSjkojisrIp1NSVLGTMn/jqFNjvzEE3i9xBTGCZ2VjuooaCE5KsFlU
         KXE3OaPYDSrG0F5MsuQt1m6U0L0oCF6Hr0jHLJCG6aKQ5fEBnf6NwFTX4XslF926of4f
         vlvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924755; x=1792529555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rkhVrgc9OmPuX9zRiI9eMYevNzdxLtYphs0y5uGuLPs=;
        b=q2wOCwT+ztWfw9vBVnTNVbs79q5S5GB/c6SjAvezCMkrFTmEhD9SK7XFDX2jaI49Xr
         93ZMp2DP/vhqHSHcI9RWzDh42pl5FL2C+p3VBNzvC9nTMZ+JhujbAwGANk8vK9uHM0Du
         m7fJyAVlzFJoyfzZAQfQVoZl8i5o6J+tjULOtLqi15hLc1DpjwomKKtzDpmtzfvsyWUz
         yWzmAh0S19qVANRVnf9dEkTHWwC7JeStlMp6juSitFiiNw9UhXwwBp+jOwFoO6n9O0SQ
         8lYz6HV2I5IibYp73NCFh28+L+NAwg99/1BJ2nCJhQxQjP7LK5Y1hEvERZN1Dg+Bzv53
         2Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924755; x=1792529555;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rkhVrgc9OmPuX9zRiI9eMYevNzdxLtYphs0y5uGuLPs=;
        b=0wizhr4CB+M0I7PuYnSfQykzJZPFdL6FE0JTKpIX9oqe63RpVEFjUql8VfIrlhvuFW
         DI/nwQJSE7tkW0GwriyxZWSNGjj/MTm9Bg0ViuNNWeAw/b05eqJt0Q/eY3LsrJr0LXqc
         qkS1KGuSz16U3qIXcUOi4tAsEuNr586gHrSzoW+llKld8gPBnCbXs0I43p8tXOy6b/5s
         YAaBdM1HR6BnpulkrDNgoVq0RBeiBxHGful/381gq421nHBCjcu+FGb+lGoZd7ALpWK3
         5mzYwff/lMNqkVFdTflnwBJyj1kJFr7hhKbLgGSSCsKgKAUFibLokWp3woNSZC0fz2H2
         l+mw==
X-Forwarded-Encrypted: i=1; AKwUvBywQaE6BspKcTcyxsig/q/6XsT0R9ecINLKItArMLrTBaUioyPZH4Yt2TvGchzfEHpx17U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFsONKS4iUqP+ikOA3XXS5f4NMyl5QGhYFnyRwfElq0ml95x4U
	g6J18yReEibIch47Mme2uxW2/q6+1koE315SAHB8yerdSfMI9oJcSCdBeI0nZr5e5fmVMR0uuan
	Bvcwt0A5cO6RM/m3vqFE4rk0Ov8G+HUw=
X-Gm-Gg: AYBFou0eSJZ9U9D0a6ghjkC1MGM5PJ9rc0D5pRswQYLG/nbESQ5EB1SmcVi8ZJMK9B4
	Eydp2fekeXD7rXsGAz1OElwBA0FzVxvivkUgh4Lb919Tst8AiOg97LOWXcYWdxB47k7Z9L2Yiwa
	NJNY7Y6pX/Ly9KAS20sNANBVlI2OD/ltUP/p37C9uPoib2hT09YoBuaVhL5RF45NuxI1Lx/lgt1
	/xxCNs0lldZpx6AZE9F96elJPL98vkielfebREpU1z2U304Twf0f3arg4mg+q3Mb/pEUrNSp6l5
	Zk7dnIPkpEaZyD/6IstKrrsM9S3Kgtozop3OuLVFi4FfhOeVoBoRmWRbvQQq4bZJojtZCB3n3yX
	UR/N8S8u7tT/MNjnlNlU3N5Bm4wWWnKtyr0x+DMCy8X4z4+SaFzVeLlq7eRIQhj2ekPuLVhlF49
	LcwrQnS4jNdfK1IdoS8XBsRVCKw0wAz2w88WmZrcPi4+pu
X-Received: by 2002:a05:6102:b11:b0:7b5:8fd9:27e9 with SMTP id
 ada2fe7eead31-7cb42386482mr3026014137.2.1791924755421; Tue, 13 Oct 2026
 13:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013-submit-stmmac-xsk-tx-completion-v1-v1-1-f21b9d098e62@gmail.com>
 <179192400014.160550.9046457038671470723@kernel.org>
In-Reply-To: <179192400014.160550.9046457038671470723@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 13 Oct 2026 14:52:22 -0600
X-Gm-Features: AclHuK-F24utQ7hdbiPLO7cynxwSmEL20qXjDzlC2RlDwy8M8X2Q-IY3WKxAQbk
Message-ID: <CADvTj4oKGOQ9rgqbqVxxyx=LzzzEwf4xpJas_r9omeU1yS3y_g@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: avoid duplicate XSK TX completions
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 2:40=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

This was flagged during Sashiko review of the larger stmmac recovery
series, then confirmed by inspecting the existing TX completion and
teardown paths. The bug exists independently of that series.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

The duplicate accounting was reproduced in a local KUnit test under
QEMU using the actual driver cleanup functions and AF_XDP completion
queue code. With three completed XSK descriptors, teardown published
another three completions on the unpatched code. With the fix, the
total remained three.

The practical trigger is bringing the interface down after AF_XDP
zero-copy transmission while leaving the socket bound. No allocation
failure or hardware fault is required.

>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

This change has not been tested on physical stmmac hardware. Validation
used the software regression tests above and ARM64/i386 compile checks.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
