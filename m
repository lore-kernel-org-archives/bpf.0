Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C826738B
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784604003; cv=none; b=MWor1YhIr1jC7NKfokjUosv5xAM5wfNYHAV9Njd2Zz+7S94kxVBqC5rHPUX+ajZrIqTU3RdZTsPighif4JhKk3VCLpjQH6iIGClWPPDiT6ZAbHMt2onXgfczECLFggNk1FNOevo6J4KkrUQOHqrlgSHPhgA4fm2LEmC6UHWV/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784604003; c=relaxed/simple;
	bh=jN48kOJU4WhtS9MttnvWOpagwtAUL58CfCi146hI6oY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=IDiv6LNsjKEtL0CoZWLZdiUdHAHh103mkzxf9CU9os7RxT8KFRXBocekjzoLZiHsU903VOKaKhuW3PBwAQs9a551Lq+wvqGZC14n/i7qN82QC6zEiy0JfkTx3qkUKtmOy4HG54kEEKDw8j8CAp7q2epLFWLYPQhII1TMhQiVoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/3w1V3a; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/3w1V3a"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf52d15d88so23773265ad.2
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784604001; x=1785208801; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jN48kOJU4WhtS9MttnvWOpagwtAUL58CfCi146hI6oY=;
        b=F/3w1V3aUddUPI6uPEHJ9+Cyn8B5U3EJ76jHNz2D34aITrFNWHX6/2BPAxjo9rW/JO
         rxv1So5A5k+jdLH/hkZ03fdUvFz0m+VNhncspfBF1+iITFiLN6MiryC1f0RCc6zISpMR
         JzKjPjsfXdMipUsEUz79amwFWRvKctqCjGSZyFFwpCrdDV23PIlyjI3Bbc4qV55tTROy
         2VA0tbX57mrPiCVOuZQQiKd3YQ2gw043pwMd5P162rc1IfvOL9p26oAyfACuFWqyCrKF
         tJ/7L2LfeaYNKwu+LurqUzex6FctTV7cFDNd/GiLJB+qUVuttvDoEsK2fyACvt7ZvwXa
         co7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784604001; x=1785208801;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jN48kOJU4WhtS9MttnvWOpagwtAUL58CfCi146hI6oY=;
        b=NzFRN0IxJxdZ9UUTtfGSE8xDk4O0pY1vT0dCPt/2hTuQtAwL2uGCByHjLjbyEVBQHs
         uWKCQAR2G4EOtk/Y4s1yoyig8170fW8uo4CemI8FBwme3siETjuDxVfWsnrXIFfgLRaD
         MfXJ7i7Rci8Ke8icgVVbLSBGUU2rXz5OSRaJzhZxWjdzVsuv4pxJDOrkjsUDzG6xyF4A
         xUvU6HW10ILG/mogZPIMm4W6NMO24DQi62reFHAFj5WfrNHBVAszuqtKi8s6d5NE4fY0
         fLOxpYGO8dy6PZuF2c5cOUmLEh2/JtjpF6xTbuAZXy3Ps4T7IX2j7Sk9wMkTRfx+OMr1
         Vh0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rovh3+NlwM9IB4R6W9xF32N2GIKT4PQKBs1Nogiu8aZeEh+GE3khqSatfy8Z+oYG1EkrIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/ST1JsZpaEc0QgR13WwjaDG5URj41CupgA2AHVQdTcBdlBm/
	XGSNJI/Ob427q2uD5WgIrBI3w3xuv4oynmytP4zwkBfyV6Wyi2dwvMyU
X-Gm-Gg: AfdE7ck9s9M+jI6FwEQyLACE2GOAkdVlcyhZjRFrXOqMIdoAG3iW/RhOgUpsoSyZR7Y
	Ep2yVIGwuAJVdg59gJSQDcvtM1aO+XWj82v2hc96vMjGZ9nND3Xt90wrAIrSh9+ZlxNVAA7nj3N
	OiBjyxpqbrS/I72zdcZTjK3AidS+PtpvubQv+qSCzAxKARawoS28QbGf2yxjDrlYRSqRZXCdCuO
	9w+nl4O4mHiDDFCen/gbhiKidwcbUCJhxoQXYANENVprNrRNZKb1Bf0oDf1K0Xa4dPRJk9cbFYv
	IZcYjmUgCIAPKJkCdl/G6XywWN7DOB6fBpeH0C9KDcefGLLlx/3kUCedmcosuFbRJTzsk1XyjmD
	ZNehPmnWuMlDAHekrdQAMDFzxDDSocXwgzN/haxCjAELEJlSFiYXIG7YNHau4JDDuLL0nHCa1mJ
	kXDkiQPspGA9+A5w==
X-Received: by 2002:a05:6a21:114c:b0:3bf:a489:1483 with SMTP id adf61e73a8af0-3c3ad80c23dmr17180509637.33.1784604001242;
        Mon, 20 Jul 2026 20:20:01 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de21asm42087052eec.23.2026.07.20.20.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 20:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 20:19:58 -0700
Message-Id: <DK3XBITGHXVO.245WLO7AFGP4M@gmail.com>
Subject: Re: [PATCH v2 0/9] binfmt_misc: bpf-backed binary type handlers
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Kees Cook" <kees@kernel.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet"
 <corbet@lwn.net>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <bpf@vger.kernel.org>, <jannh@google.com>, <mail@johnericson.me>
X-Mailer: aerc 0.21.0
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <178407531866.2243172.12944140194021045628.b4-review@b4>
 <20260715-reorganisation-umtausch-radiergummi-8b38ca81ebb0@brauner>
 <DJZK5TY3IXQC.2XKA1X9IEGJDO@gmail.com>
 <DJZK7IJ53B5J.141W232JLWL44@gmail.com>
 <20260716-surfen-erzfeind-aerodynamik-5dc96c3f136d@brauner>
In-Reply-To: <20260716-surfen-erzfeind-aerodynamik-5dc96c3f136d@brauner>

On Thu Jul 16, 2026 at 2:42 AM PDT, Christian Brauner wrote:
>> Should I continue to add Reviewed-By trailers to the other patches?
>
> Review them, please where you can.
>
>> (I have limited knowledge on some of the mutex stuff but the agent
>> review in b4 was helpful in understanding it enough to give a review.)
>>=20
>> Sorry if it's obvious. I've never contributed to a patch this far
>> along or substantial to the point of having to understand the
>> merging/acceptance process in Linux.
>
> I plan on getting this into -next in the near future.

Sorry I have not reviewed them yet.
I got a little distracted preparing myself for some talks at DEFCON34
for the Nix village [1]

I plan to take a look at the remaining patches and add my Reviewed-By
trailers to them in the next few days.

I also just saw the transparent execution patch and will review it as
well (as much as I can).

One of the talks I plan on giving at DEFCON34 is about the idea to
support relocatable binaries in Nix. I did a short self-summary of it if
you are interested in reading it [2].


[1] https://nix.vegas
[2] https://fzakaria.com/2026/07/20/linux-kernel-will-support-origin-sort-o=
f
