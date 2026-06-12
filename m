Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF2C37C0FF
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259533; cv=none; b=D0Bpdczs0mhaXY5hbM6wJFxHCatnQuGEpD2NE7DMHNdn4hIjO8v9JkzDe0odKhlti0FRZYZIthXIjLJQahITIJgiaFFOgaREQPulzvMB6vsJ1sFT/SpDC9muWSxpa9tcj2x9bBCxNWkVKPimstzB1tB8F+R/5D5GsiCF6XhJiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259533; c=relaxed/simple;
	bh=Iu+WsPA3d5zC/vpm66sf0PXFm63IcdCvAGgoL0vzIyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiwB5xuKSX5v9NXOPRz3ezuQBmVOv81h/gP2K1heFdXIm3Pf7trS3RM65IvugnaYCAEYx1q2raPjnlQTvdAJl6GB5jXPdpMT+hFrbCWlBEj+FnfzzUeshTrl6Z6p1H9o+e0xz3ZBs80Z89CWBsl/osrtrsPS6k3CVk2PdJ1QCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bBME3aOj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bBME3aOj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso9556135e9.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781259530; x=1781864330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZYS51t2QXr2ZWiJCJ2esfR2JgSuWZes3mVwU5icUks=;
        b=bBME3aOjy09Ne3TOuJciwQgMQrD3QA56oZBnha0V1aiAml8vZFjlLytwRDLcbAjTfK
         gs0paoiXwr+SoduVvkIUms0MRhDY4psKxnYztyMXaCgHdKmYEU1TrRrQrbGmf78LFKLy
         Nb7MwXBQq6cZ5ahJc1jkRoGezwCEYiQdNVic+lM3Sq67OQ6+JDEzb5aqGGVaMTwwdG8l
         Y1dVVIssm8yet7XPKGHJgxwSWw7e8nfefziTDbuAI1WXNifv4/FxN7bnwKl7QZznlsK+
         /L52yU+EIT8vhOhbInFxE4932yW9o6b9QOztuVi07hqQf1r1TUk1zeLIEwTU7TKGdYaS
         IVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781259530; x=1781864330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZYS51t2QXr2ZWiJCJ2esfR2JgSuWZes3mVwU5icUks=;
        b=b2RWtNzrLotMn5UdSDPZU72VqwtQuK3jVQmK93UxrVMgJZyGoFzVEddJCBCPLznNCJ
         ERCQ63DL4Rbpcrl46Nug/RYn99JwUQzS/KRqVtkxNodet3XohOcCTDalhBJ6teSQdn7Y
         xoD/Kvkh4Rm/FXcZ00kKuUjee+MIc1iwI9kJnx1QdtcbmlBTjxXFPfgfEaD8btopwGE7
         iRt5cjWyi63OmQF3nRR72fUz7U0Txwi9jXZexjlvKsJ1L1eCwAAiwn4J1sfoJYQkpDg3
         sRMCuSgdScUhxggEMYQOh+1hUh2ZmcQoUE7057cIwKRVh5V7Eu+EFt/s0UiLbO8RMeO/
         8qEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DhJhUbbQgaTuvizf86aNAwsjUZ+xibCXspXgR0dVE4+cC1QVTsbfz4CgeLnw1XIDjGVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySkKN+p1mmPX8tKZkmtui8MPdoR2ExsTo9CImlzyXP8UpnagUX
	DEXG6kcLt0ttFTi3sRWJuogpl9eLR0jd8GsZW9qRcvr7x38InZ/lq82m3E/kpHrsnPk=
X-Gm-Gg: Acq92OECJJt434KjrFHv9R7qyguzCvqN2JrDR8kny7cm9ia1y4tlwzygH1owSkl88cb
	4xOxgQp7XfTEhEVoRABExfCcpCPRCQGjvH9zWbCMyyn8syMKOsl5wBoynTLg5AnTJ2qKYGyfyZS
	WR3de5s2ohTJHhVWbkOfGmQxPFyxTwCqJkaFxVmDXpa/zsidrfxrSlUWZ3Aa/KaXHI2rWNv01l8
	91hCVtIbiDACpAsJo6sNwMN52Q3wcNwiAlZJoiGLh0JMnZH81TQxxbJRUTkidPLuocEMsTvZmH7
	Oa+K9EHttoTZOkJTcAt046InnYv7n+R1IL+JjC+8YY7tO5y/+XnobZY8nwApsOL8tujqqXN1TNC
	Ag7xf1YBx7aGy9AbCXlL+6RF9dleHoH2YUdS+k7/jEwg18Esi5rmcCk+4xIujxWcobYaAzskDV3
	KZYyxj4mFkwx03oS8dFqQFsuX+ygU/adYbtZ938CRa
X-Received: by 2002:a05:600c:5493:b0:490:3c15:7146 with SMTP id 5b1f17b1804b1-490ec4f26ecmr26968165e9.19.1781259530302;
        Fri, 12 Jun 2026 03:18:50 -0700 (PDT)
Received: from u94a (27-51-56-85.adsl.fetnet.net. [27.51.56.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95342sm2857806eec.29.2026.06.12.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:18:48 -0700 (PDT)
Date: Fri, 12 Jun 2026 18:18:39 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Zhenzhong Wu <jt26wzz@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, eddyz87@gmail.com, 
	stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
Message-ID: <aivZ9jYGw6QRxLQQ@u94a>
References: <20260611160749.391279-1-jt26wzz@gmail.com>
 <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com>

On Thu, Jun 11, 2026 at 09:55:55AM -0700, Alexei Starovoitov wrote:
> On Thu Jun 11, 2026 at 9:07 AM PDT, Zhenzhong Wu wrote:
> > Add a verifier runtime test for a branch pattern where a helper return
> > value and a related scalar stay live across the same control-flow
> > sequence. Rust/Aya-generated eBPF can naturally produce this shape when
> > a match on a helper status keeps data derived before the helper call
> > live across the same branches. Such code commonly uses the helper return
> > value in r0, where 0 means success, producing an r0 == 0 / r0 != 0
> > branch shape.
[...]
> > +SEC("tc")
> > +__description("helper retval linked scalar pruning")
> > +__success __retval(0)
> > +__naked void helper_retval_linked_scalar_pruning(void)
> > +{
> > +	asm volatile (
> > +	"r7 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
> > +	"r5 = *(u32 *)(r1 + %[__sk_buff_data]);"
> > +	"r7 -= r5;"
> > +	"r2 = 0;"
> > +	"r3 = r10;"
> > +	"r3 += -8;"
> > +	"r4 = 1;"
> > +	"call %[bpf_skb_load_bytes];"
> > +	"r0 += 1;"
> > +	"r6 = 1;"
> > +	/* success path keeps r7 independent; failure path links r7 to r0. */
> > +	"if r0 == 1 goto l0_%=;"
> 
> this exercises linked registers with BPF_ADD_CONST logic.
> We already have such tests. Why do we need this one?
> How is it different?

BPF_ADD_CONST wasn't what was meant to be tested.

The main logic is r7.id == r0.id only happens on "if r0 == 1 goto l0_%="
fall through, and does not have such link otherwise. I only check tests
added in commit c0087d59e504 ("selftests/bpf: tests for per-insn
sync_linked_regs() precision tracking"), but it doesn't seem like such
conditional linking was tested. 

The other rational is that this seem like a common pattern that is
genereated from Rust-based BPF program.

> > +	/* success path keeps r7 independent; failure path links r7 to r0. */
> > +	"if r0 == 1 goto l0_%=;"
> > +	"r7 = r0;"
         ^^^^^^^ conditional scalar linking

> > +"l0_%=: if r0 != 1 goto l1_%=;"
> > +	"r7 <<= 32;"
> > +	"r7 >>= 32;"
> > +	"if r7 != %[test_data_len] goto l1_%=;"
> > +	"r0 = 0;"
> > +	"exit;"
> > +"l1_%=: r0 = r6;"
> > +	"exit;"
> > +	:
> > +	: __imm(bpf_skb_load_bytes),
> > +	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
> > +	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
> > +	  __imm_const(test_data_len, TEST_DATA_LEN)
> > +	: __clobber_all);
> > +}
[...]
