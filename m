Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984826B75B
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781494287; cv=none; b=ijwiXl9fiKd7cuKDwMqHqafS9OB9Ou7L+qQFSSasDjWvo0rRDtjjEyoFwsGEQu1BKpk81DDL8d3ZQmWvY7n/VoR+BIKanyGa8zDH760JKGKP58lxkekyi/fdiekP2DsSUY4j1J83HsddKCsaAlbWDx9ErhHrcm79QWmvw0qdlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781494287; c=relaxed/simple;
	bh=ii1M5oBYcF7t4DeMDXqe4RmINRlIzzF/iUnfV29EDn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1Zqmm+IIkjU+1CWxcO7VNf0ZkJn8dsgu+jkT0YqZF8SZuKYZ4ATkCNgKvJyM9+sGnFEpU4t2IlPTsPJqxLQ0PlwC6gAu/N16i2kPLCiRiVnvxm54TupijbZxTh2GFVMPdZKscrOo5K0W7jhJiIWSmlKbrlXn7uhBQFGNEP38dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XodurliZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XodurliZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DBF1F00A3A
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 03:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781494286;
	bh=ii1M5oBYcF7t4DeMDXqe4RmINRlIzzF/iUnfV29EDn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XodurliZhLEglb4E4KQktG9pqo+OkL7ARAmbV8fN0X40SwTEkJTzLTIftX2Zs26Iv
	 Pu788f11Q+3pOfze7Uog+NDJm05nS12m8PZirZW+G95SbjE4G8OyZDXKZV+f5H+81L
	 /tr/9+Z8Ci/iIaypWJCid6p4xrUvEtMS5zWvVdBgi/Q/I/2f8nfilQ3OecmLnFYzVl
	 KLHNP7pjz4gaG3uvIUIqchtRF4ZurgcPvmYOv5MamHbCtd9LnqFmWF7P6H5SruYQqA
	 95oC5BiaEdpcojwBWgk7do5pmad/JhKG2SM8lQFjSGWYsoGt3aJAf+s8v+f/t66y0X
	 33pQEfH2VkGig==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68b90fc6a1dso5496909a12.1
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 20:31:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+SgF7EQMfIaSPpqVlAjoOgEKl8CC812TxPrTpu3o5nVpD/O3PD2sNo2Od1FNk4SToIMvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKdi6FbVIfom1xWzSTFS2r9h1972Cip0BaDucwrjeckmZI6us
	QTG6TfmEm9egQ4t6R3Up1ph6L7ibLABKjdgR1G6IxzLUBzOzWNQD1IDDZWhmRWFt6h8HPg5i08Q
	CT9EW5atsJCgSukKPVKtExqUxAn65Hwk=
X-Received: by 2002:a05:6402:2682:b0:68f:cd4c:7297 with SMTP id
 4fb4d7f45d1cf-69379013ab9mr4938630a12.14.1781494284705; Sun, 14 Jun 2026
 20:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612011616.27771-1-yangtiezhu@loongson.cn>
 <CAAhV-H4daHGFoAiXrwcNXj=T1kZm5jRRwd_sCiv7ksjR2ynHgw@mail.gmail.com>
 <e23e6781-d39d-d7fa-10ec-8d09349103ed@loongson.cn> <CAAhV-H6jJpEnNTUF0CF60fDB5ShNT+C59NEH=YodJtepFQgrKQ@mail.gmail.com>
 <833e2fca-6a41-786c-356d-6480ca168e44@loongson.cn>
In-Reply-To: <833e2fca-6a41-786c-356d-6480ca168e44@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 15 Jun 2026 11:31:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5LORpNeTycjmHFobOZEA5w=spSkxJuOajuizz-941zQg@mail.gmail.com>
X-Gm-Features: AVVi8CdaChDFwjPAsQFOYuCBd47UBORkjjLTwKuLNkZrr1QI91d_qIYsGF_RQnw
Message-ID: <CAAhV-H5LORpNeTycjmHFobOZEA5w=spSkxJuOajuizz-941zQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Move thread_info into task_struct for LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 11:16=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> On 2026/6/15 =E4=B8=8A=E5=8D=8810:23, Huacai Chen wrote:
> > On Mon, Jun 15, 2026 at 9:41=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> >>
> >> On 2026/6/14 =E4=B8=8A=E5=8D=8810:51, Huacai Chen wrote:
> >>> Hi, Tiezhu,
> >>>
> >>> I have queued this series for 7.2, does the below series depend on th=
is one?
> >>>
> >>> https://lore.kernel.org/loongarch/20260521125636.26744-1-yangtiezhu@l=
oongson.cn/T/#t
> >>
> >> This is independent on CONFIG_THREAD_INFO_IN_TASK.
> >>
> >>> https://lore.kernel.org/loongarch/20260428080051.20938-1-yangtiezhu@l=
oongson.cn/T/#t
> >>
> >> This is dependent on CONFIG_THREAD_INFO_IN_TASK.
> >>
> >> But anyway, I plan to send new version for the above two series of
> >> selftests once this "Move thread_info into task_struct for LoongArch"
> >> series is merged into the mainline, maybe after 7.2-rc1.
> >>
> >> Because the code under selftests need to be updated, for example,
> >> it can use bpf_get_current_task_btf()->thread_info.preempt_count
> >> for get_preempt_count(), and it should use ld.wu rather than ld.w
> >> for bpf_get_smp_processor_id().
> > You can update new versions now, then they can be merged together.
>
> Thanks for your suggestion.
>
> However, considering that these selftest patches need to be
> routed through the BPF tree (rather than the LoongArch tree),
> updating them right now during the active merge window might
> be inappropriate and risky.
>
> Given that these selftests strictly depend on the "move
> thread_info into task_struct" core changes, sending them to
> the BPF list now could cause cross-tree dependency issues and
> potential build breakages if the core series undergoes any late
> adjustments before hitting mainline.
>
> Moreover, because these are selftest adaptations rather than
> urgent bug fixes, they aren't high-priority for this immediate
> window. I will rebase and submit the new version to the BPF tree
> right after 7.2-rc1, once the LoongArch base infrastructure is
> securely merged into the mainline.
In history most arch-specific selftests are merged via arch trees,
including perf, bpf, ftrace, kvm and so on.

Huacai

>
> Thanks,
> Tiezhu
>
