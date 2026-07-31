Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F73E009C
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512680; cv=none; b=unrpFwjn/g47xOfGk7dY3A7KYaJMAEME+bWxc385iRc4xxT1X74348PBP/0XcWb9jLCeKeFEiVESN+uEmBdMertgCs6IaTLEgWFKjO1o9ESii37LLAFHSN9ww5dGE2M98W9RMUBNUiEGZsc1fOsFmFKQhPQnwPx54K/Te9SAw+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512680; c=relaxed/simple;
	bh=3TMU74QWZoDLOURmJXG/MdRKhkJLQUmMeQBO4XyQ9QI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ir0A6oRaUtPaz0OpMGaTwI+r64eXFyLD+arQ7AkJoP9R/6YZVo6kEwNWs9vtzOr+2NNyOAh8KBUxo9+TmdD/WJpvryoMsfwIhniIUDI878nCwBaJ9YOI2rp9DlZzOWnJEcg4ZhJHx613DoRGDOwcePNcmn3SvQnRfZHrqKv8238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUAjuzik; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUAjuzik"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f4c92d1b3so310397f8f.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785512677; x=1786117477; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3TMU74QWZoDLOURmJXG/MdRKhkJLQUmMeQBO4XyQ9QI=;
        b=BUAjuziks1o6IcLjjnCNTj5ZPOZq1/j9neEAYN+xFL8YvZJ0GabVQuFG+cbmrX1GkQ
         /HD7ej+ToDjie5K4/X3LT7FTVDTBUetjvyHN2PELc2rOSvdxHOFR7oGdotXmCpZI5SVt
         NJiNy4ozrOkKt28Ma8f+6NI11frL1BRQMPC63a9yclHwLR8PnVA/tQrLAp89RWTGAi/X
         dfXdGUA57Rq+lVKKu7SLl4hvArDlAsmwa5AVfNSzepQFd/0fJp1mrELZSKJ6M8U0A3FM
         iSPSp8HSZ6MYbAkuQejlwnvCUKRRk9c0wG5kEXDwR/h0fAfnPe271m5pmCOQ/p9kqsV+
         JtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512677; x=1786117477;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TMU74QWZoDLOURmJXG/MdRKhkJLQUmMeQBO4XyQ9QI=;
        b=ju1Gn8M6ZkIRpt2/8+amSa3Q37FOZPqpzQO3S8dUMSa4C2OMj8Fhu/b0ebN8gW+uLZ
         WYRjQKlHDMUxx0+njZV4pUStkpE61371rqysbanfIP1ujf9WXsIIIx4+ECSVRsYK9lt2
         SO5t+m93YBTehGXqjXgzO3iqZLRUNLGQvfZBPuK31QFNv0MGunIsaQ2slDgeVDCg8Mcw
         GjWoF2hcuX2ymU5QwBepnckgobXn0TdduQXyuzrtMUI3u2s8QiTJqFduqcDRyv7SMKI5
         0ZIj9uPxllHUNvGMLD2inT4k2bHWaigLOIAJwFFDVcYrqF8BG3g7qhUQ7QMiyhNAMqWH
         HoWA==
X-Forwarded-Encrypted: i=1; AHgh+RqGFfhH+HfFogbj2z6fdoOYqcFw6ffDuZvVL4YmcWJi5jLl5zYazWdT71xLzrpA6PmH0c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpqnY9K9AsCKz735fsVvQk7Vrx3tfBSTqdFV06Yfxj3PoKHYPP
	G4HR1BOkFRPHK9PxYIyFzQCFWdOgW3kLxZx1P6G+CvK8BPZ9ksjdNrwA
X-Gm-Gg: AR+sD10OOp2DIP0Ei0aKwYl4Ree8e4qEZQv+IXpgZRDKq02OY8eOLJwbrHCJQyMXbR9
	s0VRzGzWmUFbc4ibsN3T7JSPUHI5UqGNGlBrlHFCTD57/TcoNEKBYSFv9PEPIJlHZze2vwJQ5is
	ORDKdks/AlkG+NjyEOT9UjMiqIMpwCU8bGeHYw2jVRWFEsM+d2sL4cz6OR+FYyZPd1E3rAqA7xf
	YmSZkB323ZrNhN0xykeIDd8QB0sa4D7OPaG1OrVxuyXkMOQ7pHbshwQrLagOQK7Hf5ae9jdtbwM
	Ldb1+saqfL2Yx8iAffjib01MBWNxEVycIBkjzs6/VW/e0bBBEL7nnJeNSEnInhJb8I+XivzRadU
	HBjGsqxkH4eN3vOxu7YUI4+2UGQX7cFpeY0qIqzysRFNPxihYjtZ/pE7ykH2874Dgg+f00rW0cV
	rTWSsvIeYW82T/yBAOBj598GcUJevwAFY17YvB9mz0OqDw+z6takkupD2Ip+GFxDtar0zMQ73Xd
	5W8/YYpxsoM/DgMX9+c/a6Df4vWTbIN+VNj1dILQlmLXLAu1e4iTTGeg35DB8TJklVeT8WWWUc/
	w+LDMRuuxnmok/XpuFq5IAy3tww=
X-Received: by 2002:a05:6000:4615:b0:47f:918b:fa07 with SMTP id ffacd0b85a97d-47fd72d4500mr253409f8f.22.1785512676702;
        Fri, 31 Jul 2026 08:44:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a5a4sm6264702f8f.20.2026.07.31.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 17:44:35 +0200
Message-Id: <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Matt Bobrowski" <mattbobrowski@google.com>, "James
 Morris" <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, "Stephen Smalley"
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
To: "David Windsor" <dwindsor@gmail.com>, "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
In-Reply-To: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>

On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
>>
>>
>> Okay, it looks like there was some confusion/misunderstanding.
>>
>> My understanding of Kumar's comments was that he was referring to the
>> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
>> not necessarily the new kfunc you are proposing in this patchset.
>> Kumar is welcome to correct either one or both of us, if we read that
>> wrong :)
>>
>
> Yes, after another reading, that does appear to be the case =3D).
>
> We'll need v7 anyway to fix the ocfs-related UAF the bot found.
>

Since there is confusion, let me clear it up.

I meant it for all of them. I don't think it makes sense to keep this one i=
n
security/ when others are in fs/bpf_fs_kfuncs.c. That confusing limbo state=
 is
worse than just placing it where others already are.

As I already said, the discussion around whether all of them they should go=
 in
security/ is orthogonal and should be done separately; it isn't productive =
to
repeatedly bring it up in the context of this patch set.

I honestly don't get the urgency; it will be a mechanical change if we need=
 to
make such changes. The worst outcome would be stalling David's work over it=
.

As for landing this stuff, we can let Paul take the patches touching securi=
ty/
and route the rest (3-4) through bpf-next after the merge window. We need t=
hem
to go through BPF CI anyway to ensure nothing breaks.

>> However, regardless of Kumar's intent, speaking as the LSM maintainer,
>> my stance on this is that the kfunc you are proposing must live in
>> security/bpf_lsm_kfuncs.c to be acceptable.
>>
>
> Ack, will do this in v7.
>
> The Landlock series currently up for discussion [1] is proposing
> placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
> go there?
>
> [1] https://lore.kernel.org/bpf/20260731022047.189137-1-utilityemal77@gma=
il.com/
>
>> --
>> paul-moore.com

