Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904007;
	b=IaU9ueyhMysw2iryzGCce7VrdKFr62L8eG3oVSP9bVe4Lxf3u3TaAcySAZcKd2lnaI8/
	 k8guSzLyq28IeED40UmYsZ/0rmtbjHELwTWT3S4R7acuLbDKkw/sidFpIRy8gDheM7/FJ
	 Ye7rQL89l+7jjbbN9xKWki2eMVHN6dx6Tncz9xT73Ncb586W9qJ4sKnuYvGDg0iAGjI39
	 6Gitld4mfVSxWdkP1zBzweml+wn227N1lFCoygN8hCJUNwyW7I/AzPd9sFkOH0F7nN5Ew
	 obvPRQrIbj6XZkMBt7I6vZuRl6DOk4+1+BBQNtOX2IVNUvAVBda8vgc+uEpS2ms6gug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
	b=kGkeTWRsyf4tFDxs0DgDK1awzneJrD+9wC6rc4PlNGhvNd3vzmeB2rHSBvt54ZgLYBmZ
	 4ektmH/cQfOEFox/G/E3bDg5odKyCSJP93crhK7GWjjwOsJBVDKrJ6oQCVKTBFbqVaplR
	 d4T7o7TUDtVHMz5WwU33SZOjLWv3zLsT5qDTWchy6DSE3OG341zJakOLzjCl1rGXSMfVy
	 of6v3LAYHk9sZsAb3HCW6hrdhmVrDKkIWcZRiRenFy+Wc5zDcB2WGxhM+yoHfAN0A1eKM
	 naI2sqKMF6lfhhP8aXYEv9c5txWiCqIuA0AoOOP+h4IrpfgRN8GMh8YG2jK/YX5WwFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CED1606A32A
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 08:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CED1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a358881793so374286f8f.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 00:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904004; x=1795508804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=Bh3COd7ZzI6TmZdb32Fg462zWvuh7WQNnrUpXucHXcpV5t+t8gMfKKxOWwhkcHBcNt
         zIJKpUT9Ten8K9xmb0ZHj3p/ljeyNVefWtOpjWCo7Igmb/P1wzmYs63YOxLg7f+WXmDC
         wf3ao9cg3f1DrvZE/oBKoQiWFPBKSPnWk+jCT2CGoQgxeoDuJREjXd8oRMM0GizRyDLq
         q7c8W4Fdq61I08pJrjWNPm+S1jXNjmZ2MpEutx4SYZ/JoE6iRzvUZ/uRuGO7TyWDBzw1
         OlncqX8aSwrA8zDhY0Cn+N6eWM3qFfFk2ULf9A0Yk8lhKFDJjJXQbcxKbI+h6RZ2p0E1
         0Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904004; x=1795508804;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=jWHS0Ks4QW3BOItHz9bnC7hr/GnOmyy/Dyxd/W9wRjecWKtcevbswDkUwSGy7QBO8R
         ZPmGkoXBGUR5xQeAL/wmodjUP/r7gZDEDoEyQQj6HLq3G0N7WvuDBQ/BE8U1G5cegHNE
         6rZI0Bv9y3Stqf+EpPSZOtr8a0Y1Rk0rGK1vF9tOx9vKezISijQ6u7NveDmN4eOw8nou
         JpBDJlO9hkboHzHI22k3CD2GXfh+Jj3AU0AzkJLTCEmytLGWU+5ap8rOzShl19LvaoVQ
         9A/NaKLHOhYC1NgYMANkByruMzbWjD2GvuumFFZ11jSlfpDoFtEiqF69Tyr5JrjyJ/xq
         srtA==
X-Forwarded-Encrypted: i=1; AL+hErHGAp+7qA7jBcCVWT7e+e9lRDzFghXkK/9NgLX4Km2SK5BZljsLjg7BPX3vWGfz1mLukn0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Kw+YFUjz1tVy7DU94/X9VmLPLaWsrh0bd64dWua8sAWf5JANw
	EJ/+U8LMbN1grWdpiNu11SoL3tiBgax24CmCjV1LG3wdCiBouKizwC6I5cVEG3YxN7NV
X-Gm-Gg: AZFdTZdk8U6lhMfcjw/RpnW6Qjj7DhpDTTOzSaeWHAWbxniL+VD822J8tqd06CIyVPM
	6nQzBCzNb11XQW1cX8aNOgPXMEu9DTvwX5qgn/ymrI0ZPYTy8ZPxHx1wea0JRGBqvQ8s5OpUlff
	dTtJeOoFPAEf4OQNQhNsNMxUDoEelzTJ9QJu5JxxNcLGg2fjFMGfzugE+zdtCHZjGensjJR1j14
	Tb2srt10l7Dh7hcLh1C5wAtAAGsZ23VFxjpva7NB8q+Mf/Q8L0Ld1ko4XTZKHa7W0X82U55yJuN
	fNkGCf9tUXauwJkNDCE+RTJDrjsnYHHzt+RXuaUMNRjnPL9KagyQGQWHbnG4UTQNyoXYcDKpsjo
	3uaAUlyAOhLm6z0P6CTh+nnM6nk1am5ZBXkv9SB7nAnrX8dkH/oYxxCPQBp2wbqNWckPPBpYEDp
	FJHg1EgIvQQ8vhQEgoZnkVjOhi2YFF+f4FAOilOt7Qej8aSfCaABZQ/qiBjm+Pahx9xbAmsRXga
	ccoVAi/dcm+dcyoka5Iuizj9+FWLOyznn6vD7x9nWobNh6+lgj5w/nTzxHisEgeWKLZbJFzP4iL
	e4nXCzB72p3fEU1uS4lwnQpmsAkaSMMEXKb2jQTNpQ4sG74HSpitCufgMu/OsyqGjUg1gv3jpNU
	gQkT402tJAb5H5gy7p5GLotkK0Kshwbv1S2r4o5Y2s50TOk0Ks6iNofsp
X-Received: by 2002:a05:6000:2009:b0:4a5:2e5b:51c2 with SMTP id ffacd0b85a97d-4a52e6a947bmr243585f8f.29.1794904004601;
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm977858f8f.8.2026.11.17.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Message-ID: <c43d70badf41f62f8e149ac024bab3df979fa756.camel@amutable.com>
Subject: Re: [PATCH RFC v3 11/44] failfs: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:26:42 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize failfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/failfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/failfs.c b/fs/failfs.c
> index 437cdc981c2de..f03334f361c0e 100644
> --- a/fs/failfs.c
> +++ b/fs/failfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_struct.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> @@ -132,7 +133,7 @@ static int failfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fc->ops		=3D &failfs_context_ops;
> =C2=A0	fc->global	=3D true;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
