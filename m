Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C413B1035
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361821; cv=pass; b=LPcOb2MNnLGAjrbNajzYim5k3S92U6FTlwbVkphlowHQvkK+Bkp2GQG+p5EoC7Qv3IOKSPmsXDr68HoqYWJzLSFQWnlX52YD71bggrBEAYHlS9ZB4yxYea9zJ3L1PPzLZjhhZa/kV40QhOWDnQljE5kV+nHwcijds1X8/QkLkR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361821; c=relaxed/simple;
	bh=JUjEMqmLwbxMJUgeUaMHMQg946Z1KoxX7FiJOR18dng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMqSuzI6SzM9+MPcgRaR6qWPNRvVUhg7lWGwxysOOPWwz4MJGXemJ3eT4z3b/bMQGsVU0pDMwyL1fC2LyoNwgMIW1SoUDr3ILuiAE8IKeJRjvfW/v7avCOnPk3KiuMmIB231d6rEcapW8dO+JQTv904jU+Gqf2HCHlkyn/JHMKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV3wYAee; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV3wYAee"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664b3831a20so4750317d50.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 11:17:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783361819; cv=none;
        d=google.com; s=arc-20260327;
        b=Wzogmiw77QmsyiTY1y+ALmHSikMPGcahpwnQDjYcBQEXOWj2b3GzQaPRG27LKNrXT4
         LEU67wPiAKPDSX/uBnNjKEhBVKmWGa0sT8h0GQRzwSbUOAmhfnooeNN+oKTOovKWwDSZ
         zbQWDPFMSn69cSFb63tc/AVKoDlRdi57f1N6bs9lSwZio5z3VRwbcZ74vNc2i7EVXjFv
         0m6xMrQWj29OwjgdXrHi2p/LxpB7onsvDwFp5nFBtw4R8dKM0GqlzcS4Yho2CsvwONPJ
         ZNw7Bizi2fiTsBO/5J6Cl6t9iaxQ1QYDgiWs9OXBrJn7MSWDL4d+mTmNxW++Q8CMzthE
         xG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UlBknrTv2ASJSXzF6+Jo4USu59tV/IAMxbLniTjG/YU=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=ceBb2ACqRImvbY2vkSZvklcQMUtsTPUiwruDuYkp49mYxUOZCIXdjmxBIAFOxt04c7
         TofrnMXFs6dfSLK8FJh40ln+Prg5cPnHmiLc26bDLYiviDm1JCpH3y6jIfD/ygIuyz1L
         ahhZe6ZDorHh4U998Rn9YHlYQxbYLq+OI9ftb09YUsYMa/ghtRVOAafDDT7CI5i/tKfs
         dzmzE6KmLsByjBTtJMj8nzLuUqI9TBNCcjrD6sVp08Cn7qw1uNypUol3QzpKg5WXZJVa
         V0MguGr+XnYJmM4Qh/oDbn4liZlikveRGDkhlq4dWxl+ctmPrA1E6xv6cUX1timZqBHW
         XLVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783361819; x=1783966619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlBknrTv2ASJSXzF6+Jo4USu59tV/IAMxbLniTjG/YU=;
        b=YV3wYAeeOKPqDDKfiRmc6c9pYoVym7wTAAhVp9/rqmXccRlJm+cxie8bOHLjpzpifv
         7v5Bwm4YcX+pOwCC78GJ8eZQsqvMiEmsOjLS6h4FVY4EiZpXJv7TTdEpE5/DUxA1ZvrP
         0sQXmD415zhls/4TjnmmXe3ji8AvNXMR0xfMfIXj8Q+ppMHXhwrYI0mLeuwqzw0ksjTy
         iUis7RV+9+NP6kgRULEGLUV54h1qTjtBVka3jiJ5lzwTXpBRELXsIWIXVPNDZSP77Q0i
         hz2WxKvGL5s7ZevECYqPpVfZH4wze4hw2Fk4MsKOQlC4nRCZqGdFjhd1d16G8JFg4nWf
         LbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361819; x=1783966619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UlBknrTv2ASJSXzF6+Jo4USu59tV/IAMxbLniTjG/YU=;
        b=GR+T+5uOIbi2OPRmcJWf9/PrbRbv7ix8D+bVpJC/IBFQ9+y+12wGF0MvDhYq0gvVzi
         4duTzGjJt7QAL2titl8QxcL89x4V/OKZcyBrdT/UD6VzOU5hMCmiWolgAAt7dlB6W2u7
         42a9M0H4AhYlo/wpNgro1iO8srZ0EyrRV7kQAqnPxDeQhpMQDU3w6O1DLsu/0QSFRL0u
         KRD+qjnNOFcV9jTTwlcLUWx62CN+KAVSZdnJWgMv1OV4u7a43aHpIr2OKHiRP7wNH4gc
         p/dQOQvcNUmLOIbtvyQwQLZUSZb7nxNqnjs8hL7M9LMhxdGnBAAyBYUIRO2/GuPPdswQ
         8mtw==
X-Gm-Message-State: AOJu0Yy8/s73Z5qgBioiND95V75JrL8YD/BrkX87D0a/RMC05Dl0L/hZ
	PeXpf7YRNkvEFPYDrf1ahkmMmI/sEYn7KgtG2x02iapDP6sMa3rDaSZCoioecezBJC0U+/Q0QdC
	KqU5Rkyt7v5SeybGBJhG+EmFruMoPOV2KoMPm
X-Gm-Gg: AfdE7cnTvYhax3Zfdi+c+YpqR5j+kVDcfWdLr862qeCFFPvc2xgsUCpshySM3zRstKW
	IFimKSB5O5Pbak860jGcknPUPL4MfIUukVSN4QoBatRLrDfoPpki/+seCw3notbg9mOEeTVKcNY
	ntW4xrFF43cJcNroLvzTc/wTUrq4ROFbu7Ag8leZdVgPAafLVqqG8JMLFqneI7Su/LJuXuyhfLD
	ETK/5a1BTkStmwYfagKx/TpSsLhvPoBqkLhnP7iSECSuNcyMttTPvwuodXzQyGwEC/ayoa5
X-Received: by 2002:a05:690e:1183:b0:667:773f:8729 with SMTP id
 956f58d0204a3-6677fc8e533mr1600703d50.64.1783361819488; Mon, 06 Jul 2026
 11:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-4-ameryhung@gmail.com>
 <20260706173419.6F11D1F000E9@smtp.kernel.org>
In-Reply-To: <20260706173419.6F11D1F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 6 Jul 2026 11:16:48 -0700
X-Gm-Features: AVVi8CeI0q4ekJpH-zFiUMaXE2ABPNvFkjsLRgCZFGjDfhjCCxnNT-LntIzm_wY
Message-ID: <CAMB2axMsRM13Mx_xjRZAZmVEOPW8_=rU77BqgC8h0MXaw3mwyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/15] bpf: Add bpf_struct_ops accessor helpers
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:34=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The function `bpf_struct_ops_kdata_map_id` is declared in `includ=
e/linux/bpf.h` but its implementation is missing.
> --
>
> commit 95521f3bc40fc850e1847bcb5fd4b12e698ebe45
> Author: Martin KaFai Lau <martin.lau@kernel.org>
>
> bpf: Add bpf_struct_ops accessor helpers
>
> This commit adds helper functions in bpf_struct_ops.c for the upcoming
> patch to create a struct_ops to cgroup attachment link. It also exposes
> existing validation logic as new helper functions.
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 91b8479121fa3..1a1e8d0885c8e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2252,6 +2252,12 @@ u32 bpf_struct_ops_id(const void *kdata);
> >  int bpf_struct_ops_for_each_prog(const void *kdata,
> >                                int (*cb)(struct bpf_prog *prog, void *d=
ata),
> >                                void *data);
> > +void *bpf_struct_ops_map_kdata(struct bpf_map *map);
> > +u32 bpf_struct_ops_kdata_map_id(void *kdata);
>
> [Severity: Low]
> Is the implementation for bpf_struct_ops_kdata_map_id() missing?
>
> The prototype is added here and a dummy version is provided for the
> non-CONFIG_NET case further down in this file, but there doesn't appear t=
o be
> an actual definition in kernel/bpf/bpf_struct_ops.c. This would cause a l=
inker
> error if the function were called.

I removed it in v3 since it is a duplicated version of
bpf_struct_ops_id. I forgot to remove it in include/linux/bpf.h. Will
fix in v4.

>
> > +void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map);
> > +bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
> > +int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct b=
pf_map *old_map,
> > +                                  struct bpf_map *expected_old_map);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706171918.31=
7102-1-ameryhung@gmail.com?part=3D3
