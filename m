Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE331E852
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088854; cv=none; b=EFHpyqG3SgsSBdS8qZ0WrHD7W0f9hSA4B0lMWR6LDTChUR+tF0HXK+CN2Hg5VJpgoFMyhQsdBO96O2PwRyhJxxG/6roE/BJzADrDwFZEt+ZY4x+emD6DD9j3bgfNswkz/kgfsvHBMH+QeJdd70kt2RiYkX8QhYTfgHESkOJ9bEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088854; c=relaxed/simple;
	bh=avzpMIpWk8G0UsinOiaW/I+zSHwJiOsnpz63IET9gm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKo5YztG5Phw4IiXx1LsmFsX14QRDeb1/jqH5uQR5wwCsmFAO2VfQujZj1ydnYvL/FSN1AJsrA1y7Ltk46ckBClIgPuI0TAsUTRKr/GgeZX0rmmROwOhaAM3Uw952+++y/+mOwET9KsPt24/1r6VpLBzvHVrc5adl3YwQJesCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF3W6/jt; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF3W6/jt"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66b35d2c4edso646781d50.2
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787088852; x=1787693652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3sDmUeEbcal2gxd06G7R/9k1xkDLSkoYHHtzuG733R4=;
        b=kF3W6/jtJwvv4A0H6CNDc2vwexeyPGmkzPlmKMXuLoLpQh/DyCrEcWXJqQfu/Ty1dh
         RJZF2DJvF4X0+kbqJN7bEGy+A0cm9HDKJOHD/CGbhpsVBZ5sQWXkFFXP7X/LIYUPSlEX
         jHsZxiHyMuup2x96l1R33XK3s8pH2xWrbxkQ7Npts+qabNAuoPxaXglnbJs+oT7g2Xjm
         Un11fCY4a0Drnj6Vk1ZiegGjLhDm7M9lPDPHy8ZT4bzbF5c3R+cOMJfNsZlXFACYgI/f
         wK+ThaZzLvlgguNvVXuAxIg1vvTV/mwPe/BW+iMj9qf8OZkRBazuKDdy7cvcxjLQrwsD
         siwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787088852; x=1787693652;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3sDmUeEbcal2gxd06G7R/9k1xkDLSkoYHHtzuG733R4=;
        b=TKZscu4ArtFU3JlylRn6u1aUMBkkI4GX0Ge/1TSK6wMiMpYTDsV7oWm7HwXSAX81zH
         4VjfX/roWzdHsdbG6asKFn3L1WFNYLuqJfIdYnyjO4a5WM8GAeW6KBWccUuO7fvQe+Cl
         lu7ONjXuUbbATacepQhLq7r7vGiY4mRClgQ/jKdqC3Z9AAvctVcl1lw62AtTtVf21Uwh
         kEST2jeZ1coWFX49gZzz9CG8WeDZizPRf6u22Vx5MhfjyXgtygtpWiY9Wj8IJth9N60l
         G2VLyBk2SwFQfha9ZHii/OGStADBcojm84JTXCWtSEyaoFly6DEUXXzGeG4HxkSK9gvq
         RcMA==
X-Forwarded-Encrypted: i=1; AHgh+RrQn4Js8pgEKfJfEQU4WBExM3AlzSOdnogNFjCsm/K7jr6I0GrjurjotrvyIg6ymT8dAZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7g6kQU/gO5Lw9kBZDdwNYLuYQgI38Ux7Ww24h1NirAKuTQuvT
	O8tBMSAy/3tOeviMegoeE9ZOfBLbmu5hOTmBzojo8mKoOxHyPeYRQoZn
X-Gm-Gg: AR+sD11R6TRJ3141cnk6DdG/Ws+f5yfahHSqgNomcQ4npPFrPTZITsXRDzBi7ba2cA9
	0m8z+T6IbsKpdPBykE3yxBONEJ+iazPmAAk0JXfLYhBmXf7mTw0a23W0eIdJoxHeq+UH0GkFIfb
	NMMpNzstFmMXQTe+GlXFhgZ3PpJVohvF9URo7ugmHHaOjxU32oG2vpGunVOoO8RUHPlDZHQKaa5
	mUY9lh+TBJghOM6OBwho3riZN1djhXDTwvEZmgOxbNp24yz4+MU4Fc+nOwz1pr9l5m/V7DvptoE
	6AvADfsXS7HB9WJoHIX7JcAfvg2/tnNsQ1lWWrUZ9b1ExlvkVT8IH418L1sfcpcjYYsKKRXrUW7
	uQqWTYzuD4OZ+jTJnRef35X1eocS77XQ1FPSRruHh1BOGL7IjJWoZ6d4e3oyeNFgWLG6FAIxOUN
	1yzaT9C+JNYOom0uMFQBIs9cjL+Kapn+6xkjuw3deXEHWhPGMDEWYcWnn/aFZtYmS+3DZwUWqGY
	ez523DD2ACk8bNAv4u/Ok4=
X-Received: by 2002:a53:e911:0:b0:668:9b6a:653b with SMTP id 956f58d0204a3-66ccb537d3amr50318d50.3.1787088851823;
        Tue, 18 Aug 2026 14:34:11 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:5ffe:d5c9:845d:50b5])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccb19e096sm52049d50.19.2026.08.18.14.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 14:34:11 -0700 (PDT)
Date: Tue, 18 Aug 2026 17:34:10 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, brauner@kernel.org, daniel@iogearbox.net, david@kernel.org, 
	eddyz87@gmail.com, kpsingh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matt@bobrowski.net, memxor@gmail.com, 
	song@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next 2/3] bpf: Add user memory access kfuncs for
 linux_binprm
Message-ID: <aoTMu0_CNLyLGh45@zenbox>
References: <any3wCj66dWbwgwT@zenbox>
 <20260818082441.4091-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818082441.4091-1-tasos.papagiannnis@gmail.com>

On Tue, Aug 18, 2026 at 11:24:41AM +0300, Anastasios Papagiannis wrote:
> Thanks for the review!
> 
> > Would it be better to handle that case transparently rather than
> > requiring introducing a new kfunc / leaving that gap open for NOMMU?
> 
> > Either return an error or perform the copy from bprm->page[].
> 
> > Unless there's some reason I'm not seeing.
> 
> My understanding is that there is currently no way to use these kfuncs
> on a NOMMU system. Although CONFIG_BPF_LSM does not directly depend on
> CONFIG_MMU, as far as I can tell, no current NOMMU architecture provides
> the required support to use them. For this reason even if I write that
> code, this cannot be tested.
> 
> > It would also be better for portability across NOMMU / CONFIG_MMU
> > systems (the exisiting kfunc is never registered, so a program using it
> > would be rejected rather than able to handle the error).
> 
> As you suggested, I would propose to register those kfuncs
> unconditionally, move the ifdefs inside those kfuncs, in the case
> of NOMMU return an error (e.g. -EOPNOTSUPP) and allow the programs to
> handle those.
> 
> Does this sound reasonable?
>
Yes that does. It's a small niche anyway (I don't think a lot of people
are using BPF and NOMMU anyway, and BPF_LSM && !MMU is unsatisfiable
unless RISC-V or some other architecture gets JIT support in nommu)

And when/if (big if) it does, they wouldn't even need this kfunc and could
bpf_probe_read_kernel() bprm->page[] directly.

So an error is best. 

Justin
> Thanks,
> Anastasios
