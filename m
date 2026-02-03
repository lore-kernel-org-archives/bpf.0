Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398303D1CA8
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136294; cv=pass; b=u23Zp/g44DsrQfe//fzeS2hQTOjitr0imxPkvWZpNJlfvEPpt5acpVELwl2jgtZudN6FfqnZmiBj3DsdNlQW8hI1iTL33BqgXZFWVH5DReeN7UL5iB9/jplAiLd/GOOIuQwMkvgtp5quCE5mTUs2DvDDAjXVRPN7tZw7qsMAygs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136294; c=relaxed/simple;
	bh=vDIqwnNGat7UeLSbDaR+Ta7GDbEkaTxOpsZnwVbtoWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peGENPFGdXQ/hRlG8z0PkE5EclKoZ8yEsF+AbGzZ2kuFzovlexxWuRbPFU/0tptIQxer6jJdqjIJWobGb5gj3cgFD/szjDpySCFKcjReqVNtOHgJs9iNMbFrD+Nj3yXWkHTUIBE6IxMN/mfQOvJofRZfCQjFLO1l1QXPAHmLQOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N63+HBdC; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N63+HBdC"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fbc544b09so5378420f8f.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 08:31:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770136292; cv=none;
        d=google.com; s=arc-20240605;
        b=e9ZGSfmbmx94uKxcBh0Y87RaphJkMtrqJjdhPCYOqML1xQEfVSYv60GbXu1/+06jhh
         DMkkzq+CH18K9r3oK6EqFwmKP+g+kqslFYdXfPe2yYq9XHHnufIxLfUT38o4y1DGTa9U
         VWHLgb5FqHnVQlxofVwJF+euUmX/WgQFnw3NBiqM9/6RIrUn8WOZx3qSzdPjyv1pFqwC
         +55FV7sE0FF8cGowHO1dQ8LhjdpV389Q5NVXeAg98vV0/xRDHQ1vvEaBPgJOFHA13bDD
         TCXeybMFY58oTc+SKt8isXJqIcOQzPMr1X8QODrkLhbe1LkBjVOTcHegW5mTfq2EZBgg
         BVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DDXM1QX9aKS9kUkXf1pGpmDmgRr97TT7vac81474lko=;
        fh=sMwIhylWImDfOav/di0h0j4jjkAM+7lh+vXlYHz5+xg=;
        b=T114838yFEN5wzER6d9pPvBOZrJzM/h3i8oDzOHnOn8rkrRN5VF62ec61wtkt5JCDZ
         +mQ+eiXAlYqpi6xhvWYdd1Y1rZFv6nF+kDtY1RdvQ1CVj/HXGnE19zurwA3+eb2oAyCs
         uFyeaPE+QJMzTVn1YDZI4mPkPBbmbHT4kTzXi4f1FDq2gfe+4dQKn9UuK1uiaXKr9n6j
         eKW/2whckEiR3e0wsT53BkuLfMkM+2Hadn6YUr9wosXYyY3FKvUAGy/OmtLLDfp9IsWh
         /NP8Vxqy61NcQaRCjNsVTxUjswQCUrawMmo+0Ybz1Q7963M3ipCmxEzeUeAnkdpB8Et2
         ypwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770136292; x=1770741092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDXM1QX9aKS9kUkXf1pGpmDmgRr97TT7vac81474lko=;
        b=N63+HBdCnp/or3QpnmzaOiQMIuEl3Tu3Itl766iDPRP7QhVl5AhUwB+Y0EV6+FJhlj
         5YcVwTIVnvK6HGNhph7Sw6W9itCKSfTW8MyY1EhCEQva1A/LuRGcGXVpqbkOlNRSaDzE
         9Y/HHlmii8NIwmPA7p5B65Fy96nIOMXI93WPS/I5TxpKl9KEJ15oH2wnt28w9kQ9Mmcg
         ynFlor6UQEet0FFdd7OE0LG1EqJ2oFYstu1DwWzSzR+qSkyqX4amATgeNewywvz8dm0g
         caLXEsdi0bNFL0u4gqQqfBCUZHq0wHhWayJwtzS5X/UrbC+gKXduRzXDxMepDqDt0ox4
         n4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770136292; x=1770741092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDXM1QX9aKS9kUkXf1pGpmDmgRr97TT7vac81474lko=;
        b=Nws6gli+yrKqKkProkjS1dUqlDavllQFVHntI6TtIJREnJu/a5lifs8wPzWnh56K9R
         QLXvReBpkzM+U85trPzonIJLgVMkh9sj5e1mFQi2WxvlGNdQKbQthrUSgxsIwqoYwUZD
         KwPx0cb5pDeWyG2dAJ20qhVrxEZ/3D3ZNP8/gOCBRiXgEIFMv4OEAV+NVRy5ATxaHH1e
         z1kAcKwRmk7gE/2Rt4uUKdzrgY+nHYozpAfHx3K4PEPPDf5YTu/hlKYASGU6qbldbSsD
         uZoxLGyDs/MlSrmLAye5S0Pcvya5YkkzsI8163y17foGfUyYCQQXebXbkeIsFcxaePN+
         E7IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYAtlwwXHJpDaHh6k9F+rRgiyFeRyx9RG30+RzSBsP7hLRxq2sinXRJO0gZVCVeCN/G2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lcu/jKKgKCHgILh/Fs+EMIKRcQuuX1EMu6F3uJKMg2E/iMSc
	h6j4wdW5GcTfEl0VTWDW6psxpNhX/8U9gwLGojPif0dV/Oh36pTOA6nSMkAyEOZ1VyLri+ZVAN+
	vPmtCfDmD9113T6TiCTsskgQGIjEhoiQ=
X-Gm-Gg: AZuq6aKN6Cgak3fe8Oh4q2Br1owQ0J94meRefCYuUFJICQDsYOXrikNWOkE7a/TxkCA
	dBJUniwG+kel26hfgqigOkR0mwvx8lSL6rxs8Dpv/RAnmzXLQ6qJn+MBb7Wnpd7mTCARFrv8ZiT
	n+enpimU5id1XZWLSb/rjunpaZZZ7/PbrEY3kKdFAGbPD6lJVaoDyf+RWVvxQVjOGDGNJpgiLo+
	GEZ6A7iLC5v6mGNBPH/4pL7zrsx9gWL8UmQiwvgwwaJBbXGB5vOV3aNTRHHx080JCvrhbWkoFND
	MgK6QefiuspcEtjIORpktV8DeEiNVK3i6QNYLq2U/tcXtrJINXGjDELUSB6ZelYts+wAEJXWAep
	PAe/K
X-Received: by 2002:a5d:5f54:0:b0:435:95c9:6895 with SMTP id
 ffacd0b85a97d-435f3a72dd1mr23007611f8f.18.1770136291408; Tue, 03 Feb 2026
 08:31:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-11-roman.gushchin@linux.dev> <aYA4pH_nIBZ-ZhLL@google.com>
 <CAADnVQL5g8imKNGbHGQ4HA8_qNT4MYwM8P3aCTFUG7uwiuTeuw@mail.gmail.com>
 <87jywuwumq.fsf@linux.dev> <aYH21HhwNvWnFB8O@tiehlicka>
In-Reply-To: <aYH21HhwNvWnFB8O@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 08:31:19 -0800
X-Gm-Features: AZwV_QgPYD_QDDRHAxK8hl8lHjXdNa7m94_zYgqz9AxBSjsI0Bt6TxB1mrjzf8o
Message-ID: <CAADnVQ+uF4cTVYYOYBEDWrkLXJJkru_FaRttFskHRUpamktMJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/17] mm: introduce bpf_task_is_oom_victim() kfunc
To: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Matt Bobrowski <mattbobrowski@google.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 5:23=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Mon 02-02-26 16:14:37, Roman Gushchin wrote:
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >
> > > On Sun, Feb 1, 2026 at 9:39=E2=80=AFPM Matt Bobrowski <mattbobrowski@=
google.com> wrote:
> > >>
> > >> On Mon, Jan 26, 2026 at 06:44:13PM -0800, Roman Gushchin wrote:
> > >> > Export tsk_is_oom_victim() helper as a BPF kfunc.
> > >> > It's very useful to avoid redundant oom kills.
> > >> >
> > >> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > >> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > >> > ---
> > >> >  mm/oom_kill.c | 14 ++++++++++++++
> > >> >  1 file changed, 14 insertions(+)
> > >> >
> > >> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > >> > index 8f63a370b8f5..53f9f9674658 100644
> > >> > --- a/mm/oom_kill.c
> > >> > +++ b/mm/oom_kill.c
> > >> > @@ -1381,10 +1381,24 @@ __bpf_kfunc int bpf_out_of_memory(struct m=
em_cgroup *memcg__nullable,
> > >> >       return ret;
> > >> >  }
> > >> >
> > >> > +/**
> > >> > + * bpf_task_is_oom_victim - Check if the task has been marked as =
an OOM victim
> > >> > + * @task: task to check
> > >> > + *
> > >> > + * Returns true if the task has been previously selected by the O=
OM killer
> > >> > + * to be killed. It's expected that the task will be destroyed so=
on and some
> > >> > + * memory will be freed, so maybe no additional actions required.
> > >> > + */
> > >> > +__bpf_kfunc bool bpf_task_is_oom_victim(struct task_struct *task)
> > >> > +{
> > >> > +     return tsk_is_oom_victim(task);
> > >> > +}
> > >>
> > >> Why not just do a direct memory read (i.e., task->signal->oom_mm)
> > >> within the BPF program? I'm not quite convinced that a BPF kfunc
> > >> wrapper for something like tsk_is_oom_victim() is warranted as you c=
an
> > >> literally achieve the same semantics without one.
> > >
> > > +1
> > > there is no need for this kfunc.
> >
> > It was explicitly asked by Michal Hocko, who is (co)maintaining the oom
> > code. I don't have a strong opinion here. I agree that it can be easily
> > open-coded without a kfunc, but at the same time the cost of having an
> > extra kfunc is not high and it makes the API more consistent.
> >
> > Michal, do you feel strongly about having a dedicated kfunc vs the
> > direct memory read?
>
> The reason I wanted this an explicit API is that oom states are quite
> internal part of the oom synchronization. And I would really like to
> have that completely transparent for oom policies. In other words I do
> not want to touch all potential oom policies or break them in the worst
> case just because we need to change this. So while a trivial interface
> now (and hopefully for a long time) it is really an internal thing.
>
> Do I insist? No, I do not but I would like to hear why this is a bad
> idea.

It's a bad idea, since it doesn't address your goal.
bpf prog can access task->signal->oom_mm without kfunc just fine
and it will be doing so because performance matters and
static inline bool foo(task)
{
  return task->signal->oom_mm;
}

will be inlined as 2 loads while kfunc is a function call with 6 registers
being scratched.

If anything changes and, say, oom_mm will get renamed whether
it was kfunc or not doesn't change much. progs will adopt to a new
way easily with CORE. kfuncs can also be renamed/deleted, etc.
You're thinking about kfuncs as a stable api. It's definitely not.
It's not a layer of isolation either. kfuncs are necessary only
for the cases where bpf prog cannot do it on its own.

"internal thing" is also a wrong way of thinking of bpf-oom.
bpf-oom _will_ look into oom, cgroup and kernel internals in general.
All bpf progs do because they have to do that to achieve their goals.
Everything in mm/internal.h have been available to access by bpf progs
for a decade now. Did it cause any issue to mm development? No.
So let's not build some non-existent wall or "internal oom thing".
