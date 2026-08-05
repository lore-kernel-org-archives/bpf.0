Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9DF1DC198
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965831; cv=none; b=DrphAAHYSRaaghX20WENyIWMughil8K4sikAnAxpPUOwYl6gdUmlKD4FNnVQzC3PRrHhI0tBWz9D2d+qcNACLKSL5T6N8y2tFnDQGVt8BsR6w7FH8y+20hbEYyJXP3itGm823fCVxcZ4q2+us5aj5qXW9R0T4RFrBQXHC4t82jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965831; c=relaxed/simple;
	bh=ybn3edS75210yGXHR8plER5wB6+bwq7DsJxlu+7rHU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQbnB9rGbKvxVtoNlXkyl5+BvMHgZeViBBgkrFDv9K4EpGrmAPAHdmraiFJWdCikDrDVdSliqMGrR7tyiLL4C/ANMuNaiKwaKHG8my9rhFTztaL6zaAqBe1N21QLmdwwn8Rf84HaAdQ5zSfa7I4EmYE+/hj9pgQShx5PRG10/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3QAhSxu; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3QAhSxu"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66899c7b57bso2024777d50.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785965829; x=1786570629; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJ/f/QQNT6OWCbAu3IB8DxQ9ZnyppnwIAD+QIRJse9g=;
        b=Q3QAhSxuHwF7ThIMUDCku95Bjrooo3TnufEF2rcHFZ+wuvrYOiHwkbqZ1HoEY+coXz
         t14yH0GezNHRgvxBa+xE7pt3tmn/QamWFuad4SvsRCMsa8/PtKI5r9t3GkNGLSBdaOlg
         UTgA8AdytrBwtXeUWNueYCuez+ZP0YUzeRxpweA5dRcGQWGfXkBHxr9h/51vRw0V7f1w
         v52TUIBu7GWrdPpjU3tEEsjG0+2tm3Rk9yJoZKifXM50F5/IyH7hIfuBHPhPpsfPUDlT
         Qk8/SdPe3eb3Eg+J5i/e6wYyyNkqOtGCn1SgZfk7L8+ZbkdfxgLxzvwqPMjx2B3SqOp8
         YW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965829; x=1786570629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eJ/f/QQNT6OWCbAu3IB8DxQ9ZnyppnwIAD+QIRJse9g=;
        b=k/zVcU5+zwnqUSqqz2B800PBJ874dqkP9AIE+zxRw2nGf98epqc9GFKgUSHY7fmmHf
         e9daq8uBQfpu754F1l1hO7++mL83hBhzUUt5nZuyujmWiYf8ALNvPLYjXpa91QecQhWz
         8xhSoNfwBQ/b80uchUNcp/Cc8/3d/MMnlPddJOElSImSK5IFOO/dPb/7TR3OF7vMBz6J
         GPFaWt3ZmxYKGifUtOA/zkcelUdWCgfmQLq/Lk3p3Xbn3Yo3dryTktEP4iYnoHQqL/nF
         tvLuwu41SWZB+DUjzH6yYZIPN4qTmWES4osi5HdnEvHLYPOJDn0orsdvGV229wl3fmZg
         hMlg==
X-Forwarded-Encrypted: i=1; AHgh+RpLNtln187fXXwl5JYIIuW4lIK2B3ixBEUko3xaSkg9zhjH701T66j6+D3IsbJ2DAz8vzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwASlFgQVGr/y4yCxbMCacDTLRx2yPIoUVD4WALNqoW9U0lab6J
	qi/eYLWaekVfR7xmDnOrPgU/x+m4EPwDdbc+4kCCz7oE9LWyNXq/5gCT
X-Gm-Gg: AR+sD11+s6aM+tWWndahj+q/48qnFWOVlBMlqBny9U9Gs9XYuMY76OTcfXjD7btSvky
	uRxJNXMz/sNFy6O4U/36kbiLdi4qFP4r0m5+xpbeE7AqrSOJID9u5Lnn+6xJFPF/KfqCpUWISeu
	JnMgHnXaWcYecOqu5y58K8EnVcUPkU75UBAqeM1A6NzrN5kd0WmxxiymeS/deT20W5FUZ1zmrnB
	2KfQG1jJXhfkrfy5mR0Dpo365iRoB4ZJX4siTIi90i54QfCTI7Lp5ssLV9g3DuW34p2qKy04VJn
	+n0rfwHp73vMylQBzJ9s/xXCOspLaSD7TwTP/zsVz+0VmeuKjemOVEMgE80nRIGyxuFgrCaD891
	a7Pp2DKdpiec9rqs1sZ0nr8VNhDPjWBMbF5j3KQqB9cmH3K34iMsrkg9cmKAbT+Pkhlto6LQ7NV
	aClw4o+7GhJAlJSirFimNt2tMuT9/IgkIFnwYY/rRvSsrl/AlmJpXEsmVLjpPxI0WYh18jdYqoB
	quFWBEnKi07MEi5n/iRIrmdQTA41QMm+g==
X-Received: by 2002:a53:b427:0:b0:667:9d0c:5b80 with SMTP id 956f58d0204a3-6699ac4ef5amr4215598d50.28.1785965828960;
        Wed, 05 Aug 2026 14:37:08 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:7d5b:ac23:cde9:3664])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669915f5a75sm3862542d50.11.2026.08.05.14.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:37:08 -0700 (PDT)
Date: Wed, 5 Aug 2026 17:37:07 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock
 rulesets
Message-ID: <anOnaGmBTlBW9xwj@zenbox>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>

On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> On Thu, Jul 30, 2026 at 10:21 PM Justin Suess <utilityemal77@gmail.com> wrote:
> [...]
> As you may, or may not have seen, there is currently an ongoing debate
> regarding the location of LSM kfuncs that will impact this patchset.
> Sadly, we don't appear to be approaching an agreement on this issue
> which introduces some additional risk to this patchset.  We'll have to
> see how that ends up, but I just wanted you to be aware of the
> situation.

Quick aside question: Would security/bpf/ be a better place for these
type of kfuncs?

security/bpf/bpf_lsm_kfuncs.c could be for LSM framework kfuncs,
and each LSM could maintain their own security/bpf/<lsm>_kfuncs.c
for kfuncs dealing with lsm-specific types.

One issue with just security/ is it's not CONFIG_SECURITY_BPF. But
security/bpf is. Right now security/bpf only has hooks.c so it's free
real estate.

That way things are more greppable... (important!) and we can have
proper MAINTAINERS entries per file so emails get routed properly.

(linux-security-module, bpf, and whatever lsm list)

Justin
