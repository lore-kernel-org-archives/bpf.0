Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD422075
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738155; cv=none; b=IwIDRVtyqmiKyFrXmyvi8s4vlAcyA+Talqtim/Xzyy9EkC/zeajOLlW2wu8WddI+nKmzf8b+Ynj45i3vQ7rc4MgzSE8Ay9jF1GQqtBFkCL/a2aehKm4OrxPnkwqMWoA+x41BXgoeKqv3GRpine9YpOnvMLIiUnyiddi5qkIjdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738155; c=relaxed/simple;
	bh=RnbVGwrIGtvTMkY4JiMpmEIzubKUYzOp5C7V6b660o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqB9de4//UzOrhR9tyNcH2oNITkmNU18mkpbJU5EFn4fFk+7in8sG3/hDjJjd5wtDW1t6wYQFvX0BVlVWcIqKcytPkD0+p9vdFRN4NaxO9R82AZmCzS+K3xMXz5swlj4HWFHmlSuHxtUZgv0OlPVkrbom+XpfPif4Ya4NqFTIvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9tY3xMw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9tY3xMw"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34005b5927eso1540928f8f.1
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711738152; x=1712342952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnbVGwrIGtvTMkY4JiMpmEIzubKUYzOp5C7V6b660o8=;
        b=f9tY3xMwAO3dipMPFJ+ebNIVPqV4DEjJf90omkV4fodCu0RPFZ1aZsyYV7pKMrZESh
         xeu7GaaOQlDOUA0GqvUWDjtqkvJI1T5KzPiq/ldYP70tPO03JRWFbYTodiihlc4Gu92A
         Ol0pv1vRhrz85D+vq9gguycfY+Gl3TVao3j0hkZjsfvuNEskPFb8jMgqvdokUM1UsjnQ
         inmpwg5azBmBS8IgM2cjMKZxievmBopMvuOF72Jv4aS7QkWw3/6gI4dJPFtSx+T1goe1
         ceIl71QrNpzIInRl8zLxiwaw6gbY0mtIGOYwqYM6jQvAT77DXzjz/4KHFkgmjgKF9GjG
         eVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711738152; x=1712342952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnbVGwrIGtvTMkY4JiMpmEIzubKUYzOp5C7V6b660o8=;
        b=xMyKNouHo06B1uA1KnYZfBlOxgoCPD7axn2tDyxnn+3guWOeaylweleuWf1uomxMPt
         p0KVWs8bNgPAH7H8HhVatEc+w10tRzpNm3rvwJTbxOLg1yF2qYCCWUJJ9CeUJD8FaQ/B
         H52G7ptSiYCF7HxHGlHcb9Dhxvt3fKD83XlmlCv4I7fcrhbDaGPdYsao3S/dyvh7PhJP
         bSVAcKu+GS2pq6DBF6sBA3LNR/ifku98ujipBjc7uq8Xt4qguobxrkkGla6Forts5Mai
         OOWI/jWCXRwm+uo4KskE7F7X7vezKPyUbAGTGVAadaxCWUsFPvHZI6wLHCl4+8QcqhzY
         LOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZk9UVxq2isS/ddh33tTwedK2pzxSIjLGTdGs6IG6Q7jIk0GxW8dzd87avfZflz0Fp/Pvk6hDku9hTQ2wub3SOhsFN
X-Gm-Message-State: AOJu0YxDybkTQX0z/0xO6cW5/2vQ/cIms09ZG+uK2f6WLQ8SGujaLHKe
	5wuuxN+Gkg7GcV1Z+lCmDLXBgh1mmGhVr5RqIIfeH3Mi3WSKAQUOm9WB31zr8RpdxhEGZr/1nRB
	Bj0Mo9GdoV2szA9FeKLh+4E3L9Pw=
X-Google-Smtp-Source: AGHT+IFrTIujFFMIiV3YJAO7PeOb88jaATJO0tIDTCWAya7QzQae2F9RowdQVzaKr9Zx53PcqavCTf5LLpuzQhIddqE=
X-Received: by 2002:adf:ce88:0:b0:33e:3d3c:46f0 with SMTP id
 r8-20020adfce88000000b0033e3d3c46f0mr1864469wrn.0.1711738152616; Fri, 29 Mar
 2024 11:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222085232.62483-1-hffilwlqm@gmail.com> <20240222085232.62483-2-hffilwlqm@gmail.com>
 <8a3111a0-b190-437f-979e-393f0c890bf1@huawei.com> <1fdb4ba0-5b91-419a-960c-a26de0e51c25@gmail.com>
 <CAADnVQ+yzkAxCK=L9qVUzSEmj72CH=9kqe25=Risj_BdaLDA=A@mail.gmail.com>
 <c43e82e2-7a23-44fc-b841-b3ace7dc6bcf@gmail.com> <CAADnVQ+Fr0k+28L=BLaXDxu=wDBwpiuCaXzEN3y6jEXj48zhUg@mail.gmail.com>
 <c5d7fcbf-a798-4c2d-8978-7c19ae7eafa3@gmail.com>
In-Reply-To: <c5d7fcbf-a798-4c2d-8978-7c19ae7eafa3@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 11:49:01 -0700
Message-ID: <CAADnVQKUja_RBsmC+jKj0+W6s98iDQA=uNO+zjbAX6-REF2NHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Pu Lehui <pulehui@huawei.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 6:31=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> Here's another alternative approach. Like this PATCH v2, it's ok to
> initialise tcc as MAX_TAIL_CALL_CNT, and then decrement it when tailcall
> happens. This approach does same with this PATCH v2, and passes all
> selftests.
>
> Here's the diff:

before this thread falls through the cracks...

Please never post a relative diff from some patch that
was in some thread. Always post a diff against the latest bpf or bpf-next
_and_ submit it to the list as a full patch with your SOB, etc
so that CI can test it and maintainers can review it.
When the diff is not in patchwork it will be lost.
