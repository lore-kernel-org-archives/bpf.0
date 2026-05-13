Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999B390990
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714660; cv=none; b=N3JeUg67zlOsva/EW9aULtmgwSdjPp3cQsXrXiyJ7lXEVi3ZRcYSM0P6Sx3YGi01cJjnEjBmFejQhAw6PwJRGw77xy+jE7tn6hQt9iBtm13Z8kYyqbR/wNhzridNWkjAEb91N8TXOX5l8G09N6It5GgJ31I85TnY5bJ25YTU8z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714660; c=relaxed/simple;
	bh=gQfLuToUwG3/DfKQGob0k6BIvAEPEo3/GUrsIzcnvkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FsfdIOcgADe700VNLxjFU+a2L2LShWuTXDLlrFQGs/RfU7M6qSZyP3hqmsaGy/M9lWaHi8nWlYghDmIuZZe5PeTC2YtoZ54h13E5xy169KjTC/CcsVQ20YCldqIioUs1Qog0JCylO8UUzWpORrk0XYrkRMVSdGLm9F+h8KFhcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2zzW9jZ; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2zzW9jZ"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c15849aa2cso9951658eec.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778714659; x=1779319459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ruBbwhrhsClZBDQ/hSrIOxvtByrjslb4iithZDdrkUk=;
        b=o2zzW9jZgiIuwG1aL6sGygDnwA4KBT1BuFPV4w8g0Ui3NjJcS4Td1DfHs1AKn+jEUG
         OTiCKnOAeNWUEgHVzEt2riv0jTr0Sw7vkcauuPcIv5cTIjg7fEb+NKjJVGnc6vY0QFLc
         ZFaniDIevGb0ObbMSZTbxUoZyImp7QUwhnsjT3oZZBQG9SgZ6X5lQH4ac29fRqloH33A
         WlEwdXA2cAnh7mw475b6tbTB6a+O5DSm4kif3ACKWE0zsRrAhvuZkYRGelHz5YoRCWgn
         fbS7efz326Rqf5ff36/nr8ZJFREySCFbBEOsBDRE/nechPRflTvuj4Z8N0pkupNVNBc2
         hWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778714659; x=1779319459;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruBbwhrhsClZBDQ/hSrIOxvtByrjslb4iithZDdrkUk=;
        b=adbrC6bpFJ4f5OLA3sdKiox7j7cQNYNm5zhvw1YUufoZsQ5hgXZagto+lVu/IcLpmC
         MZARq/dEjIGVojqQr0epWHnYRYI4Tgwx8ZtWyjCtPSt5Ml7v/FHqtIySSWqJVO8hiMJl
         D+zkVwcbqRI6c92uE5Mftn4HRCRqeOePB47v8PMTE4cT1uYsD2jlzkfHIt5gNqlYJTJ0
         W9zLFuSnAevpXyeEHEYImDWiFiTGCvY/nlIWH5rwZTxqnGgdKdV956E/JrnnYdBDB7mo
         9QMe/wySW8DsreqvuqCiZV0yVbB6jfQGTVq0Rkr2sCu5BeU06X1skRDzpSh43OwT5a5m
         0YFw==
X-Forwarded-Encrypted: i=1; AFNElJ+6bQpdFvhvAjMu6wb07oQWwGv22A+CymnQC6Cfv3F7czmDqSuWq/VL0M6U3ew6pOh+Wmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNk9wWhW+1rxtrdgcCXpZKuQcsytC2JiToqBuv5NWBZ8CDuEAi
	yGwBb0keR5UC1ALh3PF8g9ZSjDpA3O13U0kAmqweMAba1ZKGlIfKi5SN
X-Gm-Gg: Acq92OHD+00RZ/Yx1/Azw+ivFb6fzrFHoy6csOzhK15pjjVoUYCpPrLfltgUFL1iEbt
	kfDhLLuA/iPinpZkF2wD0IrU4XmxQ7xqFI6onc6R7fWgPNzfVsJBAoBddxNk06cuUnkFAVAJEKB
	GVtoFncl2dTNindO5UcZvt/FnfcaJB5IML4uUfhyAaN0JRt/EOT+gcA0QfCcRykCXFtxf7FBU9V
	bDMEB6Onl4RtDAq8skyD1Yos1+VXRInXXAPSZGOCsG9zuzF38mADq+0N04KTUb2LNJgKPqMPsP2
	bPErjOfKinWeK6lhrlxvO/YHCOu85BJofM163BoVuNwPareGb7M/IGFP625aKtShK07JNDheIy1
	Tadbga3fKfLR9WQZipTi316aN08UQLBPlqqV6LL15cCsLLn1jccxHne4RQu6mBQNHqP5zvwCtt2
	TdHSCp7B0+1f+va3iHtT9Qiw2FH6hTICeBV92K9Iivord08YjVYkjGtvnXbKk8LDYBsOYunycPM
	5r6wg6rVs7mrHGSOQ==
X-Received: by 2002:a05:7301:9f18:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-3011747cfa2mr3791853eec.8.1778714658528;
        Wed, 13 May 2026 16:24:18 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5152:641f:f5ef:6c7b? ([2620:10d:c090:500::2:8a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978afdd3sm859170eec.29.2026.05.13.16.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:24:18 -0700 (PDT)
Message-ID: <1ca8beb266c48d54d2c5eeceb0345bb10969c069.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Report maximum combined stack depth
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 13 May 2026 16:24:16 -0700
In-Reply-To: <d3d23a0410f87f116f3bbaa98a815dbae113bda2.1778700777.git.paul.chaignon@gmail.com>
References: <cover.1778700777.git.paul.chaignon@gmail.com>
	 <d3d23a0410f87f116f3bbaa98a815dbae113bda2.1778700777.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-13 at 21:34 +0200, Paul Chaignon wrote:
> We've hit the 512 bytes limit on stack depth a few times in Cilium
> recently. As a result, we started reporting in CI our current maximum
> stack depth across all configurations for each BPF program.
>=20
> Unfortunately, that is not trivial to compute in userspace. The
> verifier reports the stack depths of individual subprogs at the end of
> the logs. However the maximum combined stack depth also depends on the
> callgraph of those subprogs (the max combined stack depth is the height
> of the callgraph weighted by per-subprog stack depths). We can compute
> a callgraph in userspace from the loaded instructions, but it often
> doesn't match the verifier's own callgraph because of dead code
> elimination. Our current approach relies on dumping the BPF_LOG_LEVEL2
> logs, but this feels overkill considering the verifier already has the
> information we need.
>=20
> The patch lets the verifier dump the maximum combined stack depth in
> the logs, on the same line as the per-subprog stack depths:
>=20
>     stack depth 16+256 max 272
>=20
> The per-subprog stack depths and the new max stack depth are not
> directly comparable. The former is sometimes updated during fixups,
> while the latter is not. As a result, even with a single subprog, we
> may end up with two slightly different values. The aim of the new max
> value is to be closest to what is actually enforced by the verifier.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
