Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B03E0C55
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160121; cv=pass; b=KLuORk8M0ZSuLh3k0ZzDhvWckXI7CwKt74v8bRZwO2fhFd9E9nCyrlnE0M1L8oXcuCIpsOY6WAdf83ht4OYkksQJzcti5zhL954nkPYZdmG49F1vQbx3J8CMGfCHVbrG6m5BKZtOATyzCBUqa5CNWjqNvcOB/MtxBzGG6TLv4zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160121; c=relaxed/simple;
	bh=Zp7ULyE01doddxqqFsJP0KrcGFM9OuAPFsmpkgG5Efg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9JAsJTsZNiCxHlp3yx4+t6D0aBF8pdt/WV/yPcI3R4X/mGjnEA645WFWfqEnQJ2hOJt22oMdKrabWhA+hJVAr+FFkz8dG9ZUFcHBeKh6GuK3kLsvooNG2e7nUDsaj6gFvjzg+9/9lyk/dmrhghRSGj2eIi+nLRMoL0P8FmsczU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBTVxDaH; arc=pass smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBTVxDaH"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6bff4d6504cso157683eaf.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 13:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789160119; cv=none;
        d=google.com; s=arc-20260327;
        b=sfYPCFLaMdTvCLnaPz6VoMg11ZGOVtE5QGe8rOnknS3L0K4Pd33WOY96LeZ0tEY5eq
         dAcrdBA23KE/y58rKz2hMaKIKWGeNZAfXgHOzaqWJUkVUg48aCDglhY1VUN78r76HnF3
         E3noG1RCdevjlOD/LtcclGuXnNzwRua/Aolqdknxjqq2n4TsgDArWmHzzLFCH6VymXGY
         mTv3hgLOxHGAoIv3wwJ0NU8h0JljQtwAWo8GxWGbpTuaZX9cyPR+pUtXo5pCuEiiQKFv
         5YxPvB/+c/XP85RaQY0849C511uQbuC00PNJLcLfSeguJ54CSHA5ZHwwTxj59387+rme
         uBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vo0RYWQKSTcaZygRJ18X5EiJDQQ/Q+gPk0GgTfTAVks=;
        fh=2MBOojPsOSARizhxuWgT5BqcaOh4dFXJJ9MmFSYnYEA=;
        b=d0YBeQFwylLVtHgWr+hkaFmWydOFdgl3EsIV7mc/tnNezWRm3R4TN08hMnH6/FPGji
         coz/sftgCLuRu2KzAq/2h9LUU12Y+Rxbxfy3tsLw2AI0MpMTn/k3C3uXyZcy6boI6An3
         5tb+s7KGYr0VHxpoEYUNJpjOgf03RD4NtpZ0h29JM9dbWnCkRlsYUdkNAeE9RuNtHiY1
         x3Ep90eoLyIokZRmUA+iIJFz5tMvZtNA01eqbV2Jb5k4kx67ZnNO0t5nwKFE4xF+3xvh
         ANNFb7woUJMTnNWZJC2D11Vu4jv9vC5hJRE7kI9A0Uk6rNej/9SRN83giLu/BljGodJn
         22ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789160119; x=1789764919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vo0RYWQKSTcaZygRJ18X5EiJDQQ/Q+gPk0GgTfTAVks=;
        b=FBTVxDaHSQI87z1/cSdlute6zjQ/5wOXBMNyN8U+qTmHpb1s7xqd5RrfYp0L7S7zwL
         U6Bj3PD3WXHnTBLthWmrDCfGGRdhM1p2RD2OaCXkWO/OX2i5hJRTZahCs4nbCgY2mjsz
         fNW9K0VGE4smUR8l1BaAyrAZ6ELvuQSZud0gSbmcz4eHwR9dMFxbYBVRRtRYBAnMoXaf
         Bisf3Xw28YOZgdmoZ1x1sQSds362M5TC/oJuG/0xCEB/hens5aHempZFL8CXCGmSqi94
         nrG7RI23HPhrnBQcupXApvlfEOVhbX4MrBUFRZZ36A0L1fQgLGbnRDG7tlKBoyBNWoH4
         eX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789160119; x=1789764919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vo0RYWQKSTcaZygRJ18X5EiJDQQ/Q+gPk0GgTfTAVks=;
        b=R3hdEI6mmb9d+H7o2UwiF+NsK5oVuqoIrq7Hg5LyxCrXgWFdZ8rDmAdew3kuJOBrjq
         fgS3RWIs9MPu0mBcPLLgm7I9KIjYxfxCbP0EdYayExTeo+S1mbm/mZAkrVeC1VVyQfYQ
         mu8F/fHD/rO/ulJ1LMLwgXQhOgVpSVRqNANdHNJp7Fr/vuhn+sgPwDnuB9pcp+IuVhxV
         mFxucPFNmlhJX9WAyA4PZsijLi78obPDUUi30HtV8EK4pcfOWfUFYafwPOIBpJ+Qhaim
         SP/bOn6b56BIsNd6faFe6e1QZY/Cl0qCmbOo845Ul3sH7xQyP8aaZhiEIvHhSCC8Miyg
         WDAA==
X-Gm-Message-State: AFuF++naQGN7tgnw7eIg8duOC+ewZfykV/CmNT/zI8KJb9H8f/Y0VfIe
	KLRy9tYlFamcbKCfT3OAUwSrjihwZ/zY8vNuDx7MQSPSwAZh+ulE6H4SYpXiITwkppXTpsOlz2T
	XEb+cSCELFF3RYFwCrHgxA4RRmIYT1GM=
X-Gm-Gg: AYBFou2CNZWKkNUMq36DUMtva6AsmV4cFfhjCesVjrxnzT0V4LOrKGPIYhbNF0qRT2S
	/vgb8gcde2bsUo2PvVgU74F2rDrZGHsH7t6WEtDmOMUrn0I7ftfz+LJYLALopKhB0Lav/ubsG66
	fI9bIK0K0TKiPXi2XgIu4kp93jDyQsTd81z/0oZQOg7PAdiNMQgRD07B4NVwP0NOPd76F3XWoKj
	sIsWIoExdQzuAFRrh1YWqXCX1ENoaE5BH5CeqZ+dS2M5h+7BcdzdWNZKpgZ1jDoShLi5TYCg0xD
	W/1MkkvlHgTicAtxEgw+NwbXhWI4NMcJsIuKu9fOfd5o8LjbKQ3pp0ta7pK9K+zVntTAmNQ=
X-Received: by 2002:a05:6820:f02e:b0:6c1:1734:2ec9 with SMTP id
 006d021491bc7-6c117345440mr6001777eaf.28.1789160119110; Fri, 11 Sep 2026
 13:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-1-ameryhung@gmail.com> <20260905220117.922028-23-ameryhung@gmail.com>
 <DLBYY2250A90.R1ISQQXJ44R4@gmail.com>
In-Reply-To: <DLBYY2250A90.R1ISQQXJ44R4@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 11 Sep 2026 13:55:06 -0700
X-Gm-Features: AcwNN1WZELWApXCPUhfiCPze14TFnhTSHYpT27MaH1kWcVzKTKGvf5y1nZqP-Co
Message-ID: <CAMB2axP-nVkZu3z_SM_pAdU1LqxcQdWqGU+ma8PgQUdXT5prxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 22/22] bpf: Check helper and kfunc arguments
 in one path
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 2:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat Sep 5, 2026 at 3:01 PM PDT, Amery Hung wrote:
> > +             err =3D check_mem_size_reg(env, buff_reg, reg, buff_argno=
, argno,
> > +                                      access_type, zero_size_allowed, =
meta, &failure);
> > +             if (err < 0) {
>
>
> can reduce indent here as well by
> if (!err)
>    break;

I will tweak the style to reduce the indent.

>
> > +                     const char *buff_arg, *size_arg;
> > +
> > +                     buff_arg =3D bpf_diag_arg_name(env, buff_argno);
> > +                     size_arg =3D bpf_diag_arg_name(env, argno);
> > +                     verbose(env, "%s and ", reg_arg_name(env, buff_ar=
gno));
> > +                     verbose(env, "%s memory, len pair leads to invali=
d memory access\n",
