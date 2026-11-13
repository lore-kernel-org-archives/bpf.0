Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586540;
	b=I/EW8p+9LiuoYKzZQ8LE3t+7FAvlk8puoW5bkhaFni90M8W9+9SVoziHkmA+c+cBfYWs
	 TMRnLY48gffmpfHdoO3MaUaPqc2p0uwwlO5q815GJ/HqAfJuUJKMJsVSi8me1aAP2azLk
	 l2spte8GreBj93kVGJYfTC6/UVWsG0uwdXs1Okk355dCxB9TXD2sWETlpUeh9qFf/dopv
	 VRZJx0INEQHDAnD/NrLRns4/OFDIWaucsT46EKnhN4ixRJruoTDg6TDMeIPlMSndLY2Fi
	 PfTba12CO3XbujRHdplIcdBUMyBY+U1c1rfiaZSVRFQKVsEvtYN35fMvV5+L3q56O7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=j3WMQoq3LZGUg08n1zN3PVbGtGVmsjr4StONFCTkZYc=;
	b=sV4TuMcxqliMIr+Ch/ZNnHe32Rj52vxtwf/WLhB4Ksp5KcMpgsrCDjWfpLBWdyDLKuyQ
	 Z3J4oGNc42ijfWfAu4PhQyudqU1lIUzUOIiBlYufwFBTZnuMEsIfAeToceqNjWYLN78MP
	 iIgBBD+TQIkZYgoNOGeu7+SRkSjOmGNWAAfFt6O+Y8um83joQTsEOGH1gp+RFVdtX3vwx
	 gpvdAh215RBKdomm/zE0h9MCbvjnuP/220Cj8BwY3MY8fEEx818WcNZlA0dZopSwn763z
	 n+tNjwy2vTkeL0hEWimc15VIWqiQZG5byBi2BrhBI45ACwDX7jFvJcg2ElL16tqAQSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mKEw5R/W";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939AC606A337
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 16:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 939AC606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mKEw5R/W
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so1075526a91.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 08:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794586540; x=1795191340; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j3WMQoq3LZGUg08n1zN3PVbGtGVmsjr4StONFCTkZYc=;
        b=mKEw5R/WmjQ8Drmd//CmjN6uf2wjG0Qm03r5v4508Rx/lrjW1NBmSDFaktVDAri2dF
         INGu90GdGyI683vRDBZa8HF77/gkxJGEvsz6jnQExSfnqNPbCxXTnAl/cG99QPRVqBzB
         x8BuE8IAVAk7xCd10YAgfsbD5Mk9+FPqQ2GNCGpmFumuDUPYQ5t0ryhzTxSMTdwEDczO
         hDBt+vww9hLSqBnGjIntXKMF2FOuohEE+eH4U0+46vIoYlXe9CqoGN3Ld58W8G7zdQyF
         PSRs8gGkCm2aToSYFjwwiIFcXAMFN+tS6zJyIMNSiFpTBMhjVKgydWainHGp4/Inv7Y7
         jeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586540; x=1795191340;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j3WMQoq3LZGUg08n1zN3PVbGtGVmsjr4StONFCTkZYc=;
        b=pLOq5WcFWh+z5YaD7O+EwjFcs4Q7ySimfIpRnqwGE/7fnMR6rAasBBzjVw79mv1JdT
         lkvIkkGH+dXRtGIrgyWzZuzztXQeqd7jG0o4ZAxd6fECxx5xyanCOaqVFBR++PdAwds2
         dep2qsa/3YOCBtFzXPMiRhp7vdgXs7N0RY1ni1WSjOBWUBxDJRly0wxPu4nadAjuXO+3
         6aW81F5gjEemCvVgrVpY9IDAnrlu/QZtbiRPJw06ZcE14p3fYffSMEHCn+Y/T9e35pFh
         NfsSy55hrH2m0WS4tHcoXsMg33aL0mx/rqsIMrXtKOJlwkInKFF9F+I5SMadS6mr8HQN
         mP7w==
X-Forwarded-Encrypted: i=1; AL+hErEIRIDFOv6dNiWnkHrJBxy+swqx4D1bUJdlICvUn5WYx5ukcNq4u+nboDCd+fNQPYOtMMg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QgLs9wf3b7toMrFcTVuDQAwXqaTeHSPOuVMWhwcKFDszim6Hq
	OE/sgKzywQWG+l6p/ZC4vrv8bWkXoDChaJ7gCX15xpSMvP+p4l6kqdMJ
X-Gm-Gg: AYBFou3AAWwKUhHrd4fQIyFgW0ibOvtzI153bUxHW5kbKb4PhavD1ymQ4MsoDPRs4cJ
	Og6mezTJMuyzISvIMwbk574GDRE6yy+ti3wMgRxEB7GgU5oJ5A8y65iGVcsy8sRLJ3h3wbSjS8v
	ZhYFWdSCDoimcgGnQr5XdpWfXh79ZCBBOSwljf2s0kYWzIZPKYMKi+B3JR3G5ODlgDj/iilWUuX
	1ZNTwtgYskAnG76FHT28ZjE5Pp+UYuvvCB/NfE/AfHcFPOTf6sZmkAtOmVM6PcRVxPlqPf+0pb/
	6E8A1PdMKmVfep+hs21JdxD+vDJdEJkxic+ApPY2/PjtsUdRTlcHwPuB/n89F3ZGvUbgkzRqVtf
	oYuuKQ7SzZq74fwIKO4+cVxYGtHL09SOPw6RFgJAVjeebvzO7u7niWNfNBAdY0nRVUXdYDBA2WB
	fR5z04i/rx1c0PC/6ooJQVTe89vKO7SPvOYLVrE12bk07eskBl9l3tRvsf4dC/12eRC0nogyE58
	drBroGqMPxVIbhYayUa//12k8AxSaUtGM3ByzMWUaUkVNRqbPYcHya0otMySyjNQDaLa5K/JfeZ
	IArA+EiqYSRjKykB+6AaJqeaJ2y8bmdF43a0+/ra0EnZ6eKMlJ+r/ml8fig+ArpD02oqOhIg4Te
	r3kzs6Ugb86Mpfq2b2+KU5Pxho6R3dNR6Uxnr
X-Received: by 2002:a17:90b:528c:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3b1b0a5030emr2346356a91.40.1794586539745;
        Fri, 13 Nov 2026 08:15:39 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6c9c5sm10137966a91.1.2026.11.13.08.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 08:15:37 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 16:15:36 +0000
Message-Id: <DMU7U1PO0XJR.4L9Y1AL5QO42@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <a.s.protopopov@gmail.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH v2 bpf-next 08/13] resolve_btfids: Don't list an error
 that follows work on an argument
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <552ca9c7597417c92823f305ed9e41c67c2621674e3b568ffa085ae2e2c28aa5@mail.kernel.org>
References: <20261113050901.1399091-9-alexei.starovoitov@gmail.com> <552ca9c7597417c92823f305ed9e41c67c2621674e3b568ffa085ae2e2c28aa5@mail.kernel.org>
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

On Thu, Nov 12, 2026 at 09:52 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +void scan_set_proto(struct scan *s, const struct image_func *f, unsigned int pointers, bool effect)
>> +{
>> +	struct callee *callee = callee_at(s, f->addr);
>> +	unsigned int i;
>> +
>> +	callee->effect = effect;
>> +	callee->pointers = 0;
>> +	for (i = 0; i < s->flow.arch->nr_args; i++)
>> +		if (pointers & BIT(i))
>> +			callee->pointers |= BIT(s->flow.arch->args[i]);
>> +}
>
> Does this mapping hold when a parameter takes more than one register?  Here
> BTF parameter i is mapped straight to arch->args[i], and set_protos() builds
> the mask the same way, without regard to parameter size:

It doesn't. Will fix in v3.

> Would advancing the register index by the size of each parameter,
> (btf__resolve_size() + 7) / 8, work here?  Alternatively, could a prototype
> with a struct or union parameter be given up on (cleared)?

Only up to 16 bytes. A bigger struct takes no register on x86-64
and one on arm64. So I'll count registers like bpf_jit_place_args()
and stop the mapping at a bigger parameter.
