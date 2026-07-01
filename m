Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168B39A800
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886198; cv=none; b=Lf44ocDHv9MDevguXygOnXKwxZ5umdIoStfJNoxOxyzkxB6pdvofv3TFOM2B9vxmLXOWx/WEnSr0ca6AqGYahgb2iXCAIREEqGHcFV08YQfrvAz+IkJNcy8I8l9HJbZlTJxjFZxSTOboNALezdFvZ06gd6T9280gzh5SHJq+0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886198; c=relaxed/simple;
	bh=6KbUYY4Kud4/SPqyi3x2WMVAQjlqAWpfU8+H8Iqg4wE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hXefBCKG4W4W/aeDUjtZWU2ig4liCCe1KyHKccATvSmGPfhLA/PdtGDi2aVjEQEuAbwEHFlMOOjKa09uvgXzZqx5lm7ZH1aN/VqfjO6Tynk3Xb4su+MBET34U49Y4CHMQKrkXExpoIY7J4ki1ZC2xxtMqHvp/CwcACHw92ax06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPALaJxL; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPALaJxL"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-44793168d3bso158243fac.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782886195; x=1783490995; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHk2CYv9CFjND1DA8+37qjWHNRV+096bhWS2yVE+OC0=;
        b=qPALaJxL49eCojqqTZcH7dHmncs/Z/anbHriboVoEHKtv72PkXZU0V5uGQaQ2N9wWZ
         nMp/GCLkq7cY2sl+E5E/scOov1FYElc45jgJ27fx6ejdC8pkUVS1a/0+34DLXzVHEM5j
         piCjbnymC6RWYRuQmTy/BpHobJ8E4w9cdxFYAabB6zrcMKc/kSO0n/f7+SvPDQPZrjiS
         pUgYH2ZRd2f4sWpr4eWfGsC7+k7w/cp+wVhGIBw7zI2zt8gmGpcuA03TsTLaqDTNoMN6
         JI/BEfzJp4aZSNpJ4DG0p4FeEjjnBQ+gDPdZU1OefWVPcZssIrAYOwE5xiQxMiILwdyY
         urUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782886195; x=1783490995;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHk2CYv9CFjND1DA8+37qjWHNRV+096bhWS2yVE+OC0=;
        b=SvAJwENA+sb1lf4sCkqmGqE2/FWFNHHs9mwffAsA0mjPLkqBgiCcqb5b1OLgjJj2OQ
         DtCqAmzyIJmeqdZQHnI8IMRVGx7Wei4EzdIThWccYwib3SKDWXMgamfLo9C14vRU3K5n
         JukWWFDxnku15YiJfg2V7YSnIKM8p6Xdku7ky8XB2osGyYVGrQstdbsrukRuhEK5LuOL
         G950A8ZbYpWQMFLJ9w6/FY/m5VsQ4ukdKbcQ/NpdJz1hc59xYoeTwG9fooVPjdMRGFlZ
         ueSBPf3u30pdMO/v2WldspJp+7GnIJV2pALmPsOE84Py7U0rTPpVfDuOqgAMT+kAK5wX
         lHlA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5x54EhgJ/El190rfa8iNQXPuD8+47ef8i8m5zXnp7ZrvAstQ2pUWjlmgX9SPzR2qAOMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMn1jP4f1qD0jWrYtA1k0eYFrycixODacg7qPnfC0M8O+v6kR
	PXsiGeDPWVzy1L6BeKxSaauf9aD/q8Nz+RfOAMGKSZ+/Bx7YzWWu2r+X
X-Gm-Gg: AfdE7clBUb0NusLTdreAV9QeckC/LpSL/z3/udur+7k9mFH4+/p532M6/ckI5W0MW2u
	oDCFQ1Z+zrhMSiCZNUFIviRnmvDWdZy/vXyD6ptV0+iRSdb0ztUUKninKFwQawyA8r0oJcGQ7qt
	YgJE/cdVfurQXvvuVgYG46jBbQS5vbuzF8V6wSp+g0uDjd+/VN3abOBXTzqANZ8jQMYT0y7hTA4
	IGRn2mdfVpIJa7wphTVZofDpvXD0fi6hSttB/HC4HP5WI+M5OYQcBPE334DO3guKtSOIq75svnZ
	O15dgmu06BfNu7/ifd1hkk05SdzPU/nNT55ENr/rcaklkBfsmaJR0z31WfyTGyu2ycnzZYBt89F
	JO4zbYr1anc9t5pvEwnEKndxFzI6/zMf5TwWGyYzKMdiz16fnAswuuMvuO+eU14IxM4Fe9XD60X
	cXyKblqmgzna8qvdN4pgwUo0T+dnyWDXOJau/xO8bj7zSd5p9+vCKeHUVTBUW6WJotUMGzllsqH
	KWrmdg18av/JA==
X-Received: by 2002:a05:6870:9e83:b0:43d:5d22:4719 with SMTP id 586e51a60fabf-44cab961fa0mr69097fac.22.1782886195152;
        Tue, 30 Jun 2026 23:09:55 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44c62027e5esm886593fac.9.2026.06.30.23.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 23:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 23:09:52 -0700
Message-Id: <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Matt Bobrowski" <mattbobrowski@google.com>, "James Morris"
 <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, "Casey
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
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>, "David Windsor" <dwindsor@gmail.com>
X-Mailer: aerc
References: <20260630183956.281293-1-dwindsor@gmail.com>
 <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
In-Reply-To: <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>

On Tue Jun 30, 2026 at 12:20 PM PDT, Paul Moore wrote:
>> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
>> +                                    const char *name__str,
>> +                                    const struct bpf_dynptr *value_p)
>> +{
>> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)=
value_p;
>> +       size_t name_len;
>> +       void *xattr_value;
>> +       struct xattr *xattr;
>> +       const void *value;
>> +       u32 value_len;
>> +
>> +       if (!xattrs || !xattrs->xattrs || !name__str)
>> +               return -EINVAL;
>> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
>> +               return -ENOSPC;
>> +
>> +       name_len =3D strlen(name__str);
>> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
>> +               return -EINVAL;
>> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
>> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
>> +               return -EPERM;
>> +
>> +       value_len =3D __bpf_dynptr_size(value_ptr);
>> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
>> +               return -EINVAL;
>> +
>> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
>> +       if (!value)
>> +               return -EINVAL;
>> +
>> +       /* Combine xattr value + name into one allocation. */
>> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
>> +       if (!xattr_value)
>> +               return -ENOMEM;
>> +
>> +       memcpy(xattr_value, value, value_len);
>> +       memcpy(xattr_value + value_len, name__str, name_len);
>> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
>> +
>> +       xattr =3D lsm_get_xattr_slot(xattrs);
>> +       if (!xattr) {
>> +               kfree(xattr_value);
>> +               return -ENOSPC;
>> +       }
>> +
>> +       xattr->value =3D xattr_value;
>> +       xattr->name =3D (const char *)xattr_value + value_len;
>> +       xattr->value_len =3D value_len;
>> +
>> +       return 0;
>> +}
>
> This is not a generic VFS function, it is a LSM specific function, it
> belongs under security/, please move the code as discussed previously.

Paul,
Not quite. It's all about xattrs.
Having "struct lsm_xattrs" in the arguments doesn't make it lsm related.
You needs to study existing kfuncs and tracepoints.
A bunch of them have "*lsm*" in the arguments.

All,
CI found issues, so this set needs another respin.
After that it's hopefully good to go.

David,
you're on the right track. The patchset is getting close.
Thank you for working on it.

