Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CF430B89;
	Sat, 28 Feb 2026 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772311173; cv=none; b=UuAMIB5MMGSwIB7p8sDvPfIPQ8n0fM+x5eNhPGb7AIuN/f22hQuBaSz028S6hULnhdzO5UW/XXDuwagvORI34myjB3mTVdqc7llMoPN8v4p9g/+lizx0T00tqjQ+cV+w/9iQylliIsbVF9ZVvYZROTnnuifIjJaualxiJhRaxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772311173; c=relaxed/simple;
	bh=ULNZ0C8qGN2aPpdVL3K6v0ACZP6yR6VBVGm/r7eaO60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rl+JzF5SAbfN0jHGvmzH133tyMZrz/ZXNqUn+FKqlVdTZfjFAQi/TWPLd8/8YGrWC9UTzqNQuZ9nzH9mZXg8DRsk61lHc6+bUlVTrwMyY+bXXRPtCOETSWg8z8SnmalZLozTSp+R1gLAyDA7uIec4hyEnKd9wMf5ONRs/uTuuMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N24SUBqn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N24SUBqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3900C116D0;
	Sat, 28 Feb 2026 20:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772311173;
	bh=ULNZ0C8qGN2aPpdVL3K6v0ACZP6yR6VBVGm/r7eaO60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N24SUBqnMxlUXDO08DU/2iTjZvmxfP6Eq49VKQknevovh0PlBMzBuBW9z0wrZderH
	 +ZTq3t7fWJdzasFy5I8Avz20G4VMOGrU+Solg1bhlWxbhfluNsD4wgQ1hOfV34rdRE
	 JUfLbLY+8/iVNpUyYaWyHlJr2mk2QYDwUtxDFbvP5o9d6KeJRWxeLMcStK11PyKD45
	 noAPyaYmYvbr/5IO6jDPFFmCtWte32yd1BiKB9N92zP3Yx7jY7BhttbBg0rRfSrSXx
	 z2O6vWRk6Ze0AjCD2dCYqkO6vSHwFO3YdGCeV3hrSOTnc/0Uqt/sxRDSbYGB/zL/JS
	 ICK9k+cj9L63Q==
Date: Sat, 28 Feb 2026 15:39:21 -0500
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
Message-ID: <20260228153921.19cd42a6@fedora>
In-Reply-To: <aaILlSuEgaYDq41r@krava>
References: <20251230145010.103439-1-jolsa@kernel.org>
	<20251230145010.103439-10-jolsa@kernel.org>
	<1b58ffb2-92ae-433a-ba46-95294d6edea2@linux.dev>
	<aaIAoBZGkP7RQrvc@krava>
	<aaILlSuEgaYDq41r@krava>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 22:24:37 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 827fb9a0bf0d..e333749a5896 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6404,7 +6404,9 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
>  			new_filter_hash = old_filter_hash;
>  		}
>  	} else {

As this looks to fix the issue, just add:

		guard(mutex)(&ftrace_lock);

> +		mutex_lock(&ftrace_lock);
>  		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
> +		mutex_unlock(&ftrace_lock);
>  		/*
>  		 * new_filter_hash is dup-ed, so we need to release it anyway,
>  		 * old_filter_hash either stays on error or is already released
> @@ -6530,7 +6532,9 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
>  			ops->func_hash->filter_hash = NULL;
>  		}
>  	} else {

And here too.

As there's nothing after the comment and before the end of the block.

-- Steve

> +		mutex_lock(&ftrace_lock);
>  		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
> +		mutex_unlock(&ftrace_lock);
>  		/*
>  		 * new_filter_hash is dup-ed, so we need to release it anyway,
>  		 * old_filter_hash either stays on error or is already released



-- Steve
