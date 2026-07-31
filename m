Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C6330652
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534600; cv=pass; b=aJl7eU3OGD51POFLYBw47gX6hCUVokYd1HEnWBqyfBD/YmBNmLB0QGxoM/8RJsNBv0S5Hr+7C88zV8M7LWMEoGLOG8MqzA+XjE3PZaiT6+UC4n65YYbpcJnrw9hdJ7KuyYJT5X+IEv15BrrVd8aECTUvsU3aEcVpZD3hhSLU5l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534600; c=relaxed/simple;
	bh=kpO9PEXx/XIiH5ZwWY4YGhkICx/l6ojRZfzW/2hja1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIUZzXwT/5N0q8kmLZA5nA0om4ZvGbmdiLD+Eh/CNpaWWbNzwuneTliVwNAwqPp1Oc6qu8yD94h2Dx5zuRNngy4iWvDhsAKZcD317nkKsuiLmLognpMKVEGEGp7Q+svhexDtijT4OZ56MrlAxnmiI1eSU2OZtcs/aRw4JHc0t78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c84Vtihi; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c84Vtihi"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8484f229529so1358979b3a.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 14:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785534598; cv=none;
        d=google.com; s=arc-20260327;
        b=FQsM84sImWi23od8xDKW31BboO26fJiwOEh87YVMMrcVES6u24rV1ktOUZoUPIv4MA
         DDcXsTEEmcRsVPkwLOhLRwhPp8Fk9d2l0WqdhdJjNWnoug9ofkAQf+hjtiPaqsO15+ZM
         x0OqFIfLlMDfigqlJrMDNkdoogCmPS+Bfwm3KS+EtC4TPUDS4dWcpnqYDjQRCvTNGki/
         jh0cWv3ZXsHnh3SyTuq9RecZyZNBeVwIhcpP31yD8/bs8JKWtfNxO9/Hu4/f9JorCx1B
         0zmFl1k/1aN+vrra3pEOJf0nei4Nz/m9BkoFX8PMJBy7IZz9kMlJaLy2IsZLOpnmiE+M
         of/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KOVe171/EgYbHhJuKKdA8XntY2KmAAQiC3TVfynAeIU=;
        fh=GJL/usf0XP067o71IPevsE3X9tdMSw2C4Em/u6UHbTk=;
        b=hzEp9N6g2PECwIDEx0gpxrnDrdlz3jHbTy7TSEiZJyS3HYrery+1/UYNbb/2e3Oiwz
         HnHrWN7IGkXqKZ+ggBcu2LKScvdEyC9AO5aCqL7NT8FkTt8TMJSHOp6M8eUk4HebHkIq
         oh3xTVi38Xrb56V7SSVNuQUlQatLOv0B5vzHjL3nMIfbhajUX9JvhdDvtUGOq4Y+qzcu
         IVKYBsnt8Uz5/va+g7ZSBaIkBNVbx/nSaDh5lsxFAjfz7TSRkF8BJeUHdmID7TdLmTBr
         l1+iIuaWW2ClFXFDMq5acsB7fOERk/yNXuKPufrlwzQzwkKs+aJA55fBOWuAkqTWe4Tn
         40NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785534598; x=1786139398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KOVe171/EgYbHhJuKKdA8XntY2KmAAQiC3TVfynAeIU=;
        b=c84VtihinNTAKFTpUvWgPuywFIBXbIrIdgFC0LIyNvf9Cq/SiAlmegMpggVzpg1lCA
         ue12iRkr6NAfm+WQocwFOaOuQkgtvioU6T5uaTIeOeNpXGEgVXMoFENwEyGlj0KD5ZDZ
         Z7rRPBa9XFPVCfz9wtSgEis3f3ZNHc0qbrlByFvG5mmNz6GaZneri0L8eAE5p5yfmbIc
         9Hj+cZoORh1wOvLilf/S7784TbMSler4wvoDax3QHj5Ep9w9AvBEbEz8tA1kmCWADop9
         ggHbVBp8uFemBT5TaYqshUfvQ7bPPOEMOmu5FVJPffOEIxk5w2nBvqzcNLwUwVnP4YAk
         jung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534598; x=1786139398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOVe171/EgYbHhJuKKdA8XntY2KmAAQiC3TVfynAeIU=;
        b=OS82x4/Mej8bH5suP1Qt4WE4EqHDmUMlesXrXsG/8WZz5A0OYakDIfIOhrWlUIpQnZ
         AdjHTfBPXOyp2SD3gigwv0o2J1O2tnRk+gDp7Ym0pyZwgIHYBjCAukX6t4GigORVJ1BI
         WRTeAxHMG07fkVQxwQv1ZRUz7CdC0u4lusei09TSVYaB7f/GLTXeOja932SdK/1s9IIT
         yV356sQDmvxuC+gYhWVFvnO6uF8tinSoQ7ae/EKnNzpX3Fz7SDO2G9lyjn3RZlhq9uLZ
         nC0PaRyGXtUjU/jl/mq0Xgv4vUtJnjnnwPi/tBJNSNqS0cz/eQTVkjkeYe2zsasFheuN
         KUsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpozdZq89HtxXpFZ+hNA1AL/iu8P9mXPmSl7j8MO86tWFafKluOg+CC8A7nH7GZEbsyl9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jkFwIgrpjQ2neARQ7HVThqwZCJhhT9xnx3+dD+hAMHcvkRpW
	HfZtpgn/BVIepRYva5810soE6HLS0sKOpJzfVnEbnkVKg945LVLmOlBP3N2Gw+AJCdp7rt9imLf
	Z3A2Rb/K0lDJrHcjpB1dgjy963RZLHqBULGGOFS+9
X-Gm-Gg: AR+sD11S1zaSOqoO6ju67LrbKq3QZYsrPjsk85XrShDuNcIpjeyLB8TnobxSa5Nw4RK
	ieJCyHsnAWYyoSy8lyXT+rJmWm0RCF7tgmCa1ajJ8H+hol3Wjw0r+sLaKWbEmFoh8fPCxXY0YXB
	/raYsf3RrMtJ3kuqUP62vqoCvi0VvXdvrm7+hBuE92KYS0T6r91LLqA57+Qt/k2WPhQBkkX1vlH
	R1kXJTpQGmKFkpkBAQAhH4f7ZpvQ6MrJ2H5ZXeQS1GwJuxEiD8ObcMDhPNIS6LAnFJ6QGgfwqXf
	xmVm/7GX+jZTfuJ4ADpdCpy1A+O9ZYM2fep8Cc2M1EwM
X-Received: by 2002:a05:6a00:1956:b0:84e:223b:98c2 with SMTP id
 d2e1a72fcca58-84ee494dff0mr989540b3a.77.1785534598073; Fri, 31 Jul 2026
 14:49:58 -0700 (PDT)
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
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
In-Reply-To: <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 17:49:46 -0400
X-Gm-Features: AUfX_mxDgkjotLxho_QpbF4kUqhzrCQm-_c1GtASttEFM0UzlBMMT_SHEoVRkJs
Message-ID: <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
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

On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> >> > <memxor@gmail.com> wrote:
> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwived=
i
> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dw=
ivedi
> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya=
 Dwivedi
> >> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrot=
e:
> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <=
paul@paul-moore.com> wrote:

...

> I think you keep forgetting that you cannot unilaterally decide this. Bot=
h VFS
> and BPF people have told you that it does not make sense. What was clearl=
y LSM
> specific code has been moved under security/ already.

I'm charged with doing the Right Thing for the LSM framework, and in
my opinion it is in the best interest of the LSM framework that the
kfunc being proposed lives in security/bpf_lsm_kfuncs.c, just as the
VFS kfuncs live in fs/bpf_fs_kfuncs.c.

> The right way to do address that is to get people who added and maintain =
that
> code to agree with you ...

I think that statement should be read by everyone, including the
original author ;)

From what I can see the only issue we disagree on is the location of
the kfunc in the codebase.  Based on your earlier comments your
concern about the location was based around testing, review, etc.
while my primary concern about the location was based around the
content, calling context, and general behavior of the hook with
secondary concerns around visibility, code ownership, etc.  Once
again, I believe your review concerns are already addressed by our
standard process around cross-subsystem reviews, and I'm happy to work
with you, or anyone else, to address the testing issues.  If you are
unable or unwilling to work on resolving your testing concerns then we
are at a stalemate as previously mentioned (a few times now).

--=20
paul-moore.com
