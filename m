Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912652;
	b=Sq2/h0ac87rrBTZwm5qpc8oHDmk+G4LUWJg4anXhnp8AMg4+DjisBufP3TRfvmtpwy/+
	 3pCgGE+TxXjY1YpB3H3TGGY2NihhsvD5YQgviFQ4KvBi/x79gK5pLZ2Xl1xONRDbWXuE+
	 eDYzY0I4JTdYP28rc2FtNw+gl0kw1eSRveRIU+Vsexgkirq7Sk3TaXA9799/fPwODvwjt
	 Bc3yGrZiCjs5g168A1GuqKdYtl6vh7YewXpcYkfcOsp9t6xzQn4cNr4wT3IUXM/sCx9BF
	 EFs0oFvDuDVfEUUvLCsx7fhTHFP3k8IpTi10K640wfObIrTV44oBM2sZDMATLikDlJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EGxIARHwfDH+PiGjWxKomdVYqHv4YKk1Tq7/8Jn6Wag=;
	b=2JPZ1XRDfPPKQr4ASEWckwOGM/ZE/Dev1ygO6j/DLbdrL/GMS7I8ndnU7QLv92THDNsu
	 yeVJZVT00OdwJjBt9xoGEA2R7gq+8FxsL7hU/6Wbu559nJlh+U2lsBMnkyUDBLNdJmfQb
	 oAep0gd/1pZxIv8BNkdIQlw62h4Jac6XdPdiP8a5w1a5xIlpcS1zQDdSThH3N62c3pkMC
	 33kJiINIPrnWZKbCddEYTBJ3dEPL/fOcT36L0eins1HZv0JIwITKbit/FoLv1+fq0rQjE
	 bkUPD4Sa7QKdUJwLv6v8vetod3uMlzVLVQfn5m9pY0vxe4ggbXEQf4kWGtdqtzT1L7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B745606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B745606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-353804b591eso4433622eec.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 13:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1793912645; x=1794517445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EGxIARHwfDH+PiGjWxKomdVYqHv4YKk1Tq7/8Jn6Wag=;
        b=RR3ez42lbroTR0C7UAFjLFoiwgCT4dVKo2bv8J6+/n5BtMBcBzpgdfeUPjSBmEF3Xz
         hbx1NKwaXgJOSk2qVFv+KuUq3AenJUb9yZ5FfI1DDcIVzOuqWDgLL9YSJprGylG9zFKG
         VdR5TyUxoabuh47Z8B5MNNnopXGLMVjLpxPbc19rCQGxomIUocvckcIWO0B6dV1TJsR4
         nhI/cKC0sJXADNN0w2beQgsvvnkh1/v8YyJy8D8mpS9oWCtfUVKtN2sNLf6lnWFbOgHl
         Mq9XYNZt2fyxKb2RsWLuZ3G7QkPe4SBJZIZBuYxskyAHso3PvYF7QMnoUo/GLLifLjpw
         Nlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912645; x=1794517445;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGxIARHwfDH+PiGjWxKomdVYqHv4YKk1Tq7/8Jn6Wag=;
        b=FvktIxhCuoW/rb4dF0rCwqK/6lfRMD//oLRCp+m2I8ZieA2u4WFY4x8MX9C/uOr9lA
         VRNb7YCwuPoZgTkuxIvnCu2KW7MQUG3SJu6k6eHQ1HDujxIV/toXDPHSG16XT1O6fHBo
         wXY7+Vq3Mi202so7mxIVIoDXruJhWQna7CFJ/HjHaJjH1m+oneGf/eOUnXAxVoSHzmfe
         FqThoWD3K1p9BxH5RZLuhmWtk+Om8qmqEPOndWgMbw9jk7RoRszr6ODDf7oypnjW22mU
         3frDPiCzgwU8zYUZDlOqcHMFPssXO/3FengO3JAeaGwUlKAftXaJZUQqGqTO9l8miJtT
         wUMg==
X-Forwarded-Encrypted: i=1; AKwUvBzX9yzJ0b5MzVl9M3EciD6yIhL7EGiN+3Owqgdtd0UK+XrLJ+9AcLrwmEGZc403d7pFJFM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AGoZ+pLx2r20g625mpHW/IzaUOkNK8gge1P3TnJ53TlEYRuPG
	6mLjc6uUI/QtxUD6/q5QD6WzqbAbQh69fqfMYTpDcX+rbyqLSgVdPKOboYMXab7Oct4a
X-Gm-Gg: AYBFou1FhEtdsvpMtCHBlLfnX+vE6E/I2t56MEwfMNw2xw9jqnxJ8diQBr6MxeQWASj
	b5gA+cbdbHYCGqwRlAVB1vKqgmR/cuS1EOc82zYxathC+8tCVZ9yr0TBFIljxubHTPfMslRX21w
	7uQKae0aK/Ai8pvIk3mzf9favMW2hmlOIWLkGE9q/uUTLdhTt9G3RUyf+MNvj4QvsSZQQeCo5BO
	AQom0PwhlZWf4MKHvsb4PIQti8A4WsMSPwpZX7aiKSkGwFXVEj4uBjPwg0vfgy9t4Is5dnL2FcP
	IRITHVZwfIrgdLIO8azBZhIXf87d4eWzdSusLceiGug80KnsMKcwGTDvuBJWtNY7tuK6dWiiMNd
	2iMtMUL9+bUOROS5Fr/7dGVKogcii0aBc44RHAQ5f3wFX7r4iwB02PrDc6t7QxDGODGZlxqhytZ
	xNEI0nJqelW1WPlkcUMP/wP75mFFIn35oo330FAtmcaNXlbmvcsqBukjLeZINbCkmGdI7x08pBs
	AMxhjDC4wTUnGnL/y+j5EYDN8zypLBgJR1CadxXOra66tHHu3GUMbTcQDAgm1CR2CsIlTUSkf69
	xx7Z8Qss0wwzPiBcU2VhZ5XpGu8PLGWb3HpMRUu6xzUHLQRJ2nrXQ0Cb8HTZqEsxEaleGmnS8uH
	yM5b8+Q==
X-Received: by 2002:a05:7301:251b:b0:36a:1e0a:accb with SMTP id 5a478bee46e88-36f7631c69amr422598eec.35.1793912645000;
        Thu, 05 Nov 2026 13:04:05 -0800 (PST)
Received: from lima-development (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f74069e31sm761960eec.0.2026.11.05.13.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 13:04:04 -0800 (PST)
Date: Fri, 6 Nov 2026 08:03:56 +1100
From: Matt Bobrowski <matt@bobrowski.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
Message-ID: <auzvPMnq2vrLaBdB@lima-development>
References: <20261020105014.97985-1-matt@bobrowski.net>
 <20261020105014.97985-2-matt@bobrowski.net>
 <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
 <atiawbBo6WRPA6QA@lima-development>
 <at_MbcW0OlciNLrE@lima-development>
 <20261105-berglandschaft-mitbringen-baufinanzierung-c0542594d218@brauner>
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
In-Reply-To: <20261105-berglandschaft-mitbringen-baufinanzierung-c0542594d218@brauner>

On Thu, Nov 05, 2026 at 04:44:34PM +0100, Christian Brauner wrote:
> On Tue, Oct 27, 2026 at 08:55:57AM +1100, Matt Bobrowski wrote:
> > On Wed, Oct 21, 2026 at 09:58:09PM +1100, Matt Bobrowski wrote:
> > > On Tue, Oct 20, 2026 at 06:24:42PM +0000, Alexei Starovoitov wrote:
> > > > On Tue, Oct 20, 2026 at 03:50 AM Matt Bobrowski <matt@bobrowski.net> wrote:
> > > > > Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> > > > > is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> > > > > cannot race with that.
> > > > 
> > > > The crash is gone, but so is the path. file_release progs will get
> > > > -EINVAL for every file that a task still has open when it exits.
> > > > 
> > > > It also breaks what works today. The d_dname branch in d_path() returns
> > > > before it looks at current->fs, so at task exit a pipe or a socket
> > > > resolves to "pipe:[123]" now and to -EINVAL with this patch.
> > > > 
> > > > And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
> > > > that current->fs == NULL in do_exit() breaks d_path() called from ext4
> > > > open.
> > > > 
> > > > can we fix it in d_path() instead ?
> > > > With an empty root prepend_path() goes up to the global root, the same
> > > > way d_absolute_path() does. Then the check in bpf_path_d_path() is not
> > > > needed and the selftest can expect the path. A chrooted task gets the
> > > > path from the global root, but it doesn't have a root anymore.
> > > > 
> > > > Something like this (compile tested only):
> > > 
> > > Prior to sending out the fix, I also considered addressing this directly
> > > within d_path(), much like you've proposed here, but decided against
> > > it. d_path()'s contract is to build a pathname relative to the current
> > > root. It does fall back to a root-independent name when the path isn't
> > > reachable from that root, but that fallback still presupposes the caller
> > > has a root to measure against. An exiting task past exit_fs() has no
> > > root, so d_path() has no correct answer to give in that state, and I'm
> > > not convinced we should invent one for it.  That's what
> > > d_absolute_path() is for.
> > > 
> > > You're right that my patch regresses the d_dname case though, since
> > > pipes and sockets resolve today without ever looking at current->fs.
> > > Rather than replicating the d_dname check in bpf_path_d_path(), which
> > > would mean duplicating VFS logic such as the mounted pseudo-inode
> > > special case, I think the cleaner fix is to move the "no root, no
> > > answer" check into d_path() itself, after the d_dname branch:
> > > 
> > > 	if (unlikely(!current->fs))
> > > 		return ERR_PTR(-ENOENT);
> 
> That seems ok albeit fugly.

Yeah, not super nice, I agree...

Anyway, I'll respin this series with what I've proposed above.
