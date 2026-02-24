Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD72DB7BF
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963437; cv=pass; b=hHsrBsQxQAyM0Gj/0ZDyIzIHYxCSVt1CedNiC3CV5Q0BqmpwpPOCDG5DoLzTg22QjyYk61MkGEjY9oXmyL+OCy6OMNAge1T9yDUAQiqZhLj8uNIUCI2xs2+Ej3PcfoqN6toPdfa9csTVNUeMpii/qrNva62ruhP639Tm1sp++1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963437; c=relaxed/simple;
	bh=gFm9sIszaRG76BMUOXhuMz0hkhlXHogVitmzULW2Yxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UItgd15d8iMZ3T7n9kkBgjqDqkKIfOOUBdwneizf904MgtrDtM/EYVCdImHpbzy2Oi5+pGE5airXQR1ZvbCPQUB+kHVSTjwRNE7MzKMu4daH2duCkz/Pum3Y8jzd2H8KS70R0DO71LbbwUpe4uFM93ijg0aNEWfzu++Phl2cyJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar0F7sd5; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar0F7sd5"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506c00df428so54920831cf.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 12:03:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771963435; cv=none;
        d=google.com; s=arc-20240605;
        b=hnPcqPb3awWYVYJTg+WPs2x61vkivWd6+2wxp5cb/TyKvSBEKtwMMMYwQ2wLaQ836N
         Ab47VZOuG6cEYWLypkP5Y9MJ3wz+PiWwiVnNqrqrrQ9IDp1yvf19/3LU/JsJSdzNa6vY
         Z7rrYz4Fp6PAQN50OaV0izp3q07DFe/gAPsnmxA/t2jF4TSwinanI1dAqoR8VM5diYzF
         lD2tlsJu/l1Iy7sA2vhJYHDfqvfWUXVmuvAJ9lOubxzpGLeXpKZWgQ0NI4j+bdtFe/qw
         CVGycWbcGovL4MculvYjFgQ/NQv3Zrc4SPbuFPJKL0odvLEGYmv2xAyuSvCCIF6clFJP
         YIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2IpFpRcZdLrJGysSA531c0+kE4YiRmcxwugRbkIrjyU=;
        fh=bc8WFXlXZf894AIsYhhuY6TmvVwpD2csT5YlAJmYy1A=;
        b=ZW5guhF/gjilxJavt44itxKdnqwBubVUU/PkA7/Rhn4wdcyAXZd4iFNXUzkgiLboCC
         DlSUi85T3qiJCPcr/K62x6fBQSWnZ6fu+otAT9xGzKxTGrshz85siIZ6UjJM8cR2Hb4c
         H/CF5fOYkXbF7KmsxBIyEsHy5Dhl3u/a0l3uQ+2gHCHtV0zbQtSkR3afAeBxRqexhjii
         GTIamMNmDrDxy1Nwc5DSnCw+Q2QwLdJwu1mvRzUp33s1ovDC8+/OTCIcep6hjdBJBdTU
         wFIWDqRCGnkiFdgi7dAGVgpdp+/aa+EzzGi/elTWaGhcAEp2ZS8fk1++wgZnlFQdBuQY
         gd0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771963435; x=1772568235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IpFpRcZdLrJGysSA531c0+kE4YiRmcxwugRbkIrjyU=;
        b=ar0F7sd5ICOrVDrfcrzUZJbNfklEbb2SqRjOoT0za/DqIF2xISuD3qKD04q0UmPF7x
         +brYYDkKb1BjwqYsLNvzw71FatH3LmXIAGOSmR3GAO4L1yFvC3tMVVq3zAhnahkSeiBh
         YC39ppeH5YbWQWU44j2zPm0nwKaC6qBoiTfSmPKDBIMCi30SWdd17/jvzS4oDaV2nJHh
         hw/UYY9ECPzTc30HbYowQkTa3dc1xt58YqWkZaIV84ou7iLsJfC8+kxpOMx1acttXNeD
         qL9dZgCnPEOCQ7OKis9245Op9MroVt3shDkcEKBcBaYGzQbIsPfDXCgZT5Li13M2C7SW
         ULkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771963435; x=1772568235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2IpFpRcZdLrJGysSA531c0+kE4YiRmcxwugRbkIrjyU=;
        b=cW6+Mo3ZThFU1hZdYuQy9S5wiSEQpRjUA/KWIIv4+jqKM/TvIXAjxCOQKzgtU1NeG8
         Cx4OQZQfpc0GgXUXaBodrXtGCU3pLQdXBnlnBnAHPX3AwyQKuPMJRl+M9RlX84a/ypLv
         0S0ov71bdHLgld5gC2dJ8RRYw5ugx5TzLh3wEGVWJIi8c/Gb+V9DaM5OdmjnJXUTaRtg
         rnKDR/KO4NIuU3MebwHya33DiP++R9YD090rL69dDCdTKc1p//pJ5I7xcF5NihiixU0n
         IjzyI6a6L/VzN5qRIE2fdbAkf0LdPrDCQ9cAmng/pQyE3+yPk4sWa7mM7KiJxzodkoPZ
         5lXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgCu0n8d252cXSx4yqa239fVQDN2GBt5Dq3AlFHRtfZfU1Ktj+oQJOdBIPZHWqnc34UPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzket/ic7XcqaRnzz3F9fPzScXoiel10ZtN8+ITWmNs/u8ji3y
	CWFrYrnTpIChi02e/4aTZ2zg6/Ngd9UGrRb05tIpCRUxWevH9BUkeusBbMrMUQez0Ogw7hkKeuZ
	+FEGzf7e1R2dIWGJk6GtmjvvXxw6GTlA=
X-Gm-Gg: AZuq6aKsaL7mOtnia0VheRqB0E0EhSFPue2o6z0hlL/RsJHsxfSC6pvSSmn0dNWcqDQ
	m71csW/DHC1uxeE7hOIFOmL40DxCL7Fll7za6PlaECqBN9ANha7GV2jYmdxkTmUjtdYULnsnd9E
	tFnHmB+kh8eZ8MFFx5cFwFd34YbUjb8XmvI5g0PgiJkPk+SGopscsROkYmC9eAiZiwNbvJZiWmS
	Hbn6FOuXK3L2GVmz9PsghMqAmVjo9FOf/I3Gxpao43hRxkH5N+akyY4Jy8CyrkAWRKB/HzNOF17
	IipH1g==
X-Received: by 2002:a05:622a:509:b0:4ee:1d84:306a with SMTP id
 d75a77b69052e-5070bcea3bcmr176449401cf.71.1771963434766; Tue, 24 Feb 2026
 12:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
 <177188733133.3935219.4620873208351971726.stgit@frogsfrogsfrogs>
 <CAJnrk1ZZ=1jF4DUF-NyedLP-BJM_5d3s0zfD4oHGyR51PM9E7Q@mail.gmail.com> <20260224195728.GE13829@frogsfrogsfrogs>
In-Reply-To: <20260224195728.GE13829@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Feb 2026 12:03:44 -0800
X-Gm-Features: AaiRm53oIeOstds6Px0N7w_1YklUZg4R-rODjC8FziXfiS_kg8Tvo9XRpKUaex4
Message-ID: <CAJnrk1YCh=CsFmxGwnK37d-31ravAOR8uLH+CrhpFzPX=ZTxUw@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: flush pending FUSE_RELEASE requests before
 sending FUSE_DESTROY
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bpf@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 11:57=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Tue, Feb 24, 2026 at 11:33:12AM -0800, Joanne Koong wrote:
> > On Mon, Feb 23, 2026 at 3:06=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > generic/488 fails with fuse2fs in the following fashion:
> > >
> > > generic/488       _check_generic_filesystem: filesystem on /dev/sdf i=
s inconsistent
> > > (see /var/tmp/fstests/generic/488.full for details)
> > >
> > > This test opens a large number of files, unlinks them (which really j=
ust
> > > renames them to fuse hidden files), closes the program, unmounts the
> > > filesystem, and runs fsck to check that there aren't any inconsistenc=
ies
> > > in the filesystem.
> > >
> > > Unfortunately, the 488.full file shows that there are a lot of hidden
> > > files left over in the filesystem, with incorrect link counts.  Traci=
ng
> > > fuse_request_* shows that there are a large number of FUSE_RELEASE
> > > commands that are queued up on behalf of the unlinked files at the ti=
me
> > > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> > > aborted, the fuse server would have responded to the RELEASE commands=
 by
> > > removing the hidden files; instead they stick around.
> > >
> > > For upper-level fuse servers that don't use fuseblk mode this isn't a
> > > problem because libfuse responds to the connection going down by prun=
ing
> > > its inode cache and calling the fuse server's ->release for any open
> > > files before calling the server's ->destroy function.
> > >
> > > For fuseblk servers this is a problem, however, because the kernel se=
nds
> > > FUSE_DESTROY to the fuse server, and the fuse server has to write all=
 of
> > > its pending changes to the block device before replying to the DESTRO=
Y
> > > request because the kernel releases its O_EXCL hold on the block devi=
ce.
> > > This means that the kernel must flush all pending FUSE_RELEASE reques=
ts
> > > before issuing FUSE_DESTROY.
> > >
> > > For fuse-iomap servers this will also be a problem because iomap serv=
ers
> > > are expected to release all exclusively-held resources before unmount
> > > returns from the kernel.
> > >
> > > Create a function to push all the background requests to the queue
> > > before sending FUSE_DESTROY.  That way, all the pending file release
> > > events are processed by the fuse server before it tears itself down, =
and
> > > we don't end up with a corrupt filesystem.
> > >
> > > Note that multithreaded fuse servers will need to track the number of
> > > open files and defer a FUSE_DESTROY request until that number reaches
> > > zero.  An earlier version of this patch made the kernel wait for the
> > > RELEASE acknowledgements before sending DESTROY, but the kernel peopl=
e
> > > weren't comfortable with adding blocking waits to unmount.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >
> > Overall LGTM, left a few comments below
> >
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> Thanks!
>
> > > ---
> > >  fs/fuse/fuse_i.h |    5 +++++
> > >  fs/fuse/dev.c    |   19 +++++++++++++++++++
> > >  fs/fuse/inode.c  |   12 +++++++++++-
> > >  3 files changed, 35 insertions(+), 1 deletion(-)
> > >
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index 7f16049387d15e..1d4beca5c7018d 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -1287,6 +1287,11 @@ void fuse_request_end(struct fuse_req *req);
> > >  void fuse_abort_conn(struct fuse_conn *fc);
> > >  void fuse_wait_aborted(struct fuse_conn *fc);
> > >
> > > +/**
> > > + * Flush all pending requests but do not wait for them.
> > > + */
> >
> > nit: /*  */ comment style
>
> I'm very confused by the comment style in this header file.  Some of
> them look like kerneldoc comments (albeit not documenting the sole
> parameter), but others are just regular C comments.

Oh I see your confusion now. Yeah the comment styles in this .h file
are kind of all over the place. Most of the functions don't even have
comments.

>
> <shrug> I sorta dislike kerneldoc's fussiness so I'll change it to a C
> comment so that I don't have to propagate this "@param fc fuse
> connection" verbosity.
>
> > > +void fuse_flush_requests(struct fuse_conn *fc);
> > > +
> > >  /* Check if any requests timed out */
> > >  void fuse_check_timeout(struct work_struct *work);
> > >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 0b0241f47170d4..ac9d7a7b3f5e68 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/splice.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/seq_file.h>
> > > +#include <linux/nmi.h>
> >
> > I don't think you meant to add this?
>
> Yep, that was added for a previous iteration and can go away now.
>
> > >
> > >  #include "fuse_trace.h"
> > >
> > > @@ -2430,6 +2431,24 @@ static void end_polls(struct fuse_conn *fc)
> > >         }
> > >  }
> > >
> > > +/*
> > > + * Flush all pending requests and wait for them.  Only call this fun=
ction when
> >
> > I think you meant "don't wait" for them?
>
> Right.  Fixed.
>
> > > + * it is no longer possible for other threads to add requests.
> > > + */
> > > +void fuse_flush_requests(struct fuse_conn *fc)
> > > +{
> > > +       spin_lock(&fc->lock);
> > > +       spin_lock(&fc->bg_lock);
> > > +       if (fc->connected) {
> > > +               /* Push all the background requests to the queue. */
> > > +               fc->blocked =3D 0;
> > > +               fc->max_background =3D UINT_MAX;
> > > +               flush_bg_queue(fc);
> > > +       }
> > > +       spin_unlock(&fc->bg_lock);
> > > +       spin_unlock(&fc->lock);
> > > +}
> > > +
> > >  /*
> > >   * Abort all requests.
> > >   *
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index e57b8af06be93e..58c3351b467221 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -2086,8 +2086,18 @@ void fuse_conn_destroy(struct fuse_mount *fm)
> > >  {
> > >         struct fuse_conn *fc =3D fm->fc;
> > >
> > > -       if (fc->destroy)
> > > +       if (fc->destroy) {
> > > +               /*
> > > +                * Flush all pending requests (most of which will be
> > > +                * FUSE_RELEASE) before sending FUSE_DESTROY, because=
 the fuse
> > > +                * server must close the filesystem before replying t=
o the
> > > +                * destroy message, because unmount is about to relea=
se its
> > > +                * O_EXCL hold on the block device.  We don't wait, s=
o libfuse
> > > +                * has to do that for us.
> >
> > nit: imo the "because the fuse server must close the filesystem before
> > replying to the destroy message, because..." part is confusing. Even
> > if that weren't true, the pending requests would still have to be sent
> > before the destroy, no? i think it would be less confusing if that
> > part of the paragraph was removed. I think it might be better to
> > remove the "we don't wait, so libfuse has to do that for us" part too
> > or rewording it to something like "flushed requests are sent before
> > the FUSE_DESTROY. Userspace is responsible for ensuring flushed
> > requests are handled before replying to the FUSE_DESTROY".
>
> How about I simplify it to:
>
>         /*
>          * Flush all pending requests before sending FUSE_DESTROY.  The
>          * fuse server must reply to the flushed requests before
>          * handling FUSE_DESTROY because unmount is about to release
>          * its O_EXCL hold on the block device.
>          */

This sounds a lot better to me.

Thanks,
Joanne
>
> --D
>
> >
> > Thanks,
> > Joanne
> >
> > > +                */
> > > +               fuse_flush_requests(fc);
> > >                 fuse_send_destroy(fm);
> > > +       }
> > >
> > >         fuse_abort_conn(fc);
> > >         fuse_wait_aborted(fc);
> > >
> >
