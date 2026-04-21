Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A837FF6F
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791683; cv=none; b=mL0KTrIc6e3PqI7p/MT//ypOZ2yGK4HAYUEJfBig59aFZZsYM549e+m/ktGDfMOhGd+VKVQ9ADwSvOwku2EzT0fypeT7//44rNoxOOhbF+c0xpDdzhIeZeiBCl8ppKcfrCPhb1Pq9kp+MDXaUZ8ADUjvEccIhqt1M+ckqMnB1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791683; c=relaxed/simple;
	bh=AbffSTTzFlGGmXL2Q/w71oMtBB4b5CPC1rT+t70buS0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=i0sVcbPk8K24dOHP0x1k/3KtiiSmXP6DugTk6cHNBMv6iONqqKO78SbqwRq3TaNxbYx8tISWQ5FLKHoYO1hHZ8Y7km9Rj0dYbjIMp9FboPaQst3/0lavj+mC8dgkH3g9glefFau5vJqqKV5ocVa72NvIYWISpLcJL1tIHJNjarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz82L3vP; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz82L3vP"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dcd9061b1aso825574a34.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791681; x=1777396481; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbffSTTzFlGGmXL2Q/w71oMtBB4b5CPC1rT+t70buS0=;
        b=Mz82L3vPoMK6pNeIYpQTYV8FGRIk1dP2f4Ot8asWfqJkbBYqYK6kvzstvYXIZ3o/c2
         1w0AHod5C3kFuYCG/a+emm9Wof+QdLIVDPazt0bJ5E72ff3zYlZfnIBxvXlC6LBYv7pU
         igUp8q3uldNLu3rXeuvstUvIaPUPAo4dAN4Fq/27ymJLJbFlMnVEmLZobll9a2iTWCbR
         gpcQVTJB9LIugrAKnaFiXqhNBxCeByoMqlb2pU1ovf+vFCn1NfZtq72aAjIfvTEIRhLE
         Jgc0vIBfhUO30cKsN5H+G3ZEcSTGm1r7alAdSke+VuwrZTVrGGsZP2b6K/V6en0vX+5O
         bSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791681; x=1777396481;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AbffSTTzFlGGmXL2Q/w71oMtBB4b5CPC1rT+t70buS0=;
        b=JFVlHC7rn2QMh5tRTZ6IQYttHu43IVSd+XF1H0PqTwsYEXmcW2fe25eH5GdgDM4Ljt
         Okih7ZXQOU/W6x3m9zRhHZojY1Ws3+JEU9lt6XQns6TE4mcANRYAWbKJsOmi0a67/iKF
         OE8U5HLUz2HjrtFfzYAxhCTFD1KSA+osv744e1Vtj52OFVj098lFceBSgpO6TI3vkbvF
         kYgIoQNAmmJ5w2AKbgxwHXriaNeNY6W3kvAY3gxbOCSMH9JohXjiEBDlBUVB8J5JCYxb
         Xh1Ov7bqbexhYz4X26rG7wCVm5dXtCAxow8o8xqioH87EpgsZPWwDnTv5YChkdbIPJIW
         Xycw==
X-Forwarded-Encrypted: i=1; AFNElJ+DqLT6ehrxZ37iop+hl2k0pHNtMg+JsazIDOqt5t3eFVOV5z3xJeo6PeqEroCdtbzjB2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyehrtF4+inAzoQ8XWt+CDOWBH/AJH4riWahwyMGYa5qXOzezG
	hn/iZED2iyHwpAA2OOZnenFl3+lcC/YxW11ARsJwM4E+kKwurP/c7JpG
X-Gm-Gg: AeBDievSRu0JniUMz/1620mz3rcAB34horfhBrBeHvr5G2vb3QLYI8FxoGFwc8vqcz9
	P2T9w6esKMrTH55ybgnOqSbYObwaLG4HhUcdJccYruff8AyMfi7xtkCGkvHJUEKm4VNxBbjwG0l
	KxtqtnMqV7ZoTmkA20bHymqfLj0vr4uYKiGF1Brhg6wyKQc+QsRQcy7kFwvWfgPuuI9OEKXVy5I
	BVoSzQEIedtRdpXJAIqyRYEnk6t/+ANG+KJ+gkIBgBvWbBbMCp4c8SKIJgatEPXusocKp5RvUDt
	ZdjW3S33H89miMc4n79bkVGWSD+reAww/du6icmz3zAPevdtyCVZ7Niedxkm7Z5j/zKyop973fm
	WnTZmXgOGeh8IUscm1XROAcuavj6BhqbjalkjTl/hdYUXpvO5Ft5zjUO0ittedXrCy7BGpIYR2A
	g14B5gd7Af3dwIHuXkJylzo7inSvk48MxmtcuV3IlE86mS2zP/RCbI7sb20qwOQdtprot8aRdeT
	sr8HAYOcFGWoHaWa3k6zF7TNmV7
X-Received: by 2002:a05:6830:3155:b0:7dc:da40:77d1 with SMTP id 46e09a7af769-7dcda407a47mr2346740a34.26.1776791681258;
        Tue, 21 Apr 2026 10:14:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcdbef352bsm1529676a34.10.2026.04.21.10.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:14:39 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 10:14:38 -0700
Message-Id: <DHZ030ULPOHM.XRU2YSEMNQA3@gmail.com>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <shung-hsi.yu@suse.com>,
 <paul.chaignon@gmail.com>, <harishankar.vishwanathan@gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with
 struct cnum{32,64}
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
 <DHYYQ6F0ZVAB.1FNAHDCF3WHKX@gmail.com>
 <b9b278f28ff94dc3207624d304be1080584603a7.camel@gmail.com>
In-Reply-To: <b9b278f28ff94dc3207624d304be1080584603a7.camel@gmail.com>

On Tue Apr 21, 2026 at 9:33 AM PDT, Eduard Zingerman wrote:
> I thought about forking additional states if an over-approximation
> is about to happen, but didn't to the experiment.

Don't bother. push_stack() will be removed.
Don't make it harder for your future self.
