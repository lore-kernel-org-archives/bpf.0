Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D0425CC4
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975014; cv=pass; b=iRx0SS/3XcRlpp4L3pxRVdYfWvbJYSoajXjw+xChQI82Hpd9+iRYSM1GNTX2Nbti0sclM/tLW+pNgp6dtVAjUJQNhR6ch4zyotAncN2etsFEQ8tXEZNYOYx1cDdexgp1bZnr+1DxI8XN+yl3gEYBqiHvwvGqqqmDkepM3gAqDU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975014; c=relaxed/simple;
	bh=wvadUB3fmrGUR2ikjBmVV0/+HIAYCYPQvlJUKbn61Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skUfb1/fK5JKORke4AyYRXoxxftqzqlTUmq5hqeVRS+40tmozANlHvGOZlkQA5DHCLeHlDnPYlw/e0bfsL45nMOE4CVZnuWMmkwWBuRkm9hktZWbOD1LbHPjUNzIj4l2y2QtbnKlWSUsxT7KxBJWR55Q7M+JLjfei9klSozSZV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2mvMYwl; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2mvMYwl"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d03db7f87so1222315f8f.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 09:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774975011; cv=none;
        d=google.com; s=arc-20240605;
        b=MK9BKBGpJpXVoEVG2Mr3UtA+2fv1pV0TfC1n5p3ARQkC0vxoanwdas4hBulCs+au+R
         rpSPtu4ht+TrcgPcNletaTG85QW0az4XUblSRhX1ZEq006t3eprWhe1WODoBPWnFB/iC
         p7RIT2FQ47afXFFVoflnAXM4mQMAdVpCJSC9Yzl73g3NqHhhsNfwwazJz5nmdTOfLTsT
         4PxHixvRhFPge77MwdHV04bAv48a3pJdL4TJWUF4KJEoxkiFK3ZLBlk9eOAkd8aH6uty
         lP33sFp+od7PC9trB5C58B0563CwQU2T/p0+pxPLKiCX5LP3WZeNHcYMRriJldNtGxPE
         OA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jRV1GuZG/wdagyTqX0iWkRgi7qmsUHQCy5BNDyJ+6rE=;
        fh=yLQauWNajQXaKDaasavuK/3+xXTvndCngrQzdMS6rzw=;
        b=CfJSz6xtSJ2Ieo5ENi5zY/go4KBnAsbsmNC3SPwj0t2qM63yRXS5zAJAa7EPVhjrby
         Xt4jCpP6BCKBswClH3S0xB39f/68Aalr5YbMjy8MvymALwdq8Cvdlbs6DP/FUYnnE0Wn
         9ZalkFV1Te1dh2rmtlhKxfIbVlMVD8l5xcHjp0tlvMNpwkA2p9ekLAw4C4cg6NUzuNrz
         zkYXhIFzcwfmL6uqc0LNVr2f8LqI/H0zI0wnc3vSoFghbrbnjsAuL6qziuBZlmnAgUXJ
         a6+Y9Ktj2U3qZXx84TCi51ZlypLBWiryenJeGsblwUwteuZc+bpNy5X/OeQ6MFFiIwqM
         2wcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774975011; x=1775579811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRV1GuZG/wdagyTqX0iWkRgi7qmsUHQCy5BNDyJ+6rE=;
        b=c2mvMYwlBZl/aJqtFmJxNvY2BfAytfIJc3eVIbtHOs6BUncet+m/qt9vRIRpGvborr
         K4qFo9vfUH1LiASBA7XZIkm9tJa8NjSWwZciNTBQGENXRsy+JPeKHl5VdUUdobU6JAX8
         PzdWGHlpkvd+Lypq8Jsy/wGUYDx89keWAvNQShCss9IkxMprsGFGo+5+3j53ZZ9gHpc9
         4H999fhUs8ynAXkCvmsMjaHtxJPzdSTmShKJOXmp7zYCgBPHEwUhy+JQJ44t4ZJw69os
         p4RwDzbe3lWxdYgOl+EuaXfzCW2DgTEKyL8LCYw6Piqsz9MBuZFmU1CUmSYE68uDsxl6
         DNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975011; x=1775579811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jRV1GuZG/wdagyTqX0iWkRgi7qmsUHQCy5BNDyJ+6rE=;
        b=O9zAPF5g9h43rRSCdy3rsAVpmHEbDfUSPnJZ/AY1gyB2ubSKB8tN9yCo5PaJplBvuv
         FlN0ShJY7dPaKOBkK37BxG0/fG2Az+0W0vd4mjgK2PnzfamGH84Xq67c2AWCJgB3j06I
         uL4UG78d7hxnQNukcYskLLcyxjbSPx8hNqWBUUqiDdQBgYmQAYyt+FzxywVzRfRgGRNd
         UnfFDE3HNPmsLUDeWZ/SGvNgx/iu/jRk7HVWHtFXAVQRb6LL9N/NcgbH6qvfKzKZPyed
         zoYfEvKCxx7mTB+cQDKwaem/rUmkXiJpf++TeAD5Q9JhjmXfbK50VFgfSGYk1JaNqEIN
         6klw==
X-Forwarded-Encrypted: i=1; AJvYcCUgbIRIGAG3Ocpv5fmbaYFWwu3JDkhEA94vjHNHeNtAWKBAEdzD+eDVND75Wt/W0dVBfU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvK8qP6ODZ68c55ZvHyGwSWBj8hrMBSAWyFpT372xrlBZ7asxq
	dPQXRHIvzUWHihlPGid3ykxpwEnU/JEw/30mgYDVyE3/YmZJLYgo/ZXOaStmr5UA8BFt2LDjQqW
	s6JlHQY5ncEKzw7+gHMWzZ4smdXwdMTE=
X-Gm-Gg: ATEYQzwch2H4vzmA14x/Ph1+j2gg8KhBzTZL4vvsg/tf/1Y8prAGIU8spPeUb5A2YE3
	isv+8WHY7OrbPrH+uSY0o6MsSRPU68s98b7bbzoz+s1gKeCts5XXiyBdF/QQ8o+e9UuQLnrGce/
	YVwcYLCZEpTwN6BU3bzITqV4rkbFdG6CbmKX0AFWPlpVZd7IlGBi9JfYn2ZRJHKPQfgo/IKSk+I
	6ZLQCpglzAjROKsO8g+St56E4I++uTSR9oDfV77Pq5m2Eowko5m5AZCi9ifyxynnGb7z99QctDp
	Vco4YF13mtKgj/XGPW5EU3GaLkT57bXBao1EpKpOAByFXcTxmol35Sr139+0qvLkmEETzqsZ2G2
	qwmlBLfjMgIi4ngw40SlPnhg2ag==
X-Received: by 2002:a05:6000:2010:b0:439:bdba:56be with SMTP id
 ffacd0b85a97d-43d150429bcmr631505f8f.10.1774975011343; Tue, 31 Mar 2026
 09:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331005215.2813492-1-memxor@gmail.com> <20260331005215.2813492-2-memxor@gmail.com>
 <CAADnVQKP3bmuDP2NzKYhU776RFVuN4fOs3y-kyQ8AFzsoK3_2A@mail.gmail.com>
 <20260331120329.7126fe6a@gandalf.local.home> <CAADnVQLjsJCyPBXdEy5A0r_es8wyDJVFXJh+PNU2dMVUMD0DJA@mail.gmail.com>
 <20260331122727.7283e589@gandalf.local.home>
In-Reply-To: <20260331122727.7283e589@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Mar 2026 09:36:39 -0700
X-Gm-Features: AQROBzADkZDB3ZBYuLaItMOzq_viePRGC4OK2gvm75Xq04W8lBKXYJYJCKqQ4rs
Message-ID: <CAADnVQ+d6zfXFtQ+7eiPSkrxWhh8srk_X+Cuf9=Y4D1+fHTF9w@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/1] bpf: Fix grace period wait for tracepoint bpf_link
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 9:26=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 31 Mar 2026 09:04:33 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > > I don't want "srcu" involved in the API. That's the internal workings=
 and
> > > who knows, it may change in the future (like it did going from RCU to=
 SRCU).
> >
> > so? When it changes we can rename it to.
> > I don't think "srcu" part of the name leaking anything.
>
> I prefer to have a API describe what it's doing and not "how" it's doing =
it.
>
> We can have:
>
>   call_tracepoint_unregister_atomic(...)
>
> and
>
>   call_tracepoint_unregister_syscall()
>
> The "atomic" describes tracepoints that can be used in atomic sections,
> where as "syscall" means the tracepoint are safer for syscall context onl=
y
> (faulting, etc).

These two names work for me.
