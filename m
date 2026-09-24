Received: from mail-pj2-f33.google.com (mail-pj2-f33.google.com [74.125.227.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E82360EC3
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262980; cv=none; b=AblN78J6IYLiII1bT9PgMzIUhSlJ8252N/DuurKnmcINlFzpLyeBG+Wm+FDY7lJpkc9ew/oYB4a8yByuJOgDwsYlKAHJmIJBSjx0fx9/f5d/yv16C2ecwIvLzhfSe7r6cv/IcCORRtDUP6DEdMf2IbRasI0BAdB0befqkuWXYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262980; c=relaxed/simple;
	bh=GR2NKcu8KApscmIBzpYo6MOzomcEaa/JzfoSdLYMsco=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=Rct1DfMH7MKXRYciUTmP/+0jBDddpy3/knxNM8qldIiqDIKtp9+e3AVcpTDRujik7GfJVhmIHWxdAFP7iHnBHQ1e1mqymKr4BoDYTFf3Q6d4FgxSpeOcjRCLF64HqiQ40k6zWdOInvKp2P2bW8p8MV+E73i2vq4crmVR6fKqc7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0oH6L0H; arc=none smtp.client-ip=74.125.227.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0oH6L0H"
Received: by mail-pj2-f33.google.com with SMTP id 98e67ed59e1d1-3a0b0fa2055so1850a91.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790262978; x=1790867778; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2p3FgvjJMLp8zu35wHG4/I6MuTSvqNH8vuvW8VX3ekg=;
        b=F0oH6L0HXdPggOQ8SDVhMES9S82WKjO/YX5VvjhIEvhDx6SEpTIehdiZz7esqfyC6v
         aQyNnm4YknPzO70KqKSFu+lCyvXHlu+AF+z1Cf4DJzyTRtjOKypO5TldS18Tv95DLCbJ
         Kuv15PmN02SyyeF4Bm7wtl0pZQx0aMzbSBP7BkzxvzZS85wHFRZxXgi0r4jImvw9OdvG
         mAnic42zuCDFaxQeeIC2G1JQ3K5q131AVRhp4q9gOydz1toj728U1DUmTl7CuHdewnqS
         F/71+hcY5n/A3PNGy64jeyHkZ+A2xT2At7WZLiwNuUTqy4eo8UI6ysgpj/2/2VtqViQk
         9jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262978; x=1790867778;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2p3FgvjJMLp8zu35wHG4/I6MuTSvqNH8vuvW8VX3ekg=;
        b=vCZIIyDrnoT6XPrVo5NfVgQyuQyoriA69u8iPq6ekz848SgtfwpUAjkkI80m/3zGF+
         SIuPMeSgJ2iLKYV1vy11sia8lOnx7Ucavke6h1Bz+NuPc14TCKufp7xk9ICv3vrSSv5I
         cFUVFaR9C1t+2fhnDkA8s89FuZDcAnFIRBPwz5UY78jVSdSJpA0u+qADMmpbB7BpqE4f
         UmSGOAeHfrCLSeIxQtv56lw7ZSxi2PMF+a2UZh11tjwQResKQK2aDnw1/4ovm7PsknFa
         XWhao+ggV7JOaGzfe/22cE8FsekaomvtGFPYgJ3X0mZ6z71amTEHMaWAznSQxRuxRd8n
         /WmQ==
X-Forwarded-Encrypted: i=1; AKwUvByD8Fu0jR2rCNexLw+YF1FA336LUlPDshScy9LTTTTAfZE9rr/8GIgPL6ZVfVj6OxyjyY4=@vger.kernel.org
X-Gm-Message-State: AFuF++mU6SeEC0yAEw48xW8S9jMkJCeq4BKmiCIyZcLGqJ+OqZlR3U1M
	ZWdjD+xrOlaaNi43x/Wz5IoDjkAcKfxBKoYNKnOFD5JBeA3NKgA9FjKK
X-Gm-Gg: AYBFou0M56Cg0XqSlcsgimM8zKvElzxaQOLW3Bi0O6XVWIqueVJXQVrayqdAIfY09wW
	90djxGFkXN1hrV+GP04LoEDPv06uKmMO1YGYl7E00YsA2mxBvwUxomzM6+PmQDKppBPl0sgWxJT
	HEIO5IJ8nuax8+LidfmvMK2oHDZB9tOIge9oSeqDBTHb06uE9/Lsg5d7uVTC3d6lJ3EDDODgPEi
	eFqKPiW47SvLRxnrSWZqcFvh72Ef0cAhfseQUxzm5QAgbHwuK5oAFhpeD4JN4p+Lljwiu/AoEMI
	C0uzx5m/u96CUDNT0WfJOEhTrzPLncGyL7H8V4f/OGOzjTo5lP4ZeA5zjSWKY2CDQe6NWceAcm+
	HlEkDthOpAS1vHW8CqNLwtNN0i2hKgYB4bZrRfmoRldnEgTev56Luhg34PvFexAwO/pALprAalS
	l+CmwP6eQS5r8cGF3CPEHguE+48iNNKSOLEIPNRWYU8LPkJTOZV/UuR1rpnkZv0AAec7F3/xcHL
	u5CdoHiV+hCegFS++FB006oAEBOEYBDy5RfIzz/1AuaGL2bnUt05mP7vUlz3yedwmRGRpKoxJQk
	je10sll3FrTkkQ==
X-Received: by 2002:a17:90b:4b82:b0:39e:6a81:f350 with SMTP id 98e67ed59e1d1-3a098bb66dcmr2514155a91.42.1790262977907;
        Thu, 24 Sep 2026 08:16:17 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a081265144sm4607675a91.3.2026.09.24.08.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 08:16:16 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 15:16:15 +0000
Message-Id: <DLNN9DAADBPQ.18FN1VMU78XSH@gmail.com>
Cc: <jolsa@kernel.org>, <daniel@iogearbox.net>, <ihor.solodrai@linux.dev>,
 <yonghong.song@linux.dev>, <song@kernel.org>, <martin.lau@linux.dev>,
 <memxor@gmail.com>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <nsc@kernel.org>, <puranjay@kernel.org>, <yatsenko@meta.com>
Subject: Re: [PATCH v4 bpf-next 09/11] bpftool: Add ability to dump
 LOC_PARAM, LOC_PROTO and LOCSEC
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <qmo@kernel.org>
In-Reply-To: <20260924111428.75957-10-alan.maguire@oracle.com>
References: <20260924111428.75957-1-alan.maguire@oracle.com> <20260924111428.75957-10-alan.maguire@oracle.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 12:14 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> +				printf("\n\tname='%s' func_type_id=%u loc_proto_type_id=%u offset=%u",
> +				       name, locs->func, locs->loc_proto, locs->offset);

My earlier feedback must have been lost:
Pls print argument names and where they are held here as well.
FUNC_PROTO has the names. LOC_PROTO has the locations.
Something like:
  foo(arg1 reg1, arg2 *(reg2 + 0x10)) offset=64

Or is it planned for follow up?

