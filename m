Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1A47DD44
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523848; cv=none; b=PnLArPqJVA3SI8mGlXbNpLScmssk9Gp7W8/947zgGaIzAfvN/93TMPYFP9yVqVB2U4eMqS1+iYgcMT0/0CXKy8NmtLW0UymYWpI3EvTaSmfzJSA3sz1+AAjKkr8myhYnAWV6+eALeB8A8/PNOoEOWq5VkFr0Ol5eNPNiDQguSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523848; c=relaxed/simple;
	bh=rNSgybq+EC4StYKEvWW6N9mV5/JG+X6iCipGDYsDyAo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=W1JrCO78Gqw4Afeq5wx9tiCZGDEqGf4+a3M+bx+qAFo7AoIhMwJPKomy0G5/seXdqdh68LEgbkwFz+piNLG730y7a3vD3rc9hYDDxhA4X4ygWgjbNlTmlOX8MSAt784sSvEAVLMvDNig1mNbs9/UY1pHy1d7PjoOYwSMhZGR2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lla4kMeS; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lla4kMeS"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so372942f8f.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785523845; x=1786128645; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rNSgybq+EC4StYKEvWW6N9mV5/JG+X6iCipGDYsDyAo=;
        b=Lla4kMeSwb1aRASQHA6OqAznb9OQ1+LmN9z9/3LN2wfQM5ggl/5b/+9Bcn51wZziyV
         nQgA1fhNLzXKilbNgD1B/nAkNhGCpzkh1P6JSs1dcdfy0LX/yNuivIZ6Vj0JPdQgqfAF
         YoNfutpa+7MCRfwGXxt1b19w+jfkRM2Iw8CL+Ct2rjfus7qYqyFihMQc80KUbYSPuXZO
         Ovwf8QV8eijEwCO/VAkq3bap7PRJhwW5SsvoAv1yuPRDQ3O/d8blnxd96K/hk7baYk4K
         oNsTYLO9yuIioNX0ot0UpeU6sGIta8lnNT6Blok4h53+Zz9TQIN/vPXD+KUR0rCN4HT5
         i4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523845; x=1786128645;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNSgybq+EC4StYKEvWW6N9mV5/JG+X6iCipGDYsDyAo=;
        b=dk2VS3L3VFXTiibYj/uMW6SRSqv+dfWGpGDCWz16zt7Ys0/q67P9kdkNdR5j9Mtz9z
         bf/DdQQ6W1Lgm0x5KoGPgSq5j+Vv/EBdeeZGRdrM0/eiJgqVJOL19o1Kkd31L+V13uuI
         gXkgfJqXqIVYcIb6bNMC49mrZwmSXDktLf9sHKsKEJc6w4G/LfP3UwKywifl1Pn85IYA
         3fzAtEG/iuzyfbimMgzwcQhe1F/9/UC8fIsTZVUIaxsQCXZxXoQuLZW59g9JfZjOkqyu
         S3aRdrr8AUn1iSfROOepl496oKi4QKrRYp0OcXHuL0LBFu4y91w4gY9wWLQCcQ/4bEgK
         nzVg==
X-Forwarded-Encrypted: i=1; AHgh+Rrg1zxWkIiw+j/94VZJ0fcAQ31J5C1JQ2cqZt2Q3vN2ZWv79+tklGx8FXDWKjv8Eli/43c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5nP4btJGt6epi15fqDxm5DgEVjlChJk54lS23sfexVTWgKZ7N
	BPpKGrKQv+9jtYjfSke/4OGDrv4b5rh6g1CjzPNcKuurED8+LBc68Hp2
X-Gm-Gg: AR+sD116XQsHSujVKvfcYJ62+alQluJIXcPylEodMapjRpMVw/QJhy7KP9+lxnkwTwH
	IwkXdI8rfGNlvT3P9p/axtafccCphD+V/ZM+ZSg76oPvWS1WmFITMzo86Puvza/1He8WKCreQRm
	ulv+WZ5HNl43UXpF0b1qmFyZ+dObJ12zodUVGOX7F6B8CaDzsC+VFVmNo7sn8zqqXiNysaOJws+
	4NInhBGt7qNdJ4UkoB3v67sXsMkYBmlgmbX0L8HlJKCpSbo6uOtJ8EyYm7rytVuK4kFpIdC8jK3
	YtJ7n0BGQSggQyCguMlSNQvxfakGsnqsoKTQOs/EHv6+eZNt7XVO7Z06NmerZL8l3ju+KzUCIFp
	yIbS/qIP7rK4hevgJISAOFkyfWE7g0qhUahqAzX0WnLCxP0z2Ta15g+ye5aukG1TODukUJ5ChCF
	DzIwoD3jiMBm//NVeaQUDXFrHwZystZjS5D2LrYD4nUYVusjZr/mcjJGgwuLWtFtkaY5sxzhXoi
	PqOrQXPveNMBGFTlLpUQiPK+EQ3TZMqDeIr9yghSYR6gMWkqMizrnl6US5pO2/Bky+dlY0Ae5MP
	7Hylp2VO5AOYYNhynRNPaVkvvhQ=
X-Received: by 2002:a5d:5307:0:b0:47f:48cb:ea5b with SMTP id ffacd0b85a97d-47fd72fb87dmr1338696f8f.43.1785523844695;
        Fri, 31 Jul 2026 11:50:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2484sm8232834f8f.11.2026.07.31.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 20:50:43 +0200
Message-Id: <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
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
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
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
In-Reply-To: <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>

On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
>> > <memxor@gmail.com> wrote:
>> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
>> >> > <memxor@gmail.com> wrote:
>> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
>> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-m=
oore.com> wrote:
>
> ...
>
>> Yes, I understand you feel it should be placed under security/. You are =
entitled
>> to your opinion.
>>
>> No, I do not think the newly added kfunc is a big enough layering violat=
ion such
>> that we need to do it ASAP, disregarding everything else outlined above.=
 I am
>> sure you see that too. There are several other instances of similar kfun=
cs.
>>
>> Therefore, please attempt to meet me halfway here.
>
> I'm happy to work with you, and/or anyone else, who wants to work on
> finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c.

Right, and for that file to exist, you need to get everyone (FS, BPF folks)=
 to
agree on whether placing all such kfuncs there makes sense. It is not for b=
oth
of us to decide on our own. So let's revisit this whole topic once you've d=
one
that exercise.
