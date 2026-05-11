Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4E37DE84
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530788; cv=pass; b=Ga7HVvdm/9O1/oQFNm80chwEvwZmLNcRnNz3OLcf1kaoRToj7sBf18RguwxmNsydr0C2p0DK/giL2q8Ig8gXKNEkMLJAenBjquLFNLGPjJJNe3xNJHZWiMXEpA+RjO8y+1kHkvmbnWagqKpfSJoRK5HLfSfXVikvVOuwZueChoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530788; c=relaxed/simple;
	bh=K6ahRJJ0e5KDfR/InW9PQmfCdOV/MMnKBcw/HB3afOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkfMLKuxCefXSDONQSmRUdFtJax7egf+XxW15cAulxdBJ+p+YmZHIS46UjQBGsXUaiVoCO9HLxzjAWjRadZitinYTTEsSKkz40/ITQyHG26KFvVn9VkCe7r38EjKNhSDtlMwTk8qjJEmZWg/F6FmT8NSWMPWFkR/xAii5d9d5AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZOasl4M0; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZOasl4M0"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8016d642b2so2666214a12.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 13:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778530787; cv=none;
        d=google.com; s=arc-20240605;
        b=B+iJorv15aQw+EoU9K6Jbxj/4skfahtTCqJWt5j+Oks0vcsPi2/7cxhfPxF3R+/MgI
         jcXCPvk+slPpN63dOfu7povmfXKQCGRPMXVwSuHZka2Px+5FiWf18sdNUm6zqZ8s86Dp
         BZKNZCVBw5u84z/9+TDDN+GjzdJvxG88jeHnW75maseXgJtL7oXm9yGjZs7KMeJERPtE
         0gO4eTbEHTyqUGmK4g9jJZhSqmi9vMCCG9Nq7NRR/yGga0vnNQ2pic5akhmqbhei4x+m
         4JfrCpA+dXlt2tRScsa36Ic1ibXfehtVftlAWmMdofqy56HZL+2qhHwM6TONnbu0PVD4
         vwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0JbAuhTmAUh8SFVng/KsaglWkjU1Cv2MgFsZRvohMws=;
        fh=3e9PkLuxTFKLJC2IAdIVhP1Qlsv/cet/0C4pdokqX6A=;
        b=PqYJ14YYwpierEGnbEPAQcz+vXEL368e7ef9+QwhoS6w5ZWyezvxPjDDvwEoMUwGq8
         1QIarclGGvAT9cWzeQyygm2jVb7/uyRJYwEJ8U9KtAbZjJqLmoQRvmzq/keKp1/ttw5R
         28Ob5e2Pa7I8h+RzQyncwa/HDzyUNa3sbfnca2CIhnk29VDWCOkJu3QEZ940N9NHyppr
         uY/46uP1oER7FtzoZWsrdszYKsBBDe1iEFZ7XALGB8q6q4pKrmUnOPWPJKHa9bkllAPI
         NlBmLNB22LegyVArCfeYY0zAwKsCQ8tS7q5oIwK329H4U8z+rFxwSU+cu8BOpHBbZg1H
         04Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778530787; x=1779135587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JbAuhTmAUh8SFVng/KsaglWkjU1Cv2MgFsZRvohMws=;
        b=ZOasl4M02vdGq0CtzjM+mJSdzkG+WbWS2zDRXeT3zlmdySNNaKpsmRKaj/NozMmeeA
         4FBuv5gCY/kAmyaFd19D6aKtGP1akbARVnR3WlhARcP+pM+vtL0vvCRp5Z8/hbhuxB8Y
         G25Ai9ebx5/Uy9l2NuYRFOfPdTHbkJWrI3UVd0a6SROG+u1qQ6YchySwuAjbQ+7knXFd
         7wK44M85G5C1WR9QFG5q67FP4m9IbeW/mFVm+deCjCzVbIihKkm6VztMdE3nepc82M43
         S63Y911yCQ8vTV+FZpZ0ZL8BXXU8x+sHK/XrLzZHerG+If8gkHtfX4r0oEAmSymTw77x
         SLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778530787; x=1779135587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JbAuhTmAUh8SFVng/KsaglWkjU1Cv2MgFsZRvohMws=;
        b=aYxWcD54k8Fbk2zAp0WpMo1trONByfh5+GJQzA/Xap2SwK0tOG7j7Bh3IH6NYOfiKK
         zARFKpZoysC55PQe0PtmkW9ZZJBiuxxG37ShfKCvgbKX+6PqwTfj3vmaGEhudJm9dias
         4RgKOtdhDTR0NOzQlYqXNHvALuUMO61tRUwI+LkRmZISecR95QPLKN0eZ2qdcu3ZJ6b8
         8lq56wVrmyZze7NxfjB9LjOOSlzbyEReoD2B9WbRcVhBIxfPLQ3/vyfpzPloNl7AQRjC
         sDm4sHR5Bxi1ehSC9gTgA7caxOIiRtM6BAKlRLdmR0fWEcWTLtw4w8jZJ5PMVDdDLAyz
         DKDg==
X-Forwarded-Encrypted: i=1; AFNElJ+d6darHijYA+MxxHD0OtHXRRzV0wwMsXa+zMmVPo0KXAp5STjykNE9O+90hrkZCkz1auY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwirRIiTGhWHk11ZuqytIJqRUyJ3D/giTILIrsmVbzAAYOfdCdc
	XjjdNhQKBK3bGsJMoYX2FjjkSqSQS2W9V5gZKTXEF8y00GZiFBw2eK4UkewugeV9yCb99H2RpwM
	9NIOUT1f69pjBTe9bg4D1HOIFJHt5Bbwep4bfwEYu
X-Gm-Gg: Acq92OFanEj4qLGauE3Ckgadujrfnjqr/dAZSiT78qEjK1mu5J1GT0qSIfVPSI0cfjp
	s4CgaNFnDx0GYhZB1Y2GoPewdTrJ/vCEkSLXAddpXznAz7brS8Ly8TMK2hSPVr21l0mZyVBcOp0
	RQcDaVlbW+4/MIVrmVlkEHUQgzp8A13QEBWsBjHH94QW7gCBu+wUHCZItomZnrxAAMoChdx320/
	0HNF/UhqxdoemgELbiB2uyd35muB8KqoWCUu0+IhVJnRAY8r9OkEUcYncShnS/UGErpCM9zd0bY
	+oDGDSU=
X-Received: by 2002:a17:902:d294:b0:2b2:ec33:cf15 with SMTP id
 d9443c01a7336-2bcfcc3cdd5mr5383065ad.7.1778530786540; Mon, 11 May 2026
 13:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agDuCdGIeM-6z-j-@altlinux.org>
In-Reply-To: <agDuCdGIeM-6z-j-@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 May 2026 16:19:34 -0400
X-Gm-Features: AVHnY4I9tIhrxU9BB89LwwsmZTDJPrnnYPaBxKCsIK682ecgTABjXJE_lLrFyyA
Message-ID: <CAHC9VhQ4VyAvG-z2h2NFpPx9PcJP4Ot2Ap=MPbCRk2TosJWOTA@mail.gmail.com>
Subject: Re: [BUG] lsm= with bpf before selinux breaks fscreate with EINVAL
To: Vitaly Chikunov <vt@altlinux.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 5:17=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
>
> Hi,
>
> We have boot failure when CONFIG_LSM has "bpf" listed before "selinux"
> (without bpf lsm scripts loaded). (This also happens with a boot with
> "security=3Dselinux" if selinux was not in LSM=3D list but bpf is.)
>
> systemd reports on the failing boot attempt:
>
>   Failed to set SELinux security context generic_u:object_r:device:s0 for=
 /dev/shm: Invalid argument
>   Mounting tmpfs to /dev/shm of type tmpfs with options mode=3D01777.
>   Mounting tmpfs (tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATIME "=
mode=3D01777")...
>   Failed to mount tmpfs (type tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_S=
TRICTATIME "mode=3D01777"): No such file or directory
>   Failed to set SELinux security context generic_u:object_r:device:s0 for=
 /dev/pts: Invalid argument
>   Mounting devpts to /dev/pts of type devpts with options mode=3D0620,gid=
=3D5.
>   Mounting devpts (devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=3D0620,=
gid=3D5")...
>   Failed to mount devpts (type devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "=
mode=3D0620,gid=3D5"): No such file or directory
>   No filesystem is currently mounted on /sys/fs/cgroup.
>   Failed to set SELinux security context generic_u:object_r:def_t:s0 for =
/sys/fs/cgroup: Invalid argument
>   Mounting cgroup2 to /sys/fs/cgroup of type cgroup2 with options nsdeleg=
ate,memory_recursiveprot.
>   Mounting cgroup2 (cgroup2) on /sys/fs/cgroup (MS_NOSUID|MS_NODEV|MS_NOE=
XEC "nsdelegate,memory_recursiveprot")...
>   Failed to set SELinux security context generic_u:object_r:def_t:s0 for =
/sys/fs/pstore: Invalid argument
>   Mounting pstore to /sys/fs/pstore of type pstore with options n/a.
>   Mounting pstore (pstore) on /sys/fs/pstore (MS_NOSUID|MS_NODEV|MS_NOEXE=
C "")...
>   Failed to set SELinux security context generic_u:object_r:def_t:s0 for =
/sys/fs/bpf: Invalid argument
>   Mounting bpf to /sys/fs/bpf of type bpf with options mode=3D0700.
>   Mounting bpf (bpf) on /sys/fs/bpf (MS_NOSUID|MS_NODEV|MS_NOEXEC "mode=
=3D0700")...
>   [!!!!!!] Failed to mount API filesystems.
>   Freezing execution
>
> 'Invalid arguments' seems from setfscreatecon_raw.
>
> Reproducer:
>
>   Boot with lsm=3Dlockdown,capability,landlock,yama,safesetid,bpf,selinux=
,ima,evm
>
>   (none):~# cat /proc/thread-self/attr/current
>   cat: /proc/thread-self/attr/current: Invalid argument
>   (none):~# echo > /proc/thread-self/attr/fscreate
>   bash: echo: write error: Invalid argument
>
> This appears to be caused by security_getprocattr / security_setprocattr
> iterating until the first hook defined (which is bpf) and returning with
> default value -EINVAL before selinux even sees them.

Thanks for the problem report, the general recommendation is to place
the BPF LSM towards the end of the list (see the CONFIG_LSM Kconfig
help text), but we're trying to ensure that the BPF LSM works properly
when placed anywhere in that list.

My apologies if you're abilities are well beyond this, but if you are
familiar with patching and building your own kernel, have you tried
changing the LSM_RET_DEFAULT value for those functions to zero/0?
Assuming userspace is happy with that, I believe it may solve this
problem.

--=20
paul-moore.com
