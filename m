Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1922E65D
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559960; cv=none; b=U7XCOkxFN8CyjfYUoqoCg8nfS8D26WlchIl90JD6Ykt9TGUeuxR6gTPYHwOxAbUi3lzstH9bmOCECTxcD7OqT+NE+rzq6/Z5IaWRzwfGRbJ2QOS5XZieDsqenW+Qx0m9YdE0DMsuyKg8QMW5WO8ZHKmJM8i+Z9LDwO+ZPK+3uHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559960; c=relaxed/simple;
	bh=Abt7s4PkODrLPYtt/GowGs46G361XNVIuLXOTwhVOkc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0Xhyikfty55VTXnpx7xqAhvTCiJ3Si9S9RMKXNf0Fy17J0b0w1+mJXGf/K7HXOh8vKU/Owwfpn1w5DPTCB16gzLxHvCixaBUab6T7Teo8oFhB1x1YZN5sTdz2mOcoua1S4t934+lcWzIvVIoaYjQcOhXYn+1rpj7WmB3FrmUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaugMhAv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaugMhAv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490a76757e5so2475645e9.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559958; x=1781164758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K0S3H7P3znE+t+BHRumrEOEZYnM/V06pBrS5mPyks6Y=;
        b=KaugMhAvWst8U4ILboncm4+8GFtSL0Wy05h5ZOdlfkAljdHZc9YTHw4mFzYroxaod0
         G5NUhpYMEstLAZIIhbVTLzoOREI7mbUHsqXboOLHIW0A7CwyELJ7zTmsSK67SgBwMV7B
         kxSIdVcG/bCVDPD+X5zW1kBulv53G0+/awMaqi/VcZmaMwNB0ajEZ/J6k6nVuKDfnSQv
         LNJWgj9OT4+lIx1/x/5edwMNIBNfqehh2IoNVDMq/NZQUd/Ncx3NTVU9JpPaEkBqVbfd
         Ie78O5k5q67pfizsIWgxT/q6A8LQoQpahBJTeNp3+SlxQVgk0UY1wpzhzZGgYSPQabCM
         Cr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559958; x=1781164758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0S3H7P3znE+t+BHRumrEOEZYnM/V06pBrS5mPyks6Y=;
        b=GJvejjTwHyvBODrpzVeOQc/MGa5U+luALcsaHCx/ushuWTJfKgkl9IuUuuOHy0YglP
         F5QkDix2wH5gcA5PbK3Ckpf2a5p6PHHtQ2vgDAp9ZFYj8EAuOsAHA1C20ssILY9N1Mtc
         LuO372NfkMMdqPe0nbtaCFuS9lGsterSBBG8B8d0PEuw1Tm4MLaOkvsg2T/tCs3ldGqn
         p4W6FIE7t9YTlYzFoB463nl24vOoP3QqrntZGoawBK0PAZblp5LbK6T96dVTpvodr7N4
         JcBUvB2P5BrTTnLARLTJl9Bo3cI7s8huqW6m2bkdkchEZxby9QNcCHhlxBvP7zrK92y/
         nrgw==
X-Gm-Message-State: AOJu0Yy78czoSHWeeat5Nd76FeY4Le+OwVdJHK1fcSNcIL5MPwtHcQJ2
	P7/3uIhE0xwUHJkNeMhURjvEViihyMcKRqNX9GaScg4QFzjAMx5TSb7v
X-Gm-Gg: Acq92OEvonVh1KFzFU9qmYEoFAp0IWWZd4W4EKT9s/494FbgVqWwWepzVnYpLKLMVX1
	jidZkwQe/lPm1aMQnvjeT4hOVwEpZImrvuTRcK/Q9hgAE5PJIX49yr/KQEV9qz83uQDdWLHXxbL
	zauxv/XDwEqTWAx/r3oY/Rn6Lcewv2HdrewcftmdiBxWI4+Ii783GJAcX3sfMMNr1X5HKJgx76u
	nY+0qxsnSHHnvAkdj9czkjNfK8o3ry0OuueUNgUC7m4usYKwQKV3kYf88kEQFj/TZeOih1BbbRQ
	iUaCwiTlVuwdbN7Gy7Nfk6DiS8/gJbJDikuLLpICp3TJeTPpIXvqVWREQ+5OkybmaWgLUDdY0jM
	QFJxSTMslHnmJZMcnbOXlv5nJUJ6LRkebyq/BlwJ5+B2un1WBzXwPzEyFp8sAjWff4Z4Fp9DxgG
	EfqULL4Jzuzw2x6A2bE0eyMg8PXyRKxIaWplBz
X-Received: by 2002:a05:600c:821a:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-490c02430cdmr346815e9.0.1780559957627;
        Thu, 04 Jun 2026 00:59:17 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm13840200f8f.12.2026.06.04.00.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:59:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jun 2026 09:59:15 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv7 bpf-next 01/29] ftrace: Add ftrace_hash_count function
Message-ID: <aiEwU0CyceOkPrfV@krava>
References: <20260603110554.29590-2-jolsa@kernel.org>
 <20260603112630.3D1EB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603112630.3D1EB1F00893@smtp.kernel.org>

On Wed, Jun 03, 2026 at 11:26:29AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The generic ftrace_hash_count() API is incorrectly guarded by CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS, returning a false 0 when direct calls are disabled.
> --
> 
> commit 61129b2eed8ea43ed2c045ef25d031a4504c8af4
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> ftrace: Add ftrace_hash_count function
> 
> Adds an external ftrace_hash_count function to allow retrieving the hash
> count from outside the ftrace object.
> 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 28b30c6f10314..02c24bf766ced 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> [ ... ]
> > @@ -551,6 +551,8 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
> >  
> >  void ftrace_stub_direct_tramp(void);
> >  
> > +unsigned long ftrace_hash_count(struct ftrace_hash *hash);
> > +
> >  #else
> >  struct ftrace_ops;
> >  static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
> > @@ -590,6 +592,11 @@ static inline int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace
> >  	return -ENODEV;
> >  }
> >  
> > +static inline unsigned long ftrace_hash_count(struct ftrace_hash *hash)
> > +{
> > +	return 0;
> > +}
> > +
> 
> [Severity: Medium]
> Is it intended to restrict this generic API to configurations where direct
> calls are enabled?
> 
> It appears this declaration and the inline dummy are placed inside the
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS block.

ftrace_hash_count declaration is in CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
black, the inline stub is in !CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS block

> 
> When CONFIG_DYNAMIC_FTRACE is enabled but direct calls are disabled, any
> external caller will silently receive 0. Could this cause subtle logic
> errors for users of this generic ftrace infrastructure?

ftrace_hash_count is enabled for CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
as are all its users, seems ok to me

jirka

> 
> >  /*
> >   * This must be implemented by the architecture.
> >   * It is the way the ftrace direct_ops helper, when called
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index b2611de3f5943..57ab01fd00bda 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> [ ... ]
> > @@ -6288,11 +6288,16 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  }
> >  EXPORT_SYMBOL_GPL(modify_ftrace_direct);
> >  
> > -static unsigned long hash_count(struct ftrace_hash *hash)
> > +static inline unsigned long hash_count(struct ftrace_hash *hash)
> >  {
> >  	return hash ? hash->count : 0;
> >  }
> >  
> > +unsigned long ftrace_hash_count(struct ftrace_hash *hash)
> > +{
> > +	return hash_count(hash);
> > +}
> > +
> 
> [Severity: Medium]
> Similarly, does this implementation need to be moved outside the direct
> calls block so it is broadly available to dynamic ftrace?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260603110554.29590-2-jolsa@kernel.org?part=1
