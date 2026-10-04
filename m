Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA93F1066;
	Sun,  4 Oct 2026 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791100651; cv=none; b=Xz5Uy7TlV0FrYUfpeq8MQzpMBnKNZ10VTSSkuYw/vYWccUpIcbq12OrnZ1LK0UG/1jSh8NqcnGj099IZRydU+T+EC/Z5FeK7TXRAEy7t/yLMBJz7M+fEqk2NOBVrw27lLRSMITqd5IFS4khH9JO9vZe+0ySFfMy05BZfBHBgDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791100651; c=relaxed/simple;
	bh=cWRUSCajbfvHJSbiVni+phIDP8PbtxGCI9qcqyjZAT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCiUhe8EqxmqPF5XWCzE7Qksj++zidznYoERn8d+HiKrTe63LyXpDG4JpMw3WWVXdVuwkStW/vt+986ZbVUEfNJ/3GLg7ufpKK3mH+MA/daiih0qC2QPbQHjzcgDsZGI06asLhbrHA07sRsjdjvhZsfZJ1T3wpEmpRFaOl9LFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=BNXcJi7e; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="BNXcJi7e"
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id EE7CC160989;
	Sun,  4 Oct 2026 07:57:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id E2B9320026;
	Sun,  4 Oct 2026 07:57:17 +0000 (UTC)
Date: Sun, 4 Oct 2026 03:57:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Nam Cao
 <namcao@linutronix.de>, K Prateek Nayak <kprateek.nayak@amd.com>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>, Viktor Malik
 <vmalik@redhat.com>
Subject: Re: [PATCH v2 01/15] sched: Add task enqueue/dequeue trace points
Message-ID: <20261004035714.18140850@fedora>
In-Reply-To: <20261002191842.GA1259248@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	<20261001152042.124445-2-gmonaco@redhat.com>
	<20261001154934.GT88198@noisy.programming.kicks-ass.net>
	<d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com>
	<20261002102939.GB2823843@noisy.programming.kicks-ass.net>
	<56972260b9221128d7aaf5bb60f90611ec9d7235.camel@redhat.com>
	<20261002191842.GA1259248@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ydicuos4fb8ico3fiuf17rk1zwchge4k
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E2B9320026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19XabwMwepFqKiJmq/gk8SU/BbFu1jBaT8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=cWRUSCajbfvHJSbiVni+phIDP8PbtxGCI9qcqyjZAT0=; b=BNXcJi7eZMssjzjWSmOxCD++e5gz7Tu0t7TgS/ZdRHX+T8XQmpEpl4kDuuUFmRlfxMDdYwbq840yVjyoADMLSu36lc/N6f0fGd+XSgCb+KoPZY0AlChDcH9P7hnijAla8FihrKkv6cGzxO6HTEBUJ1iqwom1FIEk5OOuijYrelQ=
X-HE-Tag: 1791100637-569589
X-HE-Meta: U2FsdGVkX18KyVQqFbsby1yYXb8vvGjrjnxJSWYTGFO8IBjY77l2VVOFHsMWOT4ePOoPmF91Zq6w/5/d7fSXzaMS89DHDJ/0HWfRb1giTYIlR3pzYSAWfkDbrj9gEuXNrBkFtPmv/Oc5EALV+yjtLdxxWD/xfcv44gOX44B8PNM/4HwJrN0N+IGXeCCyxVtllAa3qaMqU/4wQFiNW0V5nzW+iu4MA6LyIMvgXJBcRFGM1P/seLSC8ZzWfbrIg5slPXyuuWdc2DhVZ0MyHKdQ1Fya7CuSAJta9jdfWQNdCZZyCVfXalKJuaz/mj0OilflAL0rwbVbEcTPxG1yLLdSNMtugvharFXNSHT9Iu8Ftq172oREAjAnDbzslhZNSzzXMauvkUU6y+CymlhTf4rQdg==

On Fri, 2 Oct 2026 21:18:42 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> So personally I have 0 interest or use for html. Mail is text, code is
> text, we use a text editor (neovim is my current poison of choice).
> Nowhere is there html. So then having to look at rst is just crap. rst
> gets in the way of actually reading the thing. All down-sides, no
> up-sides.

This is specifically your opinion. I really liked text files, but I have
fallen to the dark side and found reading the Documentation directory
from docs.kernel.org so much nicer than reading the text files directly.

I think most people feel the same.

As for Cc'ing entire patches, if I get a patch series Cc'd to me in my
inbox and there's one or two patches that are supposed to be for me, I
ignore the entire thing. I'm not going to waste my time trying to
figure out why I was Cc'd, unless it is obvious in the cover letter.
Which in most cases it is not.

If I get Cc'd on one patch in a series and I want to see the entire
thing, lore is beautiful. If you don't want to look at a web page then
b4 is your friend. But since there's maintainers that want everything,
I'm constantly Cc'd for 23 patches where I need to see one. Hence, I
hit delete on the entire thing and will not ever see what I was Cc'd
for. Why should I waste my time on that? The burden is much higher to
read 23 patches to find the one you are looking for than when wanting
to see all patches to open a web browser or just using b4. And no,
seldom is the subject line obvious to why I was Cc'd. I have to
actually read what files each patch touches to figure out if it's
applicable to me or not. I've done that too many times and don't have
the time to waste on that anymore.

-- Steve
