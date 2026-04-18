Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3780E2BD11
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776471794; cv=pass; b=s72IikBJHZ8ziIRWeZHo3dnXuY5Vi3qGgPBhgPOxuC33ghNHVsFVnmYlU4xiXmily7SUOEyWoRGuLeXM0ccf0oGL4IRSooGuFTeXxoPYqmIcKewh8JrJIdbM84yvAXfSAHTrGqQnXc2Yyymlow7ywb9Mi46OhLyg+RYNXvOUNv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776471794; c=relaxed/simple;
	bh=xhSglTf4sCCNbeqQDJAF6mKa7/YyJ4WWlkfjUTiFytE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=an7LY7e/DpAe+54kBtKUnsuZk7OZhXrhwWWay56vcQGU4CqHn+XmToro+mhZhuiTLPdvNAIvw3oASnLHE+BaxPszTgdzy7VulM9Y4WxeJypg46Tro821GzNPAtiVzb+rBudhBCaW46zIDwi3eoqKLl3H6Uq/UQdgfOE2IYP+TaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKg+mqcd; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKg+mqcd"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-610e2e8f57dso447296137.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 17:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776471792; cv=none;
        d=google.com; s=arc-20240605;
        b=L+u+AYHv459eCeC41PcLZ0EPtnCOtiDuml3dgnBhX8/wjGqANKOV3JpvbFPtYepRgg
         1EY1qN8TlkpVf++MMnz5Yit9GhGcWjadiWDS2ivZObyZ9kTnQb6nXzLatbyuWDNHN4hg
         ZRKNJbMVDrj/o8LWWa/hAwOTO2F5SnMSVzkamW/z1i2Zin1kEWwQSsyLQ3DLaz5fpEbi
         NVVIKl8SlZ9AQlxtX43UbfDQVsv09kV/cgDsSiCMHr+QQdL0HLvSc11JSnsqg1QJnJha
         HhsQyAmnjKGfsZ478k0dOnTRb1YxOqLH5Bf0sQGv8h8avfTbFuyF65W2Vn7bFJzOzHpH
         JMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=av4VDF3EhhoUlH9xfUPwoi8+oC32XXJ2js66c942Ih0=;
        fh=ypw/5fet4CANHeQUz+kfgabEvSoH35hHHOlcI8B0sBI=;
        b=JZqtI8MNQ+FiYr8qUekfAVh2nWPcnPh9Jb4i5r2HTHgGyw8Tl+dYPXSoXWz+91evOG
         FG/DkwpERZQidfPUkZ40YQXAn+SnNmipCV3pn+kSZOZQk5NAJWUBftsC8ytBvIhS7ukR
         mNPaAT8NN8YaW4JXFog8FdMOE0wkYYcv5yPSOMESAiUHRIJLTqNAeeie12leIzaefGiD
         QSOmYuyqjWEpFOWPRw6FpCCVnwIv3olVXYTFnhar2bwGrMZtCX/P38+bmTcuMiAWVOHT
         vgBZEo/cD3GrghMJ7rKkIfYQ8whGl+/oxQ/sNr6d4krkWnygK79Rc9UxMBkHTW5ItBJm
         wySQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776471792; x=1777076592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av4VDF3EhhoUlH9xfUPwoi8+oC32XXJ2js66c942Ih0=;
        b=sKg+mqcd3+7cro0l2lKgQOZ0MI0p6vdctoJ7c5BNDtQa+L674SDHJjQMt4CB6XdRDK
         ijx9avIWelsHEMyxHdgnMTI0+721oGlDkda9E2cBdws/8FCrQ/3GttIRUcd1jxFd9J6L
         ujqr3MVAFZ32eeifpEkt/2Bw0wmt0NckHI0m5tpUSL7l4R9RYSUJxK+taa/uAPT4RNWX
         ukasfxWCBC2SuAG+c2svWve7XA8BT1p/rAKknUq7cGPnLsb6y5cpS1iIpDNsL4E37LrG
         /ICuMQYlEtIVAVW4IwvBcWnUHkKK4/XuiJ6CvwNfckg0hUVkb3jVu2czo9ipWS3Yseoe
         Gj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776471792; x=1777076592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=av4VDF3EhhoUlH9xfUPwoi8+oC32XXJ2js66c942Ih0=;
        b=Zr+JOOEFNAj85I/TRkV28GZp1SrIlJd+fjT3/ayhA1cRt2DXeVJicKdFtjzDf0bsis
         1SrOboBCwpalYospWp7nv9s9GFR6JeOJ7hhFkQFvuzmpdtPEeG+v+qA8PfUC6U9eN3IF
         b/6RQBSIkG2JLp7KBt2wGHlOhYCWIiBL4KI+diQ91AtT6uaMhV0dJQoijbch1HvDn1hi
         i9lH03SRaoLbjp2yLi5hs9gopFbEJ6/qPySrI9EOmFhjF4GlNL6nZ8vPa0grHCEW8RE3
         2mJBx+mGKGuMWXKODi2MnhUNQJoGhGnzDzJlTY3cDnMLi8k7Z2H7N+iMBk9V7R4nUgTl
         LlLw==
X-Gm-Message-State: AOJu0YwYXa64Lk7i7P5DTAJXFYKuv/xo7+j+svD2xsjww9c92g04o+3E
	dHJXiJXRmp+uUDB5ex/YcS4zYjyA83nrh7dkmAvqeXuZp1Esy2OfQYUU4UpoWTfLaZPgNb9y0lP
	gvntMt4MsnZ6OOW2+Fe6F7oeI5+ca5TrMlHy0bP2AUg==
X-Gm-Gg: AeBDiev/nLOLvHSFDOGkXU9oW+jfgLl1Xa8oXKV2AeYCjHiZgq/j04LjW3RlPvLb38l
	97y2XZbBZqLPhJaeE8sAKcnyqbydeOW5l32XqwTfwaYeqCnggxgN2LnerMAcIw13qkRV8Y3suQG
	8DYp1MkS4NSp8ZM7X21+onVCZIxwJ2YOvrj1wy7IC9Pd3I+ZeFoA5yEecL6jB7qHQaRV8xW2vdN
	/h3gb43hfPL0Key5g/zg4sUvxH1KWx0nkT5t4U+xymr1W2Tz2J8LgyPVkFg/NueRHMcHDtwzlZO
	R7Xi5gfWy9juHkuEYzq6++pLBQ0hRgA36A0E8ntmTijTjFOvx5/h
X-Received: by 2002:a05:6102:38cf:b0:607:5cd7:d7c0 with SMTP id
 ada2fe7eead31-616f772f67emr2460964137.19.1776471791982; Fri, 17 Apr 2026
 17:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
 <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
 <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
 <CAM=Ch07jcncdAA1D-uh66OuVXnROF72k8gunJy2cSMuvJNP+nw@mail.gmail.com> <f622c0166e9c1809184673c1bffda7e43ae495ea.camel@gmail.com>
In-Reply-To: <f622c0166e9c1809184673c1bffda7e43ae495ea.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Fri, 17 Apr 2026 20:22:55 -0400
X-Gm-Features: AQROBzBavB_jEeJwwbwndYDFUHOeb_dCSdN8Fl9SKvsQoSw28VTePWB0aaV1ozc
Message-ID: <CAM=Ch07M1S2aX+h0OOv6LOjYFaHbYvvjO2+ZopFbhVBK=i2u0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 5:17=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-04-17 at 01:34 -0400, Harishankar Vishwanathan wrote:
>
> [...]
>
> > > Could you please comment about the witness idea?
> > > Suppose reg_bounds_sync() is modified to preserve the properties I
> > > described above, would it be sufficient to check two candidates:
> > > tmin and tnum_step(tmin) to identify a register in an invalid state?
> >
> > IIUC, your idea is, if there is a witness, it should be one
> > of tmin, tnum_step(tmin).
> >
> > - I don't think tmin, tnum_step(tmin) works, because you might
> > need several applications of tnum_step from tmin to reach umin.
> >
> > - Assuming tnum_step(umin) to reach the first intersection of umin
> > with the tnum (let's say x), x might not intersect with the s64.
> >
> > -  I think one of tnum_step(umin), tnum_step(smin), smin, umin works
> > to find the common intersection point among u64, s64 and tnum.
> >
> > - But even then that particular intersection point must also intersect
> > with the u32 and s32 (when mapped to those domains). That
> > complicates the reasoning.
> >
> > Also how would you ensure property 2 described above
> > in reg_bounds_sync()?
>
> Continuing this train of thoughts, consider the function
> find_witness_aux() from [1]:
>
>     /* pre-conditions:
>      * - (u32)a_min <=3D b_min
>      * - b_max <=3D (u32)a_max
>      */
>     static bool find_witness_aux(u64 a_min, u64 a_max, u32 b_min, u32 b_m=
ax,
>                                 struct tnum tnum, u64 *out)
>
> If there is a tnum T, a 64-bit range A and a 32-bit range B, such that
> `(u32)a_min <=3D b_min && b_max <=3D (u32)a_max`,
> it can find a value that belongs to A, B and T if such value exist.
>
> I believe that this function can be used as a basis for complete
> witness check including signed and unsigned ranges:
> - Each intersection between signed and unsigned ranges produces one or
>   two unsigned ranges.
> - If e.g. (u32)a_min <=3D b_min does not hold, further subdivision is
>   possible.

This is very similar to what we were thinking about. I was coding
it up before you shared your implementation.
I have uploaded an implementation at [1]

The main problem is solving the intersection of the u64 and tnum with u32.
The other domains can be reduced to this.

A single u64 interval [x, y] can span
a) A single interval smaller than the 32-bit space
b) Three intervals, [x, k], [k, j], [j, y], where the middle interval [k, j=
]
can include one or more full 32-bit spaces.

In the second case, any one of these intervals could
intersect with the tnum, depending on the higher order bits of the
intervals. To figure out which, we can intersect these 3 intervals
with the tnum (using the tnum_step check), and can discard any
intervals that don't match the tnum.

The procedure at [1] follows this approach.
1) We intersect u64 with s64, to get at most 2 u64 intervals.
2) For each u64 interval, we break them down into at most 3
intervals as described above, to obtain at most 6 u64 intervals.
3) For each u64 interval, we run a u64-tnum intersection to discard
intervals which don't match the tnum. The rest are used to
form (at most 6) u32 intervals.
4). For each u32 interval we intersect it with the tnum32, u32, and
s32. If at any point, if any of the u32 intervals intersects with all
tnum32, u32 and s32, we have a valid allwise intersection.
If none of the u32 candidates intersect entirely, the allwise intersection
is empty.

There are more details in the README about the implementation
and in the code comments. Please let me know what you think.

[1]: https://github.com/bpfverif/ebpf-domains-intersection/blob/main/inters=
ection_allwise.c




>
> Meaning that final witness check will need to enumerate several ranges
> and call find_witness_aux() several times.
>
> Wdyt?
>
> [1] https://github.com/eddyz87/find-witness
