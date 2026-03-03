Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F18372EE2
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548074; cv=pass; b=Gfv/sW8EGxYWE2ZVMmc7PL/1IuJJgLo6q47UKx3SLdpWD4fYci/RFBhU79fl5drYg9o4y99zxe9nIwm2e4CcTCOSa30fX6subMKEMPgJU1D+uzkQXeeBmN/6imn1UmUkaOlVYNW94fHSTHh7GyzUHCeI1anGdT5Jos4uJGGrFIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548074; c=relaxed/simple;
	bh=egMEBqKWfAr8CtNnm+dE/tXlDActJ7B5VMObkcMEQkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gh2Y3hf2aWrtkS73BCBJZJusSDJ+uiF95X7WJu9knb20++mAuW45YqHjSVwqFaGyBvVsEenBe/UEdNdNf7TnhipW+B/rwRIZc+z+7ZxrkQa3MoKM2i8BvuhReTYIaEh4BlGKLJFfgAgkmiQ4MP5zRAjPnLcu2QWkgbMEGAbEIrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCzeU4/F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgTHoZjW; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCzeU4/F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgTHoZjW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772548072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pzsSwi5adWCRovilNghDM/wCo/ieqebuXIEWNF2uf4=;
	b=LCzeU4/F0Atm4hSLZpxEoV8otTBcTjsfioqyvJFGE6yu5QMULnuwhSkrNcEgL6gmtOCIH1
	BQNqh2D7Ffof2csdAu0P6uonWt/0LwwfiL8BZPSzNCVhuk5e5viBoNvj5HGYqjfyHo/K2K
	ogQPPIoz8iIIpCcfEPgRGP45ZuLVmdI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-9Y3QYL8VN8aQVYQcozhB_g-1; Tue, 03 Mar 2026 09:27:48 -0500
X-MC-Unique: 9Y3QYL8VN8aQVYQcozhB_g-1
X-Mimecast-MFC-AGG-ID: 9Y3QYL8VN8aQVYQcozhB_g_1772548068
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-65fa9f433bdso7218436a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 06:27:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772548067; cv=none;
        d=google.com; s=arc-20240605;
        b=kxEcZDO0K0et30KOVJO6BWomdPtDHvahRgtxxwb3TvF2kHjj4qz2yhQbZimH6RipQe
         gixWw3mpe9G3th9x+3mzAJrO03kHmWeHoDlPnZg6FQsf6Nj7XcQw65ryE0/bdCiK2/pz
         noF+CsNJTK+QGYpjrlgwGEZC44mjBTmlFgvzv8DAKyrgZ9aRaTlOEpVyg8Ll7PEuVu33
         JmOTV1bCC/PNU0qG+cdAKDXy17rstU144h/kFG14HCKcOY/Ax6H2wg2A2UJTzLprmR8B
         IDOgUq7/ikE1W3ERVN4//fLVf+1mvxKYz79/rxRd5IucyF0RdV6gM0HEu5aprTxujRtI
         g6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0pzsSwi5adWCRovilNghDM/wCo/ieqebuXIEWNF2uf4=;
        fh=ChK+JUF0FLLgj+vqA4LESc68YoX560XzFMJtGcSe980=;
        b=RlLSIIZ36Huv2QQK7lyZEUjxt+RG0DK6RgXWFlhzLA+Lz7VlNAHO8OV7wieSBnjHoA
         4UAH4Na5hgjnJqxPD8NiPwCAxavWzFqTBuOsOUvsxDJ5+G955ag7LrZDJK5rFdmwYjts
         6jocGue5dYEgV/kRhkmMcxa0zJlKnvREQa2MgLFeJdFZ4QuePVgFyZPlRvRRrl6drKpo
         hcSj2PzgBpZ+4sezb0D9ueRkmhHpaCnNBwx9PxERzk85mxQodPQ1LIrbKlSmfURdkpzz
         g4bbWxOLxDNG5MH0EFMIlwkGRw9NcXi8S7tHkM3fprQsYSvaY/YlnSL52aFpdwSwAFBY
         /yWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772548067; x=1773152867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pzsSwi5adWCRovilNghDM/wCo/ieqebuXIEWNF2uf4=;
        b=cgTHoZjWIdxx0/KSoPiF9linUj167OV98FX1GlScUJsBntRVBe20HA4GshXC2VGWeI
         8wSH4Mms/1h6bv0/LxaHKU/HR9iIUSVwhFR1JJw9Ol21SxSb/sqSTXn51mNvY6GOHulg
         EeULyrxiydsqHFLAd88u3ZSjuSnLu9FdwSEoexXeyxqLIM88WEpT8Xco86HeYAmnHVjH
         Zd2y3jHTKITdXi0yP/ebg69oGUiUwnzbf3fvpHSFS6nnNsxD5X/VbvqjsJxw1JEs8ZD+
         oUWNiC3aVqNWa5W+10nbTsisO99kI/0sH7YlXNAcOjgkb9Y7qXiDEPlkKShhZ1tsWJw8
         SOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772548067; x=1773152867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0pzsSwi5adWCRovilNghDM/wCo/ieqebuXIEWNF2uf4=;
        b=eQAnMztwrMGrKHnNcjRP2uEVeED/jULNFwyoChP8pt/XOJzjb+EtZfUR6hRaJeizd9
         EjhvlDrctJgfHC0TK0xWHxET8rVZk/PuS6ULOZVZWwrkqyjUR0WS3BC1BIPbsDkqoOqk
         elGrnAPc4XrlJp953zP888Gmq5YSLjdR+rl13x3RKfxbE6UI+/uuk6Dyd9+boMawQokJ
         E+a+STgYJAKXrtus4zMH5zSrwcfoIODtIQ3Mmep0jx3PqyqyO6uSERjm2cMfMmjsT2m6
         vJm4cJ27a8cU3K/QvkEZTUgxlONyUjr2a4q+S9ET06GOElFvFtMF1dryMXykyJKBPkLV
         vF/w==
X-Forwarded-Encrypted: i=1; AJvYcCUzH/0Y/YG985/hPTwu5NJLBNSHpylhoV+oHb2LBV3tyGxN/FT7pYsg085BUOyp7GH12vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFWhSku5yjX3jORKtAErNzF7UtTvpWHvcavewnxqDqdQ2YbPb
	PJ0DCUoNSlR4YmJJrNMD58uStbUeTTb3qk3Sk/3ipcJhztB6nZeVbmGHBdCPhapCxZ1MIjfc8jJ
	nSFkrpuCwt/NrDcsWFvp2bz3MycXtGxLS1a+E/CyNQcmzdIYeGjFUwtVq4uPTU60fwjMOv9uI0+
	CzHaf/PaWEwVNmkUv3nTy8WDBYrvyp
X-Gm-Gg: ATEYQzz2prLh6WepudXrw4u6dZZr3hN9Gqu8xUdMi5lejBnd52EzAH8w8WgvuAGNWaP
	n9HRGXHSCmvpcBymoS3AdEuD8kqR7FlWAtgKpkeFrbtiIG2OwV8pQXg4tRDX/aTn9xWhu41ekqV
	DsZxAIUJlDjVEb5O/F1Bllpr548m+Rp/PTOBGqi1X49tGtUafrNf4Zvx22lYkdEkMOb5Xxlsrl2
	piUcg==
X-Received: by 2002:a17:907:9288:b0:b8f:7c0a:f955 with SMTP id a640c23a62f3a-b93763b77d3mr1103360066b.21.1772548067552;
        Tue, 03 Mar 2026 06:27:47 -0800 (PST)
X-Received: by 2002:a17:907:9288:b0:b8f:7c0a:f955 with SMTP id
 a640c23a62f3a-b93763b77d3mr1103358166b.21.1772548067100; Tue, 03 Mar 2026
 06:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-13-wander@redhat.com>
In-Reply-To: <20260115163650.118910-13-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Mar 2026 15:27:35 +0100
X-Gm-Features: AaiRm52--PTPvTJjr7o8z065WWcwDMjy1s-ZrskhLMDXhoPN5incdHmTOca6bdY
Message-ID: <CAP4=nvQ6EeecMggeVciOaW_-=sa2QJ2r9DX0Xifzgsv5JBhAAg@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] rtla: Enforce exact match for time unit suffixes
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Wagner <dwagner@suse.de>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:28 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The parse_ns_duration() function currently uses prefix matching for
> detecting time units. This approach is problematic as it silently
> accepts malformed strings such as "100nsx" or "100us_invalid" by
> ignoring the trailing characters, leading to potential configuration
> errors.
>
> Switch to using strcmp() for suffix comparison to enforce exact matches.
> This ensures that the parser strictly validates the time unit and
> rejects any input containing invalid trailing characters, thereby
> improving the robustness of the configuration parsing.
>

Why not use your strncmp_static() helper to protect from overrun?

> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  tools/tracing/rtla/src/utils.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/util=
s.c
> index 486d96e8290fb..b029fe5970c31 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -211,15 +211,15 @@ long parse_ns_duration(char *val)
>         t =3D strtol(val, &end, 10);
>
>         if (end) {
> -               if (!strncmp(end, "ns", 2)) {
> +               if (strcmp(end, "ns") =3D=3D 0) {
>                         return t;
> -               } else if (!strncmp(end, "us", 2)) {
> +               } else if (strcmp(end, "us") =3D=3D 0) {
>                         t *=3D 1000;
>                         return t;
> -               } else if (!strncmp(end, "ms", 2)) {
> +               } else if (strcmp(end, "ms") =3D=3D 0) {
>                         t *=3D 1000 * 1000;
>                         return t;
> -               } else if (!strncmp(end, "s", 1)) {
> +               } else if (strcmp(end, "s") =3D=3D 0) {
>                         t *=3D 1000 * 1000 * 1000;
>                         return t;
>                 }
> --
> 2.52.0
>

Tomas

