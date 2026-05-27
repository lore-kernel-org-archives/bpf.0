Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D5041323C;
	Wed, 27 May 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889156; cv=none; b=FVCg/KGkCC+qFYyRqURd+1JBGRICCSwcCrkBuXoBVXxEO1U0rumcKn14da+6sWV5thEh0CI6NyMTLvI0K/YDVUIYpKF/23X/UqdS6MvP+Kldh8MXsWWNkvWKMrPvO3EDXEDuhygxOhR0lyFuLfUP+VhwE0rRTi5juRr5MSd1v8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889156; c=relaxed/simple;
	bh=VUa4ezsm+sM7f6tr8C2FQrWqDs6tQWk4TkROBG7Md54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E81GTzNhvBxLi02AvkcZnW1r+JgCkzFe0nmstaLkhPjDHUWFw/AvqcyfsRGtSJQrEgeLbsm07kDBJOzAz6YUci3s8xohwTbok3/wjnsUPSs9TrKHxtK9eAiZfp/rEcbbNAijv2idHgE7VRt2hHllAvB4Bff4Me6ADbzoVovZ7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKKpMEXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKKpMEXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FAA1F000E9;
	Wed, 27 May 2026 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779889153;
	bh=kOKieycg6JLArweYZ1x0gD51TGxxBSwR2EWx9wjuK3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VKKpMEXvs5zToqRQuyMN5ARMXXBosbq4X7f4jzDEoOqQcUO0v2kXzZr+KD6rd+zxd
	 umsqQgCOXFX1bN/5o7zt0MzHQoO8agCKJcDSp3KB8srdnvI7DR/yE0uNXvDBzOcQ81
	 vL6DcLfe3ZYx1XZVF57PmNE9ljDyGnV4dyCw/VmsKpB+trxzrdKebZqIgrQkp+T+r+
	 0Q8r1/mj8lAm1znSUBWovoc06nD4NVUHNYrDIipXOwmZZ48DXwJdWlm1j0y7gkGtdp
	 NZKTffgpHxI2d8XNw66q2OeJ7t0k3m0rVLIQAf4GIdIQMhi/QuXeEt/6LFTM7n5Kj3
	 o90JAa1K0+vIg==
Date: Wed, 27 May 2026 09:39:46 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, Gyokhan Kochmarla <gyokhan@amazon.de>,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 6.12] x86/fgraph: Fix return_to_handler regs.rsp value
Message-ID: <20260527093946.7a4286c6@gandalf.local.home>
In-Reply-To: <ahae7nkLYjXinDRZ@krava>
References: <20260526192324.79459-1-gyokhan@amazon.de>
	<20260526195008.897721F000E9@smtp.kernel.org>
	<ahae7nkLYjXinDRZ@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 09:36:14 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> > Because this partially initialized pt_regs structure is passed to BPF
> > kprobe_multi return programs via kprobe_multi_link_exit_handler(), and the
> > BPF verifier allows reading any field of the pt_regs context, does this
> > allow BPF programs to extract residual kernel stack data?  
> 
> I think because kprobe/bpf is root only, it's not really an issue,

Correct. If you can add kprobes to bpf programs, there's a hell of a lot
more you can "leak" than stack addresses :-p

-- Steve
