Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D982358396
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388209; cv=pass; b=JG3JLgqhSG5j9wGTE9FiKQc+TXc64D5NWaRMTLqB9JFZFaDk2echa3W2koy2izkZBbPxd+L+kyPDlxVo1IzY1Y36ISdLTJFklCiIgjE5v6i5yJkBLt58caIptly7qSTUMYpGaSI0/+3VXdEZ9L/IKeYizAQcW3gCpvP8l01937c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388209; c=relaxed/simple;
	bh=vlrlytlNu1wye5qpQ7gugL+NMTtr12p+A2DZcW6JqPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbySIXGx/Nx8CF2WAOwu1RwcPB03M2AHe0Pq9c7/PcVD9RaYrmJI2apnExX250JFc8DrjKPNXSJJb0VyG71d65FHIADRoOw/vKoRzX0Ds5aiF6BanmK+g2ka+W6rS9YhqMRVBY8tBDabFjBNRHrhW+8DFs2kt9KjwLQ6Sx6AUWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJv4QQE+; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJv4QQE+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48374014a77so58237675e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774388207; cv=none;
        d=google.com; s=arc-20240605;
        b=E7C/z+Mq3F0RgpgQIhlieXFR0EHTpH6JZqW3+tJ5mPBFtFva4f8tDwrLEHZMh/jZ/V
         cRBdvsRLxaur1VlvuTyIbYdtrjSH+UoX6ZPd4qjsZJ5PhcMAmwD1AU90eEItQ2IO71Vu
         G/kFVZt0F0X9hWJpOxsjlt+shyQ7EYMJrR7AJJECTdCxQqTv10zwM8YC+T/FFYsYzY6l
         6pL/9zgJEKg7YuL0zOpAxHx8pkuDpJGBA0G53iiwWJGABbyzGILwPVA18ao2asiu28S3
         1sh6UqPpoWMmbL6pn4VHpoR34jnY+gWs9lbfyczdgEtvQgN6Csd8ubIqShme9wO4nkju
         mNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vlrlytlNu1wye5qpQ7gugL+NMTtr12p+A2DZcW6JqPg=;
        fh=Oa7Gari/rueNAjFDVGboR0MAARQL1sjQKT8qWh1MOdg=;
        b=RFcxKwDHNXO2XWfaljzZaYbNv/L1gxr9IwKaSXh72ybywm1hHRdbc6ogU/bbnM5jWV
         HzJbSoJjgCGPmItJyJ5e5/wcBtX4uQ0OMd6bDzW0TdIkfMCxOZhqvK68lvkdWdW3YvWo
         2HaOJKSocQ72CJqOqABhZj7qkXvOuQRv/SwIXZbFO+KqE19ZwHwEarcNxekJL/WpF4J6
         D5IgI6LuBoRibWuak4I+9OJx/0gCgESOxFNHG6TE/S+wnzxsQMZECpPk8TVuWq583kM4
         UNT+dCTwsAaoLzKlogC1ps6F+aWAwj1Pp2qwKKyI4YWm4l+aT8mF4+EvCgPX6uS74B5l
         344g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774388207; x=1774993007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlrlytlNu1wye5qpQ7gugL+NMTtr12p+A2DZcW6JqPg=;
        b=sJv4QQE+MuFrG6+VbhVoXzwHnnseXfI1GxpIUXD0oGGFi87HUSPId9C+3W9gJLHW0J
         LEyM6N2Pf8g8/hCkMklHdvfUzldqmjZgtOMIuyDyq8dl9tTco1AElLgKQCvrO0Xte731
         Lk7dPftlLYliu20HpZteQmJ1DTS1g0cxN8b7SfhlO2LCONUh1fVM7yM3QxdzFmBuognh
         feJPvAAMmji0JURMbldT31TSHM6RSUxTJ8OZ0opuiUiihtrrDQucn+dvNRjZcITxA4lQ
         d0K97EcrHz7FVNF+F40AJ1hkU3VhkGi/w2FbT4jDU1X+QhTo9/kMDjl+2dMoyXDilLe3
         a2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774388207; x=1774993007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlrlytlNu1wye5qpQ7gugL+NMTtr12p+A2DZcW6JqPg=;
        b=KhInMYCTY2Dz5nBGCBuv8sgOQGX297ljg9oXXzdb9F+UxC5jh6qoGueYdOVXNgb/ao
         isU/NTbOMiIubYWpwQfRNTIIAxnZ8eDeUrQ0R6MW5aPzCFzU2GVkudXtS6zDFuu3dhsF
         Xk0njWgY/EbFlEvYNtXvC+XgTnJPAgcKZ6sYmbQVmJue0h8H7ugo2JFTjGaTpy0DICGx
         BXMOWkYWQT12Sm2/9pyCGsgpI9LzceJXoZ/JBUO6AqnRNEgIT1nBYEzQJwQWwgpIhlhT
         3HVrYfKUA90HkVv2pB8iYGT0cRdIbFboAEsg2jsUj8rBkWH9eRvhyZ4l7SybsDFNdAOf
         t9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWWq86HEOLccJitmWTy7Y3UV0m/x+z6Fp6flxNDb7O+WRrPvF5+Ij0GNfTWvZsQQQ3W1qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0lJXKVtYs3jl89sve670RvpkDBN/2IH95vFqu312oV2izQdJk
	J0WpNW0GFLQ+ctCo5B2TGY3jUp4bvxc+Y/5moCZ1l51CilCXT6Yzvq86oFYpRio4uHexWzfAIle
	9pkF8VbWExswBDhE3+jZ6msc6VTPMhSk=
X-Gm-Gg: ATEYQzyCe/2lb1WTOzR44DEmeebbVkzYMmQTVT/s8tspEBxIi48mDJtYMNhGXpi23gq
	HFt5+bJOZUdmxRzpaFTOheiNZsm0w6KNmv404BOQQcthmUd6pBBc/dEp/rJz+riH4nqVSZhQt7f
	HZktbg1Z9DdG2LlplZfnog6kUzPkrGAgfqrNHQcbRAjGmuMuIz2UTlCkj2Yw/OgS9yzC2EiRNeX
	gNjXVPkzIWQwChA94U+qGzirPKzRPRfvHO7mmtc6Pc6oZs9W0T4qXDe3gE3XxGnpMnwP5dP+9ui
	Y1yWGal1LW8EfaOPJg8H/6A14dFmUp/LDNm8+pMkd6uVjkyhuh0n/Voi3DyihFCanw8jB2qrWdF
	aA6DDmQc96TnkwQCaxwsMJcoilQ==
X-Received: by 2002:a05:600c:8b2a:b0:486:ff92:63e5 with SMTP id
 5b1f17b1804b1-48715fc32admr17503485e9.6.1774388206411; Tue, 24 Mar 2026
 14:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320162336.166542-1-hao.sun@inf.ethz.ch> <177436741379.1084685.742970732574986773.git-patchwork-notify@kernel.org>
 <CAM=Ch04dJEf0_1+NeO1AJOBwKhQ5hcQsionMyyxuu1h7Nmj_pg@mail.gmail.com>
In-Reply-To: <CAM=Ch04dJEf0_1+NeO1AJOBwKhQ5hcQsionMyyxuu1h7Nmj_pg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 14:36:35 -0700
X-Gm-Features: AQROBzC7ciJVdP3TWhsd3NHAV8z1-OaaNhXHZ8JrAnZhqKbnWTG44im0PcV6ysI
Message-ID: <CAADnVQKAb-igkV-7htfqMxFhui+utF24T70pbeWd4mwcXWQ4pQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Simplify tnum_step()
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Hao Sun <sunhao.th@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 2:33=E2=80=AFPM Harishankar Vishwanathan
<harishankar.vishwanathan@gmail.com> wrote:
>
> On Tue, Mar 24, 2026 at 11:50=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.=
org> wrote:
> >
> > Hello:
> >
> > This patch was applied to bpf/bpf-next.git (master)
> > by Alexei Starovoitov <ast@kernel.org>:
>
> Hello, I see this was applied. Just a heads up that I still had a few
> concerns regarding the
> commit message and code style in my last reply. I think it was my
> mistake to include
> the Reviewed-by while still requesting changes.
>
> Hao, would you like to send a follow-up for those, or should I put one to=
gether?
>
> Or Alexei, do you think it is okay as is? If yes, we can just leave it be=
.

They read like nits to me.
New code is definitely cleaner.
As a follow up better craft a targeted selftest and explain
your points in selftest comments.
