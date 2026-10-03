Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508A41B8CA
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791030355; cv=none; b=sfEDTDHPovnrMdkk+vOyzuJCyLUyqcXiCDiYb2Pzm7q5uxvu6pL8dplKbW57Svp7Wh7+QdUbEfSxoAoNfYyoUyoJRwaM68UO7cB4P+fh7KgLeAkju6qLB8GFs8ELt1y3M4C8A90+/qQhjCXZobX6INpjI4hdCbUH32pbmuryrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791030355; c=relaxed/simple;
	bh=QGzHGRpztg821aNnCGxDLz6qYiNQpkbVqPewYoSyG6M=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=ObFWZcVN2f0yDjfUdaeBIKmYXb9pp5+SG4ROLwMaRe2aO37PgGx9zzsC7tjPaFYDcJo91os67BVhXDc5TEEnyGlX2oDSEtojKZ2jaS/6NsQ/rqHMRm4ouaaei+KVLfEBcaQTeTBnpcrGf/CPgiy6cRxKDfDvooW+9lM3kkuwHCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+XTxCpO; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+XTxCpO"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a7906f463dso278950a91.3
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 05:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791030353; x=1791635153; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XP7BjJtXtAIJUyDpP8gnUWcoSnc5N68b3lICmArgYWw=;
        b=S+XTxCpOBKgaVgBBwMY/aOatu2Up/aZdr/rhMx3TC0pHqlrEzSNUUwYEC3MmP1wdSu
         F6pw9WAt8C7C9h7WTFrL7PKsjMQcPn543CKk+bevsF5dFB76YnflaHrE1mdUJ8ZSzRel
         UOfcdTb9UdFTmH+0PTzauSUMY+5WCExTHgRx4g6fc+oICghIllcwAvN1Cobuk6F2QFo5
         B5IVyFOPnOmKpWH0dM5zCrh9QjcdBw7yiCkVx30fORH9o2WaATS63JqXLm37CvYNAfct
         McO144jt23O946SYBVcHimh8AH94rDx3CrH4XtD6hc1fEyUCWQ3yiRTzhYdXubICO1JJ
         jv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791030353; x=1791635153;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XP7BjJtXtAIJUyDpP8gnUWcoSnc5N68b3lICmArgYWw=;
        b=iu+nSz93WfnQ9RYHSWuExAeICAS5QNqBbvb+4Dsgi3V5Rz/I2mmAppjusE+a8dffey
         wdLy5pOdZHX4GFDIj/Z4plWU+0Tl1OTapRaIhMoNbAC8uHkGrKm/bHIBDEYZt+snPk3s
         WGJ83T6rQlVPWBICfcOudM6ss09jT/mSkrDY4GpZvzWPFafyvcZK16e7TfwS3QuXtb98
         RJGzZ9VUQA4/Bd2ErxsEKp+yOegsTlog9zxglJ1caeLKIKMz+cp76IABkbnvxbLKW4h+
         SbsSZIcOwlOcvkIzvPPEk+RzWGcSrO214RBGLuOGLLpGRuL5XN7Fc06AfnSs6v3wRsY2
         RcVA==
X-Forwarded-Encrypted: i=1; AKwUvBxSvLejXYTj4ZOt+LRLlMMZ167OgNNvOPK2CQqd8n7XfiuGMRAbEwVZfoRd4UYlZ1p+qmM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkx0Ko78lszEpJUyDnjYeLeUJXfwzNd3jpVgV/DiZIWUW/ggGg
	bXNPAiNNvbQoWTa1kBusqBScwWfKFZblkSv2bhS2EzCZHADrI54f9Inw
X-Gm-Gg: AYBFou27KgUjan0D655HxH7IACD2oMzNAnmVZurN70bwFXW9/OJtFW9Tsj93+P0f7Vo
	F/QjyCIgSegthJncOmXixHg/CKnYlxyg7aw9H+hc0JXrzVFMYYsxVxWHNW0e8qJggeg2X6kHZFt
	jtWs2sxCRO1fvNxjNq1kBVQFh8RnqKRHQQQK26jUsGDfsTWJcLnZF77PqVfw5GtVLHdcQdVbziN
	YXjWv3OHXTYq7fkficjMEfC9EJOGi9GTuwnVtnkPjbWKergbL3doQD9Pm+wE7yZSsPEY1nXstPS
	oYIJzppXXIGfYbkHmZe9jWDbRvCGtpj4CZSFTWc6VWeAuac2dIRGlCrPNjSyfP3nEVDS34aPDjG
	w1kwz6BtWWvp2H3esyj02OYnpBpq3EAPVu1tjlTRIDJwEohogrofGo8zA4BY0cn0Qc3T7wVb5O6
	Yfz7E5bSDvBIAoE8/ZFctlZbwiZ7X2cVuRCXIUNDsTE1HRgC2b4scCif5hpOqjqnyyufeQtiujK
	BBtX2EHQpaoZ02DwC7iOgmrAu86Qwv9yPHmlr9r+RBU0CiZfNkbpOGDKcCMMdYR2DEjNgKMaK04
	/oC13Zun8ac9sqQ=
X-Received: by 2002:a17:90b:5310:b0:3a7:b2d4:e411 with SMTP id 98e67ed59e1d1-3a7b2d4e54cmr181903a91.21.1791030352997;
        Sat, 03 Oct 2026 05:25:52 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a70eb7e9easm2129490a91.1.2026.10.03.05.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 05:25:52 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 12:25:52 +0000
Message-Id: <DLV79T0TY8NZ.3KI8QVIB50I4H@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v8 09/22] bpf: Refuse a landing pad that does
 not resume
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261001133052.1339921-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev> <20261001133052.1339921-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 06:30 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> +	u64 in_cleanup_pad:1; /* reached with a landing pad running */
> +	u64 outside_cleanup_pad:1; /* reached the other way */

can we compare in_pad in func_states_equal(), like no_stack_arg_load,
and drop these two bits, the "runs both inside and outside a landing
pad" rule and the special case for speculative paths?
