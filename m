Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C63D9DCC
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195398; cv=none; b=ob2aZpQ3XFNwXc11bLsCqY52e27NyeR6cEv672fOQ8W8k/AyW/pjKBROttQ5It8IIevUKsVsp2mG4IT39c3ZJLyR7hR8UO/8cfZMwEkcNNPgAhnGc77fvrcjXx0szJpeR3/Hfq/IbLpBHm5J28RPpapfd8hL8JhuB7JJ3cNSPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195398; c=relaxed/simple;
	bh=OXxPZmYpI4mlPN9ogZsls8TdJ88Jcg7GFTOk8CLyGng=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=lBr6Zw4cwNwfv7DZygB70hcx+u1udIUaHUHBdD34bzSViexcmLODbBGjuKuloLYZHroiiNTxyRPGCKru20qW9q4ItZ7Ei1RN9dATikcCP9BYAK04dSxTshtLwO/CIC5bMsBegNF6FWmjxiy2xzTauwmnX9fxoK4k0X6W6Fyhk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzFQAQMS; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzFQAQMS"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4744516a312so956843f8f.1
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784195395; x=1784800195; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jJkcunLS46ASTxyciuPjAcQ3CqFxXqHDA25xRazP2KQ=;
        b=ZzFQAQMSBR54PwafY60IJs9G8oWaxyYrNknwwDhzs0hGZ4exQodTjTM3/iL5hZZgbr
         rhr99zXowkkZdDk41POQ5BuKNLdyxpwnD6/awy9eBpKlDFiQ2xSnvG/zrnZdOKUwVjp4
         7ueFDYdXVc+BgWXvQx8NykhvXDcrqqUVLKOBsCLORfEcpwzpCLjbo+1U9ShIWGw2aNnj
         voLeicyV0wWInd299zozTVm95Jn7A9iqNegBw9/bjss/f+W1SckkBTrih0+qAv99cO+2
         Z0WtXhUWaCzpBgo2xf2Y6SMC1S5464o2KmNk7vtFX5kYcCCmhKyOzoyNfNfkc43ihtBj
         dvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784195395; x=1784800195;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJkcunLS46ASTxyciuPjAcQ3CqFxXqHDA25xRazP2KQ=;
        b=g0DXLVuLOzaRnH2Y4OpQ5nxpTowJ5sj8X7fgNPWsSIKh5Q/qd3steBMuc2sqzV3HU1
         JnBYXrJf3ArohBLw4POJVwoj0t9cQZVdP7ODvcvwnDxLwQesocvkmOwgkTMNuosT3uYY
         +9ixR5HtNiDOZ4OBqc4WWi01bTeELjc2N0WwHZ/djVxSLBrJHMDIkk1fOv6M7DCNP28s
         NKCkPAouVLRvFbAv0oijeXi249kSfbrdEPyBdGXCxWlQ2Pf3ul6VepRpWZvNVs7MbryW
         JTwzuv4dtK+zKnwOJ4JeHbml4P0hocFU9QM+gOo0ztLaRt/BJumPAROyFLIniNT92HJq
         ej7Q==
X-Forwarded-Encrypted: i=1; AHgh+RrcEUypykkTwi/BjKT1kXjXRD35EyGq5Ly/jIE5Giol7PlfIjfdNca79WgZAaGxFblVXU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvSkyMv5vzRCBLp52SEk354Sd5QufMlqptEl9lnbN2n2z5uIhx
	khGa0XOrMo0XKki9F6Laupr07RiNduybTRNAzf0iz6ZgM8GS3jvN3Jnp
X-Gm-Gg: AfdE7ckY2r7hHBYwhZS6syeT5BwygkFwWJO/+mjXZj8FTJTfG1AbpTukXYPsVW3E/Vf
	6hXRztqak+rrE/1XDgE4FXb7/qWN13iJmMI2o+Pha+HqhBTue33h2mqEi9VAPbED5rlCW3+xuo+
	eg/pWRHABxK4onSV1GNSh5fAOkSe4dBwAwz91Z5Wb7NY+jGPO8JFlflr4gS/hCGY9AUfeaPmu7z
	mM0SQz0S66u52TRr+68hYyXD0o6PAUMTSynB6T6/3sO/FSVLsk3SelUhDmPruT9lnaiVRs1YZVw
	sUGsv0b0lnv9dm/zHqPNlur+KOepd/9y0IiOyjVplQuqwl5Ve2aoz55Yt+WmVn3r+g/mdrFv22C
	QJQZaE4OGpdh2m1PkLNW4hzx5R6R3SZBzcS4aeM0L2aZ/YkpU6bBn/IJnO1mcZvI2JwbrJoB7Am
	LbtMaCA52tlhdiPH+CnJpVPGDJegpTfB92tmk1BFWI6anJXI5DkcppVGffvGvjJDZTbPCSlP+xQ
	Zx2mJ62gHOfgNGuWyTuyD+BsQB6xEvgcVurYHjh9I6V
X-Received: by 2002:a05:6000:2999:20b0:47e:96f6:ab7f with SMTP id ffacd0b85a97d-47f5a4334c4mr1461201f8f.16.1784195394746;
        Thu, 16 Jul 2026 02:49:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm23682779f8f.37.2026.07.16.02.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 11:49:53 +0200
Message-Id: <DJZWHCHQJF16.5908MHLHMK0I@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: dispatcher: allocate
 bpf_dispatcher->rw_image with vzalloc()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mike Rapoport" <rppt@kernel.org>, <bot+bpf-ci@kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <luto@kernel.org>,
 <bp@alien8.de>, <daniel@iogearbox.net>, <dave.hansen@linux.intel.com>,
 <eddyz87@gmail.com>, <mingo@redhat.com>, <memxor@gmail.com>,
 <peterz@infradead.org>, <song@kernel.org>, <tglx@kernel.org>,
 <emil@etsalapatis.com>, <jolsa@kernel.org>, <john.fastabend@gmail.com>,
 <martin.lau@linux.dev>, <hpa@zytor.com>, <yonghong.song@linux.dev>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <martin.lau@kernel.org>, <clm@meta.com>, <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260716-execmem-x86-rox-bpf-v0-v3-1-4e76158c01c5@kernel.org>
 <7cce7d9ee2d24519db79c652aee2e4e562a8139dac923e5cefb4d5edfd4f6407@mail.kernel.org> <alikAx7_8tp_ryky@kernel.org>
In-Reply-To: <alikAx7_8tp_ryky@kernel.org>

On Thu Jul 16, 2026 at 11:27 AM CEST, Mike Rapoport wrote:
> On Thu, Jul 16, 2026 at 08:52:25AM +0000, bot+bpf-ci@kernel.org wrote:
>> > diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
>> > index ea2d60dc1fee..79f0c222c583 100644
>> > --- a/kernel/bpf/dispatcher.c
>> > +++ b/kernel/bpf/dispatcher.c
>> > @@ -148,7 +148,10 @@ void bpf_dispatcher_change_prog(struct bpf_dispat=
cher *d, struct bpf_prog *from,
>> >  		d->image =3D bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_=
zero, false);
>> >  		if (!d->image)
>> >  			goto out;
>> > -		d->rw_image =3D bpf_jit_alloc_exec(PAGE_SIZE);
>> > +		/* d->rw_image doesn't need to be in module memory range, so we
>> > +		 * can use vzalloc.
>> > +		 */
>> > +		d->rw_image =3D vzalloc(PAGE_SIZE);
>>
>> This isn't a bug, but for multi-line comments under kernel/bpf/ the open=
ing
>> /* is expected to sit on its own line, so would this read better as:
>>
>> 	/*
>> 	 * d->rw_image doesn't need to be in module memory range, so we
>> 	 * can use vzalloc.
>> 	 */
>
> This really contradicts what I see in the code :/
>

We ended up changing to the multi-line convention, but you can let it be. P=
eople
are out on vacation, hence things are moving slow, but I plan to get to thi=
s
series soon. Sorry about the delay.

>> >  		if (!d->rw_image) {
>> >  			bpf_prog_pack_free(d->image, PAGE_SIZE);
>> >  			d->image =3D NULL;
>>
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a=
 bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READ=
ME.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29482=
648692

