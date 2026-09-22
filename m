Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C649E5E8
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104199; cv=pass; b=O4a044+/JfJdKDjfN8HhqKP7IP87N8rR/tGQZJ6ch1JAwSRIj/tMwVDR4sA+djwpX2laPL5dHQL+ygaTSTBwx+4M4dPhykQQGEYWZQPgPX9xfD0sya82dAYWLHPJEnaVNN/9bqFNfOuUTGq7686Yek++GCgLt3lclbFxy7HHYMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104199; c=relaxed/simple;
	bh=HRjLYOJSekKmScBq0Hs/Y+bO8oSzKItDYuuVYeVZwtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9gEkLQqqEobtbBIyc+KtBTC2GobZJSUML2AuytWEwrjHmg5Ib+gykRCTZplAv5symwY1qepYNc/3KA0HF/wzGp9AMwtOgxvtQrViyFYj9qo9lpHJZ1e7/ocUafdlMW9k5VYmEryxM921ns4mBqHGjZtk+7m0RgA4cRULobVDlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EouxBJkg; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EouxBJkg"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c264788fd58so21628066b.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 12:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790104196; cv=none;
        d=google.com; s=arc-20260327;
        b=AZkLUBJkm98b5TD09QV1lfExHtKj7dioVxzj4oXFtnlSAmJoeXX97ug0xjh003kAk/
         dbTA01ma8hvXTWKknVOIIVPTHpB5fvsO0SXuH0sco0hbmFCBGSo5BkReeYMexLn8W0i2
         WIhocEy6OQ1TFoOEKhIKlFKhyyJL3HQtQHaDtjoVCXu9U09iXCbp39eIff100UeqZITn
         HDBuZ64i6yR/gYIp6FEN1pIM79F0uTbjLGN0QLTRwRNSLYmabYfV/uK587C/pgKonPRs
         or4HwIpTJIJv6fkmboNQLC2BR1cERWCzdB4nVZX0TsuTkL2B0pBGBu7wVPES087btvmk
         f+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lK/yFq614ap/r/WmvWFumoINA4i+Bww9N4pHbrRhbvQ=;
        fh=W9VAdISQSV3qPNAzalYnmj2YOhOQDhGQoxpsTNtWSes=;
        b=LxUyEhA//8fhpqTTMknW/hx8QuBdaLKrjyXffpxZubYXUieePrsaHZqeaLDq+dCO15
         XYPjrzJjiRdZUt26OSUxdlywR6seVFg38GDPb0VQPFGWQw8qJcg+J5PSdKrtXJFcfaSK
         EOfZi20D/1B8q7+eMFOXT8ulrSSWoC8WQqT8Jmt1kgPTXP70cAUU/dvBwW7TaCmbEF5Z
         cO49NZ422Zb8XSH1wrENne2tsm1O0F1xmDlzPYHebyJ3H1tVNE7YkIhEZwg+yHYKG+Km
         JCS7gCNe4s1CPA9nfCnafP8fIamKr8D+bjGgQvRxlDzqP/tEsDhBjoD0Xqz8bUOdwZEd
         r74Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790104196; x=1790708996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lK/yFq614ap/r/WmvWFumoINA4i+Bww9N4pHbrRhbvQ=;
        b=EouxBJkgm//8igosy1bj0J15eJx3MbxEu1M18kmy9WWWyRcgUKOAzyOTL9A65kQEG4
         j3EvMwoZZmRk85/Lw0j7wAM8KMo8xWK+wW+uJ1k6oeep7eyhezOvSAhCNii0q6qaZqN4
         ncPZ4VzP4auZas+ZneZhSX68NP4tSXIoDjbnt0GLeRSBGKbWn+9+2OslGNedI7El6Cap
         WjAbYTevVFzAwNlrZRsy+3qTd1LUVXkWUISYMjIraD/hgcq5dScUUfzQuvzaB2c8JwDH
         umRUXBLhwv2JPWPvTpqyc3ghxhmR50MLvtUXvf9asFBhys2pCUjkZrls7HjfEcMQnR2p
         1kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790104196; x=1790708996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lK/yFq614ap/r/WmvWFumoINA4i+Bww9N4pHbrRhbvQ=;
        b=yktPNokQzTrLDerL2IXq8BUhOaGUgu3HFMi17aLzCWvCaSUqIkUSs7xGRoAzvjEHdO
         Xgmo8ZVdTLK9Z9yiky2jmcDAQ2NcWdQY8t+F3ZmLtBuGNBjNjTuhB4vZNRwk7dBWatUW
         D8+Rnfxp8jOMPz33KUpDu303LIr4A8aslwyfnNR5GqIP+BLzr89FpXFUunaaqwhBQDpH
         ajp/ORcJjBqZnAlspCpE9B27UeQwqMP0X4g/yoDrtZBaCbIYdzn+E0/Dhk3bydwR3OG1
         R4yQKBcVLD7YCVhmCRk+p86VLxuoPUj43MzIq9VKtaDTKa3LtfTV6Dpk6v0a2mc2BUgT
         S6QA==
X-Gm-Message-State: AFuF++l6vpR1Y6Pj3Rppw4UEHnIZq2QoPSnNx3vZSXfZ/HlOCz7UiXBc
	GYk4je1bjTRvgtMy+Mcz9d3O5tEosTQOa2K4S1Csv5P1jiiMKARnsYOLey5xaqs/Kdqvd25Rety
	hzVEANF9agPH1VS8EwAjTF3/v4oVNLdI=
X-Gm-Gg: AYBFou27pbCVF0wmEBH+ZungNnZSlRuQYBCin08ljbinsJBTKcDvBTysQIP/c2YzAMV
	9y3y3KBDHprDYDm40WEPCE6JZN+57bmGVtxypgkkVvKPNzFB13HaNDuf6OYu8nTOzwm9BcwpBJy
	6Uxn6vu3MDAS4yilgbrhkJfXtEI+A58oLu4LoS4XhoQ9zMcVdPs5mxtzk9sz6Pmb+ojwx1yrtGN
	v5XD7Wb1IH6hg57BwFpZK27tZRMsG3Yws18hsV1vQafMWCnoaYYEbiccrrkJlbznHzcxqy+simQ
	3j6G3xXpefW1qD+q8lMkJtcZ8qnsfIXV+D/Bbs48wvUGtASJKPW7XM6oxjxkOXdoMi8bMyIC3eF
	wXvs0q7ppBy6//OK00gD6Gus=
X-Received: by 2002:a17:906:618a:b0:c26:19de:9ad1 with SMTP id
 a640c23a62f3a-c2aae134f94mr14378466b.41.1790104195855; Tue, 22 Sep 2026
 12:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921191407.1742386-1-puranjay@kernel.org> <20260921191407.1742386-2-puranjay@kernel.org>
 <DLLGX9F9UG4Q.2YJWNSO4FXT1P@gmail.com> <CANk7y0hpi+vjXCR1oZBoeL8XLDss-HoufJfYkqNwRUXghFYCMg@mail.gmail.com>
 <DLM296AAASVA.3IGQUR5NOALQ6@gmail.com>
In-Reply-To: <DLM296AAASVA.3IGQUR5NOALQ6@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 22 Sep 2026 20:09:44 +0100
X-Gm-Features: AclHuK9KOsB4l2WJ4Vd0mx_mdmwCNUfYrasYFeY_Zw-DTBgioYS2HRptlswmhJs
Message-ID: <CANk7y0g7ZiF5x2j9hZxc4OqFBOFRSWGj6Y9zj5NrX3M1+L3mQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: Add bpf_call_rcu() kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:35=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue Sep 22, 2026 at 2:17 PM UTC, Puranjay Mohan wrote:
> >> > +     prog =3D bpf_prog_inc_not_zero(aux->prog);
> >> > +     if (IS_ERR(prog)) {
> >> > +             WRITE_ONCE(rhk->armed, 0);
> >> > +             return -EBADF;
> >> > +     }
> >>
> >> can we drop prog_inc and remove prog pointer from rhk ?
> >> with something like if (prog->has_call_rcu) rcu_barrier() during prog =
unload?
> >
> > That could work but we would need more than just the calls to
> > rcu_barrier_tasks_trace() and/or  rcu_barrier(). As the rcu_barrier
> > only waits for callbacks enqueued before it was called, the registered
> > callback and re-queue itself and cause problems. So, we would need a
> > flag that is set before the call to rcu_barrier() which stops further
> > queueing of callbacks from that program. Also, assuming we add these
> > barrier calls in bpf_prog_free_deferred() which is runs from
> > system_percpu_wq, it could make this run for much longer than
> > expected. What is the motivation for using rcu_barrier() instead of
> > bpf_prog_inc_not_zero()? is it the 8B pointer in rhk or the atomic
> > operation in bpf_prog_inc_not_zero()?
>
> ok. fair enough. let's keep prog inc.
>
> >> > That avoids an allocation and a state machine on the arming path at =
the
> >> > cost of 64 bytes per element, 48 of which are used today.
>
> What was the thinking here? Why ask all progs to waste 16 bytes
> for future extensibility that may never happen?

My broken thought process, rcu_head won't grow anytime soon, I will
fix it in the next version.
