Received: from mail-oo2-f16.google.com (mail-oo2-f16.google.com [74.125.231.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FDA37F30B
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241598; cv=none; b=VVrqDTKbILCvfDl4t1mUlyOWqHZkYjnJ9fzOL5f89UYKl2uJFPOlvWFNK6uLxflOgk25FAJsbnpzFeeheGtZx/Frz2642RDzzI0K1RI5Izk2RlGiz27G8gbfWqczd9nnj6CsYyVp40cjNnaJiZWM+tcM7cdiKnYdwWndf6CzCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241598; c=relaxed/simple;
	bh=I7Og+9vGtkyMApSATqOVCfx1Bj3bg4Jl2NcFFMMr82A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=J8gOBu4eD7gF8zIX6FEQBKj5QlfyXB/ML4QyOPGr3K45OVESZ7iwTkLo15QkTLK5qn0bxLki/0bB/fMc/v4KYkcDebNypbf7bJq1JiUorJbB2m2Ml6eRUCZ07TtATe2ghbPhFa8nRJm8NmtzEo94AIgPTPafaS1Ip7T6GGjZ+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDeOobMQ; arc=none smtp.client-ip=74.125.231.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDeOobMQ"
Received: by mail-oo2-f16.google.com with SMTP id 46e09a7af769-805bf8c2661so402844a34.3
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789241595; x=1789846395; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I7Og+9vGtkyMApSATqOVCfx1Bj3bg4Jl2NcFFMMr82A=;
        b=tDeOobMQ1tXo2VcXdtudpww7ZK+qjwx16fcnShR18zkMtmhhAQ9WOqc4ZeOCIqMuMn
         xOrhiqJlGLOseu9ssptphrWyhTG0UeR0/5/2pf2ZvqFt6f6/Y+l6Q1wyYyKxA/CkRAKJ
         sj7VGRJ4S8jpvPeGHYO5UUQyfzmBTXt8DBacXZoyuNVZtcQySYKr+lwBI+wugKrLwdug
         2uclifhnLFD+ZSt0lYlNOHf4d0YKxtq0XF50clMdqAGrEH3ntqpzlPIIyXKvRVOYOvST
         ixqMGSWURQ9hObiZ4P/Ir6RPlUDXZcKY6hcC0YUJP747MQam6fROTvrxkmhHSHhq87Vr
         xEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789241595; x=1789846395;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I7Og+9vGtkyMApSATqOVCfx1Bj3bg4Jl2NcFFMMr82A=;
        b=hrsmiS2jvQACf5qiE3OJNO5dcOKSfDeWTAdOP3zi2Qtfnjbvtah12kU1WLX9V3o1bz
         aegcvvkDw15iZQGq0+ljSt4IkywhgexRLruWvcqoXesDXRSl0Y8nR6CG5AN+qxCR2Ocj
         isWLFONnxo8j4r9JM8QAaBxaCZn79Sf6zJ7VpYG+6MszBWjES6w5wrdwsjHJXzCocwrW
         jnqGOWiGn7Pp2vrNeUw8AXZlY+0Cw2Fp0tLuedMzgwnq6rVOnUISQFG6hmLTeThHG5kt
         NlPmUmgd7OQGtOV+MYpmPUwQD8bj48HpreFQrVfN7LmJgnlHYN9JXxaWxGoBqCPvorF0
         sjwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcsGABPXg7WuR+gsZ4DU/HGU2cGneD4u3I1u2O4uwLnzQndggjEExEEFzVbxH2XZ3k+JI=@vger.kernel.org
X-Gm-Message-State: AFuF++k1Pwu4WdPoOSmldvjdM2ts8hjEF1C+YEatxpDJtdrKwkQh3KKT
	Pds0vN262WK8/6F0UcQ5Jv409FqHnE+8hX3BiCO0ueNTuYLKiy6Jq3U/
X-Gm-Gg: AYBFou3nNKPLHgeRS8P0dmb37pju3DQlRJEeWtwnqQDrm/dVyYpZ4wrSl0VpADm5DtY
	yUuBJ4Txsf8yky2aIgs6FA6uOyjlkGLdC3VQKz5lvzG9F+XFziMDRkVOX6igczxCp/GUfCtQKvC
	LkYCIhDmLqNvEveIY/vCwWohiWYUaSQC6MTr341NlC7/VbdjEFkbQ6MJodLCy1bSeCyKeNP8IFH
	G+TD9DNrpEkvQaEBuNxHBZz4za0uzVu/WJQv9JCKEkQcoYmkp8GYI07DpfkrXv4zSZE4RACdiCa
	todj0ALLBMyFH2KUODr3tlqOp8jbvjFDXqT/8/ZrEzZmt5wVh0XsnDsnPW+AtUasL/yABZKGpGb
	VE2mbH9AuiUmQnYQSow9tsMOZgQM8Yr6753hYWJL7KwtJzuaA3E1yFhaZWP0TK+ZrL1NPcaKhZy
	OTeUXeeEGdxODvbb8DEZ5cmBYZHmhN6ncl/rHeohQsW3B3Xj3xoDHoF/L6N3uV3Dcl8J6dyhdd3
	iCkQ+JShtq52i5HPBXvrLob3JYKD+1TqUmZXLlwWx4GBQvtrsmHkJ2pRESNjSIzGw==
X-Received: by 2002:a05:6820:5706:20b0:6b1:aa44:fc16 with SMTP id 006d021491bc7-6c0b9b54c2cmr4593859eaf.12.1789241595403;
        Sat, 12 Sep 2026 12:33:15 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c09690af1dsm5938278eaf.1.2026.09.12.12.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 12:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 12:33:13 -0700
Message-Id: <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
Cc: "Paul Moore" <paul@paul-moore.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <kpsingh@kernel.org>,
 <matt@bobrowski.net>, <mic@digikod.net>, <viro@zeniv.linux.org.uk>,
 <brauner@kernel.org>, <kees@kernel.org>, <casey@schaufler-ca.com>,
 <gnoack@google.com>, <jack@suse.cz>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <jolsa@kernel.org>, <m@maowtm.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>
X-Mailer: aerc
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com> <aqTZdCz6JaoK16Fp@zenbox>
In-Reply-To: <aqTZdCz6JaoK16Fp@zenbox>

On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
>
> If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then why not
> security/? kfuncs.rst doesn't seem to forbid this.

because fs, mm, net see the value in bpf. bpf helps these subsytems
to focus on their core technologies and moves policy decisions out of
kernel and into bpf.
while lsm people treat bpf as arch-enemy.
kfuncs are not stable. we keep refactoring them.
while lsm folks treat anything within *lsm* and *security* as stable apis.
So any kfunc where they have a say, will become a huge burden for further
bpf development.

> Where would you point me to?

landlock was designed for unprivileged users. bpf needs CAP_BPF.
There is a fundamental disconnect. If you can tolerate CAP_BPF then
just use bpf-lsm and implement whatever policy you need there.
If bpf-lsm is missing a feature we can fix that.

selinux/landlock shouldn't be calling into bpf
and bpf shouldn't be calling into selinux/landlock internals.

