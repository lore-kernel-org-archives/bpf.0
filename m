Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1223806AD
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485425; cv=pass; b=u3iU55MJMq3Jw00gnF/6FSKihXJfoVqarYrlVdY87c2eSgACU8XlOYJ6uit4L7WWEhWT46UECIh45SY/KMQ0M8/W/dze43wRwKzoZMqtOU362Xp1sdTWp4WGXQaY2GC8lsOBujYX6YFx5nW6GgNhr1MnTopXZrLpRA2b1tcfhDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485425; c=relaxed/simple;
	bh=0oshv46xLuQzPLIPdH9A0EvaVpAKTWV20KUKhaXBiSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEm7Crs8KWtPY9dA00angU+TsGzFBB+9llrTOve4WvFV9Lqsxg0UXTJHHpgP2Cm44kGIQYsM/MARKmHZgLR+G05erADeWI1sAGthPyRlmCAFDHW4oYxlfYg2A1M7/vwHFbxCOEQEKjz7tWr9PMJ2r0o21WjVCOHTTT+WZ2q8+OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XeoTYTd5; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XeoTYTd5"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso21585a12.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 07:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775485422; cv=none;
        d=google.com; s=arc-20240605;
        b=Y0cUWOqJ5V+bLYdOtujPQEeM7x6cNCFhMJ545Fiz9/BpiU0L67jVeADZ7Tzix2FscB
         wM49DBb6wCOpC0csDWlpNDMoxgGSu4I3mAHw8xgRKChDmO/jaa69xd1o8RR0AwIxpG+A
         cLqZjdmL6dxJMXfxfAq3FXvvBCD4xE83cINYqaZXELZS1Vq6jpKOIHucwAm7O3rotDsd
         pjOiq3/+Qo2zoNW3uhwp05a0J7uqqhH9aaoIqkQeLFov0jLRo0FiWeolBUEv7cwj+abK
         4mcBg8J/3q9JIuUsO095pqN7/GHvcysPXE5xKP3+GiIM0lc5YsWrfGENX+VBNBgSyKQ7
         hKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4foAE2z+Q/MQv2J0mPBdcU98fqKB0vyTweCETb8dfag=;
        fh=3Q3qZB/tUSSKa0jD/aXIaAQv9dbelhuCaD5sPrZdVrU=;
        b=ClefidzQZ7zsCFi1a+UDAqVMCZ+oHYIJ/rdCKtMJqnq7wHLF+kRjb1Sn0Zo8XYiCav
         ML2Kjm7IwCcsg7mFkl6jeRW+99lf1FxWO/bdwx+TvStIiAiOj9rEf0Wt8GOmRAyzegtD
         UdEQydxQYhfE8YgGGLi9DAmdcTooklr2HUmQXoPn97j43DaVHbZZY7zIzmX0CMrsNKDf
         uCb6BiflOpLRI7C8rVB90+WWKO2KFQjarH4TfKnBUe790rZ+wMX5tsfcJYUOZgb51KJ0
         CWe/SEcaJzBYy3/MTKGuIXouY9SB8EaWWURQC8n1xS4GIa41kKH9VgdspXkr1dcc/x6j
         stvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775485422; x=1776090222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4foAE2z+Q/MQv2J0mPBdcU98fqKB0vyTweCETb8dfag=;
        b=XeoTYTd5wSE48JW8kaM0qv3ycrSE9eyeuCIskQwqlA84Ij2A9Xf6y3+NEG1J8FRvIQ
         t6bHLyFisYQzufw6dVUDCO8+C3SQMB2M3WjdVqRea1tMTT1qZ12ijqURJCW5YdMxgO/U
         0iX1FKr+yUwYvrYESOPuxPlwn8N0qKaPS2HrSIaYdfALRFDkTWB6DFUsYj2vLBsIzzdt
         uxeS2dppQQhcpnblsFY4Z4BNYMbYJ5yQSZk4VljRhDO6MTvR1NaxLYhYgKToGQoccHBJ
         uk0Miz7PmU3O0o3kStbFvFjYl8NPwzt9LvF2y0FdSXBEcd20f/V0vddkkgTmfWnI5ZQF
         agZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775485422; x=1776090222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4foAE2z+Q/MQv2J0mPBdcU98fqKB0vyTweCETb8dfag=;
        b=IbRy/zOp9FE5rsO722t0J5wSfZP0qL3cVT0fW2wvSdnK/VaeW0+vERF0UfV3USDO4R
         S+3BGJypcMR/ws3889HKcMLG2avAbDr9UVXm/0+WONM+5RuSuXC0m2qr70op1kme8MGN
         GVaIgzXIZBXKqYz7XJyWxko4yiYAqvqhv7VtMax2xMat0MAa/HgDFh+U8ZSyBvubgqMm
         we4e0JQZjc2ps1kS8HZqGfCwQqv/OcV7Obrkgc9bKBMOJQVbC4inz5f0uDq1Nv3ezqYg
         alvNK7RzreIb2CI4tr+H7FWqHJo8VbpZKOXru5S76RYMTb6oPFgza/9uG1x6IffSqjiz
         mE9w==
X-Forwarded-Encrypted: i=1; AJvYcCUqFqywi/H9sn7Dq/SJb2xhUj8Nxqk6v4tERZ0apeHzhxRCsay9kj9ZSHf671USRXFnLhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl8kRxmpfynUVoJw8CS3LZ/dF6lxuF/1zzBhpySC4nMcAPKKOg
	fuvCVnrTRsGNjWKp/Y/59HPoRU5D09CuS88KgXiqtgaNupc5dDyqkscbXvkBkTJIUJh4SfpxYJA
	qWAcX9TDmSCNg7D/oI0gyh2mJb0PHGU48tHMZz+N/
X-Gm-Gg: AeBDievtXiR2z2X++ohgAofed2LZ/bpBbtf+pHB8CWxQe3VgScRc97AxNVjUM1HUHko
	H93ZaaQJ1lbFk2CYr+buLgsCmbgZlg7FB9X697Q2W9kSgOqXZS+PWKvJ8AhDBskPxs4l9l74aGu
	aQVSLZOQwbmwhWPfZfd5n8r8qn/nQp2w6Bj+YcOI0q81P41bFcuF5UWMIAQH99BBvOV1+eY2t2v
	2oH1xFjjfLHt13dgqJwhKYPBlkkQRNz7j9m3cguGhMaVxe7cmhFJu1AwtIMMFht+nOzl6jTOs/R
	eJ+UZzg+fiCvIdX4KA==
X-Received: by 2002:aa7:c383:0:b0:66a:7b3d:f43a with SMTP id
 4fb4d7f45d1cf-66e43cdc3d3mr75635a12.1.1775485421479; Mon, 06 Apr 2026
 07:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403185236.sjgetnkha3o3a4d3@desk> <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk> <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk>
In-Reply-To: <20260404034954.t7iapenzvhdpagxp@desk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 6 Apr 2026 07:23:25 -0700
X-Gm-Features: AQROBzBKIPcP_H1GwuJoXUrRRJVPGk443GCqm_WEh0Cd97H-YqzPVn5MR8nDNUU
Message-ID: <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 8:50=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 07:21:02PM -0700, Jim Mattson wrote:
> > On Fri, Apr 3, 2026 at 5:22=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Fri, Apr 03, 2026 at 04:39:54PM -0700, Jim Mattson wrote:
> > > > > Since cloud providers have greater control over userspace, the de=
cision to
> > > > > use BHI_DIS_S or not can be left to them. KVM would simply follow=
 what it
> > > > > is asked to do by the userspace.
> > > >
> > > > I feel like we've gone over this before, but if userspace tells KVM
> > > > not to enable BHI_DIS_S, how do we inform Windows that it needs to =
do
> > > > the longer clearing sequence, despite the fact that the virtual CPU=
 is
> > > > masquerading as Ice Lake?
> > >
> > > IMO, if an OS is allergic to a hardware mitigation, and is also aware=
 that
> > > it is virtualized, it should default to a sw mitigation that works ev=
erywhere.
> >
> > Agreed. So, without any information to the contrary, VMs should assume
> > the long BHB clearing sequence is required.
> >
> > Returning to my earlier comment, the test should be:
> >
> > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL) ||
> > cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
> > +               bhb_seq_outer_loop =3D 12;
> > +               bhb_seq_inner_loop =3D 7;
> > +       }
>
> To be clear, my comment was for an OS that doesn't want BHI_DIS_S
> under-the-hood with virtual-SPEC_CTRL. Linux doesn't have that problem,
> hardware mitigation on Linux is perfectly okay.

Today, BHI_DIS_S under-the-hood isn't offered. If the hypervisor
doesn't offer the paravirtual mitigation MSRs, the guest must assume
that the hypervisor will not set BHI_DIS_S on its behalf.

> Without virtual-SPEC_CTRL, the problem set is limited to guests that
> migrate accross Alder Lake generation CPUs. As you mentioned the change i=
n
> MAXPHYADDR makes it unlikely.

I have been unable to make a compelling argument for not crossing this
boundary. The only applications I can point to that are broken by the
missing reserved bits are (nested) hypervisors using shadow-paging.
Since both nVMX and nSVM support TDP, the niche cache isn't a concern.
There are compelling business reasons to support seamless migration
from pre-Alder Lake to post-Alder Lake. If you know of any other
applications that will fail with a mis-emulated smaller MAXPHYADDR,
please let me know.

> With virtual-SPEC_CTRL support, guests that fall into the subset that
> migrate inspite of MAXPHYADDR change would also be mitigated. Then, on to=
p
> of hardware mitigation, deploying the long sequence in the guest would
> incur a significant performance penalty for no good reason.

Yes, but the guest needs a way to determine whether the hypervisor
will do what's necessary to make the short sequence effective. And, in
particular, no KVM hypervisor today is prepared to do that.

When running under a hypervisor, without BHI_CTRL and without any
evidence to the contrary, the guest must assume that the longer
sequence is necessary. At the very least, we need a CPUID or MSR bit
that says, "the short BHB clearing sequence is adequate for this
vCPU."
