Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4F3112B2
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435657; cv=none; b=OzBGvBvw1ceNF2SM6PztSHEz0xucQ/USiHxHflrD5l3gtE3LmpphfYucHmx/8W86hBS4T4p70PHRY0aCZr/6m0UcarfFJZlLvX76OBzHMGKRMKB/jlXN0qCuvN4nJFe7IwFpHq3zGuxRFGY7DT3g5Nr6sb+XOa+1OGWaNAP9oTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435657; c=relaxed/simple;
	bh=PNv9zdSBVU59fmU9/7lEi5eHPqc+E/VlzTgKu/fSaII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSoH4q9pJXzummkW+dshOQO5UufXSq80+KZvMqxB99PyAaqNdE1i706aqWjWII4TNnBIA5PawjF6ggmyMaR/30pi242RjXBpIUwNTdNPdin0jqtFNZof01Af4Tao6V8fDgz8rj7gtsvXaoGIgIRAe+v9PSID9R92lPPNQEnCUb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/IAw+ZW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/IAw+ZW"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-381b831d535so4877324a91.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783435655; x=1784040455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3aTkXAIBSsu3lXmX/xa/IfupA1waQVd+Dz2CaONflns=;
        b=Q/IAw+ZWgCHVf5meSUufA7niqEEkVq+BlEdLKGGCRLNTJ4JQvhbGdZifl6P4DgPVFe
         Q19RrYpKj3aNyEdtxlb+ouafq9sg28YC8JZGTUJbVZGjfsog73SmSI59avEcWj6bSOZJ
         aHIyvdy48Xi8QZBfaaz/ZHVyGmdMWR++7MFdwAIJ8gvxc50I5bd9FloJmFpMAhPKd7+q
         SnJk8Gmz8pGWrUc7Jhi0Rod+Jq7wSWvGFfIHT8mukBmFOA7h26o6kUXcSUVxY1epoimU
         5IQTEDUEBYd/sMQ12apPAEk87pmwWrxeiaZ8P7/LQtU7ayY2gxdm4VVkZDmOfmo9ZnJ4
         QczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435655; x=1784040455;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aTkXAIBSsu3lXmX/xa/IfupA1waQVd+Dz2CaONflns=;
        b=DNpNA5RZs3k6PvzdT2PUDEAzsqIkwiSqrpCWIiAIxEpt9PwVg8ubiYOrWMj29lVcgm
         KBEhVYil0prEa83c0iemfgfq51c4uSIu3ksRPK2ikvmi/avBRshmDdWytgtDoQVYubiW
         eBvki2StryhpdXkl8bScIWnon9nkPfYyJlpnC3ZptkUztL/REfiJWHDrQyglPf63bFIM
         TQpD4ZsyfFo6WpqBMgJ8KgjG8aR2m9EF11la8AdP9DMOQLq1niMStY3e1aTLv+Td0kGr
         od6T+hldr+g997h6E6aAKayCygGDgA9lpBSvxj1fv7h8nDF3ol/h22Yfcdg3cM4feo9Q
         z/Ow==
X-Gm-Message-State: AOJu0YymdExNfqOYS/AV+u/WKELx1X74RbCoE1kmO6wT/VxYwhNK/Ona
	eJVmWTQzcr0FdEmQxeLlUragkUMpBFfaT8hdfDcxzDURQ8LheoxS1OPDsnz5mQ==
X-Gm-Gg: AfdE7cnn6hGfmYs2RnP0yYJquMwijX24hLD5DcPGhMyJxnTTx+ussySCMZEdK2eAqgj
	Mlxkt1mFWqd1w+p5Vr+ufdDLYhpHa87sb3FnVD4kXy6377KNkiLJBPz6x4lf4xibGwauUThkfxn
	K+y8IGOKF/SJE1gx4G/tc2DWl4O/p3yzmzahFQjjbtJej2zwgpH64vJVMagOHgRdynDjDkvhZpQ
	ecq28Mj1KXwcgWwEFbxCaqr0a/h5mhNE5ws75aTimO4zCMroFUO5vCs4n/iQFv+vWfco8ccw1fn
	YjtKeYuVQRsv/9UePlK8uPr4DXbxBO47cWkZ4I++MB+/Y6Rjvg87Yakc1+7nCRYiNduAe8jPPjE
	sqllEhrOCoeNh8vAuF4F873Uv/G8ILVvMMeUkeLAf0qNhPHMxC1fOk92ByAOhy10Ef6e9E+Nuuk
	QbXRZ2qIzkLQ==
X-Received: by 2002:a17:90b:562c:b0:37e:144d:7f6e with SMTP id 98e67ed59e1d1-3875650bd7cmr5588414a91.3.1783435654718;
        Tue, 07 Jul 2026 07:47:34 -0700 (PDT)
Received: from john-p8 ([98.97.43.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d100b5a1sm1253150a91.1.2026.07.07.07.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:47:34 -0700 (PDT)
Date: Tue, 7 Jul 2026 07:47:32 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Vuln seeker Cyber Security Team <security@vulnseeker.org>
Cc: bpf@vger.kernel.org
Subject: Re: Responsible Disclosure: Heap Out-of-Bounds Write via Integer
 Underflow in libbpf parse_cpu_mask_str() (libbpf.c:14446)
Message-ID: <ak0QM9G74dc3jpWc@john-p8>
References: <CAO_sQLjn=hghkb7SZr2UWexf=opgLTu5_AHR2uTQrJ1r13vpjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAO_sQLjn=hghkb7SZr2UWexf=opgLTu5_AHR2uTQrJ1r13vpjg@mail.gmail.com>

On Fri, Jul 03, 2026 at 05:22:30PM +0500, Vuln seeker Cyber Security Team wrote:
>Dear libbpf Security Team,

[...]

>libbpf's CPU mask parser. An integer underflow in parse_cpu_mask_str()
>causes a memset to write far past a shrunk heap allocation, reachable
>end-to-end through the public libbpf_num_possible_cpus() API.

Send the fix seems worth checking to me if we are already checking
start/end. If some app is exposing user input to this then I would
push a report to them.

[...]

>  - Any downstream consumer that feeds untrusted CPU-mask strings to 
>  the
>internal parse_cpu_mask_str helper directly


Not sure why untrusted input is getting here but sure if someone
is piping user input to libbpf let them know. I think if you have
untrusted user input hitting libbpf you have bigger problems.

[...]

>
>  if (start < *mask_sz)
>      return -EINVAL;  // "CPU range out of order or overlapping"
>

Send a fix. Thanks.
