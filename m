Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB4407CDF
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316873; cv=pass; b=DtAcltSGNmn6qiNyFn8ocrVNV4Zf1YXxMLneRTfQ+gW/lqRyhcsyo5PQGNT6BvxHohGxOBzbyVTl+L62DLrk3RmbQo1RkNSBQNjTnbfQiobogPRr3eettIGrQuGvQ294jVvjwa85x5XDBNBl5jHh7xpHer7cnDcPdcGHVEcg8Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316873; c=relaxed/simple;
	bh=JlGysplpVALjv18/KlcGZlhOgXUIzAYIQP16XTyqrE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uswERjJSrQUTT3qU9+b29R2rVQyXqGJuEmqANOaGBc+WLFdyP67ip1rv777ytAhA0VOhmVeKG0om9cLhIaRGpxkhwr4yTLaYnUJDLMPe9MwnMqtyzMU49lFwBpQXmPdbnvnqeZ/sBRmcPpr1JBTA6BvodD1dXrDmNK5jNGgBfBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnN9wLoa; arc=pass smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnN9wLoa"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so1761845e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790316869; cv=none;
        d=google.com; s=arc-20260327;
        b=UGZu12KmW3spOCQCcWcGbk3/PMLrN8apWL05+OHvGVzpyOvioubM7NE3V1iVdQnlFi
         D/KVHqbfHOpilj++uolRtjQFgX8/tsnLbyHucMTMs3m0aUzz0BAa70NRGhi2412v8gv2
         zNYeOyl/WeLCfawpBoiVjCRhIIS6PQeFHVpoEoNFI0bC70gEWJeqYr3XVafLSlvA+Z23
         D720L6/aShtjwocpUivei52VKaJz2fDQeCREuNDR6O2FXaWtB0j7E26uYpx/w2YyVrDd
         ESxMQUYC1VuS7Q1feUZC7+TjzyLUZJfI7mI39Xhl2NvpkKxtGJvxPhWd6aWbFTvPTGnJ
         jt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kpy0bL3ouzGmOCneXp2v4HxEUP6xDOQAy2AwC7Iy5DI=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=oWAfHyJc2arM8KeOGvaU8SYFpkRTRhz6M/lCkgQkMmVEDFWFJts8AOpCekOgUTZZJP
         l12H8iHdZWgcDUt2B1hn7G4MWqhFZxWLwHcPYZAYB9weqkr2pF5rQHJ9IekqBANeUxr5
         mtRlSkxXZkDTjgBwI8PIJLdewlO5WSQY4v1dGHO/7SoCrk39M9PeCndSU7Kr9tZS/y6v
         erZAa5lQW6yJ51Uc/wqjLPoS/neJyO9dUNOdwrHlvNcaWPnF2eMzA/BYObLDrGsVYZWM
         BzehniTnQsr4MjyCN9SizFNJ0M7XEbh/jBH1OJ+x13gE97TP+sgxk0Gbk7Sn0jTdeJ22
         JQpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790316869; x=1790921669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kpy0bL3ouzGmOCneXp2v4HxEUP6xDOQAy2AwC7Iy5DI=;
        b=UnN9wLoakaz2LPY5Yj5zJlEek8VpVXvEhKlbFXLZeOgDpm2lXGotjL5wAB2DwIZ4tw
         cDdcORREn1T2qF2yyL/EPiWt2uH0MvWswzilqfudp4AKpyvAdgogKcSunzIrxXOcAaph
         0rYmd9gKhfdIqA9QmwS9zWeVWNgLrTrgcdAm6IzTyDe0WJUdQ8FtE3HR12FGO1NsoEaZ
         Un5uIIbiHJAbmzug/GVRn9ko0ekrvt5wby80iMkd6pzcP5d8rD3BoHjcZ1iU7yh3MSvG
         67Qv55eV78ml1CI7WQTx85S443bR9NUDeMtmvq9x5rOKpHiMi9fb0kPg+zGs2gv6yztz
         jDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790316869; x=1790921669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpy0bL3ouzGmOCneXp2v4HxEUP6xDOQAy2AwC7Iy5DI=;
        b=LzT6msuVIR22UJCNiK2+gxSHKV982FdWZOuVQ7J8+sWAHXuKs59DL45/XzFoKcMIs7
         y5WTNpEAgJ6WBYhSE7X6HQ0fjLL6pGA5d1VpLVsjw/nZjBAtfevhZN3816gHi4hBvPB9
         B8BLcuwlQC4gg150FgfpNwHOr/wcs/kALXx3KZO3UIceKOV9TamUpOkXQGnlfsJHOvvN
         X8gjbKO31XzcTPg7SiQx3+kaEe/tiVbLDOycGBQ9MOvTVHk3UTZLPBY/BlItm4gBk899
         Om0zKH7EbzB3gMmy6OHGuezdw/4BDGeflNT7fPV06Q11Scp181efTwM54gz3WuxTTeym
         hGrQ==
X-Gm-Message-State: AFuF++lzoeAbo2zv5fjJWPqE1hx8KX3iZm6bL62Gcf0jOXU8tgIU+nNR
	cFVl9hM0ChRny1JoAw0h0FZKTEqNUFDx9DrPzKR/HXhv7y+sqvLJ2OrPnkeMcNu+2P3trd5JHe4
	RZWbk4G7W4X5W8W3PnmMxTgleLWYNWkFBY5aqeCww1w==
X-Gm-Gg: AYBFou3GpoHodIYIeFEBSGsRi8ESF6vBHhKDUJ017ttuVXHb6VJBKl9BUDA972TRzGZ
	dl4y6/tKmwb3XkRyr2eYVxqNx3PbjMZf6EXdeiAa/9QD7vG7H8KjEejPoWC2agmQcSFKBk3xabx
	tkBp8RFWs0Im6M1V/zARarpQZfaJVDMhK2tRzW+qkP6bNujkdbXqkwVCN+UDY8p6zTi1zP/hCSF
	skIeOjwJhhw+/pEYppwMkHSZ5peCWNn/pdXepzNRXghnXtBT/BY1b+qN6x2wV7yqa5KFDJZ7FCI
	nXt0sejYL8bSRZTT+uj2D972rUEhfnWcRutA3NcJyUvSPtm83whHBiIAsTwNsHroPgwDGuPMB1f
	OLt7TGqdqkBpBX3HYuy/s6Qx8dGsnnVrM/kwzDF9wtxfHpsMu0EmDFh+Ws5SWl5ASv0iuCTmFFI
	a+R9RcTdyiCYAERIcEABIDgpYSaxidEf0=
X-Received: by 2002:a05:600c:4e93:b0:49d:243a:e4f9 with SMTP id
 5b1f17b1804b1-49fe66d0727mr84798475e9.10.1790316868920; Thu, 24 Sep 2026
 23:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925045536.1480933-1-memxor@gmail.com> <20260925045536.1480933-5-memxor@gmail.com>
 <20260925051521.7D8D41F000FF@smtp.kernel.org>
In-Reply-To: <20260925051521.7D8D41F000FF@smtp.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 25 Sep 2026 08:13:52 +0200
X-Gm-Features: AclHuK94nvyqfIYrKXMpv1Xd0dtsNyekIW1K-mTnoDv2pYhwLIt_jTAb_ghR3iY
Message-ID: <CAP01T76-E4O2jFtWZ+rz0O0gHoiCb4daE=kLkPFNeobaj1FbSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] bpftool: Add option to wait for program
 stream output
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Sept 2026 at 07:15, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] bpf: bpftool deadlock in exit_stream signal handler
> --
>
> commit 482ed48b5d6910c6aec52e854a7926f6f16ce58a
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpftool: Add option to wait for program stream output
>
> bpftool prog tracelog { stdout | stderr } PROG dumps the output buffered
> in a program stream and exits, which is all BPF_PROG_STREAM_READ_BY_FD
> allows. Waiting for further output means rerunning the command.
>
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index 24e40dfab4690..5e27b22444f25 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -1119,21 +1119,66 @@ enum prog_tracelog_mode {
> >       TRACE_STDERR,
> >  };
> >
> > +static void exit_stream(int signo)
> > +{
> > +     exit(0);
> > +}
> > +
>
> [Severity: Medium]
> Since exit_stream() is used as a signal handler for SIGINT, SIGHUP, and
> SIGTERM, is it safe to call exit(0) here?
>
> exit() is not async-signal-safe and attempts to flush open stdio streams.
> If the signal interrupts the main loop in prog_tracelog_stream() while it
> is executing fwrite() or fflush(), it could try to acquire the same
> non-reentrant lock, resulting in a deadlock.
>
> Could _exit(0) be used instead to avoid this deadlock?
>

I can follow up separately, otherwise include in the next respin if
that becomes necessary.

> [ ... ]
>
> > +     /*
> > +      * Exit from the handler like the trace pipe variant does. A flag=
 checked
> > +      * between reads would miss a signal that lands before read() blo=
cks and
> > +      * only end the loop at the next print.
> > +      */
> > +     for (i =3D 0; i < ARRAY_SIZE(signals); i++)
> > +             sigaction(signals[i], &act, NULL);
> > +     while ((ret =3D read(fd, buf, sizeof(buf))) > 0) {
> > +             fwrite(buf, sizeof(buf[0]), ret, file);
> > +             fflush(file);
> > +     }
> > +     if (ret < 0)
> > +             p_err("failed to read stream: %s", strerror(errno));
> > +     close(fd);
> > +out:
> >       fflush(file);
> >       return ret ? -1 : 0;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925045536.14=
80933-1-memxor@gmail.com?part=3D4
