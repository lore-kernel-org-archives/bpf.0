Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89B41A8F
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771470962; cv=pass; b=uxtA34+CkKYWhN5AtnX/sPaOETtKUE+HMabUs/H/3G0J7F9mmmyKh2qsXlZOCin8t7wVEOc6dWuq/Td2CFlu3MAD+lt866PwL21vtYKiyQCsNSqsmk5FDPhQxutXc4QmCw5ezlE3hY6qkb5NaO9AFmZKcN76pcwP7zEpD9jGkyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771470962; c=relaxed/simple;
	bh=jlCbJqBO571MidmO2wSH6N7GAv5ijJbh91S/So6TFw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jo3DBTiytQnNDVnjzi4nQb7oQX0HN6ALq9zxW8defk89fzPdCA747h8KwBMTsRMtq9OPKQkNy0Sl88qMvikyau0+Q4HrDRpL00nmEYI5PnPwePwhql47hzOSJpkfGXAPHsJKwO820Iq6Fk2h1huhHgiG7kUrrOJt8/3TzPuWmMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb/rtfZC; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb/rtfZC"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-436356740e6so524134f8f.2
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 19:16:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771470959; cv=none;
        d=google.com; s=arc-20240605;
        b=hzBoltn5+YYSOhrW+Ui7o+E9hGQxJbLyEKNuCzDYrJDTA3gOLclCQH0Mbhm0vrvd4D
         IyR3nvD/4Ae/fy5yv+vyxiQU9MZB9MuXd1myjfnErRQJlbjSkhfx11JtSjNKcjLnKV73
         pGORBATQVEaEkzKdRrJqV8F3YAfN3fWWsFiI/laVnxEecQWMttO958Mj0+xZy/LbNCqU
         puNCAWcHd5Tw3x25l6jXZyGkBkrMBnIAnAO0at5tnTa1gbWl23R9Rz8x/0h+VF7pZ3ma
         yqa2GItxnLUWf966iMUXqCc66y6XAF/V9QY/AfWd3VJeOUBXL/r+ne3MWs4XTkIG2GX6
         gVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UntGXKcFzGwNAgtGSqTbh0eSHenwKqwxhDYlBtgE9dA=;
        fh=z36xtsJtpHzI8+ug1MZyHR0pWdfpoDYh+eZo5RkG17I=;
        b=AmWVkS6hLRZx05igigt+RoAdCCq8OVjjSZWAv7onFmd8zz/q3hV0fElGnkgGEtt1Bk
         z/9vaOaJipX3arTw/Oc7TtbBEzhHd4ys6AQHG2kEy99QK0VVw8RQRMu4DIuo1DHiD4ID
         vJVcOsevbLo5Q8YbdnsgRAW9zlpDmIL0ovJcCInr/ifJzmXslXvYJ8jty32BSeHOWIM5
         zOW4x5DU4GAHMf1N9TC68yW9KYnnWh9x7hn2V1ozMb1ABgdb5LTrrSbmAB9zWVjB/X3X
         rnvw4pxBugm5o2Lg5kxg9EehBLhPShtnZF2v1uIDOttEwMYEcUGrJLo8xuEbkFhyeMOu
         Zldg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771470959; x=1772075759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UntGXKcFzGwNAgtGSqTbh0eSHenwKqwxhDYlBtgE9dA=;
        b=Bb/rtfZCvz/6suRKPp+0hjs+hwtLbbE/o1EpgtBudtTz6GCGGi16OgBvWS6KkATYrV
         MkZO1djTqEXV5d7Yo6vQ0eiq3scuU9Lrec8S2zVR2HCa1oOYgRkrPgGn4KF2hqt6MGxd
         sabOxazVj77+QbD9rfvbdvqJAGrSmPd7jelPRxDV+UhXg3sK9CBOBUGwJ+I5Zwb4JEI4
         qzk6xdGHKZe6CHy6gsaGvAImPJRpwLlGKpluB2NAk/KedajfKW8wrZumzRZS4lb7quKx
         lZX94Gkmuds28U4ejBkRWP2PnxMiyqyEZF+lwOI6neiFY30DJGz46F3PnJG5p1uzVTjX
         3UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771470959; x=1772075759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UntGXKcFzGwNAgtGSqTbh0eSHenwKqwxhDYlBtgE9dA=;
        b=H29utYQDqUo93h4PDwv30fK7Qua0vj2y434XPTKSteKTfetfhkECL1JcN2jCWcpUkF
         dSKZW+lXla7RvOibLGY1DPixux69Gc2SOJDYVzdJmRj/BZdYcZhsyYgcuAkTBE1qHYU+
         Hu4ycDxzhZ1PRLIjrNqTnYLDWPIHBUfO6MNJ2i5lOJzxBz4UjtS98bCNztC3zfEqXZqX
         8cAR+BtLo180apNzIIf4JcSsgwTg3n1S6hS09WtrPos22/DerZdMCHpfkBS03Bqm8asA
         +ZotYmSHm+gkPYQ0ZyVCHxkG7IKxsap8yUdrPr55z56n2H29J0yTNonLct4mfL4QSGTA
         7dfw==
X-Forwarded-Encrypted: i=1; AJvYcCUpKf1+HUE3Wf+D4498PIPBpBVQ9NjybN0haGJzndSePq09+cLxgZpm/Cd069EbTX2zu3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQeMGBj6rMJxN/W9Dh+jnI3uqGVkZAB7feMHfGsNlxRzdaAwM
	XJbFWPIu6jM759qhcPOgChVDDEYylMyn5ZZmK1enCQ0p3jEb0eXMuTb/nVwaGyJyw5rTMZmMCJE
	31efJ1aXvfzAaezalmtqqnQsy+NsQlZI=
X-Gm-Gg: AZuq6aIgL9Q0C2NQW917fbBjoPRh9ECFDcbzfr0rJCAYW12W7NUMNtyKGeN7E8TLfvL
	zvDtmjxYDUGGZI5yInCaeStUy2q0KQsgIWH7+rYR2nEDIulpeKju9v0Yx2G4plbjxeOLhWA3/Nf
	UAK8Qdjbh+n6dzTudstBFH/RPICJ8l3yh3DHJh/yuZvIQyPIK3r39lX6RYAHapQAm+adUScJaQJ
	IYtzMDVpqZMvXsYfai5mLKC35m7chl3+Sl1bSo2JjnpJpZkmON8w/614gfXFcroOy0K3LGtOXiE
	x03LIu5ijyoViPfBEoWuJNb6L5mIKQL0y9bBtoqSyJ1cQ1gTcnRnIAQ7f0jSwo7pmvIFDepAZm1
	K0D4b6/zPsP0BNctZjB2GbBB0JQ==
X-Received: by 2002:a5d:5d85:0:b0:430:ff0c:35f9 with SMTP id
 ffacd0b85a97d-4379dba3125mr31163255f8f.48.1771470958805; Wed, 18 Feb 2026
 19:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb4bf5fe648ac71c969c6228ac6e72ea85cbc64b.camel@gmail.com> <20260218104328.14341-1-slava.imameev@crowdstrike.com>
In-Reply-To: <20260218104328.14341-1-slava.imameev@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Feb 2026 19:15:47 -0800
X-Gm-Features: AaiRm53gWOBDMduyfV7JO2kUd65n6UPNFg_pAv-3-BgblkJrkKoD_kavOi4g3jk
Message-ID: <CAADnVQ+xwC+J1hZcHPEUjBoKcUKmnucG4AFQ-kkDmqx+C-GcoA@mail.gmail.com>
Subject: Re: Re: [PATCH bpf-next v2 0/2] bpf: Add multi-level pointer parameter
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Network Development <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 2:44=E2=80=AFAM Slava Imameev
<slava.imameev@crowdstrike.com> wrote:
>
>
> - This programs cannot be compiled as bpf_core_cast cannot cast to a
> multi-level pointer:
>
> SEC("lsm/sb_eat_lsm_opts")
> int BPF_PROG(sb_eat_lsm_opts_1,char *options, void **mnt_opts)
> {
>     void** ppt =3D bpf_core_cast(mnt_opts, void*);
>     bpf_printk("%p\t", *ppt);
>     return 0;
> }

Looks like there is a bug in llvm, since it crashes on the above.
But the following works:

void** ppt =3D bpf_rdonly_cast(mnt_opts, 0);
bpf_printk("%lx\t", *ppt);

Plus Eduard's diff:
-       if (is_void_or_int_ptr(btf, t))
+       if (is_void_or_int_ptr(btf, t) || !btf_type_is_struct_ptr(btf, t))


> - There is a workaround, which requires introducing a wrapper for
> a pointer or typedef:
>
> struct pvoid {
>     void* v;
> };

llvm should have handled it without the workaround. It's a bug
that should be fixed.

> I think there are no technical restrictions for treating single
> level pointers as PTR_TO_MEM.

I think it will be a missed opportunity and a potential foot gun.

We didn't support access to 'char *' initially.
Later relaxed it to mean that it's a valid pointer to a single byte,
but since the code is generic it also became the case
that 'char *' is allowed in kfunc and the verifier checks
that one valid byte is there.
That was a bad footgun, since we saw several cases of broken
kfunc implementations that assume that 'char *' means a string.

There are only two lsm hooks that pass 'struct foo **'.
If we make it ptr_to_mem of 8 bytes we lose the ability to do
something smarter in the future.
I think we better add support to annotate such '**' as an actual
array with given size and track types completely, so
'struct foo * var[N]' will become array_to_ptr_to_btf_id.
That's probably more work that you signed up to do,
so I suggest treating 'void **' as a scalar as Eduard suggested.
This particular sb_eat_lsm_opts() hook
doesn't have a useful type behind it anyway.
I'm less certain about 'char **'. If we make it scalar too
it will be harder to make it a pointer to nul terminated string later.

So I would do 'void **' -> scalar for now only.
