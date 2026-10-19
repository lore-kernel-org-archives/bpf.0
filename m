Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792426778;
	b=vzIvDXQatLwhPdz0aPsR1KjB/1M6cS4uV5Ght5iJFA9HWx+otpx5Ne9Y2OlIFoXkWhas
	 IkXouz98Nax7uBbZbVyIXybgBEdS3ttJFcpoXCpRLDVKhPQFiVqgkXl7h01JUUta2b0+f
	 cZ8FIoGzRpans3UCP2ERgfdiQ/r9iaUZkorGo1knKoip34yzBvWcwcJ1J++KmfvlB7zXc
	 5fngQluItbB6zhJ9CiaSZ+NRvOts1AFfeafDnr5oiNcqON5/viJq+l2YF6ZOUDmYt6GW2
	 ieHvYvkXg1pwbLubQZpJVgo21rRyKY15AzzgnOkhJtXEjRI/F4eWiBfAxt6kc6oUOHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PJJTCalwhybaV0YnpikxX4f4T6RunQfv+DiHrJ4+ZBU=;
	b=YHMd3d6SXjKPwTaMA75g78eQ/pim+cck3eZaYPOjLQWtMRqgtM3iCS6fULT6W68s+P3t
	 ZtGl4uCfcpgxLonQ3mtEV7ASzk6UlZXmEUowtqqp08XfSoXxWsJR1cZx3OoxHOJiuM7iJ
	 jON0GYm4xOAxIHoQUn22k4KC0/foMfb/9EeEOoZe/7c3qT45a+XYp/VmIb6I4OFuM24SC
	 6RrrWKcJEH4NmCy5bqwXMfENgipail9cR2fmeudTMcyjAeHkwGSyvEhCG8Nk+D02vxHns
	 kuNX0Q1qbvuE19hxpZHf5/6ZFRNB8PakfEAlYuih5+eYpFTC3b83IN7jPAgBPkz1jBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YgwJuMuA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7106606A31D
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 16:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7106606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YgwJuMuA
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab3260b2cdso1140387a91.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 09:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792426777; cv=none;
        d=google.com; s=arc-20260327;
        b=LwqQvUiuNlrNGpEZWIaV5B6rGI19hUnAuvbWGV1bM8E4dOPE4onQj89kM2mYh84AQt
         +VXjOXl0/8ITuOPJgD5uKD02wrxsxVMtp7WLEH0O3VHRSoO0rQxzg1ZSSh8JyBiOlijD
         TcINAeOvNIujW5hoEb1ucUN1AOA766230BWM88zNFVKzNvtFFAIo1+vYFgb3e/frQcwR
         CdRcGr8L24L52H37NUvODBBtTUOIAmkg0iHSL/BSN8mfG27jERpN+81UzJ73TmEGyYv6
         jREHTQd2DlQtG5YAPmCBuwo9aVPyWusDKft9TlmSpk8eZj55gVxkyg5cSsZNderAMbUR
         +FEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PJJTCalwhybaV0YnpikxX4f4T6RunQfv+DiHrJ4+ZBU=;
        fh=CgC6jO2zuFLoRipwHalfPlQ1qSxkRzgrq275PtFEEbw=;
        b=qQxQms2D6pUrBcEl4745KKdFfpZtArAIt5oxhSZvirNh03JuZraHVk/fpf4yItzQ6I
         ewX7dINSl/UdGMaDj6TtGwY282JZEFt6sy2r1wcVvyBbhhQSFJm0Z8Ed4fqwBTmUo114
         9Ph3X0COXCuss+ms/qKAUm/vf9h7y+vIpb5l7MXVOvOjhko2y95NPns497oOO6esLW0b
         OFU2T7w8SI4Olc0VP/4eWlV0AZQ39zsL+JkLfKhRAwZdwUPBufwh/VTajpj+R3UuAqCc
         j0milM0AuTQiAYChOLoazOcoIZbyTOZm5fqpySvt8tHH9cJ1DpdtiEyAxRcldoWzgOkG
         IwCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792426777; x=1793031577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PJJTCalwhybaV0YnpikxX4f4T6RunQfv+DiHrJ4+ZBU=;
        b=YgwJuMuAifhbXhFvTbAh+dNiezCsh9FgcumUZrh352cjGXc8dhxc22/r+1vsKEOuiQ
         HI+tgssG66wVWXA7yKPHd3X5X6Q5QZ5mZwhGEYYbQXYg6Kq+0nvp041dArpWfh/mx8ua
         TyO9l499UZOY5/RAJWULy4fgrZsKNt7jsbpNZ/BNReGeZuqFlzfNEYsd+DMPtfJqExz9
         Vik7WLiQIqegUicm2kQGtEq00UvxPYgsHeTv0jZhLAGzEcmcWV7VtTrLue18I6Doo6sO
         jZCTYgSwxAePX8YXHxdyU79eSW4V6uMV5ZCh4bym9h9rB+EgP5w9/RKcc06llIDuDCAN
         dfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792426777; x=1793031577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJJTCalwhybaV0YnpikxX4f4T6RunQfv+DiHrJ4+ZBU=;
        b=ZUJcHDu9pFAIsbMi9536A4lhTvXVLir5bWNhvzLnS44G6PAtAxXxT71f0e/bXObk6/
         83Vjrq37d8YC0mysvslmgwY/tkimnUMdQiyiE0MmMFMcfIfLL+j7/AVj+rU2aQekDMWG
         NImapo2g1BLGul61TEsUjvGRvl7XJAvtIbLtcWhnknyxufndEzuEjjNm2GReoUYxCsOx
         02Kw+cPLUJUkolUeHM1HDUqVbdIX3xP+vQ9usj5CMxsRmfB7C7CKcxrZtkss4YCG0f3q
         lGa9G3FhMcDq2zy/yXKd7w6p9Wmnh4gG11pkmn2XPEGdzvb1yHUd0bl8jqUj/ImXh9cR
         I8OQ==
X-Forwarded-Encrypted: i=1; AKwUvByjuAdhqU32NCjiPxPquYN2U27iKfYwCAx/H466sAest6XAWk0tHOqwZ7IAne+SX3ECZGc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbgBZUPpUpQ+teDbbEtzVkn85tk9IKWi+xr+ouvINgc3/Oe3lB
	lix6eBDP36lAEvZfJPHI4exmr5dp8WCKxsrJrD5gS5dBQTUQxlrFM07Ey2wBrZGo0ut8TNIqrdC
	2ZAcGjUDHWgEJaNOKPTXpcyx1IdBGIg8=
X-Gm-Gg: AYBFou3vy4JLD4Gcv92I6c1PBuh0davADEh+WP2gn3qD7H5E09iuv6yx7I5LHbPAc8J
	n2bGYebDEPCiNyvwDOM9lp095O0CbrxPGoAE8vd5GCu8olkE7YKNsXvB2Xd147fTejlIBN8D43e
	+LHXLN03sl1A4MJ1mo2w1Vtxlji5FFc18n7br+2PvGEuX2ZddvWhowD9zOquTFRepbBZbpxfqhM
	vW64wY5kvAMcOh5d7ijrI12uLk+sALbZhtcrec413lSS/zer4MNXzkF6Jo/7WaF6wCfJ/ymfunJ
	jI6vvhUcMVvAjGpns9AudblkErR6Xel/+3bm/teEn9SpG4aPjnU5gFo9Xf1/xeiWBjGtD52fhbG
	zNXAmDcjrqotkvi8IILxPayn26TzraimdViCD949WJ3Rrcb3eWTpF0Hkcf9So4JI=
X-Received: by 2002:a17:90b:3889:b0:3ac:17c:6e85 with SMTP id
 98e67ed59e1d1-3acef0ffa0fmr6944547a91.47.1792426777044; Mon, 19 Oct 2026
 09:19:37 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261010224902.1232178-1-arighi@nvidia.com> <DM6HVNSP3USV.AJSWS289Z3I9@gmail.com>
 <CAEf4BzZZRrD86ZswsB2r-swqNi7D1p52Vs=fQ9MXSgGATN31Jg@mail.gmail.com> <DM7JXB4PREVH.1BHG31CCNRXF1@gmail.com>
In-Reply-To: <DM7JXB4PREVH.1BHG31CCNRXF1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Oct 2026 09:19:24 -0700
X-Gm-Features: AclHuK-HFgyrtXdEf6EddMbv0AqemeagPcniTwi6V4E_qoHT91-FJu0HS9ZwBfw
Message-ID: <CAEf4BzaeXxoPqtcV6E1x8zh-Uv_C1cfNjzUYLKDWwod=k2ttLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Expose pinned arenas as sized bpffs files
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Don <joshdon@google.com>, 
	Vineeth Pillai <vineethrp@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	Shameer Kolothum <skolothumtho@nvidia.com>, 
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>, NchangRoy <royfru44@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 5:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 16, 2026 at 12:52 PM Andrii Nakryiko <andrii.nakryiko@gmail.c=
om> wrote:
> > kernel to do that. But once we have the ability to create ARRAY from a
> > bunch of pre-existing memory (e.g., from memfd), this can be used both
> > in a guest and in the host, and both models, guest allocates or host
> > allocates, could be supported with the same model.
>
> I don't think it will work for their use case.
> With array of maps scx needs two lookups and two NULL checks
> on every access, and the result cannot be kept in the task ctx
> which is in arena today, since ptr_to_map_value becomes scalar.

fair enough

> unless everything is converted to magically bounded array, but...
>
> > annoying, but what if we teach verifier to just automatically add
> > bounds limiting sequence (e.g., masking if value size is power of two,
> > slightly slower sequence for non-power-of-two, of course)
>
> while working on arena ~year back I tried to add runtime masking to
> ptr_to_map_value and couldn't figure it out.
> then in ~april I tried again with llm-s and failed again.
> the main issue is that ptr_to_map_value is a pointer,
> and progs keep adding random stuff to it.
> There is no way to split it into 'base + offset'
> and apply mask on 'offset'.

yeah, good point, some food for thought, I haven't thought much about
this, will keep it on backburner for now

> I tried alignment tricks, like align each ptr_to_map_value's base
> to 64k or such, but still failed. Something needs to remember
> upper bits to see when math overflows.
> That's why Barret was using explicit mask in C on every array access
> (when he implemented all kinds of complex data structs on top of arrays).
> Every access in C was base + mask(offset).
>
> Array from memfd is a separate topic. So far I'm failing to see
> a use case, but if it's not a lot of code, then why not.

Yeah, there are just so many cases where we have some memory that is
special in some way (e.g., huge page-backed memory, or some IOMMU,
e.g., that doorbell stuff, which, if I understand correctly, is done
though writes to specially set up memory ranges), and we can't shove
all this into BPF_MAP_CREATE interface if we want to have BPF program
accessing that memory. So having a generic way to just bolt ARRAY on
top of already created memory seems like a useful primitive.

So we'll give it a try and see how it looks.
