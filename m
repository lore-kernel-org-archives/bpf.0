Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D6351C2D
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098192; cv=pass; b=QGhaoFvb+p4k4k1erHw5qDorTx/0WQop8O9COWGBQaIz4zZuMtUsCqYjasuPMAHI2dw+uMu8pDQjy/y1O7vm/zoM/fDpVWUtuYlWw+tma+bZ7/S0rq1rRPKlz4S6b/c6dEkwKtixj1M9w//coSZ09g9jlu5f7Zyts1enQkswUY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098192; c=relaxed/simple;
	bh=s24YjcNDlm5RkCq/PpxAqixsoAF1LSfQA7DLLpd5Rvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZawBL0tpYoGo9PSnKVZnJ63smN+oDVpC6bTOW0pDnFi87T15w/rAdLPVPm6E26xYm4u8gjcRiZKd1YIEhJ4hWTng4kjZ5tEbv+ACEACz9IoqQMAVy0n0E1DnzzA6d6YXt/Q4bjaIcMvg6Pd2/5UteisdNO3oDjTQ4CExqudEd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLJ5ZqyL; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLJ5ZqyL"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-516d78ba1adso6131cf.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 16:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780098190; cv=none;
        d=google.com; s=arc-20240605;
        b=XiLOb2Z9FxY8mIT02wlINZj0qOAstGJi/d+kce4l73YNL+Xrdz0qbddKdcSzeniI6g
         rwx11N2NE5nRrgCVDobQLxd9z4Gygvzn/qEfxQwaOzmXDwgNCV4ptkYir5vxv3xdxovf
         WYmDh+aH4/ckrk9FZx57Pxdjr/Ir/qkNKAKJatUG5jNJ5MN5xEjTPLla/pe46hgwtDzC
         ujLH2DFndK8O85XZmUqbPEZPZsuQVpWF0LGAD5H1pMVYFZnrO36ZdQwzulqixcYX+fSu
         mFQRgXSZXnC070eop1lGtsQw9ZuweLWwMKSIcYq1KrcKgJKXvi5ILb1K6MShUMj+5enB
         9kKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tKzq7IfcEZUd3hgNxILmg8jMvNqPdQHBBOhGY2G7POA=;
        fh=Pqw8gmuOfiiN4jM2IBM0H2qRWsMNteDF4atNww6709E=;
        b=E7km2Oomjb8mC7MApV5ODx0y0Oyk+mp4lEn9VtBCzLdOfcCB0GjMkvTI7aWzy7xLBC
         TNT78PPx6dS36Dmcq0M2I/rmqxPxzSyIIKE7JSxn8ubhquhYwCoJitBLVh2qaaSOp/+M
         4bqokDNN/PfF9cd20fF3GXcyqBpS+YGeREMV4DyApOkCcmiDcISr0XRPACFa/fJC5glb
         083fWog0ic3ra9gYVvzD6dw6RhX62YBiPe2Ei03LGhDbDPszCktH/yoWQqcd2zWMsfjf
         AKQZfVuHrJ3gjwM4PPZ40N3nSGd2lipIxLkF3mzYaE1dzXxk9rT+dcqDskizkIDqVqAf
         GImw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780098190; x=1780702990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKzq7IfcEZUd3hgNxILmg8jMvNqPdQHBBOhGY2G7POA=;
        b=sLJ5ZqyLgFGzRytaxjXwrF5SYHqWFCPB2mwACUvWOzeMFUEFPCkNjiJ+TgVHLhJ4jI
         3b4M4aN3SA+ZdQWcu95JNMjfaODQ4pJnAMnIeyW9/IIdDl16J6B+8kJ9csCHYoV1zE8V
         IVQ+n3QP1YBOsxxsvCyUvB2fQOoW2v15on/yO7hc5NCZHUwKxwq1aY2JypIxeSqyquir
         AXf13tGp3razthQCOpqSbHxYdw6ZHiPU0bAOs02C33jzygv6wZYL3ggBDpOxl2GH7Alh
         8t50zhGJ63P0vM24YFh0sVn4al2/1dkiUfxENoa4pSbFqpUDFKrIU5a7UsKt2tNKHVRx
         09hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780098190; x=1780702990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tKzq7IfcEZUd3hgNxILmg8jMvNqPdQHBBOhGY2G7POA=;
        b=qZpPkShu1rJWy2mlo9Ompp6UOjBMBEjXz1N0yDLF56KwZ7UW+gBwdJCk7Q0Bt7xclf
         zIGWXZDY384Xl1xRqIy2vyeV8uo75AmpXk88hLoH8WJGEhrsNmDYT6nT3yDUCHE9Gtde
         niCzRhwgccJuIWvAJun6kYPFzP7QWQ+czQe8d6MjJG+Cm4c4z4yoVcKYQTMUOUsDVEzT
         IdohCFXPBVpmJGON54IhU1x9zMPLB5KQQIxIVycNe4A7h+JUQ/vKJq4GqLt+uh6gciKq
         0PLqDqJyMVqOdVpmRVCqgfcxeIIJKmugaZ3C2hWHyEaYm8fja6tCJtfotgLlv2ShKs6h
         VQ1w==
X-Forwarded-Encrypted: i=1; AFNElJ/2S52Q2DM3ty2ZCyMf3AKGu4JK+0XzK3AHxg5E50hU6Pe8Y0z34KOsiE29nYaty18oCGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3bm5l3AG3znM+BJ/JdXtzz5jddGmWFXSGwU/HSkW7QqKRBi4n
	vtmebW4LJR2cFPiP3pt1suRu+Jcm0dDQ9a47lepZTWpG4iChHcM2AASZitU+1SZXtilMGQmI6UP
	/UMS7EhmlnmGDq76PFPhDr1Fez44k0329ivpbY54v
X-Gm-Gg: Acq92OGWCfBmqEZYevCrNnVpzNFyjupH+gb5ktFntp4nwLqeyLRNUgJCmw7kSn2yRyD
	RR0Op4fQoN3KBRBPazf8FSC4LTK1aL8ipwuu1Cqt2Eizrr08G/azYLF82BfOXRLIAIks/KMzJi3
	kbkzJFxZNL/1bbBPgmXmG0AzMIfssa25nLYquzVFjdntwLdMfpHdj3Z7RIORRjn4DUuHhlwAZ7n
	WFCW1wVJcKR+MSAZ0PAFKViol4d484BiVGLnjmVu0HKIf584vEQFs+XEW5HT2FnR3zt/1tveVr+
	KEYpaoZoEDRBphbmw6XfAQImdFJzkhK+j4Hn5g+AAWXOTE/fJPexEwy0cmzRH3LTDMeWgTlEjbU
	=
X-Received: by 2002:ac8:520a:0:b0:516:cc18:4760 with SMTP id
 d75a77b69052e-5173c7f8e90mr2205181cf.21.1780098189444; Fri, 29 May 2026
 16:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
 <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
 <DIUR88219HWQ.26T4D7ZX8CNTC@gmail.com> <CADXeF1E-QpKj-37T5ghiycXrVR_YN72fOc3M4OQg-Arz7JNjsQ@mail.gmail.com>
 <DIVG6ANND95G.2MC7WWJG1P01A@gmail.com>
In-Reply-To: <DIVG6ANND95G.2MC7WWJG1P01A@gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Sat, 30 May 2026 07:42:33 +0800
X-Gm-Features: AVHnY4J1Ig3EmZdh4uvcsIMLiW1cS4wpj2bYrs1Iukydy3ntReQaRHUXULNuSBg
Message-ID: <CADXeF1HQ-Ep-DVGfDs7u7YB9prjAuotS9qRBg2xWP980a27t_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bot+bpf-ci@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Todd Kjos <tkjos@google.com>, 
	Carlos Llamas <cmllamas@google.com>, Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 4:36=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> I bet you fixed your android setup long ago,
> so all of these "but what about backward compat" is getting annoying.
> Whatever kernel patch get merged android won't even backport, so enough o=
f it.

That=E2=80=99s partially correct,  Android GKI does stick closely to upstre=
am
and mandates an upstream-first policy by default. However, we merged
this specific kernel patch into the Android GKI 6.18 branch as an
emergency fix, because internally we determined this is a kernel
regression (introduced in commit 120933984460) rather than a userspace
issue. So only kernel fix is merged, all the userspace program is
untouched.

We want to avoid carrying out-of-tree patches forward into
next-generation Android kernel releases. That is why we are raising
this here: we want to align on an upstream acceptable strategy to fix
this issue so we don't carry a permanent fork or risk regression on
future rebases.

> Replied earlier that I don't like random checks like this through the cod=
e.

Acked, I will raise a v2 patch to add theck in bpf_prog_query.
