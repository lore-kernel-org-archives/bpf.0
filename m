Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648083C5DBE
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154978; cv=pass; b=PyheD+07EC7eQ9EHvw249HnVpKhq8wQv9GvHkZEmPGvs5iE95X4EHHQmJpyIvsUW7m+d/be8sQV8v9K45Xfvl7PSvAisHIq5L+UpeArc+h4GVqCIGmQuRAKeEko7UEIT6H8tyf2N21glmV5JRKWcvKSTdO6JvTi/+2tETlwYSfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154978; c=relaxed/simple;
	bh=bzK7jDQGZuTsGyGRodE4w8KOFqKjZGsI+cS950h0EQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmrVK/Ag+2jJAQYHb9287KHfPLYSyjuvmzdD0PNXB0dD4GtPaIyflsc/hLbOCFk12NBu7+gTmf79PXzyRyHgdQogR1NoW/0MgzFdllp2eGYNy37OxktP9PlnwX48JZhiX4mjrEa055z9ZKQKzyAsHEm//3/tN9NddlFWWMaZQ94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa2Tzuw3; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa2Tzuw3"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfa33a983so798430f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 11:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775154976; cv=none;
        d=google.com; s=arc-20240605;
        b=K6uHaUrIqLc2HZtl+UP/7l88M5wReICkaCQRkeL1d/p/QjZhGpeq7DlGcgpRgGQbfh
         f4sFtljGZX8wY2i4kPWZ3n9qKfUc7wlQoU9u++SkHycbheyb4wDFBF8nF0XKdtsp3uvl
         /IpHplGYCMehOTzk6CIpWXgFDClSj47XWxDOVuQS2Jo+fV3kaAfAFlnt6GOkPpq9U9JR
         HZVCpfZzt2SPPpAzf35qyJ29g11OByFVJsMvHLIXppksT8CTICthx3ethteQu+B8UPgx
         88iR1swfd2h1zfVTTvfRHuq0bJCXHd8xvmb8/i45rwZRHlmoMJ9RWpBuVkH1wDQp4i3B
         vw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vh7HEXtcQUAR5pS7JUTCybPl3gliqz8uUSF1/K9jxIY=;
        fh=Cb1CRK833chRVTPcPtFh+80lx0tziYOaSVqRvinjGBE=;
        b=O5VqXmIPGO/cxMgsgpf35J2ogAg7aT04o7iP1c6KbhBeZ6u+f7FW/ZoQnHp1i3FTYp
         817l1MyF6k+fMoT6iHmfuoDO2t77xLypf4fV5vojohlDt+IvkUMB+pri3mZTLpX7bPmX
         aVxT8vXJE40xPGcdi644px6yufeBVt/pl9+P3pjjlGiIKSbGZEVCfjiRq8okvrQFoa05
         GsMwjUtPSzRIuIauRMyXSv2AgyYnZDw/cXbVFSLIxxq3qvMiVudGQW51BYYHoeBM4K6G
         Ndsus1fzUL7PxcD9mDirCLolMzc2v6FaGvKOaOCa+2tbaRW7zjNo5Zkh3UgTfulEaaM6
         mXXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775154976; x=1775759776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh7HEXtcQUAR5pS7JUTCybPl3gliqz8uUSF1/K9jxIY=;
        b=Fa2Tzuw3DFWYfdt92W0gPm1F3eqLvFlDRpqsB1GEFE5TQCUhA4PSfmRAlvTJWeIF1u
         /LsxBsHtvH5vm+vAxk5bXYC+ynW9BdJyYrglv3e4xe+SIYA7x/om8WIH4xJqerkjiS9Q
         bMn4ur1Su1z0gqH/DFKaJ8MZsApbi0e5ihUTkO/7VE30V3aRzeMGNeDBS1QkwRrrBQCg
         tEFXt+rnMDBTTXhdlCSlrGI60VBLiCcboFnnsayUsEeXwDlG/PLRG2q2Y969VNyfFR5g
         zbw217vwZIQQ6jiMQqChleCOegRIzJdZID1uGiL3ZXhWf20VOxqTfXGN9osZMMdeTndM
         Nr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775154976; x=1775759776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vh7HEXtcQUAR5pS7JUTCybPl3gliqz8uUSF1/K9jxIY=;
        b=sKx+f/lvL6MMtYI2/IffSTi26b1WLN756wFbj+/IfxJ+4VRieLnC7FJUumMgv/x4Yn
         gDmxPm6q36bPwA1fUndCfZh2ESAx5fxrI+9fsMrAkaN9gXZ0WJHrmA9vEDEPlo3Hxwi8
         XTXN9W9E0qYtzOm9m9SPvysCT/FkPhLd/fiSzSUqJ7UuKiyXO8GE0L/2xDV+hN06VzRL
         s2BwM6RQc/sYurU0h5n/8gQQ92ifvFNMyIq0hM/kkLXZs3BETP+SS1c5p4L9WK0VuT1M
         fIgap0HD3qbtOolAQsw+uhJdsqJFEHpH3IV7j8+AZevd0pTrioFmbTD3/90/A0exE+kz
         YVYw==
X-Forwarded-Encrypted: i=1; AJvYcCWrfzPJtQ8StfgC9dYR0xjJDQYC6814drSsk8iSF9NJ0YureVJ09kWmRg92E84Mse153k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQa1tlZPYhGBWWYdlXR/cFk+gj9vcCc/a3Ohrg5BBcL5hyD/a
	3OmCqk8GacDsbxtBBWgL8xZpBj77VUoeK8so0H+RK4tb4AzVnOrwXvUobHgrHeRZoLOv6q8GlK6
	VHdAA8vo+P3/n943cP6aegm5zQZb807U=
X-Gm-Gg: AeBDieuSyV+PG7NkizS6rTEWPTeqi5rcbE9J1nrmWeYrI1chHMSbDokJ5crj6n84fsB
	kQ0LAPhGaaHdyvWVJ+BZ3xumX4N1d3v1FoKFys3lLtx+yHSQRsIhyhdrX2qnEmuYAdcVTM1A0kV
	+otQ06NZledRAab/Hx4qBnKGonc3OuyYEDo8PXzS2V6jKAYL8zQOwxrhGAwTOwPADU0yr+uhWVe
	naTzKDaQ3YL1DkwGjVBR1g5HaZVuL3jSWS1pVda5cOKEBjDzsuWIMvp0EmZS+NrqsuRxI3GURnj
	+wCRH1cT8RtZj4geCtF+65vhf1WXgSV0mB7YA8FvFY4cQgGdcnzzSrdtlkSsGclIIurAaRzD1/A
	A1gNcEqqeVX7PmEIs8QQ7CLHEtA==
X-Received: by 2002:a5d:5d0f:0:b0:43d:184:8a9b with SMTP id
 ffacd0b85a97d-43d2929d8fcmr222802f8f.16.1775154975639; Thu, 02 Apr 2026
 11:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com>
 <420FEEDDC768A4BE+20260402074236.2187154-1-xulang@uniontech.com>
 <CAADnVQJawYEk53kS9-w5EXU0GnUYWWW7AF_n02bUs-GPJ+4Raw@mail.gmail.com> <ac6ejZrcnfQfaTZS@devbig1721.ftw5.facebook.com>
In-Reply-To: <ac6ejZrcnfQfaTZS@devbig1721.ftw5.facebook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 11:36:04 -0700
X-Gm-Features: AQROBzAqhtq0ySBSjo5wMDWXrrKU7HzkkqR0R8R5cL14JtlcTTPCO0-ZPJsNjQg
Message-ID: <CAADnVQLSUU8Yo1Wmym4B05jam6qqUPEXUDJpBH+00kjqkrYigw@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix OOB in pcpu_init_value
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: xulang <xulang@uniontech.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dongliang Mu <dzm91@hust.edu.cn>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, kernel@uniontech.com, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 10:01=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Thu, Apr 02, 2026 at 07:17:17AM -0700, Alexei Starovoitov wrote:
> > On Thu, Apr 2, 2026 at 12:43=E2=80=AFAM xulang <xulang@uniontech.com> w=
rote:
> > >
> > > From: Lang Xu <xulang@uniontech.com>
> > >
> > > An out-of-bounds read occurs when copying element from a
> > > BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with the
> > > same value_size that is not rounded up to 8 bytes.
> > >
> > > The issue happens when:
> > > 1. A CGROUP_STORAGE map is created with value_size not aligned to
> > >    8 bytes (e.g., 4 bytes)
> > > 2. A pcpu map is created with the same value_size (e.g., 4 bytes)
> > > 3. Update element in 2 with data in 1
> > >
> > > pcpu_init_value assumes that all sources are rounded up to 8 bytes,
> > > and invokes copy_map_value_long to make a data copy, However, the
> > > assumption doesn't stand since there are some cases where the source
> > > may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE,
> >
> > why? Just round it up there instead of penalizing perf everywhere.
> >
> > > skb->data.
> >
> > what that means?
> >
> > pcpu_init_value() can access skb->data ?
>
> After bound check, the skb->data can be used in
> bpf_map_update_elem(&percpu_lru_map, &key, skb_data, BPF_NOEXIST)
> which will call pcpu_init_value().

I see, but if we round up on cgroup storage size the problem is gone,
right?
Doesn't matter what the source of the copy is.
