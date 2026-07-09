Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859F3FC5CF
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589132; cv=none; b=uRYdjk7m3hAZW3pz5vRfT21AMYV/m32zDIcFtAjvOjDAUzE5+lb79EkOv1aO8x9QgQI/4meghS9WZK77WO0Gry00r+GdzAfljn2AqtA7xhWizMhcrHY6XKpmEbeWr9svrGMIIodqeab3Yl9G/4MOfmM9kq9Y45VX21Lh4B+dA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589132; c=relaxed/simple;
	bh=INljEtR9XuimqnnnM0cBOeMB6UbVuHZzfXfOlFCEE18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbzXjDUq6S85Wa6EvyDKYhOJDBTdSF9VPjyOSH65aYIHct20OlBzDOjp+T5K77k0E7Qc/gqWpFWiJ6L1V1gzBECP2qMa3gkepqoGcDUfd9T4KMTFu21XK4MoaSxm3ifFJW93cfzkW2SQ4hUeyXhoAe+E6yI9aqrXhSv6fyuUdYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw0Y1lxj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw0Y1lxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EAF1F00A3D
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 09:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783589130;
	bh=pZ+whLM1ddrhmsje/lOYyteKiFq3zY0rHsjFJw3yK/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Bw0Y1lxjwAa0ERK7GDH3hMU2jFCmTJCUEMAGRudJaj0Lg6mFi5jV/xWHehRmEM54e
	 WPoJuZqfmeWEm0w6bj7gbEe3JfR1wL/7yTMunFYyOpm4c5EwNhHlviDCy4W1b3u5Sk
	 AOXHiBnvo7wyynvxZnjv/wcT8wfatN0UVrtVp3aJ9uV1cLA1JeXwU8mSQxELkoJwNG
	 6+ac45FIyqdteyMv9Q1+GhC4Ji9ZfsJiVmEpsPreU0wFcHA+O0VxDTPh61vErUrqum
	 haIQ89PaprkeZM3Bnz5POfYJ7GZczCrGMLCSlaj/cHxVmLRK293wqPSv0s10R1G8sK
	 gbhJqnvkFvTKw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so945482a12.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 02:25:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ropy0vNt8POWCIMW2H5RPKUeAUrz91rryySxJpO77IfQOxLl0EvKIOaDJlJEF7xgEWT3HE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Pj6BZr9z93l34s/CizejOmUjO5dnuzGbtp/F5qbChBTqtVSE
	cN2i3/wpEAXG9pShXkaesymrjIi02fU/042CwSTXrOIVQ1Vri+PjzFVGHXeyn5hwoZPqR/gXhmL
	ExaPWkk9/PON7brAlj/zzDZDiiq31uaY=
X-Received: by 2002:a05:6402:e8d:b0:69a:a036:e164 with SMTP id
 4fb4d7f45d1cf-69ab4493b99mr2574789a12.25.1783589129333; Thu, 09 Jul 2026
 02:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707101508.32283-1-yangtiezhu@loongson.cn>
 <5c81752f-5c57-47c4-afad-7cef78729feb@iogearbox.net> <054a69e5-c497-d8de-6acd-1625333d0ca8@loongson.cn>
In-Reply-To: <054a69e5-c497-d8de-6acd-1625333d0ca8@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 9 Jul 2026 17:25:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H55YcyXRewC+0YzTHXb1jab0GkAV13EF9nFbTx=UkX4ww@mail.gmail.com>
X-Gm-Features: AUfX_mwfnNTVafM0_AL0AV1DHSYXFI2uglDgd1xN9bSw3VK9g5Lg-9qKZrX_qYQ
Message-ID: <CAAhV-H55YcyXRewC+0YzTHXb1jab0GkAV13EF9nFbTx=UkX4ww@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix and optimize BPF tailcall for LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Hengqi Chen <hengqi.chen@gmail.com>, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu and Daniel,

On Thu, Jul 9, 2026 at 5:15=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> On 2026/7/9 =E4=B8=8B=E5=8D=884:58, Daniel Borkmann wrote:
> > On 7/7/26 12:15 PM, Tiezhu Yang wrote:
> >> Based on 7.2-rc2, tested on a Loongson-3A6000 physical machine.
> >>
> >> Here are the test results:
> >>
> >>    $ sudo modprobe test_bpf test_suite=3Dtest_tail_calls
> >>    $ dmesg -t | tail -1
> >>    test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10
> >> JIT'ed]
> >>
> >>    $ sudo ./test_progs -t tailcalls | tail -1
> >>    Summary: 1/37 PASSED, 0 SKIPPED, 0 FAILED
> >>
> >> v2 -> v3:
> >>    -- Patch 1: Add Fixes tag.
> >>    -- Patch 2: Update the commit message and add Fixes tag.
> >>    -- Patch 3: Update the commit message and add Fixes tag.
> >>    -- Patch 4: Condense the code comments and update the commit messag=
e.
> >>
> >> No code changes.
> >
> > Tiezhu/Huacai, do you want us to route these via bpf-next tree?
>
> Hi Daniel,
>
> Yes, routing via bpf-next looks better to me
> because it is updated much more frequently,
> allowing developers to rebase quickly.
>
> However, Huacai usually takes LoongArch BPF
> JIT patches into the loongarch-next tree.
> Let's hear his thoughts on this.
Yes, I indeed prefer to take these patches into the arch tree, which
is similar to powerpc.

Huacai
>
> Thanks,
> Tiezhu
>
