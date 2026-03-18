Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D173101D8
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855265; cv=none; b=HjiTjoWLgpAg8VHq/mxY39dWvmSZM8M4JwO2bjINGtcD5QirYbgfQJ41Nun+DRIjpbQxJT5/wwrgg4L3eEGEyxSR129LD4iohW3ztcATlcQD+uraDM27Uvi3lh871Qgv7LjRA7B1AXtVpDSTWPHZq/DQcf5onmBN/P1z1d6jTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855265; c=relaxed/simple;
	bh=FZxvRu+85EWsxqRmuAs5TjqTbVp8lAzOjEKZsLeBTXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP9CwbKEmZBsGELCA6DK0R9yL9yLPb5pbuc6b0c310ehIZZmmAJnjDs0KCrwDdayDeEczJwP60lFLHFLdUQCvDPAzWWahqWqIzhvoLapeoQmu0Me+Dq0a/cWyL2hePxMkF5HIYs88HG17mLLMS0L9BrhgrpvHsSN3RfkR7DS4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZIQ8Y8q2; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZIQ8Y8q2"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d748ca8708so70964a34.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773855261; x=1774460061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWeEa0ZafBH05FmgYmVQzG8J+24xX/BkM77vv1zD8SU=;
        b=ZIQ8Y8q2up0WQADu+jzFDuMldHGgfqAA3c3j4H3T5Lcxfe4ftsyHELNmFik8FV8e8z
         w1PLCvdfsEBJkEn9+5kO8ZW+eXOSQZD5rk6PLm+FEZYiu/nCEUpj2T/jmT60Dg/g1CIs
         CrYOXi04XdvU2IBMEMVyxYjZNz1IMc6tE+G7rfzA6axZlhdnQWS6kgAp1mWQOmY+56i3
         80Fmpv18cqRt8rAfjsHpSReittFy2zgwKQl8goe6sbUWMxzRopoUWXbESr+9XoJlvnJG
         vgjo5oNJbpCubomqywdW8+KH14/Vri90Kw7Qu1EqhcZzuIKvEjXPcjOKGJ95WXD2AJvn
         bXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855261; x=1774460061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWeEa0ZafBH05FmgYmVQzG8J+24xX/BkM77vv1zD8SU=;
        b=eLh2P4vZv7WPtoDFzMq9Y9Bxb+C1p8R7y3H49z62xuMBsmtjOV3O/Z/30y7WAQfV15
         Zj/bu3uk+KShJLThVmuvSfX4xQuiaRF4CvmR/zykrKp0bL6qGhoEfxCiW1jRFSrs5GVl
         xO1Xx8fPJ1qkfFyCHNadsqpe/Vx3sFqpvFq5tjAjKwbr+qiwMFDvb7Ie4NXB0GskXn1q
         Avgyg+JBKQmBFliuLl0heeeG9eY04rYG61mIiPkds5uZvyfYHQ5j+MBf3aQItr6XRL6e
         2nqFbZzesmJVZLjAwn7iOHsdviCDbtVsW6L/QJfQbONcJU6Sk7V1ZtSQpp2a6fX6rnmA
         XH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKphTYr+b4NAHeMlJ1D8/iHSGrIuQa3zgrd2VeVsPeFs1iOga5oJ0eQlzxXsKHV3QKGRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8tT1H0T/JR26rd9WsjLDkihuH3IM2iOkNFpsL8ZyPguiRjeg
	6gDsydluv2LG4NC6nsodoDMQtNAl/+AxZ8/kNdJejzwLe2cTloGPYRsdNV/sw+drN9584waW0Yo
	bPryNuPrH0Q==
X-Gm-Gg: ATEYQzznAFKwCdG7UdQerpgjZvhqb3zsnFxJ+zekNcyxR40UIDx0dVXJGDa2VwQp2h7
	YfJO2AekSJtz4C6bv9e7uuZN1zC90Y6mw00Jm9xou+YDfNYBnzt335yqvVcgQi9IKmDq7vQ963Q
	zkaYRofSib49f5+EgXHL3ZymilYfoKY2PkvwIQ3rTi2rd3K3pDiEAErrU8uL8TppOiQ3Ol6Sgus
	R2LbeOoVja1CLTCUsyWHswkAEKGTU2FI77Vx2xXdF5L09b7fIVZOelEu67ub4SlkROKHTJwxxBE
	lQr+ijVr/Fxac8ugLtSk0DIUBTkSht4kpHk+ssmQpZMJ8LrpgLMZPsb3kAKCbr40Bilgb5RkMKE
	2zjUHCr8mv7jnYGKL9VCcs/xLK2rMlacBMH324Hubl8UP16QYOBWLFeXBL0MOQlHX7PyaBwWdPC
	gofhlt
X-Received: by 2002:a05:6830:64c8:b0:7d7:4d85:eb05 with SMTP id 46e09a7af769-7d7ca775284mr2522284a34.22.1773855260727;
        Wed, 18 Mar 2026 10:34:20 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:4e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9950ef9sm2751073a34.2.2026.03.18.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:34:20 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:34:17 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Eric Paris <eparis@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF
 LSM programs via BPF kfuncs
Message-ID: <abriGVbtYY1zhupD@CMGLRV3>
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>

Hi Kumar,

On Tue, Mar 17, 2026 at 03:43:36AM +0100, Kumar Kartikeya Dwivedi wrote:
> On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> wrote:
> > 3. All bpf_audit_log_*() functions are destructive
> >
> > The audit subsystem allows for AUDIT_FAIL_PANIC to be set when the
> > subsystem can detect that missing events. Further, some call paths may
> > invoke a BUG_ON(). Therefore all the functions are marked destructive.
> 
> I think the first part makes sense (i.e., the policy simply configured
> the system to panic on failure).
> However, in the second case, if the program is somehow able to trigger
> BUG_ON() relied upon for internal invariants, it would be considered
> broken.
> I tried grepping through and didn't find anything that would cause
> this, hence the whole thing about BUG_ON() in the cover letter only
> adds to confusion.
> Please drop it or describe cases which you were concerned about.
> 

bpf_audit_log_cause()
 -> audit_log_untrustedstring()
   -> audit_log_n_untrustedstring()
     -> audit_log_n_hex()

Was the primary call chain I was referring to, and yes this relies on
internal invariant of the SKB existing. I can remove from cover.

> >
> > 4. Functions are callable once per bpf_audit_context
> >
> > The rationale for this was to prevent abuse. Logs with repeated fields
> > are not helpful, and may not be handled by user space audit coherently.
> >
> 
> This rationale feels weak. What abuse are we talking about?
> The LSM program is already written by a trusted entity.
> 

I learned through off-list discussions that there's "undocumented" or
"unspoken" rules of log formatting and how auditd expects logs. Without
knowing exactly what these rules are, I can't provide any stronger
arguments other than to reduce duplication of fields in messages, or
exclude wrappers that supply unverified data.

WRT to unverified data, the socket wrappers accepting a netinf int.
In that case, the variable is at least verified via lookup to
report the interface in which it belongs. I left out wrapping
LSM_AUDIT_DATA_ANONINODE due to the passing of arbitrary string,
LSM_AUDIT_DATA_IPC arbitrary int. Others like for infiniband,
lockdown, nlmsgtype, were left out due to specificity, and not general
purpose usage.

Some of the rationale behind this is _not_ trusting BPF LSM authors as
much due to BPF LSM flexibility and accommodating user space audit.

Best,
Fred
