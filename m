Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C3386C25
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601783; cv=pass; b=L11PQgvc/f8F/WQV3nWUQPpX9YAlj81SSP9H+VzdR3MeCd6PpeL3z4dgwVAB9Qzn+Mwlz9/SKuEBke9f40Gr/n5wHFV5dvJhe+znL4RMH3prm6n07QxVR3wtsUYwUjEGLUM885IgyiWqKWKtlBufpMptM/bMt+EE210IhMXT58E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601783; c=relaxed/simple;
	bh=Jj1eMW4hRuQ95Mf8+sMk0J8dXwuhop1yzKow3ZKRqdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYjFpHDWHRCzn8IHvBxD0AjF25Nf8Ec4uh441oQskUpAAQRwvZ+qglhddxU2aTAqg3selep5r3QEmxxvCdbBE6eBprZz2bfVNAMuQU+G+pz2o4g2q32N5dhtN9hFhGRTdW5bPCCDxMogpGrk87MnrjRV9sBsos2tyEQhCnXzIo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7VMH41k; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7VMH41k"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so2829706a12.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787601781; cv=none;
        d=google.com; s=arc-20260327;
        b=kGwl3G0oV6iWlKrM/cu+Pfi/5zPVEn+LiwT1Scel7XqCTTuQv7/8xGHzJzWzIZYvbn
         zCKQ04thUzFJIOQKiJz1S+9tC+VBmN3bkYZ/TWgQPEBHzemZUNxKgn15CmWTeCjwcX85
         iSfElWz3uSbsKPAchOjfw44FXpsqrum00veK5fS3CDv0+TsfF4fpsQiD42Xr3PVIXVkf
         91/0xV5pChP8KC3+3pSInfEf2Bl76E2fBln9AVsqX0KfynyqRs01bBw+v93vvAabGrVY
         6pBv2iHA+6pgQI/mNk5lJ0jYvawSc1sb9cryc+Ps5m37nOt67kO/G2ig5GWr6OK2tswe
         EJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3mEWmWLPfbBEGQVJCFnc4zzX5ivCTH8MT18ptDlEOY4=;
        fh=7PZC37LH2sGqwLEK76lee9BsohGzibMfIH5NgvVumkM=;
        b=SczsC3frXV7E67mN6wYdGUsJl1suMUzJtIj3ycUjPy06DUcjkUucLS4mjoRABxMAH7
         hODILqJklQlRvffOB3E8PM4AwWraFp+tWH3Qc45TCs5VhX3NoOhNGaNDsMW8LwJ+To9I
         PuC2fR73TVBVORFkEzFEuwNzNmPwytU/Gd6z6sJyg+COqt6yeh2Nl6vJN/+KNpqiwWIM
         1eWDSGUHADFl0CjgdJtVSAYv5ueDiktvfqRf3ZUVkSicxFyzjAnc2puBMvdN+RvjitCS
         qYDK1l6gsg77kkXeeFam5EfneI4C3MAStz80uL/VFH5hGjgUsIxmYTfLSkl7hI73tySf
         54DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787601781; x=1788206581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3mEWmWLPfbBEGQVJCFnc4zzX5ivCTH8MT18ptDlEOY4=;
        b=J7VMH41kmK8mIuh9ZjV9D9Avu9Xa6+mp8Rq9yfrfFzNvpEQTiMn7b40k1QNkQenpuU
         Kl5JjYabDxgWO0yyz2VX9daDVetNFn8sQsJbxPE8e9SOjNm7P/geY7Ao1iLlrnO8UPTg
         2KGPa4wak9VhlrL423otduYahQMbmTOSO37R6amPpv3/tl1HmSdBL89hM6Zt0sTNeh6g
         9rNZk+wL3O5WyiynYwH/L9Z8b6SxCgulO4C2XDQvn3uBQTBp6sjaSRmUcbE0T0zGbg9R
         vyUVoLV0N81FfLrt2eIvf9/4x+AS6GF1Yzw2nGx7sCD2Z9/U2xKTnyhsC2KgYm4ekO77
         nX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787601781; x=1788206581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mEWmWLPfbBEGQVJCFnc4zzX5ivCTH8MT18ptDlEOY4=;
        b=nO/UqevnrQ07kaN+wyqvFtJ9nf4KTW//yRDWcNIr/Kg9pUpkqvGzKMTbrQDmIaJnuS
         YESYqFJHep0NvluYdSMsjGDgb9ZrjchhEici9DMK8f59kudEZLKl4L8NZhF66dpRoNso
         p+n3RxVUs6wyjF4tHCfk2XlAl38rolorrvoHpIHJGq1k3kmD9qf+uJc7z44KrjNI26yp
         uSTLUIn9eFPEi3sz+ne4MqhjMLrkgsQBaDdJwILsNSWv4wZbWfbiGJfrx55SIAj5R/AD
         YZkrYcfnSyj+hmF6QLIyBY6ONANeEasnKouUsICDRKVEHRCgK2tzjIS0CEPmqNjBVDVI
         qZTw==
X-Gm-Message-State: AFuF++mbR5c9JS9d+5dlGCJIqOu17Rl17ndpTy9ian7BCuaOJEHHb0aK
	9fkPib9yYeGDGf6Uq1drsAKtxd38eXMMcyFdiiHjix7RjnXg50Edb4fk7F7h5Z+MnEJ9a/XKi+V
	qEV7cX0h59qenv6IOHmGmUZsxUG0Z7d4=
X-Gm-Gg: AR+sD10xpfqjXlWjjsOgLr1qS7st+0Nu+j6/T2/2HIy7ky9bpiNXoA13SnhysbrBhke
	tL6k30XpWIrnluJo0gwTRLLDoZAoubSXOjJUW7FA32PktjXVCzs5f3ApEuIiO5dzQSNIaAqvIf/
	ra0jofTNe2HtgemdKJbH62EqqpG+9qFwIPktc2vh1MMlBu9qiAHE9jzOd4RkNuOlbRYEJsSNOnS
	oCTperl3/v07Qd2cuTirxBSCVp2dAPlCFrf6BJPD/VoDJJTU/lvBYual2t8JnkitQz7NqrO6SR/
	nSCR76SGKjOOZz+YdaqjqstLnhC6WL50wLe33MtKhpqGRZri1j9OQoNTxlCvVaajz9V3aRT6U/7
	83ysDV5TCiJhlLU3s4WJZEiG/fO9LmLTqOt2nMSnM+g==
X-Received: by 2002:a05:6a21:e96:b0:3cc:b26a:7686 with SMTP id
 adf61e73a8af0-3cd9107fdecmr2555856637.6.1787601779615; Mon, 24 Aug 2026
 13:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809150111.45000-1-leon.hwang@linux.dev> <CAEf4Bzam=0V6n4_vBahhYh2Qn9KfriDKXSz58L4L+teHJRWfPQ@mail.gmail.com>
 <0b30bc97-2ecf-46eb-a863-94e706e18c6b@linux.dev> <CAEf4BzaXaLLqs6XXCG_02c7UcvNWfbGUAJTYosr22oaD4iokuQ@mail.gmail.com>
 <c71d27ab-ec59-4b72-855f-7bf437095cd5@linux.dev>
In-Reply-To: <c71d27ab-ec59-4b72-855f-7bf437095cd5@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Aug 2026 13:02:42 -0700
X-Gm-Features: AcwNN1W7QHx2RbjWvAKjCJKxsiFvI4VgPdw5RI8B_3Oxui6UCoF584p_UxygwRo
Message-ID: <CAEf4BzZpB-qkhu3SAu5MrYYAT2+ZN8WaXqpmnKruOOdjJOLK2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] bpf: Add tracing_multi link support for
 bpf progs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Avinash Duduskar <avinash.duduskar@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>, Rong Tao <rongtao@cestc.cn>, 
	Eyal Birger <eyal.birger@gmail.com>, Pu Lehui <pulehui@huawei.com>, 
	Jingguo Tan <tanjingguo@huawei.com>, Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 10:00=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 22/8/26 01:46, Andrii Nakryiko wrote:
> > On Sun, Aug 16, 2026 at 11:20=E2=80=AFPM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> >>
> >> On 15/8/26 04:14, Andrii Nakryiko wrote:
> >>> On Sun, Aug 9, 2026 at 8:01=E2=80=AFAM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> >>>>
> >>>> Similar to the tracing_multi link support for kernel functions [1], =
add
> >>>> support for bpf progs.
> >>>>
> >>>> When attaching to bpf progs, it must attaches to the target by text =
poke
> >>>> way.
> >>>>
> >>>
> >>> Please spend a bit more human effort on justification for the change
> >>> and explaining your use case. In what case you'll be attaching to a
> >>> large amount of BPF programs such that attachment speed-up (if there
> >>> is any) matters.
> >>
> >> Will update the cover letter with justification and my use case.
> >>
> >> Here's my use case:
> >>
> >> I'm planning to enhance the function-graph feature of bpfsnoop [1]. It
> >> will trace all bpf progs, including their subprogs, to draw a full
> >> function call graph including bpf prog call sites.
> >>
> >
> > fair enough, interesting use case, definitely outline that in the next
> > revision (and provide before/after attach time as well for such use
> > case, please)
> >
> Will include my use case.
>
> Implemented the attachment micro-benchmark. Here's the result on an
> x86_64 16c16g VM:
>
> ./bench tracing-multi-attach-progs
> Setting up benchmark 'tracing-multi-attach-progs'...
> tracing-multi-attach-progs: prepared 1000 identical BPF program targets
> tracing-multi-attach-progs: fentry created and attached 1000
> programs/links in 679.324ms
> tracing-multi-attach-progs: fentry.multi created one program and
> attached one 1000-target link in 470.042ms
> tracing-multi-attach-progs: fentry.multi creation/attachment speedup is
> 1.45x
>
> The speedup 1.45x looks good. But attaching to 1000 progs via fentry

I'd say "meh". If 500ms is ok, 700ms is not that much more noticeable.

> costs less than 1 second, which is really faster than attaching to
> around 1000 kernel functions via fentry:
>
> bpfsnoop -k '*:(struct sock *)sk' -m entry -D
>  Tracing 1096 tracees costs 11.597266736s
>
> Thanks,
> Leon
>
