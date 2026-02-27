Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F9321457
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227483; cv=none; b=EVCx3xH5MvAl/u6kmxvy6z3/FO2rg8NXEbngEfm7/bDYysipSqIpZGHdfkogv6CHSgj8V0ndA7nQWofa6iJ0pZIqHcBm58TQ61IhpnNVHIfqcZcQCztrJYLOtBIGXCeFOh/STQLl9y1xs9Nt8zfqe5BtWlQ+yd0KP8D1nTrEcQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227483; c=relaxed/simple;
	bh=NIJloWgD9WAAGQfFtnF1QseEYYG4ymg++K/OMhZ2rtU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPZ1Pd6bngppz6Lni+imR2VtdRDm41o9GPjj+WzT6W6rs0vgcy/WU4vLYHb7fNgkCaAsNTH8Pm3UPLGpONPIFlXCoPF6vtGMSOx9NpBi/df+E7QYpPEtNEQYK6u+qHPme7EYatEhYIW3rheAueEwfUyZGTidhT0+npXgstK+pKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUFk/hr+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUFk/hr+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so26941025e9.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 13:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772227481; x=1772832281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lYyRSetlqylah8/QdNebjp0c2RtHTtrWCx74F8AAY04=;
        b=TUFk/hr+znhvabxB3hAu5HqCeKiaoCPAOHAHdqF51NvXCK0/5dOHDIPaXYlyHEjSvT
         Ge4P9/tdAmaWh8x0pqJsqHeXhLsVa6BCUShHVgyFQ4BCpUB+4IMLO0rk7YuCLa0Hut9q
         mCZq/aednNT3faw+JaSwxU1IyWvncyetZ6gmBq2rojJDzonthl8PdWzLs5I8APa8BfAJ
         6C/aTFGQ1LKkZRrqfe7rC/4Xw4uiWCZFe0foDLnOm96OW501yUFoGC2ywJkr55MgjuLp
         EsnBTCsmqf4xEneNBjcrXwHjlQmg+Dho+0htSGIbl5F6DQVn33TeOibhx8nB/bDpb5Ra
         NAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772227481; x=1772832281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYyRSetlqylah8/QdNebjp0c2RtHTtrWCx74F8AAY04=;
        b=p0jd4XPvDh3E53Vg6s2dhkGL95QR0zocesgQRWwrZmGlmdEuc+UQzeC875sP/yaDZN
         cbPMguSwgGejgM/LhgwaBFoOS33YqKKcSMwmO4rHjMwyd/VX8wLWa7Kw5DRLyifZgQx1
         OJqmTqw9vl4wJw5wrDEcz16gbvbSD+o88liO9S4trJlZgn/KeMs3kXJtQwfV3zB+x0kg
         r0KqHzVQ04NQi6ynrn9mPf0EakbRwAjtOceO/pg6lAcxf7PVcVg+5+ZH39Nzkpfkvj/R
         M8e/P4zYfzfLBxby0ywP24/ycAhIsmdHZRAbcWzYs8MtToZYlbnbTS61ePOebEhZYnJL
         ZzJA==
X-Forwarded-Encrypted: i=1; AJvYcCXRG0wfMpTm1nPC2UMHkoaYeIcKf6QiCpZMMBLCC4icAzQmRomSgltGn9LRZBq+5QlKbfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvcsOkTWwAKdL1BE5lwjostGOicUt8HILxFrgEoVdGqmKRaM94
	K6zDuaUSyo76jn//Jgkc0+Yg6mBbYo1i0CQ1x7NMM6M01u4EUSvU64dM
X-Gm-Gg: ATEYQzxmizVxMdbc7hZ/O6Lo8NkZmEimFWcnXgj+HYi5an081jf51eHscQw6+8y8a3i
	5F9fq1WzGbk09yk6J8nI/fpsxrt8WWOGk2g2sRAlIeadHy6Pm9wmL5oVsHf2yK3FOnECC+w61j5
	RYR5NJqjjV5H0PIBKSqAdZn6aHsWFdp+f63oWPo+IwQZRTaiH60GxTSWsSgPFCMvpOg9pHKI0Ki
	Vu3sBUSmvCTulfRHEVxliEde1eUdwmdYWhplR6EvTeNqv9j9qgSHFKS9Gl4or4pEG1gsDd6z7Cx
	gzDm+P5VjpdEcj8yRcVyQuh7jn3cTT7wUbQvGWhCSzvU/Jnkzy3TBSQhLOOv5ppuOytrVKvxFNX
	/M4gRIP85eOeNCbaFBTnMGM7siHTT7+PlDdFu7IMzUK7pFG5im/TkkVVUMlDnQvR1Qfsw9U4rR8
	0eSm7yXT+eBR0eDHrUBCX4gw==
X-Received: by 2002:a05:600c:314a:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-483c9ba7e58mr64072115e9.4.1772227480275;
        Fri, 27 Feb 2026 13:24:40 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c764546sm10133971f8f.29.2026.02.27.13.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 13:24:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 27 Feb 2026 22:24:37 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@kernel.org>,
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
Message-ID: <aaILlSuEgaYDq41r@krava>
References: <20251230145010.103439-1-jolsa@kernel.org>
 <20251230145010.103439-10-jolsa@kernel.org>
 <1b58ffb2-92ae-433a-ba46-95294d6edea2@linux.dev>
 <aaIAoBZGkP7RQrvc@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaIAoBZGkP7RQrvc@krava>

On Fri, Feb 27, 2026 at 09:37:52PM +0100, Jiri Olsa wrote:
> On Fri, Feb 27, 2026 at 09:40:12AM -0800, Ihor Solodrai wrote:
> > On 12/30/25 6:50 AM, Jiri Olsa wrote:
> > > Using single ftrace_ops for direct calls update instead of allocating
> > > ftrace_ops object for each trampoline.
> > > 
> > > With single ftrace_ops object we can use update_ftrace_direct_* api
> > > that allows multiple ip sites updates on single ftrace_ops object.
> > > 
> > > Adding HAVE_SINGLE_FTRACE_DIRECT_OPS config option to be enabled on
> > > each arch that supports this.
> > > 
> > > At the moment we can enable this only on x86 arch, because arm relies
> > > on ftrace_ops object representing just single trampoline image (stored
> > > in ftrace_ops::direct_call). Archs that do not support this will continue
> > > to use *_ftrace_direct api.
> > > 
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > Hi Jiri,
> > 
> > Me and Kumar stumbled on kernel splats with "ftrace failed to modify",
> > and if running with KASAN:
> > 
> >   BUG: KASAN: slab-use-after-free in __get_valid_kprobe+0x224/0x2a0
> > 
> > Pasting a full splat example at the bottom.
> > 
> > I was able to create a reproducer with AI, and then used it to bisect
> > to this patch. You can run it with ./test_progs -t ftrace_direct_race
> > 
> > Below is my (human-generated, haha) summary of AI's analysis of what's
> > happening. It makes sense to me conceptually, but I don't know enough
> > details here to call bullshit. Please take a look:
> 
> hi, nice :)
> 
> > 
> >     With CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS ftrace_replace_code()
> >     operates on all call sites in the shared ops. Then if a concurrent
> >     ftrace user (like kprobe) modifies a call site in between
> >     ftrace_replace_code's verify pass and its patch pass, then ftrace_bug
> >     fires and sets ftrace_disabled to 1.
> 
> hum, I'd think that's all under ftrace_lock/direct_mutex,
> but we might be missing some paths
> 

could you please try with change below? I can no longer trigger the bug with it

thanks,
jirka


---
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 827fb9a0bf0d..e333749a5896 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6404,7 +6404,9 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
 			new_filter_hash = old_filter_hash;
 		}
 	} else {
+		mutex_lock(&ftrace_lock);
 		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
+		mutex_unlock(&ftrace_lock);
 		/*
 		 * new_filter_hash is dup-ed, so we need to release it anyway,
 		 * old_filter_hash either stays on error or is already released
@@ -6530,7 +6532,9 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 			ops->func_hash->filter_hash = NULL;
 		}
 	} else {
+		mutex_lock(&ftrace_lock);
 		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
+		mutex_unlock(&ftrace_lock);
 		/*
 		 * new_filter_hash is dup-ed, so we need to release it anyway,
 		 * old_filter_hash either stays on error or is already released
