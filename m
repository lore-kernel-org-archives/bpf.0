Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3A39282B
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948102; cv=pass; b=a1iNQZ/CpNLxObXlCwEmcov1hHS0uvkLNXrMKNnI6ZM5pmwBtPqjsWTpQQuxWJEe+hX3Ynq7WndSlPWjmLQ0Tp8R+7UuWLpp2S6FpIugNKoftftOegiRG4Sn2FMUPwYtIBWpDJzdZt1x5K+hpJsN21UM9urJ3uvpFzmJWndXM6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948102; c=relaxed/simple;
	bh=FtJm1XMA2u6fuGzBGX3Jb1FioFwf8hZ2gXCOXmPtfVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQrcSDb+oCZ/vt/vb9S7KG6UYGBkOTUDoNI+vyR+cq2R8gIF4zFJs/Lol4fql3z526ctWDlp2w3mNravL2/yGFlSm0KGlLAOG6lu1xf7IlQ6CK81KKqqGrIr5Nt3LN7zEayQc/hthwkey9v3gVgtXWPQcjN4M89058ss5C1epek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZkcKu5l5; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZkcKu5l5"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c88cc025f54so683831a12.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 16:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782948100; cv=none;
        d=google.com; s=arc-20260327;
        b=tCG8/kjpdba3OLA8097/8tfiQqrNGYG/CHfE2prSo5SOAgXd8Lra1fKu7xb9rjGTHD
         hALsC7zjbodylJ/JiH96z36jd081mGunZQWL6QX89bvVlJHZXl+uesz0NvQxsSn5xXMq
         7GeB+00+ZBC/vFGaEmEUYUSG9VLYmkVhzcm4zBem9gE88E4vm9ADVluK9Cv12mG3QGOK
         +0795aiqjKaPNkoZpd5AZKQ7wGZHn5U796Vw9h1jm+UgvQU1x7M9zrOVdFxIQxi37+J4
         mBmEgEePHcrDb3AViNDlk5EJ6T2Clegl8PpGdPKmVF1B6IMpKF9DQkDzCj0BOEM0yGy9
         KbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZhVbL00Yg5I6i6D230lOzIY4kpLQfWeLuTF6oDa7To=;
        fh=l7nkyNJncjG9+5jy+WCzazwrKaQ5nOjVFrwRCifFTgs=;
        b=M4r0eC99WDfZC4EkDWCwNLgcC4tVGz4PtfoUrSOBAAVLNTQphGAWqVDbThu3oZxyfY
         LCooOvQuEMTIhrQFwqFho0avy2QzE75CxHQneWgJK3Zy/d6qIJ5QedPFMkMMmwIkHpMl
         HOnKOozLkepdjl8SRZ3dGXV5caSttZXvme61lvAUonDew2o3BVj7SRD0onhh9EjX+vSm
         aWX+BXqn63HmfvUl1wiJUcj8EWkkLgtAclEFjXrgDXlbmXBYMMS+YV6ie+U8Fb5RYOa7
         1fTlXXXfzRZ8e4bSH2QSpk3J1f1lsdYE1RPqaNcqGUJWsr1sM+W8FC73Cu4HTyAhL6eY
         OEvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782948100; x=1783552900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZhVbL00Yg5I6i6D230lOzIY4kpLQfWeLuTF6oDa7To=;
        b=ZkcKu5l54N20I+XXhjeX+Snq/ceTIYqHZrOU+F8zxdyybdWsf363sWsYa2/iCEwBUw
         5TkCQ8X2JlbeMTaKIxp6yJN6T2aqUx3bUXxsl9MlUqrkOFPKUYGtYbSgUwuP6FySolud
         b+YQnpEFriP83EOArtC4uRZsaj7FY0+ox/1NiBPmwzue3EfDkcbR3yl4WmH09XyG0ome
         C1bFhOFphJ5zkohvjbWWT61SV0BhTmGkNdV5ztmdUAGIc6ZylDS5L1D80USdAKMFzSgQ
         iCnwIX2O2SnifZTohViHr356Za0/WQPWreUCRcpOmXNL9Wn3mOlTAB0UUre7Jbw25EpM
         djXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782948100; x=1783552900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZhVbL00Yg5I6i6D230lOzIY4kpLQfWeLuTF6oDa7To=;
        b=Kh37e6LBu9jV2SdkySf8ChQZhlIyvp+8v2Qq6DNfm4d22/raGZmq8zSTx39pR/Wft3
         Mnj2as7thMIqzTWCT+FpQV6zAHVKSMZ65uKnDclyli3+CBRblOW84kJh19XEBcMdELlv
         uE0gZPCG0aeNn2xyiMulqHrav44UCyskDnPgHWc53sEWfuhPvz7erEDjRW17vga2hPMq
         1ASEdEmtuVKFTLneAu+7dJG2vqi3R/nVmNCnLTjDplLjTHmrKTVlvU2vG7ijFTDPuFHj
         mBfOra5myWCQNDQr/maVmZmIcOnO924qxmeUO3NHAmq3qyokTIyQN66S+araErsVy6NG
         /OUg==
X-Forwarded-Encrypted: i=1; AFNElJ+phfJYn9Rod7u0k8QvzkhiivgbTtiiIOrY/UVns8jJnGaBpRCZZmptLTyTweD1JNR1iB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzblkOKr6piLLrZLj6c+i2e7NU4ZR2xchUJcAxqYbZ7qyiM6JVj
	ttBNj44iIvEJh4FWFwlBAzuU7ESOlb9xBv3kq9DfU2Vqnu1URYM7oHGDGS8Ulni2AEU6h2mfP9y
	oRX0XaDyB+YqS0HxO3zsV1n56xUA/8CRzf+bVwqS5
X-Gm-Gg: AfdE7cnheF9paPv11eW+k5BhA/LB9FkyvtkwCHaKdZR3B0EkCpJt52V1svl66AjQ6iq
	+SLQRNgzzJJkcRwWgw4osLF6KePFVRenkWyozd95nS0FZfld8U1iYBLlSnelaHBFlt3Qh3aDBkN
	0WpnK1G2Ag3IICt6zK0cQfTc8hzTVoyKI3PPYQubeINefsVZIgQu1exCIblk+t7eyowYa+K9dXq
	vjw+5rbtxHS1dx+c1Xfh173L2GjFfsmjkGFB/O6uXgK7ShZYgEHnZLRhsHfvcO/FM3x7cRH
X-Received: by 2002:a05:6300:6713:b0:3b2:8675:4866 with SMTP id
 adf61e73a8af0-3bfed471c52mr4022346637.31.1782948099973; Wed, 01 Jul 2026
 16:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
 <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com> <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
 <CAEXv5_ig4P=wMoiy4h-TbZt-Wz-YBAs5k6R4szSSxr4C0kjCTw@mail.gmail.com>
In-Reply-To: <CAEXv5_ig4P=wMoiy4h-TbZt-Wz-YBAs5k6R4szSSxr4C0kjCTw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 19:21:27 -0400
X-Gm-Features: AVVi8Cckm_QE9ya8Cck0-aYUUFKQ3gs1NVwV2FqpNlxb6AaTiQhAvZrnWz_L4W4
Message-ID: <CAHC9VhTTjkHG7CQ1ptku3TONh=6bzcwVwqawAYggX3Z32kUy5Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
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

On Wed, Jul 1, 2026 at 6:58=E2=80=AFPM David Windsor <dwindsor@gmail.com> w=
rote:
> On Wed, Jul 1, 2026 at 8:55=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> [...]
> >
> >   kfunc bpf_init_inode_xattr(...)
> >   {
> >     /* sanity check params */
> >     if (!xattrs ...)
> >       return -EINVAL;
> >
> >    /* get value/len from bpf dynptr */
> >
> >    /* hook will check for LSM specific xattr count/limits, allocate,
> > copy value*/
> >    rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
> >    if (rc)
> >      return rc;
> >   }
> >
> > David, if you like I can provide you a patch that implements the
> > security_lsmxattr_add() hook above if you aren't comfortable writing
> > that, but if you want to give it a shot that's all the better :)
>
> Makes sense, I can do it while I'm fixing the remaining issue flagged
> by sashiko.
>
> I'll route the LSM preparation patch containing struct lsm_xattrs and
> security_lsmxattr_add() through security and the kfunc and selftest
> through bpf. Does that work for you?

Yep.

--=20
paul-moore.com
