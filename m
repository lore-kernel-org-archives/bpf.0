Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED66EADC
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077689; cv=none; b=c8sghl6LkXdSZhZd3n+E7pnTeQuFKd46dDEvzoeomzLuCurDmf08cMXPXBvJwtewlUbGxDr4WFvpC2CZF5RTLSZUyFqUrKCLmEIyVAj7ECcpnUjDCVP6pQ90OGeJdEx0iPu/Ap50n+VxZSwx0melAdAIlpFoLfkEI6TMyZmwxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077689; c=relaxed/simple;
	bh=Y28HJY0iodlcCHCfRKfscVKtonnBBi5sgfeq5IYe6QQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k9y2MKpvEwqQy7BEayfJNU8ylzxu6bx3Q7KsJtFREW7Lp3Z3XcHkLtVgbdVfVFtY+g+G+xgdR6SsD+v3K2bIJmL/309gkY2wqAahxPoZCpEryRiMaOEXC6sR7yw+MWOzJWFXrYY5umA1aXJKw6+uNP3kmwbWfpsSAI6OIgwtVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=spFvYM5S; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="spFvYM5S"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770077684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UL5TkTKpwfsk57GsEmn4YJixM6/oQfn+MbPgW31S17c=;
	b=spFvYM5SuR1aK33Y9Zg7Cn9Xqh/rBPTDdvWHRoUiFbG0+KEXd75LEfzQmvuXRAP0CEMz74
	3OTta24r/6f555bLCbR79g70lZ2gIrFcrmQ6HQs8FkOmG6Ttzq3obI4umAEhraTtmKL+Om
	y2jvsjD0kO2WoqE56etQ/rIYmN1/njA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Michal Hocko
 <mhocko@suse.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>,  bpf <bpf@vger.kernel.org>,
  Michal Hocko <mhocko@suse.com>,  Alexei Starovoitov <ast@kernel.org>,
  Shakeel Butt <shakeel.butt@linux.dev>,  JP Kobryn
 <inwardvessel@gmail.com>,  LKML <linux-kernel@vger.kernel.org>,  linux-mm
 <linux-mm@kvack.org>,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 10/17] mm: introduce
 bpf_task_is_oom_victim() kfunc
In-Reply-To: <CAADnVQL5g8imKNGbHGQ4HA8_qNT4MYwM8P3aCTFUG7uwiuTeuw@mail.gmail.com>
	(Alexei Starovoitov's message of "Mon, 2 Feb 2026 09:30:23 -0800")
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
	<20260127024421.494929-11-roman.gushchin@linux.dev>
	<aYA4pH_nIBZ-ZhLL@google.com>
	<CAADnVQL5g8imKNGbHGQ4HA8_qNT4MYwM8P3aCTFUG7uwiuTeuw@mail.gmail.com>
Date: Mon, 02 Feb 2026 16:14:37 -0800
Message-ID: <87jywuwumq.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sun, Feb 1, 2026 at 9:39=E2=80=AFPM Matt Bobrowski <mattbobrowski@goog=
le.com> wrote:
>>
>> On Mon, Jan 26, 2026 at 06:44:13PM -0800, Roman Gushchin wrote:
>> > Export tsk_is_oom_victim() helper as a BPF kfunc.
>> > It's very useful to avoid redundant oom kills.
>> >
>> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> > Suggested-by: Michal Hocko <mhocko@suse.com>
>> > ---
>> >  mm/oom_kill.c | 14 ++++++++++++++
>> >  1 file changed, 14 insertions(+)
>> >
>> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> > index 8f63a370b8f5..53f9f9674658 100644
>> > --- a/mm/oom_kill.c
>> > +++ b/mm/oom_kill.c
>> > @@ -1381,10 +1381,24 @@ __bpf_kfunc int bpf_out_of_memory(struct mem_c=
group *memcg__nullable,
>> >       return ret;
>> >  }
>> >
>> > +/**
>> > + * bpf_task_is_oom_victim - Check if the task has been marked as an O=
OM victim
>> > + * @task: task to check
>> > + *
>> > + * Returns true if the task has been previously selected by the OOM k=
iller
>> > + * to be killed. It's expected that the task will be destroyed soon a=
nd some
>> > + * memory will be freed, so maybe no additional actions required.
>> > + */
>> > +__bpf_kfunc bool bpf_task_is_oom_victim(struct task_struct *task)
>> > +{
>> > +     return tsk_is_oom_victim(task);
>> > +}
>>
>> Why not just do a direct memory read (i.e., task->signal->oom_mm)
>> within the BPF program? I'm not quite convinced that a BPF kfunc
>> wrapper for something like tsk_is_oom_victim() is warranted as you can
>> literally achieve the same semantics without one.
>
> +1
> there is no need for this kfunc.

It was explicitly asked by Michal Hocko, who is (co)maintaining the oom
code. I don't have a strong opinion here. I agree that it can be easily
open-coded without a kfunc, but at the same time the cost of having an
extra kfunc is not high and it makes the API more consistent.

Michal, do you feel strongly about having a dedicated kfunc vs the
direct memory read?
