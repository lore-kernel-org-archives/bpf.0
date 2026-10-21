Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792540878;
	b=lcYlSNX5JMR7TMI5PwyQVU11KQpuFhFYRFxxpwZIVQT0R0/bYAjwtchxjQoY6EJl50hV
	 mwS+qcMWf734bpbtnVP3oPqJobDd8LbC/T6+zGz2MAzIiZ6oMZZYfMbDWSiKC6cOL0PYB
	 qxTVfY2MBkBPJF159uGbvNesTjwluLWD6DnoH428O1rYDCW6pNxs5ScZfhNBAJPaI3pHn
	 +HjCvWanrnwAEv1Py9wR6e6XLj+jv5jDC+2r6sc97UzMYLcrOZrMbrF3yWNraZE2/CAcN
	 hwBYjku7OMCaQZhW3ARFziwwZ1yR+DmJGeT2jIj2ejDHez2e9wmJ2r35Csev4pNxCww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792540878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AEeiPsA/EawKKYb8+qMzkwfuJK4nmSs/11TC2lwYs/8=;
	b=SaitLo3gnx1nop5uIDBdbs0Fz6/71YaE2P+5YvztCilfuEEQ0wvJ21/LBgw1DowqNP0E
	 37pOqf4ChJbbMf0b6j+L0I5QUnkTsQMeXFxyPyRlCM5l++ZgTKRB2aSwAJ4q73nEyVaxL
	 ZGTNqxSa2FweL6zXSz9yUpQxtp74/XTEvOcHOW2DvXcjR5xtIfSZ4/WwgmfEuYOT6vN3Q
	 dQxMDLaZmNGbSAzzBvJIKVrE9nhlOEZQBXHCYQbA8o6HhRnq8/n0zkQ6VgoF4E0KVAuc9
	 yZC9vPjxw5ejOxY9VqV9opqX6Za3jPmgMtxHA8KD/G3+M9VS4Bf3DsYwa7RrYAsQGAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X4qmef56;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73D606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F73D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X4qmef56
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e901e114fdso698085ad.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792540873; x=1793145673; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AEeiPsA/EawKKYb8+qMzkwfuJK4nmSs/11TC2lwYs/8=;
        b=X4qmef56mV1cGDB+s8rxjvMjWgK79wD0teCYvWaCvGWcBsW9tn7OKw/eFYtriNtvdR
         HKc0+D0iRvbEum79CeELLv2i66rh4M1mHINIpveCbd4D6xZVVoeMFr+EI3CqjQi20KYe
         +Vwll+GwtZL5zEuusqxNLqLR5a8ZbFreBlwDmo25kL8DotyYDjR0nye+wTHO9oyR96lR
         +SLVbCk8XUPB4wTaWgjsVBkhk1kBtyQzhwBCJWi2oB6XDlYJGOHH3S3PtgdcWYgcWq2k
         v3NOx76kt1gqlC6ElSLHjsAn2tK5fx72EjQ1DMUtwCDbHZ5t3Qzjvnn2UQ1MtT6NOj53
         LdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792540873; x=1793145673;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEeiPsA/EawKKYb8+qMzkwfuJK4nmSs/11TC2lwYs/8=;
        b=2nO9O81iQv7OO/eQGcIJsuOcg9HA8WRyJwupD8i5E6aI/ubewuf1K87cEsO2tgVjLF
         9nTwxIRm4uicnMOryH1am4tJ167iGL8cuLteBBmCUouFBOn8QDlSMNzpBy05UkO05TXV
         0yAJFWXMle4nqzX+eb7MBAeYhVyBoTT+fmONXlQjV2T3m25gJJH1ITg7x5HOlSmip+ee
         kN2LZoV6VDNsu4klJ19Reb33EUyCu9lV3PetD8Vo7qJHRi+CCcSSlnT+BTA6tg9UQuOo
         bgtGPNId4Zbxw6+Or/ZTuSJBUGxRAiu68a4NDuf/+k+vZz0+YeGnNGSyRn1ojvimiNUx
         Y/cA==
X-Gm-Message-State: AFq9FYLqUMc71PRHzi5Vsqo1vKsbGRAOjlBAgzWJlHZ6q7fJyBBe8/Iq
	I3BdB8XDivQ/c/R48pB610yW82rMWLTSPArhocUPAis1hYY/WcJYMzjA
X-Gm-Gg: AYBFou2FOuHovW6wDWU2b2sOH4w/FGmo/pwVxJ3BnS4tRJ2K3mCpELdz/LKu8lGv7wD
	42Gk7uoqxCJdUXjjHKQZFnNiHUc1lSISPYxZC2FiaZGQZDX3/OgJ5FriRkU4mBiYm2Z/sNBFY38
	6le8W2ZnkCWiQSmpkHqdxYUnLWJltZ65CaCzqr+kgiULDXNutkxXIjE+VDM7HSwyOKNDVuMttOZ
	ASDOMP6ApHP3Uo3FTQVKAVYaoaeABKyjjw5x5dIPtPCzZ9Zm3Wbfz9j6GhHA/BdVWN/ZYmuns7W
	oksdjKfYy8nLeTZFZKjRx3YSPaFxwwj9topB/o3ISaj9/RPQClQQfO0/7ayxR2qzQuRQL+6LUqw
	r5xyTLjm6xYNlrbUCeiWuEDNj/FFkAXcaaZTiEa2ZREYUZ/X2oCghdkWT76l5lFoJqHCnSrK353
	pOjwUbplNJBw/9ggSuGLlwWDozkcvlyY8BJyvcgwsAelPoWO/QuHjFIYhzCBVYVYz+CmJRWqxIy
	QNFEO2tL25Axf8gf/Mz18KBpUx+2/f4g7IUbb0WnSEWr3x5Z70b8IgCefuQoAbvzSaEzHnDAvQb
	3TInjMFNbw7psA==
X-Received: by 2002:a17:90b:5310:b0:3a0:c3d4:f3b2 with SMTP id 98e67ed59e1d1-3ad86cc126cmr434607a91.56.1792540872776;
        Tue, 20 Oct 2026 17:01:12 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad802957d3sm1536060a91.8.2026.10.20.17.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:01:08 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:01:07 +0000
Message-Id: <DMA2PE5NZ5HP.3DYHQ3DIKG0OG@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 0/4] bpf: Fix a struct_ops use-after-free
 behind a flaky assoc_in_timer test
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Amery Hung" <ameryhung@gmail.com>
In-Reply-To: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-0-77b2e181e5cc@gmail.com>
References: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-0-77b2e181e5cc@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Oct 18, 2026 at 07:27 PM Qiliang Yuan <odys.yuan@gmail.com> wrote:

doesn't apply anymore
