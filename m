Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C02D2874E6
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 04:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263575; cv=none; b=CdJ7AO0ytu5gyLryJZiHB4dH5MBfBMNzAqssPb6vAL/bNSjV+thoMEV1kEIgZAxgfAr/yDxMDADje3pw6gAi3XOpbPYe6JUd9OpTw/Svhm71BLbgxlSV8aWD5F39tGi9GrifXJ75HkV6ih+gxM+7sxBwcMWEcUwGBkLW7YspQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263575; c=relaxed/simple;
	bh=rhAaEMFaCXLpstTRabb+r0BVbZKo6pDrG9Xs8zAxvKs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP8Rerp89mR+1yyPLzwOrLKH1PuldweUEb4W7VGpZLIMYbEye0wfExZ+rFr/OprUCwDBR23P3YN96/uOhZ2v8SwMjd90etsMjc7aPubfLGoqOIparwgnnSLQt0/BY/pz3TWEFvjYrTq2CzMbGcrCoFF14ItEiXFP97vHXg6ig3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J7QouTPE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J7QouTPE"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c169ae1cb26so183525366b.1
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263572; x=1784868372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rhAaEMFaCXLpstTRabb+r0BVbZKo6pDrG9Xs8zAxvKs=;
        b=J7QouTPE/kZIN+ATg/WiQYXJ/nQMA6dQM71ZACvnYLWD7JXoF8XHKmG0Cq5wCPho2Q
         j6psZF8KTDaRouwQtLjl/CPHVc8Axm6vzoQyPbq6gyNNNICHHYASy14pdVBgdc4/tdDh
         bK1cgsCuMWidU8ZChal3Jl3HWm3LK/iqlDoqhphEOaQk0b0gNPS+KqA+2I3qMzSoNhTh
         6GQLOWiWFprmldXYwdkJrAyQtSYlU6LLgN7bPaC0fUiOEZO6AGYHUoGgcIqn2Py9LA6M
         bbEXBMiUd7boUERgEvnqLi7kjkc7q4JjEHT/LPGhYwMhmj3vScuY/KrUnPx0pimcm7PV
         OfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263572; x=1784868372;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhAaEMFaCXLpstTRabb+r0BVbZKo6pDrG9Xs8zAxvKs=;
        b=sQ/1BGcjzEdzsi9fRC1KpsNFcHcGVwNu/DA5hcP7K3CVoOblugLWsSthdzhksRFKGz
         B3aZ+JtGrnrBbSPyzTrC0+21E6qKm0GnRzl25ELMGpoxwRQgvNOcgH2BCr8zM7PZPjBP
         GFUCFGbjVgUyCgpQkJvaZp9c/VYskBQDIF6bJh5BWO2J8WVBpCKjTW5s7JKanOqFlGT0
         0iYnJCBVc8Zp2JdNDf9ivd+Xdj7LIFaZc48s3mgo9aWsUpq5PtmAgNMvZegA9YGejyms
         P9ofmoaRy3VzufipH89h06W1WMTTNbfA3G3R7/FFy1H+oFwkMzdJvYynAnTu+XUo+AvA
         OIgA==
X-Gm-Message-State: AOJu0YxdMiL0upkb60Ty9TcY5kccHrsJDjPUWAPhbV7lr+K2x2y9uv10
	vjBrBiNvLZhsnX2r5n695R25eYSXgY4UAkvDt7E07R7GDJgWxI7XF1hjwbTSASoJ3I1L80gtP2A
	n8n32ip25tw==
X-Gm-Gg: AfdE7ckNC0ot9gV5yiWIFaLIF6YS4Z5YqOnJVdCR2ZGsgRcfwCVGfeNfpCOemUiUJyX
	OuKEPK1LXbo0ewGBq7oBMbGfvLn+OvTmf8QUH4QM9BYXel0g7bTr4awL6jfUACp21rb+gb/3gR0
	barYT0IT6ehFgrm5Kul9x7atyEApQm7Acn2M4avdFAUu00N4GucZqZ51zv36WgMVJ7/ygoNrDHq
	0Yl84g9peSGMlTfGOpsYvuNo+6yJlJzJ43OCgvkhyJnj/OtJauF189e73p2PSF3HY0/CCtlbBlq
	Tb9pgZA2xzJbhvtmI8yT4lrY4Q/eVui7Wax8ZJvl0lq7GgYS3Op7zK1LRY28kM2zRHMNOEUvYaM
	UKM0CQiq8eWRAFwRxwViIP/2RiHSco9TSRY5FFANmXrDOpWZngap3k82HMc+gTrV52v9yMdBffx
	l7/45Ndkicl9eOgde4HgziPWMZuAosSPrRz+U=
X-Received: by 2002:a17:906:6a1c:b0:c12:8a:7d7b with SMTP id a640c23a62f3a-c169205bba7mr251479866b.1.1784263571655;
        Thu, 16 Jul 2026 21:46:11 -0700 (PDT)
Received: from u94a (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4b247f1bsm369319a91.17.2026.07.16.21.46.09
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:46:10 -0700 (PDT)
Date: Fri, 17 Jul 2026 12:46:05 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Subject: Re: [PATCH stable 6.18 0/6] bpf: verifier: linked register tests and
 fixes
Message-ID: <almzaUY3wL92DYQd@u94a>
References: <20260717044009.120224-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717044009.120224-1-shung-hsi.yu@suse.com>

[...]

This was suppose to be sent to stable@vger.kernel.org. Sorry for the
noie.
