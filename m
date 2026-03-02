Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF43093D3
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438910; cv=none; b=Vhqf8YRIKqMcF0FIwd6qp/GJRruYHN9JBn7Sr7IgQwzMF/xPT4Z8AYYBni21AN1Xj5a/ZuH7QCFFpQnm8h1Jt6KVtfI55xPDOlxAEJ1nJ4YvmcMvxFVNQcK7iVgBBjS2bHzICH2MAtlRrMvUukzfnzHLedWhu95dykK8e+tFwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438910; c=relaxed/simple;
	bh=7dXyK6ozsmvSacmZBQXL9e0JKE9D+/u5o80S+8Bbcz0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqKVmqJi9FBzOpDFEYLuwkiby4zpxD3dw0307xt53+DWGsiDs3m/X98th6e3qS1+EgOSbKiAQBLddd+HUY3QcbdT+Yob550HpFATZ4zbNrkK1PpJvIe9q3fyeS3iYaH6KR2UQ5uSnRJ552JRKdSE+AzbgPS2q2RTYCUmwFGAtzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kgg9nmyh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kgg9nmyh"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-436e8758b91so2633076f8f.0
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 00:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772438908; x=1773043708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aywtoeuxkfunv4Ek8XeTDfrALEqJk4nC+4MbytSvfC4=;
        b=Kgg9nmyhwDp4M9HxRLZCuIzZA5/Uknb/21gXD8tW16u5VXQD4uOaRRjOMRLa+S0ln1
         FYMh4hRMKsAw2/Wavl65DdBmEgXh1i3cWcRu+Cmn4RpXHC4nkqMS3rwi+XdnHfoYv8zd
         Be63uF0qJAXsPox8RWRIf85ptWQamnaqYsPR8xf3lQxf0IMC2TKYwWM1T6woajuXyBp8
         ZTn8y9u/6mPs6HszeDO6EyAHc4jGwoPOPmUkfXBMnUTChdsaM1TztplXdqOyI9fr475f
         zCSwJ6ES3MA1JSGGMD4C25ZDEN27Fg3hXiGardbuEYDyMeuteGkTmUd2ccwlcj1hzPll
         fMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772438908; x=1773043708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aywtoeuxkfunv4Ek8XeTDfrALEqJk4nC+4MbytSvfC4=;
        b=tiY7v20zjd+zQVP/XHhLmYDCOrX8SUijLb/25MJPUIxCCw87ocxLCttlmjPh1Dhk3m
         IImvxbg0RweHv2iW3g9+RqC7y4dsz0NcWDFUeAJSd+rBrwXiWYsFKzRVeVx4eoal66k6
         l2qX5pUEz93Ok5ltvUaHFFbE6dYxQH474obTDaPfw6eynf9SbpXAr3iFU9IDunljORut
         w2YlpDCFjSqVTCH5Kx97mq2pECjsuBqHDm6082Bb+p0CKKzYIj87uVhXEm1elIPIxtH9
         fDMcEIDKg5lbwL1kfHGO7osaLQw+qgXaetl7Nzadp7Pr+MTxff4QZ4srTHm7ReyT4un0
         SM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4gKgyPlgGLYEwmPQYOAOvTuujzn8y2LGywNhZe2WCjnt41KNs3zw0kPBOX9BYAGTkHOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6bc0w7ZLRtR/HHgCewOi9CYWAUE6ciGTocIFjunlojnh5MUA
	Lfan/RCNnKOTdccFsvkXDPF2MeTVleKREpDvAjd2Z/LW6rWtBdgHpETPYDfwZ4OD
X-Gm-Gg: ATEYQzxOdx5YrpE4Z82kNATTFM9UQ1ELeNARJIVMpeUj4tCDV0J0vTEBWCmGdw69X2p
	esZxj0zScwKx+XtCkRnd4ouNR1VxoTSwKmWSL6Pfb2ivwja7h64JvqdiDTR62QyQ2CVfzkpOunG
	Jj3d4e9U71xIAk2QmzaXCtWQY6qpKSf/DyX1CcDt0+LZy7FZ/4ipazgnKq4+gjVs/fCpKzadZV/
	ZWxg+6O+put+AQ+iQDjQl/YsXGLdvbz5YToRxBG5fuiegUi6MGIDX7Ao3M6QsH7B1HKZ/C4Lrea
	3cAvHKEuCVroTpY4STL+PpQLe8VaaQu91CdbJd2409s7gL1Uhf1pZBw2Ibm96Eqla9KTzPityfA
	wuIgJyDjqWZxszsX57XUE/AlQ+fRrYY8BUXt1895sg0Dj4CrNVQwiEVM0kJFQe5UN06TWHE6x
X-Received: by 2002:a05:6000:2404:b0:437:6e55:a736 with SMTP id ffacd0b85a97d-4399dde3046mr20509566f8f.7.1772438907722;
        Mon, 02 Mar 2026 00:08:27 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a25dsm25282488f8f.21.2026.03.02.00.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:08:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 2 Mar 2026 09:08:25 +0100
To: Steven Rostedt <rostedt@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCHv6 bpf-next 9/9] bpf,x86: Use single ftrace_ops for direct
 calls
Message-ID: <aaVFeafZb76l9L0m@krava>
References: <20251230145010.103439-1-jolsa@kernel.org>
 <20251230145010.103439-10-jolsa@kernel.org>
 <1b58ffb2-92ae-433a-ba46-95294d6edea2@linux.dev>
 <aaIAoBZGkP7RQrvc@krava>
 <aaILlSuEgaYDq41r@krava>
 <20260228153921.19cd42a6@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228153921.19cd42a6@fedora>

On Sat, Feb 28, 2026 at 03:39:21PM -0500, Steven Rostedt wrote:
> On Fri, 27 Feb 2026 22:24:37 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 827fb9a0bf0d..e333749a5896 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6404,7 +6404,9 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
> >  			new_filter_hash = old_filter_hash;
> >  		}
> >  	} else {
> 
> As this looks to fix the issue, just add:
> 
> 		guard(mutex)(&ftrace_lock);
> 
> > +		mutex_lock(&ftrace_lock);
> >  		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
> > +		mutex_unlock(&ftrace_lock);
> >  		/*
> >  		 * new_filter_hash is dup-ed, so we need to release it anyway,
> >  		 * old_filter_hash either stays on error or is already released
> > @@ -6530,7 +6532,9 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> >  			ops->func_hash->filter_hash = NULL;
> >  		}
> >  	} else {
> 
> And here too.
> 
> As there's nothing after the comment and before the end of the block.

ok, will do.. the original changes:

  05dc5e9c1fe1 ("ftrace: Add update_ftrace_direct_add function")
  8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")

went through bpf tree, so I'll send the fix the same way,
please let me know otherwise

thanks,
jirka


> 
> -- Steve
> 
> > +		mutex_lock(&ftrace_lock);
> >  		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
> > +		mutex_unlock(&ftrace_lock);
> >  		/*
> >  		 * new_filter_hash is dup-ed, so we need to release it anyway,
> >  		 * old_filter_hash either stays on error or is already released
> 
> 
> 
> -- Steve
