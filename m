Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DA385D9E
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363662; cv=pass; b=clMpe4vyfjZTpkla5OcH25aE/9WskRnnRUldxkRFI5k3BbYreAaiyIKi4SKr24jy6xqec0oiZN8tXwEGfriVAI03xNRtS8Su25QmYWXkyrqdoZz36emMqurHT2d95RZ1/j3Yv5gqN56RnilWomGmpxGKGxl7kg8lwoQxUqmHKew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363662; c=relaxed/simple;
	bh=riJyyQBHmcmUr4FLiqYcGUxqo/3HIffc80/U9WyxWpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/oKR45Wv0vfyjgcvfR9u9mzZeTCRrDRE1ZR6exvMJ4Hr4ZVc1w5hlYjJS/UkjDYGg27X7cjBbxUIax45zr+V1oQhnLuYcZPUHP9J4hoBIF+xQBniAGsPw8OWBBNnj+GX2P+5aNAicITJ8FY+YxNxkbloVp+WztLJamssU3Ipk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vzecz3l8; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vzecz3l8"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d6b393d60so6411cf.0
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 04:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779363659; cv=none;
        d=google.com; s=arc-20240605;
        b=PoGa6bFTGmxlsgFpERlZYRxVmWRodXOezCHLDaGisLk+CMqU63c+bcOc66OIGdBGsS
         6stIezDp3kGsecuLX9ETZlEaMjYvrAnCHr28vvTC8eTdacWi0lHiPKIJPIWgChvLDjbD
         ilHES6clvhn9NJEX+7GdkKU8+JSUQ3HEQZuc5FqZXkkdjcs4u+wVp4KqLHE5fnzPwOpl
         2idX8YPeP+WutMJBOnUToGgfhBLlOyrrIgX4XmRHIOQq/fEumij4tQmZZgKZxDoxbbDi
         XDTUpyQDm8knf4zI0AUTTmNzaOrQ7joKAVXruWUNCC81Kmld+WlgsfV61ROcclwybbmu
         iGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/o74v8Vq3GABGlC1t1lTUtlP7/VYHfplVzyMXpW76dY=;
        fh=VIindWiXS6mCK63kR9wRP2ObrCYGLN77DoR1RTXojDU=;
        b=N7Vag4EFncSXgjMqh978KvXLbq3b4ERhmE15iQ+pX5iKbfwra/b3gONldtZ8fOzbCP
         M5B534MOWWtxSx5o0T6qictSvU0ku5ukcmUsUljuVpT+LyZ90rD+8vEGNbo2L4km4MFF
         +gI1LMeBw1zSAIf1prRhEXEeWH3nBGvc9wJ//VDe+yOussZTulLiNBQ3YSv5fF93l52s
         9hLrA8k86F64dLneILF1eFzHHmGZw2a5fefYPx3WUH8IP8dKkO+wNU6uDaaa0fXt2FsA
         ovEh+EDE0PMAm4LY/uJXam0LlFrEzwAfBdo+X0kSo/bcVDFvLBxe85X5otqkLIrzsEYi
         cIAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779363659; x=1779968459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o74v8Vq3GABGlC1t1lTUtlP7/VYHfplVzyMXpW76dY=;
        b=Vzecz3l8Z8HlAE4eXB8ac5yjuUr4scO3+amtVCTVTVI1ycbXZBN02VySl2SEpkBlpV
         84+FJcIY8BRpNlclBLyw9mqiqQN/V2a6iRMJBzccwJ77T9nSkvQM7fx2LUYoE1z8P31u
         5kJidmpgtJ1/c3FWli28BxVI+i95FkHphTF6ql6JZQUTdd9cTALUZc4G9k3Hl5gaYAfx
         PgsleDCtdrbGvDw3EaCfAK4+FGdrpxCrlWjmv2l4XYXIyG7YnBe8MrJgCoIwYNr78zUy
         xP8jgsnTuVuqh2rhFPLMNVb+GjHC21hAhOR8r827ZtTJsKU/TLNmO09z8SAtSMY0Xf9u
         6MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779363659; x=1779968459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/o74v8Vq3GABGlC1t1lTUtlP7/VYHfplVzyMXpW76dY=;
        b=BjA8fi6BMexgSB4QLgahDnU/nKShk2U8njYrmGXZFX41hwgpjl8rm3iXMTu44E1NOU
         9FkSEJUL6utLGgeTwMeXh9cFytJmT0fMPL8vRSczdjN+Hya2A0RpafsV9lbX+RulksNn
         680NHZ85xBy3CrtPbETFPlIlYWhHsaeccwpkHcFQDwaSlrYZoreuRoBj/VGN3pcY6ALg
         /JLJHxMEuuPjipA1fbgRz3PwGsE3hG6/WYq4ih2uZJNOdN41bhoo289JCMPG9LnQzU53
         AVx3YBRFDqOuyVA1UcuRQRqRPrynFnD7P0FT5E9OXq74SHKf30lfz12JdRf+WuQSuGNx
         NZxg==
X-Forwarded-Encrypted: i=1; AFNElJ/5gNQkHUO0YRtziQk2nrGr23UYy6OIvAKI6Pz89oMRvsLNRs404sRhpUI2VsClwbrgTxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIh4uVqYIBmJQI7q2siklsx57/t/oL/YH01nqWc/SqgRuOsbCh
	+DQfBlV+NnVg5riKPJzDPDmuzrlsdqGAES01VurOkSEXR4vZ8NXHSagFwPMt0wkCbrYmu3m3hr+
	u+Z40pdMW/drszgTPN7fc5EkCoWIZ0HFyfMNNxQAr
X-Gm-Gg: Acq92OF4XMZp+iw8bGsBocb+USfvrUSUYXFijNXodD57iHS3r1OXKw4wWr8RNgRhUX5
	Sero7gLKjwpNGpk5i0A3QfCMUGazc+A9Zgw8UoVR4j8MsmFYtYgY6Sqyf0P2YHO9MjCt7LIz17Y
	4LOyggsTvsCJXy5GShGsSy6hiFeNVeh0DKKxVbgw9AQY5eCtL/t/+Yyn7Hf7a+O/lzUI4BcF0Pe
	vTmN2rBfLj0FJeVn84KgNRO63JVjfFq72AJWNLo6cw9upTwWLdCQepN8EhQXTtJkjfHoe4YaQZQ
	QJwZtz7XjFsXwOUwgRt+e2equi/cjgv8Q95k8hT8WFjsdVu0sg==
X-Received: by 2002:a05:622a:4cc5:b0:516:4f62:85e8 with SMTP id
 d75a77b69052e-516c552713emr8883241cf.19.1779363657940; Thu, 21 May 2026
 04:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com> <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
In-Reply-To: <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 21 May 2026 20:40:16 +0900
X-Gm-Features: AVHnY4KDqeWgH1b717hobUKU0xoHOtcJ-628JzCiilCfBkbsFuci0Aw-f-9_VXQ
Message-ID: <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: bot+bpf-ci@kernel.org
Cc: davem@davemloft.net, ast@kernel.org, andrew+netdev@lunn.ch, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	edumazet@google.com, kuba@kernel.org, jolsa@kernel.org, 
	john.fastabend@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	razor@blackwall.org, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org, 
	song@kernel.org, sdf@fomichev.me, yonghong.song@linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, maze@google.com, 
	lorenzo@google.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>This looks like a bug fix for an out-of-bounds write vulnerability.
>Should this include a Fixes: tag to identify which commit introduced the
>unconditional copy_to_user() calls for query.revision without checking
>the user-provided buffer size?

 > Fixes: 3fe213c040b3 ("adding ci files")

I completely missed this checkpatch comment. I will add the Fixes tag
in v2 if there is a consensus that this patch is the right approach to
resolve the issue.


On Fri, May 15, 2026 at 5:14=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> >     bpf: align syscall writeback behavior with caller-declared size
> >
> >     The bpf(cmd, attr, size) syscall copies up to 'size' bytes on input=
, but
> >     several commands write outputs back to userspace unconditionally. B=
ecause
> >     copy_to_user() does not fault on adjacent mapped memory, a short us=
erspace
> >     buffer results in out-of-bounds writes, potentially overwriting adj=
acent
> >     userspace memory.
> >
> >     Address this by introducing two policies based on field type:
> >
> >     1) Mandatory fields (original ABI): Return -EINVAL in __sys_bpf() i=
f the
> >        buffer size does not cover them. This hardens the syscall front-=
gate
> >        for the following commands:
> >        - BPF_PROG_QUERY (min size: query.prog_cnt)
> >        - BPF_PROG_TEST_RUN (min size: test.duration)
> >        - BPF_*_GET_NEXT_ID (min size: next_id)
> >        - BPF_OBJ_GET_INFO_BY_FD (min size: info.info_len)
> >        - BPF_TASK_FD_QUERY (minimum size: task_fd_query.probe_addr)
> >        - BPF_MAP_*_BATCH (min size: batch.flags)
> >
> >     2) Optional fields (later revisions): Skip writeback if the buffer =
size
> >        does not cover the field. This is applied to BPF_PROG_QUERY's
> >        'query.revision'. Older userspace passing a smaller size (e.g., =
40
> >        bytes) will have the write safely skipped. This size-gating patt=
ern
> >        mirrors the existing precedent used for 'log_true_size' (verifie=
r.c)
> >        and 'btf_log_true_size' (btf.c).
> >
> >     To support this, the user-declared 'size' is plumbed from __sys_bpf=
()
> >     through the query dispatchers (cgroup, tcx, netkit) to the underlyi=
ng
> >     writeback helpers in cgroup.c and mprog.c.
> >
> >     Cc: Maciej =C5=BBenczykowski <maze@google.com>
> >     Cc: Lorenzo Colitti <lorenzo@google.com>
> >     Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> >     Link: https://lore.kernel.org/r/CANP3RGfZTXM_u=3DE_atoomPZXutoQJ02n=
OMkCCR-YBZbOm2suWA@mail.gmail.com
>
> This looks like a bug fix for an out-of-bounds write vulnerability.
> Should this include a Fixes: tag to identify which commit introduced the
> unconditional copy_to_user() calls for query.revision without checking
> the user-provided buffer size?
>
>   Fixes: 3fe213c040b3 ("adding ci files")
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/259059=
28331
