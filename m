Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637852;
	b=sVL/Y/DDTeZyXRqrvtjeDNp+bLb/DqOeLSuq12zAcG2qyiqu/+o3pAQSingJH3nDDmjI
	 Ws9vBllHGweSPHwek+jISbgDBpdCAR29pOietdzBEkh6b+UpPcfkJYfviXQyJwUQwZVA/
	 3V0sFNmzGNaNPqrTdy05DvxxpRM4PdZmyFkJrYtVLe+/EK+m2HWuLfXT3aflxOIy6UEpC
	 oxIGOKzoq8Lj4GJk6S0x9bLUrOZ16hG0Ti/z7Y9bYJ60KMnCNC56543qKhSgfc8pbCYtV
	 T7GI9oPOlvLIfoyzHTVsiGHlVLbAjR0UjyFaICaph0HM6SEMgQqcMKCa111JO8L2S6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer;
	bh=jbCDllRU5wYbKPFOhnGrl1xB/avA24qTnso9VdtaQCs=;
	b=iYS8TEUUcg2q6g+Km4jKePKZsRRgPG9YIlrJib3GP9gowvTcVx7EW8S8Mt/ALhZzP15L
	 AaRv4q/Ie+DJsyr/PYUbWnO4T+ljglHOQI6EDyHhUSjtD5eHWo2yxEbN4/4iauEPOZy99
	 rwU2DUzdqsXRcS9cc26ynx6TfmX+OMfpBokS9RdZyWWAyggePl/ElbuqNJ9bJrWv467o8
	 poO8Pv5kNxc/g8Nkh+1sAsdlR1HB6JxzivyROhMaFO9j3N5a3pfB5yXewD1T60J+wqR0Z
	 IUoyiQWKxW4MLCcR1CLFMStLC4ORwR7ICLGa1XhS9VCbD9//CLrw3j4ZAA6HOQ61MaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="koa/V6Uj";
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA8606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 02:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67EA8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=koa/V6Uj
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e503815adso129495285a.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 19:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792637850; x=1793242650; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jbCDllRU5wYbKPFOhnGrl1xB/avA24qTnso9VdtaQCs=;
        b=koa/V6UjBswa4FuSyaK1aj7mCWWDpckd3P8cm34TWWyRP4wzh2NLGZFSH6Q4M4DXu3
         qzvnXX9HeaVR6rcKzXOZbL4uzEnVmqZL+MMzzyWUGBG2X6ItbpmKYvjiIE7ZPOD6pDdX
         PykgPTns0Qtfo8nduMQ1sHSyApXHEviCMbeUO00ZvHROPMI86Ykmx6SQl+abfVMyiKWf
         CvkbnJxDfiv3XJxFjZ82pcIdZyeNVZqTP/ETC6T9H+76M973HmqPv2qbgfT+YBQjViJJ
         TAOrklU+ENqV10WidZ/pbmFlwYkvtftj2K/YJxpRPZem9Bu3acDn5HeG7eCd8A/aUPfS
         BT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637850; x=1793242650;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbCDllRU5wYbKPFOhnGrl1xB/avA24qTnso9VdtaQCs=;
        b=0jkRbBOL+G424xMWC4oAP+/tY3ILSFn8CKV2WEuMMBl/FABF3DAAV9pXB+7aNAfJnE
         0iy+ww54emRkenZxZG8cGnuq0RXUYFNPHmF2s0S0sBo6qbz9CCvyME6yf/OHSW/84p6d
         jzTLE/eZQS4hIh/UGqCNFhD5RCZvBWZAIL2Li5Gn1ReJuht/SA5r99CoYeZBV6li0d1j
         Ur5gXBsBMw6gurkAdQaTYlhQ97TVesK9el2EHLjBi/D1KpFxdin38jPCmhF67tmIWTbm
         5bjPKj1xc0Ge+YJAIy/7ZpX9mSUkHciNK53RQ9DgHt9Vjx6jsIhNacjCgRxOUY34/v9N
         4zlA==
X-Gm-Message-State: AFq9FYIsC0UjNsVf7BCHw8sFXTMmRVPBSAeFTsia5L+fU5n6Ee1DYQBD
	BsIJV2+Huy/4I2OUJL3KuvPVfQ2SXHce5R0SQ7PLOHXoTUhDIG7+A8Vdm6MixfuG+o4=
X-Gm-Gg: AYBFou2dB/hfUVqRJF0/MdXDRIPTWSqKYEURQ+iPS3N0BS/2iDFxFsCsp9+syHK4w3c
	xgpGhbAh7c0Bg4SEAdDs/sirFtb9seIPaLtOwvjVmw0SzRPVoz5XAK7Cdfe3TODwyWko70l+0W3
	CcXAs4aqZy86xlpcioSBuZz0t+45XfA31Wmy08IWdlGncw5K4exkjGdjwVm3zutozgH8XDh9Nx9
	WdSCTrgUnXmXz8QRf6pTvByr6BgP2AoRxGJ7a1GHBnK1O3stHFZNoUUkzmLkoLll/c6cEnkPjly
	Yw7k2CAUdn0+Wg/52XfP05Fq2mOqlksHbEqVKNv9vM+Qs6F/yNPtFh/iIy8X02yMOSCflEl+egM
	Pws0Q+4Sxuz5Zowa3arXA2rXcGGfgAGY+xB6lpHGDY12AgnWValopD2cHjkYObbgJ9sit/kWnOz
	lK6u7DK927qxecQTnZS3ZEcjD06tYCshpKaOWtmC0B1l6faJ81nR2SfMJqRsDh8JIy/cDN36cx8
	sw8SPQ3Df0IpM6wgyU4txxPwIxvxuolAiyiUXpTFlKQZMUNYXW1jEuTu3kLc3T/A0fF1GN8uRT1
	aWKV74eYS9BdLVTCmFTzw8t5iVM=
X-Received: by 2002:a05:620a:2415:10b0:93f:5cc0:5978 with SMTP id af79cd13be357-93f5cc05b2cmr353949485a.37.1792637850409;
        Wed, 21 Oct 2026 19:57:30 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e30610sm406637385a.43.2026.10.21.19.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:57:28 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next 3/9] uprobes/x86: Finish an unoptimization
 which failed half-way
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
 eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, 
 mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, 
 liam@infradead.org, ljs@kernel.org, surenb@google.com, david@kernel.org, 
 vbabka@kernel.org, jannh@google.com, hughd@google.com, kees@kernel.org, 
 mingo@redhat.com, tglx@kernel.org, x86@kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
Date: Wed, 21 Oct 2026 22:57:26 -0400
Message-Id: <179263784614.2549665.557126403507804820.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-22 01:57 +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> int3_update_unoptimize() restores optimized nop10 in three writes:
> 
>   48 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%rsp; call tramp
>   cc 8d 64 24 80 e8 d0 d1 d2 d3    1. trap new entries
>   cc 2e 0f 1f 84 e8 d0 d1 d2 d3    2. restore bytes 1..4
>   66 2e 0f 1f 84 e8 d0 d1 d2 d3    3. restore byte 0
> 
> uprobe_write() can fail with -ENOMEM, or with -EINTR when the task is being
> killed. When the 2nd write fails the result of the 1st one stays. Byte 0 is
> a breakpoint and it works. But the next set_orig_insn() doesn't find lea in
> byte 0, takes it for a plain breakpoint and restores one byte:
> 
>   66 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%sp; call tramp
> 
> Nothing recognizes these bytes anymore. The process keeps the call into
> uprobe trampoline, which can be unmapped already.
> 
> Teach is_optimized() to recognize the half-way state, and let the 1st write
> of int3_update_unoptimize() skip what is already done.
> 
> The failure wasn't reproduced, but the state can be made by hand. Attach to
> nop10, call it to get it optimized, write 0xcc over byte 0, detach.
> 
> "uprobes: Don't sleep on mmap_lock under dup_mmap_sem" needs this. There
> fork() removes the breakpoint from its mm. When fork() is killed in
> the middle register_for_each_vma() removes it for the second time.
> 
> Fixes: 554ba38456da ("uprobes/x86: Move optimized uprobe from nop5 to nop10")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

This was a nice read.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
