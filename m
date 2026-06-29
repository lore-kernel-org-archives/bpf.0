Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769E2DFF04
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782763378; cv=none; b=irHRh4W5CRhmHS0BXxMglOjAYvKvvofCNGZ8cgT+5vouON0ba5U2nVUOj+z2jlS3bvHM7W0znQQBBatv/P8eo+D70xdk/wDfzxxZ0AbjYx6O42lxAtTGfFi7IeFbj5jIHPJ9L4Y0wWXwG9sL0Qz70pu+FQ6+hJ9JCcOH0A1DH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782763378; c=relaxed/simple;
	bh=QwixfGbWGhTuu6raySOLPg4INdSroRyWxE+C2oSf0iw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXVBdTUHKFKYCypa9fezWoYzK69BMI6Xj2w6OKrUhBJoVU/pd1x9Whh+KDZLcu35pQRo7oUOdji+/E4qwfILz4tqqunTc8OkWJmJ4e2S4j+JGpQ9ynDAOvXWROWmUhGvlmWbZ4+3Aq4vc0bQnWyHU5NUiEGY2ZHY13bfKh9Z07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pixzm4+/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pixzm4+/"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-470174001a0so1765797f8f.0
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782763375; x=1783368175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Sj8m3KZsiEZu/wgYSabNoHSTpWP+hWiZBqI5ByuJ9E=;
        b=pixzm4+/NnD9WYf44Gj7tRHzw9X89rXoIOU2FiUSkpe9/saZKTIgfipi5F+4Vo37xf
         631eu8ttEtrh1NeA9Teeri48Ozi30Rc/gfm9F3FQXEhwFoMzkm4TsTuUnvq4GgpU2hCX
         dTUu1IJ8kSQ7t9BDM5AGJAjFVb3p20BX6+Ye0w9Czz8wDX8DclIQBPWGXykajAfJfsPe
         vC0f0MQzOTLL75I0I5M0d4ybYYs9C+wiYyT/0nMtSVdsfg1IDd4osawpxl7oADVf0NP/
         X9XssAagBMX+zljmP5j+FIBLyjwuRE3ykMQbwmjuCvdn0QUGlet4dssNZw1KezPoTbs6
         sexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782763375; x=1783368175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Sj8m3KZsiEZu/wgYSabNoHSTpWP+hWiZBqI5ByuJ9E=;
        b=cEVDg3TNV2dHcthCU/3ev37J9RB6C0wLcxPW3gTxsnlER2UJbHxbKrr2AZ7G0owib9
         w/hrRp5/xbuQeFf7s5GvPr9n264sq1BeI3c88wGuAPQJzy4hZOwgo1Bvr/fEjKjW8EE1
         F/IbUSjHRczIUwLdM7P5Uu9H6BOjYbaYeYcK1dXEkEwjvJmRM+EjKsizifiJ2XxV7Qam
         kt1E4Z881/F8o6V80d7AuPgMaCaqPEEF9kNSGVcqRTlyDLO1TVp/WQsdXZtIYI8EDnHI
         w0vfdXqmhFDDG1iY/ztf5uecQllehMcyJT0LuBG9sLxzMRLqYPjk0i+q63Mnct7MMQz/
         1Zsg==
X-Forwarded-Encrypted: i=1; AHgh+RqHyiJ7fa8UWYZU+bHRjrRfngKbkVY3TauHau2sTjEb0KKzPiaZrFkL1EZZWPHr9q9+j3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHloSG+OBGs+x3qhMFA7QhWmjPlvKYc+GvUapA9+yMvHub3kUk
	GmIAO08szCmL/+aw2LwdxiJt17RIAfdn7KUcYql/R0e5GnnHIn0vyQ2S
X-Gm-Gg: AfdE7cnz0TTjZWyhLoRG9zr5N1eid8mTo2ygQlPsXC8JiNHZ8CbBq/570nUMUKVC8J/
	a18IKr/7ecSB2icEQ07gT3RcgiCOrFTVPHqURpbuxi3o2uMrQ/vE3uDYd7z2HCRwEmRsWsCJ/Bu
	rQlyemA8BTDiV5KJGgh5zO+qEh0bdGWs16v/Mf/cZFsDui/v5uFnty5mDNrrJLXZHtnH1BVKwEs
	IqYUE2ztEfPSGZLb7tJBxp9gDsz1cCa97mIUNx69QhtXsGxbZrjezj4dMa+CnMN6FDiEQONtIz+
	5Cf0ADtfb1+3THPDgS+Ig8k93jCVrRKRW+dLs8mku/3qgWFb3TAjPe76uJavDaoqJVIczQBtZUd
	Zd9ThpDH3bGp6aIOmt0e4Y2hVhuNEpPUbcikxu+imDWR5HvyaCK74T0j0CTcvWJS/wvjrBxE0sp
	EwDUfMdN/P6OWzAjYMIkGsyiHt
X-Received: by 2002:adf:fac8:0:b0:46d:d693:88cc with SMTP id ffacd0b85a97d-47553213191mr681701f8f.47.1782763375354;
        Mon, 29 Jun 2026 13:02:55 -0700 (PDT)
Received: from krava (37-188-219-218.red.o2.cz. [37.188.219.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636d2cfsm844599f8f.17.2026.06.29.13.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:02:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 Jun 2026 22:02:51 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCHv3 bpf-next 3/3] bpftool: Add tracing_multi link info
 output
Message-ID: <akLPa1TGZ4lOuQYB@krava>
References: <20260629143844.862369-1-jolsa@kernel.org>
 <20260629143844.862369-4-jolsa@kernel.org>
 <DJLPKY6WJTBD.319506WRJ7EUI@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJLPKY6WJTBD.319506WRJ7EUI@gmail.com>

On Mon, Jun 29, 2026 at 10:28:08AM -0700, Alexei Starovoitov wrote:
> On Mon Jun 29, 2026 at 7:38 AM PDT, Jiri Olsa wrote:
> > +	if (info.type == BPF_LINK_TYPE_TRACING_MULTI && !info.tracing_multi.ids) {
> > +		count = info.tracing_multi.count;
> > +		if (count) {
> > +			ids = calloc(count, sizeof(__u32));
> > +			addrs = calloc(count, sizeof(__u64));
> > +			cookies = calloc(count, sizeof(__u64));
> > +			if (!ids) {
> > +				p_err("mem alloc failed");
> > +				close(fd);
> > +				free(cookies);
> > +				free(addrs);
> > +				free(ids);
> > +				return -ENOMEM;
> > +			}
> > +			info.tracing_multi.ids = ptr_to_u64(ids);
> > +			info.tracing_multi.addrs = ptr_to_u64(addrs);
> > +			info.tracing_multi.cookies = ptr_to_u64(cookies);
> > +			goto again;
> > +		}
> 
> The above doesn't look correct.
> Please de-llm your code before posting.

ugh will repost, sry

jirka
