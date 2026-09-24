Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6A4AFE0F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278506; cv=pass; b=bVThGSIp/UojUM9k2NaQL8ooEx5cCoPArruvHK1DGI2YZPMTha1dTmCXBx5scDRWVjvvjL+Q4ABK/hcVdQ2LXNy1VhMilmXB9C7REsQIWw3SdNahASkq8fj4Y2nJgAaVSX3J4+E77jIGK/N/ZwSF6xpLcHziuAHm4KrhREgQs/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278506; c=relaxed/simple;
	bh=Xh6cigaJGh2nl2K1gfL4NfpjbUyrPHxMoHdW4U9oa2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYgJF1X5UvhiXcN3X3KgBNQJzPkS+/3iUtHg7oEB6tKy0C3ZzkwKsav8gOGiukD9Nb6GWSMjVrdYtQ0JKdAUDh12D3rG677KtpYXb2yYbYNw3a9Ee6PUMJUO3p6PVmVEHLfOtIhMyOeT/kOCW4K7d8EE0YfRZbjrlSYfdTe3Om0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BrEolTOi; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BrEolTOi"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4aa80a73so716485ad.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790278492; cv=none;
        d=google.com; s=arc-20260327;
        b=qAkDaCuhZGDf0uT/vMTXK02X/mtFL67nakg8+G/0gRCPcz9+jy3Y8IV9gANljs9BPI
         Mxc5QuMSCIk0r64e0F8Y1HUGgB2g+BRnavqn7cnzC9NKCcaYKT/kG/qTCtOEuoijHGYL
         17uR6PHSibsDPa/2eEs2GSjSQ0wzLzqPzupXSQBiUlhseLhCgj66d1wSnU9hGep1+gdb
         BINoEWX8GH3HcHLULWo96W4aKQBPME2E0YV58mKuN6JjlnR6dnzd61pXx/k0f24KpXSK
         vUA1T+usShuIOB3XXq1+TnnEM8kFTD7PZ/xeeDQS7oIK+MAP7IhGd5p8yrmXa4h4xtZn
         4T3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRSn02XFlHAYU71ZYcqdkqquo3iQQ46lCWrb5uNEf70=;
        fh=4yWZhlhHHJq6XqJSW6OVv/ghqmZPSt+585DlDM0cwMA=;
        b=jM+zWMG94hzXnuoA5dUejjQnyKd2BWA7TwQinZPryNjly75nFvDlXbR5up80eTYsYB
         49410ZxHWz8z8XUO8U2qn1eOTBSkoE/0YR6WxD6Rj0D0/8oF3RAtGBLDvquaswGehVH9
         KPU+PU1EyivjGpSj1Q3BHH0+6gHSzIgjKAvy7wEWXVvaNBhqDu1FADKEF4dv30qtBgaS
         wELR/vYiVHNu2QOZXoHU5RIAQINBYNNxHtLprxH6BdTw6q7bDhnHLWGLTq2BuD5aM72g
         B7O45ZIAmAdxeMgktCHU+x5FRJaju599lfHBlpmx6I8ib59her2cIEX2riv2Vpm2zn8p
         3ELw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790278492; x=1790883292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oRSn02XFlHAYU71ZYcqdkqquo3iQQ46lCWrb5uNEf70=;
        b=BrEolTOi0ZFLGwdiqIocwy+8Nm8yKuI93x1FcsnJrcqPvyYPcC7gKpLMNfJYGEAdj8
         MrwtTQb92GMtS8P1PeBocbTgEk8V2GRVAghMuNw9sWsXy59mmtAUG0CFnfRnn+gqk84+
         OsLopjSLL5WPwUZi0k+lgf8+SdnW1mFd5NiVdc9YDA9rxAv2AQZSUDuyCgTL3VN/U55d
         5cNyrwzL8WKyZVo+sfBkSUsTxQgNSqcZNVa1Q60A4v/VCal/aiafVFk4jeHEJwaH1bBS
         LrUqREJxTykqnetQvwBpUgOKECBH7cAstw2MymTvAvJqZXs4f9Z/B/AgYmfcs4T19blb
         TgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790278492; x=1790883292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRSn02XFlHAYU71ZYcqdkqquo3iQQ46lCWrb5uNEf70=;
        b=VJEPoNHzq5dSiZwRCmVD0hCCgm2J91+8W6tu0BqWLsuvBp9MqyKD2qAcdsv4W5b0PE
         fS/rcDZAxBsV+4AVyLaZTcWOWs+WbaLdAg+0dCfK3jdKx3KO/H9eoOysTr4lzF0tTSdl
         4vhxb4ElyYTHnYwJ3UaEPML+86Qh87xOeX4NSJdRtoAGf7vT4MfppXM1Mw84n1ETUMmJ
         Z81qCQt+lSXZxvtuAkUzvZm7V6jQ4jpTfZaKhRyhwI/rX9dZWsDcMzzE7BKCVV6K0+g6
         n89LTioHIH07cBWYZtU2s73nxgQeBBejlh+STRgUw6NHI2s0fttBKpGUIzaypdSOH10C
         oUwA==
X-Forwarded-Encrypted: i=1; AKwUvByRe7p4q3JFixs6lM/cZcc3/dFt/fw+ZXDpS8Cadr4Lau0LJzF9eozCUloOE1iEOFdjymA=@vger.kernel.org
X-Gm-Message-State: AFuF++mU8Pa7ynLg8IhNDOUIF/EC7cSP3/gSAnfCGrCy129MMlOGj8cj
	A2q66Uk0me5u4hr4VuUVxwTJB/biCFKZKabX15fqXzIIpVZvBkZNpb4qpMBz2GYniuBq4sUDxHx
	2Qmjnq+YM4UC/+NqMLtSZJKccmRPfFfqOfYaW8hco
X-Gm-Gg: AYBFou0+WNp7iDXhPQnohczEotdc7BCWA3hojT9b9sPs0n6J/Arl6thuzOvcY4HwhyR
	L6YzNNVGw3aql2M9VPRsc2D+Uxl33OVKYAUFQjU8eVxSwcCnBJcl90kiyUc7G5uZstdl3m9VNxk
	4FbJFzlqX7KY/sjAGMa5C/xhIgrm64CgMDkOqdfGRzsTMZbm946HsBz/whoMAORO/oFW4RwYS1D
	cOX8uFWqpKESUHgXxi4IV5QdG8GlEbMLGXUeBp5nDf5gDwnBiWNyI+mBPo+mtr0KqaYSz9JIfTk
	u+HquEAO3DVIrlS60Rf0MwNk/0z8Ltvcny/WCpnywLDRGZdRJ1pkPT2dgJtV4THg6+BCvLLIzup
	dOfYMSaYb7+o=
X-Received: by 2002:a17:903:19e7:b0:2dd:c053:82fa with SMTP id
 d9443c01a7336-2df7dfd5d68mr33739235ad.49.1790278491614; Thu, 24 Sep 2026
 12:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
 <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
 <arVKSpezisxe3pkr@suesslenovo> <CAHC9VhSwbHF8tZkZ00JM40VTBeXVgcVdoBt7NcX0XKaKSARWug@mail.gmail.com>
 <arVkWs7tG3ayGxyX@suesslenovo> <CAHC9VhTzGJz5Lt8tXYzJfMihsMOX3Wa=6b83dV8QihpRBfBbWw@mail.gmail.com>
In-Reply-To: <CAHC9VhTzGJz5Lt8tXYzJfMihsMOX3Wa=6b83dV8QihpRBfBbWw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Sep 2026 15:34:39 -0400
X-Gm-Features: AclHuK_3RmnxFwfWOEc5RzC2ZEn68Zk0RXtvqz1D3LH-whkeqU9xYC9Rbdxv0Yw
Message-ID: <CAHC9VhRuFWZtxqcH3kfRVgM42dR_9P5QH9JN-dkpudgx0LGUXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Justin Suess <utilityemal77@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	alexei.starovoitov@gmail.com, brauner@kernel.org, john.fastabend@gmail.com, 
	memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 3:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Sep 24, 2026 at 2:38=E2=80=AFPM Justin Suess <utilityemal77@gmail=
.com> wrote:
> > On Thu, Sep 24, 2026 at 12:23:13PM -0400, Paul Moore wrote:
> > > On Thu, Sep 24, 2026 at 12:15=E2=80=AFPM Justin Suess <utilityemal77@=
gmail.com> wrote:
> > > > On Wed, Sep 23, 2026 at 03:14:28PM -0400, David Windsor wrote:
> > > > > On Wed, Sep 23, 2026 at 12:57=E2=80=AFPM Paul Moore <paul@paul-mo=
ore.com> wrote:
> > > > > > @David, simply for my own understanding, did you ask Daniel to =
do
> > > > > > this, or was Daniel operating on his own with this patchset?
> > > > > >
> > > > >
> > > > > Daniel and I work together and both have things written on top of=
 this
> > > > > kfunc. He reached out to collaborate, I agreed. We're also going =
to
> > > > > send bpf_set_file_xattr shortly.
> > > > >
> > > > > This implementation was chosen due to its immediate mergeability =
(it
> > > > > only touches security/bpf), but was actually suggested by Kumar i=
n v1
> > > > > or so of my original series.
> > > > >
> > > > > That said, sorry for any confusion about this appearing as a new
> > > > > series rather than as v7 of my previous one.
> > > >
> > > > Howdy all,
> > > >
> > > > Hope you all are doing well and having a good Thursday.
> > > >
> > > > These patches are excellent and useful, and have been in the pipeli=
ne
> > > > for a while.
> > > >
> > > > In the interest of moving forward:
> > > >
> > > > Would you both be able to live with the following: provide a securi=
ty hook
> > > > for lsm_get_xattr_slot or another proper interface with the necessa=
ry
> > > > abstraction, and keep the kfunc where it is in fs/?
> > >
> > > That still doesn't change the fundamentals around the kfunc: it is
> > > really only a valid to call it from within the LSM inode_init_securit=
y
> > > callback, it populates a LSM framework managed buffer, and that buffe=
r
> > > is then used to by the LSM framework code in
> > > security_inode_init_security() to do the xattr initialization using
> > > the values from the BPF LSM as well as all of the other configured
> > > LSMs.  It's very hard to see this as anything other than an LSM kfunc=
.
> > > I worked with David over several revisions of his patchset to review
> > > the code and get it in a good place, I'm supportive of the basic
> > > ideas, but this really needs to be located in
> > > security/bpf_lsm_kfuncs.c as it is an LSM kfunc.  As we've seen there
> > > is precedence for subsystem specific kfuncs located in the associated
> > > subsystem's directory, things should be no different here.
> > >
> > Hello,
> >
> > I'm less arguing for any particular placement:
> >
> > More so that the concrete security interest of just getting the kfunc
> > *somewhere* is much more important. I have no doubt that the function
> > would be equally well stewarded in either directory.
> >
> > The xattr kfunc in security/ question can be fought best in a different
> > venue where it's not holding back good contributions.
>
> This (the mailing list) is *the* venue, and sorting out
> cross-subsystem issues isn't a foundational thing, not something that

Sorry, typo.

/isn't/is/

Sorting out cross-subsystem issues *is* a foundational thing.

> can be cast aside because it is inconvenient.  In this particular
> case, resolving this before it lands in Linus' tree is that much more
> important since cooperation has been "strained" to put it mildly.

--=20
paul-moore.com
