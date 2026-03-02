Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8A4014A7;
	Mon,  2 Mar 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464219; cv=none; b=aVD1/b7tR6YlvCcfZWm0EDyjXLrK3MxjcBsm2wGhuUSYYimuerAkbEsU0aYNpqMsfvNRVpGIHQm8SgilKpgmjgJyTnp9v6VIvu6d5YvuoRK9I9oUziEA8NQwtLaaz/4S5prhRyQaihW5m177vZHswMohE3UY/0SXgXkVlhgh4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464219; c=relaxed/simple;
	bh=Fo8AGgEEzophPRCLg2uWkd+i0mJGxmJxIyxa7Su84ho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/o3QT7ht/nBdNSYIKteEudc22MQiuzE1D9z7oHR01lXVHI0GjV8ROPM/qxiAFdrW05azLBC2e5gRiK6nELB6UwKX6hDFsQpdkyioBBo7xb1g+Uvy60bSfRAOx94ucTrekwRJaLpfF0Ubz6GKwSEtsR0IM0xTGXHMpZ3ZDazkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tb2tDcol; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb2tDcol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FC2C19423;
	Mon,  2 Mar 2026 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772464219;
	bh=Fo8AGgEEzophPRCLg2uWkd+i0mJGxmJxIyxa7Su84ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tb2tDcolb55tZqvQmfAaMmhbQ5a39mBkDUdVfODBy/jb7bN+6sJl3LoDenifihszL
	 W9hYruogmc8ellq52FKqN9YJnozp2dPjI2kcZQ1I3AZMdK8h+XlHfwa7h0et7/PErd
	 T4Jai7HRwUGSyNuu7raBEKQeCyxQ1X+8HVfvkV96pUAFpI2JxT3HFmqCX7H58C/3DV
	 ZpBeJOQwBVbBjtmKsdQRnTTWAw+WUsdUURdGX4YnOTAL51kkIdqgyBimvZ1qMB2HSK
	 ZrOmFE8qLDpy0ZWm1nekKktTUYeAk8ADwgPeP95GEENvd4hRnQJQPkcim8vJZk3bWt
	 5gMXNzay92m4Q==
Date: Mon, 2 Mar 2026 10:10:49 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Florent Revest
 <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Subject: Re: [PATCHv6 bpf-next 9/9] bpf,x86: Use single ftrace_ops for
 direct calls
Message-ID: <20260302101049.2614bca4@gandalf.local.home>
In-Reply-To: <aaVFeafZb76l9L0m@krava>
References: <20251230145010.103439-1-jolsa@kernel.org>
	<20251230145010.103439-10-jolsa@kernel.org>
	<1b58ffb2-92ae-433a-ba46-95294d6edea2@linux.dev>
	<aaIAoBZGkP7RQrvc@krava>
	<aaILlSuEgaYDq41r@krava>
	<20260228153921.19cd42a6@fedora>
	<aaVFeafZb76l9L0m@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 09:08:25 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> > As there's nothing after the comment and before the end of the block.  
> 
> ok, will do.. the original changes:
> 
>   05dc5e9c1fe1 ("ftrace: Add update_ftrace_direct_add function")
>   8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")
> 
> went through bpf tree, so I'll send the fix the same way,
> please let me know otherwise

As long as I give a reviewed-by tag.

Thanks,

-- Steve
