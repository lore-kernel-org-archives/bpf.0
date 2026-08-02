Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8233B4417
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682216; cv=pass; b=D/JvVWzkeXF8CBCp7RHrzcUs+SeugodFEeZFPQTu+9aYxS2RXffiqAdIBskesiMsKeZtKPliuYoSOAvomuMPTzHr3EE5nA9++oRIpi7cp4cSin8TnrKeM4KrZX4GEAHNrvqC5C0+RZMbayUflpKugJqCGbreVrs+J4lovsmmAFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682216; c=relaxed/simple;
	bh=7kkcp+wOorntAb3DNadH0Q8Sg1yGSgKiD+TONbs7qUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyKGoF2y8XT6Ftnx5Y9qb6++AJnLMcUInLRsbsGDvpILRHK7WL3+Loftuc7qT5PdR2b0uv8q5+oYLVOFtRwgalm6O21ljF1DrbqaLv0AaMiD6hyLTU3iI5212oR3KuXFLw+aWhW9B75OFgGt325bR5GGcMXGcKlKWY6IpTNpGvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d3TmUEmD; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d3TmUEmD"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so2984502b3a.2
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 07:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785682213; cv=none;
        d=google.com; s=arc-20260327;
        b=pSYPmFz8Ff1x4HjbXb5/AkvAGWlAfNF8ZRXGEplvl52HsGdFKGhTeVNab8SedVn9pw
         gsPD+VT8UbhW5rAXQbueW4MGpWNuPNnYvBdcox6mCRFlWawSumQVN7PnC5Z/BAniHSmj
         p8jfrWA7CL0rbQ9CZbkCP2A3lS/0FfbnBTid0ljVIaoN7EhcVIHdDDS8H0FWkqLqhpxi
         6EcyodmtbfpeNHJnS6jfB4ZPvO5LhEem/QcgK4JNqkitEzMyWfqBtNzeGPrLlT2T6KTs
         i0LQgQ2lgx5aH5aGIXEqxl/BBvflEWu0+NDlAHEaNZ5RaRZNSIoAALn5M7Thqg/pW/Z5
         c/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OmgWl/f4uXW4AQpzfCn2lxP5muAJ5BUlRpvNvDKBVgs=;
        fh=GNMBleevHYGvvqzzw69JpULH59u79sQ8QBXOTlQGfDk=;
        b=C6rtep72DWOJEYVSjgZmIC6OgKdCtILizyPkqqO2GdXZp65Hld3p4O61ymEL8oqXTo
         AWywQvXaGd2LtUHCK4ECdB5qqjBVMkfyjyyGWa3q/q/9QvATjHcQpHu/1cQDxZlFJIun
         R/tCzaCE1vRGO92VQHzIP1EZ4FX6okEPAMwLHtcPJBQXo6TS5ir2fofeCDuFroXgkeSk
         YeLsyob/QnA66pnifo1GVoujyRWtjswt33c6uiy0aRxGK/7rGs7D9utSQXV5YhMfBoqF
         xPcP5Ddka7maLF3ht114RiYe/HSGQWjr+LHmjEsm1bsFjWmw3NaZMb3iVx6LkR9dfq1E
         L2MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785682213; x=1786287013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OmgWl/f4uXW4AQpzfCn2lxP5muAJ5BUlRpvNvDKBVgs=;
        b=d3TmUEmDewxJT2GJJ7flVa7AXI99c0jYB/Vci5U63n3USKpC5+LDvLpUnz4on+ypxi
         a/iyVr7JUa0NIzulDnSprmnZdyTmouYpUiDDFC5wel/7jkvzaPLhR46rOzF/X9RAu6AT
         1g1BZaRSKENCDMGTi7RlE1Xu++pjSkF0+9myK99aZTDszaTD7vn9SH4p5xWpeUJ0kzcu
         ln9n1Ye7sIwrY0SUdzj58jQBwZbVu9ffhcJeJlsjiJCt6oKF0Nmoz7uMUf9iOQRkl6Kf
         abDInXlm5RnSjfJ3IH5DV0+J4Z8YI317/4LJ1/KC3fEioyR0GHlcv+b8ZtLGH36/6mqk
         cf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785682213; x=1786287013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmgWl/f4uXW4AQpzfCn2lxP5muAJ5BUlRpvNvDKBVgs=;
        b=LLzxclG9WP+Nk2dc7dr1VdAx611buCGKQYdmramKvLRT+kDeGx29TH/m0l82pTei5c
         cSnwImTDw608mSyNFAUWRd8sFr2VhvYSEB+/vK92AO6GxYLQXfC/ICLBLuTDm9Z8IV2K
         KdKn/nDj1S/bY9XSWX1NOMV0AzYxyMpYv0w+jzbozxp2gtR6fpM5qcHXUF62h678Z9bh
         d5hw62XwIDMWpKOUMEAAYP+8tJ+DofiVxLWhe+5tj5UpLh9Vdzb6VjMfBdZHREPBT/IQ
         y8jWYmG5TLqr6Ppu3TXm7pHk6/gyhixy7gTv3uX56fqwsxiBuAtbwn+/qATgzW+GsjX0
         IocQ==
X-Forwarded-Encrypted: i=1; AHgh+RproO6yLKKVj1Hw4/YmUN3YNxjK3geGRKku63cMWRFgj1LNbXkncpPmefDCp99VoL5/LN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5VtBZnpTvXAmjfVSj6/lJQPYaLjeIxqPCi7vKCsRUbPEmyB9N
	JJbwPLbIwrax38jrMX5DiE5/sWtXfIIFyL3GRKq9wTehNMwX4Wn3eAykMZzNy8AJ0g2oVLk89Wm
	Mlthc2UbHGlaLEQXrXc51+jWzFsA6oE/Hi3mTK0Ui
X-Gm-Gg: AR+sD13Irxi5Ew3kBEFSkm51hle5XSl/VXRagFQ5+LpuOF+kWUPdqLA4rAnYYsnLt/+
	3rED3czjdL1mxG5AOEvQyqcq6S2uxt0xHJc+uYy+dOw4An5wHofd/YK+8mTrAYlJ+WqoXmkyp35
	mlgI1to3xWKXPBVAvUtQ8MSNJzswXKhrWNAGuS3IOydtGKJpmHsVMHeE7bfwhLIB28R/AkUCf8w
	0WKzdp048cy39iqwhOeJiH+Pzk4+BBiUEwEhGukMZWnuZhYP9TPnM6J+hES0FKV1sA2T+pLFhSh
	w462ogPnTNhyLJmF6hF9EgAqxnjzQEUXg4QcM1cJYQcI
X-Received: by 2002:a05:6a00:9289:b0:848:6c1c:17c0 with SMTP id
 d2e1a72fcca58-84ee47c7dbbmr6238656b3a.19.1785682213526; Sun, 02 Aug 2026
 07:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com> <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com> <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com> <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com> <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com> <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com> <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com> <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com> <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
 <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com> <CAHC9VhQxeNJ1U_cUX=4mdJT17jG2ZFY27YM2CXK8wcuRPQYtrQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQxeNJ1U_cUX=4mdJT17jG2ZFY27YM2CXK8wcuRPQYtrQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 2 Aug 2026 10:50:03 -0400
X-Gm-Features: AUfX_myOurolkOWbQTM-uf1kAESEJT0FADttjcAMdHsh5yOJTC09VeSrydmRClc
Message-ID: <CAHC9VhSRbwLD_yxEPKx38X59KcjZWKPQj2QnGupP4NFC6zu66A@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 10:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Jul 31, 2026 at 7:11=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> > On Fri, Jul 31, 2026 at 6:23=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > > On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> > > > > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > > > <memxor@gmail.com> wrote:
> > > > >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> > > > >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwived=
i
> > > > >> > <memxor@gmail.com> wrote:
> > > > >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> > > > >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwi=
vedi
> > > > >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> > > > >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya =
Dwivedi
> > > > >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> > > > >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartike=
ya Dwivedi
> > > > >> >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrot=
e:
> > > > >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kar=
tikeya Dwivedi
> > > > >> >> >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore w=
rote:
> > > > >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar =
Kartikeya Dwivedi
> > > > >> >> >> >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Win=
dsor wrote:
> > > > >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Pau=
l Moore <paul@paul-moore.com> wrote:
> > >
> > > ...
> > >
> > > > As a consequence, everyone suffers because they first need to satis=
fy your whims
> > > > on how all code and kfuncs written thus far are wrong, and need to =
be moved
> > > > around ASAP, including the one being proposed.
> > >
> > > That's not a reasonble or truthful summary of things, I've only
> > > requested that David locate his proposed kfunc in
> > > security/bpf_lsm_kfuncs.c, I never suggested he move any others.
> >
> > Looking at what's left of the kfunc itself, it's basically nothing.
> > Everything meaningful has been moved into security/ already.
> >
> > Aside from bpf dynptr ops, what's left is:
> >
> > if (!name__str)
> >     return -EINVAL;
> >
> > if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX, sizeof(XATTR_BPF_LSM_SUFFI=
X) - 1))
> >     return -EPERM;
> >
> > if (!xattrs->xattrs)
> >     return -EOPNOTSUPP;
> >
> > ... then a call to security_lsmxattr_add. Why not move this chunk into
> > security_lsmxattr_add, and leave the remaining bits, which are pure
> > bpf, in fs/ for now, and litigate the total placement of all of them
> > once v7 lands?
>
> Thanks David, but my comments and decision are based on the kfunc as a
> whole, not necessarily how the work is divided between the kfunc and
> the LSM hook it calls; shuffling bits of code between the two doesn't
> change the character of the function.

To be clear, this means I would still need to see the proposed kfunc
in security/bpf_lsm_kfuncs.c to be deemed acceptable.  Also to be
clear, I'm not suggesting, or even requiring, that you move any of the
other existing kfuncs in your patchset; I never suggested that as a
requirement for your work.

--=20
paul-moore.com
