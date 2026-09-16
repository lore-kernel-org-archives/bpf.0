Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C61F3DEFF0
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581795; cv=none; b=t0z8lRcnhxTegu0x9q75LKHSvd4YCZIimtI+gNN+2L4OVeQW2/7sjNQpkMmFSoqsh8k2kI2g5rMaZ5jS5dA0CsvGbRXlAYsqCi1e4jUS8goeUwslLhdqtsObx/GHG/6PAV3KnG7Fj3yHMSzyBGw2otiduHOELRjBjENQy/igjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581795; c=relaxed/simple;
	bh=27Obz6IWJZjv81xNpwFQV3Q4Yjfl5dy4rzmGKCz63H8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XMDJcIcpSM4MdQeAmci4/wbUChDbW8A0w6nbHuE+H9C2x3Z/ISsG/JHXLBNDnhmqqkFDrVSUfkAp36wZCXJq7/sc+qWOLbZ1K/7KPXnwU4UmVa7nBybif6m4AlxzsQ2Shr3s1VAZHTcOFjYcB1BK9W/+eOCoZTHZ0C77/8sSpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYKOAjW3; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYKOAjW3"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b35611so813348b3a.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789581787; x=1790186587; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=27Obz6IWJZjv81xNpwFQV3Q4Yjfl5dy4rzmGKCz63H8=;
        b=hYKOAjW3enw1Id5SKRcSYafe/7om9uLHovCWF7+MtXH/EWQ2M9zwFRZUrY3oHwK6Dz
         /WZ0LipIsMtio9QKaZojUOW3cKyOr8kyC7q6r8tN5m381WHi8Z5pVhEWOOu4j2NzPrvC
         vNx9lBo2Kca67TPhBZWtbSlnPsobnqtk9sC2F/6uDWitc3cCryJD+1hWbQSONEh9lrWV
         GbC2TBa7XlheyWGLkz5dFaxAGOTk7lKVEg04vqvEMT18N3tkW4KokcUdfm71P5xLKwtC
         Z54bOdim+6F99FW9WoS92aOSaYEbYxMWUgJBvNy3oRJJEPWKplCwk5hyP42dkz+kOKax
         CRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789581788; x=1790186588;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27Obz6IWJZjv81xNpwFQV3Q4Yjfl5dy4rzmGKCz63H8=;
        b=YnN1qkiXMBuC5t4icy0YRKSm26GbYlBtbLinYijcWRVvy1emgzxUMY/o02YFxeVt4p
         J+mtm/shglsqOI4Po+WP9rSTE+4golbnoNm3t/LW3MM1wNUeq/e1msqqwMvIYy8sG7AY
         LJ2U38yWeBrNHKYTFIRxzxRL2Heom1g8I7qAV97bkH8kRrZ0jzPjCp+/puJW1LgBz6DM
         w0zwabVuyjiF8vmCrAxhDkiUH6ytxreRwcDM6EaVLYmp/PdCOAMNsKWYxi+cIXVokA4A
         QNWCspRkcPR+MPkzHOWeaeC50ZoTEmMY8xhiW6JZghKDupQHbzHgTYTmp937WfMZen3j
         4Bjg==
X-Gm-Message-State: AFuF++kGM2tHS/68YM8KRvTCDrV5I2D+xbht1+0PxOWwSPIrECPYjcRN
	Fso1YzEX7D3w5SUEkpNWNuFDy3clj5oucjNLazdazqTL47crhUsXW6nd
X-Gm-Gg: AYBFou1kG7oKeGm4jeMB0fqluWLovkcdtLQcybXWcBDd3l78SAI0/1t46mQZ2kzclHt
	QZJtUCleGTKUFh5RvFIR+XA0Yk33ZmVltQBoSPUPOfXUPJuXSnc21XG4+WxZLRkq0VryADrgPwr
	kZwBNSoY4tdl3gBRKwjMsMPaOwjzV/L+Fb8UVoPtenU4WDqvjWfFBPTu8KBj/D2DMRrBx59+GFf
	LoQLUSMwdD4l1v/TKjOaFQTz+OICUSVzSyGUvB1+o8nL7k+/qUOBZd1BHvkJdLgVMLeu8U52DpC
	sosGJ4HOEAZeOKeqzV1IqdOTbN2aqKMld09TCwctf4vty1gAZC8ja8v2mAwl5iyeMbyw7O6dRVO
	8C1elhgC77nSkTnPBNnsbHK84cbi6Ldj5RGqGkJTsETUgJe+Z+4fauRqNqdC/iE4yPH9Qhw0TqB
	WNqOYpNZI2KUkx9NGmXvv8eLce6e9fLhYjgVCXH3k1CZ4r73RVYN4ckSKuFvJdpPwOADOwoA2bs
	EWP7WSymoaJqa+V5a3+d2wU8IDjwKwjBNEXsxA6QmZF0572HQjUl3Ua0EdXrxWrP3uI5Yt/U9+x
	5pVp0yGVwzIJUr3XVymVmgIONUVbCIqKd+XGlpUws0iE2qQhlEUdbD2166lz3067B44=
X-Received: by 2002:a05:6a21:7d01:b0:3d3:ad3c:49a5 with SMTP id adf61e73a8af0-3dd5f73c983mr8648332637.19.1789581787395;
        Wed, 16 Sep 2026 11:03:07 -0700 (PDT)
Received: from localhost (ec2-35-83-186-167.us-west-2.compute.amazonaws.com. [35.83.186.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8720123e374sm1634714b3a.24.2026.09.16.11.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 11:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 18:03:06 +0000
Message-Id: <DLGXSR1YQPQS.3SMAU8ECAYUW1@gmail.com>
To: "Florent Revest" <florent.revest@linux.dev>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "KP Singh"
 <kpsingh@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Leon
 Hwang" <leon.hwang@linux.dev>, "Junseo Lim" <zirajs7@gmail.com>, "Sechang
 Lim" <rhkrqnwk98@gmail.com>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu
 Kuohai" <xukuohai@huaweicloud.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 "Hari Bathini" <hbathini@linux.ibm.com>, "Christophe Leroy"
 <chleroy@kernel.org>, "Naveen N Rao" <naveen@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Pu Lehui"
 <pulehui@huawei.com>, "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Hengqi Chen"
 <hengqi.chen@gmail.com>, "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] bpf: Skip detached progs in trampoline
 images that are still in use
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260912095924.866254-1-florent.revest@linux.dev>
 <20260912095924.866254-2-florent.revest@linux.dev>
 <DLDHKKLCOAVR.3PHQ832S121Q2@gmail.com>
 <DLG3Y32QQ9JU.3LNSYXLJIGH17@linux.dev>
 <CAADnVQL=sW1-UOUbP_j98G2eY4MPzQd=HbP-7q5-sjqFQya=Rw@mail.gmail.com>
 <DLGKT6Z7ULBJ.3SKG7CYVTUAJF@linux.dev>
In-Reply-To: <DLGKT6Z7ULBJ.3SKG7CYVTUAJF@linux.dev>

On Wed Sep 16, 2026 at 7:52 AM UTC, Florent Revest wrote:
> On Wed Sep 16, 2026 at 5:29 AM UTC, Alexei Starovoitov wrote:
> > On Tue, Sep 15, 2026 at 11:39=E2=80=AFAM Florent Revest
> > <florent.revest@linux.dev> wrote:
> > >
> > >
> > > Ah yeah, I tried to address that in the cover letter. Basically, if w=
e patch
> > > all the nops, tasks running in the old image could skip some progs th=
at are
> > > still attached. For fexit, that's already what happens with ip_after_=
call but
> > > for fmod_ret it would be new and this would cause for example an LSM =
prog's
> > > verdict to get skipped when another prog gets attached to the same ho=
ok. That's
> > > why I thought that patching only the detached prog's nop would be bet=
ter and
> > > needed these extra pointers. But it's a bit of an edge case and I don=
't have a
> > > strong opinion on it.
> >
> > Hmm. Not sure I agree with your reasoning.
> > fmod_ret progs are called _before_ orig_call.
> > So fentry+fmod_ret are in the same category.
> > Adding/removing a prog to the trampoline causes regeneration
> > of the trampoline.
> > So cpus may execute different numbers of progs already.
> > The race is inevitable.
> > With 'patch all nops in old tramp' approach the only
> > additional race is some of the fentry/fmod_ret progs
> > will get skipped in old tramp.
> >
> > If the concern of a tiny window where old tramp is started
> > to be destroyed, then fentry prog is called and we patched
> > another fentry, but tramp will continue and execute orig_call,
> > then, yes, I see the issue, but it's a lot more subtle.
> > If I understood the concern correctly then let's add
> > another 'jump over the call' nop in addition to
> > 'patch nops in front of all progs' and
> > let's patch 'jump over the call' _first_.
> > This way fentry/fmod_ret progs can never miss
> > execution of orig_call. They can be invoked "unncessarily".
> > They may execute though orig_call will not fire.
> > but that's an acceptable race. Better than not executing
> > fmod_ret while letting orig_call to go through.
> >
> > This is still simpler implementation than link-list all all extra book =
keeping.
>
> My concern wasn't orig_call running but rather progs that are still attac=
hed
> getting skipped. Say, fentry progs A and B are attached to a function and=
 a
> task is sleeping in A. Someone attaches C, the old image gets all its nop=
s
> patched, the task wakes up and skips B even though B was never detached.

so ? the orig call will also be patched and will be skipped.
So no observable difference from B pov.

> But it's a narrow window and it needs an attach/detach on that function t=
o race
> with, so if you're OK with that behavior I'll respin v3 with your simpler
> version.

I don't think above scenario is anything to be concerned about.
So yeah. let's go with simpler solution.
