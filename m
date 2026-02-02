Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2831FE47C
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053437; cv=pass; b=X0FsJUzZQEIfT1H04rJObxbazLKlZA5d9K8T73ze0wdmfGagk5TZtBZ3M5NU5Bxfwz1XfLXTfMf61Xv5g5WgwtantrKJEPcl254paNrlIgB6bRd98uCFWiMDetp38eJT6DdxHGlpd7TLDFqHP2cQ8HB2QZEEx+BotGcDTWzEBGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053437; c=relaxed/simple;
	bh=xHRU6/bNj6+uMnq9mihk8grlPO8m7SSjW+LH/3QX3RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXCFFUCkBZojSJF+ZHpZN0oW8OmDFZnDHzeqjybnJTJt8Gt1nq7THqtlyTgfE9x1fJom04s4S8fqkjj8DBxiRDSW/51+tBIYyC4RVehvjrVqKBpzxzzgzuwkA+/IifFYpUCa8AywLps8HjDgQZC4Y/+Jj3vVjA/otl1GE6xbgAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2mYyqRy; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2mYyqRy"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359a16a400so4051355f8f.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 09:30:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770053435; cv=none;
        d=google.com; s=arc-20240605;
        b=g1HjGVi8vdrDgZx8bqnQC8KUVSX/v5cxNJ3CmLcS9/DnHM75ypcXHyhLWSF7yTyGIr
         gXsuxeF1NTv8+s3GtzGPxZSEDZa46lzZUdxK8n32pBZ8Jj+3HkXtjrE4/orhHxrcWS0A
         IvqRFg0wiYVS4wzDtQ8Q0QBZzXbRnYZPBu6iH+mE9vZv/6mlLGrcHnGTF3OlNLtl9ADj
         M1WF/aCi+oHZ5JHvScyBymz2CrDyRhtyaeVrv4u14ic9p7IVdJ/EA5MfyrAtt4uCYV3Y
         AAuXtflj+OvA3T0LG/AWBSLRGlaEoidfS7QRnhLp25k0iLwBVX/SlGGMdp+axwYcGIOJ
         b8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7xld51LHMG18KNiYZotetpk23zS9dV8htqF6ZY/bre0=;
        fh=JbTsXoB07mo7G82j/2SAaAFPmvlgSLjvx+Br23H59ik=;
        b=bCnuzLoDbmYxxEO5Ck6rIQQ06H5UjA6d5HgyhVbH9XTSizJtXILnaQB6fCyswNNRdq
         ims5oNsxcpPZxXKOg0fXenFyQkbKsvlg3qJdScDKIyIqRuSTdQl79SaQhysw+Px4fNAv
         Xk5PrZmT9TtwzPCFLKWZsMWqq51gqB2y7Lt76U1a7B7OKzfMIdw4KUTAUVIo3KRPiC8T
         KdqXoGuEc3PAj4ooJ3HOhoFNM+NH1gazPqhmQEGs6LRStiUK694Qv/tARio7OiNNNbxV
         wjg0ihoNQFuankjNKoscm3WTyJ/JCafro4hOrZgl04B4AMqbU7F6FeHxBK1qpEko2jGx
         /Cpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770053435; x=1770658235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xld51LHMG18KNiYZotetpk23zS9dV8htqF6ZY/bre0=;
        b=K2mYyqRyMlhVTd1/Vxudyfk2+sMJrnCNoDVgr5qsO/jJF1LvaMZgCkdhk2UgPp0VY6
         6PpM8qLeQpxvFy4KbyySHGMHRW323X+hCYTnSsRy0oxH/Qn9u3PSaW2RNPrAi7l0ulh9
         p3j5UlJ613iq3uMgSRAA++EYXVczo7qGVpG4yrMjt6Tqp/k/Og0g45XUrJlphBW7pdLc
         4n7kJTIQTLYkoD+heHd6SUe2fCtBP7YkTKBliaUZLVEUVo0y9KD2XyMhBPlWMdJlEiDW
         ZtDtNRoiaFDDKeSAq12JBMLOFNEtwmZRh2V75hIBvJxFVyrXtH0sfz5cPbUOfrDeFlgU
         ikiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770053435; x=1770658235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7xld51LHMG18KNiYZotetpk23zS9dV8htqF6ZY/bre0=;
        b=hsR1hAORrfvE3xByZzl4NzWpqQ5GCBJZDz89o9uzA8at6AA/nGi9Y4VCgbhC00hqin
         tQMQAPwcW2VrFDvLUX4kda14K21PlLzl00aqaCUbmnnAIzC9xGOvQh7CgAArmgwgvQM5
         nFjSs375efpQUKXRV7TkqZJEBoqExQj5X/r6QwsmL68buGWLs+PG+NJQvMbMEGm6fFEV
         2P8xJ1W4pLym0pczQHIQT1wKAnDlbu2sG1jEz9V912/Ck5CNvCr+p5GKlcJm2+Cksor3
         WTE1P6SN7kTH4X/qMM3Kw3ZJrLhYZG97Cm3fUkksplkEPgJhvkcM8O1USnE9ABZc2Liz
         aMGw==
X-Forwarded-Encrypted: i=1; AJvYcCWKDcP4EA9fjSeOixq7nw2ZyasfII7wnoTovIS8OogVyT1+9M/4vdl6I/vPY0JT05BaU1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGQIR8bANkqMYStw0v/QWz93KOKTJ0DRahPomZuJ8JMVL0jJz
	Hr9wg6sgT3BrhFu8MLOUCzTTMhrq87ZqLo8iGlzvQ485RZdxBnx0hG8agnUJ4ug2cEzsJuaKQYe
	tM6lRQhtFUrem1dqNuTEnv5W8N6xmHa8=
X-Gm-Gg: AZuq6aKtrMDFSpWe/0M5mNfGMTNOHvw52OrVIBEIedqPTKzjOHH9iey95hkw8oiGYVb
	7joyd7Q+2JqI47Ce4I44S0a1JTIlMqzxpVRKc5sOAOj9QehfZfu7etJtd+TdfsX6tOHsW1TAKtx
	q6OaEAe5iGUYFfQefUThn1SV4IBurSn5ZWj4BKd5rUVkBmFBJcMmWyWM2eJy5bDMJ+6VLQIqHpU
	/9dBzyuEgLWdMOKROPi+5gR6uIn63mL4Ym8gSHbUmqv43EPYi3jZ8JWixNtqHJk8P55PG6IS2be
	I2Syuoqh4nzi0ICAXC0ztBGUWlOg0P8f4kvflnPucBuEu815TGVKQAQxaHUJXK6dijLY7UDQ
X-Received: by 2002:a05:6000:1861:b0:435:dbc4:3af0 with SMTP id
 ffacd0b85a97d-435f3a9181fmr18606086f8f.14.1770053434861; Mon, 02 Feb 2026
 09:30:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-11-roman.gushchin@linux.dev> <aYA4pH_nIBZ-ZhLL@google.com>
In-Reply-To: <aYA4pH_nIBZ-ZhLL@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Feb 2026 09:30:23 -0800
X-Gm-Features: AZwV_QhcSxBOzKmir8YnJuWGB8mK-DNJ9JY3HMjEXt_lprjX8IPmESFpgJWBbyM
Message-ID: <CAADnVQL5g8imKNGbHGQ4HA8_qNT4MYwM8P3aCTFUG7uwiuTeuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/17] mm: introduce bpf_task_is_oom_victim() kfunc
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 9:39=E2=80=AFPM Matt Bobrowski <mattbobrowski@google=
.com> wrote:
>
> On Mon, Jan 26, 2026 at 06:44:13PM -0800, Roman Gushchin wrote:
> > Export tsk_is_oom_victim() helper as a BPF kfunc.
> > It's very useful to avoid redundant oom kills.
> >
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/oom_kill.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 8f63a370b8f5..53f9f9674658 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -1381,10 +1381,24 @@ __bpf_kfunc int bpf_out_of_memory(struct mem_cg=
roup *memcg__nullable,
> >       return ret;
> >  }
> >
> > +/**
> > + * bpf_task_is_oom_victim - Check if the task has been marked as an OO=
M victim
> > + * @task: task to check
> > + *
> > + * Returns true if the task has been previously selected by the OOM ki=
ller
> > + * to be killed. It's expected that the task will be destroyed soon an=
d some
> > + * memory will be freed, so maybe no additional actions required.
> > + */
> > +__bpf_kfunc bool bpf_task_is_oom_victim(struct task_struct *task)
> > +{
> > +     return tsk_is_oom_victim(task);
> > +}
>
> Why not just do a direct memory read (i.e., task->signal->oom_mm)
> within the BPF program? I'm not quite convinced that a BPF kfunc
> wrapper for something like tsk_is_oom_victim() is warranted as you can
> literally achieve the same semantics without one.

+1
there is no need for this kfunc.
