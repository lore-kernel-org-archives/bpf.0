Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571358;
	b=qVGqxeESaVNDp9OzlIV/8En9yLGKdXZGfK63aPDyxcKPrrMsaThNBqdpBdLvQe0jOKM1
	 3suFwLKCR0gSecxShIIfkjheR+10k5DDo7Vh28yNjnMMMpdRbkSvScEddBt9nxkH93u3e
	 qlBoTgXKDJbm143olzvnp9W9yFTbywARDLPN7XymcCIAR6wYs+0cMsdXVBQkAoeS/tHDr
	 F62yYmYcuR1IlwpcUgVW/zodKduJ5hoz2ho3WVrPt06fv8XdddM8kqQ5fk8HRXMymaOee
	 46aT7bo/ucDZx7vAFvp179al+APApgYppP+WDq1CuC0eCjKtP5wk4+BANnMq/4nNlow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ePINk0mSFf3VIuXGADrPFF3uNMGNrwU5/iy/vZOc9s4=;
	b=2C20tm1vBiZaBuSOVsM5G+TNbqgw/Mrfz4LrmQ7wi2QfxGXN3uWD54DUQtAgO2nqUKRU
	 M/6ffbatZpdUdruwDkdzVCsN4MsYgQSD0q8krFxXi9MUvNUXyDIMRhmC87XR5VdYKHvpW
	 pHgoP2i5iw8fkRITJZ1QeADZSvSpzeAoNXqKqFf8HFjFcBoEuv9SAGkYTFyJcfjjrDeIw
	 LSuy52CuPcSW6TM1PTbz/7/y55nyQOLJTV2NdDvlrWtAYGGd7Xy0JoFdNw4cHo9drer+j
	 gHis0FcImaDlZeoxVLTn3gANRN+NgYmRzVyDr4Ad8VqKgEOGv09qD3FhyvCabswNlMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S52GLF0s;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44A606A890
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 12:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F44A606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S52GLF0s
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so8711375e9.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 04:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794571356; x=1795176156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ePINk0mSFf3VIuXGADrPFF3uNMGNrwU5/iy/vZOc9s4=;
        b=S52GLF0sFG4+vIRlUUXcyfi+FRVt7RgHAJCkDJqkA7q3KMtTMZXAIEj0mx31JLWQB8
         KaPjL1hFuFOmGPEOQSdpIcA/Jk0EZczKJekwl/94gNmTItLiP9kfd1KI3plzL3ePzByy
         QMqa6I88O10fTb6++ga+wQykKJ0+1R9ExxM8WQbO0P/CtqcXJsfneAeHD+bRxmuVLW0F
         MRGd1xyyJRnI9Omk+LrL7mLA3wBK0i2O5qRClLuW2rLuYbfxPMvZmeps0XlnCRbNS9Oz
         Q6FgSKceF1SMBXYrS1pqwG9JRcplC7wOP+X3KiRUp6wg/OuOHKt6SjS3P8AhI9/9GnMQ
         vtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571356; x=1795176156;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ePINk0mSFf3VIuXGADrPFF3uNMGNrwU5/iy/vZOc9s4=;
        b=dEvDGNywhzVCUYRUHjx02N04K0Ny/WjFbhttlS2kf5ugKjTj/84tRlu3PfLwfWHSLv
         8XkAG6AjEh0Bg0Ot1O3Q6yx2zfWMZiihIVP9gc1q4520qzS8RAApMtSJAqHPyewATPv2
         iOfl9BU2TEXeso9CExDFBQ6dHnjXoWeVJ9YWpk38RVLkcY+5K6ASQDtONd/458r/LCkY
         nS5U9QI06Ac6dkfcFbYK0l9/YHdP0dRfXqerTsXX9yTzIGL8neURAzI/owmg5jKcR3Of
         MGZ91QuG3dFkTbTDXZBrZTS6lqmauIPsbE6HKOm8sGZ29U+iUngOH3DavZoOVJ8egU31
         uFAw==
X-Gm-Message-State: APuU4Z9/rxnvY0nnAtWRM6HOaamn5icNlafnZpk4ZK9Q1ruBTkViISw2
	2CLG1i33eEW4wNd3rzhbUbPRJmunj35EApT1GcJcofUt/SqWTp4MEg8V
X-Gm-Gg: AYBFou2M0bCufkwD1CFqS3IN3QOV2hePtBmxl4V52y61oo7Fe6E/cuqgI4K6XAwLpDO
	svTyEMxagCewIDzsJKvQ/bUVliP+RIlK/vrskiNf8dRdNg4q7aXH0YWD/T9TJJxgZf72aWixFEa
	RgOqTc5KtsI4He5hPVU+8qHNpyRF3weJGEvokGq4Xzk2QTKqvWPVRvMShOILtNanhFj5xpys57G
	0pWzAHNFtYDx4M658V0NQgveCMFNFuFnzAWwMQIvjQcXA/2eITox2vAoecO50OAEyT4bWj9hX36
	Ln2SzcCiJh09ZSnKxRTD+JXqX2cG6WC2trl6tMEj1H/1ngM7QOPI9pXR/zq788649SeLG78gGa6
	2oJwqE9SqzUyhSa9F73tNDVqbIOKevH5rbr8OCoGBrNN01ymIuuJ7ICAjGvmZajZkAOjXRxa93Q
	zi4fZTOlZNJrJNNxs8aFW8FiBs/UPqDeIHxIRDSNJs8CBekpzPjbfo+5MvZJWJD/8wujo65G8Zs
	VOIwS/C9iT6+36+UuxV0Zyd+5cCKt3QaY/qMlQE8bi8usFV+YRvh/5DATJTncmm4Rcmr8yD2bPV
	dYauN+QY45a8QWFUd3l0m0pOGQLjhMrRf0TiiEJDa2t6bMPnKJCbg5hlJKs=
X-Received: by 2002:a05:600c:55c7:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4bb55a8d13fmr33670975e9.13.1794571355926;
        Fri, 13 Nov 2026 04:02:35 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm253302365e9.1.2026.11.13.04.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:02:34 -0800 (PST)
Date: Fri, 13 Nov 2026 12:14:09 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [PATCH v2 bpf-next 08/13] resolve_btfids: Don't list an error
 that follows work on an argument
Message-ID: <avb_ETHW4LCryuhQ@mail.gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
 <20261113050901.1399091-9-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113050901.1399091-9-alexei.starovoitov@gmail.com>

On 26/11/13 05:08AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> A program that returns an error skips f(). A skip of f() is not a failure
> of f(). ksys_dup3() takes the lock and ends with "return do_dup2(..)":
> 
> 	static int do_dup2(..) __releases(&files->file_lock)
> 	..
> 	Ebusy:
> 		spin_unlock(&files->file_lock);
> 		return -EBUSY;
> 
> 	do_dup2() fails         dup2() = -EBUSY, the lock is free
> 	do_dup2() is skipped    dup2() = -EBUSY, the lock stays held
> 
> A caller can rely on what f() does on each path to "return e". The rule:
> 
> 	An error is not in the list if, on each path from the entry to its
> 	return, f() hands a pointer that is based on one of its pointer
> 	arguments to a callee that returns void.
> 
> A callee that returns void cannot fail: what it does to the object is done
> when f() returns the error. Most unlock, put, free and init functions
> return void. BTF says so, no name is needed. A callee that returns a value
> may have failed. "Based on": computed without a load, as &arg->lock is.
> 
> 	forward, may   the registers that hold a based pointer. A call that
> 	               hands one to a void callee is an effect. Does a path
> 	               without an effect lead from the entry to here?
> 	backward, may  the analysis that is there. It stops at an effect
> 
> f() stays a target if its list keeps an error.
> 
> 	                tagged            errors
> 	x86-64 GCC      12817 -> 11985    20967 -> 19248
> 	x86-64 clang    13549 -> 12633    22964 -> 20889
> 	arm64 clang     12435 -> 11543    21304 -> 19186
> The run on vmlinux takes 0.2 s more.
> 
> The tool does not see
>  - an unlock that is inlined: it is a store, not a call
>  - a callee that takes the object and returns a value, a computed callee
>  - a void callee without BTF: f.isra.0, a name that two functions have
>  - a pointer that was spilled to the stack, or loaded from the object
>  - that BUG() and panic() do not return: the next block counts as reached
> It also leaves out
>  - an error between mutex_lock(&arg->lock) and its unlock: both are void
>  - an error after a void callee that only prints a message about arg
> 
> Outline KASAN and KCSAN add void callees that get a pointer, such as
> __asan_load8(p) and __tsan_read8(p). Each read of *arg is an effect then:
> in 32 files of fs, net and mm 76 % of the errors go, not 6.5 %.
> Inline KASAN and KCOV: 6.3 % and 6.6 %. Targets are lost, none is added.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The robot's finding is real, otherwise

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
