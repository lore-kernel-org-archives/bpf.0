Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075633BBAF
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144693; cv=pass; b=FJB5p095IVpPHYUCs1UzHY6nV/G2DxnqxUREj82IBZf6/EKjzrvPi3ZVgOYuFAQMCEZNQxgVaxNKDPKrCPXW64Ti6kqSos64cJNxhcHloKN7qNc8jit24D1cmZn2Yz/GldUcTzUIWjOyk4/hF05FMIFWPa4FfZL6nto+bp771NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144693; c=relaxed/simple;
	bh=Z05kgezgeQBnAhHNLQ06IrbWptjbuPKQZgHZ1hJUBJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjoJ/hA1b7rmebhAWsUlURb/ZODJUvc17zjfhzqsxeQk19cFYV7GKoRIeKqmvofwMg5Aw30nhK2DmjU3rhW8Q1KFJl9d0AN0B9UiIZudnjVsQ6Tq44tMmeRBdyhBn89dr9urgFnzebJ6ofmJFUknMeoBe1Glvy7En5wDiG6B5aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2M4yfDS; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2M4yfDS"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c297931c2a0so62868366b.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 09:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789144687; cv=none;
        d=google.com; s=arc-20260327;
        b=RPHeDJ+waf0wPTpDz9EQLwtdTekKIDhWAXKvReFQBSn8OIoPi8AM/i2Y2c4I9oBvUy
         vGyp0IrrJipqNTS78CZOWLLHFNvls0n0xKmspJ0daPDKHWzLIZqqirYfPh+rJ8dvRNek
         hh2xeUNgmYTzxNADVi++0TWDKyxIJ5XK2oErA6N+c2NHTWh/RMBKK9vc+/jxeW/lZXMi
         EpwZakW8i/7prVAjPp9ztT3eBK+dLpLkgrR2/6ODLp2rBQWspzbJFndhuHoJdUWRX9aS
         CvsOEmpidjEHAe8m9eOcNVUPxn3HmcViKw1wOq/Ivk+tp9A+ZV8Iu+HZoj0+mlRg9I0H
         rY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z05kgezgeQBnAhHNLQ06IrbWptjbuPKQZgHZ1hJUBJw=;
        fh=Q1UHcNlsgAQGO1mqRYKVGo3oFUs9RzH1kzdVlX/gzyM=;
        b=pdyNAYfNg41EYUja2GjQJT+chMRtBXamQJrJemUutP+Wmn3tNFrorPFex30nJbAKNB
         kobD7jv/Khdckrtzl5SznptypouxKfast9q2GENcQDfOomF09kuQjm+O+BCTTpf0z9wr
         MQJU+WIQegICOUGRGplZtczjJKornXGMDtQTW36q4b0GmeTOxua8+gOhHsYzXfKbZszY
         dQK86mAbx+0AemTdvzON7e+UvMBfKQC4NFXwN+7K+yKfkPjh8mJ3O+gjgIywbNVMI28b
         YNkhyZ5avCpdxzE/aEo/hiJOX2LiwI1KoVLldQG3g5rv+yaCBczH5+pJEE4UsqcVSDnP
         Z4Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789144687; x=1789749487; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z05kgezgeQBnAhHNLQ06IrbWptjbuPKQZgHZ1hJUBJw=;
        b=g2M4yfDSACO/61PjGPBqrQrc0uxYXzpECVYGcmNPOYeaVOercFn43MaC34b7TKeOyQ
         /vboXhT84q4ct7WEnTdjtTEPCkIxDqVol49N9RvYqqrqJFZ2+kouvQKAB4ziBlVuN7ci
         +UH/CzRekC6lUCYwHDjF38Xv6OPAmykgyhQ1LZvh/YZd43KOUnp+HhIAP41WbAl8jbuN
         crgTVbtRD9D+cDvw1ZIS+QSLRRUbXrnlA69krUc3znpM/G5PTzsiJ7+J77KVPhNc7MMg
         H1OnUKJfSWUe1oixFPMtZZmH0g1nfLBX8DY5S3Bl5pUjx6/aVqpvRHp66BaDgp1IbvW3
         Pswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144687; x=1789749487;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z05kgezgeQBnAhHNLQ06IrbWptjbuPKQZgHZ1hJUBJw=;
        b=egMSfFrjpU8T6hq0qojgirzUXcw9icacu1mgebK+GeEhyPwGH5UooZL0dziehHZc+G
         KixIG9ANQCVuAKTxT/acNfd1pFr8KfGYlrrxQfQfhoJAqo17yR9Zv3tqdBOD8XvzCepD
         d1ommdRmZnsKDmlspL+eL0xHUcZp9BCLTbUAMwHO7pve2qj5VACRTqTwWYOTm0ti8NEx
         EPw3A+lYcwcJAaCX4pqyJu1O4v7T77z9Tod6/+5+qslZgQHKzKKJIBg20aCN/I2dkw4+
         GxifV6pqssN5FBhyjm1k2aeR94jQ1zDBp1EK+67W9LeQVQMcJtfwWk85Sv8pYax57Hud
         rkdQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7TaxVBOuwEtEo/oy7pR0Hk21JWonCFqugPNyzWLOyyyp8EDEYJxc1Hy3oghvxhKjIDc8=@vger.kernel.org
X-Gm-Message-State: AFuF++msrookwkyQr85IcIxglAEWgxR//SgZgbgJ5HJyKEPXbAppTyNJ
	mXeWMuIS0Cn8u1Rz8wsenRANWNSuRX1bADWbCQqrbZKjP2XMrHlpmtVx5vNtuXkipQlYzaId5Tp
	cbbqwQt1HHBJKDovvhfoFgQyjurvG4jY=
X-Gm-Gg: AYBFou2rE7Xd5zhtNDkmw+k32o+pMcyTEa7qvZ4tvaicVbj7AFeCvK1JGCaSnFq8jID
	16rk4sratq+amhA1Qf7GBlTT+kvDDoSFHVtbwUpuzF5xBRxWw857S3KjQe+ftaTBsgo4V2Cf/EX
	fGoG84HURGHY95gc50REigZsZwMBfi9ryzuYNAZgPUVXP2G+faYXN+k15616Lr0ilZtxeMd9TzP
	DsundkHDAeMR42Q/4D0dVHR+M8n9jCNhm9X5xpMF93tfFHSPvMj3J+cvRcp3nzbGwHHcTbJpOM8
	9uk32QaMxaHl+3amL67v0pRDJ0Hlnp4JWLdQF1UGH5EKmKIUmfjh6mSio+wAl+BE
X-Received: by 2002:a17:907:73cd:b0:c1c:2007:298e with SMTP id
 a640c23a62f3a-c29666bc8e7mr228183666b.24.1789144686888; Fri, 11 Sep 2026
 09:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904111731.673341-1-main.kalliope@gmail.com>
 <20260904111731.673341-3-main.kalliope@gmail.com> <CAM1=_QTN3JJ6jtckf32F8wxBzLDbHSrzUttyMBWNqZKmRe=2rg@mail.gmail.com>
In-Reply-To: <CAM1=_QTN3JJ6jtckf32F8wxBzLDbHSrzUttyMBWNqZKmRe=2rg@mail.gmail.com>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 11 Sep 2026 12:37:53 -0400
X-Gm-Features: AcwNN1UBDacB_mdUgPo31Abc79q-kaSzXTwE_yQATKEr1z50cei1mPjcgBoyYeY
Message-ID: <CAJZwKkghmHn1twrwTtfGSZg5NZ5FMu8L_=6N_pb0VrP75GMKGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf, mips: Add support for BPF_MOVSX in
 the JITs
To: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, paulburton@kernel.org, tsbogend@alpha.franken.de, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	bpf@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I would suggest that we do this optimization.

Thanks for reviewing. I'll get working on the seb/seh additions and
ISA-specific MOVSX handling. I'll send SDIV/SMOD v4 with the updated
uasm patch, followed by MOVSX v3.

Nicholas
