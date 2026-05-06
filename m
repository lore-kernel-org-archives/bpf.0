Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1832A3C9
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070560; cv=none; b=ASJehELFuUhUl56qmWje5bnXGoI8f6V4ESkbVP3UPN2m/r4hXbacURNFHVH7Q4fEy678KplKEFCt80MhsqM0azivQe8y1PLCfmhvpKz9XFTtJoPaEeXre+D7UVNmT5QcXojJPiLEFWaLGNtICTxPlpXOC9SiBBTWQ7LFB831qPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070560; c=relaxed/simple;
	bh=xH3UHSEF+kKer/2l+b4ykufyBAPYHPws5oRNcU+Qowc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/lztSmFecuvB0R3UNEmPoDyTzcVYOO+wPP1bRPLRKP80P6wG/78/3BALs6HXIsAqAWyZoLIGi2XVFs7EAowZ4KjKXuyvcefNKdTuzJE0UGCTouJjPC8ikaAr0/ADbFJayZ40+BBu+x1KQcy5Ld9w5F+y0Hfz4I0fz1VfmLf9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVr3Y0ES; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVr3Y0ES"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso48799725e9.3
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778070557; x=1778675357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Czs3D5A5wlLCB5HWOqbKm3KToTO4H/Ui2EEQd8UX9vA=;
        b=jVr3Y0ESl7dIuOZ9FB8dng2v+1ZUBGkiF+cKIKcena7dRs49XqMl5hJbPZ1vS16Q7/
         Cx9i76g6RDeF7d5TnuCx3/ctSE8cp9hcXh23Dv+vCZ35bwCmbMTceYtJndIlXgIApwpi
         MZOQvAwtBeCbAQKW5IhoQ1Dv7ePsOq0zms/nERLtNtHBttRWu3u209bZ95PMqBZPjbgy
         Kr7wJuXJ8B82JWZdrMGP+Vsaft1VHltklWd/UZI487sdQHIIsAtRje6Il0eRgo95XFDQ
         dHxMQU4u5qC6rimrQE6r4oIhWOFCzTdaGIk+SGHX7Ha4aajZezPN0mzPadCTxs/uq5oV
         lRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778070557; x=1778675357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Czs3D5A5wlLCB5HWOqbKm3KToTO4H/Ui2EEQd8UX9vA=;
        b=lOvZemajc5m+Kk1vD/f07rR5cdP6uh0nUl7hAn2oJ1iAMNFbCqRE1ZxsFLPxqE3NOQ
         wyh5jF776Uurnau9o1+SBHFsO3jMZIhRSaHrbbg3hYd8B1Wafxy0cipR2yRYwwwF/NbS
         /RwDIULIb+OiiOQt5U1aQRuFPLMF7kB0Ezo9CUu0XSrn6lqp3i1m76EtP+HsQliPpyyx
         HCLeTZR/frlUDSl25MwotsKbmH5+szV9F6ekZsZ+fES2+7Pz7hItxSv0TcH1DtQWa0IL
         TxS69E657y2yeOkXUpKfZIYsj3Uf5xtPbQLokDPwv8X6Ho0PebxFL1dY8W+bNaAyWuXJ
         T8hQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3J/INrAjSDm3+oXZ4nupTMgMrBawZpSKQV+V4rUMbK8nQO1i5g34hqMZx7GIjg9F6gag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV9l9qcNtIxPt+4vyBAJi8DNCfM5Ht1wMj/lzZUE3WKjaxGc29
	xp89eLec24Ax7zY6jGLlBm2ls0HbQ9m6zftsDE21GcACvevVmwriptWU
X-Gm-Gg: AeBDievk2tvOy3eipXM3ovnE7g8n+NBFOUtn5D/Lb5vnK/mSS+mwuoRCslTO2sUv2jn
	05nEOLdMzKWehjZLJyiPj0qI9Lyern22RosAf3cAtrXhuqWgFlq2OPkBVOVmk/TAha4gXTTu+oQ
	H62hmn3xrCnMHXWzn+gkJJzZ0avqK4q4FvC4hjOcKBE0/BhHgvLtYLZHfpH5z7g3mP++Dv5uH7w
	/zw0c+Gr8Fxc/wh9F6RD/fxqz08JTKAl49FxRotBPGjR5qzDPCwNq1mNNEGBcRg5xnumfa2GhtN
	856GZ4nLJJXSZVD1GZAkI0B1J7b93vGnwcQsmRs/HHTUU8FOXbBYvOVNycSFHHtpaTNzCW2bn3C
	yT8qaxyjH3OY/pXF7AyWczThwmOcZuSMfXJWjpnKfGa2Cd01+EM24xTV32RnJBoFg0xuzYJMyvq
	t8qsoXIv3u5smi4IbBU4JIcmwe+mvklUM5cIHviTa4yZnou2ZFr0Z4ZgQ0XH8OquHj7215Qnt0A
	e8LpO+P5maQnSwYfluG0zXpkx8Xb+NrmXRmOjHO8uwQJaPOkaICrHLkIvmkMTTvXcW3M4Qpt9Py
	sseFO+IjhLZCXVDqmq5CKToEZeMEbUW/pJkrawvmkhMZah6O0h9qOw==
X-Received: by 2002:a05:600c:8b0c:b0:48a:7a10:4f47 with SMTP id 5b1f17b1804b1-48e51e0a620mr59477595e9.3.1778070557139;
        Wed, 06 May 2026 05:29:17 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b5a044c6307a465e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b5a0:44c6:307a:465e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a50d0sm75518935e9.5.2026.05.06.05.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:29:16 -0700 (PDT)
Date: Wed, 6 May 2026 14:29:14 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Paul Houssel <paulhoussel2@gmail.com>
Cc: paul.houssel@orange.com, Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Florian Westphal <fw@strlen.de>,
	"T.J. Mercier" <tjmercier@google.com>,
	Li RongQing <lirongqing@baidu.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf: render CGROUP_LSM_NUM configurable as a KConfig
Message-ID: <afs0GuNstGXQd2E6@mail.gmail.com>
References: <20260506065048.592474-1-paulhoussel2@gmail.com>
 <20260506065048.592474-2-paulhoussel2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506065048.592474-2-paulhoussel2@gmail.com>

On Wed, May 06, 2026 at 08:50:47AM +0200, Paul Houssel wrote:
> In include/linux/bpf-cgroup-defs.h, CGROUP_LSM_NUM defines the maximum
> number of BPF_PROG_TYPE_LSM programs that can be simultaneously attached
> using the `BPF_LSM_CGROUP` attachment type. We set the value to the newly
> introduced `CONFIG_CGROUP_LSM_NUM` Kconfig option, allowing users and
> distributions to tune this limit at build time rather than relying on a
> hardcoded value.
> 
> The option ranges from 0 to 300 and defaults to 10, preserving the
> existing behaviour. There are currently 273 LSM hooks but this number is
> subject to change. I coudn't find a MACRO counting the sum of LSM
> interfaces and therefore arbitrarily set the threshold to 300. I am open
> to suggestions on how to set this limit dynamically or not.

For reference, there was a discussion on this previously at
https://lore.kernel.org/bpf/20220408225628.oog4a3qteauhqkdn@kafai-mbp.dhcp.thefacebook.com/

> 
> ---

Your SOB isn't detected because of the above separation. Text between
the "---" and the diff is ignored by git.

It's probably also worth cc'ing Stanislav Fomichev when sending the v2.

pw-bot: cr
