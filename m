Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5D33AD9C
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745300; cv=none; b=iraPUD6j3Cn94BKxu6BQib2rnBji1AojOwkMAnQFN2Uu4PNOI87/bOMGjlqHBsMxTCkb7067F6AspwuDsfKMM2O+Ov+ZGytevsweJXLx135+x1qeV9HMAQ5cH871k4Sh6WfaWu1/oRmZ24doLtu1F+a+onBjVKPOaz/QzIg6oLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745300; c=relaxed/simple;
	bh=ZjYzEAgtLNk9ASjxIlHFBuTc8H1shrJZV7rjxPmkjgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pT4iWr/RNr9Jeu76K+Rf1bFG8supAV+NGSN5DTUKAor44/5S0kttorv1bTtQ5L8gYAnIjrM1l/n/zL316ZpyAC9Narrm6al6h0o+MWugaeTww/WQ9lmHqKFGoFxhM3dlPloAklIe/ZAi2uTCumqX0YrDQgSbgN+XeYj0oliP8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oca2waew; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oca2waew"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a2dcede83so2019297b3a.3
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745298; x=1787350098; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=h1fs3gotylP0AzEmYnhzcYjG4/UpG/38AhdVCX6qjcE=;
        b=Oca2waewwb8T+747KbYwsw9lpotbOkUbvL1zItcQP1GYCVr4ihArrfhDFe+lx2z48J
         43TUHnpBmNCVxLo/BSdWQuNFIfETV2/OKj55Ym+pr6tDPvcRicfjmiVJR4hX5LMvu7em
         ntDf/2+u6VSrszwG2S6vEHHMmcCw2xkELMatXIQ6yAfMRS7rWltR/Fd1jVXi3TSwENl3
         /9ytnTuSZ9NXXD1k5FIJ/2LlTdjlRfAoI5bpqGo7d2tDr4rqTInoAwlnk5O64KJ6EtsK
         +1SbkgSHPcCEWbsBtpO9deGnWdlJCaCKWV+xm9VAUbRM/OaY/jJImbU7+qUxLPB+o9l1
         Rt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745298; x=1787350098;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h1fs3gotylP0AzEmYnhzcYjG4/UpG/38AhdVCX6qjcE=;
        b=pTjRhK0U+1Zzs6LXA/OADT3uD6wma/Ws+nEW+pnb2o5sD7aPnixlo7n/6tZK9Zwqr8
         mdhBRcErc6Qu2Vm07lWBH8TI07OSkFFpr+j/XDMD6DJL+UOIejA40M2un1VGkKb9OTZw
         PDKpjrwLCY+K1MuFQw3wCoHQllmYOHoAFcjnbKLtE5NnvrA2M6TiHKq0Ho7v07x9ZgLk
         6mPN2Bx2D357SROAUe4Jo0LLMbuZCgHkxl0jfc0/8WAaFOBDJ4sfJJpVDzi25iVIN8KD
         5eMS6UhR5gmz/TXQU+pHCYzlXhEJWYWv/uqHsBCUgC+lnaP8OXVSMJgm5W6+UYwrULy5
         xafg==
X-Forwarded-Encrypted: i=1; AHgh+RoJTK5vkFzOSMr5WBQaRJldQQV/mEpg3pKEwPp335vbxJ129zLYVsta+DQxnZ4LDytOSMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6H1GqhoR2b851b+P69l4ZKiKJunBkRl/gdhxxf9GH/VyohA19
	gEL3mvBHyeMHwmFWaAN3+/ML00jgXMPIcIycnH/tMA9Jxx/9aeNHOGG1
X-Gm-Gg: AR+sD11mp4hMHn3djCfU+WvGi76lwhIYigpwQ7abhILHYS1FoJCA4N5UYH7yeLmFfHq
	oR1NgJcYKjEzqYD703Wxmj01N44K+LzlvFrt7YZnDHY+5HMc/yXccdyMTCd8hmMp1yn76mjUCh8
	/kfm8zb1yow0CwgnepGAMiRfAw2S0DiJA+iTZxvrl+hSQOTghqzbesOFTmogfELxZdeN8e4fSl5
	qQ+XQlfZ5SG8WjfhwiMqvCd9pCEoRiPnvwqS6n1p7EWM+dYPvBWMisWCa9dpIiazONG3s/5SEq6
	BwDUT8IBbJhpKBZOUsv4WMClT9Z1NLjXV5Ov/HXtAS/OkhFTQ+y6i/lUcU5BSpZZrKaTRmcbToR
	miCKO759Pb5lFGc5OYK/iVb353XdHDyoL308Fzz1tP6S2QKWzYLJzBEX3woNkV8r5wKNMpQ5COW
	x8xZCWZ2h2rCPCPQojeVUV/RCi3dkGFEa7R0/NEkastpE3vfShI+/3bp5ZTHhf4o89ebdPCL11D
	FjTSz904GjS1vCbBCvjOrfMUrHesbCK0XBGxGXDBDaL
X-Received: by 2002:a05:6a21:9d84:b0:3c3:bbe6:95c7 with SMTP id adf61e73a8af0-3cc71c57b6cmr12589551637.17.1786745297980;
        Fri, 14 Aug 2026 15:08:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b77:bdad:4587:c682? ([2620:10d:c090:500::6:84a4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141388bd5a7sm16363905c88.15.2026.08.14.15.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:08:17 -0700 (PDT)
Message-ID: <e1bf30cac04d54aa328fee5282de348a89494048.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/13] bpf: Add verifier support for 16-byte
 returns in R0:R2
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Fri, 14 Aug 2026 15:08:16 -0700
In-Reply-To: <cd43d82d-0f0b-48a9-9d81-eb214d96a3ad@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811000947.2381981-1-yonghong.song@linux.dev>
	 <e6f6247b319dde9f055092cd337a61292887b141.camel@gmail.com>
	 <cd43d82d-0f0b-48a9-9d81-eb214d96a3ad@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 11:20 -0700, Yonghong Song wrote:

...

> > > @@ -19366,6 +19452,22 @@ int bpf_check_attach_target(struct bpf_verif=
ier_log *log,
> > >  =C2=A0			return -EOPNOTSUPP;
> > >  =C2=A0		}
> > >
> > > +		/*
> > > +		 * An extension replaces the target outright, so it has to match
> > > +		 * the target's return convention. Its own return value is capped
> > > +		 * at 8 bytes (a >8 byte program return is rejected at BPF_EXIT),
> > > +		 * so it can never fill the R0:R2 pair the target's callers read.
> > > +		 * This cannot be left to btf_check_type_match() above, which
> > > +		 * compares return types by btf_type->info only: an int carries no
> > > +		 * vlen, so a 16-byte __int128 and an 8-byte long compare equal.
> > > +		 */
> > Should the btf_check_type_match() be fixed?
>
> The function=C2=A0btf_check_type_match() calls btf_check_func_type_match(=
).
> In btf_check_func_type_match(), we have
>
>
>          t1 =3D btf_type_skip_modifiers(btf1, t1->type, NULL);
>          t2 =3D btf_type_skip_modifiers(btf2, t2->type, NULL);
>          if (t1->info !=3D t2->info) {
>                  bpf_log(log,
>                          "Return type %s of %s() doesn't match type %s of=
 %s()\n",
>                          btf_type_str(t1), fn1,
>                          btf_type_str(t2), fn2);
>                  return -EINVAL;
>          }
>
>          for (i =3D 0; i < nargs1; i++) {
> 		...
> 	}
>
> It only checked the t1->info vs. t2->info. For example t1->info and t2->i=
nfo both
> have kind INT. But t1 and t2 may have different INT type (e.g. int vs. lo=
ng)
> and this is allowed in btf_check_func_type_match().
> The same thing it also allows int vs. int128.
> The same for other kinds e.g. struct (some struct has smaller size and so=
me struct
> has larger size).
>
> So I didn't use btf_check_type_match() and rather use tgt_info->fmodel.re=
t_size > 8
> where reject any prog returning more than 8 bytes.

Yes, I understand the mechanics. The question is whether
btf_check_type_match() needs adjustment. This function is used by a
single caller, bpf_check_attach_target():

	if (prog_extension &&
	    btf_check_type_match(log, prog, btf, t))
		return -EINVAL;

And just a few lines below this (and v5 of the series) adds:

+	if (prog_extension && tgt_info->fmodel.ret_size > 8) {
+		bpf_log(log,
+			"Cannot replace function %s with a >8 byte return value\n",
+			tname);
+		return -EOPNOTSUPP;
+	}

Given that the sole reason for btf_check_type_match() to exist is to
answer the question if an extension BPF subprogram is compatible with
the subprogram being extended, I thing this new check has to be moved
inside btf_check_type_match(). (E.g. by deeming that integers below
8-bytes are compatible between each other, but larger integers are not).
