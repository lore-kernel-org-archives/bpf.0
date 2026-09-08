Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E656B856
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888551; cv=pass; b=tguRxdJkY7ylWLR1GcrXOZA5WAf1wReZLYHLyaO+vb1dC8ue08TbyIIIvaHkIq4eO2ZPGMvtoZnjvRR0akOHSMwwSMMpeb3BhradlLEbHnbyt3mgmMirjFmDs4+pctAvYBsF9NyXqawEHokS7PB2mlZdA0Qp6EHXthCKby7rJeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888551; c=relaxed/simple;
	bh=TV5fg2vDNwOsjIsuoNOpfutnb5SXppBqOtK/HP2PzCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAmWIhnYjcdlh0YZLg8Le7/YJtm3L46L1sDBvy1J3Ws1fGrUOKSJFouyJy/QL6q+8NlIM73UzWzKf3ohN19bgi/X7MpkZMG9acI5l4Sv3iBk+5dwBbBjBmInRuBSt2NhNDxy+/XEjTon5ng8XaW0bnDxyAKuqofC7VMuyEt8oiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRITZW0T; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRITZW0T"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so668671cf.0
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 10:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788888548; cv=none;
        d=google.com; s=arc-20260327;
        b=XEuf530xCSh9gN+2VaCNlwR6dVcGoQLj1+GwZ/P1D7KfBfWtsBxb3q7YTVB2hgm7Ng
         z2wp/tpPmONBFxBOBfCEqaiyNHHI9ZAGzUi/oFE2NGtFay871cBACRa6MTtd5IRA5dsf
         qDKSN3a6Cw6XqAGMBqLJ1iMU8TmK5xmynRsQFFbHiA76xE5A2laptlUxOjO7XUtlzi4l
         dnZ8bMToAzoYIxrdOXFa5lq4X7nJuH8JFPXmtPYOw2UI32Z5FP31B4l3FLXlTx9iLlk+
         wn1jED+xV9SLJ+MHrOYeJes461MZF3fKxrNexb65LHG9MwaV/h7wqq4DeAPMnamaxla7
         Y+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TV5fg2vDNwOsjIsuoNOpfutnb5SXppBqOtK/HP2PzCs=;
        fh=wpVNT0C5PMOPG85jWZvXT3s4S30wFCe2VAZ5nRphPH4=;
        b=YMhelnVzEBDnlV+Ow5MI1QES+pBYOdq0eGBfUfQWtk8QN1js62EIbPpsgFR/WSu25d
         GJARfo0Dvd7DeHHQDs+K9/7Yju1oeto6o9jvr92Nr+YLYYQDsNPnoHO9N2A603donhUl
         exbXYmNCj+0HYQEAYL8Mjcc1VIPZH84nG9ksyI9Yi3bCp3JYeAXBgYMa/lkTaqVN6y05
         Y2v7N9QjE1m4Talf8Y7D/O45EbHdndbylRiod6yTt75lWsTSCrGiY5BC+nt/E+pdfDuD
         FjxifYxdAuE8qUpL1rI5/Oji618M/8W5/PIHH+ArmAhRiIydHxpZrvCJ/S4sWpYh091U
         g+jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788888548; x=1789493348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TV5fg2vDNwOsjIsuoNOpfutnb5SXppBqOtK/HP2PzCs=;
        b=lRITZW0Tipp4XNZviNi+dcRudC9YGOtr5Xwhm7xgN0+fsOipsV1hcA0U1YmrFjO9sz
         82+2SHZolaBR5fQynx4vsME0DuscTxe22sGESKeVXwUqCTsTIaZl7vuy+8EgIISXCzNX
         7ZgGV7Ppw3O9B8gqszJDl+G76pKsOxx/Wc+dJzeOfnSs40pFboHtOREIwvB8tLNHdL+7
         rnpHsvGa+Prs//Qzxxh/wvdQx9ej72pNc5JiqOQ0x7PyI8iuzLU7HjGKyephcCYL8Db9
         duYuoVWXxAl1VfzLvjo+ToewKMl26Z1bTJym98pR4zv7nEgfSfUz13yJw3BoKhsJ8qE/
         s39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888548; x=1789493348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TV5fg2vDNwOsjIsuoNOpfutnb5SXppBqOtK/HP2PzCs=;
        b=pS+ZY41o4fiLprYktp1v4CV8Ka/1xHI+/FWOSg2I+opkGRtVuNtU6Z6ktukS80zB+e
         7ahhc8LNCvwg56ny8rzfiDfH9kXQicTT9HX61/DDxBDDmfz144lBa0o354iBzOev82Zw
         N6YmvIpvWpOD5M70RdicVvSH0OxkUTeI4ZScX+6MPxWeE70W3CWttcbMdG0AYkq3a9dt
         03ncGm6KKWRKH0T1ofiUINhkZwrXPpU0Te61P41AvUu72wUM99uZBk4hx9zitnsMrZ/k
         Fi8RgzAozrw0//BM2W42llAJWlDXQig1fWBzapsDuLwfNecVbvIXlYR5eojY8CeFn8HD
         8Asg==
X-Forwarded-Encrypted: i=1; AKwUvBwL5Fz6JG5epw0jjMQ+XVfblOo1wIMZwIGMV6NOUtiX++rnvLL5ThHTjIjER1DnbBKlAq0=@vger.kernel.org
X-Gm-Message-State: AFuF++nhxtXNbme0rnoDosm0ky6JhPQIa/wlqRHm42td/eZJ8qaPeu7y
	d4hro3E0lBs/SG5xDWO7jUfSmx6LV1Tf8SpoUp4cvqE1I4Jiz5ZlTD9SoHJOoP8LKhmOPw7jYSk
	dyAKwU9/SM6QBULZGTtxrQVPCuXYbMIlfY4oOsQ5G
X-Gm-Gg: AYBFou3qtMxn9+zWQ2grAdEhO7DCtkGORI8Suqea0CqAK0BWBuq3cgXZ473+Sl/5fRV
	R7PvAOYoHHEbObfp1l1wbzMq/67I252SQnra22MSmktExvJ+yx5EN12oNwP2fhIghCr8wDrrPPu
	U7KI4c+XeNAXqmu/wCSf5jOdrc9901VBpt8nbjSh0DBLIOyUl0Xu1wUdF2c8ydukVFtKv0KQYyh
	ZJrnXj0ADPKPp5hFCSPYdNyZjNKPGIM496+S+bioGpANqNlSQ2cuy1qdVEdEImumQpdyQfePaHJ
	B8ipH+RdqKatYjddqw49HR6M5g8VIBfdrVw4sqwTZi5ABE/2u9Lgqay9eNlz/FqwOFzxKmEIgm0
	=
X-Received: by 2002:a05:622a:1b17:b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-530a3b7c7e8mr1827921cf.7.1788888547684; Tue, 08 Sep 2026
 10:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
 <CAADnVQLrga+tx0QCUkviGHqbk9Q6a7bmk3oAe51ZrLhQgRaw5Q@mail.gmail.com> <CAEdQ38EMGjp5RbvZn_RStu1=OOS3H+VT8xHFdnEaVC+dof7Thw@mail.gmail.com>
In-Reply-To: <CAEdQ38EMGjp5RbvZn_RStu1=OOS3H+VT8xHFdnEaVC+dof7Thw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Sep 2026 10:28:56 -0700
X-Gm-Features: AcwNN1U0pzsDB7Ni4zxKoMakrdxYWC_p3L8TNTCtZOf0qYoAAkhxK8NQXfMaReU
Message-ID: <CAP-5=fWjxnoUxSHwrO3aQ=QPdz2zmjiE1kZZgj4o-eXYCx7Qdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] perf tools: port UI from GTK2 to GTK4
To: Matt Turner <mattst88@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 2:05=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> On Sun, Sep 6, 2026 at 4:59=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Sep 6, 2026 at 1:13=E2=80=AFPM Matt Turner <mattst88@gmail.com>=
 wrote:
> > >
> > > GTK2 is long dead upstream and increasingly hard to keep building on
> > > current distros. This series ports perf's GTK-based report browser to
> > > GTK4 and fixes it up so it's actually loadable at runtime after the
> > > port.
> > >
> > > Patch 1 does the mechanical port (build system, widget API changes),
> > > including the leftover-GTK2-call and signal-handling fixes that were =
a
> > > separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
> > > port that prevented the browser from loading. Patch 3 fixes two stack
> > > buffer overflows in the hierarchy view that predate the port.
> > >
> > > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > > ---
> > > Changes in v7:
> >
> > Matt, please stop the spam.
> > Wait for humans to reply before respinning.
> > 7 revisions in one day is way too much.
>
> My apologies. I figured it would actually save humans time if I went
> ahead and addressed all the sashiko-generated feedback. Dunno.
>
> Is there a way to get feedback from sashiko without mailing the public li=
st?

TL;DR: drop bpf from the to/cc list when sending patches. This work is
most interesting to linux-perf-users where multiple versions of a
patch series within a short period of time are common.

I appreciate having the latest patches to review. If Sashiko provides
feedback, the change goes on my 'to be reviewed later' pile, which
hinders getting code/fixes landed.
It is possible to configure Sashiko to 'embargo' its feedback for a
set number of hours. Networking does this, and it can be frustrating
when you must wait for a patch to receive review before landing it. It
also slows down developers.

Sashiko isn't adopted on all mailing lists, and while it is a widely
praised, others don't want the email churn. In a year or so, when the
models are better, I imagine the churn will decrease as:
1) If AI is used to create the code then it should be better able to
predict Sashiko-like issues,
2) Sashiko itself can report all problems, suggest changes, etc.
rather than its current drip drip of issues.

Thanks for the contribution!
Ian
