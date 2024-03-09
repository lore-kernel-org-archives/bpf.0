Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E415AF
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946010; cv=none; b=B0sNuV3YWX61Sx/yifmRwh/1jCrCY9ijZBrI4c0rZZHJUpGoaU3UqVI/4U7fpCded/yk6OCyGSgZjmzj7mrHUsCeZZ/T/d0PskgFAtIboyzlf2ub9szO5tRO9dTAfP6PNZBkQ4z97fCTeWewMx2VmtoCZU+PrANLDVMQVWWYtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946010; c=relaxed/simple;
	bh=9j3QuuDm3nVltLN8KwysnK1OYgHpJiIhXrkPBs6xQ2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e21L/ZI19ouOzyd2uenkulGXUpA5NjHe4N9jwrnDRs5uM/PDKmy/LPXxKCyprRxtcVuz72Uwg1AK0gtALOsW2tEgukQDkpKsnKMQNDrvGWPzuy4l71vluvjPeAwBVvJEZ/tEtUqBL9uPSWKdmEFddVJWVYdpGwxo//yuVWvRgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIymAKM+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIymAKM+"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a456ab934eeso379747266b.0
        for <bpf@vger.kernel.org>; Fri, 08 Mar 2024 17:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709946004; x=1710550804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+39JzJdPMOse6Ap73XwBX2okQdFUO73zLTPO3/9pYzs=;
        b=TIymAKM+y12c8cvEWqFAQy949BpjSAiJMEgCmalTtN00VKqqw5KUI2utw73Fjk9PWR
         aLvlQKu8AhhF0ZRwgCVA+FqKDBTgyhTFsJybwbICQRQN+7pDxkOXbnXfIIvvCZLU8/Pg
         75OkwIY/9z/PIChsPPC5dGbsuANUDvd+tjTUvt+p2BGoUpZdEx6e5bdaeo7PuowF0pdB
         z6URLyiXBy1v+E53sr0eoPE3QX4jQ6mFKVHTftcltunSND8ZCjO4udR5X3bMqggiHxGI
         pEqEf7Q906Q6Gugpx+7VDwpd+0meifirb3WmB+x2Wr7oHjfmatPoWcdJw0RjEcF4oM5c
         E0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709946004; x=1710550804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+39JzJdPMOse6Ap73XwBX2okQdFUO73zLTPO3/9pYzs=;
        b=Ib7BKZcvZ1RlYVudTbSS20wA2wuGnoJ2pmS03WtmNDP5BTB9Gdz654mV6KscRDskyN
         kVaw3XsWYGg/fCYk+OF0v9lKqPTuYIUvCITkCX6udqF++kmdk/rvU3qy1SW8GuokZsTN
         jLa0PqPuMh6dlrWe9tVaVEvJNT09N8J4Hnwv8JAlrFGgUH9qFCKiKNja1swPVK6MKlMs
         riPvyEN6vE90qzWkV+45zZuGmXnnW6ndQfS9StA3GuIaEY+2nH+vxW8A1UVJpPltmr7p
         rIZ5pEywrU8BXKCoYf7HFTNcLAqm63cR2VhEWE41doVK4Lm6VTVELGav1ZNTMzaTQpqF
         PE0Q==
X-Gm-Message-State: AOJu0Yy1trrZ0jHcNcwwKgoj99zJLDYeK5C3xnjNe9DAd4daA8Gr+b2N
	W3JZVH6ewyK16OCyZaMAYVES5elYie0isJYuQ4z23e/ZVyfFRMT2jREBs1Kq4Ej8KoI5all4Ha7
	kDfvxYlv5I3F+RQkiV8AhESmOeOo=
X-Google-Smtp-Source: AGHT+IEItwexlP6QgVZEXbYmmAaforfyMTD254BSLAXrMXfkclr5zF92EQGyQsEgBIDzAJ8b+naVD5jJZ9LILIUJsB8=
X-Received: by 2002:a17:906:360d:b0:a45:f4d9:d911 with SMTP id
 q13-20020a170906360d00b00a45f4d9d911mr163573ejb.34.1709946003596; Fri, 08 Mar
 2024 17:00:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305202155.3890667-1-yonghong.song@linux.dev> <20240305202201.3891042-1-yonghong.song@linux.dev>
In-Reply-To: <20240305202201.3891042-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Mar 2024 16:59:49 -0800
Message-ID: <CAEf4BzYXwKsmbj2D38DNsoi_gb-VLN1+2xXR9SqyPB6wN=S81A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/5] bpf: Add link support for sk_msg prog
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:22=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Add link support for sk_msg program. This will make user space
> easy to manage as most common used programs have alrady have
> link support.

So we have:

SEC("sk_skb/stream_parser") mapping to SK_SKB/BPF_SK_SKB_STREAM_PARSER.
SEC("sk_skb/stream_verdict") mapping to SK_SKB/BPF_SK_SKB_STREAM_VERDICT.
SEC("sk_msg") mapping to SK_MSG/BPF_SK_MSG_VERDICT.

Are those all kind of in the same category and should we support link
for both SK_MSG and SK_SKB? I'm not too familiar, maybe John or
someone else can clarify.

>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h            |  13 +++
>  include/uapi/linux/bpf.h       |   5 ++
>  kernel/bpf/syscall.c           |   3 +
>  net/core/skmsg.c               | 153 +++++++++++++++++++++++++++++++++
>  net/core/sock_map.c            |   6 +-
>  tools/include/uapi/linux/bpf.h |   5 ++
>  6 files changed, 181 insertions(+), 4 deletions(-)
>

[...]
