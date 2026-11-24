Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549563;
	b=kZpZNXakPQuJKbs/oeg3fz61ez5GjBRZGCpvvzZRtgqPr3H7OQTrpHDpFTHLqDtucLuD
	 6ddvYNgbbCqHScwqQ9kojhdfVLffol0AKXev56IkXAmIzKZQ0T7yx9Rkock095qsul3d7
	 TfC+BYhD7WT3DqqiGy2CvL2rKoLtsIKCAiIAg3Rc37qoiNAsjrnZAeP4Na6hOG9UHX2gq
	 fzeuX0awQfa3k+n9FnD6MktflpteHfzd38VMMmcperMnqIDaSAgURcSE9ORvFSCCfizmR
	 EZ6BRBphTtxqH4Uy1vMQKMTdIjVebntAIUAZtuVCYMRS1NCukgs79uwkcb+G8ztZQPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=IhHpDAgfyfKkfFHlLgvSfcAvCTliXqLpV8yYbO4GRDc=;
	b=FLahpMLY589aEDmeeOjspfOpRF2SiAm5gCD1IVE7iSjUpWuNXOuvASNBwxvVTdvCom9m
	 /8ITPfxCysRQwaX4v+7MGj8g3bIHyOUjQcxaAv+v4riHuifLil0BjOJauW1J7qi8wb7vm
	 RAWpAIkXlOR53RIcltM//LfnfKJxNatsfen4brAULInv9mXEX0FCe8BbQk0HFI/XHg/C3
	 HYpnTXOlfVh770Y8SrHiZhNIZPMMV0qEsV+sNbLrJvSQJIeGawp2f/hFj2phF/eSNGdY5
	 /zRHfqU8YdmJQkehFCDDn3ODj/UQGVazQqpgcJ9imdeYLVJdprPL2OUqEez4Md8/1JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zaskLmf5;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189E606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0189E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zaskLmf5
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8c4cc85a315so3441571b3a.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 11:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795549562; x=1796154362; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhHpDAgfyfKkfFHlLgvSfcAvCTliXqLpV8yYbO4GRDc=;
        b=zaskLmf5jPP4fDhg+qSfGe3mIT2L93UYfNLj6OZ3n98KPgCabKsLoWPsLIdLXjWslU
         Tsh7A5FvsuDxMzrjBUJpot9uv0bQJdHkz24OB8VpUaRF6aIW+TmDxENXIMtpb3+gpoMv
         1f+Sh73ex4YMQz7fp7z3nRjtg+oQCEJSKCr/JyzfgC+NLb8+mQBvMoGuQ5gpqbXSot82
         UEvQrAQKMlcpFqj1lBXayWETLKFNvtUHiYXWCvFVwWzp1IDJRkr4ocKcYfHf0mgx9tNP
         mW5I8YfdrU8gzkmOmv3cqOV/UkvE/aQAMX5Ke1dbQatGNwO4U40JvTyRZh7MjqXRey/p
         9AGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549562; x=1796154362;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhHpDAgfyfKkfFHlLgvSfcAvCTliXqLpV8yYbO4GRDc=;
        b=mYlkJVpbXSr8comxPfc0zmIuSiccJjko4N8d5Tzg5l88rcu0Y9GRYFRuIL+LUvEgpv
         ol/nxnVhgg7WI5l00rCIh2mqe6wDBT+RgJBHirMXR9S6QP5hSwhMQvBP0tuVcMDWeVAA
         6LYefRII5FXe9QWK7SqSY15kplV804jiGIMarrn0a59Tp0JXIVnnkuLBzI2SGblkBInW
         BpQJurSVpAz6z6nAVJNIFUM7nluNcV0iueiPlieaVP708ogQbzECPcmSJkb6drBxL5na
         zj2I3HuKGd5kmEISLzeFmlO5olKbRQXkRf6S8TbwufZsSkwE6TcA5Vp8VgHVzll7rfOL
         SyWg==
X-Forwarded-Encrypted: i=1; AL+hErEYCFHScnQaNIM75o5Cb4NBuRJS+Mb9Atl8nSv9TOhOn0QGUv0cDQf1KQR1ZehmI7Mh74Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z91IETgOKFRHDaUau4TuQVb93Lw7bZiRZRQwZrchHh42uje683I
	dfVgpSxOQhNEw89FrBDmcroW8kv5vG9dD2zQLvNYwgFDBWLSe0q/sbW6
X-Gm-Gg: AZFdTZdWxC91gCWJrm6a71ZyypKZaPiVQZyyUKSW2C0jA+VVyiAE4xkpyv00QWQjwkx
	GaOzHLQzSG6DDI370LniKiIEu51Q9s+OEySCScDudkiQu7RMc4Bif+CxLoPwYp8eUlqOkrwyiBT
	zohu50DVx0NdVP7lVO/8iHDWMCHkuObFnEqmQJw5qfykj1K9pnd5Oce/ioROwDT9bAi4P2py0/n
	3Q1CpKdDsg0kCinRyOyRpW/MslnjJgUozBhSgZlDmxgmh8V0fIXP38oj+ljxssfQ13orrhmn6d4
	JAaPeFrQn94Ot+zaIuL4Il5GnRiQy+rm84olrwPW9tzsZ745Gz3RiTKXg89JnHQvdaGV+lCkBOv
	fFKBHNo/BcktuZfoEj2tcZw6gqQSSMJi6qvQbDCiV/Z/xuqo9+yt/o4xXzhS8yFuggZJhTMRt0u
	YM2+kmC3Whz9U0LR1kwbZH4utYiOaTS9EqS6QcKR0/9+n7gcZWygeIJ5PmGg1TxiqwGEAy7JHhf
	o6gNezGVxXRwMUBLrlmCMmnTQrJzFJfigifms8P8SWxVo9n/Y99x1TDln3rDo8fis2YEKloW/x/
	RSWPvdWRuEgJavb8yOx5V5qcMcQxGfi4mWvNr7ccxPL5dbe9OXLhL/mrqQr3GmUNVBFrU68ThOW
	WadGwH6MV9tiv1sUN/eQm94rGD+glG/rvSIg=
X-Received: by 2002:a05:6372:a70f:b0:3fb:4a1e:2f7c with SMTP id adf61e73a8af0-4014e351c1fmr14548751637.57.1795549561999;
        Tue, 24 Nov 2026 11:46:01 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfebdbasm7413834a12.13.2026.11.24.11.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:46:01 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 19:46:01 +0000
Message-Id: <DN3P7509U44I.MLLYA1W3M3X9@gmail.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>
Cc: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Matt Bobrowski" <matt@bobrowski.net>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf, lsm: Make bpf_lsm_get_retval_range()
 return void
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <CAGn_itxav5uLkQXCzgkqzgff+ZsFZrhO6rofZJJSqk7K7JPGWw@mail.gmail.com>
References: <20261120-jf-bpf-lsm-retval-range-v1-1-d712e4090907@linux.dev> <DN30L7T6638S.3GDFKZBDTI1CN@gmail.com> <CAGn_itxav5uLkQXCzgkqzgff+ZsFZrhO6rofZJJSqk7K7JPGWw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 06:15 AM Anton Protopopov <a.s.protopopov@gmail.com> wrote:
> I think that this makes sense to not list helpers, kfuncs, and
> verifier (and jits), they're building blocks for BPF programs
> themselves. I've checked that most of external functions called by
> verifier (~20 files) are not in the tagged list, five are, but look
> legitimate or "harmless" (security_bpf_prog_load,
> get_callchain_buffers, copy_from_kernel_nofault,
> bpf_set_dentry_xattr_locked, bpf_remove_dentry_xattr_locked).

For the verifier, yes. But copy_from_kernel_nofault() breaks ftrace.
A prog on it returns -EFAULT, and fentry on foo() detaches on x86:

  unregister_fentry()
    update_ftrace_direct_del()    returns 0
      ftrace_replace_code()       ftrace_bug(), no text poke
        ftrace_verify_code()      -EFAULT
    bpf_tramp_image_put()         foo() still calls the freed image

Let's deny it by name.
The two *_locked() are kfuncs without bpf_kfunc tag.
See specialize_kfunc().

The verifier also calls kfunc filters via a pointer. In visit_insn():

	if (ret == 0 && bpf_is_throw_kfunc(insn))
		sub->might_throw = true;

A prog on tracing_iter_filter() makes ret -EACCES for this one call.
Then check_func_call() skips the exception path of a global subprog.
That undoes commit 3d562d35a044.
This filter is in net/core/filter.c and has no "bpf_" prefix.
So funcs that take 'bpf_*' types have to go too.

> Blacklisting these removes about 200 hooks. (Blacklisting all
> kernel/bpf/* removes around 600 hooks. I wonder, maybe this make sense
> to do this, after all?)

Yes. All of kernel/bpf/*. btf_*() cannot stay either.
By the rules in fmodret.c these get tags too:

  target                  error    after the skip
  ----------------------  -------  ---------------------------------------
  btf_kfunc_check_flag()  -ENOENT  fentry/bpf_wq_set_callback saves 3 args
                                   of 4. aux is garbage. That undoes
                                   commit 3917b1012ee2
  bpf_mprog_detach()      -ENOENT  tcx_link_release() only warns.
                                   tcx_run() runs the freed prog

security_bpf*() and the bpf syscall entry need no tag. They stay.
So a prog can still block a bad bpf command.

Could you send a patch for the above?

> (Just in case, I am preparing patch for "fmodret -> functions
> returning pointers", so numbers can be a bit different later.)

Nice. Looking forward.
