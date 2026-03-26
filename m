Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91908DF59
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774496818; cv=none; b=jFJZTTHIs2n5MRl8TUrHPP31c1IOx7Kud7T2x/ZHYBZUx1vigqVhnZ8ZXkrUbpYJ4zaSAc+sNx8lPmv7p/NsPeU+4+nRzrWwkCmclTIjXPoO8SO4BWDaySm/sowaFjKKw9gC9I/Zi7092ZBwX/cbYiWGxR4sF6Dkl20XvIBlWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774496818; c=relaxed/simple;
	bh=TpXIOE0zKCcg2/dKXEK2isrj55QtWa+ucN7wcNDcoS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fx3J+8ISMf2kJ8ByAYgFF9VY7eq6rr3VAgC07DymIpwVj/tB8BnX3xT5GFaEvnj3MP9su0eNeqeCG8iIdx0S7eoIqrjiNQV4GMMzTgqIJ0c63VSlfmcb2cCALh2DLl6TY8Z+lcSs+UzYkCsUddsDUq5DpgencozRY+NPOIfbbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gsdHBl0p; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gsdHBl0p"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-482f454be5bso14495465e9.0
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 20:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774496815; x=1775101615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rx/hM9tEY2bKaC+3a39zTrnXDe9lSCuvs2OMj9HI3+8=;
        b=gsdHBl0p+VZQRTNpJXao3xsdWvwiTSupW4I71bMbpTHh4xnvuVQNAs8r62Ev/i9JN2
         mSIx76p75ogPHF+iCJ/whAxLubWMaWmRtJqWIlQac9UyNcXLyLEdFoJQFvi/JlueHqjD
         UotVeP+l+qkHovue0K1osYGGY11jvkC3LumQ3RqFlCRP6V4exKIeV2JUl7LbhF8us7lD
         fvbkEjM/a8qMOu0JD2g5IgSDEWKbHnfvlfoqIUpi0wtozsKzPEqhjG4lJdw3dwEbKZz9
         M77VXOZw8GaebCSTCaEROFY0GTkbDPvHWMPq91crx7z4jBdtrhX/f6NMU07yXOJ6T7H1
         ZltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774496815; x=1775101615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx/hM9tEY2bKaC+3a39zTrnXDe9lSCuvs2OMj9HI3+8=;
        b=BS6R/sXFcn0oeudymbUR+vnyTVKjDpQwgA3whwvvC6Nxjm2/Ifh6mN8+jZ2BzsjyQI
         oZfnWBlqX9fyPWlb7uEAq3umH6aAD+uhzT3i0XwiDOsvXRnBZHnGIBj/ub8k4Q/ZpRW9
         xp8vgaEbuTywKQAtrgzTPU8XaEs4RpH+XXWiVW7NIMAT3w0+WR2P+13him4Pqmm+ywvx
         QQNroqLuBxosh5guPvppwE/tTGn4RAd3Lj4pHwYH2p6E1rVMVikJKRHf29r39MqPhwb2
         PzrTK5BWD4ILHTHbBvCEpdR/rVZcijQrPBrx5gVnVyPllpqXiBLdGrGEPaQVb2PM1JZj
         sKdQ==
X-Gm-Message-State: AOJu0YzU3L1rTsR9XrMdSW1KKMrhio82SrcijOuiZ6ZMFln2avmKf/CM
	r2dK9J0xWniIMGswf7RkfLFzWZfP7ScCdNjJc/N453sCOH7LIHOHY2976W0yBiKit2s=
X-Gm-Gg: ATEYQzzY3/Aq+EAe8gc51TKS5zGbVJbVfTxe3Bctk73M9kNwfdk5mch8ChWxIrbgvTW
	EDsMnbzqOBydbS/pjW10f3AndQPvNRZmsXY7WD4q/Yz2FHbhnPesCxWqQ2RafSAICZnXG5Y5fxz
	XajSC/9+UMqMvZpESyfC7qr6I7te0XOsaeph9f1JiqU45RdTKLYwOxufFM2d+ByyvtyvMf4OVRj
	5PXQLqieJFUAnxlddZu8XzOfzXqsMfGC0pQBXHzpcsFh4H2Y74cH8fvgBGo0QWJtDNPw2mQIDl1
	2Yg3LHDAGq8kl3LpgGjMinn9JUaOetpresW2CgaCDakdwGHayvwQsFFAQ8/uJorXGRd8wY8181J
	/VhqY1o3AB4RmR1xajCHRSTf/amlN99c7vPQowyUe66r7EUw1Kr/WvtYsfX50ZnFORKef1ndSQc
	KEhE4Ha68ADqL3/S+6ISY=
X-Received: by 2002:a05:600c:2d82:b0:487:467:49e9 with SMTP id 5b1f17b1804b1-48722b92fcfmr418905e9.7.1774496814828;
        Wed, 25 Mar 2026 20:46:54 -0700 (PDT)
Received: from u94a ([2401:e180:8df5:367c:7729:d191:ce82:e062])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22d09573sm9229a91.16.2026.03.25.20.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 20:46:53 -0700 (PDT)
Date: Thu, 26 Mar 2026 11:46:47 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, paul.chaignon@gmail.com, harishankar.vishwanathan@gmail.com
Subject: Re: [PATCH RFC bpf-next v1 1/4] bpf: representation and basic
 operations on circular numbers
Message-ID: <pptqk4ehfb4zptc6ubd7h7rrup72xkaqzgkdguf25iunp4j4ot@n3ddkhculaok>
References: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
 <20260318-cnum-sync-bounds-v1-1-1f2e455ea711@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-cnum-sync-bounds-v1-1-1f2e455ea711@gmail.com>

On Wed, Mar 18, 2026 at 09:28:58AM -0700, Eduard Zingerman wrote:
...
> + * cnum32: a circular number.
> + * A unified representation for signed and unsigned ranges.
> + *
> + * Assume that a 32-bit range is a circle, with 0 being in the 12 o'clock
> + * position, numbers placed sequentially in clockwise order and U32_MAX
> + * in the 11 o'clock position. Signed values map onto the same circle:
> + * S32_MAX sits at 5 o'clock, S32_MIN sits at 6 o'clock (opposite 0),
> + * negative values occupy the left half and positive values the right half.
> + *
> + * @cnum32 represents an arc on this circle drawn clockwise.
> + * @base corresponds to the first value of the range.
> + * @size corresponds to the number of integers in the range excluding @base.
> + * (The @base is excluded to avoid integer overflow when representing the full
> + *  0..U32_MAX range, which corresponds to 2^32, which can't be stored in u32).
> + *
> + * For example: {U32_MAX, 1} corresponds to signed range [-1, 0],
> + *              {S32_MAX, 1} corresponds to unsigned range [S32_MAX, S32_MIN].
> + */
> +struct cnum32 {
> +	u32 base;
> +	u32 size;
> +};

Minor note, memory are vague, but despite having 'size' available seems
to make some calculation easier, I end up finding using 'start' and
'end'[1] more intuitive and feel to me less indirection, as well as
being closer to existing implementation. E.g.

...
> +/* True if this cnum represents two signed ranges. */
> +static inline bool FN(srange_overflow)(struct cnum_t cnum)
> +{
> +	return FN(contains)(cnum, (ut)ST_MAX) && FN(contains)(cnum, (ut)ST_MIN);

To check overflow in signed ranges, just do `(sT)end < (sT)start`, which
should be more familiar to most.

1: https://lore.kernel.org/bpf/20231108054611.19531-2-shung-hsi.yu@suse.com/

> +}
...
