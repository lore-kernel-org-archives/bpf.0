Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975B1E494
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337286; cv=none; b=m7g/xmW9SY+0x2MJW/ZDflfyXk6n5lktPWpnWMqMRRaRQONTTdEodW/wtRrOkirwVA7FerLAiSvPHgQ3+rz9f1QsDvJIQe5kh4It+YNbxJO6LhmuQ1e8j/zQekM0KP9jA5bX1VNXTqb9pmylm47BJkDK2Pm/cCorI9I7exw4Qvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337286; c=relaxed/simple;
	bh=EkTn7u0sYAeoa9bLdyb/dieFuxcJd6z2/oY9Xf732SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGT41BfCJl9oGt8lo83CXLahmD0LZ3D+oXYoyeUvwgSmPB6vYZHZGIkjdTZLI9K+NmiVwNq1E8N2NvW6Mxo530mzvCUw3PEFN+AjmV8x3zx9O7Q7pNLHJsgJpDRX2/FKIXAEYMpwTjMCgmgLRnL+61FNtPczWG6yb3Q6/iG1bqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=2CiJ1Ilm; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2CiJ1Ilm"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-617dfcf80aeso3956227b3.3
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712337283; x=1712942083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5w11nCTqm8J4qGiccVNrSRqUDMWKnAd7bql5yRn1SQM=;
        b=2CiJ1Ilml9coMeq5TgmmgiJv8+K9dafFBA9a+rt+pPoHonkCmz55M4HakrJbmVna7U
         DkJ15J1ymAGfmdGm7+4LCyFwnz7R5mOg6gt6ZPEJJALU+z+mtLpaKXuWPRt3Tge2mhRc
         2r12NpxtG5XAFHE8TwE5Xh0aqDfvP6FheaYPP94o6BMS8CzbAL/1tpNCxq1dKnDBwkDe
         bG4OSRgklq8UeU3YgD0+hPqoYsS0rur0HspaCCHJxO1UWA4MYnf5LueOKw33NkG6K3VC
         BgNcc5Gr44dDnInwBDU6//qfh2c/5ZRLn/PLwDHfgcU/L4Sxq3RJjPagzRF7M4NaSL+j
         b3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712337283; x=1712942083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5w11nCTqm8J4qGiccVNrSRqUDMWKnAd7bql5yRn1SQM=;
        b=nI/8kMhLquh+TanVq/F5xsewR5eW+wHGA50qgcYpYVUjM8FnBLbPtuDozCeE0CqR8t
         g/+RhF4YW8n/L1gZTHWM1XTwinU3u7ZgJyTp39hnQcUowzsBCyg+u6Vy4+MZBxC6hpo9
         pzM88E5UcDaHFyD/69BWs2x0k2KQ8BMFsu3yRiilBGtIolgEz3p/LOXW+dEg37bFJlQD
         QxmxPKDdRnKRZr/Hu9zMgYoOD106ZRTEAXyJZkAXYNyAP1JTH65KFInWaWYFpsmuf01g
         S9pXRKvuvZOJ+HDGRxlwwKCsuczyv9HYKXp93GK67HroVUkSVFHiCC5CjjvH9akomL0Y
         LSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmpcSAVTDv5AzcCgIg0hWw7bAqeVNqqH7DC8lKnrxMsg02IKG9sdo8nwPphKj2sJZVqWfOnvEEZXG79PZ03FIS7qks
X-Gm-Message-State: AOJu0YxTCl5E8mv2uqkYT+z8dEgZ/h7fvKEqT/LEkMBUIjPk6FCE/lMY
	9pgEbqTlq+/tM5r990f/NUKNTY2H7gSTC+/TeW/9x/G/OQzyqjXSePPufSGB+HEm4jwSuFFpDG2
	92JF5AoOhn6CU1edlYL1WqTPbSf5BH9i4WJWL
X-Google-Smtp-Source: AGHT+IFsONJN+PXLdXKVh9Slji3R+8eAgDnXMa9qUeh0+VWHzm9WNWcb3V4HreRbCGMYs/cVA/TmnI2kqH05/U+8ON8=
X-Received: by 2002:a25:900b:0:b0:dcc:d196:a573 with SMTP id
 s11-20020a25900b000000b00dccd196a573mr1998118ybl.36.1712337283481; Fri, 05
 Apr 2024 10:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122338.372945-1-jhs@mojatatu.com> <20240404122338.372945-15-jhs@mojatatu.com>
 <CAADnVQLw1FRkvYJX0=6WMDoR7rQaWSVPnparErh4soDtKjc73w@mail.gmail.com>
 <CAM0EoM=SyHR-f7z8YVRknXrUsKALgx96eH-hBudo40NyeaxuoA@mail.gmail.com>
 <CAADnVQLJ3iO73c7g0PG1Em9iM4W-n=7aanu_pc9O0t4XrG5Gwg@mail.gmail.com>
 <CAM0EoMn6Nyu5AKgSERZEtSojvzKN6r7enc7t313G9xBvq-bcog@mail.gmail.com> <db5fa77e-c179-d90c-f4f5-1f39a5a0f56d@iogearbox.net>
In-Reply-To: <db5fa77e-c179-d90c-f4f5-1f39a5a0f56d@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 5 Apr 2024 13:14:31 -0400
Message-ID: <CAM0EoMmGxQGA8LXWvRvgPHZd80r2mv6SB8P79v47tkbWhx7SXg@mail.gmail.com>
Subject: Re: [PATCH net-next v14 14/15] p4tc: add set of P4TC table kfuncs
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, khalidm@nvidia.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, victor@mojatatu.com, 
	Pedro Tammela <pctammela@mojatatu.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 11:51=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 4/5/24 1:16 AM, Jamal Hadi Salim wrote:
> > On Thu, Apr 4, 2024 at 7:05=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Thu, Apr 4, 2024 at 3:59=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> >>>
> >>> We will use ebpf/xdp/kfuncs whenever they make sense to us.
> >>
> >> In such case my Nack stands even if you drop this patch.
> >
> > We are not changing any ebpf code. I must have missed the memo that
> > stated you can control how people write or use ebpf.
> > The situation is this: Anybody can write kfuncs today. They can put
> > them in kernel modules - i am sure you designed it with that intent.
> > So what exactly are you objecting to that is ebpf related here?
>
> To be honest, this entire patchset is questionable from a design pov for
> the many reasons stated by various folks (including tc co-maintainers) in
> all the earlier discussions, but related to the BPF bits if someone else
> were trying to propose an interface on kfuncs which replicate to a larger
> extend BPF map APIs, the feedback would be similarly in that this should
> be attempted to generalize instead so that this is useful as a building
> block, esp given the goal is on SW datapath and not offloads, and the
> context specific pieces would reside in the p4tc code.

"questionable from a design pov" is the crux of the back and forth.
You have to live in a world where other people have different design
Povs, different use cases. You are imposing on us how it should be
done and according to you guys just because it runs in tc it is
inferior. In open source you work on your itches -  many use cases and
many designs. Given history on how far we bent over to try and reach a
compromise i have concluded we'll never satisfy you.
100% of the code is in the tc domain. It is touching zero of the ebpf code.
We are using kfuncs the way they are intended. You are not going to
stop people using kfuncs the way we did. Giving us advice on how to
better kfuncs is reasonable. Martin did that and we fixed those
issues. Trying to dictate whether we can use kfuncs or not is crossing
the line in particular given that you have said many times that kfuncs
dont even have to be even posted on the bpf mailing list. And i am not
going to relitigate some of the statements you made above that we have
rehashed many times. Read the cover letter.

cheers,
jamal
