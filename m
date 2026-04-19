Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC11474CC
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776574903; cv=pass; b=FrLCgqBQSL2SBRHh8UIU6rbx3EzOHXGrfadbe7GIuOI3yNmB43bSIn1nQGKPXgW1X0kyXlw3hnO04AeWBlFEr9g7cuQNiDDjG+J0M0bm18ky4lDdiTY8X/9J/jmyj3ru9yoNGdnquS4St25f8VMMdiRmP5U05FkTCox/cRk0z90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776574903; c=relaxed/simple;
	bh=/YCCUzjM/p2xoSD20SHgjZdgeD6MDGHJ4xWdipBp+t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfPzT9lP0JVu60d2/tlUERVjCxZZc4IcwVqJtD+twEPyUiYA+Ei7JU5O2T3byq8SEHTLk56cZ7eiq76vC6dao+x6qN1XQ0F++qU+cDOvwjP/j2m2Pe0kE3Ygz/Msa1ekIQKuKbobW9uQ+T+JreIfXO6lMHXX2UYGwdgzv9H2gns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxqoJm6l; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxqoJm6l"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a7109f568so21268747b3.1
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 22:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776574901; cv=none;
        d=google.com; s=arc-20240605;
        b=SB6y4TV6hhvxu+JeAA8PorfmArYP9l4BUDDmkmpWHtDsiNgnqb/2pYkwpE6R+rAFta
         pSClS71XkJFLXjkqS4tGL+RiaN+eahI7Cib1XCKGte+TB7nEUX2o8k7lBJKLWSlFZRUr
         3vD5gPZyYPm4bVim8r4Eb0QxFTIxg/PlwOaDlOBVaw6ur/1QVtPfjzU873WCxfGhnc8r
         D/p9swRnpTJtmztTaelakwyj0wstyVj7d7RlDMC4cSZw0eDolHpO8pszQU/hoMjvGHsP
         h+XrlhkWJo9p6ViPYQayaMMtps8gwRxzRFTLCM3oCrxU9OSgqIBLmB4wDf00d02f5Vrt
         YY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/YCCUzjM/p2xoSD20SHgjZdgeD6MDGHJ4xWdipBp+t4=;
        fh=cC05dwtD+LzE1z7OuPY0sSrqEdg0Z4lEHJ7HpTVImOc=;
        b=Pk2YeI2te3GaLiNIHt8//k81SVgOQ+agiRlKDQGsHmlSvO03BhhUfxuValfDku2BFO
         FZbzdB0Be4WQGCnCuacf8WWiFgtF4MvfiPGl60HdzAR31GSsvLrfK4uXISxx37U+OU0A
         mCqHIDELLuJOPqgJ4h3jPacFrxJFx7+u8ABoJTuwJm9AnFb/VMxt5u8ijF9J9w8WP0RZ
         oL5HQ+Ogvl3KKO3A+vpRps2ksMavWzKV5Cr/xbKXXQNZ04x6k9pLWFV4agBn9lhuYzVN
         pozH2g2q9qgTHOuFsA2mCqHfBs3fxg1/tTN6nqQZxvnD3ZkDClQSXFWzCHb53p9nPnIz
         KcaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776574901; x=1777179701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/YCCUzjM/p2xoSD20SHgjZdgeD6MDGHJ4xWdipBp+t4=;
        b=MxqoJm6lLS0W7jqdmwOtojgfTFzaPBra730VH7OjLQG7+Kz/HTxP2DCb/Xc1TnjbUa
         qQMKXbnc1WiDZmLxeYS6W9qNdlNd7+qOa9On2lhiep3cE0tEqYLpR9cYFmP3bgchMymm
         FE0kkQXnxF0GeekArFPPGA07g2LwQqDWqrXKVCuc0Azi4r0pQ3Ohoi3hmrNskjDHWeLW
         xYccajqUq2OVR9YBEaEoHsysQgUlh3NdwrBnFIqTPi6AvzV0+OQZg44A9+ivWWcYrC4M
         oNcjQkuidAhrNI5nOThPoTiZW3Hl2tTcrvZRtM5YO10uHbvNwdfIdzgXMyF7GjB1hUoW
         vXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776574901; x=1777179701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YCCUzjM/p2xoSD20SHgjZdgeD6MDGHJ4xWdipBp+t4=;
        b=I0jONg1qzuHZWwRTfU+Qi/1Gmi8v7SxCwaYs/kdHx205PV9KxDOWLRjZ2yhvDgu5Rt
         dRrC1ZWlO1GcXHSVJyxP+dsgEBr0qil8rB2P3MGbU++6uEGQfsK054lBRZ64tX+CIpIS
         iJjJBlwhlQ/X1B89vQIu7SL5qcaep67PdLicde9NeRv9UNdty27HZgaKk31C04+ibBjB
         K/ApWRrYn/lZnzfJBrZgeA/zrUcUgJFnPYJZELstp2/AbVVU7LGUFUPZGXo9VwKQiFAV
         97mr+6FWrWmEh7rKBTVHuTLSyPMwSM0Dh8gPnSlc0YKrR/HFR7Q2N1FYejNW0fcAXfg8
         Kejw==
X-Forwarded-Encrypted: i=1; AFNElJ8t4FmvfOmoBaGYB12CkwTz7ehz05bz1PcX0F1K0IHsBtmVTcAxJGZvUvKdsHYgW2BXLCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUKkZ/qKKpsCTEAzmiiY8fq1c9s2FQ2z8KN1Ts5y4L+R8/B0K
	YEfuKNb5Z+hmYBA4XEgeRPKlr4Xs1ldRWHRVdz2PamNkt7jlZ76pDg2PeO1Qthpjt//O2Ztc9No
	k7zPPry0Dtysd1KI1E6SHmrUqKKBaQXE=
X-Gm-Gg: AeBDietCEYMEGUbtTvOeCi4jcaLLLNWWIYkHQBvpas8fnZlbpmHDtCCWRAWX9L+Jbs6
	cZFj0wIsEYLXXTT2GtsjdnXTRJ5ozFEFPCBp7cVCusKN6Jw0Fo0d+wkNsYp1w4JqbMOvbSNLL1v
	wclHNnkJgcYKThQwLPSMQVoBYq7m9SHaBXPjjD8z2LrnysCthIlrnjwgkyf257TxZMjCrRuVAv6
	Ei4Ev1QCrcn4Kq/7uai1Ds2TlMzroMzgz/tg2z84t8hT395ZL9J1k6UQ7zZijDYQH0G23XxDboY
	xBS5J81l10NhS28LH6S/pCQ2lz1QIr5KdRY2+76D8d9Ul96bMXA2ufmSBHDCtYjSiXM=
X-Received: by 2002:a05:690e:419c:b0:64c:a4ab:e4dd with SMTP id
 956f58d0204a3-653107edd75mr6704204d50.1.1776574900890; Sat, 18 Apr 2026
 22:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419040426.9672-1-avinashpal441@gmail.com> <557b90e63fb85b646de7ae4792eb2c06d6be251dcd95dabe9ed99435c82b85e0@mail.kernel.org>
In-Reply-To: <557b90e63fb85b646de7ae4792eb2c06d6be251dcd95dabe9ed99435c82b85e0@mail.kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sun, 19 Apr 2026 13:01:29 +0800
X-Gm-Features: AQROBzD8qwKrPSY9P1AT3an5qxnX6iBnH_hkCb6oiYpdndmJpIgSaNI8Zgm7iRs
Message-ID: <CABFUUZGGBL8Buo3piZA=pmaNY8ihgTo6xuP5XLM4m1pc0zWn9g@mail.gmail.com>
Subject: Re: [PATCH] bpf: verifier: fix NULL deref in map_kptr_match_type()
 for scalar regs
To: bot+bpf-ci@kernel.org
Cc: avinashpal441@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Avinash,

This looks like the same bug Mykyta already addressed here:

https://lore.kernel.org/bpf/20260416-kptr_crash-v1-0-5589356584b4@meta.com/

That series includes both the verifier fix and a selftest for scalar
store into a kptr slot, and Alexei has already picked it up.

Thanks,
