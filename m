Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B02260B
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099631; cv=none; b=OauVOg9gbloElmVlv6lHJQAEkwxzG9P0IjLU7P4uzybLwgP+KujYhgifeUbLCwFCGkwcKaRksFDyGz7FjbxyJY23SWaqA+9x8XK/lc/tumyjEObNfZm6SEe8VncXkhVZe7h+ez2duvM/7kPoCfsGy/T1Ix1AWTc83Ue2pYuuqAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099631; c=relaxed/simple;
	bh=MmpZWUBB2vKBfw3rmXpNn5xt2H9k2XXIg4L+f4r28ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaKCMvuP8TtTVuqEjXFUCs8cuDcX/uLfBIRFJ4B3byDU2wLK9oFX6sbLrcAp04IRwLw/ROFncXflAY5/JokPBAYFNFKRLLE9a9JFbKUF+vZNnbzw/7nDBALBkKGlvhSz9Yono1AxlWtDsq7VKnnERlg3mE2J5hcLtr9tpd1Vjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=UTLENcKq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UTLENcKq"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6151e2d037dso14878957b3.3
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712099628; x=1712704428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYMcrejXI7GPCev86KeNEsV+/yEflaCRUuzZ3qW3MXg=;
        b=UTLENcKqEXRv2MStX+r6JXtkY72ji4GWSore7AmbzCNlyV1LHtjWKqFz4nK186iqow
         soxtNzZ8kBhXbkvK4qyWhrNVFIsA8SrgrGWch1yUOR7B/1HbmvZCN5CCOQSWcd2HoXkO
         M2rTW8+BcHaBU/wnEa6N7Ewm9bCc/uq3QbfbLJbE2FlFD6jEdXqT8d7+49qI6IdUGVfW
         0SaYrn4MT4Luww2noJYZKyuzjQYXL2y1yxfV/QOneEMm542FZE+wwTu1bmsTXXgwcYiB
         ZAMO+rzE97TNnnUxzGj0o2QWZpT84FqSV1nWlALOxMX445CE4zVFEYDVhDZBpv0AVmXs
         sUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712099628; x=1712704428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYMcrejXI7GPCev86KeNEsV+/yEflaCRUuzZ3qW3MXg=;
        b=mEdbr/KcuXcKLBLsp7Wh2RWJkHzfWv+xNz4qRMr1SmopZ3TcE+9Lf+8Iw7IKExuRcA
         xO/pb4F8Lsvgt66p0oATW/ILWlbfkrQC9kztDu2lOr5Q51T97o3CeLjbT+tLLZl1BNgL
         Js2nKu7x6aQ87ThbZy7eOyvb3lN9773ODQI//V7j07SpTXhIa3g3rRPx5jzRbPjNjt/u
         oiXADU0aDsrSdpdUwLpVMIQYd2u8f2xqtv/nkPCoCHsC8T/ARtPzWUMShJANMc8Cu+Uu
         PQAHm/16fqbVIqAAFKXFJJenyCpv11JmUduyy1uulmAkQDXRyJ8DXHR1muWZyC3PERcf
         1iFA==
X-Forwarded-Encrypted: i=1; AJvYcCU3fJraLefCDYLXUUGUP/AbQFHSQT9rguEa6sVUDdDI0ow5by6V0KTlktkZbnzuy6nhdhjWXW8xyq1VQZWWk6vtuW+x
X-Gm-Message-State: AOJu0YzlkMpusLi9AjMw/zJvz/8Csq5QgR7sh1VZIqC7v016O35ZNI3y
	2EKex2n91ZfJRe9qhlegkx4y1/fCc7YN/2kVH9bm0ermQPuUtxhsK+L6LnWw9kjhuPe1cdr80z1
	e8qoZfczAV/6Yrb1ew4sU1QQD9/W2aAr3Gbyb
X-Google-Smtp-Source: AGHT+IEnBrm952jlWPpLFgUaPqkiKdXOguSeCjPGJCbzO/vdeND3YPYQ3vdEARGNS5GzrWokTa+QGVRndw7PdKYxXmY=
X-Received: by 2002:a25:8b81:0:b0:dc2:398b:fa08 with SMTP id
 j1-20020a258b81000000b00dc2398bfa08mr10836302ybl.31.1712099628382; Tue, 02
 Apr 2024 16:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325142834.157411-1-jhs@mojatatu.com> <877chfmoe5.fsf@toke.dk>
In-Reply-To: <877chfmoe5.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 2 Apr 2024 19:13:36 -0400
Message-ID: <CAM0EoM=dXbS-=h_oD13Rg4VcmAGFm1Je-nM0KhA4WXkO+RGpzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v13 00/15] Introducing P4TC (series 1)
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, 
	horms@kernel.org, khalidm@nvidia.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, dan.daly@intel.com, 
	andy.fingerhut@gmail.com, chris.sommers@keysight.com, mattyk@nvidia.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 5:43=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > This is the first patchset of two. In this patch we are submitting 15 w=
hich
> > cover the minimal viable P4 PNA architecture.
> > Please, if you want to discuss a slightly tangential subject like offlo=
ad or
> > even your politics then start another thread with a different subject l=
ine.
> > The way you do it is to change the subject line to for example
> > "<Your New Subject here> (WAS: <original subject line here>)".
> >
> > In this cover letter i am restoring text i took out in V10 which stated=
 "our
> > requirements".
> >
> > Martin, please look at patch 14 again. The bpf selftests for kfuncs is
> > sloted for series 2. Paolo, please take a look at 1, 3, 6 for the chang=
es
> > you suggested. Marcelo, because we made changes to patch 14, I have
> > removed your reviewed-by. Can you please take another look at that patc=
h?
> >
> > __Description of these Patches__
> >
> > These Patches are constrained entirely within the TC domain with very t=
iny
> > changes made in patch 1-5. eBPF is used as an infrastructure component =
for
> > the software datapath and no changes are made to any eBPF code, only kf=
uncs
> > are introduced in patch 14.
> >
> > Patch #1 adds infrastructure for per-netns P4 actions that can be creat=
ed on
> > as need basis for the P4 program requirement. This patch makes a small
> > incision into act_api. Patches 2-4 are minimalist enablers for P4TC and=
 have
> > no effect on the classical tc action (example patch#2 just increases th=
e size
> > of the action names from 16->64B).
> > Patch 5 adds infrastructure support for preallocation of dynamic action=
s
> > needed for P4.
> >
> > The core P4TC code implements several P4 objects.
> > 1) Patch #6 introduces P4 data types which are consumed by the rest of =
the
> >    code
> > 2) Patch #7 introduces the templating API. i.e. CRUD commands for templ=
ates
> > 3) Patch #8 introduces the concept of templating Pipelines. i.e CRUD
> >    commands for P4 pipelines.
> > 4) Patch #9 introduces the action templates and associated CRUD command=
s.
> > 5) Patch #10 introduce the action runtime infrastructure.
> > 6) Patch #11 introduces the concept of P4 table templates and associate=
d
> >    CRUD commands for tables.
> > 7) Patch #12 introduces runtime table entry infra and associated CU
> >    commands.
> > 8) Patch #13 introduces runtime table entry infra and associated RD
> >    commands.
> > 9) Patch #14 introduces interaction of eBPF to P4TC tables via kfunc.
> > 10) Patch #15 introduces the TC classifier P4 used at runtime.
> >
> > There are a few more patches not in this patchset that deal with extern=
s,
> > test cases, etc.
>
> Unfortunately I don't have the bandwidth to review these in details ATM,
> but I think it makes sense to have P4 be a conceptual entity in TC, and
> using eBPF as the infrastructure to execute the programs. So, on that
> conceptual level only:
>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>

Thanks Toke!

> [...]
>
> > To summarize in presence of eBPF: The debugging idea is probably still
> > alive.  One could dump, with proper tooling(bpftool for example), the
> > loaded eBPF code and be able to check for differences. But this is not =
the
> > interesting part.
> > The concept of going back from whats in the kernel to P4 is a lot more
> > difficult to implement mostly due to scoping of DSL vs general purpose.=
 It
> > may be lost.  We have been discussing ways to use BTF and embedding
> > annotations in the eBPF code and binary but more thought is required an=
d we
> > welcome suggestions.
>
> One thought on this: I don't believe there's any strict requirement that
> the source lines in the "BTF lineinfo" information has to be C source
> code. So if the P4 compiler can relate the generated BPF instructions
> back to the original P4, couldn't it just embed the P4 program itself
> (in some suitable syntax) as the lineinfo?

I like it. Note, we do generate the P4 code embedded as comments in
the eBPF code today.
We'll look into it ;->

cheers,
jamal
