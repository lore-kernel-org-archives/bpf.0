Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486F46E005
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924048; cv=none; b=C/uLGp/mPD40Wf3vyN3f6gEwEB8iKzFV3HiA4Bg/2n8G4+650DZh1l7W3EW/DJZk6KDuA700IZM9Um9Y2vi4b+r1OJChsIxCgrMsTgklK3/byyK1IglFMcWXIa8etP5Gu0WTJEsaCCLne7aMf0GwM3EMjoCRN9jpWXtT9NNjUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924048; c=relaxed/simple;
	bh=MoNEDcWdGlP7UcyCq8wXBRR56spV4f4PPUO0eUL2OZE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ctVGSCGo5Uim86XuucXYv0lN8Dwen61IGDEMSz/F+oyh9kLnzz3YPtH47Ab7+ssTlOSK6zYq2VzWqQklTN9I7dVgec3KywCZLWZ8v1NYrpPYEhQ/ry9hnpCxaF9GNNkGzkfKCkyOl/lHE94pdne3hu5DMv255T/PAN39Z2EPm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxbYk8Rs; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxbYk8Rs"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so1500278a12.3
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789924046; x=1790528846; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+5OXkFTl19euajO1h3c9jy1KZ0WClYAUhVVTBNP2yF4=;
        b=YxbYk8RstqpNoQLxSV22rHj2WD/9cVINT6vI6PCf3oDmUoVKamqBQMaITd6AMf88zW
         +WmYeNe6xhJyLXwgGa6owSWwffxx4malxAJX6EA0iQyCCoQk0f12JSMk4cygi1+vHALH
         ISbQsG/471I0i6Pyxu59MVm33urf6afCcopbGmfOwlZN1GPazdMyUSnUvQw6ob9EzVsU
         kqw87eLGW250yl3z0Z0Hl1idiuFfetYTFeiYJ1bXPP6iWQeyLvngAy8ag0xFPqVX2fXb
         Yb7oyGHZ5YMP6A4OIs3U3TsuiSYRS7TUs1lU955TL3Cob3eDECtyDjzqYXXfdApXH8Nw
         VVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789924046; x=1790528846;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5OXkFTl19euajO1h3c9jy1KZ0WClYAUhVVTBNP2yF4=;
        b=k9xvjGtZalvii7ssSErV3tkNM92wvS79OKVSewio1HSevC4Bjbd/Rb4NHYfRZcmguk
         yXfTR4q/F0aiSsfEoErsqffhMOh6ieAXZ1+Udqb9xKCeKH1II+mYSoT6Rt27oaGm0O86
         0sBebsv+oQvkzk+0KoPgRxq/y92G89L9/hZVlpMTs0QLlLQxUC38g4aH8dVhL1vjBb3l
         fDFaeE3UrnlGYMhhjmHhf5MpaCm8Ll1DcnSB4jm/rz7ssLpwxI6KAxX1O7Qpw2iT3qzx
         OxFTVNLvqY8XoIsX643EQ6HpC/f1zubETh6Lu/mi+wSAqABtvrW7Pm9bPazN4ghselUp
         yLDw==
X-Forwarded-Encrypted: i=1; AKwUvByHOxUoZiGm9lX0J/X0pkH7m5714KJgRVmNhY+zz7E7dByJU/6bvGEzF3a9p63NRro9Bts=@vger.kernel.org
X-Gm-Message-State: AFuF++mcRsamrHmS5zLWDRaiNy4dLOcbSlJzPRXp3c5vXM1d6i+x0j63
	fVDsU0JCCcdMHUGltE19CqWkx53ArdB9SjdjLHaZ/xU4jmZD/a3Kb6mP
X-Gm-Gg: AYBFou0UqPZ1l36DSb3XotGjFqPzX+d2P4zCE2gfmhTbDOrNAcU62Jw7TKjpEK4gr1x
	DwG3aehZXdeCyF3Ztf4aDPHztk9XifMpx84V7ucqhzjsVsiWvOIcx4OgE+ows+QJfWXhDZBB3dN
	7VSyfh4MVgnM8hMJJpP1DSjjB1iSoqJziHYmgxgzwxrpVFPtrr73rPbqTwHBcokkWvqd4jLnAtm
	h69Jxc15k0V2k6OM2ZOO1wGE/376Gu2vQN3q6bxyHduNzQwR1aiOisbjFblMQucsjGSI2TnSaJM
	aRnL3TV1SI+xP9WxvSWM72vf0Q9QHj6uwGG5s58wXdOryhyupqdzU8N7JyqXmdgHJarE8YRsrAZ
	N+RMlgPQeB8iOWlgfCKihNTnw8uDaU+j+qZtuXFvjD4gYILAPIyhAEMM22ZkQBAHyIiclQmch7F
	CsKQdpjC9gxy8dNoFY/rVknQzKzLqY5feFMKACBjtwZ/RQI/K+cmtfudNxrkbnPYS1mSBoUiub+
	iJoo+wrYOvEiRisDBT6EZUsRazbx+5WWeA0iSC+1VKlL8s/s9wKzB4GrKNsaRCctEEKEnC4yJ5E
	P16j
X-Received: by 2002:a17:90b:2b43:b0:39e:1ff0:331b with SMTP id 98e67ed59e1d1-39e54d37ad0mr12487465a91.2.1789924045869;
        Sun, 20 Sep 2026 10:07:25 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02900f84fsm8679011a91.2.2026.09.20.10.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 10:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 17:07:24 +0000
Message-Id: <DLKB4AJ21W5Y.VSMC8ZB4EK9@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Peter
 Oskolkov" <posk@google.com>, "Xiang Mei" <xmei5@asu.edu>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] bpf: propagate cb_access from freplace programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.17.0
References: <20260920163211.795547-1-bestswngs@gmail.com>
 <20260920163211.795547-2-bestswngs@gmail.com>
In-Reply-To: <20260920163211.795547-2-bestswngs@gmail.com>

On Sun Sep 20, 2026 at 4:32 PM UTC, Weiming Shi wrote:
> =20
>  struct bpf_prog {
>  	u16			pages;		/* Number of allocated pages */
> +	bool			cb_access;	/* Is control block accessed? */
>  	u32			jited:1,	/* Is our filter JIT'ed? */
>  				jit_requested:1,/* archs need to JIT the prog */
>  				jit_required:1,	/* program strictly requires JIT compiler */
>  				gpl_compatible:1, /* Is filter GPL compatible? */
> -				cb_access:1,	/* Is control block accessed? */

No. keep the signle bit.
