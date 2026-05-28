Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679A3D47B5;
	Thu, 28 May 2026 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973405; cv=none; b=hLx4Wkjh2vNK/d6odHg1NnXTxyROrATsq+JM9MiySf6jla2YKl1aXqSxEOfHq0odL2cAwv+4AtE+02XdmAW4Wp0I849uG7t7gm05enqssHzSjkwRPJQi9MUK3xhVjbybvJ+sVgngo8pFHLPGMFtMoHcOu1Eav1p612MVnEA/WGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973405; c=relaxed/simple;
	bh=9WJNhH0EVFmLxpkfUQEdXAv6Qr1Xe/cF0N8uHZSWQJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lI7e9cWKxUIsvL5+zA2C6ETq2HDRv48v/UhivP5KwLl8fkt5WjwLANodwfyVtrbEvSpq8VStmx2wiuO157bddmvJlhIZXB7OrFYtRI0B3qRiRyClWZo5wzivHx/HdzJO7DP/iTgeZgmnYb7wEqHPUpo/WCMDkEOM+d/xJAluGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 79B921617BA;
	Thu, 28 May 2026 13:03:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id C7B576000F;
	Thu, 28 May 2026 13:03:11 +0000 (UTC)
Date: Thu, 28 May 2026 09:03:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Alexis =?UTF-8?B?TG90aG9yw6k=?= (eBPF Foundation)"
 <alexis.lothore@bootlin.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, ebpf@linuxfoundation.org, Bastien Curutchet
 <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH bpf-next] x86/ftrace: relocate %rip-relative percpu refs
 in dynamic trampolines
Message-ID: <20260528090310.6318e082@fedora>
In-Reply-To: <20260528090231.45d9b28f@fedora>
References: <20260527-fix_call_depth_in_trampoline-v1-1-1c1abc8ae310@bootlin.com>
	<20260527211135.GA343181@noisy.programming.kicks-ass.net>
	<20260528090231.45d9b28f@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: muuaah5p4xkif5bwgm8ja96fykbtxbpj
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C7B576000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186uQcE4RFDNUT/4Zg1wqr1e36BBeSEZDg=
X-HE-Tag: 1779973391-145890
X-HE-Meta: U2FsdGVkX18YlWmKGApzqd6lXNiCelfPTSMs7hn0672vvgUE9eJuipFfnZwmhH0dqr95TGK2Nhigvdj27c+5Kyqm6eS1OJ0u115tn015pnmB84oZc4bR4KCDDg87bCE3wg6eAAU2z3ofgxIr9SMwHp5I9dgbKe7+IR7zf9oq4QxXvVIiRNIu2yXlWa370fwwMUlL0VJSmhJ6WQcWVuZklavgW8hWxB+scEiMp+rMUtjqZZ7wUqw7ZrwkzTS4oQtem1Xns3soTc7hDE7JUMChAfq79sPi1WOKfqB6d8+YcI1F2Sudj3CL9snUOXALWsiQLPVLN6mfGEv3qbeYiAb9hG3UDMTO+HNSwTZQrpfv0adwzovpFFW2yFzt91Cl53crc4/LJf5BLy5mJtaSZ+Ra2pzWNG8OaAcy4f1tDYMe413vGpW9WZPjAYupov8eeOr/

On Thu, 28 May 2026 09:02:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 27 May 2026 23:11:35 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > I went and had a quick grep through the tree to see if there are more
> > sites that were missed in the conversion (commit 17bce3b2ae2d), but I
> > couldn't find another one.
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>  
> 
> Peter, do you want me to take this through my tree, or do you prefer it
> goes through the x86 tree?
> 

Never mind. I now see it is in tip.

-- Steve
