Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCA3DCDA0
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705022; cv=pass; b=F9MrNXI2GN1r1+T2eqncMQeA60cEyevECSPm0qip/p2gSVjA4dpN/U23MT62NDXCShRr9206GD7gpEsc0xESJEVgcRHsfNx3GJ4w8XSMrZswtKcwgXZCOiGr982oKkJtXRK6E3zddLBENMcgnVxWzURajBfYS+9CX/DINWbo4Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705022; c=relaxed/simple;
	bh=66NPz0C8eG0KHGSWeidBwsifxHr9iMvd7btjXL3I6t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KS+KnZqUc3Ish0HP0nx/h5jS95kY7iDA39/jD+nmU6Bp7T0lJh29HGqnVrL1FmFi54T5S36QSO3d8APFTAaTeQjipyquEu33YJMVNdo9X7gTnhLcD4UPaqP7F4Lvvw+VdnfkDuVURQGFLLiyETwgmMXSJNtMYR1I1AjtB3ISNhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZ3eNak/; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZ3eNak/"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaf8415866so5871369a12.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790705019; cv=none;
        d=google.com; s=arc-20260327;
        b=TLrFuLzM4JGZot9qlBxlratQX06ZxFEYkAWSH0GuRmdXXalZI33QzjmSAp+CBzuYAR
         EQA+R++1jg8HnbwGPws73rcha0rieAQ1F1qna4PKkDgpjDxfU8j8o6BxYPmiDHswRMTM
         OSv6fqSu3HJpIYQ6M7buiR56nSahatvN7pSr73mpKgtnbtidewsH0M2vOd+QG5zmIrTw
         6+cW+NZ55xXRdTD/aL/fE/3Y6iI2iU1vqOCsyxKzPgyAekeReKR3jG4yLQtKhNPFEEz9
         TpO1g3JTBffmt4sfdqd2YZu1pLkncqpEfzStWxGfym6JmA89dQQbPZcmvvQYPSoeEhkH
         UD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cx+hvzKqglq+4E86uBoiNqYHk0FJfTWAwibQaEI3f9A=;
        fh=n8HtL/tQYsg6uYl56l87VWJL97Mga9jTLSdYnf8zSJI=;
        b=s8+tQ5zJdUdNxFbmfpLT4m1GKi7hf4R9MoWkDUyOQ2TUf6iJWQWKxDsq81EnzmWjvr
         I2ySaumoGrNMXjiuuBtnM/hcJXWla41XzmcmH0AxMAeApmGS2Glxox8HauYWQmPytbEA
         k3TXS5ofqLw9M4UeQNh17fPA3ioEPHWWq1PzIBXY1j/DiObACOCwtkEDMzb6Ba74+09g
         N2zPzxkxJEXuCHHDxWSl1+MI8sH8p67co+zz4xC5HRnBU1yQAK72Q3R4ug3wTagZbg5H
         4zlEOhT+zOkRiNh1XYvOFXZw0SAW0yYBQveToU4dz26AN2sdg7nT3CqXhpooifgDKyF8
         u+qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790705019; x=1791309819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cx+hvzKqglq+4E86uBoiNqYHk0FJfTWAwibQaEI3f9A=;
        b=HZ3eNak/DKOJPows8YaJ8hUGPD74CpsdmBBhhS/pws2y7XTwxXcgim/XCd69/GDi2g
         aW0y6pNYCYkIn3YgUS9NrTISuyvJyOALivXZHU3NCmtFvI2lx5g+r7lPzmiSjghQXmkt
         yYLv9FqXEDRiW0ki0zT976ELXQP1A6c0eWD9bxTZ49f/MpXUBPL9I16Vlothp+nlRQKu
         5JWYeyuI89Q73YA5HJY9wyKI5VfqVutemcGQg7sq1QcX/uSlqTquZkMmgh79MGYtdD5S
         F4DZpcp1CyIaaqf2CobxZDrL5zLTYauYaUFUaXLRzH14TOawFXqnC6Uh8NGgwjsfODQ4
         OIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705019; x=1791309819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cx+hvzKqglq+4E86uBoiNqYHk0FJfTWAwibQaEI3f9A=;
        b=rrOW7rKjhE7ME5d9J8T7d+1C+lH89ySvQoa7Y9X3S3FzkvdbgHd2e35FsswDB/ofth
         +8jbNuEviAWjpvpAuvprJ3/FLB66K3SJlxf//7GujYPxj1HtVIcGCU1y+65dNip7xSFl
         UZ3wwe1MPqtIDdm08Xbr3zL/GNQ5C2ScdBjeaJXeiCiDJfIy4SQ82rv/rN64nuJiXLsj
         97PCzp4xqZsr1yx+UhdtqKQrNaiH17HtgW4Rx0bU1YDlap8B6xeF5b5gdw+vuJG1ax/W
         VA0GMaRow3Tk8u4TUnFd+1188+JqBzfIlosPNchNQz4nBg3HQODwNxsGHoFFzb+CrgdZ
         PDpQ==
X-Forwarded-Encrypted: i=1; AKwUvBwx+9qFgrVp1juIzSzdqT8taGZly4zX++zJxg8sPh1yxRplHVdloWfZQqQIQ3z5EgCkSSM=@vger.kernel.org
X-Gm-Message-State: AFuF++n1i4VRXTkaonDblDcfgMjXvRj2H6DznMhvbp61pnXftxAgxJRX
	qkjRZa/8HFw+RfRV35O0FTmH1EmmTjkMtk33VhO+pb+59GClmSVJkGOPMCTjJy0twhhTUUjOU2Z
	/SzmsOVb7R2SxbipD02FsAYWnzmj4fS9kanZMPamH
X-Gm-Gg: AYBFou1cPjYzol+I92SsRPyOk6ECaRolvn8mbzXXzxH1Wl99pxiyeM6EguSpMAogMIw
	z34L5An4xcpZEOAQq42WGBBTaKo3z1fc9BgB29Cl0RwtQj9c2vNHCi6rz+k8DuLKoj3y+DLdynW
	k5iJ5O9HmsZTH9zXlKifF7F22p99uh7goFDxMRNTYvAhO+5z90nsO4gRvjK8zHHN9udEDNNYYP5
	hhFOVHWTd3+dQe6sDTgOkRNYhxgbtdlMBJqIAvbZGPa+mfMp/gZ38YumUZBIkYfAJgu5SQXVgJ3
	+8/yTOMCgwNQwPu47/hN9L609Rsn+NLptf6ae76OUDixcez218quUFvmLA==
X-Received: by 2002:a17:907:c408:b0:c26:2eee:ffc7 with SMTP id
 a640c23a62f3a-c2e1588b329mr24041666b.35.1790705018647; Tue, 29 Sep 2026
 11:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924185316.2831077-7-hramamurthy@google.com>
 <179036256202.2160803.12978678207911420221@kernel.org> <286547c9-9f4a-4202-a615-b51d42850951@redhat.com>
In-Reply-To: <286547c9-9f4a-4202-a615-b51d42850951@redhat.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 29 Sep 2026 11:03:27 -0700
X-Gm-Features: AclHuK8gnKhB4zG1JHYYcGdrp3cm0c0-oSpP2e81va5MA8TRCBQ1L_AaXhWMhjM
Message-ID: <CALuQH+Um-hzm3UTsG35+c5AX6RuW2x=OLYq=GOpgK8fR4P7FMg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 06/12] gve: simplify reset logic
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, hramamurthy@google.com, 
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	jordanrhee@google.com, willemb@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, jacob.e.keller@intel.com, 
	debarghyak@google.com, kees@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 2:27=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/25/26 20:56, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 7 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 2 (1) =C2=B7 Medium: 2 (2) =C2=B7 Low: 3 (1)
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] After a failed recovery, an unprivileged user can crash the
> >    kernel with an ethtool query.
> > - [High] When gve_recover() fails during a reset while the interface is
> >    up (service-task reset, ethtool reset, flow-rule timeout, or=E2=80=
=A6
> > - [Medium] gve_teardown_control_plane_resources() (gve_main.c) now call=
s
> >    gve_teardown_clock().
> > - [Medium] The commit message does not mention several user-visible
> >    changes to error handling, and one of its design statements is not=
=E2=80=A6
> > - [Low] This patch removed gve_queues_mem_remove() from
> >    gve_queues_start()'s error path.
> > - [Low] The commit fixes a real unbounded recursive reset but has no
> >    Fixes: tag.
> > - [Low] Item 2 of the commit message describes the old bug this way:
> >    gve_close() during gve_shutdown triggers a hardware reset and then=
=E2=80=A6
> Low prio remarks could be ignored and we prefer no fixes tag in net-next
> patches, but the first 3 ones in the list look relevant and should be
> addressed.
>
> Also please note you are supposed to address clashiko comments proactivel=
y.
>
> /P
>

My apologies for not replying directly. Harshitha ultimately replied
to the cover letter stating that we would be sending a v9 to address
high/medium issues, so I thought that was sufficient.

In any case, I will add a response here for the planned fixes for v9:

> - [High] After a failed recovery, an unprivileged user can crash the
>    kernel with an ethtool query.
> - [High] When gve_recover() fails during a reset while the interface is
>    up (service-task reset, ethtool reset, flow-rule timeout, or=E2=80=A6

These first two are a result of the change to teardown when recover
fails. For that, we will avoid tearing down when only queue creation
fails, and call device_detach when the control plane itself cannot be
set up. This should prevent any ethtool IOCTLs from going through.

> - [Medium] gve_teardown_control_plane_resources() (gve_main.c) now calls
>    gve_teardown_clock().

gve_teardown_clock() will be called as part of
gve_free_control_plane_resources() instead. Since it is only freeing
memory, and is idempotent, this should be a safe change.

For the commit message issue, the commit message will be updated to
reflect the latest changes. This code has changed quite a lot since
v1, but the commit messages has not seen many of those updates.

-- Josh
