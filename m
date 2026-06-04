Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1EB30BBB8
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611313; cv=pass; b=gjplkaxcwHGTnHcQskrH8qo5HOFFA60BwiU2+aWGD7Thyq3Ny3mxc89f0m/Hz0zxUvFBC41cttDaxz1TcOTKFdemLozjx9ZmLZcW8QwrISIekAgehGbbd10PK43aG+FPxoY6FH94DIuREWdl6la7DScyhwoXG1iS2xB3/NG9JEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611313; c=relaxed/simple;
	bh=N+S6n/Znutpvljp2LyGehOTzm7sQwOqrmvx6wxqCpZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYfY6fQImii7Q10qvj2J1OzjO3uRr7DmyEyfQ0930boV43AG9A/mLtJ5foQuQlHPSatTcb6J4bhH14dxBsb33Pr+Ytmns4A+9eCpHD05s8z5eLy8RAqzdo5ZXe1g8BE4DqgcCaVXPIY1IpkNximDPWDYsSIxaE8nma7g/Fb9nj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEXUFXgs; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEXUFXgs"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-490b7866869so14526915e9.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 15:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780611310; cv=none;
        d=google.com; s=arc-20240605;
        b=ZvVtZ/8QiSOp86J27I58XNkkq8rS/DmImnSdFLmmcQ5L7jBj2UF6H2ytg6QdkeKgAg
         lc6uOqS097jUagGI2NbSk7c6GlZSUsQkthCxuZAj6VyDhAdIx93k2t7DN+m5FRGjf1VS
         Dj67tsSwFSl0Mgc6nS+zBZ3q3E5bAgpPzOrR6/hYsgAiNZin76OGXVnKYsE2XhBH2Fzi
         LruGh3n4y8d4FA/PDSYPCmI9gUgcF3Zy7zpjjHWWxeYMcVp7mA+LRUZ5A0hHI9dXcaMn
         Go3chTapMdhBez4N4PGIR9O5+tM2ZJlRy66tFFzaGTI+PVAwD6Qjm/AZj9WSoeervSNw
         AvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N+S6n/Znutpvljp2LyGehOTzm7sQwOqrmvx6wxqCpZQ=;
        fh=2WVsoe9GQizXMrjgQhVKA4Ta0Xz/nzv3fgA5u4oE8ls=;
        b=T7AA/jlLHGazCIFLyzDBNbPrn8MOBPxqUnDdsZSb+tCXpy9FAhCUl2QIriAXBoJgBl
         ncujzhRXHFF5ll5xPocRod6t2cuuIN+gOcrIeoB9cDCCoZ9ldGGeh14Hed2YNBfF57BU
         5rly8eK6HUgVMSLdMy0rCxh1xTrLYgWMg0j3t5/vmMkT0ZSxcz2HBFTZihW9lX6UnC4h
         1bHYWh4//nb0se11NRK6g4gLX68kXLh4bvcx1LLZyQVoJ/1ccKi4cqivsQWcqq1SvMDJ
         Xd/zFSlL4jlHj3kRmf4LWjxAVp17PEw/LJoVxBhlTemEM3P2AeNqD/Ow88vO2e67D4hc
         l/ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780611310; x=1781216110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+S6n/Znutpvljp2LyGehOTzm7sQwOqrmvx6wxqCpZQ=;
        b=iEXUFXgsNaotlG0sgZ+JlvIz2B3IEpkbi/YW95qSNxebMXaDvuDYK1FoctdNnitX3E
         XGdnsqbtB4LbTLxsLSsWmKbvHMfxVLgVpONZJbuBXQv7W65yD0guZL3TfLImNeuKO6b5
         SiyzRdmgjiAqJ8KCQwMeD3pDCyxQPbr1xBjuHpI7jB2pJxCTCzcq5rx+vfaeEqkIlWr7
         U85Go+1mMusqson7jV7KnAUZWiWoflZ0kD/5TyKyPV9X8G4bqi9udpII6dEIHULzUT10
         2B5foUb0eD7R/bFMQO/mqe4ZmqVo96L7uABjHvG3wiaKkX0g+T+1ky6auP+Tn9R572ZF
         +sSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780611310; x=1781216110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+S6n/Znutpvljp2LyGehOTzm7sQwOqrmvx6wxqCpZQ=;
        b=Bt5JsuSimE7qKCb9c8/vu10xSeUoP52JtYpxFpJpDYfwXrjB9eQPoqLPT8Y0w2QuLH
         Usyh45gV5GyD6qR6/DGCxNI//01YqYHpZk7V3DVQs3Q6vWFQzL6XM5p7u2ZeYrnJs6t0
         KsALOKATA/2W+JTvEC+y9mY7ixzR3M6sH92asJQA6hHU12awxMV8SEBnsMYO/vGPL+bQ
         DuEis0Gygspbm7BPCH2ugRrjV0uv/9Tmy6rUdfPtu8QiKQ1PnL0HgoKYLemxVMrvw8eN
         5Lzs6a8/MjxybmmssW+kgmQ6o1CTpnOaWibo2SmMC2aEVwd5VRhKuNSA+RTERazCDPFQ
         kVoA==
X-Gm-Message-State: AOJu0YxBv8PkZQ94jdtyn3ZhlNDVgPBqiUlzoTo4TBdOcJqje3lGnP0C
	GyzgbMz9zMkfal1ko2I5QFY1xZe+pc0xd1QoG3aZVpBEjNrL6SfiznR+rkmFllwmQ54ul21xiMS
	Besdp52+TTCR2aanPq5PSs+0GTW7hyVM=
X-Gm-Gg: Acq92OFJWH+0+gIjpqYQkf+sPpaWOtkc3h0+T89rZTZclDkR86SN3vBd9SR8GqDveso
	Ab5WhWa9ybaCUxQs3FJyhaaMm5egRZHrQT6bA90ySVk4N0/bL1N6D5eYiKcRHWy/I52Nyr/8pov
	o2lP55G9egc3Y5hrp2NBYlfPhj7x3WU6xzVYzkDDsnZ1urr/nxBkNeIHhjwOOglxoiUC+mEwHsR
	gBx9WeW0lYIW9+VSeoNVGZxEgcaI3WTMrGKwfSzK/kUyD9h0OmLT+YhiNMDq5N6TsNpLd9W2MVv
	TNP+9r8npFfjDcRoXaL9rH4wpy3tXvAk51COTpyuOvy8DAHg7UbZSbIkI+FtXevg5k5zjNOd1l1
	PxaqmROxDp/zSTo3TSPOgAfLNdk1eY3xO5b7Aj4Tfm1zsckRZwr08/UTB7ydShNb12ouZWw==
X-Received: by 2002:a05:600c:4fc9:b0:490:b8c0:d474 with SMTP id
 5b1f17b1804b1-490c25eee06mr6021975e9.14.1780611310133; Thu, 04 Jun 2026
 15:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604220904.1032145-1-ameryhung@gmail.com>
In-Reply-To: <20260604220904.1032145-1-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 5 Jun 2026 00:14:00 +0200
X-Gm-Features: AVVi8CfnBYLIp-tlymFRZk0s_Hv9SPnYJxD2LptM1OA6yj_xom8IhP939m0OY98
Message-ID: <CAP01T75pWAgXi4CRR4Ca75grBFwXBKHERdH94KVxW8hDQ3uqog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] Object relationship refactor followup
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 00:09, Amery Hung <ameryhung@gmail.com> wrote:
>
> Hi,
>
> The main patchset refactoring object relationship tracking in the
> verifier has landed and this is a followup that addresses the remaining
> feedback in v6 [0].
>
> [0] https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmail.com/
>
>

bpf-next makes sense, but Fixes: tag looks missing?
