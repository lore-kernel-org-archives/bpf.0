Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F80330655
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439645; cv=pass; b=FypL+xtXImyXfwYxokPZsC84UaQYtW9H+3KBumtpzftwe/T0N7q6Har2J6uMDckG3wxCugI2+NnAZFJUUJ9QlkcdkQqlIO3tKinilDlf2lI5FIOcwxr2Tyi2mN3Gc0oTX/vXslKlrQMsRO5+YytXibcYQg4JqDuvNZgomE42XSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439645; c=relaxed/simple;
	bh=9JGYl35tsizFXDZbiaiYoxJweuXrqnzNLHEso6sNh6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl51Vtu04HOxhJBmOQ5t9X2UR1HN24obJfNU+iBquymV/i/cKO1X7DsrROAJlVaHpNJYT5crOigYyYnaO5a6IiBsCQAYqFzC199BcN/9AA2p4PCG7DV9L8qJ2EexNfpqY//UmfEg1IUISapMvY2Wi6YdvjYZJTpqDHkW6RkTGKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuWHL4bK; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuWHL4bK"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so56513a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 10:34:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771439644; cv=none;
        d=google.com; s=arc-20240605;
        b=I0zCaXM+BFFCsNm1D6LLTPQymI4/dZAOus7bdPLvKTHV9A+0cp3up1Gd01QzhYAKgF
         Tr7vroOEsIygTI/0lRALo02S/8bxELnobCJLpbAswsgMYehadKooM2WIviZ5HEpTKjAJ
         sGlV0Cv4NMDTMTwWOBb+xlo0QDiyfomcg0wbb6QBlBJIelzK6DmTi1j47iU7shamuVnF
         ipsT317kpilZvY1ZixOKIY3duZMMFWN8tIVoeT8VbIKRy3559E3liBwdZX4bk5AfZR6C
         y+KhZ64cN5zz9wTf6HxCNM05HMlDD64gQ45Z9TIpGyDAol3hgzqWJIOpYguRxL6NUJAz
         /K9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IxsfAz9E39DdzhZFaBMej/hqhUaL8iTYK1AdVHtalIc=;
        fh=TLpF+ZY074HBeC/TEsbXzydO1Ihz6w4ltTtwh6BBWKM=;
        b=bJ3VCS6mnWMq1h4GPErx1ANq4c6pKDWTaZ6YlAzvfb1Zn1XbfogkJvBTb8HqIgjxf4
         OWpH2+BI64FXi0gnIMsUQs9NZjWaDWTwPS3/SbyR30z6O1z2/R4Ci4T7lWrZkOiA/ZFS
         99Z/1R1qw+EJLux1B7siXmeofHvz4oAEisZHoFAThQy1w/LMm9bx/f2B7hXosUGKpB7B
         na3sHy8zof+395jltyKphiL4L/gd9b2i8GTh4qbb7MxFu1TNq/cOJyPqD47UCIqybN0N
         kFJJb1AP74iiw9yArOBQuhUdQL4chKSOoJVJ2vSMmCCm//kNfXU1gQdzuetgUWBs0tdn
         yhPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771439644; x=1772044444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxsfAz9E39DdzhZFaBMej/hqhUaL8iTYK1AdVHtalIc=;
        b=TuWHL4bKv6ae/18tuWgKhOX3zUFrqof3Tm6H8Z8Y/gH6YMVRA3BdeB8dN8dkxxxYJ2
         fdQIJ9yGzwOYd3g9OyBhx6Ve9NuvLofTnXF+NXEI7YgQmBKzoAtNIbe8YQ7CafH28Yzo
         DCiTokfXIWC6rCSWbeRTK04ZvAQfIwNBNgiKxIsbmLsiUBu9IFM4Qu7PfkWcvRSXFVrf
         PztxnShMlW4QjAvLBfmVcKA4GezkHnUxevs58/8XPH1aZN1WF2sIfCBj6uscj4jymazI
         Puq4gPes6nkRR+zAjeJtFTsJ2nUzlmPzNFjPyCcBuA8xuLDslekGmU3KucOztLLyOjKA
         0gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439644; x=1772044444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IxsfAz9E39DdzhZFaBMej/hqhUaL8iTYK1AdVHtalIc=;
        b=uYxrPVo7nO0UrZNm9lR2PxcmA/3U84RfRULdfEEeZv7EBPdoaGglLkfmQSXzyFOkEK
         CCp8QWS8uyb9YHp/kLftZ2/cAfE4/uLyTwnY5ddm2K6lYecz/dAUoXe7EdCIN/sMUumA
         lagIQx0NN63MevYlS4Vd8ghtYx/MloPefdmHSinA8f8/zp2W4IaxhH9HjRf9y2OG2xxT
         eA85ReBJKsRCyy32yg5bPDsoEsBdt6Xzn1Wa4NqKZXTA2MO95yjo+SNz+DQ2chK/do/6
         3F5zAnjqsJMEvLYabV7qqD9Zyf5IJKrjNPTkmtxMTTUkWLv+/Q8ZhCeEY4ryhGe9oZr9
         5V/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0k0PXYJa+ZgiEBS3a0MJWvb+rKk0hKz9a0l104buybqjlKvuQbtO1sYM2lGk6InUdSv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylac3iTuhZZV3aFpQVVS0w5RYbonvZB9KyJjkWgyl+sBiy7Geu
	QW8bQY/LFcXBJxnp1jjVApj0PnGSzqS3FON8dTaPPMd2NG1YPqLhyUcf0zRVC/vgGo/xVFVP7c2
	HznpAw/Iu5rmTMwQLhIA5RcGyTaR6TjY=
X-Gm-Gg: AZuq6aK8gQmmStBvY67fkv/a77kCsl5GT6iEjt7QsVUlr9T2p58FLkiCJbXexmxqxUI
	lemEkI9tWCF0Q7mb9h9VKQ9ActoC+M15xlAkZbYUeuaXHbcjfKrc+g9cM5gDp3DI5/STolT7yNH
	7h0vIDXptKxE+orTgRMMGUzXWOmsK6QotfOM2E63Ijny1tUtM0CzEH1idNB2PjuXk29ryGV487j
	KYFW70zDk5OkqEHBVCy1MdPOuaAhPIxwQXcJoNeYdZy1ddS7y0gp6NA9KY98/UUiV4G1MIfA/sa
	PKRVUQcRKTAIH1FWNTGB6vlnVTmrkYY6
X-Received: by 2002:a17:90b:3ecc:b0:356:4ea0:e9e2 with SMTP id
 98e67ed59e1d1-3588918c444mr2082595a91.34.1771439643965; Wed, 18 Feb 2026
 10:34:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212-veristat_prepare-v1-0-c351023fb0db@meta.com>
 <20260212-veristat_prepare-v1-2-c351023fb0db@meta.com> <CAADnVQJqBqBaUZjQAGdchePKZMT5BMop8Sn1W5jmVOKUUdv0OA@mail.gmail.com>
 <02973092-a718-4374-a6ee-e31e8c046ade@gmail.com>
In-Reply-To: <02973092-a718-4374-a6ee-e31e8c046ade@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Feb 2026 10:33:52 -0800
X-Gm-Features: AaiRm51ioCDp_h4X_U8Axy_kcIw0y7DQw61BKD48Nxk6-u3-gclOjBHfhidVy6E
Message-ID: <CAEf4BzYFGdpdPP+HV085mhPmujW7kcE4TBxLtwu1PegOz_QAZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Use bpf_prog_clone() in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 8:22=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 2/12/26 02:45, Alexei Starovoitov wrote:
> > On Wed, Feb 11, 2026 at 4:45=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Replace veristat's per-program object re-opening with bpf_prog_clone()=
.
> >>
> >> Previously, veristat opened a separate bpf_object for every program in=
 a
> >> multi-program object file, iterated all programs to enable only the
> >> target one, and then loaded the entire object.
> >>
> >> Use bpf_object__prepare() once, then call bpf_prog_clone() for each
> >> program individually. This lets veristat load programs one at a time f=
rom
> >> a single prepared object.
> > Any performance numbers that prove that it makes a difference?
> it's neutral, I did not manage to record any difference.
>

How did you measure? I just ran

time sudo ./veristat *.bpf.o

across BPF selftests object files:

WITHOUT bpf_prog_clone()
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Done. Processed 905 files, 4327 programs. Skipped 11 files, 0 programs.
sudo ./veristat *.bpf.o  0.01s user 0.08s system 0% cpu 54.512 total

WITH bpf_prog_clone()
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Done. Processed 905 files, 4045 programs. Skipped 11 files, 0 programs.
sudo ./veristat *.bpf.o  0.01s user 0.11s system 0% cpu 17.883 total


54 vs 17 seconds. Though it's curious we have much less programs
loaded (according to veristat reporting). Still, those 300 programs
(if the difference is real and we should check why we have the
difference in the first place) should account for 37 second
difference.
