Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0421CC51
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671777; cv=pass; b=sxtAFmJ0snzbWQLv+ZLnK0aWli78MJI6CYWVTE9Q9AxmzehzUPfY8gcDl2kUwZtuYNC3qfIJbNqSrX2shsVm6Uyom73jnx46hxNdnX6dsDCZiR3Cb2JtfKbnKKOUf1LFv7NtzA+3qEZEJl5h1xSd6aKBvlkSjtR+ivE/s5xgaIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671777; c=relaxed/simple;
	bh=GdTjpZtbBVQmtxycqSdR+cBuzBwSfmy+9xEj5bqcZPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EumU1Y0MSsxMpcIcqMX/tkIE750M0X7GEnp2VPsr3yqhLZrQTKnceZsg504hVmxiuEF1vhzOKqMUH4YwHnc2l/ZD91JOP0HvvbXEd5jpycLi4BQLxfuZm6Ep1X23OnTzFTL5HYRXjnnI+B/LeZEthv/0I12mAgv0Z40MSASjR4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROKqOScZ; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROKqOScZ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so5655322d50.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 16:49:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772671774; cv=none;
        d=google.com; s=arc-20240605;
        b=G5GpGOeHPubILRv59cr3qio5BT0rlGl6A6diPb9nGG3+tc8y4TXH0n8pDep3fpgboF
         PAH4NBHiR4jUNJm8G0vqDQgzQtPavMtsi9ShdI00Dphu0H3XGH2BJhCSlaL+1saoiR55
         6+2MUGQdpRGT9hjtuU2cb7jFeuirnZWY1Mxe4YknXWc375LVc0TDlnwPrksAITWA7Ji8
         ja4P6LCrWza4jzFYfvxRlJlgVYWAH8MNmhB5AmYUKccDQCd4tqqTPJDCrmKnxYQl3Cna
         evBhwPQxx3xl+1MMF+OUt/W/DcvX12IVQLEpff4rUjc9IY0cZZNWBYjGDgsFDdt/Nm2+
         mG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GdTjpZtbBVQmtxycqSdR+cBuzBwSfmy+9xEj5bqcZPA=;
        fh=tgJDFsF2QDO0feyfyhE2S9+qIh8Wpmdt5AgmPPiGHAo=;
        b=bpTJl10AszoNQOPCB0Z8tHJwgGYBIxiyjjb9VlRjJsL/Y2R7izYnjrAJ3/W1I5fNWR
         AOX8+3DxU5YTBl/PpiepTpBwB0LY7el3nltv/a4+gMpF1xxzuU0oap0oRWsHR0Dmsc8+
         LgqSKoWFZXfv/ldk9CDn6i7DfsRCRC6qBDn7vN8zBRdiO4mvDa6hgzMFvm9SSPQ23HlX
         gh53B5noNlY9fzOZDkEWoza/zcy0RiRWYPiiqTjyrokerjst+V15KGOpLCL5dSlDtniu
         7v1OCXsIBis+rjDdMfD/Q2InkeYZ6nZoqTDvp5qwVU+LjZrUWKXlxmBEF3+98QIWBZyA
         Tx8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671774; x=1773276574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdTjpZtbBVQmtxycqSdR+cBuzBwSfmy+9xEj5bqcZPA=;
        b=ROKqOScZiwPAK8Xh1mmL1v1vQHnhoOjOgB93hB3EpjUUT8Rv0yhnylBfIM1KJlhuBK
         yAzSsaduv2loBNP1fFEaDzHMBTq3aFd3mZqGMQZ50LDV/bBTPWgT+0mmaEyCw2OwdUtL
         oEYefllBeZMTrs+l8lfWWeXbc6MGWCpUCFj2qmeB+NIkvDKb51NxuN3gNifxfJnkw84Z
         WvoRvQhSeBr24iBv+hq9tHiAADFMNecibufRVGr3FNPe+yqqL1xr+LkkTSYObxiU6TNF
         7VB46qXMgJyOOYlB62NBujBZB5+XMXluvk4HBFHpi5qKMTdJBg8GmGqYa34/PweBBo/b
         BBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671774; x=1773276574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GdTjpZtbBVQmtxycqSdR+cBuzBwSfmy+9xEj5bqcZPA=;
        b=UIWXB689VG3XCgZBVJJQua5Yyz4TQOQVHk8LIq0hHN0Wm9HPp2AWD4UbLrcuG/IM3H
         lc3FCS6t9LZgkF4uyodQeB+iet73m5tBuu0wHutzRkJLBVt0/9sga+UPJLv8tA+XUAXP
         wK8gn55AimIcQNuuFBTgZT3HUXy4cd909w9MGJJiBiKc4fddPpKA8SMWhEutlJgzThy0
         GLAyi+rPsCQ7ji022xCUSPvZxym6nR785HYpXbJjk0ZfAzxONT1Lk1M3msbpAhi/YeCc
         bna54WbUENHdZouq4gmdHvHx1m7M9UcgvDJDWTJSHmvpVfi5eBfB4ZH1/mQzy/MRi4GH
         h1hg==
X-Forwarded-Encrypted: i=1; AJvYcCV9ngblA1zlQK4JtN8wVCJWEGvdpL0qOvJJumwmF8qm2VLVQeX3KcZ//nGvMaefkHk3XeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDeU+9BTYwN96LKbyd7gbrSa4nfVD09Xp1VAZ7GEUb1KopPXCD
	3DZe+NL4KkKaAvlQrw2WpfLPRbSuEF2sDXnRrpivYmvyZ4lAWMpIJH2EPpcpxHO7FYkKoVKSuNA
	PwbrCxZnErS8U66x/Q2GVKqbdNX+PrVTb8CW/cCey0JDh
X-Gm-Gg: ATEYQzyJ9dzitb2WEILrwPIbBR0mVRrlbx3b++FPu8SXIzWADWpWdDAZslq993KLUyp
	oBMsOL/rcKHLPJVAOSjsae5wIrTfs4UJi9onSqlWwms3vfNKJZqB3CJoNbAGDtZplOuaO7HnkMw
	M202Mf6ati5ajOI4py43gcVWkhW1xEfgt7q9pSpUFmlKI2YLVu2zQzOmgo0vi+ttcYsfFNOu+aG
	VUhBLV6No8Vuc1fnYO+Cwc0bg30dPC0O+NRCpnvWwvhHSOwQB2mUQ9dxCVpQ2SGDyDUPc1GS3HC
	OzX8Sw==
X-Received: by 2002:a05:690e:b4d:b0:64c:9f87:ffc8 with SMTP id
 956f58d0204a3-64cf9b502f8mr2926055d50.27.1772671774394; Wed, 04 Mar 2026
 16:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302071434.311395-1-sun.jian.kdev@gmail.com> <aagWYyrrwUt-poL1@mail.gmail.com>
In-Reply-To: <aagWYyrrwUt-poL1@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 5 Mar 2026 08:49:24 +0800
X-Gm-Features: AaiRm52CcrFpcHu1btFE-2CrSqBTFC7iJEHky54hbkfEP45VEUCw4H3dKOIHjiQ
Message-ID: <CABFUUZEdbCMrNyp4kEO7A4KZPn5TKi48+tQvaaYaYuJj5FQ7gA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: skip verif_scale_pyperf600 on -E2BIG jump
 complexity limit
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 7:24=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.c=
om> wrote:
>
> On Mon, Mar 02, 2026 at 03:14:34PM +0800, Sun Jian wrote:
> > verif_scale_pyperf600 loads pyperf600.bpf.o, a large scale case produce=
d
> > by partial LLVM unrolling.
>
> This is a known issue with LLVM 19+ [1] and this test is already
> skipped in CI [2, 3]. I don't think ignoring the error is the proper
> fix here.
>
 Thanks for the pointers. Agreed =E2=80=94 since this is a known LLVM issue=
, I'll drop
this patch.
