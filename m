Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940726B2AD
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900528; cv=none; b=Xb42T+bF4TnTHghR6hjje5h3Y/bUPXavYzXttrPYiUKVuO/KwWl5c8WTQBzRPXUZ7j3lRdDP7eSf2q+NsnNy/1asrDyZ1y+yR9V/ZMe2lgUYDA9W193gx1FcUJPCNFIge6eLFM1IN3tdmcEiIGK8ivefGUW0LrIqdy39zfwTLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900528; c=relaxed/simple;
	bh=F/7KlDqSeMVu6sM/czxRLTxBPfRX7IB7v8B/2Nccn5U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDNg05EFvpB0ClStRrz5VONdrZsEfRslZ8rN4RJdvzLKVi7+Y2kp7aCCp1eKLhElqrkQDpEJQE/EyXVF8E089f2KFAXEi5/CvQWFSeBuiG4DOEHcayEEQawl3dyY22abB+HYah7nNuwybEQrEhBQwuVMMIIYtn7GkXU7mQ9JOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqZzCkso; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqZzCkso"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so38465705e9.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774900525; x=1775505325; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BvecMkdZN7GJ1eMynnJGBnNnu5EUvC0Prs3Kd/u+xy0=;
        b=EqZzCkso5cO72Gz0U7Vg4/pEWXkWqThhozO/aEH76P7tQ2SLrMqBJaKlBvOR+f39lk
         Nh5dmJOKM61LWDLF7C6Qn9Zu+ZY5KpdELajEFS3VzbDDHBCZY7vFjZpJfm0sI6Kis8Ev
         LAAvIXUVutTY8lZ5vKG8Hx4Hi3HvNkTjAo0bsajhOfNACgfV0FZCBZYMr+7MpH4c4Yri
         izKa7IAcWLSAp8pvGRydeAyT1GTeUoUgYD7w/7g6msdG05rZ1YUMHN9kH7vP9hrLgim9
         UF7XU+NbERf+Eg3X89aa8m1F+OFTat9G3HG3Rqzo/Bo+3ZfQs4CCcj7VlHTuol3UD6sZ
         yW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774900525; x=1775505325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvecMkdZN7GJ1eMynnJGBnNnu5EUvC0Prs3Kd/u+xy0=;
        b=RMzVneNHdJDyLbYhLu/Ug1UvkNPuFpEhml6z9r7KU/KinebiRK8V4y2pSrzK+eQxQ9
         frnARTW6WAd4uUL9ZIvId1Mp108Y7nOEIS6zCONa9lBVhffRvhHxYTww/XbocUASTX27
         LGa82zxjQSOb7dwKlMw014OLSs+hWBM7sepDnbe9kolOIVyaANfMvo7izN83cWD16Q30
         AkaAQNzmL8XuiMM7nqkrkj/AT6w/1UQwht+OwxSZ24g54jjN3VmYLBgfA/LpcEq7XeHE
         J42pi30YfZqOkfNBbXKnTv0I85BmTcK/lZZE37eF9bEqmWeWQiSHj7AqOcpzlRmBxrSw
         yXmA==
X-Forwarded-Encrypted: i=1; AJvYcCXoDRrpO8ZQwEz7ch8VSefZH/zxNoHWq/TUbpHnlGS0AncOuRXs++uQGxmqwUFpAKx2iWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6lx6is1SiVSSQHMYzslGoWjdiKR9fS4Tw2lMaY44+Vzlr39/N
	N/tjyfo72Dol9CqHTOx3ck4ELgJmvLRNlHtneERmRlmCLxaIIOzVanRj
X-Gm-Gg: ATEYQzy2Sj+przR+ZEH3/6obLX2hjDGbEMrIKKjMrpDlFV01XCtIjbqFVLjngITBcK6
	2YAnFe7xnORFF+FghREbzXV0/lDfl1J0ZizglE0nfg345KxlQtvLAafKEe5SezjRG7Cu8ZSfC1R
	V0lqauX6hHc8NLR/i6yf7JsGk2nLFeESxFqCkYIfMwytoJYKo2AfjRt0+ECnBBP6m2SnKmRI8im
	2KxueHoeYv5zbrtV/MxhcAV+yy5yVcjazHIowbke/1I+nCuz+IyQ6dFGyd7LmFWlYQgOwTCx7RG
	HSo/I5gcIBovTMXHVfCUoL0ss9CdtrvqGydQ5QQjyRxjSQsVduvLmfOZRqa1UVuGEcRizsbLIWM
	atHJgVfeG8BexhJBhf4tKfA8/H+X+SxUHdK106gXqhQtuH1tqohmgPDgFEE8pKn/ewD9To6nAd7
	xiw8oXjwCJ1JpvHZmDk6HRWxCrYK7xFnGZMPWDWLfyiRNi3Omj5zZvcZjjCw==
X-Received: by 2002:a05:600c:1f11:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48727d638efmr242642785e9.12.1774900525175;
        Mon, 30 Mar 2026 12:55:25 -0700 (PDT)
Received: from krava (cust-west-par-46-193-1-135.cust.wifirst.net. [46.193.1.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c95041sm277968485e9.6.2026.03.30.12.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:55:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Mar 2026 21:55:21 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Abhishek Dubey <adubey@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [linux-next-20260327]resolve_btfids warnings for unresolved
 bpf_lsm_bdev_* symbols
Message-ID: <acrVKUy_EPiFFmV9@krava>
References: <6ebc74b5-3dd8-4bb5-adac-fa32bf71eacd@linux.ibm.com>
 <CAADnVQ+KpCZqjAhMBzDZqm14yaORK-PG2VHRnub1Q0gYTHKG=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+KpCZqjAhMBzDZqm14yaORK-PG2VHRnub1Q0gYTHKG=Q@mail.gmail.com>

On Mon, Mar 30, 2026 at 07:42:18AM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 30, 2026 at 6:45 AM Venkat Rao Bagalkote
> <venkat88@linux.ibm.com> wrote:
> >
> > Hi,
> >
> >
> > While testing linux-next, I’m seeing the following warnings during the
> > build:
> >
> >
> > WARN: resolve_btfids: unresolved symbol bpf_lsm_bdev_free
> >
> > WARN: resolve_btfids: unresolved symbol bpf_lsm_bdev_alloc
> >
> 
> Christian,
> 
> looks like those two need some #ifdef
> 

I think it's wrong hooks name, this fixes it for me

jirka


---
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 119e3942cf5a..0e74325d96a6 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -383,7 +383,7 @@ BTF_ID(func, bpf_lsm_task_prctl)
 BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_task_to_inode)
 BTF_ID(func, bpf_lsm_userns_create)
-BTF_ID(func, bpf_lsm_bdev_alloc)
+BTF_ID(func, bpf_lsm_bdev_alloc_security)
 BTF_ID(func, bpf_lsm_bdev_setintegrity)
 BTF_SET_END(sleepable_lsm_hooks)
 
@@ -397,8 +397,8 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
 BTF_ID(func, bpf_lsm_sk_free_security)
 #endif /* CONFIG_SECURITY_NETWORK */
 BTF_ID(func, bpf_lsm_task_free)
-BTF_ID(func, bpf_lsm_bdev_alloc)
-BTF_ID(func, bpf_lsm_bdev_free)
+BTF_ID(func, bpf_lsm_bdev_alloc_security)
+BTF_ID(func, bpf_lsm_bdev_free_security)
 BTF_SET_END(untrusted_lsm_hooks)
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id)
