Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8943E9FF
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848788; cv=pass; b=W/NgA1CJWsLjzACrrOA5EQdCISAhUjjTg3OPyuvRMkM0LWi1F1MCFPU1nN4bLukFyejJe4QNBquL/LToY+IcUWLP01sdbhdwJ8F5jo7DoUucoEur8shAynPDoMw9Clae0OAUrAcdOGi334Pv9tZ9hDRB771vbrmdcoL0G5OYfas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848788; c=relaxed/simple;
	bh=FEuTAJ7cvXYrNKltcj+rFQjDc4Z4pZNfiCFe6tGQHE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHVQ/ObFQ3+sv4DOJqNyACZtDTlZ5PGl1vhX83qBj5xZcgu3jW5Hd4g+h+KHzPbXbSOnug9OWO7NSQ9zfy9A53UvYNk3FB/T4AMLdxlOfhwcJQW/O7cxH0wVC06+t4IxNCMnARBQG2CmDsJx/cqadu7DLc4iNoxNw5wFl4LCBUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh3tOBaL; arc=pass smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh3tOBaL"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f4c92d1b3so1215543f8f.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 06:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848785; cv=none;
        d=google.com; s=arc-20260327;
        b=p5qn08xbbgsGRIr7sKaZm9z0NlHICXWJMREWylFAjFrvf31jgWOH11VkpXfmmhM9K8
         zjjgpVkWep3LDXy/EfsH2S8pLYwYl4zCXsg+YEo1LprOuUKJbn4qmzxBgKtM3R0WSs/a
         rMORXpH3dm+YqilBki9H5UrZyDALhs0TpWPvq8c0OdKv+ezmQ49qoLtbPoSctFnYPzc1
         zImlINOi3MUahT9TGuHMXmgFihyx1q1M7/PRySjGa3Zw/+P0utBSaibX8+LEWAkPtFTr
         r9XD6fS2m1mHvdPRxgtJnYX3Jmxo7EOr0ORC1I8tOHOoHIPl8QJJsI6X2EIXo2ThyTBs
         Z4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FEuTAJ7cvXYrNKltcj+rFQjDc4Z4pZNfiCFe6tGQHE4=;
        fh=5azqE/kgo7NNaU0KjPDkh/AY59AXbf+x3swVPAyQ+MA=;
        b=WBvejGZmge6oCkw4kJZTVqIATlp2Ps34RSlm414suGw9QbAXPiaSDdKufOGd2bD+PH
         WGmK/4JEG7LSZkE1HLtQyx36u91zws+EKgrEd+7X35tk1rzw4Gu96gF8qzmaVelTPKSn
         N0FeE345XHM0gNph2gR+4moBzavXxVFaCtHJi1Mh1JtJWFsZ86PotEN0U7NeplWrR0ws
         Q1BDpb/bbYVh5pkeMVShXNMTQn5s872itYTpWzeesJVrASzPn0gyQtMjd/UyQuY47rUD
         WU/JfYJ6o8HUBieTNXfnMs75quegoX4F/PTT+v4gX3nfx3kEfVfvTWbCXz+hogJXZyIk
         IBiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785848785; x=1786453585; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEuTAJ7cvXYrNKltcj+rFQjDc4Z4pZNfiCFe6tGQHE4=;
        b=Jh3tOBaLgd/YzmARC7GZTNCQZSayn4afe5F95Q2ishycsY8YmEDRKNqj8B5Xo37cZ5
         yeempMUZ9D545YJvnh0nxcK5SzztFFCfysLaFcj7/egGwMg8mrW9NuQNgVsOqoj9zVbW
         0ciWNrsbjS2B323yE9QK4oxIrH1hSOw/XpXepHQWM0RzobubCRHr6M2xtmllXvxym9zc
         CtutKIJq2Jm6c1aFw0E7lVWsPwwYjNQLhmiE+hn8vJfbWEqZG0pTuwY1Wm65aUMxuNTT
         XM+jTVmxFFBpgVzBRdAptsTY7ZDRDbgLlSIZ/+CABzLCThSgRkG/68x9TmEGxwtAVG8k
         vBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785848785; x=1786453585;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FEuTAJ7cvXYrNKltcj+rFQjDc4Z4pZNfiCFe6tGQHE4=;
        b=eMROBlHvGy9+X4ehDxNct3IZIbir56MJdIWvHMMCj3yhDYNJQs9sxWTmlyEaCait4m
         CDzex/H6OUXMPaBE3VsQUaCEVwPCg7Ph5gwfYoyFP+9O0vYJbRvO0PQwYsSIurGMMGkv
         mFwucQtZKOhku5k4DehEgMIBnhcimeee4Xi4HrMfqFbJ7sivfVi/5HCnF7p57fTbsv9f
         kcEv7I7NQtMLkGt7JYJlrnrqfjb7XJiMZBPBo8jiYex+SINQFupnlqtj2mM/5NV2iY5T
         O4zdk0/N6A2qeEG01mh6ZXVrgXWqQ7omrrzKRmxGHGLSBvttAq/inqIYqjYjGLFARTEB
         q0eA==
X-Forwarded-Encrypted: i=1; AHgh+RptpAzweopsKoperLqraYOIZdHLrWE5oNSxswdr2x4080iFFkvEWWyWKUZVssbw2A9NPhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJK1lNiVVDG1a6j1oo7fwOkSgdHNoNoqcKjwE+dHRpANEZCQ7
	58/X+YLyHEK/CrvBpKQXfkcj7ZuEEHDDe77LnA1OIy+njCHlwdJgz0ReIHk/V8+Pv+n3/weiQIL
	Vz3y25oNcgxdUwNp3+MQzkjsKEBHGFSc=
X-Gm-Gg: AR+sD10RAppN8ZoUp+3rh1U+uq0MRUiQ3AU8tC8Qi2MwEmUPkldm0GB6FxBuH/O1bNu
	+VAUi/JJ3Y9d78UBBMFiJl86IH4T/BmYVbkKDJdrm1Hk73cnd6NADXv5BEatyYQBL6cGh1pPRXN
	CnT6qA5CNUzmNCCXv9CMCudTlFyFmUkBYuBdvLxg68dH/YVc8GgGn1Mp+CEoaudcd3jKVfu28Po
	sJQ8KogvCQtBtAtWv1bAR6BKxfKpJOwRxz5a01ifKnO9nf/Ot2lBiZxamRoahDZ/gO3YbTd6M/3
	9FCoD+TiDpt4g7HtDB65VWmB0KTaxkG+U/rap+jt1zb8eRcp0rUlGj7Xz/ftmD+fV6/szEFS5iY
	UjFx2Ai3Uld7/IXMJVXEIgXLwLFshvdjACWNaCx/hJEHCFpYjPd3dlSnlwLaEbxh4Oll8lQ8x3/
	HG9trtI+lPvg2xUF0ELAhSSjMohcYKllA=
X-Received: by 2002:a05:600c:871a:b0:498:952:e276 with SMTP id
 5b1f17b1804b1-4980c66c991mr387897745e9.8.1785848784563; Tue, 04 Aug 2026
 06:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804083212.79271-1-kaitao.cheng@linux.dev>
 <DKG0YUDSTBUY.1X220287HT9V3@gmail.com> <4aa061ed-6640-42b4-9f12-e33edb8ba1b2@linux.dev>
 <DKG27RH0P7OV.36PQRQ6C74UR0@gmail.com> <dd8e114a-7aa0-4657-ba28-2929ebca0973@linux.dev>
 <DKG32J18PN0J.OP1J3RRHOU13@gmail.com> <8d256ca9-9291-4151-a329-d0b9bf101a72@gmail.com>
In-Reply-To: <8d256ca9-9291-4151-a329-d0b9bf101a72@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 4 Aug 2026 15:05:48 +0200
X-Gm-Features: AUfX_mzZrnewkHZeKMpNmY7REkEQm8YpUhI-Kzvc-0hdMSx-BuCBDTJ7_-nB6X4
Message-ID: <CAP01T759brVc7=HWHqtjcvLJYEJg9FjkjmdgBxTneS2J348uqQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: add KF_SPIN_LOCK flag for kfuncs under bpf_spin_lock
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Kaitao Cheng <kaitao.cheng@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kaitao Cheng <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Aug 2026 at 14:43, Leon Hwang <hffilwlqm@gmail.com> wrote:
>
> On 2026/8/4 18:22, Kumar Kartikeya Dwivedi wrote:
> > On Tue Aug 4, 2026 at 12:09 PM CEST, Kaitao Cheng wrote:
> [...]
> >>
> >> Alternatively, following the naming of GFP_ATOMIC, could we call it KF_ATOMIC?
> >
> > I think that is also confusing, every kfunc is allowed in atomic context in
> > general. E.g. bpf_map_update_elem() in spin lock critical section would be
> > problematic (due to embedded bpf_spin_lock in map value surfacing a deadlock
> > opportunity). KF_OK_IN_SPIN_LOCK_CS is another option, but slightly longer than
> > the previous proposal.
> >
> > In any case, let's choose this or the former one, and not fret too much about
> > the naming. We can also choose a better name later on.
> >
>
> KF_LOCK_SAFE? Since other kfuncs are lock-unsafe for verifier.

That works too, probably better. Kaitao would probably prefer
KF_SPIN_LOCK_SAFE, to make it more specific I guess.

>
> Thanks,
> Leon
>
