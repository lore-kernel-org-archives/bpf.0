Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572878;
	b=wgzU0PHDhuczvYWBc44n+S69qrNEEFtFHy5i92j9CN+NF7JCjN0w6ksRDr8QhqIsXtQy
	 M1UkDLQpVc0KManOW6XLATfOpHPd1TGZti7cTKZN6t6ulF9ouvK3WGdg6iREqUVrAgI/P
	 6ch9DPb9uBg1Mj2P9ZI5fzJBp7LMiq9OFhAhg6uNlRe4q3rkmjcd/zLNX8zaoJUCG+3Fu
	 cCvuDguSdIZja34paZl9/P70+QLjZo0OqCFrB0wYp23qQetPuEhE9cdZuOPW4wMQYrfwJ
	 HFLH4UJF4NNXYYmplTFpqkJPoAn4A0VDNRT//1w4h+FnAW/RxKKWuvzrr64lSVAWK4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572878;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ih0kmKcb+JTGX8X9TmKGdoWXmH5JYncIL9JCeP4tsvU=;
	b=Rw5tXjFMU+IB14WLIU3AonNuyjR+tHHIcp+cXRLVK8+lBQz5Li2jj4iE7jwcquVMpgGr
	 JUUpxfkkbvvE+na/ZH4gNzzWEqc6xUP2jWEpnVmLkDrYENGEYNliOMSSi5uwpxzQBcRuz
	 HsNoXxiHA+CTNihO3IEH2WEJ7koo5/E/0KUfzIS7jVjVtReIyD89N5YgyTQ/kLAw5VGiP
	 qlqpl/tw7FO8S2tkgkPgFLqwF9nVLZ7ZOa47dFfyZOazSN0LQONqfqcJickVgDcN/ZCZb
	 F0nwquzbH9JvgVADytyDr+k90OCnsDqBtp2TIzdIkpPeNSiQLP6sbjrUzzLKcCs5hDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+MsoB9L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9CD606A319;
	Wed, 21 Oct 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+MsoB9L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E60A1F000C9;
	Wed, 21 Oct 2026 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792572878;
	bh=Ih0kmKcb+JTGX8X9TmKGdoWXmH5JYncIL9JCeP4tsvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V+MsoB9LTGZnEE9Fye5EvMTP+G79p8Ot8rTKibVKnoqv6jEmhVeF3HkkkFCOLts8I
	 EA9r1gCAFe4HbAc0HKOqNsBK0ehaKc8b6TfF63+Or3XdBUwIjb9EIAgZlIqrXCGccW
	 2FQmR2/wZfbqaFZVfb64J8u7ZWvZEQeM5ouogy+iO5XKYy2o9TZSheakWuXdvW8Wza
	 5DK77KeVgJ9TOZ86JrqkDfenBj89xOlSJqePj+WmrJ7lddpylMiUE1L9k/SDErZHdx
	 09TCcn6bER55lOoTXP1CIoWaioSpuH1+rPVnk8vYY1wvjQzxwPigVY4f9Ejq6psb5e
	 clbd3dOfVwVEA==
Date: Wed, 21 Oct 2026 10:54:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH vfs v2] bpf: Allow bpf_d_path() from filp_close_sync()
Message-ID: <20261021-ananas-siegen-kurstadt-24cc3e5c1ce6@brauner>
References: <20260925210347.1364191-1-ihor.solodrai@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925210347.1364191-1-ihor.solodrai@linux.dev>

On Fri, Sep 25, 2026 at 02:03:47PM -0700, Ihor Solodrai wrote:
> The d_path selftest closes its descriptors with close_range() so that
> its fentry program on filp_close() runs. The vfs commit
> c1ed65ea167b ("fs: make close_range() synchronous") switched
> close_range() to filp_close_sync(), so the program still attaches but
> is never called:
> 
>   test_d_path_basic:FAIL:close trampoline for filp_close was not called
> 
> With that series, close(), close_range() and the closes on exec and
> exit all go through filp_close_sync(). Few paths still reach
> filp_close(), dup2() being one of them, so a program on filp_close()
> no longer sees most file closes.
> 
> Allow bpf_d_path() from filp_close_sync(), but only from fentry.
> filp_close_sync() drops the last file reference inline, so by the time
> an fexit program runs, file->f_path may already be freed, with no RCU
> delay for NORCU dentries such as pipes and sockets.
> 
> Attach the selftest program to filp_close_sync() and keep triggering
> it with close_range().
> 
> Add a test rejecting bpf_d_path() from fexit/filp_close_sync.
> 
> Assisted-by: LLM
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> ---

This seems fine to me. Sashiko has some comments though.
Maybe go through them and resend as necessary.
