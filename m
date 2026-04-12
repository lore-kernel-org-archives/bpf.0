Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C31B4F2C
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995797; cv=pass; b=Gn1TSDSrnkXaezqSdUFYYP2ZXPdSrFu3B7ZrzUoT0x7I68Fm6L8bEiuDQ0FkLVpDYuOCYIcpW08ZyTnyLWwdNhtHFquGGLu1R+txW5F+wRp+RZkwOmdJ8v0YbLxwn+6NslkKO4iIhuuOhE59rh3/KzmhT/5G0br4/ow0vaSyqSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995797; c=relaxed/simple;
	bh=SVTNVJLn1VqDWx0HDz8tbsYxcEIfkMoVv4id3LOHg7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDi0cijOb2o4jHTwWn3pYLLtbxxS3gVMtj3oZYo7jWcspdeEg01Wz3gAAQU1IdbTIjTOsxYMMWSHXZTzaXSdMulVwgW+poYMPQEVhcfQcfH+atKASeh1Tmzt1sm9BfLG+gHuu4JQ7698A5TnPTifJzQMJgV1HgRzN4BPRGCOOSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrduKbKu; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrduKbKu"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7986e0553bdso33470367b3.2
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775995795; cv=none;
        d=google.com; s=arc-20240605;
        b=OkUgssFAdqSolKoAU5lSgcugk3+ObJhJmqUZURFvTsZkllpryftcd2m0kfa9h7Joqx
         uqSPtrXvIuvdaU5la2WCRGuNHGktHSKeHGU8/EKe0hxnJNipPgQHo2ijqngdUKVyyELC
         UK1CBsEHnJa/UPgmfr1ZEekzQmZYFnw94+8eRs8mWjfwh8Ay2c/nchtT3wWlILaEWd1n
         hnJaBSd8OGr5FlsgdmW+PqBWTKFV7oYkA8DV+mYiplR0g7PlWmq3iH1LN3FaNj0EJ0ge
         L7caXUHHNpLOVtVH6fMzv/3xJF5lLhF+pIb+GeT7uaJ9yU4g9VhHz493lNOLWA+d7uEl
         QM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3yi7Jufl9MZ6r9E9T+DntWdpQRPYoo/vSgS2eY9Rp+c=;
        fh=uLdhUBuUp2ynjUEdz1qnPo3ArlJq4lM/hwa7YkBaByE=;
        b=go2I4jJ+49pns5r68yR88c97LBhfrevh8zHkA283HmOYAOi2vXYV0k75EtLw9eQyYI
         CAixlJEReU/ZDl6bIlvYOjKZqXYPRqlQs89jguvQJYoKrpADFpRzd96swltp85ImZGvd
         6oLvjtGE3OxWcQxd+uvltMqhvt5KaMKVkz69y8vb1Bgur1CVZGsk9l1eglyRocBYJWwq
         b6mjmP95ELNUGWokfB5dHqXFC+xbd1sDuEm85YRn3RijYKFngpH5eWSL9sXHSP1zjT2M
         r0DI4xXk4W+J5QihSdi1ZuF+/YJnJR36RZLVnpLUujzctVPJNJvdh3JO8321v1l/YfJd
         i4TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775995795; x=1776600595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yi7Jufl9MZ6r9E9T+DntWdpQRPYoo/vSgS2eY9Rp+c=;
        b=jrduKbKucOJ0CrdEhOzQjksun3glLXXyDIsHC29QDod3cu+as1tdU/z//zLc3j771F
         Ww0mpRkjrNeekX5PJhDel6R4DMkc6Ea5uPdNN8QAEvd2w2v9BWeqEgh81fUyMRKCYoaz
         PKjzJ1ADdJLkpXk9OsWoHjE4qpRTULett3nyv/g16kMfC/HsuxD/CBtq7KDTa/Q50WfX
         IGmN9R4IaIlJhNnocOiKpGnjeqM6Ob+Ym6X/+JxHmIEuW+GzceECvAJan3e9NKQ5tB8t
         4SnhUenVs+FFcdLic6qX9rVRaofoOzUPQ6B4l5TAYm2AmbSyukIT2c/v4XbvLqPuvyd4
         SlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775995795; x=1776600595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yi7Jufl9MZ6r9E9T+DntWdpQRPYoo/vSgS2eY9Rp+c=;
        b=rOr74ilVhuMLL+x9yDDDcmRrD+l5w1Y4YOE+OLRBPlTin07N+R0nvokcgK3et4cWwV
         LG8IuxMppLgHonXK0AAmzpe7rHKv8h3lpxTiDhxEEkhLla9xsqMdQJEvtPPK0fKP8b/Q
         V3DCpSBOhn6K9dI72S1apH1ROrzNRfy+R4HYrzJLEZohvTFZbTfPWMv+Awk7cfNhURhX
         NF0GUigDq18S0p+xGvEYx4dkYfGEHGS0N8sCqcJGvuE3FT6StlS5RK6dqhuvtVL9xwPi
         3rjZDkigqWT2JOr9TEQ71+smPbMY8CxD2PUGy5uH2nozFJy9AiyxSlQYPOnt/ijbGq0c
         OPbA==
X-Forwarded-Encrypted: i=1; AFNElJ+xjxZgLXDQ4+VbSbq2Q25HcC4sPQX9mkTJBZE+FhFSMcuINK+u6c7aKOndWU2OJbCVw6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5GI5GJUBwO/Aozt4BlM7SpkYC+xSu8JakB7+RkAmqLJzmBpBI
	kIODFmb0tgn9nNDnJOwog9uT9LTOQoxHkL+4iSaNKEP8MG1F5JrrlKTM8C0abLulXtySQqyuYrd
	bTakFGh20WBTQc1EM+hEflneWxd8BFKY=
X-Gm-Gg: AeBDiet9Pbt5uZ/ULPeB9XEXvC0DaeRW6h9s1Jlp+TIMdAMHze6RQlZMKzv9gfypB9z
	FPd3wfakhneiX11xkPND/8OaJS/RfUJAEsBLUZS+LENoBgzWfvq+eyO/vD+SDgcuJaM74MzO/JT
	rcqN/c5Cb3Ny8C9VY+uOYp085KpFXMsky0aYaEp4NUXihRS8TgsJFlf8PcCYTw9Xrj74jkHucMz
	YtM7i7ckLzINGT06rKzjB9D/tRQbytSZMst2lBnUj3wDvEHEnTU0TiIloWCjDJd0FNovRESnRGN
	I6f6wLa0rYxpG0fzdEC+U7wexf3BkjFWvm0X8h8E
X-Received: by 2002:a05:690c:dc3:b0:79a:cc64:886e with SMTP id
 00721157ae682-7af7282b96bmr107487127b3.52.1775995794798; Sun, 12 Apr 2026
 05:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
 <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
 <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com> <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
 <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
 <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com>
 <adUd0Mojbtrwmeod@pathway.suse.cz> <CALOAHbDG9mq1iJv5suct=cqJ+2r8VvJ-dXN=nuvMw0XYqnUjxA@mail.gmail.com>
 <adY_WgA54CDtWBq6@pathway.suse.cz>
In-Reply-To: <adY_WgA54CDtWBq6@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Apr 2026 20:09:18 +0800
X-Gm-Features: AQROBzCu-w_ClAxqsNaksL5y_dXr6lYJTZQFfWsBZznnXM9_LWPtoFPm4-st89c
Message-ID: <CALOAHbB8Kt-RTVUcy66Bx__Bqu_YWKjgJoRBRNTGXk=CNmXGPQ@mail.gmail.com>
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

On Wed, Apr 8, 2026 at 7:43=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Wed 2026-04-08 10:40:10, Yafang Shao wrote:
> > On Tue, Apr 7, 2026 at 11:08=E2=80=AFPM Petr Mladek <pmladek@suse.com> =
wrote:
> > >
> > > On Tue 2026-04-07 17:45:31, Yafang Shao wrote:
> > > > On Tue, Apr 7, 2026 at 11:16=E2=80=AFAM Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > > >
> > > > > On Tue, Apr 7, 2026 at 10:54=E2=80=AFAM Song Liu <song@kernel.org=
> wrote:
> > > > > >
> > > > > > On Mon, Apr 6, 2026 at 2:12=E2=80=AFPM Joe Lawrence <joe.lawren=
ce@redhat.com> wrote:
> > > > > > [...]
> > > > > > > > > > - The regular livepatches are cumulative, have the repl=
ace flag; and
> > > > > > > > > >   are replaceable.
> > > > > > > > > > - The occasional "off-band" livepatches do not have the=
 replace flag,
> > > > > > > > > >   and are not replaceable.
> > > > > > > > > >
> > > > > > > > > > With this setup, for systems with off-band livepatches =
loaded, we can
> > > > > > > > > > still release a cumulative livepatch to replace the pre=
vious cumulative
> > > > > > > > > > livepatch. Is this the expected use case?
> > > > > > > > >
> > > > > > > > > That matches our expected use case.
> > > > > > > >
> > > > > > > > If we really want to serve use cases like this, I think we =
can introduce
> > > > > > > > some replace tag concept: Each livepatch will have a tag, u=
32 number.
> > > > > > > > Newly loaded livepatch will only replace existing livepatch=
 with the
> > > > > > > > same tag. We can even reuse the existing "bool replace" in =
klp_patch,
> > > > > > > > and make it u32: replace=3D0 means no replace; replace > 0 =
are the
> > > > > > > > replace tag.
> > > > > > > >
> > > > > > > > For current users of cumulative patches, all the livepatch =
will have the
> > > > > > > > same tag, say 1. For your use case, you can assign each use=
r a
> > > > > > > > unique tag. Then all these users can do atomic upgrades of =
their
> > > > > > > > own livepatches.
> > > > > > > >
> > > > > > > > We may also need to check whether two livepatches of differ=
ent tags
> > > > > > > > touch the same kernel function. When that happens, the late=
r
> > > > > > > > livepatch should fail to load.
> > >
> > > I still think how to make the hybrid mode more secure:
> > >
> > >     + The isolated sets of livepatched functions look like a good rul=
e.
> > >     + What about isolating the shadow variables/states as well?
> >
> > We might consider extending the klp_shadow_* API to support the new
> > livepatch tag.
>
> It would be nice to associate shadow variables with states so that
> we could check which shadow variables are used by each livepatch.
>
> It is partially implemented in my earlier RFC, see
> https://lore.kernel.org/all/20250115082431.5550-3-pmladek@suse.com/

This patch is still pending acceptance, but it offers a nice
improvement. With your modifications, the remaining task would be to
integrate a new replace_set into klp_state and update the API
accordingly

[...]

--=20
Regards
Yafang
