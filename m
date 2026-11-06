Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933088;
	b=tRzZNlV3F9XmanvTpIljB3X2tOrXo2ZQ3JK5XkV9moJXcF/NNUOlxRfiGeBIQiKVTJCR
	 zY7g3p7XPrLfuvyU76N3zxld0YJI9esmMSudR8kg5JPUMdyO+VR4Uinp10j298BevATRr
	 4Y4JtlcNzAcEOi/1QEEe7tagS/L4LtbZbVqtAWTQFHz0cyMtUiIazQ6cg59aha/VYSei0
	 mqop1WkL1aYMWau6wroX+l0WnZTtQFhd18jwykkIDSoe050Gukp/1BIQ1hKKnxlAT+g3K
	 R3CU+Dofp5RcTWAsncZnOaCvYHxJ7igyVVtbqBioGhFSkMLJzwHPiFlYzkvBPusU5Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=6qk4Doih6ZbruNOo4U3Hy1CLX5odz4MX9P1LmVXvTDs=;
	b=10Ly0F4jZVUha8lOUjcmUywPOFJH8nC5wzZkU7oCGGDbi76RW6TnK+pvInMpnJ9J2Lbm
	 k58OkPTAkXPziiQ3iL9lsNTp4+yc3XzAsNdnIRbbtt/C8+BJv3n4rp2x9L0n6NciX/J12
	 o7qyq2QV1MZ/fwIxr0cjWCCCTFO5CJtB8UilQ3wSwLqvN+lUNV5wz+DlT/dH34y43KGkC
	 rOuKivYyNWJ+cZa7irT3tjgpELXBXeUm2ii5QQdtGTD2KSacM/1dtXBpSZpbOn94/Zi7W
	 SGGzqG3kWVySJ9gpDmGJOmlUktDK/d7EHz7KowuEsime1ka7UZN1j/WHItS5yFxFfxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sjn8XOB+;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF4606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 02:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61EF4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sjn8XOB+
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso86387a91.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 18:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793933088; x=1794537888; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6qk4Doih6ZbruNOo4U3Hy1CLX5odz4MX9P1LmVXvTDs=;
        b=Sjn8XOB+zldi/CGiko+EG8itMhQVxD9p0Eq91B2UT+29SuH0/agx1t45/sZ/SJuuTE
         FwSQjXIdvzwKHvW9BsvsWTdLYgxUV/TgiMxjyA4MI3mwLBD6zwWPDaz1VKIJKN1COJEW
         FW29qC6UP41k1tQlt6T0xnE14wyIMJhRUmvaPj88c18BQMx6RSHmCIO+wU1g9JixkTY6
         lxjmwXD1R1s9u68mj9O/sot6vdNlC9oK7+vitEBEfV4Nu5/PM93cdesOeILmItdJlKm6
         mGQ8ePQ6vvT02erkIum5/8bXfY1AcUiguIaSA8p6fcf33X52eu94f5YOEQl1YXXRZ45f
         IYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793933088; x=1794537888;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6qk4Doih6ZbruNOo4U3Hy1CLX5odz4MX9P1LmVXvTDs=;
        b=CZ41MVea6gKlCoUUc7pZJzpa4emvu3jMsnFjJ9fm1u8omQH3/p99UWnyZqLMZTdr49
         j8t3TOASc6a0lWwApem7DJC0I9BUyR3oV/zfTDOPE1qzaC7Dx3tZuYKe2fPOSsKsn43T
         79dKXCwWQl6hOx2hnqdAY2wVIS4dkmwlbXI15H6KqPKAZlUI1v6yAuQnxWtzTc8YfqTI
         a/i8YWOn0pag0CH6s9DhMIWZl98xehDFlYBdbw4Z1A2ydi88cdcDgBp7/ksGLhV3Qpz5
         ah8cOsSoZQb2V4MxTw97QTgBS5xbE0fwv4wUYea+guukKEUijv5V/s8a2fpGgeLsqmRa
         TgbQ==
X-Forwarded-Encrypted: i=1; AL+hErEqKX5fF7vxuVauhKProv0Rr///CBRhBKGMCzJQ7hGQpZo9Z9m40KiTQ8nPC9kCnxgVroQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8C80I2b+dpeTb3VE9avD/eH/hVftdxMtzFdgVnbBeYmb1/CIGH
	q4L8EP1sUVg/3Cc/k8jEOBcXx7Q/maRXiWrOHLImSXhvVSlIZj6skKQwAlc3sQ==
X-Gm-Gg: AYBFou1ePWpfsvKZyKBFtSBBeBUVJIFSLrODdTngyY5PLWY3fIqyOF/E3qcFJWZ/OiR
	kWR0OyALNW7Lh9p+T3l4iGc+IKamtc375ZxOIRKphPUjzcUagDot7wxDoYMidKODT6umYqeEI8g
	dGivzZ9F4bv9dhaYBNAWEo8f6IWr//KGJvty89VUmw+JbqRcM5LbrqGHoeVa6L9X0Zo0x72/rlg
	59eaMUlHgGcjWOsqIMdolNKESPxG51MltuX18m/srD6aFOo+3LtjTFX0yw+gp2Q7C3RRnG/m4T+
	7LFLR/tRLktUR8xl8Nt/b9sfY2VcpcJK+Jj5FdPbXyhZpx9r1Rtl4anrBV9wrX9/bWLswAoLc8f
	BwkPHM0jdftz1QsWgOkMq8RAo5oWscODOlhXRVFUiR0bPP0tigklLN2nwo3dLb/FTDI3Hkz9Opm
	jGIEn33Rr4i/6gDy9Xp8GVNkDepbsi1S8JTXs93h1tbtZIRsIhzNd826H8RK0YBcBjYKTFNZM36
	S+ncL8RrT259UtZXu5Gc2nHmqr07NfMfKUm4Wx8PIJafsZ1PNmNCBRFoLcJovmaxyuvkOCrQiv1
	BWNZ8jfzvU8vJszKd7FIDNcEH6xSG1tngQvTJuecVc8NqUsn/HgDrn3wJbGzcEQBj0CVgGaaEAH
	CGrK/QnHYVdTAACYewTTQeoB6xVklfp4DEAsK6GW3EQvOFlv/olNCTjc=
X-Received: by 2002:a17:90b:1c0f:b0:3a4:b8dd:1447 with SMTP id 98e67ed59e1d1-3b0db6f69aamr1009303a91.34.1793933087546;
        Thu, 05 Nov 2026 18:44:47 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d77c7ea3sm1365990a91.0.2026.11.05.18.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 18:44:47 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 02:44:46 +0000
Message-Id: <DMNS7EVJIZNH.2KVNGPHEJ2H60@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, <bpf@vger.kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "HyeongJun
 An" <sammiee5311@gmail.com>, "Christian Simon" <simon@swine.de>
Subject: Re: [PATCH bpf-next 0/4] bpf: Disable private stacks for uprobe
 programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiri Olsa" <olsajiri@gmail.com>
In-Reply-To: <aus-b8Lo2oCw_cGd@krava>
References: <20261103093400.112178-1-jolsa@kernel.org> <DMM59LNY80FW.36KH8ZKL94T59@gmail.com> <aus-b8Lo2oCw_cGd@krava>
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

On Wed, Nov 04, 2026 at 06:17 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> should we also ban all kprobe.multi programs in here?
>
> checking only jits_use_priv_stack on the entry program may miss a
> private-stack tail-call target, like:

Good point. Yes.

> +	if (is_uprobe &&
> +	    (prog->aux->jits_use_priv_stack ||
> +	     prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ||
> +	     prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION))
>  		return -EINVAL;

can we ban all four multi and session types, on kprobe events too ?
like your commit db8eae6bc5c7 did for perf_link.
The ioctl still has that crash: bpf_get_attach_cookie() in a kprobe.multi
prog reads bpf_trace_run_ctx as bpf_kprobe_multi_run_ctx.
Then no need for is_uprobe and jits_use_priv_stack in this check.
Like:

	if (prog->type == BPF_PROG_TYPE_KPROBE &&
	    (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ||
	     prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION ||
	     prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI ||
	     prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION))
		return -EINVAL;
