Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF354582DE
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524752; cv=pass; b=d4grWWqTfa43HbkSWB43Y24nZIc07c+H3iEZJEk1k40LU9JoT+8LF3MLbbYRSsRZyWEFFD8C894omy397m7uzwQZdc9h0ZQ2CsDKLJzqfvFyFwcCAeFlpNlnORKdFb9Cdd6mFcgZhv6kqIkGmJFChXtljmr1+JYu7AS9hiW7kh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524752; c=relaxed/simple;
	bh=yYMvOLG38w4orK+MApkA+zLYeQLhs8q2VGY6o9e0R70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvF/4/WVZkUU0b1OngX9/U3V8kkV02JwgkDYGbe3oTLFZ5cE3ghmrrew39kw2UDzn1p8Epm3nIayB45iBweRR1LFscMByFalB5J+pYLoVwf9TpdyzlwCp9zFu4Nz1bVRkz1FDA66En66TNkPw7Ykx72Gr51koocaRHZg/Q4tmGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JHsniNAR; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JHsniNAR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so16406365ad.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 12:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785524750; cv=none;
        d=google.com; s=arc-20260327;
        b=U8COj8NXYg3F+dIoqg4iiQmenUg6WohuuIchr6+8pbAlEX5bVR4M9gLxOC6ZJpWk6k
         rMyEI2O1JXfLnFICTCh5IroyBlS4/wT9SxfzWQ7SXJgaQEYvrK3iShF3ThQ4tzMyN8p+
         Z/NKhYHh9/uQOV39e/dS/O/1juGwbvYptyYrtXJzEiDHzO4GadaLS+oUZTqItuhc9NSV
         56okm7t/D+6EVX20MFjD7+yJdr5uLfuYa/pgt8gqbNIWRI139rbuXDRFvDkn7eQawfk5
         pWm+W/wB5K336GrcHmaSL/qkunt6cNgOnBWln+hE3TRqBNpMRlg5FxY6+/QnEaeshzLU
         IAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zCFFdTFE+G8fjImWxQnVKNrepHGR6cvlOP2Q22SYkCE=;
        fh=3rH+Lrr39olgCHTNJlj4s6e4qZhM5sJ7Lrg9UuwhKxc=;
        b=n8skIhvTvCT3CqE6e73+kVa3dhOYKFRXI8j53l+9uFfGkh9JNmL6TLHjPdz3uwMfA5
         FFYPHAoqaD50Ae5TOJzRKgeRmr+vkarRuURvq4morkYbk6I9wl1qL0IdsqIT8dknMM1l
         B0BBUaD9B1fxnT0oeZmnWywYG4oWk62FZL11IpziKY5xhw9lAt/J8mYC5m3sXxk5fSYz
         SiSGb2oo5SV2zuwAF8L04Idpc+HsQhnbdgfA/vADG/IbUrQoNf3eDJ/XXEDvxQdYrITJ
         nRRne9o2BkxLWbldzEXXAbUp3kRu3PhQ7jOQ3CMdO94yRg8igcL8X6AC6i6ycIY72M75
         OB/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785524750; x=1786129550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zCFFdTFE+G8fjImWxQnVKNrepHGR6cvlOP2Q22SYkCE=;
        b=JHsniNARppQyfJeOgEgBJvYYzu8PxccLQtymddShLvf8oyb5pRRaNbSXotDjNhau36
         +hBb3nubmbuoMpB9/XVN4ELIDLMy/ArNYL1yWJZ6ROnOokG3T/hGs8z+mwcLKfZRxmuS
         ek8A/9RDiZY1h/u+1sYJwSz7awEGiAw2eHh2nwLf3vRTGy37vuRAiZFN/+z3r5QT7NMI
         MbxoxWNq5djA1Z2XkI1LGRxpyeZ+cGTKSO8Zn0Oq6B1QdNcbcbj8BzClTNxHEtvSzjGe
         7anGUu34U3LKcW/bI9SDCerAiIAFR5cMQ9DrPeN9ENL9qZSiwPiRnqduKgyRQhK6QM4l
         E7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785524750; x=1786129550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCFFdTFE+G8fjImWxQnVKNrepHGR6cvlOP2Q22SYkCE=;
        b=i3qFMnxubKzH1nr4hMSIwOn1AnRlM7RYlHcabXjKkgFxfi2PYO8cc93x3PBlZ7P4Sy
         /GjgW+c4vvKYRodvIF3Ne1KdVMRAUEcnZr2/lwD0pT5L/QZSRvoZGJHAdGwHKtfB3nb0
         0k+fCdhq+9qKddM4uytTLrlTEhyxaVaVAzfgsb8j3tltru2VpeL2zcD0tCeook7Zx+37
         VLOwaW7PkHqmLlgXdj6xUyxc0pc201kFLm+STHEW3qrjhajxNBpXSijCNMVgdzRBS0kJ
         v1jwKSP7HIsr7SmsFdyxspv3h2Cn5Ynhjq9pnU7/SsR84tRbybmciqB4HGFGWMTxlIxR
         czMw==
X-Forwarded-Encrypted: i=1; AHgh+RoXPyZ34Ekq2Qee0ZoMKSzuMbZBPbIsY6V4qVlvdk7xwncjewNyiDqQxIuKWv1DMsmK6Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3jcEK7HkkGNAtnDBqcx4j05zvDiV4WVxrsUWrgbUWJinNRYS
	A/WkvHUrXYtD6F4awJbArsm+8tpJJIKmW2XTjfXhhAI+Dniw/3hwXYmclKEf+FnvSMvQMpLZdNQ
	W8SyClobvk5xDVCsU5ERlAaWOgvAADa5OTq1Q09+oYGfeMW7CVvbnKequlro=
X-Gm-Gg: AR+sD10w4OOOR5+fZL5nDkiN3CHq55KqyBl3Wh2kFLWD7uwjBEqpLIXH9nnZcoAxSUv
	R3v7Am0ib/ahmJjsOM+JcnsMeQOBZgfRxuTYmCcnbiuT7HE5LEy8d2OsROkTP4UQp3SBJmIU1eI
	EQLnaOA6u3hdqgix5/GmdITkx4ZrXEWzA3grr0rIcINzXiUe4MrcQRs9Jy128rW3gfWRqShuODR
	sp8nX9nd4hQcPOuwQTh9c3TWwF1i9JopVMNZq4n3yfz+zzqAiSal1grGkgTRVKRMW0S6TC48apo
	aYG00rcr9T+clqs/HCoWx7FwmJCGxe+n3+rNUzmU3b1W5iBQjrpnlMo=
X-Received: by 2002:a05:6a21:7a46:b0:3b4:7b3d:179b with SMTP id
 adf61e73a8af0-3c92a53fb35mr967925637.12.1785524750076; Fri, 31 Jul 2026
 12:05:50 -0700 (PDT)
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
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
In-Reply-To: <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 15:05:37 -0400
X-Gm-Features: AUfX_mzhQwXzX6axL_JCU146kBpF3HezC08-d7tZrEnJLnYGCd9nHtAkxsjABNI
Message-ID: <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
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

On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
> >> >> > <memxor@gmail.com> wrote:
> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul=
-moore.com> wrote:
> >
> > ...
> >
> >> Yes, I understand you feel it should be placed under security/. You ar=
e entitled
> >> to your opinion.
> >>
> >> No, I do not think the newly added kfunc is a big enough layering viol=
ation such
> >> that we need to do it ASAP, disregarding everything else outlined abov=
e. I am
> >> sure you see that too. There are several other instances of similar kf=
uncs.
> >>
> >> Therefore, please attempt to meet me halfway here.
> >
> > I'm happy to work with you, and/or anyone else, who wants to work on
> > finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c.
>
> Right, and for that file to exist, you need to get everyone (FS, BPF folk=
s) to
> agree on whether placing all such kfuncs there makes sense. It is not for=
 both
> of us to decide on our own. So let's revisit this whole topic once you've=
 done
> that exercise.

The kfunc that David has proposed must be located in
security/bpf_lsm_kfuncs.c, similar to the VFS kfuncs and
fs/bpf_fs_kfuncs.c.  If you read David's bpf_init_inode_xattr() kfunc
you will notice there is nothing in the function relating to the VFS,
well other than the "inode" and "xattr" in the name of the function;
this is purely a LSM kfunc and I stand by my previous comments.  The
BPF maintainers have seen fit to decide quite a few things LSM related
solely on their own, I see no reason why requiring a LSM kfunc be
located in security/bpf_lsm_kfuncs.c is unreasonable given our current
situation.

As I said earlier, I'm happy to work with you, David, or anyone else
on ensuring security/bpf_lsm_kfuncs.c has the proper test coverage,
but I'm not going to continue to go back and forth about the location
of the bpf_init_inode_xattr() kfunc that is proposed in this patchset.
If you, or any of the other BPF maintainers, are not able to live with
that location then David will need to find another way.

--=20
paul-moore.com
