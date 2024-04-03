Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D336E60F
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163951; cv=none; b=quSZ/P8uIdNlE0GzWoKB9tRCTxvzAxk/ABWJcG8k8+ri85q1pLtKGc+PgKaInPcmq/jJCmpjn0E1PWtOHcOU8FxO56VwNBmN1xC/QcDSuOV82T2cJjJCkec+Yzs/tlfMCpTxXA4vmDNgx9XBt/gbK8DhQGUaqVgIx9rjUo1nB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163951; c=relaxed/simple;
	bh=gjdcA/T5VjlOFjbiVDW3dMVKPF+tUicG8N8GX8fqxgc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kx2a5glE59Xzj9ufhaCa6nc2Azt0oJrXMD8kLFWo8Klm7i/DkTaqantej21S4ythGOptW1Qq72FfXvU7W6nOQX4XDaqnpzgQjEJua+SLBB2ZsG8bcGU2Nx86QR23C3b8kf/U6i1C07Yu3hwkOeQNMg6ngcS7dJKJqiUxPhcre0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY8wdEUH; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY8wdEUH"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43107ccd7b9so321981cf.3
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712163949; x=1712768749; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gjdcA/T5VjlOFjbiVDW3dMVKPF+tUicG8N8GX8fqxgc=;
        b=fY8wdEUHgKjmwQ9K06VccqJkNzvmaOxG7OLGl4ykxs0NLgA4Ha14RpvnhrsLJRcJaK
         nmyGq2L8dOXayOByWZSKvhAI7uUWpI5tB40Jz+Ml6MRL4pdJi9duh3cULJg0t6xQ0DAM
         bV26noavoKZ4vr2B6+50ObxJS2HCRi0r4qh6BsyRq3X+1ExaruJb/YpMuAr2npIz1IZh
         LUMv5dwnnPXH0JYT1d8BHlrVIMl+B/q/wbiC/gUDpuyu4TvsGHLhidHo0W9j2uMfNf0K
         T3tnrKA5ZGMM+AEo3s+tEc7z37Y3Ahu2rkqkUH4MC2JQkokOkbewS1SAO5KxGY3UbId0
         Tkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163949; x=1712768749;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjdcA/T5VjlOFjbiVDW3dMVKPF+tUicG8N8GX8fqxgc=;
        b=X7hl/2Zw61PCfcbVIr+mmse1l6vHF37r6U+XVlTX0Xsl1FBj+NBl3p6Pu4DsZ+ezz2
         YlURWJKxeUi3yjdVb7BMx6Ih/kRKwQCuoyfY3T/yjG7IGcWtyIuu8chcMX0du70HyFzL
         5vW7j6c2vfZkBUJHWhs8TXioLJJzqgk/tynFnXbyuinQKOJpamI0etSC3cZSN9P5dmi2
         94JdsZZxf+lMHMh/IWzxwupGjTzlLWtD/eXj9n+P6SdQu6966AY+wU/SYeDEn5Zc9CHL
         oDVk88VUkVws7uNt1ICA/tvXXJJiy3KaEQS/LfBPSZfu4dHRg1LuDVrEPP27prZek7Bl
         7hyw==
X-Gm-Message-State: AOJu0Yx+yzVRLjsFdrS+ZNO9NGYr91+1gm0IESRleGEweUyoV6jmphPF
	Pw/EYjbS6VsF524W/YHTdS7YQvwCBIj75CRaVRcrhqK1JP3L6dxzpMfpxjj/8blZiJ2B9cq/0wY
	v4gwfDjlutQJfhHoN7FIpGIl0QUFOptoq6y0=
X-Google-Smtp-Source: AGHT+IGX5DmeJgyJDTDwXzvehgGd1fhAGovzciVqnMGnOlyPS4TGb1LBzRpKb4ocIQyKCdTFk/jBdcLOtangzKu1mD0=
X-Received: by 2002:a05:622a:486:b0:431:60c3:7854 with SMTP id
 p6-20020a05622a048600b0043160c37854mr18528414qtx.2.1712163948720; Wed, 03 Apr
 2024 10:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 3 Apr 2024 10:05:37 -0700
Message-ID: <CAK3+h2zKF-RY-Hr0SCDNttktAhdjOzgP1jLgbH6wD7+ssL4rtA@mail.gmail.com>
Subject: [Question]: How to disable modules BTF independently?
To: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Once I enabled the open source firewall IPfire kernel 6.6.15
DEBUG_INFO_BTF, the IPfire ISO image is increased from about 450MB to
about 1.5GB, I suspect because IPfire has many driver modules to
support as many hardware as possible, pahole generated BTF for all
these modules, that could increase the size of the ISO image, so I
wonder if I could disable modules BTF only but keep vmlinux BTF, or
maybe selectively enable BTF for some modules, but not other modules?

I found this discussion [0] making DEBUG_INFO_BTF_MODULES selectable
independently. I am still not sure how to disable modules BTF, I tried
make menuconfig, still not obvious to me how to disable
DEBUG_INFO_BTF_MODULES

[0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN2tyk84ZGvwuCJLjesqw-_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b665951feb931b294ec2d

Thanks!
