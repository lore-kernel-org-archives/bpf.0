Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013D345734
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682157; cv=pass; b=WTbxNOHFuPhoEJSRc0lAxbSUO0ksEpiwyILB0yIQsKczABL+d11wx5RyPEF2qKWqGZCFLoAF+a0WuqOrpwnk60qPh6mmkInXb3UTN8929YIFiyN+VW+dRLtjJv1rceFHmwG1jpe3Ov5IDuptv1mX7aiBJKC1SSoi84OUegjEC9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682157; c=relaxed/simple;
	bh=9oAvbmkZKYIomDiaD1TObEK2e0CJ69Ld6tGN1kWMXEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPBpXjVSLRrXpruutMH7DMS0/mkr/t1im22HWGG3qjfcS14I+8a8O89kWt4jWDSPY1gHClSTUBuy/E3zUoAVW4mp3viGIhGdAMnU8HcesfrVDi8i9ov99RKxKMHobIwBYgZNFWDx+zQO7YRtbihlT8MEteLV8sawA7QdnBV5XyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoZKp0Jt; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoZKp0Jt"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a8ee4b703fso991486e87.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 07:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778682154; cv=none;
        d=google.com; s=arc-20240605;
        b=j9Gmrbca5fFwUNJE1XjuRE8xH2l2/nBxlnmZiR5AsbUd6h2z9rGMHRMmwRUXaSxlPw
         2YQuCb2/FdiNJSTtXqKPtz1D5qLl0RVf5ucWeAG4tv9UfK0T4v0KduRD82/2AkjFwGLB
         UAN5TRI9umVj2w7bqm3wQNoPu8/ooIHiKSMpYSwC1NoZH3rnBKfs3ju8QTVpAO5qW9Sk
         z8gJ0OXrE/GyksPs8cBLZR2iOnl3y+7AUgA9P1cdm9UMS6MNsm/x4pm3rXHv3TnJRkmd
         yhVcFPh7lG5c3amyJ9Shz4Mco3zIFTzUKBL7LarE3nOIy3L7C5x+ZuQZOmKSQVmIdMdk
         99jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/SY+5SsAhGChwgUWInPuI1u1aUmX1Vik5Ht/pl+52U0=;
        fh=7Owjkglu+isUHEnn3UdfSiyqCc2WfMNEMdJMMehFRIo=;
        b=lPWCwnG9zcSiXy9tMqnTk1QwHzasOiKcucEplZLeYuhCbYrb217yYnhyjRH+lHYswx
         XfckGH92Ih2umjBtGIs8dW1Qc3GHSiwVIJsmyDg3h/gK1Tb/sNYL1VzqL3F1usZzXihr
         jNvqphIfsMZ97NDa/lLDArmPYRT1ArVGkDHu7fpXUaLUgxJNkNNGHvAtHJRBbmSTvjlA
         8v9gaD63MpA/QVPDW0TCA8em9i5VVZpeWzpuJ2gMvzbYbeu0jonGOi1hWh+EfL+WXHJA
         XOE1KPYF5jlhdP6AsO32PY0e2/5t96jThlVxBaBPURPEi01+dhbrmbboqonf5FhdTmQN
         J/tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778682154; x=1779286954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SY+5SsAhGChwgUWInPuI1u1aUmX1Vik5Ht/pl+52U0=;
        b=RoZKp0Jto5wNOsJ83U3hECgx19CQ5Adb0DW/4N8iAxqjGw4yN6yjqakPJO/9sALVYq
         ZAvVpGsZD50GpfYl5ZhTXaT//lXCq0PxBoz2PAsedAiQEefF0QUZfCSNtkAZ7fSfO3yX
         a1gAPdJEED5gi4r0jt0ridBQ+wr1pFjeuEUcaCdQONbdnYp+yPGmF0A1PNPOkgvDNb94
         h+J47e+10itNqt83Qh/NUYUcwFlng7cG4hxxBI7GOIJ7DXK9ulJ32+RfJH9zaLvXUDXn
         4o2hreBc5MZgobOxfAtVpGzQiqFni0aPYo9GI1ob2L9WvWcsR6hm5GTdb7D8r2VyjrZ0
         gyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778682154; x=1779286954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/SY+5SsAhGChwgUWInPuI1u1aUmX1Vik5Ht/pl+52U0=;
        b=HEy9X9gvAp7Mw6IWxM6zJnbcQnpm2oZWLqbuhybQcVmr0AHESlH+Wx2AXu0tgP4d6H
         Wet5nhrSw2wXyDl+Rv6Sx1viSgp2dPXyPt77ooIrd6H1OgzzPfccjj7X5IGyLT1MubjE
         cascJ6rkAI2LFU42bvTxEbQihIr+ovhiw9T9t7ct9B+m1dIwVN3Bu5XGaUXbidVtW4kh
         9vLRdj+Sc20TpCVwvWk4TBi4Y3wgd0E4yprJs2sKi8F0VjCEP8I7pd+hAkPjUrhhxsgi
         qZsy0oJrrbeh8wk48k488N5labTb9fIZr/7V6M4rOm+w4byu35+PR0fgFCsX1iFDcv08
         9EjA==
X-Forwarded-Encrypted: i=1; AFNElJ9IJzaWX2AGk59WTE3N/PCBIDpwP1le2k/lL6vBSdfXC8mSXJuJUFWJ5d2GQAPBNo+gJds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ0em++qMvqcAHi+xp2Wl84t6GC2Kepz3E7ba+gHUrk8sgVi3Z
	7ygTendRltaK+P25J47izHghhvubez6MN0VtxiIaJYcVNiysYlfa293XKHeOD4fzZBuYFLWwwkg
	ZlzrL1kXUDYLPIZYrJSgwNmOUSJ4zRLA=
X-Gm-Gg: Acq92OEWVzkAWI/eAYqsrA7r1Z1UKRLE+bnmM47APZyQw4ggM7Gnae48Wc4+TCLTp3/
	SXbDkbkdwp1ig7sestBhB4bp/Upd+OroPxm2cxqsi/ND5QXnSe3PupOvHuB3MjtNA+eNZTModFd
	/8Pc4SemOuYTCTFWAjCpfrpCPHInZmn8cDcgZaG1MHkEOi50FgHYVdesje26FSmxcI66qhSZSpF
	a4K/FgypAOjHCxd0Fd4hBW7TfX9oRfXJvhUa7wzIoma1ucotGxke9ltJmsN99A9Lsi7yxrEWk+F
	216ep+J0mXgKDryg3HUPqH0dXYncbXroY7638a0=
X-Received: by 2002:a05:6512:3d07:b0:5a3:f25f:cc30 with SMTP id
 2adb3069b0e04-5a8ef99a4fcmr1198885e87.32.1778682153873; Wed, 13 May 2026
 07:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com> <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
 <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com> <agOozH29XU6KQUTy@devvm7509.cco0.facebook.com>
In-Reply-To: <agOozH29XU6KQUTy@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 13 May 2026 22:21:56 +0800
X-Gm-Features: AVHnY4LFjy8smvgA5gfVpYV3feknTwoegdWnsJllj82k8og6Ki_PDkhRRWeveHA
Message-ID: <CAL+tcoDqtEAqX65-8crUkUko5T_0nq=LSxAbMg+5jCAHa_uC=A@mail.gmail.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 6:34=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 05/12, Jason Xing wrote:
> > On Mon, May 11, 2026 at 11:03=E2=80=AFPM Stanislav Fomichev
> > <sdf.kernel@gmail.com> wrote:
> > >
> > > On 05/10, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > The TX metadata area resides in the UMEM buffer which is memory-map=
ped
> > > > and concurrently writable by userspace. In xsk_skb_metadata(),
> > > > csum_start and csum_offset are read from shared memory for bounds
> > > > validation, then read again for skb assignment. A malicious userspa=
ce
> > > > application can race to overwrite these values between the two read=
s,
> > > > bypassing the bounds check and causing out-of-bounds memory access
> > > > during checksum computation in the transmit path.
> > > >
> > > > Fix this by reading csum_start and csum_offset into local variables
> > > > once, then using the local copies for both validation and assignmen=
t.
> > > >
> > > > Note that other metadata fields (flags, launch_time) and the cached
> > > > csum fields may be mutually inconsistent due to concurrent userspac=
e
> > > > writes, but this is benign: the only security-critical invariant is
> > > > that each field's validated value is the same one used, which local
> > > > caching guarantees.
> > > >
> > > > Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp=
.kernel.org/
> > > > Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload=
 support")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/xdp/xsk.c | 11 +++++++----
> > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 6bcd77068e52..cd039e397018 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb=
, void *buffer,
> > > >                           u32 hr)
> > > >  {
> > > >       struct xsk_tx_metadata *meta =3D NULL;
> > > > +     u16 csum_start, csum_offset;
> > > >
> > > >       if (unlikely(pool->tx_metadata_len =3D=3D 0))
> > > >               return -EINVAL;
> > > > @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *s=
kb, void *buffer,
> > > >               return -EINVAL;
> > > >
> > > >       if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > > > -             if (unlikely(meta->request.csum_start +
> > > > -                          meta->request.csum_offset +
> > > > +             csum_start =3D meta->request.csum_start;
> > > > +             csum_offset =3D meta->request.csum_offset;
> > >
> > > Wondering if it's better to READ_ONCE(x) these?
> >
> > I still chose not to use it after reading the suggestion from local
> > AI. The reason is there is no WRITE_ONCE pair to make sure everything
> > is no data-race. I also checked some existing implementations around
> > the shared buffer (between userspace and kernel) and didn't manage to
> > see the usage of XXXX_ONCE(). Does it make any sense to you :) ?
>
> Without READ_ONCE your patch relies on the compiler honoring exactly the
> loads and stores as written. Which I don't think it does (hence that
> whole WRITE_ONCE/READ_ONCE mess). IOW, it can pretty much generate
> the same code (and read csum_start twice) even with your patch applied. H=
appy
> to argue with your local AI if you give me the output :-D
>
> I grepped io_uring/ and I see similar pattern for reading user supplied
> entries (via READ_ONCE).

I roughly understand what your meaning is here. My thought is the
data-race condition in this case still happens even with the
READ_ONCE() protection (because no such corresponding operation is
performed on the writer side).

Actually the local AI said use READ_ONCE instead.

I can change this as you suggested for sure. Maybe related fields can
be protected in the same way in another patch.

Thanks,
Jason
