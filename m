Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4270429D270;
	Wed,  1 Jul 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931654; cv=none; b=rI6N42oeidn/28VJC/wlyWzY+QGBwsOVeN6cTKKLTrcnxfr6cPEIKub5MCZGEYfrojNXNeP/wiZz5AV4kYkRbI5iAadJKBYpRd6hLUVtp1utfjokOyZC7tHBPLB7TmqHJs1klyqjkqOh1SsFPSm4AuYXuASV2v6kkGNIgW9OGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931654; c=relaxed/simple;
	bh=Bv4eIIhD/UW5raHnrH6IUEqFqPOnDoBJnz9Uy1BFplE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvXMfZSCxP8f/FFjmy0wnoYTCGx2KDEJJcYtfn7iQ5op04hI2rTEohHamK6cc1Y/B689ZIVUopuKOEftu4nf1asIK62Ci8wjX+FS+3K3cYZV2GxGMC9F94ZsmtMfLs3AjnMzt6xRysa1B8/bbXTyibTvcD+SSWh+8tbe/0ME0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 8E973A0491;
	Wed,  1 Jul 2026 18:47:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id AD6F120010;
	Wed,  1 Jul 2026 18:47:29 +0000 (UTC)
Date: Wed, 1 Jul 2026 14:47:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a
 single BPF program per event
Message-ID: <20260701144726.0a5f2204@gandalf.local.home>
In-Reply-To: <DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com>
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
	<178291354144.1566898.14374948740441958770.stgit@devnote2>
	<DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: AD6F120010
X-Stat-Signature: d56td36c4g4yztnbxcxgcxpcmqb9us74
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18mX5lUMeihXGfja00fI0x1iyJPCxtIs7c=
X-HE-Tag: 1782931649-832966
X-HE-Meta: U2FsdGVkX1+59Ncl33seKpTxr4/j3s9L28VIw8Vo/gOgnKZTX+TG8JVTwXcDQnsmFA706q39TlcVGTznfwnPWq49fXqlG3EmZaR7dWAVmaSkxg0zyTDRDxFX5Qphr0LrKuZZGqWOcOpnqvXljQ8Txm4ytZ5pckRAFowpgxD/UaNKhWE+XXrJH96rJSSLbJn1LVUXA7xxMtzDnBCcQHi8dKeEoxXuV21oXdRRD3o0jXFewU+jR27yMwP0N2AbECnDYNHKUSaC/eXDzxJ83/36WldmYMtEEp5SigVcNmcSJMsYtAot9kNK4dRIwSiOKG4vMtivrwl4ZZxQ+/qQgEXsy/8ah1HZdampCEURku5vdVf35uxTOKAL3w==

On Wed, 01 Jul 2026 11:41:26 -0700
"Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:

> Nack.
> I really don't like it.

So the nack is mostly your opinion and not technical?

> There were days in the past when the kernel generating bpf directly was appealing.
> These days are gone. Performance improvements for fetchargs is not a good reason

Why is performance *not* a good reason?

> to add all this complexity and bypass verifier checks.

The code lives in the kernel. What reason is there to add verification
checks? The point of verification is because we don't trust user space. Why
do we not trust the kernel?

> bpf insns should come from user space.

Why?

-- Steve
