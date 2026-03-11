Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823B3644DD
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189439; cv=pass; b=c++uf0kXF/8ulqpqIXlh8yM5gLNGun4yIurInFokb0e/RYj+3PGS6hvCE9D1cWNkE3ZuMMaQSORiMDVTa2upB4HR/F4ufMgc4UhuJgB9cEaPHQccjlNen2qfJb8JdE7bQQy/ZMknQXHAwOU8QAg8zv4SEucR5dVWm0LDJmp1EQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189439; c=relaxed/simple;
	bh=qB2Y9UmS3AGYwZt5ou15zHmd+DF8TtbO3BwMKq5EH/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kfve83RuIUUFISWtnbclQCNhMxEK4BgPD544DT4N/EA96Aam98U2sdMnqmIXBqr2ppeeXUzBG2qIpUrEluWB8VoBj5252quCwEh5I1dE5v+azIewU8wDMdwbi6MkvA1jl03OJZcTDPjTR/fko2clAMJWjAw2ynRa3QNDbbNSfAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz1k53Z0; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz1k53Z0"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso6652608e87.3
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 17:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773189436; cv=none;
        d=google.com; s=arc-20240605;
        b=PnYeMeu+PFDUqQCawu1ERmlH8s6bSh7pZjUFexZ8g7EFwuS/ubF57rA76uPBIvAhyf
         1bIG2ut5kPXP3gg5w9jqaE0IvDAySDUt2Y00YK1VkdCCuCxYuLwEpecCiIVvR27qRLZH
         DFFxi42j9vagPmQIqoM992z4ixbffTSdgcndzX/befpH19Ffx7mmKIrIZllZo5d8e3is
         TVPZ8WoSsL9P+ksNdiJ1TFTzENNxZ9SBf2be/pSLP6OW7atFPZ4kFdqNi8CBhfsn2u/2
         KOmDknndfZxeIA55i5zroC3INjPOQFMaVfWGzzIesXnVYQQBfi2U2rkpiw3PljCvqIhM
         Vgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qB2Y9UmS3AGYwZt5ou15zHmd+DF8TtbO3BwMKq5EH/s=;
        fh=tVfTTMJdJpv4VzFd0wHIpO+uke8xnIi5UzT6jDPGcQg=;
        b=CDK1E3eSVb4I0Aijfu+pXJIeb39qXmUo4xN7FBcudqfPw8EHDxZBLyTcVMO7NRuZt4
         gYRMwWp/yf2r6uIZ9kOIdrd6QNbb4DcBwaT/XKLdlfCs48ZmuSLQuJmMUK5ixZk0wzGt
         kR0aBsfI7FnfO0h+MJWDeQ40rE1kvdyqW3IrZ3Hg569NgAZD3BUkbrK6+1ZH7gC4oiUP
         +R578ohHaGdcXSWczbAYHAKiSzrF1Kx2bpHpbClLD3HbViTfMUUtU2+K7zIy+EySgrpO
         U56hMB4pQr/fWF+6RcVMl8XmuS7YGcKvKinIFiWpPrZTSgGIN29E32C/VtD25pIPdW6y
         YMkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773189436; x=1773794236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB2Y9UmS3AGYwZt5ou15zHmd+DF8TtbO3BwMKq5EH/s=;
        b=Jz1k53Z0FHFzA49AV7XnVztSZl2QXneLkgTzK/MyPWhwiOIyr5ez/yLelhxBPE88vq
         c48T4eExpH7cZL0OEOW6Mno7DwSzWEJrEllkGGIGIF/DuCaMyd+Z5otFrMuFo8OZJR0Z
         nFIGi3RcFjEDDT0Rl4mGzZCPsVoIGGCi7639oTdt11RmHSocCnnUO8nBYXHN15fU2VN1
         2jIRYxzojHQl3pHhLoAkApl4YmqkyFFt1/yRxoHBE6+PxtXhwYO3fKBzWwzpMkPznlc/
         1O1zyJoD7AN2JhWmHiiYrD4jVon3gOckWF6P4iBEDav+mHioddVwbnLCxbfhLzt1VNqk
         ksBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773189436; x=1773794236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qB2Y9UmS3AGYwZt5ou15zHmd+DF8TtbO3BwMKq5EH/s=;
        b=ruLAyCaisPkvc7Tg1AMgqSz7+bhcVDbT9afUM5ZZRnR1N3a9dgYwfksvVjK5uyRojk
         +g3JF0/6JNbQxwynZrNU33VJSPQ0bgfBEC4s0OR+ah6/ojo2U0G6Y353zlEzJbs1Njog
         PVOZVpdKq2ozsdus2vNKCKMOscw0E6SS7LurrSAnR8FmOAAo2Db6GiXlE1JNRIV4IVIr
         aknGh2xDK09ockCEk+BFdi8SaSBAUGu3AeFSc/I3u0zY14yqZNfjmhS87BJp10o/3tzK
         GD6zbCUbhsYH/WP4HwelJ3PLSck6sjcAStnTBx4O9GNYJXByGnUyDYfgG39TacRwTaHP
         HKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdeMcgkLfAtvl1g24mN0Fu0REtw/gOjlp9zKkQPTeSE1F3iICxyCgs0Y/YcEqPwchEzL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdqISa3Yi3EtddLSQIZhc+Oxn2fifI739c2W7XeI+W7wfI3hHh
	VLnKpHlPqGdi+4+/UAx1dPVEVmOvH7tjYjaYFGSxVOdDWPjl5cgiWEDk72FsOf7KBw+1vrqTGAQ
	3tYuKDbFrH7aZKkWFtk2arwH2FcFp64U=
X-Gm-Gg: ATEYQzymTnTDyYE8c54n8lDvBylJbwGATvzuUqWOGOh+Y6oTd6aEZU9XU0UCxmYSSzt
	8Si9e2LQY1lO9UW6iYq2PF5+OklzpjdB7H/8E2r1n8Gx3CEWzWcZzDuWX16lOpDxxQD1xujgZkP
	i5RYmKzeJlRrvFpElly7yFuNZqKiTCVUSG5Z1+D98u77fOt2KiBHVe9tpbwGXw5DqlUldHKo7xL
	tlNPCKKG/Bc0g7FFN8oNqDF+sI35PvTuHDjbJYdus6qsi2rK+uNA0ZR/PALIl0Wfn8qPeP9XXl5
	Gj9qtNJOfcV+s/Jq2A==
X-Received: by 2002:ac2:5b52:0:b0:5a1:3f63:c7e2 with SMTP id
 2adb3069b0e04-5a156cd0940mr124426e87.26.1773189436194; Tue, 10 Mar 2026
 17:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 11 Mar 2026 08:36:38 +0800
X-Gm-Features: AaiRm51sHV0zYJIAPWsSjsEAUdn-xyam-DpjW4gRVLnnnDHvbN21UgXe1QQXnuM
Message-ID: <CAL+tcoBmggp7USbD_n4oq3C1rLduejPyn+OgSbV_H-7vhyndmw@mail.gmail.com>
Subject: Re: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer
 Rx processing
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 11:04=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> full") addressed a case in copy mode, when working with multi-buffer
> xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> there is a space to produce descriptors.
>
> Adjust ZC path to follow the same principle.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!
