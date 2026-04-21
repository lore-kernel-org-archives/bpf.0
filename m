Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5973A63F7
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811811; cv=pass; b=NPTDD/8zIBSAmqt4BSEBLUbVlDbW0HaBKCO4hWWaRL4ly6A6knRet/f+VEh8j9hyxpRsXCnObC+Y4YrnS2wIVU8mcVRgRL5e1DU8hIA8K6uQlb5yFCgXZd0hfFubam47jqnwczYt+YQu8/nA6qD1Ge+zSRVsVctvFdyC0l6sfoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811811; c=relaxed/simple;
	bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scyP2N4N5JenLd2tZ6UMt03A773EqG5WDcnfPVnqXJQRmjOCxCW0ZhrbqEbF9JHB1w+WcJcMgvDddOEf0rhgh6JkGNEA/mNYVln2U0Yp0BvefX6dcBfVoJfM7gIhyQ0xDuURb7emMqxR0lqm4ofWmkV1mJWneP+x7cbi3Z9BCG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T75RJCJi; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T75RJCJi"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b24fede2acso30496945ad.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811810; cv=none;
        d=google.com; s=arc-20240605;
        b=DzKxza/PtoPvKAVrqDsOB705JNeWLpiq1PZZfm5qWlMSwHjoDSo2f9usdyND8tlgd4
         RFTwfjQYO/nKEGMvaBJIztLjhS6n1OYeoMi8rbnjGAVlbFhD0YIqxNenC4N5+9HXiYae
         m278Ap/au7aJjT2e8nACHKoXTRv+Ops5vDbH/V8Hoxcm9qWhE1rJt9d1XFt1zMussHwZ
         pHC/keLxdueUDlnuAGiXwxpg75sTUwvC678mXe0Twqv4etWHIUSILEKM9ocUX2tSvAfq
         h3w6LJL3n2D3+6YOHbn7U7obP7K/6qWixUIfRtmP75Zag5HKe8eZ5Y9XIwZxZ9pDd5/c
         X/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
        fh=3oNZAcS2GzXO773bbuuRev/Wx4PyBqwi8U08RTk4qqg=;
        b=NxLGebomjDhsI+2dHikwEw9KJDR65PMcVyGkeM5xavX3qGv8RlplJOfMDNm8tA1w2C
         i5+JxiO6+ZhE1GTZ6oRp9EpKr2DperOawqOdavI0kVmtQzl2IO7zm/y2G1n+M+4NSwLk
         fUrz1g1ut352tfPwS/GABMZAbjoGlnvQO81Pfs8x9CFCW/KyZcoJrDRsEGVBH/6nDGxl
         kFqoDIzUdh7rfllD7lwIZG2wxgd/y6ae12/83oRmr69vNhhM4kriJWt1VLDeUEYsRSth
         LDEMSfb/QV0rkUjJ5rmgIt3nDL1T2AayGwGxAA34TCG+Tv/QQC3zI6D/hsD35a0ZlO6Y
         /NEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776811810; x=1777416610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
        b=T75RJCJi/8g+lGjFoandwtXi2tVESI3/UIugg6CRYqICGsXnA9F0jWXhxoqU8IWIix
         UUL1wb9ZPHEFuoCB2QNnaCXPyBEmsUoQ5MFscAFA9HtA0KQ2MMZsGK2/EgFFLhXx00io
         bW6Bj7J/heMT7bxY3FrLeZFRmAE+WjVebBYr38MRBfNrf5nYqEJpja8Kl+XDGoopdYY7
         l2omqBX4MIBqbMIeVia3qbeIx1X/VPODFuQ77ZgOtL3PLa3dtg4VrPzniZrXba79Du/m
         nLZLwwz76lyTwSQHVYHkg1IXngrYczlDySkLNVsfgoZUcXrT+/GTwHT8DKX83WEk/Yyq
         2rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776811810; x=1777416610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
        b=GsYKF/bJWv3bi0r+ajurLEIQLK3mLS1ML/seKt4ShCIdosBPGsgUyhT/tu4s3QRHmY
         /996Pr+GZz7rGM5X/y+WDo8cKtK/W2dQfYXP/ODUXjmK84QCptqwjce78mQYRGpUroW7
         HDzlgIzgWv9YhCFU6kynWMqKdx0vg/GOgwTAzKsSUb202HUFXPVztsB2O+pnF99F+zPD
         1Y6/b/2goUd/zMM+O4qNGVFzvBe3bXY3faoBRfT9L0gYl+K+n8ARSdi3LfTIgGd4jAwB
         WXkDm6K1VDny3+/IKadcePHFlcTMUn4MQkb7JKNVErmmpi3LBqCJdW4mUerjOSLMgE/6
         +0lQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Ip0JW/xNtzwNcDQE3YywqWBzEwHqrMHq11fNVNUNs+ZlDht/ojCC/gcUndD/jbbZ+Vo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgvi9+k11Jp47w7GEr4qSRYmwPtPDA87dW5eKoZYTKfLenz1U4
	5d2hxJFbuHccfPinsVKwCPNRglm7+XKi+w0ONCdpD2VfKhX130V5zFh1OCfFIynw7pW0h9Ov+DU
	8Lp0AOb39RFAtCTKzEDVMS6O2Q1Sn7GRKUJE+slrR
X-Gm-Gg: AeBDietO8BUAxSYZVq4L5oUhMhwIwYRVpHBDUcWPwKY7LgLJ7eoWQjjEMs8VAY7RkKa
	jVv6njeUPevPU44iuQX+Y9pDVe1SRnrTgnJxQv2k+sdpBK/fQGMgeAJPpFPAcNGISaRJaCBN1Os
	ExmDY7QkU0kT7TrDmHkR4GneAjJS2Yh1f67OdBFEKkIJ6kapNXrwZSwk+wtaaiplUEkN6YNg+2M
	KRttvgJkgV4vxoKJNXnn/6yrcD47KFNwel38DMjBCw7M7tMDbTYnBW5lN9f10d3PTtn24b8oQIV
	PPMDneltb+HjZdlj8g==
X-Received: by 2002:a17:902:be0a:b0:2b2:481b:de68 with SMTP id
 d9443c01a7336-2b5f9f8f446mr154652785ad.35.1776811809715; Tue, 21 Apr 2026
 15:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
 <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com> <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com>
In-Reply-To: <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Apr 2026 18:49:57 -0400
X-Gm-Features: AQROBzC8n0JJ9DjsWU-7Puv6JCDhA7IZFjxayYVxpNJDKTQHihIrjlR17p1FK3w
Message-ID: <CAHC9VhSKvC+p5j5Pe1YKB-=vRkRA81K3kp97Q6-H5K+kvYa0AQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Frederick Lawler <fred@cloudflare.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 6:15=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > > It's still Nack.
> >
> > Based solely on the diffstat and a quick look, this appears to be an
> > LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs,
> > but they are LSM/audit kfuncs and not core BPF functionality.
> > Regardless, I want to see how the LSS presentation is received before
> > worrying about this too much, but your NACK has been noted.
>
> Paul,
>
> told you countless times LSM cannot touch BPF bits without
> explicit Ack.

Based on a quick glance it doesn't appear that Fred's patches touch
BPF bits, they simply supply kfuncs for users to use in their BPF
programs.

> So, no, you cannot add bpf kfuncs in random places in the kernel

I see plenty of places outside of kernel/bpf that define kfuncs.

> And, no, you cannot call bpf internals through bpf_map_ops, etc.

It doesn't appear that Fred is doing that in his patches.

--=20
paul-moore.com
