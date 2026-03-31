Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24563A9017
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955614; cv=pass; b=PEbFai0E/qeYWzwIpLNhc8IoLyWIXGM6z4ACjECwOtat3kv+g4XO8VMzBCMg45ioHLx3TpyrbkxgjKmDpz7dfbS/rY6H5F/Cu17sYgtkGNIz+m5i94uwyCF5wzzOX986ptCR7OTC5bBJd7nDUGbeOoI1s6uNmYU9ZhDm2GmH0zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955614; c=relaxed/simple;
	bh=yvnXswRVk8DAzH+h8locSccnYqxZuJsTFBTaEkQyCV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xu5NB+Dd/cw/qhpFHHhK5xxcnCF1XvqpIFJbOI1G2yflYp7TKtX49IH3aHQ7TZq5I8nCE1QGqboMiRQJ8srMRAdMrCnooXOxm32UBusHqlRwWQr1Etti9CBNVUJjkciltqHMK1jfJqc2NKfUQQD5s5nMw8K6jQVZSs3uE2NWuEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FScwTjbE; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FScwTjbE"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ee82e853cso5983921d50.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 04:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774955612; cv=none;
        d=google.com; s=arc-20240605;
        b=LreHnf0OyAtShWqPeVS4R/Wc9fu1X/t/EQNl5Vx5CwuOJXbJ3O9OAMH/qcGcdYvEIZ
         ayiqpjwpX+oOHSIcKCcyJt5mkkdYUDHxvuD2xfZmlfdFQiEjxaozKOnRtF+1koEqDjLS
         bejlZ/RZ19OyypHHfMCJtwIhclAVfJNbKZVlm1W49R4Mo9X6A/2Zgy6ovWzWeBS4s+Ct
         9DSyZoktNm/fMhGoqo/CFeM12Vu56nsfj0IssIkgDHyZK9s8JY0BtcNIyKhLhl7v87Dx
         6KzmZ0xnNyn1nYkCJLtmNnAuxasVQ9XcCQgywAhtxLRXIUmZ0/PX3bw1grl1bHTmgJcp
         JnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eIKbQO6sYgebk24yvJXDnZP95QC1IFHPrP5Jda6NqeE=;
        fh=K2wdOLTD/Tjv8zz+rk9F+jNN9A3lDmv4RIDEaS9q5no=;
        b=am7Wj/yDIfKprkAdiPCMPW315+9OBFUlY3Gv0B0Cri6xKsKzHvj23hX78YCP++Ce6u
         HIeAe4ABgzzkCKZfkRLgykLwBqQwLXQVSeUJ6jcb3DNGZ4dvVkKpUK8zD9SdCU14ef72
         KlOjM2NGo78W/CWy0WNQNfcHMnQ5+5u5P6rXVKqerI57+gLzn9txDgA5fbXF8CWB+YNi
         FAA3VIngPPPqiJmoOEceh6Wx1JmsDKKIGvU2cNbDBGe0sSQlR8cAef/2nkabsiOPN+wy
         vFq9uKnAPFYkNXZXT8X9wbpPa8RUyJu9aknUHjk/54pRAZHq/d9YtVxCLtxjA/4+durB
         mwHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774955612; x=1775560412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIKbQO6sYgebk24yvJXDnZP95QC1IFHPrP5Jda6NqeE=;
        b=FScwTjbEBsW7t6tW9q+eqfy1VQZTu8/NOZjfSJcGI0obE5vUbTIrhRIIvoCDtqoLnK
         Sym8mpHOQERZcVuRFnmkhu9uK9w8y8bdz1m4MjqC+5fCndOdeVFj7rxBn4eXCKxCkcue
         +UiPI8N5RNWbGW1pP+HY1v4XS98Qfjkuzb0YYcJ28bT1PfWnLI32pvcKbHkVuvruu4M8
         ewEt3li8GAB2jA1SGQ+dmpcYsUMyz+NuIEGUhfBclNan9SDXh9SF/lAmSACJIdBbuUR9
         /Pj0rgIOP6TF0SE8nN812L/svTMVIkkkkQJnf2EX9CxBogmrCEYm14flQ8z5FfCDE4U9
         bYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774955612; x=1775560412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eIKbQO6sYgebk24yvJXDnZP95QC1IFHPrP5Jda6NqeE=;
        b=JEJ2c2jReAeR2elTO9Eq1FF0f01hyIZoGIomd586zaeoUGl3sEwHUU+9QENOPqojQ9
         Z+ilgygExD4YYTEec/l2z+GMbpYWuc+aHzLqk3ZOGEVPWANScJN1AHY/e3EBxsRTY6XR
         Rwu+towLvHmqITw1SDOPENk1AlvGcYs4X2woc2gN0v6jOX7rrFzQK7Oj9+LxwtGlXYRP
         kBJIAacjWsjARdZRJ4UW2DPOWHGz/ugYWadRmhCTEJCcpOYLOdBWODoLbl8FABTbT/Vp
         pWeTIqwV/0dgSBke1dGJnby87ZQ7tNj9seZlPsJkqTpH+07BjZPKBqeBHC+cQkP5otgM
         sqPw==
X-Gm-Message-State: AOJu0YyGuzE/ycH7AWEfhSlTWeUTNiBhTNPQzxBBEPIVND8K6Bk4UqDP
	LPKLKvmEuzoEOd8Wk2dnwmdMOyJ1T6DrzGJsWiQzIf9edI/4zB7c5rNKvAJdd9WPPvJrqv2kaAA
	7QrmT45SkASFvrd8L5OBUyPBLcFpqn08=
X-Gm-Gg: ATEYQzxKyVYzi+bomau88FimmTnkmX8hdph6xM7rAowSRozsl+UYVcz3ViDWMq/5T7/
	hYTkhVEJPyNAB9SNkgjfVuREu9kcq4N3S+67iDIN2OFfSebDIcNSn50xG1/HkHX5DczCRFZ0FDU
	tzDz/Svrfdd7JUKgjFYIbjmdItIQD1mxb5C50KCwOpShnEUEtEiiDcB7s/XM/o9spGjSyxmhFqg
	XflSSyPvmkng8/uHqgFsfH0jCBJ1MYMq6/2/Clii0CLON5cYG4RrNSh+lRlS1F6ujZ1hDf7+JKU
	hPPjeKb/KAgs3h0WeiEgYfjJ+KX1AqO0SXgaHgAzqX4NPe6bVHIaLP2t/iTjHACCXe0amw==
X-Received: by 2002:a05:690e:144c:b0:650:d66:9265 with SMTP id
 956f58d0204a3-6500d66982dmr10724693d50.57.1774955611755; Tue, 31 Mar 2026
 04:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331005215.2813492-1-memxor@gmail.com> <20260331005215.2813492-2-memxor@gmail.com>
In-Reply-To: <20260331005215.2813492-2-memxor@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 31 Mar 2026 19:13:20 +0800
X-Gm-Features: AQROBzBc_mIOv_dUxz7pInYV28Zq-VGG1tg6euI-Jv8y-aQB4-g7uqJxf0Ya65o
Message-ID: <CABFUUZGhF7UdObHTf9iuVAWbvZAzMDQjDjijJsKZcRe263Y9gw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/1] bpf: Fix grace period wait for tracepoint bpf_link
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:55=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> As far RCU Tasks Trace gp -> RCU gp chaining is concerned, it is deemed

nit: "As far as" seems better here.

> unnecessary for tracepoint programs. The link and program are either
> accessed under RCU Tasks Trace protection, or SRCU-fast protection now.
>
> The earlier logic of chaining both RCU Tasks Trace and RCU gp waits was
> to generalize the logic, even if it conceded an extra RCU gp wait,
> however that is unnecessary for tracepoints even before this change.
> In practice no cost was paid since rcu_trace_implies_rcu_gp() was always
> true. Hence we need not chaing any RCU gp after the SRCU gp.

nit: "chaing" seems to be a typo of chain.

>
>                 if (link->sleepable || (link->prog && link->prog->sleepab=
le))
>                         call_rcu_tasks_trace(&link->rcu, bpf_link_defer_d=
ealloc_mult_rcu_gp);
> +               /* We need to do a SRCU grace period wait for tracepoint-=
based BPF links. */
> +               else if (bpf_link_is_tracepoint(link))
> +                       call_tracepoint_unregister_non_faultable(&link->r=
cu, bpf_link_defer_dealloc_rcu_gp);

As non-faultable tracepoints were switched to SRCU-fast, using
call_srcu() for deferred
 link deallocation looks right to me.

Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
