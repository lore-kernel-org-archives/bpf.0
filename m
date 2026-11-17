Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794951887;
	b=TyB25YlPij3K7k+02d4QZ0hoFYThgZ/slhKFxepTRvLfciFwq7COA4SSmesdWluB100n
	 TrjFwWYV6yR2TKQ06vM0gWhSKYnvC9qwKmiI/SCh8uXtz1DkKq2pZKLpge0GASl9Auqgw
	 gajPvIQI6BGjQDCv+y6iSfqIg7L4iRTETJ87JN7mlWUYcf79E3W6wNdT5pnvSBMp2/MkA
	 IpwQ2Wd8UCt56iD10JxVrN6FO0Z/gECntOWfqUHQKDjlyRCg6rUNl1toxQXmF1qAFvESn
	 W7skIsJkYLPU3GoFYJiSKloCYgUD7tK/IprFVAXW7kc2uTxXwIVC0xzcv3z9BoGSQgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QCHf0rhDeEETaZD4vNh0xBLfMvMYAYCFBm3oqRl3Mdw=;
	b=jnyJyF1C7xNqcHdM+NiR/MkV05Yd7hmnPy/S9d13/yuY6eXdF03riK5619vFN+G63YLc
	 JW1SMri1KBW45aD0UwT0JSE7eIIp5Ko2cjDP5iBzbNRZn3fkzj941jufVPdGvTdT7m0cg
	 b2GK/s8UJZlJmFNCGuWwha1b8OFLnf9C6ZFq8e7L7Js4WJFvKUuL33yXLSST1EWdNldzk
	 r3gnqstrdSW7ukFgbA7yq3Mo9LNKk5ig6+zUHXzPYkm0Mudl5KGladtsZNNMDAicbA6XB
	 kzTzn3MB0311chAn3iWIyMBVU2HSEiBK7QMWnRFDZx6Enm4sV3uHA+s0O40zj2L/vSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q4akuTuj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A1606A338
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 21:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B7A1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q4akuTuj
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dee593f18so181676f8f.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 13:44:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794951886; cv=none;
        d=google.com; s=arc-20260327;
        b=UbYwfVeWMbDYAbtMl5za8LJCOdlX7J/Ktzia5L2IXnKNSFl/s5CSKvGbaNMMNC/Rq4
         DCH/wrg3fVx/VqECBmbD/mggmPHXOnV/+AUu90uWIB1bqEDLARGjqSq3y3HP/xB3aCpl
         +6nedMF1PqH1PIV+xKa9/x3mvDpa6vK6KeriicaEFE+BgIlmgl3pBBei73Xx4FseZW6f
         DrIzaXjp2KdoWaial8tpO2w9WjwwCAmTtG8HZCV6VvZiIOugIE2WYmtFiYPxfX0WFfHN
         TzkFdU33uIgyrGjlJZOMbPLc3vEidGzxuyB8CukOSEsW6jhaXp8+/+CY4Bct6cIPIcvF
         eh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QCHf0rhDeEETaZD4vNh0xBLfMvMYAYCFBm3oqRl3Mdw=;
        fh=M6U1DWtidgwLaTaznhLwIFZU9g4aY4HcRT+tn4lWgWo=;
        b=S/r5vUS/jYUo4I0/yDXWX1i/Csnjt+JDZHHUMFvGdtKUycIAgr8GBMEfKNCnjsEgHq
         SZPCbLP75PdxoQGA4HJwBQaotyRs3UouHI+w54z34RrfWqB1TLmOLCvYP+8nTCcFCvC8
         nCf1nNkLZIAo1yUd8byisaJj71C4ZV8+0ESnVxuwn6uAhLT2+Nsu0ReUuTj0wMH6drXp
         OOACAPvR5awVI+er6j8ExDwJICAPEz5v73DSwMjQOJMvcJmla76G0WJXpWk97naPJWt6
         Iq6hVfO91zCfb1YKF7pqPuIkPEi69oi8Xihqmtt6EqbS5sO1AfZuWXFp85BLvC3UA3J+
         iXqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794951886; x=1795556686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QCHf0rhDeEETaZD4vNh0xBLfMvMYAYCFBm3oqRl3Mdw=;
        b=Q4akuTujr5pbvaLa0lhDO0YCADGQAgjj8c2bG0N995NS/8kAVFkkoWtJjNIQKLY5fT
         4ickiyj2FfqJOk8tH16u9eywWyjjuOmFE2Z76cJqYpJth3IvCSP6L/HCPzEW3Ho9Hm9R
         tVV8fupVGdTK9lKvreeZp+la3khqvF/seI5TtqQYoDGbT3AdKpvkVfS4+/OLrjJtWqFm
         UtMTRjJm6oOzhtgyNQyGNCyQanScn66u9qQY/VN7Qc05wwVkkDuuToTv5Je99B09RCnZ
         qaWDLTWuUDigZ0f0SuJLY+eUXdEfA0Fv2meq2PbnYvGEcToaK1tcPcGI2VgejyWZ0b6Q
         Li5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794951886; x=1795556686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCHf0rhDeEETaZD4vNh0xBLfMvMYAYCFBm3oqRl3Mdw=;
        b=jmIc3Sxjn0svtRQ9J/sOrs3PBNvR2ji9pKZOAKZZQfw3IgAyG41lRoqBEQT72acSoK
         Bp6CI+u2JY93nrThx/jwS47bisA/aFqWI6c5d0DUpFu6HWEDeyA7iKjNI8VJM9R1qBFz
         9lpLCT1eqsTVC1bSGaedLBBEYnMApDBRvVz1zoNfTrzka/u5BKwA4XfVQ/tn8ONIZBOa
         CBynWzsfJJFNUbodcYqDWgbiK0P+w/W5VtI0yQX+fLZkvIPwpga5F7C35dp6KgZryDmn
         lOv+Mwzpye1wqCkrrhRsDXG0UAO8aRUoTjkIldKcit8q7AcGtXeX/hvjvyuPF9WGUdz3
         MkJA==
X-Forwarded-Encrypted: i=1; AL+hErEewFceQVxmFO102GFJFRHCccuH/V3rqdf+OK7q3iVvkXspr9k7ITVENrT/jSToGSAhy30=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LwJhFvCTb8Tin0lxGWKy/Tr6xiDBy2nnwRefraJVhuEtqX3Yb
	eQ/UsaiHwBAhOvm/eaKSaO5dHUgByUr45Xpnp7uHKG/j42kab6r9Es9wgePt7G7HF0LotnDpHhd
	FCZxUKNdv6Po8trztmFvIBUjnftKPxe0=
X-Gm-Gg: AZFdTZdQ19hZqXjAFpAW7AO+I69YNYF9K17PcKw2u3vwdNCXrTSC0U1vU3LRHTmVv0P
	3CrfPiP5iijUZnw0tQ1kHs52T8T052p/csOOvkvAyOWXyn+xicIDSU/qsEapM78rqYQNyLQ6QrA
	0najHL/Mkxzveg8aFIJGgP9n/eFyuj+KRnrxs4ud7xkqffJOQScpm8r5Yt5hHIeYXQmKs37gzYn
	ih1sztHLLJNr6CPo08cKo3bXdbrwl1LAwaocrQzSDSd8JDWNKYoHQJXCdMLcxSF9kIOa/v2C0YL
	HTK2HY0tYsyRDCfcbITtyvX0O5+PTVMwCwdHy3YaB2icuwjnpVlenA8ZJNeo1YMqgisdeFWGNZG
	ubPl9flTIyb8ixbnZXbPfwflRG398PfdEsJKOeHDgPgOol09xD+iaJE4nKxBNa/ExH4k/8zGzDn
	bdpUB2TaDsPxJ+r/N9p6eO5kxeOxmjxY5hJCm/SlSqJm5pZ6h5vrLIxJI=
X-Received: by 2002:a5d:5f05:0:b0:48f:cb37:3ec3 with SMTP id
 ffacd0b85a97d-4a63b22de8emr1573091f8f.41.1794951885727; Tue, 17 Nov 2026
 13:44:45 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <CAEf4Bzb+oYDqO20v4YbJ45wdtcGgJT3xVse822P+=oA7fpFAOA@mail.gmail.com>
 <CAHC9VhRcT3rmdpeadwi2avhwvr7aEZYStZ3bbEEx1hm=wtBGhQ@mail.gmail.com>
 <CAEf4BzZ120age2-M-a_TJ07xohb7-s=xn3e1W_-V0kopnATq6A@mail.gmail.com> <CAHC9VhThV9xiXr8j5_+W__CBKn0JqUiZ-RGZpF4Nz-i_RZprAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhThV9xiXr8j5_+W__CBKn0JqUiZ-RGZpF4Nz-i_RZprAQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Nov 2026 13:44:33 -0800
X-Gm-Features: Aa3M54qGP8nd7yA_gOyJhY4In2fLuAhhx8Joode7Q3Ty5mdfX54Ucq86pk3FqTg
Message-ID: <CAEf4Bzb5Y5TUbN3kLBJNPn5Ae+_nbc7YhJice_wUzqdvpjFr_A@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Paul Moore <paul@paul-moore.com>
Cc: roblabla <linux@roblab.la>, Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:30=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Tue, Nov 17, 2026 at 11:51=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Thu, Nov 12, 2026 at 6:41=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Thu, Nov 12, 2026 at 6:00=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Mon, Nov 9, 2026 at 7:08=E2=80=AFAM roblabla <linux@roblab.la> w=
rote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Thanks for the replies!
> > > > >
> > > > > > LSMs that need to provide a stable API must provide an abstract=
ion
> > > > > > layer between the LSM hook callbacks and their stable API.  The=
 LSM
> > > > > > framework is not responsible for the stability of individual LS=
M APIs.
> > > > >
> > > > > Understood, that lines up with my expectations. I think the bigge=
st
> > > > > thing here would not necessarily be stability guarantees, but rat=
her to
> > > > > make sure that the eBPFs fail to load when the compatibility is b=
roken.
> > > > > But that's probably a problem for the eBPF side, and not LSM, I a=
ssume.
> > > > >
> > > > > > So, in short, would it be possible to send a follow up to Daan'=
s
> > > > > > commit and move `struct mnt_idmap *idmap` to the end of LSM arg=
ument
> > > > > > list?
> > > > >
> > > > > If this is possible, that'd be nice so that we avoid this breakag=
e in
> > > > > the short term, since the change isn't in a released kernel yet.
> > > >
> > > > can you please send a patch proposing that and we can continue
> > > > discussion there? please cc me so I can follow along
> > >
> > > Considering the original patch was submitted, reviewed, and merged
> > > with the BPF LSM being the only user (none of the existing in-tree
> > > LSMs use the idmap parameter at present), I'm a little surprised this
> > > wasn't brought up earlier.
> >
> > Yeah, unfortunately this was missed. Not sure it's surprising that it
> > wasn't detected immediately, though, because unlikely someone tested
> > an unreleased kernel in production. Luckily, this was still detected
> > early enough before the final release and this gives us a chance to
> > fix a mistake.
>
> I've been surprised lately by apparently how little the BPF LSM
> program interface is tested with real BPF programs before landing in
> Linus' tree.  I know the BPF folks have a pretty good set of CI tests,
> bots, etc. but there do seem to be gaps relating to real world usage.

I think it's a hard problem, yes. BPF selftests test latest kernel, so
this issue we are discussing here just won't come up there. Then,
e.g., for Meta, we do have internal tests that validate existing BPF
LSM programs across different kernel versions, but unless our internal
BPF LSM programs utilize specific LSMs, this won't be caught either.

>
> > > Beyond that, from a style perspective, I think I prefer the idmap at
> > > the front of the parameter list in most (all?) of the hooks where it
> > > was added.  I'm not interested in moving it at this point in time.
> >
> > So on one hand we have a real user pain which is easily fixable
> > without burdening kernel and LSM subsystem in particular, right?
>
> Arguably changes that negatively impact code style and readability do
> affect developers and maintainers.

I agree, but argument order is not that big of an issue

>
> > On
> > the other hand there is a minor issue of argument ordering with
> > mnt_idmap preferably as a first argument. I get the preference, but I
> > think fixing an unnecessary (but easily fixable!) user pain should
> > come first, don't you agree?
> >
> > Can you please reconsider?
>
> The user pain exists because there is no abstraction layer between the
> LSM hook callbacks and what the BPF LSM makes available to BPF
> programs.  That's a choice made by the BPF LSM devs, and while it's a
> valid choice, it does have drawbacks like we are seeing here.  Changes
> to the callback arguments and/or the semantic behavior of the LSM
> hooks are going to continue to happen regardless of what we do here.

Yes, just like it will for tracepoints, kprobes, etc. Sometimes it's
inevitable and BPF ecosystem does have tools to deal with. It's still
a friction and pain and burden to do this, so if it's avoidable at low
cost to the kernel, we should try to minimize unnecessary pain.

That's really what I'm asking about here. We did do that with
scheduling tracepoints, I think it's reasonable to do this here as
well.

> It's better if the BPF LSM figures out how to deal with problems like
> these rather than relying on a set of bandaids at the LSM framework
> layer.  If the decision is to push the pain up to the user to keep the
> BPF program interface thin and flexible, that is their choice.

Yes, thin (and thus performant) and flexible is the design choice and
I think it's fine. That's not really the crux of the problem here. As
I mentioned, users have tools to work around changing unstable kernel
interfaces that BPF programs rely on.

But in this case we are discussing reordering a few arguments *before
they even get into final release* just to avoid unnecessary pain and
workaround. *Unnecessary* is the key here.

I really don't think that's too much to ask in this situation.

>
> --
> paul-moore.com
