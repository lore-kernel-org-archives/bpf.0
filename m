Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE51F4CB3
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490177; cv=none; b=WU6g8yTkV9vzZh6V/JsizWsTGfXtV9Gz0ExSqTsUqMC0vZQeX0spzBZwPyR+U9f8wb6GO/ugB3UnumM754S/dDABsDuGx6JtHbFBAtYmZ+M3U97TkwpEEibl3JwNg8mvJbccEbt9Y4xfc4MqWZ3dnMgwFJKE7+wOGZWPH/2xRLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490177; c=relaxed/simple;
	bh=xCsUMh1nS0mbpecrkieLhDPcw/OPT3goLS49yYxNSRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBva/6cKq5v9smwk8T+SEMxCha7HTW85ij19dIXIfoCIWrMogHTuDoPHjMR//wEeKVCoicdzSvrD1TYHNj+Wz+47z2i/TufLRVk9PAc4SOhB4he2GvfoMd1/BNzoJB+U0+LyRRZIWW337NzRQIkGsKlDHjC/eyrcK+rGJcr7khM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dul78nW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dul78nW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348FF1F00A3A
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 02:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781490176;
	bh=xCsUMh1nS0mbpecrkieLhDPcw/OPT3goLS49yYxNSRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dul78nW2dqUIKlU/reSDfwr6HPyemYksu2t0et3SRTXnr2JD5WO0Z/Tcw0I9RLuQT
	 xiypR5l0gB67CA9nrd5d55k+RRtIuMJbLSzVMOETWWGqSimIlZEzHqrZpnONI4Hcdc
	 hngPMiN1RBG0maMvNqvnoAY0TvSnSPpvT6+CRM9I0jlLVe0qQT/3Ndpu3B1AXWPovA
	 S0OqHuoCU60cIKfYn568mUV8ys5sM0KbaHCmoS83Q7sTaV5rUVSNmSTPoyWlFwsXnH
	 8LWmEAwCjQ/UuHSeAZANN+TU+r6jP8b6KGKtX9VLPW19vXdtziAawxrxOsLrKPD9Z4
	 vQXxYQNtDirMg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so4879762a12.1
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 19:22:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ81wwjNlIX8oWLXv/UuyFeIy236ofhoo3rPsStWpUErsuoqZV3T7JDwrfIZGASSI9yZ0Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dz5w5gdfJluKHG/GxPC5PBAulTYCt1gW8OtDpYjXSGtfsAhV
	KUJbzXBO9Har5kvWO4QqV4x1QvxJvYs0Cl/7e8EAFuA7hcdlM/lcW7UjqXKwZltg/S8JJUYvpBN
	PgWGROm312V8EMwXBUK22XmvAIp14MeM=
X-Received: by 2002:a05:6402:380b:b0:681:eb80:df17 with SMTP id
 4fb4d7f45d1cf-693778c3ae1mr5156233a12.3.1781490174933; Sun, 14 Jun 2026
 19:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612011616.27771-1-yangtiezhu@loongson.cn>
 <CAAhV-H4daHGFoAiXrwcNXj=T1kZm5jRRwd_sCiv7ksjR2ynHgw@mail.gmail.com> <e23e6781-d39d-d7fa-10ec-8d09349103ed@loongson.cn>
In-Reply-To: <e23e6781-d39d-d7fa-10ec-8d09349103ed@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 15 Jun 2026 10:23:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6jJpEnNTUF0CF60fDB5ShNT+C59NEH=YodJtepFQgrKQ@mail.gmail.com>
X-Gm-Features: AVVi8CdShvgPGBApSdXR2DwBr9UP7oVXAZR20TrhilIR-50IQzpsobXGkoxYJ5Y
Message-ID: <CAAhV-H6jJpEnNTUF0CF60fDB5ShNT+C59NEH=YodJtepFQgrKQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Move thread_info into task_struct for LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 9:41=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2026/6/14 =E4=B8=8A=E5=8D=8810:51, Huacai Chen wrote:
> > Hi, Tiezhu,
> >
> > I have queued this series for 7.2, does the below series depend on this=
 one?
> >
> > https://lore.kernel.org/loongarch/20260521125636.26744-1-yangtiezhu@loo=
ngson.cn/T/#t
>
> This is independent on CONFIG_THREAD_INFO_IN_TASK.
>
> > https://lore.kernel.org/loongarch/20260428080051.20938-1-yangtiezhu@loo=
ngson.cn/T/#t
>
> This is dependent on CONFIG_THREAD_INFO_IN_TASK.
>
> But anyway, I plan to send new version for the above two series of
> selftests once this "Move thread_info into task_struct for LoongArch"
> series is merged into the mainline, maybe after 7.2-rc1.
>
> Because the code under selftests need to be updated, for example,
> it can use bpf_get_current_task_btf()->thread_info.preempt_count
> for get_preempt_count(), and it should use ld.wu rather than ld.w
> for bpf_get_smp_processor_id().
You can update new versions now, then they can be merged together.

Huacai

>
> Thanks,
> Tiezhu
>
