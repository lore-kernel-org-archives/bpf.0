Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62935E1D1
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860128; cv=pass; b=H1up0QwgSgXUSvqc7Tx9Qzbc159sMwKu0CT9L7QQ89YkbreZg+bFHgX+c0tILkjdVYN5rKZbANVUJEOJ3uSDcMiFOC9NoW8P5zUklaXK0gIa8urAYLbYAtJxNHKxo8MbSLNuxN94KMtw8j7hIl73u80KC45tU4YmzbH2A+MrYpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860128; c=relaxed/simple;
	bh=T/K5UlzDllbLEYYLehMYSn+//Xryze9YYv1LULQa/mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYea/M5HMsCj7Ho34BpVcLD40hjto9hxYgcEoWydhR6HcAtfjaBMRf10su4FsFxT/80pYOv00R+iQUn504+4GYUQVJlLAzcHEtCOpr9KKj0b7dPkaAGziO7kBpZ6Dmou7l6MjERyR/ovHCd2EBsoz8ogHegcfeW3eDTRs623emQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFwqJugu; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFwqJugu"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7fe4808741eso21436877b3.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 02:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781860126; cv=none;
        d=google.com; s=arc-20240605;
        b=OpPjBF52C8yR5fn7ZBFMKZoBxQdl8L7jvWh0RvhYGVj7TFIKiiYW6cpXOH8J6YsTk8
         oFm4rLQEYHCsf+dHKxKVrsFeupb2cn2HGWLgM7m+exBGDpi1thVUcHbMp6tjpEg893LH
         +jL0w1hjOsqCNi91D3uoSZVaSmjiIYAdKemi6Ce14hT6Fvf8ni/3y+Hr63wX5OJRgz6Z
         U+XYFaEqeSSg4eYHnRLM3qVsZCMM9x8MijkAoTWFoUTPMVcfCr1kK3EggBkVb/878qNG
         O718vgfznCoTqyIVPQVtDilt6IMLkCeJGZKFY3RTJSLklxyBvwyiRYs9eV/lroyAJazD
         yryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T/K5UlzDllbLEYYLehMYSn+//Xryze9YYv1LULQa/mM=;
        fh=81ciHR/9jxmpd+fL1O4y1Eo1Z60Oc/O1CyOi7F/OA1E=;
        b=He9v7bz0bFcm15RSqVz53+OgJx/8r1uysZ2HjQuVjdNtgxSzGYMd1RHHHWzrNo+La7
         62FrwOf4uX9g52D7L9KbRvVAMngMeQ08KGdSNkgXMxKf8M/5shE1sZLJj1FfM07uzKUK
         Oh7rVqys9nFvK5P8RrOComU9q/sczRYOMDHvzAcUr7HpbtO343RE+kBovFLXnuOxfJ0z
         l+PB78E/+129FVoL+BVkHhYUSRufvYUIb/vfYUowEMgPfYeNyFeWdVo1/3MzGJkgL8z6
         HPjoxGfi5GVkeKv2RHMWhhbM97DdqVNTq7UVGQcvoUavt7YhZJlWqs5FXmkcZT/trU33
         65CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781860126; x=1782464926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/K5UlzDllbLEYYLehMYSn+//Xryze9YYv1LULQa/mM=;
        b=PFwqJuguw/X0MUQPzdQpu5Du8dVYZP2egHhfyM2XKAgtuc0MJzeJiwUKuXM3+wzlYR
         3J7u8mlJBTUJ3gjoMCJwiMfoFBuVJyJVne7+yteAB/vBGxhPYroC2GigPQKHMtRhbO32
         PMR2qW2I3UaD3n0/PNiWivNArf6goAbIF5t2w1i4Lxw3VPqJMB9CT7qSOzPdNfOKUVuS
         28UUmHOI12RmR1XgOopLs/Aupz+GAEspuWALWsVQcmL2OEYpGjrd4pKjGFdFumU5g02L
         GthAIqLH5KQ4ILMJ/gOsiu1Lap5eqBY2HVEbGTCmfZTddKw/KsJsNPJTL0wY4TG1Z8Bk
         Rhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781860126; x=1782464926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/K5UlzDllbLEYYLehMYSn+//Xryze9YYv1LULQa/mM=;
        b=H0/otXUgPriaDkfDMA2GlfS6Ew7aCvFayJzotZFqSGYlMmAQsQGea2GZMBUSrdcVN7
         t0xLL9pQpygeljgFcaXQ08AGfepOb/Dx9YNBmETjWGlpF3KaPKxkvajkd7cWy4o4hozs
         Ns/n0kKU5hkz6FyoNLh6i/bsdmMBvHh8SRJTN0dBTUv2PEFkbhTatwISvxpoxyzkfB1K
         cC5M4aEogjMsETiBnzcKacc9PQSlZGq42Bf3LyqNj3v0zboQ6A4Gq+jcaFufKkdzqRwh
         32yxF2OpiXBoX2yZjnrGpu+uBMKi97KXcdhdHfMsIbCiHV5HsHBgoW+bjVYVDG+qcSoo
         cJmQ==
X-Forwarded-Encrypted: i=1; AFNElJ89JH75fIyxNcq5NsY8RPTSGnXIxVJ0lC/Fllj1jqsUURaenfx4umx4NoDx3htdGr+6vGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5vu1NgEHGL9VsM53pg2OSwJr0KJ3VGXkoLSJoHqiCFiwBQ5P
	57wIJEGxxZAF/hFmijx+/nht7/Ixs5TTNLN8Xxl1u+nSGjdIFyMbs7A+OuzqC2fBcsrOq6HVf9L
	9vA3qXXMc4CT5HQ6h+HwYa18xr/UhgV4=
X-Gm-Gg: AfdE7cmrLhbHHPPWEGimVPkKxuRvU0148FzKI0Vi8R2vJN8KIABJqlep3Q3cvEvQMmo
	Q40nKl7jYU63+Ez3b/Ovol4r8UZcSrQoVMxOG48mNkAH6lqD3rZi+oYJp9Zg2FmTuJPaY9EbMsT
	LiDml8Wqzlv4Sk+ri3YwwNlGuLS3NhylIXweK3vaXmMHGm9cNjkYafPsGsxPo5zh23Olcdg0zuC
	Met9Sa4VLv7ov+V0FyF+Y9F1Ast0J7sSJuRrtAIFfQvrMFAVX05I/Ed3VXR6z+EhhHWGNzOpuU0
	ppjFrb2k6Jk47sB51nbK8Pe4xvPHqjowBiQRYytu
X-Received: by 2002:a05:690c:3705:b0:7dc:ca63:b0 with SMTP id
 00721157ae682-80132d3838dmr20841087b3.40.1781860126104; Fri, 19 Jun 2026
 02:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
 <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
 <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com>
 <ajOv_oOd1zInaW1b@mail.gmail.com> <CABFUUZHCr=4kb7kSaaPGpc4nkyn32i-svD9v7ONF+TYrrQ-xaQ@mail.gmail.com>
 <ajT3x2H0swzg4yhm@mail.gmail.com>
In-Reply-To: <ajT3x2H0swzg4yhm@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 19 Jun 2026 17:08:35 +0800
X-Gm-Features: AVVi8CcmPEP5XdoxB6X1yoIuhlHbMlAQ1h-E7WonW2hkMbAK-HKHfU53WVaNd10
Message-ID: <CABFUUZE6uZDjaxa-ss9CYhjNTCt2Z_ND1S6-nGvCLg7hDLTEQg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com, 
	lorenzo@kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 4:03=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> On Thu, Jun 18, 2026 at 06:45:18PM +0800, sun jian wrote:
> > On Thu, Jun 18, 2026 at 4:44=E2=80=AFPM Paul Chaignon <paul.chaignon@gm=
ail.com> wrote:
> > >
> > > On Wed, Jun 17, 2026 at 10:19:52PM +0800, sun jian wrote:
> > > > On Wed, Jun 17, 2026 at 6:31=E2=80=AFPM <bot+bpf-ci@kernel.org> wro=
te:
>
> [...]
>
> > > > I tried reusing pkt_v4 and the existing TC program, but they do not=
 fit
> > > > the skb case this test is trying to cover.
> > > >
> > > > For skb test_run, IPv4/IPv6 inputs with a too-short L3 header in th=
e
> > > > linear area are rejected before bpf_test_finish(). With pkt_v4 and =
a
> > > > linear area of ETH_HLEN, the test fails with -EINVAL before reachin=
g the
> > > > partial copy-out path. If the linear area is increased enough to pa=
ss the
> > > > IPv4 check, pkt_v4 is too small to both trigger the old
> > > > copy_size - frag_size path and verify that the copied prefix spans =
the
> > > > linear data and the first fragment. pkt_v6 has the same issue: afte=
r
> > > > making the IPv6 header linear, only 20 bytes remain in frags.
> > > >
> > > > The existing test_pkt_access program has its own packet-access cove=
rage
> > > > goals and is not just a pass-through carrier. With such a short lin=
ear
> > > > area or small packet fixture, it can fail before the test hits the
> > > > bpf_test_finish()'s partial copy-out path. A pass-through TC progra=
m is
> > > > therefore a better fit, because it keeps the test focused on the
> > > > bpf_test_finish() copy-out semantics.
> > >
> > > If we're keeping tc_pass_prog() then can't we use pkt_v4 and get rid =
of
> > > init_pkt?
> > >
> >
> > pkt_v4 is too small to construct a meaningful nonlinear skb with a stab=
le
> > linear/frag split while still exercising the partial copy-out boundary =
in
> > bpf_test_finish().
> >
> > With pkt_v4, we either do not reach a fragmented layout, or lose contro=
l over
> > the linear/frag boundary needed to exercise the regression path.
>
> I think I'm missing something. Why can't we use pkt_v4 with
> tc_pass_prog() and a linear area of ETH_HLEN? That would leave 42 bytes
> of non-linear area, so a SHORT_OUT_LEN of 30 should work to trigger the
> bug, no?
>

I should have made that part clearer. With a linear area of ETH_HLEN, the
skb test_run path fails before reaching bpf_test_finish(). After
eth_type_trans(), skb->data is advanced past the Ethernet header, so the
remaining linear L3 area is 0. The short IPv4 input check then rejects the
packet with -EINVAL.

To pass that check with pkt_v4, the linear area has to include the IPv4
header as well, i.e. ETH_HLEN + sizeof(struct iphdr). That leaves only abou=
t
20 bytes in frags, so a SHORT_OUT_LEN of 30 no longer triggers the old
copy_size - frag_size < 0 path.

> >
> > This test uses a 9000B packet so it does not depend on small-packet
> > allocation details. Smaller packets might work depending on allocation
> > state, but 9000B reliably gives us a non-linear skb with page frags and=
 a
> > stable linear/frag boundary for the copy-out regression.
> >
> > init_pkt() is needed to ensure deterministic byte content across both l=
inear
> > and fragmented regions so that the memcmp-based validation is stable.
> >
> > Thanks,
> > Sun Jian
> >
> >
> > > >
> > > > For XDP, this object does not have an existing xdp.frags pass-throu=
gh
> > > > program, so the small XDP frags program is needed to cover the othe=
r
> > > > caller of the shared bpf_test_finish() path.
> > > >
> > > > Thanks,
> > > > Sun Jian
