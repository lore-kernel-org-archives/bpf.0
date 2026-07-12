Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D03D994
	for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783838083; cv=pass; b=p4z7l1FdvRx4FWPUOBg3AuX+WphPAQUZ8kFAzeFHS4x0gi6ZSC9ETgUIUycxBeMhvRSmPwU6mUhyeVFx+piP0eRiJpbMX7RiPvkVZb51g733VkXS/1FBaa+Um9uspNCg8JqFlbTCdw4IzT5E2QHsdD/8f0IwR2w7Tcse6q/1M18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783838083; c=relaxed/simple;
	bh=YeCGzZKby0DzGyJ13Wlsi2uw0Y5H81ufmO5agPxkulg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQJoPSh9BfsjrOn5ywsZuQ4cu2nH8p79dyO1fSGFzVNVgPk0nUFT+kFaFRfum1mVKKrAzHty46Kku4fBrrKy9BCZuBAju4ol80BpOjsYuRvwIcNCRJVoVjKYggGQh+P/ZFJ+bPMDc/mNyVNgdMZUEbAlr1dUkhJYtvTOvd9sWg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlCquX5s; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlCquX5s"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7dbcb505578so22549307b3.3
        for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 23:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783838081; cv=none;
        d=google.com; s=arc-20260327;
        b=SsfC9LE0S52LUYmZb/90I6bBvqGW1ogtIKjGmTopZQ3gFyQqK69eZxOD0L3u8PfaPJ
         QxFEQnY+/mRGyHeGSYz3idPaf6czPAQxwhB4NO1IQJCRLJt5/2g8LdeicMKZA2K3mnYj
         28dJWvi4xKpRJMGrEI7cNJQK6C9wpK88Nt6dc/Mb259AsdCA/vlPd2I6MSCdlg1Zm1Hs
         Ih4zbT2VVDf6SZi+rdv6XHb/l7sgHvnEX65a/iZArv8KCkw19QiEFjq6N8IaMWLk20Jj
         QYmTUfCXFP19LfoOvpqtGQrtq+lgqYZoD/Mdz8Y1s3TZBwkzq+DGFMLIiRl7/ePRynCH
         x2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qKiOMIK/5sZdE3Eul+wowZxaMmUdof2Iuc1X8BqCpOA=;
        fh=EChNKY2g9Ffnfc9mVv+MPUNTZI4vrJMjSm7tK2BTSLA=;
        b=heeS7f9pSh5c52et4Qqq849iItkbUFUDo33ybVOoG81pnvqlgqQwvlZUGU9NENrsBL
         LEE1qaE1tCVaTCfL6KmWj4MOrBAU7actkkO+3PONvs43mUVXihk8zPOVwM2G6QyqkrLp
         F3m9vnf5oK1H2Jqz25xlpFpOaFtOU0/6QHr/9g3M9vShMjpICGaeWSxuVGy6BPWTAyEF
         Rk4pod1lzVagffMiBH3udHyEi/VHYKSEXN9iP3FA9NlLTggsVvnPnWgl8UBSWVNh6gAT
         gLSm6WyEq74J35s8iI1vc9ujJ6N50uwiSCdOGzyTqg6BEfg0+ZlOkCkk6Izxu+OmL8Bg
         2Uvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783838081; x=1784442881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qKiOMIK/5sZdE3Eul+wowZxaMmUdof2Iuc1X8BqCpOA=;
        b=KlCquX5st3ymYKBbOXVk8bSjaryJCGPsg+silkbZyu/TLidoRziew3DrdHFhzI+y7Y
         K79nWASkSe4/Ml0Kv9n+3fB0GGn6Np1YUFPrWex6K8d6GCweSYTdSKNYaPQvsmqSzJcl
         x6HfIpV6sKO9jzb4IuLwlR3ukCAwN0iio4M/nmRqYNbxyZkcZ9u7tAfFRSbw6Fz4mPPo
         Tz+obMZ5oVASpSq7HQXmwbAGjMlHxwe8fERub3DotcSPnG89wEFFLhwOPWWOKMtuXilP
         Zgb5te7NcWy99lOLw1WPfEwBybEXDId1Ugxd1HAgDzOfMvTigKd8FGLk8d47VCmwslPM
         P+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783838081; x=1784442881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKiOMIK/5sZdE3Eul+wowZxaMmUdof2Iuc1X8BqCpOA=;
        b=BpkbQt82ArtOsNDgpV9AX1FB4pAi9ppQc9DtzmjVrv2ZVoQ/c5Ru6yaBE9QQRs+a6G
         BnTQSHOyS6j1FyBNiOfJlV+vY/PHU1AlOWlyh8anTqMb7OI1TZqDzNoXH2W8sL9CPzOl
         jEL+74CCzBcU6osBh6BZxXHaSabwGcF9xhTzWOIEFo33XnNvBjW2kd38EORdDEhonGIg
         yGsHngImyWu80gV02ZmHQtbVXvizwRJv5qbzM1LTPniX9s2roeOusb0Dm3Inkwfu8Rn/
         oLOghSIy60DHnp6Dkycf0+jdyzrJyyqGlyUN8dWOQBkDPOkNSRghq+EhzR3+hOXGUHYY
         fg7A==
X-Forwarded-Encrypted: i=1; AHgh+Ro7x44u8tlLR4LeaZ/fQsEYoh92KVW8EsDmjWVjyhVkc0Fk169Ri6geqFGlSMCFdxYddeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kWj3HT5F2nw83waDOzLhFfRsiPmE1oijIY+8AZIUBY5Nj1jS
	txa927Px2vMETXDKxcGt1OADBS0JlFztOfH7PynHvdYyYToVx+U/tHaqHCEIhFAICTtFPz1bYwJ
	wfwgAOFhw6GIpY5RLDw7go9xgz6yTou4=
X-Gm-Gg: AfdE7cmiCj4NLmOMgoNVqkQ9go3hYC9KsN5kjK9A8sMLsW3y/mB4ur4li1ji7HuDepX
	vtkR5XudsJBodYBUfnW/f6jEhFPBLWXZpZDkGeopox0aoPiZuMWzt2E4ekbqOuqZN1bb6FhxAbk
	heO7nqRIiFXyZT+crKAUUfG60RfdK5SVFYhvlq8PhzLFU+cAQn0w39hqrDQUtje/iotautUb0uW
	xtY4iSQir140wgOTV3ME2PClcpRF9LcZe/A3aaObCugK2w8BCw/SnnTb8rRkRDXQkQaxvIESy0b
	hBirWQmmwk5JdJ6t2cPMlCZ6EJFrzAdk6HXvG7eD
X-Received: by 2002:a05:690c:6288:b0:80b:e6ac:53dc with SMTP id
 00721157ae682-81e900612bdmr36089167b3.23.1783838081581; Sat, 11 Jul 2026
 23:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712062834.77872-1-laoar.shao@gmail.com> <20260712062834.77872-2-laoar.shao@gmail.com>
In-Reply-To: <20260712062834.77872-2-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Jul 2026 14:34:04 +0800
X-Gm-Features: AUfX_mxCYDdD6z8a-Csmxv-OMKDHFinCVOYPN9LK_qmXdlu70OdjjCdCliGhaJo
Message-ID: <CALOAHbCjOsc2JcwwMLOdpx9kQw5TncLZBtGJZfimq-UNcHJg9Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rpm-pkg: append %{?dist} macro to Release tag
To: nathan@kernel.org, nsc@kernel.org
Cc: linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 2:29=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add support for the %{?dist} macro in the kernel.spec file. This enables
> building and releasing kernel RPMs with a custom distribution suffix
> (e.g., via rpmbuild's --define option) to better match production
> environment tracking.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  scripts/package/kernel.spec | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index b3c956205af0..c732415662ef 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -6,7 +6,7 @@
>  Name: kernel
>  Summary: The Linux Kernel
>  Version: %(echo %{KERNELRELEASE} | sed -e 's/-/_/g')
> -Release: %{pkg_release}
> +Release: %{pkg_release}%{?dist}
>  License: GPL
>  Group: System Environment/Kernel
>  Vendor: The Linux Community
> --
> 2.47.3
>

oops!
Apologies for the confusion. Please disregard the patch, as it was an
accepted patch accidentally included in the same directory and sent
alongside the intended one:

  https://lore.kernel.org/linux-kbuild/20260712062834.77872-1-laoar.shao@gm=
ail.com/


--
Regards
Yafang
