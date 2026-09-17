Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC363CB
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607313; cv=pass; b=VmHPRDwHfKaDG+1H8ziQxgjjWJkPW45/yYnpZiqiD7jj0mT9WshClRionxECw0zcqL/eh5Yqmutg4x4A5uqOUz7WoP9dEoOpd/djKHxW+LXs7/3mmS1XnB4RjxOccV6WPgqUSry6DlSu3n91xhtU/HTq+wsaAQuhgFC5mqpspjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607313; c=relaxed/simple;
	bh=b/Xc9HzgZjg7fhanYRzVgdWXqQGyt9NTKLSAqLreHuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OU9MUR4g9GyiC7yWppAfJBQf9N4j86ZjPcgUjkBWzb02aYeZscAZto94D8XIzgu4AC0cZXt9DhBuezX/FQLgb/Kg6P/8peXkMLq8XMhXNMzlPpl26CnYvw4XYjYQrplnrXgmMmZSrkI+hcUFRzxrdYL8IGZ/cf4cYgCSfRUSxvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UznuVFUg; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UznuVFUg"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8631d0023daso193670b3a.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789607311; cv=none;
        d=google.com; s=arc-20260327;
        b=EuFBFUs0XxN/1kxiMCTnSL5lbL1Dtu39q6sOzpHe1ZuC4OwvN7OQRvwEuIcY3i+zjo
         HRvUE3oxN9QNsTg3t5HmmD5iXcxXQAJoy6BBEJNfXlgmzNnRiE2EuR0kUaTEvfbmaI8s
         EdPm/tPm19+OX6bry6xSWWEaUI5chXVoyfzg4gCVweE5dKSNVoeuJNHAX2IsOSnnc950
         auRLZjVla1WogVh44zE8VPOzmv/NZM/MM5vhycwdMxl9lQbRdeJSDFKfUbwRiMhzDviY
         zUdEcc1he5FBr7mXnhiFqs0IsOa4BvJbIarILsWuyf3ipHZOpe/IfBtIdimWcpNB34f5
         9sTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jupEOQLptiGPgmt9L56+vZqjhOjmzrPD+LELh2pfe+U=;
        fh=M5nk8zRlCammrAUYuReZUkLuaiheBRYF8C4xRMj9RJA=;
        b=k5pcn/mkMCmNpoCvFSj5BgyLL0lOTr/jJAAnjMfXvNGWNX111P0XfDwcz9+GBHpLUM
         yhlkB2fGwVViLZzQFMKG/Xb07mj/aVHFrBOFJeOnLYTz8G1s6JfABpyKjfkMef/DendN
         0qXlw0z2NiKbRhnQP9GOFoXvYos+9OQdHXAlIaSEDh99mcEF4MVynySQY/pn7CebZhho
         bW58UrhyF99q42r2bpqEfZQGFpZPIA2CK0Aoni2G0MsGhWgXJctpToW22WQ9yfW4FHsi
         s2gYbMDboJsOycZN0If40jS7sVP3/dfZVFs9cNuhuAvtN/+lKBINJvJsXXSInd99DJkO
         SwYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789607311; x=1790212111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jupEOQLptiGPgmt9L56+vZqjhOjmzrPD+LELh2pfe+U=;
        b=UznuVFUgGQLBTuAVIjVI6aWVt0rZ4YOpoR/3ZcdwGnFolGhgcgrOBALXIQ40DUIcoF
         V0iH+FQrXXIQTwC/HL1LulUWB8wkVHLYAwEZv7PQmg7+++mJKLbWwhFKbzN02cNczjzp
         mqsouFmFr40ojrt4GZ0ApEPHpYi6F/y01GkxmqhJXSaDa896/rzeeYE7wL6LcI5g/ATi
         SXlaokkEXD2D2VsEnjAeuIsZ2Q1EIhXogApwAMyTyOsukL+rnGi3knhJUjqoEecDP7Tr
         9Pm1883eO7MpUodbDLKU8cl7G4wjlbAFuBIrOauJyFhCp8K/NEmRX6FIWCQmFkVnaR3D
         P3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789607311; x=1790212111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jupEOQLptiGPgmt9L56+vZqjhOjmzrPD+LELh2pfe+U=;
        b=danhsYNZO1t96zQ1UbyyB98LWLvYVBABhsgXgKE29xyGLEfJuZB/iFGdEVeAAsN9Dw
         0KwcjCbZJU+OaNUwG1ViYF60Ll4pB/H+w51paQrbcNfDISYqnZC+gafj5Pz6V30JSVio
         d6zSA0G5OWUNSsv2ZSJsMm56k7pm71EB01hVI/MeqkD5f6QAYjPtZ0kPYt9qbNBj6vdR
         j2FkgMrWS1bace5sIE08PyYjHiYWx3NY6ULze0GQv7eNwugAzybexp7+1iyPTZ9EgvHH
         W7vB+EKB1BAGRMZMdkhUw9ekiHcfqT3oC7FiQxjaOTM6J6yfLIFXciTX5ZDK2npHxz6b
         b7Qw==
X-Gm-Message-State: AFuF++mXudfkjxIAMzNPis6kVF/O/noJ/JK+08OfkWjwlX87adpR9D6P
	thuNPOWWHXqAXEKAXO+SMZeCLjOLOJG2/tIWXQEnD6BjeTz0jsZS2UkBjE4geS9ezk1C1XW8QpN
	PbTqqtrXlP3aOsfx9qSb0uyv+75tFcX0=
X-Gm-Gg: AYBFou3dPI4l/ql6YH26Ad5Yo6+h7Mq5KHUHEQE1qXg91i77zEzamsPSDD4f4OK/Yfu
	KRBgJGKGAA2Trh5Q7MMcUMsEBUUtOliXl/lBMZWBMT/yebMrtsmOkHkh+k06/53GGQI38togX8f
	YWySoJnYp0AbcmKYILO/w3BS4CzYFlULkXRHwwkosKDH9WxHWcP1Yxb5jpuvt1OtBlyRAM2M78Z
	4Ub0bmJm8mLaX1m2Jz55UgPXpe8Tr8bxYRWyeDi07wJ5Puy+5xf8IO6XON4KB+zn7gjbDR1WWVF
	vz6/eGNM8J0hLaLvnfvX36LIJVogDKLAPB3bYPPpwqlNZWX+zZn/hrDvjJXwkqm4X/CHeydUrdN
	C2gr/fhSFphCtC58Se6mYAez46lHJJJzWs4yNSJj7GA==
X-Received: by 2002:a05:6a00:a589:b0:82f:38df:681c with SMTP id
 d2e1a72fcca58-872371c72d0mr9144213b3a.6.1789607311168; Wed, 16 Sep 2026
 18:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916212102.597335-1-memxor@gmail.com> <20260916212102.597335-10-memxor@gmail.com>
 <DLH6GI0M7GQH.3MTAVNEGD97AV@gmail.com> <DLH6SM4M6XL2.1OB88H6MWSRR0@gmail.com>
In-Reply-To: <DLH6SM4M6XL2.1OB88H6MWSRR0@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Sep 2026 18:08:19 -0700
X-Gm-Features: AcwNN1WAv4B3_BEGllXlbQMSnbDm1grDIeLmEteRKuMkp8J3pBIt07cjQ81eGBc
Message-ID: <CAADnVQJdXFfWbJv8r08+EH++Ud7XxKO6FiQgh1pTHLkGJGoDzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 09/10] selftests/bpf: Check callback map value
 lock identity
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 6:06=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu Sep 17, 2026 at 2:50 AM CEST, Alexei Starovoitov wrote:
> > On Wed, Sep 16, 2026 at 11:20 PM Kumar Kartikeya Dwivedi <memxor@gmail.=
com> wrote:
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/=
testing/selftests/bpf/prog_tests/cb_refs.c
> >> index 78566b817fd7..490e15e7126d 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> >> @@ -13,7 +13,7 @@ struct {
> >>  } cb_refs_tests[] =3D {
> >>      { "underflow_prog", "release kfunc bpf_kfunc_call_test_release ex=
pects referenced PTR_TO_BTF_ID passed to R1" },
> >>      { "leak_prog", "Possibly NULL pointer passed to helper R2" },
> >> -    { "nested_cb", "Unreleased reference id=3D4 alloc_insn=3D2" }, /*=
 alloc_insn=3D2{4,5} */
> >> +    { "nested_cb", "Unreleased reference id=3D5 alloc_insn=3D2" }, /*=
 alloc_insn=3D2{4,5} */
> >>      { "non_cb_transfer_ref", "Unreleased reference id=3D4 alloc_insn=
=3D1" }, /* alloc_insn=3D1{1,2} */
> >>  };
> >
> > \robot voice
> >
> > This is the hunk that doesn't apply. The two context lines above are
> > not what bpf-next has, and on b
> > pf-next leak_prog still expects
> > "Unreleased reference id=3D4 alloc_insn=3D3" for an acquire done inside=
 a
> > for_each callback, so it will need the same +1 after patch 8 hands out
> > an id to R3 at callback push time.
> >
> > Chasing verifier-internal id numbers in expected strings is fragile.
> > While rebasing, either drop the id from these patterns (match on
> > "Unreleased reference" and alloc_insn) or at least fold the expectation
> > update into patch 8, so test_progs is green at every step of the
> > series.
> >
> > pw-bot: cr
>
> It got mistagged by me, should have been targeting bpf tree. I did a CI r=
un in
> https://github.com/kernel-patches/bpf/pull/13872, which is green for bpf =
tree,
> so if there are no other objections it can be applied there. Otherwise, I=
 will
> respin tomorrow.

CI didn't run so respin is necessary.
