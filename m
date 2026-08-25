Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A733938C
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672584; cv=none; b=eg70XKoY5WR3DAfeMBSG+Be2IjmCuxxK73h1pG+oq8W3t0mae9LpL+NQKcdD6S1brf7YPvaYvR+uFuZtOdF0qinZrOYO5JIfuYwt02q0FyIQ0y9Bed+7BoXkEV53YHS66KEKxwXSxi/2TCpPeYdFkZh9w7mibIU+pEUJA4BNa44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672584; c=relaxed/simple;
	bh=fhiQy2OV+cVozCzA7BSCdsrQ7zEt4QGoeZmCdVvGFro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgS+pdXVJ6I/uNeEPAWpLKI7fGLodojFWJ2gEynqyLes76aez6s09dwZXSMMp61tsXADl5R1gWsg3YFl4d4QMhmdB0e64MG1RYwHN3QKzZLO7/EVIrr9KeHbw08eNxzSHtc4m24WduhdWcWA822H27d/y2sHVRiECMQH80L7ImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ckt1bpky; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckt1bpky"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceab75934dso63979545ad.2
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787672583; x=1788277383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fhiQy2OV+cVozCzA7BSCdsrQ7zEt4QGoeZmCdVvGFro=;
        b=Ckt1bpkyFwWg1EvlI4uGlY8G3cO5IES3FcAaseE44jO/8wvNJRGpwCJ/bUhmomKDae
         5H0y5nVG7xbzwrp+HTQ5D5RSvGUiahAe0MNj0+CEveTo5fsk6gLQ2+RRBvbplSDIQFgK
         2dwSBuRurkY9zNB7LIIPSqfzIPndlcsktWFtYoudJxyWD2LSsXYfHw3Gk734Pz73Jurp
         obFoxpNWbWqpY/0ivjSFDW1H7aWdPZkyf6ohg6ahxmSUzpO1S+Gzx2aF1x5Jfzflprfz
         aSOhsxOJ6B4yh0Dp12NOdMueW0ujNLVYSf//tPB0ssYEOsPdC2jhHlfQ0H5qrsZ+udmF
         reqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787672583; x=1788277383;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhiQy2OV+cVozCzA7BSCdsrQ7zEt4QGoeZmCdVvGFro=;
        b=tLoUT/d+S6uIdSNBIsL7R/v9wP+D5zIVQVO6bUqIldFqYaysS8ogr8h9LwYkhqnUTd
         5VjOp5PLew9vZ7Zh7+gYnlg0D5VwSD03nkX57qefVUiWB+zmSpmVcWKEYli9aTYuzgjD
         MQyuyUKPYTPJY6+zjttBpuRLr+i7RzOjKRsIYRrdRQIwZBgsMqYRm6yGCxo+30y+XI0j
         +qjnEY8s0TNlk+fqpmC90klfq1E4CVmqdWALaclvmEVBW1CsHlzKdqIxYkDiIRDeETaR
         DlZJFXd/YwVDy8vP6q6UUoLm6s6D1L6pNTW4USn2D6fIJFbU6dYUwpqb2JWUjvXxVx26
         KYjw==
X-Gm-Message-State: AFuF++kDRGX8PffWXvccxxkrzIjUqg3ULaoJwHEPBV2Ivqy6v7O9I3fa
	Lhv+QEdCdPYxKXflRUm9yLJ6r7WC3xSwYFi3TZgZIkzEyKF+crHMFIIOCiLYNbLzp8/65pUq
X-Gm-Gg: AR+sD12wFdmBt1W7HBdvTO7ZAgLURAvdmjENdZYuZ9beZPkkzw/pDmUmcjqFn1vKgSN
	+PqtnjmcDp6hrQizffUtXKwvqry4L5mNxoytMQCvFd9FsMYojBIPZqFlwUmrEl6j1RTzRyaPdDN
	HJ923j/pqbbbzAh7LJTIGFXbATOVUM7CpLel61sLY2SSrk8teX6rOdqxmn4G9rtGt/VglcuR777
	DOj38a5GZaAwHZH9cjdBlnhO5trAaTq7/fSuTiyQxyi4kn4uEeliQ8fhREl2vfLY1PIxLTIHjwZ
	oQbQy68PgHMPO458QuW4V6XGuqH3YoAqSb0X79VbDs/KKZc3zS03PRQ/cXu2Kl6nPOUFH4Bzw8m
	D5RoVWpjOcl9xNxVxJBrAlVtXTJBOUGkeSts2uiEAdExwAjz4hVsvdE5W4tCAXMf/58vkAeT8SR
	8ciJU+gk1BCB/H+T5wjXPBqPHi/Z/y3YPw+5JOrnCaDZL3z1l4os8jhBeJvQN2SUx2Hgfuou6sc
	JKm0MECGWd1s0UOkg==
X-Received: by 2002:a17:902:e803:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2d670bb0a3dmr468059675ad.4.1787672582533;
        Tue, 25 Aug 2026 08:43:02 -0700 (PDT)
Received: from localhost.localdomain ([103.210.91.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0a59sm46306748eec.9.2026.08.25.08.42.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 08:43:01 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: daniel@iogearbox.net
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next] xsk: Fix circular locking dependency in xsk_bind
Date: Tue, 25 Aug 2026 21:12:54 +0530
Message-ID: <20260825154254.86328-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825152152.86092-1-ahemadkhawar123@gmail.com>
References: <20260825152152.86092-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Daniel,

Thank you for the quick review and pointer. You are completely right —
I missed that xsk_notifier() calls xp_clear_dev() while holding xs->mutex,
which acquires netdev_lock_ops() internally.

Please drop this patch. I will step back and do a more thorough analysis
of the full locking design between xs->mutex, net->xdp.lock, and
xp_clear_dev().

Thanks,
Khawar Ahemad <ahemadkhawar123@gmail.com>
