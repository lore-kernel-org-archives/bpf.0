Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2253247FAE1
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469071; cv=none; b=EvJR9aVUewzZGAoR/iNhSeZc6fCa6mBWrZVVLDUJiDPd5l2Jc9BNPlw9nObs2jVnME+CUiIRt5ODSQKYqjyN7byS5LEBQ60jUVnV8iqYjBfk892rVMaLutWkOJtXj4PblyND+MNdPUBCCpfpq437/BR8yj+E7xkw7mHeCiilQqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469071; c=relaxed/simple;
	bh=PXYk2CjpqaFOtZ3enTd1crlPq1RImHYVTbmQaBuSLpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6Qvc60fLBpLc1b/ZtVJHNUd0SDBnVl1RIJYjycGx/gFcckI3z0pBA/hpYBgaJGETjGuwpBz7+mhczZRWx/zUX2HOwfc/2h/4TafpXRKpJA0nMH7ePa/O1TzxJRF1RfN+2FtmvnGuv80+CuXwKSB9YjqqBEd97SXbH1muVtVY1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bu4/8Lav; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bu4/8Lav"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso35608165e9.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 03:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789469068; x=1790073868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vtBXE5s98f3H1Kuxmko8mfPZgOKWxXan0nIHL+Fl4H8=;
        b=bu4/8LavM6NpZrlw8ApfBgMbZKNDlHPOV5/DPJhv7JNcE5zkq+5BtRp69AuvUbr+77
         DhayjJeXZ/Sv6PIOCqgwbbPw2vS3BAvpuyjCDYQJH/WVJzmRBY3AA7x9/g7/zIEQ1yml
         dn58tG3C59OW6jY8YLkdrIPWAGsiT2b3uuyaQtTEyidDGHvew8+W+T+v5FZMyIXx5VoE
         Qr63rxWuLHJkkVHFAaCEvuAt8aGdTxnCdJMdy7/sSXH2w4fYpMSG5P0P9g63wJAt1Cqx
         d8BFS9A12Me/0PRpZA5h61CG9mJOP6RnLX22t82m6Im+FOcmJQA7eTmWHQIzeIZ167Vl
         QjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789469068; x=1790073868;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vtBXE5s98f3H1Kuxmko8mfPZgOKWxXan0nIHL+Fl4H8=;
        b=vHr46rjSol+qs58tEAu+6jp2k2MRzRbKu7WQrEBAkNOPNvnfszaVzXix4+cCm96SOx
         tqHe6E7IoRlMmdir3Pvny5y1fHb0aomWlq+NSkp2ZU2ViZyBj1kvaudx5QURqBwxWhUR
         Xo+YaNOmqYkHS/ufc7V/jiaJhGpk9ukzkeljP1MJ1yuqOaDifvI+eSMrtSaEPKVmjuzB
         LDwog1y1zrtbKj+cJW5AOrywzYIFOpzZ2LPdRtOq9UygiOmgVVDJ/dR7/G3Xtg1mkL9e
         XyIIrRIvahDXO9j7SP4u8wccL8HaEhf2mBfCTiIzWtOFPQGW9NnlSOyhcaPFmfvU1EzF
         XPxQ==
X-Gm-Message-State: AFuF++nV8+ntt/BvvPCF5FNs5iQ5NedntWKq8UESd8CdtYTRLiShEAOo
	l3f2WDXyOB2MZJFkNIMuoezJOI74n+DiBLX4NUY328DGLRxBg/OoZiz/
X-Gm-Gg: AYBFou17idfoxVDMl6VXaE471M2mvEc6R4zALBjib6yQKpMNlIEP5cOmpjOq+lk/Ixt
	gDoDtC+/Bch07AQS/zkPbvjBt8TGeMy/BnJDcnOnPm3DZuYfB0+3hGDLCgagp8lrng3Sifllir+
	/DmvYKAe/Qy4wpUleOx1O8wz1n4gpqacruCDEqrvfKKiTZHttmWqgVGCma1vvNZW7IWrDKF5nOG
	LYJYkwDWYpSQjZw63G7Ob2164xAZLrUCLpggiLTYsZkFdNjYbd77KYbyrs9PDAvmRLLMo8uKvbE
	TakZQ1znASFKvWf4lYMHrQsz3W4X213YYLg0tUGmGtQhT7cNEVfx/Vsh3Hd1ghhKXo0U8ZHoPy/
	/jydZRNME0rclwvSTe+bcki44SRsebCzYF0HqAP+XzwG2jOPckjUxX3QFhMVV2UzPPsn55m4eh/
	saxUESiDXoW0gUMaYlBCfeqodBLvfSLCML7RS8NNdv49CLDzVvRQaL0Bfm6tl9ipUHPiqi4w8z+
	GHNiBvblHaQnJWggfBAK2Dv7wZ5p7Vo3AKIe5KPyw==
X-Received: by 2002:a05:600c:6217:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49e7a656c01mr158995415e9.7.1789469068146;
        Tue, 15 Sep 2026 03:44:28 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34f1f7sm32985244f8f.24.2026.09.15.03.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:44:27 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:44:25 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 19/23] bpf: Consolidate function call
 pkt_access validation
Message-ID: <aqkhifLvyAhw66jg@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
 <20260911220415.1396439-20-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911220415.1396439-20-ameryhung@gmail.com>

On Fri, Sep 11, 2026 at 03:04:11PM -0700, Amery Hung wrote:
> check_func_arg() checks whether a helper permits packet pointers before
> dispatching argument-specific memory validation. check_kfunc_args() has
> no equivalent check, even though kfunc memory arguments may be backed by
> packet data.
> 
> Move packet-access validation to check_helper_mem_access(), where the
> access direction is known and helper, kfunc, and global-subprogram memory
> arguments converge. Pass call metadata there so helpers continue to
> require bpf_func_proto::pkt_access, while writes through kfunc and global
> subprogram arguments use the program-type policy and set
> env->seen_direct_write.
> 
> Keep call metadata when variable-size memory disables raw mode by
> clearing arg_raw_mem.regno instead, and pass it through the map-key path
> as well.
> 
> This also makes kfunc and global-subprogram packet writes request the
> required writable-packet prologue and rejects them for program types
> that only support direct packet reads.

Hello, sorry I don't have the full context on this patch series but it
looks like this commit broke one of our programs on bpf-next, we have a
global function with the following signature in a cgroup_skb program:

	__attribute__((noinline)) int
	parse_something(struct __sk_buff *skb, __u16 off, char *data_start, ...)

that we call with data_start being skb->data + some_offset and now it
fails passing the verifier with:

	; ret = parse_something(skb, offset_start, data, ...); @ parser.h:131
	199: (bf) r2 = r8                     ; R2=scalar(id=5) R8=scalar(id=5)
	200: (57) r2 &= 65535                 ; R2=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))
	201: (79) r1 = *(u64 *)(r10 -40)      ; R1=ctx() R10=fp0 fp-40=ctx()
	202: (bf) r3 = r7                     ; R3=pkt(r=1247,imm=1244) R7=pkt(r=1247,imm=1244)
	203: (b7) r4 = 0                      ; R4=0
	204: (85) call pc+776
	function access to the packet is not allowed
	Caller passes invalid args into func#3 ('parse_something')

And this is read-only access given it's cgroup_skb prog.

We can work around this by just passing the integer offset and re-doing
the whole skb->data + offset dance in the global function (we've been
already doing it in some other spots for function by function
verification) but I was wondering if this actually a regression or
expected, thanks.

> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 24 +++++++++----------
>  .../bpf/progs/verifier_helper_packet_access.c |  4 ++--
>  2 files changed, 13 insertions(+), 15 deletions(-)

[...]

