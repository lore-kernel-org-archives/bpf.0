Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71264772B9
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766586; cv=none; b=Q5zFGw9t8qKTce8HV46eEOtq9UXBV9V0mAxP3ES+dXj26qVN0A0fWnU21Sc4JtbXBkVfMxzud1FIH/d/2xVxOFfrHoVcBoP5wkdZZ2M/ruKS/FVwEkp5r6UUIoJMOY1I3g13VY17MyvARl99NgfKLnUztev3+Jc9ENhlNwumMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766586; c=relaxed/simple;
	bh=8o8c4IAe8U75qnpSJQagYzi56CmZ3s7yR+zEHSeQMv4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmDf3P+ynspJDeREmU6xG+cfwk8zlIx0nNcdhnXGwqLq49GVg2FOVOWB1HfMykWCmkHDSiMnFP7Tt9sxSVCOlUkp2zgX9Zdb+UR9RJ6G4EfxORQhvAe0AaZ4AlHK00DVQ46tTFMALcx+zkLzkKnBvHPGs5ysObnSuIvPeQbTOfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1H9l2hJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1H9l2hJ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38f620399a0so793730a91.2
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787766574; x=1788371374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8o8c4IAe8U75qnpSJQagYzi56CmZ3s7yR+zEHSeQMv4=;
        b=C1H9l2hJBtw4weAQ/oKw+cjQHWqeQsUlUAow8SQpk84X54abaaybOUQinHu7eqHUFJ
         mCUfB4yEfT3dZ6hqIp4k31CWDdFiz61mVLYUeGlKXHNEXD4bvRuCfcyDdZTbOCMwmKUg
         dhe152XPxRUB8dRlZ4JAQ4m7FheCqTxqpezXuYhl2y7I7kMtCsupOEqRIZAEpl35GLlH
         SslYZWnE0LdEYfOJCwpB6TWSUstJKZq9kDnFXaXVlsfvYi2xCaUkcSQ5Rj+MqUnNXFwg
         B4xk/0/sO3CSAtlyEiCYIuQpNMr3W9AH9LoPMxTFZBn5eAADeProfvRM6z3RmwtzoWR7
         5uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766574; x=1788371374;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8o8c4IAe8U75qnpSJQagYzi56CmZ3s7yR+zEHSeQMv4=;
        b=YJgbo2VwSn1dXv+sPdWJ141vCqRICxnJv+hkKN4nsMeC4/6qYp/IvQNplUYwgLNARX
         w50b6mX0XPR8an+Std1NUhhbHsQlOl+DNw03G5qWOJWefBmp1VFErWfuJx9W9JGv7NnT
         ULFUrnI/NC4iiZKsPWNlat5S1sxHq/IJ+/qBS17x9sWEQX6BjrmtUarf0xBV5LiF3ujl
         tKK7Yl4lhALzQTOvHw6gwbo6THM4zvl06OEwkdDFmtEjT7JRnc0a75x0ZuZT4gLu7fOQ
         FNrZAt/hJi8DvpClv/T80lBMtNAQQDhndpzqgKIRecy7v7JpY8jKyahubw9b5jVMaDt9
         6F8w==
X-Gm-Message-State: AFuF++n+D+BiDdqVJDGnl/xDvLAG2QSyL18lXLBG18dv9MLsakmMqNw+
	NdJPnA97KLJiUnYsp4Bi7m9nwSDw2AmH55q9Z8XPGrmupRwyzI7Z+QU8tjwnMg==
X-Gm-Gg: AR+sD11y/B0dTTPHEmxlC8ouK8SDNqf390l61l8BJyljolb/O+hQKjAkbGYcFby8lU8
	2hX7hr0ykgH8aEEpQeIu+bA8elbHkh2qvS0ZCnmOZ2/aWGYe1kyraKF4pzLtCIj0Cm5IO6W4tX2
	Jc1KvL06mRckJ7yeiyHab5dBaaf1KNn2deNfwpX06NFjxaLXg6I25rUXmDYthgYUSREvhODdySR
	de7PzaJCebO5lhbUjOp5Jf0FDBJ4qnRkSaVvCaXVE/c00dtZA2rEWGRgthCSR8gip5Zeb1pIQpY
	/hBrIZr7ce9BlLBYS0JPN5xRlFKKUz48v/FokooDO6ssnZBQdsOeK4r2vshEuZyJw/Bw3DMYKnn
	0RwmlTYpvqwwl79OYD19e3Hjy60uwEFi1QSqR7upgHoL8kw3qrNwlhKtIOKpTwLgWVkyrA90Q9L
	rWaEaUahsWfIYk7ZbkG9ta/T5WfqWLtww9fhHdzcwj5Y8nSdF7CL7eWkx9X7C2/2Vnnr292I1xp
	qUMGblStpYyAKvbSw72Iys=
X-Received: by 2002:a17:90b:280a:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3966d1e226bmr18902135a91.4.1787766573836;
        Wed, 26 Aug 2026 10:49:33 -0700 (PDT)
Received: from localhost.localdomain ([103.210.91.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3966875e5c3sm5093511a91.7.2026.08.26.10.49.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 10:49:33 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v3] xsk: Fix circular locking dependency between &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Date: Wed, 26 Aug 2026 23:19:25 +0530
Message-ID: <20260826174925.3425-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260826173019.2917-1-ahemadkhawar123@gmail.com>
References: <20260826173019.2917-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I sincerely apologize for the noise and mailing list churn. You are completely
right—I made a mistake in rebasing against v2 rather than upstream master,
and I should have respected the mandatory 24-hour waiting window.

I will pause here, stop sending revisions, and ensure future submissions
strictly adhere to the 24-hour rule after thorough local validation.

Thank you for the correction, and apologies again for the inconvenience.

Best regards,
Khawar
