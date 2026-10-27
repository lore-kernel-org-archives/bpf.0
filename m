Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.133
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793136623;
	b=JkjKB5uUx9qwSZAjCrroM3gd4cpiWWxYhDCa4yI6iF0kD8RgTgFsJMAEtxSyGtj0B88O
	 pW0EN/n9H/tXFdC15GJfNvF/HApwhns2E/QvtiFOyASPMvjwwXgez1KLkmpPY/r5djjFV
	 m/arFd4o5FJD6gqKtb5mR4/kgiQj7xPJDQeejzOfxNHWKS5pFNOX09Fk5leahgMsFVdNu
	 BszDmwEE36w2919kccOtvKqtqiRPO5fpAHeTqorVD860q4Ipou5it/C+OX9UTICQRyBvH
	 EjtR3PGF5WzowAXyH+tQfq9bcBKM0nSlzMtJUPfTn+IKlrl6en3PCO/CsZt6nbI3uoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qKF60zSIUN6NF5i11KAQ17vhC1V/mt6HwlhhSQIFEuM=;
	b=UhiSwKpxhJgMPLnbNO3egXBwETNmrgSv2oC9eRg4v987r5apZRe7uqfB7ukRyYstdhMp
	 YOekyOuFjW1QDJmyr06VIJZBNdyoMjiLrwF7BewLO7Zrd6+1vTPP2vsvJjLhc2V51gpxJ
	 YjY1v3WSNB7zo0avpjzx1keMR8qj5cFwx4uNqQNmU4eMgO+bvQenepcObzE0ulLeooXaZ
	 pkOCTdnRhtcpHmoJso3Apv/Shec2ZMjNIZCAGxtPj+S/eWRE1oCIkXgAushNeL1aR0Ezu
	 yvwSsj4t94myGK/mLLF03r2H/VKF9PMrr4rOrIg5s1Z/pufFRPDOVxC7RCBIA84tYQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWkHslfb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.133
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4E606A327
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91F4E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWkHslfb
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so1181775e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 14:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793136622; cv=none;
        d=google.com; s=arc-20260327;
        b=EOXtqctdpnQRdzD9UrnlHMx8r7x91a/AAAu4hpiQfNS5hsfdrDMpA2EysQ6JmlqVov
         CM0dxHggf/9ZrqQMzr+g8twQtJhvbZYqeD9S6NzrcayvvnrVPnrG+E3/fcLRmxF55/gr
         Hci8fzVKSmRSv5IK27xAEllo/+4esCPeth4XSLmvvRkPZyQnvlZ9CPog1lM5fN+3IbJR
         wgzKNXRc0+3IhPrrj9kJ1fko22VZe0ff9Wur3u1n4wJPfWNYY57pzBigUu9yJeBCSXvf
         ihsfw8DHdzCvAhpk2ikoPh9p6yygMMioiWPddeyyQxSs+0aZugzojaHmgFylIyadjkT5
         AWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qKF60zSIUN6NF5i11KAQ17vhC1V/mt6HwlhhSQIFEuM=;
        fh=B3ZHNuG7eIfbrw4r5vZQvZrqAyXzc/rNSN2ZSgRSqT4=;
        b=ISdWHphlrRFD9ys5awZ05r/zjc0UWt9thz8oRlHkWx2oUn3RQKtRMuf9Clr5fJRkxP
         LwfO5YfQ6acasq/1uFECM1KXhZcfJD2Q9hUxKBr8NuE/o1FgFt7ZQKVI4QpiwHhVVEl4
         c/wIf266xMc8d0zy/JTNSpYSBgS1z/UoP5aZXPHQVD596GV1s7Cb1RGd48f/EOauHcQf
         GNDJyAM5IPXTtXhaDtGAf5bYxh1MyDQyZXoaN6uLpBhiR5r9teFS8s8c+j2U0Sgw7xBP
         kbsOQCB+l/lb2wrrtqFiBPdCEqae0jtHjiXgv2xR8lvvXqa81X2tqqop3RuFfAp3Fjzk
         veaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793136622; x=1793741422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qKF60zSIUN6NF5i11KAQ17vhC1V/mt6HwlhhSQIFEuM=;
        b=OWkHslfbaLNzlt7JoNmvxpYXgHuLfsA4oVvS1/lKRZdVrDLnbD0xvLdPEm6iCrYFIv
         1OORLMgHCEnX4TY5ts71UTG6ZlRUu4cZe/Rt6YSUd2uN1TPmoMEs+dNY7yF6PRT9yRsi
         /pG5wMBp3w6WrIGBlHHwXUksHQ6amPmjB4u7lP+V8a1n/oDBGs4Pkymm82O/bVw/QPGg
         JxFZai0fRNaPK7dRsjaTpJq3MpFP9qKbflXEaUhbnkdL/QoxWeyO+Csjw9GwBKS3L1yu
         vEO4Mni/7C1m+wH/AyEOunXn7rWVavYqaei4j679HTvY48H0JKPx8iHdlNn7IpsOPQin
         IqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136622; x=1793741422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKF60zSIUN6NF5i11KAQ17vhC1V/mt6HwlhhSQIFEuM=;
        b=caCqsoHeZdzeS6xdYqXeW/z8jWd6pwxeOLx7W97GYbc7eWy7sDZidFUlKp35wAkEXa
         uZt1++qliaWLj06qll09zcefgdjpo6PTZKtTLZkgJDpLCK1lxybsRkNvMVnr8fHGv76N
         eDAVk+iw3CXICR50D6kVryHeIZpbJMYFMrC45sZTc0XI8UDbUUqUvALYGgsn034h0Zsc
         uyDiVzvm/PkITCZ222Ez9hYd7wH3nbdZW3obmgzgtVLwEk//jEArWSd5sAFs2q0DBIHb
         Q6uTPZ0FUkv0LpQwPSsWQ/wcDSr55CxkWHf83ehKgmi8d6XsnHAAAgfbz7vCkJE8BCW9
         ZOfA==
X-Forwarded-Encrypted: i=1; AKwUvByi1a3Mc6WlHTZjwQCQL+tMfKY2wU8KBi/DGP0A8zunh4V8dAuQtKobGGhveaPpV86kFrE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiT+A/bKOXekTIAkIpAQBuwHG/oibn9UzlBEltxD/jHCPa04go
	RFvgsjQrW1b4sNqISOOdxHP/lemNiMFQMoNBtJ3zN1WBb9g0tS7mbiRm4WXPSmBULrgAYjWntn0
	PdG6cH8xVKwBuZgFcxplxQFLj/fgPlYE=
X-Gm-Gg: AYBFou2ILkVe1+lZyOQetzkLuIte2ZQY3bMxkVKKuIK6XqsH2UvJS9HRSRB6Ifan3uu
	p9fqi0X/eBHBc2u8Uee2xcy1mPvltjKLKOnh1vHh9/fqEcLXjRTBVI/2X23FXSxz59nPHozMoxw
	bk+oNK5cXudW4B9fV7PhbKWPYfk8dGeHSGoklUmURb8z0OEoOnjBpx3txC0WS48QSuXVmVNy5dQ
	vox0/568FpMkOeYHnkeuRWVNrnxK6LwCvsN2WcKD4zCkYJ25F7eThR5ZiLgp5i2Ww9Cpa/DzA5N
	ul/48ds5t+YqBrI59gctLsZSpMgnlKvJm9nNaG5aTOYWfauVbvODy/5zfIbtbvyrQkzZMBNRBaQ
	POfrX3BZC53YJzdYdBpkfM+SsgbHc4uPw2lPBuz5OitLYs/YdPCsmSvTuwZ5leGraFV41sv8ilR
	0h8d6pNosZMQmDUurqjVuz4K4bCD9WK/4SHbZBR005Q4r4JC0TLoRg9ov0QFP/EyR9eK8lGtJw8
	D98scNB5hTpIHkW
X-Received: by 2002:a05:600c:530d:b0:4a2:1050:aff with SMTP id
 5b1f17b1804b1-4a9662a0b3bmr3867655e9.6.1793136621855; Tue, 27 Oct 2026
 14:30:21 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-17-alexei.starovoitov@gmail.com> <CAEf4BzYrpYHS1V=VXF0PTRXkXQo6FnseWirR-ka-O9wKTv_GcQ@mail.gmail.com>
 <CAP01T775XCUmtK97tBcWsvOvUsGxR7AKCGqfOCgebf+-_WfhkQ@mail.gmail.com>
 <DMF6PRBIH8GS.3LZZSW3LDCMWQ@gmail.com> <CAP01T75GQRJWXWVNhxxYH6w21QfFVvi_eBV-ob0uEHLmx4DQrg@mail.gmail.com>
 <DMFXPRARP7T8.JRCWN1DA8NWL@gmail.com> <CAEf4BzZdjCVsEC2QzYtCqPRXL-tN_4mOnR4XY8zNoExin+e-rQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZdjCVsEC2QzYtCqPRXL-tN_4mOnR4XY8zNoExin+e-rQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 27 Oct 2026 22:29:43 +0100
X-Gm-Features: AclHuK8xCJUww59ExrmwBEMokTtiQ1Ssw97jv2Rjm8HVIjYxixWeaLRFd8NxITs
Message-ID: <CAP01T76JXXefYaba-yT1nrhLuU6o+vOkvCeR5QN4W3NOh0Hyyw@mail.gmail.com>
Subject: Re: [PATCH bpf 16/81] libbpf: Make arena 1 Gbyte when max_entries is
 not set
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 at 22:28, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Tue, Oct 27, 2026 at 2:22=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Oct 27, 2026 at 02:11 PM Kumar Kartikeya Dwivedi <memxor@gmail.=
com> wrote:
> > >> The reason I didn't go with 4G since 4k pages on x86 need 8Mbyte
> > >> of kernel memory for empty arena while 1G needs 2Mbyte, which felt o=
k-ish.
> > >
> > > I re-read the current code (even with your patches in this set), my
> > > understanding is that regardless of max_entries, we always commit 8MB
> > > of page tables, no? I don't see anything that uses max_entries to
> > > decide that bit. So I think this patch is noop regardless.
> >
> > ohh. populate_pgtable_except_pte() doesn't look at max_entries :(
> > sigh. ok let's do 4G then.
> > The only remaining question is whether to do it libbpf or kernel.
> > I lean toward libbpf, since it's easier to revisit
> > if/when we fix populate_pgtable_except_pte() not to waste memory.
>

I can follow up on this (not sure which approach you'll prefer, but we
can iterate later), since something similar is necessary for typed
arenas which may be numerous per program. The other thing I noticed is
that we don't remove populated page tables when arena is freed, so we
also "leak" 8MB, until something reuses that VA region.

> I'd do both. libbpf side for backwards compat and to not care about
> kernel version, but kernel should just assume that zero means "no
> extra limitations"

+1.
