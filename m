Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3002336C586
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772769602; cv=pass; b=CxKum5fPZXLCCvvJlI88TmOftxur+DzMyaHY7SnU+sR0aJDPRQ9/GEi7nPE3gAaM86ZmJM9bOBxUDE1IfatFEyL1VLa1A0lOqwXYSjltwVg72r7KgORp2SD3gZLwa+rMD0diLA9rajkEC8DhyDVwwbdHXrxzauTGO20Qstuq2Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772769602; c=relaxed/simple;
	bh=GPhVWsvp17jPq1lj7bpUXGPzZRpU/p3BDzr8VGRq+Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJz2A05jooypCxzMo/UFISISoLXblyXgdq4QGmB485Q+FC15/izpSC4zRWCvmYgXwtLydTiugjlFIUpDgp8nNwV+xMhWKcBDs/T4KuLgiM2B4lhYweas/p8FPo/jfYkEj4uchL/nLH62wqrAhWho2JWoXsHXmRsZedou5fddDmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhXGs/CV; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhXGs/CV"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b611274bso3411515f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 20:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772769599; cv=none;
        d=google.com; s=arc-20240605;
        b=baQdBJmn3+Aq2NzKejldD0m4IaGmWumiKWWMxoVQHrYZIJXuhax8J2rKKoJosyS3zY
         Tq3W7daxvyrfuSDWLnFx8Zs1G5uZKGdFOJVatFwOtVpu9FFmOn9IdFrNstrMyD86dPCA
         rNN0RVLT/s2V7sbVI5Ks86hV+cQFv6qbNcOF01Q516rsvqmPSrds5LJFVTIcYx/0z9/E
         C9gF1UPz1/t9dtAl+50BLMV6AmwJVa2D8sd7GRfuGTeJYOF7cAgRt7ld4vVqylJh0et6
         mNapbda+r6YZ+7RbEkd3PS1c+gCGSZCdesLCsw9N/DcR/H31GQWXNiPfcIGMy1F+E44z
         n7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SnLEJrQ0ljVYb0fnrtiFu4aHIpSuhyglLLdZRNH1Z9E=;
        fh=3eEylOAaEwS5h2WtUY3Dotg6QB3gU9BomEhF+F652AU=;
        b=hjUpYAa2cynRGq2UZtOa6Q3RASfX9UVmvj0srJZaWSBZAbwAaDHIvbIEGcg7FNAwEb
         Ixd1fbeXjes7FIdwKftp4gR6aGg7BTMWrzudve5QRkBvpJEfk29KB/U5Uh3PsxpC1R0I
         mNHataDMdKVuqoC3FXDr/SOX2QuvBu2fdq7v/FfLO5UTPV940y1egc7Z6OXgdmGeAnx6
         uDeb1+009MJz+r1qoSO8e7hBeJJjUFGYZ/JptTbYevG5xj4XEBpmndbWNyxw7cVIWSB9
         I276AKSAba+GYZfpzakwh4TAVkmiljGb1cGlad8Wkn18WXxoN+Rg+JgLo8VUqxDI1bc/
         SXQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772769599; x=1773374399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnLEJrQ0ljVYb0fnrtiFu4aHIpSuhyglLLdZRNH1Z9E=;
        b=MhXGs/CVGtYKx3xXbJq2JD70Uw22URTc7MzXjBc36AxLmAm89LAbRuO9QbyRxnSxLl
         MeHCPzN1gMW1pE3thgL9qK1AEwtnT7K7NybivULEiB0wwxYEadSdbzgku9gzreIddIM5
         FpeOSFxL9biog6GpihPX256ryY/osNYFMWbSOigkj0kzbDzNwJefKpDT4HzwDWvPOve1
         uiy7pXnvSFpXg1Iqg/dDjIt4WgI6nWsqFj28bMu/8T1pnkkmZfHUAjA6teoBWkd6iLjc
         ZrvBCBZyaJtFHVLDzRYGUI3Yn7y6ax/SG61JBRbR/qT+EMFElltW+scR1bVYSsYMudkb
         FNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772769599; x=1773374399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SnLEJrQ0ljVYb0fnrtiFu4aHIpSuhyglLLdZRNH1Z9E=;
        b=iLdZWIarQdq/geTC/NKH3UtUQVVsveAFRcQGUEUEh/Oa/rW6BhYoBm2Z+rydDVAyWb
         j8ZCMQgXZ1AI+NZp9wsR/kdSviXujvfhF8qycSGoRuY+6oldXp5N/njh7yBpO4Y6GpVR
         +dI3FluPGTkSksMkINmShNwFJwfEWCppBLAkuj4vHp57LmYt+1VCC/nUowsDP7zVkedW
         OhblEyLdiEYIU/vv0XejYHSUC/cnQwaDuQKZgXw2P9yE3ln4RRYivFpgzhOqCRBofI1Z
         CY0A8mUcgLC14OSMjhRDkuHGXTnSLmcTSbqkokD4WIdH7HZnrurs5FYVnR7NcSv3TssJ
         RMnA==
X-Forwarded-Encrypted: i=1; AJvYcCV8YBSXgXbcvnfoAglWO3Xtl6IGU9VxVqUV8f0bNj41eXh00YzJQyqomDieTShxhoAABWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KJoMEAfroBrxepNpxArgul6twX/WYn0mlf7iPBkqAtd7G38N
	5KcrhWrjFgxVB6BarwF79dSl7qGn8qpTyjdziHqMH5Rm6qsLEeDHpIQkbKNVc5Cy4NZnPGv/uKY
	pubYJegfdPDMR9+R6ZhiTiFG6d24XxxU=
X-Gm-Gg: ATEYQzxvRiD2jlZlv4enYGWZDyBqdlkBZq804dzTxaRzamh0BLfL84TM00byYqWAtJH
	92fB0AavHjpI6a90qv2kVTlwPrONLkpexFD2N7PHVXYiM83NmFY0cOXD0Rxkwd6jWCZOyPYHOS1
	I+BBKJLhJhjquMCHVtxWrAD5ggzNdxmngDs/M59FqhdePz9Vo5U4qBVtKobWngwLoLFcz0ad+3w
	4vDfwqdleHnmczKUTq8gphQzJ2ZsUmy22gIqCRvZ2hkGVOPIakvtoTC/eEU52TFQ01QpirmnjZc
	g88JdD2ZSQz6pHAyP3y4iY5x8HTiAYCf2FGzXD8ziC9iUnoDG92ZvOX9hG9ZPz4i64NmCMZoxMe
	nKpQBOZGtzw8d/UKFwCggTVTuHQ==
X-Received: by 2002:a05:6000:26cc:b0:439:c550:d920 with SMTP id
 ffacd0b85a97d-439da895078mr877244f8f.47.1772769599318; Thu, 05 Mar 2026
 19:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304210212.235096-2-dev@der-flo.net> <c860945b84fb9b75ec9eb0299a4cab36c3afb69e9da90bab3d71c780e8cf18b4@mail.kernel.org>
 <CAP01T76=Am0SMkURBtcXKAm+uouMKR55ZbnzJC12heOwYuYs4w@mail.gmail.com>
In-Reply-To: <CAP01T76=Am0SMkURBtcXKAm+uouMKR55ZbnzJC12heOwYuYs4w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Mar 2026 19:59:48 -0800
X-Gm-Features: AaiRm517QAZBGaavqvOuZmK41dOuh7zCcKj-4ZBseT8cGzlNSlfNQtlAUPAnVAc
Message-ID: <CAADnVQKFpDhFUWnB+noVr6SEn9B3K1L0s3XY3v_cLsYq9ni1HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add LINK_DETACH support for perf link
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, Florian Lehner <dev@der-flo.net>, 
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 7:39=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Wed, 4 Mar 2026 at 23:01, <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -3863,10 +3863,23 @@ struct bpf_perf_link {
> > >  static void bpf_perf_link_release(struct bpf_link *link)
> > >  {
> > >       struct bpf_perf_link *perf_link =3D container_of(link, struct b=
pf_perf_link, link);
> > > -     struct perf_event *event =3D perf_link->perf_file->private_data=
;
> > > +     struct perf_event *event;
> > > +     struct file *perf_file;
> > > +
> > > +     /* bpf_perf_link_detach() may have already released perf_file *=
/
> > > +     perf_file =3D xchg(&perf_link->perf_file, NULL);
> > > +     if (!perf_file)
> > > +             return;
> > > +
> > > +     event =3D perf_file->private_data;
> > >       perf_event_free_bpf_prog(event);
> > > -     fput(perf_link->perf_file);
> > > +     fput(perf_file);
> > > +}
> >
> > [ ... ]
> >
> > > @@ -4075,9 +4088,13 @@ static int bpf_perf_link_fill_link_info(const =
struct bpf_link *link,
> > >  {
> > >       struct bpf_perf_link *perf_link;
> > >       const struct perf_event *event;
> > > +     struct file *perf_file;
> > > +
> > >       perf_link =3D container_of(link, struct bpf_perf_link, link);
> > > -     event =3D perf_get_event(perf_link->perf_file);
> > > +     perf_file =3D READ_ONCE(perf_link->perf_file);
> > > +     if (!perf_file)
> > > +             return 0;
> > > +     event =3D perf_get_event(perf_file);
> >
> > Could bpf_perf_link_fill_link_info() race with bpf_perf_link_release()
> > here?
> >
> > After READ_ONCE reads a non-NULL perf_file, no reference is taken on
> > the file.  A concurrent BPF_LINK_DETACH on another CPU can call
> > bpf_perf_link_release(), which does xchg() followed by fput().  If
> > the perf event fd has already been closed by userspace, fput() drops
> > the last reference.  Once the detaching thread returns to userspace,
> > task_work runs __fput and frees the file struct.
> >
> > At that point perf_get_event() dereferences file->f_op on freed
> > memory:
> >
> >   Thread A (BPF_OBJ_GET_INFO_BY_FD)      Thread B (BPF_LINK_DETACH)
> >   --------------------------------       --------------------------
> >   perf_file =3D READ_ONCE(...)  [non-NULL]
> >                                          xchg(&..., NULL)
> >                                          fput(perf_file)
> >                                          return to userspace
> >                                          task_work -> __fput -> free
> >   perf_get_event(perf_file) -> UAF
> >
> > The xdp and cgroup link types handle this by serializing
> > fill_link_info and release under a shared lock (rtnl_lock and
> > cgroup_lock respectively):
> >
> > kernel/bpf/cgroup.c:bpf_cgroup_link_fill_link_info() {
> >     cgroup_lock();
> >     if (cg_link->cgroup)
> >         cg_id =3D cgroup_id(cg_link->cgroup);
> >     cgroup_unlock();
> > }
> >
> > net/core/dev.c:bpf_xdp_link_fill_link_info() {
> >     rtnl_lock();
> >     if (xdp_link->dev)
> >         ifindex =3D xdp_link->dev->ifindex;
> >     rtnl_unlock();
> > }
> >
> > The same issue applies to bpf_perf_link_show_fdinfo() below.
> >
> > > @@ -4143,9 +4160,13 @@ static void bpf_perf_link_show_fdinfo(const st=
ruct bpf_link *link,
> > >  {
> > >       struct bpf_perf_link *perf_link;
> > >       const struct perf_event *event;
> > > +     struct file *perf_file;
> > > +
> > >       perf_link =3D container_of(link, struct bpf_perf_link, link);
> > > -     event =3D perf_get_event(perf_link->perf_file);
> > > +     perf_file =3D READ_ONCE(perf_link->perf_file);
> > > +     if (!perf_file)
> > > +             return;
> > > +     event =3D perf_get_event(perf_file);
> >
> > Same race as bpf_perf_link_fill_link_info() above -- a concurrent
> > BPF_LINK_DETACH can free perf_file between the READ_ONCE and the
> > perf_get_event() call.
>
> AI is correct, but is not proposing a fix, so I will try to be helpful.
> I think we can add per-link spin lock, so that operations on the same
> link are serialized.
> You can do the perf_file replacement in release under the lock, and
> call the rest of the stuff (perf_event_free.., fput) outside the lock.
> On the show_fdinfo and fill_link_info side, you will under the
> protection of the spin lock, read the perf_file and take a reference
> on it using get_file.
> Then you can release the lock and use it for the callback and fput on
> the way out.
>
> Other cases are unaffected since they are already under lock
> protection. I think a global lock is also an option, but I would lean
> toward having a 4-byte spin lock in the bpf_link itself.

I would just do a global mutex and avoid the complexity.
fdinfo could be doing a bunch of work.
