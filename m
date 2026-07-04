Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F0371CE9
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144227; cv=pass; b=O1V4e/QL6eW10buQp7QwyaiAWBkNaooZ/eBNZIlqEPjxOlXtzp1eItVwn0Ystv5juulWOU/x+PEf7A+l231kkTo29Qfh1+EHU6Jos109r3iwbRU9+syvQeI4Z++rPSRXfvvHFVEhcYNePsZ3hW8kFsNLN1R+mYvXy2xTsditxag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144227; c=relaxed/simple;
	bh=ZRYk8rUc0v5PjnNM82oYLX9kGjn4ucYipOPsdxWXZY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/+s/4i+WIlueA7O21JVXPX26Q+oGmp1apxZ28jaA3tfxZSoHNR4pHP8YkdFBZIFRGNkNmn/ek2tOdIsDDBBI3iULmrpkn2MnqeRr3IP6oYf+Vk71RBVLBRnqAhbfgBiHQNTcZnN+9BuJxx8CiVHQRDmhSJ6ZXY/OtR4q6y9Q9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UICjz+Bg; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UICjz+Bg"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso732278f8f.2
        for <bpf@vger.kernel.org>; Fri, 03 Jul 2026 22:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783144224; cv=none;
        d=google.com; s=arc-20260327;
        b=J1KNf7YiG0YNEkmaUxF+Yn2HWXKS4jWWhBNF53M9gLUj/zbSFDqqqQa09h8krB8Wk2
         f7y3iRBAhijdySVMgotbwiSV9BLDE6jUOXwHpf8l3+qNYypJ/fhaqv3aockk9ZQXG6nG
         vG9Ba0bWyXOvPWfhXmAqAgFuNL10XPVk08pBW+DiJkDFp9MwATzUIy3rNe3FfZTmh0MI
         BiGX62F1lY54dN5prXyNNP3Cnkqyknp9HhofQGu+zOUIHCvl5DmrAlIZ/pH7BX8qou7U
         wNmrO5n3pkb7btMFWZatGBpVa0OHuyZOre2pMzFS+8cXf5Rx2sknOfMa6qmiIFcpeH1X
         tIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6+6YmgpaeM5juotgbcQnSfBdzNCdrt/VISxrQFcbQHI=;
        fh=c8fGKSXj7GHbu8c6WGf+KnzOsRFDyhvpHmmjjsMucBo=;
        b=WjP6RVs5WfyK1JdS+q6vpGN5om0aJqfL07B0mWatx5yJJISK1QA6dtdgaMCocz1s0k
         rS/1uanLwLMYOTslXjmDILDDeFr2Mhp8xWbUaBsS57+lqbCpHuuSp1n+c4pgzuNggn9F
         MJaG4KSif7fMpS57prSDiCTDLpSJ90WZB42kvmdJ7ENGXgX6znjySxharFLEKMyDhBOy
         OnwlFUcAqJHULH3tZlGHA0xH6xSz9xJIQ2B2hEb5+SvwHegb+ycCWBaBp79kT7XGP6hP
         2aU+tz6wrGLTZellWekDhHY9BP4bECKivtqnTlPTrB0t8FWlSQKLMZUesuc7Ta9fAvr9
         qtoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144224; x=1783749024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+6YmgpaeM5juotgbcQnSfBdzNCdrt/VISxrQFcbQHI=;
        b=UICjz+BgMiVkxsRUgIRFD7YiUTb0SqaX3J8Rh6llMBEZjZTFWs4lAClWnMhy8vJCv5
         UKEIqqq8RGFQsNEwR22b+LmHWk+sG0UbuQCPoeJHoatoX6GxnIVkMh6YEFxxmkvU/PXr
         +ifsOTrkLVQzJAiiOr2RSGAv/LGNDsj5QhQAdBtXItP4dU6rPAPcEJynKw13Hy/2yFiX
         q2w6gYwL3JCuIVYHgx2zakavJjo3+T0XeEGLvD6c/Iap35A83F9YxFmp/wevnUsPbNzj
         JlGFkcHt0wXhwxoU9Z0N/zXrpClyGP4H+oSMglGNT0auSEyzdanNsxYD54jpEtdw9kPi
         KOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144224; x=1783749024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+6YmgpaeM5juotgbcQnSfBdzNCdrt/VISxrQFcbQHI=;
        b=P+Tg9NbT8+F/BzD0ZgLdNWrD3lgeS1vFMpN4A8xCtJCUdldEkyH0US2faK0fImZbR3
         mSmIBA0dxxP7yTEcrhmLcpJeG3jTJuEZMvBGniI7KTEoJ6wEHst5oa2V6B39G84nweEX
         JnA6LpzuIlAimziv0BoowoQ0r0Q+0+Ivq/5qnsHT6Nz2/8abC1AV0Cwho49Cb5I2p0Iu
         9RH0o+SAbGzFm9ldKaBLyUJWdfR6j7VE0pGZOfOpx7Gt36idfsqV8pAyCr7Y2LZhYBEy
         ojWz3CnBKkt9+TwLZ5/Ia2kk63fAwsy7I3u4QiagxOTkcnAcSXnizEg44TSK9MPCe/5D
         j3gg==
X-Forwarded-Encrypted: i=1; AHgh+RplwqscKGnsgTSlYmtjOrxcQaUuWJU4X86T4YiMRDU6nhY7DJTbT3Nu6bhx4v2d8xxNOn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwm5mgd9VbTsGPEn2ScRdQ7TUs5miCZ0sP7Kob/42Bc6muiRTq
	oQqJElocIM9DOTU7yS/GjfOczWSic37ku3x/DsGeA+M8quPGDL/07zobsn5At2v2vPaWhh3VEDG
	n6wks94yeeHEcc303Q7TkB5r525GBnMg=
X-Gm-Gg: AfdE7cnPz9EerKxMvFtp64rZpZDyAjZS/3WAhN1FrxmvMU8tl5wYgtQlFHWDyREXhqB
	z5LqwJIvQ3ygJQ4v8JxhNVUKOw/Rsh9E4844OS7aZGqMVSBUWwoy6yWZcniiZRFiojfw0IhgV6B
	aNAeI9qZvgb1dkOmvqPq72RBLSyCUgHQW88OGLdwLhwJCIFUPJc0K0D4EvprGHPQ0XvfFMS7jUm
	MJE8O1sMh9cCLSmLXB3t7bXLUBHRUQ4c+tuy6say82KgPVjFZnNOV8GfOgWb/NiumTASA==
X-Received: by 2002:a05:6000:1acb:b0:473:975c:4fc7 with SMTP id
 ffacd0b85a97d-47aabb4cdf7mr2219612f8f.27.1783144223640; Fri, 03 Jul 2026
 22:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
 <29129c40-4010-4862-9b4b-3bafad874568@linux.dev>
In-Reply-To: <29129c40-4010-4862-9b4b-3bafad874568@linux.dev>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sat, 4 Jul 2026 14:50:12 +0900
X-Gm-Features: AVVi8CeSvpagGiT9Pdk8CHkTxPDqdZD1f9ODz7VToeC131JQxDxF1e8qrCd_jd4
Message-ID: <CAFk-A4n9U0r07tn6XHHqmOZ++-bmM4bSd-SwdpEU-88gjKts7Q@mail.gmail.com>
Subject: Re: [RFC] xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Leon. I think this is a much better direction than my RFC, so I'l=
l
drop my tracepoint proposal and support your approach instead.

Since a user-space dependency on the existing tracepoint would make it hard
for you to retire it, I'll make sure the Cilium PR doesn't rely on the
tracepoint either.

Is there anything I can help with on the new approach?

Regards,
Masashi Honma

2026=E5=B9=B46=E6=9C=8829=E6=97=A5(=E6=9C=88) 0:26 Leon Hwang <leon.hwang@l=
inux.dev>:
>
> On 2026/6/28 19:39, Masashi Honma wrote:
> > Hello, I am re-posting this mail because I forget to add [RFC].
> >
> > The bpf_xdp_link_attach_failed tracepoint (added in commit bf4ea1d0b2cb
> > "xdp: Add tracepoint for xdp attaching failure") exposes the netlink
> > extack message produced when attaching an XDP program via BPF_LINK_CREA=
TE
> > fails. This is useful because, unlike the netlink attach path, the
>
> I really appreciate that the XDP tracepoint helped someone.
>
> > bpf_link attach path does not return the extack to userspace -- the cal=
ler
> > only gets an errno (e.g. EINVAL/ERANGE).
> >
> > We would like to use this in Cilium [1][2]: when attaching the XDP
> > datapath program fails, surface the kernel's reason (e.g. "single-buffe=
r
> > XDP requires MTU less than ...") in the agent logs instead of an opaque
> > errno, so operators don't have to inspect dmesg on the host.
> >
> > The limitation we hit is that the tracepoint only carries the message
> > string, so a consumer cannot tell which device a failure belongs to.
> > This matters for two reasons:
> >
> >   1. Correlation: with only the message, a consumer cannot reliably
> >       attribute a failure to a specific attach, particularly if multipl=
e
> >       XDP attaches happen concurrently.
> >   2. Scoping: a consumer watching this tracepoint sees XDP attach
> >       failures system-wide and cannot limit them to the devices it
> >       manages.
> >
> > At the call site (bpf_xdp_link_attach() in net/core/dev.c) the net_devi=
ce
> > is in scope, so exposing it looks straightforward:
> >
> >   TRACE_EVENT(bpf_xdp_link_attach_failed,
> >       TP_PROTO(const char *msg, const struct net_device *dev),
> >       TP_ARGS(msg, dev),
> >       TP_STRUCT__entry(
> >           __string(msg, msg)
> >           __field(int, ifindex)
> >       ),
> >       TP_fast_assign(
> >           __assign_str(msg);
> >           __entry->ifindex =3D dev->ifindex;
> >       ),
> >       TP_printk("ifindex=3D%d errmsg=3D%s", __entry->ifindex, __get_str=
(msg))
> >   );
> >
> >   - trace_bpf_xdp_link_attach_failed(extack._msg);
> >   + trace_bpf_xdp_link_attach_failed(extack._msg, dev);
> >
> > Before sending a formal patch I'd appreciate guidance on a few points:
> >
> >   - Should the tracepoint take const struct net_device *dev (consistent
> >     with the other tracepoints in this file, and lets TP_printk show th=
e
> >     device), or just the ifindex as an int (simpler for raw_tp BPF
> >     consumers, which otherwise read dev->ifindex via CO-RE)?
> >
> >   - For raw_tp consumers the argument order is effectively ABI: prepend=
ing
> >     dev would shift the existing msg argument. I've appended dev above =
to
> >     keep msg at args[0]. Is preserving the existing argument position t=
he
> >     right call, or is reordering acceptable given how new and rarely
> >     consumed this tracepoint is?
> >
>
> Good concerns. I'm not sure about these parts.
>
> >   - Is extending the existing tracepoint preferred, or would you rather
> >     keep it as-is and expose the device context some other way?
> >
>
> I'm planning to retire this tracepoint. But I think I cannot do it, if
> there's user space application relied on the tracepoint.
>
> I'm planning to add BPF syscall common attributes support for
> BPF_LINK_CREATE, including XDP link. By that way, the kernel will be
> able to back-propagate the 'extack._msg' to user space, when fail to
> create XDP link. Thereafter, the user space library will be able to get
> the error message alongside the errno.
>
> Thanks,
> Leon
>
> > This would be my first XDP/BPF tracepoint change, so any direction is
> > welcome. I'm happy to send a proper patch once the shape is agreed.
> >
> > Regards,
> > Masashi Honma
> >
> > [1] https://github.com/cilium/cilium/issues/40777
> > [2] https://github.com/cilium/cilium/pull/46546
>
