Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEBC3451C6
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290529; cv=pass; b=S854sRWV5mCsKOjny65iJB3ZumImas5iCygHPA4IMYXnYi9dnRck8CKu1ooIQF7kljEiiWtPdi3w0k1jAaZW3vGCPv45cxU+cvVwSkRTW9iVxkkznp/dZoVjWxSzsM3MdUrTgvknrizhdqpn715/zPIdu4jA0lgmwqmZuWDhHJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290529; c=relaxed/simple;
	bh=YEBunFSHRGDNumLMfC5wR4SHihWDvjTENa69vkBW9iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rw+P0+NURfFSvqq9z9b3UdwFp4l296UzxNyc9KD0iHW/6HAtiPf8xkc6pvRIiA9QZKCPLVMi+s5sdVs3lICycjWSNYHn235eD2GMaVdUMKViDIIHNYylcRNa8nGF72H3PlJzAjjq9wTlz9yBvY4wYJRQImMIoUorf4GfbejDJ3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NUXtngYM; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUXtngYM"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13807d2f898so1562995c88.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 11:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781290527; cv=none;
        d=google.com; s=arc-20240605;
        b=Jb5wDOqwe96+eelErbMBAOZmM0Vcm2HBD3+QSzOXC0sPQcalCznXyUQex8oToIiIbO
         uKNQMPFCdbMkzLG3FozklL/3NwCvxOksNkBd/VT5W7Sp3OkGGSt1kfJuTF5eZZ0s0BsF
         AnUO/hyseRtvOOcrESw07ANWs1u+l7B9J5zfQUFd5udRc9icbL9FgVrIUfDgOR1smJse
         CI0JVK1IwrKUkAyQtdt6vHsrNSPzRAyROhpXHW9iAWJc9eipfr0Zxb8Devq5tnLiAD33
         LgSjoZzXcRl1dTqubUEPHVv+qq2lU/E7uSzGks2nKnjpSHfn3gUE5ULUOQ66eTqbfAdh
         mviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+VG0vtUWvBGovF7rROnctTtU6VOb+iUw0EGb9SMXyc8=;
        fh=xk3t0WUh7D3GsBXtLqfg0DjunLqxeROqrLveNHq/olU=;
        b=BGogVq/dDyVn6mhCHI9Wzakcsm6RFfQ86r9gwDIy1R/BVykyOla0h+KskQn+kiz6zB
         JeBgJNQZOMjYNT3liwuFkTr51b3OJ1w/LfRDPNqZhLaXbko8cjB2GnJ/JQGszF3k3F7Z
         71wk/pMfmokgt+XDx31QKl4Fg3O2MaTmdFR4oFJdSOuGs17OMntNY/J3AArcbwAmeRJy
         Xr/OO8At6KjMjuf1o0yIqoA+h1lOiXQy1ga8xebxAQ5BKIc82GDDjiURX1Ui4mIDtAHr
         NIWf2BeB8sC9yFOviZW/K28S+97qB2Cu6tZeGIoc+qARNbUeSkxw+NOkJNAcvQiaS35l
         QfWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781290527; x=1781895327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VG0vtUWvBGovF7rROnctTtU6VOb+iUw0EGb9SMXyc8=;
        b=NUXtngYMsejP3RYB0EmQraDRaroggi4WPq5D6VZrp6JM1EyKU1FAuNxv09IP8Yk20r
         4mpze1aj0lbtAu2jIgwU1GuuwcyB024sIs9hDkg3xLLqUahGk0pFks2MPfPw4QtJDBYO
         i1u8XTRTjNx2lKO6sQ3pO0xlIAAbLoQqAXpePe96ZByYF3hsg2qImFNqlghm80ahiYOG
         nusqDN/g8QAxr8xsm//jYHJP82jsR+bgPVqJYC0jwOAzKS1P/xLreQqRpKOYQecMALxj
         SYCGBEVEfmOKUhyQ7Uu0xw72imZtCzYwU+/OqT4vghMzodgx1wIFciaKD71qPohfQY6Y
         9sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781290527; x=1781895327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+VG0vtUWvBGovF7rROnctTtU6VOb+iUw0EGb9SMXyc8=;
        b=q9dfMYJIGM2G6CLyltvyWTAPCx6GgFEyzYuRf/arIZdHLt8poQPsyy86pjjbaNQ/7Y
         vwA5W4V7dTTwESb5TdntFk+C957SbK3azeMkHzMnoT9a7V1rT83IIyfXb5Ogg67+eehQ
         YtYzT2SajS83Tx93AwX9MmAW/54heJC2+jCjMJS7P/yP5XxbVnjsdDlcafKhGLhcR09r
         7F2NmD77sC5SPcoq2WO5SJ0vNf2uEzKoMbGf53526CDLsYSjbIDAuMGRN+M1TjhP8pcU
         tvrQxSGJjmEw7yYRWapB4zcCZ1qUPIQXRST+ESUTJQHyahwGxtFTxSgygV2G49iUsQ79
         zIdw==
X-Forwarded-Encrypted: i=1; AFNElJ/YUJXxzEDiBWf+n2OMi0w/oA1alT2mVTAwEzYj85yGhi8GYfsNiEqWfNgd+82PWmIjBUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysknfg4EeHoxwsKXxQ2Sn9PY98ZArMXD9EZ1PZWTH6RyGb6GOJ
	QbE8Q10sGWqNjb/949wbzHn/OVKHaE+zUk4opNn0dmx7uafBQyfPvWwi6oA6n5f2r7zXVHRBJqn
	AfoGSOhemZhfk/GTPe65N8Y39Eh79C8Hxi43GMlU4
X-Gm-Gg: Acq92OF7qqGQuFareVAxEwwjYOplWNtVeJfzkmsiJZ94798qHI6jd7T5+iPx/8zGfml
	fqrDGxHhfk7qI2l6IxQ1bvG+eVKhpBpDMj8SX2tLLZAYovmW1ZxEjHrokdRCZKitfJ+jNrSXnM7
	Z8mw08YD/jg9EJjyID5GXuSYdsUXB6mIFm7RwxqBXV6CmBbdYAgUilOeOSj2xQ/TOzR3NkHJsP0
	6nhEX1rZPQGjs3DD+ntJe9fOeRN2qEuSbBnJcYrUjb2N9FRNKqvym46qK56kU4r9KURVx8UBAaZ
	v1OVS7P2d7l1y4owDfx6lvgtF9SErxs5VRjLqpNQISp19oNwzjhJbGmzm7MZdFxdtwDTsvlAMPf
	RsoG8AOuAIQGZRb1qh+RzXqqS+YtkgVKkZMITNxd2iMDCZsVkwaZi
X-Received: by 2002:a05:7022:629:b0:137:f875:c1e8 with SMTP id
 a92af1059eb24-1384bb6939amr1718651c88.19.1781290526219; Fri, 12 Jun 2026
 11:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612001803.23341-6-kuniyu@google.com> <20260612003138.E67A01F00A3A@smtp.kernel.org>
 <CAAVpQUCRU1ie22PbegWgGnfyWw9V0wSTjgQpw=5Wwb2RZ=su+w@mail.gmail.com> <DJ775MFSG561.2SI6FNLLV8NG5@gmail.com>
In-Reply-To: <DJ775MFSG561.2SI6FNLLV8NG5@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 11:55:14 -0700
X-Gm-Features: AVVi8CfGFiXpNBZTAVmql2XQgWnU7gXYvHBtNP2-sFXgWrH5--YEOApHj6Xd1Kk
Message-ID: <CAAVpQUAWh__B6C05kt4ph30KD+CDPjh3_kD-DaBEOo4WavaERw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 5/5] selftest: bpf: Add test for hwtstamp proxy.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 9:04=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Jun 11, 2026 at 11:03 PM PDT, Kuniyuki Iwashima wrote:
> > On Thu, Jun 11, 2026 at 5:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >>
> >> Thank you for your contribution! Sashiko AI review found 5 potential i=
ssue(s) to consider:
> >> - [High] Comparing a potentially negative return value to `sizeof()` c=
auses failure handling to be skipped, erroneously dropping packets.
> >> - [Medium] Incorrect struct cast for SO_TIMESTAMPING_NEW cmsg data cau=
ses test failures on 32-bit systems.
> >> - [Medium] Typo in the test assertion prevents verification of TX time=
stamp keys.
> >> - [Low] Multi-line comments violate the BPF subsystem comment style.
> >> - [Low] The `buf_cmsg` array is not fully initialized before being pas=
sed to `sendmsg()`, passing uninitialized stack data to the kernel.
> >> --
> >>
> >> commit e747f30190af013f6f5cc858f0dacb86e902e2d2
> >> Author: Kuniyuki Iwashima <kuniyu@google.com>
> >>
> >> selftest: bpf: Add test for hwtstamp proxy.
> >>
> >> This selftest simulates the hardware timestamp proxy scenario using tw=
o
> >> UDP sockets, simulating a userspace proxy via a GENEVE device.
> >>
> >> > diff --git a/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c=
 b/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
> >> > new file mode 100644
> >> > index 0000000000000..d0f90f22bea22
> >> > --- /dev/null
> >> > +++ b/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
> >> [ ... ]
> >> > +char *ipv4_commands[] =3D {
> >> > +     "ip link set dev lo up",
> >> > +     "ip link add geneve0 type geneve local " APP_SRC_IPV4 " extern=
al",
> >> > +     "ip addr add " APP_SRC_IPV4 "/24 dev geneve0",
> >> > +     "ip link set dev geneve0 address aa:bb:cc:dd:ee:ff",
> >> > +     "ip link set dev geneve0 up",
> >> > +     "ip route add " APP_DST_IPV4 "/32 dev geneve0",
> >> > +     /* We do not forward ARP to the wire in this test,
> >> > +      * so a static neighbour entry is needed for APP_DST_IPV4.
> >> > +      */
> >>
> >> [Severity: Low]
> >> Does this multi-line comment format violate the BPF subsystem comment =
style?
> >> It seems the subsystem guidelines prefer the opening /* on its own lin=
e for
> >> multi-line comments.
> >
> > Gray zone, this is rather net one :)
>
> bot is correct on this one :) BPF prefers normal kernel coding style.

Fair, will follow that ;)

Thanks !
