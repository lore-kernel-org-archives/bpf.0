Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAAA3C3C09;
	Wed,  1 Jul 2026 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782945612; cv=none; b=YkqPYqc0cWcHtwYmKxwJzSpipEVxC+o2caW92NXXeBw5qcYvDX6UwCUr+Qt/gnEPqq3JGnhhXFrdK2e7sk5iOMjrkTw5pSe566ZlsiStB6Ljk9fNMrAVR46mMzvQHfXNUNS8zMZbaaAkCNKmxLDjz3PCpJON9VpPx0sd3xojJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782945612; c=relaxed/simple;
	bh=B1kGvX1uwgZMy2KhnwcwCRKk1uNMqQ6IeFW4Pc7annU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Hx2HPs+DMtUVJ/mZMhVeENLw0LGzi33nY+VgghKLk7nvBDnKIy8An411AL5m1ZtaCfBD3E1PJpHUEAUU6ZsvkTyrzFf0hraIiPLLr55erf/yeN7zRUNPfna00i+t/jxZeHu8XoYzBljrse0PEh9ZVdP5ERvGJi9ZIYZBXa+phCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8rzhPgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8rzhPgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBF31F000E9;
	Wed,  1 Jul 2026 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782945611;
	bh=OLY48Ear0UIQH8cltbkZOUcSlqV0T6EvRRrPrfj1IEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E8rzhPgw5L3W0YPP1JUcOqX618LAWkIf1ex1P41D40g8JaFZE3vLwnOsrcYi9PRr1
	 /tj/AeoAGiWzYCZDzFKbDJpzikl7CP3/xSocEsMAPNr2cE/RnXtG4Nv0hsjiBx3USR
	 4KfCf3BEfAy50hC/2IyOSIMQ9miVi8M3AHa2Q4Q/7+DfUiSKOrJI09ePeVsI6+XFo2
	 V5rS7xF7argr8uThejzCrfiK89P7HXKnKwXlrR1uUd11g2BIPOyIBSW8rBB3M6kDG4
	 U5kAy3ogcZLPy9UaPh+y4/reGUebC3fL3DBBns+GnzfpHxPOw93HmVK8wTgCeXd0LZ
	 7988ToKm+hleA==
Date: Thu, 2 Jul 2026 07:40:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Shuah Khan" <shuah@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a
 single BPF program per event
Message-Id: <20260702074007.e1047c9d66cbcecc7d4ab3a9@kernel.org>
In-Reply-To: <DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com>
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
	<178291354144.1566898.14374948740441958770.stgit@devnote2>
	<DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 Jul 2026 11:41:26 -0700
"Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:

> 
> Nack.
> I really don't like it.
> There were days in the past when the kernel generating bpf directly was appealing.
> These days are gone. Performance improvements for fetchargs is not a good reason
> to add all this complexity and bypass verifier checks.
> bpf insns should come from user space.

Thanks for your comment!
OK, I don't mind because this is a kind of investigation project. And some
people had asked me about the same idea, now I can tell them the result.

I'm satisfied with the current outcome, as this development process gave me
insight into the implementation of BPF and demonstrated the potential for
optimization via JIT. :)

And also, as noted in the cover letter, the current performance of fetcharg
is better than I thought, and is good enough for debugging. :)

BTW, I'm also interested in calling the verifier on this generated code.
Even it it is not merged, I think showing the correct way to implement it
will be useful in the future.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
