Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB933A6ED
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166388; cv=none; b=A5Y6tVge7qYHDRQyPg7zxBZOvNUM633xFY+lQwTVaWIviybzSzPgkiDxjuKa3zTBIHRdpRBwKDF//1ig9yrQESWmQ8VPH5FbGzyGKD2S7pTogq2QRkU3VIJDrljF4j8fvsQqxZdwcjOrqZ9uOa+NccMMg94OwzvHkfzr6Sj75Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166388; c=relaxed/simple;
	bh=wIseGvriRyJ9uL5yHm4hTiZMhKY2y9uQV9NZswbNZnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDC3JsJC/t5oSJMaJQslInXfmW4vuTki25IkSAUJYDdBa1TUbBvlf6AcShbngRy9YkqZ3cY4x7tvH6Ma1MleTrA/+pyhfZIx5hbisImUYcrCiNPF/DTrV08xUDRzHHYYZycoCDtXE3MgTMkGKC0YlvfWZs/Et/MqtiIUsa0Lxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=18D0Obk5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="18D0Obk5"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so2885672a12.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 03:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769166385; x=1769771185; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=muu0l78hU9PlvWs+XaVgcIrONIv8p+ljWK1+CvMfJx4=;
        b=18D0Obk5+I7FZHid4h0X1pLxOS+nyvVmCZoebasD1lM+Pylg28yYw28DMZ5mpLTxYa
         tU2e3F1Gu2G7KXGr3Q3GrMVNTFV+zD8lN+PGIIZh/sPuXm44cdHQTSXELQ3hhNSHA28M
         sTqM4rq160+WmbPu+o34d+tENKsN8Jd70bmlhgCBP0ZhTB2MADG/1a/4AnNB2WtSoIpd
         d+EMjzJdMK+tUEdKR4Y9CWmTtVu0kYsxBFvJQ7UcMIVNkMC9nEWcCY49K9t6t+HGmcOk
         /WWug+W/3OvE5K/Aan/9iAEIoS6+ji5IUJRGywhjWdjMhmdP7wNFss6QtRFnrHjrIWdG
         SOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769166385; x=1769771185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muu0l78hU9PlvWs+XaVgcIrONIv8p+ljWK1+CvMfJx4=;
        b=RLxtFHrZilIDGpR7g6XGFkJcOUMIguT7rnMNsVcMJdu0/WLJpIzG0Od78wnsRqESJ9
         zsrrXVXA8NJ9SWlgzNButAdzAfPNtLw070uY2Q6Ju33b+9M9Q4k6Aq+K9zIZnSm67Xfg
         IGDgI68VIWm058prV9bxbdItSQnP4zgETeheB8e1NYyA3s5CgRJUGGIG83JszoJ/vIsV
         tBQoiIa18YuG1Q/ZQe9VVHhHcSHssi+LVnwK+DYxDj5wTNmTlwi6hJz5iCI1zr2y0sdf
         jORoM4PonaAMIYtpQoDRjzfh2YMJ7Z2Rpq83aECK4WZM1rKwFUawaF7wqlYyeZX7Z5/L
         ORyA==
X-Gm-Message-State: AOJu0YwhJHiYCtyR0j93Nn1GweS+BVwp+zkbtXtpLDoyq9lIX5UD2KE4
	PBCwZSplBkUnDQ1F6FZ3cPbXrPZ7c5blIKLP6Myi2K9NfjmiKWrDwslG4EEVqkaRLQpXZ77KpJq
	HxCewnQ==
X-Gm-Gg: AZuq6aJ3wWmGebXQCble7IBxuQp+f28f+T3TP2OdS80cIbpOhM9gu46RD8aFuSexxDo
	voyU+hWDtFJsQsCX7d2699WcSBg55PPDX7Yzh5ZapbrcfUgmrrWWAnGZKne1U0ysw9Xyhi188Lr
	L0cSG4xSfBnpQkhAVXzOMywTbr76Eg0FoXJwHhakfiUNsXAIB+vt/d66Qrl1VEyqJ18VQUw1D5a
	cwoWT+bcOk5N/d+8C12eZ75MBtcY02t9UuOil6r7+dB9Q0g5x2bczapjoD9gUD+HxwFjL4f/5j7
	wED+NaIMQgvhQIIgn8we6JYHFvmRl3MTggaZ/yaGM2TLlfVJc9q1bPxh6lW8eKwbJHwFHOWcslO
	cCxpeJ7SLo2tMWJBT5YEbGdOC1NSA/nFxcztvfzzy3r46W2tQ9LinXBbksLlqMxQHAo8OAaFrER
	+byE30Y2oPRT0F8I5N0AtIs20xA+cJnMkA35TTec1tbqh+uMKXF8nkqw==
X-Received: by 2002:a05:6402:278b:b0:64d:317e:8ae3 with SMTP id 4fb4d7f45d1cf-658487c9c3bmr1638182a12.33.1769166384952;
        Fri, 23 Jan 2026 03:06:24 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b92b66dsm845559a12.20.2026.01.23.03.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:06:24 -0800 (PST)
Date: Fri, 23 Jan 2026 11:06:21 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
Message-ID: <aXNWLU7ay1HHmg6S@google.com>
References: <20260121135444.187001-1-mattbobrowski@google.com>
 <CAADnVQ+8f1mK1+L9S6uDbo0n53zs9VeUhZr5eTg0+jXppRAhcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+8f1mK1+L9S6uDbo0n53zs9VeUhZr5eTg0+jXppRAhcg@mail.gmail.com>

On Thu, Jan 22, 2026 at 08:26:49PM -0800, Alexei Starovoitov wrote:
> On Wed, Jan 21, 2026 at 5:54 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> >                 break;
> > +       case BPF_CGROUP_ITER_CHILDREN_ONLY:
> > +               kit->pos = css_next_child(kit->pos, kit->start);
> > +               break;
>
> There are no users of css_next_child() outside of cgroup
> internals. It's a red flag for me.

Hm, I can see the slight hesitation here. However, until somewhat
recently, the same argument could have been applied to functions like
css_next_descendant_post(), right?

css_next_descendant_post() has rather recently started seeing usage in
other subsystems (block/, kernel/sched/, kernel/bpf), despite
remaining internal-only since its inception over a decade ago. Given
that css_next_descendant_post() continues to remain unexported, in all
fairness, I don't see css_next_child() being all that different in
this context.

Would your stance change if Tejun agreed to mark css_next_child() as
exportable, or simply agreed to it being used from BPF cgroup
iterators?

Both css_next_child() and css_for_each_child() have remained virtually
unchanged - and therefore inherently stable - since their
introduction. I should also mention that functions like
css_next_child() and css_next_descendant_post() were originally marked
as exported, and only later unmarked. This presumably was done as part
of a symbol cleanup, not because the functions were unstable
primitives.

> I feel there is something wrong with the use case. It should have
> been handled by the primitives we have.

Right, arguably it could be handled with the current set of
primitives, but it isn't nice and certainly not as efficient as I'd
like.

