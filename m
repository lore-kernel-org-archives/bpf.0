Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E354749C;
	Thu, 29 Jan 2026 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645635; cv=none; b=Ybqo7CYRnc2ogA7Ro5OZ7EDTQP3lQUdJJ7KTa4f0W8p+uJzMcWmB4bnIAP3bGj2BVWTEtxb3jKAdD/D2IqIPRdH90g+Q99wBZV/N5LZw+eB0MMyx6UZC6tK3hU1EV6LQxQJ6JhUpluq/PxLAw/hbuT1r/NdBVbGywkSSOemiWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645635; c=relaxed/simple;
	bh=QMY5VhDr13qrK5klyZc+O0AvB6eLS0h6Y2IbLGJESHQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bdlcTxi6AxLMmqOmWrQCmzAIVnII+jUMJ7W9VmPWcIKW6CI8CwLlSNu491+AFpvHykS8iqoYbXZcMbo0DUzMSYTvK/M0REvSR0/jeX4FUotToW18KEbgR7VgIXHNr5+PrroAwDwWNb7+9ybuCBEOd8nsRurUZ09GqtGn60dTRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COlU+WAX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COlU+WAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2620AC4CEF1;
	Thu, 29 Jan 2026 00:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769645634;
	bh=QMY5VhDr13qrK5klyZc+O0AvB6eLS0h6Y2IbLGJESHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=COlU+WAXp1Bq6C7gDzAJ53zNC99nQGKd04z1Od5Z3g2nC1XVRT2R22B4Y3dL4ydfV
	 NwG7RZHdNjEJaShoggNHurkzFnIYcIRg14RO0ENNFhnJL2vfBlgOi2eKIzy4gDzJYE
	 SU6vtBUrap9ZqEoY//PRWc7azTLSDxhvyeLipqUFGTxUTBHInUVcYYJHvaf44y8yfH
	 iKcIo3feDWIywDDwJTFt1qiQXDQTCoEmSVTgjABNzh8a0LZ4kckJ6e5SD7YLrdi+y4
	 OzXWPL60C7NMiPWgaFahJrl4q+bAFNok1/yP6hmX5Mr9Bqybqvqgqn5RBrMhDBRXNh
	 dt1PmNEFdxBeQ==
Date: Thu, 29 Jan 2026 09:13:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: liujing.root@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, liujing40@xiaomi.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 2/2] bpf: Implement kretprobe fallback for kprobe multi
 link
Message-Id: <20260129091346.0744de91bb053b24ba679438@kernel.org>
In-Reply-To: <4ee5b08b6cebfc87b552a0fde1f09fd5a2c190813760aa7e68f1e6d060f15ccd@mail.kernel.org>
References: <20251218130629.365398-3-liujing40@xiaomi.com>
	<4ee5b08b6cebfc87b552a0fde1f09fd5a2c190813760aa7e68f1e6d060f15ccd@mail.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 13:33:31 +0000 (UTC)
bot+bpf-ci@kernel.org wrote:

> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 1fd07c10378f..426a1c627508 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > +int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> > +{
> > +	struct bpf_kprobe_multi_link *link = NULL;
> > +	struct bpf_link_primer link_primer;
> > +	struct bpf_kprobe *kprobes = NULL;
> > +	u32 flags, cnt;
> > +	u64 __user *ucookies;
> > +	unsigned long __user *uaddrs;
> > +	unsigned long __user *usyms;
> > +	int err, i;
> 
> [ ... ]
> 
> > +	for (i = 0; i < cnt; i++) {
> > +		unsigned long addr;
> > +
> > +		if (uaddrs) {
> > +			if (__get_user(addr, uaddrs + i)) {
> > +				err = -EFAULT;
> > +				goto error;
> > +			}
> > +		} else {
> > +			unsigned long __user usymbol;
> > +			char buf[KSYM_NAME_LEN];
> > +
> > +			if (__get_user(usymbol, usyms + i)) {
> > +				err = -EFAULT;
> > +				goto error;
> > +			}
> > +			err = strncpy_from_user(buf, (const char __user *) usymbol, KSYM_NAME_LEN);
> > +			if (err == KSYM_NAME_LEN)
> > +				err = -E2BIG;
> > +			if (err < 0)
> > +				goto error;
> > +
> > +			addr = kallsyms_lookup_name(buf);
> > +			if (!addr)
> > +				goto error;
> 
> When kallsyms_lookup_name() returns 0 (symbol not found), is err being set
> to an error code before jumping to the error label? It looks like err will
> still hold the positive return value from strncpy_from_user() (the string
> length), which would be returned to the caller as a success indication.

Good catch. It should set err = -ENOENT.

Thanks,

> 
> The error label at the end of the function does:
> 
>     error:
>         kvfree(kprobes);
>         kfree(link);
>         return err;
> 
> This could cause the syscall to return a positive value to userspace instead
> of an error, and also leak a prog reference since link_create() only calls
> bpf_prog_put() when ret < 0.
> 
> > +		}
> > +		if (prog->kprobe_override && !within_error_injection_list(addr)) {
> > +			err = -EINVAL;
> > +			goto error;
> > +		}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20338242683


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
