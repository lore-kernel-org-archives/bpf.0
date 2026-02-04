Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE2385EE0
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195757; cv=none; b=sJA0y4HhddlEzAXwi0D+q7QtCuMyAKEYvc++M1PgJCpouTIat7/8rGnh/sJ39+O0W3E/Bcshj7j3tM1mW4vhJINf9dGgbbZfnbjoTx3Bh+s5BPL1slpporrA+NEjXr82B9iWD9tsb0rpcZFQFdf+As0LnrfT5CaO7C/X/dThvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195757; c=relaxed/simple;
	bh=nrXgtwtgluErA+P46xrRI8zggZuVydscpcYjuDLXiVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdSaXquJwxiX0HXvwZu+eHqY2w/qbXp1+rOKGOrduMS5O0njr9qUDwxlwVTQxMP4p0QV9BFWTFUrgluLJNviRlDCj+Kw6MCDGN8qem6Pb5GyLxQmLkbCpPMXJzaZR5M9eyFpzQFiUmsHx46y/rvAkz2pcCcceRpl3huvVKwpwV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wz3/+N1k; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wz3/+N1k"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee0291921so62174435e9.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770195756; x=1770800556; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+BKvdMgbyHAEo+wOrGBnZb6vr7blKztbePG761zDzsA=;
        b=Wz3/+N1k6GP2myy4YWUGvO4ImAKdR8CSf7XmbXsW1UM1wXWjMKqBbAcaabbr47oglq
         /hpCJJYFnQc4V7+99I5Z4LAO8YzcWodbAVLzNk14aSdb3+LOvdN4UI0HUd0522G1AsZZ
         hWD0oZDWT9hnjhnv8W8GApoyQkaQqey649yhaE8ik3w1rUOgN9t1awYq1D7jIFfoQQGr
         SqrBtY98wGmelbkjjdWP5rtUxYiYJ8OsiOGYOGySV6Qm85H6NsqX7OaNdj0eLh2XIZrv
         GDZD1DEvKjcs4H/OX5XdyjvhygOpPRzkRQmPZPIkDVb6L10q4vjVhrPic6cEyJW5FlpH
         fbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770195756; x=1770800556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BKvdMgbyHAEo+wOrGBnZb6vr7blKztbePG761zDzsA=;
        b=sBS/6sG1gtRIjJEK5TCygjIoJAPqqS9NSHV7A6+ibnYdelRi0Hd8ltvVpzxhinZ8nh
         K/Qi3J61G1DgZyVB2Dhr3tIxdavleX1AahR7e4DPa0T6S7z+kVW7rIKRb1nayxiIoBZe
         pdrc/uPuDQGBVEBUB/zM6GcFxyK6zMXUx8oQkGY6e81/itrCGOXso/nljqXTDue7+7OO
         kPIkRwS/JzvNajvJu6yP9NJPuf5CJTWufkhoznjWAcXjmV0N7W8bEOx7zDYoT3hSwWBo
         EhGPCShTuCZIBk1gAgmwRXvEdgjCoInwvE3qPgKN7d1iaKgMw1zoHtu5o9SfJeXbgSSA
         +iag==
X-Forwarded-Encrypted: i=1; AJvYcCWmAne0egRKhXLxyRuIEtmnEotvn8DcVjR4fR1DywEvpGSMe3bg5fyLdzVho20f77zwTqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxSjNevSVMXQ1noVDVU1Npw6U82OiDpk0X2w12UvnUTCVXYY+
	112+0FcY7vxM2hsSqEhgjvxgmd1P6FLl2YCMCldUL987Sus1x6EJzLZcIFCp6tEt/QTzEiDVN6I
	d1vfj
X-Gm-Gg: AZuq6aIAwPmjvW59AU61L5rig6Sx3ugriC87sGxyDrAsxYRJbnTLTrWR2UgDDU+m1Je
	wU9NPxFExkVJ3cqWcXRwv33ihF7Wz/W5uROUbhan8ZbwH10pyq/Uo5NX/NLn9YPeDzUtQWqK9Xh
	xbMLpkmwPNwKWfYL3MjMG9qMUiokTzp8zkjww7TU4zdAdwyJy7V5cDmQyz3UwSfURLl50piqPED
	wDWtwq8LblP//OwuJXBVFU8FlLJKuwke11nqrUMPyXuPF9efcWFwhu7dctu4rCmRo6st4nFDseF
	SRJoiCPl3XpxkCjAG7Hkqk5jqu1gO5NMgJl5ziDM2ceG0zqRh72owAsYw79einK22y23HWkOztR
	YhZxD0aOcPyEvam1190BsroEIZNjiOf92gCRaRM4KZj3g97zIwjXkI47FlWL/mMH4iyNYN8wrCl
	0mPqhyMSMLWwqMxHgFzWuDKvO1
X-Received: by 2002:a05:600c:34cb:b0:47e:e779:36d with SMTP id 5b1f17b1804b1-4830e96d019mr26114345e9.23.1770195755513;
        Wed, 04 Feb 2026 01:02:35 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831088d318sm50023575e9.10.2026.02.04.01.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:02:34 -0800 (PST)
Date: Wed, 4 Feb 2026 10:02:30 +0100
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
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
Message-ID: <aYMLJv64GOh7coMK@tiehlicka>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-11-roman.gushchin@linux.dev>
 <aYA4pH_nIBZ-ZhLL@google.com>
 <CAADnVQL5g8imKNGbHGQ4HA8_qNT4MYwM8P3aCTFUG7uwiuTeuw@mail.gmail.com>
 <87jywuwumq.fsf@linux.dev>
 <aYH21HhwNvWnFB8O@tiehlicka>
 <CAADnVQ+uF4cTVYYOYBEDWrkLXJJkru_FaRttFskHRUpamktMJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+uF4cTVYYOYBEDWrkLXJJkru_FaRttFskHRUpamktMJQ@mail.gmail.com>

On Tue 03-02-26 08:31:19, Alexei Starovoitov wrote:
> On Tue, Feb 3, 2026 at 5:23 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 02-02-26 16:14:37, Roman Gushchin wrote:
[...]
> > > Michal, do you feel strongly about having a dedicated kfunc vs the
> > > direct memory read?
> >
> > The reason I wanted this an explicit API is that oom states are quite
> > internal part of the oom synchronization. And I would really like to
> > have that completely transparent for oom policies. In other words I do
> > not want to touch all potential oom policies or break them in the worst
> > case just because we need to change this. So while a trivial interface
> > now (and hopefully for a long time) it is really an internal thing.
> >
> > Do I insist? No, I do not but I would like to hear why this is a bad
> > idea.
> 
> It's a bad idea, since it doesn't address your goal.
> bpf prog can access task->signal->oom_mm without kfunc just fine
> and it will be doing so because performance matters and
> static inline bool foo(task)
> {
>   return task->signal->oom_mm;
> }

OK, so my understanding was that BPF can only use exported
functionality. If those progs can access whatever they get a pointer for
and than traverse down the road then this is moot from a large part.

> will be inlined as 2 loads while kfunc is a function call with 6 registers
> being scratched.

performance is not really crucial in this context. We are OOM, couple of
loads vs. registers will not make much difference. It is really more
about code writers what they can/should be using. OOM is a piece of
complex code with many loose ends that might not be obvious.

> If anything changes and, say, oom_mm will get renamed whether
> it was kfunc or not doesn't change much. progs will adopt to a new
> way easily with CORE. kfuncs can also be renamed/deleted, etc.
> You're thinking about kfuncs as a stable api. It's definitely not.
> It's not a layer of isolation either. kfuncs are necessary only
> for the cases where bpf prog cannot do it on its own.

It is obviously not clear to me where that line is for BPF progs. Where
is this documented?

-- 
Michal Hocko
SUSE Labs
