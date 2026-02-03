Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C63AE707;
	Tue,  3 Feb 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133211; cv=none; b=WOjIlxq6WiCRdiB9glEHVwmqxhZ8aG/wYUVdvnNjDL8vbKgwytMU7P2NhnQfQ3AQzHsxHhw9kpEpFtWVOHf9CPMRHswLQDKEsFO6zK7o+GslRbT1bLi1FyvlNedhlz4miK5yC9YADWSrL12SHY3CPmshMERD2dTLiXCll536GjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133211; c=relaxed/simple;
	bh=hrFdTrodQLTOUFALvACjE3G445u0ZYWW+u8M1WKUmNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhXHOsx03QbD3wwNy2kUewpcgioYWX8UhcayPxYRvAXBMioQ/vfA54fv2eAbddRxQI9bzXI2R4udYJsgiBlv8fTJC0r7/06+edVsZKNZhH79k1MBrtNb0wS1VWxnIO7ncwpPbJUCfIrQKYLeZCW7lPI2GM3VsJbxGyt7f5JTyy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhQfhA7d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhQfhA7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99D4C116D0;
	Tue,  3 Feb 2026 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770133211;
	bh=hrFdTrodQLTOUFALvACjE3G445u0ZYWW+u8M1WKUmNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lhQfhA7dyL+sQj4/xdCK8PkDpNeBsD2T3jiL4ZS5qpDIRkqwfjCH8fqUiltnUe0UT
	 9xmU9TcUbclSF05XihXyymlzwP6se2LYe/jjeh2sW7g0V5YtaUH3ceAab2ndasaU13
	 fVTKmSU908gEZ7pyV3W5P1x8ypC/nXWIPsv3bHZH18mlOqFrYBZCNVDm96gzCxTIUC
	 v9r7PRPMwkNnOgrVrnK22nLo2kO1s4vDR47MTlBDtYmJBsNh2zPDC6+VgchOLxoQuA
	 4Dk8/WW8diYNV2T7/L7wXY0WeePDWSDtYM+Y+4HXBCvdg846SoQET3MIVP6o4dfSZ6
	 rF8+xVKLbpk4A==
Date: Tue, 3 Feb 2026 10:40:32 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Martin KaFai Lau
 <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Menglong Dong
 <menglong8.dong@gmail.com>
Subject: Re: [RFC bpf-next 01/12] ftrace: Add ftrace_hash_count function
Message-ID: <20260203104032.582709b7@gandalf.local.home>
In-Reply-To: <20260203093819.2105105-2-jolsa@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
	<20260203093819.2105105-2-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Feb 2026 10:38:08 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 705db0a6d995..6dade0eaee46 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -413,6 +413,7 @@ struct ftrace_hash *alloc_ftrace_hash(int size_bits);
>  void free_ftrace_hash(struct ftrace_hash *hash);
>  struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
>  						       unsigned long ip, unsigned long direct);
> +unsigned long ftrace_hash_count(struct ftrace_hash *hash);
>  
>  /* The hash used to know what functions callbacks trace */
>  struct ftrace_ops_hash {
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b12dbd93ae1c..be9e0ac1fd95 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6284,7 +6284,7 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  }
>  EXPORT_SYMBOL_GPL(modify_ftrace_direct);
>  
> -static unsigned long hash_count(struct ftrace_hash *hash)
> +unsigned long ftrace_hash_count(struct ftrace_hash *hash)
>  {
>  	return hash ? hash->count : 0;
>  }

I think this may make it less likely to inline this function, so let's just
add an external function, and even add a "inline" to the original:

static inline unsigned long hash_count(struct ftrace_hash *hash)
{
	return hash ? hash->count : 0;
}

unsigned long ftrace_hash_count(struct ftrace_hash *hash)
{
	return hash_count(hash);
}

And don't modify anything else.

-- Steve

