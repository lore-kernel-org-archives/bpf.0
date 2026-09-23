Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3754280D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182676; cv=pass; b=u5L0TmUCGWjaSX0byC+3CcpY/aoWMj2E1zDzCCiNb/gE77AN0Q1uGZbMVdciLf6Xp0+UVAx3U8VAQipLnk3vEtUQ/cE9s/wKEqD+zmhevJ5/mB4HUMxRx29IkBfayb+cEctytMc2w68lGX0rD4TT7gLRuQu5WsK9mA3bORwppdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182676; c=relaxed/simple;
	bh=McqDOGf5r1CnE1bN7FiRiYswkQTi90pIdMUmOHjlXZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1ELuPbMJ59Y5JrCrPrLCmhZGNQrVg6eNlKW6qRPYSCo+ehP8cHOvKxFWjBx3zceZWGS1b9hybExM6ON1XM7lns+x/SY2j3H6u5E61cZ8MgSM+zyUKzs2jTYFSIwDJ9puxYx9r8zxmeY05BSOl4pkT9Sy2TIapyTvptfR/fCvyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JjkYbBrz; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JjkYbBrz"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c5so773227b3a.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 09:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790182673; cv=none;
        d=google.com; s=arc-20260327;
        b=TksPzsCXSk8b/T3KGSjtlrP7d51LDF2Ku5hUvhRImrAHnbbl2ilYxwYHY/6KPbb+Bv
         r/rqpgpyNRNMTSuSCtdcgNTmpWZ0rx3Col8jKKgOwTXV1uQN5Y04JYIZqT9aKSGIkP24
         PB06lr0nkZJ7wpdTOxs19FRX4Wvp2k2qoNteO8y5dE70FJg96AiJC/L/JdP6osAEOxP+
         ZliBzo13bEIgjvJukx96PTVWBs7q877sg+R4gnt5r16BAv7eXFCeJQ60t2FkpxjFpuus
         jBzo+Ml0CXC0M/Xq/ya4aom7DYRv2iwyLxuK5sWolbJZ44mVvZ+LczJH1ynPVEXyH4lG
         ab7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ijs+6l1Z4Lnz2cWqooyvDNYk6B/Cjo1CnXBD1Ikc0Ww=;
        fh=TPS6RMEfLRXaiFD53OmxSVz6Tt4HYiHLuP3KSeRC+8E=;
        b=MpB9nhZnHpOgk2R+6nRgrCy7UacIY63JZ7musW5/YLDXUaiZE6Z+Owf7EwsIpHQWO4
         vIr44oS8EW6tP3D2cQBbLXKFWCj8nTUSpz65Rs6TjCQIIqJS/3GQ/nzbvmLXdWWTdG7r
         FP1ltYtx5+2EJlnBkxwhqkJe3RWyYSSRhYm3K661MOMDujOYehudK25b9IWKR5joAaZa
         UrUOgZJ1LBXXj1bZkGrcxQe6tJH9TVGDafOeD4+1u9pe3leqdj99GuBj5d6OuZkze38T
         T0SSXgYUEDayKIOFe+3wDyMtbKTlWd/ZDr2Ol/01aHRtqxBX25rAgxOiSEjvYCsrBaK1
         Ab9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790182673; x=1790787473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ijs+6l1Z4Lnz2cWqooyvDNYk6B/Cjo1CnXBD1Ikc0Ww=;
        b=JjkYbBrzfIpHFHkcivEd1rTidlNFx00ArknNboJSZP9Nyth6ClIwumGeYFLEHnok80
         bfNrZQx4b/eVJgy3ezqlkuyPjwF1qqQfZSYxMvp+smJufFKk3sa4Vm4W7QJXp7KlhkgF
         QJ9qM/J5IkqiPjPNZI618VQT+4y4CNlv/sTzC1mR7RZuKTk6djaHgcndC3MGRfI/7pum
         QgOvt2A5uv59QxbJiGvSbKZwjWcjkHylEMCVRbwSofk7ibvkO+O9gjGzktpRC68n70C8
         b3Dwwin/JhXzLvtlswLPf59ARMM8w5kD2/xpOeu1ttgweQZHuQVoWguYKmSeppzG4Lvd
         fvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182673; x=1790787473;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ijs+6l1Z4Lnz2cWqooyvDNYk6B/Cjo1CnXBD1Ikc0Ww=;
        b=ljAaKrMRDYfw9HMu5IZulHfVZYB57du064Ha9ofSZrediQmquNmQET7o0agNZ3QoLW
         JUlZiwnqtDBhinIiCwZjKFsQOV9FiWqcthdQX4d8Kd+EFfTt9PhK8+xmylr5ZDmJFgjs
         TqvX1zd/svI6tuvwhMG89YGOAFiYUle9gxPZd6RyJ2oCg+MJ9vO+q4t+RC7QTkrALlul
         6esde1/xHuvNnf/Ig9xAZs9eHIwEDRgvSPj3PpOJQBfGc9NjgrrYWoc3Mk1GiRyjKFF7
         xB2AdKQBFoDtNpV+OhvUZI4S8pVcmLlkoOa0jaIg/Xt6tyG1QVku2azxZix2dlrO6fB6
         tTuw==
X-Forwarded-Encrypted: i=1; AKwUvBy9pRaaFCKzBSf4uP+YFP54MLwihAO0RQNt/dWcghPEyQsVEmMb0V+7sl/yk+H0oBbqbyY=@vger.kernel.org
X-Gm-Message-State: AFuF++lqJVFlR2MarB2qSUc8AIAtzhYdML6nD3LVmAk2JtAOVqmQD2XT
	S+boPqnHjNGXsZDncPbPKmDjIFdPqfC6srwGoVZO9B9gsbHU+sME1P7PoPb1rTA2RhI2zckknbr
	2lLXYIDEx0nUnbJYhrQ/X5CCvaMl3B2fPfjn3hhRKbmCm3+MGosd+rt85
X-Gm-Gg: AYBFou0gqfvA75Txasfu2wHEViyRIxgi5grZEN0Y9cKRMt9ffvscZvLUSZ4x/aiHTGC
	x6ZWXuBC8nR6MvtznR2/my+jC0Kls/B1EQl4eeByWQY5Kik0ws0+KyZp0bi9PkBmaoLt5poRUdd
	mW5bOMgXjmUZIT9wpxeeEU7S8I3rDmpWbnELaCczRFS1jqrfTjmBRlp/i/wTo/gyHKFZrxE0OHq
	eIVJfOfOQ7uRD9qMsN+60KLmYfbE3NO0PNcEg7ZtqMevYtzzh+sOCRtEYeXMnPJ6EO9XZ06bjAz
	KJmGGrM+ga2iLRsw8Z9z8JWUiOSlw3b9AQNaWeB29XC/KZcd2nCpc9L8tuIXfiNUePbyWfPe9jk
	7V4EmV0YPuyY=
X-Received: by 2002:a05:6a00:2d11:b0:878:3783:8a83 with SMTP id
 d2e1a72fcca58-87d1d0b7a7fmr2881163b3a.53.1790182672888; Wed, 23 Sep 2026
 09:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
In-Reply-To: <20260915150739.284189-5-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Sep 2026 12:57:40 -0400
X-Gm-Features: AcwNN1XZMabSPPsGaBL7S-QH7qLqXRrYdrHmvEhiaqbQfwf82MsfQqNIw9dalxc
Message-ID: <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Daniel Borkmann <daniel@iogearbox.net>, dwindsor@gmail.com
Cc: alexei.starovoitov@gmail.com, brauner@kernel.org, john.fastabend@gmail.com, 
	memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:07=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> From: David Windsor <dwindsor@gmail.com>
>
> Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in extend=
ed
> attributes. For these LSMs, atomic labeling during inode creation is
> critical: if the inode becomes accessible before its xattr is set, it is
> briefly unlabeled, which can disrupt LSMs making policy decisions based
> on file labels. Existing LSMs solve this by setting xattrs in the
> inode_init_security hook, which runs before the inode becomes accessible.
> BPF LSM programs currently lack this capability because the hook uses an
> output parameter (xattr_count) that BPF programs cannot write to, and
> existing kfuncs like bpf_set_dentry_xattr() require a dentry that isn't
> available until after the inode is accessible.
>
> Add a bpf_inode_init_xattr() kfunc that takes the hook's own xattrs and
> xattr_count arguments, passed through from the program's context, and
> claims a slot via lsm_get_xattr_slot() on the program's behalf. The
> xattr_count output argument is exposed to inode_init_security programs
> as trusted read-only memory, so programs can pass it to the kfunc but
> cannot modify the count themselves.
>
> Reserve BPF_LSM_INODE_INIT_XATTRS slots in bpf_lsm_blob_sizes the way
> every other xattr-providing LSM does, for the life of the kernel. The
> framework keys the collection off the reserved slot count, so a kernel
> built with CONFIG_BPF_LSM=3Dy now allocates the xattr array on every inod=
e
> creation, whether or not a program sits on the hook.
>
> Give the hook a strong prototype in bpf_lsm_proto.c so that its qstr and
> xattrs arguments are marked __nullable. Both can be NULL for some callers=
.
> Without the annotation the verifier otherwise hands the program a trusted
> non-NULL pointer which it dereferences. Also, keep the hook out of the
> sleepable set. inode_init_security runs inside the transaction creating
> the inode, with a journal handle held on ext4 and btrfs and the parent's
> i_rwsem down, which is why everything on the path allocates GFP_NOFS.
>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  fs/bpf_fs_kfuncs.c         | 99 ++++++++++++++++++++++++++++++++++++++
>  include/linux/bpf_lsm.h    | 11 ++++-
>  kernel/bpf/bpf_lsm.c       | 22 ++++++++-
>  kernel/bpf/bpf_lsm_proto.c | 15 ++++++
>  security/bpf/hooks.c       |  1 +
>  5 files changed, 145 insertions(+), 3 deletions(-)

@Daniel, you were CC'd on David's previous patches, so I'm guessing
you saw my objection[1], but just in case you hadn't please look at my
comments where I requested that David's proposed LSM kfunc be located
in security/bpf_lsm_kfuncs.c as opposed to fs/bpf_fs_kfuncs.c.  It
would be really nice if we could sort this out now and avoid having
this drag out or escalate.

@David, simply for my own understanding, did you ask Daniel to do
this, or was Daniel operating on his own with this patchset?

[1] https://lore.kernel.org/linux-security-module/CAHC9VhTS7rSnBqg00ZxNkcZy=
h_=3DEeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com/

--=20
paul-moore.com
