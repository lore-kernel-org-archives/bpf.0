Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594B13D51E
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774397305; cv=none; b=M9Klf9wieUzfavjlr5oqerDnMSpu/fgdUi5oZfmNVnRxHwnZTPACEbB2vJXvhcbD4b+AlEeRpzJVhnbZqXWg0AhE9oA8464flxnrOwwsKjo89b12AzHZCcd4d64PVjgdq7yGLpDR23Z7X9sA+hSuKIWWZPnxp0Eos9YlJNxWdEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774397305; c=relaxed/simple;
	bh=8PWDeFsSPAQxT5s1vTmPcO3gk6UBtRUaHgt+0Hxr550=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwqvIv1llEsjEFcVdJ8CLvgy71pjV19Rz+XYW1b9M3ExHsittD6ZMRSjWmhk5enFHFQek+y43baYekSe7Sxci0wTl7kradxz/lLPDErBBlRbU7WnqiLj+zQCDYrcAGqQ9Z9GF5532mRgdBFz1IK64AzY3RxbZHR1eSlHLjPvzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH2MWiKX; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH2MWiKX"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c1092cc08cso2040434eec.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 17:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774397304; x=1775002104; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=anljWnIgB+Zw+Fc3bpW3eKtjg1Z7f933CBy7wuCK1Go=;
        b=jH2MWiKXOg9XfKuoBVDpJC0bumoRGFpfi95RRR3xTvxl1cfuz/E8IqpC0dOJCKUrXL
         N1UiFLsG9Q0qGrkFpz/9JDYTVGOhNuQ5BhoHnUxIy+CGLIH2SQhD84Bbp5UgQleBVozi
         OY+cK7GVTtp1UqRlkOjxuWr1ljTm9Q2PSO5wzH4XCgmaIglOeaSM9s7pYGRKQZm82fiZ
         +Nb5/PQtMr8oijWkL2aSupVm0nqFU3kP6VmqKHXwwmb0b7EFThe2kSYA7idL0T/PP1SZ
         WuOYfd6/zxiAQv0wxFGQVddjAK2IqRfu0b/nBKxx+Xfy0VjzE7QPYPIgkHtwe5GkluJw
         avCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774397304; x=1775002104;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anljWnIgB+Zw+Fc3bpW3eKtjg1Z7f933CBy7wuCK1Go=;
        b=Zdn9OdmmEFA/wAmhVnEd51gSaESIHGD0WpmbhDl8EW1vDCJR0sONIyesRY2Zaf9tlP
         ew0KazBc+1X5OnF1n0QGEU0mzuUCplMyf+cvblYEnd0hUF/o3niYLG/5uqKKz0YiFiBt
         bcwb8jtL5/OhUa+dRE3J7eM/3B9rSdQ59IpMm3XHc5PP4PduVDddkP8vK9k4gYQU8OkP
         SIKtORKD8AVVYGZG5l3CZjW9UeSb5WxObuG1MeV2B48wAOq44YhYLEhKZUxZ+yBF2m7F
         rFVc8tTk0Bo0DLvmONwpONiR9VF+LfpiNZJtBfRY/DaS8xtEnHMIgAUoi1c2c5ZjCA4I
         fWng==
X-Forwarded-Encrypted: i=1; AJvYcCV4if74Bm0t7vuaP1JM66Q5iJgB0UZUThrV0bEvCfYUsEfwxPX4fEpUgIwtq1K5QEQpPOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg7qkuxrwjBoLNin5NPnHJ46jIhbAS4Zj4LPw8hyiW+nZeX2Jn
	boW1MRS6KJuvsvUa+OlyfkwUPXw/hwT+XJMY0SeDBIMB15IYShXeiTGX
X-Gm-Gg: ATEYQzxg/yeVSvF3scpz3duKHnFz+U3l2yRdL7CQ5NpSi1ocpvkZ8fNvqWlzZ/pLg7V
	fQdlR71vXoLXdJMdVoZwgmd9ZoAGv3ebanBbSxLRNr2biCM/StYZ3uR3xZvuEv71jiJEX650PCu
	K8Bt430tKV6EPTCSpHkEh9xhUNLx88Nz4pydt+pAcgH1pSW3h8StIILhqKGDRcqL84UuesXTFyI
	igyAh6R/NPioxaBvgwIGNKlV4htmkO+zOa6DNaLB+JPBOCNt6pKceRbvozE4UepnToI02THlkC6
	3tjy5jgJDuqEEFO3hHqe1ZY9JmZSxoJTjzkd4wVYo95i3LgDlkMyIDcRiVcghvkwpnBP1SpXCbe
	fwUUaReb/CyMzjcqLqkJMFxXsMdqCnn5QOxO52cJjFNM4+iD1ADcx8wvk7l+zUsnIpfpz9yfEIa
	YFqv/ruqUj336z9BwMMBI/smY4iiEd9zNblS3F5S3uHhoivjTx/mtW61H3wbDpcF39ams/6/r3Q
	Q0kXQ==
X-Received: by 2002:a05:7300:cd8e:b0:2c1:571f:b821 with SMTP id 5a478bee46e88-2c15d49f242mr730268eec.28.1774397303666;
        Tue, 24 Mar 2026 17:08:23 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:41fb:8dcd:b77b:d6ce? ([2620:10d:c090:500::bed7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b1a88e5sm21094754eec.13.2026.03.24.17.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 17:08:23 -0700 (PDT)
Message-ID: <17127463da926dd8850d1b5c8e645da15cca2f0a.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] bpf: Simulate branches to prune based
 on range violations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Tue, 24 Mar 2026 17:08:21 -0700
In-Reply-To: <CAM=Ch05-XWF-x_VzUZAWhRO9eum-bjdutuwvPXEcOvnx_0omAA@mail.gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
	 <d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com>
	 <847173114a13630e1512ad05375c6b407720a916.camel@gmail.com>
	 <CAM=Ch05-XWF-x_VzUZAWhRO9eum-bjdutuwvPXEcOvnx_0omAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-24 at 19:59 -0400, Harishankar Vishwanathan wrote:

[...]

> > Also, it appears that tnum bounds checking functions are unnecessarily
> > restricted and should be implemented as follows:
> >=20
> >   static bool const_tnum_out_of_sync_with_range_bounds(struct bpf_reg_s=
tate *reg)
> >   {
> >=20
> >         u64 tnum_umin =3D reg->var_off.value;
> >         u64 tnum_umax =3D reg->var_off.value | reg->var_off.mask;
> >         s64 tnum_smin =3D (s64)tnum_umin;
> >         s64 tnum_smax =3D (s64)tnum_smax;
> >=20
> >         // check that [tnum_umin, tnum_umax] and [reg->umin_value, reg-=
>umax_value] intersect
> >         // check that [tnum_smin, tnum_smax] and [reg->smin_value, reg-=
>smax_value] intersect
> >         return ...;
> >   }
> >=20
> > Wdyt?
>=20
> I like the idea! If we do this, we should also rename the function to sim=
ply
> "tnum_range_mismatch" or something along those lines (as mentioned in
> the other thread),
> dropping the "const".
>=20
> Technically, the verifier should maintain the invariant that all domain
> pairs always have intersections. There are 10 domain pairs:
> u64_s64, u64_tnum, s64_tnum, u32_s32, u32_tnum, s32_tnum,
> u64_u32, u64_s32, u32_s64, s64_s32. We can have intersection checks
> for each of these pairs, or we can stick to the major ones, i.e. the top =
6
> in this list.
>=20
> Checking for intersections was part of the original idea in the RFC
> for tnum_step()
> I had sent a while back [1], which was about detecting intersection betwe=
en
> tnum and u64.
>=20
> Generally a simple check will be
> if (tmin > umax) || (tmax < umin) // no intersection
>=20
> The original idea in the RFC was to use tnum_step to make this check
> complete. Particularly, for cases like:
>=20
>         t =3D x0x1 {1, 3, 9, 11}
>         r =3D [4, 8] {4, 5, 6, 7, 8}
>=20
> The above check won't suffice. We can add the following check:
>=20
> if tnum_step(t, umin) > umax) // no intersection

Yes, this makes sense.

> Since tnum_step() has been upstreamed, maybe it is a good time to
> revisit the idea, and have a sound and complete intersection check?
> Or do you think that is overkill for this patch?
>=20
> Also, then, should this patch introduce domain checks for all 10 domain p=
airs?

I'd say we should check each and every but 10 sounds a bit scary.
Maybe do it in a straightforward way and see if it shows in perf
profile? Trying on a few large programs?

[...]
