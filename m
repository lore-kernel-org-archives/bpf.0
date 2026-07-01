Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B143FC5A7
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907968; cv=pass; b=jQdREWPgrpVLsTlvIwiiAAz+fCL7VuFl84iOxG1O4QXNRlosdRC90s/g46vcoo9mKGmLwVijCwn4/Ks7t6wrEB2g3Y0dhBpFHS9WB8yZimEYFpa+yagfHjnEqP035XpwDqOFgOP4NtVcGO9L5PuXaOU0Xgbi1JzYzg+IXU0iJ/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907968; c=relaxed/simple;
	bh=Fk8PD7DHIxYkylROYr9KgJtjNuKi7EFq1m7jUmi/2yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOXqdgoB7NbxbwhJUHHTzOjUepcERI5n4biYKLiRlUCzHXrQDqoBTSttImL+Uw5hafLzkSaAcx8EYJ2h42dp/uqL54QbgjCW170BFHuiLkQVgMkPZPGM+8EBTbbEhFQM8mfbCIaGbal9uFzBsM3HiteAkL70O/h7tHOfPfD8eMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HWNFwAuy; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HWNFwAuy"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so311625a12.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 05:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907966; cv=none;
        d=google.com; s=arc-20260327;
        b=RfgmMxoIdyx7lSJwxFkI7pGsQ5MZTKlw5D/ttJ4iHI68y9pVUb68NiZo+dOPEen6nB
         58zjf1vl0j1tQq4y9u81yt06yBMzo1Def2u1ngxAzJE4/WUJiIwYfyfF1gn8od4eIM1o
         uNi+g7qu++IzHEkQGbJUENIlIDgS2kv5X7U79asrXtcfMkOzLIw4YLR7vEOvzx/RuJ55
         ANbSynKAzl4TGM/MlmVTjgNVC8RbGV7iVrbBtCAkNANeWzdFa4h/T1UQ9+0znZY2vHhU
         QObwRes/jc6dajtGWGdYx5X0oIt8Ak9rH6Eeq0uMQUjv2w9gkFwRCkubLz0Coax+ZJSt
         lflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v+RmTpdSNJcnbFj51/rDNICNavYVs5s5tmOS41AN5HI=;
        fh=jm8kMeQLk15sXFS+RhHC5kxQ5/hxGAiayJgh3pTqJ/o=;
        b=TMNE6O5tUDrDGwmpVkHy+f4Z01SwV6GoeFYgfQ0RPyrO+vojf4kHXRVLl/BAIPCMAR
         +IFdtopOv94/hdqAfMyadLpYSZIKm8OtUF6q2MZUDbBjzWKlwA8EQx7pLgpmfNLXerEA
         HY1L53kkmHKnctM7AXMfNIw3d+FlUzY7wfnrtWWw2xReo+0dt7llkaP9SXx57IFEU8Wf
         CFAf2ibs9Nrk29HmPDQ16OrhZ1rWEXbPUJh6r26GBDftSFv/sfimb8mkGhBwC4lqUqwh
         T0uIAvcLssVFaqj5QvWxf4PPnUd6S3aUJVfZXZ40AYWQ61/9v8lnDXUgINSq/NRMS+k1
         RREA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782907966; x=1783512766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+RmTpdSNJcnbFj51/rDNICNavYVs5s5tmOS41AN5HI=;
        b=HWNFwAuyF9faYBiKPwy/0ShIU4GCX4wa8/hc/SOe9F1q6tq9fkzadaCiz8K7nKYUps
         NpttmbGGEfEuTuLNSy8f4TGD7jG0Zpxg0iAE9BzzCM3xE8Voz4C/sKSlXqrbtPC0NFb/
         ascm4R4G6ggQ/8xtWBrJMlGiKNK+4pHnswraCYIM2tZuaj5rZ6GgCXYl8u9qerzeER+Q
         ZRZexYuBnlnePZ8w/f+27PT+QqZf9f331aWKtJrU6Oi7oHSiJU4FNN9o9jB55DuoblSO
         Si6/GSNg/N8/pWcI6bl2bpqpfdWah69vJTFIJ9WOcKR7J8D8npYORHpmI1VFRfzjZ1D+
         5LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907966; x=1783512766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+RmTpdSNJcnbFj51/rDNICNavYVs5s5tmOS41AN5HI=;
        b=WKr8v9LkDzdouALf2G175t9LllReLbV++p58VGp0fveCkT2HXHXUdTRewfcyZ8Xz6K
         2fvlzMMj8DRNUE/XoRgELwnr34Mw3yyJwCHRqjAeQI5oFhqHk2fuw+InOr/rfj8Bfmme
         WI7rUP3NUCdo+NKMmhuaGdIUdCNEOMKJCHimUpXY2UtKTWhVRJW8Qds7Q0pnoaxIKuSs
         i9RXWyHHWFxIoGRtH2uuKxVUAj6+YM6w3Tc3ubEbFGS2iFmCUORnQrUTvPNRffkaEfPH
         fPYHwhKHCYT2frNX77oJUt1VgEWa+haqhAD+vdrVL0x0nx2qq6s6XJtuLG9UPuCr2bHD
         uekw==
X-Forwarded-Encrypted: i=1; AHgh+RqfmIPzNpXCAhQgxbwYKlWr0FAGUgM7ITuiMZr5RSk8cdj8k0Ydnke1k65whZdjCASja1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6LCKozPGCcYE08PnpgaJ4caW9lojR010JAD5FetKVeyrpZmE
	e9PBw9PNOmmoKdfOGfaQqE0u+VB2X8Bnm169Asu5XWk8gaVl+5u9PkrBd558sLndueYifzPZCVu
	VbOHwnkcIVsA+KkPo4FtEMXDpuQlqrkExQhwgXJQT
X-Gm-Gg: AfdE7clQCJDOaNOl3V0WACD98nOkh12t1CAa9ObiN01tR6vimlZZ6dHclfzE9PJxSbN
	0Owgh6gKaDaHjdNavwW18tIg0gs1wbZwZ+CLi51ABH5Aejv1Al5lIwbPUvPFHYEf2b8RiSZyHab
	W3qmuBN0E6hVZE/zDOtUCXCN8I8LzbV8oA65UqEQF+qd2S9DVTzKA5hkC1DJLU99OG0GG2reh5/
	9XpICetUx9AhmBtozA5MnWRNdSRpBtVN72DxJ5CiNNOndXZB+Gr8SS43a2BFH1sQthbWf36
X-Received: by 2002:a05:6a20:5484:b0:3bf:6c08:2842 with SMTP id
 adf61e73a8af0-3bff42c92cdmr553443637.49.1782907966065; Wed, 01 Jul 2026
 05:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
In-Reply-To: <20260701.ze4eph1eKo7a@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 08:12:34 -0400
X-Gm-Features: AVVi8CeqewfdSkYjjmrhNYrv7bEJMOVzvMagAf7bsF5eyhzqBn0BNZSrdfQn4sM
Message-ID: <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org, 
	serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, 
	john.fastabend@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > Create 2 kfuncs exposing control over Landlock functionality to BPF
> > callers. Export an opaque struct bpf_landlock_ruleset preventing caller=
s
> > from accessing unstable internal Landlock fields.

Generally speaking we don't want to provide APIs, either in-kernel or
at the userspace/kernel boundary, that are specific to a single LSM,
see the LSM syscalls or the security_current_getlsmprop_subj()
function as examples.

Yes, Landlock does have its own syscalls, but those are
"grandfathered" and not something I want to see emulated across other
LSMs.  If a BPF program wants to interact with a LSM, it should go
through a LSM framework API.

There have been some initial efforts to develop a LSM wide policy API
for userspace, and while it was put on hold to sort out some namespace
issues, we could move forward with an in-kernel API now.  We don't
have strict API stability guarantees for LSM hooks/APIs so we have
some more freedom to do something now, even if it isn't perfect, and
refine it at a later date.

--=20
paul-moore.com
