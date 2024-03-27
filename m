Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA43DAC10
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711508771; cv=none; b=mvi4S3d8j/Os0J6EmW/ijSxcibBTgApLG73jB7xxma3+Po92RmAO784OsaEhZaHeORolltPiwWkCUyOBkaM8O6pOLxNQmKxaQYJEUUdGqcPOFSVwNHkaZ+BwO1CJfUvynKbyFmR6XHcZkG+BQuIO0Q0FtwZoh05V9y3DHdCL8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711508771; c=relaxed/simple;
	bh=apeonm2y/FdWgsULk16rObGuLPp7ng3LOLOhIs96iHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAXpbtxq+9qLNJbw/xG+NDO0x3aydwH4544PdpbZ179vejQWjzwjWPYlF0rSfK6pYsyNy7CoW/TVFlsTYWmqtgTrod63hrVAijo7SJVTIx4wQvMybM7cpddtKwDol7I+fpCnzvKzCryhgbHLJOCO+Ra6c/50IB+lr9sSQXvsG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCO/mW6D; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCO/mW6D"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78a3bccc420so315677885a.1
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 20:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711508769; x=1712113569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1iThhZAXJD+x/yEV6beaOw5nIzueqXMbpg6fCh+eZo=;
        b=KCO/mW6Djj4s20X+SCr3clf53vRiw06VlS9/uGRbMoeVaK+UhjN2hHjQp4Hk2lcJ9S
         jixdqw285RprkWy0xZSGGWSvkVHWuvZDhSd9zOxmxhbMtX1b0eYPRVYLA/GE1ZJS0/cB
         20DoThMmgQagxvaNOjONGAxs9EuLeeM0oY0twZADeHf8hYRUgMKxOvrCxMMfy6BKoE/G
         wfal+sd9VaHT+Vhjn3eR6noqE82BwK/8PvCYmjI1mI9kVpnrXK4QWejHFGzk5KQfH8f4
         B14xgYkd859P4kh/AcubLa7p8DoZRvt5YWCN+u2nyGFjmORWGeVj2ZrTfcG3D1nksThT
         z5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711508769; x=1712113569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1iThhZAXJD+x/yEV6beaOw5nIzueqXMbpg6fCh+eZo=;
        b=TeqnhjJYfEoD73m/Ldq+WB6wcAmBArJQlD2h6i6N0saEsWrkJt0OCqrreBp63sJ9F+
         bir7Sp2Kf65tTeKHScwnavYWF+oVjMoGz+SZjxMwWG0ivrh3dwpsYOdklf7SVDoAY+p9
         NViq5+fczVF302Uur8wOrT6v8gUF5GscEuBHNoLS4YQFmcp0vfLL/LREJKjAHo8E7zXc
         I3GAydKRxHQiTydq/uMolmVHFwKGbOzEd0dqGDh8IW4Cl0PAhwepWps32+DzJqoG7rFp
         pcNhNr1zwprA7qyRZ3gOi2HWkKf0XgcS5/f/mwOafcnjSHh2evS0U2N7lXPNEgaRHNsI
         PgIg==
X-Forwarded-Encrypted: i=1; AJvYcCXVei7cKrFdBfKfAAQAGVRRcpd+KbPzKJd40HhKnC7ysY2owDB1xkBS2XQyzY6YUlNd4a/nGjReiKYkWSuIGFraFWly
X-Gm-Message-State: AOJu0YyZCvfHdQy7Kh3FpO13si/oVEQXran6vRNpx8zpHuIbBoGYJpp1
	CvZbcDK7YGcmW+VaVsnnYFHu7PA+5NX6K93H+1fMf9kbbPpDew3AwxG59DiQ4J7WH0+1JxwZbcy
	R1MaJT/51P9RGwy41Cq044EQq0vo=
X-Google-Smtp-Source: AGHT+IHQHYiZhne1Jfe1ZfJTkyuxaaraopGVdeBSG2vLSuNA6c1QHc8qg8emeB9llTCFFr0eH0T4Zx94s77FwVLKwwE=
X-Received: by 2002:ad4:5ec5:0:b0:690:b782:bc9e with SMTP id
 jm5-20020ad45ec5000000b00690b782bc9emr4885767qvb.53.1711508769129; Tue, 26
 Mar 2024 20:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326081207.73375-1-laoar.shao@gmail.com> <8caa200a-f8a4-4381-9269-da706a22f990@linux.dev>
In-Reply-To: <8caa200a-f8a4-4381-9269-da706a22f990@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 27 Mar 2024 11:05:33 +0800
Message-ID: <CALOAHbBy-ndctQetrTX91=ipG0AJyu+HtMPOYPQY=fshv7q6NQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Mitigate latency spikes associated with
 freeing non-preallocated htab
To: Yonghong Song <yonghong.song@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 12:50=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 3/26/24 1:12 AM, Yafang Shao wrote:
> > Following the recent upgrade of one of our BPF programs, we encountered
> > significant latency spikes affecting other applications running on the =
same
> > host. After thorough investigation, we identified that these spikes wer=
e
> > primarily caused by the prolonged duration required to free a
> > non-preallocated htab with approximately 2 million keys.
> >
> > Notably, our kernel configuration lacks the presence of CONFIG_PREEMPT.=
 In
> > scenarios where kernel execution extends excessively, other threads mig=
ht
> > be starved of CPU time, resulting in latency issues across the system. =
To
> > mitigate this, we've adopted a proactive approach by incorporating
> > cond_resched() calls within the kernel code. This ensures that during
> > lengthy kernel operations, the scheduler is invoked periodically to pro=
vide
> > opportunities for other threads to execute.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   kernel/bpf/hashtab.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 3a088a5349bc..d3d5aad045cc 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -1489,6 +1489,7 @@ static void delete_all_elements(struct bpf_htab *=
htab)
> >               hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
> >                       hlist_nulls_del_rcu(&l->hash_node);
> >                       htab_elem_free(htab, l);
> > +                     cond_resched();
> >               }
>
> should we put cond_resched() here inside the top 'for' loop, but outside
> the bucket loop? Do you really have a long link list for a particular buc=
ket?

We haven't monitored a long list for a particular bucket.  Will change it.
Thanks for your suggestion.

> Otherwise, the patch looks good to me. In hashtab.c, we have cond_resched=
()
> in some other places to mitigate similar issues.
>
> >       }
> >       migrate_enable();

--=20
Regards
Yafang
