Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D03477980
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198095; cv=none; b=S2jYJj8fnkgUFxqK9kAl5R3hEuvLSyrPMc7hZ9Re3OiiULzgk6eUa+TCUa+1kJNy2m/5sZC4APU6C3FWYfptmGXLp+TN5oNO74YI9KQHCtw2my8CgZKajZg55jWTRPFbLm21jsthxqgcOvVXJzlUwI2Hhnkp7F0Ko6iCB86siRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198095; c=relaxed/simple;
	bh=C/Rz9qm1AS7WcIJwDp7Kv3cwkoR6F2w0jDkOHOcFIFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGtb8a3bgLKDRPtbEE/o6/xbmyOwO4wyR/mFXSX8QGnnTlVmryd7tYZHi4gkwCJcQh0QqICVQSOtO2arUO8MFzhv/7lvqAdiTv2vbM1IrJCunqYqRTMV5M8hSuy4cBokmiL5oczKgSA81E5ntjUFAzFexPg2sWIgKeJ13DBibWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/3gY3aJ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/3gY3aJ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90c4e297a01so33156916d6.3
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788198092; x=1788802892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gve2pugT7l3BMYWVMzhugMxNXpv/Y4BKioJOYqJB6Is=;
        b=H/3gY3aJZjb/853Y0ygGssCvXexBNV7ijQaHpGAfUzoEZkuCUQHwyTuqBigVIvUjz3
         jU5zRsdLKMa5OpLORvfvdNuUFCuLG55mu2A2/YEugk0Jf7UCtqvE7IRNH6O5sLLlfIrn
         P+nVPPvGujofLsCvBLJd4YJy1BES4qnyjspmgsOrVhO25rrG9ThK2wxo/6pa+nHc3AWc
         4+U8AyqJ0AcYf8Q/+P33Fa8yHo8EAU3Fsw0WiR65EHWE5NNysHzIz/LpRIm/9j8zQyzF
         9n7Y/wJibiwY5oGUPAR4EsAeJgWf4gpfIkhiHnJFsRyHcATed2A1N8Loq5OsjVtshyuk
         /0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788198092; x=1788802892;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gve2pugT7l3BMYWVMzhugMxNXpv/Y4BKioJOYqJB6Is=;
        b=OezAsJPRa9VMWzv6b14A0yiohwX/anaIVfuYyGMV0p3te5a2iBjSxkYeTksXk5NroT
         OyWShHziOVCOuqlkC6tDt8cQ5AyaTBjcB9fUrAGlTnah6s0tLEu6J8FWt5l1nMJTZ1Mi
         04ISByvyDXiOgix3OJAW/gKJj7XltPMj7/04XoS7KRbWOIG/gwa5bZxkl4TsodEc+wzG
         zDcA5d9Ck/jCIfJvTaCVyIQqxr8Gip+7T8xzoEX+r5tF2xE3AxFT0iBcs7S1LX973/hB
         h9+UwmAQ4J5ghqnAd6OaoDLMvMCoTsy/pbi4C2MiXUKVoijD0e+iXU8pKZhi/p9iOKA1
         hZ1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrSiCjmeHpzyOHdTxhLahCV6fPwRlXrTBc60HHZPVSejqyNTsyk1vLMQTTXTd993eV4PAo=@vger.kernel.org
X-Gm-Message-State: AFuF++n9MhkLyrbVizju5+Y1ygZXuP0042Jd/U7wqrMYM5QWIlXEzLRF
	myXQ4JJBjxEjtvH8xw5vu4a3UQNeyIwDi3qNkLv/+7B6UHasbi99SFLu
X-Gm-Gg: AR+sD12ydkMHQzpdMN4VLkbwob0RuCASE0u4s3HXpJwO3gN5WhS9Wclj9t3J4oQnD5Q
	D10n724scImX5Am+lmvYqTZ2hgyplzeoavBKaLr5TJWRinxBrxa8p8YkeAdvHbgvPo98c2tceu8
	XY1qIpA1p6AeLgMTB8Upc/XcaVx4U+NL017KPDSXt5YvoHKNrh0YcnFM3xeBRZIUl0n0tbjIsL7
	9K6eReRDOI82qwvXgemhjRjuBSwZsHo/aEtzEVcbD83iszt9+YPEAcr2/VoD3UEKCaqFeY+6da0
	SRm+MwU8+IwIOpUx7XHnY4qztn0XSefZFWoXWf9Q+sM107RHTOHVFvdVec0VNZRCDwqgt7XHJus
	21WGkRk/TQoOMz55WpeDhvaIy/JbKb6fSbW8cspT3U7wE9TA7/I/lwccFfIJbV6Ms1xvJDzZGaU
	UHbtoEGFiPI89KQEaHXaCwLtswT5vkP2LRIwNlbTb5NjOBe05fOzO5fPTmDj5VHUOZ4q3LQi5k/
	zvJLjm0hgRrFnNEkz9Yg/A/ggUFZoamdg==
X-Received: by 2002:a05:620a:27c7:b0:930:a635:a782 with SMTP id af79cd13be357-9391380cd2dmr3621041185a.11.1788198092300;
        Mon, 31 Aug 2026 10:41:32 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce444e76asm89697106d6.2.2026.08.31.10.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:41:31 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:41:29 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, paul@paul-moore.com, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] lsm: Add the LSM policy object lifetime hooks
Message-ID: <apW7yi06EutRfCBO@zenbox>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
 <20260831145858.3869191-2-utilityemal77@gmail.com>
 <fb9ee5e1-dfc1-460a-85db-1f31f2f6ed17@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9ee5e1-dfc1-460a-85db-1f31f2f6ed17@schaufler-ca.com>

On Mon, Aug 31, 2026 at 10:17:43AM -0700, Casey Schaufler wrote:
> On 8/31/2026 7:58 AM, Justin Suess wrote:
> > Add struct lsm_policy_object, the identity an LSM embeds in a policy
> > object it shares with BPF programs, and the three hooks managing such
> > an object's lifetime:
> 
> I am not seeing the cover letter for this patch set. Are you sending
> it to the LSM list? Without that I do not have sufficient context to
> comment on the patches (1,2,3 and 8) that you have sent.
> 
> What I do see has me quite concerned. It's possible the cover letter
> will addresses my issues. If nothing else, I assume it describes what
> a "policy object" is, and what it's for.
>
Indeed it did get sent to linux-security-module, it's up on lore as
such.

https://lore.kernel.org/linux-security-module/20260831145858.3869191-1-utilityemal77@gmail.com/

Possibly got caught in your spam filter?

Indeed it does provide important context about lsm_policy_object.

Thanks,
Justin

