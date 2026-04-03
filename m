Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6850D341ACA
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775241878; cv=none; b=iVPcRsZEuK9pMKvns3sgVg2nfR7IuM8Yos6RThsdSHZSf4wo1BsLO5MND+/cIwTGqXrTjtMlnrlUA47viAXLGtMLkiIKgn18sYNU1Nzz8jjO3QnlGbi5ZutgNjdPJmzstt5VqnSredgObKoVIVl0QQQq8LR5sEFqMomgl4dzbAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775241878; c=relaxed/simple;
	bh=tBELxCV0wDSxh+MzZ2d9z9QObo82NSVlz32J4tvZNdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNHzWZ+xeUaQGu8YrgPT1ElIS91aED5h21xbe+0BDweU4BEB8ifk2zHbk3UNqSvWDQYPeDHQKs5q/AuYk3POY0AebWPhBQ4aBORsJAx/GB9dKz3STN+6GZDK3Aw5MJmbV8kjrZmU956PhbhsFVufz2akSWWAf0XtZjohBAKbXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7cItptN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7cItptN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18570C4AF09
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775241878;
	bh=tBELxCV0wDSxh+MzZ2d9z9QObo82NSVlz32J4tvZNdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d7cItptNPLYSoEHwe4Il9Hy6VH/tT9HABUDfU0DBXxUyJirpr5KIEkNer2tZJrfYG
	 cwkTgk6rIfDGql1tlG2JCFun02E0QlupopuOCMRy4ry8pz5q7V8vUTPBrrYVwUQnRU
	 UeL7+sNP2qLMEcM+r/FGF9Eg96LRFZfRu94/SxN3tjCFLVP70GMZg5tOO9Hz0Z4Jvp
	 Mt6mTMwcGco7T+oz1IMqVpq4t3ZRnXD8zK6fc7gmHIscSdMQaVsk9BHwQI8MjGAWyc
	 VrHqyoaZHwQ2ZoieLAijTKxFD72Kq06JtqMr+g0m6Ki6Tw8374j2Fnps0qo6y8LLxq
	 hG29LAGOwyF+Q==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a56ca653ceso22053096d6.2
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 11:44:38 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzg1Y42YgM6W4punGnszKR29eDwZJTsegA+selAW4nNEHrZ8R/P
	pr6inLV0Nn4wBFQvKsRyvXpvev6pXqpOqDnpPHogNdtGrQY+Be/6t+0f4K7QsK1iDSdXoDSGu3G
	/eA0SUTo6jEEaIuBlGv1jE9FKQ5Dobk0=
X-Received: by 2002:a05:6214:808e:b0:89c:4e50:1921 with SMTP id
 6a1803df08f44-8a702b92d9dmr63131116d6.26.1775241877190; Fri, 03 Apr 2026
 11:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403042720.18862-1-emil@etsalapatis.com> <20260403042720.18862-4-emil@etsalapatis.com>
In-Reply-To: <20260403042720.18862-4-emil@etsalapatis.com>
From: Song Liu <song@kernel.org>
Date: Fri, 3 Apr 2026 11:44:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6hK-KMKSOPYCEqdvH=MDX9xnBYSy-6YhQ8e9dLfFjJLw@mail.gmail.com>
X-Gm-Features: AQROBzCdCkjxcPmRq0mbkw41gJWla0f1X08cERJUlbJeIM0Xyge4ffcBD2rbAsU
Message-ID: <CAPhsuW6hK-KMKSOPYCEqdvH=MDX9xnBYSy-6YhQ8e9dLfFjJLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] selftests/bpf: Move bpf_arena_spin_lock.h
 to the top level
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com, 
	daniel@iogearbox.net, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:29=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> The bpf_arena_spin_lock.h header is useful for all programs and not
> just the selftests. Move it to the top level of the BPF selftests
> to make it more readily accessible.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Song Liu <song@kernel.org>
