Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65D17BCA
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771546439; cv=none; b=twiuvW2ZTI5sKM2aI88bxm/L7E3XHI5q1OrEShkFUTrqQ3aeRICf5eAb6RyiQ+Mc0ZNS8T+ogAxSN4Q8hvS9GJB6uTR3UsajjqBUrsdqItX8X53+BvBQkVxrRN4iF8sMpPKMqN1J7+AE+uYo+JdlMD6iFQwQluxBf0qvGCXxdXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771546439; c=relaxed/simple;
	bh=eK3pUJ5mNcioiln/Ma5A7kx3CZN2lRZnlxLCoGat76w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFRBQ5kUVbU5KDIAbojKke+3KhrkA5wVBlsoQHBEJ9FUUggBhgeoLYhQR2o/rTRdgRHq+V3qFO1MtxWWJoQ9cNt6qDdQNns0DJcYNdrfe6/WkvSqj3A2Q0lTlXThX8nUHIdL5LTQP1QWiB+0ApWevYqZmT5OIBnb+dvq9T8116E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTq37hCf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTq37hCf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48375f10628so9292365e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 16:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771546436; x=1772151236; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vWvZhz8mK3Ad3Q3KFYJIxCj2PkwY67Pk3Eem0L4tNqY=;
        b=LTq37hCfWlk4lI0eCIZ0YWOZ4SEtXwcGOTn6soML5ofqSPZ6g5hTQUgEj+mX1sB4Eh
         sh1vA24labbFvr3eiysxNxYgcoHd7osVxOndJhV3rQHyGT0krlP2mW3G6rMJRj88eRnX
         xFcTN+7FS01Y8VheRbYVI8b+WqPvgQ6J1haF2MU2U1CeqgD0Ik+XjR46oHuahq/AeOyT
         o4gfKBFE2QdEZ30zDLuaR5tE5TQfuxkRMiVgG0W0lDj3dWFJcXpEEVtgBOTAYvCjlvqN
         zH6eW4j2/ByqgVRyRToV6NPnu3OqZC2MO/9Cu3MWNLbb1MSHXJ331Xgkx85LtUsrPXYY
         8t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771546436; x=1772151236;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWvZhz8mK3Ad3Q3KFYJIxCj2PkwY67Pk3Eem0L4tNqY=;
        b=NyqsF8RLKdJWMdTo+t8ruOu0V0raIqFC6BubZmwmULQrx1jyKotHNW0lecsctTAyiv
         bAVwbfIAnqNp4k7VvQYiLHDCHfTh/YAc51egOJqfBABqCghKfJGFDioOP/OJkAo7EpNu
         jKmEaxkwtZtP8QtJIruu88uUYAAqRW8EAqKD+EwwQHgqwMqLPiKl4DxmnmLFoqai5Wdu
         rafuCgnAaFqUOpPn3yhN3MPfVclgHK8UAnwa7EbVTIQbRea7Q9d05ps3gryN1ZV1UZtt
         rURe2cUOswmdDV+TN+GQab+CIGwxtAwJyXYsE+8TqDhmx3zr3HcKlQyeE4XixfaiO+Eh
         atvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfKLKrcEk+LupAh1SG9JkXXtuFFoJ4ympa7ZWUsQ1CsAauUWXmtg5DdeRYTAH5i/V+B+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF2n5tBywL5OHgffcI2ySe1cHZXmGDBjwGmjZ3X6G3+l8fuOC5
	jLHFDCK9sdrELQ9aUniKRlxhKOxrj/txh7ZHV1d8K2QQsWiUez2X8g4l
X-Gm-Gg: AZuq6aK9kk/8YrJQcAAB++zekTzG5Mg1LBbDzt8Jw9BNED+q22iXlosqaoFFWXHjI7g
	DaTDU+GX+EwQB+NCN6rq5PUxfOhlI1ErY5vdx2SOp+p/NMfPmXGeY9n5bbbxI0KPnPHw5275U21
	HpwYH5md/AKdvVDjoLvPLfHMKY34TiI3YWw2f+qF3mzTUKmYp8ZGy3ml7gendm89a5GhO7Mpolp
	7eLerkJb0QfBm8YJxFsJGnHq+NB8XaAYTIkFQfkRKn/4SQKNBZPINDPPGzmN99LRE5tzkwn4jgD
	O3i9qYrUacsKVSKZXBLP2sA3vYtBRledQ5dt6nJuSMKEanxmGJCCfaftBWw9+CHdVy/3c+QaKlu
	OWahjw4TmiU5aZU05o9U0+49N8ha9n2Y+MXfqPfE4xuD/ilFdjnGqWkM0jTbIyx5GO6sLDvLT66
	DJvkYH+dCUQ73uchN3dpZIZWSpg7fJPfkgRFImtEtoaf1Rn0+61V62vzbMwtYE1vtcrC/3NobVy
	wo+W5h4sjo23/B57UK4Q2mvuHe+SQ8XGVAh4xBuDycABrl/7C1pGlbtuNHTE7ooQnbzYqbKPcWb
	+4p5+urb56Xy9LOAc50fCQ==
X-Received: by 2002:a05:600c:83c6:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-4839e636fa5mr51770195e9.8.1771546436270;
        Thu, 19 Feb 2026 16:13:56 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e009fdf63486ebff0d3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:9fdf:6348:6ebf:f0d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31ff4d7sm35341505e9.15.2026.02.19.16.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 16:13:55 -0800 (PST)
Date: Fri, 20 Feb 2026 01:13:53 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
Message-ID: <aZenQb3H5g73Bhz9@mail.gmail.com>
References: <cover.1771316309.git.paul.chaignon@gmail.com>
 <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
 <12705b3d58569685048804c33e90755c17667cbf.camel@gmail.com>
 <CAM=Ch06Vg-faG9ukU4DAsF9FRG2PeUtYHh3BkG0dOzYi=WDCyg@mail.gmail.com>
 <5044b1d83c3c916c0754eb5556008316c36c15ae.camel@gmail.com>
 <aZdcoaH9ERUNpln1@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZdcoaH9ERUNpln1@mail.gmail.com>

On Thu, Feb 19, 2026 at 07:55:33PM +0100, Paul Chaignon wrote:
> On Thu, Feb 19, 2026 at 10:32:19AM -0800, Eduard Zingerman wrote:
> > On Wed, 2026-02-18 at 01:06 -0500, Harishankar Vishwanathan wrote:
> > > On Tue, Feb 17, 2026 at 5:58 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > [...]
> > > > > 1. The u64 range and the tnum only overlap in umin.
> > > > >    u64:  ---[xxxxxx]-----
> > > > >    tnum: --xx----------x-
> > > > I think this hunk should be rewritten as follows:
> > > > 
> > > >         tnum_next = tnum_step(reg->var_off, reg->umin_value);
> > > >         tnum_max = reg->var_off.value | reg->var_off.mask;
> > > >         tnum_min = reg->var_off.value;
> > > >         if (tnum_next > reg->umax_value) {
> > > >                 /* The only overlap is umin */
> > > >                 ___mark_reg_known(reg, tnum_min);
> > > >         } else if (tnum_min < reg->umin_value && tnum_next == tnum_max) {
> > > >                 /* The only overlap is tmax */
> > > >                 ___mark_reg_known(reg, tnum_next);
> > > >         } else if (tnum_next <= reg->umax_value &&
> > > >                    tnum_step(reg->var_off, tnum_next) > reg->umax_value) {
> > > >                 ___mark_reg_known(reg, tnum_next);

Actually, that last condition is not enough. In the original patch we
also would check that umin is not part of the tnum. That's needed for
example if we have R3=(u64=[0; 1], var_off=unknown) (a case possible
because __update_reg_bounds is the first refinement step in
reg_bounds_sync). With those values, we would match the third condition
and set R3=1.

Checking that tmin < reg->umin_value in the third condition would also
not work. For example R3=(u64=[0xffff; 0x10000], var_off=(0; 0x1ffff))
would be incorrectly simplified to R3=0x10000 because tmin=0,
umin=0xffff.

What we really want is to check that umin is not already part of the
tnum, as in the original patch. I think we can however improve
readability as you did. Here's what I have in mind:

    tnum_next = tnum_step(reg->var_off, reg->umin_value);
    umin_in_tnum = (reg->umin_value & ~reg->var_off.mask) == reg->var_off.value;
    tmax = reg->var_off.value | reg->var_off.mask;
    if (tnum_next > reg->umax_value) {
        /* The u64 range and the tnum only overlap in umin.
         * u64:  ---[xxxxxx]-----
         * tnum: --xx----------x-
         */
        ___mark_reg_known(reg, reg->umin_value);
    } else if (!umin_in_tnum && tnum_next == tmax) {
        /* The u64 range and the tnum only overlap in the maximum value
         * represented by the tnum, called tmax.
         * u64:  ---[xxxxxx]-----
         * tnum: xx-----x--------
         */
        ___mark_reg_known(reg, tmax);
    } else if (!umin_in_tnum && tnum_next <= reg->umax_value &&
       tnum_step(reg->var_off, tnum_next) > reg->umax_value) {
        /* The u64 range and the tnum only overlap once in between umin
         * (excluded) and umax.
         * u64:  ---[xxxxxx]-----
         * tnum: xx----x-------x-
         */
        ___mark_reg_known(reg, tnum_next);
    }

Wdyt?

[...]

