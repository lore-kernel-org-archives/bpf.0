Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82937BE9B
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775996339; cv=pass; b=lbJ3sV39I0+51eWPzjkizne2ZvScgymwhv3OwzeF5KKRtmyhDvm2ayQBIpbLjfm/Ez72D7GE3km3UbkEcugkDC0TKvR60wO8PBPaII3dn3CiRtnopl6Grb0QnnqXfRamw+bciFQFHfHpR3DGbQfylAyNwde+19dZwq6O89/Qlyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775996339; c=relaxed/simple;
	bh=uafX2bQpJrLfg9yfw+DCfmB3m9g7ysXsoTFfZ75pRt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqQGCRGoRGgCSxhz6pwGRi8ACV/OwT/1tqc0uVh1/QlFS5EC9lsHgm77YAz2NLORopy0scPjMKHxdEscYxmKglcLuMmUBZaexs5aaXtSnISxTTQ4Y6qMeb76pQslxrhDPDhIBtEluj88+QFyW+sBxmRQ34DGD2OGI6uykHG5QjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1w7iWpP; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1w7iWpP"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7b248750279so2343437b3.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775996337; cv=none;
        d=google.com; s=arc-20240605;
        b=YWt6NHrlxQAHdSGN+o6gHVOO3hfMRLjMg1JAWqCgv5by83YL51sWjRyT6aercLR4wk
         DuqZOBvnDEgdNHjoGhSVDO+k/HHTFVKOAvu9pN83I2a2MxJ8e7Jc6+WHAGmbhXBaBSBc
         gae/Me+22G4edGV21BBjAbaLIHCWxtM7eY55hj2t69VGujkKO86B1v33Wi8S+AcdDE47
         JLdKDbPIh4TRXurP1ACBH8jWTfMa76Uvhl4KWpb3UfKPa5Khc3mD+1EZM44yG2Hf9rba
         /h+3PtQMxgwvJPqAwIHnQkqeLK3tjKNx+bE3t6O3c6UngkZc3q4z4m1mCUmpfxSDbhT8
         wr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pDCtYpSt5MQDUqGRaPZuhMEbLqOBYANHADybtg+qQXY=;
        fh=ITi6V+df/BLXKtPIOzuiePDH0Gx42eXDKfus5vZtqfM=;
        b=SEniWsKGrt+eCr0lJupcfjE+GZjPZ5r7cNmAFd5WaBFWvsKY/hF0jS3KjZwbk6kFYd
         FQ7xMcefXRLKUfVXICcoziSn/Z6XE0UGl/ewt/O4pfMitt8NfLsOX4YyOgmN7fbXKviV
         blvn7Dl/unMJ8+jfLGB2ltjgLcpElFfMoWq7y1UpZUdnA12OJzCnc0lWzRCP5y9aqINV
         S0B3Fsk3/DS+a1bRDPXvWcH3rs5rbB4xTt9Pz7YOcxgtDLDCXZpMDizR8zioD7Tybw3o
         2ZQqaH6YW68pHGvS7jPVBg+Bvjg3pfWjoOya51AQyZeSSwp6WxidqXKcxUoGsAusl8/i
         Rl5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775996337; x=1776601137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDCtYpSt5MQDUqGRaPZuhMEbLqOBYANHADybtg+qQXY=;
        b=L1w7iWpPjeegHoc9cP6BaGEAqFGK/8eCGY7df9Mu6T7TiPe6jg8yrlfT5j7X6WhBZS
         JCZf2TZlC/ol2ltgkb2jLz+ZBfnaddtYmm7F2xg9ysRtaKPYEIIj6Kc3fMIWXVRQhfS/
         Rv0lcdIXCgI16EFL0Z8jQJqxDECvrtcyPN0s9S5J4Q9Ac2X/MxNBac78S1FhVR1+aDbn
         mKfrDac9sl7Lf8IZ8AxVCoHAyODdkNQMhgvyOhwOlgaUNvf871kGs/tzQ9Y5Q99GPL7T
         roUWoyD+oGDJmTDhegrO0nRZOlBkMQKlLi8EulyjkxfBm0psBw1b1Xa7X+laho44JjdZ
         +Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775996337; x=1776601137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDCtYpSt5MQDUqGRaPZuhMEbLqOBYANHADybtg+qQXY=;
        b=qVZu/TyjCjkZ57k260VP79Hpt3RfXKGbNH4O5YV02aZm6XmwWiaffBA8CSDyvtZmn6
         INmhiMBQVAau0szmJVFzO6DuyCWTO3+ryyBow8OLSbS4J5mKIpvCT5V+5Q3FPaLwWoJE
         BU5gke851VMA2LKAdZXzQTgbyyBYV0ISAUrP1qRTP5N1zTzlG4+zng0u7BjHMZjZqevJ
         QXkmQPn/bZatI8V5Gh2Hg/tI8aszxm6Wyj/SzVOR6oJpgRqWxW65pAcSUjgJmAyfsZv6
         hwg3xG/5Qsp3xzgM3Lz6u9TEJ0F+e++ak216auK6i7c3zqAM3Hffur6AkcyaSTMlBcyf
         CVfw==
X-Forwarded-Encrypted: i=1; AFNElJ+JUX58yySfEJjZSYB8D9Lg8WcB42WZXwv5THway9oXUkMduPzkopoh7P6UGwl6hK3t7Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64hsSH+m45e70TfGZSPJPu9xKEir9c6BQvX9crSInLK1Kx/+6
	rijcJDUsmghvWNQfg8vlqwKcH1OcXgA1ilPea1Sy8DPb2PxJeWqhhjH3l+cds4Rxmi9WGH3bJa2
	ZmzYvSWk2kV45uob8Znp3H7KqSnlEaNU=
X-Gm-Gg: AeBDieuZqUO7ME6SkvX7EVXvOurReEIy8BV2ULulyONxxb99qvz1K6/9oNCsZzIHxZB
	++bWKOl8kNAvYoNaQCqGmpEFG+4u/w/V9XNEqSrdZXSBrEfNYs04BTPhVhaMOZKy5q2SUQeHZ5d
	f1BXclApoIbKcaZcrUUnapSwrtRODFsUlwTPvK3Ji5hqWp0PY/neHC6Mmmhp85ZBcvLKpGEJgWZ
	U7XHTrA9hF8fBubtG4Tgp1jr7fSfSgt2IxhK5SomlMqjpdy4ouF2jA7pgF2RaCHEPKJNPmc628P
	n48nqNFKifbBfF0jKeLudubvbGBZeOCi5sN1f8Mg
X-Received: by 2002:a05:690e:e8b:b0:650:70da:bc25 with SMTP id
 956f58d0204a3-65198c71a1amr8599414d50.58.1775996337015; Sun, 12 Apr 2026
 05:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com> <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
 <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
 <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com>
 <adUd0Mojbtrwmeod@pathway.suse.cz> <CALOAHbDG9mq1iJv5suct=cqJ+2r8VvJ-dXN=nuvMw0XYqnUjxA@mail.gmail.com>
 <adY_WgA54CDtWBq6@pathway.suse.cz> <CAPhsuW42WqGuZ1Z-RG0yzifZ7rh=XKUa5hKb6JxLeTWdc4s4-A@mail.gmail.com>
 <addW_-whBavyHY-Z@pathway.suse.cz>
In-Reply-To: <addW_-whBavyHY-Z@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Apr 2026 20:18:21 +0800
X-Gm-Features: AQROBzAAbQj2joTRPhJ-lyVJz17Ih4lLYbyXLH4mJVa2clLa9rohXScgqMMq5Wg
Message-ID: <CALOAHbB-b6YUx4zQjp-AgV0gYp26pKjwrjABd8+XJHNsW=0EtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
To: Petr Mladek <pmladek@suse.com>
Cc: Song Liu <song@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Dylan Hatch <dylanbhatch@google.com>, jpoimboe@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 3:36=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Wed 2026-04-08 11:19:50, Song Liu wrote:
> > On Wed, Apr 8, 2026 at 4:43=E2=80=AFAM Petr Mladek <pmladek@suse.com> w=
rote:
> > [...]
> > > > >
> > > > > This is weird semantic. Which livepatch tag would be allowed to
> > > > > supersede it, please?
> > > > >
> > > > > Do we still need this category?
> > > >
> > > > It can be superseded by any livepatch that has a non-zero tag set.
> > >
> > > And this exactly the weird thing.
> > >
> > > A patch with the .replace flag set is supposed to obsolete all alread=
y
> > > installed livepatches. It means that it should provide all existing
> > > fixes and features.
> > >
> > > Now, we want to introduce a replace flag/set which would allow to
> > > replace/obsolete only the livepatch with the same tag/set number.
> > > And we want to prevent conflicts by making sure that livepatches with
> > > different tag/set number will never livepatch the same function.
> > >
> > > Obviously, livepatches with different tag/set number could not
> > > obsolete the same no-replace livepatch. They would need to livepatch
> > > the same functions touched by the no-replace livepatch and would
> > > conflict.
> > >
> > > So, I suggest to remove the no-replace mode completely. It should
> > > not be needed. A livepatch which should be installed in parallel
> > > will simply use another unique tag/set number.
> >
> > I think I see your point now. Existing code works as:
> > - replace=3Dfalse doesn't replace anything
> > - replace=3Dtrue replaces everything
> >
> > If we assume false=3D0 and true=3D1, it is technically possible to defi=
ne:
> > - replace_set=3D0 doesn't replace anything
> > - replace_set=3D1 replaces everything
> > - replace_set=3D2+ only replace the same replace_set
>
> Yes. This well describes my point.
>
> > This is probably a little too complicated.
> >
> > > > This ensures backward compatibility: while a non-atomic-replace
> > > > livepatch can be superseded by an atomic-replace one, the reverse i=
s
> > > > not permitted=E2=80=94an atomic-replace livepatch cannot be superse=
ded by a
> > > > non-atomic one.
> > >
> > > IMHO, the backward compatibility would just create complexity and mes=
s
> > > in this case.
> >
> > Given that livepatch is for expert users, I think we can make this work
> > without backward compatibility. But breaking compatibility is always no=
t
> > preferred.
>
> I believe that it is acceptable because:
>
>   1. It was always hard to combine no-replace and replace livepatches.
>      I wonder if anyone combines them at all.

Because 'replace' patches can supersede 'no-replace' ones, users have
to maintain a strict loading order. I doubt anyone actually combines
them in production.

>
>   2. I believe that nobody tries to load the same livepatch module on
>      different kernel versions. Instead, everyone prepares a custom
>      livepatch module for each livepatched kernel version/release.

Correct. We always build and apply distinct livepatches for each
specific kernel version.

>
>      And the tooling for creating livepatches will need to be updated
>      to use "number" instead of "true/false" anyway.
>
> That said, it is easier to always use "0" for non-replace patches
> instead of assigning an unique "number" to avoid replacing. But
> I do not think that this would justify the complexity of having
> different semantic for 0, 1, and 2+ replace_set numbers.

Fair enough. Let's drop backward compatibility to keep the
implementation simple.

--
Regards
Yafang
