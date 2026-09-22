Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B552D2C8
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066491; cv=none; b=g0GgeS6U1vjaX7s6GbyOMO2iM3rkK6JSPRpMJQkQIuNe/3on0Iv3HHcJkkOXyAozgr71jzsFwmiK0fas5jk6P+/lkete0dDN/tfms3xqChdkBhLj7QpOTxsTh1id6X3QWIpQ6RVcwQRoEIhxzxi4f9KNe5Z+7xYFio0dbrj4rbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066491; c=relaxed/simple;
	bh=kOlxOzHhVvQ0sv7Ka/MactNXSbragQda2YaQkUVz2ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWe4kc5U8As6bwibnDIWqHpuOzB9otFzr6dfZ79S3VZ2hsC1Wtb0xdmrGQOS4iPhwW7fzyk+xvCQKJd7R53q+APer2fHPz7gdYt7s7/Q2McQr3hi2gpWOijnklfdggjOIF4/zMSoPRN5xqCJNk3TuzgIiS4vnhQ8XRQk7Kbj2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImcOj2QM; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImcOj2QM"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843796e373so2182378f8f.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066488; x=1790671288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nbg33pT6Fj2JHlCGEBzVZXSsW4USfoXndE7ADPxXyBU=;
        b=ImcOj2QMGpUz+C5+gC2ReEPGiUIn18wXse9HbltG6mDd3sIgsBz3uUZsTruvWi9RQx
         hfnMKR2SyGaApfOZ9mJuyTWyeNvIin/hO9iqaAmi9TqAZxkVJ1QsDT/6SubDurBeqMEt
         RutKbJuWooVwABlXVzTJgeiaVyjsK/eORpLr3KXaNkDO7OT5Qd80m2IGXg1pkLXmdsu6
         OdhnB70VNneNtZyX2Yq9RMzoxDuCCMj3U5U/fJDSluzVrydwThqigBqbfnAMQcjVgjvr
         QWQwbGp39kGTFuuMiYtoHbnqLlbgb+HPe8DBfH5EeuxneZJ53y96iLks1Olzgwk3r5yj
         yb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066488; x=1790671288;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nbg33pT6Fj2JHlCGEBzVZXSsW4USfoXndE7ADPxXyBU=;
        b=XCxvju0iVD9AA0gj/MxZA5HWRfjd4uKcw5qfnrp5P1OpREbNENM0RAaU9n8HBWKRZG
         IP9rexkvogOMoQAfDZNy+aO7jUIz3lgSFxVLLEJAa4MYWYlLL9pFeu9eH4GLbe3eZ0Cm
         cWtC8v+uvUMtBlh8jA/dIDlgPLAgQmdzK5yJwuas3HUWjwO5XJNycN8EyUgrPhq81zM5
         uGMfNTXz9RpHGj/FEhy+AKrfwxQsxpc2hwgrCKrdJXFbv9Z/+8nyrhtgVBmJq5ddsjZH
         lsrUKgwfkYM5W7UOurWkH+oZ+LRCalJTtgrN15v4esBfUPqRpmebPhmlCGkIxxBTNWBQ
         bQLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRSYCCNnl6DbmtUAS2VzIDuBKFQo8BVUenUmE0MCCvYIGyDQpEesVcLXeRhNFVpfqYlTE=@vger.kernel.org
X-Gm-Message-State: AFuF++lUoE50YyLOAhRfJAQVO4zAWi+FPZlO8pwJEpmqVBKUeU1sj+b0
	S6auv4hocgj9M3HD/kyGE/lDOrTGHu/vazR2otX+mMMiFDOWes4LhU5M6tiqiIw3
X-Gm-Gg: AYBFou2eg2CJIBl2HW35MZtmG0Lc1Kn383IMS9fkfRavEl1VIOlQ7c7FdfXF90lI/zF
	J8224F7KBAwVU6cgQwGQmkksAB6WiuMsmdvyJG8PB35HtRXDR08pxeJ7LFcgGwCeqD4FNOjJofY
	GUbS2IEnMOehKvpu/KW6mZCyGP+lTiDx+D/IGO+0bkL2dUFlInvjlbqr+cb5+Z7oIupPocshtk4
	KOFcbpe5suVN4Yx4nBJ1g41CaOqttTu/iP92szZTUVsRG3TtdQmR5NRQxyqWd+BzODYmVt1aREY
	8F8hU4FE5iu3ZXQpzgLZexvRhDCwmA2jiUnAbIljgvPMhOLNdj45gZbg1WazU2+GMn3DmbCK+tu
	diFymeSc2/IWN2oXxkrU/A1FhD0+9L62W52EwkXfhvt12dcQ8yUZp+NQWGepr41+fKkr5mUyrA5
	KluHz18RjxVy2jLQAREUEH5RtqzFpicabQR4s8lWl9Qyqa42IyVqNb/eGcnl7cXUkY5DsSbePvm
	RkFnl+Big7KfTJ9SenixkF/oq37/NfVMg4=
X-Received: by 2002:a05:6000:1861:b0:488:5852:6ee3 with SMTP id ffacd0b85a97d-48858527005mr10835062f8f.34.1790066487965;
        Tue, 22 Sep 2026 01:41:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886277e841sm3674945f8f.19.2026.09.22.01.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:41:27 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:41:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <ljs@kernel.org>, Kees Cook <kees@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/3] kallsyms: Accelerate symbol name lookups by ~19x
Message-ID: <20260922094126.05bdc42a@pumpkin>
In-Reply-To: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
References: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 01:19:18 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> kallsyms_lookup_names() resolves symbol names to addresses using a
> 17-step binary search over kallsyms_names[] (~184k symbols on x86_64).
> At each step of the search, two bottlenecks compound to create
> substantial lookup latency:
> 
> 0. Marker scanning: get_symbol_offset() scans sequentially from the
>    nearest 256-symbol marker, decoding an average of ~128 ULEB128 record
>    headers per probe (~2,176 header decodes per lookup).
> 
> 1. Redundant string expansion: kallsyms_expand_symbol() decompresses
>    the entire candidate symbol into a 512-byte stack buffer (namebuf)
>    before calling strcmp(), even though ~94% of binary search probes
>    mismatch on the first 1-2 characters.
> 
> Together, these bottlenecks impose a ~3.8 us latency penalty per hit and
> ~3.6 us per miss.

How much does just doing change 1 give you?
Might be worth putting that patch first.

If you do the binary chop using only 256 aligned symbols it won't add
any more stages but means you don't need to scan until the 256 symbol
block has been identified.
At that point there are two options:
B: A linear scan - average 128 compare per lookup.
A: Generate a table of the offsets for the next 128 symbols and do
   a binary scan (only read the second 128 if in the second half).

The linear scan may not be too bad.
You can get the first data byte while sorting out the length and then
to an initial check that the first few characters match before adding
in the complexity of the loop along the compressed data.

David
