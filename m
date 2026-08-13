Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA1368D4C
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592466; cv=pass; b=r9b3qu0EizQikrHMPAIQCTSH4TKz3gvAGp1WLETwf9gCLY6P+3eQCC/rckmy5M6qd6kHUW3HAK6dJQa7t/Wy/smoRw2LoSkK0Zv7BsCKZB99vU5RpluTNqDdTzoe/9ZO3L2mq8hZZwrCK6Xn0uMORmJTJ8evOhkLvCbtLwSVLpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592466; c=relaxed/simple;
	bh=KGNqgcuWPSyLSxhZ6HvJxhNYRieQ49SCRyUh0hq1fDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTRGCZwK09d2n+lJyCALsbnzWjgFpSbNSf8RaOxG6wD2TU5i1yJDVBt11dVt8+HjCeP/NMluYdQa3fxp0Ig7s8Rpumj3cdKlLc3LF50xniQ9cZfIoPPaC9bKeWCx7cGDTYzIBSQjaFOfMbaQFkqDdMYOr1lWSGbsm+ZllauVnWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzJe6LdD; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzJe6LdD"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b159850b16so1640870e87.3
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 20:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786592463; cv=none;
        d=google.com; s=arc-20260327;
        b=eONOz0R6vpmtNYjN5A+g5MRy+WyZVENXIwqVY+VFdz1fHXik4IDZy7LznJtyY3hhwO
         Kto4TMhMDk69cJIP2Hj5ka0nN39l8KAdNarvehnthUJJQWZl6u0Pc4xV19zDRGTLkfKG
         +SnifA+AxOK+uyFbNJIudbdIKLVOxYqTRaqdPtIkmUKZi4ABMUUksoSm8P397oJ1CoXF
         7uWUKl0g1fjNfbuUYcHDshIeiMf3Ha7wUBO+HDyhuVagABuoPCXHWJNseAFrhYm3oIqp
         BMGiX/CvIuzO8cE3SdEHRfkm1GFZiPkbTu0ExhVLfcjPs2eBb4taZW6heyU/085rfai3
         CT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KGNqgcuWPSyLSxhZ6HvJxhNYRieQ49SCRyUh0hq1fDw=;
        fh=+2i0Mx8zdklcqxcl0fG68rMUoFBPzhW3ezoAD8ONY7w=;
        b=Qp60YUV5OXfvZtekakLFmEY4kOvyYY5JixM9wPLpwVd+vxV2kJG3DqXtIAtk+JnIdo
         B15ud9VBwVpeLvMG5gyy5+Y5ejTQnq4hHv15B2j8AoefZbHjy1bz0iAungpq+zuU0WiM
         cGicygjLmIZaPb0CvSBdQmgIwBJdPLyn74uhvU1TH9D5HB1AqOsYgRJb9dJJXhQ7ZhhW
         fGHpKkozTOQKeXObEoRNOYD2fP7c4dfauxsM49km9acaF2RgSKO9XvJhghjLqaIrFBJQ
         nHcqd2rnky0Mvu/L+xakU8jRNIp1fEhl/z772tmcnIcpfa/F6IxOcmLWc6+6W7d+RLCg
         w/Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786592463; x=1787197263; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KGNqgcuWPSyLSxhZ6HvJxhNYRieQ49SCRyUh0hq1fDw=;
        b=fzJe6LdDAHCuOOen4AkfHRsMy3EwDZfFW0QIGdze8sdEzctJHbmxFalbj80Y8dleWX
         3UUmVust8DHJrCtnFWl1GnVC4d7POz9pyspy2EUGTixNoIlZWyk6Pv/iHNYU6nTr/cWp
         29VhdtucWlR24q94AmhvclmBvl97Z5BI1KEd1tdzsxnvKu2LVn/K9GRi5qkhFDSIz/sP
         9i9s3UVPeA7SK9vboCTKSNQ+oUxVidBp6CFwHbCBm3/bJrE4kKeryNRt+U4mtZQrFkLO
         M6F24OmEcjYHZ9nugjXpwCx+TpzuOr6ErsRwmWoJnibtqt8umwWBD2eY1+tgWY4pIPc/
         LREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786592463; x=1787197263;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KGNqgcuWPSyLSxhZ6HvJxhNYRieQ49SCRyUh0hq1fDw=;
        b=g6z+JMsy//nCQYop63tKiUR2rU8Mtx2bIsjnD2c+BRO8GSviN8UU+IvTSvE7p25fmk
         6GADJl+Z8TBmOJMZjqq7nzMPxzGCaNNTaZ/ujZa4G42YC3/95969r133JmuekWFeYFRU
         EYG8HasRuScyRDNkY739erUDEh9uI9su9VVkFS6naNi3cvWq9ME7eOauaZZ0vGE9XfIh
         iFpeUx/CxYUDZGIMW9agGH7j1ywM668dUczRFCQ1kjnVBxskMFH1kxbDmpVOHKMwS6DP
         z0z+VizlU/Q3BRUG+Mwg02GEw99U+WlVqz9Q8CaijGggvSSNdY8X/YjYCvSNYaqET3OF
         0W+w==
X-Gm-Message-State: AOJu0YxlKzHrCuk4K/WlmLdj9r9gapdJBQsVx361CbFCCHnd6MjL4eVO
	pqx5+/5dxfCPx5HMAJpNpnFPjSO80R6mleks1SeKjUpkrTCI8NDYbLK7VbB6SbWRWaEoUbQ6c3j
	Sj0HfaU8ec8dUxPGF2nvrCEe99UGCkak=
X-Gm-Gg: AR+sD11mkq7tEya/LIyovGS9rLH804Iz3ESJf5RztogYX8CrBIKP1OlVVHmXRbPqub0
	b6zekMElWGLUeP4DnOA95ZkusDy0YjGF221o7xxKXlTvdHjfVyVRF/trygTa8ak1S4YWA1O1i4f
	hUAfzEYE4WnJ8FvOyBVxa2xBNefFV4szDwmGoEseOFAdCk1muKdvu3OWStIJDtxEbcC/BCoq1y2
	nEJr0I6SdoDVXg0Wx3rNm3W7YAhmG16dpwcr5+nUtEE/VEMEZ3+8gqhFSMsybA0gNBrk+e0m8Ea
	O6AKqhinqd1LxvnidnD03ouiziFtdwPTeMVgLGTIV4Q=
X-Received: by 2002:a05:6512:65c9:10b0:5aa:671d:9960 with SMTP id
 2adb3069b0e04-5b453f3a290mr198295e87.6.1786592462622; Wed, 12 Aug 2026
 20:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803112218.3361213-1-dingning04@gmail.com>
 <20260803112218.3361213-5-dingning04@gmail.com> <DKNGPMSHGC89.1WT6CHDFCPRJR@gmail.com>
In-Reply-To: <DKNGPMSHGC89.1WT6CHDFCPRJR@gmail.com>
From: Ning Ding <dingning04@gmail.com>
Date: Wed, 12 Aug 2026 20:40:51 -0700
X-Gm-Features: AUfX_mzFUfYUhn8CtVXH-132owRD1GihhiMHZXa7_zmjDSR98AiJaHY2mSy0pJI
Message-ID: <CAJP4iutYA3fcAb5V0Hmc_MDu1=Tk9NuRzDy+NuD9k4N3L8OoQg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 4/4] selftests/bpf: Test untrusted allocated-object pointers
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, greg@kroah.com, sashiko-bot@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	Viktor Malik <vmalik@redhat.com>, Justin Suess <utilityemal77@gmail.com>, 
	Kaitao Cheng <chengkaitao@kylinos.cn>, Leon Hwang <leon.hwang@linux.dev>, 
	Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Please respin and only send patches after you have tested them properly.
>
> The right fix might be to use fentry.s for these tests to trigger untrusted
> marking of pointers. The fixes themselves do make sense.
>
> For the next version, target bpf-next and drop Cc: stable.

Ah I see, I forgot that tc programs are non-sleepable. Will apply the
fixes soon, thanks!
