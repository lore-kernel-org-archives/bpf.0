Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD931064B
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474008; cv=pass; b=nyPYv5RYHSqwiY8CNrc5LgwAmoTrLvkot7lS6W4DFQfo28LsVhDTmPImsb+8XoqbvmSGdwZWnBw9Y/eiCJeLaKc3FP1LTq1Lg16ACOPL4NZGaE/YyL1SWpbJk++j1hE7Kx+ROuuG3uMFrIMvd59uvjoK0Oe+ZfUk/mDyrPJE7qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474008; c=relaxed/simple;
	bh=oynyw7lcIZ5xObe+aDx2HP+H0gU8ruT/dxDQxLDEOM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMiXWvfgmhG/IaOf+m4T44ME4ip8voAROMuhJTxofN/c+dO1gmHXs9Tz+DK8+yiXbtZaPalY+eYIoUSwXcvoxUrrE7nhJkeXor9/5c6Qrxe9a1yb0uEXq9HIEwM0w9axm+hcieUeN6Z6liRcBKSJrDhLs8wW5tO1NdII9JII8nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haeB1c6L; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haeB1c6L"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3516698f8f.2
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 09:53:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772474006; cv=none;
        d=google.com; s=arc-20240605;
        b=D8ikDGjLNVeFO8Gt1dBQv0VS/vDK+Ja4QtmNnrJ1dpFrwuQIWK0QmwbUgUtA3Tzenw
         2iKW1vR5X4rsSGPXv70KF3VujuYWztS1hpwWk/p5lZQKzDUX12OIj+MKuaDzB+nmI1x0
         W1WU+EMNFL5nkRD0oxx+9BNhsgZoHoXSpSTpKc9nMwLmEI5kscK2sqgtFzoAGYI6abZE
         IxekDnfBcFulh50kzuATmegoEoPbxDzRM9+iGa7F3btjSJ6YNfBLyuzSt6G2/kxkAyl8
         wgr7th90DuOMr0wckL5sG+8mwJSa2GM1kc12mPThHHxeVVcNPucZIqsokoqwblQO+3lj
         mL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oynyw7lcIZ5xObe+aDx2HP+H0gU8ruT/dxDQxLDEOM0=;
        fh=C7hx2QiHYx4QDv7bmLxXYpk4lo5UHBxSOO5ODO31GzA=;
        b=EfVTjUJE1qGyIIn7ZDwNXDRGmFWrUEta7WvquhCKjqMfJzPOgoXifJ76SF7+uhJcdG
         kId8L8HMJQXRDQ3m05boS5XJwM5enC5DQYgdCt8h6tKNK2ewYWJrW2n53ATI5tDv+3gZ
         oWpOdJ3XKl5dypqGiZcdA2ztB5VWKhPIgef/UsWhdDvOC57qaWfnvGANzXRjK2/phArQ
         zZqzCMVFrWxicmshRtjH4XhRRMlhmSRQ4WL3noTg8LTagWCKKfVMnplAlDfN4ngbEkn2
         UdVCjltMIvcZ7qOFtGbQCuisRLtK3AIQ3L5SyMXBdQ3XVQj6KNWXHMNvGRpS+Y6LVoem
         VXCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772474006; x=1773078806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oynyw7lcIZ5xObe+aDx2HP+H0gU8ruT/dxDQxLDEOM0=;
        b=haeB1c6LWWur6RrHJmmWJnI1dtZ6X0l9Bu1tADV19MKat8QseAiRPl0KRFjAjbpQp4
         m53g4GVx5MpRnZrJpN76xxfYuEePFhPR44wJKC/0HnbjZJJ5EeRAytvGGB0P3UYdp1Xz
         RlM+C8+q+zugtTNCsW0lqiUxzJfYs7Ee8OnZNAOCQqiu7F/fdKFRpjMHzdw2XMvCz8oZ
         Lxa429v19nDb/SmCQXI8kIegV16ObTwPGuO0LEhhv460GyG4/CssQXo0J8E9lGA9oObo
         c2KbmZBgpA9ZNpa+c4OJaRWZZEv1IpE7Ry/IK9PUK+WQn3VvjxsyPPdqxJ9GQf+NFu0S
         N0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772474006; x=1773078806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oynyw7lcIZ5xObe+aDx2HP+H0gU8ruT/dxDQxLDEOM0=;
        b=ZyGhzWJPnjb9FboKqSX0hpimKyJlGHHHuBN+D5m+hjno3hPkmCb2S4nHwLuVNle2rB
         GnhsscCLzN8LSA+WAniH6N3XyrzmGpka9RlyyozkzrDFiem+EtLm90LXVZbp+u5adRQ1
         xvUmTj1qtTP8F/WUtap+lKiTC4VgnG5v31uqAvlBXR5z2xE26Tjj6PXmmxXct89aeIQV
         /v5v3WJQV0XUcNS2Q2TaSGrCPgVK9+W8vxmI2Mt5P5muC7OPYPPaYsQ7C3uo1HYSooGZ
         PyCGR2AIZ3JF3WlqT9ZSfgOcgansQi4ciJHvpkSQ8TzNUOI3AVdd1vNqchSu1J8382UL
         ZUxA==
X-Forwarded-Encrypted: i=1; AJvYcCUlwmLf+A2Uv7BKKie7Ne23mUn9UvM/mwFx4JRNzvv3HkqUHbd8yiHzk7BEechuwmxsmBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHI9lRCJr5kgVXA+ijDan8bprP38mcSFuAHiWJQ26KTq7Vj4p5
	3hByHa4NiD4HreigOdEpkS65iALIX8FuqPHcBfGWi/tKWuEgOljzFKdCBVhyqMh0AJmCVOiy1kg
	HDtkzxiuYAfAdAlMZOuqOI/xxeJruvcE=
X-Gm-Gg: ATEYQzyeXJA/PZCVH1dBZI4j6SisxgjeGEjKHtvF1y547aVFqUl/0DZyKn4UegoMtpn
	V3Ca/coepWkfnwRHZjCKseaIQsvLKqjPOBUAIJiyCczkK1ZPGbv/8cLBd5NJKW5WTsghRndokQk
	37c8s5B3VvyZ2NDLzmld8SkP56jnC80ogll+vzf1cdqC6JvxrdtQgYMUlHYZZMcCc6TDpLaUP5U
	9OBERdX1DAy7/C6NXseurKyAWHVUt7/vsHDKaVF14V+HvSiglV5LS3sO5jw69sq4kz/bwIZPt30
	FokFUBRYKvGY6Q7l2OifiOqmMOSUxoZrwsN/H1k8aPJ6WrmQ0ZEzfri5qlnDtUsl0BDyXpyIr4l
	tysZ2iA==
X-Received: by 2002:a5d:440e:0:b0:439:ac98:7520 with SMTP id
 ffacd0b85a97d-439ac9875camr10630519f8f.37.1772474005867; Mon, 02 Mar 2026
 09:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302081622.165713-1-jolsa@kernel.org> <CAADnVQKBx71HOwVcRFj7ja+y_NL83rpKQ0BRcismOwdCNx6pbA@mail.gmail.com>
 <20260302124755.4ff16264@gandalf.local.home>
In-Reply-To: <20260302124755.4ff16264@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Mar 2026 09:53:12 -0800
X-Gm-Features: AaiRm50oFCeMqWDjRaaels5ZujM2CrG2K_lxFfYLspEAPuE4HMm6GAwzq8uSE-o
Message-ID: <CAADnVQLXBfd-U5Teqv7vd+EFNX6cT4KxA-oiiCZx4aPNrme70g@mail.gmail.com>
Subject: Re: [PATCH bpf] ftrace: Add missing ftrace_lock to update_ftrace_direct_add/del
To: Steven Rostedt <rostedt@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 9:47=E2=80=AFAM Steven Rostedt <rostedt@kernel.org> =
wrote:
>
> On Mon, 2 Mar 2026 07:58:11 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > Steven,
> > should it land through ftrace tree?
>
> I added my review by tag. It's small enough that you can take it through
> your tree.

Ok. Applied.
