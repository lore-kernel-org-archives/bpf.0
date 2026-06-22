Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ADF1643B
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782172168; cv=pass; b=pGA9/FJeba2K7b7CTypTg1Z0lnBxSIq/mtiq9SRzfgEM7weuHNJk34yJyxnRide5qPNNFb80kEyEN8j5HtGbm8a+t3c87Xa+qbRFzFwPfqivPGoGLMPajeHzkvaJYFdAKOFu0qZPolJ2F3TlrVi84hT9U5qx5ZAJCT+L6F3dw70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782172168; c=relaxed/simple;
	bh=adOwapYg7+gUvRoqCaWAFG19xXjx0M8sahK39VTKig8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxhelkXrtFO6hy4AwgQeS7ThO4D/n6xm/SLyO0SZqW3avahFAf/Bh7vUhP24k1keUsLeG+24dHuZCdrJwxyLv1enXZko6185WCfRSu1VWeD2tfFyUqAyM+MCbA5iiaDNCr9Ikjarkk8mHElbQY/3fCuQbxT5JMttilwamj5J5Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq0kY0RO; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq0kY0RO"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ad536cd0c6so5148936e87.2
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 16:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782172165; cv=none;
        d=google.com; s=arc-20240605;
        b=MCzA3/NE3FI8mJrCf2QoRl7o4dD5o7dOp0R8CZoZnyDYSVm8MWPo7vywDvfr+cUbOF
         vkja9D+RkFgqdlqOfI5N1pZbrUsR+/7v7leyyCtoSvazDHh8PJfBRZkbkmMcyhg16wPx
         NKaNJzPjbG6F1AQ8nPPaL9P+Yj9l7M07YW9gW0hhcWxGKZDDR+QtSx0Dl0UJoHYI0xdv
         JyZbhBq1rxhXGoYQfk9c78o/ExYVgyEM8MHzxEl9Kx1CD7IGTk8VeLgDP2UheEFWBKEB
         nBGUdrSDTjnT/UHkoqmAmp7d8bz1TLEPPyyM6TkjLJG1sJbODOtS88cp9B0z98iMQ7jo
         nnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=adOwapYg7+gUvRoqCaWAFG19xXjx0M8sahK39VTKig8=;
        fh=MJlMPEHAnwFIoGgdexFBNzHVNGK3c/f8M8ZFDXkHT5E=;
        b=XPWbSpx6CFy2VtPHIrzlKNGYB68jn/zMxFqOPrdzdNlwDvSyjc5wgURjp0aFZKh0r8
         xXUOQtVuo/VrdcQQKq/TmyVKmlwYdmL7JBG8tv5gF8lt6PeGxaILA7eGo/UkFXOqMoZn
         2TzyUNPjFyG3XMhIviXU4OIdJ+bIviv8JY676xt2xiaG21BxVbaBayvxomP+nUhth5nQ
         Ms4ZLzRBIL7n649FGmO8iwxnML4CKl83etKdfTNI5NQQKLDyYCb3KL9upKsvI37WTAGN
         U5nIwyg1AGOYu49ysXKgP798Tbnjln1yOejLbGQQ+Zy4Iegj7caUUKpfmv+m71l2qWIY
         ir/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782172165; x=1782776965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adOwapYg7+gUvRoqCaWAFG19xXjx0M8sahK39VTKig8=;
        b=Oq0kY0RO4G97cxbgDy70N9M+XXG79BZ79rKm92zbZVP4N2IIBCvFv3dOM+NeamZbxR
         trOzVbu2IxOzTljNcSZAUga5zOhXk3d953r/UU/jjc8oUPymobr8ZqLNIBjncJ1VsUEu
         Kh7n0WHbuKx1yTBEseJNtuNmXJm9DstSiMGJIKrn4LJUFVA7ibB7zKJrCaQgmgLDnpBp
         dU8YU6x3UEQU67G1pXPgKJ0s/nRMMa/K87enlKnXJg/uFdOmAwOArn/v1L8zLusPQn3s
         mWJqEzVnY0fTLlcabNcUxhkhJZ703dcF55Rk+pkIrH9B1Vi5IHEt/wiG4YISpLTf7OdD
         u+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782172165; x=1782776965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=adOwapYg7+gUvRoqCaWAFG19xXjx0M8sahK39VTKig8=;
        b=qNDR8uCXSU7aBrxWCMbSiLm1LXy0qVGFwFzH2//1FRJFauut1jroTn6E8LDx1k7SOl
         LJVTZ9wCEDsWld5yuCxopQsx8OHx3ZCcsXE3P5CO6IV81fGYMgLucrFywH0fftCsfgPU
         O+8dSUxlFkYjq9iDuZB/C36miXm3fmZKw3BtPsTIIqvvD6FRlCLGel3Zc/F9qWr8zsYY
         Pb2I3EW2cy9OUzk0FuH6qjauEdFg9S1Ml1nbxrwJOAC0jXk46HKKCHJWKzZgNDHqrnk+
         ggc0mr2asP4OSbJm+dJyOJC3gyN5fC09LXhw/oAB5mPFShipatxjrIl9coRMhGCaX72E
         5W3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9SRy5LgwFVCN5narNTPVNeLQBHJCcpr7lYJ7Lnj9UUjVVkFQIQJRgZ2PqFoxaSjziXzUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBJozNA0CwDIpE5SnwHPrq1r3Xq/JzIOWseBn5XiEEML8SHeO
	KgbWDTENQ0Xvp4RHP732qDaXM2tXKde77s5/trZwOT5sWlTraHWtQIr+AI9bO8M1A2vw57cmrM0
	7Zi0nbX20tH7R4SsJ9/N7yRUEFBTYWw8=
X-Gm-Gg: AfdE7cmdJFHzrV1ci91pz9SbxqpqnW5I2SxGRcbDViMvaqgoIvmo1vU7EacB7/J3JY6
	GI3hJ0T1dm0qprLLwpNNBDaedLf3aIeblynJi1Whv4SQ6Wg33A0ea2/bBXCNNkvtAE07cne50tr
	OIl/Zl81VhEqulQEjaczoBnrJcBaRCbWCx0/rjoQWZpOslS8AZWbdydTEY9HZ0xEK4Hom/TkmIM
	nyPB6uRyyRHwlWTGH8cBaxZtGbWlrcu4jE4EDUTHxgWR5rzVNyALs/2mm3JRARK0fr/PvQkRN0D
	UMlyTAjr781zfSIiRCVpb0gXPOh7yYamEfRbCS69ZqQa266jMaEkOkZ8MOcDSfhcatoF2+wR63j
	ga512rPFCTg==
X-Received: by 2002:a05:6512:8013:20b0:5aa:6e01:ff81 with SMTP id
 2adb3069b0e04-5ad5770aa4bmr3508733e87.24.1782172164873; Mon, 22 Jun 2026
 16:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
 <CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com>
 <ajJsMj0QMOF5I8qq@boxer> <20260622160706.0b4a27bf@kernel.org>
In-Reply-To: <20260622160706.0b4a27bf@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Jun 2026 07:48:47 +0800
X-Gm-Features: AVVi8Cf3LHE0YZbwHl_tkTcu7hd3qcD9Ut_nkX72BhZiRl2XSMeVQBsWTJs5gTg
Message-ID: <CAL+tcoAQ4E0-zWH9tBnKjz8KLka-aBfnjMHpk3owM-B7ugjQ=w@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test behavior
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com, stfomichev@gmail.com, kernelxing@tencent.com, 
	davem@davemloft.net, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 7:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 17 Jun 2026 11:43:14 +0200 Maciej Fijalkowski wrote:
> > > On Tue, Jun 16, 2026 at 11:50=E2=80=AFPM Tushar Vyavahare
> > > <tushar.vyavahare@intel.com> wrote:
> > > >
> > > > This series improves AF_XDP selftests by making timeout handling
> > > > explicit and fixing sources of non-determinism in xsk timeout tests=
.
> > > >
> > > > Patch 1 introduces test_spec::poll_tmout and removes implicit
> > > > dependence on RX UMEM setup state for timeout behavior.
> > > >
> > > > Patch 2 fixes thread harness sequencing by attaching XDP programs
> > > > before worker startup, removing signal-based termination, and using
> > > > barrier synchronization only for dual-thread runs.
> > > >
> > > > Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
> > > > configuration does not leak into subsequent cases on shared-netdev
> > > > runs.
> > > >
> > > > Together these changes make timeout handling easier to follow and
> > > > improve selftest stability, especially on real NIC runs.
> > >
> > > net-next is closed, but in the meantime I'll review the series ASAP.
> > >
> > > BTW, another thing about selftests I had in my mind is that are you
> > > planning to work on this [1]?
> >
> > This one is on me. I took your changes Jason and aligned ZC batching si=
de
> > to this behavior, followed by xskxceiver adjustment. I am planning to s=
end
> > this today EOD, however let's see how badly internal Sashiko will kick =
my
> > ass.
>
> Hi Maciej, do you want these applied? If they help make the tests less
> flaky I think that it's fine to take them during the merge window.

I'm not Maciej, and my take on this overall looks fine to me. Sorry
for the delay (I've been too busy to review patches during this
period).

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason
