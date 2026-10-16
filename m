Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152522EEE61
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113099; cv=none; b=fmJ2V/j5dtWU33LmfsjkvsIG6PyMx+l+g67oxFfsSpCQNgZoyR59oo333I/jHsnmGWtOYVl6kKI923Dx00nayMCfbgRlUwimqs7ynXsKtIKFVoh5gn9vlVSS5JqivA8a3Xd+333R1HXkMBc3Ts/khvK4KLew9USRJhgTrOIDQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113099; c=relaxed/simple;
	bh=sLnYbktuT1g1g/LjqgU2Z9M3b7lTLh+tW2NCmQ5QERo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hN5Di2hrNNb4pjBj/L8JcUb6yEMZAcuHnLvri1U0KD9oZuIUqghi8/MjEMvxvLXkAbAFvon4ukix2meOJHZkK/SsIjIg0uK3LLVJQpqrWmsyanxh8VLcgX9NdzrmbjNiwMyU5KVvLCIWl6B/sB92D27mEN5OkhmgAP9M99c6F4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIQLIHTe; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIQLIHTe"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso2536718a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792113097; x=1792717897; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sgvWF4fy+Zfo0uM9S9tFOKwb3/yr+Ndnr70noKK8doY=;
        b=dIQLIHTeG/8cPvsvgdrdiSaRxuCUcY6V+k20FPrQmCj24demV/StNSDu3oQTJn0NHV
         M3E1yRfiOcGvWjYqapkz1vIyzp+7QnDpIhMSfrJ6x6kLw4+2AypTlHfSZIwAamUJfpLv
         amnlrfWM9IwlwUo1MBC0GwnDtS4Jc+eZOrtpa0Y8Eb10fVOnFnDft7sxNlB4UTy9QeJD
         hgfMRHIHyetEDlCK0Jo4QqbB/kl6ifkcaIdBXYSKZUFRh0M5oUJGQPABiXLroFR2UdIH
         NT8Ne4Ozzakhup6j2vYQ0HRKmtB1yt8XUTjOFavjDLqhA3hiGIf0FTbgKbtsVGbBLAOE
         Arvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792113097; x=1792717897;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sgvWF4fy+Zfo0uM9S9tFOKwb3/yr+Ndnr70noKK8doY=;
        b=rIEGnldOtLsb+0WDrquMIoO8KUt4D/4mMbouIc5rwa9VrmfLXHAT1zMAuaOOfedTVx
         duiy+aRrRl7EdV5W1bMTZhN+UL97S/eYSYcLDurhzxBRelA0Cloup+rTUB/11rXomeBF
         f9Xbk/Y/0q7BDxXqFEIyFmPkXpbVeSaX+8R0GXPCajaAS1SAJyqfCG0CjQGQaZEwCX8s
         E8QUmo7/vub+5D0ThelLkyMgbhNQkRmCxfEnlp2B4/siJPP3lnMq6YRHkuOi5KX+7Flk
         MQY1NOzSpYuCQg+YePYAbMbVkvEfS7wUqiAGLUj95Pv4YD29dLzx1z0a1Wgh6kRgn/jq
         HL5A==
X-Forwarded-Encrypted: i=1; AKwUvBzExD/cQW9hzP43DJ6V5b7YM8/MpTlvJghKj6icC9oJVpKu8T8W54ullfvToiiGbBCiqAA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEycss75SY2FwTKpPs6rIq3B3dqeVgJinN2T8KGgMIisRYjyZF
	K1yGcdqMsZn5y1KDsU4WgO1y2vZlUMmSLnXvYSmKI0gRRW10iDJPaxMq
X-Gm-Gg: AYBFou31j8Nx/X63Z9K/e6VeHgN6vVF/0Mov7q8aGRlSGVKua73psGB+4R9ZnPqEOMp
	ml3oUulaHycMQJegcjOZMwtP8uCdl+1TgKKKV9QQ7CgC3Z+3L9HL/KRjtVO1SbbZ85T22gYhk86
	reAQ5w+JWuyYm09wLWuu3cR6g0orbaarW28uM74EkJisNxlSEeTclWzCkFY5d2kLHvayMOsh0Bd
	lOtP9xuxRV+9GHP1Xy6wQc1ae9LXase0PiBidDu56RGxXn4iFPMBaBKI3ct3N+ZssW3Srj4isjR
	Ks1ofNIBV8lDuNmw4b8NYjy7eXD07oLS0PhlbtCMo83Px6MtzaPF4Rgp59Mkn2nx6JvZYTpmwK3
	Z2xxhTINaVaXJeKwGS6JiQtp5sScADJzQW1Rpwr6tFJWq/xSh6R1eRs5o3xxZ6vgvA4X8sARqu+
	10i28HTmHihyVawib6oa/9Mg4Aee/YLQ69mUwjTWGl166Z5xFaBJ8cSveZt8hDApFvMzZcG8eCX
	KZFijXo0KatDx+ePL05w8bT8bqfyCW7sBerUTW629fBHSlOB2MYSHbPVWe90RHJW2/mg88D0+OQ
	qNaf
X-Received: by 2002:a17:90b:538c:b0:3ac:80dc:f406 with SMTP id 98e67ed59e1d1-3ac80dd0135mr5944732a91.50.1792113097193;
        Thu, 15 Oct 2026 18:11:37 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm7471432a91.9.2026.10.15.18.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 18:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 01:11:36 +0000
Message-Id: <DM5V2MT14QRH.1HNZAXBA35LX6@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Tejun Heo" <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 09/15] selftests/bpf: Test __arena pointer
 members
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261015234125.3152346-1-memxor@gmail.com>
 <20261015234125.3152346-10-memxor@gmail.com>
In-Reply-To: <20261015234125.3152346-10-memxor@gmail.com>

On Thu Oct 15, 2026 at 11:41 PM UTC, Kumar Kartikeya Dwivedi wrote:
> +struct bpf_testmod_arena_member_args {
> +	__u64 __attribute__((btf_type_tag("arena"))) *ptr;
> +	__u64 __attribute__((btf_type_tag("arena"))) __attribute__((btf_type_ta=
g("nullable"))) *null_ptr;
> +	struct {
> +		__u64 __attribute__((btf_type_tag("arena"))) *ptr;
> +	} nested;
> +} __attribute__((preserve_access_index));

why __attribute__-s are open coded?

