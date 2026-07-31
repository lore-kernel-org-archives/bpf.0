Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A79369D74
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536595; cv=pass; b=ownlhCmyXcvLD3BHDozsN/aQbnlTa3WwLMNDptTvjCAt3cPRw52VP6CHMcT5YX2wiUSu1ZiRRnwJcbnHjvvO83oerY+6OayRjuiJYUhMo810eVkIQCLMc0KclSegg2r+omVAQo0YNAvoJiQ3UtR0BoDPKs5xUs0Zg/A1kPghZ9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536595; c=relaxed/simple;
	bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WETIkY3hlxAH1pTrkBqB4dMY7Mr6wRJUzTGHYlx8Bl7BDy+4Ph8bh960sRZrLQ/f9jawfjHulPMnJtafYlctTnTPc1e7oP6ZdgkK1SYGQj3r+C/TwTVcv8jqzg15ZuCG1p0um4uZhxlsg5eF+mUanEhFhnVBkhNTDEPhYJfuWfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=azYAMVWj; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="azYAMVWj"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1949871b3a.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785536593; cv=none;
        d=google.com; s=arc-20260327;
        b=ZYbFZxxIa9R3hYjeCrTq7N0BpZlPLsLNcDhALv4LPmo/C6GP/OFIUczKUmDVCTeR9q
         tFtCxli/CLlabDWXkkeEqrDH1zbxhqXy3Q5ggPeeAfmH38ocbOj/F4hpEw/QQOEj5u24
         P432lGxWDZWDrs7K359W6T43F1YZVqnfFGJWZRKTUmPH6AXCqDwWICkNBV1RqNNU+UfV
         LHRFteQhOVZZVhQZlUD+rXymnSWIxlhYTBfI5kAfaqHg/fBtSxcVlsEFeRP8TVO3dED/
         91HVVRhgiRB1psDc8UU6IaB35kOu40xnXUXFC/4oc7rstiXGJd3jbV+lWf2VV/jRPC1+
         r5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
        fh=Zeq+yFfkNmx059GTIf9yfqUhnQOyQPd4dqPQ/DssTCs=;
        b=XRnMLuDuJxQDjVJN83yCNMQrtseYv+Mh37utEeetL/YN+l/E/ZY/3hO/lAELB4XL68
         Zhst72BIrz5xKt+RlItudIvNnxfGQifPk7HpdrWLxm10oc5XysEXdGakM8geLT9DQinL
         +xrB1wCx+U03zNhNbh5lbGcKiMhy1hVApn5SJEJbxeBOPYjkZycrR0/4LPtpuqNZVfXJ
         ECGGUhaOnGmW2BMUlD5BO44PpFci0eZicula6wQkuyWgy+KsWSqUwAtQUcjhIskpyNl+
         e9pQjyDPyvO5xM1NLGsRjTNwrfIuIy1D4vTXABBdLdzm7y84rCjWtxxH4RU7v2pS1ZpS
         WxRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785536593; x=1786141393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
        b=azYAMVWjhYdwMzeWcI05q+xknmIUABIj20r9StipuVxCW9z+9th7XSxJqAvVXfLmGe
         kwiyItVFAYt+/ueem29u5RRBWGKKVb/wEmoj2QlgXoncZDuBe7sHY2+mO9KYLJQkzMyP
         eZzNV/8pcDHq3R1KiUYE5q4288oLsAtCZCxriuDmXBAyNDhifmb+sHXOEmyYaL22lye2
         BMRteaBReo5RF62tMgo4B/Fz0XbfFvMDQqUJBYYrxNMBbIc0v5bNJQh42DHKyBp4+gev
         EPWOPkGDeGFMIo+IqbnsjD4/JzZJmej3g8N9b4AvPsvs9jJVId27rbMrogTfmo7xAwdr
         2akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785536593; x=1786141393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
        b=fnxBcUw5RsV7CtMMkvA4oUboTRUe1zqVcsQbcWyJ9RsaXKlm/IUciQQF1b1i9mM+ob
         gBWQQPH92Arn1x6k8TR17wkGs4mk2E7WhyaB5k+rA7Bl+RWDhev845xy4A9cwFbidfEG
         mhpHtZfGsWkdXyL6iRwFTbk1U7OAYHU6PIT8leEatF2LIFPcIsHQFvZnr3vFoXkd6N2K
         /pHghQfPFU/T5Kq7lem1u8O01EAX+RZG4xhi8iGKLnGt4toBFGzzNOu4xRdPjLC7c0WV
         /QwYeHDLs8/p+gMYSQktJ+A3ATWsaZsFRMxdvn2lJUgHbD5te4nvvpVyQmWR8DPEwSuq
         /YmA==
X-Forwarded-Encrypted: i=1; AHgh+Rqlm4KIwuNvhj6YBmrsxBzgvK56P4NHxwe6BgiaFl2LPILqrbg7viEYOY9Z8uuzv43XA30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyht+oJg+uF7ROSrS7sCc6uAuMFXL0Kr9AyGfLrdVMV9q41nJ/f
	eHgwcDhbO+wEP5oBfDLCFjWCDfYUe0ZrdY/gRkfwdkskteQzlW6/BBzDHmIGMTSlDpZNpLyeOwU
	ryZ22T2ADBFDK+RpzVCSY8yRv/6+SXSAo7JmcG2ow
X-Gm-Gg: AR+sD13XGiCtJ6d3yp87wqsDr+Ot2y2bs966EunrmgAoj3xqoxRB2aKR7OvFz5qvtlb
	EMm0+RdrViJL9seO406a449Bi/vOYmYYSCoUW2PlsSuPTYT3UfnscyS6JftyqB37ggnIGAztUi6
	3jJmoJ7SE9YS4K4MbrvYBdAQal3f/Zg08fJwwZOtvj4PvEGsykdboHsXFU+zmimGMSpdUjMqCk1
	9wUoLxz9X3SEf+ioWiXJlTqTmIlBYwfeE/AMCjlBdRTa4o912PUh+Qu8vo6Fy/hgnY3bsfljTiC
	7TOhB+u2aeNZsLOMviT97ixudhu989QfwrG4R+XN4xyi
X-Received: by 2002:a05:6a20:e20f:b0:3c3:c3fb:2473 with SMTP id
 adf61e73a8af0-3c92a53cb12mr1339830637.20.1785536593141; Fri, 31 Jul 2026
 15:23:13 -0700 (PDT)
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
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
In-Reply-To: <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 18:23:01 -0400
X-Gm-Features: AUfX_myDvAP-mn0LUSqkiSdO37b1-jlQ3lFWXPwWxDYV3yXxAuKFWzBHOxeX2Yo
Message-ID: <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
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

On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> >> > <memxor@gmail.com> wrote:
> >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwived=
i
> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwi=
vedi
> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya=
 Dwivedi
> >> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartik=
eya Dwivedi
> >> >> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor w=
rote:
> >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moor=
e <paul@paul-moore.com> wrote:

...

> As a consequence, everyone suffers because they first need to satisfy you=
r whims
> on how all code and kfuncs written thus far are wrong, and need to be mov=
ed
> around ASAP, including the one being proposed.

That's not a reasonble or truthful summary of things, I've only
requested that David locate his proposed kfunc in
security/bpf_lsm_kfuncs.c, I never suggested he move any others.

--=20
paul-moore.com
