Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524A334374
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683796; cv=pass; b=Rw73dRuRZii/QO5rt728QccsIfVErEZyZ0E0aoGX/BX/dCape2IOEcUpnB3ogu/yT2qyydVko9GtgjhSf+kfxya18TNbRWRDHD6xLtR3RyT36fwjIEu86fFgQQPHnU3U+QdnegBSGkBaoP12S6o0VqdEymH3+dXQeaHmjlHzLKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683796; c=relaxed/simple;
	bh=I1vbAzFZtc0KG+gZfLVD1SzRI7ZL+EQR3nZxbZkmL9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpQSdpyaXk+IL0Ul1nkDZ/KHJvm4TvZPo6mOZ+bT8DdJc7o1LLkIWuJM1IkPIx9J5st9lNE7DKu2NECIh4x1rTvHOuGHSr77ninXtVppyjdKz9fCtrU66QSDk/PPmxw1c3k3A5N2ja2Cuy0exaf7WprkOnwcrqHdJ0el2Gg6EV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbqNu+T5; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbqNu+T5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so5499985f8f.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 10:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773683793; cv=none;
        d=google.com; s=arc-20240605;
        b=YXEzfQic6zSlf/xrKNgQ5ahen3aHx1fTVPWI4n1FGh/kTJSZwh37vvv4ddCceaw1Yn
         pxVTyFtzedkRWKGb1lgAzdcmnWWrx3isGpda4iOzUvUJZcutAIUzW7P48LB5fOl0jiP4
         /oVU9vBaa87vG1G2O6kTmXqgiVy1m2pxQg7RC+Ppahnd0ip5qwY9SYtK5wdYcKQjcu3G
         o/PD1mNc4XkqorcFrWP/yhvbBHvsmuyBlYskfz9Zd6XlOXO1Ig0Th5HBYBY5qRbF83y5
         A1L1sg+VkJm5V9jX/Sodna5+Kt9GxcgymeFcSG+UIrQl8TeHa3mMiBX59YmYzu6xmSNK
         Im1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nLN8x7h3gKI0NxYeYvj5GuYRQATdaCAiSq+73Q3o4Nk=;
        fh=T/bq3F/bbNb2L8T7ccUB3YipRABtsW09HD8UGH7rwPQ=;
        b=Z9HIZqB1ebZFE5aoL4If0Qnd30MTTx/VWHTXN6V/VaFSecdXkHfLfaXM0Ktilx+BFU
         d+CLUV+a6Vyzsy84sFFIM+ey25F9tf5sHJQfnxdk7sArpzR43a05XQLH26KPuuYCpGxT
         hEx+GrCDX1xL8K+t5i4yOIXP2wCqAKuQ3tklJmnVAtVpZFmw+VdbsyNN9KCv4Qcjachu
         rj/CytTXnhzy9ORKBXK4zXYJxQuSS4gNKTlp6lK4dVukW3HpBhqSTxJuLtp4ftHYNt5M
         +6wZ8rMxQgrucT8TUEsQsLyypWCBIOAoXFBMennVbhLegpYLYbrHmvZ3Li2fkAZW/LYN
         4ZPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773683793; x=1774288593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLN8x7h3gKI0NxYeYvj5GuYRQATdaCAiSq+73Q3o4Nk=;
        b=VbqNu+T56XiJ5b6lsaCKvhkwWlyWO/maLFnOJHzDC2lyZ1i3OblWQqeaP2TokZTtco
         B2kbxC1MqknfA0jskEMTyn/BudH6NvwOU1WVCbIEt+eHcn/wGfGe5he8OpSlbouIgsP0
         zJHKHfYYbdqxqVj6XNv1ckge+NSwis+kPk3/Itz2KCPROhV97+GBlt01SLLhG41cqb6I
         htah7i1/JVmrHTjQ7m7S95XVbK194A72YT9ts98q4tBiD/ItplDdP9V7Ox28VXW3n94Q
         +JLOg26S7EaP6u9UwCne+Xr9+MShZOw1etgkpFpQYTPSw+D/y8Otsd/+Sw/I4vcAKqoc
         KsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773683793; x=1774288593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nLN8x7h3gKI0NxYeYvj5GuYRQATdaCAiSq+73Q3o4Nk=;
        b=g6BcUz2KUZk+hEMfnafnbLCgCwKHKdvLayP2FuDVpmc4HQpfoBv22zTx6glKRMPkGs
         nh6Bde90aKS+72ED3uG4Db/jlLvZw6SPBRahDuabcDIPLbWGCb/sT4fvPwUbQg0PDUa0
         gr8VOyRZw3tKXlsPZFFCBTCha5FvIlY/PSeUeW7BRSKSkLbhaMAosXaqwLQqWYF9WdWm
         T9kTx8iB8sqXTZe/T7j3xczKLD+af4apc5jiocb846jDYu3bTR2P1XTo8HXiMNZiEc4F
         4Wie/QmzJx2B2oIDJRgVlC4pcudmOI01d8oFd3ASVMjvZT1CJkMg8SUgHPjYqIVF88e7
         CyHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhH/GslIFGqIIZ3JAPHvc9QO5Ou6B+/ht4ECMyCEPR2BUOxJYwc1LDEBZIXfyBJEOMg90=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywui7JAjAVqIvj7iMIRH4BQH9oE4BHg7D2r5IN/BZ2Clg68oJ04
	+e6Ttyl6oMF4FYCEkmRg8cTmCojj6NB4gDdscWSCRYGgmox65Tdw9ILSAEBtrVTlfEH5bJ216qw
	UVUhcqArLQeU9mEYzGpsy/qAXkGmU8WQ=
X-Gm-Gg: ATEYQzyaioNA+DPaq41UqH/xGhmy7eK2Gjp0cMZ7rdG6FqIYwU1nD3qAV4c0zszrCdr
	3H7HoSkFBSRkiHR+o//Xwh5QmlKitlNz86IP+Jg7xjV9Byfp3Ytwkcxv8mN99hqt4u77e7WQmh+
	cnh4GxrZlE38O9C53Hrjg/yiaCPYZt1HUJFtZdsG3KfBOZJRnqVQkK2bsh3KOHsQmTfPQDOFBXr
	m3C/EAb3JXvdwQT4bLqSAeTFw22gdkQUzl+zuKNvxUcf/jPwzsq4bTbamtfZobmPD8EPvfpPnWJ
	G8zFKw==
X-Received: by 2002:a05:6000:1787:b0:439:c6d9:7fc with SMTP id
 ffacd0b85a97d-43a04d95261mr25316775f8f.25.1773683793152; Mon, 16 Mar 2026
 10:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223224617.GA2390314@frogsfrogsfrogs>
In-Reply-To: <20260223224617.GA2390314@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Mar 2026 10:56:21 -0700
X-Gm-Features: AaiRm511WAGRtITI8RxyWj-xfdb_uS3eh6Gi0osoQrCb5u55mxyV9n1ZU3-bjXI
Message-ID: <CAJnrk1Yd1J60-Ek=O7jzZQg454pbr3O=b71yZHzYbrWfqJr__w@mail.gmail.com>
Subject: Re: [PATCHBLIZZARD v7] fuse/libfuse/e2fsprogs: containerize ext4 for
 safer operation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org, 
	linux-ext4 <linux-ext4@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, "Theodore Ts'o" <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>, 
	Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, John@groves.net, demiobenour@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 2:46=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> There are some warts remaining:
>
> a. I would like to continue the discussion about how the design review
>    of this code should be structured, and how might I go about creating
>    new userspace filesystem servers -- lightweight new ones based off
>    the existing userspace tools?  Or by merging lklfuse?

What do you mean by "merging lklfuse"?

Could you explain what the limitations of lklfuse are compared to the
fuse iomap approach in this patchset?

Thanks,
Joanne

>
> b. ext4 doesn't support out of place writes so I don't know if that
>    actually works correctly.
>
> c. fuse2fs doesn't support the ext4 journal.  Urk.
>
> d. There's a VERY large quantity of fuse2fs improvements that need to be
>    applied before we get to the fuse-iomap parts.  I'm not sending these
>    (or the fstests changes) to keep the size of the patchbomb at
>    "unreasonably large". :P  As a result, the fstests and e2fsprogs
>    postings are very targeted.
>
> e. I've dropped the fstests part of the patchbomb because v6 was just
>    way too long.
>
> I would like to get the main parts of this submission reviewed for 7.1
> now that this has been collecting comments and tweaks in non-rfc status
> for 3.5 months.
>
> Kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/=
?h=3Dfuse-iomap-bpf
>
> libfuse:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/log/?h=
=3Dfuse-iomap-bpf
>
> e2fsprogs:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/e2fsprogs.git/log/=
?h=3Dfuse-iomap-bpf
>
> fstests:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/l=
og/?h=3Dfuse2fs
>
> --Darrick
