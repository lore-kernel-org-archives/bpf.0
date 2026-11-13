Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570493;
	b=iXYDrOdcGhT2Fn5u4zjiewd1lJKfGeIVun7aMjiUFrZLBxA2h4fkuFwyapxPzmA8nKJ4
	 lkILxtFq8WM+AhTxLke+BKBSLDn5eWW0nXPJByXENe5orLKXjx49dkzpWpZDdcIRvsWJO
	 G6gxpLrbddZqtd5zUyvGxAvDF2DASuVnUcnPdREv33keoEBgEoLLNksIqXxNZmerxdMQr
	 YG65gP024Udho4VF7yFj+yvuKlHgIL+VXtKHdoEkfV7RHCzHhHX6uKT+eVNqcJKb2aDR0
	 wGn045W0ZBVOM+N+UMBfu4xoHm7SCvBA4QOcI3WZzml6oF2eDOj9DPQxSSHMUOCeKWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=FF393OWUbpiID2ySHDkmn+OTtcDLw7WwaP3Q15EwAJE=;
	b=guyAC9kEnCrrmSO0LJOalLReM06ZWrAD3tJsP7MyntMo820ko+17OrD+qBpkWKP07X6z
	 UK4dSlmJIZUPGtTBSpzA8kYzXVCqHX7sp2Y9lhNr6xxwl0iBb3nF1UZTK+suJpnj4Xx3d
	 o5NM6yUuAg50eOW23MWK5ieYR/jmjRxPDnpMJha5CytQFRTSgqTkKO3OnLGAlxHHk9cFs
	 48nsTQf3i9m+D02k+1Kk8PlzY5GV3D/yTJvVCvnHgkccbGol8A14/5KOLJr9cy6mtJnUl
	 n5l/Oxz9xsn3Jj0Noy7vW/o+9eBPTj+DMIlzSZxcc77/sLzUN5tGx0JIMQmA9tbtBUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ju51keFO;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B040606A321
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 11:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B040606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ju51keFO
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so5774795e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 03:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794570491; x=1795175291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FF393OWUbpiID2ySHDkmn+OTtcDLw7WwaP3Q15EwAJE=;
        b=ju51keFOeH7ByukWRrWQShBW452PCvaCNcrSAe/WSlTsq/z2DEQGkJl6J25VlE65rO
         xZoRzECtqrrgjyjAkcWwWmAnDRYAL7Ao/1LpD84FRObhqYec0fvOohi39pSf4ybhT3bK
         11hzVgAaXaEMTWyCVcencF7uqErGcwM4/a2r/6CcVorVy2CnZpGa4gnHtQCxSHIyT29M
         1aFDj8UhFB3AkH7ijzgFobd7JrKGL/WKsGca0Ds9b/xTMXdYEdikN70IkT7rFXwmZ4ny
         VtgiFazFdCWrKafdogm/fv9nuo0y74wv9MLHA91Em/pxYIirKdGhsRl5cnts1oAV6SA+
         zgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570491; x=1795175291;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FF393OWUbpiID2ySHDkmn+OTtcDLw7WwaP3Q15EwAJE=;
        b=GFk6qUzNmKsvVlQmSVrDaSZgfDJ7qPZfMaW6E48aXVmz+3eH7lSwwoMT7V0WUIkU+s
         Pjl3A7l4U3BlTntXEBdWG6SDOgzMoN4zM6GxYh9U3vBHCmMZMmDX/hHDvnwHhMwJndUN
         m0/nFSgs1dvai3YXZ8SymMIgJSzowefAkdMWaRkHtKzg+Ss8GG/OyYb9/sbHRHUnpayF
         PveE7Sr8WfdOJgvXfubR0xjjG/5TqQ4MIBlt4BeCc1AdjHG7/S9hn+ypocf3mvJO3FTm
         uSj6oApeWbM/vMIcex9OttPCFtB5bZBVULMmu3NrFNfbgb+G1t5qAQxGvtsMsxkZKIJm
         y+JA==
X-Gm-Message-State: APuU4Z/EAG75i/q7ZvCRCRFfis8+LjnZn0Pk5K+O1BnSlKGqTFdbtAJ6
	A2tkgPRY+AgAS24LyhxSXsGHRS9vscsmzO2FncVo9+tFgMuh9Kvsrdod
X-Gm-Gg: AYBFou12ywKyb6w4mc6gJxVI5muRHOXFGhKLwQ0pVPJ+OoPuXk9j952bhTRsktREECX
	iE+VvOSgkKtVl/sQzQOWFTTiFKW9OkR1vYSDWfy6PwmFpJtNIpwdDhymuKg6u+nFej0GAjPLpk9
	noE+njXhux0pjxCxJfHa8PByhYdaPq3LovOJqSWDob4khHrPmdkIikAaFqEvLAimF+EicvDOAqv
	qNNf8pFIoaKH6vDcLIB3rznrvOmkDKjGr7is0PgiilxBGuj+Re2scEz7zaHVeegO5dvdtcuxNq+
	ZJliR3tGUS2nfxMTcLyQAqB4+UVugYsRPllRPe1BE+HuXTVa4pTJfs1+mDiMSoRbd4Yq4hzmBB6
	tQSVpev6/hB71Lh0U7EojEdtUpwDBCfNXtLqptD2vJgYhRT2jrp6Sgg/dRFqP3Hf26YYftkjMqT
	ltOgjXCtST0wxWNe5/0+1tp0qHXfmE+5Lj5lkiJsy4hNom0WgtwcsiObRnkylI//yldXDpEFZ+O
	OXo5y8J48UMta68y+veBglgRP1UiOGlJfAAAKFeZbA/Rz6CN56H3gzOzfhcCyPPfTu2VBKI5LjG
	MH+YfP0ZPpr74tkadFkerSorFtK3ceSjzktaFQ==
X-Received: by 2002:a05:600c:3e17:b0:4bb:53e4:a7c8 with SMTP id 5b1f17b1804b1-4bb55aa27cfmr45389995e9.22.1794570490877;
        Fri, 13 Nov 2026 03:48:10 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5fb58fefsm5405863f8f.26.2026.11.13.03.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:48:08 -0800 (PST)
Date: Fri, 13 Nov 2026 11:59:45 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [PATCH v2 bpf-next 06/13] resolve_btfids: Fold the constants of
 a select without a branch
Message-ID: <avb7sY_yAZuvTnxZ@mail.gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
 <20261113050901.1399091-7-alexei.starovoitov@gmail.com>
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
In-Reply-To: <20261113050901.1399091-7-alexei.starovoitov@gmail.com>

On 26/11/13 05:08AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> 	return copy_to_user(to, from, n) ? -EFAULT : 0;
> 
> GCC for x86-64 never loads -14 into a register here:
> 
> 	neg    %rax
> 	sbb    %eax,%eax                0 or -1
> 	and    $0xfffffff2,%eax         0 or -14
> 	ret
> 
> So the function gets no tag. Other forms of the same select:
> 
> 	one of two errors               sbb; and; sub
> 	the condition is negated        sbb; not; and
> 
> The table of x86-64 describes "sbb %eax,%eax" as a definition with two
> constants, 0 and -1. Describe "dst = src op imm" in text_insn.h as
> TEXT_ALU_IMM. text_flow_fold() runs before the analysis. It computes the
> instruction if src still holds the constants of an earlier instruction,
> and the code falls through from there. The result is again a definition
> with two constants.
> 
> Five patterns of x86-64 use it: "and" and "sub" of a short immediate, in
> 32 and in 64 bits, and "not".
> 
> 	functions tagged     before      after
> 	x86-64 GCC            12633       12817
> 	x86-64 clang          13541       13549
> 	arm64 clang           12435       12435
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>

> [...]
