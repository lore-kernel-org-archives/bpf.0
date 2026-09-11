Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1B4CCDC9
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154840; cv=pass; b=MKwxeRduiKs+ku4OBVnNywwjs8a7QHOiPcYZ1l5X44OjHDCx5OYIRqtPV1MYu/78kpoZEbHcrchB3aq8X1bRsjjGDJYlrrtnpF92PBCQOu46tWmZ1OHZoKV5Ak8PCac5lfJfUiOUXDqrV3K5ZZHVTkxiRrL0LfEMyUIifPsYBSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154840; c=relaxed/simple;
	bh=w6/9piynRRKXPssCmFy5vTu4brh1mtSocO/C/Q3IPQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOI32QFoAQ7DQ6ZSx3vYHgom86IWGvWtN5jLBA1/7QXK1c64j0RsaBksDYfZNTjhDqLfOBjokUEfRBUaf/80vE3ZpzjQ7+Tt+qryNzvQLKPsoGeokt20kpyvNO73z2icbwcEphtE4EIDM4k+NrqLgIoYorwl6wo6rRj9hUo9HZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMKI/3a+; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMKI/3a+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d58efc7356so18755545ad.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 12:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789154839; cv=none;
        d=google.com; s=arc-20260327;
        b=Ps15v7wPOByHrWdeCXyz1zk3bZk0QBqKRePIuGl9m+yC2NX84JizaGxwDYuo/TCAVU
         5jq46Sfdz4gonoIhGSIViRT/KZNARQIMeTuHR2khadwue6e9hlueSIQyM7LT0BbLiBI8
         7QIfnDoZYlcvjt6qVcmN+X/9ZX8SGAPnX5AZ9bdgOoelmaDBNCEyClmtVCKCnnGFG3y8
         VOwQhZSmTg3qENFe3oHmTi7b76zF6A1FDm1nE6+Tu3r5XgYuXd2HwI0mwuda43ur5hxD
         Sxs33f3d1Q/KO3SGpZT4f63ELlUpo8xJe5ESV5l7MqtgW2Gljm48qBZN8l8roB0vId5Q
         8ipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w6/9piynRRKXPssCmFy5vTu4brh1mtSocO/C/Q3IPQc=;
        fh=HcEwcAOsUSs2gvuUepopR3Yw+WU9bvtqgNvY9fpN77Y=;
        b=c96aCJ3iprcMeY6lmrj22oubS23OPJZVvXpocsixWqStjEDluZmgZV/TtOlBLG5GGZ
         K8h+JB52U4Vkk4vA49TvTsPBhH0cImnHIaGuRwq61UwOGCrSEQ/XjiNytC4VDcaWUsLK
         h2+GrXvydxfffjV1VXOOARHdbELn9vxvlN8G556jU0sB6uYRrvUOD0BRCj18M6M2N1J4
         czBef0gnJsb70zYPVP+96rbq9AET3V8iXsfjinCM126ZCYwWcSoBEb2KgWP4o1GHY8sd
         tBtKIxt8LOVOf/dvqfDWQy0JaADXqFpMOMeZib/1qYugnaau8x1SJkySJzzdDIPnxb5o
         l47w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789154839; x=1789759639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w6/9piynRRKXPssCmFy5vTu4brh1mtSocO/C/Q3IPQc=;
        b=JMKI/3a+3wv3uiuCWz41fwmldb5i20HYq9c7xiJMPkNgNuzA0Gv3bDmbSbRzTHwW77
         U5qjTO5xxxuJtMC3Kzd+vdy7yTPyvVCJBFo518i4NIOTwI17Nl/4M74P1cyfFaescYwg
         Qbb2iBpSZ6RoAKD+nNPS0LCf8t1QJxFI7yi3Ilq0Wh+nBmFPT0UHEDksx6eqYLnMkY0X
         iWcrTrIBIg6Lam42Gfh0CwBnMrYntWB/78rQxlDudtkK6Hhnx45hy/Rqvye6mMXAvfUm
         AJ1lfdN2DEtrkfNHDLfcFlqp/an7LNa3kJDbrRKdlerNil1jcMb2iG5YZFOCymPbsgkQ
         3nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789154839; x=1789759639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w6/9piynRRKXPssCmFy5vTu4brh1mtSocO/C/Q3IPQc=;
        b=enhcLIf0LD25k1rWJLDGDrb1zbf/+Tm7ZefBw/0puHY8FjJ6jB9adbb/AqJYPZ48z6
         4IV6UfwjktJSA4vuW8q7RK10Yr0pVAVYWQ1B2S1ApXwX3gFjXvPUfnimWsIsUG6liSw3
         /wsCvD9iiFuAU8wFhwt9pEZ0bvVLa95h6NEXd6fJrBZIkCUj0rwdoXEGeGj6JrWNuETn
         TLxRzsWKXPUMcZzmcNucjfeXzY6zcsAHWJt7pbUtyuWYo3sC9Q6UFRcvDHfSn2jPwa3h
         7izhGo3F2Dk2OyLC6cqkx0+Ot+qW4g+XvrDgZbVRHtVSY7b7O2hK2XCt7W/cBHB0d3dJ
         QtfQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7EAoYW7f/wwWpokcWCkd2GMDVb/eVqAGQeghLxI1I7QuCtzXqjT1PUh7KgkIDUcCMbzc=@vger.kernel.org
X-Gm-Message-State: AFuF++mY5A6CCIH3tduldqp1LchALTvEzPqn+u/L+mwJEF3W+KwMQglZ
	hmFdOfT+nrPpkWIT2+2bwsVWtmew057hAoJfls+MQC9yiDHQwkLRGZ79a1yXOwTBj7BHa1/6xRq
	Is/yMnqUzD9O1fmrDw17QPRepyRniaG8=
X-Gm-Gg: AYBFou1QfZUSrf9sbhxAHu9NhvGRnD0aQrKK4asj/4AHDTDEZiJk0rit0SCbM7Bmp0t
	egzEJoAkvhiYeWXbx1w8RKOYnkTRrDaKAAxasFjmciXis2I9RgYDxmIsEVgZCc+SHyk50t5bI67
	ui2+kH8ciFEXB5WcESuI8xaJeZxB+8IeiZzYTD3mYk9YBdJb0NNv7mlRKGamhhbPVP1o+aJJVp2
	LAnS2FcqhV0fBgvvCLe5/CaryGUMHG8FYlH5ADEVgM8DYMbefsFQPYMKhORvyJmmUz7w1XxKv69
	Fj/tK8x+otBQyN6Hmc4VlB/uglFYpuhuV1hdOSgMdUDH2Q/0/aXUqmlUyBQfcuHXVG3FecUOQSB
	v3WH238isaSbCXsCPXJhmV6AqHW10z/BaIY+EkgiU1z6rh3fh
X-Received: by 2002:a17:90b:1847:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-39d9bbe0f12mr10387705a91.1.1789154838863; Fri, 11 Sep 2026
 12:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910183222.307208-1-toke@redhat.com> <20260910183222.307208-3-toke@redhat.com>
 <0e8f9a9c-6295-49ad-b29b-84613dfbfd65@linux.dev> <871pb0dshe.fsf@toke.dk>
In-Reply-To: <871pb0dshe.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 12:27:06 -0700
X-Gm-Features: AcwNN1UNE_XMfGnmmE1hCum3jv72pXAvdmmsUQvigC_2xKHdjhV4FMljr04cN54
Message-ID: <CAEf4BzbToKWpKwkYNovhOrB-ZvXXyMr71BBaTQN9DsM7KrFzPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Adopt bpf_program__add_flags()
 helper
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 2:53=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Jiayuan Chen <jiayuan.chen@linux.dev> writes:
>
> > On 9/11/26 2:32 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> Adopt the newly added bpf_program__add_flags() helper everywhere the
> >> selftests non-destructively modifies program flags (which turns out to
> >> be every use of bpf_program__set_flags() in the tests).
> >>
> >> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >
> >
> > Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >
> >
> > =E2=80=8CAI pays excessive attention to wording.
> >
> > maybe just delete whole parenthetical notes=E2=80=8C "(which turns out =
...)"
>
> Well, the two instances the bot is complaining about turns out to have
> been added after I wrote that commit message; I didn't re-run the 'git
> grep' after rebasing for v2, so I didn't notice this.
>
> I'm not sure if those two are candidates for conversion as well, TBH. I
> can respin with your suggested change to the commit message, or just
> convert those two as well. Or just leave it as-is, I suppose. What do
> the maintainers think? :)
>

let's replace, you'll need another revision anyways, thanks!

> -Toke
>
