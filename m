Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983830F526
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762900; cv=pass; b=TV9gbRmtAzy/4VHRgNi42HWRuLFQ4EWBrQq9jWh2DwBVlqBO1sS9W/rouQn104/OeWHg1aAWQoStiXRPWQUFqiFp7HDnsx6yZbuIHAHNgx5enOnrn44qKsaq4hbYBoU83h7jBkLREtL9+iIEx6SakZlI2uTDMH4db7GB3wy/61c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762900; c=relaxed/simple;
	bh=/Uki9RsKdjh0Yx5MYD7ET7E2uUAT8r6JDmpn2OGZ5ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C++SnME6j1IytVopQp9o4MvbyuJPfRlC1lpNFF58ijZcS0n2mOGj3SqNeR8lU09iIH7YKt2hrpoNuf+yo/kPmavK7AN7H5hNU6h0eWwP69Xgt/QTwiwqnhFFHwVLIpHlUzntwI0bfgl/XkDmnMaIhaKAqFLB2l3qB+yICRuFFZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9KamQkJ; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9KamQkJ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ad9238d8fso8580027d50.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 18:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772762898; cv=none;
        d=google.com; s=arc-20240605;
        b=IcRRAPSl0MUE46yinQAXU0WNg8I6nh1x79xDX9MEwgDGImodgoAMkhF3Wwbzz9iJm8
         +Wfx+jkkpLiouj82LUs8gJ/7JCE+D2SxpcyDQ5XC5Z7cvFENCPIsFsYCD3O6UuLxIyhT
         XnnWKyjqeiM0THVMPbVxxWVyTN+3lp4VrfPTfmYeAEL7D9pWpnzSaCB76II3G9UwH5NG
         gPczWPaX0RcuX5ZqN8LOHdeYd5jJrHTcfN9q61Ov6TEkIdSNrLEQAqbKa1Zb5x7Y5AXk
         gErTZs8zWgCLKlnu7MISGQTQ5WioJBey7W7g6B67KTONi4dNDaaPQztEOUZDpbg6n37R
         kQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Uki9RsKdjh0Yx5MYD7ET7E2uUAT8r6JDmpn2OGZ5ws=;
        fh=WYbGtvxB+E69PKOCfB6mhLldlF1yFZJRHUivRg2LdU8=;
        b=YMyzqcOjAd2Gt9Z19TifbkSB7NmzGWl9dVkUhliLEChkHg4HxqqufqPWIQbc29qmz6
         dZfBWe1NV/3MamCxfnATcERmli7LQ8fvx0VdQOtuWQO/Yy5VhTX5kiXfVFkjEDOrIA3L
         Pf0j4tVcT6JMNyNB61DI2IG+zDYxeYQH1fIHcJyVJdre1FECaeZQMiF87fxZXoPhQ8s6
         VUZd2tPtTkYEaePkkpY4rEZVL+OWI9rxLYF5pPERPiLcyx0pShpdR5YY+yqIYf5pFG7n
         uaXtO8ji0PlCxPIniAtjoKAi8rkU5fvPpgNXnPUS/zsyPgLic/MExqiOdjZM72KUZrDr
         LVfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772762898; x=1773367698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Uki9RsKdjh0Yx5MYD7ET7E2uUAT8r6JDmpn2OGZ5ws=;
        b=D9KamQkJzxVp5OWhPai0/1n5H2348UX7/msn5iG9HUgApWIeRwg4yevNhNnSG27pQd
         8PI93Z922NtwV7SGXTtKpKyzWVFiETCHOCPK96bY1t+/zCJWdZSgRTlZSXISPyUlKjK0
         udQG6U2L6dN8lk/Ufw0sDtj2qiTstu7StPYPSQAhQUOI8ikpR28Eovi4BUsJN8JJlwjU
         wnDpuHpIFLHZFDiSUhoRAu5DYH3p0fhZC0Q4adeUA9RmRIn2COQPuetyaxhbRq1SCOB9
         SM9jk6baHOU1Ml/tdcQQy0izT+9Z5AgAYO8brJvi4tnGj9zb/pM46nmnYGKBPgGspSIS
         ggag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772762898; x=1773367698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Uki9RsKdjh0Yx5MYD7ET7E2uUAT8r6JDmpn2OGZ5ws=;
        b=CwzGjj+iEdISkWSlF5W4SMh+46Sva+Ajxj6Tk8jHQst1DqJMzp0Bd8CLN90ssy+9fi
         j0Na5ZdDvDgQOsnxNFnl5OCSA7ddN7eQ4COE+suRMuxdi5BBumv+yMJbRKOsaRaN3ZFv
         N51DuPR/aHusD7a/MQ4myJcNqCJVduYhHaNC/ycSco4yeGMInTiXzjik5IGS+lV/OYMQ
         9XcY8xxhU+gO9n4/ijU1FHq3Y+TeS9eh4yQ8nzm++0QLloqu5zmlOVfbfe5CrYWopeel
         nE9vftdxp40e9rvXedUuLTobU4bJJlqhzSdd1zZYjMN46Dn4rKfZWvcphe9Y5HXrz+nY
         FbAA==
X-Forwarded-Encrypted: i=1; AJvYcCW7oLgS3ecrEQVotA6QVtjtvN+nSNxhr/6abdW7d07FR5ldAbRtOy+mmK9spfi9PLItRZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz969W5Szso6eJiIDhU4FwCqr8WSg/olGTlrfjQLh42SetuCZbn
	rnRoib/loxfsOjMYwNzyQSQCgOu6JvhnbVYE4QA9xRJvUIRjt5OocK4K6AeHw3DZOojpLjUACEM
	QMTPR5oe236l5vgxLmHL3naZhhMmBzRE=
X-Gm-Gg: ATEYQzyVqHq9lVDsbYjSIeNRcPE8LqmHjjKVPCPmb08/4htzTzuCcUdisi701qrhwH7
	Ns/JtXhBoa8nojn29WfysY8HhbcpIipaz5QXNkQBA2JE3dk4DiI4ZeNdJfbNckASuiMxdcHo5II
	drFGBoQu0c8WkTNnEdg9Wtb/CAub2Hj3MWTvyYv0LrprHMO4+vk5iQobAiIiBqL7Gw3zj4VnsJ+
	itDichJaov/qrzW0X/R615azLVtoFXAprER2FbkMRqR357ngMFtnouduCTqUV3C7CXR3caTTxG8
	hqaVLlWU
X-Received: by 2002:a53:b191:0:b0:64c:b68a:f519 with SMTP id
 956f58d0204a3-64d14397896mr464727d50.80.1772762898553; Thu, 05 Mar 2026
 18:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302071434.311395-1-sun.jian.kdev@gmail.com>
 <aagWYyrrwUt-poL1@mail.gmail.com> <CABFUUZEdbCMrNyp4kEO7A4KZPn5TKi48+tQvaaYaYuJj5FQ7gA@mail.gmail.com>
 <CAADnVQJfDYiBHa4f3p_7MpURE_a33+atRbjbcpZ0VmrKFaKkqA@mail.gmail.com>
In-Reply-To: <CAADnVQJfDYiBHa4f3p_7MpURE_a33+atRbjbcpZ0VmrKFaKkqA@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 6 Mar 2026 10:08:08 +0800
X-Gm-Features: AaiRm506lW5sZ0vhaSfvVU0rEwcX9rsPKby9YutJ4fCIZJpsj4LuhVd5BCEEaHs
Message-ID: <CABFUUZHv2a0ky84aUKcqvH3o8x=5jpUtZMW=SrrNiD392e0sQA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: skip verif_scale_pyperf600 on -E2BIG jump
 complexity limit
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 9:14=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> It's been failing for too long.
> Pls do a minimal change to its source to workaround this 8k limit.

Will do, sending v2.
