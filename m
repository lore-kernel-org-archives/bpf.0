Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86904A33
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775531854; cv=pass; b=SnwQCOnQlkeNOr1kUAmLh/1kg4zPlmdSNOu0R8Jec3v8O8AeRP6lkMWeZj1sHj9By9L0c2wMiWpdq1E3DyexjAN76jZM1ObHzFoXPsuyI91UFSylw26U5UdnDep4xwNHLYTJCVH0nlIRz4LFS7LlZilSNS+YAbeXrCm1DzseX7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775531854; c=relaxed/simple;
	bh=6CnKNasyITD4j1QE4XtIgi0X7ZJLQxlz/57w101u5co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDjEJZlS6qMiS09jNkw0dI9LamiNajKU/Bol2Zq4PfOSpUtb4CxLp68MEs2Vc52SCLnC926YosbqUutKY3W2LSA2AFflSxgTP1LYE7UsmV64sQYbu7qNybOztHC0qtN+1W26Jqggp+mJYX3LPEvFPq11lACY+oTnLzzrIzk6fBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1kt9KFh; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1kt9KFh"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79db5e18ac6so50296307b3.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 20:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775531853; cv=none;
        d=google.com; s=arc-20240605;
        b=BQY2Q+0SBZ9Fj9LkaNgSlAvn7O/E0LML/5Hnh8XyrrMI+UtPO83JfZKQEToUIQaBU9
         yQQ+u1kXtAvjx1J8SjPkW/JU53Z1KH+VNqx2YwhXRspMFaJ3jqRLwjtTkgqMFRR72k+5
         Ftf+xXp+oVwTGfkByHefvztnmL/Tigd70Otfhk7IAriEeQbRgIGJOAb3F4CBpBZNoXPS
         FGoVdpdGJcjzl0oRjQpUhqohyIhgtuxLIa6Zns9WX266JHsOvh3U6ezkl9QyBO9cQeF9
         VCch6F6Rx8kcdxYRB+jGjVx1+jxbGI9SLuBTmsAwyzbhBlOV1/sIb/4k9VckEY0Q8iXO
         lwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n13KGfoQXw/JheUE7BLN4ftaWLYzsgUyZfU3shLQ6UE=;
        fh=Jx+ovLluVFSgFEHdbQL7F7JRyZNQNqNQyGuOnV3Mo50=;
        b=GuMCmeEj08YoXYs/McoatKf6pashYyBFzpfWx0l0SGir8BDlfM3WKhzbJJmWB9mNz5
         YDVnD9OOd40AmJ/FUqBKJCNsAZqYoGQnCWRVO9pW/oTFV1JQo3+I0OdrNppwCKcJBz+g
         +cs6tA7quCewClYzRrbaRhv6ZrW4LZo0bEs2amm5BVEAwUMPfZGju0LxWAVcr5z6lku5
         4VN6hYUMzSw34Sjaaj2yuvA01EG9b/Es2ssolq74mehRn3iGPSjiIbq4kls/59QPCDJd
         XUt5SRf22jpJeQciLNa1YZe0tAy8mhs6SR012E2XlNm9ATpEoKE4MSj73LOB0K6C+o+Y
         vCDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775531853; x=1776136653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n13KGfoQXw/JheUE7BLN4ftaWLYzsgUyZfU3shLQ6UE=;
        b=s1kt9KFh5RKKNomECIut4vs912QYz8t6mRnyIuks8WbKpdymCjd99HDaBQf0ZMKu6A
         tDF/q+L3Yodlx5dhvQwJRmFlggUPqJ27A4GcIL5YagBNkhdyJgOAO/i78q55J4SE4lJa
         GOlx12r59F7wbWfjlmfta+70FjXODYtV1mxacIrr2aLt3UYcZQPptsdMxfm8r3hXfui3
         k3dd3JjxvPwJ2lX1Q/yU8jxr4fPtof5A9s1rSbgeIMZWXzTYbVPCQccBCiDPi8+M3gRF
         tKHUgYZu8stbCmEgclbqWCzC24m8QVX8b6FVHIR3Wt/hCVON11rxhaFDQ7y++FnpFhGF
         4n0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775531853; x=1776136653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n13KGfoQXw/JheUE7BLN4ftaWLYzsgUyZfU3shLQ6UE=;
        b=bWQGLKqA+d+96tMMvfdPrHFgZySZCMImqUkqx+uJlTmmjVadiy080INoyfq85LdCea
         1x4qEf20ByQiUzKZSKbNcuJyHorphfCcnPHsFhb6GmhKSF5loVzeUcszKhcsqB2CayTO
         LEYnXLgoV0kf7HWCroOXhTYN4nCOwkoQc/LDlrhsbs2OSzMKApEimSnub5M7hj6gKpGv
         F6f7LaglqZ1D8JMujgASw7tTytB2QGnsnyoGbH/wwtCjuBJv2aHgqhaBX3wdUDN3no+y
         lPBvFZ/aYUSFh1gHLuj18Z3T7CETbzDPepcTmVh33JZZuE5TNt+fvGXIPdojHTI8Oq0m
         BJYg==
X-Forwarded-Encrypted: i=1; AJvYcCUYqWrODndOEmoT9H3fYCaXqZXTT8CXAlAnWmMipGvyIXuGkRnC4K+hJV88fyLmo6Lo1Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4oYzF4tHPRs3a2ZJsV+SVQ0Tj0Uf/aTAgWLJafTrEvyUuYNxn
	jt2m1y41UVNdMXqVAoXLrReIM5VqUwJQ5dj8vdiqLIA6KLZRt0M7KPX8X1iqh6vKEEGhp+sxeIX
	Q5cqloYn5U/FBuawpZ8zLTdAfxIL6Mk4=
X-Gm-Gg: AeBDietlVx1OavRJeOKNlfb7htFtW88QWzJIxKF0HB5/Vc0XoN2D4iBNix6S0rwcxpZ
	niUwPZwAqCKZwdawrjeGF+wE+YwdUxIdROYi5cf7RmSUSEgS2b8wT4/O8mVtDJ5B7bGLwstG7Kt
	8OnWljTUCIC4vUVKHXQ+MkzWQK/9MpinH1fyDPMx6t5WzPkuc8Ns+G8fCRX1/SBa33s5Iq7ba2k
	p4+DN6yXrD5nMuYzKsTSoOEnDuUaaJUIJOhG0gTgZixlK/HtX9b/sFGXWJh66FeOs1fRXC4R5eW
	U9WBsgKJRzIHDvIU5KRsLvm5/GVUybkdpkS4othZMlg+NcpZN4U=
X-Received: by 2002:a05:690e:1c09:b0:650:7b9f:2cdd with SMTP id
 956f58d0204a3-6507b9f3331mr921741d50.19.1775531852696; Mon, 06 Apr 2026
 20:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260402092607.96430-4-laoar.shao@gmail.com>
 <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
 <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
 <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
 <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com> <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
In-Reply-To: <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Apr 2026 11:16:56 +0800
X-Gm-Features: AQROBzAxg6OOezCNjm_WO_2NQj3cYCfJeAVYvX9rzsZKOm4J2VwnmP_iFBuGkkQ
Message-ID: <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
To: Song Liu <song@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, Dylan Hatch <dylanbhatch@google.com>, jpoimboe@kernel.org, 
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, kpsingh@kernel.org, 
	mattbobrowski@google.com, jolsa@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:54=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, Apr 6, 2026 at 2:12=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.=
com> wrote:
> [...]
> > > > > - The regular livepatches are cumulative, have the replace flag; =
and
> > > > >   are replaceable.
> > > > > - The occasional "off-band" livepatches do not have the replace f=
lag,
> > > > >   and are not replaceable.
> > > > >
> > > > > With this setup, for systems with off-band livepatches loaded, we=
 can
> > > > > still release a cumulative livepatch to replace the previous cumu=
lative
> > > > > livepatch. Is this the expected use case?
> > > >
> > > > That matches our expected use case.
> > >
> > > If we really want to serve use cases like this, I think we can introd=
uce
> > > some replace tag concept: Each livepatch will have a tag, u32 number.
> > > Newly loaded livepatch will only replace existing livepatch with the
> > > same tag. We can even reuse the existing "bool replace" in klp_patch,
> > > and make it u32: replace=3D0 means no replace; replace > 0 are the
> > > replace tag.
> > >
> > > For current users of cumulative patches, all the livepatch will have =
the
> > > same tag, say 1. For your use case, you can assign each user a
> > > unique tag. Then all these users can do atomic upgrades of their
> > > own livepatches.
> > >
> > > We may also need to check whether two livepatches of different tags
> > > touch the same kernel function. When that happens, the later
> > > livepatch should fail to load.

That sounds like a viable solution. I'll look into it and see how we
can implement it.

> > >
> > > Does this make sense?
> > >
> >
> > I haven't been following the thread carefully, but could the Livepatch
> > system state API (see Documentation/livepatch/system-state.rst) be
> > leveraged somehow instead of adding further replace semantics?
>
> AFAICT, system state will not help Yafang's use case.

Right.

--=20
Regards
Yafang
