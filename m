Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792618021;
	b=XysGIpt+rPYXjqjvLbOl7I1xL0A171YsHLC1gBliYMY0BCMJn30O4hcO8ceJtS3SpxXt
	 AAkPfniR6r+mQXOsi5H2VDPp14nXqVZa0O0cgKpkVHg154Ph/VhkbSYsgNX0cIyRhpc0R
	 RicQ/J3t6i2OsN0wWu1aYZfKqEf5CQGzY9Ag34wrGBphFuFZuehR8JQOd4a9CTep5d9gF
	 8LdSvFXIMeoWbQZyQb/zXNRs0VcLPndUIUZ3G0oEr3nIPv5ZEkfbYgyrg8E8rktJdVsln
	 2l39b0afVe/qmx5NKNJHN51/+C2tlreeFTlMh8eLFtwEnN//9Oep3zROb6v/Vyy7Qbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3BrqJG4OjTNvcnuuTV6wbrFx+ZsrsyYDwwPn/2n+09s=;
	b=YcQUJzJ44GoHqhEloSomePwoTTsB1sAeiD/bwK+SCPa3Fcb+yvnZ/GWtIS2lgLQQcvMQ
	 dYHwy/X8mM8CB9KEnGCxLKuk0H0JaFEHelYD4lkcl+bVZ5xIFX8ceWwao7TPEgOxIIU9T
	 fsHHmPiDW25Aq59m9MHCh2cA40kOReA3GZTp7OcEr/bSvcQ/psq0ai0WQW26dwq4YtXQT
	 QyNHxiARK3uoCYBY+E2enMNLMs/Okwr309+E6wi2cnSCCQHLotCsV71COrOBGCwJj1rXk
	 wiJ3tKcTdJw+tUJMq9Ae4oPdrNcr9MmahLQJDqtx/q5Cpilg30i2kNs595r9ToPKlNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Olp7wuHM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB990606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 21:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB990606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Olp7wuHM
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so585696b3a.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 14:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792618020; cv=none;
        d=google.com; s=arc-20260327;
        b=aoZg0FI1E8P6TODKv7YIucQJptQB0sahpIB6/rlx18YKF4fFvCBVnYl5dqxLHFBVse
         0A0iuQVnCLp9rTtNJdZzqBy72Ww+5cuXhP1r7+eTY2E/zy8wU18kzaEEBIFsYvSCxQnb
         LRVkm8kmqGD3gBKcZNus8zGotPsiVVyQf4YVIUKKQ3nwBRdFin+K0023i0I7ioUMQxKF
         ETkQVVESuEz1+i7uF1gnzm4vSz9JPwF3gIjCF5E0zTIb+g1fCK3e6FC0WI6xEkUUXsoJ
         2CpaXj5Sep+9DYwZDDi4skAI4jAuaHUbVJ5i5IrNZKv03mmNSidqd2wcAr5ZF3MHY6fF
         dW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BrqJG4OjTNvcnuuTV6wbrFx+ZsrsyYDwwPn/2n+09s=;
        fh=2Blbz625QIf+Fxdi8gnoN0NWFhVuuQw9kWpOwycKAyM=;
        b=EiVJNVD7NfuvBfPQTGq6kJB/gcZ3mrWApSKdes0mmG5BgMYIPlmHW8WKUfB8P2f83b
         9Tudv0novopUl5ztKx6IpTywnvKoiNezOTsSHzZEzlAfG3Go8M7+hzVHC3NBO0Tjjr+v
         QApm9bETo2gCSnii+r5zxI9kEr+JeFbwsQHFH7GpbeMdAmIDidUs4+ffOjIWb9ewllJ/
         aF9YB9bYwURyc5YKVXjXAwCn6A8l0sBuJDsjT2dIx0GOjVbK0h2mvOIpnPaqMyNuP+s5
         yrKWWBck9uzo5Ov+KO2vFHCIw8MxSO0YGSKH6PUlPLpJFTyYgutx3gS2kRlL7DG7DxCl
         rP8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792618020; x=1793222820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3BrqJG4OjTNvcnuuTV6wbrFx+ZsrsyYDwwPn/2n+09s=;
        b=Olp7wuHMPD0rgobGBOMxtyo3z7aaxKDbIa5dXP9TbKcGbUygsV5+IyHL8X9MqiHLaK
         SF5Q5F4zcrxukH7gCbcEDiPEW9TpK/LpwdG0Zp/WNkOdtLXKPWtGgrHx/rm/fKd6AhBq
         Sqb50iWdaGSjuPC5yJGvuwszU7ygtTWzQzZzP/Y5LQoxeQ1zpTaf/cP0Y5LTLuxgm5m+
         mMgxFh7Hw03KKtYJx+gFMRQnB+Oh03CAT2q6U0wCJLi+WorHDAxZdarTr6GXiIUZ6YPT
         zDSBAXgbVjqLnbccNnkKOAC5CpooqtBxZ16uSW5SOOCW9/xyD3tKjCWX38scl4p5skSS
         RyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792618020; x=1793222820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BrqJG4OjTNvcnuuTV6wbrFx+ZsrsyYDwwPn/2n+09s=;
        b=NEwLKl0X2e0DHvyPEDwKWlRK5Zch+xpbiofEbXs+p7r6ZDWNPIrqe91f3/L3PDlyMQ
         751EiB7gx7zdPQLApGFlNCXj1QHXVqnsWwuLZTCFeQORklWTZU9wtjh2HBzECVxly3bB
         JYc9zRV/NN5cGdl8cJ4MJKkLFWu1AggHVqsie2urpSBvntSLquduWktCvFWiTS6a2KZm
         wCk7l0b3aEYNFcSjYno6S2S+zBFrhctoFYZVRwExwMqqYXrYc3qvAAt9DdVfXRcx6XEc
         0LHfnzOX0ZHI+Vwj16cEHsYKLt/mcTWQUO9GpOQM8ed9HQ/ZVpzY2D4fQCA1zZbfuNji
         IoGA==
X-Forwarded-Encrypted: i=1; AKwUvBwfFSaAW2fgaq2puLGvy7w2tMZWxv1lYdUJ9MWfGiBXsWg+g+gyAlpv0DB7VwP7/L+2XGY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMDJPdcwXcHwHxsgjJiCcINLjJXsnNlQabO7J4Odx9Fp0Oqd9p
	0UhLrStBrUnrB/WVjIemtnuF82H2sBNqfjfciW9v5J9e0BIb/tssXf2BBNguF3Us9W1Hm4ZBEeM
	bGmtWmZFC5Byp731nu0qX9C1AdHt3QNoqIqCSJQtS
X-Gm-Gg: AYBFou2uhrx7znzTSw3Cw2BKsphbqKqKz9bMJZNABW2b6WTjJOM1wAKdUstdKIRKmVT
	GW5ELwwqZEWUD4d5k1kQzSAZtL0eWGKPb2JiMw0uI2cT6nFXcnFJTW/1Uz/DlSIgxYz2Hr1Dn70
	s/dWMNbZUxsOjl1KZPdgqV8Qj7NVnKRGHtorp2eBmHyD8W3fjwdU80cid6HKK0Jjb9n9pygd1oI
	tamUFVZyksdjzwLdS2ISPkrRiMFshEYrHWlBu1jwkPch/UdWjsgAgd39U5EW4hU3voZ+fGF5wdu
	vI/5Z7XPU72HzA+uZdv3hddwPjXesJtHQgOpojQAV9URcDac3GkccecZmhhzMz7HpY4xCr0Bi+g
	61ikjfHqcRHhMLiraY1BF7O3akoecZetsQyu9nBKLTHP9viDBjVywl0pi9lSKxXAbk8m2nK3EdU
	93SwgDVdGoMAsgzA==
X-Received: by 2002:a05:6a00:448c:b0:891:6721:370a with SMTP id
 d2e1a72fcca58-8a089d16bd2mr2288044b3a.29.1792618020160; Wed, 21 Oct 2026
 14:27:00 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021210147.3450677-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261021210147.3450677-1-alexei.starovoitov@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Oct 2026 17:26:48 -0400
X-Gm-Features: AclHuK_WG0WtmvYrPQFuNXHrb2rzzSH_2jeZmbcgt1YGcpXNkJbu_aqEAAZfEdc
Message-ID: <CAHC9VhQGeZtDLKZ7iLYx-d1ua_CojCN03uSG25oVDqOm9GKFag@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 7.4
To: torvalds@linux-foundation.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	Alexei Starovoitov <ast@kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 5:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Hi Linus,
>
> The following changes since commit ff47652a4b66c067c765a7ad464d930b5a9367=
cc:
>
>   Merge tag 'cifs-fixes-7.3-rc6' of https://git.manguebit.org/linux (2026=
-10-02 14:04:11 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/b=
pf-next-7.4
>
> for you to fetch changes up to b116ac6087541d3d98031e786adbe9c733cd6df3:
>
>   selftests/bpf: Time tc_edt from its first packet with data (2026-10-21 =
17:50:51 +0000)

...

> Other features and fixes:
>
> - Let BPF LSM set xattrs at inode creation with bpf_inode_init_xattr()
>   (David Windsor, Daniel Borkmann)

I need to object to the BPF LSM kfunc added in commit ff0d1c0915d1
("bpf, lsm: Let BPF LSM provide xattrs at inode creation") for reasons
already mentioned in the thread below:

https://lore.kernel.org/all/20260915150739.284189-5-daniel@iogearbox.net

The primary reason for my objection is that the bpf_inode_init_xattr()
kfunc, despite its name, is a LSM kfunc and should be located in
security/bpf_lsm_kfuncs.c.  The bpf_inode_init_xattr() kfunc is called
from a BPF LSM program where it allocates a buffer for an xattr
name/value pairing, updates the LSM framework managed list with the
name/value pair, and then returns to the BPF LSM program which in turn
returns to the LSM framework where security_inode_init_security()
writes the inode's xattrs collected from all of the enabled LSMs.  The
bpf_inode_init_xattr() kfunc does not call into any VFS APIs, but it
does call into an LSM internal API.  There is no good technical reason
why this kfunc is located outside the security/ directory, and given
that there is plenty of precdence for BPF kfuncs located outside of
bpf/ (e.g. drivers, VFS, io_uring, cgroups, scheduler, mm, networking,
etc.) it weould appear the decision to locate bpf_inode_init_xattr()
in fs/bpf_fs_kfuncs.c is due largely (solely?) to a petulant policy to
never allow a kfunc in the security/ space:

https://lore.kernel.org/linux-security-module/DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gm=
ail.com

I'm supportive of the work that David Windsor did to enable BPF LSMs
to leverage the security_inode_init_security() LSM hook, and generally
speaking I'm supportive of changes to make it easier for BPF LSM
developers to use existing LSM hooks (there were multiple changes in
the Linux v7.4 LSM framework pull request to do just that), but I
can't support the BPF maintainers actively circumventing
review/oversight from LSM developers.  I'm happy to support David's
work, but the bpf_inode_init_xattr() kfunc, and associacted code,
needs to be moved into security/bpf_lsm_kfuncs.c.

--=20
paul-moore.com
