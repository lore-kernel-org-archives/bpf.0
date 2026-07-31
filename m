Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786C453A24
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523334; cv=pass; b=toXhilHswQDt2l4SThllpc/6TBnhni5So0KRceZ195YAEPQO0gECcLVIKcRchI5+QOLkDRWH1wq+PANlGb/f8AZc3GvMsn6OZ1ceomV+l5lozNVvhirYM3suPOvD9FOWKvskrAflbmiTSbNmJ1WwCYTpq8tizKd9b0Oagd35Rro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523334; c=relaxed/simple;
	bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNKyI78DcQn7ZgBLsOCmiJ9gpHXydX6a1sx0QQL6XifTofD6iOMwX6T0w8lZfWmjJrKZ+q+N1Z5JCCgXg/KOnDbt6ezmAGpFhVNZK+fiuD/JRIyIqK0nlfiLuAj9AfpEP8LJoCXwijgv4H7N+DrafcIzys1BHailyB8+RfSpmOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RnJTn1gs; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RnJTn1gs"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbb973e6749so1479107a12.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 11:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785523332; cv=none;
        d=google.com; s=arc-20260327;
        b=bIri3HtBI3Ng6KPEH2GYxjhSjKBpyRFTBfls9hxUEzLBgYsZBlKnC0GLxOR/66nwUn
         38Ps7QYLKAO0MDn6UVdFpewx5VHl8w9yWe6Qpb+dm+LqBhZ0eOmaqFfO2TACXIYtpd5N
         8wYvuY+vU1g4SUaRKmiANLNnerH5Yn4YM9dp6V6Xf8//uRY0Yp9a4sA8yTCdbdYBJmRd
         j8ryaxooOgr6nVIiKaeaX8CfYfQqCgL8YqBtZTgjUmlMgOtBMCtgkB8d3LqeO6CjmKtu
         2YsdduLSY4Zh4nWF/z+OPZkENZ0nuG8wH7gO/crB9oDfC7VB18FpvOet3S8XUMhd7Whd
         QEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        fh=srHm2BfhUD3KlfSZ/32JlffZK92MgLMWYt3vk61FwgQ=;
        b=Xxu+y63jlYR7sAs8j9GiDZ0yUryF64toUWC3hldwg/HKpbCtfleHhIXbPq3IHoxo2z
         G/e0xp6gFgj1nMCHlwBT8/xZjMXZnsTh6/Xh2vtaUwcDSEEyzq6ElHK5LglQyiyejyd3
         EqQ42aPPpOnBiUIO4f5g0l+FJ9lR/+7rEX+kFgxwWViuVQWSerjcAJuj4xf95H0RL4Rj
         rEHbVD7jVRM6g5hlS8TO9u+6g/PKf4KBd4qJmoOGPN8IriMW+fScakq7AFuAxVB8WXym
         QY8/sV39YETKssgDie0esTzEdLQ3J9ljCNOTxbR9OFQZ3ChfmhCdjwNm0O9a8U3i4Lcw
         hjEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785523332; x=1786128132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        b=RnJTn1gsg8Uvh+FH/JN6RNrus99YZFL8IUWO8gsTbGhi7g5TdULCt76g6yFSun3eam
         /fzTn46vxP0Z0X2fnq7JigzVRr/xdX/XHA70QC1cy6h1utGmvhKCDLCFoQ/RNBGOckvg
         97y1yBejqtJ65K2/0EWVzZaebgnnON2raioNwo1ai9KoWhm+MWWt5xCgxgPjfqBM7qFe
         QNakghMFv/aMxbH4adDhNvmjTErcD+whz8nvTCoYiABhrlNcPPUHkFIIUASoypBphT6V
         5dD86q/GjkETaPz+Oh4RXhVxtcD3gzD/ealPGd28IbQNTXDVihOUC/6CdXG8SsU4bL+x
         ODBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523332; x=1786128132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        b=KhU5mgf5lcBaPcDEJOQOHFXkLVJfin31Mp1nODEBnADWzzF6MePyZnnA0xNagMVMQ+
         NQTAsKeAQoFDarZCenW8/X4kEB243vve4UAcD9HTqx3KeovcFyToG4k8VjkNlsVZZ0N+
         M7qmpynVHYNcssxY3H1zkW9i6J/SvwsNXSWYH5IAijNo8PbdJeU6NeoOtAMLArcYeX+/
         IRxc/XKeOnx1LZOW0C7flEHuNsJdzmrOQpR2vdK9n5gzqdvx4FM+gIl6Ud5l4J75MfaO
         +jmPBw1UEDHmI2lFeiSeSyfUSWbxDS7HhEznxXGgb/NxN+sQR1yJZI9zVUBfpqSEtqy4
         YMqw==
X-Forwarded-Encrypted: i=1; AHgh+RrLKznuCqtrZ3Ypj4RQ4dnScDMguonkrnjciVmmszAKfk0rKgVdzdAsQPhMp9sM8SSjT2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAlIbyit6V/4mzhLyHiBG8uybWO1XR5ZyLz1WXYWgZnGTrFNZ
	mQTnH9ChRukVA5kJ7Qan1Lc0YAXoKCU94/HS4J/LDKtNr3p+AaqlFzuVfTpqdtxgIv8V2JKT4dv
	g+bAf8a0ltUp5Od2sLgMRnv9t/1fwmbBIVL/OdhPc
X-Gm-Gg: AR+sD10ClQfP12RhHpAWfF3zRu88yBXiJHAU/9qXg7uzaNtaqEu8WbAjQCrCrcSfeVF
	tJZ6NvTTUUwdpnOGHxpTsHlZNPA7yVUfag+8XvK+YOQX91yommsYX/ZXj7Ln3KwXAVVlkXSIXOQ
	HCMTHJEZVO7YoNuspJ1qIu2AziwlC9jdKwmrv7H5kN+0kRU/Oo3T9Ypc30tq5Z+Ieg1LxyV30M/
	PVUxD+2TkcuGUu8J0Surr/W7xHFUyQEoDaGe4NmG0YTUuRF4iJERZgRRDcQQY95X7lSpmpusME0
	3ghJ48yOIuodZU3GUCqUaIe2HpGLsS+EIGvP6d6iltWEMp+zPOLxVzI=
X-Received: by 2002:a05:6300:2208:b0:3c3:ab31:3d1e with SMTP id
 adf61e73a8af0-3c92a8d3125mr777248637.56.1785523332205; Fri, 31 Jul 2026
 11:42:12 -0700 (PDT)
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
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
In-Reply-To: <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 14:42:00 -0400
X-Gm-Features: AUfX_mxuliCX4ORjmGWbiior9WDlNPKrwS-oHeLLni0oyboDwl_jDraty6suaKI
Message-ID: <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-mo=
ore.com> wrote:

...

> Yes, I understand you feel it should be placed under security/. You are e=
ntitled
> to your opinion.
>
> No, I do not think the newly added kfunc is a big enough layering violati=
on such
> that we need to do it ASAP, disregarding everything else outlined above. =
I am
> sure you see that too. There are several other instances of similar kfunc=
s.
>
> Therefore, please attempt to meet me halfway here.

I'm happy to work with you, and/or anyone else, who wants to work on
finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c.

--=20
paul-moore.com
