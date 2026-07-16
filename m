Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CACE37E5F7
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784241058; cv=none; b=aJXTQaEBe8qdkAEfrp5JO993z3+Jao8hSLm5CfmI3AH5ca/dIcqPCjXiUmClpYAxcuuqB2JI0cj31SzzgMW/GxXM76f4mEosMaRF6ZYt5ypb98MwOWQ0Te2oYKf1E4NxiCnQx5AvMQ1OLcQq+cWTznthFeYmVVoutOtYbeAT9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784241058; c=relaxed/simple;
	bh=ot1GNo1gVRyZJWP8njVcEz1T81CPSxx4Z/T3i2f4BGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFRLelEh8/2bige29CUyV71fdokHVvxlXNTIRT1PXQkMprpMVX3asWSc9C0etN5anRO9d+pNUZ/pgLzgxXloP6TFvzZrfdWahbXhfeUR0y2ynGX0p2RIreSabRRWfnrR/EEhahCgKW91VV8ithBJFVJwP8zpBrblqgw2gN22xsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4IVdNB5; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4IVdNB5"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so5626991a12.3
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784241056; x=1784845856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jnQqVHT9mIlQjz4b13IFWBpUZI0AFofijg1xz6XP/Fs=;
        b=o4IVdNB5cHZDi+biVvBttG1Zw0Vu+InskeepJSSBxtDHg5MMzvKpMNgQ5zNk8852r/
         pjDZTg2slp+9q23Kho1lK+cOvr76zuJcr/Ys7yY0Iqm3ljCbkDeGE0aeOjMqnIf6vhJ6
         9rARmYehh5KaW36z0TdnShite12LHFAvCC4VsUQ/yeZAhjZjOHvPO/nC9UDrHsy4UxlU
         8B2Ye0tmn/DfW1gN056pbObzCUsOTqtRZBYZhixcveyF4R0G7gJCuAjiAl2M3I4HQ1Uo
         0ub+5ovo69NWiDUJCNxEqxYIfXskeCiovyeT8M1tVhzNeWdY1GSg3wjiOddxYxxfq/9x
         EWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784241056; x=1784845856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jnQqVHT9mIlQjz4b13IFWBpUZI0AFofijg1xz6XP/Fs=;
        b=aCEL7NAsXG9GHP8NkCEUQR675KckkXw9bv6ivuPvS73Ge/xrYjUdKDBhufxRg+5cPj
         KiZop+y71mBog4pc3x3plDTqN9xndybfHjDbwMj0UrUlyL43Iz4Jjn7nEA0B0HT8lbM6
         2goytHABR9XFutNJdmy4a0YSlCebkWhYa9eoC0kn3tMEpEnAtTXP3rIOrxAbMOALwpl/
         wMJg5JAhV/PT8ccOB7uAC0reSF16xT2LsrtVfBUPVBFgUwuWCT/mlWENXndhWee3e9Mo
         MoKp496pjS+QlWciTzlVJrXjj+yvJEFwBd1VAMlY5KLjUPARjIOaLG/8TY7YDG9ZMoTm
         PNHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpqncxkAE5PTXrrmU8t2sMalDvh+uIwvssE8cHUfjN6z5KoxFY9SKoKedb0J4AoOvh829A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaeCr37yLA/vgaH8dzMdMElmbKhRgUCpIODYmTB6QoJmsNArjk
	tbqjFG8wZuY0o1ckbc8mZFolCoLF96+DYSr3RRZ75vf6DXmkQ4ux0Loz
X-Gm-Gg: AfdE7cnQbtggI9BIFKmFUg2V47M32P+rmf6WJCtC6xV8zxJ4uqDBbBTccpuswh+GBQK
	hybdJuq2bmMg653KwuO07GlvZEklDfKoihjkKH7TtTeQ5c/PusmLsIaJN6nqNVhqf/oFo6eaEp+
	I/7ukqaZ07Wlm542rM4pHgJbnoJjtg9/LLnta/Ygc/ssxH7wmREX50Z8W8HRjrUEvnDTokxx47t
	JMp7JLOkc4WLOMJU22pMChywTMMjFKsmOm7eLzR/X+9NbXRUDhE8rUR8t+JvtxXJIQKZXBihVkr
	9BCgqreqgCLXy+PtuqrFhY6OlKTr74B3C8np/Tb7TSdyzEfHKYHpe/7SU1liTDEqM83PdFfRzLJ
	RvN6brOviSAfIbS4qaigtQLu/9MKnHjM4/oi3wkONaKeMv7zA9/JMLYxeuZ836cg4pQiXNJ+N/w
	cNZpFbWXhrGmb352II0cet7XnNwDAJMC6fAKN8TZn7kBw=
X-Received: by 2002:a05:6a21:7103:b0:398:837a:7af0 with SMTP id adf61e73a8af0-3c36c1e6ac4mr9446805637.30.1784241055983;
        Thu, 16 Jul 2026 15:30:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:38ea:b937:53f6:928c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d444sm113394eec.6.2026.07.16.15.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 15:30:55 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:30:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Theodore Tso <tytso@mit.edu>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Derek Barbosa <debarbos@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Steven Rostedt <rostedt@goodmis.org>, users@kernel.org, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, Stephen Finucane <stephenfin@redhat.com>, 
	bpf <bpf@vger.kernel.org>, Chris Mason <clm@meta.com>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: Linking Patchwork with Sashiko?
Message-ID: <allajcbLlV5xwfXh@google.com>
References: <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
 <20260715163921.GH1778116@killaraus.ideasonboard.com>
 <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev>
 <20260715190654.GK1778116@killaraus.ideasonboard.com>
 <alfwOgVRgUJYOGtU@mit.edu>
 <ef9f77c613a05c5745941587099eeb4f159d5e31.camel@ndufresne.ca>
 <alhMB7vGodoewjcz@mit.edu>
 <cd791ba9f1819528a9a964ae2ae3833c8e6c4b87.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd791ba9f1819528a9a964ae2ae3833c8e6c4b87.camel@ndufresne.ca>

On Thu, Jul 16, 2026 at 04:54:37PM -0400, Nicolas Dufresne wrote:
> Le mercredi 15 juillet 2026 à 23:53 -0400, Theodore Tso a écrit :
> > On Wed, Jul 15, 2026 at 11:00:54PM -0500, Nicolas Dufresne wrote:
> > > In V4L2 m2m notably, there is a "job" in the background, which allow
> > > to safely (at least this is the theory) chain up work, and
> > > synchronize against pending work. But Sashiko (and other AI) seems
> > > to not get it and state with confidence and long explanation that
> > > the drivers are racy and should do X/Y/Z more on top (and never
> > > blames the framework).
> > 
> > Is there actually a race which is allowed by the framework?  Or is
> > Sashiko's proposed race actually not possible?
> 
> Not that I'm aware of, as long as the driver follow the conventions. A typical
> occurrence of this is when Sashiko suggest that you should do an extra worker
> cancel after streamoff. The framework already ensure, through a job wait
> mechanism, that there is no more active tasks. This allow chaining this work
> across workers, and one really done with the task, the driver will call a
> function to finish the job.
> 
> Though, AI is also fed with code using the framework, but not the jobs. Venus
> and Iris from Qualcomm just leave the job running, and manually tear down and
> finish the job on streamoff. So when AI use that as example (or thinking model),
> they conclude defensive coding is needed. I bet that if Qualcomm Iris/Venus
> developer where to review other m2m they would provide similar reviews. But they
> will likely add words that show a certain level of uncertainty, very unlike
> Sashiko today.
> 
> What happens is that developers endup producing defensive code for cases that
> will never occur, but it can go as far as refactoring and putting in place extra
> mechanism that are simply duplicate of the existing framework. So we receive
> more complex code, with convincing comment that does not reflect any real-life
> scenarios.
> 
> Now its not a great mechanism, since its easy to "finish the job" and keep
> working, which can make the driver code run concurrently with a device_run()
> from another thread. And for multi-core drivers, its easy to forget that the
> framework does not protect anything concurrent inside your driver.
> 
> Sashiko is just not doing the teaching that is needed for new contributors, or
> for experienced developers handling slightly different type of HW with this
> "problematic" framework.

So I think here you need to teach Sashiko a bit. Submit a patch to
https://github.com/masoncl/review-prompts that creates
kernel/subsystem/media.md and lists all fine points of the APIs and
common pitfalls that driver writers are often fall into. That will steer
Sashiko away from suggesting hallucinated or impossible to happen
scenarios.

Thanks.

-- 
Dmitry
