Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365660;
	b=5gnn31/n7D/zhm3DAPqxBToDEQumTvp5yhCzOyB6bD5/wdqgTYFnYZe3Wp6Md/A0Devd
	 nVUHrQjIUh5SP3WBSUOx7QR3Rmqvebl7ouNja3Akv1QuvfOFWeU/pTwBW9CC+VJFKAizp
	 KgbVw6JUn2qDf4blGSYcG9nMLagyWC1+jk0ph39k63crQ/RaD+6VkhdvyjyWf0EQGA8sS
	 pNIIdtXT/zuuS43CBDddc/fRGelNGc2Byrbg/APG0g1A7ngXMpMgPE7JBk4mxUhWJQjfv
	 7j9iadvJtOY9b/QdzPB3APsvQHl1k5kDmCigMA4OyJomtd+1QsafSdlVKYRREIY19Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2CXkmd/O2aNTlZ+qEZ1HRRpRXyJoN5I797iFBoYREzI=;
	b=GDG0aW7MCcn8UVcG9VY7Nv45mKi5v662i71LvH9E3zLpsb3s4GSANEXGicXde2WNfYlB
	 DL8N6jF7+tPMFuMseoBSmiHg88+kxqTuOh6r90qiMTsVS0y93YM7G2AOnf6RlKhBJkwTg
	 HISbKVRvBpkmdue1KzIiHNNWf8O/AY+zeo4uc2JitB/h/Z3wreg7SaQB7eff/dab5s7pX
	 Todg+MZt+Y+csWTSzsM7pRDKKOFCToi3/YG/G1g1ydQWpAzCKL5UWyUBvjSGlTPqPb9L0
	 AdIZfzTbRiE1uhXO1lPe32vaFXK4+QWpS8a8vcDYPQ5/sLI1BwA2qbVfPUc/RlE7X2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U2uW+tmH;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359AD606A31F
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 13:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 359AD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U2uW+tmH
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e0d1da913so516710f8f.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793365658; x=1793970458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2CXkmd/O2aNTlZ+qEZ1HRRpRXyJoN5I797iFBoYREzI=;
        b=U2uW+tmH+jZ4SficOARdAU3HBbBTI5RN2cg+Wb894aXlhp0IzQaummM8vVPYTZCF3/
         hKZeWq3KXtoUFqmoONsEmvdlODqFzRTKPXgvEHHYLEWXfMgl/gsY6AGDD9uNmZizR7Xl
         6XFGyAhcZ9CO9ONKLz7490//d++2dGUoIwGqR5WwQA+2FNr+v0ufv4QPsFUdA4at4R0h
         w67ny6817oHVwyLo2c30y1f5Iq8n5ON8+JvQMhTtIfcH8NiT+hoipkXqR6GzqptZ5cZs
         57rkJ3HmfaKY1t5acz7WtzJip6Jvv9XDrJVPvvdKvbJtWYTN/1G4hShAEM547w9Zcg4T
         BPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793365658; x=1793970458;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2CXkmd/O2aNTlZ+qEZ1HRRpRXyJoN5I797iFBoYREzI=;
        b=cqCG3lj74/I9Wj/laoICv3/0lKJ7IAwNHoIC31URdyHUyZ82KoZmP/Mb1Nf8SoSaG/
         WU06Fdy3d1B+26Yjd+SMXyC2Th96oiWK+X13k6ZMFlAyTBFvP3oK30c+Nqk5VhAmF4TR
         HztMzZIiWaiO0VPPcOCf2+Is6IoNNQrUtPkYpwgBgipfVsIdjVL8hB/HmXt95+EJ/owV
         Hutdzq4JIXzWH//qm9GJqid6N2nepFsceGfK+2Q4Q1g56h1rn2fAZXa8i3aQnG8pFkyz
         m+wObWOBa67ZPsV1z2KmVZOuUzSCuJrrQnL15mQog7MpcBAsyRXOZCYuD4dcRleICuBY
         ZfDg==
X-Forwarded-Encrypted: i=1; AKwUvBxwsAv/Yh29I/ObXLTaM8zMyqPZraWM61Keh2auWDAsLbxNla1ZuP5J6YkjiS65Prz9mis=@vger.kernel.org
X-Gm-Message-State: AFq9FYIB0x5y7/S/HaK7AYw5D40EAPL8TtNGVhXIQYIYVCvXII2Z3Kb5
	DupRBisCBOygQxSLnRxTWNiCfhtXRzSLyT+DrCi8QGTUHDXRvjeP15vP
X-Gm-Gg: AYBFou3R+NL9j4goX8Dg3T619OtskBLzSU1ISg1HtbNv/Saaa61ScWL4NWYsnAWuEoC
	oocIs+3Zrl41+yxWflaOqTFx/46SLoEyUIdC5OP9nBbhr3PepizE2yBn5RfrSdGQOWSJ2wBBVYV
	DiWAEQjLSpTGJ5/yikSIjeHV9DpOf+0tknV2fT2/x6lZGxvMXkLFGmNEOT/MKW+CwDNL/lsj1KJ
	9zQqArMw7jdTBNeoz3adCdYOLJbjGubiFQ6L4+/R82tWriFGjXf08xwzQb+yzkFLCYqX2Qd9L2u
	XFup5O5woMcmVmWNIz4Xblrx4uC7OnsD6KX1Lt77f9zTNU8I2zfhzwYqiOsle2r0FjibggVDaIf
	Th0bPP2GiGpSY7ynUtbIta+MQQt4O0Cg4Sq/BT4lxtZ301pE8YRdyWchzwN6iP6F3AY3Cxi29By
	oqmi1m/RqMmYr5oJS+UDDh5dWcucR2awdDYivwJ12CtcHQ8BeA3z8pWZNEnHO3Jsy+9zQ0U80EZ
	6iWvXd8zNpiRPnjPuQ60gWmx0JuqevWzC9wfOAmxiqEWxAIsAHrZDV2vIywzcl24M4tYqIVtzyt
	0A==
X-Received: by 2002:a05:6000:4910:b0:48c:69b3:6114 with SMTP id ffacd0b85a97d-48e6494c24fmr14608261f8f.3.1793365658172;
        Fri, 30 Oct 2026 06:07:38 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b789c6sm3482083f8f.26.2026.10.30.06.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:07:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 30 Oct 2026 14:07:35 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
	linux-mm@kvack.org, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, ljs@kernel.org, john.fastabend@gmail.com,
	nierro92@gmail.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 2/8] bpf: Add user memory kfuncs
Message-ID: <auSWl0wLpYO8RjHz@krava>
References: <20261029212551.56964-3-jolsa@kernel.org>
 <571f32a410a85199bc9bcecfe07a9a9b6ef425b2052643e64031dd246c13691e@mail.kernel.org>
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
In-Reply-To: <571f32a410a85199bc9bcecfe07a9a9b6ef425b2052643e64031dd246c13691e@mail.kernel.org>

On Thu, Oct 29, 2026 at 10:12:12PM +0000, bot+bpf-ci@kernel.org wrote:

SNIP

> arch_validate_prot() in arch/powerpc/include/asm/mman.h rejects:
> 
> - any bit outside PROT_READ|PROT_WRITE|PROT_EXEC|PROT_SEM|PROT_SAO
> - PROT_SAO when !cpu_has_feature(CPU_FTR_SAO), for example on Power10
> - PROT_SAO in a guest without CONFIG_PPC_PROT_SAO_LPAR
> 
> vm_mmap() -> vm_mmap_pgoff() -> do_mmap() never calls arch_validate_prot().
> Instead do_mmap() -> calc_vm_prot_bits() -> arch_calc_vm_prot_bits() sets
> VM_SAO for PROT_SAO without any check, and vm_get_page_prot() then adds
> _PAGE_SAO to the page table entries.
> 
> So a program can create strong-access-ordering mappings that the architecture
> code deliberately refuses.  The Kconfig help for PPC_PROT_SAO_LPAR warns that
> using them may cause issues when migrating a guest from a host that supports
> strong access ordering to one that does not.
> 
> Would it make sense to validate prot with arch_validate_prot(), or to
> restrict it to PROT_READ|PROT_WRITE|PROT_EXEC?

arch_validate_prot seems ok to me

jirka
