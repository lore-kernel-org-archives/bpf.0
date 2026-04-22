Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D7372675
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877241; cv=pass; b=ThALaQmWRIfpaNhgc2B3WPns90CGEw3ztdFcYUBfELG1yjPUd1GofAdmLEfERZGHLNE3au2Q1aa3wqLTtNIzCR8FARximyp0Y1RXXwNfXLZwNV+uQOTG5DAP/41uyMtpBfzXaXG9ymkyaSW7xDCRuOr0n1+xv5BLDx/vLhqZ5zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877241; c=relaxed/simple;
	bh=CxgXhmIfs95bP8mO1YgT6vZFXh/0sLshxolGw4v1KS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSm9PV+d/79HA2ZZOC7E6EdPmHkK2QNLHNrdmQIQWzezuzqwRFuMNpNRcARy9s1hPZBNSzV6DT7O6PX1eQPZimqJ+8ttaP+kRYpUY2p/WFTRsbhYwd03HYBqH9zJTpntgi7x4c50FqWv83AxxnJkR84ypLIxPywIwrxj6Y4o72M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMBq9boe; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMBq9boe"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso22815155e9.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 10:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776877239; cv=none;
        d=google.com; s=arc-20240605;
        b=iBnHk/WzubM4XDRnqs3K4GXCzFLZ+dlFKCI3SyxDVzI7R+Yxs/Sqie+UWUMa1NPvKA
         HVrCkxl/L2pZs/oIoyDXerUTHoNzOA1Egm1CvhIPSIPULpP2tyOpHaSnvEjFH3muouS9
         r+KhPvd0zvLhsVgON5VsGf9srgOxpsL29rMYAYzaSLCRzWoL2jnvnQd5INRqFMZ7GmEV
         gFxEZq4+9Nzd0kPbeOHpBYkNYJ1y1gD8vHZKYKEDL5txZ1fhsx6TOwN2GAiuLW/PSDnO
         73b0TPLzNv4dRUI0AA3erRxbx6RzoZZ547DDPESnkmfN6FkG1RXuCqy/S7O4DfXd7xWf
         OoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rFt9ozge0i4yVavBllhXzXygEpvlvlEs4XIJE4L4qaI=;
        fh=rAcxfttTLJAdCNMSy19/VPnAUmqG35It1g+aOSO2mmc=;
        b=ZKkOQLLCO60TpiPmeZGNB1RrKF8T3GW4UJFZ9wMnU8SCWpV7BC8tSG3N0HkTfgWAa8
         G2a8q1hBPD6c/nOqhFx+kyRp08HTPFohF4bmc5H35qWqRMClWqZY0gmac4l6gj5u+Wl7
         2tEKI313vmdLZmDCQtUsDNwH4MWLgW4vg7e2G3Z5RwMbtnIo57MlhMT77tc9eX79HKfM
         zhtXzDHZSVpIC3BpQjTcMJoPYdIux+XCt3U0b54D6/IvkiGvZzIIhWepCnoyzgZC7pFt
         GCoG+n+mlvGXLCbxDNxW+dCrjMxmdMoIFf7iGJ0nckwlem63W4rd7Hbtk4oMuLbO0It2
         vHfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776877239; x=1777482039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFt9ozge0i4yVavBllhXzXygEpvlvlEs4XIJE4L4qaI=;
        b=RMBq9boeCztHD+OmVHwsRDnhos3DWXveOQgmAVzl7z6l32FjQCjYK88JabWvN0GfMY
         kFEDRzZUep7yKVcorQjJIP93bQz/9xzf1U2ganskle7bIvd9gX+lFiKe6262n8uxzAfS
         tjYYHJDLnV1cCF5xwfrkES5BjU3vE9LEfKKdhywwRNviy/KhanuYzwwDiNHk5GAc4bx7
         CEjza35pOwbtqQon0JEYY6lyyISEgn8xvUlpKwRBkC8f9PF5klj9UL+juDC1fAnF0rKc
         Ch27P6qg0FvE+r4WNcEeLR/kwWX5RSwicoTDKJNaNcgXWeJbNE7iCIo8WIEGo6ivfU/7
         lBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877239; x=1777482039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rFt9ozge0i4yVavBllhXzXygEpvlvlEs4XIJE4L4qaI=;
        b=OdigWk6rWLaImTaPBOmO3OkLT/gfKtxo9MEgWsEpONg0B5rMvSTGvA7jCX5FI8Bm3R
         tSIgLiax7ql1dr5czFaKUMMCTy4kz/XoUYANdqASI+vo6EwIRE+JPOb3UAqx7DmBL0+F
         XDYp9ATqjdWjEiuXtCQnmPpYgJd+A2btIleQF5R2Wh8OO8uHxdWf7soLLJsJdwxdQzx9
         TJp66bP0qpxalRUrGW4S0hvJR6LOQEl3698agFUz/s+vv4AoMR3JSa3OBhvg/lWM/7JD
         y7A1fCzgmDukZAMOMvOeBlsT1fv3K7bsmoWpBUvGrxI2UwiN/WDgUpqepZoMaxkgMgNc
         oTrA==
X-Forwarded-Encrypted: i=1; AFNElJ8JjtdDN8ESuu1V2RP7XuG4yVGVH9G3/x417R8r/+1J73QrQFUNA4eN9paNJxedMX0TipQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUcTL+G7FqnSHGB5Vchzr2QuKUNToFFKnyiO4jTwt5cJY0uws
	7Ngu7kQ688KlquFXnsDL/0eX9m+U4cRLv3QRpLbPD9sXRI3rNwF3gtj30hL2yNBaBBaegPdouZI
	m5Z/cgj7ruJbwyqPmHciUAHi//LunaiI=
X-Gm-Gg: AeBDies0POqu3vfhed4h22BmeZodvZ0VDdwRDn040QoZy0p1WcH/JkJy5Tojgtogdb6
	74U35gSSwpbMiWmyTHMxj9XFRASAfApuP0LqZZKbyykHSSPG2gCZ6sRKas2uV4yas/6hA5v7GMb
	sAcyeLg4eXVGE4HYCgNbCgVIRJQ79+ef3aRildES+LmnWDwxXpq7fxgDIdBN9XrQ5A21JQfKLI5
	SRH+B0zSdMf9uPBbQIYZC4CQ7n68pmG79boy+Vd4oDECXsPaICTu/umn7JJevm2pJfAO6bIhEPw
	kSKTP9OuwIdE/B8/o8CnNQ5GUcnYd/SVej/SCj3wvIWLSx47giMyMt+Qtn8sYTV+9jyYwojFSEV
	EJypBwdd+0g0RSt5hLQUHWD6wiGBE6L+Jp7ITcdr1/UKSgBk=
X-Received: by 2002:a05:600c:8b38:b0:487:59c:2bb8 with SMTP id
 5b1f17b1804b1-488fb7925dcmr323083825e9.27.1776877238655; Wed, 22 Apr 2026
 10:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-sleepable_tracepoints-v12-2-744bf0e3b311@meta.com>
 <e93b3ecc3e3406ac70466f8083544d896295f6fbb3f07c8e5a059fa25f8f19b2@mail.kernel.org>
 <5e93b4e4-12db-454f-b900-68ebad02ba5b@gmail.com>
In-Reply-To: <5e93b4e4-12db-454f-b900-68ebad02ba5b@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Apr 2026 10:00:27 -0700
X-Gm-Features: AQROBzAKyQ4SN3xuXpmq-TslNp3acJe5xKwXL0lJAqcoWMC33zLKbcdYvdE_vJg
Message-ID: <CAADnVQLBk8oARVE9vZoM8Cabtov3RVr3Ezp3tG3NahoU5=6ktQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 2/6] bpf: Add bpf_prog_run_array_sleepable()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 9:36=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> >> +
> >> +            if (prog->sleepable) {
> >> +                    guard(rcu)();
> >> +                    ret &=3D run_prog(prog, ctx);
> >> +            } else {
> >> +                    ret &=3D run_prog(prog, ctx);
> >> +            }
> >
>
> Yep, this one should be inverted.

Ohh and CI was green. Looks like there is a gap in test coverage.
I thought you added a test that does something like bpf_copy_from_user.
We should have seen the splat with config_debug_atomic_sleep.
What happened?
