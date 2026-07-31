Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CD44E66F
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525655; cv=none; b=lmj4G3RIoowTeB4UZUq8fxZuVd+PhzD2Je0JugjQJO1+m7SJbOvcNP5ifXUY+ir9nI7sb1IVBTrw6sF6liwz2Se2FjUhspdD9/IGLUVGXjiagSFOp1iUyua4sQ7A10HM2KMxUlvaJO/5K6rfr0bfFZgV8lyFk04UvMQuYG4ucGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525655; c=relaxed/simple;
	bh=W/cQazly5+ZSmwW+vMYjDeAOiE27Kjc1Cr7JvjQ9jfs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=gs9nRWY5m5sC9zZWd1wSB08aKeNZ+ujys33IK2mKNHbVPfq6FAAHR+ebmoKnQuivP6O7jnc24m3ba0P4/m3cZd7Lat4GZu+8Pc5dMDpzLXzFhofWy18xuXOfXPWn5zWC4wkE7bht8CWktmESYrldqgpj1TiitUXgUT0g/d9pI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhAFGLhV; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhAFGLhV"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47301772842so669627f8f.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785525651; x=1786130451; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3/Y6YcDM4/zvWNQ6LoR9jhMZHzjhOIbqHOCYPbHDmdw=;
        b=nhAFGLhVLCPf3TVFJtApTCWIQHVQvV9MPsEf6fHLya8JT19sY+BBoWI8P2L631IEIJ
         JIkv0qRStiFochcRnso74FFbiEfM/zttVtvwqSjkUbHlVPAeIAYxgorGBqyGf2MlJ6Ns
         ytLz0mKTS35yftkeGpuJ+kqpCzkq6UjL1Rl0VaszcxCHb61UAIvcd/ADrkHlbSKM5uyk
         AHjkndgGbiaAlzFO8cM0IHpd4pxrKvRZUkari1tm7Q1M8zoC5MO5t2ioOxxnfyNtiapG
         /zuGi/w7A7XStv38XKLTDte6pi/D36FArcTi/C/rsmrow9rW5NNV6udYKSzDpjoXZfyB
         aJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525651; x=1786130451;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/Y6YcDM4/zvWNQ6LoR9jhMZHzjhOIbqHOCYPbHDmdw=;
        b=EHUxY2u/kv0+FLfc9G815MRWYJm5jUMvg3vB6Cti8ISQ+ruFmMPVSyO2mDr83ZEWS8
         Q2oXKnrrOX67XT9M/DK1zUb4IKuF3CHCxkJ6tA8w6zi4th7t/YQSSci+NVBZHNVA6QzH
         dJDOX16TvUVdnOtdmWyNFr01JyaHkqV33uTpaq8o0yyGmAxvPeV7ppIB088e41SHimDa
         VMWqlOdQqps8BG7CJZA2GDjQ2+Fotl0qjLaUGrH+5T6hP8hVJKlq13g27w7NNGxEnq1t
         r1EmBHiELNxfZw0WAnZaa8cZObK02AUpHchVudXF4mKz70CSbTjuDpzkupn0kghrSla4
         QVJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+T/0s9msDdBKk1/aFhtywwjto+P+xQApPahA1sHuOrjHV8AL2NCO4EwQCWY5S1u77aSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6StvjoylVZrDOhXSGCTwOnOvUUsS34Eh4HV7l76QE4TFhwWH/
	twCE+rgQDWsj9s1kvBB7kOu6A/krxHEha57BtjEbXgVMjbBPmTKL7hby
X-Gm-Gg: AR+sD13wlKFMmJMuaQyQPTnr15wz+YPOqivKvNTRni/x8y1iBhNnP51pXlrHkSw0I3l
	fAWKRlWoXXht2rWO7xgdjgPfC0e/hPQPm/xffxvQBpJgvjugXc0qpCnLPOc3nhD6PtE9eoO8R/p
	rce0E8mu9BTSIKXjp2pPRJudkAPP3MuTZ7GfG5jA2N7pE3XQRkWAYOTBxYZBL4YcgtO2IOIm7g8
	oDEZJK9BuRgBXm8UfHEvD01BeEe+Pj1xyROXOGKXC2Os5YpQrzFLKhvdYr4L18YBFlOox92l/BL
	23v1iLPHD7WLcUKaLKobtbHy0mJULEBVV8RnbN5Ergbs607pziHgvzm1ziVjGnzA26G8eMsMSkV
	SjAF77d8YIahf+Qu64DYDyPhLqFIZIMOi0VAlDWIHNmKMCIOjdDYp9EFxNNlaVwseC3yAhkewgf
	BD0NuhHFt7Ngrfd/0XMTl0NIBucnvifvoknjB8/hmDlV5PWihPIJuEOQ/hO6zCTwZEDJx86Uz2N
	6WQoIGsNP9oNkjKeyGDjE1IXaYrThtemN/KJ+MWPFYPUeRdNtdjulzjyV/jTv5guQfJMuGqFwaY
	nXJKXjKaJjLv6SgUjq17RbtL9uY=
X-Received: by 2002:adf:eac3:0:b0:47d:dfc6:b28b with SMTP id ffacd0b85a97d-47fd72e1887mr1421938f8f.30.1785525651097;
        Fri, 31 Jul 2026 12:20:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6cbsm7789645f8f.23.2026.07.31.12.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 21:20:50 +0200
Message-Id: <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>
Cc: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Matt
 Bobrowski" <mattbobrowski@google.com>, "James Morris" <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, "Casey Schaufler"
 <casey@schaufler-ca.com>, "Stephen Smalley"
 <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
 <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
 <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
 <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
In-Reply-To: <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>

On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
>> > <memxor@gmail.com> wrote:
>> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
>> >> > <memxor@gmail.com> wrote:
>> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
>> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
>> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@pau=
l-moore.com> wrote:
>> >
>> > ...
>> >
>> >> Yes, I understand you feel it should be placed under security/. You a=
re entitled
>> >> to your opinion.
>> >>
>> >> No, I do not think the newly added kfunc is a big enough layering vio=
lation such
>> >> that we need to do it ASAP, disregarding everything else outlined abo=
ve. I am
>> >> sure you see that too. There are several other instances of similar k=
funcs.
>> >>
>> >> Therefore, please attempt to meet me halfway here.
>> >
>> > I'm happy to work with you, and/or anyone else, who wants to work on
>> > finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c.
>>
>> Right, and for that file to exist, you need to get everyone (FS, BPF fol=
ks) to
>> agree on whether placing all such kfuncs there makes sense. It is not fo=
r both
>> of us to decide on our own. So let's revisit this whole topic once you'v=
e done
>> that exercise.
>
> The kfunc that David has proposed must be located in
> security/bpf_lsm_kfuncs.c, similar to the VFS kfuncs and
> fs/bpf_fs_kfuncs.c.  If you read David's bpf_init_inode_xattr() kfunc

Sigh.

I now went and read the archives, and Christian already told you no before =
[0],
which I missed in my first read. So two people whom this code affects alrea=
dy
objected to your proposal.

  [0]: https://lore.kernel.org/bpf/20260625-schnabel-rennmaschine-parieren-=
bcb352c3cf59@brauner

> you will notice there is nothing in the function relating to the VFS,
> well other than the "inode" and "xattr" in the name of the function;

I can also read it the other way. There is only one "security_lsmxattr_add(=
)"
call that is LSM related, and the rest is VFS or BPF specific stuff.

There would be no xattr support in LSM code without filesystems implementin=
g
them.

Please avoid making absurd and non-sensical arguments.

If we went by this logic, we would have to move the entirety of the kernel =
under
security/, since anything that calls into LSM code becomes eligible to go t=
here.

> this is purely a LSM kfunc and I stand by my previous comments.  The
> BPF maintainers have seen fit to decide quite a few things LSM related
> solely on their own, I see no reason why requiring a LSM kfunc be
> located in security/bpf_lsm_kfuncs.c is unreasonable given our current
> situation.
>
> As I said earlier, I'm happy to work with you, David, or anyone else
> on ensuring security/bpf_lsm_kfuncs.c has the proper test coverage,
> but I'm not going to continue to go back and forth about the location
> of the bpf_init_inode_xattr() kfunc that is proposed in this patchset.
> If you, or any of the other BPF maintainers, are not able to live with
> that location then David will need to find another way.

Yeah, I think we've spilled enough ink on this. We'll figure out a way to m=
ove
things forward.  Since VFS people disagree too, the kfunc should stay where=
 it
is in this series.

I am always open to revisiting all this once you can convince others by mak=
ing
useful arguments, instead of imposing your will onto them and throwing a ta=
ntrum.
