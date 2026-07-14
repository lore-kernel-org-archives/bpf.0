Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896635028D
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999964; cv=none; b=aD0nZ/i3tzeWHtQO7vUnGyLFPSBYuU3jwu/qtrE+ceeXT3MtfWq/QMtutJhV9MWOLe1mYks9XyaC4QmTVgz9Hey0qqCIpj1o4JroDJp1piXP5niykQri0JXwQFNA08QpPZSpStgz/hjVX4xx/bphkO9+0Hl/M+XgwGGXGcuw9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999964; c=relaxed/simple;
	bh=5l6nLVdO88+2acJsOr1UCToSieAPDX3Bwyvphb8xIls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZg0ssF/6zTUHOld8vOFWwDHOZJRw1HKk1nX+UyAoiJx+I8D2tGQh0onv/tao2QoA4F0SPNMnIIL4zFDhEj5TBFGM1BSbLJVWWMy3W1DwMEsXHI+aYKKheaOgZ7n31JkEZ2mX4MJMeO/Kq5GIjIwIPnrr37SqHcBZ3Dg8IXeDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ArqdH1rX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ArqdH1rX"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so446714966b.3
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 20:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783999959; x=1784604759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bdiM3wGZvU9W32ITVwJWXfEY5ZH1jUwmribSUCxIuno=;
        b=ArqdH1rXOesSkDeZcyrn/gwmYeGCPfhD9ycpZxDFlq1zBr3byohbWaORK5xuqH9P+i
         Kp7BWm7ILY2LeTUxrHADGfcElxoWDlnPpBhtJ9OwCTU5hkGqqiTWQm0Ywi8VvSYSQhx4
         +Cg5J5j7gww51+d9kU01an3h1a3e4Rabush3KBhThPMvWOTRQiNcoknZwBpdgg/mzsTi
         QmsDm3aZlF/Affo/XDS+kP0YFn2VN/nccOxyxycivjBO/FYoSzCL+K9til6FtgxEq2Qd
         WLyI7qrwMz4UBX9JArXVYtfRCWB0a9sca3WoLrGIZ9Q8L8TRKbN899ZQjDFxMkn3yxz7
         Tg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783999959; x=1784604759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdiM3wGZvU9W32ITVwJWXfEY5ZH1jUwmribSUCxIuno=;
        b=s9BDf/eFekbYZTR4MJxyGPkTAmhFFJ5wzUzfNnpcfjCnq64uYG8U/BeucvczozZo0j
         Wy96P4rn9MAK6ght8hLmOBPh79qVY4KjEPddDl3FRRVgStiBGIVXwyBUO32JUKsAWLgf
         9rOSmp9k4narBHE7krUQoYYJqnOTNu6pFagkPZRCvjynne06YX1ONW4Se8Ts1k7zPy1E
         2E7vFmTCPiY074mi6fpajppfQ+0AKQl5VJkLf7crOOI2rR3gIo23FfmsahBtOfgTyJ4/
         VW7wEbjXNjJYqgV4uN0V+sggS+A2vdyVkVZBCDisAzye0DhmVYesa2GuBp6sGafAcwxc
         0aoA==
X-Gm-Message-State: AOJu0Yz1q1oLbHIUAfjr/8TvYC5s5gE2dO5A3KSC86MbA3XpAToFj+i6
	4UiziJe0kC0Tin/MepNZFum0LapdFWiEAUKpoXK0r+k1eKIIKbLGOatyhpU0cf0gitE=
X-Gm-Gg: AfdE7ck2qvVdVWLofgueDSyydMyFys8OR8GL4hoC0wQ6fUL2RHuQa5rQA+DcvIshn0e
	NGCdinNiTYBrik/ztqg5aFnC8hJWEL2OB/1K6GnACS7OaiNhWt/MJBwDqqLe1wx4ZlL5gegQ6QQ
	M6j8ReZhrbkXzj694nR9qKjuH0wYjUipZVkYMIbnBs2ON7gGMu3nKbEXF08q5cHammgZYOMhtY/
	Ch2ReiK40mxv5di/+VwGpkhDZvmInQDn2r9IOn8VkPiQH3v3YwLXsw75lj+1kcOH4g7dtSdNWER
	4v/mJpY93BcJWCicHJnp0j19WXKC/Rwh4JYBqf8sUF7j4uh6J/rbLGz5GYL9nN5JCKVma04+is1
	aVaVUYMwfavKvK5pLsCYe05HK+Pija/WjkY15Mi/FSIWm8Ryabv/YIEZLlXfY7ueacX7NvNNyva
	6bwgG+12NgrqztkZNr1A+BCP2dZQ+gi71S3xmncPpwZn4=
X-Received: by 2002:a17:906:f587:b0:c15:e8c8:34f with SMTP id a640c23a62f3a-c161e84b4a7mr493269566b.13.1783999959174;
        Mon, 13 Jul 2026 20:32:39 -0700 (PDT)
Received: from u94a (27-51-48-151.adsl.fetnet.net. [27.51.48.151])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2b79c9sm14334466a34.22.2026.07.13.20.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:32:38 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:32:29 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>, 
	sun jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Mullins <mmullins@mmlx.us>, stable@vger.kernel.org
Subject: Re: [PATCH bpf 1/1] selftests/bpf: Enable BLK_DEV_NBD for
 raw_tp_writable_reject_nbd_invalid
Message-ID: <alWsBzShn4sgDRl-@u94a>
References: <20260713063513.215781-1-shung-hsi.yu@suse.com>
 <08508d2133284d49e1da297895c85cf854a97bf3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08508d2133284d49e1da297895c85cf854a97bf3.camel@gmail.com>

On Mon, Jul 13, 2026 at 01:47:18PM -0700, Eduard Zingerman wrote:
> On Mon, 2026-07-13 at 14:35 +0800, Shung-Hsi Yu wrote:
> > The raw_tp_writable_reject_nbd_invalid test relies on availability of the
> > nbd_send_request tracepoint, which is only present if the selftest kernel is
> > built with CONFIG_BLK_DEV_NBD=y and the kernel built from current BPF selftests
> > config lacks.
> > 
> > Without it, the bpf_raw_tracepoint_open() call always returns with -2, leaving
> > raw_tp_writable_reject_nbd_invalid test always passing without exercising the
> > checks bpf_probe_register().
> > 
> > Cc: <stable@vger.kernel.org> # 5.2.0
> > Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > ---
> > Not sure if fixes tag is the right thing to use here, so use the cc
> > stable tag instead to get this config change propogated to other stable
> > branches to make stable BPF CI's job easier.
> 
> Shung-Hsi,
> 
> Thank you for figuring this out.
> I'd suggest we switch to bpf_testmod_test_writable_bare_tp() [1]
> from the test module to avoid the config dependency and let
> Sun pack all of this as a single patch-set to simplify backports
> (if such are necessary). Wdyt?

Make sense, that's probably for the better.

pw-bot: changes-requested

@Sun can you make sure to include the follow tag for [1] when you send
it? Should give a better guarantee that is will be picked up by AUTOSEL.
Thanks!

  Cc: <stable@vger.kernel.org> # 5.2.0
