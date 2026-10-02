Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190C282F1E
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926664; cv=none; b=llC3Jr7a8Nz5Z6u6Xtsb7rzMW/k3Yk+ktzdXunO/KvNHaqpDf1NH2Kr4mX5EmXt+G+iYcMxWkru1cJKJegyod9dFaEmhXIxnyOonpvzXMKBRbLnDe91VtY5E4o0iWg8xrEcJq6EF8PksmOUpxbR2BCtPAdBISriC8TF96P6YrmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926664; c=relaxed/simple;
	bh=sYAyqQ6f9bRmVhsxj1veuLunk3nA6ckSjNhuKUxpq88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rS0YeXo3BiwooZ23XUWjRe7o/BFLj59iW75UZAn6oVUiOsOlqZM72dHddtbiN8i1gbiuba7D9prkn2Z+ZbmUblu7m/2zOZDWeWhh2H41WbviD0tnrBSMoNWgfUWGdJFMylth4Gx0DQQ7fd9jIVOKz5h71b4u6r9aXQgoJU8Tmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWZxQ6cU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeYoPVhP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWZxQ6cU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeYoPVhP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790926662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WV95wAdEBW1v5k5upi/D6jheWF0Dkl/DxQsG1HnT/70=;
	b=EWZxQ6cUE+CJ2uDDFjubjrlIYY3GLy1X3MSekZmdFl5YK8f/4AjYbqTi4QyihkvNhqF8sI
	dhhodhftzhl+TX36Gv3/kWKRlQgDqmYo0wLHC6ncbliWu0yr/wWoLTOkmp2rRYM4qY+M4Q
	SveOuTxdK2aI3nfi2aaXSjWMBZM0gao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-xjLa13jNPXyig3lS-Oza-A-1; Fri, 02 Oct 2026 03:37:40 -0400
X-MC-Unique: xjLa13jNPXyig3lS-Oza-A-1
X-Mimecast-MFC-AGG-ID: xjLa13jNPXyig3lS-Oza-A_1790926660
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a019d53f46so27696965e9.3
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790926659; x=1791531459; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WV95wAdEBW1v5k5upi/D6jheWF0Dkl/DxQsG1HnT/70=;
        b=ZeYoPVhPeBCYI4tJMUHvSWBzHL0JWHBXuNqDLibDCcGpPKpg5NROpaBTSMW2aFKpPD
         VyDJt8AapoKubq7MHS7dqoQtIK/S63mb1iOI7J9my9KagNLCVPGJ9XSlENnUADsA9VLB
         ivMtSeQu5WY0cJYks46WVRAnAHSAR/3d5wC0YssIgl53Je5G0e+aJW20mAt6NRUwvnZJ
         +WntoqaX+z6IJ2zJFYXq0pe2C1/TCnHeUQjVWFEDLfz1Mdqkrl6hUcIwH49nkiyOO28J
         8lnKYe1WRTA06/znEOoGrvxs/vKv9DqYJrAyjDIof5stnVC3QMU7aVUynEMf//T/B7Rl
         ia1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790926659; x=1791531459;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WV95wAdEBW1v5k5upi/D6jheWF0Dkl/DxQsG1HnT/70=;
        b=n8nsHyJ9UHdpLOVjMdMxEIixWcr2UctypUxJ5zoLX97YKL+WqdmkkQp76/t/qfb15q
         OA8Ued9eAJW2j6kB6ns9qRX3D6z1AxG/Lw9q37oaT6O8A2LjT8ESzvgiaHWiOKzVMS/r
         Rt7cu3g/Tk5Cj4pd5eifUgVKHEHGmZ9vQ7RORBHW3HCytSbZuM78ANCLUq2VUNkA9UAh
         yhEck2F7K7QudYVi+l76MlfRvF+LJt7EZtbXWcrRyb8mtaEoavM9zDpuObyIri6Z2mvG
         AwTR+SsuDYkSXgsRdw47Yv77nt74RQKMU6nNjD8qTMDIZs3EE2fKjYAlk489Zb3uQSJl
         1USQ==
X-Forwarded-Encrypted: i=1; AKwUvBwV0cJ5kqxBW3L0hx9Scp7YO3vC+9KEYcAGKW83xwBSU44Rl7qnR8RbR5IFgIUEpplYgps=@vger.kernel.org
X-Gm-Message-State: AFuF++kJnDKQB+KHyvCxuKaR3ZUJsx6RBbrw1Sx+SgWbAt4KsWAhE9rs
	h15RQ2gPfj/8u7nFhDy6OU97CU6yNhK+xMFw2AGbRqwQSRNT/rZrNggnpew8PfzwrQ/SSwdFRZo
	BOU9UsGUiU7z/8DT+SGHBJn8IwLaNJMgEiyZb5i21D01lRKJHP6Wddw==
X-Gm-Gg: AYBFou2lsVwv/qeYCUnQ/P38AGChvSrslH13Q0Bqn7Igs64lvpdRgX3HExVwgBMk6FE
	t4e4qe/EqchPA6ZTxehqCTQOfQc8JsTV1TpJnXyFL1q5iZBtDz2T0U2ylu4nWwsfiDnX2hmFKp9
	skT68DubqmjvBx2S4oXE8OGtMiCizG1Wrw56FxtHClMUnNmnCHRnH2VZbCuiMJcX+YYWXl8GqZS
	PQN7QCgW1pP1NCq4D8dev6dNilN4BTx7QeE/Z7qoQD1xaGlOMIuTI+rmOHa4E4wzyug45gH5qyb
	jmyce6H0oYSflHXPMHWCWRXWc7GsI5ruS8+2XUtkrMONGt1iMbmMu2HxfWh1g/O32nPA/e58Sy6
	X47Z35SbJmRxnen8/feL3HgtNz5hzxbPzoTQ0akG85k23jwgLkZYqofhyCSSAsERKcQ==
X-Received: by 2002:a05:600c:4e8e:b0:49f:fe79:62f9 with SMTP id 5b1f17b1804b1-4a0276afe79mr34251135e9.25.1790926659476;
        Fri, 02 Oct 2026 00:37:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8e:b0:49f:fe79:62f9 with SMTP id 5b1f17b1804b1-4a0276afe79mr34250535e9.25.1790926658971;
        Fri, 02 Oct 2026 00:37:38 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027da120bsm63581875e9.0.2026.10.02.00.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:37:38 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Maxime Ripard
 <mripard@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
In-Reply-To: <2bd17843-4a65-49b0-9e10-7b73afb206b6@linaro.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
 <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org>
 <arrAqg5n87INTHE6@beelink>
 <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org> <artpBMeM13Dd0lLy@houat>
 <xlv1wls4ebjq.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <828c9108-2db1-45a6-9301-19159a094301@linaro.org> <ar4CRTMQGs5_nGKY@houat>
 <2bd17843-4a65-49b0-9e10-7b73afb206b6@linaro.org>
Date: Fri, 02 Oct 2026 09:37:37 +0200
Message-ID: <xlv1cxtsft8e.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Neil Armstrong <neil.armstrong@linaro.org> writes:

Hello Neil,

> On 10/1/26 08:50, Maxime Ripard wrote:

[...]

>>>
>>> I don't want to add a supplementary maintenance burden for the sake of using a cool
>>> technology which has serious drawbacks and dependencies on user-space even if looks
>>> really cool.
>> 
>> Spoiler alert: v2 won't. I've got the in-kernel loader to work and thus
>> you can have a built-in panel driver that works without user-space
>> intervention. So this is not a topic of discussion anymore.
>
> It will still have users-space dependency, meaning the BPF files will need to
> exist in the fs when drivers probes.
>

It doesn't have to AFAIU. The BPF programs could be built into the kernel
image, just like firmware binaries could be built-in as well.

> Neil
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

