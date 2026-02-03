Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B531D750
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770125018; cv=none; b=KhP0nlC+hLwuFqUwLehQik41GiVvfDoK+Qs+lKZ02HQbQNQ8pg9wwujrCO87LSt4ypnOdGObi7p0J47Br3VGqdOyJfpmM+JPKREky0u+fW1xEjgFFaqzD3cBRHV5VGfFQfI7UM4OVXueIojslXwjxLxmfMasqWEB2OLBssYtg3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770125018; c=relaxed/simple;
	bh=m3yePJc5GJA6IQZfzwxGBSJ6VJU+aPmQFSVFUxjLip4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otBjjeKWHsI3GRdd41D1DrUDABSvBB9DLzbEj0obaShNiOBU9rVOxfWG4ds2p7uM/fuWs1PTpp2gIn0O1WEArzGCtrWwfBcH06Ehne5dY0hhl8T0H6OSYp+o7KWT8qZalifVh/h2gvF0SxAjHxG9u7Nt6oD1maoUuWGyj0A/8mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RHU9TQnT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RHU9TQnT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4805ef35864so48748815e9.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 05:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770125014; x=1770729814; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X9jKCMLhYnPbhGwJQdPwGF6Ru9Db2nKOSg989VKRbuc=;
        b=RHU9TQnT3v/UP+udLXke8my/D7cl6GQgGutNManoVPenN0hBXukToYoGzQ/6u+N9KP
         zzW1/8MyoCTa4jJmR5L/s6eiJvNP4h10Bvzi9PYOAzbnY/SaAGgpH6+dEJbsifhMx7Vu
         QT7ho0ZSnHvvhoTM7ev8JOerrD/wHog5Acm4nN1ZzxZyM1rwJrVHhG31VzmcS74XM+/l
         ni1eM5LvUybOoDglmaTffus0JX/giSuFc4caXwKTK2XBrAbzmTyZpbtFnPEaFqDfwKYq
         suPuE2KMw1JTDYXM6IcnRjNPFhrjt0FahVncFU9oLDVswInGXW5/27j6t1XAKiamstL8
         d0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770125014; x=1770729814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9jKCMLhYnPbhGwJQdPwGF6Ru9Db2nKOSg989VKRbuc=;
        b=iLczaOcZnsq11///Fe4FCcMRM6tROGtMedHZHd5wjALdxQfGKgRc9kc7JdNqyMfTsg
         pu45QOHgf5juxPq3WYugT9+Ce3VDSKuIA3elSeaFFBh1Psp9uE+jGD9l7rwgKCddhZhU
         qdSr0jisuTKSsZtw8QS2Y90ayXtVeL21226+Uqb+ey5DKKfqyA/wJowjaTvPJtfapMxH
         c1qFIJ1rHLl5/IdPRT9eDtDvrcvGXG4Pb3INCxfngI0dmAmnvyDKCDbKcSihAj1Y20rX
         J5dPbdbNILMu7/t624Gyd+s2Mp0mUgBEBqmAFt+9q/GkeFGxm1rwswmDiagC9NJGjEjy
         RMRg==
X-Forwarded-Encrypted: i=1; AJvYcCVsdIpNJklb1SK3H1dDSOSTTjjeAUpS/2YdPdvV/ejYLRJbcZElqFox707KKoT/41RF8RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2rGCAHSEww/g2rGvF1bp4GubCW44mwYAapMxUVxz3xw9WB+9
	dJs2g44YYicDHp9Go97JrMgilyq13+3Gd5ENi2a9MN/0ZRcNEyadnGSgRQ47GKCC8yQ=
X-Gm-Gg: AZuq6aK90HfynQKmxOM4XQnppoK7m1W/OLopPr4PVVrM59Lqa2klY1LCo4ORscLbbaE
	KhmajeLpoMZBrfulEHyA0iftD9Ju/iUvEzzCjQ+AnmRM/xGZT7/s72BXgiclPQ+DvepDkBaL2AF
	14VggKavJFSGqpYuVKtaxng/6lQh3xo/5ZY/NOfVQLrCmuO8KaIp7eYhJCEJ8h6OfRVkGMxqGYI
	6rZrM4rhsNmzj4jvQ8RFCuh/P6AfsJrax4wzUn96H7mT57Dm69396um6KbbB2NZoUjGGZ0W3+KW
	yg6+/XryR1NuBni867xMl6DwIHhMG3piVXXuWyES9ZPfb7v/uC8aIz39/n8aRKSR43WxaK0kSAq
	vYmHOoWj7KBj9CalKXIj5AUe7gwIIJI6e6VTpNCo4KPi+g1chMoq8vS85TSgdSU8MIoudXk/JVu
	caH+h+yy7wAWXoWUR/tnbzzDmb
X-Received: by 2002:a05:600c:a087:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-482db48f2ccmr215249685e9.30.1770125014093;
        Tue, 03 Feb 2026 05:23:34 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da903a30sm149018775e9.1.2026.02.03.05.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 05:23:33 -0800 (PST)
Date: Tue, 3 Feb 2026 14:23:32 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 10/17] mm: introduce bpf_task_is_oom_victim()
 kfunc
Message-ID: <aYH21HhwNvWnFB8O@tiehlicka>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-11-roman.gushchin@linux.dev>
 <aYA4pH_nIBZ-ZhLL@google.com>
 <CAADnVQL5g8imKNGbHGQ4HA8_qNT4MYwM8P3aCTFUG7uwiuTeuw@mail.gmail.com>
 <87jywuwumq.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jywuwumq.fsf@linux.dev>

On Mon 02-02-26 16:14:37, Roman Gushchin wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> 
> > On Sun, Feb 1, 2026 at 9:39 PM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >>
> >> On Mon, Jan 26, 2026 at 06:44:13PM -0800, Roman Gushchin wrote:
> >> > Export tsk_is_oom_victim() helper as a BPF kfunc.
> >> > It's very useful to avoid redundant oom kills.
> >> >
> >> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> >> > Suggested-by: Michal Hocko <mhocko@suse.com>
> >> > ---
> >> >  mm/oom_kill.c | 14 ++++++++++++++
> >> >  1 file changed, 14 insertions(+)
> >> >
> >> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> >> > index 8f63a370b8f5..53f9f9674658 100644
> >> > --- a/mm/oom_kill.c
> >> > +++ b/mm/oom_kill.c
> >> > @@ -1381,10 +1381,24 @@ __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
> >> >       return ret;
> >> >  }
> >> >
> >> > +/**
> >> > + * bpf_task_is_oom_victim - Check if the task has been marked as an OOM victim
> >> > + * @task: task to check
> >> > + *
> >> > + * Returns true if the task has been previously selected by the OOM killer
> >> > + * to be killed. It's expected that the task will be destroyed soon and some
> >> > + * memory will be freed, so maybe no additional actions required.
> >> > + */
> >> > +__bpf_kfunc bool bpf_task_is_oom_victim(struct task_struct *task)
> >> > +{
> >> > +     return tsk_is_oom_victim(task);
> >> > +}
> >>
> >> Why not just do a direct memory read (i.e., task->signal->oom_mm)
> >> within the BPF program? I'm not quite convinced that a BPF kfunc
> >> wrapper for something like tsk_is_oom_victim() is warranted as you can
> >> literally achieve the same semantics without one.
> >
> > +1
> > there is no need for this kfunc.
> 
> It was explicitly asked by Michal Hocko, who is (co)maintaining the oom
> code. I don't have a strong opinion here. I agree that it can be easily
> open-coded without a kfunc, but at the same time the cost of having an
> extra kfunc is not high and it makes the API more consistent.
> 
> Michal, do you feel strongly about having a dedicated kfunc vs the
> direct memory read?

The reason I wanted this an explicit API is that oom states are quite
internal part of the oom synchronization. And I would really like to
have that completely transparent for oom policies. In other words I do
not want to touch all potential oom policies or break them in the worst
case just because we need to change this. So while a trivial interface
now (and hopefully for a long time) it is really an internal thing.

Do I insist? No, I do not but I would like to hear why this is a bad
idea.

-- 
Michal Hocko
SUSE Labs
