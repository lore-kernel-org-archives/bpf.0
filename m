Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622748;
	b=YaVf6EUNdi7MPqJ6OJB3mmEXdcB/Jl25pb+CSEb/MGsUhXgc957Wf6uBDK3uQ9Km7LNL
	 DqU8qEArdbz87BDwT7qEAV+w6EFz2aOv9+pqfa5DqITWagbQGPFIWhtRaduMumypvPi79
	 lmzYiOy51rXsHeMx/kVom/0viAZso74WgFWjBBDAibUX8XKOqyLLvdUa7YtX7Ubf6emn+
	 SX49yM97GMp5t83NJ+q6vY2fCEg7HbeMtQwISdLGtBMd2EJJonTtFNYZ1zAMsTDddsDBM
	 K44Q9z0+JfPEK4wcqDeULG/axeTxnaAQ7LMF6tdQ4ViYaHUgFnhmdFtiOkIOHMM/37Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4llyIL00u+37KgFZuL7wHKAnvyFDGQSYrc7zfpO6OMA=;
	b=cW6p2g6jSjAXXT+Fsv9nRIft9MHVSSVvWvdTsFtn7bzHMvJXpyTx5F5YzuCCNtHvkEZt
	 ymsSJ14g9W3FkDvQD2rS9E4jJgo25E8JfommQevcnJWZDUg93k54yuQ67X3LA8rFFRVb/
	 5IslYFnvw68gKD8VRD3cvElhO3eSqRmzDhyppgI2f3b98tS1mKYz1SLMaQqWKZftwylSR
	 dGHuA8CIkZUN59sRASzyzIQcULHwHzVbuWpGYbv+tJGCI80/CMSL+Qh6JnCapu/GXIZJK
	 WQjmyrdqj1StvtDb/DK317sPpVQEMvSp4XN82GteAHze3b/5POpg7kKOjIv6MlcTZHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OhBKRuxM;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B689606A31E
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B689606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OhBKRuxM
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1018642a91.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792622748; x=1793227548; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4llyIL00u+37KgFZuL7wHKAnvyFDGQSYrc7zfpO6OMA=;
        b=OhBKRuxMGHwUmmfTFM7fh88Q717Sm8fLuKCUC7E2Ni0wE7BGYNuQiKEyFm3I/d4qoV
         /p7E9SGOrPgKQlLfaKyitIPI0vtmGSbgNiPBfzuqol2QkDYxfpgl2FihMMSktk48pOzl
         dA++Vo7mrC9bOO7mIfwBo7Z41XtKQ3p7hdr5UxOiO0Y/VBZVSKn320qV8eCMxFabSgm8
         7lQeChYyLislsSyVv33w08Dimat5+907g27KR4Uj5bWfkuMEf/DhRIBi9L4TVoEJhlze
         NEzHYS2yJizUQKBZoJpfOKJt21xvcypQWJCa2olkRMYAozzJAMSO/GYE4LMpJ7Zum3eo
         /hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622748; x=1793227548;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4llyIL00u+37KgFZuL7wHKAnvyFDGQSYrc7zfpO6OMA=;
        b=sDOdQWfWvNcKD2Me/jKkUxSimPycRvbZSx1AOi2WchSvPmeuZdk8cWI+kllGtWmtlt
         +APtHzCOGIN6TTyPjb83DVmaqILKWNX8ulbaed1Q9Y3QAXId3JDhJQec4kjsGx5PBZbI
         qHZywbZ/x04YxKkm14uVi00FGSbQBzjSCi5qvD74zRxIU5ouxp5hf1cw5uIP3FsKy72Z
         au7GswToGQmNfX6xO9kfAaZ9CowLtIP4cAQEOMtozIlOKlMIDHHtTG+nTqKjdcBa/KN3
         CQxmBZvLftOTc3GGvUPeqoy/iy9wxEmFVvXkq1dmaVFN5glIjA0mT8nOsjbNakoInzpl
         15pg==
X-Gm-Message-State: AFq9FYKpVSIcXkJzQ/U4evKbA5JA+izDSi0+TH0H5hC0wW2efN+5Wbwk
	RKo4GrbvDxQBtOxQrNlbdI384PcJFuX7G+fv3214+lbXR1PAYx/jvKmJ
X-Gm-Gg: AYBFou0eWYfs45BlzQMj3Z5XtSZC2DQeCulGcWDWVCnTB6RSJTgi5NN2eBd5dQGFv1T
	ix5luRhPQa2eE43emfQGVZ2ZavSUMJBULOiCM93sBdSkcv13Bc2qz7reI06bkpDFGTH0Kdn2ZuB
	e3DuVcoVV8RsZj+T7iZdSy+IK77Rh+x+AGNOIZal9Z5IGTpa+oh8+nQ4oLtKNArMf4pTB93/b9y
	3OiDzGeqMwwqpfBbTmOyWjcVhop+4rXD6QDPQYb3lA7Nh5AEjwqa12xHkxtYXMNnSf5vhWjp0V7
	QCAuUGQmHDRF/r5eYmE/u/ydbo5XEmYIZlle1OvvNeBnasWPCG/s2/8HENdcFIdApnl4Z8dHQg3
	a03QJFz4CpRW6y0VpRy6iwt777teAxUVY4Ii4G+LkFiDZSqzWMIJrx/n6dBuFykOtOYwYbLluWI
	cMcNwUFWGkvbJdHLT4m/xY6mCVJewjwnrpa407pmDp6evlzcSoTfb692Mxl1Wmj3XN5PX9ag2rJ
	Q7otbFkFfHWE5NsbUpvpY0pAmbr/VOPkNiYPoYJlzn+ghdU3ThbsWTk5hiLVU7L220aaiAcZmcM
	BdSES5rqKCnGTQ9Z7biD7RcawExA1uzlYCg6M5HdCwYZOJtVC7UA4bAobfn/8g==
X-Received: by 2002:a17:90b:3f8f:b0:3ac:7c4d:8be1 with SMTP id 98e67ed59e1d1-3ad8708f735mr2855455a91.62.1792622747523;
        Wed, 21 Oct 2026 15:45:47 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48bcf45sm1215949a91.15.2026.10.21.15.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:45:47 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 22:45:46 +0000
Message-Id: <DMAVQ90EWW3Q.44GJKDHWOSFC@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>,
 <linux-security-module@vger.kernel.org>, <brauner@kernel.org>,
 <dwindsor@gmail.com>, <kpsingh@kernel.org>, <matt@bobrowski.net>
Subject: Re: [GIT PULL] BPF changes for 7.4
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>, <torvalds@linux-foundation.org>
In-Reply-To: <CAHC9VhQGeZtDLKZ7iLYx-d1ua_CojCN03uSG25oVDqOm9GKFag@mail.gmail.com>
References: <20261021210147.3450677-1-alexei.starovoitov@gmail.com> <CAHC9VhQGeZtDLKZ7iLYx-d1ua_CojCN03uSG25oVDqOm9GKFag@mail.gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 02:26 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The primary reason for my objection is that the bpf_inode_init_xattr()
> kfunc, despite its name, is a LSM kfunc and should be located in
> security/bpf_lsm_kfuncs.c.

Linus,

there is no such file. The ask is to create it and to give it to LSM tree:
"We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
the LSM framework"
https://lore.kernel.org/all/CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com/

fs/bpf_fs_kfuncs.c has six xattr kfuncs already:
bpf_{get,set,remove}_dentry_xattr(), bpf_get_file_xattr(),
bpf_cgroup_read_xattr(), bpf_sock_read_xattr().
bpf_inode_init_xattr() is the 7th. Same "security.bpf." names,
same check of the name.
Christian's answer to the same ask in June:
"For xattrs we have it all centralized in the VFS and in general all VFS
related bpf kfuncs should continue living there and be registered there."
https://lore.kernel.org/bpf/20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner/

> The bpf_inode_init_xattr() kfunc does not call into any VFS APIs, but it
> does call into an LSM internal API.

That API is lsm_get_xattr_slot(), a static inline in
include/linux/lsm_hooks.h:

	if (unlikely(!xattrs))
		return NULL;
	return &xattrs[(*xattr_count)++];

The kdoc of security_inode_init_security() tells LSMs to call it.
selinux, smack and evm do. BPF LSM is one more LSM.
The series doesn't touch LSM framework. All it has under security/ is:
 security/bpf/hooks.c |  1 +

The kfunc fills struct xattr for initxattrs() callback of the filesystem.
It runs inside the transaction that creates the inode.

> it weould appear the decision to locate bpf_inode_init_xattr()
> in fs/bpf_fs_kfuncs.c is due largely (solely?) to a petulant policy to
> never allow a kfunc in the security/ space:

The kfunc is in fs/bpf_fs_kfuncs.c since David's v1 in April.
That email is from September.

On Jul 1 Paul was ok with the kfunc there as long as LSM bits move into
security_lsmxattr_add():
https://lore.kernel.org/all/CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com/
David did that in v5 and v6. On Jul 31:
"I saw the v5 patchset and the nature of the kfunc became painfully
obvious to me so I changed my opinion."
https://lore.kernel.org/all/CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com/
"this puts us at a stalemate and David will need to find another
approach for his work."
https://lore.kernel.org/all/CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com/
Six versions in three months, stuck on the name of the file.
That's why I don't want bpf kfuncs under security/.

> I can't support the BPF maintainers actively circumventing
> review/oversight from LSM developers.

v3-v6 were on LSM list.
The last series is that other approach. Christian, KP and Matt were in cc.
LSM list was not. It should have been. Fair point. Will cc next time.

It's in linux-next since September. On Sep 23 Daniel asked for technical
comments or bugs:
https://lore.kernel.org/bpf/04fe4568-90cb-4aac-a21d-c0443e418b46@iogearbox.net/
None so far.
