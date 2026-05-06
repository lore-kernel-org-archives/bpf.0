Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F6248C8C7
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083888; cv=none; b=IvhDQPAnee7sJkoljaNuQh7UZso/pyBhJ6e3JIARjnr5WDiTXuPoqNr75JZ5z4qfiWdOBcnf34Gy+QB6n+//hG8YlM1qJt99lpP7bOLMNgIvHwcxadGtZQErlYETMoSpGonsQp3p95cfZn8VRv8D6DXmb0pZXw43nn9C1uCg5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083888; c=relaxed/simple;
	bh=+I5AaAjQZ6H0h4QD6DQuJ2QJ2vXo8B9AgreXanFTw9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td7Re/K8vwJAfZWNECfBy0VicSa1a8DsrL5ItOtj82+xkuKk3CmqJYucjiXSy/dTEr3fhARfsKjL1y5nRlcZpDkN4TJfV+JmuHYdfCQyXG7Lhm8Vk1ctWJNzTf37NU3Vw+EYBmaYJrYp6RukrspcEo1b/yZbTAo20SFuwGTWXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMNn5OBW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMNn5OBW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0046078so58919745e9.1
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778083880; x=1778688680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyMNDRKfzK1vF98XQ+2IVptze3RF9BMcP5R8o6uND/c=;
        b=gMNn5OBWcLSZDsMfPpUMl14m85yIYieaoDIs8FZXYo4CA1ZIh4Ptun7qdrmQ2OSArZ
         St7yalil8zKLf9x8AC5BjJxeCPrgmgPV2MGqZ/RoizqJ6rFpv5ViOYgTcR+OvIxsqjAO
         BUwkj7e29jRv8rDR/b8XnpeFmlnN1gWOW5ymFhJLMi4xLB0kj5CPdpOkyzIN7ku0Km4W
         454NqyyPFCuawXCKkDcUTjKOQS4mWm/VmuAiUhOBZcQE/wsPxqPJe5aDTU4Icr0pskcZ
         ZTk+ETf/4grbKhSjvXWJOjD9qShb0H3cYJirDCr6VyMcBrwidiic0QEVnoekpVpEG/p+
         Dt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083880; x=1778688680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyMNDRKfzK1vF98XQ+2IVptze3RF9BMcP5R8o6uND/c=;
        b=q/e+dykeJzOWiCD0GkkGe8V7+JtLLaIWnHGYBBY1cNqtGaHpdjlbLu1BssJfJctOKm
         yCFHi31HGPI6NGVFD/FSLOoYneUOnu0x/szwuKEaQ3ytZwFYttFijk7MdlRiy4sSWpcH
         C3vAPdqkGbnAWrTCDNWNAGs3oy/GcNH7/o+XWnWVdVQsAqfoDdv7SB8fTxbEPi5wxPDj
         zByrT7mr6H52fIkodk/bDbYzeCNH/yY4VepouSG2Sgro39zckea6iGCzvqdVKrHeoKwL
         FoKAwXgYA0kQCN375ldVMtmB7svOudOBLsiYYlmCgRjcaOXWDeewlj/iz8ugq0YCsc/b
         KnOA==
X-Forwarded-Encrypted: i=1; AFNElJ9IfO/67SPzJ+BLWer5jhmRIahkqpDvK4I90QY1TJEMeCh/gLMTb9Khmq6PhEXVNND87WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj0mTQS0saGxSRgUE6cwdd+uh38dhgAbMERgRl7v3lMCzEAi3e
	Zi7q1KKvekn2zl7S6lXlUu3ifl+4/GISHe7q0KURXC6oCMGEpx/MoTHh
X-Gm-Gg: AeBDietq5AVP9rcGqssYkgGKpAyg0/ykxTwpyOPWJSzUkfZyBsAZ/7zee+ZNFyn+m6z
	jhPEcHLje/wXK0cQpzK8rSICkSkjDpu/RlVWCApJ9ehCJbVVlo07E8I0L97zdgGyOajx6APbGLw
	OZmWpULANz+DI4kvICNuaxZizAmT/lQZ92mRtwFNzkTx5dEy+DqmYZ9xPRFtQWoxDcH514v4lkR
	bFiUWWO+Hz1g4lQ9iQf/dqAs/JUYepQ6Rs3rDIP61VbADSXAFQa2oepaOUbaCiL6NE2EdNscXci
	/Gz72dJC4m/+YbU3BSEqZsOTeBZvbBULq6Yry1NWUjgrVP9g/kS66fubmjJWDzVovoc7i0EbXrG
	o+WN0OCwN6LyslIdaGfs2tZ+q/9k/G3KuHB9LfH5pYVeYy4t30ErFLXWmBXMEu+9ktAIDosi60J
	OVmigK2Pn83CJ4ZPPzQcVT6Oo1BgZ6+yjBQMsjui0mt35HnOxGFHAV3vEAWsjYkEF0BDTGkgkAL
	s7AFkKa/7bJpvTOvXSTtZb/j8cpIHmPsGhGVBv2KU5nbiVmLXDUt8AUtKljLI6lYlYdvogx+4Mu
	veI8ZxYE8r8aNrhO8E0hz05pIw97WUd23qIkBl22cf3WHRldrgyUWg==
X-Received: by 2002:a05:600c:1f0d:b0:48a:93d2:60d2 with SMTP id 5b1f17b1804b1-48e51dd9772mr68431305e9.0.1778083879372;
        Wed, 06 May 2026 09:11:19 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b5a044c6307a465e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b5a0:44c6:307a:465e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53891d62sm94600595e9.1.2026.05.06.09.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:11:18 -0700 (PDT)
Date: Wed, 6 May 2026 18:11:17 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: paulhoussel2@gmail.com, paul.houssel@orange.com, andrii@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, ast@kernel.org,
	song@kernel.org, martin.lau@kernel.org, christian.koenig@amd.com,
	fw@strlen.de, tjmercier@google.com, lirongqing@baidu.com,
	alibuda@linux.alibaba.com, kuba@kernel.org, sdf@fomichev.me,
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v3 1/2] bpf: render CGROUP_LSM_NUM configurable as a
 KConfig
Message-ID: <aftoJQRKGhosKT9B@mail.gmail.com>
References: <20260506150547.767315-2-paulhoussel2@gmail.com>
 <283f244ee4c180a4a69cf5cffdbeffea1a0928262758906384f3512e09fe3c44@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283f244ee4c180a4a69cf5cffdbeffea1a0928262758906384f3512e09fe3c44@mail.kernel.org>

On Wed, May 06, 2026 at 03:52:37PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
> > index c9e6b26abab6..9ab5ca3dbaba 100644
> > --- a/include/linux/bpf-cgroup-defs.h
> > +++ b/include/linux/bpf-cgroup-defs.h
> > @@ -12,7 +12,7 @@ struct bpf_prog_array;
> >
> >  #ifdef CONFIG_BPF_LSM
> >  /* Maximum number of concurrently attachable per-cgroup LSM hooks. */
> > -#define CGROUP_LSM_NUM 10
> > +#define CGROUP_LSM_NUM CONFIG_CGROUP_LSM_NUM
> >  #else
> >  #define CGROUP_LSM_NUM 0
> >  #endif
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> > index eb3de35734f0..050af0b72651 100644
> > --- a/kernel/bpf/Kconfig
> > +++ b/kernel/bpf/Kconfig
> > @@ -101,4 +101,23 @@ config BPF_LSM
> >
> >  	  If you are unsure how to answer this question, answer N.
> >
> > +config CGROUP_LSM_NUM
> > +	int "Maximum number of per-cgroup LSM hooks"
> > +	depends on BPF_LSM
> > +	depends on CGROUP_BPF
> > +	range 0 300
>               ^^^
> 
> Should the minimum range be 1 instead of 0? When CONFIG_CGROUP_LSM_NUM=0,
> the enum in include/linux/bpf-cgroup-defs.h calculates:

That makes sense to me, especially since we already have CONFIG_BPF_LSM
to disable BPF LSM altogether. CONFIG_CGROUP_LSM_NUM=0 could be useful
if we wanted to offer a way to disable per-cgroup LSM specifically, but
then you'd need to rework things a bit as pointed out by the bot. I'm
not sure it's worth it.

> 
> enum cgroup_bpf_attach_type {
>     ...
>     CGROUP_LSM_START,
>     CGROUP_LSM_END = CGROUP_LSM_START + CGROUP_LSM_NUM - 1,
>     ...
> };
> 
> This results in CGROUP_LSM_END being less than CGROUP_LSM_START (END =
> START - 1), which contradicts C enum range conventions. While the runtime
> behavior stays safe since bpf_cgroup_atype_find returns -E2BIG for empty
> arrays, the enum definition is semantically incorrect.
> 
> The Kconfig help text refers to "Maximum number of concurrently attachable
> per-cgroup LSM hooks" which suggests at least one hook should be
> attachable.
> 
> > +	default 10
> > +	help
> > +	  Maximum number of concurrently attachable per-cgroup LSM hooks.
> > +	  Increasing this value has two memory costs:
> > +		- 8 bytes per added hook (due to growing
> > +		cgroup_lsm_atype[] array in kernel/bpf/cgroup.c)
> > +
> > +		- 25 bytes per added hook, because each hook adds a value to
> > +		MAX_CGROUP_BPF_ATTACH_TYPE and thus increases the
> > +		effective, progs, flags and revisions arrays in struct
> > +		cgroup_bpf
> > +
> > +	  If you are unsure, leave the default value.
> > +
> >  endmenu # "BPF subsystem"
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25444641622

