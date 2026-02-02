Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188328635D;
	Mon,  2 Feb 2026 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044092; cv=none; b=OOH8lb6D/snFugupvuqjU/C7CZHcH3t+6vOPeAO0ocEIIxTFIhVw7KhK4Di8KjWejW1RqIJXVNpxdkjbnOMQs4tQDvLPlJxIDcCMAadQQ8nBGL5gMYK+i3MZhwcV1/tCZVM+4RgfeqccDJkQ9VEpLC6KG9sc/OvJ5TxyuYDzKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044092; c=relaxed/simple;
	bh=PciqbNAgGJ2BuJgZbKqtIT7Gn3ClMwCddqRYAXV9jl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJA6bDkTww+sUbyyvDPsdARikzniBlsRuo56Vh3PyFtwEO00IxI/OKEyPS582zPMqB3uoaKtnVAJde/OZMic/lHhqNUa+Ole/MJ2hZb/ZDKpEPOOYoxRQWT+i44vZHKVqny9dOpiojOlakSl/h4A2g/zoanjd7QXz+/rzrEpLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmLwSHpN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmLwSHpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6500C116C6;
	Mon,  2 Feb 2026 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770044091;
	bh=PciqbNAgGJ2BuJgZbKqtIT7Gn3ClMwCddqRYAXV9jl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EmLwSHpNaIVRZu6wx74CUVVfzppUKrMCCD/NJDFwtdfUzG8sIEuluvZCTigPK2v46
	 NW5fUVQQw5wyYTC7RjnJ1JV38jQHAZ0oPBnLOxhNg2YsIWmSS4JeI2plkbCbreybT1
	 Z6PMOe7yqyR4qldgXuWdPZef/za3jbjra+Wr4WJu4fwwH4Pr8dgasSXU2DexKbaHy3
	 X0KAbn/6hLWDnzmT/A047Diz+m/Sqg58NJNynr+/Z1nhHcNOjAkT290Z9bw7KdPqBw
	 ff7+O98iYWAFaZ55AD5erguvPOIdBUiPkuACVeAIqxsicoTf5Ym8b090OpwLxFuIdt
	 o1GIScBiTdIhg==
Date: Mon, 2 Feb 2026 09:55:15 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH bpf-next] ftrace: Fix direct_functions leak in
 update_ftrace_direct_del
Message-ID: <20260202095515.5f438287@gandalf.local.home>
In-Reply-To: <20260202075849.1684369-1-jolsa@kernel.org>
References: <20260202075849.1684369-1-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Feb 2026 08:58:49 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> Alexei reported memory leak in update_ftrace_direct_del.
> We miss cleanup of the replaced direct_functions in the
> success path in update_ftrace_direct_del, adding that.
> 
> Fixes: 8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/bpf/aX_BxG5EJTJdCMT9@krava/T/#m7c13f5a95f862ed7ab78e905fbb678d635306a0c
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> ---
>  kernel/trace/ftrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8574932e66b6..b12dbd93ae1c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6537,6 +6537,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
>  		/* free the new_direct_functions */
>  		old_direct_functions = new_direct_functions;
>  	} else {
> +		old_direct_functions = direct_functions;
>  		rcu_assign_pointer(direct_functions, new_direct_functions);
>  	}
>  

